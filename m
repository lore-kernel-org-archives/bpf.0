Received: from mail-ej2-f10.google.com (mail-ej2-f10.google.com [74.125.228.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498CE41F5D4
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355334; cv=none; b=NxtEykCJ20q/godJ0WCbKpDfjFT4Lz8gVeMsKCTnvnCxQCq+Zamtnr7GYKTnUJwd/x1x0lE0DHflGoHBpQ4JXqx8xLysed5jvn3J1wrwSQ7TIqJ3t+sw5SgUL9Hwy94VBOootNc0yhz4eikPYUAfMQIz38nc3QooRJOkZ22bjfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355334; c=relaxed/simple;
	bh=S3yEJmUmy7L7zemQR01gNA8HPwRZW8W0BinzN17dwAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIGSt6Zhfyp6R6VNQ+DVOVKXBOdAqProYnjd1Kff/tp4Jrk1536TjAzwN3hf0Pt9bBrxgGmSbwZwJ0ndn2+ZsZjNyS5Vrphm9xzd6bxh1S4H8olBxb10CiGhiEMpxmsM2kAiaFVStaOpsfcOIIBNrZzyzYGt9dNqjUaKsd0gMBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NB8NSPDX; arc=none smtp.client-ip=74.125.228.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB8NSPDX"
Received: by mail-ej2-f10.google.com with SMTP id a640c23a62f3a-c1fd40c88b6so90377766b.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 16:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787355331; x=1787960131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ccrhoMDtdA5tyw6qxnOqDTARDE5sq0aIRp4HGqH9V5A=;
        b=NB8NSPDXa7fR0jVHxi6F+niqNyuWd0CAS0QQEZEoMah6YlJ/iHDLVSeqrveQnOhEZl
         /MdKAo1/BLaJur5VseyosyqupW6S99K/PD0tjUntHt1XQj0OAstQauoxzTQ3+sPgqNTN
         2c7CsIErqJIwUu1qp8eWf3+6KyG9Evdy2yxe09HpYKtS6AEbOcmOeb5AqgNIBAh44WCy
         EtWiirW/4htfJOcX7AUf6HbQ/mh1rtCVuM2miZeGLZC2GM3fGbuxUhVjpAhHqhc9vFhC
         RnmekrdLupZzK9udWB6ivD/jJ4O9i05UWxnHQ+8wSb8THhg2I+d9hjBogMMA9A4jPf/P
         tBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787355331; x=1787960131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ccrhoMDtdA5tyw6qxnOqDTARDE5sq0aIRp4HGqH9V5A=;
        b=VT+0IqIpTA2SNSBzs2xXQdnGNMxEcG1kbHanx9sbLtqMaZZSk5t4Yq4uNeikG9IKw4
         JGJApVlT3S9xBmunDrKK+0k9VJ8Z54tBzJFvB/bP2yCeNIcG/nBIViHhonRq4QWNTyRS
         hwwMoSmoFvQvnyCKcUs2A2lMr74UpB8JZazGuoLNJuSxca19XENv4fXTAnnEoHluzLuY
         S8rObb7IELhA6+I2Nk4zBytfEELLdGpZbMftFvWTDKxIB2d4uWhyPlJPUYuv/0lTNQXi
         M35C41x6cLPcGJ86L9FxPJyyByXAD6juyVRKtwaMLFSV2yaWwd7t5zd6CyKKzpyRU0CB
         u2Fw==
X-Gm-Message-State: AFuF++meOXFAs3QJiuCv+TVzkt1/3yMVN9Welid3SlnGrZO/sac290ya
	5/OCuT4Kvti91ayh1SRIdGuttBLr66DGOa5uEEZwytgMqvbQMoVXHF6qdvjbXVUX
X-Gm-Gg: AR+sD12nrd9zGu21dqjwar+wHgeA3Emk3gLlAv0InIymTMe3wOxLMfUrLAv9v2JPcFv
	5kMhE7QNq/jRhA/sJp/DSVyI7w/hF1+5ql5A41OWpooWsr0Xy4F6L1LJQdohCC9H/jwEH8zz3qD
	IyvoeEcWqYYPQxh5lIoMIEtyWHOeF4W1StESV6tQs56mlYWYZYZEPPY6JU7bCKoVkgy6RZPFYGw
	ecD3ymjS7gGPkwK+tde0MZvnlXivllsOYQ+3Pa8tFvwdIAxI8G9nYoEf1eN6BvbsIV6W81WtInm
	UhlGbRbopnLMNxbv9jvVorGWbuDk/Ar2x4up+Lgkaip/a8inmLkrbr1sT/yDiHuAcDrb7FzFW7X
	n64+Eo6/nKe8EeqlZGb/Q3U76iLT/kt36UaB4eoMrHTLgRkbY0fq6XO3KtD3j+wLJSP0Fyk7FW0
	5vl2P3A7x3GuZFThBz4aE4UGrGlTNHFX2fo7rt/6PR/PssU2pVHF0nv/EVy/k9AT53EfcMIKD+e
	nVL4U9Y9dgc7phu77dLZcgs2l3/Imz84A7ijLvUH7gLBdIntbK8rkX+cbU9D/25IkJVi0TXDqPE
	psv2qZz9ClgQovrFxoZzRvk+GHpelMM/
X-Received: by 2002:a17:907:e1d0:20b0:c20:f864:d480 with SMTP id a640c23a62f3a-c246a6559aemr801665766b.13.1787355331367;
        Fri, 21 Aug 2026 16:35:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b696sm57521166b.7.2026.08.21.16.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:35:31 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 09/14] bpf, loongarch: Convert struct_ops arena arguments in trampolines
Date: Sat, 22 Aug 2026 01:35:03 +0200
Message-ID: <20260821233516.3426127-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821233516.3426127-1-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5624; i=memxor@gmail.com; h=from:subject; bh=S3yEJmUmy7L7zemQR01gNA8HPwRZW8W0BinzN17dwAE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavjQV/ducNm4Wrz4vUaG0VLVoa+2HP8lPMikd/hfgdTN 2zwqD3aUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgImcMGBk2CzjoZS2ZtIP++bt nM5zUuf/COrZ9fvxss6bpm7da+VqXRgZPpi+aVmfG1KY/U7J/7W43/f2RcucfBXX6QX2uFYU2dq xAgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A struct_ops callback receives native kernel addresses from its caller,
but an arena BPF program expects each argument marked with
BTF_FMODEL_ARENA_ARG to be a 32-bit offset from its arena mapping.
LoongArch currently copies the native pointer into the BPF ctx unchanged.

Obtain the mapping base through bpf_tramp_arena_base() and materialize it
in t2 while saving arguments. Copy a marked argument through t1, preserve
a nullable native NULL by branching over the subtraction, and otherwise
subtract the base before clearing the upper 32 bits. Truncating the full
address difference produces the required arena offset.

Walk the function model by argument while maintaining a separate ABI slot
index. This keeps argument flags aligned when an earlier small struct spans
two slots, while preserving the existing register and stack slot layout.
The preceding indirect-trampoline fix supplies the correct stack source
for arguments beyond a0-a7.

bpf_tramp_arena_base() only returns a base for the single-program indirect
trampoline. Assert that such a trampoline cannot call the original
function, which expects unconverted kernel addresses, and advertise the
struct_ops-specific arena argument capability.

Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 73 ++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 12 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 33cabaa7353f..5020414bfd9f 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -288,6 +288,11 @@ bool bpf_jit_supports_arena_kfunc_args(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena_struct_ops_args(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_far_kfunc_call(void)
 {
 	return true;
@@ -1680,21 +1685,55 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
 	return ret;
 }
 
-static void store_args(struct jit_ctx *ctx, int nr_arg_slots, int args_off, bool is_struct_ops)
+/*
+ * Convert an arena kernel address into a 32-bit arena offset while copying it
+ * into the BPF ctx. A nullable argument preserves a native NULL.
+ */
+static void emit_arena_arg_conv(struct jit_ctx *ctx, int dst, int src, bool nullable, int base)
+{
+	if (dst != src)
+		move_reg(ctx, dst, src);
+	if (nullable)
+		emit_insn(ctx, beq, dst, LOONGARCH_GPR_ZERO, 2);
+	emit_insn(ctx, subd, dst, dst, base);
+	emit_zext_32(ctx, dst, true);
+}
+
+static void store_args(struct jit_ctx *ctx, const struct btf_func_model *m, int args_off,
+		       bool is_struct_ops, u64 arena_base)
 {
 	int stack_args_off = is_struct_ops ? 0 : 16;
-	int i;
+	int i, slot = 0;
+
+	if (arena_base)
+		move_imm(ctx, LOONGARCH_GPR_T2, arena_base, false);
 
-	for (i = 0; i < nr_arg_slots; i++) {
-		if (i < LOONGARCH_MAX_REG_ARGS)
-			emit_insn(ctx, std, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_FP, -args_off);
-		else {
-			/* Skip the saved T0 and FP slots for a traced function. */
-			emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP,
-				  stack_args_off + (i - LOONGARCH_MAX_REG_ARGS) * 8);
-			emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -args_off);
+	for (i = 0; i < m->nr_args; i++) {
+		bool arena_arg = arena_base && (m->arg_flags[i] & BTF_FMODEL_ARENA_ARG);
+		bool nullable = m->arg_flags[i] & BTF_FMODEL_NULLABLE_ARG;
+		int slots = round_up(m->arg_size[i], 8) / 8;
+
+		while (slots-- > 0) {
+			int src;
+
+			if (slot < LOONGARCH_MAX_REG_ARGS) {
+				src = LOONGARCH_GPR_A0 + slot;
+			} else {
+				/* Skip the saved T0 and FP slots for a traced function. */
+				emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP,
+					  stack_args_off +
+					  (slot - LOONGARCH_MAX_REG_ARGS) * 8);
+				src = LOONGARCH_GPR_T1;
+			}
+			if (arena_arg) {
+				emit_arena_arg_conv(ctx, LOONGARCH_GPR_T1, src, nullable,
+						    LOONGARCH_GPR_T2);
+				src = LOONGARCH_GPR_T1;
+			}
+			emit_insn(ctx, std, src, LOONGARCH_GPR_FP, -args_off);
+			slot++;
+			args_off -= 8;
 		}
-		args_off -= 8;
 	}
 }
 
@@ -1868,6 +1907,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	struct bpf_tramp_nodes *fexit = &tnodes[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_nodes *fmod_ret = &tnodes[BPF_TRAMP_MODIFY_RETURN];
 	u32 **branches = NULL;
+	u64 arena_base;
 
 	/*
 	 * FP + 8       [ RA to parent func ] return address to parent
@@ -1922,6 +1962,15 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
 		return -ENOTSUPP;
 
+	/*
+	 * An indirect trampoline never calls the original function. Arena
+	 * conversion relies on this because the original takes kernel addresses.
+	 */
+	WARN_ON_ONCE((flags & BPF_TRAMP_F_INDIRECT) &&
+		     (flags & ~(BPF_TRAMP_F_INDIRECT | BPF_TRAMP_F_RET_FENTRY_RET)));
+
+	arena_base = bpf_tramp_arena_base(m, tnodes, flags);
+
 	/* Room of trampoline frame to store return address and frame pointer */
 	stack_size = 16;
 
@@ -2014,7 +2063,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	func_meta = nr_arg_slots;
 	emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -func_meta_off, func_meta);
 
-	store_args(ctx, nr_arg_slots, args_off, is_struct_ops);
+	store_args(ctx, m, args_off, is_struct_ops, arena_base);
 
 	if (bpf_fsession_cnt(tnodes)) {
 		/* clear all session cookies' value */
-- 
2.53.0

