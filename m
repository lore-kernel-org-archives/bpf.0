Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D6E448CF1
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231928; cv=none; b=Ny/zipwAGTWvOFiqb9ZUWlEft+D9j8R4J6syUyWs25t5fxrqiJnVExFYDHcpAb2MFP1HqeyWAowRlyZ593ctoCtQS3FoipVCgv1wMhdTYgogFXDK+CPgVIJ3XmcIYqrmD+FGEhXzLe/HIipVx3ztiTJEu29VOtF+pwJXtbGLyxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231928; c=relaxed/simple;
	bh=f/eVcXeoiqfV4jlIqAc69WXM4ZBCO3csmi5dXDXXPOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMGZtj/q1z6bDfZvRgKaRTbOQCE1KPHA2QIWzxNkbpmLjoteQ+I9gt11DDst6kZCERmtYb3p8ly1suEjGEc2hOuLEBmLGmUBEhdulCULtiVrZkIs6reRAl/RmNhFJYAKXGicBLjRodlFLs9NcWA2h1/tbhTBwRxVpb54TTP2QS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkQDIuaR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkQDIuaR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4956242332dso23115105e9.2
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 06:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787231925; x=1787836725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vR40jF9Ss8LmiP9zSaPNfnunPJsok/mkpHKsfsj1AOo=;
        b=QkQDIuaR2WKegu2Qgjv7FQom99t505tsPoaT4Q+kXMp5E6f+JIP9/Xk0lUFiAoxUbZ
         9VtFXzGW8pc+wDMb3lCcjUOxCRdWwA+O4v2s/rkYC9EgR8M+zOqZC5P4eaBwls2tnX35
         IRSIQSD6IuRpH0SQL4FMrpd/6l6vszZoGC0zXzt041D7BQDi9+0iZdvPb9GOIOiwqBqo
         Ne1+mERowikGOfEydBzkFSOsd7WQjakLitEqlc3OAJR3WOIanYIdTuwC7qZL7Qlm2pqW
         qdvSMjm7/XwfcR2qRZF0y7j0cIXlVruWTEAiZK015pJvnIHjNRvUuHAkob+DLlsk5/4I
         geMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787231925; x=1787836725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vR40jF9Ss8LmiP9zSaPNfnunPJsok/mkpHKsfsj1AOo=;
        b=TEoFqG6xtzL2zKWOcjmoWTNjza7rXfPraFW3EGsK8/oR4D7lhbIHCnXo0n5bNZngAQ
         lTrFZyOar9jRF1P7s1l8gI/nJDrTnaTXRZar0GflagJtYc2vkOd3bwykI6yQ97IVLP8y
         40Kt0r9izxvOCoEjZdEOz06wZaBwSJPfVjJb0v+mskQIP7bvn/nV5qXKCp5kZFmtqsfA
         B2O/o1+50KY8bjdtLcT1abGjMK3vYRpdP3j9qKYfDXtzNxuh1OJTsjV1RrPwDFwIyRWU
         ilcaJF0FG6nSZpcQBNXBv519CRewIOA0HUL6zBt4+lvwV/hSMgE5OX4XFUGzJ+Kfsd43
         2efA==
X-Gm-Message-State: AOJu0YzOAIiuqFyMyhYtWMWv6pFNCN5f2RwmHC8MMZrMCn+xcuve31JS
	B4VNdSDXrGpLoUEa3dl9dFXJbzW1Y8PGTYjMjgfeMU9r6yz9vq+2Go2l0aAS71oEFqY=
X-Gm-Gg: AR+sD10AgaQm+cAqPSM3caeko29kCNkaDQzt7zQuPb2E6y92NBDxszQjtkP5wpohG/j
	2ceMtRiSnWqHvg9SVu+e1W4TbCTIXYaxzljac+cW6YbZ/GejryayDtH5SewPGoFnpN86VUfECWJ
	2mgnfW5hDrCSSZsZSHDcybSlLhASiWnmOWS+dOw6QZC5Z3PKQtpF+IH9G4Kmml8y99flZhfAkPi
	v/gcbM4MKuZB+j3HUgoXVUc9jjPmkC1U9wKyzVybAIM35SoOybgwwlV5AZ4yiev6oP3JoKzoBa+
	vgTrLJom9WFEX9b61reYLJVy7c8PV/aUh+5CEdG3grTE9rtbW7LKNjg2bAS23EAqaTHYXKZrI1E
	VvL2oHxxG0iRcFjszU4dvHT14wRE40HzzKoEJfX8+MTFAOAhS8/0qGLzXGkVxThBhcNiHhGQCdC
	FjwMacf2aLI7jMqRVZCBIG4TI0rnpY4QvOuOYiuzbrqgPbYlGk/YjeW6h3nfx7RLRtrcJ2VMyz+
	rnn
