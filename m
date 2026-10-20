Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520025;
	b=bTbwqJGgf4K2obEjW6AjoDsaWxQn2gDCwIieqJAGjXr0nPSqh4z+ckBZBUFilhgn8mla
	 teBdZoBUxUJ4nG/92TXiGwoqWeftH6g/hgh7ujmMHLUqxkMeHUnbwPz7TxmpjkszHQaht
	 9S+5Ic8GzkOCraMeq1MabtqXZmTCA1AKNS25WZQteuFL482lqBExnGG0FAYpULORsUlfA
	 3rTLiVdBJ9bPN5SETGq0OPjkqcF3reVvKjP6zO1RaLcOiJCwFIgaR97qgZlydkVkNiJ6r
	 dzT9XYVJ8VM8Mk4a0swyPKWSvxxKE5cQkzyayjpkmRZI1MQKv1S+Y8B7kY/lw7yuMow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yT10DJ13ihrJt/+S1ujgqZ9BFhp0KMP1Y7fpV0gmA8k=;
	b=WhDZeY6l1Mx2FVjVKabaUZdPKF2Z0bkud7LczxDsXYXNhW5keJtgwXgknrgvIO98vrRk
	 o48r6fbWATNZNrDTzNOx7WaIm4b//2Yg+8hVgbnCpDwBaPj7dAfrvSH6htO1hw3LuwAks
	 YT8HvNqv/ddCyQIT6o1xdepjYZGwA4s+SkJ+ZYtEU8g8JgiscRSn+W8NT8AGDAySjK9DQ
	 Dz8uZSMRyF6cU4wj7TAXbz5oadqBHmm4YFx/7ity1jpnIB/MnC1yjYv+B5QChswBoLCPJ
	 LCI5DkaoVh0FDAlg2jvgx9BxFJRdZs/8FIQA8MHcfmPkfeLzUroMoBGNvoZwup1WpTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TREXgKpi;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7AA606A31C
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B7AA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TREXgKpi
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so2979151a91.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520024; x=1793124824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yT10DJ13ihrJt/+S1ujgqZ9BFhp0KMP1Y7fpV0gmA8k=;
        b=TREXgKpio0V85vPRH9rRiRxo0WDBohh5AaHTe+fEdSEntwmRBEtEl5/gO8Y9+OjFsp
         FUCLw+/JOw1UXYiF4SWRRZUo4y/wRiPyFkeCe7fFaPAT7TUwv0tV3FK0wzVmGcBJEtU8
         W3LjPBM8cbdqppYv/nMHQS4mFMPmi1z1/3HSGkOJG7KqX5zRBxQkYOOl3VjoqdO9DSqx
         MNbdR1xUGhXgauA1E9m0MghDTn5nRhlVny8l9DPFElymTVUzGiGRZm8F6tamLyz7UVIm
         gI3QhEuOBIzo0HZ7vge/uBg00p+OMAcw2MlKE6Fe8WYhXk+ywW6jLuTXE83pSobwSDSW
         0T2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520024; x=1793124824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yT10DJ13ihrJt/+S1ujgqZ9BFhp0KMP1Y7fpV0gmA8k=;
        b=oLw8SEUGza2FLvwk27j37gQC3RYYmppW/Eav5AunIsM+qWmMjOyt9SoIT3dQe7SzPW
         fb1d9eLQRpsn/QVIjw8636PUr0rpa20wNHvn2FAFydSTw75/EHcuj8AXoW7OLQWdGbL9
         e5yWOmOeGtz8qqQNE7YWIXRW88Lck4tTw89hDfdMWpQwUqSrahCcaWLr9sxOHft02MnS
         D5M/si/3mOck6kpLra0lXTCNV43PsJgEjNPZwnhyIWV8oJr52qhK7QcLzmw/fsCxaKad
         q0qQkGBt2wuU2kmHVQbmm8j94zvPw9Q8EGlbaSAzbQcTUzvBCPSYlC9+8+m4ktz0YV85
         wF7A==
X-Gm-Message-State: AFq9FYIIxSCTbEOGgQHqJz8OyIN0FF1nwdHOagcqxxSRr9rM3ds/AgN3
	zF3syOJSRg/mmJL/jKbwNRnKOVezhFNSOW6ZfSvy4ta601rJ6V43owQJf0WyYA==
