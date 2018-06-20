#!/usr/bin/env bats

@test "await works" {
	run docker-compose run --rm -e ATTEMPTS=5 server \
		npm run-script await-redis
	[ $status -eq 0 ]
	echo "${output}" | grep -Fi 'connection ok'
}

@test "await fails given a bad REDIS_URL" {
	run docker-compose run -e ATTEMPTS=5 -e REDIS_URL=redis://junk --rm server \
		npm run-script await-redis
	[ $status -ne 0 ]
	echo "${output}" | grep -Fi 'connection failed'
}
