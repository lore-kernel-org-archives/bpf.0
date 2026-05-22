Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411F43FFAD3
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458198; cv=none; b=IN8Fg8dBc5sdPB7YRjqa9qqAkSB8HW7jFUZRcfLDdkAd1GmhAQi9lyA8DZnXmiSnc7hSlErrOpxpozItlnW2wGdO58e9ORdzX3+Td1bHrm0CbDtt2SPwi7FGsJtzWAh7i7SMCZ4jN5p+MBP/aK4M0GncqL8VCGyPknLBQZZFTIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458198; c=relaxed/simple;
	bh=VgBqmXIl+uiIRsTT2wLNmNaHj/S17K0jxSrUwoJmzjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PICSCEJBK6dNB8x49ZKHs1+F9tBBSaxtMVwmCkGb58Q3T+UG9w8+DZxgBM+ZyHHTS7MBBG8KjKXSLpJNhISb+J4XSJr/fNJIc5kxwbILtXliV4m9HE0027kpecuPLbIzB4NOSmddiDLpiDsbhYcO+KpzrTY3cI9ZmMJVsdQXZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=XfbmVzv0; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="XfbmVzv0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rTBS2ZjlJtDeTCTdbj21ZmYWkTVaxqSISmA0lopv9Wk=; b=XfbmVzv0s93LVIdeWSbWfrmUsq
	Wu/phNWrJ5ju1LQwRBKVXlBxb9aaDHobGz4QKOeRK91ow6ijWr5UUCUgUSTkN3VZ6bJ1bcdTwvFma
	wLmZJr0l3EaBZxTXMl04pkGC/voyeH5vTQUqn46q9a86WxyVyO6JH8KgtnvdngudgX/SahQ5e+jT9
	jEEgXmTFPucP6M0moO0aMs3qIJjvyEBqqbcLlwqXzSPKX9ZCuS/7ruSgNTqBgvKJN2nvyvRc3iuMy
	51rSQ9wVPusJWPcPZy5u5PxF8LnS+5D9PBxDE6PfJd8FL4FOmb+c7756t71DDOkeHY5l3vSNlN8X7
	EZnKhXUw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wQQMW-000LwD-2K;
	Fri, 22 May 2026 15:56:28 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: brauner@kernel.org,
	kpsingh@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add xattr label test with BPF LSM
Date: Fri, 22 May 2026 15:56:26 +0200
Message-ID: <20260522135626.120732-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522135626.120732-1-daniel@iogearbox.net>
References: <20260522135626.120732-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28008/Fri May 22 08:24:46 2026)

Exercise bpffs extended attribute support together with a BPF LSM
that turns a security.bpf.* label into an immutable, lifecycle-bound
attribute. The example is modeling a user space application invoked
during init that labels pinned BPF objects via "security.bpf.foo"
and having the LSM locking it down. All tests combined now:

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t bpffs_xattr
  [...]
  ./test_progs -t bpffs_xattr
  [    1.654579] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.655378] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  #34/1    bpffs_xattr/prefixes:OK
  #34/2    bpffs_xattr/unsupported_prefix:OK
  #34/3    bpffs_xattr/flags:OK
  #34/4    bpffs_xattr/inode_types:OK
  #34/5    bpffs_xattr/repin_same_path:OK
  #34/6    bpffs_xattr/umount_lifetime:OK
  #34      bpffs_xattr:OK
  #35      bpffs_xattr_label:OK
  Summary: 2/6 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../bpf/prog_tests/bpffs_xattr_label.c        | 114 ++++++++++++++++++
 .../selftests/bpf/progs/bpffs_xattr_label.c   | 102 ++++++++++++++++
 2 files changed, 216 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpffs_xattr_label.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpffs_xattr_label.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpffs_xattr_label.c b/tools/testing/selftests/bpf/prog_tests/bpffs_xattr_label.c
