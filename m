Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B2346E6D
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058587; cv=none; b=sVH+d4TU2YT0ZVPI9TGQSXiG4TYKw4eDPYAaQJfF4z2LTaT6dRgPBgvUrhE5cocbBAJ4SQtHVw3I6Y5gFdQWIHtD8PWpXwYdG5PfHArCa0Oe/qaudEXKx774aDJvGDtnmYUl90LtW+/QU5PpoIOIlHQiHX9JgmD55MOvCrP1et8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058587; c=relaxed/simple;
	bh=LHR075UY486fpsXGUi350IEnZr7NzppqMA1s3cQVc2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocuIXAked7q1o408JMWirDqeAS+h/Pj4lJrMV4Ch/Jjo8jMI5kOwtYUeYL6ypjvRhcIuhxCig09hvBbVaqE8mgmLTM/R2q1P+kIcq+1HxizPzBYO43RIhaHiA9mzXg2MpjJb9xCwfYPyJlf/9IElNlFslv3NypDhrL58D/J5jdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYiOgeIS; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYiOgeIS"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-794719afcd4so89533847b3.1
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 12:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777058584; x=1777663384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXFgJCypw7ednp/A4tOiuWxyYBpLDqI4ZqepU5c/oeo=;
        b=SYiOgeIS6lj6uLnle/H3R7MlLPRM57LcRiBupfmI57QM1nwuGjlhp+1yDL1SRHQ8aV
         LqkTRykiht/lb5bhvYsNichgbYyradfB/QX/OxkgR/0D0L0JdOPVe9L6NQQch+TFYRTS
         cxkz53D4TbW6HgCTRpp5qO/yD9oe8HZNzyRM3IdqeV5fxVnWzrToXHyyjGs24d8gpNcZ
         PfYpek441DIvFlKKiu8un4+dU5MsbXYz/WGSH5wOZGBXPYHnl3RrvTAgYKZhsShbehpD
         XN8BaGqyaE6X2lDonWCGfRwUF/0ICYRuVFxs3jtgiTpNU47MudwVtfwjcRFtQvuFLH6o
         hZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777058584; x=1777663384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dXFgJCypw7ednp/A4tOiuWxyYBpLDqI4ZqepU5c/oeo=;
        b=d+puN8tVd4CIpznzc+NZkmnTF00qkJR+lbW4/JNM4dDQbK68tFrvXV0uotWZcDrF0p
         cLFR5/MUX3pQJ0W5Cn0ZdtEHsgwmuZLjNosqUYOoaQhAsYQNCuIn0SbYUDw9wBw9J7ru
         05b3Vzb22Ymr8P4V50z2e9A+KHt0cXtIB63eWJasSC7ldOHMwf6TMQgpsekjzl+QIMW0
         uqcJuiS1pZotsRevIXgLW/BjIxfSOZE+6Cgx++lJi5NNbryXl3R7TqahCUhBaUSLooaX
         LOZh5rLOfk87QBauigk5OqYaFv7DbpDVIwHuTU3j7K7yaeJRxLItFDkl8CynnJO7vPy8
         UBbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+IF5+Adbd0f5b5gndcbwccXXLqUm8s3ZW/Kr8oY48RK8Wwa4P8VbRXvle2I3LjpQQx+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7QQkwSi2CMc5jPT7Vp7r6dA49T+t6Zvvw7XNhSIwscIvWlx4W
	ljboOYeBVugpQDjiHyZ3sRHcoMk+8KgdOm42ZP3O0jbzqEOM7lrj4xtm
