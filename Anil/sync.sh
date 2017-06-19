for i in ` cat oc.txt `
do
	name=$(echo $i)
	#folder=$(echo $name | awk '{print $1}')
	#githubrepo=$(echo $name | awk '{print $2}')
	#bitbucketrepo=$(echo $name | awk '{print $3}')
	#echo "git clone $githubrepo"
	#git clone $githubrepo
#echo -n $folder $githubrepo $bitbucketrepo	
	#echo $name
	folder=$(echo $name | cut -d "*" -f1)
        githuburl=$(echo $name | cut -d "*" -f2)
	bitbucketurl=$(echo $name | cut -d "*" -f3)
	if  [ ! -d  "$folder" ];
	then
	git clone $githuburl
	else
	echo "clone exists not cloning again "
	fi
        cd $folder
	git checkout master &&  git pull origin master
	git checkout cord-2.0 && git pull origin cord-2.0
	git remote remove origin
        git remote add origin $bitbucketurl
	git push origin --all
	git remote remove origin
	git remote add origin $githuburl
	cd ..

	
	#git remote remove origin
#	git remote add origin $githuburl
	
	

	
	#echo $var1
	#echo $var2
        #echo $var3
#	echo "this is test"
done  
