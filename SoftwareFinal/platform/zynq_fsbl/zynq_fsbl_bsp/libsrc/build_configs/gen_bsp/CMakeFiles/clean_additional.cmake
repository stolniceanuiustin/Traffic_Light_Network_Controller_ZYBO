# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "")
  file(REMOVE_RECURSE
  "D:\\ProiectSSC\\SoftwareFinal\\platform\\zynq_fsbl\\zynq_fsbl_bsp\\include\\diskio.h"
  "D:\\ProiectSSC\\SoftwareFinal\\platform\\zynq_fsbl\\zynq_fsbl_bsp\\include\\ff.h"
  "D:\\ProiectSSC\\SoftwareFinal\\platform\\zynq_fsbl\\zynq_fsbl_bsp\\include\\ffconf.h"
  "D:\\ProiectSSC\\SoftwareFinal\\platform\\zynq_fsbl\\zynq_fsbl_bsp\\include\\sleep.h"
  "D:\\ProiectSSC\\SoftwareFinal\\platform\\zynq_fsbl\\zynq_fsbl_bsp\\include\\xilffs.h"
  "D:\\ProiectSSC\\SoftwareFinal\\platform\\zynq_fsbl\\zynq_fsbl_bsp\\include\\xilffs_config.h"
  "D:\\ProiectSSC\\SoftwareFinal\\platform\\zynq_fsbl\\zynq_fsbl_bsp\\include\\xilrsa.h"
  "D:\\ProiectSSC\\SoftwareFinal\\platform\\zynq_fsbl\\zynq_fsbl_bsp\\include\\xiltimer.h"
  "D:\\ProiectSSC\\SoftwareFinal\\platform\\zynq_fsbl\\zynq_fsbl_bsp\\include\\xtimer_config.h"
  "D:\\ProiectSSC\\SoftwareFinal\\platform\\zynq_fsbl\\zynq_fsbl_bsp\\lib\\libxilffs.a"
  "D:\\ProiectSSC\\SoftwareFinal\\platform\\zynq_fsbl\\zynq_fsbl_bsp\\lib\\libxilrsa.a"
  "D:\\ProiectSSC\\SoftwareFinal\\platform\\zynq_fsbl\\zynq_fsbl_bsp\\lib\\libxiltimer.a"
  )
endif()
