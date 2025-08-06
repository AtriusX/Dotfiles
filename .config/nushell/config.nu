# config.nu
#
# Installed by:
# version = "0.106.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

$env.config.show_banner = false
$env.config.buffer_editor = "/usr/bin/micro"

# Add local binary directory to path
$env.PATH = (
	$env.PATH
	| append "~/.local/bin"
	| append "~/.cargo/bin"
	| append "~/.sdkman/candidates/java/current/bin"
)

source ~/.zoxide.nu

def --env dr [drive: string] {
	let drivePath = $"/mnt/($drive)"
	echo $"Changing to ($drivePath)" 
  	cd $drivePath 
}

def --env live [] {
	try {
		# Checkout main branch
    	try {
    		git checkout main err> /dev/null
    	} catch {
    		git checkout master err> /dev/null
    	}
    	# Pull changes
		git pull
	} catch {
	    # Reset branch to origin if it can't be recovered
	    try {
			git reset --hard origin/main err> /dev/null
	    } catch {
	    	git reset --hard origin/master err> /dev/null
	    }
	}
}

def --env jump [branch: string] {
	git checkout -b $branch err> /dev/null or git checkout $branch
}

def --env mp3-dl [
	link: string,
	location?: string = "."
] {
	spotify-dl $link -f mp3 -d $location
}

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
