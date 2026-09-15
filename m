Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFD138A73F
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484872; cv=none; b=JwW/enTabn7lRlgmD5et+wpuRzrLjHaN6N9UL/YjqWOzRKh06Bodt3EKhVj8xYI+/lXD6npiAHbSJsiwBdwhgGyKfZ/qHm22Sdy0fGOcM4s+57YRk7gVu6FtLXUpkFZBcFztBZbiYhKEnSzRInpTHE4aKdrMXTT4vCQm2Bxybg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484872; c=relaxed/simple;
	bh=iDBe9sXrW2w52ywnJAXSSJzhDIh2hB0y/rqwA0uceAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTgtw3R9HWe9e5yFcGroHSATR8RavdNrbHZ548pyA634Hykc8l6Bj7kdaU8qy0EKOu+iIfWwOnfKnMv6swLT2VLvoNiQmZ52JFzmWy+EKL4iVfbhcMWC8Ew0ArGLRyoyGau2YYVEL3VJn2kUwKYkinipfTv5KgFMCCTFyxc9xss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=PeciK2OD; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="PeciK2OD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=p2oHioalWYae0vitTf8goxy6OGfXaDr5AfXh588/qbI=; b=PeciK2ODzOzauJb2y0Og4F8JGD
	YXioQ9F7ohm8JTbxAn+PG9VYhVgsgimtd44WZTNoQxxbr2aDtAY4z8KSLzdLQdKaXJw4MSrtC+cp1
	4JOHag+ICluXBOvQ2U4mLq2ZCOAIRb98lMQWfIViTkjMThQXty9etA9GIhM94hgrKuQhzr6/7S6gA
	ZFQ4UNQzsTnCWlsEcvHMeq/DvVFqIxzXwf1IUco7Fw348fPKiBpujGoO02DKzJ1gBQUi6hO6KlAlq
	9EqvOZtLKO15/gtU/uK/X6B3An+EZXZ9UZvodY/4bLxL+JdRxVMZsG1nWxMsbyEC6ARQKqUBYpUUu
	J1TSusRQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x6Ul9-0007LS-34;
	Tue, 15 Sep 2026 17:07:48 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: brauner@kernel.org,
	dwindsor@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 8/8] selftests/bpf: Add tests for BPF LSM inode init labelling
Date: Tue, 15 Sep 2026 17:07:39 +0200
Message-ID: <20260915150739.284189-9-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915150739.284189-1-daniel@iogearbox.net>
References: <20260915150739.284189-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28124/Tue Sep 15 08:27:28 2026)

Exercise bpf_inode_init_xattr() in combination with a policy example
via BPF LSM. A program on the inode_init_security hook labels new files
and directories, inherits a zone label from the parent directory, and
has claims refused for names outside the security.bpf. prefix and for
a name that would exceed XATTR_NAME_MAX once the prefix is put back as
well as other corner case tests that should get rejected.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t lsm_inode_init_xattr
  [...]
  #226/1   lsm_inode_init_xattr/init_labels:OK
  #226/2   lsm_inode_init_xattr/inherit_from_parent:OK
  #226/3   lsm_inode_init_xattr/refused_claims:OK
  #226/4   lsm_inode_init_xattr/null_xattrs:OK
  #226/5   lsm_inode_init_xattr/shared_budget:OK
  #226/6   lsm_inode_init_xattr/value_shapes:OK
  #226     lsm_inode_init_xattr:OK
  Summary: 1/6 PASSED, 0 SKIPPED, 0/0 FAILED

Co-developed-by: David Windsor <dwindsor@gmail.com>
Signed-off-by: David Windsor <dwindsor@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/config            |   2 +
 .../bpf/prog_tests/lsm_inode_init_xattr.c     | 399 ++++++++++++++++++
 .../bpf/progs/lsm_inode_init_xattr.c          |  98 +++++
 .../bpf/progs/lsm_inode_init_xattr_budget.c   |  37 ++
 .../bpf/progs/lsm_inode_init_xattr_value.c    |  47 +++
 5 files changed, 583 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_inode_init_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_inode_init_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_inode_init_xattr_budget.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_inode_init_xattr_value.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 2f79688dcf7c..d292cb60a5a4 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -124,6 +124,8 @@ CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
 CONFIG_SYN_COOKIES=y
 CONFIG_TEST_BPF=m
