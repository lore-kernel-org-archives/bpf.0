Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795829350;
	b=ZQ0l/PT69GWpg63aGWPGO01J5arVGj6l4PM1lJWgfVrcEbUxoHfYVIiyzSBYFSY7doRb
	 k0pMrcEMZ3D2f5nXiAtNIKmX9OLmOByFKfSX8wdeF0uGT3u0EiKXjNmopdDY9DcvsxBVl
	 2YdG55jcPwQ2RnNeRvXwpmz3s4I4YPQ3fWaJRY8rbEVruv19GEW9Zo3MchPSiG3TrNW5g
	 MtGjVHm1K1kyAqejzHnhZAGS/m+YMSj9KOPiiLJr2ljZ/XRmjtzpRCFxVdkYeiURbctlF
	 f6FKImKIpFEU+bLzQDqBYi/j7UkBUQd4K0eUffmJOSOf/HoWuPQtj3aAwOStWM0A37Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795829350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=6ADaLE8jYm8rNT2IAQKAXJepPjBkKDtxdmKU8mc9rGM=;
	b=VkSnhzwyGMCzaPrlDivkMD5yM09pgPIn1ihjxHcCFGP9HHuoyFUkMSnl8xlJ3BfB+7HX
	 IiLWsLXj5rdwwVojsqycDib8XRImPxftZ18LWb1GScudiy2jNy0iHz6X1X8VaxYBk6KKU
	 MLF7MZ93I5xCJXEepXh6bY0L+jKtlKtM/3VpzgGvajErDTvnOT42F9nNf5BSD8SSkBzH4
	 stjxjMiutddSG5FABBNgIyw2A93PVyLwPoGe1W3+a9B9/LlSs9l1/6sJ0kZy6rbrylVzN
	 FXPCHDswNMLhNVQQZNaxGimVJCx1UkB7j0ign4EY5syJWUNibe7SeUxQ7tk1s1Ir+Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DxuxtukL;
	arc=none smtp.remote-ip=74.125.231.75
Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D99606A31F
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 01:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24D99606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DxuxtukL
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-49e2cb73ba3so2882878fac.1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 17:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795829349; x=1796434149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ADaLE8jYm8rNT2IAQKAXJepPjBkKDtxdmKU8mc9rGM=;
        b=DxuxtukLMYwGSh2bMf6A98RlQh8RlguNUqhI0J+brd7HS8PimUS5ixuyEXK57yG03B
         T2PisPzRBcUMYtesQR7NamrxSfLkRXyyCH0O5sGxOIwQT4BqcUGmiKp/qgfjVGVZJ1ol
         4Vl7BYQ8QfD9f84ORFhMsMWOSmvSZg1Ahv7uPBXSxaAMUzov+ulcSJWio4G8pUJXYoiB
         fuTwqJxC2OrDO5HXyyX3IrHUOajE6eMphhMUf2fQBhKMTUpFDsxsgVMw3Uu0Esg/Qxnq
         rUhbrPJEm0C2g3utr7J/9FEwXNDgGK/x3DevhAB48MQ11GE62xrK1b83298LvAt1/78p
         6tRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795829349; x=1796434149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ADaLE8jYm8rNT2IAQKAXJepPjBkKDtxdmKU8mc9rGM=;
        b=cYjdEFjNb9O0HtCm+dxvStOINe4R96FyRqzzUYrEv1l2Pxk8TqZninvuw0X+RvTjmp
         xuaFYLnCZ9u4tI5IVuMblbWyQ60lwkmZ276f+XRWTo3tpd0hCTEGUV2grmI5BTUnwnTT
         as/lxOK/jQ9tvYJwrCgsjUI1wwkveAMWF6bd7iXgxaZPqhIPTQDXnxZg9cCdS0wxD0/a
         RXTX+KsYZldRNkOdDtL3cyWgKHbE6H7hR7Dh9+nmhvt9W57HaawVNuaSB/sfREz4Qbbs
         Krr4Tvmbl7wXBaWubAGjmB6OECfMlgI0bcV0WRKxR3piMSVik1uvxVIPkH0ImgD0n7aK
         B6NQ==
X-Gm-Message-State: APuU4Z/2NQ6u6InOxqB/8UJMXKIx2++VbWiapf1rc/zTkXjwskFLbKT6
	13sEPuQ29Vp9/k8XSvaoKyxTP2wfmb2eFcfFOuTJc0EaJdCjPIllOCST154uvQlJBk8=
