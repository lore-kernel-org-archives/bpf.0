Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C883C37A2
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152861; cv=none; b=mfbpGXAN4kFwkHN+AO+He1usjR+aJAk19MVVWRhTCLsfESll8PTKahydIC1MLYnx+Tq4EZ3GDnBvVNxVvmTj7X2MDpqtDKAaDOW7DBIFWGNWmwdeRQImf+w/sLcIu8laqix69AWKGisyj0lizN2HZFQUX7F8tlwezr6I8x36jyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152861; c=relaxed/simple;
	bh=jC3uoCU2590qoNomEcH3U2v12dEmSjbRnzu7YDFwssU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAy9Tgu06nL67l/9v/esliE+75rrDSjUFYVOVRIeHp+GOoprSPYAd17wS2YEAtTDaueXNCmrO6cLOpxRB2mQkynXHABzJYnwcthIZza6FQSbATPQLsZ+5SA5r4d94VAPv1/c9DG4uCIva7HrZXuzNpdV5KRIVrG1FgRCnXTrj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gC2Gm9zl; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gC2Gm9zl"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-49242309566so13703205e9.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 15:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784152858; x=1784757658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cvz5BJ0Y0qEXEU3XgNnSaq97bOUDaSzqN8hxy1BYrjI=;
        b=gC2Gm9zlhYeCZVpQx81nmWE2Z3q4CIz0PdbO2ptDON45n47DBpdjzXqwWCoD1H2EcY
         epbSiWmztrHr2eJ6XothLp+v2NvImZdJgcAtVAaripi/dnV/RJV81IZ9FpRz7cJXDori
         O22V5Cegx7p4tBEeyNJZHMqKsxcOcputQoT1XdZQ58HOMDKM4laArxrRo3mCiLIv0/iB
         kev08NosYE7pSAhMYE6yUX7ooXmO+bgZcxdYoohJhE3o/tkxtXx8Nes+ZfBmaXCKKsuP
         faOc5zHcmFkpb4KxaLjrIdx5EV/yPVdgojf9dtGNEOa67CgRciC5SwEWfVO8+UauPWNB
         TYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784152858; x=1784757658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cvz5BJ0Y0qEXEU3XgNnSaq97bOUDaSzqN8hxy1BYrjI=;
        b=LG9r5FstcCJacvb52BScQokseOTTCpPGC8ECZk1dgFvLq1V7KwwDtpFCngnF/YuXHA
         USpYhTHguqr8YUtTQkZlFE56L4hvEBlsP3Tmm5OKjVltgliqI35vQzYxcxGGF3aFVSJC
         5ndJVK47x4bHhIjx/NpS2B/5DSs8h62AtACAK8wYGP6THWhN3Vd9UWCMz5+QEUBhEi3e
         kG5syn9dUap+PBwpLd68f2rSb37ubtQ+QFTkVh3kIT2EpJtCh9fy/c7En7FokWM6c/Mn
         8WcpFzuhvJiTfxSlParL9ikpzVIdOqyeUInKZ6K24a8nWfuKdY1imiDr8cqKXNqzkGRu
         0n1w==
X-Gm-Message-State: AOJu0Yw+gpM6GyeMJfXEmRcejBO5zr1DxxyTKWXYBi62X6Ly+JzP7EZb
	RsFTilur71+HvkYq4c6T+OV8iTme1RMYRB8z6qLfS4NahmpuonC7c3ugWsCEnOqj
X-Gm-Gg: AfdE7ckuiI9cXcrTHbesnP4t+7Tj6fsVDy7ihvrKoFSSV993Bdq7nw7zBn/I8HG68QE
	WfRpowfNfhEHpxtj+PBW7ImEbu0K5Crz27ftOc3dJ7/GaE4uy0j2a+N4C6YGFBQXQbtsjw8P+7A
	ma80aEWaK+Pol+AaLQBXl5926M1UV9Htk7B5yDpkNdUwYGdjp2H/COJXJDJIVkBvVCN3XyMZfld
	Booa85R4Rhf0ZH7HLTJ1DW2LIHBFYBHN1GFi65Ostx652yhcCduCXJ+bAgLkXz4RRzUuYESGh9+
	W53i42gcANfqdzTT3nQYGQsP+RDyCG1lcPvhIHCwyxcqohPunMTxjfGstBdbgO8zqDcYweTiY2B
	n1ucfl9/xJNN/9TjKzB+EYOQou29StkcylJOGkU+m5nvql8Z4lijnMwlcQ2pcf0KeZ0tgzlvbk6
	wnZ4AOiQJHn2ixDPF0FVgj65Hw0aM8q66uog0ctdzeiDYpHH9S3P3rQYjBR9SbZh1U1dfLw34AV
	QQAMmiIsGrg4KWEC0bWm4qHZdG93SAkWf38RzxxL0/l
