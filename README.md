# Linux Lab Scripts

Bash scripts and notes for the laboratory works in the "System Programming and Operating System Administration" course.

## Lab 4: RPM package

### Overview
In this lab i packed my Bash script into an RPM package. The package is named `count-files`. After the installation the script works as the command `count_files` from any folder, and it can be updated or removed with the `rpm` tool.
The script shows statistics for a directory: 
- how many regular files, subdirectories and symbolic links it has;
- how many files have the extension the user enters;
- the total size of all files;
- the biggest file with its size and path.

### What is new in version 2.0
- Config file `/etc/count_files.conf`. The variable `DEFAULT_DIR` sets the directory that is checked  when no parameter is given;
- Man page, so `man count_files` shows the full help;
- Option `-h`, which prints a short help;
- Search for the biggest file in the directory;
- Script `%pre`, which makes a backup of the config before an update;
- Script `%post`, which updates the man database and prints a hint after the installation.

### Configuration
```
DEFAULT_DIR=/etc
```
The directory is chosen in this order: the command-line parameter, then `DEFAULT_DIR` from the config, and `/etc` if there isn't config.

### Build
```bash
cd ~/rpmbuild/SOURCES
tar czvf count-files-2.0.tar.gz count-files-2.0
rpmbuild -ba ~/rpmbuild/SPECS/count-files-2.spec
```
The ready package appears in `~/rpmbuild/RPMS/noarch`.
After checking the package, the first command shows the package info and the second one shows the files inside.
<img width="888" height="460" alt="image" src="https://github.com/user-attachments/assets/4f42735a-f861-47dc-9c10-c39813ef964e" />
<img width="883" height="136" alt="image" src="https://github.com/user-attachments/assets/8bceef2a-c8ef-4d20-969d-fdc0d69c707a" />

### Installation and removal
```bash
sudo rpm -ivh --nodeps ~/rpmbuild/RPMS/noarch/count-files-2.0-1*.rpm
sudo rpm -e count-files
```
I use the option `--nodeps` because I work on Lubuntu. It's a Debian-based system, and its packages are managed by `apt` and `dpkg`. The RPM database doesn't know about them. To update an installed package, i use `-Uvh` instead of `-ivh`.

### Usage
After the installation, run the program with the command `count_files`. The program checks the default directory. It is taken from the configuration file `/etc/count_files.conf`. If there is no config, the directory `/etc` is used. Then the program asks for a file extension. Enter it without a dot and after that it prints the statistics (the number of files directories and symbolic links, the number of files with this extension, the total size and the biggest file).
<img width="676" height="261" alt="image" src="https://github.com/user-attachments/assets/05f9a9ef-c429-4205-86de-7ed91c9a1181" />

To check another directory, write its path after the command `count_files /var/log`. If the directory doesn't exist, the program prints an error message and stops. To see a short help, use the option `-h`.

### Manual Page 
The package includes a manual page. To view it, you need to write a command `man count_files`.
<img width="892" height="628" alt="image" src="https://github.com/user-attachments/assets/70638340-f9be-463b-8d69-ea748b09aef6" />
<img width="895" height="634" alt="image" src="https://github.com/user-attachments/assets/e7f83cf0-3caf-43a9-b18e-b463a74f002b" />


## Lab 2-3

### Content

- `count_files_homework.sh` - the script (it's the extended version of the basic /etc file counter);
- `.github/workflows/syntax-check.yml` - GitHub Actions workflow, which checks the script syntax.

### Usage

```bash
./count_files_homework.sh
```
### How it works
It's reading the directory first. The path is taken from the first command-line argument `$1`. If it's empty, the default value `/etc` is used. Then the script checks that the path is an existing directory. If not, it prints an error message. The user types an extension without a dot and it's stored in a variable for later use. The function `count_items` counts the result lines with `wc -l`. `-maxdepth` isn't used because the search is recursive and goes through all nested subdirectories. A separate `find` call with `-name "*.EXTRA"` counts only with the files, which end with the requested extension. `-printf '$s\n'` prints the size of every file in bytes. The sum is shown in bytes and converted to kilobytes.
<img width="778" height="295" alt="image" src="https://github.com/user-attachments/assets/2a600fc2-89fb-46b0-bef2-a0e169de4812" />

### GitHub Actions
The repository has a simple workflow, which starts automatically on every `push` and `pull_request`. The job runs on `ubuntu-latest`, downloads the code with `actions/checkout@v4` and then checks the script with the command `bash -n count_files_homework.sh`, where `-n` only reads the script and looks for syntax errors.If there aren't erorrs, the job gets a green check mark.
The first run finished successfully.
<img width="1280" height="144" alt="image" src="https://github.com/user-attachments/assets/0e0266a8-dc75-40d9-9837-7118f83119eb" />
<img width="1280" height="529" alt="image" src="https://github.com/user-attachments/assets/0f1eaf8c-3d73-45d7-8bee-5c56bc58b85c" />

### Author

Zlata Zadumina, group PI-242
