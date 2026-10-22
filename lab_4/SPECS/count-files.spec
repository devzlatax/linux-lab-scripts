Name:           count-files
Version:        1.0
Release:        1%{?dist}
Summary:        Script to count files in a directory

License:        MIT
URL:            https://github.com/devzlatax/linux-lab-scripts
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch
Requires:       bash
Requires:       coreutils
Requires:       findutils

%description
A Bash script that counts regular files, directories and symblic links in a given 
directory (/etc by default), counts files with a given extension and shows the
total size of the files.

%prep
%setup -q

%install
mkdir -p %{buildroot}%{_bindir}
install -m 755 count_files_homework.sh %{buildroot}%{_bindir}/count_files

%files
%{_bindir}/count_files

%changelog
* Thu Oct 22 2026 Zlata Zadumina <zzadumina@gmail.com> - 1.0-1
- Initial package release
