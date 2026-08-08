Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5B72E401
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149600; cv=none; b=u/SnozvffDUkLBm0dLM5pUtBH+3fO8y8BIQFpGlqfvZguqUqn9+S9RPrbW/ANWMBhaCkq1mbyUZA5dMz0GWR8dvmoepcHFwcBAFrjeaMY11IsCC4fHqAW9GJzmPloO89toONwcQ2jtExT+i10xFAP+I4VSQvBrrJeFgFKu4QvDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149600; c=relaxed/simple;
	bh=k0RLtHHW72Hb+l9CkYiINBw2zwxUpstp1P29/xuEng0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cL/92R1EfX6PKBPgR00sovCFvhUKDqlvZ5IY9fuabNMNszn8gwXsqQxVw4NBdvs+6CoOvjMsWR8eQn2uXGDBk6/FTfwI1BqlKhhUVr4fG1CjsU9UwDjQpQLFwsQnkg0OEMSLdFwKllM2Lg9KBdYmLRdTeIx0DeQFRtx/aM5mJLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5Laqmyk; arc=none smtp.client-ip=74.125.231.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5Laqmyk"
Received: by mail-oo2-f5.google.com with SMTP id 46e09a7af769-7ee51175479so63914a34.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 17:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786149598; x=1786754398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JyGWQQtHXAuLPi0eGbKJ1wrngmbJKuDK/0aYMD23X48=;
        b=a5LaqmykX7EovVmpPei5CVitb5TtpbWMj9U98KGjYDg++YYRhM2ofpsenvyXRRI+wu
         qOrpIOQHncRdYuprFM8cYZ2/lcX9bPvYY1+u8WFmxZAlZEKkLkAhrZRxvM/UP6wF4gGs
         ZQah+60khCAmDrJ3iSh3dau0juluPt/cxRv3KNQ+xoDaWJ3IjVEH4TjseO/i+uG/ScEW
         x91jA/+yDfNRUO01vZZNdtyqqDn6WFZ5/xncKjw9z2UWg95gNmPlPwoWz5VfcgESCJUs
         9P/KakBXOhi32I+V9AoC0UlElAcWLbtcsemzQJAm1pOg32wEhT7ktJkH8w5gPwqysD4T
         +9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149598; x=1786754398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JyGWQQtHXAuLPi0eGbKJ1wrngmbJKuDK/0aYMD23X48=;
        b=IQUxyfe9WNj9GyVLUj4G40jsRNDQMPR7V0S7orYThMEBbGNA55hCJjMeC84BC13/D6
         rioAF3q89i9HTGiaU2G8B6VNu7tKqd3uXlvFqWJ6eZFdiN346+7CNZYpO6Rz0xXkpfW+
         nHoyA8fs1BkJPpN3vd9l2BXksfXkGfwQHVm7W2HL8JWh5DUGyfZJkmPiy4dTxhCp8BUz
         grjO3BbiHWBw21OO190BUIVev7609zX5l4otjpZFhXRB8HNknGDGkCenD4y7Qr0mYSHl
         r7xrpMjnvJ7cGIdaaC77uunEd/bcgGWkzC8FeMXN/0+v4Gy8A8t8ncjP/k5YYHP2h5x8
         Sutg==
X-Gm-Message-State: AOJu0YxuBBhmPsFA/+jdzgo58xc25Ios9uDheEUTAhe+KxcRU556wxmi
	0dcyPmic6wOIY4zciOfNi0HnwjffiNYM9DglvRESuXw40pLlQpY2V8J6lFkot7NoA2Y=
X-Gm-Gg: AR+sD11eom7LOU9VZFZrE6EtsUqbd1argMOnwCeCmRQxkBlsqSMnjset7PI/4a6DlEk
	KpHlR8zxQovA96HkZWW5Vyad1a8iYpm0ZrU5dKbQPgPvPRMx53kMk5i3sf13Oh2MVA2ycxXHueF
	gktOdVZUxFr5iM31X0ScJho0wdeeYqKPQa/cW6hoBc5LI5kSVeOGP3Cf5hzHye/EZIsS4kvkQ5R
	TyTy+SRF+QmtxjO2PDb5xVwhteWSTFXyJgl+qKHLe4RVAGi7CFJ6Pw0RVoXwq+wyRVObx3CLObw
	vCKtwaPLOf/L6KxmHebQd3Dfbu7TEW8EhV41jWHQc//2ZvjLkOZlC3pcQXqs6S9OGV9LHYx9odC
	3kyxI0Z+9t9OLs64XtiHHrzIvpI2Wp70FwA3mK9XFU/RgfjuMCQpnv1v3iCNAPkU4c2WyNg+CIt
	QoeuPdfbZAcdp0CdiBKwPSH6ky/qre+EJ5ePPC48srtOBLEmcoG1H3QlhDEb+EpJHefAY5Ul1H9
	B98BHCHb9xLUak1YnUXXmQPo8MQy6wT0W9A7YrPFCyOGcvAx9fYY8jjmDUyDiEQhGsRhFSy66Mo
	JHb/wg==
