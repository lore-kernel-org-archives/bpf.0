Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB24DEC38;
	Wed, 30 Sep 2026 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775154; cv=none; b=Ok1d6jGoM08P125fLZZt9mRydvbEaMLqQNg+G7ZxflHO4KVJ0r63u/YY+2HXr4qBKZ5ihPa5BDRZ04lvO7atjT3tVzxIOHeiEcTaN5Y9jCEjbF7lbnnnfYK5cdFhMV268F0wJLaPBwrgZ7NjTEmNdDsEdUPC485aGCulgRKL2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775154; c=relaxed/simple;
	bh=gMzUz4rVfYZyudbMnZ+0L/6T4P+6UvD5PpGtMfD2YHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MftmI6YxOSNDN5EJ73lzoAMmd6BPdd229yLF82FZ3YvGbDdBZ6+PeSoU59MDYjyRKOuo5ac4UujJs4huTcROhqcz6tk+mfUvf0RgA1yA6dfle4OO8r5fKiLo1hlij5hQVsNvZXVTOdqPvtnpu0FahcF9Vn36MbhCVI9IY1GicIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgAqZBRm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgAqZBRm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C941F0089C;
	Wed, 30 Sep 2026 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775143;
	bh=S96j5y3s8dYgxkxSjIicPcvsvvUENgeIYqG1VOhlmaE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZgAqZBRmHQ5JPY3pfOyRXYiPxaHiSoruAvShNdbnWzTAhRtwum6pi+iUr/VFxYZb1
	 HX3hQE4l02lhmZb0j04UgTUajRCF5eu69jUrlI0p8DKnR2VQCR2Z64UoB/sCO/u+Zk
	 GdcsZf5CEst7LrcY7YImdsCdy3tzGYdqOdtID/cAuYklmZmQCFoYDA1xyGJwbIwzi3
	 nlxFMplP49kwWLt6LQaUz/0YVCVM0+ueV616Ckm/7DOgCkZrDUBH/b6rYNPnlCyJow
	 RhwVJIewbBQlBusSgy3A5Wm0fs8LGRLbuo70SspXuDlkQoipMtKDk/K+4pBtvjrVdb
	 5ZBNZi7Q4v7PA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:31:59 +0200
Subject: [PATCH 07/17] selftests/filesystems: check that
 OPEN_TREE_NAMESPACE keeps mounts covered
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-work-mount-fixes-3-v1-7-be34c83956ae@kernel.org>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
In-Reply-To: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Amir Goldstein <amir73il@gmail.com>, 
 bpf@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=7195; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gMzUz4rVfYZyudbMnZ+0L/6T4P+6UvD5PpGtMfD2YHQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt5ffXaFOLVbe1dwhhDXvLtulwo2fCznc1zbzKe0I49
 ixzExfqKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmIjxc4a/EpYnznoW/GmPCr3G
 tu3/k7Yf7FJyPusnrC1iuMGoPUn6AcP/wFkyE6MuBtxt9kiodngep7pCYo9+vri7HHvtr8LA4zq
 sAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a test for open_tree(OPEN_TREE_NAMESPACE) from a user namespace that
doesn't own the mount namespace it copies from:

- a file covered by a private or an unbindable tmpfs mount
- the non-recursive copy of the parent mount fails with EINVAL
- the recursive copy keeps the file covered in the new mount namespace
- the owner of the mount namespace keeps the bind mount semantics

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../selftests/filesystems/open_tree_ns/.gitignore  |   1 +
 .../selftests/filesystems/open_tree_ns/Makefile    |   2 +-
 .../open_tree_ns/open_tree_ns_covered_test.c       | 183 +++++++++++++++++++++
 3 files changed, 185 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/open_tree_ns/.gitignore b/tools/testing/selftests/filesystems/open_tree_ns/.gitignore
index fb12b93fbcaa..76f95c0ae5ef 100644
--- a/tools/testing/selftests/filesystems/open_tree_ns/.gitignore
+++ b/tools/testing/selftests/filesystems/open_tree_ns/.gitignore
@@ -1 +1,2 @@
 open_tree_ns_test
+open_tree_ns_covered_test
diff --git a/tools/testing/selftests/filesystems/open_tree_ns/Makefile b/tools/testing/selftests/filesystems/open_tree_ns/Makefile
index 4976ed1d7d4a..fb2aa77b6edb 100644
--- a/tools/testing/selftests/filesystems/open_tree_ns/Makefile
+++ b/tools/testing/selftests/filesystems/open_tree_ns/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_GEN_PROGS := open_tree_ns_test
+TEST_GEN_PROGS := open_tree_ns_test open_tree_ns_covered_test
 
 CFLAGS += -Wall -O0 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS := -lcap
