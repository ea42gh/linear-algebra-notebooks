# Elementary Linear Algebra

Explore **Elementary Linear Algebra** concepts and algorithms through over 100 interactive Jupyter Notebooks. This repository is ideal for learners, educators, and researchers looking to deepen their understanding of linear algebra with Python, Julia, and visual tools.

---

## Access to Notebooks and Videos

### YouTube Channel
Enhance your learning with detailed video lectures and tutorials that accompany the notebooks:
- [YouTube Playlist](https://www.youtube.com/playlist?list=PLBDUlnmEqyXD_llq6wETUqRkJGRiu8wFU)

### Interactive Access via Binder

Run the notebooks interactively in your browser (slow):

- [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gl/ea42gh%2Felementary-linear-algebra/master?urlpath=lab/tree/notebooks/Index.ipynb) opens Index.ipynb with jupyter lab

- [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gl/ea42gh%2Felementary-linear-algebra/HEAD?urlpath=tree)   opens a directory view<br>
- [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gl/ea42gh%2Felementary-linear-algebra/master?filepath=notebooks/Index.ipynb) opens Index.ipynb with links to individual notebooks<br>

---

## Repository Overview

### Notebook Index
The **Index.ipynb** notebook provides an overview and links to individual notebooks categorized by topic.

### Notes Directory
The **Notes** directory contains Obsidian-compatible markdown files summarizing the headings in each notebook. This is ideal for creating personalized notes.

### Directory Structure
- **notebooks/**: Read-only directory containing the lecture notebooks.
- **work/**: Writable directory for creating new notebooks and running computations.
- **tmp/**: Temporary directory for file storage during computations.

### Wiki
- Explore the [Wiki](./-/wikis/home).

---

## Docker Image

Simplify your environment setup using our pre-built Docker image:

### Download the Docker Image
```bash
docker pull ea42gh/la_image
```

### Build the Docker Image Locally

To build the Docker image locally, navigate to the binder subdirectory and issue the following command:
```bash
docker build . -t la_image
```

### Update the Repository

To fetch the latest notebooks, use the following commands:
```bash
git fetch --all
git reset --hard origin/main
```

Note: This command will reset all changes in the repository except those in the work directory.

---

## Software and Packages Used

This repository leverages both Julia and Python programming languages to provide robust and interactive learning tools. Below are the key software packages and tools utilized:

- **itikz**: A Python library that generates LaTeX-styled matrix operation diagrams, perfect for creating clean and professional mathematical visuals.  
  - GitHub: [itikz](https://github.com/ea42gh/itikz)  
  - **Note**: When installing locally, ensure the `itikz` directory is added to your Python path.
- **Holoviews** and **Panel**: High-level libraries for interactive plotting and data visualization, enabling real-time exploration of mathematical concepts.  
  - Website: [Holoviz](http://holoviz.org/)

The complete list of dependencies and their installation commands is provided in the `binder/Dockerfile`.

---

## Key Features

This repository offers a comprehensive suite of interactive resources for learning linear algebra, including:

- **Extensive Coverage**: Over 100 Jupyter Notebooks, categorized by topic, covering a wide range of linear algebra concepts:
  - **Matrix Decompositions**: LU, QR, Cholesky, and Singular Value Decomposition (SVD)
  - **Gaussian Elimination**: Step-by-step guides for solving linear systems
  - **Eigenvalues and Eigenvectors**: Detailed explanations, computations, and applications
  - **Applications**: Explore uses in Data Science, Graph Theory, Cryptography, and more
- **Multilingual Implementations**: Examples and algorithms implemented in both Python and Julia for versatility and flexibility.
- **Interactive Learning**: Integration of visualizations, interactive tools, and LaTeX-styled equations for intuitive understanding.
- **Practical Examples**: Real-world applications and computational examples to bridge theory and practice.

---

## Contributions and Feedback

We encourage contributions and feedback from the community to improve and expand this repository.

### How to Contribute
1. **Fork this repository**: Create a copy of the project under your GitLab account.
2. **Create a feature branch**: Work on your changes in a new branch for better organization.
3. **Submit a pull request**: Clearly explain the purpose of your changes and how they enhance the repository.

### Feedback and Issues
Have questions, suggestions, or bug reports?  
Open an issue on this repository to share your feedback or start a discussion.

---

## Acknowledgments

This project would not have been possible without the support of the open-source community and the collaborative efforts of contributors worldwide. We are grateful to everyone who has contributed directly or indirectly to this repository.

### Special Thanks
- **Holoviz**: For providing high-quality libraries like Holoviews and Panel, enabling seamless interactive visualizations in Jupyter Notebooks.  
  - Website: [Holoviz](http://holoviz.org/)
- **itikz**: The original authors of this Python library that integrates LaTeX to produce professional-quality diagrams and illustrations of matrix operations.  
  - GitHub: [itikz](https://github.com/ea42gh/itikz)
- **CTAN nicematrix package**: For its LaTeX tools that enhance the formatting of matrix-related content, providing clean and visually appealing matrix displays in generated diagrams.  
  - CTAN: [nicematrix package](https://ctan.org/pkg/nicematrix)


We also extend our gratitude to educators, researchers, and learners who have shared their insights and feedback, helping us refine and expand this resource.

---

Enjoy exploring the fascinating world of linear algebra, and thank you for being part of our community!

