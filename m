Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FCD4E0B93;
	Wed, 30 Sep 2026 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775145; cv=none; b=ScnDoPKy2ODIz3PULEdrK4SOrzPxnBWw15LYiIRFzaME+Auyk7hKsKYD10HkTvYJmaM4vuLPpTlRAEXucaEcTggITyQMABT1eyRBjjavHuTX2WXRZoZHGUusjTFNOPMs70a0rqZ/7Ng40twKa5CmgTklfECzdMwAc1TbKX2FWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775145; c=relaxed/simple;
	bh=GavR/S1GTlZd8Eqp09CFHIdEEtCFcg32T6xR+AKwVTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VQh+jlLBd6GGZIpzdXFqDSPBJvueaUHAkRz3c/RLV5BBxU20qqjqzLE73UFjfX2xSCUTssbsXNJeYrRAoBYpEgD7KhDIOs969RTIaWE3H0/Vlp5R+rVItyv191KdsvtRqIGgNpumzWTZSE4TEhN6GNw3V5iOAL8FkTuIHXu5TAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1lHq3dT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1lHq3dT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938FE1F00893;
	Wed, 30 Sep 2026 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775137;
	bh=TvCX2nLvtEptZR+okARpJgK2Ns5UKLaQUS+4g7AKHJo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=B1lHq3dTDb22VJ4MeJZCG7rLCj3YyTXPjR7AFpcXO+1W9EqhmVXzxuR0A0RDLwKkC
	 hwpQeLlrqfAwVdcTh+U1y+V7BJ7EC4jvaMNedfoqfm79aaZm0/YQhzu8vVdm/lhSoG
	 oTXST/+dVDYUW04alGheT5JwMZ9vlA4wzOM4v67XA3x1cghGeYaZ8HLQGGUEXObp49
	 UKq6uZ+i39YPHO86ENgpOYJXkhH4qlymcD65fcCc4jGkTuO9lcpHVTOSv/oyasqTun
	 5C34E16jzhmVcjn3ar3wgwUtK2z2i0FGZK9XRFHrMpz2ZnckrqY7cCwJmfYp22Mcsi
	 ZwSZ0ORqYQWTA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:31:57 +0200
Subject: [PATCH 05/17] selftests/filesystems: check that a recursive bind
 mount can't pin the caller's mount namespace
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-work-mount-fixes-3-v1-5-be34c83956ae@kernel.org>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
In-Reply-To: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Amir Goldstein <amir73il@gmail.com>, 
 bpf@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=7391; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GavR/S1GTlZd8Eqp09CFHIdEEtCFcg32T6xR+AKwVTo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt5feX7fhwd1bEeePMF86JNZ+r3u1kO3uqv7S5w+6fp
 TZvfWhrRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERavBgZ5iZNVF/43enhbIcl
 2SKtYZP0Nr1802rndODyrOC3U9dFODIy7Lm5OKq5QupCXZVUrK3+njpm7hxt9oeGSTP63/27VjC
 fDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a test for a recursive bind mount of a namespace file in another mount
namespace:

- a bind mount of the network namespace file, held through a descriptor
- the caller's own mount namespace file stacked on top of it there
- the recursive bind mount through the descriptor fails with EINVAL
- a plain bind mount of the file still works

The copy would pin the namespace it is put in otherwise.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../selftests/filesystems/mount_cycle/.gitignore   |   1 +
 .../selftests/filesystems/mount_cycle/Makefile     |   1 +
 .../filesystems/mount_cycle/nsfs_rbind_loop_test.c | 193 +++++++++++++++++++++
 3 files changed, 195 insertions(+)

diff --git a/tools/testing/selftests/filesystems/mount_cycle/.gitignore b/tools/testing/selftests/filesystems/mount_cycle/.gitignore
index 03ca95de7765..8cd722977a32 100644
--- a/tools/testing/selftests/filesystems/mount_cycle/.gitignore
+++ b/tools/testing/selftests/filesystems/mount_cycle/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 unmounted_tree_test
 overmount_reparent_test
+nsfs_rbind_loop_test
diff --git a/tools/testing/selftests/filesystems/mount_cycle/Makefile b/tools/testing/selftests/filesystems/mount_cycle/Makefile
index 88271c82d1c1..32e26336b132 100644
--- a/tools/testing/selftests/filesystems/mount_cycle/Makefile
+++ b/tools/testing/selftests/filesystems/mount_cycle/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_GEN_PROGS := unmounted_tree_test overmount_reparent_test
+TEST_GEN_PROGS += nsfs_rbind_loop_test
 
 CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
 
