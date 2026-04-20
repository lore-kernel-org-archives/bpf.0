Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F2838239C
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776717265; cv=none; b=Y3rkxrbYLjot1TzzQtsVxT0eHc1Aj/fSz0l98N4GPHAUo4XfazYxUzPMRhNxWGE3DmItgLKaMrFLryzgj7LGGOSAjfktqQBtAP5BIWpGpUfKozs4wFsbyS8SmVqROjE2eNudxqi/z2d2SdSJrKY2c6dHxRyfGqBnOK+fCgmlvT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776717265; c=relaxed/simple;
	bh=4RWAPfLF+6wKdR2qPAgJbz31i7nqgIPv/FmYxooDPWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pD8jzZsJaHLVjVuM+fbJT6iqhNzMww0bpJRbX8+7lxRy1vL3kL9NE/bB9fPzmGHZ03tpWvIx/VCjdF+zuSW1Epnzczc/CHIc5Kb9I5TSJRNVo8HahmMz7wBTqpo+9RGwLM7VeavWlu9G5WXC0YJErcpdMsJpz3PJxtIRUkk1yso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyyaCFKi; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyyaCFKi"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79db5e18ac6so45816467b3.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 13:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776717263; x=1777322063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uHr6TK8mmV1SbeKlhyttIsPjwqsc16ZmXZ3x5LtUj4=;
        b=cyyaCFKi71M1LUABg6uOzl3f7jf8s4xa4bN3PbTcfmLyNJIAI4czvF6jiVj0PUTrVM
         jx43mNejQtYd5mh7DsrQxXxKzWMOca6We+e3/eNFewM6G2SSu434SOfC5ba7320uuJf7
         XnLhjsw0cKIEOAOaw1d3Q17muNKdJoKgH3MonZ7HzZ0mGSuM6CumyL1nWvU0eIV1V3di
         havRCdPrmXcZj2rmbvgXF7K/wghEVuH6IHNL4KAJeeqSP8xS1Oz+HEqyr/ve4uz3yw4B
         BoAUBO6OBaWQ6hMNSWGjKxtPUHix+YdeQrJtA9fRZcwhfF1AVc37fa1LTq6QQnRuhWwT
         RLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776717263; x=1777322063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1uHr6TK8mmV1SbeKlhyttIsPjwqsc16ZmXZ3x5LtUj4=;
        b=ImKJV1vn4N700ig6ia1uA2EOzr77Qd7xnLcfB9M3F5j9Bo8ikSPqbS2p7xbPL9JJKt
         cfm3DJqwqVLVHatZAlI+3GDvBhPTP5+/YiuhGJtqr9yhkMMwGNuMo5/Sfuj8wLoIzRzc
         790exs63G0X9ItDfZ6+trlCUB+leDpJK6rK/C8SCKi4Gdk+yHb3FD1dOiE02+5YsMYZq
         OAWaH9BC69iWLl+MyFoU7q4jpyEVmmSBnCZTBRoOwWdrX8na1qTN06YhwYy2+eHnc2oG
         hXSQK6nePVHDrAFzQ4X2TDh5e1CBfxOSrq99QMztwtvN7iwL4yYTZnhsh7Or3JP7jaWO
         8YEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/peF1PSYNVjmNPdP4BcTH/jrmBfjFX41dVcIt2OiOQH8Hk3f1MGpM1gLyKrW+6sQGi6mI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWk4Bs4UJ8tY66c7v9jCT0hi6AHtWQYVKoE8NSbciGBh6Kjemg
	/9wdGX1dP6s9D7YvQaegwcvWm2tzJxJwwzgROxqMWR2Rl4Zj/t9s9RyU
