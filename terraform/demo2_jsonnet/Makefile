# 1) install jsonnet (brew install jsonnet)
# 2) execute jsonnet file to json
# 3) run terraform plan, apply, as usual

.PHONY: all

all: default

default:
	jsonnet -o users.tf.json users.tf.jsonnet