X-Gm-Gg: AYBFou3UrcebU4V5RyvOV2AkWRG1APTeJj413N0qEReLwIoQzoUgvR9cmrgDp1yOXl6
	8sV7K0Rhj2xBRun+AiL0iaC/53Pr6nHzRmsesel/lAHXY40QnKoz22b3UoLxdT9j5b4d1C5z7Sk
	iO3wxabJ9q7i68Wj3UtF3YExPv8F5IKo2XpkJ3Qj4+Dx0cMhZZOeS9N1VdNORbh6ZrTdI1hmXm4
	PVEmS9BJJqbCN2mBUQ5UQ2vVQJjsLEMLHcnFg2S34KBosGrpCzHBB2s1ISTEdvX7TQJZMfEc6J6
	cFEnxZoWyTc0e3zHXe5czRxjZCdn3qNdBBHyP1nEiSEq7vsGzzYrqjlvGewHBQjRHiSA1/eBJ7t
	x0vkwXMjwtBvehKYPUOoVH6DFcZTaVODswKVRGN+EXOjPm6l47+Ghcf27lMwXdp7+kU5mnmUupo
	BGfWtNqkKvriCJ/hVyDsc6LoEp+pxClT+xZosedDRqVA1/i15rapmUGox96cTZKe2EWutlt9GkB
	XCG+l5cvpy+lYnhaHPzjFvrLaq3C4x+R2KddiZVAfFct6eETmPPQtYFAaE4NLPC/BmzldhUMAVO
	7xs8CF26tIyf+wH+Z0tkmPCjH99GCpeaoqJHSX+GdXQ=
X-Received: by 2002:a17:90a:e7d2:b0:3ac:a204:aa27 with SMTP id 98e67ed59e1d1-3acef55d72cmr10759222a91.66.1792520024406;
        Tue, 20 Oct 2026 11:13:44 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad803035a1sm612354a91.13.2026.10.20.11.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:13:43 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH v4 bpf-next 3/6] bpf, arm64: Support unwind_goto and unwind_exit
Date: Tue, 20 Oct 2026 18:13:17 +0000
Message-ID: <20261020181320.1284798-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020181320.1284798-1-alexei.starovoitov@gmail.com>
References: <20261020181320.1284798-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

  bpf                         arm64
  call inner                  bl inner
                              mov x8, x0
  unwind_goto pad
  w0 = w6                     mov w8, w19

Like on x86 unwind_goto is an extable entry and no code.
unwind_exit returns to the pad past 'mov x8, x0'. That's fine: r0 is x8,
and the epilogue of the callee copies it to x0 and leaves x8 as it is.

With pointer authentication LR in the frame record is signed. unwind_exit
doesn't sign the address of the pad. It looks up the offset of the pad from
its return address. Then it's the epilogue as it is, and the offset is
added to LR after autiasp:

  stp x8, x1, [sp, #-16]!
  ldr x0, [x29, #8]
  bl bpf_unwind_fixup
  mov x10, x0
  ldp x8, x1, [sp], #16
  ...
  ldp x29, x30, [sp], #16
  mov x0, x8
  autiasp
  add x30, x30, x10
  ret

So LR is authenticated like in exit, and the frame record stays as it is.
bpf_unwind_fixup() strips the signature for the lookup.
RET is not subject to BTI.
r0 and r2 are what a subprog returns, so x8 and x1 are saved around the
lookup.

Like on x86 the offset is 0 when the kernel called the subprog as
a callback, and unwind_exit of the main prog is exit, unless it's
an extension.

The private stack pointer is in a callee saved register. Unlike x86 there
is nothing to undo after the call.

Tested in qemu with -cpu max and -cpu cortex-a72, i.e. with and without
pointer authentication.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 97 +++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 1d5f4cf88d33..b3efe0668e86 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -11,6 +11,7 @@
 #include <linux/bitfield.h>
 #include <linux/bpf.h>
 #include <linux/cfi.h>
+#include <linux/extable.h>
 #include <linux/filter.h>
 #include <linux/memory.h>
 #include <linux/printk.h>
@@ -1044,8 +1045,9 @@ static void __maybe_unused build_bhb_mitigation(struct jit_ctx *ctx)
 	}
 }
 
-static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
+static void build_epilogue(struct jit_ctx *ctx, bool was_classic, bool unwind)
 {
+	const u8 tmp = bpf2a64[TMP_REG_1];
 	const u8 r0 = bpf2a64[BPF_REG_0];
 	const u8 ptr = bpf2a64[TCCNT_PTR];
 
@@ -1073,6 +1075,10 @@ static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
 	if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL))
 		emit(A64_AUTIASP, ctx);
 
+	/* tmp is the offset of the pad, see emit_unwind_exit() */
+	if (unwind)
+		emit(A64_ADD(1, A64_LR, A64_LR, tmp), ctx);
+
 	emit(A64_RET(A64_LR), ctx);
 }
 
@@ -1221,6 +1227,76 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	return 0;
 }
 
