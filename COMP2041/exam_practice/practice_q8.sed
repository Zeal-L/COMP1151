/^[^0-9]/d
/^[0-9]{4}\|[0-9]{3}/d
/^[0-9]{4}\|[0-9][1-9]/d
/^[0-9]{4}\|[2-9]0/d
s/^[0-9]{4}\|.{1,2}\|//
s/(.*)\|(.*)/\2 - \1/