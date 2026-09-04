.PHONY: l_julia l_python l_pluto l_jupyter l_la_course l_ci_la_course l_chain l_clean julia python pluto jupyter la_course chain clean help info git checkgit list_remote push list list_images refresh_deps refresh_python_deps refresh_python_deps_local check_deps_lock check_python_deps_lock check_notebook_api check_notebooks check_notebooks_docker check_integration_smoke check_integration_smoke_docker

IMAGE_JULIA   ?= julia-tex
IMAGE_PYTHON  ?= julia-python
IMAGE_BASE    ?= $(IMAGE_PYTHON)
IMAGE_JUPYTER ?= julia-python-jupyter
IMAGE_PLUTO   ?= julia-pluto
IMAGE_LA_COURSE ?= la-course
CI_BASE_IMAGE ?= ea42gh/$(IMAGE_JUPYTER):$(VERSION)
export BUILDX_GIT_INFO := false
DOCKER_BUILD ?= docker build
DOCKER_BUILDX_BUILD ?= docker buildx build
NO_CACHE ?= 0
ifeq ($(filter 1 true yes,$(NO_CACHE)),)
DOCKER_CACHE_FLAG :=
else
DOCKER_CACHE_FLAG := --no-cache
endif
DEPENDENCY_LOCK_IMAGE ?= python:$(PYTHON_LOCK_VERSION)-slim
BINDER_PYTHON_BUILD_DEPS ?= build-essential graphviz-dev libcairo2-dev libpango1.0-dev pkg-config
NOTEBOOK_CHECK_IMAGE ?= $(IMAGE_LA_COURSE):$(VERSION)
NOTEBOOK_DOCKER_USER ?= jovyan
NOTEBOOK_DIR ?= notebooks
NOTEBOOK_TIMEOUT ?= 600
NOTEBOOK_STARTUP_TIMEOUT ?= 180
NOTEBOOK_REPORT_DIR ?= artifacts/notebook-check
NOTEBOOK_ONLY ?=
NOTEBOOK_RESUME_FROM ?=
NOTEBOOK_CONTAINER ?= ela-notebook-check

VERSION ?= 1.0
JULIA_VERSION  ?= 1.10.12
PYTHON_VERSION ?= 3.13.15
PYTHON_LOCK_VERSION ?= 3.13
PYTHON_LOCK_VERSIONS ?= 3.10 3.11 3.12 3.13
PIP_VERSION ?= 25.3
PIP_TOOLS_VERSION ?= 7.5.2
JULIA_PRECOMPILE_TASKS ?= 2
IMG_VERSION ?= 1.0.0
ifeq ($(OS),Windows_NT)
PYTHON ?= python
TIMESTAMP = $(shell powershell -NoProfile -Command "Get-Date -Format 'yyyy-MM-dd HH:mm'")
ARCH_RAW = $(shell powershell -NoProfile -Command "[System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture.ToString().ToLower()")
else
PYTHON ?= python3
TIMESTAMP = $(shell date '+%Y-%m-%d %H:%M')
ARCH_RAW = $(shell uname -m)
endif
ifeq ($(findstring arm64,$(ARCH_RAW)),arm64)
ARCH_SUFFIX = arm64
else ifeq ($(findstring aarch64,$(ARCH_RAW)),aarch64)
ARCH_SUFFIX = arm64
else ifeq ($(findstring x86_64,$(ARCH_RAW)),x86_64)
ARCH_SUFFIX = amd64
else ifeq ($(findstring amd64,$(ARCH_RAW)),amd64)
ARCH_SUFFIX = amd64
else
$(error Unsupported architecture "$(ARCH_RAW)"; expected amd64/x86_64 or arm64/aarch64)
endif

# Compatibility tag (informational but useful)
RUNTIME_TAG := julia$(JULIA_VERSION)-py$(PYTHON_VERSION)

