Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09C2489898
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761484; cv=none; b=VrCYpWVJtNbqr4MYOpgz4frqPgAMtOUY+qxbcVuumPatn2RFT5hzX1QKD1ZGinNY9DoIhhFJuBxIlXlRSOtCvT7febDco51V29jxk+ILJC/k9wI6hTX5WbMhQ3oTRA9/3wGuZgoOLb/WyvffaG1UTlxAqyf9ntNASQXTJ1SlcTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761484; c=relaxed/simple;
	bh=LgEDRU1z5qTFoxUvoNSdBrhwsz5zdghp5Cht+urPGCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daNm5pa3DmQ6dSs90W1z3ghRx7r+G1jNZGXND0Giyy2TRMguqLOMKsoe+ojWxnNl+ksVCjp0xxqIYbur91e1R/MSXDm58eb4cP6qYAvkNwVXfZz+pihWtnUbYjUVq3900CoEbPjqea0S4EYYTjNnZyK8usehVgT06QLtV65wjzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyUqdNzY; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyUqdNzY"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553da76dcso7943795e9.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 05:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785761481; x=1786366281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sfvTYVwsmJRCRHlREwDF9NsXvJBYrCd+D4NADE9xTjk=;
        b=MyUqdNzYAxHHaQGReSg1Y5iQGU8KF538qsS44MfkPssfX16fXZwTIrWTouHQc5S6KW
         sc0oF5b27RLHcAVZRxDSSntUgv9hALs6Nrf0/r8Kg+gp+7/fdcVdMOVDBwuMyDFYyAmp
         H/vckBfI227OnEGQwwRU3ShaJAO76Xih/kiugg3U2Fl6SP0V+0Ocbl7cv/eAOyV9q6pa
         UTjSDtlACnq4Nu0yKkc1x5TeuVqQvB6asYMGeNsME3rHuaIG3UH2MqGo8Amyf0HlOc2k
         n6LgiAuuHIyOlkkf3PdsrToMNY4gZ5AKMnB4b7A6zP6Dgx5QwNSKJw4ZzWhpPU4WKjtj
         nWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785761481; x=1786366281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sfvTYVwsmJRCRHlREwDF9NsXvJBYrCd+D4NADE9xTjk=;
        b=Sak+tXCa/EhSz6UE+/W1MAUQxLspk0XGVLiq7hvwBJHsYu+Dnu/JzQocLZk/tueRuh
         qidXOAlKI/2Y4dsleS9EqFUH+Bab1pLaiLSMWBVoitq+zzjrsvo3scS30RareF/YShpe
         1HcQUjLHuZ+HpFWUXevX61h8Bfp8moHK3UX7DG0uEsco+8X9odk6UHUVz/crp1ieYkX1
         XvDlDZ5eE4HUj9dUxUDIPPw0eF+qEweDxGiFhLDM3bu1hlqSUcRKOOY4FuF4n9EW0bSa
         SlV4U9c88gFJlihSk1Z/zUkHRy1V/dxENknoXD2sBatvdeHvSDF6M0Mkxi+lzn+iCQxY
         X5jw==
X-Gm-Message-State: AOJu0Yz69qNnhT4twB5sd/Xnkg76uZBHze7nrXGgusHc/sZLGUlcxnzs
	6EWJ1rDcFQVUaC5Lnf7Of6THmUKNCLDuzegwYTinixmD/ePsWiTlNjsx2FkSMAS8
