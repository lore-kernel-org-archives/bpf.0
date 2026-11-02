Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616463;
	b=zME7m1I6kIqUQBKhMy6/UcPwMWjHvpHnCYAWi7EXD3r7flvvlECakI9pt+T0sGqFPNZv
	 r+dt+1hDLYMqgVWzBV1DdwSjbtFIXOmgZ3f2+7TpaLeJFZJoynIxjoO0i4v6a/VLAXFJr
	 b9jL4rXip1RHAZre2Ur2gMB/9AZk9cxOxkvaucHh6QUqdAbag1tndKd7CKXuhUqDZOaO9
	 TegSoz5qlLFZLiVzPCIDs64hnyT/fYddQhJ7IxkP92YYmrEFQQrJYcXqeMPF0CYkbSOi4
	 cK+I7466boks/N/q/j1zznzx6tAH36v5fAKVSnOTk33B0j3WitS7SpdRpW+5SE5BMXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2QVBZZ/JFvc6ExerAFVZp6Xujims56fhL0wTgciA7Uo=;
	b=yVXPtunr3YYliISalNkcZ2dcX6o50MA5f6nPhmrwvUukliW7SW+unjHgbRcv4++q7UrG
	 1nIlRbA+Iu+7uGEvSZ5dJJ/twmip63LFyRoWtWA0vD67Kvprq8j5BWsL0YkgUDypV4o/v
	 9O+XhaimSjmNJlP/3fhJ3/ebOpOXvLcqqLSeBI7zE1Vhm4MemfFqslWF/PT3JlrzUmEKp
	 7v3gD+Y3vVNRlWmJBQhXNME9OL3IKO9RsfUBl+kn8A0P8mlG+m2GZMtY/jXc5uDuT9vCd
	 YSjOFuMFwO5MaH4fQYQPcX2rFYZnm1u9fAc5m0mhnc1HIJmJambyixCJFw7P+vMUZqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nkUbDXNW;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EDA606A334
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 10:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09EDA606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nkUbDXNW
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so26353205e9.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 02:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793616461; x=1794221261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2QVBZZ/JFvc6ExerAFVZp6Xujims56fhL0wTgciA7Uo=;
        b=nkUbDXNWGxlGmrQ1g0JcLY/zR9VSVMDSDooH4gNQSGig1tLcFm4GYRLq2BGWwZjeRI
         OdxcQKotTKH/XU2sic6unSKu6siqHqmFNGjzP+LtkbDjQOGCmj7IlQR8DPjn046QjeE/
         PnaV/zU8dL+x0ANWxCr8VzlaozDZQWftcIrCc3N3XR6LE/YUGiQTSFQ859fVNcW6qMrl
         kYzujvQBPhf5YFHjM/4b3sm6zWmASn9jDd+Wce0qM0c/XhoqZjt4eAszoen34TOUN17R
         Q8BKroF61KJqx/2GRltA77MGcVW+PVNVdlkSU7aszXjagBvz542Df5UcBqcGO/+gjYsy
         IVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793616461; x=1794221261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2QVBZZ/JFvc6ExerAFVZp6Xujims56fhL0wTgciA7Uo=;
        b=sK6JTRg9egpGqmyNg6hOmKa9F5/o4/sKprvXnSpCociTWRn60+Jx/2Ay/x7Ik41rf8
         QcPALZPAs1gg/k1x+xw2oTMK+GzFEZkyw9uKgtNlnqDVc+RXhyvysoQe5DMJXej7cslX
         zT1p09LfWkx5cAm2Vp1LrQUCyGk4smtQKd6ZcNHP5aJskOd73JoOu+N5GgxQCE6VRHIj
         3FFfLp5mP5inWf2DVT3zXSwmc0SIjyCihPfCizV5B8JI+1HTbaBPfJtPNj4ANjGrDAKF
         O/q6ya0ldlwo/Fxo9fvk1UbSGLvd8kX3QJ/fkkXvj4WNKKSVGhJcslON92MF1axdL+qF
         Lpfg==
X-Gm-Message-State: AFq9FYJKdt5Im0IfIHrvNqGUhsJMLdEwKZsDxcMDka2Ftq2eLVLqJRjf
	uIgbwYWwQfHdqEkivPHKfDu83Tuj8EADuQq8GWLaR+CwF79OVgCDmSSa