diff --git a/tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_covered_test.c b/tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_covered_test.c
new file mode 100644
index 000000000000..1b2f1385326a
--- /dev/null
+++ b/tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_covered_test.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * open_tree(OPEN_TREE_NAMESPACE) by a caller that isn't privileged over the
+ * mount namespace it copies from must not reveal what the mounts below the
+ * copied mount cover. Without AT_RECURSIVE the copy is refused when there's
+ * anything mounted below the requested directory. With AT_RECURSIVE
+ * unbindable mounts are copied as well.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+
+#include "../wrappers.h"
+#include "../../kselftest_harness.h"
+
+#ifndef OPEN_TREE_NAMESPACE
+#define OPEN_TREE_NAMESPACE	(1 << 1)
+#endif
+
+#define DIR_LEN 64
+#define PATH_LEN 128
+
+/* Child exit codes. */
+enum {
+	CHILD_OK,
+	CHILD_USERNS,		/* could not create the child user namespace */
+	CHILD_NONREC_ALLOWED,	/* the non-recursive copy was not refused */
+	CHILD_NONREC_ERRNO,	/* it was refused with the wrong error */
+	CHILD_REC_REFUSED,	/* the recursive copy failed */
+	CHILD_SETNS,		/* could not enter the new mount namespace */
+	CHILD_NO_COVER,		/* the covering mount is missing in the copy */
+	CHILD_REVEALED,		/* the covered file is visible in the copy */
+};
+
+static int write_file(const char *path, const char *s)
+{
+	ssize_t n = -1;
+	int fd;
+
+	fd = open(path, O_WRONLY | O_CLOEXEC);
+	if (fd >= 0) {
+		n = write(fd, s, strlen(s));
+		close(fd);
+	}
+	return n == (ssize_t)strlen(s) ? 0 : -1;
+}
+
+static int create_file(const char *path, const char *s)
+{
+	ssize_t n = -1;
+	int fd;
+
+	fd = open(path, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, 0644);
+	if (fd >= 0) {
+		n = write(fd, s, strlen(s));
+		close(fd);
+	}
+	return n == (ssize_t)strlen(s) ? 0 : -1;
+}
+
+/* Become root in a new user namespace, the uid @uid is mapped to 0. */
+static int enter_userns(uid_t uid, gid_t gid)
+{
+	char map[32];
+
+	if (unshare(CLONE_NEWUSER))
+		return -1;
+	if (write_file("/proc/self/setgroups", "deny") && errno != ENOENT)
+		return -1;
+	snprintf(map, sizeof(map), "0 %d 1", uid);
+	if (write_file("/proc/self/uid_map", map))
+		return -1;
+	snprintf(map, sizeof(map), "0 %d 1", gid);
+	if (write_file("/proc/self/gid_map", map))
+		return -1;
+	return setgid(0) || setuid(0) ? -1 : 0;
+}
+
+FIXTURE(open_tree_ns_covered) {
+	char dir[DIR_LEN];
+	char cover[PATH_LEN];
+};
+
+FIXTURE_VARIANT(open_tree_ns_covered) {
+	int propagation;
+};
+
+FIXTURE_VARIANT_ADD(open_tree_ns_covered, private_cover) {
+	.propagation = MS_PRIVATE,
+};
+
+FIXTURE_VARIANT_ADD(open_tree_ns_covered, unbindable_cover) {
+	.propagation = MS_UNBINDABLE,
+};
+
+/*
+ * Root in a user namespace owns a private mount namespace with a tmpfs
+ * on @dir and a second tmpfs covering @dir/covered/under.txt.
+ */
+FIXTURE_SETUP(open_tree_ns_covered)
+{
+	char p[PATH_LEN];
+
+	snprintf(self->dir, sizeof(self->dir), "/tmp/open_tree_ns_covered.XXXXXX");
+	ASSERT_NE(mkdtemp(self->dir), NULL);
+	if (enter_userns(getuid(), getgid()) || unshare(CLONE_NEWNS)) {
+		rmdir(self->dir);
+		SKIP(return, "test requires user namespaces");
+	}
+	ASSERT_EQ(mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+	ASSERT_EQ(mount("tmpfs", self->dir, "tmpfs", 0, NULL), 0);
+
+	snprintf(self->cover, sizeof(self->cover), "%s/covered", self->dir);
+	ASSERT_EQ(mkdir(self->cover, 0755), 0);
+	snprintf(p, sizeof(p), "%s/covered/under.txt", self->dir);
+	ASSERT_EQ(create_file(p, "hidden"), 0);
+	ASSERT_EQ(mount("tmpfs", self->cover, "tmpfs", 0, NULL), 0);
+	ASSERT_EQ(mount(NULL, self->cover, NULL, variant->propagation, NULL), 0);
+}
+
+FIXTURE_TEARDOWN(open_tree_ns_covered)
+{
+	umount2(self->dir, MNT_DETACH);
+	rmdir(self->dir);
+}
+
+/* A caller in a new user namespace that doesn't own the mount namespace. */
+static int foreign_child(const char *dir)
+{
+	struct stat st;
+	int fd;
+
+	if (enter_userns(0, 0))
+		return CHILD_USERNS;
+
+	fd = sys_open_tree(AT_FDCWD, dir, OPEN_TREE_NAMESPACE | OPEN_TREE_CLOEXEC);
+	if (fd >= 0)
+		return CHILD_NONREC_ALLOWED;
+	if (errno != EINVAL)
+		return CHILD_NONREC_ERRNO;
+
+	fd = sys_open_tree(AT_FDCWD, dir,
+			   OPEN_TREE_NAMESPACE | OPEN_TREE_CLOEXEC | AT_RECURSIVE);
+	if (fd < 0)
+		return CHILD_REC_REFUSED;
+	if (setns(fd, CLONE_NEWNS))
+		return CHILD_SETNS;
+	if (stat("/covered", &st))
+		return CHILD_NO_COVER;
+	if (!access("/covered/under.txt", F_OK) || errno != ENOENT)
+		return CHILD_REVEALED;
+	return CHILD_OK;
+}
+
+TEST_F(open_tree_ns_covered, foreign_user_namespace)
+{
+	int status, fd;
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		_exit(foreign_child(self->dir));
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), CHILD_OK);
+
+	/* the owner of the mount namespace keeps bind mount semantics */
+	fd = sys_open_tree(AT_FDCWD, self->dir,
+			   OPEN_TREE_NAMESPACE | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	close(fd);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

