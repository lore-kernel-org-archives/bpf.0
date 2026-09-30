Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB524CDDE9;
	Wed, 30 Sep 2026 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775145; cv=none; b=Ox4F+QZPbrEZNUsjaeS7aIO1zEdPgRkSL/mFgp01yNmchKHuqOZGy8dLo+O4OhpWN+XcTrBIGSb9vA19QdShTEQ0tifhUOO5onIPAzrlCmq+Jbrb0hPZ+l/TL7XH7Ue35TDBGM7ukxv0UxuBhRpKbRmSMd1zNpOsHFlTexoA4iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775145; c=relaxed/simple;
	bh=ztLM35Qr0oV/05PRMvv+9f4jSxB0/1eBcWA9hwx9q84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B02f7rqErK1HdNsBNRzDYiE3oYo3qlTCbla0s5lk8av1AlY91HQh4EHlO00DPQaRu9nxm0kaDPptxi3/6nRCx3nbxrdFDRg0uHvfDaDEfa9X2eR58llRe2Zr5n7285QQe/SM0kdcmdVSdqEypVSCbrL0mvuLVwrYLhpvIGO0z0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZj3ay2N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZj3ay2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5181F00899;
	Wed, 30 Sep 2026 13:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775132;
	bh=2/g2/v0zHzO2eELEux9kjv+wQvGI8n3JLLLZeJf2UNQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PZj3ay2Ncs5/kv5+FxPjH7WysrT+GuF6u5Fv73wByb2xXpN5bqcdxozszzNpWIBc3
	 p6pxsYEMb4jZE4an7CxBVGiFHCBz08LPCqkZPNeGop8pp0N4cFtyr30hYVwuQhqJR5
	 cty6W4jKS4JstAI2fKBY53BseeQsZZKK9Z42pVXfcAUqQvFqJituvljc0yX3nVh4hk
	 H704ZZ37VVKBt4+ubMiQ1TFKdEBFchRiTxZizpq1bbDEPZgzSjp7jh/YGXF/95meBh
	 0WwG1qZvw4GibPkqc6ZMqfBBK2y4BBhYtDhMgoAUqa4GjyWA+L0d7d/QA0YdVz3rvA
	 0seNL/+uBEDmA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:31:55 +0200
Subject: [PATCH 03/17] selftests/filesystems: check that a busy submount
 survives a synchronous umount
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-work-mount-fixes-3-v1-3-be34c83956ae@kernel.org>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
In-Reply-To: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Amir Goldstein <amir73il@gmail.com>, 
 bpf@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=8569; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ztLM35Qr0oV/05PRMvv+9f4jSxB0/1eBcWA9hwx9q84=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt5ffb+vrYP3b5/RvWqHrfljmRW7n+en+QpE9or+cur
 o+qm5VDOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyMZyR4ZPsyxcnOwXrvb6Y
 TXS5YSS3jVGmgstl6Vdnk39/hDbMXMXIcL9Lu3iSrqfhPj3hsGNxYuyJl9aUn8ya97z64PJbjV3
 qvAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a test for the shrinkable submounts of a synchronous umount:

- P shared, P1 a slave that is shared in turn, P2 its peer
- B on P/options with copies on P1 and P2, R on top of the copy in P2
- P with B moved below P1, R is the working directory
- umount(P1) slides R to where the copy of B is looked up

The umount fails with EBUSY and R stays mounted. Needs the tracefs
automount below debugfs for the shrinkable mounts.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../filesystems/umount_propagation/Makefile        |   2 +-
 .../umount_propagation/shrink_submounts_test.c     | 205 +++++++++++++++++++++
 2 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/umount_propagation/Makefile b/tools/testing/selftests/filesystems/umount_propagation/Makefile
index fc0a0783018b..eb85612abf8d 100644
--- a/tools/testing/selftests/filesystems/umount_propagation/Makefile
+++ b/tools/testing/selftests/filesystems/umount_propagation/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_GEN_PROGS := umount_propagation_test
+TEST_GEN_PROGS := umount_propagation_test shrink_submounts_test
 
 CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
 
