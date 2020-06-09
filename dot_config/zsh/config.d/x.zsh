function x ()
{
    # If we have atool installed then use it.
    if ( which atool 2>/dev/null >/dev/null ) ; then
        atool --extract "$@"
        return
    fi

    for archive in "$@"; do
        case "$archive" in
            *.tar* | *.t?z)
                case $archive in
                    *.gz | *tgz | *.Z)
                        TARFLAGS="--use-compress-prog gzip"
                    ;;
                    *.bz | *.bz2 | *tbz)
                        TARFLAGS="--use-compress-prog bzip2"
                    ;;
                    *)
                        TARFLAGS=""
                    ;;
                esac;
                tar xf "$archive" ${TARFLAGS}
            ;;
            *.zip | *.ZIP)
                unzip -q "$archive"
            ;;
            *.gz | *.GZ)
                gunzip "$archive"
            ;;
            *.deb)
                dpkg-deb -x "$archive" .
            ;;
            *.rar)
                unrar x "$archive"
            ;;
            *.cpio)
                cpio --extract --make-directories --file="$archive"
            ;;
            *.cpio.gz)
                gzip -dc "$archive" | cpio --extract --make-directories
            ;;
            *)
                echo "Unknown archive format" 1>&2
            ;;
        esac;
    done
}