# ==========================================================================================
# l_ targets build local versions only, and use local images for building
# ==========================================================================================
l_julia:
	$(DOCKER_BUILD)  -f binder/Dockerfile.julia \
	  --build-arg JULIA_VERSION=$(JULIA_VERSION) \
	  -t $(IMAGE_JULIA):$(VERSION) -t $(IMAGE_JULIA):julia$(JULIA_VERSION) \
	  --progress=plain $(DOCKER_CACHE_FLAG) --load .
	@echo "<DONE> l_julia $(TIMESTAMP)"
l_julia_run:
	docker run --rm -it $(IMAGE_JULIA):$(VERSION) bash


l_python:
	$(DOCKER_BUILD)  -f binder/Dockerfile.python \
	  --build-arg BASE_IMAGE=$(IMAGE_JULIA):$(VERSION) \
	  --build-arg PYTHON_VERSION=$(PYTHON_VERSION) \
	  -t $(IMAGE_PYTHON):$(VERSION) -t $(IMAGE_PYTHON):$(RUNTIME_TAG) \
	  --progress=plain $(DOCKER_CACHE_FLAG) --load .
	@echo "<DONE> l_python $(TIMESTAMP)"
l_python_run:
	docker run --rm -it $(IMAGE_PYTHON):$(VERSION) bash

l_jupyter:
	  $(DOCKER_BUILD) -f binder/Dockerfile.jupyter \
	  --build-arg BASE_IMAGE=$(IMAGE_PYTHON):$(VERSION) \
	  -t $(IMAGE_JUPYTER):$(VERSION) -t  $(IMAGE_JUPYTER):$(RUNTIME_TAG) \
	  --progress=plain $(DOCKER_CACHE_FLAG) --load .
	@echo "<DONE> l_jupyter $(TIMESTAMP)"
l_jupyter_run:
	docker run --rm -it $(IMAGE_JUPYTER):$(VERSION) bash

l_pluto:
	  $(DOCKER_BUILD) -f binder/Dockerfile.pluto \
	  --build-arg BASE_IMAGE=$(IMAGE_JULIA):$(VERSION) \
	  -t $(IMAGE_PLUTO):$(VERSION) -t $(IMAGE_PLUTO):julia$(JULIA_VERSION) \
	  --progress=plain $(DOCKER_CACHE_FLAG) --load .
	@echo "<DONE> l_pluto $(TIMESTAMP)"
l_pluto_run:
	docker run --rm -it $(IMAGE_PLUTO):$(VERSION) bash

l_la_course:
	  $(DOCKER_BUILD) -f binder/Dockerfile.la_course \
	  --build-arg BASE_IMAGE=$(IMAGE_JUPYTER):$(VERSION) \
	  --build-arg JULIA_PRECOMPILE_TASKS=$(JULIA_PRECOMPILE_TASKS) \
	  -t $(IMAGE_LA_COURSE):$(VERSION) -t  $(IMAGE_LA_COURSE):$(RUNTIME_TAG) \
	  --progress=plain $(DOCKER_CACHE_FLAG) --load .
	@echo "<DONE> l_la_course $(TIMESTAMP)"


l_la_course_run:
	docker run --rm -it $(IMAGE_LA_COURSE):$(VERSION) bash
	@echo "<DONE> l_la_course $(TIMESTAMP)"

l_ci_la_course:
	  $(DOCKER_BUILDX_BUILD) -f binder/Dockerfile.la_course \
	  --build-arg BASE_IMAGE=$(CI_BASE_IMAGE) \
	  --build-arg JULIA_PRECOMPILE_TASKS=$(JULIA_PRECOMPILE_TASKS) \
	  -t $(IMAGE_LA_COURSE):$(VERSION) \
	  --progress=plain --load .
	@echo "<DONE> l_ci_la_course $(TIMESTAMP)"

l_chain: l_julia l_python l_jupyter l_la_course #l_pluto 
	@echo "<DONE> l_chain $(TIMESTAMP)"

# =======================================================================================================
julia:
	$(DOCKER_BUILDX_BUILD) --platform linux/arm64,linux/amd64 -f binder/Dockerfile.julia \
	  --build-arg JULIA_VERSION=$(JULIA_VERSION) \
	  -t ea42gh/$(IMAGE_JULIA):$(VERSION) -t ea42gh/$(IMAGE_JULIA):julia$(JULIA_VERSION) \
	  --progress=plain $(DOCKER_CACHE_FLAG) --push .
	@echo "<DONE> julia $(TIMESTAMP)"

