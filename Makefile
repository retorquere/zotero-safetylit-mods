install:
	cp 'docs/SafetyLit MODS.js' ~/.BBTTEST/zotero/translators

split:
	cd docs && git checkout MODS.js
	cd docs && ../header.py --split header.json MODS.js
	cd docs && patch -o 'SafetyLit MODS.js' < '../SafetyLit MODS.patch'

merge:
	cd docs && diff -u MODS.js 'SafetyLit MODS.js' > '../SafetyLit MODS.patch'; status=$$?; if [ $$status -gt 1 ]; then exit $$status; fi
	cd docs && git checkout MODS.js
	cd docs && ../header.py --merge header.json 'SafetyLit MODS.js'

update:
	git add docs *.patch
	git commit -m 'update'
	git push
	@echo published $(shell grep lastUpdated 'docs/SafetyLit MODS.js')

base:
	cd docs && curl -LO https://raw.githubusercontent.com/zotero/translators/master/MODS.js
