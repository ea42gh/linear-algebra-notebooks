# Contributing to Elementary Linear Algebra

Thank you for considering contributing to the **Elementary Linear Algebra** project! Your input, feedback, and contributions help make this repository a better resource for learners, educators, and researchers worldwide.

---

## How to Contribute

### 1. Fork the Repository
To contribute, first **fork the repository** to your own GitLab account. This creates a copy of the project where you can make changes.

### 2. Clone Your Fork
Clone your forked repository to your local machine:
```bash
git clone https://gitlab.com/your-username/elementary-linear-algebra.git
cd elementary-linear-algebra
```

### 3. Create a Branch

To keep your changes organized and isolated from the main codebase, create a new branch for your contribution. This helps maintain a clean history and makes it easier to review your work.

#### Steps to Create a Branch

1. Ensure you are on the `master` branch (or the branch from which you want to base your work):
   ```bash
   git checkout master
   ```

2. Pull the latest changes from the main repository to ensure your branch starts from the most up-to-date code:
   ```bash
   git pull --ff-only origin master
   ```

3. Create a new branch for your contribution:
   ```bash
   git checkout -b feature-or-bugfix-name
   ```

#### Naming Your Branch

Use a descriptive branch name that reflects the purpose of your work. Examples:

* *fix-typo-in-readme:* For fixing typos or small corrections in documentation.
* *add-eigenvalue-example:* For adding a new notebook or example related to eigenvalues.
* *update-dockerfile-dependencies:* For updating or modifying the binder/Dockerfile.

By using descriptive names, you make it easier for others to understand the purpose of your branch at a glance.

#### Example Workflow

Here is an example of creating and switching to a branch for adding a new notebook about LU decomposition:
   ```bash
   git checkout -b add-lu-decomposition-notebook
   ```

Your branch is now ready for making changes!


## Validation

Before submitting changes to notebooks, Binder files, or the Julia/Python
integration, run the API and integration checks:

```bash
make check_notebook_api
make check_integration_smoke_docker NOTEBOOK_CHECK_IMAGE=la-course:1.0
make check_notebooks_docker NOTEBOOK_CHECK_IMAGE=la-course:1.0
```

The Docker checks must run against a built `la-course` image because they
exercise the image's shared Julia environment, PythonCall configuration,
LaTeX toolchain, and editable course packages together. The GitHub Actions and
GitLab CI jobs build a temporary `la-course-ci` image and run the same smoke
check against it.
