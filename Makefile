lu := \"lastUpdated\": \"
ts := \"lastUpdated\": \"$(shell /bin/date "+%Y-%m-%d %H:%M:%S")\"

all:
	sed -i '' "s/$(lu).*/$(ts)/" 'docs/SafetyLit MODS.js'
	cd docs && diff -u MODS.js 'SafetyLit MODS.js' > '../SafetyLit MODS.js.patch' || true

install:
	make all
	cp 'docs/SafetyLit MODS.js' ~/.BBTZ5TEST/zotero/translators

update:
	make all
	git add docs *.patch
	git commit -m 'update'
	git push
