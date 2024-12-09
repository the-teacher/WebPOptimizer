build:
	touch .bash_history
	docker build -t iamteacher/image_optimizer -f dev/Dockerfile .

shell:
	touch .bash_history

	docker run \
	-v ${PWD}/.bash_history:/root/.bash_history \
	-v ${PWD}/images:/images \
	-v ${PWD}/scripts:/scripts \
	-it iamteacher/image_optimizer \
	bash

optimize:
	touch .bash_history

	docker run \
	-v ${PWD}/.bash_history:/root/.bash_history \
	-v ${PWD}/images:/images \
	-v ${PWD}/scripts:/scripts \
	-it iamteacher/image_optimizer \
	"source /scripts/process_images.sh /images"

pdf2images:
	touch .bash_history

	docker run \
	-v ${PWD}/.bash_history:/root/.bash_history \
	-v ${PWD}/images:/images \
	-v ${PWD}/scripts:/scripts \
	-it iamteacher/image_optimizer \
	"source /scripts/pdf2images.sh /images"
	
resize:

	touch .bash_history

	docker run \
	-v ${PWD}/.bash_history:/root/.bash_history \
	-v ${PWD}/images:/images \
	-v ${PWD}/scripts:/scripts \
	-it iamteacher/image_optimizer \
	"source /scripts/resize_images.sh /images"