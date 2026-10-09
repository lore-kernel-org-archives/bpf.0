Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFD435202B
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 02:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514181; cv=none; b=PYpYH2nCASOex3x1jBB5fRvloCQLeOL2QBQANMo4AauRaK0we/hCSMoomu493RHskyco0z5JphRN3t2UXOSobqiFfEvJ4+PgLhvsgGkvPKp3TI5tN7UGPIOXdHG8IvYvKaBq+Al3CP2o2re18SJde+Cj5V6QLg3FH4aImuA9rs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514181; c=relaxed/simple;
	bh=pZ2LQ1mcW19e9zbv6dn1tCsFTO3+3e1BnDlqHRe3oWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Thlh86TusJDpjcHFB102P0xFb8e2o9RUD4yveMswUCbIt9cKFEw00jyTIvqEd7mZIC1RXEwycwFpqkhTzWLwXk1o3qouwaxGxka0iqSqyTVg/MbUijWGZkXgicp8NFmcRu+ajRr9h1FMk9VWGSwbAUvIef9EzId1ViNrZp72VR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hnruczoa; arc=none smtp.client-ip=74.125.231.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hnruczoa"
Received: by mail-oa2-f1.google.com with SMTP id 586e51a60fabf-448a12ddfb4so2893655fac.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 19:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791514178; x=1792118978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yFsPZQMGn5BAWFrELIi38nxVy/jbhNPk/JM7FZWSKto=;
        b=Hnruczoa0FaTx6HtFxZcYIM0nuZFmKPCC/0EiFsctTPe9VJwvMs/LhLmybm9X6UO2A
         jE+ZkE/YhOYolDlyZH4O7GgoH6dKQOejanejMxHN2gZxcSwDMNX35ytHLCJSadQdM6KV
         RGYLbGGthnbp44HBibG7+zYvGRXYqOtP0n2FF1A1qT8lV/vW7wgsWvgx319S8pf7Eszd
         eQHDdQXhDUQXXNkZzL247X4ANw6XfTS5AxQED8sHsGacXhu8/PyCgM7cAnFaXhQ/53HX
         41+FC9n7YYTpvUe4zP+E0lpYRFlkFi5iPFdFiigy3EiL3uOchpEh+q7nwa/3hk3Rq0f4
         OAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791514178; x=1792118978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yFsPZQMGn5BAWFrELIi38nxVy/jbhNPk/JM7FZWSKto=;
        b=GHERZm5PCMb71wEqppNFPPf/HCtEal+alerhiazBaMWQYyXUE3Tkf2X5jsCEUNCtVS
         Ml2INB6tTVBXZmlLsnzbyYZGqZcdp/v3ZzWt4cwjqhBxW4i00cmChjtELw3S1GDd0NI1
         FtM43/1U8BGWCc68gK4nc6WvzW288wkQw43OUv/lQqYKSBdzHf5+tndv77QSkMMLLX6r
         PI3VwWluINlkdTniTRCRpjLUDrkdDXv0MVdLfFY8/MwIO5c+Wy10zX1DMwHLMn8M0rv8
         VGknmfINPIlhvO3bQT5gJWqElMxHBknnKEnLyJNpEdlt7cG5/9k+0gO6QIm90WpxnFvj
         9SAQ==
X-Gm-Message-State: AFq9FYLdrw4lacT7swV0Nh7jtGkbjQ4hempadNQg853Nl+jkqxzD6vqA
	guzfMW+WipRiDu8heZhTnAdU6XYwce+De+gxz6cC5VegetqSkIJLZ6L86GuM/zv0K+I=
X-Gm-Gg: AYBFou0/pARl1HA6waeAW0Yg9UIEqApu30O2mn8mZx3iTLmc53BTP0JeSaHt4LW7XWB
	Jy8Sd5K/ZqmhtX2zrzvKBlEx07ySUEVHiopnnoPrH7o4o8h0pp0v9ifZgCp5xsh0UVdPv85DR5b
	XqxXy/C5a8HJckhmTvHrE+9cnFznxWiyv78cHQtmK6EWRE47D4DU3EHIyVuRBEESNgZMcVpIhKl
	SCjRq1p3bulx19isg0kvEPPAQ0uX8pDLcJcwqTWAayHsNzU5orgjafNhUKL+YJ8frkqTX89Sp3S
	hqwSN1HywjD1nwjjErkrzQmicIjTSIzjFheOVNiOb13Wopa5GJ5WzAMtGcTuQamtM1jBbf3GyTW
	ornF7HufuNHlMcVpHSsWg3h2T0cGXnhay9gTUwkeUYVLfuAR8DHJr3H1PJp7fbgIskaRVKK8BUQ
	lS0zzZC6G+I2Tjh10dxtYYi0KFlRyjCoJ6hhztX6/S1f/bIMiSl/UvvuKis66VWb/ULEifgI8DB
	oeWxmfIE7cUt0UpHo8GaskuVgviOYFLR6kE3RwIwynzvvKJx+DW1/DcSmd2Mu2ANkGDhSOFaYq7
	gWb26Q==
X-Received: by 2002:a05:6871:a844:b0:48f:e107:318b with SMTP id 586e51a60fabf-4a2a88f81f3mr595845fac.43.1791514178445;
        Thu, 08 Oct 2026 19:49:38 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a86317a5sm750913fac.17.2026.10.08.19.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 19:49:37 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Puranjay Mohan <puranjay@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Test PROBE_MEM loads from invalid addresses
