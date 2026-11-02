Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793583056;
	b=4NtdTnw5vJ71a95hWpy+sO+tt7auRT0qg7i9Vwa2f8XzVgulk4ImggdjRyj2r3ipNfcw
	 m9nJokZ5SNN4kwfbkMWkrT1/ilkNma4LJ1qCdqSAILZQSnRmbqnjuPeGvu+XTx3OnFqqB
	 3z/3qtDaJEDrwjEi7uVKXiyzG4O7+X2/bNLb8LPIvORmr/RSsrX880hsTcvIWuAQaepKV
	 4S7wDpp2bdbXTMq0fzXgFgMhINt54guoMxWoKMlzIyB4E4d6yp6X7RPfRG7AjRAGfa6aY
	 NYjEvBgHcD32+b6Du6tOUou0fPsdGa/7e6tMGJZFH3oPIH9Srr7fkWuDxNNjFxRPkeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793583056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RRDf7VPMukbp+PO/uRvCu/Qff7V075PP4S5VqGe4jTI=;
	b=ZxgNEhJElITeyihzhCGCGec6qiFFTrn+OmRC8X8fvlZZUJmCQNFsEE5k2WcfllHRQa7r
	 ICYtidMnDMrMl4oIYdirYwUF+lYGf+kAMhljIfeXLemHEi54nuedBpHylacWstZU4R7Lm
	 jc4CWLJJoPza26RdY4yKC6y7xlb+3oGMJZD/VTfwyz1zXu0HtcMduY8chSXQv6bb3Y5XH
	 YGpfYXAXT6AGznajyF9on4g6DQYhEBZDtibxiwWcLwI3J1tg3Yzhjtn9/FCGzICVyo7IO
	 Atfi4DUJz0ZZYMcXZTj23FrYiB9qKYPEokAaC84BMm9/BTMI+YaNNkKvMOixrvgscZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EQHwRUBr;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130F606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 01:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D130F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EQHwRUBr
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so1781464a91.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 17:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793583055; x=1794187855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RRDf7VPMukbp+PO/uRvCu/Qff7V075PP4S5VqGe4jTI=;
        b=EQHwRUBrEDqwoJCjGxRmvTLvyTtMCt6KeCtAgdHcXdldafon17uo4EgYalX35ZITAN
         L8V5rFlamsUagk22AmiTDdBzOTe7m0iWHiyiL7Ym4U5V8TtlUb1/Rxe4CfJg3Hf0SUYo
         x0S24XhQzBR8vgO06nyh6oEZxKbr18tcnME10zenrm+GJkci74CDjBvOb9OPG/8bzJ81
         nhup7R0uczU5ySpQnpSsyy9k5C0Bc8rRsgzVTtZxAC0+Ux4dWOmfCH/yT7G+dTfCr55a
         mD/VvFX9bHpdSxBf4cGqq9kJ9kbu/h8TZ3bn6ckaIyLln4MoIRzdYLNV2anuA49L+YKq
         19Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793583055; x=1794187855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RRDf7VPMukbp+PO/uRvCu/Qff7V075PP4S5VqGe4jTI=;
        b=PdXwMSW4nAVm5segOlUaI8Bq9j6LgmSs4lC2KqAHld279+csSfMO3uG81a62T8xFnB
         0f6C7zqmSxnpkDy8Ypo9oQF2xHNqkc8n76obdZtxIyxGiula5zOy8D1ZM4LzrQQtBYsG
         /6d2kgMv0HYLSnoi5o5rCOIXLndJoaju+TPHEXMh/L8xdS42CwvCw9w7qvQbHlIFuCQy
         nW5H1hMkHE4YyoBXZOd6CuK2YoNRBkggpMkXRmqHVTrhcdtrGC3gkIwXDkyTwFsmVHFv
         eOyrWme66GLe4zDH02dvrjsWOsQH+JLTcd98XXV8ha1rS9jKzWv0Zsb4phjPz1CqaLeX
         QFrA==
X-Gm-Message-State: APuU4Z9CMCp9oEj1i9xONCUjj+m5mIz/PjdUj3iX0MSyBBxQwbnmSdvj
	ZZUNKd760052hUeY9BEEHstwDDS6ftMhwZprAihAb4bESk+e7C8lTNz0T7jgbQ==