X-Gm-Gg: AR+sD13gBixHUJp9MqzCGsH98ksVMsDAX7ldxlrKQjsCYSUm9MonL+fTjY2foYqlBeR
	bsJhsUZWls24zB4n0P7zJH6gvHGyGLumQ0CATRsoGkXX+rV6Qmjgkl4ZHf1IeGNatKzs3/cuCRO
	STCEw55na6H3wet582BxVibze972qCEKZV+X1IyxpRHcpmrFneB173PJ8dYEUYKQDQgKEa75N9s
	ffE4AbtIlju2vpsEs+iLbZVSCqFdy0DvAGK29GptACUp0PQllNQhqJLwYBkTlEScfvxsyy3DgJV
	gyB4cwVMwkKXmiaOCzm+08OSrae+yHkCZaCOgd/FXV1r35me5Jat6tvIuFQR5kqE9U6qlfuQTy9
	WiyufQWJniApWrn0xz4cDtQndqzdG7OHh/sJ+to3sQGQCHoqfx6uY5UXKV/xH+LEHHfQMpSfZms
	6MD9OESXFtMeH6NslMw0XkJDrhudnKUHzv89ssZLlaLHm0qUUsr3sMRH7c1Fb5L2FAud/OZCVya
	dG5HvgRsj1XepT2S4wqv3+UObbeE5VJCw8G+dQ4GL5zW04HcR7k5zC6Tfebwsh4iTdmd3QEG2eA
	UHcXRiz0V9QHHK8ZbV/C/KC7iHsbNPpgtoAIcg==
X-Received: by 2002:a05:600c:4e52:b0:496:bbce:fc with SMTP id 5b1f17b1804b1-4980c658ff3mr252749905e9.12.1785761480803;
        Mon, 03 Aug 2026 05:51:20 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808191ccbsm229011835e9.3.2026.08.03.05.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:51:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 4/9] bpf, x86: Convert struct_ops arena arguments in the trampoline
Date: Mon,  3 Aug 2026 14:51:05 +0200
Message-ID: <20260803125115.2264733-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803125115.2264733-1-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6591; i=memxor@gmail.com; h=from:subject; bh=L0fWvVYvGiotWpoXyzlmkfyBMX95NZZyd63dlbD4A2A=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIaugb3Pk9ALJo17RL3v7/DMFX7lUhc18y6uZYRKxZ2mHz em5bJkdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmMjNdkaGzT4en24FXTOtTfuw av7dwuVrKlf4LgsT/JP4zuXj8v3TehkZPgQc2eNfzcPF+vTLRWfWI4rn3lor/Nr2N3dqD8vPnWl hzAA=
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

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 64 +++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 817977797e59..f70689b27845 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3043,12 +3043,39 @@ static int get_nr_used_regs(const struct btf_func_model *m)
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
@@ -3089,6 +3116,10 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 			for (j = 0; j < arg_regs; j++) {
 				emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
 					 nr_stack_slots * 8 + 16 + (!use_jmp) * 8);
+				if (aargs && (aargs->slots & BIT(slot)))
+					emit_arena_arg_conv(prog, BPF_REG_0,
+							    aargs->nullable_slots & BIT(slot),
+							    (u32)aargs->kern_vm_start);
 				emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
 					 -stack_size);
 
@@ -3096,6 +3127,7 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 					first_off = stack_size;
 				stack_size -= 8;
 				nr_stack_slots++;
+				slot++;
 			}
 		} else {
 			/* Only copy the arguments on-stack to current
@@ -3104,16 +3136,24 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
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
@@ -3404,11 +3444,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
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
@@ -3419,6 +3461,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	WARN_ON_ONCE((flags & BPF_TRAMP_F_INDIRECT) &&
 		     (flags & ~(BPF_TRAMP_F_INDIRECT | BPF_TRAMP_F_RET_FENTRY_RET)));
 
+	has_aargs = bpf_tramp_collect_arena_args(tnodes, flags, &aargs);
+
 	for (i = 0; i < m->nr_args; i++)
 		nr_regs += (m->arg_size[i] + 7) / 8 - 1;
 
@@ -3553,7 +3597,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		emit_store_stack_imm64(&prog, BPF_REG_0, -ip_off, (long)func_addr);
 	}
 
-	save_args(m, &prog, regs_off, false, flags);
+	save_args(m, &prog, regs_off, false, flags,
+		  has_aargs ? &aargs : NULL);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
@@ -3595,7 +3640,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		restore_regs(m, &prog, regs_off);
-		save_args(m, &prog, arg_stack_off, true, flags);
+		save_args(m, &prog, arg_stack_off, true, flags, NULL);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
 			/* Before calling the original function, load the
@@ -4096,6 +4141,11 @@ bool bpf_jit_supports_stack_args(void)
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

