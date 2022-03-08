# get-pr-nr-from-branch
Small script that returns GitHub pull request number of current branch. 

Can be used in external CI systems to resolve the PR number of a branch. 


The script will return the PR number as last line on STDOUT and store it to `pr_number.txt`

Usage: 
```
./pr_number.sh REPOSITORY_USER REPOSITORY_NAME

# Example: 
./pr_number.sh ls1intum Artemis
```


Example for CI Application: 

```bash
apt install curl -y 

curl https://raw.githubusercontent.com/Mtze/get-pr-nr-from-branch/main/pr_number.sh > pr_number.sh
bash pr_number.sh ls1intum Artemis

```