python:
	$(DOCKER_BUILDX_BUILD) --platform linux/arm64,linux/amd64 -f binder/Dockerfile.python \
	  --build-arg BASE_IMAGE=ea42gh/$(IMAGE_JULIA):$(VERSION) \
	  --build-arg PYTHON_VERSION=$(PYTHON_VERSION) \
	  -t ea42gh/$(IMAGE_PYTHON):$(VERSION) -t ea42gh/$(IMAGE_PYTHON):$(RUNTIME_TAG) \
	  --progress=plain $(DOCKER_CACHE_FLAG) --push .
	@echo "<DONE> python $(TIMESTAMP)"

jupyter:
	$(DOCKER_BUILDX_BUILD) --platform linux/arm64,linux/amd64 -f binder/Dockerfile.jupyter \
	  --build-arg BASE_IMAGE=ea42gh/$(IMAGE_PYTHON):$(VERSION) \
	  -t ea42gh/$(IMAGE_JUPYTER):$(VERSION) -t ea42gh/$(IMAGE_JUPYTER):$(RUNTIME_TAG) \
	  --progress=plain $(DOCKER_CACHE_FLAG) --push .
	@echo "<DONE> jupyter $(TIMESTAMP)"

pluto:
	$(DOCKER_BUILDX_BUILD) --platform linux/arm64,linux/amd64 -f binder/Dockerfile.pluto \
	  --build-arg BASE_IMAGE=ea42gh/$(IMAGE_JULIA):$(VERSION) \
	  -t ea42gh/$(IMAGE_PLUTO):$(VERSION) -t ea42gh/$(IMAGE_PLUTO):$(RUNTIME_TAG) \
	  --progress=plain $(DOCKER_CACHE_FLAG) --push .
	@echo "<DONE> pluto $(TIMESTAMP)"

la_course:
	$(DOCKER_BUILDX_BUILD) --platform linux/arm64,linux/amd64 -f binder/Dockerfile.la_course \
	  --build-arg BASE_IMAGE=ea42gh/$(IMAGE_JUPYTER):$(VERSION) \
	  --build-arg JULIA_PRECOMPILE_TASKS=$(JULIA_PRECOMPILE_TASKS) \
	  -t ea42gh/$(IMAGE_LA_COURSE):$(VERSION) -t ea42gh/$(IMAGE_LA_COURSE):$(RUNTIME_TAG) \
	  --progress=plain $(DOCKER_CACHE_FLAG) --push .
	@echo "<DONE> la_course $(TIMESTAMP)"

chain: julia python jupyter la_course # pluto
	@echo "<DONE> chain $(TIMESTAMP)"

C ?= container
CHECKGIT_REPOS ?= ../jupyter-tikz ../matrixlayout ../la_figures ../LAlatex ../GenLAProblems .
git:
	docker cp ~/.gitconfig $C:/home/jovyan
	docker cp ~/.git-credentials $C:/home/jovyan
checkgit:
	@$(PYTHON) bin/checkgit.py $(CHECKGIT_REPOS)
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
refresh_deps: refresh_python_deps

check_deps_lock: check_python_deps_lock

refresh_python_deps:
	@set -eu; \
	for version in $(PYTHON_LOCK_VERSIONS); do \
	  echo "Refreshing binder/requirements-py$$version.txt"; \
	  docker run --rm --user root -e LOCK_VERSION=$$version -e PIP_VERSION=$(PIP_VERSION) -e PIP_TOOLS_VERSION=$(PIP_TOOLS_VERSION) -v "$(CURDIR):/work" -w /work python:$$version-slim \
	    sh -lc 'set -eu; apt-get update >/dev/null && apt-get install -y --no-install-recommends $(BINDER_PYTHON_BUILD_DEPS) >/dev/null && python3 -m pip install --upgrade pip==$$PIP_VERSION pip-tools==$$PIP_TOOLS_VERSION >/dev/null && python3 -m piptools compile --upgrade --strip-extras --resolver=backtracking --output-file binder/requirements-py$$LOCK_VERSION.txt binder/requirements.in'; \
	done; \
	cp binder/requirements-py$(PYTHON_LOCK_VERSION).txt binder/requirements.txt
