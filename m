Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7AE4F7999
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737518; cv=none; b=U9znLAsOKdlv8pCP2S7urbNDn5SlAcrSoHTu5fYk7OieAITUlbG72r6QbrSawhEGjg3rXa8KTCccf9+do9uhGqY9b0qWWUNcCRSXEEP91Nu+gUhQ+El6FJPWp/2IZrVMpsjbRroEdGyBmCIN57IRMJjKGvm/4BF/dpV6IMA+QV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737518; c=relaxed/simple;
	bh=GnQNNaO2NdAe4bfr6j79tdcCpkRyZDIf9oDO6K4Un58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYl8DR29mqhxqk12WT27X+gI/9s0GAn/OmWFg8kfNNQBQmgJJRxhqDvHPYwJA1XUf85WbNAc6BmzN70MXEkzenYZMfHNRU7Uz6cWozf6w0w3YHfLtYaRFcbyWXHvPGL3lRBF9Mi+xfrap4buXKFLAD/+HhBz1flXRwKChsWUXOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfNj6vqq; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfNj6vqq"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f635552aso586440f8f.2
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789737513; x=1790342313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fpIPJYBrAn9lh0X90aJ+LjetM4Yd20S6QCxk4a13+gY=;
        b=dfNj6vqq9xkhGvDp+J6LNGtrm5ncKHKgZ8DFRcbBaYW1fEYVgQRm+GygaOxmtkowpi
         Hn6UAlfO3JrbHYqvVctOMS/O46fN8RBxPeAq7HwsObKpN4Gv5xnKfFZyiYSV/85gpsCK
         mJ0zFAZNfCANkCk6/ZCsf6OzyzYBiAPY+OM6t2Xz1NGPPiDp0nnbvMTkE9MjIOLuZ3nj
         ZzmJDso5Pp7WkAoRqsX3wzyzblhY9prTKhybIRe5eJ6VZAvHwqsS0DgByxx3ZWm2EHbY
         ZojEHTVgSft6SrLfQFWYn4EhDj2/OxavCHGMoq74PDzTq6Ap8TY8UtCLmh6uKSDtbYBR
         Bwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737513; x=1790342313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fpIPJYBrAn9lh0X90aJ+LjetM4Yd20S6QCxk4a13+gY=;
        b=WqRILlieqjF4AETp1aYBhlbOjSaT48D0cZBv6DTJPLXflm8hMAAYCsDcrQwW+rCMyZ
         YBVm++CXZW1+o/JmYSPuMm6IjEmRhxUQvW5A0Ze6RROOj1JswjPYXE9VU6XacPc+Y36E
         tepMQSheZsgMcs5SS9OMJgWjLp9Bf6C1GO9bvbp03Y24xP+yBayBKZJ5C+B8mwUDbsXO
         B004RmmnHPWcObdCrFNBeqALnhXnbB8FsuqBMfJqm/1uNb10XkI2hxFavAxVMKtmY8nm
         3vUI3y8iTapUbTzSF1sbOA2K47r95rr4AxVWuuk92JuKg5sJVpXCN3nuM3EmAEgwa8/M
         6H1w==
X-Gm-Message-State: AFuF++kTauXzZS04j41ClbsL3fcuKIU1pmGGVhQhxY/YA++pZuayLkfv
	6UN8CqTsAKextyuc5Wf0Khb/x9fuCFQgWamk/KPbYcebUHrBtvb9//dSv9DpLHdA
X-Gm-Gg: AYBFou30Dfq1PI3RCnVcsBx8npPHbr11NIx00JqoFfZ5kBdO/ZpOIIUpSVfzJ5SdSlz
	YpfJ2M1j+b2PpIqEezrpbvKA4UB+zo7CM96dgBmz6+jitFmuoZsdWn3NK7iMWXUvw/dMyYyKH0d
	l6eKLUl89ufv7gfUfq2Mhg5wijuXcSGg/0A1qjXLhhLo2WHWf+OQ6lbP1Bd/0Z8FQ/pc31r50Jc
	g5X6z/m5x/Kv9TJNJquD9/VOr/rIBdbTkZr9KH7q/znWKP4M502g9jeaIcPkPLE7F/1+CSxy/sg
	I1L51wLMRu4KX6pLa9kVu45WgQQ9jpihegdA2tbHbojYgd9nlZ36XPzBgWR+h6JxV8hA7X96In9
	kHbuDvhfV0drEbpavnvXLIORfB3lGQCZHULsgu336HfveVAjr2GxIxWxTInp/GKW4b0Xg3pcDEY
	fLK5irAC586a8D7FtGlhyXu6I2QwNCeUFTq2rakrpUk+GtCK3cxP+1f/AkSoAI2LeelLS0D32r9
	zCXAUHQUxdruYk=
X-Received: by 2002:a05:6000:41f0:b0:487:7fd:730 with SMTP id ffacd0b85a97d-4871e254ef7mr3501858f8f.13.1789737513163;
        Fri, 18 Sep 2026 06:18:33 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871feb5de3sm4424549f8f.1.2026.09.18.06.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:18:32 -0700 (PDT)
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
Subject: [PATCH bpf-next v9 5/5] selftests/bpf: Test mm_struct user memory kfuncs with linux_binprm
Date: Fri, 18 Sep 2026 16:17:57 +0300
Message-ID: <20260918131757.42802-6-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918131757.42802-1-tasos.papagiannnis@gmail.com>
References: <20260918131757.42802-1-tasos.papagiannnis@gmail.com>
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

