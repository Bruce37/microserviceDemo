ENVIRONMENT:=tmp/environment

$(ENVIRONMENT): docker-compose.yml $(wildcard counter/*) $(wildcard poller/*) $(wildcard server/*)
	docker-compose up --build -d
	sleep 1
	mkdir -p $(@D)
	touch $@

.PHONY: test-ci
test-ci: $(ENVIRONMENT)
	bats test/smoke_test.bats

.PHONY: clean
clean:
	docker-compose down
	rm -rf $(ENVIRONMENT)

.PHONY: deploy
deploy:
	docker-compose build
	docker-compose push
