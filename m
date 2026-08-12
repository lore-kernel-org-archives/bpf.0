Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770FE432BC1
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533141; cv=none; b=ZKtznFWcr2YLIH9/R2an27u6hjWCTNhjVZKwGvzYs1iY3lXKFjDdaKqXPN6UA42EQpZ51nnltMqukalWYWdc+F9l/SXmLwoXm920ZERPBfYpk0CocOSODP+vuQDo5uq1ssbcIQaQ32Jwm3lt5cA8n0hN+hhAUZnXuyeERcAXRj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533141; c=relaxed/simple;
	bh=Vt4B7VdAPzg3HHiMRpJdUpbR4PPcaOpFgQUR4MjJ044=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwmEpmFN4JTQ9KB/RcNsiiXO+0aHMCY+bAIwnuGGElHXNoWHtfYi7BQLTbXoQnaGbFe2kUKl5zWDcyePr1NW4vd4W9gLFnVmb2lAWdsRVvHiuPQYXL0Rd98xCDk3qnGB/1bwlL9qg4TPrNhaBd0HNkCcn/dXadZexHi9fMLK+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlY9sLDW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlY9sLDW"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49557167508so5934295e9.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533138; x=1787137938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DniDtpSNvo/ABReRZwqLfy9Ok6b/HLHOLbbY3qeelds=;
        b=JlY9sLDWDtDapzTzws3QQeLPVJ+VVeOlPjxwE00g4ai3iQtK5L6n8BXAJjWVpV9w8b
         PC+t3v+TzJiDZBwZkQ6syADHGJbeCWPZwpyIklzbqZhP2JHQNCjpRMGbglPsPv0MdE1Q
         EsfP52vfTlZaeZMXVZ8+5H9KQKForG8MkEwMb5i6fl/O7cUSE3Mi/HLfbZmT6CXyTR1O
         MMqe1WLuAg1FasxZxabEGHPue6w7yM2hzeOwX9KQNivzpL7aDp/dxQvb42Yr8mtkyCqC
         cP1++Fnv8XGOf94gJ4hMkzPY4z/8EbVQ7yV4KB+Ho1t9Va7kpv6k18fJYlxSzp1S5p/i
         0qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533138; x=1787137938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DniDtpSNvo/ABReRZwqLfy9Ok6b/HLHOLbbY3qeelds=;
        b=p20aPhm8ASn+GeZ67CwquHZUH27XuLbvWh3OLD/yweW03/5eM6gLVJriyE1JL1x49Y
         wIECxVZVyYr/AXO1gTbfy80WgwuzLL2KI+dbRgPIdYXiO3HT3WxkUBvgzxktGxp/PDa7
         ML8mcmaKwrjpMa9iC+MJxhbhhnrKJ73Ls6vp1fViU0yBNnqNhpNdBm2S0FW45xKtfSUS
         DPmyPco4pB1sQZfUPi5FJrodepy8fn6vPehXcKzydaGkundvqX2cu104wTKle+KRik3X
         UuHvuicxM/8+1oWnBynW4LpdXon2FuwqaA14ENTmQvhXr/rC8JtTiBLelOe/zoj1Q6pI
         Dr4g==
X-Gm-Message-State: AOJu0YwEVIvEVHkbd9xv7e5fPI/lD/8qIOk3U0O5m3e2s5I9VR8yxPNl
	ua6CHeUifGI4Dq0MJ+O9VO1aL/OUqZ183vGk577ZTh3br9W77LaEwi343fjyQzTz
