Name:           count-files
Version:        2.0
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
total size and the biggest file.
Version 2.0 adds a man page, a config file and the -h option. 


%prep
%setup -q

%install
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_sysconfdir}
mkdir -p %{buildroot}%{_mandir}/man1
install -m 755 count_files_homework.sh %{buildroot}%{_bindir}/count_files
install -m 644 count_files.conf %{buildroot}%{_sysconfdir}/count_files.conf
install -m 644 count_files.1 %{buildroot}%{_mandir}/man1/count_files.1

%pre
if [ -f /etc/count_files.conf ] && [ ! -f /etc/count_files.conf.backup ]; then
cp /etc/count_files.conf.backup
fi
echo "Починається встановлення count-files"
exit 0

%post 
if command -v mandb >/dev/null2>&1; then
mandb -q
fi
echo "count-files встановлено. Запустіть count_files."
echo "Введіть цю команду: man count_files"
exit 0

%files
%{_bindir}/count_files
%config(noreplace) %{_sysconfdir}/count_files.conf
%{_mandir}/man1/count_files.1*

%changelog

* Thu Oct 22 2026 Zlata Zadumina <zzadumina@gmail.com> - 2.0-1
- Add man page, config file and %pre and %post scripts
- Also add -h option and look for the biggest file
- Initial package release

* Thu Oct 22 2026 Zlata Zadumina <zzadumina@gmail.com> - 1.0-1
- Initial package release
