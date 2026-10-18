Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EFA28640B
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 01:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792285388; cv=none; b=qtjAFOHcg8TeBSUyT5HgGQycp9Xk/l+xPkJEz2cUwFgMS1H8YT+rtmYSsBT20ELzkiF2N05JNorJy9IBKd0tlxDINsaKVYjJsHxJEF1YBKmHoY/nbunKiRQICYl1+wd7jF7FVRq7sDU2SFfrto4XXniusTMEPIHiUDHopayxKmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792285388; c=relaxed/simple;
	bh=vfVj6xDUSyJVYthPFvPtXRKBIognCI/1uGH7CshVOio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnB0U1Lrkr76NbqdnTroBChXukUgbS3gNlo4++oMH750X7UwnnvYv5EHdXT90fS1k0xjAtnLX8auaBkeuiRzBSQsSLxqj5Xtr3ZpDvM9X+iIJCG2Yc0YAdx8Pcpf/AItpuQO/8+79BcqkcufYuJzOdvxqLZ2FFV+FQFniFTKLes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqyOnVm3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqyOnVm3"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38759bcd877so623642a91.2
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 18:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792285386; x=1792890186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3TrHXAfAbjO/BfS7Lf91lg3nUbKI9hcTBhHPC9nb+JY=;
        b=TqyOnVm3QGjiaXdgCh3NSDicLjNd/wZs6ytyvGgpoCzx1izSvn9j53lKZ6uElcDkMz
         89gDWujvYwNv+kOJboKFyv3rSDRHystencEwFvH37+eJKu5O5VKNf4VVkCldud/CFm9R
         E+4eni1qpb0nf4soZ04A21JWmJ0e4izmq2y5Ct6fO0Si+4ZrA5I0iRYuJ/zqytcHpWHs
         uqGFUZhCdaY4hk7gdRIfw3s4WhfobPW6G50/sv776ok0I83taAbZaphN2tr84CMyHXnF
         rXSnplf067csFuuZELfhYscIeEQTHqTj4bNl9jM3+Z/EMApZY3i183SUd59k5GXQ6JUD
         Mb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792285386; x=1792890186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3TrHXAfAbjO/BfS7Lf91lg3nUbKI9hcTBhHPC9nb+JY=;
        b=CIAz3Tbl0X0ruLn85lFdwTxpXHRw01Jx4LCUl/aLcSGXxJYtOwMSB7qvhDPy1DxWJK
         5jkSH6+lun7WHHipEYbOQ3xU0zZLetZfAtDa61VtgIyWQokSeOTLLwFaGpevCu1fXrO5
         kTa3xg2CLxB7M61dzaJ+XyZfG7XOvxkQFzpS+ImbPdWpa7fmLTI8hHNFSWakyUKlKglr
         AOovLQItk/8oDWDEjPSeZp/43nDa2od7eEBKUHKpkYw4T9UoSY8RXeO/EOMyQ9n2txcb
         J4r/9nKFZXc9R7Xt/eBCP5nHr3eX6SRuFVP5FcWTqaRGONcHdGImuqgBPb+toD2OJUNW
         TAdQ==
X-Gm-Message-State: AFq9FYKTjyJq9wFY1B8ZG2Xvxyczy8Ljv+izH2MFk1FCNJQjOdBAWVXv
	DGJezH37zFmjul1KbFt9vzgx29xrugvaR3/sKL0udXRATwVEeRzeVbuRJ/BRDw==
X-Gm-Gg: AYBFou0EStV+scP4cDyccnMEu4D7cOPm52bOHyelXZVcdiuzaTFoNfU/QQnQdY2yfsD
	sB7jIluiC8xf2HWpQyKNszuaEdFmUGXntFRmNB2eTwLsvlS3IxuHQhU13POIesEpi0NinmYnxDt
	TTVuyk9LVQL7emqHEUdVYxlAWKBtgU2Rp7svJXAjLX8MWz3IPzZ/Zpu7ifQ+W9L1iPSd2h9y9qC
	gEbf6X1BuAM2QwJlTDXcZI2pD6EFlltMzrphcTkPgAFHKR/x0msy6cUVLf+DVP9yNH/RZwuA+8R
	NWd5HU22NUjC7hM6cuo+Za2wkysEGeDrjYZ909hVkelEuoDFbar0PM29HEzLbS4gx1qcJ5oBccP
	LepDWXLnahc+ka0Cm1SYZJJNO+BqLp6cRx6pqqWrtLwwr6cA8HD+IiHmPh9uWG70OM2jUXfM7zL
	lSiaZz2SereKGpz839xxUG0Z0guAlwCUOSPHMQJZ602c8JXxh5dGx+YkhgJzZy74l/BWEqVVLc9
	3Q1L0DOF/QPVD9Aag0Z7gyE2NSPQ08OIjN5cLlk242np7ELTgnam/SU8QX1JcCR8jF4eRgKwoEL
	3AJ7kjH/ur4R0infsvvR7oTGm35rYAgQ+LLhlsP9nftGyRMpagkiCA==