X-Gm-Gg: AYBFou1yWYIGr9aPc3oheDThyV5jB6Joa5/m96L9vrUehnjqo9D1jcqJZJwaFc/R5oE
	wLJ0YkCbowqnUubP3GpNIG92EwUbCMQjs6AlA7MWsomth6H+4hahM3D9yhIIgXA2wH3e8lOI3Rm
	jfHYM7/UMhhYQpGfcIyGSOPQh9iV+04Y+3SdOngoR7E59DpGoKs0fuX/YUYFF6HddG+AiQ1qKcq
	K15TDaGHxAoY3xrWLo9g5R54hchUEkDkUT9ZZj4PDrHzFwXdot3gSlWILpU/+RDgT7/AuOuIK6H
	k9a4VEve9bQrz5WFP7Tlnkl7xF65N9TFN58Wr+lgi/I23HSWZO8hoJGxG+/UJN0VFnC7OCtXT+C
	o2/eqjEikcWkXp2sxCghROk4zR4s6GFRWCv42IloI+j6htFdsGIny7fbuTIreRaIVUHsWkNG9Jw
	eYzwx8E5QQEhjNgHc5XF5H/mpC+bdfGv1SqhvurgUTymf1ymWukBAAW0MX6wmRMoOHSOWJfAggs
	1yxmJv9wLmodMCk6F5MuO1G1fQWFdkgFAU+4xknPZllcPtrQ81GTLuTvkk4EcibgNsd09ML6TAI
	Tzfw+XgscfIT5eEP/k4/aGuLvb92fdC3/4KjuYCzyCKBX40A9Bo/nSXOyLImiKzW
X-Received: by 2002:a05:600c:6095:b0:4a0:1b21:2628 with SMTP id 5b1f17b1804b1-4ac18b7e1c1mr199730515e9.23.1793616461259;
        Mon, 02 Nov 2026 02:47:41 -0800 (PST)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c7852esm248939695e9.11.2026.11.02.02.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:47:40 -0800 (PST)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: brauner@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	tasos.papagiannnis@gmail.com
Subject: [PATCH vfs-7.5.bpf v2 3/3] selftests/bpf: Test bpf_path_getattr()
Date: Mon,  2 Nov 2026 12:46:55 +0200
Message-ID: <20261102104655.70901-4-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
References: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compare basic fields with statx() on tmpfs and overlayfs, including
copy-up and device encoding. Cover verifier restrictions.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 .../selftests/bpf/prog_tests/path_getattr.c   | 162 ++++++++++++++++++
 .../selftests/bpf/progs/path_getattr.c        |  42 +++++
 .../bpf/progs/verifier_path_getattr.c         |  57 ++++++
 3 files changed, 261 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_getattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_getattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_path_getattr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/path_getattr.c b/tools/testing/selftests/bpf/prog_tests/path_getattr.c