Date: Fri,  9 Oct 2026 04:49:23 +0200
Message-ID: <20261009024925.3169077-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009024925.3169077-1-memxor@gmail.com>
References: <20261009024925.3169077-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4672; h=from:subject; bh=pZ2LQ1mcW19e9zbv6dn1tCsFTO3+3e1BnDlqHRe3oWk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetEmEjVzIzTX/7WZh5dXXPf6vCiL4od10UfNjSamwdxvlfJ uSLXUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIl86GZk6Dp6cYvSMjbjtY8Y4gUW+9 XterBX1in7k2nOLiPZLV93mjEyLO3O+fnwz2vvsn0bg8oENl6sYvf/LjAhtjdEyOvZwiQhbgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a test that performs PROBE_MEM loads of three sizes through a
bpf_core_cast() pointer whose value is chosen by userspace: NULL, a low
user address, the last user page, a non-canonical address and, on x86-64,
the vsyscall page and an offset into it. Each load must read zero and the
kernel must survive. A load through the current task pointer checks that
the same loads read real values when the address is valid.

The test passes on kernels that reject the addresses with the JIT's range
check and on kernels that rely on the fault handler; with only the JIT
change of the previous patch applied, the first subtest oopses, which is
what the fault handler change prevents.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/probe_mem_fault.c          | 69 +++++++++++++++++++
 .../selftests/bpf/progs/probe_mem_fault.c     | 41 +++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_mem_fault.c
 create mode 100644 tools/testing/selftests/bpf/progs/probe_mem_fault.c

diff --git a/tools/testing/selftests/bpf/prog_tests/probe_mem_fault.c b/tools/testing/selftests/bpf/prog_tests/probe_mem_fault.c
new file mode 100644
index 000000000000..57a313e35eb6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/probe_mem_fault.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "probe_mem_fault.skel.h"
+
+#if defined(__x86_64__)
+#include <asm/vsyscall.h>
+#endif
+
+/*
+ * Addresses a PROBE_MEM load has to survive. Either the JIT's address check
+ * or the fault handler must turn each load into a zero result.
+ */
+static const struct {
+	const char *name;
+	unsigned long addr;
+} bad_addrs[] = {
+	{ "null", 0 },
+	{ "low_user", 4096 },
+	{ "last_user_page", (1UL << 47) - 4096 },
+	{ "non_canonical", 1UL << 63 },
+#if defined(__x86_64__)
+	{ "vsyscall", VSYSCALL_ADDR },
+	{ "vsyscall_tail", VSYSCALL_ADDR + 0x800 },
+#endif
+};
+
+static void trigger(struct probe_mem_fault *skel, int *runs)
+{
+	skel->bss->val_dw = ~0ULL;
+	skel->bss->val_w = ~0U;
+	skel->bss->val_b = ~0;
+	usleep(1);
+	ASSERT_EQ(skel->bss->runs, ++*runs, "runs");
+}
+
+void test_probe_mem_fault(void)
+{
+	struct probe_mem_fault *skel;
+	int runs = 0, i;
+
+	skel = probe_mem_fault__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	skel->bss->target_pid = getpid();
+	if (!ASSERT_OK(probe_mem_fault__attach(skel), "attach"))
+		goto out;
+
+	/* A valid kernel address is read for real. */
+	skel->bss->use_current_task = true;
+	trigger(skel, &runs);
+	ASSERT_EQ(skel->bss->val_w, getpid(), "pid");
+	ASSERT_NEQ(skel->bss->val_dw, 0, "start_time");
+	ASSERT_NEQ(skel->bss->val_b, 0, "comm");
+
+	skel->bss->use_current_task = false;
+	for (i = 0; i < ARRAY_SIZE(bad_addrs); i++) {
+		if (!test__start_subtest(bad_addrs[i].name))
+			continue;
+		skel->bss->addr = bad_addrs[i].addr;
+		trigger(skel, &runs);
+		ASSERT_EQ(skel->bss->val_dw, 0, "start_time");
+		ASSERT_EQ(skel->bss->val_w, 0, "pid");
+		ASSERT_EQ(skel->bss->val_b, 0, "comm");
+	}
+out:
+	probe_mem_fault__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/probe_mem_fault.c b/tools/testing/selftests/bpf/progs/probe_mem_fault.c
new file mode 100644
index 000000000000..748be45418f5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/probe_mem_fault.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int target_pid;
+bool use_current_task;
+unsigned long addr;
+int runs;
+__u64 val_dw;
+__u32 val_w;
+__u8 val_b;
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int probe_mem_fault(void *ctx)
+{
+	struct task_struct *task;
+	unsigned long p = addr;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+
+	if (use_current_task)
+		p = (unsigned long)bpf_get_current_task_btf();
+	/*
+	 * bpf_core_cast() yields an untrusted pointer, so every load through it
+	 * is a PROBE_MEM load. Whatever the address is, the load must either
+	 * read the field or produce zero; the kernel must not oops.
+	 */
+	task = bpf_core_cast((void *)p, struct task_struct);
+	val_dw = task->start_time;
+	val_w = task->pid;
+	val_b = task->comm[0];
+	runs++;
+	return 0;
+}
-- 
2.53.0-Meta

