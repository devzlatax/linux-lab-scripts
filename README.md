# Linux Lab2-3

Bash script and notes for the lab work in the "System Programming and Operating System Administration" course.

## About 
This repository contains a small tool that gathers statistics about a directory on a Linux system: how many regular files, subdirectories and symbolic links it has, how many files have a given extension and how much disk space the files take up in total.

## Content

- `count_files_homework.sh` - the script (it's the extended version of the basic /etc file counter);
- `.github/workflows/syntax-check.yml` - GitHub Actions workflow, which checks the script syntax.

## Usage

```bash
./count_files_homework.sh
```
## How it works
It's reading the directory first. The path is taken from the first command-line argument `$1`. If it's empty, the default value `/etc` is used. Then the script checks that the path is an existing directory. If not, it prints an error message. The user types an extension without a dot and it's stored in a variable for later use. The function `count_items` counts the result lines with `wc -l`. `-maxdepth` isn't used because the search is recursive and goes through all nested subdirectories. A separate `find` call with `-name "*.EXTRA"` counts only with the files, which end with the requested extension. `-printf '$s\n'` prints the size of every file in bytes. The sum is shown in bytes and converted to kilobytes.
<img width="778" height="295" alt="image" src="https://github.com/user-attachments/assets/2a600fc2-89fb-46b0-bef2-a0e169de4812" />

## GitHub Actions
The repository has a simple workflow, which starts automatically on every `push` and `pull_request`. The job runs on `ubuntu-latest`, downloads the code with `actions/checkout@v4` and then checks the script with the command `bash -n count_files_homework.sh`, where `-n` only reads the script and looks for syntax errors.If there aren't erorrs, the job gets a green check mark.
The first run finished successfully.
<img width="1280" height="144" alt="image" src="https://github.com/user-attachments/assets/0e0266a8-dc75-40d9-9837-7118f83119eb" />
<img width="1280" height="529" alt="image" src="https://github.com/user-attachments/assets/0f1eaf8c-3d73-45d7-8bee-5c56bc58b85c" />

## Author

Zlata Zadumina, group PI-242