X-Received: by 2002:a05:600c:470a:b0:499:a5fc:207e with SMTP id 5b1f17b1804b1-499aa17e2bamr164727435e9.8.1787231924991;
        Thu, 20 Aug 2026 06:18:44 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0e473dsm136027275e9.15.2026.08.20.06.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 06:18:44 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	song@kernel.org,
	utilityemal77@gmail.com,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Test linux_binprm user memory kfuncs
Date: Thu, 20 Aug 2026 16:18:01 +0300
Message-ID: <20260820131801.68759-4-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820131801.68759-1-tasos.papagiannnis@gmail.com>
References: <20260820131801.68759-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a sleepable BPF LSM program attached to
bprm_check_security to test bpf_copy_from_user_bprm() and
bpf_copy_from_user_bprm_str().

Starting at bprm->p, verify that bpf_copy_from_user_bprm() can copy the
contiguous NUL-separated argument and environment data. Then
use bpf_copy_from_user_bprm_str() to read each argument and environment
string separately, by advancing the offset based on the returned length.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 .../bpf/prog_tests/copy_from_user_bprm.c      |  62 ++++++++++
 .../selftests/bpf/progs/copy_from_user_bprm.c | 115 ++++++++++++++++++
 2 files changed, 177 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
 create mode 100644 tools/testing/selftests/bpf/progs/copy_from_user_bprm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c b/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
new file mode 100644
index 000000000000..1007e3aec054
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
@@ -0,0 +1,62 @@
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
+		execve("/bin/true", argv, envp);
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
index 000000000000..4d7e9002b45b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <errno.h>
+#include "bpf_misc.h"
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
+extern int bpf_copy_from_user_bprm(void *dst, u32 dst__sz,
+				   const void *unsafe_ptr__ign,
+				   const struct linux_binprm *bprm,
+				   u64 flags) __ksym;
+
+extern int bpf_copy_from_user_bprm_str(void *dst, u32 dst__sz,
+				       const void *unsafe_ptr__ign,
+				       const struct linux_binprm *bprm,
+				       u64 flags) __ksym;
+
+SEC("lsm.s/bprm_check_security")
+int BPF_PROG(check_exec_args, struct linux_binprm *bprm)
+{
+	u32 pid = bpf_get_current_pid_tgid() >> 32;
+	char data[sizeof(expected_data)];
+	char arg0[32];
+	char arg1[32];
+	char env0[32];
+	char env1[32];
+	u64 offset = 0;
+	u64 data_len;
+
+	if (pid != monitored_pid)
+		return 0;
+
+	bprm_argc = bprm->argc;
+	bprm_envc = bprm->envc;
+
+	/* this is the total size of args and envs starting from bprm->p */
+	data_len = bprm->exec - bprm->p;
+	data_len_match = data_len == sizeof(expected_data);
+
+	invalid_flags_ret = bpf_copy_from_user_bprm(data,
+						    sizeof(data), (void *)bprm->p, bprm, ~0ULL);
+
+	copy_ret = bpf_copy_from_user_bprm(data, sizeof(data), (void *)bprm->p,
+					   bprm, 0);
+	if (copy_ret)
+		return 0;
+
+	data_match =
+		!__builtin_memcmp(data, expected_data, sizeof(expected_data));
+
+	/* arg0 is at bprm->p */
+	str_arg0_ret = bpf_copy_from_user_bprm_str(arg0, sizeof(arg0),
+						   (void *)(bprm->p + offset),
+						   bprm, BPF_F_PAD_ZEROS);
+	if (str_arg0_ret != sizeof(expected_arg0))
+		return 0;
+	offset += str_arg0_ret;
+
+	/* arg1 is at bprm->p + sizeof(arg0) */
+	str_arg1_ret = bpf_copy_from_user_bprm_str(arg1, sizeof(arg1),
+						   (void *)(bprm->p + offset),
+						   bprm, BPF_F_PAD_ZEROS);
+	if (str_arg1_ret != sizeof(expected_arg1))
+		return 0;
+	offset += str_arg1_ret;
+
+	/* env0 is at bprm->p + sizeof(arg0) + sizeof(arg1) */
+	str_env0_ret = bpf_copy_from_user_bprm_str(env0, sizeof(env0),
+						   (void *)(bprm->p + offset),
+						   bprm, BPF_F_PAD_ZEROS);
+	if (str_env0_ret != sizeof(expected_env0))
+		return 0;
+	offset += str_env0_ret;
+
+	/* env1 is at bprm->p + sizeof(arg0) + sizeof(arg1) + sizeof(env0) */
+	str_env1_ret = bpf_copy_from_user_bprm_str(env1, sizeof(env1),
+						   (void *)(bprm->p + offset),
+						   bprm, BPF_F_PAD_ZEROS);
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

