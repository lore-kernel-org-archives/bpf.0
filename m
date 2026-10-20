Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493446;
	b=srb05g5o/y3Na7iHwtfSd+WHETVmgr2khe0XbkflRjrsWVgmaVD94zO0ocnOGxsqaHvw
	 YWAYutkAu/p7zvWym0MCqRquKwQoNLsj1D2CIhTbcZcTdby99vS45trOsKdsfMuOrlyCJ
	 RnG2dlmtk+0rmkUgvqu7AGagonudgecTDVQGgogMw7zqp4LudawzxuVKvZ2rRlqxw6bVI
	 B+FQo7Vx8mDMx5EPYwBOiM6nNul3eZq5pznbuLF0R82YxYBVBT4Sv36xxNFVPMFm0cK7Z
	 hlOddeqCZoMqw45SMHQiEygOUDEv3keE6XZ7/LHhuKHJBWjjxvKQF4Y6UaGJVpk0/fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ijPSVZtN0wV/FObkbQ5coj1GUsZLgW/HlOlDTeZNmFI=;
	b=m/MDehEqoxK2nCbYvAjQ5px/K/WcxmB91yd9bYoY9QjbdyupChhysx4tMqA9jTRlDHO2
	 6rr//QjLDDj23yJ7jAmcL6uFH6voPzxjQHOlgZfvBsXjjgizRWc8CVSF4Qj5+Xut4RZ+R
	 Nl2rJUAGG+KW6RlSALM4RGVb5Y+r0c2K+JxczIq0ZIHYAZUHg81t5+SoWi1t0Fgivq2Q5
	 jzVUJM5Jqfct7LvUdVpyiClTkIGaL/MhJ5HHhv6z4X9ZIVvRBxECEOoW8yO2n30iIQRan
	 BW9HHAvyU7aM8yLRN3sxuxhZxemaPsjwVCBhGVl2pgL24DhbXXmZSuVDOrj8rlUSmlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bobrowski.net;
	spf=pass smtp.mailfrom=bobrowski.net;
	dkim=pass header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=CpFjF7HH;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC89606A324
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 10:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEC89606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=CpFjF7HH
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd633ef819bso1170899a12.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1792493445; x=1793098245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ijPSVZtN0wV/FObkbQ5coj1GUsZLgW/HlOlDTeZNmFI=;
        b=CpFjF7HHjiBPEyxhDRihQ3nc60Cyw7biDO8DewrQJDjFdKjSR2q77jdcI1CmwnPdMZ
         o4ylYaenRJ0i0c2ZUC37IwuqhT1jiKsZg0pxehLaIZdv3mEKzVRbkM3sLlY5gimJvxgz
         hFrpy4bSAjXp2Ej4If0TH7VypNFaIOAUlKAk8IXr3sQMpNZ0OMq6UTYk+GK3l4acuY2r
         D6wCZ7JWOXgS45XELV+UcEMeFsCo296qi5jaHfg8fWnqpwj6x0SZb8deUrJ10uat0gm7
         8ehHCsjjtnf22GSXcc5xYv6kU7rudfhKMJlroNQb861zFTQbpmk0cC293LYzjq9zUOnd
         wSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493445; x=1793098245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ijPSVZtN0wV/FObkbQ5coj1GUsZLgW/HlOlDTeZNmFI=;
        b=giyj6KqO9cbWflekS5aewFGfrwfvKATZPRag0m/xPlaBA7ktamDm4ps64gSvEO79i/
         2P0pMP2Rv6/d3aNG4TO+tcgv1C+GLWXQEeQlAjR7uL2qkwy2Lx+I6upjt+nK0dwJ9Z+B
         TsJ/1Ok0vUhtpYJz4eHbQrN7NQn2EnxyYrXQcEatcDljFprnU/HJarQvf+X1iDHj9hp7
         Q2OnZB+910uyv9knxLBbvhMxlS8mPlRTKmEmL1sz/Sgty1fiuvkc23D5/3nkVfWdZSTB
         4LXKOtOQLO5Ges5O5k69JAApD76OAme5KW4HWRKjS9vLh35wJkzSDF1PEqfpjmwm6VlW
         LYeA==
X-Gm-Message-State: AFq9FYKJzPqhsrJCCQo/ePbjU/3fUUmlTN0V/5t2yTLcdfmlAznwLlq2
	X2ZbtMCTwlD45F+9UVbkqcXT5eZCvFuRlaxh2gs5oWQa6P+b+X66J8m0ozczJu6PKq1XUPH+BDp
	nKQW/JQ==
X-Gm-Gg: AYBFou2M0b7dLg2p3ERgi+hcTSc6fVbZ2yI73cK1K8O9pBCcXlQ58j5zgpoOMcB3mPL
	Kzutb8OiuA1ovyoa8wibr26SV8sJWdGCQ0U9YmVURvSh2TcoZnnU2lsvOdxjYC6KHtVGrNvg1t8
	iq94GQaShPbUc+micB2+Vf74GF6FzGtIseyLNjBNeqD1+wW1oY+JMiF0f8mlaJm9psPAAqKE98R
	PHYnxqDMjV/udmCeaNkp+eCZ13ip3x0gL2d4SnsgeWQDtm6CuTkuZSymg54VQGDEf9q5fOLaK5x
	i7eGFgfrEY8jpu9up+Fjk5OpHxuTcsa09jNK/NEpAHrY26XjtOR0s+tQfWmp9SK3KM7tiQTbnyw
	w0v6CePRgujxfXGEyhVcv5rPXV3dx/Ra/6nkwLZS1Rfiv2Pq3A1MR5zt6f036wvJM4G1ieAR8Kn
	jaBNWA8lsz69ezX480miNaDe1Rf5svGENDDVZMMdGdKXXKByh5+Mf4TIVLcHVutICfFjbFHt5k0
	1HijBz5skSqmvkVtPHZyf8TKwXkWf5F0yNuv82N4IVDQw==
