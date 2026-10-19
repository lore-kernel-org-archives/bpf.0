Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09774356748
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 05:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792387166; cv=none; b=YcFWjySs6Gd3mn2ywlhPPn2zWeJoqPz9EA8/lbM4VxHhAGDYSkujd8PGLaufubD+wzGCltsotTggir4jCnO67BcTqaYQrot0WSy3IAq5BZOo2e+cMWDlw6ZwkOMib+MEaLHOXHFUO6rfDHeKo6hmQ1MkVQhN9WIVumpl7EesMs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792387166; c=relaxed/simple;
	bh=b9B//EOjfaZWHjLttFfk8fwh6gIUnGKWIvXXvPM/mQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwFgm2yJdizOv9Eh+ktFGeOaLMMOD0TRDmpwZUWxKHmUUpzYz1valgp+DHkvoCJy5GLJEgMfzzKkdrWkGKakA8HNBikx90FrBzvYiNVDf7OaHOGaSbsShxugyXdCT16grB7Y0PTnk+42Pm7FbQjSWRq/0evn3eiPOxatpSq0KmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qu7MXD5H; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qu7MXD5H"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a070781f63so80987b3a.1
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 22:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792387157; x=1792991957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LR6tUpHW1GTbsr4lwzML/P7Pql3/IhkEBFcjLdL0vWI=;
        b=qu7MXD5Hiv+UEPeh++U5YXLqygPxh3GPaWtHnlv0zCrAzBWfF4y/KZAhKfX8mzGIQU
         vJoBYYmy0RI6+2Q99IjAVznKcNP0bZyFAVyud3idvyZOwtVgHeiERwPxuyHUQq5NJetf
         REvvARvY4E1KT1fGXcdlJcRI87Yb6WpGdWIZMY4RIa8IcfrLMy1pvOL3moRI7aoHESMC
         UoWoNB9Dgldjv52YK6o6iHwtf6burFnpip6+/ktwZ2rMIpVtHWdvrS+zOX9bxbpW2Xb+
         BpC/SAp7HQPjkpH3Ab5lmV6ivxPmMF/M9s8NO2FMpXCv7Ixj8pWJJw1A3qyhoIgYrSxV
         nsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792387157; x=1792991957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LR6tUpHW1GTbsr4lwzML/P7Pql3/IhkEBFcjLdL0vWI=;
        b=sNvBd9jT6coLorkrqD8aEBboylNtswe/nq50+rv5jGVQau4CoO69iADDMNd1g5mcFI
         pfjP1r4USYbhLCKp+seSH6YKS4VBThzm+5hw3tok/OkYzLNP0s9C8Anmxxoapzuskpaz
         mh7L5FEhq1L8BTkR6dYaYrOsg4qw19/QHbE0169y5NNe0Bs6CG584KYUSr3s8casMClP
         nrHq+C/uzO4Bz+EslevOeWHhlvtHKG2vhinmCINSmmvu1rKg/1obKqO5lNoC6dfC3nK4
         UuC+CCsxdAGsl+JZuI0s3S2KBQq+dWHWzaVyqTpHztcVCVTVyTgnox61X87qVGqTPyNw
         5M6g==
X-Gm-Message-State: AFq9FYIS3WX98ah5dfPmfrkqtZNAcnrxJmwyivuuTT1HzCqGn6lYl6Lv
	w0uN+IPAPEtHuL3qVv51IOra5jyYWKs86C7lFyYEbCnEJoMz4nSAAIKw1175pQ==
