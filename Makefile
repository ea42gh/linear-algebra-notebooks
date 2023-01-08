la_image.tar:
	docker build -t la_image --file .\binder\Dockerfile .
	docker save la_image > la_image.tar
run: la_image.tar
	#docker run -it --rm -p 8888:8888 la_image jupyter lab --NotebookApp.default_url=/lab/ --ip=0.0.0.0 --port=8888
	docker load < la_image.tar
