tlu := \"lastUpdated\": \"
tts := \"lastUpdated\": \"$(shell /bin/date "+%Y-%m-%d %H:%M:%S")\"
plu := updated:
pts := updated: $(shell /bin/date "+%Y-%m-%d %H:%M:%S")

all:
	sed -i '' "s/$(tlu).*/$(tts)/" 'docs/SafetyLit MODS.js'
	sed -i '' "s/$(plu)[^\\)]*/$(pts)/" 'docs/index.html'
	sed -i '' "s/$(plu)[^\\)]*/$(pts)/" 'README.md'
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
