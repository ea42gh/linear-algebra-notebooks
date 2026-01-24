.PHONEY: l_julia l_python l_pluto l_jupyter l_la_course l_chain l_clean julia python pluto jupyter la_course chain clean help info git checkgit
IMAGE_JULIA   ?= julia-tex
IMAGE_PYTHON  ?= julia-python
IMAGE_BASE    ?= $(IMAGE_PYTHON)
IMAGE_JUPYTER ?= julia-python-jupyter
IMAGE_PLUTO   ?= julia-pluto
IMAGE_LA_COURSE ?= la-course

VERSION ?= 0.2
JULIA_VERSION  ?= 1.10.5
PYTHON_VERSION ?= 3.11.9
IMG_VERSION ?= 0.1.0

# Compatibility tag (informational but useful)
RUNTIME_TAG := julia$(JULIA_VERSION)-py$(PYTHON_VERSION)

# ==========================================================================================
# l_ targets build local versions only, and use local images for building
# ==========================================================================================
l_julia:
	docker build  -f binder/Dockerfile.julia \
	  --build-arg JULIA_VERSION=$(JULIA_VERSION) \
	  -t $(IMAGE_JULIA):$(VERSION) -t $(IMAGE_JULIA):julia$(JULIA_VERSION) \
	  --progress=plain --no-cache --load .
	@echo "<DONE> l_julia"
l_julia_run:
	docker run --rm -it $(IMAGE_JULIA):$(VERSION) bash


l_python:
	docker build  -f binder/Dockerfile.python \
	  --build-arg BASE_IMAGE=$(IMAGE_JULIA):$(VERSION) \
	  --build-arg PYTHON_VERSION=$(PYTHON_VERSION) \
	  -t $(IMAGE_PYTHON):$(VERSION) -t $(IMAGE_PYTHON):$(RUNTIME_TAG) \
	  --progress=plain --no-cache --load .
	@echo "<DONE> l_python"
l_python_run:
	docker run --rm -it $(IMAGE_PYTHON):$(VERSION) bash

l_jupyter:
	  docker build -f binder/Dockerfile.jupyter \
	  --build-arg BASE_IMAGE=$(IMAGE_PYTHON):$(VERSION) \
	  -t $(IMAGE_JUPYTER):$(VERSION) -t  $(IMAGE_JUPYTER):$(RUNTIME_TAG) \
	  --progress=plain --no-cache --load .
	@echo "<DONE> l_jupyter"
l_jupyter_run:
	docker run --rm -it $(IMAGE_JUPYTER):$(VERSION) bash

l_pluto:
	  docker build -f Dockerfile.jupyter \
	  --build-arg BASE_IMAGE=$(IMAGE_JULIA):$(VERSION) \
	  -t $(IMAGE_PLUTO):$(VERSION) -t $(IMAGE_PLUTO):julia$(JULIA_VERSION) \
	  --progress=plain --no-cache --load .
	@echo "<DONE> l_pluto"
l_pluto_run:
	docker run --rm -it $(IMAGE_PLUTO):$(VERSION) bash

l_la_course:
	  docker build -f binder/Dockerfile.la_course \
	  --build-arg BASE_IMAGE=$(IMAGE_JUPYTER):$(VERSION) \
	  -t $(IMAGE_LA_COURSE):$(VERSION) -t  $(IMAGE_LA_COURSE):$(RUNTIME_TAG) \
	  --no-cache \
	  --progress=plain --load .
	@echo "<DONE> l_la_course"


l_la_course_run:
	docker run --rm -it $(IMAGE_LA_COURSE):$(VERSION) bash
	@echo "<DONE> l_la_course"

l_chain: l_julia l_python l_jupyter l_pluto l_la_course
	@echo "<DONE> l_chain"

# =======================================================================================================
julia:
	docker buildx build --platform linux/arm64,linux/amd64 -f binder/Dockerfile.julia \
	  --build-arg JULIA_VERSION=$(JULIA_VERSION) \
	  -t ea42gh/$(IMAGE_JULIA):$(VERSION) -t ea42gh/$(IMAGE_JULIA):julia$(JULIA_VERSION) \
	  --progress=plain --no-cache --push .
	@echo "<DONE> julia"

python:
	docker buildx build --platform linux/arm64,linux/amd64 -f binder/Dockerfile.python \
	  --build-arg BASE_IMAGE=ea42gh/$(IMAGE_JULIA):$(VERSION) \
	  --build-arg PYTHON_VERSION=$(PYTHON_VERSION) \
	  -t ea42gh/$(IMAGE_PYTHON):$(VERSION) -t ea42gh/$(IMAGE_PYTHON):$(RUNTIME_TAG) \
	  --progress=plain --no-cache --push .
	@echo "<DONE> python"

jupyter:
	docker buildx build --platform linux/arm64,linux/amd64 -f binder/Dockerfile.jupyter \
	  --build-arg BASE_IMAGE=ea42gh/$(IMAGE_PYTHON):$(VERSION) \
	  -t ea42gh/$(IMAGE_JUPYTER):$(VERSION) -t ea42gh/$(IMAGE_JUPYTER):$(RUNTIME_TAG) \
	  --progress=plain --no-cache --push .
	@echo "<DONE> jupyter"