+CONFIG_TMPFS=y
+CONFIG_TMPFS_XATTR=y
 CONFIG_UDMABUF=y
 CONFIG_USERFAULTFD=y
 CONFIG_VSOCKETS=y
diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_inode_init_xattr.c b/tools/testing/selftests/bpf/prog_tests/lsm_inode_init_xattr.c
new file mode 100644
index 000000000000..b91c5c659542
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_inode_init_xattr.c
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/xattr.h>
+#include <test_progs.h>
+
+#include "lsm_inode_init_xattr.skel.h"
+#include "lsm_inode_init_xattr_budget.skel.h"
+#include "lsm_inode_init_xattr_value.skel.h"
+
+#define INIT_XATTRS_MAX		2
+#define VALUE_SIZE_MAX		(64 * 1024)
+#define TESTDIR			"/tmp/test_progs_lsm_init_xattr"
+#define RAMFSDIR		"/tmp/test_progs_lsm_init_xattr_ramfs"
+
+static bool testdir_mounted;
+static bool ramfsdir_mounted;
+
+static int testdir_setup(void)
+{
+	if (mkdir(TESTDIR, 0755) && errno != EEXIST)
+		return -errno;
+	if (mount("tmpfs", TESTDIR, "tmpfs", 0, NULL))
+		return -errno;
+	testdir_mounted = true;
+	if (mkdir(RAMFSDIR, 0755) && errno != EEXIST)
+		return -errno;
+	if (mount("ramfs", RAMFSDIR, "ramfs", 0, NULL))
+		return -errno;
+	ramfsdir_mounted = true;
+	return 0;
+}
+
+static void testdir_cleanup(void)
+{
+	if (ramfsdir_mounted)
+		umount(RAMFSDIR);
+	rmdir(RAMFSDIR);
+	if (testdir_mounted)
+		umount(TESTDIR);
+	rmdir(TESTDIR);
+}
+
+static bool lsm_is_active(const char *name)
+{
+	char buf[512], *tok;
+	int fd, len;
+
+	fd = open("/sys/kernel/security/lsm", O_RDONLY);
+	if (fd < 0)
+		return true;
+	len = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (len <= 0)
+		return true;
+	buf[len] = '\0';
+	for (tok = strtok(buf, ",\n"); tok; tok = strtok(NULL, ",\n"))
+		if (!strcmp(tok, name))
+			return true;
+	return false;
+}
+
+static int read_label(const char *path, const char *name, char *buf, size_t sz)
+{
+	int ret = getxattr(path, name, buf, sz);
+
+	return ret < 0 ? -errno : ret;
+}
+
+static void assert_label(const char *path, const char *name, const char *want)
+{
+	char buf[64] = {};
+	int ret;
+
+	ret = read_label(path, name, buf, sizeof(buf));
+	if (!ASSERT_EQ(ret, (int)strlen(want) + 1, name))
+		return;
+	ASSERT_STREQ(buf, want, name);
+}
+
+static struct lsm_inode_init_xattr *policy_attach(void)
+{
+	struct lsm_inode_init_xattr *skel;
+
+	skel = lsm_inode_init_xattr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return NULL;
+
+	skel->bss->monitored_pid = getpid();
+	if (!ASSERT_OK(lsm_inode_init_xattr__attach(skel), "skel_attach")) {
+		lsm_inode_init_xattr__destroy(skel);
+		return NULL;
+	}
+	return skel;
+}
+
+static void test_init_labels(void)
+{
+	struct lsm_inode_init_xattr *skel;
+	const char *file = TESTDIR "/file";
+	const char *subdir = TESTDIR "/subdir";
+	int fd = -1;
+
+	skel = policy_attach();
+	if (!skel)
+		return;
+
+	fd = open(file, O_CREAT | O_RDWR, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		goto out;
+
+	if (!ASSERT_TRUE(skel->bss->hook_ran, "hook_ran"))
+		goto out;
+
+	ASSERT_OK(skel->data->zone_err, "zone_err");
+	ASSERT_OK(skel->data->origin_err, "origin_err");
+	assert_label(file, "security.bpf.zone", "default");
+	assert_label(file, "security.bpf.origin", "created");
+
+	if (!ASSERT_OK(mkdir(subdir, 0755), "mkdir"))
+		goto out;
+	assert_label(subdir, "security.bpf.zone", "default");
+	assert_label(subdir, "security.bpf.origin", "created");
+	rmdir(subdir);
+out:
+	if (fd >= 0)
+		close(fd);
+	remove(file);
+	lsm_inode_init_xattr__destroy(skel);
+}
+
+static void test_inherit_from_parent(void)
+{
+	const char *zonedir = TESTDIR "/zoned";
+	const char *file = TESTDIR "/zoned/file";
+	struct lsm_inode_init_xattr *skel;
+	int dirfd = -1, fd = -1, err;
+	struct {
+		char	v[32];
+		__u32	len;
+	} label = {};
+
+	if (!ASSERT_OK(mkdir(zonedir, 0755), "mkdir_zoned"))
+		return;
+
+	skel = policy_attach();
+	if (!skel)
+		goto out_dir;
+
+	dirfd = open(zonedir, O_RDONLY | O_DIRECTORY);
+	if (!ASSERT_GE(dirfd, 0, "open_zoned"))
+		goto out;
+
+	strncpy(label.v, "restricted", sizeof(label.v) - 1);
+	label.len = strlen("restricted") + 1;
+
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.inode_zone), &dirfd,
+				  &label, BPF_ANY);
+	if (!ASSERT_OK(err, "seed_parent_zone"))
+		goto out;
+
+	fd = open(file, O_CREAT | O_RDWR, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		goto out;
+
+	if (!ASSERT_TRUE(skel->bss->hook_ran, "hook_ran"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->inherited, 1, "inherited");
+	ASSERT_OK(skel->data->zone_err, "zone_err");
+	assert_label(file, "security.bpf.zone", "restricted");
+	assert_label(file, "security.bpf.origin", "created");
+out:
+	if (fd >= 0)
+		close(fd);
+	if (dirfd >= 0)
+		close(dirfd);
+	remove(file);
+	lsm_inode_init_xattr__destroy(skel);
+out_dir:
+	rmdir(zonedir);
+}
+
+static void test_refused_claims(void)
+{
+	const char *file = TESTDIR "/refused";
+	struct lsm_inode_init_xattr *skel;
+	char buf[64];
+	int fd = -1;
+
+	skel = policy_attach();
+	if (!skel)
+		return;
+
+	fd = open(file, O_CREAT | O_RDWR, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		goto out;
+
+	if (!ASSERT_TRUE(skel->bss->hook_ran, "hook_ran"))
+		goto out;
+
+	ASSERT_EQ(skel->data->overflow_err, -ENOSPC, "overflow_err");
+	ASSERT_EQ(read_label(file, "security.bpf.overflow", buf, sizeof(buf)),
+		  -ENODATA, "overflow_absent");
+
+	ASSERT_EQ(skel->data->toolong_err, -EINVAL, "toolong_err");
+
+	ASSERT_EQ(skel->data->selinux_err, -EPERM, "selinux_err");
+	ASSERT_EQ(skel->data->user_err, -EPERM, "user_err");
+
+	if (!lsm_is_active("selinux"))
+		ASSERT_EQ(read_label(file, "security.selinux", buf, sizeof(buf)),
+			  -ENODATA, "selinux_absent");
+	ASSERT_EQ(read_label(file, "user.zone", buf, sizeof(buf)),
+		  -ENODATA, "user_absent");
+out:
+	if (fd >= 0)
+		close(fd);
+	remove(file);
+	lsm_inode_init_xattr__destroy(skel);
+}
+
+static void test_null_xattrs(void)
+{
+	const char *file = RAMFSDIR "/file";
+	struct lsm_inode_init_xattr *skel;
+	int fd = -1;
+
+	skel = policy_attach();
+	if (!skel)
+		return;
+
+	fd = open(file, O_CREAT | O_RDWR, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		goto out;
+
+	if (!ASSERT_TRUE(skel->bss->hook_ran, "hook_ran"))
+		goto out;
+	ASSERT_EQ(skel->data->zone_err, -EOPNOTSUPP, "zone_err");
+out:
+	if (fd >= 0)
+		close(fd);
+	remove(file);
+	lsm_inode_init_xattr__destroy(skel);
+}
+
+static void test_shared_budget(void)
+{
+	struct lsm_inode_init_xattr_budget *skel[INIT_XATTRS_MAX + 1] = {};
+	struct bpf_link *link[INIT_XATTRS_MAX + 1] = {};
+	const char *file = TESTDIR "/budget";
+	int claimed = 0, refused = 0;
+	int i, fd = -1;
+
+	for (i = 0; i <= INIT_XATTRS_MAX; i++) {
+		skel[i] = lsm_inode_init_xattr_budget__open();
+		if (!ASSERT_OK_PTR(skel[i], "skel_open"))
+			goto out;
+
+		snprintf(skel[i]->rodata->xattr_name,
+			 sizeof(skel[i]->rodata->xattr_name),
+			 "security.bpf.slot%d", i);
+
+		if (!ASSERT_OK(lsm_inode_init_xattr_budget__load(skel[i]),
+			       "skel_load"))
+			goto out;
+
+		skel[i]->bss->monitored_pid = getpid();
+
+		link[i] = bpf_program__attach_lsm(skel[i]->progs.claim_one);
+		if (!ASSERT_OK_PTR(link[i], "attach"))
+			goto out;
+	}
+
+	fd = open(file, O_CREAT | O_RDWR, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		goto out;
+
+	for (i = 0; i <= INIT_XATTRS_MAX; i++) {
+		int err = skel[i]->data->claim_err;
+
+		ASSERT_TRUE(skel[i]->bss->hook_ran, "hook_ran");
+		if (!err)
+			claimed++;
+		else if (ASSERT_EQ(err, -ENOSPC, "claim_err"))
+			refused++;
+	}
+
+	ASSERT_EQ(claimed, INIT_XATTRS_MAX, "claimed");
+	ASSERT_EQ(refused, 1, "refused");
+out:
+	if (fd >= 0)
+		close(fd);
+	remove(file);
+	for (i = 0; i <= INIT_XATTRS_MAX; i++) {
+		bpf_link__destroy(link[i]);
+		lsm_inode_init_xattr_budget__destroy(skel[i]);
+	}
+}
+
+static int claim_value(const char *file, __u32 len, __u64 flags,
+		       int hook_retval, int *open_errno)
+{
+	struct lsm_inode_init_xattr_value *skel;
+	struct bpf_link *link = NULL;
+	int err = 1, fd;
+
+	skel = lsm_inode_init_xattr_value__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return 1;
+
+	skel->rodata->value_len = len;
+	skel->rodata->dynptr_flags = flags;
+	skel->rodata->hook_retval = hook_retval;
+
+	if (!ASSERT_OK(lsm_inode_init_xattr_value__load(skel), "skel_load"))
+		goto out;
+
+	skel->bss->monitored_pid = getpid();
+
+	link = bpf_program__attach_lsm(skel->progs.claim_value);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		goto out;
+
+	fd = open(file, O_CREAT | O_RDWR | O_EXCL, 0644);
+	*open_errno = fd < 0 ? errno : 0;
+	if (fd >= 0)
+		close(fd);
+
+	if (ASSERT_TRUE(skel->bss->hook_ran, "hook_ran"))
+		err = skel->data->claim_err;
+out:
+	bpf_link__destroy(link);
+	lsm_inode_init_xattr_value__destroy(skel);
+	return err;
+}
+
+static void test_value_shapes(void)
+{
+	const char *file = TESTDIR "/value";
+	char buf[64];
+	int err, open_errno;
+
+	remove(file);
+
+	err = claim_value(file, 0, 0, 0, &open_errno);
+	ASSERT_OK(err, "empty_value_err");
+	ASSERT_OK(open_errno, "empty_value_open");
+	ASSERT_EQ(read_label(file, "security.bpf.value", buf, sizeof(buf)),
+		  0, "empty_value_len");
+	remove(file);
+
+	err = claim_value(file, sizeof(buf), 1, 0, &open_errno);
+	ASSERT_EQ(err, -EINVAL, "bad_dynptr_err");
+	ASSERT_EQ(read_label(file, "security.bpf.value", buf, sizeof(buf)),
+		  -ENODATA, "bad_dynptr_absent");
+	remove(file);
+
+	err = claim_value(file, VALUE_SIZE_MAX + 1, 0, 0, &open_errno);
+	ASSERT_EQ(err, -E2BIG, "oversized_err");
+	ASSERT_EQ(read_label(file, "security.bpf.value", buf, sizeof(buf)),
+		  -ENODATA, "oversized_absent");
+	remove(file);
+
+	err = claim_value(file, 8, 0, -EPERM, &open_errno);
+	ASSERT_OK(err, "denied_claim_err");
+	ASSERT_EQ(open_errno, EPERM, "denied_open");
+	ASSERT_EQ(read_label(file, "security.bpf.value", buf, sizeof(buf)),
+		  -ENOENT, "denied_absent");
+	remove(file);
+}
+
+void test_lsm_inode_init_xattr(void)
+{
+	if (!ASSERT_OK(testdir_setup(), "testdir_setup"))
+		goto out;
+
+	if (test__start_subtest("init_labels"))
+		test_init_labels();
+	if (test__start_subtest("inherit_from_parent"))
+		test_inherit_from_parent();
+	if (test__start_subtest("refused_claims"))
+		test_refused_claims();
+	if (test__start_subtest("null_xattrs"))
+		test_null_xattrs();
+	if (test__start_subtest("shared_budget"))
+		test_shared_budget();
+	if (test__start_subtest("value_shapes"))
+		test_value_shapes();
+out:
+	testdir_cleanup();
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_inode_init_xattr.c b/tools/testing/selftests/bpf/progs/lsm_inode_init_xattr.c
new file mode 100644
index 000000000000..77b37cf6165a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_inode_init_xattr.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define LABEL_MAX	32
+
+struct label {
+	char	v[LABEL_MAX];
+	__u32	len;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_INODE_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct label);
+} inode_zone SEC(".maps");
+
+__u32 monitored_pid;
+
+const char xattr_zone[]     = "security.bpf.zone";
+const char xattr_origin[]   = "security.bpf.origin";
+const char xattr_overflow[] = "security.bpf.overflow";
+/* One byte over XATTR_NAME_MAX once "security." is prepended again. */
+const char xattr_toolong[] = "security.bpf." "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
+const char xattr_selinux[]  = "security.selinux";
+const char xattr_user[]     = "user.zone";
+
+char zone_scratch[LABEL_MAX];
+char origin_value[] = "created";
+
+__u32 hook_ran;
+__s32 zone_err = 1;
+__s32 origin_err = 1;
+__s32 overflow_err = 1;
+__s32 toolong_err = 1;
+__s32 selinux_err = 1;
+__s32 user_err = 1;
+__u32 inherited;
+
+SEC("lsm/inode_init_security")
+int BPF_PROG(init_label, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	struct bpf_dynptr value;
+	struct label *parent;
+	int len = 0;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
+		return 0;
+
+	hook_ran = 1;
+	if (!xattrs) {
+		/* The filesystem takes no xattrs at inode creation. */
+		zone_err = -EOPNOTSUPP;
+		return 0;
+	}
+	__builtin_memset(zone_scratch, 0, LABEL_MAX);
+
+	if (dir) {
+		parent = bpf_inode_storage_get(&inode_zone, dir, 0, 0);
+		if (parent && parent->len > 0 && parent->len <= LABEL_MAX) {
+			len = parent->len;
+			__builtin_memcpy(zone_scratch, parent->v, LABEL_MAX);
+			inherited = 1;
+		}
+	}
+	if (!len) {
+		__builtin_memcpy(zone_scratch, "default", sizeof("default"));
+		len = sizeof("default");
+	}
+
+	bpf_dynptr_from_mem(zone_scratch, len, 0, &value);
+	/* Refused before a slot is claimed, so the budget below is intact. */
+	toolong_err = bpf_inode_init_xattr(xattrs, xattr_count, xattr_toolong,
+					   &value);
+	zone_err = bpf_inode_init_xattr(xattrs, xattr_count, xattr_zone,
+					&value);
+
+	bpf_dynptr_from_mem(origin_value, sizeof(origin_value), 0, &value);
+	origin_err = bpf_inode_init_xattr(xattrs, xattr_count, xattr_origin,
+					  &value);
+
+	overflow_err = bpf_inode_init_xattr(xattrs, xattr_count,
+					    xattr_overflow, &value);
+
+	selinux_err = bpf_inode_init_xattr(xattrs, xattr_count, xattr_selinux,
+					   &value);
+	user_err = bpf_inode_init_xattr(xattrs, xattr_count, xattr_user,
+					&value);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_inode_init_xattr_budget.c b/tools/testing/selftests/bpf/progs/lsm_inode_init_xattr_budget.c
new file mode 100644
index 000000000000..08dd93a1db11
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_inode_init_xattr_budget.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+const char xattr_name[32] = "security.bpf.slot";
+
+__u32 monitored_pid;
+__u32 hook_ran;
+__s32 claim_err = 1;
+
+char claim_value[] = "v";
+
+SEC("lsm/inode_init_security")
+int BPF_PROG(claim_one, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	struct bpf_dynptr value;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
+		return 0;
+
+	hook_ran = 1;
+	if (!xattrs) {
+		claim_err = -EOPNOTSUPP;
+		return 0;
+	}
+	bpf_dynptr_from_mem(claim_value, sizeof(claim_value), 0, &value);
+	claim_err = bpf_inode_init_xattr(xattrs, xattr_count, xattr_name,
+					 &value);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_inode_init_xattr_value.c b/tools/testing/selftests/bpf/progs/lsm_inode_init_xattr_value.c
new file mode 100644
index 000000000000..6a879a758601
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_inode_init_xattr_value.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define VALUE_MAX	(64 * 1024 + 1)
+
+const char xattr_value[] = "security.bpf.value";
+
+/* Shape of the value handed to the kfunc, and what the hook returns after. */
+const volatile __u32 value_len;
+const volatile __u64 dynptr_flags;
+const volatile __s32 hook_retval;
+
+char value_src[VALUE_MAX];
+
+__u32 monitored_pid;
+__u32 hook_ran;
+__s32 claim_err = 1;
+
+SEC("lsm/inode_init_security")
+int BPF_PROG(claim_value, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	struct bpf_dynptr value;
+	__u32 len = value_len;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
+		return 0;
+	if (len > VALUE_MAX)
+		return 0;
+
+	hook_ran = 1;
+	if (!xattrs) {
+		claim_err = -EOPNOTSUPP;
+		return 0;
+	}
+	bpf_dynptr_from_mem(value_src, len, dynptr_flags, &value);
+	claim_err = bpf_inode_init_xattr(xattrs, xattr_count, xattr_value,
+					 &value);
+	return hook_retval;
+}
-- 
2.43.0

