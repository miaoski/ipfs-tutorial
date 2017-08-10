
url="http://localhost:8080/ipfs/"

publish:
	@export hash=$(shell ipfs add -r -q . | tail -n1); \
		echo $$hash >published-version; \
		echo $(url)$$hash/mdown