pluto:
	docker buildx build --platform linux/arm64,linux/amd64 -f binder/Dockerfile.pluto \
	  --build-arg BASE_IMAGE=$(IMAGE_JULIA):$(VERSION) \
	  -t ea42gh/$(IMAGE_PLUTO):$(VERSION) -t ea42gh/$(IMAGE_PLUTO):$(RUNTIME_TAG) \
	  --progress=plain --no-cache --push .
	@echo "<DONE> pluto"

la_course:
	docker buildx build --platform linux/arm64,linux/amd64 -f binder/Dockerfile.la_course \
	  --build-arg BASE_IMAGE=$(IMAGE_JUPYTER):$(VERSION) \
	  -t ea42gh/$(IMAGE_LA_COURSE):$(VERSION) -t ea42gh/$(IMAGE_LA_COURSE):$(RUNTIME_TAG) \
	  --progress=plain --no-cache --push .
	@echo "<DONE> la_course"

chain: julia python jupyter la_course pluto
	@echo "<DONE> chain"

C ?= container
git:
	docker cp ~/Downloads/configs/GIT.tgz $C:/home/jovyan
checkgit:
	@cd /home/lab/NOTEBOOKS/0_ITIKZ/jupyter_tikz && if [ -n "$$(git status --porcelain)" ]; then echo "# ============================================= jupyter_tikz "; git status; fi
	@cd /home/lab/NOTEBOOKS/0_ITIKZ/matrixlayout && if [ -n "$$(git status --porcelain)" ]; then echo "# ============================================= matrixlayout "; git status; fi
	@cd /home/lab/NOTEBOOKS/0_ITIKZ/la_figures && if [ -n "$$(git status --porcelain)" ]; then echo "# ============================================= la_figures "; git status; fi
	@cd /home/lab/NOTEBOOKS/0_LSHOW/LAlatex && if [ -n "$$(git status --porcelain)" ]; then echo "# ============================================= LAlatex"; git status; fi
	@cd /home/lab/NOTEBOOKS/0_LSHOW/GenLAProblems && if [ -n "$$(git status --porcelain)" ]; then echo "# ============================================= GenLAProblems"; git status; fi
	@cd /home/lab/NOTEBOOKS/elementary-linear-algebra && if [ -n "$$(git status --porcelain)" ]; then echo "# ================================================================= elementary-linear-algebra"; git status; fi
# =======================================================================================================
help:
	@echo " l_julia l_python l_pluto l_jupyter l_la_course l_chain"
	@echo " julia python pluto jupyter la_course chain"
	@echo " info"

info:
	@echo "VERSION        = $(VERSION)"
	@echo "JULIA_VERSION  = $(JULIA_VERSION)"
	@echo "PYTHON_VERSION = $(PYTHON_VERSION)"
	@echo "RUNTIME_TAG    = $(RUNTIME_TAG)"
# =======================================================================================================
## intro:   https://stackify.com/docker-build-a-beginners-guide-to-building-docker-images/ .
## # ------------------------------------------------------
## # in the binder dir
## docker build . -t la_course  --progress=plain --no-cache
## docker images
## docker run -p 8888:8888 -p 1234:1234 la_course
## docker run --rm -it --entrypoint bash la_course
## 
## docker tag la_course ea42gh/la_course
## docker push ea42gh/la_course
## 
## # =============================================================================================================
## # local builds
## docker build -t ea42gh/base_image -f binder/Dockerfile.base --load .
## docker run --rm -it ea42gh/base_image bash
## docker build -t ea42gh/la_course -f binder/Dockerfile --load .
## docker run --rm -it ea42gh/la_course bash
## 
## # =============================================================================================================
## # build and push to repository
## # build the base
## docker buildx build \
##   --platform linux/arm64,linux/amd64 \
##   --cache-to=type=local,dest=.buildx-cache \
##   --cache-from=type=local,src=.buildx-cache \
##   --progress=plain \
##   -t ea42gh/base_image:1.0.2 \
##   -t ea42gh/base_image:latest \
##   -t ea42gh/base_image:julia-1.12-python-3.12-texlive \
##   -f binder/Dockerfile.base \
##   --push \
##   .
## 
## 
## docker buildx build --platform linux/arm64,linux/amd64 --cache-to=type=local,dest=.buildx-cache --cache-from=type=local,src=.buildx-cache -t ea42gh/base_image:1.0.2 -t ea42gh/base_image:latest -t ea42gh/base_image:julia-1.12-python-3.12i-texlive 
##              -f binder/Dockerfile.base --push .
## # build la_course
## docker buildx build --platform linux/arm64,linux/amd64 -t ea42gh/la_course:1.0.2 -t ea42gh/la_course:latest -f binder/Dockerfile --push .
## 
## 
## docker buildx build \
##   --platform linux/amd64 \
##   --cache-from=type=local,src=.buildx-cache \
##   -t ea42gh/la_course:local \
##   -f binder/Dockerfile \
##   --load \
##   .
