CMD=deploy
build:
	@docker build --tag cdk-github-action-kmzz .

run: build
	@docker run --rm cdk-github-action-kmzz $(CMD)

test:
	./entrypoint.sh $(CMD)
