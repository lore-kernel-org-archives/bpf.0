Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B517242D89
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 01:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792285395; cv=none; b=OOSXSJu0l2h+8wKZNbaQxvqqXaxn4v/97MnlLV1Qdl1Df5yC5wujRD3HxFu40XYE2RJju0ZQFAEa77jwSiY2uZUv+c7uZVKHxdx+97XF57Yt0BPA/i06JD1zJI/P8dgRspM2XLG3jGC9C5jedZts9uu5Yb8C5yqL4m5EREYZct4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792285395; c=relaxed/simple;
	bh=5a8j3amPlqot+b2YunsCBQhIXWvdQCxBBa760u5CvSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAU0+wCPeaV7cFy2S/tqvKxQYxB7B0udu0SqZx5RtEzdQUt+1HqdRFuYSoimmetJO1aQuXSBuMAwLjVt/edCzN7DIKKXccrthnGCZROUQtaEKPJMTsqsRONwx3ho17jne+lHl/tg1o9i9jOYK+5QDq0yMeEbX9aB/A4+FBd1y5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzPJmi5C; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzPJmi5C"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so1401427a91.1
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 18:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792285392; x=1792890192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6dY2dzAOUngbDQqs/BK4gpOOLVBpIUQf//vo/cpD9HI=;
        b=WzPJmi5CXnKZx0Uwm8lwVXxoJh1JBuN25UX1h2smQzn8cV1bcruFZMjVddRalMWar8
         FFKippzYr16CL1zf75SWp9llxa6x1QYMXy+wAgZ7KTxQr49DvAKwU94DMPGomXMuyPwb
         z04gS/5CmkAOKB+cJhyIMZZeuyug1OL1wQUPdGPZQGlwK6JufUimZSSMATDp+dtrF6HX
         Medobncl2VemYz2B7N4UZ2xmfkfygN5YjE87AapZvUtndgKYR1N45YVleRczABwQfFuV
         QeAy0lvEe+QHcobU1uSfcduZglbYp3ND+lpLJ6X2j8juWUsG0tZxsbrG4RphdiSebptk
         PAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792285392; x=1792890192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6dY2dzAOUngbDQqs/BK4gpOOLVBpIUQf//vo/cpD9HI=;
        b=nXZYx1QcE0IggisQ/S8ev9cIEcHCbc0+bGoB7laOnnTAdlbzi9IMjbGtU+Oev7VN27
         VdSjdnCaa1sbwm3bnZmA6fD0FmCXvekXXzApQ4p7yoFUyRJUC8Vrjp/VhzOi/rMRRkqW
         T2kRrQnQol9OAX2B270vhbOyKT6N82tjt7mM6BQDMcPAdgcF74Fja0WZga4FMe6oTKfB
         pRjlITwZu4PoFJsV4Ed2BqsY+1uL1Ms8uPPaEHS/S5caBGYQFZrGmGFHY9D+oqRLiNQB
         bmSFeeTFrUeLMXvQGJOPVDFBS0vJ5g3/cyLbLoCJwiLV8iEvk8lUcEs5WVAmU4vZ5EPv
         BFuw==
X-Gm-Message-State: AFq9FYKzgBqaNCWZTmVh4rDLArINkLiLLewVwKR+7wDoK7V8onJiCBx9
	20AaPPJBRLyUqqomygid9CyfK0Pn4HHgcJI6qLSx3dIvHfSJDRUtqYUMi1p7pA==
