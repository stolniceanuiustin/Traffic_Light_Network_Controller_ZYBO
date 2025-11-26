# 2025-11-26T16:43:33.005507400
import vitis

client = vitis.create_client()
client.set_workspace(path="D:/ProiectSSC")

platform = client.create_platform_component(name = "Software",hw_design = "$COMPONENT_LOCATION/../HardwareZYBO/design_1_wrapper.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0")

platform = client.get_component(name="Software")
status = platform.build()

status = platform.build()

client.delete_component(name="Software")

