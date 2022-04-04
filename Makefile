mock:
	docker run --init --rm -v $(PWD)/contract/petstore/spec:/tmp -p 4010:4010 stoplight/prism:4 mock -h 0.0.0.0 "/tmp/index.yaml"

dynamic-mock:
	docker run --init --rm -v $(PWD)/contract/petstore/spec:/tmp -p 4010:4010 stoplight/prism:4 mock -h 0.0.0.0 "/tmp/index.yaml" --dynamic
