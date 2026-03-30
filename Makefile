.PHONEY: l_julia l_python l_pluto l_jupyter l_la_course l_chain l_clean julia python pluto jupyter la_course chain clean help info git checkgit list_remote
.PHONEY: push_amd64 push arm64

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
	@echo "<DONE> l_julia $$(date +%-m/%-d/%y\ %H:%M)"
l_julia_run:
	docker run --rm -it $(IMAGE_JULIA):$(VERSION) bash


l_python:
	docker build  -f binder/Dockerfile.python \
	  --build-arg BASE_IMAGE=$(IMAGE_JULIA):$(VERSION) \
	  --build-arg PYTHON_VERSION=$(PYTHON_VERSION) \
	  -t $(IMAGE_PYTHON):$(VERSION) -t $(IMAGE_PYTHON):$(RUNTIME_TAG) \
	  --progress=plain --no-cache --load .
	@echo "<DONE> l_python $$(date +%-m/%-d/%y\ %H:%M)"
l_python_run:
	docker run --rm -it $(IMAGE_PYTHON):$(VERSION) bash

l_jupyter:
	  docker build -f binder/Dockerfile.jupyter \
	  --build-arg BASE_IMAGE=$(IMAGE_PYTHON):$(VERSION) \
	  -t $(IMAGE_JUPYTER):$(VERSION) -t  $(IMAGE_JUPYTER):$(RUNTIME_TAG) \
	  --progress=plain --no-cache --load .
	@echo "<DONE> l_jupyter $$(date +%-m/%-d/%y\ %H:%M)"
l_jupyter_run:
	docker run --rm -it $(IMAGE_JUPYTER):$(VERSION) bash

l_pluto:
	  docker build -f Dockerfile.jupyter \
	  --build-arg BASE_IMAGE=$(IMAGE_JULIA):$(VERSION) \
	  -t $(IMAGE_PLUTO):$(VERSION) -t $(IMAGE_PLUTO):julia$(JULIA_VERSION) \
	  --progress=plain --no-cache --load .
	@echo "<DONE> l_pluto $$(date +%-m/%-d/%y\ %H:%M)"
l_pluto_run:
	docker run --rm -it $(IMAGE_PLUTO):$(VERSION) bash

l_la_course:
	  docker build -f binder/Dockerfile.la_course \
	  --build-arg BASE_IMAGE=$(IMAGE_JUPYTER):$(VERSION) \
	  -t $(IMAGE_LA_COURSE):$(VERSION) -t  $(IMAGE_LA_COURSE):$(RUNTIME_TAG) \
	  --no-cache \
	  --progress=plain --load .
	@echo "<DONE> l_la_course $$(date +%-m/%-d/%y\ %H:%M)"


l_la_course_run:
	docker run --rm -it $(IMAGE_LA_COURSE):$(VERSION) bash
	@echo "<DONE> l_la_course $$(date +%-m/%-d/%y\ %H:%M)"

l_chain: l_julia l_python l_jupyter l_la_course #l_pluto 
	@echo "<DONE> l_chain $$(date +%-m/%-d/%y\ %H:%M)"

# =======================================================================================================
julia:
	docker buildx build --platform linux/arm64,linux/amd64 -f binder/Dockerfile.julia \
	  --build-arg JULIA_VERSION=$(JULIA_VERSION) \
	  -t ea42gh/$(IMAGE_JULIA):$(VERSION) -t ea42gh/$(IMAGE_JULIA):julia$(JULIA_VERSION) \
	  --progress=plain --no-cache --push .
	@echo "<DONE> julia $$(date +%-m/%-d/%y\ %H:%M)"

python:
	docker buildx build --platform linux/arm64,linux/amd64 -f binder/Dockerfile.python \
	  --build-arg BASE_IMAGE=ea42gh/$(IMAGE_JULIA):$(VERSION) \
	  --build-arg PYTHON_VERSION=$(PYTHON_VERSION) \
	  -t ea42gh/$(IMAGE_PYTHON):$(VERSION) -t ea42gh/$(IMAGE_PYTHON):$(RUNTIME_TAG) \
	  --progress=plain --no-cache --push .
	@echo "<DONE> python $$(date +%-m/%-d/%y\ %H:%M)"

jupyter:
	docker buildx build --platform linux/arm64,linux/amd64 -f binder/Dockerfile.jupyter \
	  --build-arg BASE_IMAGE=ea42gh/$(IMAGE_PYTHON):$(VERSION) \
	  -t ea42gh/$(IMAGE_JUPYTER):$(VERSION) -t ea42gh/$(IMAGE_JUPYTER):$(RUNTIME_TAG) \
	  --progress=plain --no-cache --push .
	@echo "<DONE> jupyter $$(date +%-m/%-d/%y\ %H:%M)"

