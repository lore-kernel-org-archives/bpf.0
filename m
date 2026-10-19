Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BB847DD44
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 05:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792387153; cv=none; b=UUuOncojuSFlBIFG/+PBAtQW9Ok8bk8RS7Auw1GFX0GvdAzcBBsLqQSjNg4DpsewvXEQaTnP4YWZDT29GkkQSs+wWDwOcOPkOuPDqjkr6dvcDVk+XzcDxoiL06peeOhJ4vOsk7RAsx40M/qKeb0H1958ID4EHNl0X1FYxyzcTBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792387153; c=relaxed/simple;
	bh=yb+V6w84qKEdd3/l3mnNonUYQ/avVgmIu3I+Iskg9V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbVttsp4nITtgTklWbxvsoSxrBJXN/idr4a13hvufxfJ8lWanqQBqFD3nxOgA0aeMLar0HSTmcxmUuMUt3n8lM5ajKld9Yye3QEP6eeH7lR/bOzGWfqNka1Obf0HbdIpMOkix4EYtxE2n6Xxp5z2k5fsMM/5HbxW+izaeGZq3a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5nTF77I; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5nTF77I"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ab4178ee33so1326153a91.3
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 22:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792387150; x=1792991950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3RoG5b5wjoYrblrTNYNazD/N9RtyPx8pVWHbMuXI588=;
        b=T5nTF77IoLP/5ae67J8vNwyREfv5ZdwkHj0zhNB6AjltH26Sd+ln2KJ0Ok7uvjZqqu
         qtznLWTm7dzYqO6wUErTXhfoTbjDPFek6YA8vZnVsQjcUSUEaG4FPm16K7BhtNmGjkio
         BiJcWhLo2Ex41lgL4ecnBI/iVkZDNzMXNu/1oD72G4cTgp7B9RhopFHgvjaIEFXeW44N
         oMEk4xJ81XUvN53cLUI7TqtICMdC1zX1LxCxp80zGRdMfoBWldQdVUkqe8pdXr2OIift
         XVyiFuVXMl+tiO3ujmM1SpR6VCpWrjT+tz+89XfWiIyMIvermZiXp9mYtt/pmSnVDxH2
         y8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792387150; x=1792991950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3RoG5b5wjoYrblrTNYNazD/N9RtyPx8pVWHbMuXI588=;
        b=zqlCtga4d56kbh7POK0E8y0lC2Lk+sF2+m35K+WUcZ88baAYkAQaYPxXqrKRUq8aNe
         eKJpvV49amRXccT74XXJI/uUlWpV5ynvZQxZR7Z95z42lGkaJtRHl5VQyn5i+6OQYsTG
         C4dQfc17gOT5+aTG8eZuTHIDjVjNN1JQex9Q4/xI/TdFOsHXoPJ+LEPISHYVblPeMDlu
         tUEFwTqwDMhMajbGLfu/e8/QIKLbzWkZgBoZFAKqBxy8uOg3W5RE32uzRxyuDdKTB6Ny
         +ROqITnzX74Z6Mzmc8bVM274pfdK5XfjCicOvGWpr8pvN+HcuILJK21mgpfCjifOP/ZJ
         rcvQ==
X-Gm-Message-State: AFq9FYJ7ymBo8AZpmqQ33i61rH6S4vqctlekeQV2irqtAPclLkIiHHyA
	TJ0wo1JJe45TpTF/r+9x/ZixGKTE0QGsX36LPtol7k9avz09DKRnSJzixi+uZQ==
X-Gm-Gg: AYBFou0P18jJutX4bD+zgH4Z6SQld4M5WlOrQwbKbAs6EmYSGSiBKO1Vtud9ejNU9fQ
	Z5KpWLf+HGkLehbkH6exiViRhFXYnB2xci0aC0PrtQKcUWSxJy9ci6emV2/eu9aMYcSJzqWY2un
	gkUGDi5g3TJIKSxChWz0+rLtlsJ9w/vY0OVRaqyfeie4NPSDZMY4mGwNE8n8Pe6eN06YvW/Ubob
	vL0YXWrKJF5e/5lltID6z5e2dvVoVJz4IWyQQYsjtUPFwpiP0YHeqDqCAsw36ZJOlXm/PuLltUc
	l0LBq1nHmvqWm88Zc+3i7DcFdse6tHqIOhUIRtEcZzj61r8S+uZ25IistRhfB/BM/CVxvomITJ9
	+OdbzVgxVdeCJsiGfMu6RjTYdoFnAINNy0efVR/GxPDAMJpPKGiidmjxKdB4wzQH6H7n+LY1XWy
	QgUjkDCfKYOYq8E7sRZm+y1V7CJEA7JTGjO7FXtI339tHSA0heGZcdXysM+M3xIXnitKqZbEWbc
	0FzHaD8IlSbDM1QvIpHNjAmyiLPXfh9erExWw7h/e1uL+6flnr7cxV2m9u+kNWXoZVy3CEINJ76
	2IOr+KtMG9Y1eO7r7q7LHL3uVbSvxN9mCMWTgn+KjRo=