X-Gm-Gg: AeBDieteGdEvuSkuOZ356TzAU1eUpjAtp5zqbfM6AJrgLgVL5ppMp3y0x5Gerhz8Y4G
	Ze/YP5XaaBjMbopOqH5ymNLJZiYjDbZKcpEI9T9Gt7aIDaDEeS3SDmTLsTuyFE83Q2D3030XZii
	bwl4QNBJu2vooQNZYgiLzzpOqCU5+kxnzq7Op94fAuYP8M5GxSFRy1Cbhux2t8oX6M+tapIASy4
	7lPH2hNzY7vyIjZJKodblOIbSF0nzccde3AB0EGF4XXrDMsd5X66SaadlumJivRx2rYfAnvZk30
	mcXRFKAUWEmoK6t8X3jDOuFkxkn/oKYon87sf0OaGyZyEs7kULXV86bbVGpH5DpPqngcrw+IJhY
	tC1gRl7Iz3K2FJyTkjYtopxOiOCjWXaWxH/M2qFvvLey0z1HD5F+yHinXtgepX4uVismeDU+Ojh
	TlMHpEBsiCnKtk8cRLjun5KmjVL6q9NI4RqH8sQtjBKcKe06FniaW1fvUfEuG5eiYYkc6xUpCJP
	EGdTQqkQqw=
X-Received: by 2002:a05:690e:130b:b0:650:1aa5:856e with SMTP id 956f58d0204a3-65311beafccmr10330814d50.37.1776717262834;
        Mon, 20 Apr 2026 13:34:22 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:adde:1cbf:87f2:a99c])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314e81399sm5702955d50.14.2026.04.20.13.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 13:34:22 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	mic@digikod.net,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for map-stored struct file kptrs
Date: Mon, 20 Apr 2026 16:33:06 -0400
Message-ID: <20260420203306.3107246-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420203306.3107246-1-utilityemal77@gmail.com>
References: <20260420203306.3107246-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for map-stored struct file referenced kptrs.

Add a test storing a referenced kptr in a map. The referenced pointer is
acquired by get_task_exe_file in this case.

Add a test that verifies that the struct file reference remains valid
when the original file descriptor is closed, by checking the extented
attributes on it after completion. Trigger this validation manually by
hooking file_open and opening dev null.

Validation is done with xattrs.

Add a test verifying that attempting to insert unreferenced struct file
pointers into the map is rejected by the verifier.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 .../bpf/prog_tests/refcounted_kptr_file.c     | 246 ++++++++++++++++++
 .../bpf/progs/refcounted_kptr_file.c          | 152 +++++++++++
 .../bpf/progs/refcounted_kptr_file_fail.c     |  35 +++
 3 files changed, 433 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.c
 create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr_file.c
 create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr_file_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.c b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.c
