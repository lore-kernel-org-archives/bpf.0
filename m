Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6CE313293;
	Wed, 30 Sep 2026 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775156; cv=none; b=fX/fT0dvSML01EOtNQ2ZAO2dM3RA8qjLcuF5i/bzcnaTuwh9/JACnHLnX6EbbCNzvZhe9I5lqmeTL9wK6YWWDcCKV6P6uJI2+9CEXVFCEdx9fJFBWY3AhfXjiELmvcu3CXDxf4EThi2Wa78suOzvXkR+6ctf4HPcWFZTOxTscnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775156; c=relaxed/simple;
	bh=gEZl0mEsaZa7WRddcC5Z11Ytf+YG3fBvZAlD07TScVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q1MFvHHuXNH0iDzeC4i2Q+uN6kQLXoBzxH7GsFY7wR31sFEV4vEGkU6gUiRy7/PkHeabJTNMMpXqoGvDLiSIs1zRcbMUwQJ9vnPa7hghFYmUxhX6xVk8DIIofIxIXPYC0c5YbhFAEszlsDX+0PIGmj0AOLcMOCspXw3bXXsL0x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVsuIDrt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVsuIDrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B5C1F00893;
	Wed, 30 Sep 2026 13:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775149;
	bh=Oxs1RSDdbFw+U5c15rxuJZGpgcDnHWe6oqt/PqNeMvc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mVsuIDrt+3cr2RDkx5p12m3E9LmDFECQ7msoQbUI2Xhr6+UEpjVSIjxEuVcEbtcHu
	 cNg2I7x69Wt6KdMr9YUt6QBtESIi7tIsLByvAI533FT9AMSC2KR7JJhQewz3/Sy4ej
	 Jw2Hty2JI12aiWGMz4un5yZwvqFaRTCsgUOFYLfUM6nfumcWutM8NEllGaimL7IYeI
	 Nl8jsRK68wjGiuBTAbzqlKQRkFCXtBvfweQ6C/1sUDlO8+rSrgNvOpBSJg04WsJSTO
	 /3akbH+5KzZ8wxGueo8AeQSTOzHtiMA1P+XDhCDOjHwajCbY2DhbeQihvqazf7CIIz
	 n7ytMUHOb69ug==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:32:01 +0200
Subject: [PATCH 09/17] selftests/filesystems: check that a mount namespace
 file on top doesn't bury a mount
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-work-mount-fixes-3-v1-9-be34c83956ae@kernel.org>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
In-Reply-To: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Amir Goldstein <amir73il@gmail.com>, 
 bpf@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=7508; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gEZl0mEsaZa7WRddcC5Z11Ytf+YG3fBvZAlD07TScVA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt5fcXqd17Yu0nWSWFdU7v58ruet1441LGgvUtwiJa5
 4XYOydydpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkxiuG/4mvvfcYujZJtdks
 mZt0JCWC5dEUuS1VffFsHqvWxDQH9TP8Fe6yfnBnecju7b9V22fvOb9ySwXzKR5X+Q0Td56bY5J
 +lB0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a test for moving a mount with a mount namespace file on top of it:

- S, a bind mount of a file, with a newer mount namespace's file on top
- A shared with a slave B that has Q on B/file
- S moved onto A/file, its copy lands on B/file below Q

B/file keeps reading Q and once Q is unmounted it reads the copy.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../selftests/filesystems/mount_cycle/.gitignore   |   1 +
 .../selftests/filesystems/mount_cycle/Makefile     |   2 +-
 .../mount_cycle/overmount_ns_file_test.c           | 187 +++++++++++++++++++++
 3 files changed, 189 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount_cycle/.gitignore b/tools/testing/selftests/filesystems/mount_cycle/.gitignore
index 8cd722977a32..d11f5b720d5b 100644
--- a/tools/testing/selftests/filesystems/mount_cycle/.gitignore
+++ b/tools/testing/selftests/filesystems/mount_cycle/.gitignore
@@ -2,3 +2,4 @@
 unmounted_tree_test
 overmount_reparent_test
 nsfs_rbind_loop_test
+overmount_ns_file_test
diff --git a/tools/testing/selftests/filesystems/mount_cycle/Makefile b/tools/testing/selftests/filesystems/mount_cycle/Makefile
index 32e26336b132..49a8402ca858 100644
--- a/tools/testing/selftests/filesystems/mount_cycle/Makefile
+++ b/tools/testing/selftests/filesystems/mount_cycle/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_GEN_PROGS := unmounted_tree_test overmount_reparent_test
-TEST_GEN_PROGS += nsfs_rbind_loop_test
+TEST_GEN_PROGS += nsfs_rbind_loop_test overmount_ns_file_test
 
 CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
 
