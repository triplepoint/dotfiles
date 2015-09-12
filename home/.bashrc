# .bashrc is for "interactive non-login shells", but OSX's terminal always uses a login shell.
# So instead of duplicating effort, this file will just copy bash_profile, which is used
# for login shells.  On non-OSX machines this should still have more or less the expected
# behavior, unless you add some sort of login info echo statements to bash_profile or something.
[ -n "$PS1" ] && source ~/.bash_profile;