X-Gm-Gg: AYBFou3a4h3ToRFRQbfjgdsEQm13GsQQFUrB6wzExkHGxyeNUYlB5IpLhiQ9theD17f
	c66Z+J58teq1Be974XDIXzCIKYbR/OpKUfKFQWpme8BKp4yRGTRp0nkZHFW10kcx2HhUe4s8Q15
	f5GWmrQ7hq/MHQzmqp0ZSWmUEneqHdd+O4k6rUU2wvCCrlmTYYz0o/t/tmUzM9zWp9VjH3/V0Y6
	y1FlfcFSBO6BpvbPojlp4HWtvM1xIAaLiieZMa1f15hhZtRmBFfeLu2HtkhO8bpgmq7V++2b6+g
	6qBqcsHjZU21GDUqVus01MbVnKE2M3noYxiwzzFgtdlb4z0CEPDQB81gVzbQysqENGwLCGERsY6
	ISeqICMmFcz0jEg3+pTs2KegM3oYQjvRr64VsBW9FxgxFr7bTdmMe8+PGu9H8guOsrNikOeGaj4
	e9LB7y3DD7PpVFQfNndXK5oLtzcCLcZT+M/vJ47wsTbBKgvZEGJB0Sajjk7vZgNjG1K3mGBAPQK
	AvY2jO73vk8/xQP+khSh/qJDd1S/0tGf7Ta3aCxn4aQLpvi4cTWAibfu6wcGodvM1x0bjuFt4Ms
	4FIiaw8PgxjwpAMhTdRXnTotvAhUSZjtUPzfqQ/kntLLMdJ3x+AG1w==
X-Received: by 2002:a17:90b:1d43:b0:3a6:d850:bf16 with SMTP id 98e67ed59e1d1-3acef14bee3mr1939701a91.23.1792285392255;
        Sat, 17 Oct 2026 18:03:12 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94792925sm14478403a91.13.2026.10.17.18.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 18:03:11 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 4/5] selftests/bpf: Add tests for unwinding via r3
Date: Sun, 18 Oct 2026 01:02:44 +0000
Message-ID: <20261018010246.1643877-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018010246.1643877-1-alexei.starovoitov@gmail.com>
References: <20261018010246.1643877-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The tests spell out the insns that llvm emits and put BTF decl_tag "unwind"
on the subprogs by hand, so they don't depend on llvm version.

verifier_unwind:
- r3 of a static and of a global subprog at run time, through one and
  two frames. The verifier removes 'if r3 != 0' when it knows r3, so the
  tests derive it from skb->len.
- A landing pad is checked like any other code: it has to drop
  rcu_read_lock.
- r3 is not readable after a call to a subprog without the tag.
- A subprog with the tag has to exit with a scalar in r3.
- Precision of r3 is tracked into the callee.
- A callback has to exit with r3 == 0.
- Tail call and ld_abs are rejected.
- x86-64 and arm64 JITs don't emit the branch after the call, unless it's
  a jump target, and an exit with r3 != 0 fixes its return address.

unwind_attach: only fentry can attach to a subprog that can unwind.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/unwind_attach.c  |  67 ++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/unwind_attach.c       |  32 +
 .../selftests/bpf/progs/verifier_unwind.c     | 759 ++++++++++++++++++
 4 files changed, 860 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwind_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_unwind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/unwind_attach.c b/tools/testing/selftests/bpf/prog_tests/unwind_attach.c
