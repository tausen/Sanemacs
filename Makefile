all:
	jekyll build
	sass build/css/main.sass > build/css/main.css
