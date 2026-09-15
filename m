Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5F53CCFCC
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459424; cv=none; b=PjaZ46vNpqzaifY+IejYXI6YAJb9IR2aBDjhO7LFO5t+JyWYmOe2RbAJHgWy9Hca2d0tZa9w1ocyjGczc5AFEXGmodGZJfKJ4e4J0eGBxpsD8IwScR7zk9Vdhu10RW89sP5L+v/cN++6xxz74xIv8xLMrof+aL+XFN1wldH6Vn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459424; c=relaxed/simple;
	bh=xB2rAwluU7tS0l2mdEY9sK1jOotMoucM4DUYTDrHNek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aj4fIKhA6ZcK/XYnxpWEuOnR9xEE2XQrq+N0+3/0RQbi6SHvGqHU7/VvCwvTsKMRXU2EDDlhemh/D1k+CMu9B0rEB7P782H1XV8XFeu+WoVbAOuHxwgnWdVHzhWQOW1MPOUY8p/jqzvMAOCAeM0Sbx5wCsN32dMMH3h1yB9bEPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3pJBLmu; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3pJBLmu"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f635552aso2347632f8f.2
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 01:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789459420; x=1790064220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JMfo0lOkU7nY+kpMSBVMONrY7JpNJm89ZLpxpQTDFY8=;
        b=Z3pJBLmu12QY1ysKUlG7VxUXFpj2RrliLNaF30kHzuwC3vsG/hPcONSouwMvlI8dbF
         G2MYw//rQbOpgWeEFjo4ADxIkxFKn5cwUZvypja3yuNjP9RCdBSwTaPf73IrtlfI2+ul
         mHgEjyoguhGwmhPtjkk52Jc+kjZwkGNj3FW1Ej8B2B2lVQ8U54hoiM5D8YtYpFXIXDy5
         CUm1UbD7LCVExoTu+eiM943oK0loh+lg6iNpMncmUtvZ0ff6zYF2jOiDEwizEce/GzWa
         l3DYyyqo5Fi+Wp/Nao04X58v/rOuWjWUF8GTaKMps8TW5mE8gjJeE9RWn4ZzrdJI4iD7
         Nqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789459420; x=1790064220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JMfo0lOkU7nY+kpMSBVMONrY7JpNJm89ZLpxpQTDFY8=;
        b=Uw0ulqVYJNKQ2C5helfAYZaFipptlGvUqlaR+kHyXXCSlwhVVK+5/Vk+sazaDgBGF/
         l/hvaRcH0N6nNNnREhJioPKCUyIMVqcCv1TAX4M9awVs3A29C4rp5OnaHgFOK5uJFS95
         1nc3axDmHGOVjjnhIorCDXMExN9KYWocwWQVKgQYO42qspUc4FG7+CPzDDI35B2lynoZ
         IUBtUr/tMV1ktS2OF8VqPbjr8t+oZFrKgZUWrY1Wk/u+N8jn41Mf1nI3P/grjJElMYPE
         M9i+IRHZjDQAU2oC8dKFC9oR/JlZTQSuvnXQcmlg6InpFAFL3qjcWBuq5tp5Yl7JserM
         rZjg==
X-Gm-Message-State: AFuF++l2rjBzNNWmpCgB0kLBRt8gG46iEj4qH8OKkKvCGSvxbpDN1Hq2
	CLguA1eUhz93JuoD7EqOUJXDMc5rQGvX3a9CswM6Ot5o9g6DkCOTgic7DASnL/1DD7k=
