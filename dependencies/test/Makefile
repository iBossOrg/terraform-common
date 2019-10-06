init: tf-init

plan: init tf-plan

apply: init tf-apply

output: init tf-output

destroy: tf-destroy tf-forget

forget: tf-forget

clean: tf-clean forget

MK_DIR  ?= $(CURDIR)/../../../Mk
include $(MK_DIR)/terraform.mk