new file mode 100644
index 000000000000..384dde8bb30f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpffs_xattr_label.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#define _GNU_SOURCE
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/xattr.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <test_progs.h>
+
+#include "bpffs_xattr_label.skel.h"
+
+/*
+ * Exercises the bpffs xattr support together with a BPF LSM example:
+ *
+ *   1. pin a BPF map and create a directory in bpffs,
+ *   2. attach the labels (security.bpf.foo) with XATTR_CREATE,
+ *   3. confirm the kernel (BPF LSM) reads back exactly what userspace set,
+ *   4. confirm the label cannot be changed/removed and the pin cannot be
+ *      unlinked/rmdir'd/renamed while labeled,
+ *   5. confirm an unlabeled pin is unaffected (control).
+ */
+
+static const char value_foo[] = "0123456789abcdef0123456789abcdef";
+static const char xattr_foo[] = "security.bpf.foo";
+
+void test_bpffs_xattr_label(void)
+{
+	char map_path[128], labeled_dir[128], plain_dir[128], rename_to[128];
+	char dir[] = "/tmp/bpffs_xattr_label.XXXXXX";
+	struct bpffs_xattr_label *skel = NULL;
+	bool mounted = false;
+	int map_fd = -1, err;
+	char out[64];
+
+	if (!ASSERT_OK_PTR(mkdtemp(dir), "mkdtemp"))
+		return;
+
+	err = mount("bpf", dir, "bpf", 0, NULL);
+	if (!ASSERT_OK(err, "mount_bpffs"))
+		goto out;
+	mounted = true;
+
+	snprintf(map_path, sizeof(map_path), "%s/themap", dir);
+	snprintf(labeled_dir, sizeof(labeled_dir), "%s/labeled", dir);
+	snprintf(plain_dir, sizeof(plain_dir), "%s/plain", dir);
+	snprintf(rename_to, sizeof(rename_to), "%s/renamed", dir);
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "label_map", 4, 4, 1, NULL);
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		goto out;
+	if (!ASSERT_OK(bpf_obj_pin(map_fd, map_path), "map_pin"))
+		goto out;
+	if (!ASSERT_OK(mkdir(labeled_dir, 0755), "mkdir_labeled"))
+		goto out;
+	if (!ASSERT_OK(mkdir(plain_dir, 0755), "mkdir_plain"))
+		goto out;
+
+	skel = bpffs_xattr_label__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load"))
+		goto out;
+	skel->bss->monitored_pid = getpid();
+	if (!ASSERT_OK(bpffs_xattr_label__attach(skel), "skel_attach"))
+		goto out;
+
+	err = setxattr(map_path, xattr_foo, value_foo, sizeof(value_foo),
+		       XATTR_CREATE);
+	if (!ASSERT_OK(err, "setxattr_map_create"))
+		goto out;
+	ASSERT_OK(setxattr(labeled_dir, xattr_foo, value_foo, sizeof(value_foo),
+			   XATTR_CREATE), "setxattr_dir_create");
+
+	err = getxattr(map_path, xattr_foo, out, sizeof(out));
+	ASSERT_EQ(err, sizeof(value_foo), "getxattr_len");
+	ASSERT_MEMEQ(out, value_foo, sizeof(value_foo), "getxattr_value");
+
+	ASSERT_EQ(skel->bss->read_value_len, sizeof(value_foo), "bpf_read_len");
+	ASSERT_MEMEQ(skel->bss->read_value, value_foo, sizeof(value_foo),
+		     "bpf_read_value");
+
+	err = setxattr(map_path, xattr_foo, "changed", sizeof("changed"), 0);
+	ASSERT_EQ(err, -1, "setxattr_replace_ret");
+	ASSERT_EQ(errno, EPERM, "setxattr_replace_errno");
+
+	ASSERT_EQ(removexattr(map_path, xattr_foo), -1, "removexattr_ret");
+	ASSERT_EQ(errno, EPERM, "removexattr_errno");
+
+	ASSERT_EQ(unlink(map_path), -1, "unlink_labeled_ret");
+	ASSERT_EQ(errno, EPERM, "unlink_labeled_errno");
+	ASSERT_EQ(rename(map_path, rename_to), -1, "rename_labeled_ret");
+	ASSERT_EQ(errno, EPERM, "rename_labeled_errno");
+
+	ASSERT_EQ(rmdir(labeled_dir), -1, "rmdir_labeled_ret");
+	ASSERT_EQ(errno, EPERM, "rmdir_labeled_errno");
+
+	ASSERT_OK(rmdir(plain_dir), "rmdir_plain");
+
+	err = getxattr(map_path, xattr_foo, out, sizeof(out));
+	ASSERT_EQ(err, sizeof(value_foo), "getxattr_len_after");
+	ASSERT_MEMEQ(out, value_foo, sizeof(value_foo), "getxattr_value_after");
+
+out:
+	bpffs_xattr_label__destroy(skel);
+	if (map_fd >= 0)
+		close(map_fd);
+	if (mounted) {
+		unlink(map_path);
+		rmdir(labeled_dir);
+		rmdir(plain_dir);
+		umount(dir);
+	}
+	rmdir(dir);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpffs_xattr_label.c b/tools/testing/selftests/bpf/progs/bpffs_xattr_label.c
new file mode 100644
index 000000000000..3891611c3b1c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpffs_xattr_label.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+#include "bpf_misc.h"
+
+const char xattr_foo[] = "security.bpf.foo";
+char _license[] SEC("license") = "GPL";
+
+__u32 monitored_pid;
+
+char read_value[64];
+int read_value_len;
+
+char label_check_buf[64];
+char name_buf[64];
+
+static __always_inline bool name_is_foo(const char *name)
+{
+	bpf_probe_read_kernel(name_buf, sizeof(name_buf), name);
+	return !bpf_strncmp(name_buf, sizeof(xattr_foo), xattr_foo);
+}
+
+static __always_inline bool has_label(struct dentry *dentry)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_mem(label_check_buf, sizeof(label_check_buf), 0, &ptr);
+	return bpf_get_dentry_xattr(dentry, xattr_foo, &ptr) >= 0;
+}
+
+SEC("lsm.s/inode_setxattr")
+int BPF_PROG(label_setxattr, struct mnt_idmap *idmap, struct dentry *dentry,
+	     const char *name, const void *value, size_t size, int flags)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
+		return 0;
+	if (!name_is_foo(name))
+		return 0;
+	if (has_label(dentry))
+		return -EPERM;
+	return 0;
+}
+
+SEC("lsm.s/inode_removexattr")
+int BPF_PROG(label_removexattr, struct mnt_idmap *idmap, struct dentry *dentry,
+	     const char *name)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
+		return 0;
+	if (!name_is_foo(name))
+		return 0;
+	return -EPERM;
+}
+
+SEC("lsm.s/inode_getxattr")
+int BPF_PROG(label_getxattr, struct dentry *dentry, const char *name)
+{
+	struct bpf_dynptr ptr;
+	int ret;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
+		return 0;
+	if (!name_is_foo(name))
+		return 0;
+
+	bpf_dynptr_from_mem(read_value, sizeof(read_value), 0, &ptr);
+	ret = bpf_get_dentry_xattr(dentry, xattr_foo, &ptr);
+	if (ret >= 0)
+		read_value_len = ret;
+	return 0;
+}
+
+SEC("lsm.s/inode_unlink")
+int BPF_PROG(label_unlink, struct inode *dir, struct dentry *victim)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
+		return 0;
+	return has_label(victim) ? -EPERM : 0;
+}
+
+SEC("lsm.s/inode_rmdir")
+int BPF_PROG(label_rmdir, struct inode *dir, struct dentry *victim)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
+		return 0;
+	return has_label(victim) ? -EPERM : 0;
+}
+
+SEC("lsm.s/inode_rename")
+int BPF_PROG(label_rename, struct inode *old_dir, struct dentry *old_dentry,
+	     struct inode *new_dir, struct dentry *new_dentry,
+	     unsigned int flags)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
+		return 0;
+	return has_label(old_dentry) ? -EPERM : 0;
+}
-- 
2.43.0

