Synopsis
--------

This small Merb application was written to scratch an itch. I wanted my ticketing system to be integrated with my source control system. Since I use GitHub for source control and Unfuddle for ticket management and since both GitHub and Unfuddle are excellent in what they specialize in, I wanted to integrate the two. By utilizing Unfuddle's API and GitHub's post-receive hook, you can start commiting code to GitHub as if it were hosted on Unfuddle. Once you've setup the mapping of GitHub users to Unfuddle users and GitHub projects to Unfuddle projects, you can start utilizing Unfuddle's "Powerful Commit Messages" to do things like close tickets, associate a ticket with the commit that fixed the bug, etc. 

For example you can include something like "fixes #234, #87 and #42. closes #99" in your commit message and when you push your commit to GitHub, the respective actions will be taken on the tickets in Unfuddle.

Inspiration
-----------

[github-unfuddle](http://github.com/mbleigh/github-unfuddle) by [Michael Bleigh](http://github.com/mbleigh/) served as the inspiration for this project. 

Usage
-----

1. Create a deploy user in Unfuddle with manage code and ticket privileges.
2. In Unfuddle, make sure to create a fake repo and enable the "Changesets Managed Manually" option in the edit repository page. Also make sure to associate the fake repo to your Unfuddle project.
3. Edit the config/config.yml file to setup the mappings between users and projects. Checkout the config.sample.yml for guidance.
4. Point the post-receive hook for your GitHub repo to where you have git-sentinel running.

More Info
----------

If you have any questions or suggestions, please make a note in the [wiki](http://github.com/entombedvirus/git-sentinel/wikis).