new file mode 100644
index 000000000000..173121377040
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <test_progs.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <sys/xattr.h>
+#include <unistd.h>
+
+#include "refcounted_kptr_file_fail.skel.h"
+#include "refcounted_kptr_file.skel.h"
+
+static const char shell_path[] = "/bin/sh";
+static const char xattr_name[] = "user.kptr_ref";
+static const char xattr_value[] = "kptr-live";
+
+static void close_fd(int fd)
+{
+	if (fd >= 0)
+		close(fd);
+}
+
+static int write_full(int fd, const void *buf, size_t len)
+{
+	const char *pos = buf;
+
+	while (len) {
+		ssize_t written;
+
+		written = write(fd, pos, len);
+		if (written < 0) {
+			if (errno == EINTR)
+				continue;
+			return -errno;
+		}
+
+		pos += written;
+		len -= written;
+	}
+
+	return 0;
+}
+
+static int copy_file(const char *src_path, const char *dst_path, mode_t mode)
+{
+	char buf[4096];
+	int src_fd = -1, dst_fd = -1;
+	int err = 0;
+
+	src_fd = open(src_path, O_RDONLY | O_CLOEXEC);
+	if (src_fd < 0)
+		return -errno;
+
+	dst_fd = open(dst_path, O_WRONLY | O_CREAT | O_EXCL | O_CLOEXEC,
+		      mode & 0777);
+	if (dst_fd < 0) {
+		err = -errno;
+		goto out;
+	}
+
+	while (1) {
+		ssize_t bytes_read;
+
+		bytes_read = read(src_fd, buf, sizeof(buf));
+		if (bytes_read < 0) {
+			if (errno == EINTR)
+				continue;
+			err = -errno;
+			goto out;
+		}
+
+		if (!bytes_read)
+			break;
+
+		err = write_full(dst_fd, buf, bytes_read);
+		if (err) {
+			/* Remove partially written destination file so it
+			 * doesn't linger on disk.
+			 */
+			unlink(dst_path);
+			goto out;
+		}
+	}
+
+out:
+	close_fd(dst_fd);
+	close_fd(src_fd);
+	return err;
+}
+
+static bool prepare_tagged_shell(char *temp_dir, size_t temp_dir_sz,
+				 char *shell_copy, size_t shell_copy_sz)
+{
+	struct stat st;
+	int err;
+
+	if (!ASSERT_LT(snprintf(temp_dir, temp_dir_sz,
+				"./refcounted_kptr_file.XXXXXX"),
+		     (int)temp_dir_sz, "temp_dir_template"))
+		return false;
+
+	if (!ASSERT_OK_PTR(mkdtemp(temp_dir), "mkdtemp"))
+		return false;
+
+	if (!ASSERT_LT(snprintf(shell_copy, shell_copy_sz, "%s/sh", temp_dir),
+		       (int)shell_copy_sz, "shell_copy_path"))
+		goto err_rmdir;
+
+	if (!ASSERT_OK(stat(shell_path, &st), "stat_shell"))
+		goto err_rmdir;
+
+	err = copy_file(shell_path, shell_copy, st.st_mode);
+	if (!ASSERT_OK(err, "copy_shell"))
+		goto err_unlink;
+
+	err = setxattr(shell_copy, xattr_name, xattr_value, sizeof(xattr_value), 0);
+	if (err && errno == EOPNOTSUPP) {
+		printf("%s:SKIP:filesystem does not support user xattr (%d)\n",
+		       __func__, errno);
+		test__skip();
+		goto err_unlink;
+	}
+
+	if (!ASSERT_OK(err, "setxattr_shell"))
+		goto err_unlink;
+
+	return true;
+
+err_unlink:
+	unlink(shell_copy);
+err_rmdir:
+	rmdir(temp_dir);
+	return false;
+}
+
+static void run_refcounted_file_kptr_success(void)
+{
+	struct refcounted_kptr_file *skel;
+	char shell_copy[PATH_MAX] = {};
+	char temp_dir[PATH_MAX] = {};
+	int pipefd[2] = { -1, -1 };
+	int status;
+	pid_t child_pid;
+	int err, fd = -1;
+
+	skel = refcounted_kptr_file__open();
+	if (!ASSERT_OK_PTR(skel, "refcounted_kptr_file__open"))
+		return;
+
+	err = refcounted_kptr_file__load(skel);
+	if (!ASSERT_OK(err, "refcounted_kptr_file__load"))
+		goto out;
+
+	err = refcounted_kptr_file__attach(skel);
+	if (!ASSERT_OK(err, "refcounted_kptr_file__attach"))
+		goto out;
+
+	if (!prepare_tagged_shell(temp_dir, sizeof(temp_dir), shell_copy,
+				  sizeof(shell_copy)))
+		goto out;
+
+	if (!ASSERT_OK(pipe2(pipefd, O_CLOEXEC), "pipe2"))
+		goto out;
+
+	child_pid = fork();
+	if (!ASSERT_GT(child_pid, -1, "fork"))
+		goto out;
+
+	if (child_pid == 0) {
+		char sync;
+
+		close(pipefd[1]);
+		if (read(pipefd[0], &sync, 1) != 1)
+			_exit(127);
+		close(pipefd[0]);
+		execl(shell_copy, shell_copy, "-c", ": </dev/null", NULL);
+		_exit(127);
+	}
+
+	close(pipefd[0]);
+	pipefd[0] = -1;
+
+	/* Set the PID *before* unblocking the child so that the BPF program's
+	 * file_open hook can filter on it from the very first file opened during
+	 * exec.  If the write happened first, early file_open events during
+	 * exec could be missed.
+	 */
+	skel->bss->file_kptr_insert_pid = child_pid;
+	err = write_full(pipefd[1], "1", 1);
+	if (!ASSERT_OK(err, "start_child"))
+		goto out;
+	close(pipefd[1]);
+	pipefd[1] = -1;
+
+	if (!ASSERT_EQ(waitpid(child_pid, &status, 0), child_pid, "waitpid"))
+		goto out;
+	if (!ASSERT_TRUE(WIFEXITED(status), "child_exited"))
+		goto out;
+	if (!ASSERT_EQ(WEXITSTATUS(status), 0, "child_status"))
+		goto out;
+
+	skel->bss->file_kptr_verify_pid = getpid();
+	/* The child is gone at this point. Reopening an unrelated file triggers a
+	 * second file_open hook where the BPF program validates the stashed ref.
+	 * Our test op for the ref validity is reading the xattrs we set earlier.
+	 */
+	fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+	if (!ASSERT_GE(fd, 0, "open_dev_null"))
+		goto out;
+	close(fd);
+	fd = -1;
+
+	ASSERT_EQ(skel->bss->file_kptr_err, 0, "file_kptr_err");
+	ASSERT_EQ(skel->bss->file_kptr_inserted, 1, "file_kptr_inserted");
+	ASSERT_EQ(skel->bss->file_kptr_verified, 1, "file_kptr_verified");
+	ASSERT_EQ(skel->bss->file_kptr_xattr_ret, sizeof(xattr_value),
+		  "file_kptr_xattr_ret");
+	ASSERT_EQ(strcmp(skel->bss->file_kptr_value, xattr_value), 0,
+		  "file_kptr_value");
+
+out:
+	close_fd(fd);
+	close_fd(pipefd[0]);
+	close_fd(pipefd[1]);
+	if (shell_copy[0])
+		unlink(shell_copy);
+	if (temp_dir[0])
+		rmdir(temp_dir);
+	refcounted_kptr_file__destroy(skel);
+}
+
+void test_refcounted_kptr_file(void)
+{
+	if (test__start_subtest("holds_ref_after_close"))
+		run_refcounted_file_kptr_success();
+
+	if (test__start_subtest("reject_unref_ctx_file"))
+		RUN_TESTS(refcounted_kptr_file_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_file.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_file.c
new file mode 100644
index 000000000000..104fc85b2afa
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_file.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+#include "bpf_experimental.h"
+
+struct file_map_value {
+	struct file __kptr * file;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct file_map_value);
+	__uint(max_entries, 1);
+} stashed_files SEC(".maps");
+
+static const char xattr_name[] = "user.kptr_ref";
+static const char expected_value[] = "kptr-live";
+
+char file_kptr_probe_value[32];
+int file_kptr_insert_pid;
+int file_kptr_verify_pid;
+int file_kptr_inserted;
+int file_kptr_verified;
+int file_kptr_err;
+int file_kptr_xattr_ret;
+char file_kptr_value[32];
+
+SEC("lsm.s/file_open")
+int insert_file_kptr(struct file *ctx_file)
+{
+	struct bpf_dynptr value_ptr;
+	struct file_map_value *mapval;
+	struct task_struct *task;
+	struct file *file, *old;
+	int ret;
+	int zero = 0;
+
+	(void)ctx_file;
+
+	if ((__u32)(bpf_get_current_pid_tgid() >> 32) != (__u32)file_kptr_insert_pid)
+		return 0;
+
+	if (file_kptr_inserted)
+		return 0;
+
+	mapval = bpf_map_lookup_elem(&stashed_files, &zero);
+	if (!mapval) {
+		file_kptr_err = 1;
+		return 0;
+	}
+
+	task = bpf_get_current_task_btf();
+	file = bpf_get_task_exe_file(task);
+	if (!file) {
+		file_kptr_err = 2;
+		return 0;
+	}
+
+	/* Exec can open multiple files while the new image is being installed.
+	 * Only stash the child's final executable, which we identify by the test
+	 * xattr.
+	 */
+	ret = bpf_dynptr_from_mem(file_kptr_probe_value,
+				  sizeof(file_kptr_probe_value), 0,
+				  &value_ptr);
+	if (ret) {
+		file_kptr_err = 8;
+		bpf_put_file(file);
+		return 0;
+	}
+
+	ret = bpf_get_file_xattr(file, xattr_name, &value_ptr);
+	if (ret != sizeof(expected_value) ||
+	    bpf_strncmp(file_kptr_probe_value, sizeof(expected_value),
+			expected_value)) {
+		bpf_put_file(file);
+		return 0;
+	}
+
+	old = bpf_kptr_xchg(&mapval->file, file);
+	if (old)
+		bpf_put_file(old);
+
+	file_kptr_inserted = 1;
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+int verify_file_kptr(struct file *ctx_file)
+{
+	struct bpf_dynptr value_ptr;
+	struct file_map_value *mapval;
+	struct file *file;
+	int zero = 0;
+	int ret;
+
+	(void)ctx_file;
+
+	if ((__u32)(bpf_get_current_pid_tgid() >> 32) != (__u32)file_kptr_verify_pid)
+		return 0;
+
+	if (!file_kptr_inserted || file_kptr_verified)
+		return 0;
+
+	mapval = bpf_map_lookup_elem(&stashed_files, &zero);
+	if (!mapval) {
+		file_kptr_err = 3;
+		return 0;
+	}
+
+	/* 
+	 * Pull the file out of the map to get a referenced pointer for the xattr
+	 * kfunc and to drop the map's last reference once verification completes.
+	 */
+	file = bpf_kptr_xchg(&mapval->file, NULL);
+	if (!file) {
+		file_kptr_err = 4;
+		return 0;
+	}
+
+	ret = bpf_dynptr_from_mem(file_kptr_value, sizeof(file_kptr_value), 0,
+				  &value_ptr);
+	if (ret) {
+		file_kptr_err = 5;
+		bpf_put_file(file);
+		return 0;
+	}
+
+	ret = bpf_get_file_xattr(file, xattr_name, &value_ptr);
+	file_kptr_xattr_ret = ret;
+	if (ret != sizeof(expected_value)) {
+		file_kptr_err = 6;
+		bpf_put_file(file);
+		return 0;
+	}
+
+	if (bpf_strncmp(file_kptr_value, sizeof(expected_value), expected_value)) {
+		file_kptr_err = 7;
+		bpf_put_file(file);
+		return 0;
+	}
+
+	file_kptr_verified = 1;
+	bpf_put_file(file);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_file_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_file_fail.c
new file mode 100644
index 000000000000..7adfa6645801
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_file_fail.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+struct file_map_value {
+	struct file __kptr * file;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct file_map_value);
+	__uint(max_entries, 1);
+} stashed_files SEC(".maps");
+
+SEC("lsm.s/file_open")
+__failure __msg("R2 type=ctx expected=ptr_, trusted_ptr_, rcu_ptr_")
+int stash_unref_ctx_file(struct file *ctx_file)
+{
+	struct file_map_value *mapval;
+	int zero = 0;
+
+	mapval = bpf_map_lookup_elem(&stashed_files, &zero);
+	if (!mapval)
+		return 0;
+
+	/* ctx_file is just the hook argument, not an acquired file reference. */
+	bpf_kptr_xchg(&mapval->file, ctx_file);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

