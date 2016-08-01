
# RTSPPlayer

* Use

	1. 将 FFmpegPlayer 文件夹拖入项目中
	2. 在 Bridging-Header.h 桥文件中添加 #import "VideoFrameExtractor.h"
	3. 在 项目 -> Build Settings -> Search Paths -> Header Search Paths 中 添加下列项目: (... 表示中间缺省的路径)
		* $(inherited)
		* $(PROJECT_DIR)/.../FFmpegPlayer/include
	4. 在需要播放的位置，放置 UIImageView。
	5. 调用 FFMpegPlayer(view: imageView, delegate: self) 创建 FFMpegPlayer.
	6. player.play()