pluto:
	docker buildx build --platform linux/arm64,linux/amd64 -f binder/Dockerfile.pluto \
	  --build-arg BASE_IMAGE=$(IMAGE_JULIA):$(VERSION) \
	  -t ea42gh/$(IMAGE_PLUTO):$(VERSION) -t ea42gh/$(IMAGE_PLUTO):$(RUNTIME_TAG) \
	  --progress=plain --no-cache --push .
	@echo "<DONE> pluto $$(date +%-m/%-d/%y\ %H:%M)"

la_course:
	docker buildx build --platform linux/arm64,linux/amd64 -f binder/Dockerfile.la_course \
	  --build-arg BASE_IMAGE=ea42gh/$(IMAGE_JUPYTER):$(VERSION) \
	  -t ea42gh/$(IMAGE_LA_COURSE):$(VERSION) -t ea42gh/$(IMAGE_LA_COURSE):$(RUNTIME_TAG) \
	  --progress=plain --no-cache --push .
	@echo "<DONE> la_course $$(date +%-m/%-d/%y\ %H:%M)"

chain: julia python jupyter la_course # pluto
	@echo "<DONE> chain $$(date +%-m/%-d/%y\ %H:%M)"

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

API_URL := https://hub.docker.com/v2/repositories/ea42gh/?page_size=100
# Base URL for the user “ea42gh”
API_ROOT := https://hub.docker.com/v2/repositories/ea42gh

# -----------------------------------------------------------------
# Main target
# -----------------------------------------------------------------
.PHONY: list
list:
	@echo "Fetching image names and tags from Docker Hub …"
	@# 1️⃣ Get the list of repository names
	@curl -s "$(API_ROOT)/?page_size=100" \
	| jq -r '.results[].name' \
	| while read repo; do \
	    curl -s "$(API_ROOT)/$$repo/tags?page_size=100" \
	    | jq -r --arg r "$$repo" '.results[].name | "\($$r):\(.)"'; \
	  done | sort   # optional – alphabetical order

# -----------------------------------------------------------------
list_remote:
	@echo "Repositories for ea42gh:"
	@echo "$(REPO_NAMES)" | tr ' ' '\n' | sort

.PHONY: list_images
list_images:
	@echo "Fetching image names from Docker Hub …"
	@curl -s "$(API_URL)" \
	| jq -r '.results[].name' \
	| sort   # optional – alphabetical order
# =======================================================================================================
help:
	@echo " l_julia l_python l_pluto l_jupyter l_la_course l_chain"
	@echo " julia python pluto jupyter la_course chain"
	@echo " list list_images git check_git"
	@echo " info"

info:
	@echo "VERSION        = $(VERSION)"
	@echo "JULIA_VERSION  = $(JULIA_VERSION)"
	@echo "PYTHON_VERSION = $(PYTHON_VERSION)"
	@echo "RUNTIME_TAG    = $(RUNTIME_TAG)"
# =======================================================================================================
push_arm64:
	docker tag la-course:0.2 ea42gh/la-course:0.2-arm64
	docker tag la-course:julia1.10.5-py3.11.9 ea42gh/la-course:julia1.10.5-py3.11.9-arm64
	docker push ea42gh/la-course:0.2-arm64
	docker push ea42gh/la-course:julia1.10.5-py3.11.9-arm64
	docker buildx imagetools create -t ea42gh/la-course:0.2 \
	    ea42gh/la-course:0.2-arm64 \
	    ea42gh/la-course:0.2-arm64
	docker buildx imagetools create -t ea42gh/la-course:julia1.10.5-py3.11.9 \
	    ea42gh/la-course:julia1.10.5-py3.11.9-arm64 \
	    ea42gh/la-course:julia1.10.5-py3.11.9-arm64
	docker buildx imagetools inspect ea42gh/la-course:0.2
	docker buildx imagetools inspect ea42gh/la-course:julia1.10.5-py3.11.9
push_amd64:
	docker tag la-course:0.2 ea42gh/la-course:0.2-amd64
	docker tag la-course:julia1.10.5-py3.11.9 ea42gh/la-course:julia1.10.5-py3.11.9-amd64
	docker push ea42gh/la-course:0.2-amd64
	docker push ea42gh/la-course:julia1.10.5-py3.11.9-amd64
	docker buildx imagetools create -t ea42gh/la-course:0.2 \
	    ea42gh/la-course:0.2-arm64 \
	    ea42gh/la-course:0.2-amd64
	docker buildx imagetools create -t ea42gh/la-course:julia1.10.5-py3.11.9 \
	    ea42gh/la-course:julia1.10.5-py3.11.9-arm64 \
	    ea42gh/la-course:julia1.10.5-py3.11.9-amd64
	docker buildx imagetools inspect ea42gh/la-course:0.2
	docker buildx imagetools inspect ea42gh/la-course:julia1.10.5-py3.11.9