check_python_deps_lock:
	@set -eu; \
	for version in $(PYTHON_LOCK_VERSIONS); do \
	  test -s binder/requirements-py$$version.txt || { echo "Missing binder/requirements-py$$version.txt" >&2; exit 1; }; \
	  echo "Checking binder/requirements-py$$version.txt"; \
	  docker run --rm --user root -e LOCK_VERSION=$$version -e PIP_VERSION=$(PIP_VERSION) -e PIP_TOOLS_VERSION=$(PIP_TOOLS_VERSION) -v "$(CURDIR):/work" -w /work python:$$version-slim \
	    sh -lc 'set -eu; apt-get update >/dev/null && apt-get install -y --no-install-recommends $(BINDER_PYTHON_BUILD_DEPS) >/dev/null && python3 -m pip install --upgrade pip==$$PIP_VERSION pip-tools==$$PIP_TOOLS_VERSION >/dev/null && cp binder/requirements-py$$LOCK_VERSION.txt /tmp/requirements-py$$LOCK_VERSION.txt && python3 -m piptools compile --strip-extras --resolver=backtracking --quiet --output-file /tmp/requirements-py$$LOCK_VERSION.txt binder/requirements.in && sed "/^#    pip-compile --output-file=/d" binder/requirements-py$$LOCK_VERSION.txt | tr -d "\r" > /tmp/requirements.expected && sed -e "/^#    pip-compile --output-file=/d" -e "s#--output-file=/tmp/requirements-py$$LOCK_VERSION.txt#--output-file=binder/requirements-py$$LOCK_VERSION.txt#" /tmp/requirements-py$$LOCK_VERSION.txt | tr -d "\r" > /tmp/requirements.actual && cmp -s /tmp/requirements.actual /tmp/requirements.expected || (echo "binder/requirements-py$$LOCK_VERSION.txt is stale; run make refresh_deps" >&2; diff -u /tmp/requirements.expected /tmp/requirements.actual; exit 1)'; \
	done
check_notebook_api:
	$(PYTHON) bin/check_notebook_api.py $(NOTEBOOK_DIR)

check_notebooks: check_notebook_api
	bash bin/check_notebooks.sh $(NOTEBOOK_DIR) $(NOTEBOOK_TIMEOUT) $(NOTEBOOK_REPORT_DIR) $(NOTEBOOK_STARTUP_TIMEOUT) "$(NOTEBOOK_ONLY)" "$(NOTEBOOK_RESUME_FROM)"

check_integration_smoke:
	bash bin/check_integration_smoke.sh

check_integration_smoke_docker:
	docker run --rm --user $(NOTEBOOK_DOCKER_USER) \
	  -v "$(CURDIR):/work" -w /work $(NOTEBOOK_CHECK_IMAGE) \
	  bash bin/check_integration_smoke.sh

check_notebooks_docker: check_notebook_api
	$(PYTHON) -c "import subprocess; subprocess.run(['docker', 'rm', '-f', '$(NOTEBOOK_CONTAINER)'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)"
	docker run --rm --user root -v "$(CURDIR):/work" -w /work $(NOTEBOOK_CHECK_IMAGE) \
	  bash -lc 'mkdir -p "$(NOTEBOOK_REPORT_DIR)" && chown -R $(NOTEBOOK_DOCKER_USER):$(NOTEBOOK_DOCKER_USER) "$(NOTEBOOK_REPORT_DIR)"'
	docker run --name $(NOTEBOOK_CONTAINER) --rm --user $(NOTEBOOK_DOCKER_USER) \
	  -e NOTEBOOK_STARTUP_TIMEOUT=$(NOTEBOOK_STARTUP_TIMEOUT) \
	  -e NOTEBOOK_ONLY="$(NOTEBOOK_ONLY)" \
	  -e NOTEBOOK_RESUME_FROM="$(NOTEBOOK_RESUME_FROM)" \
	  -v "$(CURDIR):/work" -w /work $(NOTEBOOK_CHECK_IMAGE) \
	  bash bin/check_notebooks.sh $(NOTEBOOK_DIR) $(NOTEBOOK_TIMEOUT) $(NOTEBOOK_REPORT_DIR) $(NOTEBOOK_STARTUP_TIMEOUT) "$(NOTEBOOK_ONLY)" "$(NOTEBOOK_RESUME_FROM)"