+/*
+ * There is no branch for unwind_goto, only an extable entry
+ *   { .insn = ret_addr - 1, .fixup = pad - ret_addr }
+ * where ret_addr is the return address of the call in front of it. unwind_exit
+ * adds .fixup to its LR.
+ * ret_addr - 1, because what follows the call can have an entry of its own.
+ * No insn starts there, so a fault cannot hit the entry.
+ * 'bl foo; mov x8, x0' is in front of unwind_goto. The pad doesn't miss the mov:
+ * r0 is x8 and the epilogue of the callee copies it to x0 and leaves x8 as it is.
+ */
+static int add_unwind_exentry(struct jit_ctx *ctx, int pad)
+{
+	int ret_addr = ctx->idx - 1;
+	struct exception_table_entry *ex;
+	off_t ins_offset;
+
+	if (!ctx->image)
+		/* First pass */
+		return 0;
+
+	if (!ctx->prog->aux->extable ||
+	    WARN_ON_ONCE(ctx->exentry_idx >= ctx->prog->aux->num_exentries))
+		return -EINVAL;
+
+	ex = &ctx->prog->aux->extable[ctx->exentry_idx];
+	ins_offset = (long)&ctx->ro_image[ret_addr] - 1 - (long)&ex->insn;
+	if (WARN_ON_ONCE(ins_offset >= 0 || ins_offset < INT_MIN))
+		return -ERANGE;
+
+	/* switch ex to rw buffer for writing */
+	ex = (void *)ctx->image + ((void *)ex - (void *)ctx->ro_image);
+	ex->insn = ins_offset;
+	ex->fixup = (ctx->offset[pad] - ret_addr) * AARCH64_INSN_SIZE;
+	ex->type = EX_TYPE_BPF;
+
+	ctx->exentry_idx++;
+	return 0;
+}
+
+static long bpf_unwind_fixup(u64 lr)
+{
+	const struct exception_table_entry *e;
+
+	e = search_bpf_extables(ptrauth_strip_kernel_insn_pac(lr) - 1);
+	/*
+	 * The verifier made sure that unwind_goto follows a call in a prog. When
+	 * the kernel called an async or an exception callback, it's exit.
+	 */
+	return e ? e->fixup : 0;
+}
+
+/*
+ * unwind_exit: return to the pad. LR in the frame record is signed. Instead of
+ * signing the address of the pad, let the epilogue authenticate LR as it is and
+ * add the offset of the pad to it. r0 and r2 are returned.
+ */
+static void emit_unwind_exit(struct jit_ctx *ctx)
+{
+	const u8 tmp = bpf2a64[TMP_REG_1];
+	const u8 r0 = bpf2a64[BPF_REG_0];
+	const u8 r2 = bpf2a64[BPF_REG_2];
+
+	emit(A64_PUSH(r0, r2, A64_SP), ctx);
+	emit(A64_LDR64I(A64_R(0), A64_FP, 8), ctx);
+	emit_call((u64)bpf_unwind_fixup, ctx);
+	emit(A64_MOV(1, tmp, A64_R(0)), ctx);
+	emit(A64_POP(r0, r2, A64_SP), ctx);
+	build_epilogue(ctx, false, true);
+}
+
 static const struct bpf_jit_arg_abi arm64_arg_abi = {
 	.nr_arg_regs		= 8,
 	.even_reg_align		= true,
@@ -1806,8 +1882,18 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		if (emit_bpf_tail_call(ctx))
 			return -EFAULT;
 		break;
+	/* unwind_goto. The verifier expanded may_goto. */
+	case BPF_JMP | BPF_JCOND:
+		ret = add_unwind_exentry(ctx, i + 1 + off);
+		if (ret)
+			return ret;
+		break;
 	/* function return */
 	case BPF_JMP | BPF_EXIT:
+		if (bpf_is_unwind_exit(insn) && bpf_prog_can_unwind(ctx->prog)) {
+			emit_unwind_exit(ctx);
+			break;
+		}
 		/* Optimization: when last instruction is EXIT,
 		   simply fallthrough to epilogue. */
 		if (i == ctx->prog->len - 1)
@@ -2312,7 +2398,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		goto out_off;
 
 	ctx.epilogue_offset = ctx.idx;
-	build_epilogue(&ctx, was_classic);
+	build_epilogue(&ctx, was_classic, false);
 	build_plt(&ctx);
 
 	extable_align = __alignof__(struct exception_table_entry);
@@ -2369,7 +2455,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		WARN_ON_ONCE(ctx.idx != ctx.epilogue_offset))
 		goto out_free_hdr;
 
-	build_epilogue(&ctx, was_classic);
+	build_epilogue(&ctx, was_classic, false);
 	build_plt(&ctx);
 
 	/* Extra pass to validate JITed code. */
@@ -2466,6 +2552,11 @@ bool bpf_jit_supports_kfunc_ret_reg_pair(void)
 	return true;
 }
 
+bool bpf_jit_supports_unwind(void)
+{
+	return true;
+}
+
 const struct bpf_jit_arg_abi *bpf_jit_arg_abi(void)
 {
 	return &arm64_arg_abi;
-- 
2.55.0

