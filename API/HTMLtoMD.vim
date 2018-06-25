:%s/<code>/`/g
:%s/<\/code>/`/g
:%s/<a href="\([^"]*\)">\([^>]*\)<\/a>/[\2](\1)/g
:%s/CodeName/SC/g
:%s/<i>/*/g
:%s/<\/i>/*/g
:%s/<b>/**/g
:%s/<\/b>/**/g
:%s/<pre class="CPPListing">/```C++/g
:%s/<pre class="PythonListing">/```python/g
:%s/<\/pre>/```/g
:%s/<p>//g
:%s/<h1>\([^>].*\)<\/h1>/# \1/g
:%s/<h2>\([^>].*\)<\/h2>/## \1/g
:%s/<h3>\([^>].*\)<\/h3>/### \1/g
:%s/<h4>\([^>].*\)<\/h4>/#### \1/g
:%s/^<li>/+ /g
:%s/^[ ]*<li>/+ /g
:%s/<\/li>//g
:%s/<ul>//g
:%s/<ol>//g
:%s/<\/ul>//g
:%s/<\/ol>//g
