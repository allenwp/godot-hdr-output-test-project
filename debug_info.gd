extends Label

func _process(_delta: float) -> void:
	var window := get_window()
	var screen := window.current_screen;
	
	var device := RenderingServer.get_rendering_device();
	
	var format := device.screen_get_color_format();
	var format_info: String
	match format:
		RenderingDevice.DataFormat.DATA_FORMAT_B8G8R8A8_UNORM: 
			format_info = "DATA_FORMAT_B8G8R8A8_UNORM";
		RenderingDevice.DataFormat.DATA_FORMAT_R8G8B8A8_UNORM: 
			format_info = "DATA_FORMAT_R8G8B8A8_UNORM";
		RenderingDevice.DataFormat.DATA_FORMAT_A2B10G10R10_UNORM_PACK32: 
			format_info = "DATA_FORMAT_A2B10G10R10_UNORM_PACK32";
		RenderingDevice.DataFormat.DATA_FORMAT_A2R10G10B10_UNORM_PACK32:
			format_info = "DATA_FORMAT_A2R10G10B10_UNORM_PACK32";
		RenderingDevice.DataFormat.DATA_FORMAT_R16G16B16A16_SFLOAT:
			format_info = "DATA_FORMAT_R16G16B16A16_SFLOAT";
		_: 
			format_info = "UNKNOWN";
	
	var color_space := device.screen_get_color_space();
	var color_space_info: String
	match color_space:
		RenderingDevice.ColorSpace.COLOR_SPACE_SRGB_LINEAR:
			color_space_info = "COLOR_SPACE_SRGB_LINEAR";
		RenderingDevice.ColorSpace.COLOR_SPACE_SRGB_NONLINEAR:
			color_space_info = "COLOR_SPACE_SRGB_NONLINEAR";
		RenderingDevice.ColorSpace.COLOR_SPACE_HDR10_ST2084:
			color_space_info = "COLOR_SPACE_HDR10_ST2084";
		_:
			color_space_info = "UNKNOWN";
	
	text = ""
	text += " - DisplayServer Supports HDR: %s\n" % DisplayServer.has_feature(DisplayServer.FEATURE_HDR)
	text += " - RenderingDevice Supports HDR: %s\n" % RenderingServer.get_rendering_device().has_feature(RenderingDevice.SUPPORTS_HDR_OUTPUT)
	text += " - Screen Supports HDR: %s\n" % DisplayServer.screen_is_hdr_supported(screen)
	text += " - Window Supports HDR: %s\n" % DisplayServer.window_is_hdr_output_supported(window.get_window_id())
	
	text += "SCREEN INFO:\n"
	text += " - Min Luminance: %.2f\n" % DisplayServer.screen_get_min_luminance(screen)
	text += " - Max Luminance: %.2f\n" % DisplayServer.screen_get_max_luminance(screen)
	text += " - Max Full Frame Luminance: %.2f\n" % DisplayServer.screen_get_max_full_frame_luminance(screen)
	text += " - SDR White Level: %.2f\n" % DisplayServer.screen_get_sdr_white_level(screen)
	text += " - Output Max Value: %.2f\n" % window.get_hdr_output_max_value()
	
	text += "FORMAT INFO:\n"
	text += " - %s\n" % format_info
	text += " - %s" % color_space_info
	