diff --git a/tools/testing/selftests/filesystems/umount_propagation/shrink_submounts_test.c b/tools/testing/selftests/filesystems/umount_propagation/shrink_submounts_test.c
new file mode 100644
index 000000000000..43efb7faf95c
--- /dev/null
+++ b/tools/testing/selftests/filesystems/umount_propagation/shrink_submounts_test.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A synchronous umount first unmounts the shrinkable submounts of the
+ * victim that aren't busy. Every one of them has to be checked right
+ * before it is unmounted: unmounting one can slide a busy mount to where
+ * the propagated copy of the next one is looked up.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/fanotify.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/statfs.h>
+#include <sys/vfs.h>
+#include <linux/magic.h>
+
+#include "../../kselftest_harness.h"
+
+#ifndef FAN_REPORT_MNT
+#define FAN_REPORT_MNT		0x00004000
+#endif
+#ifndef FAN_MARK_MNTNS
+#define FAN_MARK_MNTNS		0x00000110
+#endif
+#ifndef FAN_MNT_ATTACH
+#define FAN_MNT_ATTACH		0x01000000
+#endif
+#ifndef FAN_MNT_DETACH
+#define FAN_MNT_DETACH		0x02000000
+#endif
+
+#define DIR_LEN 64
+#define PATH_LEN 128
+
+FIXTURE(shrink_submounts) {
+	char base[DIR_LEN];
+	char automount[PATH_LEN];
+	bool mounted;
+	int fan;
+};
+
+/*
+ * Shrinkable mounts come from an automount. The tracefs mount below debugfs
+ * is one and bind mounts inherit the flag.
+ */
+FIXTURE_SETUP(shrink_submounts)
+{
+	struct stat st;
+	char p[PATH_LEN];
+
+	self->mounted = false;
+	self->fan = -1;
+
+	if (geteuid() != 0)
+		SKIP(return, "test requires CAP_SYS_ADMIN");
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+
+	snprintf(self->base, sizeof(self->base), "/tmp/shrink_submounts.XXXXXX");
+	ASSERT_NE(mkdtemp(self->base), NULL);
+	ASSERT_EQ(mount("tmpfs", self->base, "tmpfs", 0, NULL), 0);
+	self->mounted = true;
+	ASSERT_EQ(mount(NULL, self->base, NULL, MS_PRIVATE, NULL), 0);
+
+	snprintf(p, sizeof(p), "%s/dbg", self->base);
+	ASSERT_EQ(mkdir(p, 0755), 0);
+	if (mount("debugfs", p, "debugfs", 0, NULL))
+		SKIP(return, "test requires debugfs");
+	snprintf(self->automount, sizeof(self->automount), "%s/dbg/tracing",
+		 self->base);
+	snprintf(p, sizeof(p), "%s/dbg/tracing/.", self->base);
+	if (stat(p, &st))
+		SKIP(return, "test requires the tracefs automount");
+}
+
+FIXTURE_TEARDOWN(shrink_submounts)
+{
+	if (self->fan >= 0)
+		close(self->fan);
+	chdir("/");
+	if (self->mounted)
+		umount2(self->base, MNT_DETACH);
+	rmdir(self->base);
+}
+
+static bool mounted_tmpfs(const char *path)
+{
+	struct statfs st;
+
+	return !statfs(path, &st) && st.f_type == TMPFS_MAGIC;
+}
+
+/*
+ * P is a shared bind mount of the automount, P1 a slave of P that is shared
+ * in turn and P2 its peer. B, another bind mount of the automount, goes on
+ * P/options and propagates copies Bc1 and Bc2 onto P1/options and
+ * P2/options. R, a tmpfs and our working directory, sits on top of Bc2 which
+ * is made private first. P, with B on it, is moved to P1/instances.
+ *
+ * A synchronous umount of P1 unmounts the shrinkable submounts Bc1 and B
+ * first. Unmounting Bc1 takes Bc2 along and slides R to P2/options where
+ * the propagated copy of B is looked up next. R is busy, so B has to stay
+ * and the umount fails with EBUSY.
+ */
+TEST_F(shrink_submounts, busy_mount_moved_into_reach)
+{
+	char p[PATH_LEN], p1[PATH_LEN], p2[PATH_LEN], r[PATH_LEN], cwd[PATH_LEN];
+	int nsfd;
+
+	snprintf(p, sizeof(p), "%s/p", self->base);
+	snprintf(p1, sizeof(p1), "%s/p1", self->base);
+	snprintf(p2, sizeof(p2), "%s/p2", self->base);
+	ASSERT_EQ(mkdir(p, 0755), 0);
+	ASSERT_EQ(mkdir(p1, 0755), 0);
+	ASSERT_EQ(mkdir(p2, 0755), 0);
+
+	/* watch the mount namespace so that the detached mounts get queued */
+	self->fan = fanotify_init(FAN_REPORT_MNT, O_RDONLY);
+	if (self->fan >= 0) {
+		nsfd = open("/proc/self/ns/mnt", O_RDONLY | O_CLOEXEC);
+		ASSERT_GE(nsfd, 0);
+		EXPECT_EQ(fanotify_mark(self->fan, FAN_MARK_ADD | FAN_MARK_MNTNS,
+					FAN_MNT_ATTACH | FAN_MNT_DETACH, nsfd, NULL), 0);
+		close(nsfd);
+	}
+
+	ASSERT_EQ(mount(self->automount, p, NULL, MS_BIND, NULL), 0);
+	ASSERT_EQ(mount(NULL, p, NULL, MS_SHARED, NULL), 0);
+	ASSERT_EQ(mount(p, p1, NULL, MS_BIND, NULL), 0);
+	ASSERT_EQ(mount(NULL, p1, NULL, MS_SLAVE, NULL), 0);
+	ASSERT_EQ(mount(NULL, p1, NULL, MS_SHARED, NULL), 0);
+	ASSERT_EQ(mount(p1, p2, NULL, MS_BIND, NULL), 0);
+
+	/* B on P/options, copies on P1/options and P2/options */
+	snprintf(r, sizeof(r), "%s/p/options", self->base);
+	ASSERT_EQ(mount(self->automount, r, NULL, MS_BIND, NULL), 0);
+
+	/* R on top of Bc2 */
+	snprintf(r, sizeof(r), "%s/p2/options", self->base);
+	ASSERT_EQ(mount(NULL, r, NULL, MS_PRIVATE, NULL), 0);
+	ASSERT_EQ(mount("R", r, "tmpfs", 0, NULL), 0);
+	ASSERT_EQ(chdir(r), 0);
+
+	/* P, with B on it, below the victim */
+	snprintf(cwd, sizeof(cwd), "%s/p1/instances", self->base);
+	ASSERT_EQ(mount(p, cwd, NULL, MS_MOVE, NULL), 0);
+
+	ASSERT_TRUE(mounted_tmpfs(r));
+	ASSERT_EQ(umount2(p1, 0), -1);
+	EXPECT_EQ(errno, EBUSY);
+
+	/* R is still mounted and still our working directory */
+	EXPECT_TRUE(mounted_tmpfs(r));
+	ASSERT_NE(getcwd(cwd, sizeof(cwd)), NULL);
+	EXPECT_STREQ(cwd, r);
+}
+
+/*
+ * T is shared and Q, a slave of T, has T moved into it, so Q receives
+ * propagation from its own child. M, another bind mount of the automount, is
+ * on T/options and that is the dentry T sits on in Q. Unmounting M makes T
+ * the propagated victim at that dentry in Q and takes T along. The shrink
+ * walk of V has just unmounted M and continues in the children of T.
+ */
+TEST_F(shrink_submounts, parent_goes_with_child)
+{
+	char v[PATH_LEN], t[PATH_LEN], q[PATH_LEN], p[PATH_LEN];
+	struct stat before, after;
+
+	snprintf(v, sizeof(v), "%s/v", self->base);
+	snprintf(t, sizeof(t), "%s/v/t", self->base);
+	snprintf(q, sizeof(q), "%s/v/q", self->base);
+	ASSERT_EQ(mkdir(v, 0755), 0);
+	ASSERT_EQ(mount("V", v, "tmpfs", 0, NULL), 0);
+	ASSERT_EQ(mount(NULL, v, NULL, MS_PRIVATE, NULL), 0);
+	ASSERT_EQ(stat(v, &before), 0);
+	ASSERT_EQ(mkdir(t, 0755), 0);
+	ASSERT_EQ(mkdir(q, 0755), 0);
+
+	/* T shared, M on T/options before anything receives from T */
+	ASSERT_EQ(mount(self->automount, t, NULL, MS_BIND, NULL), 0);
+	ASSERT_EQ(mount(NULL, t, NULL, MS_SHARED, NULL), 0);
+	snprintf(p, sizeof(p), "%s/v/t/options", self->base);
+	ASSERT_EQ(mount(self->automount, p, NULL, MS_BIND, NULL), 0);
+
+	/* Q, a slave of T, and T moved into Q at the dentry M sits on */
+	ASSERT_EQ(mount(t, q, NULL, MS_BIND, NULL), 0);
+	ASSERT_EQ(mount(NULL, q, NULL, MS_SLAVE, NULL), 0);
+	snprintf(p, sizeof(p), "%s/v/q/options", self->base);
+	ASSERT_EQ(mount(t, p, NULL, MS_MOVE, NULL), 0);
+
+	/* M, T and then Q go, V is empty and can be unmounted */
+	ASSERT_EQ(umount2(v, 0), 0);
+	ASSERT_EQ(stat(v, &after), 0);
+	EXPECT_NE(before.st_dev, after.st_dev);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