X-Gm-Gg: AYBFou3Xt6pzjBHQQTFjQcMQ9+sf7GRVdnGKB8B65t+imHdmucoII/DzQQd8IGmYfzP
	e1j33p/O7eWX9EqPEQK08apYZ52pqp1u8UKPR5Whw23vZr4OyVTEdbJLIIeTMxcTJEnC2HtZWyj
	BFRmBKy8kl6X4nNgUneCR+3lih/MhKTf8cA1ovyh/ZzVuCCfmQgqkNkp8DmgDav7Q8w//TCaKV1
	oB1xIGwU7grDbTv+Ki0jQfQy60OiyIlhuiQqKPX8vunOyYLoqPBFahy8AKPL31DmQIRZkp8IFct
	3y2vbp8GbDbkdo5jlip4+QxA2ZYa1dNnRnn9+FwVqLjoMnzX/IJsy2PL7Va+NOrKtBwm99BRr4G
	4LjcXC2aQGF7v+QvCXoVk5UGeU/kxp1PGNmayUu8AJkw6GDxuGsR47orJefQ0722dwu8vY+5s3/
	ChM1keahSKkNmsxn11lRJPA2qznLSATlQq16v+KKK7doUfZ7oCqLNxO34STo+35QMo8jcCQu8st
	WJPosjLE5uy67xt1sp9SAAUtxLNiqy6QGDN9PfNjIOapUrhsig0YbfAxquM1FjIGkIYiVrb1V+f
	Igevv/G3thyNPUIzmp+6Rxxbk5CLBExNAqhO5Ct//cS1fjycsBKRQCWQ4yHkuheM5pi8/t6Fr4m
	AnbkgNRL34mT/QxPgWK63U3DoggIVKhGharxvvrCkn/iutkMbHDmolnvF3PeIm8aW2IJBj5xsFQ
	==
X-Received: by 2002:a17:90b:1b0d:b0:3ac:36c7:c144 with SMTP id 98e67ed59e1d1-3ae89776936mr4835304a91.28.1793583054947;
        Sun, 01 Nov 2026 17:30:54 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9bc6f7sm15650559a91.16.2026.11.01.17.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 17:30:54 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	odys.yuan@gmail.com
Subject: [PATCH bpf-next v3 12/13] selftests/bpf: Test jumps around patched instructions
Date: Mon,  2 Nov 2026 01:29:39 +0000
Message-ID: <20261102012940.1756142-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102012940.1756142-1-alexei.starovoitov@gmail.com>
References: <20261102012940.1756142-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qiliang Yuan <odys.yuan@gmail.com>

The verifier queues its patches in a patch list. One commit builds the new
image of the prog and gives each jump a new offset. Test the cases in which
this offset can be incorrect. In most tests the patched insn is 'r0 /= r1',
which gets a patch of 4 insns.

 - A jump to a patched insn lands on the first insn of its patch: forward,
   backward and with gotox.
 - The target of gotox is a ctx load that becomes a load and a mask. A
   patch in front of it changes its index, thus the entry of the insn array
   must move. Each incorrect landing gives a different return value.
 - A jump over patches gets a longer offset. One such jump is in the patch
   of may_goto and leaves its patch.
 - A jump over 8200 patches gets out of range, and the load fails.
 - A backward may_goto goes over 8191 patches. The conditional jump in its
   patch is out of range by 1. The verifier must select 'gotol' when it
   queues the patch, but the offset is final only at the commit. The test
   compares the final offset.

The tests have may_goto as a raw insn. Thus the assembler does not have to
know it. They run as a serial test, because other tests set
net.core.bpf_jit_harden, and the blinding of constants changes the xlated
insns.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   3 +
 .../selftests/bpf/progs/verifier_patch_list.c | 245 ++++++++++++++++++
 2 files changed, 248 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_patch_list.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 386ad81051a9..99f0551c8b59 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -96,6 +96,7 @@
 #include "verifier_netfilter_retcode.skel.h"
 #include "verifier_bpf_fastcall.skel.h"
 #include "verifier_or_jmp32_k.skel.h"