diff --git a/tools/testing/selftests/filesystems/mount_cycle/nsfs_rbind_loop_test.c b/tools/testing/selftests/filesystems/mount_cycle/nsfs_rbind_loop_test.c
new file mode 100644
index 000000000000..0928a584eddc
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount_cycle/nsfs_rbind_loop_test.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A recursive bind mount of a namespace file that lives in another mount
+ * namespace copies whatever is stacked on top of it there. If that includes
+ * the file of the caller's own mount namespace, or of an older one, the copy
+ * would pin the namespace it is put in forever. The bind mount has to be
+ * refused, a plain bind mount of the file itself still works.
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
+#include "../../kselftest_harness.h"
+
+#define DIR_LEN 64
+#define PATH_LEN 128
+
+/* Child exit codes. */
+enum {
+	CHILD_OK,
+	CHILD_UNSHARE,		/* could not create the newer mount namespace */
+	CHILD_PIPE,		/* the parent went away */
+	CHILD_TMPFS,		/* could not mount the tmpfs in the new namespace */
+	CHILD_REC_ALLOWED,	/* the recursive bind mount was not refused */
+	CHILD_REC_ERRNO,	/* it was refused with the wrong error */
+	CHILD_PLAIN_REFUSED,	/* the plain bind mount of the file was refused */
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
+static int create_file(const char *path)
+{
+	int fd = open(path, O_WRONLY | O_CREAT | O_CLOEXEC, 0644);
+
+	if (fd < 0)
+		return -1;
+	close(fd);
+	return 0;
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
+static int send_msg(int fd, char msg)
+{
+	return write(fd, &msg, 1) == 1 ? 0 : -1;
+}
+
+static char recv_msg(int fd)
+{
+	char msg;
+
+	if (read(fd, &msg, 1) != 1)
+		return 0;
+	return msg;
+}
+
+FIXTURE(nsfs_rbind_loop) {
+	char dir[DIR_LEN];
+	char x[PATH_LEN];
+};
+
+FIXTURE_SETUP(nsfs_rbind_loop)
+{
+	snprintf(self->dir, sizeof(self->dir), "/tmp/nsfs_rbind_loop.XXXXXX");
+	ASSERT_NE(mkdtemp(self->dir), NULL);
+	if (enter_userns()) {
+		rmdir(self->dir);
+		SKIP(return, "test requires user namespaces");
+	}
+	ASSERT_EQ(mount("tmpfs", self->dir, "tmpfs", 0, NULL), 0);
+	snprintf(self->x, sizeof(self->x), "%s/x", self->dir);
+	ASSERT_EQ(create_file(self->x), 0);
+}
+
+FIXTURE_TEARDOWN(nsfs_rbind_loop)
+{
+	umount2(self->dir, MNT_DETACH);
+	rmdir(self->dir);
+}
+
+/*
+ * The child in the newer mount namespace binds the network namespace file
+ * mount of the parent through @fd. Recursively that would copy the mount of
+ * its own mount namespace file that the parent stacked on top.
+ */
+static int newer_ns_child(const char *dir, int fd, int to_parent, int from_parent)
+{
+	char src[32], y[PATH_LEN];
+
+	if (unshare(CLONE_NEWNS))
+		return CHILD_UNSHARE;
+	if (send_msg(to_parent, 'r') || recv_msg(from_parent) != 'g')
+		return CHILD_PIPE;
+
+	snprintf(y, sizeof(y), "%s/y", dir);
+	if (mount("tmpfs", y, "tmpfs", 0, NULL))
+		return CHILD_TMPFS;
+	snprintf(src, sizeof(src), "/proc/self/fd/%d", fd);
+	snprintf(y, sizeof(y), "%s/y/f", dir);
+	if (create_file(y))
+		return CHILD_TMPFS;
+
+	if (!mount(src, y, NULL, MS_BIND | MS_REC, NULL))
+		return CHILD_REC_ALLOWED;
+	if (errno != EINVAL)
+		return CHILD_REC_ERRNO;
+	if (mount(src, y, NULL, MS_BIND, NULL))
+		return CHILD_PLAIN_REFUSED;
+	umount2(y, MNT_DETACH);
+	return CHILD_OK;
+}
+
+TEST_F(nsfs_rbind_loop, own_ns_file_below_foreign_source)
+{
+	int to_child[2], to_parent[2], fd, status;
+	char p[PATH_LEN];
+	pid_t pid;
+
+	snprintf(p, sizeof(p), "%s/y", self->dir);
+	ASSERT_EQ(mkdir(p, 0755), 0);
+
+	/* M, a mount of our network namespace file, held by a descriptor */
+	ASSERT_EQ(mount("/proc/self/ns/net", self->x, NULL, MS_BIND, NULL), 0);
+	fd = open(self->x, O_PATH | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+
+	ASSERT_EQ(pipe(to_child), 0);
+	ASSERT_EQ(pipe(to_parent), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		close(to_child[1]);
+		close(to_parent[0]);
+		_exit(newer_ns_child(self->dir, fd, to_parent[1], to_child[0]));
+	}
+	close(to_child[0]);
+	close(to_parent[1]);
+	ASSERT_EQ(recv_msg(to_parent[0]), 'r');
+
+	/* the child's mount namespace file on top of M */
+	snprintf(p, sizeof(p), "/proc/%d/ns/mnt", pid);
+	ASSERT_EQ(mount(p, self->x, NULL, MS_BIND, NULL), 0);
+
+	ASSERT_EQ(send_msg(to_child[1], 'g'), 0);
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), CHILD_OK);
+
+	close(fd);
+	ASSERT_EQ(umount2(self->x, MNT_DETACH), 0);
+	ASSERT_EQ(umount2(self->x, MNT_DETACH), 0);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

