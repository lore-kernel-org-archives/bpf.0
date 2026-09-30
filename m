Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB564F68A7;
	Wed, 30 Sep 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775169; cv=none; b=nUegX8WOQoJa0wXtGv7eNbHUFQ0qdsEutzqkrwYA3VM2DqG2tlYlhD8n3WNWah+5EXKeBy5GnSNUoyXeNISXiMHddT6NpvcRCKaM4kqHctr2q+LmH76WWfQs40MF7JSPBGgp63mQ834NAk/7qrR2jUAatAX9SXECucnsBISjHh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775169; c=relaxed/simple;
	bh=qAhFc1MKfRPlCnzoOiOLF3NZPByZNr5U3L7UmdgR1WY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vfutw4EPd8RT8cW2H8hmlmm8/BDAGiLOIujTpXSADKnLZj0SA4K7EONPViykbrC5Y9y4Tpr06x/9TGdu9H2yFqGCr6GvMjQV2XukYc/Ca5L4tG89PA7l1HWpoeocOY57xRZgHCOhJVaYhjW1d0ab0q+iUmhYO1M/Aj5BnbFmbCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScYu/8cK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScYu/8cK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9B81F00898;
	Wed, 30 Sep 2026 13:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775157;
	bh=QH5MHjbLZHRgehOfJtLxrSDVUDUvUZovYV2sI4Kr/iM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ScYu/8cKK3bPFejSapFFpmwZbJm6u1fpIVFe0BhGqEI5q3OUED46/c9wdBu1osP8p
	 i7CKAnH2hTVQ1f40YVXAdjMsR+MfEt1ymit1UXIJG69ptz69x1z17M6ZiAlwq2QzkJ
	 MCsjxdflJQnPj8Ss+txH55xk9w0ir3IEF5OR4kqYgigwoVc3QGknBrQaVRqvhmfygE
	 4C0vKI2jvrL8i7MSuR9dNKcOyprL3QlRg5ilzYnybwkVpkhcZlpBN0jWmfw2kMJiHi
	 LT7JJGeWC77m1b4m8/FgOS+9u35fpO42iRgbCNgng54Qt/5rYMm4FAnQl+UgJeA8/2
	 meLs9sKoZQ+fg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:32:04 +0200
Subject: [PATCH 12/17] selftests/filesystems: check that the nullfs root
 can't be reconfigured
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-work-mount-fixes-3-v1-12-be34c83956ae@kernel.org>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
In-Reply-To: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Amir Goldstein <amir73il@gmail.com>, 
 bpf@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4887; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qAhFc1MKfRPlCnzoOiOLF3NZPByZNr5U3L7UmdgR1WY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt5ffPzdy2zeChsNJHE/v/NjKHmtqrcksX+Fz9tWZW5
 pe2ucu/dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykO4aR4U/gu+D+qm8tj101
 4tu6+7k650guXBKx4YfPCjZDvzyLKEaG5w+l52eViPe3tjapJ5tHS3hOld6zeKHGL7u3Bp+lU7a
 xAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a test for the root of an empty mount namespace:

- fspick() of the root fails with EINVAL
- mount(MS_REMOUNT) of the root fails with EINVAL
- umount() of the root fails and doesn't remount it read-only

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../selftests/filesystems/empty_mntns/.gitignore   |   1 +
 .../selftests/filesystems/empty_mntns/Makefile     |   2 +
 .../empty_mntns/internal_sb_reconfigure_test.c     | 108 +++++++++++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/tools/testing/selftests/filesystems/empty_mntns/.gitignore b/tools/testing/selftests/filesystems/empty_mntns/.gitignore
index 99f89d329db2..32125b3eaa80 100644
--- a/tools/testing/selftests/filesystems/empty_mntns/.gitignore
+++ b/tools/testing/selftests/filesystems/empty_mntns/.gitignore
@@ -2,3 +2,4 @@
 clone3_empty_mntns_test
 empty_mntns_test
 overmount_chroot_test
