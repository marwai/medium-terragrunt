# Wiping old commit history

1. checkout 
 
	$ git checkout --orphan latest_branch


3. Add all the files


   	$ git add -A

4. Commit the changes


	$ git commit -am "commit message"

4. Delete the branch

	$ git branch -D main

5. Rename the current branch to main

	$ git branch -m main

6. Finally, force update your repository

	$ git push -f origin main