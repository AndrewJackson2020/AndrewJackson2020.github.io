

main_commands () {
	case $1 in 
		"--build" | "-b")

			bundle exec jekyll b \
				--source ./site
				--destination ./docs
				
			# Push to bucket
			gsutil rsync \
				./docs \
				gs://arch-custom-repos	
			
			# Delete local files
			sudo rm -r docs	
			;;
		"--help" | "-h")
			echo help 
			;;
		*)
			echo "Command '$1' not found"
			;;
	esac
}


main_commands $@

