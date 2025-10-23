# 🗄️ Filesystem Utility ( FSUtil)
fsutil behavior set DisableDeleteNotify 0 # Allow drive trimming for health and performance
fsutil behavior set disablelastaccess 1 # No logging when a file was last edited, less disk writes and overhead
fsutil behavior set memoryusage 2 # More caching
fsutil behavior set disable8dot3 1 # No old filename fallback, less overhead