refresh_python_deps_local:
	$(PYTHON) -m pip install --upgrade pip==$(PIP_VERSION) pip-tools==$(PIP_TOOLS_VERSION)
	$(PYTHON) -m piptools compile --upgrade --strip-extras --resolver=backtracking \
	  --output-file binder/requirements-py$(PYTHON_LOCK_VERSION).txt \
	  binder/requirements.in
	cp binder/requirements-py$(PYTHON_LOCK_VERSION).txt binder/requirements.txt

# =======================================================================================================
help:
	@echo " l_julia l_python l_pluto l_jupyter l_la_course l_ci_la_course l_chain"
	@echo " julia python pluto jupyter la_course chain"
	@echo " refresh_deps refresh_python_deps refresh_python_deps_local check_deps_lock"
	@echo " check_notebook_api check_notebooks check_notebooks_docker check_integration_smoke check_integration_smoke_docker"
	@echo "   Optional: NOTEBOOK_ONLY=foo.ipynb NOTEBOOK_RESUME_FROM=foo.ipynb NOTEBOOK_STARTUP_TIMEOUT=180"
	@echo " list list_images git check_git"
	@echo " info"

info:
	@echo "VERSION        = $(VERSION)"
	@echo "JULIA_VERSION  = $(JULIA_VERSION)"
	@echo "PYTHON_VERSION = $(PYTHON_VERSION)"
	@echo "RUNTIME_TAG    = $(RUNTIME_TAG)"
	@echo "NO_CACHE       = $(NO_CACHE)"
	@echo "CACHE_FLAG     = $(DOCKER_CACHE_FLAG)"
	@echo "CI_BASE_IMAGE  = $(CI_BASE_IMAGE)"
	@echo "DEPENDENCY_LOCK_IMAGE = $(DEPENDENCY_LOCK_IMAGE)"
# =======================================================================================================
push:
	docker tag $(IMAGE_LA_COURSE):$(VERSION) ea42gh/$(IMAGE_LA_COURSE):$(VERSION)-$(ARCH_SUFFIX)
	docker tag $(IMAGE_LA_COURSE):$(RUNTIME_TAG) ea42gh/$(IMAGE_LA_COURSE):$(RUNTIME_TAG)-$(ARCH_SUFFIX)
	docker push ea42gh/$(IMAGE_LA_COURSE):$(VERSION)-$(ARCH_SUFFIX)
	docker push ea42gh/$(IMAGE_LA_COURSE):$(RUNTIME_TAG)-$(ARCH_SUFFIX)
	docker buildx imagetools create -t ea42gh/$(IMAGE_LA_COURSE):$(VERSION) \
	    ea42gh/$(IMAGE_LA_COURSE):$(VERSION)-amd64 \
	    ea42gh/$(IMAGE_LA_COURSE):$(VERSION)-arm64
	docker buildx imagetools create -t ea42gh/$(IMAGE_LA_COURSE):$(RUNTIME_TAG) \
	    ea42gh/$(IMAGE_LA_COURSE):$(RUNTIME_TAG)-amd64 \
	    ea42gh/$(IMAGE_LA_COURSE):$(RUNTIME_TAG)-arm64
	docker buildx imagetools inspect ea42gh/$(IMAGE_LA_COURSE):$(VERSION)
	docker buildx imagetools inspect ea42gh/$(IMAGE_LA_COURSE):$(RUNTIME_TAG)
	docker buildx imagetools inspect ea42gh/$(IMAGE_LA_COURSE):$(VERSION)-$(ARCH_SUFFIX)
	docker buildx imagetools inspect ea42gh/$(IMAGE_LA_COURSE):$(RUNTIME_TAG)-$(ARCH_SUFFIX)
