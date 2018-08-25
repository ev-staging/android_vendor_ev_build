ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
    BOARD_USES_QTI_HARDWARE := true
endif

ifeq ($(BOARD_USES_QTI_HARDWARE),true)
include $(SRC_EVERVOLV_DIR)/build/target/board/BoardConfigQcom.mk
endif