X-Gm-Gg: AYBFou2ZpUGwfRKXnzJb4isYeUZzxEoDmdp02PrvFyyeEOTx4BM2dlS1mxoHY5TXcgc
	UOlSo2slDRLiCIvqLbdc4dG0femfS8qctWCs3RPkkh9h9jlrNlbiJsWmH8QWhaA8bu7N8il27f4
	FTf3IfgFh4JorPKNk8Q83DSQspH0alL6GLWJwcqQbUh8MN+LiCdBMIVxdLLN+tdKFahjkff1s9M
	G3/qDSriN1NewAa7aMEqHp34YNOTDXgvBg0JH8csoVHSpcdg5AHmR+S+SBhFLlCheprHJhdb8Ta
	R2aDqlkV0Op+5hxQeRuvqaImRYBaXPXOHYg4FCNRd/fOHyBQACNwW3LKF5MReM5jtBcJpBe5enh
	sc0QFWBZ54KK9vK8DDW0z8RO51V591CRl5uahMYPcIPkeK9m2tdvzz7mE6ue3mPJuZqEJOrML/D
	cNvQwkcneShn3G2SbHRQsrLQo6u9we3rGrg11sk4X6FKGJuUV7unzTSa+3bWrNNgTq5heKkHx8L
	jiBYRz1L3eWWBWd5Q33uu81nUFUOWEc12GUfcnujklwjtDOjnKD1elR/bNZSEgltx0XD3NB+Fhd
	y4C8XtwwSGNcmLRvQRHP7wB5KIg35THc0YAcemI4kd8=
X-Received: by 2002:a05:6a21:6f89:b0:3e2:1f0b:596e with SMTP id adf61e73a8af0-3e225fd9e90mr5277543637.47.1792387156988;
        Sun, 18 Oct 2026 22:19:16 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f54b30b24sm3454563b3a.7.2026.10.18.22.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 22:19:15 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf-next 4/5] selftests/bpf: Add tests for unwind_goto and unwind_exit
Date: Mon, 19 Oct 2026 05:18:45 +0000
Message-ID: <20261019051846.3012089-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019051846.3012089-1-alexei.starovoitov@gmail.com>
References: <20261019051846.3012089-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The tests spell the two insns out as raw insns, so they don't depend on
llvm version.

verifier_unwind:
- A static subprog, a global one and a callee of callx leave either way at
  run time, through one and two frames. The verifier follows a static
  subprog, so the tests derive the argument from skb->len or read it from
  a map.
- r0 of unwind_exit, r6-r9 and the stack are there in the pad. r1-r5
  are not readable.
- A pad is checked like any other code: it has to drop rcu_read_lock.
- How the callee left is a part of the verifier state: two states that
  differ only in that are not pruned.
- The pad of a call of a global subprog is always checked.
- A callee that never returns, and one that never unwinds, where the pad
  goes away.
- unwind_exit without unwind_goto after the call.
- unwind_goto that doesn't follow a call of a subprog or is a jump target.
- Reserved fields.
- A callback cannot unwind. What it calls can.
- Tail call and ld_abs in a subprog that can unwind.
- unwind_exit of the main prog is exit.
- What x86-64 and arm64 JITs emit.
- Private stack. On x86-64 r9 has to be restored on the way to the pad.

The last one has to look at the return value of a prog that uses private
stack. raw_tp is such a prog. Its test_run doesn't take a packet, so let
test_loader run it like it runs syscall progs.

unwind_attach: fentry and freplace are attached to a subprog that unwinds
and the caller is run. fexit is refused.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/unwind_attach.c  |  102 ++
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../selftests/bpf/progs/unwind_attach.c       |   29 +
 .../selftests/bpf/progs/verifier_unwind.c     | 1047 +++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |    3 +-
 5 files changed, 1182 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwind_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_unwind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/unwind_attach.c b/tools/testing/selftests/bpf/prog_tests/unwind_attach.c