X-Received: by 2002:a17:90b:4c0d:b0:3aa:f4af:1e16 with SMTP id 98e67ed59e1d1-3acee293046mr3650756a91.7.1792285386243;
        Sat, 17 Oct 2026 18:03:06 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc4972fe6sm10076612a91.15.2026.10.17.18.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 18:03:05 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 3/5] bpf, arm64: Support unwinding via r3
Date: Sun, 18 Oct 2026 01:02:43 +0000
Message-ID: <20261018010246.1643877-4-alexei.starovoitov@gmail.com>
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

r3 is x2. The epilogue doesn't touch it, so say so in
bpf_jit_supports_unwind().

Like x86, replace 'if r3 != 0 goto pad' after a call with an extable entry:

  bpf                         arm64 before                arm64 after
  call inner                  bl inner                    bl inner
  if r3 != 0 goto pad         mov x8, x0                  mov x8, x0
  w0 = w6                     cmp x2, #0                  mov w8, w19
                              b.ne pad
                              mov w8, w19

The callee returns to the pad past 'mov x8, x0'. That's fine: r0 is x8 and
the epilogue of the callee copies it to x0 and leaves x8 as it is.

An exit with r3 != 0 fixes LR in its frame record. With pointer
authentication it's signed with SP at the entry of the prog, which is
FP + 16:

  ldr x17, [x29, #8]
  add x16, x29, #16
  autia1716
  mov x0, x17
  bl bpf_unwind_target
  mov x17, x0
  add x16, x29, #16
  pacia1716
  str x17, [x29, #8]

So the lookup gets an authenticated address, and autiasp in the epilogue
checks the new one. autia1716 and pacia1716 are hints like paciasp and
autiasp: nops when the cpu doesn't have pointer authentication.
RET is not subject to BTI.

The private stack pointer is in a callee saved register. Unlike x86 there
is nothing to undo after the call, so it doesn't get in the way.

Tested in qemu with -cpu max and -cpu cortex-a72, i.e. with and without
pointer authentication.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm64/net/bpf_jit.h      |   2 +
 arch/arm64/net/bpf_jit_comp.c | 110 ++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

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
index 506c4201fec8..9b702930486a 100644
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
@@ -1221,6 +1222,86 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	return 0;
 }
 
+/*
+ * See bpf_jit_unwind_site(). The branch after the call that was just emitted is
+ * not emitted. Remember where it goes. The pad is an index into ctx->offset.
+ */
+static int add_unwind_exentry(struct jit_ctx *ctx, int pad)
+{
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
+	ins_offset = (long)&ctx->ro_image[ctx->idx] - 1 - (long)&ex->insn;
+	if (WARN_ON_ONCE(ins_offset >= 0 || ins_offset < INT_MIN))
+		return -ERANGE;
+
+	/* switch ex to rw buffer for writing */
+	ex = (void *)ctx->image + ((void *)ex - (void *)ctx->ro_image);
+	ex->insn = ins_offset;
+	ex->fixup = (ctx->offset[pad] - ctx->idx) * AARCH64_INSN_SIZE;
+	ex->type = EX_TYPE_BPF;
+
+	ctx->exentry_idx++;
+	return 0;
+}
+
+static u64 bpf_unwind_target(u64 ret_addr)
+{
+	const struct exception_table_entry *e = search_bpf_extables(ret_addr - 1);
+
+	return e ? ret_addr + e->fixup : ret_addr;
+}
+
+/*
+ * Make an exit with r3 != 0 return to the pad.
+ * LR in the frame record is signed with SP at the entry of the prog, which is
+ * FP + 16. The x16/x17 forms are hints like PACIASP: nops without pointer auth.
+ * r0, r2 and r3 are what the caller may look at.
+ */
+static void emit_unwind_ret_addr(struct jit_ctx *ctx, bool look_at_r3)
+{
+	const bool ptr_auth = IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL);
+	const u8 r0 = bpf2a64[BPF_REG_0];
+	const u8 r2 = bpf2a64[BPF_REG_2];
+	const u8 r3 = bpf2a64[BPF_REG_3];
+	__le32 *branch = ctx->image + ctx->idx;
+
+	if (look_at_r3)
+		emit(A64_NOP, ctx);
+
+	emit(A64_PUSH(r0, r2, A64_SP), ctx);
+	emit(A64_PUSH(r3, A64_ZR, A64_SP), ctx);
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
+	emit(A64_POP(r3, A64_ZR, A64_SP), ctx);
+	emit(A64_POP(r0, r2, A64_SP), ctx);
+
+	if (look_at_r3 && ctx->image)
+		*branch = cpu_to_le32(A64_CBZ(1, r3, &ctx->image[ctx->idx] - branch));
+}
+
 static const struct bpf_jit_arg_abi arm64_arg_abi = {
 	.nr_arg_regs		= 8,
 	.even_reg_align		= true,
@@ -1378,6 +1459,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	int off_adj;
 	int ret;
 	bool sign_extend;
+	enum bpf_unwind_exit unw;
 
 	if (bpf_insn_is_indirect_target(env, ctx->prog, i))
 		emit_bti(A64_BTI_J, ctx);
@@ -1781,6 +1863,13 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 			emit_kfunc_arg_moves(ctx, fm);
 		}
 		emit_call(func_addr, ctx);
