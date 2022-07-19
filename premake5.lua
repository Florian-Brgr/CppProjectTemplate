-- core
project_name = "UnnamedProject"

-- directory paths
output_dir = "Win64-%{cfg.buildcfg}"
target_dir = "Bin/" ..output_dir.. "/%{prj.name}"
obj_dir = "Bin/" ..output_dir.. "/Int/%{prj.name}"

-- cpp specs
cpp_dialect = "C++20"

-- workspace
workspace(project_name)
	architecture "x64"
	configurations { "Debug", "Optimized", "Dist" }
	startproject "Testing"

-- main project
project(project_name)
	location "%{prj.name}"
	kind "Staticlib"
	language "C++"
	staticruntime "off"

	targetdir(target_dir)
	objdir(obj_dir)

	cppdialect(cpp_dialect) 
	
	pchheader "Pch.hpp"
	pchsource "%{prj.name}/Src/Pch.cpp"

	files { "%{prj.name}/Src/**", "%{prj.name}/Vendor/**"}
	includedirs { "$(ProjectDir)", "$(ProjectDir)Src/" }

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"
	filter "configurations:Optimized"
		runtime "Release"
		optimize "on"
	filter "configurations:Dist"
		runtime "Release"
		optimize "on"

-- testing project
project "Testing"
	location "%{prj.name}"
	kind "ConsoleApp"
	language "C++"

	targetdir(target_dir)
	objdir(obj_dir)

	cppdialect(cpp_dialect)

	files { "%{prj.name}/Src/**" }
	includedirs { "$(ProjectDir)Src/", project_name.. "/Src/"}
	links { project_name }

	ignoredefaultlibraries { "LIBCMTD" }
	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"
	filter "configurations:Optimized"
		runtime "Release"
		optimize "on"
	filter "configurations:Dist"
		runtime "Release"
		optimize "on"
