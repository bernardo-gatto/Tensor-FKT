# Multilinear Clustering via Tensor Fukunaga–Koontz Transform with Fisher Eigenspectrum Regularization

This repository contains MATLAB code supporting the experiments in the paper:

> **Gatto, B. B., dos Santos, E. M., Molinetti, M. A. F., & Fukui, K.** (2021). *Multilinear clustering via tensor Fukunaga–Koontz transform with Fisher eigenspectrum regularization*. *Applied Soft Computing, 113*, 107899.

---

## Table of Contents

* [Overview](#overview)
* [Dependencies](#dependencies)
* [Data](#data)
* [Code Structure](#code-structure)
* [Usage](#usage)
* [Functions](#functions)
* [Example](#example)
* [Citation](#citation)
* [License](#license)

---

## Overview

This project implements a multilinear subspace clustering approach based on the tensor Fukunaga–Koontz transform (FKT), enhanced with a Fisher eigenspectrum regularization. It applies the Mutual Subspace Method (MSM) over different tensor modes and combines the resulting similarity matrices to perform classification on video data under varying illumination settings.

---

## Dependencies

* **MATLAB** R2019b or later
* **Image Processing Toolbox** (for `imresize3`)

---

## Data

The dataset `cambridge16x12.mat` contains the preprocessed Cambridge hand-gesture video sequences:

```matlab
load('cambridge16x12.mat')
```

* `Data` is a cell array of size `nclass`, each containing 100 video samples.
* Each video sample is a matrix of size `d × t`, where `d = 12 × 16` pixels and `t` is the number of frames.

---

## Code Structure

```plaintext
├── cambridge16x12.mat      % Dataset file
├── main.m                  % Script to run training, testing, and plot confusion matrices
├── Tensor_rep.m            % Function to build mode-1, mode-2, mode-3 unfoldings for a video tensor
├── EVD.m                   % Function for eigenvalue decomposition and basis extraction
└── README.md               % This documentation file
```

---

## Usage

1. **Configure parameters** in `main.m`:

   * Number of classes (`nclass`)
   * Subspace dimensions (`ri1`, `rd1`, etc.)
   * Number of canonical angles (`k`, `k3`)

2. **Run the script**:

   ```matlab
   clear all; close all;
   load('cambridge16x12.mat');
   main;  % or simply execute the content of main.m
   ```

3. **View results**:

   * Three confusion matrices (`confusion1`, `confusion2`, `confusion3`) for each tensor mode
   * Combined similarity matrix `conf_total`

---

## Functions

* **`[X1,X2,X3] = Tensor_rep(D)`**

  * Input: `D` (d × t data matrix)
  * Outputs: Mode-1 unfolding `X1`, Mode-2 unfolding `X2`, Mode-3 unfolding `X3`

* **`[eig_vec,eig_val] = EVD(D)`**

  * Input: `D` (d × n data matrix)
  * Outputs: Sorted eigenvectors and eigenvalues of the covariance matrix

---

## Example

The provided `main.m` script demonstrates:

* Extraction of tensor unfoldings from sample videos
* Basis computation via `EVD`
* Similarity scoring using MSM over three modes
* Weighted combination of similarity matrices
* Visualization of classification performance with `imagesc`

---

## Citation

If you use this code for your research, please cite:

```bibtex
@article{gatto2021multilinear,
  title={Multilinear clustering via tensor Fukunaga--Koontz transform with Fisher eigenspectrum regularization},
  author={Gatto, Bernardo B and dos Santos, Eulanda M and Molinetti, Marco AF and Fukui, Kazuhiro},
  journal={Applied Soft Computing},
  volume={113},
  pages={107899},
  year={2021},
  publisher={Elsevier}
}
```

---

## License

This code is released under the MIT License. See `LICENSE` for details.