X-Gm-Gg: AZFdTZfQY1dAXKC6rVjtHMm0qICWri1xZHW2RZA65J8qGZpwY8+sZ/LP15T32FhfGXO
	mxowL/PYpC0q6RUllNMbmb2SR3PYsY/WAp2KYhA5IjunBqZTMXFo4q4pv5tSx6iS6Wp/98yiZaT
	lot7Rlv90IwhVbkF4GzRYjR84teCqwUOByprzgSBgedEirnvlc0J+tVZg3hpwpa+1nluSiFXxdq
	PvvIVidEcg3LXdso920xJE3/CHeotL4gcvPJt5Lo6d4wuU5nQA0aFpZv0r+EdZGmyQxAbQ1+815
	noVTcyY4gmdMI3/WMnmVCKT2qxZagJbxBN9qPMyQiYVgGfI/yg4cJ/caci4/pPB6kFFNeBUFyZo
	d/wqLmebjHTrO5JYKkwjPMR2uQGDZQngl1/0pl+T6luUgmsFxl0Se4Uth99RzqvK51qMMLp0csQ
	T3Y/ErC7grPLxPNgYsmUo5rQbnnUK2UcVibUZk7qh9wMbL5okv9wo619aqJ+tnCezlIy3zO29V9
	9WuG3onkYwjdJvsR4tjY9aJwjB9bdoiHaSHMYCrqes2JpgZrjd1N/coZ41rEOnmpAKei9wbparx
	Ws/HJjYj7UCDgVS/1SdcLhmnaU0Uo7Mr/oVxdNJt+qduWqOkKnryxXVbkZsSnygpDHiys/zBGW0
	xAtMWahEJISzfj02qLUkT+hjwxP2YRYR+w339EfkbxzCJ73asTWYJig==
X-Received: by 2002:a05:6870:2c8a:b0:4b7:3a4e:e66a with SMTP id 586e51a60fabf-4bc8386b8demr24157788fac.34.1795829349065;
        Fri, 27 Nov 2026 17:29:09 -0800 (PST)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5b07d57csm22307521fac.1.2026.11.27.17.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 17:29:07 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Puranjay Mohan <puranjay@kernel.org>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Test PROBE_MEM loads from invalid addresses
Date: Sat, 28 Nov 2026 02:28:56 +0100
Message-ID: <44a6c33e241845271afd6f9cd5eb16276003f082.1795829324.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <cover.1795829324.git.memxor@gmail.com>
References: <cover.1795829324.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5118; h=from:subject:message-id; bh=lBEd9gswYQp8x9IxA02i2vKePHOg/na7EqogNIBgb3g=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZtLz/fd5cJa5/j7IZKn3wRzez67lZyRtuEVx5/X8pqu13+n 9jzpKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQ0WBn+J4U6Pdv9LuHv7UU8HpzC2T oHmTMe7nXsWS9/eNEB9dVTZjL8z7f9tS55w3w2da29PKeXB75YuF3r6r27DMyajXbf5JZ/ZQQA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a test that performs PROBE_MEM loads of three sizes through a
bpf_core_cast() pointer whose value is chosen by userspace: NULL, a low
user address, the last user page and the guard page of both the four and
five level paging layouts, a non-canonical address and, on x86-64, the
vsyscall page and an offset into it. Each load must read zero and the
kernel must survive. A load through the current task pointer checks that
the same loads read real values when the address is valid. NULL and the low
user address are left out on s390x, which has its lowcore there.

The test passes on kernels that reject the addresses with the JIT's range
check and on kernels that rely on the fault handler. With only the JIT
change applied, the first subtest oopses.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/probe_mem_fault.c          | 77 +++++++++++++++++++
 .../selftests/bpf/progs/probe_mem_fault.c     | 41 ++++++++++
 2 files changed, 118 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_mem_fault.c
 create mode 100644 tools/testing/selftests/bpf/progs/probe_mem_fault.c

diff --git a/tools/testing/selftests/bpf/prog_tests/probe_mem_fault.c b/tools/testing/selftests/bpf/prog_tests/probe_mem_fault.c
new file mode 100644
index 000000000000..9b89864b9ac2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/probe_mem_fault.c
@@ -0,0 +1,77 @@
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
+ * or the fault handler must turn each load into a zero result. The user and
+ * guard page addresses are those of x86-64 with four and five paging levels;
+ * on other kernels they are merely unmapped.
+ */
+static const struct {
+	const char *name;
+	__u64 addr;
+} bad_addrs[] = {
+#if !defined(__s390x__)
+	/* s390x has its lowcore at these addresses, so the loads read it. */
+	{ "null", 0 },
+	{ "low_user", 4096 },
+#endif
+	{ "last_user_page_4l", (1ULL << 47) - 2 * 4096 },
+	{ "guard_page_4l", (1ULL << 47) - 4096 },
+	{ "last_user_page_5l", (1ULL << 56) - 2 * 4096 },
+	{ "guard_page_5l", (1ULL << 56) - 4096 },
+	{ "non_canonical", 1ULL << 63 },
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
index 000000000000..f95db455722e
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
+__u64 addr;
+int runs;
+__u64 val_dw;
+__u32 val_w;
+__u8 val_b;
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int probe_mem_fault(void *ctx)
+{
+	struct task_struct *task;
+	__u64 p = addr;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+
+	if (use_current_task)
+		p = (__u64)bpf_get_current_task_btf();
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
2.53.1-Meta