X-Received: by 2002:a17:90b:1343:b0:3ac:8897:7ba4 with SMTP id 98e67ed59e1d1-3acee2939a4mr4931819a91.5.1792387149992;
        Sun, 18 Oct 2026 22:19:09 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad42878d72sm1221156a91.5.2026.10.18.22.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 22:19:09 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf-next 3/5] bpf, arm64: Support unwind_goto and unwind_exit
Date: Mon, 19 Oct 2026 05:18:44 +0000
Message-ID: <20261019051846.3012089-4-alexei.starovoitov@gmail.com>
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

  bpf                         arm64
  call inner                  bl inner
                              mov x8, x0
  unwind_goto pad
  w0 = w6                     mov w8, w19

Like on x86 unwind_goto is an extable entry and no code.
unwind_exit returns to the pad past 'mov x8, x0'. That's fine: r0 is x8,
and the epilogue of the callee copies it to x0 and leaves x8 as it is.

unwind_exit fixes LR in its frame record. With pointer authentication it's
signed with SP at the entry of the prog, which is FP + 16:

  stp x8, x1, [sp, #-16]!
  ldr x17, [x29, #8]
  add x16, x29, #16
  autia1716
  mov x0, x17
  bl bpf_unwind_target
  mov x17, x0
  add x16, x29, #16
  pacia1716
  str x17, [x29, #8]
  ldp x8, x1, [sp], #16

So the lookup gets an authenticated address, and autiasp in the epilogue
checks the new one. autia1716 and pacia1716 are hints like paciasp and
autiasp: nops when the cpu doesn't have pointer authentication.
RET is not subject to BTI.
r0 and r2 are what a subprog returns, so x8 and x1 are saved around the
lookup.

The private stack pointer is in a callee saved register. Unlike x86 there
is nothing to undo after the call.

Tested in qemu with -cpu max and -cpu cortex-a72, i.e. with and without
pointer authentication.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm64/net/bpf_jit.h      |  2 +
 arch/arm64/net/bpf_jit_comp.c | 78 +++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index b2fe6e6dcf44..50029dd9baa6 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -316,6 +316,8 @@
 
 #define A64_PACIASP A64_HINT(AARCH64_INSN_HINT_PACIASP)
 #define A64_AUTIASP A64_HINT(AARCH64_INSN_HINT_AUTIASP)
+#define A64_PACIA1716 A64_HINT(AARCH64_INSN_HINT_PACIA_1716)
+#define A64_AUTIA1716 A64_HINT(AARCH64_INSN_HINT_AUTIA_1716)
 
 /* BTI */
 #define A64_BTI_C  A64_HINT(AARCH64_INSN_HINT_BTIC)
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 506c4201fec8..182463b730b9 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1221,6 +1221,70 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	return 0;
 }
 
+/*
+ * unwind_goto: an entry for bpf_unwind_target(). 'bl foo; mov x8, x0' is in front
+ * of it. The pad doesn't miss the mov: r0 is x8 and the epilogue of the callee
+ * copies it to x0 and leaves x8 as it is.
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
+/*
+ * unwind_exit: fix LR in the frame record. It's signed with SP at the entry of
+ * the prog, which is FP + 16. The x16/x17 forms are hints like PACIASP: nops
+ * without pointer auth. r0 and r2 are returned.
+ */
+static void emit_unwind_ret_addr(struct jit_ctx *ctx)
+{
+	const bool ptr_auth = IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL);
+	const u8 r0 = bpf2a64[BPF_REG_0];
+	const u8 r2 = bpf2a64[BPF_REG_2];
+
+	emit(A64_PUSH(r0, r2, A64_SP), ctx);
+
+	emit(A64_LDR64I(A64_R(17), A64_FP, 8), ctx);
+	if (ptr_auth) {
+		emit(A64_ADD_I(1, A64_R(16), A64_FP, 16), ctx);
+		emit(A64_AUTIA1716, ctx);
+	}
+	emit(A64_MOV(1, A64_R(0), A64_R(17)), ctx);
+	emit_call((u64)bpf_unwind_target, ctx);
+	emit(A64_MOV(1, A64_R(17), A64_R(0)), ctx);
+	if (ptr_auth) {
+		emit(A64_ADD_I(1, A64_R(16), A64_FP, 16), ctx);
+		emit(A64_PACIA1716, ctx);
+	}
+	emit(A64_STR64I(A64_R(17), A64_FP, 8), ctx);
+
+	emit(A64_POP(r0, r2, A64_SP), ctx);
+}
+
 static const struct bpf_jit_arg_abi arm64_arg_abi = {
 	.nr_arg_regs		= 8,
 	.even_reg_align		= true,
@@ -1806,8 +1870,17 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
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
+		/* The caller of the main prog doesn't tell them apart */
+		if (bpf_is_unwind_exit(insn) && bpf_is_subprog(ctx->prog))
+			emit_unwind_ret_addr(ctx);
 		/* Optimization: when last instruction is EXIT,
 		   simply fallthrough to epilogue. */
 		if (i == ctx->prog->len - 1)
@@ -2464,6 +2537,11 @@ bool bpf_jit_supports_kfunc_ret_reg_pair(void)
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

