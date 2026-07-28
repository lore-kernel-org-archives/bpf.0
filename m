Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16B043302F;
	Tue, 28 Jul 2026 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785241609; cv=none; b=L+258OPm+SnTeiP2CJrsTnluiUMhAKQa+4s6t13gR1OvEYNmf63XdgHsPhxJJele/TDWPxuxq18dtDIaJswtklWmwkjxmjSMZqJHQILRC4cEibJmRVCrEu2IBt8dYeoSOPyA0NjahaAcKlKfu7o78vSuZOa8I/UZbiFZS/PwR9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785241609; c=relaxed/simple;
	bh=CmftR+Uc2FulAhzpeWNRVyNZ624y2VtvgpyJWGwwBlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tQ+VS8GkUa656sTSBnx35uppGjvIzPADavDtlHvpjzyK/o88f/hJHVyQA3FLnyXx9cwdcbGFtB1H3MV+FsqYgNnwHOkyUv8T2B046ZV1cQ1jLDfWxo9v7i/Qcp4nehJrL+ooWn39wIr0US5OPQCRyLwG+eH3qttLeA6HFPtczPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkwjnDmS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkwjnDmS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CB51F000E9;
	Tue, 28 Jul 2026 12:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785241607;
	bh=vt+CJvPgKyczXyAdtoV88qBhp4afcyiatTku0ZwlgLA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RkwjnDmS64pm/DmPqFCIfCwnQdHdazM/1/l2XmCdXFlJ3GXdmOTjev4t3PRrex56N
	 zYYW2z5f3s4cK6w68uhCmpBC0TVyoWbbCmoScpcSzTe1dcJvt9QzOPKsljwx+LvT1S
	 U9cRFXaNi3zkrrzQuojn2k+93bF18+ES/QjiPvNeN+UvhFbQLRxdWXADGb6aYZt90p
	 j1EUWnYe3iMRWeSj8lhGWGjA2TggoeKZyTuJkIJOYCx6K+EHi4lQjORjySrTMmw8jN
	 6jFD59IFqxu/Ti4XqDmcN0ixxxDH6+ME38K2CziAJbq3xdhmrTJZmtz38bZ6pyS+pM
	 ngI/uOID+H7VQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Jul 2026 14:26:33 +0200
Subject: [PATCH 2/2] selftests/exec: check that a binfmt_misc instance
 cannot be pinned
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-work-binfmt_misc-selfpin-v1-2-74df5daeca5b@kernel.org>
References: <20260728-work-binfmt_misc-selfpin-v1-0-74df5daeca5b@kernel.org>
In-Reply-To: <20260728-work-binfmt_misc-selfpin-v1-0-74df5daeca5b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 Farid Zakaria <farid.m.zakaria@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 bpf@vger.kernel.org, jannh@google.com, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-cca4b
X-Developer-Signature: v=1; a=openpgp-sha256; l=7434; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CmftR+Uc2FulAhzpeWNRVyNZ624y2VtvgpyJWGwwBlM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlzP8XHbF14qzo2Nuvn/toXA25t9lG7uHS9ikdxU/t9
 tw6e1hnfkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEZlxjZLh4h8Vgw62WGfJ3
 OlqEg+aZFajXOk/YKZ9nGt+3a9mez3KMDFt6V5gYzt+9Pl/9NOO7/5vus7Cm+es9U596f0HT0kX
 ySTwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

An 'F' entry whose interpreter keeps the binfmt_misc superblock alive
pins the instance that owns it forever. Cover both ways to build that:

- an interpreter on the instance's own files, control file and entry
  file alike

- and an instance used as an overlayfs lower layer.

Check that an ordinary 'F' registration still succeeds so the fix stays
honest about not changing what 'F' promises.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/exec/Makefile              |  10 ++
 tools/testing/selftests/exec/binfmt_misc_selfpin.c | 158 +++++++++++++++++++++
 tools/testing/selftests/exec/config                |   4 +
 3 files changed, 172 insertions(+)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 45a3cfc435cf..b15505f5e0bc 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -21,6 +21,10 @@ TEST_GEN_PROGS += recursion-depth
 TEST_GEN_PROGS += null-argv
 TEST_GEN_PROGS += check-exec
 
