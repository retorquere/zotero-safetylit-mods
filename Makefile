lu := \"lastUpdated\": \"
ts := \"lastUpdated\": \"$(shell /bin/date "+%Y-%m-%d %H:%M:%S")\"

all:
	sed -i '' "s/$(lu).*/$(ts)/" 'docs/SafetyLit MODS.js'
	cd docs && diff -u MODS.js 'SafetyLit MODS.js' > '../SafetyLit MODS.js.patch' || true