X-Gm-Gg: AeBDietsWitpG/Ga0gY3yNzAsatB+A3S8J41qVfCAXfpDJqTCy8sMrvZj6hD8aFML7+
	Hcl7cP0lo6jtzkknBsC1EtX3cQBI8LzE3Uq0HPXhkDtU1EfZ3CSXA6KB8UJPYADPCI9EAhz1wKJ
	uOManETtQvKCqdNypI6NGiES/PZiYG/mv5p7uhrIT/CiKAEaj/OCzSkfUEzYwbJnd4hkJA+C75j
	vp1n3JNUz+vaJZ8qkHVozbJSdIWVAVi9HuYKfm1ZPzMYxcIIG1qJrEWmuMdWTLxTwK53/36m5A5
	SH1hfsoRoJ8PRqIwfMruh3EhOJDXLH5a5VDghjmMFuqLUzyZ8AT1S7jOEFT7AyFFDWJwXO7wcWC
	5SMGGLbjTWlhApsRVNfc7+Ojo/99LvtpDT1a4pWVcuEwtn/S0ode2WUbHY94ogqVfoPeu/oWWom
	R/Qjd26p4FisjKjo9BCS2/AG8tQYTYjwdpmkzl1mykgdRW37hCwDdCVy8JF9DsoNUjV79hjnIMf
	bQkuExEoITJ26VBcvxf
X-Received: by 2002:a05:690c:498f:b0:79a:8f2f:cb3 with SMTP id 00721157ae682-7b9ecff6256mr344573907b3.44.1777058583934;
        Fri, 24 Apr 2026 12:23:03 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:cc96:e003:f6cc:4ed])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9b5254sm94726757b3.41.2026.04.24.12.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:23:03 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add test for map-stored struct file kptrs
Date: Fri, 24 Apr 2026 15:22:52 -0400
Message-ID: <20260424192252.695240-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424192252.695240-1-utilityemal77@gmail.com>
References: <20260424192252.695240-1-utilityemal77@gmail.com>
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
when the original file descriptor is closed, by checking the extended
attributes on it after completion. Trigger this validation manually by
hooking file_open and opening dev null.

Validation is done with xattrs.

Add a test verifying that attempting to insert unreferenced struct file
pointers into the map is rejected by the verifier.

Add fail tests for reference counting with the struct file objects.

Cc: Song Liu <song@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Changes in v3:
	- Properly close fd in test case.
	- Fix variable name in fail test case.
	- Remove dead function.

Changes in v2:
	- Add success verifier tests per Song Liu's suggestion.
	- Remove close_fd per Song Liu's suggestion.
	- Fix typos in commit per Sashiko.
	- Fix subtest ordering per Sashiko.
	- Fix comments per Sashiko.

 .../bpf/prog_tests/refcounted_kptr_file.c     | 247 ++++++++++++++++++
 .../bpf/progs/refcounted_kptr_file.c          | 158 +++++++++++
 .../bpf/progs/refcounted_kptr_file_fail.c     | 141 ++++++++++
 .../bpf/progs/refcounted_kptr_file_success.c  |  61 +++++
 4 files changed, 607 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.c
 create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr_file.c
 create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr_file_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr_file_success.c

diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.c b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.c
new file mode 100644
index 000000000000..7656f0428812
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.c
@@ -0,0 +1,247 @@
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
+#include "refcounted_kptr_file_success.skel.h"
+
+static const char shell_path[] = "/bin/sh";
+static const char xattr_name[] = "user.kptr_ref";
+static const char xattr_value[] = "kptr-live";
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
+			unlink(dst_path);
+			goto out;
+		}
+	}
+
+out:
+	if (src_fd >= 0 && close(src_fd) && !err)
+		err = -errno;
+	if (dst_fd >= 0 && close(dst_fd) && !err)
+		err = -errno;
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
+	pid_t child_pid = -1;
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
+	/*
+	 * Set the PID *before* unblocking the child so that the BPF program's
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
+	child_pid = -1;
+	if (!ASSERT_TRUE(WIFEXITED(status), "child_exited"))
+		goto out;
+	if (!ASSERT_EQ(WEXITSTATUS(status), 0, "child_status"))
+		goto out;
+
+	skel->bss->file_kptr_verify_pid = getpid();
+	/*
+	 * The child is gone at this point. Reopening an unrelated file triggers a
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
+	close(fd);
+	close(pipefd[0]);
+	close(pipefd[1]);
+	if (child_pid > 0)
+		(void)waitpid(child_pid, NULL, 0);
+	if (shell_copy[0])
+		unlink(shell_copy);
+	if (temp_dir[0])
+		rmdir(temp_dir);
+	refcounted_kptr_file__destroy(skel);
+}
+void test_refcounted_kptr_file(void)
+{
+	RUN_TESTS(refcounted_kptr_file_success);
+
+	RUN_TESTS(refcounted_kptr_file_fail);
+
+	if (test__start_subtest("holds_ref_after_close"))
+		run_refcounted_file_kptr_success();
+
+	RUN_TESTS(refcounted_kptr_file);
+}
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_file.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_file.c
new file mode 100644
index 000000000000..510ea1107791
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_file.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
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
+__description("file_kptr: insert referenced file")
+__success
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
+	/*
+	 * Exec can open multiple files while the new image is being installed.
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
+__description("file_kptr: verify referenced file")
+__success
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
index 000000000000..635d2493fd78
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_file_fail.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
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
+SEC("lsm.s/file_open")
+__failure
+__msg("Unreleased reference")
+int stash_xchg_file_kptr_unreleased(struct file *ctx_file)
+{
+	struct file_map_value *mapval;
+	struct file *file = NULL;
+	int zero = 0;
+
+	(void)ctx_file;
+
+	mapval = bpf_map_lookup_elem(&stashed_files, &zero);
+	if (!mapval)
+		return 0;
+
+	file = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!file)
+		return 0;
+
+	file = bpf_kptr_xchg(&mapval->file, file);
+	if (file)
+		bpf_put_file(file);
+
+	file = bpf_kptr_xchg(&mapval->file, NULL);
+	if (!file)
+		return 0;
+
+	/* Retrieved kptr is never released. */
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure
+__msg("Possibly NULL pointer passed to trusted R1")
+int stash_xchg_file_kptr_no_null_check(struct file *ctx_file)
+{
+	struct file_map_value *mapval;
+	struct file *file = NULL;
+	int zero = 0;
+
+	(void)ctx_file;
+
+	mapval = bpf_map_lookup_elem(&stashed_files, &zero);
+	if (!mapval)
+		return 0;
+
+	file = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!file)
+		return 0;
+
+	file = bpf_kptr_xchg(&mapval->file, file);
+	if (file)
+		bpf_put_file(file);
+
+	file = bpf_kptr_xchg(&mapval->file, NULL);
+	bpf_put_file(file);
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure
+__msg("R1 must be referenced or trusted")
+int put_map_owned_file(struct file *ctx_file)
+{
+	struct file_map_value *mapval;
+	struct file *file = NULL;
+	int zero = 0;
+
+	(void)ctx_file;
+
+	mapval = bpf_map_lookup_elem(&stashed_files, &zero);
+	if (!mapval)
+		return 0;
+
+	file = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!file)
+		return 0;
+
+	file = bpf_kptr_xchg(&mapval->file, file);
+	if (file)
+		bpf_put_file(file);
+
+	bpf_rcu_read_lock();
+	file = mapval->file;
+	if (!file) {
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+
+	/* Can't release a kptr while it is still owned by the map. */
+	bpf_put_file(file);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure
+__msg("release kernel function bpf_put_file expects")
+int BPF_PROG(put_unref_ctx_file, struct file *file)
+{
+	/* Can't release the unacquired LSM hook argument. */
+	bpf_put_file(file);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_file_success.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_file_success.c
new file mode 100644
index 000000000000..ece00c9e584f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_file_success.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
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
+SEC("lsm.s/file_open")
+__description("file_kptr: xchg and reinsert")
+__success
+int xchg_reinsert_file_kptr(struct file *ctx_file)
+{
+	struct file_map_value *mapval;
+	struct file *file, *old;
+	int zero = 0;
+
+	(void)ctx_file;
+
+	mapval = bpf_map_lookup_elem(&stashed_files, &zero);
+	if (!mapval)
+		return 0;
+
+	file = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!file)
+		return 0;
+
+	old = bpf_kptr_xchg(&mapval->file, file);
+	if (old)
+		bpf_put_file(old);
+
+	file = bpf_kptr_xchg(&mapval->file, NULL);
+	if (!file)
+		return 0;
+
+	old = bpf_kptr_xchg(&mapval->file, file);
+	if (old) {
+		bpf_put_file(old);
+		return 0;
+	}
+
+	file = bpf_kptr_xchg(&mapval->file, NULL);
+	if (file)
+		bpf_put_file(file);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