diff --git a/tools/testing/selftests/filesystems/mount_cycle/overmount_ns_file_test.c b/tools/testing/selftests/filesystems/mount_cycle/overmount_ns_file_test.c
new file mode 100644
index 000000000000..c24436a17c0f
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount_cycle/overmount_ns_file_test.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A mount namespace file bind-mounted on top of the mount that is moved
+ * onto a shared mount isn't copied to the peers and slaves. The mount that
+ * already sits at the destination in a slave has to end up on top of the
+ * propagated copy, not below the root of the mount namespace file where no
+ * path walk ever finds it.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+
+#include "../wrappers.h"
+#include "../../kselftest_harness.h"
+
+#define DIR_LEN 64
+#define PATH_LEN 128
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
+/* the first bytes of the file at @path, "" if it can't be read */
+static const char *read_file(const char *path, char *buf, size_t len)
+{
+	ssize_t n = -1;
+	int fd;
+
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd >= 0) {
+		n = read(fd, buf, len - 1);
+		close(fd);
+	}
+	buf[n > 0 ? n : 0] = '\0';
+	return buf;
+}
+
+/* Become root in a new user namespace with a private mount namespace. */
+static int enter_userns(void)
+{
+	uid_t uid = getuid();
+	gid_t gid = getgid();
+	char map[32];
+
+	if (unshare(CLONE_NEWUSER | CLONE_NEWNS))
+		return -1;
+	if (write_file("/proc/self/setgroups", "deny") && errno != ENOENT)
+		return -1;
+	snprintf(map, sizeof(map), "0 %d 1", uid);
+	if (write_file("/proc/self/uid_map", map))
+		return -1;
+	snprintf(map, sizeof(map), "0 %d 1", gid);
+	if (write_file("/proc/self/gid_map", map))
+		return -1;
+	if (setgid(0) || setuid(0))
+		return -1;
+	return mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL);
+}
+
+FIXTURE(overmount_ns_file) {
+	char dir[DIR_LEN];
+	pid_t child;
+};
+
+FIXTURE_SETUP(overmount_ns_file)
+{
+	self->child = -1;
+	snprintf(self->dir, sizeof(self->dir), "/tmp/overmount_ns_file.XXXXXX");
+	ASSERT_NE(mkdtemp(self->dir), NULL);
+	if (enter_userns()) {
+		rmdir(self->dir);
+		SKIP(return, "test requires user namespaces");
+	}
+	ASSERT_EQ(mount("tmpfs", self->dir, "tmpfs", 0, NULL), 0);
+}
+
+FIXTURE_TEARDOWN(overmount_ns_file)
+{
+	if (self->child > 0) {
+		kill(self->child, SIGKILL);
+		waitpid(self->child, NULL, 0);
+	}
+	umount2(self->dir, MNT_DETACH);
+	rmdir(self->dir);
+}
+
+/*
+ * A is a shared tmpfs and B its slave with Q, a bind mount of a file, on
+ * B/file. S is a bind mount of a file with N, a bind mount of a newer mount
+ * namespace's file, on top of it. S is moved onto A/file. Its copy S' lands
+ * on B/file below Q, without N. B/file keeps reading Q and once Q is
+ * unmounted it reads S'.
+ */
+TEST_F(overmount_ns_file, existing_mount_stays_on_top)
+{
+	char a[PATH_LEN], b[PATH_LEN], s[PATH_LEN], p[PATH_LEN], buf[16];
+	int fd, pfd[2];
+	char c;
+
+	snprintf(a, sizeof(a), "%s/A", self->dir);
+	snprintf(b, sizeof(b), "%s/B", self->dir);
+	snprintf(s, sizeof(s), "%s/s", self->dir);
+	ASSERT_EQ(mkdir(a, 0755), 0);
+	ASSERT_EQ(mkdir(b, 0755), 0);
+	ASSERT_EQ(mkdir(s, 0755), 0);
+
+	/* A shared, B its slave, Q on B/file */
+	ASSERT_EQ(mount("tmpfs", a, "tmpfs", 0, NULL), 0);
+	ASSERT_EQ(mount(NULL, a, NULL, MS_SHARED, NULL), 0);
+	snprintf(p, sizeof(p), "%s/A/file", self->dir);
+	ASSERT_EQ(create_file(p, "A"), 0);
+	ASSERT_EQ(mount(a, b, NULL, MS_BIND, NULL), 0);
+	ASSERT_EQ(mount(NULL, b, NULL, MS_SLAVE, NULL), 0);
+	snprintf(p, sizeof(p), "%s/Q", self->dir);
+	ASSERT_EQ(create_file(p, "Q"), 0);
+	snprintf(b, sizeof(b), "%s/B/file", self->dir);
+	ASSERT_EQ(mount(p, b, NULL, MS_BIND, NULL), 0);
+
+	/* S on s/f, pinned by a file descriptor before N goes on top */
+	ASSERT_EQ(mount("tmpfs", s, "tmpfs", 0, NULL), 0);
+	snprintf(p, sizeof(p), "%s/s/f", self->dir);
+	ASSERT_EQ(create_file(p, "f"), 0);
+	snprintf(s, sizeof(s), "%s/s/S", self->dir);
+	ASSERT_EQ(create_file(s, "S"), 0);
+	ASSERT_EQ(mount(s, p, NULL, MS_BIND, NULL), 0);
+	fd = open(p, O_PATH | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+
+	/* a newer mount namespace whose file can be bound */
+	ASSERT_EQ(pipe(pfd), 0);
+	self->child = fork();
+	ASSERT_GE(self->child, 0);
+	if (self->child == 0) {
+		if (unshare(CLONE_NEWNS) || write(pfd[1], "r", 1) != 1)
+			_exit(1);
+		pause();
+		_exit(0);
+	}
+	ASSERT_EQ(read(pfd[0], &c, 1), 1);
+	snprintf(s, sizeof(s), "/proc/%d/ns/mnt", self->child);
+	ASSERT_EQ(mount(s, p, NULL, MS_BIND, NULL), 0);
+
+	ASSERT_STREQ(read_file(b, buf, sizeof(buf)), "Q");
+
+	snprintf(a, sizeof(a), "%s/A/file", self->dir);
+	ASSERT_EQ(sys_move_mount(fd, "", AT_FDCWD, a, MOVE_MOUNT_F_EMPTY_PATH), 0);
+	close(fd);
+
+	/* Q is still on top of the copy in B and can be unmounted */
+	EXPECT_STREQ(read_file(b, buf, sizeof(buf)), "Q");
+	EXPECT_EQ(umount2(b, 0), 0);
+	EXPECT_STREQ(read_file(b, buf, sizeof(buf)), "S");
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