+internal_sb_reconfigure_test
diff --git a/tools/testing/selftests/filesystems/empty_mntns/Makefile b/tools/testing/selftests/filesystems/empty_mntns/Makefile
index 22e3fb915e81..b64818b962ca 100644
--- a/tools/testing/selftests/filesystems/empty_mntns/Makefile
+++ b/tools/testing/selftests/filesystems/empty_mntns/Makefile
@@ -4,9 +4,11 @@ CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS += -lcap
 
 TEST_GEN_PROGS := empty_mntns_test overmount_chroot_test clone3_empty_mntns_test
+TEST_GEN_PROGS += internal_sb_reconfigure_test
 
 include ../../lib.mk
 
 $(OUTPUT)/empty_mntns_test: ../utils.c
 $(OUTPUT)/overmount_chroot_test: ../utils.c
 $(OUTPUT)/clone3_empty_mntns_test: ../utils.c
+$(OUTPUT)/internal_sb_reconfigure_test: ../utils.c
diff --git a/tools/testing/selftests/filesystems/empty_mntns/internal_sb_reconfigure_test.c b/tools/testing/selftests/filesystems/empty_mntns/internal_sb_reconfigure_test.c
new file mode 100644
index 000000000000..cb645d1e5a9a
--- /dev/null
+++ b/tools/testing/selftests/filesystems/empty_mntns/internal_sb_reconfigure_test.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * The root of an empty mount namespace is a nullfs mount. Its superblock is
+ * kernel-internal and shared by every mount namespace. It can't be
+ * reconfigured, neither through fspick() nor through mount(MS_REMOUNT) nor
+ * through umount() of the root which remounts it read-only.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/statfs.h>
+#include <sys/statvfs.h>
+#include <sys/syscall.h>
+#include <sys/vfs.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "../utils.h"
+#include "../wrappers.h"
+#include "empty_mntns.h"
+#include "kselftest_harness.h"
+
+#ifndef __NR_fspick
+#define __NR_fspick 433
+#endif
+
+static int sys_fspick(int dfd, const char *path, unsigned int flags)
+{
+	return syscall(__NR_fspick, dfd, path, flags);
+}
+
+/* Child exit codes. */
+enum {
+	CHILD_OK,
+	CHILD_USERNS,		/* could not create the user namespace */
+	CHILD_UNSHARE,		/* could not create the empty mount namespace */
+	CHILD_FSPICK,		/* fspick() of the root was not refused with EINVAL */
+	CHILD_REMOUNT,		/* mount(MS_REMOUNT) was not refused with EINVAL */
+	CHILD_UMOUNT,		/* umount() of the root succeeded */
+	CHILD_STATFS,		/* statfs() of the root failed */
+	CHILD_RDONLY,		/* the root ended up read-only */
+};
+
+static int empty_mntns_child(void)
+{
+	struct statfs st;
+
+	if (enter_userns())
+		return CHILD_USERNS;
+	if (unshare(UNSHARE_EMPTY_MNTNS))
+		return CHILD_UNSHARE;
+
+	if (sys_fspick(AT_FDCWD, "/", 0) >= 0 || errno != EINVAL)
+		return CHILD_FSPICK;
+	if (!mount(NULL, "/", NULL, MS_REMOUNT | MS_RDONLY, NULL) ||
+	    errno != EINVAL)
+		return CHILD_REMOUNT;
+	if (!umount2("/", 0))
+		return CHILD_UMOUNT;
+	if (statfs("/", &st))
+		return CHILD_STATFS;
+	if (st.f_flags & ST_RDONLY)
+		return CHILD_RDONLY;
+	return CHILD_OK;
+}
+
+FIXTURE(internal_sb_reconfigure) {};
+
+FIXTURE_SETUP(internal_sb_reconfigure)
+{
+	pid_t pid;
+	int status;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		if (enter_userns())
+			_exit(1);
+		if (unshare(UNSHARE_EMPTY_MNTNS))
+			_exit(1);
+		_exit(0);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	if (!WIFEXITED(status) || WEXITSTATUS(status))
+		SKIP(return, "UNSHARE_EMPTY_MNTNS not supported");
+}
+
+FIXTURE_TEARDOWN(internal_sb_reconfigure) {}
+
+TEST_F(internal_sb_reconfigure, nullfs_root)
+{
+	pid_t pid;
+	int status;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		_exit(empty_mntns_child());
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), CHILD_OK);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

