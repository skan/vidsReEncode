find video files on windows and log them to "vids2convert.txt"
	dir /b /s *.mp4* >> oldVids.txt

ffmeg command to re encode vids
	ffmpeg.exe -i VI_1835.MOV -c:v libx264 -preset veryfast VI_1835.mkv
