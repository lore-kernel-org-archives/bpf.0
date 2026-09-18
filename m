Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB484B7A5C
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722699; cv=none; b=QaMX/c+MiTRyYFtLBXx73ngx4P87/oTYuPxdaEYdYKmUeC3W/wMssbTgay2UG/a1SNdV7q6iEVkQDomrogqTXE4nY12DplI8fx3S07onlbsOu/dFMPEnYfeRL/F/GSXFWmPnS/Jm0SCVMOMrYAlvqHAZ8XaVv/Bd5457orQ2rN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722699; c=relaxed/simple;
	bh=GnQNNaO2NdAe4bfr6j79tdcCpkRyZDIf9oDO6K4Un58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLCM2WkzSNoyPtoisDoiNprZFkTGEo+6ouT6Uiz6iIUN1ykYw71LQyFxFgDk4P2NDYPBzfJAHiJqzRB2lptVyl92Pzkg+KXHwUuCumE0n5GwbD6XvBLZT0v1IiD8SANU8Y22JeEOTxLZvyx1VJmQ32N94G9kRpo3HqWYy7cmLxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSMkcGyL; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSMkcGyL"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso2496825e9.0
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 02:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789722696; x=1790327496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fpIPJYBrAn9lh0X90aJ+LjetM4Yd20S6QCxk4a13+gY=;
        b=WSMkcGyLeThcjPB3yQKMfLgB5NXcufEm5GIyDXYbj1CFeGUzHHz3bgvzQNk0GylDjA
         PYo1FlOUkTdD5dG/ms9avQEdlevkcRbj6VTpBy2bEuV7u7rcPq5kbl0aT1DoTosBfW13
         2PamQ8/eN91LUJAKp5USHESSY4R7t1SbWVIvFkcNMmtJwN81fCZY9VBxqKKnp+CwnCj3
         06P0OHPFHr2oxfaRW3itkjbndyUnujIuPPlm1PTzMl1bvg5ZFO3isyYwl05CEIse4kDf
         psyRujXW5Q1LyL46x169UqAkQNlwJP/Kh8mRL94ddGcQtPOwMTvAv264EhIzvlbeu55d
         secg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789722696; x=1790327496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fpIPJYBrAn9lh0X90aJ+LjetM4Yd20S6QCxk4a13+gY=;
        b=yutyh8Z9cqR5DwEgZi9LoHaA0NHfpLChS2l84Jt2HqRjHSACryGhwk7aMSTcAbr8Ou
         tPdTjvofAIRMiqngnnp+I6EDGu0a0pqmGGeHNcI7K+pNSqkhodByzJCeqK2+3I+v4EU/
         PREyix7elPg2rtyt8HaAm4843/VLO6KO2pF+MqlymBG07MTpPAvpe94wrUUzLtLAe+ee
         Qxr+cOh+66n3+MmYiyu8VLiJVYjaIpJxMLYYexP0obuQZP8zSc9R6jOD0vNPO3nWurry
         TryXtnED2ZcqSqpwXJNx6LJ59lKdQvUp5yCW0S4mKsoCnxY+lvxc1ZMcrFX9f5bo2bk1
         D8ew==
X-Gm-Message-State: AFuF++l2/+WnAMp5goTxqOxfmJsbBbVGZdwZ3LJu9rr/hOH0eFjRe5Si
	za1Nai8j9WNhtXqnK+bMEBmA6nI3o9jE4Eg7o4Djd7oZX3TG0wtn7eKZtBx+UJbE