+		if (bpf_jit_unwind_site(env, ctx->prog, i)) {
+			ret = add_unwind_exentry(ctx, i + 2 + insn[1].off);
+			if (ret)
+				return ret;
+			emit(A64_MOV(1, r0, A64_R(0)), ctx);
+			return 1;
+		}
 		/*
 		 * Call to arch_bpf_timed_may_goto() is emitted by the
 		 * verifier and called with custom calling convention with
@@ -1799,6 +1888,13 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		 * counter and the private stack are callee saved.
 		 */
 		emit(A64_BLR(dst), ctx);
+		if (bpf_jit_unwind_site(env, ctx->prog, i)) {
+			ret = add_unwind_exentry(ctx, i + 2 + insn[1].off);
+			if (ret)
+				return ret;
+			emit(A64_MOV(1, bpf2a64[BPF_REG_0], A64_R(0)), ctx);
+			return 1;
+		}
 		emit(A64_MOV(1, bpf2a64[BPF_REG_0], A64_R(0)), ctx);
 		break;
 	/* tail call */
@@ -1808,6 +1904,9 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		break;
 	/* function return */
 	case BPF_JMP | BPF_EXIT:
+		unw = bpf_jit_unwind_exit(env, ctx->prog, i);
+		if (unw != BPF_EXIT_RETURNS)
+			emit_unwind_ret_addr(ctx, unw == BPF_EXIT_LOOK_AT_R3);
 		/* Optimization: when last instruction is EXIT,
 		   simply fallthrough to epilogue. */
 		if (i == ctx->prog->len - 1)
@@ -2240,6 +2339,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	int body_idx;
 	int exentry_idx;
 	int out_cnt;
+	int i;
 
 	if (!prog->jit_requested)
 		return prog;
@@ -2313,6 +2413,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	build_epilogue(&ctx, was_classic);
 	build_plt(&ctx);
 
+	/* The extra pass doesn't get here, so the count is adjusted once. */
+	for (i = 0; i < prog->len; i++)
+		if (bpf_jit_unwind_site(env, prog, i))
+			prog->aux->num_exentries++;
+
 	extable_align = __alignof__(struct exception_table_entry);
 	extable_size = prog->aux->num_exentries *
 		sizeof(struct exception_table_entry);
@@ -2464,6 +2569,11 @@ bool bpf_jit_supports_kfunc_ret_reg_pair(void)
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