X-Gm-Gg: AYBFou3Hfc61+nS9oR8oO32eW1Oq+yda2d1+pllO0RJjHNC/XiXE88LFzIIh1nvbCV4
	+WHddkpmV9K6KhFxehe/4LT+TzHW2ZjgYI5H6IrKU2t5siBlwLlWyGVUoagbKcFzNQa/p7n9n7U
	dEAY4ZTs5TulInL0JgPHHJ/p+akupCF7A3ySRfgbvbVcQhhveens1oZyzx0tSnlMsFQMPDjZ4KH
	VTGylzatASPA+nTQxcKlzcVYHB2VzME0TUWfZv5uvlPeU8eeqhKlGkW4NJRXvFHud14uzxNZ/ol
	r8c65qcLTz025fmxgYYCbDF2ItveYkhs5JsUpkJSTJA2GK4jsPVi6Ui7QvZp9prdVZUJ3DFPkEd
	qV3wjAFCTzSW0wyWz6BbtVO+BWTqrw/rBeluFF0uR7jn1T4qJv6pBGbj6f4oYTyzmaAVnaIAIE1
	qZv1I2vYZ7PZyoxMRTkvJB+Z0e81IKet5YSuO4Kd9BcJgDMlXoOyO7Fo7Nxo9If65Alw9iSbL6F
	KaecdnbITiTcV+8
X-Received: by 2002:a05:6000:381:b0:487:40d:af2a with SMTP id ffacd0b85a97d-487040db0f5mr6181796f8f.4.1789459420380;
        Tue, 15 Sep 2026 01:03:40 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35c071sm33764675f8f.33.2026.09.15.01.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:03:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 5/5] selftests/bpf: Test mm_struct user memory kfuncs with linux_binprm
Date: Tue, 15 Sep 2026 11:02:55 +0300
Message-ID: <20260915080255.48929-6-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915080255.48929-1-tasos.papagiannnis@gmail.com>
References: <20260915080255.48929-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sleepable BPF LSM program attached to bprm_check_security to test
bpf_copy_from_user_mm() and bpf_copy_from_user_mm_str() on CONFIG_MMU
kernels.

Starting at bprm->p, verify that bpf_copy_from_user_mm() can copy the
contiguous NUL-separated argument and environment data. Then use
bpf_copy_from_user_mm_str() to read each argument and environment string
separately, advancing the offset by the length returned from each call.

Skip the test on !CONFIG_MMU. In that configuration, exec argument and
environment strings remain in bprm->page[] until the binary loader
transfers them to the new process stack, so they are not accessible
through bprm->mm at the bprm_check_security hook.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 .../bpf/prog_tests/copy_from_user_bprm.c      |  72 +++++++++++
 .../selftests/bpf/progs/copy_from_user_bprm.c | 122 ++++++++++++++++++
 2 files changed, 194 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
 create mode 100644 tools/testing/selftests/bpf/progs/copy_from_user_bprm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c b/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