X-Received: by 2002:a17:90b:5743:b0:3ac:9d14:feb2 with SMTP id 98e67ed59e1d1-3acef14fe3bmr8737797a91.35.1792493445059;
        Tue, 20 Oct 2026 03:50:45 -0700 (PDT)
Received: from workstation.. (163-53-146-70.ip4.superloop.au. [163.53.146.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60f36a5asm3487902a91.9.2026.10.20.03.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:50:44 -0700 (PDT)
From: Matt Bobrowski <matt@bobrowski.net>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Matt Bobrowski <matt@bobrowski.net>,
	stable@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: test bpf_path_d_path() on a file released at task exit
Date: Tue, 20 Oct 2026 21:50:14 +1100
Message-ID: <20261020105014.97985-3-matt@bobrowski.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020105014.97985-1-matt@bobrowski.net>
References: <20261020105014.97985-1-matt@bobrowski.net>
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

Add a fs_kfuncs subtest for the crash fixed by the previous commit. A
child opens a file and exits without closing it, so exit_files() drops
the last reference and the file is released from exit_task_work(),
after exit_fs() has cleared the task's fs. A file_release program calls
bpf_path_d_path() on that release, matched by the file's inode number,
and records what it returned.

Without the fix the subtest crashes the kernel in d_path(). With it,
bpf_path_d_path() returns -EINVAL.

Fixes: d08e2045ebf0 ("bpf: introduce new VFS based BPF kfuncs")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Bobrowski <matt@bobrowski.net>
---
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 51 +++++++++++++++++++
 .../selftests/bpf/progs/test_path_d_path.c    | 35 +++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_path_d_path.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
index 43a26ec69a8e..510cf11c8bd8 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -4,12 +4,15 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/xattr.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
 #include <linux/fsverity.h>
 #include <unistd.h>
 #include <test_progs.h>
 #include "test_get_xattr.skel.h"
 #include "test_set_remove_xattr.skel.h"
 #include "test_fsverity.skel.h"
+#include "test_path_d_path.skel.h"
 
 static const char testfile[] = "/tmp/test_progs_fs_kfuncs";
 
@@ -268,6 +271,51 @@ static void test_fsverity(void)
 	remove(testfile);
 }
 
+static void test_path_d_path_on_exit(void)
+{
+	struct test_path_d_path *skel = NULL;
+	struct stat st;
+	int fd, status;
+	pid_t pid;
+
+	fd = open(testfile, O_CREAT | O_RDONLY, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		return;
+	close(fd);
+
+	if (!ASSERT_OK(stat(testfile, &st), "stat"))
+		goto out;
+
+	skel = test_path_d_path__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_path_d_path__open_and_load"))
+		goto out;
+
+	skel->bss->monitored_ino = st.st_ino;
+
+	if (!ASSERT_OK(test_path_d_path__attach(skel), "test_path_d_path__attach"))
+		goto out;
+
+	/*
+	 * The child exits with testfile still open, so exit_files() drops
+	 * the last reference and the file is released from exit_task_work(),
+	 * after exit_fs().
+	 */
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		goto out;
+	if (pid == 0)
+		_exit(open(testfile, O_RDONLY) < 0);
+
+	if (!ASSERT_EQ(waitpid(pid, &status, 0), pid, "waitpid"))
+		goto out;
+	ASSERT_TRUE(WIFEXITED(status) && !WEXITSTATUS(status), "child_open");
+	ASSERT_EQ(skel->bss->called, 1, "called");
+	ASSERT_EQ(skel->bss->ret, -EINVAL, "bpf_path_d_path");
+out:
+	test_path_d_path__destroy(skel);
+	remove(testfile);
+}
+
 void test_fs_kfuncs(void)
 {
 	/* Matches xattr_names in progs/test_get_xattr.c */
@@ -288,4 +336,7 @@ void test_fs_kfuncs(void)
 
 	if (test__start_subtest("fsverity"))
 		test_fsverity();
+
+	if (test__start_subtest("path_d_path_on_exit"))
+		test_path_d_path_on_exit();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_path_d_path.c b/tools/testing/selftests/bpf/progs/test_path_d_path.c
new file mode 100644
index 000000000000..4ea50a067819
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_path_d_path.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+#define PF_EXITING 0x00000004
+
+char _license[] SEC("license") = "GPL";
+
+__u64 monitored_ino;
+int called;
+int ret;
+
+/*
+ * A task that exits with a file still open releases it from
+ * exit_task_work(), after exit_fs() has already cleared its fs.
+ */
+SEC("lsm/file_release")
+int BPF_PROG(path_d_path_on_exit, struct file *file)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	char buf[64];
+
+	if (file->f_inode->i_ino != monitored_ino ||
+	    !(task->flags & PF_EXITING))
+		return 0;
+
+	ret = bpf_path_d_path(&file->f_path, buf, sizeof(buf));
+	called = 1;
+	return 0;
+}
-- 
2.47.3

