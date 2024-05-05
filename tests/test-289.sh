:
# https://github.github.com/gfm/#example-289

trap 'rm -f $IN $EXPECT $OUT' 0
IN=`mktemp /tmp/test-XXXXXX`
EXPECT=`mktemp /tmp/test-XXXXXX`
OUT=`mktemp /tmp/test-XXXXXX`

cat >$IN <<EOF
-   foo

    notcode

-   foo

<!-- -->

    code
EOF

cat >$EXPECT <<EOF
<ul>
<li><p>foo</p>
<p>notcode</p>
</li>
<li><p>foo</p>
</li>
</ul>
<!-- -->
<pre><code>code
</code></pre>
EOF

gawk '@include "markdown.awk"; { lines = lines $0 "\n" } END { printf "%s", markdown::to_html(lines) }' $IN >$OUT

diff -u $EXPECT $OUT