X-Gm-Gg: AR+sD133zhiqKZWl5HkxflXuXN/lbzkI9LffdS2SBwJ74cgNJIjXB5dwgdA4OC0Lx0m
	FLAXUKNpwlmaDWpfg/xD6wXWeLcgvuVvc8//1hP1YnirOtBpwGPbOeOX3Ex2msIgsBTCFVL62eH
	LyBYonlJujWmIIIdVm8xZ7N6ChHEPA+ZyHs2caJV6xJxXWjIjxinqDqj7SoMzZUHi22iqxW5mDa
	4kOu4xa7ykTUSLINdl80/BYjuRznbsL9V3x1DJ3ut2sPQj6fqvCX7WQJwed69TKpoyNhvGqvbD2
	nERsILGHL3O0/XiB4Zz6Zdzjs3RValcmjCSW1Fow06007BRt5gvdxVML2F9xboSSvnVHJmI++fS
	jn8Wh6qzQI+EOgeAbCfuiqm7Ytlu4zB5NrhOvmfGgm+JMeMH2iCoZ2WIkO9tT168BKMrYLZ8z7F
	E0097vYDuXRP+EIpmDbsviIefaMyaxhUPFJJqZ1y99hm2FGPaOnaY/3MwRh5AEbBeOPJsNLvs0K
	+FvqnD2xQcfB+E=
X-Received: by 2002:a05:600c:6305:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-4997c0d7658mr46390285e9.4.1786533137639;
        Wed, 12 Aug 2026 04:12:17 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c9417bcsm54830855e9.4.2026.08.12.04.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:12:17 -0700 (PDT)
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
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next 3/3] selftests/bpf: Test linux_binprm user memory kfuncs
Date: Wed, 12 Aug 2026 14:11:40 +0300
Message-ID: <20260812111140.7762-4-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812111140.7762-1-tasos.papagiannnis@gmail.com>
References: <20260812111140.7762-1-tasos.papagiannnis@gmail.com>
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
contiguous NUL-separated argument data. Then use
bpf_copy_from_user_bprm_str() to read each argument separately,
by advancing the offset based on the returned length.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 .../bpf/prog_tests/copy_from_user_bprm.c      | 52 +++++++++++++
 .../selftests/bpf/progs/copy_from_user_bprm.c | 74 +++++++++++++++++++
 2 files changed, 126 insertions(+)
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
index 000000000000..679363811edc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
@@ -0,0 +1,74 @@
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
+extern int bpf_copy_from_user_bprm(void *dst, u32 dst__sz,
+				   const void *unsafe_ptr__ign,
+					   const struct linux_binprm *bprm,
+					   u64 flags) __ksym;
+
+extern int bpf_copy_from_user_bprm_str(void *dst, u32 dst__sz,
+				       const void *unsafe_ptr__ign,
+					       const struct linux_binprm *bprm,
+					       u64 flags) __ksym;
+
+SEC("lsm.s/bprm_check_security")
+int BPF_PROG(check_exec_args, struct linux_binprm *bprm, int ret)
+{
+	u32 pid = bpf_get_current_pid_tgid() >> 32;
+	char args[sizeof(expected_args)];
+	char arg0[32];
+	char arg1[32];
+
+	if (ret || pid != monitored_pid)
+		return ret;
+
+	bprm_argc = bprm->argc;
+
+	invalid_flags_ret = bpf_copy_from_user_bprm(args, sizeof(args),
+						    (void *)bprm->p, bprm, 1);
+
+	copy_ret = bpf_copy_from_user_bprm(args, sizeof(args),
+					   (void *)bprm->p, bprm, 0);
+	if (copy_ret)
+		return 0;
+
+	args_match = !__builtin_memcmp(args, expected_args, sizeof(expected_args));
+
+	str_arg0_ret = bpf_copy_from_user_bprm_str(arg0, sizeof(arg0),
+						   (void *)bprm->p, bprm,
+						BPF_F_PAD_ZEROS);
+	if (str_arg0_ret != sizeof(expected_arg0))
+		return 0;
+
+	str_arg1_ret = bpf_copy_from_user_bprm_str(arg1, sizeof(arg1),
+						   (void *)(bprm->p + str_arg0_ret),
+						bprm, BPF_F_PAD_ZEROS);
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