new file mode 100644
index 000000000000..6927757a15b6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/unwind_attach.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "verifier_unwind.skel.h"
+#include "unwind_attach.skel.h"
+
+/*
+ * A trampoline that calls the subprog and an extension that replaces it don't
+ * keep r3, so only fentry can attach to a subprog that can unwind.
+ */
+static void attach(int tgt_fd, const char *name, bool ok)
+{
+	struct unwind_attach *skel;
+	struct bpf_program *prog;
+	int err;
+
+	skel = unwind_attach__open();
+	if (!ASSERT_OK_PTR(skel, "unwind_attach__open"))
+		return;
+
+	prog = bpf_object__find_program_by_name(skel->obj, name);
+	if (!ASSERT_OK_PTR(prog, name))
+		goto out;
+	bpf_program__set_autoload(prog, true);
+	err = bpf_program__set_attach_target(prog, tgt_fd, "global_unwinds");
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	err = unwind_attach__load(skel);
+	if (ok)
+		ASSERT_OK(err, name);
+	else
+		ASSERT_ERR(err, name);
+out:
+	unwind_attach__destroy(skel);
+}
+
+void test_unwind_attach(void)
+{
+#if defined(__x86_64__) || defined(__aarch64__)
+	struct verifier_unwind *tgt;
+	struct bpf_program *prog;
+	int tgt_fd;
+
+	if (!is_jit_enabled()) {
+		test__skip();
+		return;
+	}
+
+	tgt = verifier_unwind__open();
+	if (!ASSERT_OK_PTR(tgt, "verifier_unwind__open"))
+		return;
+	bpf_object__for_each_program(prog, tgt->obj)
+		bpf_program__set_autoload(prog, prog == tgt->progs.calls_global_unwinds);
+	if (!ASSERT_OK(verifier_unwind__load(tgt), "verifier_unwind__load"))
+		goto out;
+	tgt_fd = bpf_program__fd(tgt->progs.calls_global_unwinds);
+
+	attach(tgt_fd, "fentry_unwind", true);
+	attach(tgt_fd, "fexit_unwind", false);
+	attach(tgt_fd, "fmod_ret_unwind", false);
+	attach(tgt_fd, "freplace_unwind", false);
+out:
+	verifier_unwind__destroy(tgt);
+#else
+	test__skip();
+#endif
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c69c0f7e9cc8..2c15d6251b5a 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -130,6 +130,7 @@
 #include "verifier_uninit.skel.h"
 #include "verifier_unpriv.skel.h"
 #include "verifier_unpriv_perf.skel.h"
+#include "verifier_unwind.skel.h"
 #include "verifier_value_adj_spill.skel.h"
 #include "verifier_value.skel.h"
 #include "verifier_value_illegal_alu.skel.h"
@@ -319,6 +320,7 @@ void test_verifier_typedef(void)              { RUN(verifier_typedef); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
 void test_verifier_unpriv(void)               { RUN(verifier_unpriv); }
 void test_verifier_unpriv_perf(void)          { RUN(verifier_unpriv_perf); }
+void test_verifier_unwind(void)               { RUN(verifier_unwind); }
 void test_verifier_value_adj_spill(void)      { RUN(verifier_value_adj_spill); }
 void test_verifier_value(void)                { RUN(verifier_value); }
 void test_verifier_value_illegal_alu(void)    { RUN(verifier_value_illegal_alu); }
diff --git a/tools/testing/selftests/bpf/progs/unwind_attach.c b/tools/testing/selftests/bpf/progs/unwind_attach.c
new file mode 100644
index 000000000000..269d349139fc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/unwind_attach.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/* The target is global_unwinds() in verifier_unwind.c */
+
+SEC("?fentry/global_unwinds")
+int BPF_PROG(fentry_unwind)
+{
+	return 0;
+}
+
+SEC("?fexit/global_unwinds")
+int BPF_PROG(fexit_unwind)
+{
+	return 0;
+}
+
+SEC("?fmod_ret/global_unwinds")
+int BPF_PROG(fmod_ret_unwind)
+{
+	return 0;
+}
+
+SEC("?freplace/global_unwinds")
+unsigned long freplace_unwind(void)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_unwind.c b/tools/testing/selftests/bpf/progs/verifier_unwind.c
new file mode 100644
index 000000000000..18b4774f4292
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_unwind.c
@@ -0,0 +1,759 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/*
+ * llvm lowers unwinding to plain insns:
+ *   ret                      r3 = 0; exit
+ *   invoke foo unwind pad    call foo; if r3 != 0 goto pad
+ *   resume                   r0 = 0; r3 = 1; exit
+ * and puts this tag on the functions that say something in r3.
+ * The tests spell the insns out, so they don't depend on llvm version.
+ */
+#define __unwind __attribute__((btf_decl_tag("unwind")))
+
+extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} prog_array SEC(".maps");
+
+/*
+ * The verifier removes 'if r3 != 0' when it knows r3. To have it at run time
+ * the tests pass skb->len, which is 64, or skb->len - 64.
+ *
+ * r1 == 0: returns 7, otherwise unwinds
+ */
+__naked __noinline __used __unwind
+static unsigned long may_unwind(void)
+{
+	asm volatile (
+		"if r1 != 0 goto 1f;"
+		"r0 = 7;"
+		"r3 = 0;"
+		"exit;"
+	"1:"
+		"r0 = 0;"
+		"r3 = 1;"
+		"exit;"
+	);
+}
+
+/* owns nothing: its pad only resumes */
+__naked __noinline __used __unwind
+static unsigned long passes_on(void)
+{
+	asm volatile (
+		"call may_unwind;"
+		"if r3 != 0 goto 1f;"
+		"r0 += 1;"
+		"r3 = 0;"
+		"exit;"
+	"1:"
+		"r0 = 0;"
+		"r3 = 1;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used __unwind
+unsigned long global_returns(void)
+{
+	asm volatile (
+		"r0 = 7;"
+		"r3 = 0;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used __unwind
+unsigned long global_unwinds(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"r3 = 1;"
+		"exit;"
+	);
+}
+
+SEC("tc")
+__description("unwind: the callee returns")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(7)
+__naked int callee_returns(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"r1 -= 64;"
+		"call may_unwind;"
+		"if r3 != 0 goto 1f;"
+		"exit;"
+	"1:"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len))
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: the callee unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(42)
+__naked int callee_unwinds(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"call may_unwind;"
+		"if r3 != 0 goto 1f;"
+		"exit;"
+	"1:"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len))
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: return through two frames")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(8)
+__naked int two_frames_return(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"r1 -= 64;"
+		"call passes_on;"
+		"if r3 != 0 goto 1f;"
+		"exit;"
+	"1:"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len))
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: unwind through two frames")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(42)
+__naked int two_frames_unwind(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"call passes_on;"
+		"if r3 != 0 goto 1f;"
+		"exit;"
+	"1:"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len))
+		: __clobber_all
+	);
+}
+
+/* 'if r3 != 0' makes r3 precise. The chain goes into the callee through its exit. */
+SEC("tc")
+__description("unwind: precision of r3 is tracked into the callee")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r3 stack= before 12: (95) exit")
+__msg("mark_precise: frame1: regs=r3 stack= before 11: (b7) r3 = 1")
+__naked int r3_precision(void)
+{
+	asm volatile (
+		"r1 = 1;"
+		"call may_unwind;"
+		"if r3 != 0 goto 1f;"
+		"exit;"
+	"1:"
+		"r0 = 42;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: the pad drops what the frame owns")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success
+__naked int pad_unlocks(void)
+{
+	asm volatile (
+		"call %[bpf_rcu_read_lock];"
+		"call %[bpf_get_prandom_u32];"
+		"r1 = r0;"
+		"call may_unwind;"
+		"if r3 != 0 goto 1f;"
+		"call %[bpf_rcu_read_unlock];"
+		"r0 = 0;"
+		"exit;"
+	"1:"
+		"call %[bpf_rcu_read_unlock];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_rcu_read_lock),
+		  __imm(bpf_rcu_read_unlock),
+		  __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: the pad is checked like any other code")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_rcu_read_lock-ed region")
+__naked int pad_forgets_to_unlock(void)
+{
+	asm volatile (
+		"call %[bpf_rcu_read_lock];"
+		"call %[bpf_get_prandom_u32];"
+		"r1 = r0;"
+		"call may_unwind;"
+		"if r3 != 0 goto 1f;"
+		"call %[bpf_rcu_read_unlock];"
+	"1:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_rcu_read_lock),
+		  __imm(bpf_rcu_read_unlock),
+		  __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+/* The verifier doesn't look into a global subprog at the call: it may unwind. */
+SEC("tc")
+__description("unwind: r3 is unknown after a call to a global subprog")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_rcu_read_lock-ed region")
+__naked int global_pad_forgets_to_unlock(void)
+{
+	asm volatile (
+		"call %[bpf_rcu_read_lock];"
+		"call global_returns;"
+		"if r3 != 0 goto 1f;"
+		"call %[bpf_rcu_read_unlock];"
+	"1:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_rcu_read_lock),
+		  __imm(bpf_rcu_read_unlock)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: a global subprog returns")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(7)
+__naked int calls_global_returns(void)
+{
+	asm volatile (
+		"call global_returns;"
+		"if r3 != 0 goto 1f;"
+		"exit;"
+	"1:"
+		"r0 = 42;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: a global subprog unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(42)
+__naked int calls_global_unwinds(void)
+{
+	asm volatile (
+		"call global_unwinds;"
+		"if r3 != 0 goto 1f;"
+		"exit;"
+	"1:"
+		"r0 = 42;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+__naked __noinline __used
+static unsigned long no_tag(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"r3 = 0;"
+		"exit;"
+	);
+}
+
+SEC("tc")
+__description("unwind: r3 is not readable after a call to a subprog without the tag")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("R3 !read_ok")
+__naked int callee_has_no_tag(void)
+{
+	asm volatile (
+		"call no_tag;"
+		"if r3 != 0 goto 1f;"
+	"1:"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+__naked __noinline __used __unwind
+static unsigned long r3_not_set(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+SEC("tc")
+__description("unwind: static subprog doesn't set r3")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("R3 !read_ok")
+__naked int static_r3_not_set(void)
+{
+	asm volatile (
+		"call r3_not_set;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+__naked __noinline __used __unwind
+static unsigned long r3_is_pointer(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"r3 = r10;"
+		"exit;"
+	);
+}
+
+SEC("tc")
+__description("unwind: static subprog leaves a pointer in r3")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("At subprogram exit the register R3 is not a scalar value (fp)")
+__naked int static_r3_is_pointer(void)
+{
+	asm volatile (
+		"call r3_is_pointer;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+__naked __noinline __used __unwind
+unsigned long global_r3_not_set(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+SEC("tc")
+__description("unwind: global subprog doesn't set r3")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("R3 !read_ok")
+__naked int calls_global_r3_not_set(void)
+{
+	asm volatile (
+		"call global_r3_not_set;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+__naked __noinline __used __unwind
+unsigned long global_r3_is_pointer(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"r3 = r10;"
+		"exit;"
+	);
+}
+
+SEC("tc")
+__description("unwind: global subprog leaves a pointer in r3")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("At subprogram exit the register R3 is not a scalar value (fp)")
+__naked int calls_global_r3_is_pointer(void)
+{
+	asm volatile (
+		"call global_r3_is_pointer;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/* The helper that calls a callback doesn't look at r3. */
+__naked __noinline __used __unwind
+static unsigned long cb_returns(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"r3 = 0;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used __unwind
+static unsigned long cb_unwinds(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"r3 = 1;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used __unwind
+static unsigned long cb_r3_not_set(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+SEC("tc")
+__description("unwind: callback returns")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(3)
+__naked int callback_returns(void)
+{
+	asm volatile (
+		"r1 = 3;"
+		"r2 = %[cb_returns];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		"exit;"
+		:
+		: __imm_ptr(cb_returns),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
+SEC("tc")
+__description("unwind: callback unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("callback cannot unwind")
+__naked int callback_unwinds(void)
+{
+	asm volatile (
+		"r1 = 3;"
+		"r2 = %[cb_unwinds];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		"exit;"
+		:
+		: __imm_ptr(cb_unwinds),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
+SEC("tc")
+__description("unwind: callback doesn't set r3")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("callback cannot unwind")
+__naked int callback_r3_not_set(void)
+{
+	asm volatile (
+		"r1 = 3;"
+		"r2 = %[cb_r3_not_set];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		"exit;"
+		:
+		: __imm_ptr(cb_r3_not_set),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
+/* Both return to the caller of the subprog with whatever is in r3. */
+__naked __noinline __used __unwind
+static unsigned long does_tail_call(void)
+{
+	asm volatile (
+		"r2 = %[prog_array] ll;"
+		"r3 = 0;"
+		"call %[bpf_tail_call];"
+		"r0 = 0;"
+		"r3 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_tail_call),
+		  __imm_addr(prog_array)
+	);
+}
+
+SEC("tc")
+__description("unwind: tail call in a subprog that can unwind")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("tail call or ld_abs in a subprog that can unwind")
+__naked int tail_call_in_subprog(void)
+{
+	asm volatile (
+		"call does_tail_call;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+__naked __noinline __used __unwind
+static unsigned long does_ld_abs(void)
+{
+	asm volatile (
+		"r6 = r1;"
+		"r0 = *(u8*)skb[0];"
+		"r3 = 0;"
+		"exit;"
+	);
+}
+
+SEC("tc")
+__description("unwind: ld_abs in a subprog that can unwind")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("tail call or ld_abs in a subprog that can unwind")
+__naked int ld_abs_in_subprog(void)
+{
+	asm volatile (
+		"call does_ld_abs;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/*
+ * JITs don't emit 'if r3 != 0 goto pad' after a call. It becomes an extable entry.
+ * An exit with r3 != 0 looks its return address up there.
+ */
+SEC("tc")
+__description("unwind: jit: no branch after the call")
+__success __retval(42)
+__load_if_JITed()
+__arch_x86_64
+__jited("	callq	0x{{.*}}")
+__jited("	movl	$0x7, %eax")
+__jited("...")
+__jited("	movl	$0x1, %edx")
+__jited("	pushq	%rax")
+__jited("	pushq	%rsi")
+__jited("	pushq	%rdx")
+__jited("	movq	0x8(%rbp), %rdi")
+__jited("	callq	0x{{.*}}")
+__jited("	movq	%rax, 0x8(%rbp)")
+__jited("	popq	%rdx")
+__jited("	popq	%rsi")
+__jited("	popq	%rax")
+__arch_arm64
+__jited("	bl	{{.*}}")
+__jited("	mov	x8, x0")
+__jited("	mov	x8, #0x7")
+__jited("...")
+__jited("	mov	x2, #0x1")
+__jited("	stp	x8, x1, [sp, #-0x10]!")
+__jited("	stp	x2, xzr, [sp, #-0x10]!")
+__jited("	ldr	x17, [x29, #0x8]")
+__jited("...")
+__jited("	str	x17, [x29, #0x8]")
+__jited("	ldp	x2, xzr, [sp], #0x10")
+__jited("	ldp	x8, x1, [sp], #0x10")
+__naked int jit_no_branch(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"call may_unwind;"
+		"if r3 != 0 goto 1f;"
+		"r0 = 7;"
+		"exit;"
+	"1:"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len))
+		: __clobber_all
+	);
+}
+
+/* The exit cannot tell what is in r3 */
+__naked __noinline __used __unwind
+static unsigned long r3_from_r1(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"r3 = r1;"
+		"exit;"
+	);
+}
+
+SEC("tc")
+__description("unwind: jit: exit looks at r3, returns")
+__success __retval(7)
+__load_if_JITed()
+__arch_x86_64
+__jited("	movq	%rdi, %rdx")
+__jited("	testq	%rdx, %rdx")
+__jited("	je	{{.*}}")
+__jited("	pushq	%rax")
+__arch_arm64
+__jited("	mov	x2, x0")
+__jited("	cbz	x2, {{.*}}")
+__jited("	stp	x8, x1, [sp, #-0x10]!")
+__naked int jit_exit_looks_at_r3_returns(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"r1 -= 64;"
+		"call r3_from_r1;"
+		"if r3 != 0 goto 1f;"
+		"r0 = 7;"
+		"exit;"
+	"1:"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len))
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: jit: exit looks at r3, unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(42)
+__naked int jit_exit_looks_at_r3_unwinds(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"call r3_from_r1;"
+		"if r3 != 0 goto 1f;"
+		"r0 = 7;"
+		"exit;"
+	"1:"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len))
+		: __clobber_all
+	);
+}
+
+/* Something else jumps to the branch, so it has to be there */
+SEC("tc")
+__description("unwind: jit: the branch is a jump target")
+__success
+__load_if_JITed()
+__arch_x86_64
+__jited("	movl	$0x1, %edi")
+__jited("	callq	0x{{.*}}")
+__jited("{{.*}}	testq	%rdx, %rdx")
+__jited("	jne	{{.*}}")
+__arch_arm64
+__jited("	mov	x0, #0x1")
+__jited("	bl	{{.*}}")
+__jited("	mov	x8, x0")
+__jited("{{.*}}	cmp	x2, #0x0")
+__jited("	b.ne	{{.*}}")
+__naked int jit_branch_is_jump_target(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r3 = 0;"
+		"if r0 == 0 goto 2f;"
+		"r1 = 1;"
+		"call may_unwind;"
+	"2:"
+		"if r3 != 0 goto 1f;"
+		"r0 = 7;"
+		"exit;"
+	"1:"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+/*
+ * BTF FUNC records are not generated for kfuncs referenced
+ * from inline assembly. These records are necessary for
+ * libbpf to link the program. The function below is a hack
+ * to ensure that BTF FUNC records are generated.
+ */
+void __kfunc_btf_root(void)
+{
+	bpf_rcu_read_lock();
+	bpf_rcu_read_unlock();
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