new file mode 100644
index 000000000000..6d8cabfd24c6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/path_getattr.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <linux/stat.h>
+#include <sched.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <test_progs.h>
+
+#include "path_getattr.skel.h"
+#include "verifier_path_getattr.skel.h"
+
+static void query_stat(struct path_getattr *skel, const char *path)
+{
+	struct statx stx;
+	int err;
+
+	skel->bss->request_mask = STATX_BASIC_STATS;
+	skel->bss->calls = 0;
+	skel->bss->monitored_tid = syscall(SYS_gettid);
+	err = statx(AT_FDCWD, path, 0, skel->bss->request_mask, &stx);
+	skel->bss->monitored_tid = 0;
+	if (!ASSERT_OK(err, "statx") ||
+	    !ASSERT_EQ(skel->bss->calls, 1, "hook_calls") ||
+	    !ASSERT_OK(skel->bss->getattr_ret, "bpf_path_getattr"))
+		return;
+	ASSERT_EQ(skel->bss->ino, stx.stx_ino, "ino");
+	/* Kernel dev_t stores the minor number in the low 20 bits. */
+	ASSERT_EQ(skel->bss->dev, (stx.stx_dev_major << 20) | stx.stx_dev_minor, "dev");
+	ASSERT_EQ(skel->bss->size, stx.stx_size, "size");
+	ASSERT_EQ(skel->bss->mode, stx.stx_mode, "mode");
+	ASSERT_EQ(skel->bss->uid, stx.stx_uid, "uid");
+	ASSERT_EQ(skel->bss->gid, stx.stx_gid, "gid");
+	ASSERT_EQ(skel->bss->result_mask & STATX_BASIC_STATS,
+		  stx.stx_mask & STATX_BASIC_STATS, "result_mask");
+}
+
+static int create_file(const char *path)
+{
+	int fd, err;
+
+	fd = open(path, O_CREAT | O_EXCL | O_RDWR | O_CLOEXEC, 0640);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		return -1;
+	err = ftruncate(fd, 12345);
+	if (ASSERT_OK(err, "truncate_file"))
+		err = fchown(fd, 123, 456);
+	ASSERT_OK(err, "chown_file");
+	close(fd);
+	return err;
+}
+
+static void test_overlay(struct path_getattr *skel, const char *root)
+{
+	char lower[PATH_MAX], upper[PATH_MAX], work[PATH_MAX], merged[PATH_MAX];
+	char lower_file[PATH_MAX], merged_file[PATH_MAX], opts[PATH_MAX * 3 + 64];
+	__u32 overlay_dev;
+	int fd;
+
+	snprintf(lower, sizeof(lower), "%s/lower", root);
+	snprintf(upper, sizeof(upper), "%s/upper", root);
+	snprintf(work, sizeof(work), "%s/work", root);
+	snprintf(merged, sizeof(merged), "%s/merged", root);
+	if (!ASSERT_OK(mkdir(lower, 0755), "mkdir_lower") ||
+	    !ASSERT_OK(mkdir(upper, 0755), "mkdir_upper") ||
+	    !ASSERT_OK(mkdir(work, 0755), "mkdir_work") ||
+	    !ASSERT_OK(mkdir(merged, 0755), "mkdir_merged"))
+		return;
+	snprintf(lower_file, sizeof(lower_file), "%s/lower/file", root);
+	snprintf(merged_file, sizeof(merged_file), "%s/merged/file", root);
+	/*
+	 * Distinct layer filesystems with xino disabled expose a different
+	 * device for regular files than the overlay superblock's device.
+	 */
+	if (!ASSERT_OK(mount("tmpfs", lower, "tmpfs", 0, NULL), "mount_lower"))
+		return;
+	if (create_file(lower_file))
+		goto out_lower;
+	snprintf(opts, sizeof(opts), "lowerdir=%s,upperdir=%s,workdir=%s,xino=off",
+		 lower, upper, work);
+	if (mount("overlay", merged, "overlay", 0, opts)) {
+		if (errno == ENODEV || errno == EOPNOTSUPP) {
+			printf("%s:SKIP: overlayfs unavailable: %s\n",
+			       __func__, strerror(errno));
+			test__skip();
+			goto out_lower;
+		}
+		ASSERT_OK(-errno, "mount_overlay");
+		goto out_lower;
+	}
+	query_stat(skel, merged);
+	overlay_dev = skel->bss->dev;
+	query_stat(skel, merged_file);
+	ASSERT_NEQ(skel->bss->dev, overlay_dev, "lower_layer_dev");
+	/* Opening for write copies a lower-only file into the upper layer. */
+	fd = open(merged_file, O_WRONLY | O_CLOEXEC);
+	if (ASSERT_GE(fd, 0, "copy_up")) {
+		ASSERT_OK(ftruncate(fd, 23456), "truncate_upper");
+		close(fd);
+		query_stat(skel, merged_file);
+		ASSERT_NEQ(skel->bss->dev, overlay_dev, "upper_layer_dev");
+	}
+	umount(merged);
+out_lower:
+	umount(lower);
+}
+
+void test_path_getattr(void)
+{
+	char root[] = "/tmp/bpf_path_getattr.XXXXXX";
+	struct path_getattr *skel;
+	char file[PATH_MAX];
+	int nsfd, cwdfd;
+
+	skel = path_getattr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (!ASSERT_OK(path_getattr__attach(skel), "attach_skeleton"))
+		goto out_skel;
+	nsfd = open("/proc/self/ns/mnt", O_RDONLY | O_CLOEXEC);
+	if (!ASSERT_GE(nsfd, 0, "save_mountns"))
+		goto out_skel;
+	cwdfd = open(".", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	if (!ASSERT_GE(cwdfd, 0, "save_cwd"))
+		goto out_ns;
+	if (!ASSERT_OK(unshare(CLONE_NEWNS), "unshare_mountns"))
+		goto out_cwd;
+	if (!ASSERT_OK(mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL), "private_mounts") ||
+	    !ASSERT_OK_PTR(mkdtemp(root), "mkdtemp"))
+		goto out_restore;
+	if (!ASSERT_OK(mount("tmpfs", root, "tmpfs", 0, NULL), "mount_tmpfs"))
+		goto out_dir;
+	snprintf(file, sizeof(file), "%s/file", root);
+	if (create_file(file))
+		goto out_umount;
+	if (test__start_subtest("stat_parity")) {
+		query_stat(skel, file);
+		query_stat(skel, root);
+	}
+	if (test__start_subtest("overlay"))
+		test_overlay(skel, root);
+out_umount:
+	umount2(root, MNT_DETACH);
+out_dir:
+	rmdir(root);
+out_restore:
+	ASSERT_OK(setns(nsfd, CLONE_NEWNS), "restore_mountns");
+	/* setns() also resets the working directory. */
+	ASSERT_OK(fchdir(cwdfd), "restore_cwd");
+out_cwd:
+	close(cwdfd);
+out_ns:
+	close(nsfd);
+out_skel:
+	path_getattr__destroy(skel);
+}
+
+void test_verifier_path_getattr(void)
+{
+	RUN_TESTS(verifier_path_getattr);
+}
diff --git a/tools/testing/selftests/bpf/progs/path_getattr.c b/tools/testing/selftests/bpf/progs/path_getattr.c
new file mode 100644
index 000000000000..509cf13a0047
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/path_getattr.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u32 monitored_tid;
+__u32 request_mask;
+__u32 calls;
+int getattr_ret;
+
+__u64 ino;
+__u32 dev;
+__s64 size;
+__u32 mode;
+__u32 uid;
+__u32 gid;
+__u32 result_mask;
+
+SEC("lsm.s/inode_getattr")
+int BPF_PROG(path_getattr, const struct path *path, int ret)
+{
+	struct kstat stat = {};
+
+	if (ret || (__u32)bpf_get_current_pid_tgid() != monitored_tid || calls)
+		return ret;
+	calls++;
+	getattr_ret = bpf_path_getattr(path, request_mask, 0, &stat, sizeof(stat));
+	if (!getattr_ret) {
+		ino = stat.ino;
+		dev = stat.dev;
+		size = stat.size;
+		mode = stat.mode;
+		uid = stat.uid.val;
+		gid = stat.gid.val;
+		result_mask = stat.result_mask;
+	}
+	return ret;
+}
diff --git a/tools/testing/selftests/bpf/progs/verifier_path_getattr.c b/tools/testing/selftests/bpf/progs/verifier_path_getattr.c
new file mode 100644
index 000000000000..8792f4242727
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_path_getattr.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+static struct kstat output;
+
+SEC("lsm.s/file_open")
+__success
+int BPF_PROG(getattr_embedded_path_stack, struct file *file)
+{
+	struct kstat st;
+
+	bpf_path_getattr(&file->f_path, 0, 0, &st, sizeof(st));
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("dereference of modified untrusted_ptr_")
+int BPF_PROG(getattr_untrusted_path)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	bpf_path_getattr(&task->fs->pwd, 0, 0, &output, sizeof(output));
+	return 0;
+}
+
+SEC("lsm/inode_getattr")
+__failure __msg("program must be sleepable to call sleepable kfunc bpf_path_getattr")
+int BPF_PROG(getattr_non_sleepable, const struct path *path)
+{
+	bpf_path_getattr(path, 0, 0, &output, sizeof(output));
+	return 0;
+}
+
+SEC("fentry/vfs_getattr")
+__failure __msg("calling kernel function bpf_path_getattr is not allowed")
+int BPF_PROG(getattr_fentry, const struct path *path)
+{
+	bpf_path_getattr(path, 0, 0, &output, sizeof(output));
+	return 0;
+}
+
+SEC("lsm.s/inode_getattr")
+__failure __msg("invalid write to stack")
+int BPF_PROG(getattr_short_output, const struct path *path)
+{
+	__u64 small;
+
+	bpf_path_getattr(path, 0, 0, (void *)&small, sizeof(output));
+	return 0;
+}
-- 
2.56.0

