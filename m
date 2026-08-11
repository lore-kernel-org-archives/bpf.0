Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FCC42CAF3
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447381; cv=none; b=Hzh/SKqGpeBUa8Q9zNO/4LihPpovYxOSJ9WLp/vPy5hS2SsJovN8znbh2+b7wxjhFMiMJ7VP46N72LVINUgvoNMFXl43WozzuJZNOIuuSVwgKxL8uZVLe0EKS8WCxoDvE+3sintSPSBiALdh72uVtG+bFypmy2lcZ3+aLvjMAyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447381; c=relaxed/simple;
	bh=p3Bm9C4/TiK3m7Ewplohyu6u32ZVatvdJv7hlTAaDjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srRkyDIl8C/Xqbf6cNs6APRbgo9CnHf5p2P3Gm2S+htF8i/E9090DXgfjjayrABtO1j/xFJDt9dOpnUcCp3KopM9qm8klJ6+9fNNx5BwLqCQFodEWKQMGVpD0rSkBGhc9FjUa3z50KPIB0VX4Ogz3rfoZqfCdwLy8BVgrd5PvrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zmtq/H51; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zmtq/H51"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49954b88fffso32031085e9.0
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 04:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786447374; x=1787052174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Ekcm9Or7cb8hAHyaAjXHw9qfIL5BM5+FlcvqMKj+G4=;
        b=Zmtq/H51iVg6FFS3t1cWxMf4+2otpAYUxoEoQxjQstxSrXegodNh0vpv2cEIcbUprM
         dvS4c/OwRKbvIsatBqUrE1AG23eh3VJNX9xQ/8am/2WnNVBJSzzGSOlA0GM+NA+c0jnt
         hCt/COyJFJiD44pytup3+HpE86Ukp/5rNh44QOUa27MDRVCd7mZJjypD+6wKtpr91mvO
         qsfjj5J6l7uSUvmQ8Y0JljlFHauUrLy9zSKlqUp2HL37QoqVL7b8pHFc33C2Df2loP6R
         /Nc9dzWACavPI59/VjSAj7mYhjfq6s/kvCAmPu65YmJQ+HvUs4oGClz2MN1jvC+/sVyr
         M1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786447374; x=1787052174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Ekcm9Or7cb8hAHyaAjXHw9qfIL5BM5+FlcvqMKj+G4=;
        b=WUf6l+QmimCLcL9TubYU9a0L2CklF1Pep+5zRj0kC6nvAJahHCQX5ZjWcZVtpFvY0X
         Ve/0OIA6gwkaC7/R2LdDwGka/w89vjwnNxioIzzOeSFU3B5jvLZ5LZN4Sw0E7+Bmr+h9
         EaFZyX6YEPWOFDa30X2mv9io7JSFOteqcFXVMqPfiphd6MiEZCks54Fo3gfchET9h4en
         dB76tMpApI6lQV/SadcbfpCYntIY7D1jGLL92Gim7ooYgIn9vfm9gLqTBKtrvb2wpfB8
         dgFhlSjZ1+yJCNJHhqMbzVDR0SWGRjotxHeCGG/I9AfUZ+2QRjc6sDKmCHKBwLY6aOtM
         yjoA==
X-Gm-Message-State: AOJu0YzLWtypoZTNAx3QFCvm/AQ/yoPchDWJyQYiAol+ar48pH7qVnCE
	w72Ky7jQH0es27+otLUOr+qnAvlKtHgWbA670t3DCPcoHPBKYyusnpWj0YwwX6uY
X-Gm-Gg: AR+sD106/TlTafpvyVGJpdZ0Ma3B4xmuhhJz0HXHJIt5novtJbAeAFiOeCGFaHNhlCM
	33Ri38wPrfGjvcXfVSRuJNAFVtpuXRcmgcmyjZAIx2vjyG65nHIL30P6N6rIJt5MCQpeW0FjgEt
	z98gZMOPaSqIZ/mdV+v4kyDCdW7Gs7tFQwA4Z5Z0ohhZsVSGjIWUW2kA29+p4KT2dYkzDHunzvO
	SwaP+2ziW8YV/fMBeWIMSemLrQTJV6TQGwY2xEgC4phiVfLDi6MK71hTPbBzZQSc+sBnOrWC4qO
	EyOLiwhe9lTHCS1e5hbWVIqUdd7pmord3cG7l09pq6kV5VvPgntLAa0BfjDJ1/IGMygoeYRXr9/
	FPOtONMabxouMTEFe0klWt+zAg7CseOKt7d30haFuhXLqbPZHu5I/eqqK6LsOenhkx0QSEqIw6F
	0pdFAhRXvo7P4PfbKDvzQy8lR3t2ZQE2YzGRAUTyRjpwN2zAB9FGy9wVlAJC8WUYuTBuu+vKHSg
	i9k