X-Received: by 2002:a05:600c:1d9a:b0:493:c8f7:3631 with SMTP id 5b1f17b1804b1-495389bcc3fmr92538885e9.22.1784152857591;
        Wed, 15 Jul 2026 15:00:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e8847esm10979205e9.5.2026.07.15.15.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:00:57 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 4/9] bpf, x86: Convert struct_ops arena arguments in the trampoline
Date: Thu, 16 Jul 2026 00:00:44 +0200
Message-ID: <20260715220052.1590783-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715220052.1590783-1-memxor@gmail.com>
References: <20260715220052.1590783-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6755; i=memxor@gmail.com; h=from:subject; bh=5PKaSdBXL5x3iGE9FjDBrnsYnCuq9ihVtTiq8V4H8Oc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuC6XbhtJ3fRN1+WuiU7F3nUlDOJCGpWioaEyF3usO/Y x6jallHKQuDGBeDrJgiS8n/fUzGJyp/B9ou44aZw8oEMoSBi1MAJvJalJHh2k7bufwT6rsFuBWu f6u/x7jabBrXbwXLkwp+mzIibS/KMfzhUfneM5l3vXS7830B4ePZcn7vpjkmtom8DSjtPy/9KJc VAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

Implement the struct_ops arena argument conversion on x86. save_args()
gains the conversion map from bpf_tramp_collect_arena_args() and, as it
copies each native argument into the BPF ctx, routes a marked slot
through RAX:

  movl %esrc, %eax      /* truncate and clear the upper 32 bits */
  subl $base_lo, %eax
  movq %rax, ctx_slot

A nullable slot tests the full 64-bit kernel pointer first:

  movq  %rsrc, %rax
  testq %rax, %rax
  jz    1f
  subl  $base_lo, %eax
1:
  movq  %rax, ctx_slot

The 32-bit subtraction is sufficient since (u32)(kaddr - base) ==
(u32)kaddr - (u32)base, and it clears the upper half as the JITs require
of arena pointer registers. Stack-passed arguments already reload
through RAX, so only the subtraction (and the NULL test) is inserted
there. The marked slots are tracked with a running slot counter shared
by the register and stack branches, matching the flattened ctx offsets
in ctx_arg_info. The size probe reruns the same emission with the same
tnodes, so the image size matches by construction.

With both the kfunc and struct_ops directions implemented, flip
bpf_jit_supports_arena_args() on for x86.

v3: New patch, moving the conversion from a BPF entry prologue into the
    trampoline, per review from Kumar.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 64 +++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index dd9009fcdc39..2f25353f135b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3042,12 +3042,39 @@ static int get_nr_used_regs(const struct btf_func_model *m)
 	return nr_used_regs;
 }
 