new file mode 100644
index 000000000000..ef351cda9348
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
@@ -0,0 +1,72 @@
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
+	/*
+	 * On !CONFIG_MMU, exec strings are held in bprm->page[] rather than
+	 * being mapped in bprm->mm.
+	 */
+	if (!skel->kconfig->CONFIG_MMU) {
+		printf("%s:SKIP: test requires CONFIG_MMU\n", __func__);
+		test__skip();
+		goto out;
+	}
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
+	ASSERT_EQ(skel->bss->data_len_match, 1, "data_len_match");
+	ASSERT_EQ(skel->bss->invalid_flags_ret, -EINVAL, "invalid_flags_ret");
+	ASSERT_EQ(skel->bss->copy_ret, 0, "copy_ret");
+	ASSERT_EQ(skel->bss->str_arg0_ret, sizeof(arg0), "str_arg0_ret");
+	ASSERT_EQ(skel->bss->str_arg1_ret, sizeof(arg1), "str_arg1_ret");
+	ASSERT_EQ(skel->bss->str_env0_ret, sizeof(env0), "str_env0_ret");
+	ASSERT_EQ(skel->bss->str_env1_ret, sizeof(env1), "str_env1_ret");
+	ASSERT_EQ(skel->bss->data_match, 1, "data_match");
+	ASSERT_EQ(skel->bss->str_args_match, 1, "str_args_match");
+	ASSERT_EQ(skel->bss->str_envs_match, 1, "str_envs_match");
+
+out:
+	copy_from_user_bprm__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
new file mode 100644
index 000000000000..07ca96d9db45
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
@@ -0,0 +1,122 @@
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
+static const char expected_data[] = "first\0second-argument\0"
+				    "SOME_ENV=a\0OTHER_ENV=something";
+static const char expected_arg0[] = "first";
+static const char expected_arg1[] = "second-argument";
+static const char expected_env0[] = "SOME_ENV=a";
+static const char expected_env1[] = "OTHER_ENV=something";
+
+int monitored_pid;
+int bprm_argc;
+int bprm_envc;
+int data_len_match;
+int invalid_flags_ret;
+int copy_ret;
+int str_arg0_ret;
+int str_arg1_ret;
+int str_env0_ret;
+int str_env1_ret;
+int data_match;
+int str_args_match;
+int str_envs_match;
+
+extern bool CONFIG_MMU __kconfig __weak;
+
+extern int bpf_copy_from_user_mm(void *dst, u32 dst__sz,
+				 const void *unsafe_ptr__ign,
+				 struct mm_struct *mm, u64 flags) __ksym;
+
+extern int bpf_copy_from_user_mm_str(void *dst, u32 dst__sz,
+				     const void *unsafe_ptr__ign,
+				     struct mm_struct *mm, u64 flags) __ksym;
+
+SEC("lsm.s/bprm_check_security")
+int BPF_PROG(check_exec_args, struct linux_binprm *bprm)
+{
+	u32 pid = bpf_get_current_pid_tgid() >> 32;
+	char data[sizeof(expected_data)] = {};
+	struct mm_struct *mm;
+	char arg0[32] = {};
+	char arg1[32] = {};
+	char env0[32] = {};
+	char env1[32] = {};
+	u64 offset = 0;
+	u64 data_len;
+
+	if (!CONFIG_MMU)
+		return 0;
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
+	data_len_match = data_len == sizeof(expected_data);
+
+	invalid_flags_ret = bpf_copy_from_user_mm(data, sizeof(data),
+						  (void *)bprm->p, mm, ~0ULL);
+
+	copy_ret = bpf_copy_from_user_mm(data, sizeof(data), (void *)bprm->p,
+					 mm, 0);
+	if (copy_ret)
+		return 0;
+
+	data_match =
+		!__builtin_memcmp(data, expected_data, sizeof(expected_data));
+
+	/* arg0 is at bprm->p */
+	str_arg0_ret = bpf_copy_from_user_mm_str(arg0, sizeof(arg0),
+						 (void *)(bprm->p + offset),
+						 mm, BPF_F_PAD_ZEROS);
+	if (str_arg0_ret != sizeof(expected_arg0))
+		return 0;
+	offset += str_arg0_ret;
+
+	/* arg1 is at bprm->p + sizeof(arg0) */
+	str_arg1_ret = bpf_copy_from_user_mm_str(arg1, sizeof(arg1),
+						 (void *)(bprm->p + offset),
+						 mm, BPF_F_PAD_ZEROS);
+	if (str_arg1_ret != sizeof(expected_arg1))
+		return 0;
+	offset += str_arg1_ret;
+
+	/* env0 is at bprm->p + sizeof(arg0) + sizeof(arg1) */
+	str_env0_ret = bpf_copy_from_user_mm_str(env0, sizeof(env0),
+						 (void *)(bprm->p + offset),
+						 mm, BPF_F_PAD_ZEROS);
+	if (str_env0_ret != sizeof(expected_env0))
+		return 0;
+	offset += str_env0_ret;
+
+	/* env1 is at bprm->p + sizeof(arg0) + sizeof(arg1) + sizeof(env0) */
+	str_env1_ret = bpf_copy_from_user_mm_str(env1, sizeof(env1),
+						 (void *)(bprm->p + offset),
+						 mm, BPF_F_PAD_ZEROS);
+	if (str_env1_ret != sizeof(expected_env1))
+		return 0;
+
+	str_args_match =
+		!__builtin_memcmp(arg0, expected_arg0, sizeof(expected_arg0)) &&
+		!__builtin_memcmp(arg1, expected_arg1, sizeof(expected_arg1));
+	str_envs_match =
+		!__builtin_memcmp(env0, expected_env0, sizeof(expected_env0)) &&
+		!__builtin_memcmp(env1, expected_env1, sizeof(expected_env1));
+
+	return data_match && str_args_match && str_envs_match ? -EPERM : 0;
+}
-- 
2.55.0