X-Received: by 2002:a05:600c:34d3:b0:499:6eac:36d2 with SMTP id 5b1f17b1804b1-4997846d9c5mr44664915e9.17.1786447373789;
        Tue, 11 Aug 2026 04:22:53 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c2bcsm47547665e9.3.2026.08.11.04.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 04:22:53 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
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
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next 5/5] selftests/bpf: Test mm_struct user memory kfuncs with linux_binprm
Date: Tue, 11 Aug 2026 14:21:54 +0300
Message-ID: <20260811112154.94053-6-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811112154.94053-1-tasos.papagiannnis@gmail.com>
References: <20260811112154.94053-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sleepable BPF LSM program attached to bprm_check_security to test
bpf_copy_from_user_mm() and bpf_copy_from_user_mm_str() using the trusted
mm_struct from linux_binprm.

After checking bprm->mm for NULL, start at bprm->p and verify that
bpf_copy_from_user_mm() can copy the contiguous NUL-separated argument
data. Then use bpf_copy_from_user_mm_str() to read each argument separately
by advancing the offset based on the returned length. Also verify that
bpf_copy_from_user_mm() rejects unsupported flags.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 .../bpf/prog_tests/copy_from_user_bprm.c      | 52 +++++++++++++
 .../selftests/bpf/progs/copy_from_user_bprm.c | 77 +++++++++++++++++++
 2 files changed, 129 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
 create mode 100644 tools/testing/selftests/bpf/progs/copy_from_user_bprm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c b/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
new file mode 100644
index 000000000000..3d5080a3975e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
@@ -0,0 +1,52 @@
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
+		char *const argv[] = { "first", "second-argument", NULL };
+
+		skel->bss->monitored_pid = getpid();
+		execv("/bin/true", argv);
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
+	ASSERT_EQ(skel->bss->invalid_flags_ret, -EINVAL, "invalid_flags_ret");
+	ASSERT_EQ(skel->bss->copy_ret, 0, "copy_ret");
+	ASSERT_EQ(skel->bss->str_arg0_ret, 6, "str_arg0_ret");
+	ASSERT_EQ(skel->bss->str_arg1_ret, 16, "str_arg1_ret");
+	ASSERT_EQ(skel->bss->args_match, 1, "args_match");
+	ASSERT_EQ(skel->bss->str_args_match, 1, "str_args_match");
+
+out:
+	copy_from_user_bprm__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
new file mode 100644
index 000000000000..d7132bca6edc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
@@ -0,0 +1,77 @@
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
+static const char expected_args[] = "first\0second-argument";
+static const char expected_arg0[] = "first";
+static const char expected_arg1[] = "second-argument";
+
+int monitored_pid;
+int bprm_argc;
+int invalid_flags_ret;
+int copy_ret;
+int str_arg0_ret;
+int str_arg1_ret;
+int args_match;
+int str_args_match;
+
+extern int bpf_copy_from_user_mm(void *dst, u32 dst__sz,
+				const void *unsafe_ptr__ign,
+				struct mm_struct *mm, u64 flags) __ksym;
+
+extern int bpf_copy_from_user_mm_str(void *dst, u32 dst__sz,
+				    const void *unsafe_ptr__ign,
+				    struct mm_struct *mm, u64 flags) __ksym;
+
+SEC("lsm.s/bprm_check_security")
+int BPF_PROG(check_exec_args, struct linux_binprm *bprm, int ret)
+{
+	u32 pid = bpf_get_current_pid_tgid() >> 32;
+	struct mm_struct *mm;
+	char args[sizeof(expected_args)];
+	char arg0[32];
+	char arg1[32];
+
+	if (ret || pid != monitored_pid)
+		return ret;
+
+	mm = bprm->mm;
+	if (!mm)
+		return 0;
+
+	bprm_argc = bprm->argc;
+
+	invalid_flags_ret = bpf_copy_from_user_mm(args, sizeof(args),
+						  (void *)bprm->p, mm, 1);
+
+	copy_ret = bpf_copy_from_user_mm(args, sizeof(args),
+					 (void *)bprm->p, mm, 0);
+	if (copy_ret)
+		return 0;
+
+	args_match = !__builtin_memcmp(args, expected_args, sizeof(expected_args));
+
+	str_arg0_ret = bpf_copy_from_user_mm_str(arg0, sizeof(arg0),
+						 (void *)bprm->p, mm,
+						 BPF_F_PAD_ZEROS);
+	if (str_arg0_ret != sizeof(expected_arg0))
+		return 0;
+
+	str_arg1_ret = bpf_copy_from_user_mm_str(arg1, sizeof(arg1),
+						 (void *)(bprm->p + str_arg0_ret),
+						 mm, BPF_F_PAD_ZEROS);
+	if (str_arg1_ret != sizeof(expected_arg1))
+		return 0;
+
+	str_args_match = !__builtin_memcmp(arg0, expected_arg0, sizeof(expected_arg0)) &&
+			!__builtin_memcmp(arg1, expected_arg1, sizeof(expected_arg1));
+
+	return args_match && str_args_match ? -EPERM : 0;
+}
-- 
2.55.0

