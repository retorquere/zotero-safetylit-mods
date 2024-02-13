tlu := \"lastUpdated\": \"
tts := \"lastUpdated\": \"$(shell /bin/date "+%Y-%m-%d %H:%M:%S")\"
plu := Updated:
pts := Updated: $(shell /bin/date "+%Y-%m-%d %H:%M:%S")

all:
	sed -i '' "s/$(tlu).*/$(tts)/" 'docs/SafetyLit MODS.js'
	echo $(pts)
	sed -i '' "s/$(plu).*/$(pts)/" 'docs/index.html'
	cd docs && diff -u MODS.js 'SafetyLit MODS.js' > '../SafetyLit MODS.js.patch' || true

install:
	@make all
	cp 'docs/SafetyLit MODS.js' ~/.BBTZ5TEST/zotero/translators

update:
	@make all
	git add docs *.patch
	git commit -m 'update'
	git push
	@echo published $(shell grep lastUpdated 'docs/SafetyLit MODS.js')
