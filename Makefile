.PHONY: all dev clean build env-up env-down run



run: build
	@echo "Start app ..."
	@./heroes-service


build:
	@echo "Build ..."
	@go build
	@echo "Build done"


env-up:
	@echo "Start environnement ..."
	@cd fixtures && docker-compose up --force-recreate
	@echo "Sleep 15 seconds in order to let the environment setup correctly"
	@echo "Environnement up"

env-down:
	@echo "Stop environnement ..."
	@cd fixtures && docker-compose down
	@echo "Environnement down"



clean: env-down
	@echo "Clean up ..."
	@rm -rf /tmp/enroll_user /tmp/msp heroes-service
	@docker rm -f -v `docker ps -a --no-trunc | grep "heroes-service" | cut -d ' ' -f 1` 2>/dev/null || true
	@docker rmi `docker images --no-trunc | grep "heroes-service" | cut -d ' ' -f 1` 2>/dev/null || true
	@echo "Clean up done"