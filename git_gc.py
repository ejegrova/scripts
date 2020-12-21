import tarfile
import os
import git

archive = ".tar.gz"

tmp_dir = "extract"
with tarfile.open(archive, mode="r:gz") as tar:
 	tar.extractall(tmp_dir)

repo = git.Repo(os.path.join(tmp_dir, "app"))
print(repo)

repo.git.gc("--prune=now")