new file mode 100644
index 000000000000..cdbf172e13bb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/unwind_attach.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "verifier_unwind.skel.h"
+#include "unwind_attach.skel.h"
+
+#ifndef ENOTSUPP
+#define ENOTSUPP 524
+#endif
+
+static char log_buf[16 * 1024];
+
+static int run(int fd)
+{
+	char data[64] = {};
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = data,
+		.data_size_in = sizeof(data),
+		.repeat = 1,
+	);
+
+	ASSERT_OK(bpf_prog_test_run_opts(fd, &opts), "test_run");
+	return opts.retval;
+}
+
+/*
+ * The target calls global_unwinds(), which unwinds with r0 = 5, and returns
+ * r0 + 10 from the pad.
+ * msg: why it cannot be loaded. Otherwise retval is what the target returns
+ * with the prog attached.
+ */
+static void attach(int tgt_fd, const char *name, const char *msg, int retval)
+{
+	struct bpf_link *link = NULL;
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
+	log_buf[0] = 0;
+	bpf_program__set_log_buf(prog, log_buf, sizeof(log_buf));
+	err = bpf_program__set_attach_target(prog, tgt_fd, "global_unwinds");
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	err = unwind_attach__load(skel);
+	if (msg) {
+		ASSERT_ERR(err, name);
+		ASSERT_HAS_SUBSTR(log_buf, msg, name);
+		goto out;
+	}
+	if (!ASSERT_OK(err, name))
+		goto out;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		goto out;
+	ASSERT_EQ(run(tgt_fd), retval, "retval");
+	if (prog == skel->progs.fentry_unwind)
+		ASSERT_EQ(skel->bss->fentry_cnt, 1, "fentry_cnt");
+out:
+	bpf_link__destroy(link);
+	unwind_attach__destroy(skel);
+}
+
+void test_unwind_attach(void)
+{
+	struct verifier_unwind *tgt;
+	struct bpf_program *prog;
+	int tgt_fd, err;
+
+	tgt = verifier_unwind__open();
+	if (!ASSERT_OK_PTR(tgt, "verifier_unwind__open"))
+		return;
+	bpf_object__for_each_program(prog, tgt->obj)
+		bpf_program__set_autoload(prog, prog == tgt->progs.calls_global_unwinds);
+	err = verifier_unwind__load(tgt);
+	if (err == -ENOTSUPP) {
+		printf("%s:SKIP:JIT does not support unwinding\n", __func__);
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_OK(err, "verifier_unwind__load"))
+		goto out;
+	tgt_fd = bpf_program__fd(tgt->progs.calls_global_unwinds);
+	ASSERT_EQ(run(tgt_fd), 15, "retval");
+
+	attach(tgt_fd, "fentry_unwind", NULL, 15);
+	/* unwind_exit would return to the trampoline */
+	attach(tgt_fd, "fexit_unwind", "Only fentry can attach to global_unwinds", 0);
+	/* An extension doesn't unwind. The caller is ready for that. */
+	attach(tgt_fd, "freplace_unwind", NULL, 9);
+	ASSERT_EQ(run(tgt_fd), 15, "retval");
+out:
+	verifier_unwind__destroy(tgt);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c69c0f7e9cc8..28d06a7f0ec6 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -129,6 +129,7 @@
 #include "verifier_typedef.skel.h"
 #include "verifier_uninit.skel.h"
 #include "verifier_unpriv.skel.h"
+#include "verifier_unwind.skel.h"
 #include "verifier_unpriv_perf.skel.h"
 #include "verifier_value_adj_spill.skel.h"
 #include "verifier_value.skel.h"
@@ -318,6 +319,7 @@ void test_verifier_tailcall_jit(void)         { RUN(verifier_tailcall_jit); }
 void test_verifier_typedef(void)              { RUN(verifier_typedef); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
 void test_verifier_unpriv(void)               { RUN(verifier_unpriv); }
+void test_verifier_unwind(void)               { RUN(verifier_unwind); }
 void test_verifier_unpriv_perf(void)          { RUN(verifier_unpriv_perf); }
 void test_verifier_value_adj_spill(void)      { RUN(verifier_value_adj_spill); }
 void test_verifier_value(void)                { RUN(verifier_value); }
diff --git a/tools/testing/selftests/bpf/progs/unwind_attach.c b/tools/testing/selftests/bpf/progs/unwind_attach.c
new file mode 100644
index 000000000000..c39df02385e4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/unwind_attach.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/* The target is global_unwinds() in verifier_unwind.c */
+
+int fentry_cnt;
+
+SEC("?fentry/global_unwinds")
+int BPF_PROG(fentry_unwind)
+{
+	fentry_cnt++;
+	return 0;
+}
+
+SEC("?fexit/global_unwinds")
+int BPF_PROG(fexit_unwind)
+{
+	return 0;
+}
+
+SEC("?freplace/global_unwinds")
+unsigned long freplace_unwind(void)
+{
+	return 9;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_unwind.c b/tools/testing/selftests/bpf/progs/verifier_unwind.c
new file mode 100644
index 000000000000..a235c6143e10
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_unwind.c
@@ -0,0 +1,1047 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+/*
+ * llvm lowers unwinding to two insns:
+ *   invoke foo unwind pad    call foo; unwind_goto pad
+ *   resume                   unwind_exit
+ * The tests spell them out as raw insns, so they don't depend on llvm version.
+ * The argument of unwind_goto() is the number of insns to skip.
+ */
+#define unwind_goto(off) ".8byte %[insn_unwind_goto_" #off "];"
+#define unwind_exit ".8byte %[insn_unwind_exit];"
+
+#define __imm_unwind_goto(off) \
+	__imm_insn(insn_unwind_goto_##off, \
+		   BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, BPF_UNWIND_GOTO, off, 0))
+#define __imm_unwind_exit \
+	__imm_insn(insn_unwind_exit, \
+		   BPF_RAW_INSN(BPF_JMP | BPF_EXIT, 0, BPF_UNWIND_EXIT, 0, 0))
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
+/* The verifier doesn't know what is in there */
+unsigned long zero;
+unsigned long one = 1;
+
+/*
+ * The verifier follows a static subprog, so it knows which way it leaves when
+ * it knows the argument. To have both ways at run time the tests pass skb->len,
+ * which is 64, or skb->len - 64.
+ *
+ * r1 == 0: returns 7, otherwise unwinds with r0 = 5
+ */
+__naked __noinline __used
+static unsigned long may_unwind(void)
+{
+	asm volatile (
+		"if r1 != 0 goto 1f;"
+		"r0 = 7;"
+		"exit;"
+	"1:"
+		"r0 = 5;"
+		unwind_exit
+		:
+		: __imm_unwind_exit
+	);
+}
+
+/* owns nothing: its pad only carries on */
+__naked __noinline __used
+static unsigned long passes_on(void)
+{
+	asm volatile (
+		"call may_unwind;"
+		unwind_goto(2)
+		"r0 += 1;"
+		"exit;"
+		unwind_exit
+		:
+		: __imm_unwind_goto(2),
+		  __imm_unwind_exit
+	);
+}
+
+__naked __noinline __used
+static unsigned long always_unwinds(void)
+{
+	asm volatile (
+		"r0 = 5;"
+		unwind_exit
+		:
+		: __imm_unwind_exit
+	);
+}
+
+__naked __noinline __used
+static unsigned long never_unwinds(void)
+{
+	asm volatile (
+		"r0 = 7;"
+		"exit;"
+	);
+}
+
+/* Both can unwind. This one returns 7. */
+__naked __noinline __used
+unsigned long global_returns(void)
+{
+	asm volatile (
+		"r1 = %[zero] ll;"
+		"r1 = *(u64 *)(r1 + 0);"
+		"if r1 != 0 goto 1f;"
+		"r0 = 7;"
+		"exit;"
+	"1:"
+		"r0 = 5;"
+		unwind_exit
+		:
+		: __imm_addr(zero),
+		  __imm_unwind_exit
+	);
+}
+
+/* This one unwinds with r0 = 5 */
+__naked __noinline __used
+unsigned long global_unwinds(void)
+{
+	asm volatile (
+		"r1 = %[one] ll;"
+		"r1 = *(u64 *)(r1 + 0);"
+		"if r1 != 0 goto 1f;"
+		"r0 = 7;"
+		"exit;"
+	"1:"
+		"r0 = 5;"
+		unwind_exit
+		:
+		: __imm_addr(one),
+		  __imm_unwind_exit
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
+		unwind_goto(1)
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_unwind_goto(1)
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
+		unwind_goto(1)
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_unwind_goto(1)
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
+		unwind_goto(1)
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+/* unwind_exit returns r0 like exit does */
+SEC("tc")
+__description("unwind: unwind through two frames, r0 reaches the pad")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(15)
+__naked int two_frames_unwind(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"call passes_on;"
+		unwind_goto(1)
+		"exit;"
+		"r0 += 10;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: r6-r9 and the stack are intact in the pad")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(1111)
+__naked int pad_sees_callee_saved(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"r6 = 1;"
+		"r7 = 10;"
+		"r8 = 100;"
+		"r9 = 400;"
+		"*(u64 *)(r10 - 8) = 600;"
+		"call passes_on;"
+		unwind_goto(2)
+		"r0 = 0;"
+		"exit;"
+		"r0 = r6;"
+		"r0 += r7;"
+		"r0 += r8;"
+		"r0 += r9;"
+		"r1 = *(u64 *)(r10 - 8);"
+		"r0 += r1;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_unwind_goto(2)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: r1-r5 are not readable in the pad")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("R3 !read_ok")
+__naked int pad_reads_r3(void)
+{
+	asm volatile (
+		"r3 = 0;"
+		"call always_unwinds;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = r3;"
+		"exit;"
+		:
+		: __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: unwind_exit of the main prog is exit")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(3)
+__naked int main_prog_unwinds(void)
+{
+	asm volatile (
+		"r0 = 3;"
+		unwind_exit
+		:
+		: __imm_unwind_exit
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: unwind_exit of the main prog needs r0")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("R0 !read_ok")
+__naked int main_prog_unwinds_no_r0(void)
+{
+	asm volatile (
+		unwind_exit
+		:
+		: __imm_unwind_exit
+		: __clobber_all
+	);
+}
+
+/* What follows unwind_goto is dead code. unwind_exit still has to find the pad. */
+SEC("tc")
+__description("unwind: the callee never returns")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(42)
+__naked int callee_never_returns(void)
+{
+	asm volatile (
+		"call always_unwinds;"
+		unwind_goto(2)
+		"r0 = 1;"
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_unwind_goto(2)
+		: __clobber_all
+	);
+}
+
+/* The pad is dead code and goes away together with unwind_goto */
+SEC("tc")
+__description("unwind: the callee never unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(7)
+__xlated("0: call pc+1")
+__xlated("1: exit")
+__xlated("2: r0 = 7")
+__xlated("3: exit")
+__naked int callee_never_unwinds(void)
+{
+	asm volatile (
+		"call never_unwinds;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = *(u64 *)(r0 + 0);"
+		"exit;"
+		:
+		: __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: the pad drops what the frame owns")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(42)
+__naked int pad_unlocks(void)
+{
+	asm volatile (
+		"r6 = *(u32 *)(r1 + %[len]);"
+		"call %[bpf_rcu_read_lock];"
+		"r1 = r6;"
+		"call may_unwind;"
+		unwind_goto(3)
+		"call %[bpf_rcu_read_unlock];"
+		"r0 = 0;"
+		"exit;"
+		"call %[bpf_rcu_read_unlock];"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm(bpf_rcu_read_lock),
+		  __imm(bpf_rcu_read_unlock),
+		  __imm_unwind_goto(3)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: the pad is checked like any other code")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("in main prog cannot be used inside bpf_rcu_read_lock-ed region")
+__naked int pad_does_not_unlock(void)
+{
+	asm volatile (
+		"r6 = *(u32 *)(r1 + %[len]);"
+		"call %[bpf_rcu_read_lock];"
+		"r1 = r6;"
+		"call may_unwind;"
+		unwind_goto(3)
+		"call %[bpf_rcu_read_unlock];"
+		"r0 = 0;"
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm(bpf_rcu_read_lock),
+		  __imm(bpf_rcu_read_unlock),
+		  __imm_unwind_goto(3)
+		: __clobber_all
+	);
+}
+
+/* Leaves either way with the same registers */
+__naked __noinline __used
+static unsigned long same_regs(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"if r1 != 0 goto 1f;"
+		"exit;"
+	"1:"
+		unwind_exit
+		:
+		: __imm_unwind_exit
+	);
+}
+
+/*
+ * After the call the two states differ only in the way the callee left.
+ * The second one must not be pruned, or nobody looks at the pad.
+ */
+SEC("tc")
+__description("unwind: the way the callee left is a part of the state")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("R0 invalid mem access 'scalar'")
+__naked int no_pruning_after_the_call(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"call same_regs;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = *(u64 *)(r0 + 0);"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_unwind_goto(1)
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
+		unwind_goto(1)
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: a global subprog unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(15)
+__naked int calls_global_unwinds(void)
+{
+	asm volatile (
+		"call global_unwinds;"
+		unwind_goto(1)
+		"exit;"
+		"r0 += 10;"
+		"exit;"
+		:
+		: __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+/* The verifier doesn't look inside */
+SEC("tc")
+__description("unwind: the pad of a call of a global subprog is always checked")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("R0 invalid mem access 'scalar'")
+__naked int global_pad_is_checked(void)
+{
+	asm volatile (
+		"call global_returns;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = *(u64 *)(r0 + 0);"
+		"exit;"
+		:
+		: __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: no unwind_goto after a call of a global subprog")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("no unwind_goto after the call of global_returns()")
+__naked int global_no_unwind_goto(void)
+{
+	asm volatile (
+		"call global_returns;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: no unwind_goto after a call of a static subprog")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("unwind_exit, but no unwind_goto after the call at insn 1")
+__naked int static_no_unwind_goto(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"call may_unwind;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len))
+		: __clobber_all
+	);
+}
+
+/* The verifier sees that it doesn't get to unwind_exit */
+SEC("tc")
+__description("unwind: no unwind_goto is fine when the callee doesn't unwind")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(7)
+__naked int static_does_not_get_there(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"call may_unwind;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: callx, the callee returns")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(7)
+__naked int callx_returns(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"r1 -= 64;"
+		"r6 = %[may_unwind] ll;"
+		"callx r6;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_addr(may_unwind),
+		  __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: callx, the callee unwinds")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(42)
+__naked int callx_unwinds(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"r6 = %[may_unwind] ll;"
+		"callx r6;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_addr(may_unwind),
+		  __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: unwind_goto after a plain insn")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("unwind_goto at insn 1 doesn't follow a call of a subprog")
+__naked int unwind_goto_after_mov(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		unwind_goto(0)
+		"exit;"
+		:
+		: __imm_unwind_goto(0)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: unwind_goto is the first insn")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("unwind_goto at insn 0 doesn't follow a call of a subprog")
+__naked int unwind_goto_first(void)
+{
+	asm volatile (
+		unwind_goto(0)
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_unwind_goto(0)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: unwind_goto after a call of a helper")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("unwind_goto at insn 1 doesn't follow a call of a subprog")
+__naked int unwind_goto_after_helper(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		unwind_goto(0)
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm_unwind_goto(0)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: unwind_goto after a call of a kfunc")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("unwind_goto at insn 1 doesn't follow a call of a subprog")
+__naked int unwind_goto_after_kfunc(void)
+{
+	asm volatile (
+		"call %[bpf_rcu_read_lock];"
+		unwind_goto(0)
+		"call %[bpf_rcu_read_unlock];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_rcu_read_lock),
+		  __imm(bpf_rcu_read_unlock),
+		  __imm_unwind_goto(0)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: jump to unwind_goto")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__failure __msg("jump to unwind_goto at insn 3")
+__naked int jump_to_unwind_goto(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"if r1 != 0 goto 1f;"
+		"call never_unwinds;"
+	"1:"
+		unwind_goto(0)
+		"exit;"
+		:
+		: __imm_unwind_goto(0)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: reserved fields of unwind_goto")
+__failure __msg("invalid may_goto imm 1")
+__naked int unwind_goto_reserved(void)
+{
+	asm volatile (
+		"call never_unwinds;"
+		".8byte %[bad];"
+		"exit;"
+		:
+		: __imm_insn(bad, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, BPF_UNWIND_GOTO, 0, 1))
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: unknown kind of jcond")
+__failure __msg("invalid may_goto imm 0")
+__naked int jcond_unknown(void)
+{
+	asm volatile (
+		"call never_unwinds;"
+		".8byte %[bad];"
+		"exit;"
+		:
+		: __imm_insn(bad, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, BPF_UNWIND_GOTO + 1, 0, 0))
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("unwind: unknown kind of exit")
+__failure __msg("BPF_EXIT uses reserved fields")
+__naked int exit_unknown(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		".8byte %[bad];"
+		:
+		: __imm_insn(bad, BPF_RAW_INSN(BPF_JMP | BPF_EXIT, 0, BPF_UNWIND_EXIT + 1, 0, 0))
+		: __clobber_all
+	);
+}
+
+/* r1 is the index: unwinds in the second iteration */
+__naked __noinline __used
+static unsigned long cb_unwinds(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"if r1 != 0 goto 1f;"
+		"exit;"
+	"1:"
+		unwind_exit
+		:
+		: __imm_unwind_exit
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
+/* What it calls can unwind as long as it doesn't let it out */
+__naked __noinline __used
+static unsigned long cb_catches(void)
+{
+	asm volatile (
+		"call may_unwind;"
+		unwind_goto(0)
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_unwind_goto(0)
+	);
+}
+
+SEC("tc")
+__description("unwind: callback catches")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(3)
+__naked int callback_catches(void)
+{
+	asm volatile (
+		"r1 = 3;"
+		"r2 = %[cb_catches];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		"exit;"
+		:
+		: __imm_ptr(cb_catches),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
+/* Both leave the subprog like exit does */
+__naked __noinline __used
+static unsigned long does_tail_call(void)
+{
+	asm volatile (
+		"r6 = *(u32 *)(r1 + %[len]);"
+		"r2 = %[prog_array] ll;"
+		"r3 = 0;"
+		"call %[bpf_tail_call];"
+		"r0 = 7;"
+		"if r6 == 64 goto 1f;"
+		unwind_exit
+	"1:"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm(bpf_tail_call),
+		  __imm_addr(prog_array),
+		  __imm_unwind_exit
+	);
+}
+
+SEC("tc")
+__description("unwind: tail call in a subprog that can unwind")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(7)
+__naked int tail_call_in_subprog(void)
+{
+	asm volatile (
+		"call does_tail_call;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+/* The packet is shorter than that: ld_abs leaves the subprog with r0 = 0 */
+__naked __noinline __used
+static unsigned long does_ld_abs(void)
+{
+	asm volatile (
+		"r6 = r1;"
+		"r0 = *(u8 *)skb[1000];"
+		"r0 = 5;"
+		unwind_exit
+		:
+		: __imm_unwind_exit
+	);
+}
+
+SEC("tc")
+__description("unwind: ld_abs in a subprog that can unwind")
+__arch_x86_64
+__arch_arm64
+__load_if_JITed()
+__success __retval(7)
+__naked int ld_abs_in_subprog(void)
+{
+	asm volatile (
+		"call does_ld_abs;"
+		unwind_goto(2)
+		"r0 += 7;"
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_unwind_goto(2)
+		: __clobber_all
+	);
+}
+
+/*
+ * JITs don't emit anything for unwind_goto. It's an extable entry, where
+ * unwind_exit looks its return address up.
+ */
+SEC("tc")
+__description("unwind: jit")
+__success __retval(42)
+__load_if_JITed()
+__arch_x86_64
+__jited("	callq	0x{{.*}}")
+__jited("	movl	$0x7, %eax")
+__jited("...")
+__jited("	movl	$0x5, %eax")
+__jited("	pushq	%rax")
+__jited("	pushq	%rsi")
+__jited("	movq	0x8(%rbp), %rdi")
+__jited("	callq	0x{{.*}}")
+__jited("	movq	%rax, 0x8(%rbp)")
+__jited("	popq	%rsi")
+__jited("	popq	%rax")
+__arch_arm64
+__jited("	bl	{{.*}}")
+__jited("	mov	x8, x0")
+__jited("	mov	x8, #0x7")
+__jited("...")
+__jited("	mov	x8, #0x5")
+__jited("	stp	x8, x1, [sp, #-0x10]!")
+__jited("	ldr	x17, [x29, #0x8]")
+__jited("...")
+__jited("	str	x17, [x29, #0x8]")
+__jited("	ldp	x8, x1, [sp], #0x10")
+__naked int jit(void)
+{
+	asm volatile (
+		"r1 = *(u32 *)(r1 + %[len]);"
+		"call may_unwind;"
+		unwind_goto(2)
+		"r0 = 7;"
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_const(len, offsetof(struct __sk_buff, len)),
+		  __imm_unwind_goto(2)
+		: __clobber_all
+	);
+}
+
+/* r1 == 0: returns 7, otherwise unwinds with r0 = 5 */
+__naked __noinline __used
+static unsigned long may_unwind_big_stack(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 200) = r1;"
+		"if r1 != 0 goto 1f;"
+		"r0 = 7;"
+		"exit;"
+	"1:"
+		"r0 = 5;"
+		unwind_exit
+		:
+		: __imm_unwind_exit
+	);
+}
+
+/*
+ * x86-64 keeps the pointer to the private stack in r9 and saves it around a call.
+ * The value that is read back in the pad is there only when r9 is restored.
+ */
+SEC("raw_tp")
+__description("unwind: private stack, the callee unwinds")
+__success __retval(47)
+__load_if_JITed()
+__arch_x86_64
+__jited("	pushq	%r9")
+__jited("	callq	0x{{.*}}")
+__jited("	popq	%r9")
+__jited("	jmp	L{{.*}}")
+__jited("	popq	%r9")
+__jited("	jmp	L{{.*}}")
+__arch_arm64
+__naked int private_stack_unwinds(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 200) = 42;"
+		"r1 = %[one] ll;"
+		"r1 = *(u64 *)(r1 + 0);"
+		"call may_unwind_big_stack;"
+		unwind_goto(1)
+		"exit;"
+		"r1 = *(u64 *)(r10 - 200);"
+		"r0 += r1;"
+		"exit;"
+		:
+		: __imm_addr(one),
+		  __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+SEC("raw_tp")
+__description("unwind: private stack, the callee returns")
+__success __retval(49)
+__load_if_JITed()
+__arch_x86_64
+__arch_arm64
+__naked int private_stack_returns(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 200) = 42;"
+		"r1 = %[zero] ll;"
+		"r1 = *(u64 *)(r1 + 0);"
+		"call may_unwind_big_stack;"
+		unwind_goto(3)
+		"r1 = *(u64 *)(r10 - 200);"
+		"r0 += r1;"
+		"exit;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(zero),
+		  __imm_unwind_goto(3)
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
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 18d47e925400..824e5912ebcb 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -1546,7 +1546,8 @@ void run_subtest(struct test_loader *tester,
 		}
 
 		err = do_prog_test_run(bpf_program__fd(tprog), &retval,
-				       bpf_program__type(tprog) == BPF_PROG_TYPE_SYSCALL ? true : false,
+				       bpf_program__type(tprog) == BPF_PROG_TYPE_SYSCALL ||
+				       bpf_program__type(tprog) == BPF_PROG_TYPE_RAW_TRACEPOINT,
 				       spec->linear_sz);
 		if (!err && retval != subspec->retval && subspec->retval != POINTER_VALUE) {
 			PRINT_FAIL("Unexpected retval: %d != %d\n", retval, subspec->retval);
-- 
2.55.0