+/*
+ * Convert an arena kernel address into the arena pointer form on its way
+ * into the BPF ctx, rax = (u32)(src - kern_vm_start). A nullable arg
+ * preserves NULL, tested on the full 64-bit kernel pointer. The 32-bit
+ * subtraction both truncates and clears the upper half, so the stored
+ * value satisfies the JIT invariant for arena pointer registers.
+ */
+static void emit_arena_arg_conv(u8 **pprog, u32 src_reg, bool nullable, u32 base_lo)
+{
+	u8 *prog = *pprog;
+
+	if (nullable) {
+		if (src_reg != BPF_REG_0)
+			emit_mov_reg(&prog, true, BPF_REG_0, src_reg);
+		/* test rax, rax; jz over the 5-byte sub */
+		EMIT3(0x48, 0x85, 0xC0);
+		EMIT2(X86_JE, 5);
+	} else if (src_reg != BPF_REG_0) {
+		emit_mov_reg(&prog, false, BPF_REG_0, src_reg);
+	}
+	/* sub eax, base_lo */
+	EMIT1_off32(0x2D, base_lo);
+
+	*pprog = prog;
+}
+
 static void save_args(const struct btf_func_model *m, u8 **prog,
-		      int stack_size, bool for_call_origin, u32 flags)
+		      int stack_size, bool for_call_origin, u32 flags,
+		      const struct bpf_tramp_arena_args *aargs)
 {
 	int arg_regs, first_off = 0, nr_regs = 0, nr_stack_slots = 0;
 	bool use_jmp = bpf_trampoline_use_jmp(flags);
-	int i, j;
+	int i, j, slot = 0;
 
 	/* Store function arguments to stack.
 	 * For a function that accepts two pointers the sequence will be:
@@ -3088,6 +3115,10 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 			for (j = 0; j < arg_regs; j++) {
 				emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
 					 nr_stack_slots * 8 + 16 + (!use_jmp) * 8);
+				if (aargs && (aargs->slots & BIT(slot)))
+					emit_arena_arg_conv(prog, BPF_REG_0,
+							    aargs->nullable_slots & BIT(slot),
+							    (u32)aargs->kern_vm_start);
 				emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
 					 -stack_size);
 
@@ -3095,6 +3126,7 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 					first_off = stack_size;
 				stack_size -= 8;
 				nr_stack_slots++;
+				slot++;
 			}
 		} else {
 			/* Only copy the arguments on-stack to current
@@ -3103,16 +3135,24 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 			 */
 			if (for_call_origin) {
 				nr_regs += arg_regs;
+				slot += arg_regs;
 				continue;
 			}
 
 			/* copy the arguments from regs into stack */
 			for (j = 0; j < arg_regs; j++) {
-				emit_stx(prog, BPF_DW, BPF_REG_FP,
-					 nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs,
-					 -stack_size);
+				u32 src = nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs;
+
+				if (aargs && (aargs->slots & BIT(slot))) {
+					emit_arena_arg_conv(prog, src,
+							    aargs->nullable_slots & BIT(slot),
+							    (u32)aargs->kern_vm_start);
+					src = BPF_REG_0;
+				}
+				emit_stx(prog, BPF_DW, BPF_REG_FP, src, -stack_size);
 				stack_size -= 8;
 				nr_regs++;
+				slot++;
 			}
 		}
 	}
@@ -3403,11 +3443,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	struct bpf_tramp_nodes *fentry = &tnodes[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_nodes *fexit = &tnodes[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_nodes *fmod_ret = &tnodes[BPF_TRAMP_MODIFY_RETURN];
+	struct bpf_tramp_arena_args aargs;
 	void *orig_call = func_addr;
 	int cookie_off, cookie_cnt;
 	u8 **branches = NULL;
 	u64 func_meta;
 	u8 *prog;
+	bool has_aargs;
 	bool save_ret;
 
 	/*
@@ -3418,6 +3460,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	WARN_ON_ONCE((flags & BPF_TRAMP_F_INDIRECT) &&
 		     (flags & ~(BPF_TRAMP_F_INDIRECT | BPF_TRAMP_F_RET_FENTRY_RET)));
 
+	has_aargs = bpf_tramp_collect_arena_args(tnodes, flags, &aargs);
+
 	/* extra registers for struct arguments */
 	for (i = 0; i < m->nr_args; i++) {
 		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
@@ -3555,7 +3599,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		emit_store_stack_imm64(&prog, BPF_REG_0, -ip_off, (long)func_addr);
 	}
 
-	save_args(m, &prog, regs_off, false, flags);
+	save_args(m, &prog, regs_off, false, flags,
+		  has_aargs ? &aargs : NULL);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
@@ -3597,7 +3642,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		restore_regs(m, &prog, regs_off);
-		save_args(m, &prog, arg_stack_off, true, flags);
+		save_args(m, &prog, arg_stack_off, true, flags, NULL);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
 			/* Before calling the original function, load the
@@ -4099,6 +4144,11 @@ bool bpf_jit_supports_stack_args(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena_args(void)
+{
+	return true;
+}
+
 void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 {
 	if (text_poke_copy(dst, src, len) == NULL)
-- 
2.53.0

