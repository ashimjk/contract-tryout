moduleContractFile := $(shell grep 'inputSpec:' contract/fixed-deposit/server.yaml | tail -n1 | cut -c 13- | rev | cut -c 2- | rev)

generate:
	./cicd/generate.sh
	#npm run generate-server && npm run generate-client

test:
	swagger-cli bundle $(moduleContractFile) -o artifacts/fixed-deposit/server/src/main/resources/fixed-deposit.json

prism:
	docker run --init --rm -v $(PWD)/contract/petstore/spec:/tmp -p 4010:4010 stoplight/prism:4 mock -h 0.0.0.0 "/tmp/index.yaml"

prism-dynamic:
	docker run --init --rm -v $(PWD)/contract/petstore/spec:/tmp -p 4010:4010 stoplight/prism:4 mock -h 0.0.0.0 "/tmp/index.yaml" --dynamic

