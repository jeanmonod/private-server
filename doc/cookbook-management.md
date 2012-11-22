Cookbook integration
####################

Rules
=====

 * always use 'proxy' repo from https://github.com/cookbooks when available (**be aware** that https://github.com/cookbooks default page only display the repository recently modified, not the whole list!)
 * *Git submodule*-style integration (not with knife-github-cookbooks plugin)
 * always refer to an official release of the cookbook (git tag) if it exist
 * check if/why a cookbook is forked. Try to take the most active one...
 * Use the https:// protocol for the git submodule (to avoid futur proxy issues)
