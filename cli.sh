set -e

build () {

	bucket_name=gs://blog-wadfaf
	sudo rm -r docs	
	mkdir ./docs

	(cd ./site && sudo bundle exec jekyll b \
		--source ./ \
		--destination ../docs)

	if [[ $(gsutil du "$bucket_name" | wc -l) -gt 0 ]]
	then 
		gsutil -m rm -rf "$bucket_name/*"; 
	fi 

	# Push to bucket
	gsutil cp \
		-r \
		./docs/* \
		"$bucket_name"
	
	# Delete local files
	sudo rm -r docs	
}


main_commands () {
	case $1 in 
		"--build" | "-b")
			build
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