X-Received: by 2002:a05:6830:3889:b0:7e9:adef:4fd4 with SMTP id 46e09a7af769-7f1e5e1e5c9mr17118220a34.11.1786149598149;
        Fri, 07 Aug 2026 17:39:58 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:13::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b7c4c25sm2371424a34.22.2026.08.07.17.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:39:57 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 07/14] bpf, x86: Convert struct_ops arena arguments in the trampoline
Date: Sat,  8 Aug 2026 02:39:27 +0200
Message-ID: <20260808003938.3486067-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808003938.3486067-1-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6194; i=memxor@gmail.com; h=from:subject; bh=+cDVdyB9/Y33IzSmo/Ya6Hs8kJvBoH1MNDwci8DNNMw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIausqjLRTuTq3V05G7u2lFl4Z+vvb96RZiye9CtxAo+LSFar /qeOUhYGMS4GWTFFlpL/+5iMT1T+DrRdxg0zh5UJZAgDF6cATEROl+EX83qOM44KF18sb7qm95pbb9 28ZaKBHtGFR04XfMp7Uuj3meEPf1fOjp0H77e2fkp8FJAocSLd947Nk6f6izZuvaOWmLaTCwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

Implement the struct_ops arena argument conversion on x86. save_args()
receives the arena base from bpf_tramp_arena_base() and consults the
btf_func_model argument flags as it copies each native argument into the
BPF ctx, routing a marked argument through RAX:

  movl %esrc, %eax      /* truncate and clear the upper 32 bits */
  subl $base_lo, %eax
  movq %rax, ctx_slot

A nullable argument tests the full 64-bit kernel pointer first:

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
there.

Keep arena and nullable classification in btf_func_model.
bpf_tramp_arena_base() returns a base only for a single-program
struct_ops indirect trampoline; other trampolines pass zero and perform
no conversion. The size probe reruns the same emission with the same
model and nodes, so the image size matches by construction.

With both the kfunc and struct_ops directions implemented, flip
bpf_jit_supports_arena_args() on for x86.

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 57 +++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 107b9901fba8..162fbd2ba1df 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3048,8 +3048,35 @@ static int get_nr_used_regs(const struct btf_func_model *m)
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
+		      u64 arena_base)
 {
 	int arg_regs, first_off = 0, nr_regs = 0, nr_stack_slots = 0;
 	bool use_jmp = bpf_trampoline_use_jmp(flags);
@@ -3061,6 +3088,9 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 	 * mov QWORD PTR [rbp-0x8],rsi
 	 */
 	for (i = 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_ARGS); i++) {
+		bool arena_arg = arena_base && (m->arg_flags[i] & BTF_FMODEL_ARENA_ARG);
+		bool nullable = m->arg_flags[i] & BTF_FMODEL_NULLABLE_ARG;
+
 		arg_regs = (m->arg_size[i] + 7) / 8;
 
 		/* According to the research of Yonghong, struct members
@@ -3094,6 +3124,9 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 			for (j = 0; j < arg_regs; j++) {
 				emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
 					 nr_stack_slots * 8 + 16 + (!use_jmp) * 8);
+				if (arena_arg)
+					emit_arena_arg_conv(prog, BPF_REG_0, nullable,
+							    (u32)arena_base);
 				emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
 					 -stack_size);
 
@@ -3114,9 +3147,13 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 
 			/* copy the arguments from regs into stack */
 			for (j = 0; j < arg_regs; j++) {
-				emit_stx(prog, BPF_DW, BPF_REG_FP,
-					 nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs,
-					 -stack_size);
+				u32 src = nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs;
+
+				if (arena_arg) {
+					emit_arena_arg_conv(prog, src, nullable, (u32)arena_base);
+					src = BPF_REG_0;
+				}
+				emit_stx(prog, BPF_DW, BPF_REG_FP, src, -stack_size);
 				stack_size -= 8;
 				nr_regs++;
 			}
@@ -3412,6 +3449,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	void *orig_call = func_addr;
 	int cookie_off, cookie_cnt;
 	u8 **branches = NULL;
+	u64 arena_base;
 	u64 func_meta;
 	u8 *prog;
 	bool save_ret;
@@ -3424,6 +3462,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	WARN_ON_ONCE((flags & BPF_TRAMP_F_INDIRECT) &&
 		     (flags & ~(BPF_TRAMP_F_INDIRECT | BPF_TRAMP_F_RET_FENTRY_RET)));
 
+	arena_base = bpf_tramp_arena_base(m, tnodes, flags);
+
 	for (i = 0; i < m->nr_args; i++)
 		nr_regs += (m->arg_size[i] + 7) / 8 - 1;
 
@@ -3558,7 +3598,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		emit_store_stack_imm64(&prog, BPF_REG_0, -ip_off, (long)func_addr);
 	}
 
-	save_args(m, &prog, regs_off, false, flags);
+	save_args(m, &prog, regs_off, false, flags, arena_base);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
@@ -3600,7 +3640,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		restore_regs(m, &prog, regs_off);
-		save_args(m, &prog, arg_stack_off, true, flags);
+		save_args(m, &prog, arg_stack_off, true, flags, 0);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
 			/* Before calling the original function, load the
@@ -4101,6 +4141,11 @@ bool bpf_jit_supports_stack_args(void)
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
2.53.0-Meta

