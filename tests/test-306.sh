:
# https://github.github.com/gfm/#example-306

trap 'rm -f $IN $EXPECT $OUT' 0
IN=`mktemp /tmp/test-XXXXXX`
EXPECT=`mktemp /tmp/test-XXXXXX`
OUT=`mktemp /tmp/test-XXXXXX`

cat >$IN <<EOF
- a
  - b
  - c

- d
  - e
  - f
EOF

cat >$EXPECT <<EOF
<ul>
<li><p>a</p>
<ul>
<li><p>b</p>
</li>
<li><p>c</p>
</li>
</ul>
</li>
<li><p>d</p>
<ul>
<li><p>e</p>
</li>
<li><p>f</p>
</li>
</ul>
</li>
</ul>
EOF

gawk '@include "markdown.awk"; { lines = lines $0 "\n" } END { printf "%s", markdown::to_html(lines) }' $IN >$OUT

diff -u $EXPECT $OUT