X-Gm-Gg: AYBFou1IA0i+t5PzRlo6TBUvA3QcmWr4vyz7REpLuIspjXqhhbUoXD6frP2n6wc/fIU
	NkW4kj9QF3GZGatTjxaRf5U2fUjU5AzwuQhKfe+k9Uq4fsIhEU+MPF5Jauab/AMEruma/TG3UEq
	4f6v6odwO1SBxnq7Gq/8YXAztq2PvHkxN6zRemBvbKEmBb8wzqJjmv4yqjNG4aPCwTQ52B3Ldc3
	6U7P62lrhzcWEoQzJdiE3VJh9r9cRyagvnLtAUBUaKBtulGmeQzVthtzIe53rEmdHlX5k9JSO9G
	n3nJqLGJeXLVhMI7RVwQrYoQEEj/Z5czH6ZIQDbGtVIbLpbyCSTTVx2w6Q25HMKgpMGyEe6IN+h
	58t7Yi+2oKU7VRTydVDF0U8JPA5FW6uMD5e0CrUshwA9x5UzRyIr35vgQ7YtEhLrwI8xO9/ekOX
	cda1DlFLwRAzbZYk3VyUzEPyQPNpX0s0xM5hyXZ3HflfjVO9sgRteLU10KuDGRpwFTPoe234mJE
	02oBMinkiQgwTSHzyDMyLuLtw==
X-Received: by 2002:a05:600c:3550:b0:49e:7d74:7b7a with SMTP id 5b1f17b1804b1-49fc56db8f3mr21040695e9.6.1789722695703;
        Fri, 18 Sep 2026 02:11:35 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1d0978sm138774275e9.2.2026.09.18.02.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:11:35 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	ljs@kernel.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v8 5/5] selftests/bpf: Test mm_struct user memory kfuncs with linux_binprm
Date: Fri, 18 Sep 2026 12:10:58 +0300
Message-ID: <20260918091058.297740-6-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918091058.297740-1-tasos.papagiannnis@gmail.com>
References: <20260918091058.297740-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sleepable BPF LSM program attached to bprm_check_security to test
bpf_copy_from_user_mm() and bpf_copy_from_user_mm_str().

Starting at bprm->p, verify that bpf_copy_from_user_mm() can copy the
contiguous NUL-separated argument and environment data. Then use
bpf_copy_from_user_mm_str() to read each argument and environment string
separately, advancing the offset by the length returned from each call.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 .../bpf/prog_tests/copy_from_user_bprm.c      | 65 +++++++++++++++++
 .../selftests/bpf/progs/copy_from_user_bprm.c | 69 +++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
 create mode 100644 tools/testing/selftests/bpf/progs/copy_from_user_bprm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c b/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