+#include "verifier_patch_list.skel.h"
 #include "verifier_percpu_addr.skel.h"
 #include "verifier_precision.skel.h"
 #include "verifier_prevent_map_lookup.skel.h"
@@ -287,6 +288,8 @@ void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_ctx); }
 void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_retcode); }
 void test_verifier_bpf_fastcall(void)         { RUN(verifier_bpf_fastcall); }
 void test_verifier_or_jmp32_k(void)           { RUN(verifier_or_jmp32_k); }
+/* Serial: the xlated code is another one while another test sets bpf_jit_harden */
+void serial_test_verifier_patch_list(void)    { RUN(verifier_patch_list); }
 void test_verifier_percpu_addr(void)          { RUN(verifier_percpu_addr); }
 void test_verifier_precision(void)            { RUN(verifier_precision); }
 void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map_lookup); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_patch_list.c b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
new file mode 100644
index 000000000000..ffadd723f947
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+/*
+ * bpf_do_misc_fixups() guards each division by a register against division
+ * by zero with a 4 insn patch. Jumps to a patched insn must land on the
+ * first insn of its patch, other jumps must follow the insns they target.
+ *
+ * JITs that need explicit zero extensions, like s390x and riscv64, get one
+ * more insn behind the 'w0 ^= w0' of that patch. The tests that compare such
+ * code don't run there.
+ */
+
+SEC("raw_tp")
+__description("patch list: forward jumps to and over patched insns")
+__arch_x86_64
+__arch_arm64
+__success
+__xlated("0: call")
+__xlated("1: r1 = r0")
+__xlated("2: r0 = 7")
+__xlated("3: if r1 > 0x5 goto pc+1")
+__xlated("4: r0 = 9")
+__xlated("5: if r1 != 0x0 goto pc+2")
+__xlated("6: w0 ^= w0")
+__xlated("7: goto pc+1")
+__xlated("8: r0 /= r1")
+__xlated("9: if r0 > 0x3 goto pc+4")
+__xlated("10: if r1 != 0x0 goto pc+2")
+__xlated("11: w0 ^= w0")
+__xlated("12: goto pc+1")
+__xlated("13: r0 /= r1")
+__xlated("14: exit")
+__naked void patch_list_forward(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = r0;"
+	"r0 = 7;"
+	"if r1 > 5 goto l0_%=;"
+	"r0 = 9;"
+"l0_%=:"
+	"r0 /= r1;"
+	"if r0 > 3 goto l1_%=;"
+	"r0 /= r1;"
+"l1_%=:"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__description("patch list: backward jump to a patched insn")
+__arch_x86_64
+__arch_arm64
+__success
+__xlated("0: call")
+__xlated("1: r1 = r0")
+__xlated("2: r2 = 0")
+__xlated("3: if r1 != 0x0 goto pc+2")
+__xlated("4: w0 ^= w0")
+__xlated("5: goto pc+1")
+__xlated("6: r0 /= r1")
+__xlated("7: r2 += 1")
+__xlated("8: if r2 < 0x3 goto pc-6")
+__xlated("9: exit")
+__naked void patch_list_backward(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = r0;"
+	"r2 = 0;"
+"l0_%=:"
+	"r0 /= r1;"
+	"r2 += 1;"
+	"if r2 < 3 goto l0_%=;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* The jump of may_goto leaves its own patch and crosses another one. */
+SEC("raw_tp")
+__description("patch list: may_goto between patched insns")
+__arch_x86_64
+__arch_arm64
+__success
+__xlated("0: *(u64 *)(r10 -16) = 65535")
+__xlated("1: *(u64 *)(r10 -8) = 0")
+__xlated("2: call")
+__xlated("3: r1 = r0")
+__xlated("4: if r1 != 0x0 goto pc+2")
+__xlated("5: w0 ^= w0")
+__xlated("6: goto pc+1")
+__xlated("7: r0 /= r1")
+__xlated("8: r12 = *(u64 *)(r10 -16)")
+__xlated("9: if r12 == 0x0 goto pc+9")
+__xlated("...")
+__xlated("15: if r1 != 0x0 goto pc+2")
+__xlated("16: w0 ^= w0")
+__xlated("17: goto pc+1")
+__xlated("18: r0 /= r1")
+__xlated("19: exit")
+__naked void patch_list_may_goto(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = r0;"
+	"r0 /= r1;"
+	".8byte %[may_goto];"
+	"r0 /= r1;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1 /* offset */, 0))
+	: __clobber_all);
+}
+
+/*
+ * The conditional jump skips 8200 divisions, which their patches turn into
+ * 32800 insns, too far for its 16-bit offset.
+ */
+SEC("raw_tp")
+__description("patch list: jump pushed out of range by patches")
+__failure __msg("cannot be patched due to 16-bit range")
+__naked void patch_list_jump_out_of_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	if r0 == 0 goto 0f;				\
+	.rept 8200;					\
+	r0 /= r1;					\
+	.endr;						\
+0:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* the JITs that support gotox, as in verifier_gotox.c */
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
+	defined(__TARGET_ARCH_powerpc) || \
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)
+/*
+ * An indirect jump to a patched insn must land on the first insn of its
+ * patch. The load of pkt_type, which is 0, becomes a load and a mask. Behind
+ * the load r0 still has bits of 255, and the result isn't 7.
+ *
+ * mark is 0, which the verifier doesn't know. So the division stays, never
+ * runs, and its patch moves the target by 3 insns. The old index of the target
+ * is the 'goto +1' of that patch, which goes to the exit with 255 in r0.
+ */
+SEC("socket")
+__description("patch list: indirect jump to a patched insn")
+__success __retval(7)
+__load_if_JITed()
+__naked void patch_list_indirect(void)
+{
+	asm volatile ("					\
+	.pushsection .jumptables,\"\",@progbits;	\
+jt0_%=:							\
+	.quad l1_%= - socket;				\
+	.quad l0_%= - socket;				\
+	.size jt0_%=, 16;				\
+	.global jt0_%=;					\
+	.popsection;					\
+	r2 = *(u32 *)(r1 + %[mark]);			\
+	r2 &= 8;					\
+	r3 = jt0_%= ll;					\
+	r3 += r2;					\
+	r3 = *(u64 *)(r3 + 0);				\
+	r0 = 255;					\
+	.8byte %[gotox_r3];				\
+l0_%=:							\
+	r0 /= r2;					\
+	exit;						\
+l1_%=:							\
+	r0 = *(u32 *)(r1 + %[pkt_type]);		\
+	r0 += 7;					\
+	exit;						\
+"	:
+	: __imm_const(mark, offsetof(struct __sk_buff, mark)),
+	  __imm_const(pkt_type, offsetof(struct __sk_buff, pkt_type)),
+	  __imm_insn(gotox_r3, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_3, 0, 0, 0))
+	: __clobber_all);
+}
+#else
+SEC("socket")
+__description("patch list: indirect jump to a patched insn")
+__skip("the JIT does not support gotox")
+__success
+int patch_list_indirect(void)
+{
+	return 0;
+}
+#endif
+
+/*
+ * may_goto jumps back by 8195 insns, by 32768 once each of the 8191
+ * divisions is guarded by a patch of 4 insns. That still fits the 16 bits of
+ * may_goto, but not the jump it expands to, which has to become gotol. Once
+ * the budget runs out, may_goto jumps back with r6 set and the program exits.
+ */
+SEC("raw_tp")
+__description("patch list: backward may_goto expanded to gotol")
+__arch_x86_64
+__arch_arm64
+__success
+__xlated("8: if r6 != 0x0 goto pc-3")
+__xlated("...")
+__xlated("32776: if r12 != 0x0 goto pc+1")
+__xlated("32777: gotol pc-32770")
+__naked void patch_list_may_goto_gotol(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r6 = 0;						\
+	goto 0f;					\
+1:	r0 = 0;						\
+	exit;						\
+0:	if r6 != 0 goto 1b;				\
+	.rept 8191;					\
+	r0 /= r1;					\
+	.endr;						\
+	r2 = 0;						\
+	r6 = 1;						\
+	.8byte %[may_goto];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, -8195 /* offset */, 0))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