+# binfmt_misc must not be reachable as an exec source or as a stacking layer,
+# or an 'F' entry can pin the instance that owns it. Unprivileged, no bpf.
+TEST_GEN_PROGS += binfmt_misc_selfpin
+
 EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved $(OUTPUT)/xxxxx*	\
 	       $(OUTPUT)/S_I*.test
 
@@ -55,3 +59,9 @@ $(OUTPUT)/script-exec.inc: $(CHECK_EXEC_SAMPLES)/script-exec.inc
 	cp $< $@
 $(OUTPUT)/script-noexec.inc: $(CHECK_EXEC_SAMPLES)/script-noexec.inc
 	cp $< $@
+
+# Reuses setup_userns()/write_file() from the filesystems selftests. Their
+# wrappers.h wants the uapi headers, so ask for them here rather than widening
+# CFLAGS for every program in this directory.
+$(OUTPUT)/binfmt_misc_selfpin: CFLAGS += $(TOOLS_INCLUDES)
+$(OUTPUT)/binfmt_misc_selfpin: ../filesystems/utils.c
diff --git a/tools/testing/selftests/exec/binfmt_misc_selfpin.c b/tools/testing/selftests/exec/binfmt_misc_selfpin.c
new file mode 100644
index 000000000000..5286b0604eed
--- /dev/null
+++ b/tools/testing/selftests/exec/binfmt_misc_selfpin.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An 'F' entry keeps its interpreter open for as long as the entry exists,
+ * and the entry only goes away when the binfmt_misc superblock is destroyed.
+ * An interpreter that lives on a mount which in turn keeps that superblock
+ * alive therefore pins the instance that owns it, and nothing can break the
+ * cycle. Check the two ways userspace could arrange for that: an interpreter
+ * on the binfmt_misc instance itself, and one on a filesystem stacked on it.
+ *
+ * Runs unprivileged in a user namespace; binfmt_misc is FS_USERNS_MOUNT.
+ */
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <limits.h>
+#include <sched.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+
+#include "../filesystems/utils.h"
+#include "kselftest_harness.h"
+
+#define MNT		"/tmp/binfmt_selfpin"
+#define BACKING		"/tmp/binfmt_selfpin_back"
+#define LOWER		BACKING "/lower"
+#define MERGED		"/tmp/binfmt_selfpin_merged"
+
+#define MAGIC		"\\xde\\xad"
+#define RULE(interp)	":selfpin:M::" MAGIC "::" interp ":F"
+/* Not on the instance, and unlike /bin/true it always exists. */
+#define INTERP		"/proc/self/exe"
+
+#define OPTS_MAX	(3 * PATH_MAX + 64)
+
+static int ensure_dir(const char *path)
+{
+	if (mkdir(path, 0755) && errno != EEXIST)
+		return -1;
+	return 0;
+}
+
+/* Write @rule to this instance's register file, preserving write(2)'s errno. */
+static int register_at(struct __test_metadata *_metadata, const char *rule)
+{
+	int fd, saved;
+	ssize_t n;
+
+	fd = open(MNT "/register", O_WRONLY);
+	ASSERT_GE(fd, 0);
+	n = write(fd, rule, strlen(rule));
+	saved = errno;
+	close(fd);
+	errno = saved;
+	return n < 0 ? -1 : 0;
+}
+
+/*
+ * Mount an overlay over @lower using a private upper/work pair, so the two
+ * mounts this test performs cannot interfere with each other and neither
+ * overlaps the lower layer.
+ */
+static int mount_overlay(const char *lower, int nr)
+{
+	char opts[OPTS_MAX], upper[PATH_MAX], work[PATH_MAX];
+
+	snprintf(upper, sizeof(upper), "%s/upper%d", BACKING, nr);
+	snprintf(work, sizeof(work), "%s/work%d", BACKING, nr);
+	if (mkdir(upper, 0755) || mkdir(work, 0755))
+		return -1;
+
+	snprintf(opts, sizeof(opts), "lowerdir=%s,upperdir=%s,workdir=%s",
+		 lower, upper, work);
+	return mount("ovl", MERGED, "overlay", 0, opts);
+}
+
+FIXTURE(selfpin) {
+};
+
+FIXTURE_SETUP(selfpin)
+{
+	/* setup_userns() exits rather than returns if this is not there. */
+	if (access("/proc/self/ns/user", F_OK))
+		SKIP(return, "kernel without user namespaces");
+	ASSERT_EQ(setup_userns(), 0);
+
+	ASSERT_EQ(ensure_dir(MNT), 0);
+	if (mount("binfmt_misc", MNT, "binfmt_misc", 0, NULL)) {
+		int saved = errno;
+
+		/* Teardown doesn't run when setup skips, so clean up here. */
+		rmdir(MNT);
+		SKIP(return, "no binfmt_misc: %s", strerror(saved));
+	}
+}
+
+FIXTURE_TEARDOWN(selfpin)
+{
+	/* The namespaces go with the process; just don't litter /tmp. */
+	umount2(MERGED, MNT_DETACH);
+	umount2(BACKING, MNT_DETACH);
+	umount2(MNT, MNT_DETACH);
+	rmdir(MERGED);
+	rmdir(BACKING);
+	rmdir(MNT);
+}
+
+/*
+ * The instance's own files are regular files the mounter owns, so they can be
+ * made executable. Opening one for exec still has to fail, otherwise the entry
+ * pins the very superblock it lives in.
+ */
+TEST_F(selfpin, interpreter_on_the_instance)
+{
+	ASSERT_EQ(chmod(MNT "/status", 0755), 0);
+
+	ASSERT_NE(register_at(_metadata, RULE(MNT "/status")), 0);
+	EXPECT_EQ(errno, EACCES);
+}
+
+/* Same for an entry file rather than one of the control files. */
+TEST_F(selfpin, interpreter_on_an_entry)
+{
+	ASSERT_EQ(register_at(_metadata, ":victim:M::" MAGIC "::" INTERP ":"), 0);
+	ASSERT_EQ(chmod(MNT "/victim", 0755), 0);
+
+	ASSERT_NE(register_at(_metadata, RULE(MNT "/victim")), 0);
+	EXPECT_EQ(errno, EACCES);
+}
+
+/*
+ * A stacking filesystem holds a private clone of each layer for its whole
+ * lifetime, so an instance used as a layer can be pinned by an interpreter
+ * that does not live on it at all. Refuse to be a layer.
+ */
+TEST_F(selfpin, refuses_to_be_stacked_on)
+{
+	ASSERT_EQ(ensure_dir(BACKING), 0);
+	ASSERT_EQ(mount("tmpfs", BACKING, "tmpfs", 0, NULL), 0);
+	ASSERT_EQ(mkdir(LOWER, 0755), 0);
+	ASSERT_EQ(ensure_dir(MERGED), 0);
+
+	/* Nothing to prove unless overlayfs works here at all. */
+	if (mount_overlay(LOWER, 1)) {
+		if (errno == ENODEV || errno == EPERM)
+			SKIP(return, "no unprivileged overlayfs");
+		SKIP(return, "overlayfs unusable here: %s", strerror(errno));
+	}
+	ASSERT_EQ(umount(MERGED), 0);
+
+	EXPECT_NE(mount_overlay(MNT, 2), 0);
+}
+
+/* An ordinary interpreter still registers with 'F'. */
+TEST_F(selfpin, ordinary_interpreter_still_works)
+{
+	EXPECT_EQ(register_at(_metadata, RULE(INTERP)), 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/exec/config b/tools/testing/selftests/exec/config
index c308079867b3..c03d52d8abee 100644
--- a/tools/testing/selftests/exec/config
+++ b/tools/testing/selftests/exec/config
@@ -1,2 +1,6 @@
 CONFIG_BLK_DEV=y
 CONFIG_BLK_DEV_LOOP=y
+CONFIG_BINFMT_MISC=y
+CONFIG_OVERLAY_FS=y
+CONFIG_TMPFS=y
+CONFIG_USER_NS=y

-- 
2.53.0