new file mode 100644
index 000000000000..310370689427
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <errno.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <test_progs.h>
+
+#include "copy_from_user_bprm.skel.h"
+
+void test_copy_from_user_bprm(void)
+{
+	char data[] = "first\0second-argument\0SOME_ENV=a\0OTHER_ENV=something";
+	char arg0[] = "first";
+	char arg1[] = "second-argument";
+	char env0[] = "SOME_ENV=a";
+	char env1[] = "OTHER_ENV=something";
+	struct copy_from_user_bprm *skel;
+	pid_t child;
+	int status;
+
+	skel = copy_from_user_bprm__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (!ASSERT_OK(copy_from_user_bprm__attach(skel), "attach"))
+		goto out;
+
+	child = fork();
+	if (!ASSERT_GE(child, 0, "fork"))
+		goto out;
+
+	if (!child) {
+		char *const argv[] = { arg0, arg1, NULL };
+		char *const envp[] = { env0, env1, NULL };
+
+		skel->bss->monitored_pid = getpid();
+		execvpe("true", argv, envp);
+		_exit(errno);
+	}
+
+	if (!ASSERT_EQ(waitpid(child, &status, 0), child, "waitpid"))
+		goto out;
+
+	if (ASSERT_TRUE(WIFEXITED(status), "child_exited"))
+		ASSERT_EQ(WEXITSTATUS(status), EPERM, "exec_errno");
+
+	ASSERT_EQ(skel->bss->bprm_argc, 2, "bprm_argc");
+	ASSERT_EQ(skel->bss->bprm_envc, 2, "bprm_envc");
+	ASSERT_EQ(skel->bss->data_len, sizeof(data), "data_len");
+	ASSERT_EQ(skel->bss->invalid_flags_ret, -EINVAL, "invalid_flags_ret");
+	ASSERT_EQ(skel->bss->copy_ret, 0, "copy_ret");
+	ASSERT_EQ(skel->bss->arg0_ret, sizeof(arg0), "arg0_ret");
+	ASSERT_EQ(skel->bss->arg1_ret, sizeof(arg1), "arg1_ret");
+	ASSERT_EQ(skel->bss->env0_ret, sizeof(env0), "env0_ret");
+	ASSERT_EQ(skel->bss->env1_ret, sizeof(env1), "env1_ret");
+	ASSERT_EQ(memcmp(skel->bss->data, data, sizeof(data)), 0, "data");
+	ASSERT_EQ(memcmp(skel->bss->arg0, arg0, sizeof(arg0)), 0, "arg0");
+	ASSERT_EQ(memcmp(skel->bss->arg1, arg1, sizeof(arg1)), 0, "arg1");
+	ASSERT_EQ(memcmp(skel->bss->env0, env0, sizeof(env0)), 0, "env0");
+	ASSERT_EQ(memcmp(skel->bss->env1, env1, sizeof(env1)), 0, "env1");
+
+out:
+	copy_from_user_bprm__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
new file mode 100644
index 000000000000..00ecba3ea567
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <errno.h>
+
+char _license[] SEC("license") = "GPL";
+
+int monitored_pid;
+int bprm_argc;
+int bprm_envc;
+int data_len;
+int invalid_flags_ret;
+int copy_ret;
+int arg0_ret;
+int arg1_ret;
+int env0_ret;
+int env1_ret;
+char data[64] = {};
+char arg0[32] = {};
+char arg1[32] = {};
+char env0[32] = {};
+char env1[32] = {};
+
+SEC("lsm.s/bprm_check_security")
+int BPF_PROG(check_exec_args, struct linux_binprm *bprm)
+{
+	u32 pid = bpf_get_current_pid_tgid() >> 32;
+	struct mm_struct *mm;
+	u64 offset = 0;
+
+	if (pid != monitored_pid)
+		return 0;
+
+	mm = bprm->mm;
+	if (!mm)
+		return 0;
+
+	bprm_argc = bprm->argc;
+	bprm_envc = bprm->envc;
+
+	/* this is the total size of args and envs starting from bprm->p */
+	data_len = bprm->exec - bprm->p;
+
+	invalid_flags_ret = bpf_copy_from_user_mm(data, sizeof(data), (void *)bprm->p, mm, ~0ULL);
+
+	copy_ret = bpf_copy_from_user_mm(data, sizeof(data), (void *)bprm->p, mm, 0);
+	if (copy_ret)
+		return 0;
+
+	/* arg0 is at bprm->p */
+	arg0_ret = bpf_copy_from_user_mm_str(arg0, sizeof(arg0), (void *)(bprm->p + offset), mm, BPF_F_PAD_ZEROS);
+	offset += arg0_ret;
+
+	/* arg1 is at bprm->p + arg0_ret */
+	arg1_ret = bpf_copy_from_user_mm_str(arg1, sizeof(arg1), (void *)(bprm->p + offset), mm, BPF_F_PAD_ZEROS);
+	offset += arg1_ret;
+
+	/* env0 is at bprm->p + arg0_ret + arg1_ret */
+	env0_ret = bpf_copy_from_user_mm_str(env0, sizeof(env0), (void *)(bprm->p + offset), mm, BPF_F_PAD_ZEROS);
+	offset += env0_ret;
+
+	/* env1 is at bprm->p + arg0_ret + arg1_ret + env0_ret */
+	env1_ret = bpf_copy_from_user_mm_str(env1, sizeof(env1), (void *)(bprm->p + offset), mm, BPF_F_PAD_ZEROS);
+
+	return -EPERM;
+}
-- 
2.55.0

