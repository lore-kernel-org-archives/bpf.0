Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B953B5305
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427270; cv=none; b=fg+CxIHOFIkQVw0ragX6QHQ668TjNytNBpA8ZokZ6yZilM9WKUxvNV3L4JNEo5A3kUMhVojMYZPgBERyuMf2F5hkAVqYHnTncu2U+G6Nd2Vn9GDplE8E+/mmsviwaf+CCQJx4DfAojAQvV0+L/hgFuRYXjuDQcXCGU9WD35losg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427270; c=relaxed/simple;
	bh=vsQVODaDXRaeaXhk9Y1Lf+peOOAIukBDyQ1teqUzsFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElCC9H5GfmrrEmR4Yc6UL3Z1/5TrseAdfVO/vT6z+qtAwLHWHgsnNPhMl5nwmDc6/XIa2SSV7p/FytC2coESazNt3Uxglx4L1JeL0N0IqoTi/uAo+yYwgl6M0NFoD1ibA0x+hDtAVmumXv2m6GFSkWXV1z6Sx/pBDI3Gylaw/GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8PnG1od; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8PnG1od"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B991F00A3D;
	Thu,  3 Sep 2026 09:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788427264;
	bh=j1y3Oi1LrKhgB6pwN4bpNCTkOr0UqSjPvgwzS7HdpGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U8PnG1odCgkShhlYSnQSm3TH7I6QbFKhX706dIxhR8aEOvEbMbBloU+ckwuBuYk4B
	 p+cUOXz0HEXLhxOWNOxR4HcCSmwkwQa97lbz8gEkaiBd0BeijyXZ4+Da+95KcqpPVB
	 tYEn3yZzQfAwLLV6JlxKnttwJETkIACHhBAQNvwhFMMIGjDgFDxvIrKakS/OH1F4Hn
	 OquLSr6S5hcMyYNLCdFCAxZKEMLbwgRrw2KQ6q6nqIaSdtSzTqGEuccv9JBn6g9dxk
	 H5oRXLEUsVh+ICL0wZVATtZ7XRJQ6OM5f4G57nT0dd0+6M9u2xwnQ2bN0uXpdijJMT
	 bl3j/TKtuWNHQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCHv2 bpf-next 2/3] bpf, x86: Introduce JIT emission context
Date: Thu,  3 Sep 2026 11:20:38 +0200
Message-ID: <20260903092039.477827-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903092039.477827-1-jolsa@kernel.org>
References: <20260903092039.477827-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass a struct jit_emit_context through the jit emit helpers instead of
passing the output pointer separately.

Put the current output pointer in the context and use it from the EMIT
macros and helper functions. This centralizes the emission state and
provides a place for additional state needed by following change.

There is no functional change intended.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 829 +++++++++++++++---------------------
 1 file changed, 353 insertions(+), 476 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5922bb4728aa..ee2ddeba3de1 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -23,6 +23,10 @@
 
 static bool all_callee_regs_used[4] = {true, true, true, true};
 
+struct jit_emit_context {
+	u8 *prog;
+};
+
 static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
 {
 	if (len == 1)
@@ -36,8 +40,13 @@ static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
 	return ptr + len;
 }
 
+static void emit_code_jit(struct jit_emit_context *jit, u32 bytes, unsigned int len)
+{
+	jit->prog = emit_code(jit->prog, bytes, len);
+}
+
 #define EMIT(bytes, len) \
-	do { prog = emit_code(prog, bytes, len); } while (0)
+	emit_code_jit(jit, bytes, len)
 
 #define EMIT1(b1)		EMIT(b1, 1)
 #define EMIT2(b1, b2)		EMIT((b1) + ((b2) << 8), 2)
@@ -149,15 +158,15 @@ static int bpf_size_to_x86_bytes(int bpf_size)
 		return 0;
 }
 
-static int bpf_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
+static int bpf_call_depth_emit_accounting(struct jit_emit_context *jit, void *func, void *ip)
 {
 	u8 insn_buff[MAX_PATCH_LEN];
 	int size;
 
 	size = x86_call_depth_emit_accounting(insn_buff, func, ip);
-	memcpy(*pprog, insn_buff, size);
+	memcpy(jit->prog, insn_buff, size);
 
-	*pprog += size;
+	jit->prog += size;
 	return size;
 }
 
@@ -321,6 +330,8 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
 }
 
 struct jit_context {
+	struct jit_emit_context jit;
+
 	int cleanup_addr; /* Epilogue code offset */
 
 	/*
@@ -341,34 +352,23 @@ struct jit_context {
 /* Number of bytes that will be skipped on tailcall */
 #define X86_TAIL_CALL_OFFSET	(12 + ENDBR_INSN_SIZE)
 
-static void push_r9(u8 **pprog)
+static void push_r9(struct jit_emit_context *jit)
 {
-	u8 *prog = *pprog;
-
 	EMIT2(0x41, 0x51);   /* push r9 */
-	*pprog = prog;
 }
 
-static void pop_r9(u8 **pprog)
+static void pop_r9(struct jit_emit_context *jit)
 {
-	u8 *prog = *pprog;
-
 	EMIT2(0x41, 0x59);   /* pop r9 */
-	*pprog = prog;
 }
 
-static void push_r12(u8 **pprog)
+static void push_r12(struct jit_emit_context *jit)
 {
-	u8 *prog = *pprog;
-
 	EMIT2(0x41, 0x54);   /* push r12 */
-	*pprog = prog;
 }
 
-static void push_callee_regs(u8 **pprog, bool *callee_regs_used)
+static void push_callee_regs(struct jit_emit_context *jit, bool *callee_regs_used)
 {
-	u8 *prog = *pprog;
-
 	if (callee_regs_used[0])
 		EMIT1(0x53);         /* push rbx */
 	if (callee_regs_used[1])
@@ -377,21 +377,15 @@ static void push_callee_regs(u8 **pprog, bool *callee_regs_used)
 		EMIT2(0x41, 0x56);   /* push r14 */
 	if (callee_regs_used[3])
 		EMIT2(0x41, 0x57);   /* push r15 */
-	*pprog = prog;
 }
 
-static void pop_r12(u8 **pprog)
+static void pop_r12(struct jit_emit_context *jit)
 {
-	u8 *prog = *pprog;
-
 	EMIT2(0x41, 0x5C);   /* pop r12 */
-	*pprog = prog;
 }
 
-static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
+static void pop_callee_regs(struct jit_emit_context *jit, bool *callee_regs_used)
 {
-	u8 *prog = *pprog;
-
 	if (callee_regs_used[3])
 		EMIT2(0x41, 0x5F);   /* pop r15 */
 	if (callee_regs_used[2])
@@ -400,40 +394,32 @@ static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
 		EMIT2(0x41, 0x5D);   /* pop r13 */
 	if (callee_regs_used[0])
 		EMIT1(0x5B);         /* pop rbx */
-	*pprog = prog;
 }
 
 /* add rsp, depth */
-static void emit_add_rsp(u8 **pprog, u16 depth)
+static void emit_add_rsp(struct jit_emit_context *jit, u16 depth)
 {
-	u8 *prog = *pprog;
-
 	if (!depth)
 		return;
 	if (is_imm8(depth))
 		EMIT4(0x48, 0x83, 0xC4, depth); /* add rsp, imm8 */
 	else
 		EMIT3_off32(0x48, 0x81, 0xC4, depth); /* add rsp, imm32 */
-	*pprog = prog;
 }
 
 /* sub rsp, depth */
-static void emit_sub_rsp(u8 **pprog, u16 depth)
+static void emit_sub_rsp(struct jit_emit_context *jit, u16 depth)
 {
-	u8 *prog = *pprog;
-
 	if (!depth)
 		return;
 	if (is_imm8(depth))
 		EMIT4(0x48, 0x83, 0xEC, depth); /* sub rsp, imm8 */
 	else
 		EMIT3_off32(0x48, 0x81, 0xEC, depth); /* sub rsp, imm32 */
-	*pprog = prog;
 }
 
-static void emit_nops(u8 **pprog, int len)
+static void emit_nops(struct jit_emit_context *jit, int len)
 {
-	u8 *prog = *pprog;
 	int i, noplen;
 
 	while (len > 0) {
@@ -446,72 +432,56 @@ static void emit_nops(u8 **pprog, int len)
 			EMIT1(x86_nops[noplen][i]);
 		len -= noplen;
 	}
-
-	*pprog = prog;
 }
 
 /*
  * Emit the various CFI preambles, see asm/cfi.h and the comments about FineIBT
  * in arch/x86/kernel/alternative.c
  */
-static int emit_call(u8 **prog, void *func, void *ip);
+static int emit_call(struct jit_emit_context *jit, void *func, void *ip);
 
-static void emit_fineibt(u8 **pprog, u8 *ip, u32 hash, int arity)
+static void emit_fineibt(struct jit_emit_context *jit, u8 *ip, u32 hash, int arity)
 {
-	u8 *prog = *pprog;
-
 	EMIT_ENDBR();
 	EMIT1_off32(0x2d, hash);			/* subl $hash, %eax	*/
 	if (cfi_bhi) {
 		EMIT2(0x2e, 0x2e);			/* cs cs */
-		emit_call(&prog, __bhi_args[arity], ip + 11);
+		emit_call(jit, __bhi_args[arity], ip + 11);
 	} else {
 		EMIT3_off32(0x2e, 0x0f, 0x85, 3);	/* jne.d32,pn 3		*/
 	}
 	EMIT_ENDBR_POISON();
-
-	*pprog = prog;
 }
 
-static void emit_kcfi(u8 **pprog, u32 hash)
+static void emit_kcfi(struct jit_emit_context *jit, u32 hash)
 {
-	u8 *prog = *pprog;
-
 	EMIT1_off32(0xb8, hash);			/* movl $hash, %eax	*/
 #ifdef CONFIG_CALL_PADDING
 	for (int i = 0; i < CONFIG_FUNCTION_PADDING_CFI; i++)
 		EMIT1(0x90);
 #endif
 	EMIT_ENDBR();
-
-	*pprog = prog;
 }
 
-static void emit_cfi(u8 **pprog, u8 *ip, u32 hash, int arity)
+static void emit_cfi(struct jit_emit_context *jit, u8 *ip, u32 hash, int arity)
 {
-	u8 *prog = *pprog;
-
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
-		emit_fineibt(&prog, ip, hash, arity);
+		emit_fineibt(jit, ip, hash, arity);
 		break;
 
 	case CFI_KCFI:
-		emit_kcfi(&prog, hash);
+		emit_kcfi(jit, hash);
 		break;
 
 	default:
 		EMIT_ENDBR();
 		break;
 	}
-
-	*pprog = prog;
 }
 
-static void emit_prologue_tail_call(u8 **pprog, bool is_subprog)
+static void emit_prologue_tail_call(struct jit_emit_context *jit, bool is_subprog)
 {
-	u8 *prog = *pprog;
-
 	if (!is_subprog) {
 		/* cmp rax, MAX_TAIL_CALL_CNT */
 		EMIT4(0x48, 0x83, 0xF8, MAX_TAIL_CALL_CNT);
@@ -535,8 +505,6 @@ static void emit_prologue_tail_call(u8 **pprog, bool is_subprog)
 		EMIT1(0x50);             /* push rax */
 		EMIT1(0x50);             /* push rax */
 	}
-
-	*pprog = prog;
 }
 
 /*
@@ -544,21 +512,19 @@ static void emit_prologue_tail_call(u8 **pprog, bool is_subprog)
  * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
  * while jumping to another program
  */
-static void emit_prologue(u8 **pprog, u8 *ip, u32 stack_depth, bool ebpf_from_cbpf,
-			  bool tail_call_reachable, bool is_subprog,
+static void emit_prologue(struct jit_emit_context *jit, u8 *ip, u32 stack_depth,
+			  bool ebpf_from_cbpf, bool tail_call_reachable, bool is_subprog,
 			  bool is_exception_cb)
 {
-	u8 *prog = *pprog;
-
 	if (is_subprog) {
-		emit_cfi(&prog, ip, cfi_bpf_subprog_hash, 5);
+		emit_cfi(jit, ip, cfi_bpf_subprog_hash, 5);
 	} else {
-		emit_cfi(&prog, ip, cfi_bpf_hash, 1);
+		emit_cfi(jit, ip, cfi_bpf_hash, 1);
 	}
 	/* BPF trampoline can be made to work without these nops,
 	 * but let's waste 5 bytes for now and optimize later
 	 */
-	emit_nops(&prog, X86_PATCH_SIZE);
+	emit_nops(jit, X86_PATCH_SIZE);
 	if (!ebpf_from_cbpf) {
 		if (tail_call_reachable && !is_subprog)
 			/* When it's the entry of the whole tailcall context,
@@ -567,7 +533,7 @@ static void emit_prologue(u8 **pprog, u8 *ip, u32 stack_depth, bool ebpf_from_cb
 			EMIT3(0x48, 0x31, 0xC0); /* xor rax, rax */
 		else
 			/* Keep the same instruction layout. */
-			emit_nops(&prog, 3);     /* nop3 */
+			emit_nops(jit, 3);     /* nop3 */
 	}
 	/* Exception callback receives FP as third parameter */
 	if (is_exception_cb) {
@@ -577,8 +543,8 @@ static void emit_prologue(u8 **pprog, u8 *ip, u32 stack_depth, bool ebpf_from_cb
 		 * first restore those callee-saved regs from stack, before
 		 * reusing the stack frame.
 		 */
-		pop_callee_regs(&prog, all_callee_regs_used);
-		pop_r12(&prog);
+		pop_callee_regs(jit, all_callee_regs_used);
+		pop_r12(jit);
 		/* Reset the stack frame. */
 		EMIT3(0x48, 0x89, 0xEC); /* mov rsp, rbp */
 	} else {
@@ -593,13 +559,11 @@ static void emit_prologue(u8 **pprog, u8 *ip, u32 stack_depth, bool ebpf_from_cb
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
 	if (tail_call_reachable)
-		emit_prologue_tail_call(&prog, is_subprog);
-	*pprog = prog;
+		emit_prologue_tail_call(jit, is_subprog);
 }
 
-static int emit_patch(u8 **pprog, void *func, void *ip, u8 opcode)
+static int emit_patch(struct jit_emit_context *jit, void *func, void *ip, u8 opcode)
 {
-	u8 *prog = *pprog;
 	s64 offset;
 
 	offset = func - (ip + X86_PATCH_SIZE);
@@ -608,25 +572,24 @@ static int emit_patch(u8 **pprog, void *func, void *ip, u8 opcode)
 		return -ERANGE;
 	}
 	EMIT1_off32(opcode, offset);
-	*pprog = prog;
 	return 0;
 }
 
-static int emit_call(u8 **pprog, void *func, void *ip)
+static int emit_call(struct jit_emit_context *jit, void *func, void *ip)
 {
-	return emit_patch(pprog, func, ip, 0xE8);
+	return emit_patch(jit, func, ip, 0xE8);
 }
 
-static int emit_rsb_call(u8 **pprog, void *func, void *ip)
+static int emit_rsb_call(struct jit_emit_context *jit, void *func, void *ip)
 {
 	OPTIMIZER_HIDE_VAR(func);
-	ip += bpf_call_depth_emit_accounting(pprog, func, ip);
-	return emit_patch(pprog, func, ip, 0xE8);
+	ip += bpf_call_depth_emit_accounting(jit, func, ip);
+	return emit_patch(jit, func, ip, 0xE8);
 }
 
-static int emit_jump(u8 **pprog, void *func, void *ip)
+static int emit_jump(struct jit_emit_context *jit, void *func, void *ip)
 {
-	return emit_patch(pprog, func, ip, 0xE9);
+	return emit_patch(jit, func, ip, 0xE9);
 }
 
 static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
@@ -634,27 +597,27 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 				void *old_addr, void *new_addr)
 {
 	const u8 *nop_insn = x86_nops[5];
+	struct jit_emit_context jit = {};
 	u8 old_insn[X86_PATCH_SIZE];
 	u8 new_insn[X86_PATCH_SIZE];
-	u8 *prog;
 	int ret;
 
 	memcpy(old_insn, nop_insn, X86_PATCH_SIZE);
 	if (old_t != BPF_MOD_NOP && old_addr) {
-		prog = old_insn;
+		jit.prog = old_insn;
 		ret = old_t == BPF_MOD_CALL ?
-		      emit_call(&prog, old_addr, ip) :
-		      emit_jump(&prog, old_addr, ip);
+		      emit_call(&jit, old_addr, ip) :
+		      emit_jump(&jit, old_addr, ip);
 		if (ret)
 			return ret;
 	}
 
 	memcpy(new_insn, nop_insn, X86_PATCH_SIZE);
 	if (new_t != BPF_MOD_NOP && new_addr) {
-		prog = new_insn;
+		jit.prog = new_insn;
 		ret = new_t == BPF_MOD_CALL ?
-		      emit_call(&prog, new_addr, ip) :
-		      emit_jump(&prog, new_addr, ip);
+		      emit_call(&jit, new_addr, ip) :
+		      emit_jump(&jit, new_addr, ip);
 		if (ret)
 			return ret;
 	}
@@ -694,58 +657,47 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 
 #define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
 
-static void __emit_indirect_jump(u8 **pprog, int reg, bool ereg)
+static void __emit_indirect_jump(struct jit_emit_context *jit, int reg, bool ereg)
 {
-	u8 *prog = *pprog;
-
 	if (ereg)
 		EMIT1(0x41);
 
 	EMIT2(0xFF, 0xE0 + reg);
-
-	*pprog = prog;
 }
 
-static void emit_indirect_jump(u8 **pprog, int bpf_reg, u8 *ip)
+static void emit_indirect_jump(struct jit_emit_context *jit, int bpf_reg, u8 *ip)
 {
-	u8 *prog = *pprog;
 	int reg = reg2hex[bpf_reg];
 	bool ereg = is_ereg(bpf_reg);
 
 	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
 		OPTIMIZER_HIDE_VAR(reg);
-		emit_jump(&prog, its_static_thunk(reg + 8*ereg), ip);
+		emit_jump(jit, its_static_thunk(reg + 8*ereg), ip);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
 		EMIT_LFENCE();
-		__emit_indirect_jump(&prog, reg, ereg);
+		__emit_indirect_jump(jit, reg, ereg);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
 		OPTIMIZER_HIDE_VAR(reg);
 		if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
-			emit_jump(&prog, &__x86_indirect_jump_thunk_array[reg + 8*ereg], ip);
+			emit_jump(jit, &__x86_indirect_jump_thunk_array[reg + 8*ereg], ip);
 		else
-			emit_jump(&prog, &__x86_indirect_thunk_array[reg + 8*ereg], ip);
+			emit_jump(jit, &__x86_indirect_thunk_array[reg + 8*ereg], ip);
 	} else {
-		__emit_indirect_jump(&prog, reg, ereg);
+		__emit_indirect_jump(jit, reg, ereg);
 		if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) || IS_ENABLED(CONFIG_MITIGATION_SLS))
 			EMIT1(0xCC);		/* int3 */
 	}
-
-	*pprog = prog;
 }
 
-static void emit_return(u8 **pprog, u8 *ip)
+static void emit_return(struct jit_emit_context *jit, u8 *ip)
 {
-	u8 *prog = *pprog;
-
 	if (cpu_wants_rethunk()) {
-		emit_jump(&prog, x86_return_thunk, ip);
+		emit_jump(jit, x86_return_thunk, ip);
 	} else {
 		EMIT1(0xC3);		/* ret */
 		if (IS_ENABLED(CONFIG_MITIGATION_SLS))
 			EMIT1(0xCC);	/* int3 */
 	}
-
-	*pprog = prog;
 }
 
 #define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack)	(-16 - round_up(stack, 8))
@@ -765,12 +717,13 @@ static void emit_return(u8 **pprog, u8 *ip)
  * out:
  */
 static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
-					u8 **pprog, bool *callee_regs_used,
+					bool *callee_regs_used,
 					u32 stack_depth, u8 *ip,
 					struct jit_context *ctx)
 {
 	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack_depth);
-	u8 *prog = *pprog, *start = *pprog;
+	struct jit_emit_context *jit = &ctx->jit;
+	u8 *start = jit->prog;
 	int offset;
 
 	/*
@@ -787,7 +740,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	EMIT3(0x39, 0x56,                         /* cmp dword ptr [rsi + 16], edx */
 	      offsetof(struct bpf_array, map.max_entries));
 
-	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
+	offset = ctx->tail_call_indirect_label - (jit->prog + 2 - start);
 	EMIT2(X86_JBE, offset);                   /* jbe out */
 
 	/*
@@ -797,7 +750,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off); /* mov rax, qword ptr [rbp - tcc_ptr_off] */
 	EMIT4(0x48, 0x83, 0x38, MAX_TAIL_CALL_CNT); /* cmp qword ptr [rax], MAX_TAIL_CALL_CNT */
 
-	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
+	offset = ctx->tail_call_indirect_label - (jit->prog + 2 - start);
 	EMIT2(X86_JAE, offset);                   /* jae out */
 
 	/* prog = array->ptrs[index]; */
@@ -810,19 +763,19 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	 */
 	EMIT3(0x48, 0x85, 0xC9);                  /* test rcx,rcx */
 
-	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
+	offset = ctx->tail_call_indirect_label - (jit->prog + 2 - start);
 	EMIT2(X86_JE, offset);                    /* je out */
 
 	/* Inc tail_call_cnt if the slot is populated. */
 	EMIT4(0x48, 0x83, 0x00, 0x01);            /* add qword ptr [rax], 1 */
 
 	if (bpf_prog->aux->exception_boundary) {
-		pop_callee_regs(&prog, all_callee_regs_used);
-		pop_r12(&prog);
+		pop_callee_regs(jit, all_callee_regs_used);
+		pop_r12(jit);
 	} else {
-		pop_callee_regs(&prog, callee_regs_used);
+		pop_callee_regs(jit, callee_regs_used);
 		if (bpf_arena_get_kern_vm_start(bpf_prog->aux->arena))
-			pop_r12(&prog);
+			pop_r12(jit);
 	}
 
 	/* Pop tail_call_cnt_ptr. */
@@ -845,21 +798,21 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	 * rdi == ctx (1st arg)
 	 * rcx == prog->bpf_func + X86_TAIL_CALL_OFFSET
 	 */
-	emit_indirect_jump(&prog, BPF_REG_4 /* R4 -> rcx */, ip + (prog - start));
+	emit_indirect_jump(jit, BPF_REG_4 /* R4 -> rcx */, ip + (jit->prog - start));
 
 	/* out: */
-	ctx->tail_call_indirect_label = prog - start;
-	*pprog = prog;
+	ctx->tail_call_indirect_label = jit->prog - start;
 }
 
 static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 				      struct bpf_jit_poke_descriptor *poke,
-				      u8 **pprog, u8 *ip,
+				      u8 *ip,
 				      bool *callee_regs_used, u32 stack_depth,
 				      struct jit_context *ctx)
 {
+	struct jit_emit_context *jit = &ctx->jit;
 	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack_depth);
-	u8 *prog = *pprog, *start = *pprog;
+	u8 *start = jit->prog;
 	int offset;
 
 	/*
@@ -869,27 +822,27 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off);   /* mov rax, qword ptr [rbp - tcc_ptr_off] */
 	EMIT4(0x48, 0x83, 0x38, MAX_TAIL_CALL_CNT);   /* cmp qword ptr [rax], MAX_TAIL_CALL_CNT */
 
-	offset = ctx->tail_call_direct_label - (prog + 2 - start);
+	offset = ctx->tail_call_direct_label - (jit->prog + 2 - start);
 	EMIT2(X86_JAE, offset);                       /* jae out */
 
-	poke->tailcall_bypass = ip + (prog - start);
+	poke->tailcall_bypass = ip + (jit->prog - start);
 	poke->adj_off = X86_TAIL_CALL_OFFSET;
 	poke->tailcall_target = ip + ctx->tail_call_direct_label - X86_PATCH_SIZE;
 	poke->bypass_addr = (u8 *)poke->tailcall_target + X86_PATCH_SIZE;
 
-	emit_jump(&prog, (u8 *)poke->tailcall_target + X86_PATCH_SIZE,
+	emit_jump(jit, (u8 *)poke->tailcall_target + X86_PATCH_SIZE,
 		  poke->tailcall_bypass);
 
 	/* Inc tail_call_cnt if the slot is populated. */
 	EMIT4(0x48, 0x83, 0x00, 0x01);                /* add qword ptr [rax], 1 */
 
 	if (bpf_prog->aux->exception_boundary) {
-		pop_callee_regs(&prog, all_callee_regs_used);
-		pop_r12(&prog);
+		pop_callee_regs(jit, all_callee_regs_used);
+		pop_r12(jit);
 	} else {
-		pop_callee_regs(&prog, callee_regs_used);
+		pop_callee_regs(jit, callee_regs_used);
 		if (bpf_arena_get_kern_vm_start(bpf_prog->aux->arena))
-			pop_r12(&prog);
+			pop_r12(jit);
 	}
 
 	/* Pop tail_call_cnt_ptr. */
@@ -901,12 +854,10 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
 
-	emit_nops(&prog, X86_PATCH_SIZE);
+	emit_nops(jit, X86_PATCH_SIZE);
 
 	/* out: */
-	ctx->tail_call_direct_label = prog - start;
-
-	*pprog = prog;
+	ctx->tail_call_direct_label = jit->prog - start;
 }
 
 static void bpf_tail_call_direct_fixup(struct bpf_prog *prog)
@@ -947,10 +898,9 @@ static void bpf_tail_call_direct_fixup(struct bpf_prog *prog)
 	}
 }
 
-static void emit_mov_imm32(u8 **pprog, bool sign_propagate,
+static void emit_mov_imm32(struct jit_emit_context *jit, bool sign_propagate,
 			   u32 dst_reg, const u32 imm32)
 {
-	u8 *prog = *pprog;
 	u8 b1, b2, b3;
 
 	/*
@@ -963,7 +913,7 @@ static void emit_mov_imm32(u8 **pprog, bool sign_propagate,
 		b2 = 0xC7;
 		b3 = 0xC0;
 		EMIT3_off32(b1, b2, add_1reg(b3, dst_reg), imm32);
-		goto done;
+		return;
 	}
 
 	/*
@@ -976,22 +926,19 @@ static void emit_mov_imm32(u8 **pprog, bool sign_propagate,
 		b2 = 0x31; /* xor */
 		b3 = 0xC0;
 		EMIT2(b2, add_2reg(b3, dst_reg, dst_reg));
-		goto done;
+		return;
 	}
 
 	/* mov %eax, imm32 */
 	if (is_ereg(dst_reg))
 		EMIT1(add_1mod(0x40, dst_reg));
 	EMIT1_off32(add_1reg(0xB8, dst_reg), imm32);
-done:
-	*pprog = prog;
 }
 
-static void emit_mov_imm64(u8 **pprog, u32 dst_reg,
+static void emit_mov_imm64(struct jit_emit_context *jit, u32 dst_reg,
 			   const u32 imm32_hi, const u32 imm32_lo)
 {
 	u64 imm64 = ((u64)imm32_hi << 32) | (u32)imm32_lo;
-	u8 *prog = *pprog;
 
 	if (is_uimm32(imm64)) {
 		/*
@@ -1000,23 +947,19 @@ static void emit_mov_imm64(u8 **pprog, u32 dst_reg,
 		 * directly, so save couple of bytes by just doing
 		 * 'mov %eax, imm32' instead.
 		 */
-		emit_mov_imm32(&prog, false, dst_reg, imm32_lo);
+		emit_mov_imm32(jit, false, dst_reg, imm32_lo);
 	} else if (is_simm32(imm64)) {
-		emit_mov_imm32(&prog, true, dst_reg, imm32_lo);
+		emit_mov_imm32(jit, true, dst_reg, imm32_lo);
 	} else {
 		/* movabsq rax, imm64 */
 		EMIT2(add_1mod(0x48, dst_reg), add_1reg(0xB8, dst_reg));
 		EMIT(imm32_lo, 4);
 		EMIT(imm32_hi, 4);
 	}
-
-	*pprog = prog;
 }
 
-static void emit_mov_reg(u8 **pprog, bool is64, u32 dst_reg, u32 src_reg)
+static void emit_mov_reg(struct jit_emit_context *jit, bool is64, u32 dst_reg, u32 src_reg)
 {
-	u8 *prog = *pprog;
-
 	if (is64) {
 		/* mov dst, src */
 		EMIT_mov(dst_reg, src_reg);
@@ -1026,15 +969,11 @@ static void emit_mov_reg(u8 **pprog, bool is64, u32 dst_reg, u32 src_reg)
 			EMIT1(add_2mod(0x40, dst_reg, src_reg));
 		EMIT2(0x89, add_2reg(0xC0, dst_reg, src_reg));
 	}
-
-	*pprog = prog;
 }
 
-static void emit_movsx_reg(u8 **pprog, int num_bits, bool is64, u32 dst_reg,
+static void emit_movsx_reg(struct jit_emit_context *jit, int num_bits, bool is64, u32 dst_reg,
 			   u32 src_reg)
 {
-	u8 *prog = *pprog;
-
 	if (is64) {
 		/* movs[b,w,l]q dst, src */
 		if (num_bits == 8)
@@ -1058,15 +997,11 @@ static void emit_movsx_reg(u8 **pprog, int num_bits, bool is64, u32 dst_reg,
 			      add_2reg(0xC0, src_reg, dst_reg));
 		}
 	}
-
-	*pprog = prog;
 }
 
 /* Emit the suffix (ModR/M etc) for addressing *(ptr_reg + off) and val_reg */
-static void emit_insn_suffix(u8 **pprog, u32 ptr_reg, u32 val_reg, int off)
+static void emit_insn_suffix(struct jit_emit_context *jit, u32 ptr_reg, u32 val_reg, int off)
 {
-	u8 *prog = *pprog;
-
 	if (is_imm8(off)) {
 		/* 1-byte signed displacement.
 		 *
@@ -1079,54 +1014,43 @@ static void emit_insn_suffix(u8 **pprog, u32 ptr_reg, u32 val_reg, int off)
 		/* 4-byte signed displacement */
 		EMIT1_off32(add_2reg(0x80, ptr_reg, val_reg), off);
 	}
-	*pprog = prog;
 }
 
-static void emit_insn_suffix_SIB(u8 **pprog, u32 ptr_reg, u32 val_reg, u32 index_reg, int off)
+static void emit_insn_suffix_SIB(struct jit_emit_context *jit, u32 ptr_reg, u32 val_reg,
+				 u32 index_reg, int off)
 {
-	u8 *prog = *pprog;
-
 	if (is_imm8(off)) {
 		EMIT3(add_2reg(0x44, BPF_REG_0, val_reg), add_2reg(0, ptr_reg, index_reg) /* SIB */, off);
 	} else {
 		EMIT2_off32(add_2reg(0x84, BPF_REG_0, val_reg), add_2reg(0, ptr_reg, index_reg) /* SIB */, off);
 	}
-	*pprog = prog;
 }
 
 /*
  * Emit a REX byte if it will be necessary to address these registers
  */
-static void maybe_emit_mod(u8 **pprog, u32 dst_reg, u32 src_reg, bool is64)
+static void maybe_emit_mod(struct jit_emit_context *jit, u32 dst_reg, u32 src_reg, bool is64)
 {
-	u8 *prog = *pprog;
-
 	if (is64)
 		EMIT1(add_2mod(0x48, dst_reg, src_reg));
 	else if (is_ereg(dst_reg) || is_ereg(src_reg))
 		EMIT1(add_2mod(0x40, dst_reg, src_reg));
-	*pprog = prog;
 }
 
 /*
  * Similar version of maybe_emit_mod() for a single register
  */
-static void maybe_emit_1mod(u8 **pprog, u32 reg, bool is64)
+static void maybe_emit_1mod(struct jit_emit_context *jit, u32 reg, bool is64)
 {
-	u8 *prog = *pprog;
-
 	if (is64)
 		EMIT1(add_1mod(0x48, reg));
 	else if (is_ereg(reg))
 		EMIT1(add_1mod(0x40, reg));
-	*pprog = prog;
 }
 
 /* LDX: dst_reg = *(u8*)(src_reg + off) */
-static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
+static void emit_ldx(struct jit_emit_context *jit, u32 size, u32 dst_reg, u32 src_reg, int off)
 {
-	u8 *prog = *pprog;
-
 	switch (size) {
 	case BPF_B:
 		/* Emit 'movzx rax, byte ptr [rax + off]' */
@@ -1148,15 +1072,12 @@ static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 		EMIT2(add_2mod(0x48, src_reg, dst_reg), 0x8B);
 		break;
 	}
-	emit_insn_suffix(&prog, src_reg, dst_reg, off);
-	*pprog = prog;
+	emit_insn_suffix(jit, src_reg, dst_reg, off);
 }
 
 /* LDSX: dst_reg = *(s8*)(src_reg + off) */
-static void emit_ldsx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
+static void emit_ldsx(struct jit_emit_context *jit, u32 size, u32 dst_reg, u32 src_reg, int off)
 {
-	u8 *prog = *pprog;
-
 	switch (size) {
 	case BPF_B:
 		/* Emit 'movsx rax, byte ptr [rax + off]' */
@@ -1171,14 +1092,12 @@ static void emit_ldsx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 		EMIT2(add_2mod(0x48, src_reg, dst_reg), 0x63);
 		break;
 	}
-	emit_insn_suffix(&prog, src_reg, dst_reg, off);
-	*pprog = prog;
+	emit_insn_suffix(jit, src_reg, dst_reg, off);
 }
 
-static void emit_ldx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32 index_reg, int off)
+static void emit_ldx_index(struct jit_emit_context *jit, u32 size, u32 dst_reg, u32 src_reg,
+			   u32 index_reg, int off)
 {
-	u8 *prog = *pprog;
-
 	switch (size) {
 	case BPF_B:
 		/* movzx rax, byte ptr [rax + r12 + off] */
@@ -1197,14 +1116,12 @@ static void emit_ldx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32 i
 		EMIT2(add_3mod(0x48, src_reg, dst_reg, index_reg), 0x8B);
 		break;
 	}
-	emit_insn_suffix_SIB(&prog, src_reg, dst_reg, index_reg, off);
-	*pprog = prog;
+	emit_insn_suffix_SIB(jit, src_reg, dst_reg, index_reg, off);
 }
 
-static void emit_ldsx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32 index_reg, int off)
+static void emit_ldsx_index(struct jit_emit_context *jit, u32 size, u32 dst_reg, u32 src_reg,
+			    u32 index_reg, int off)
 {
-	u8 *prog = *pprog;
-
 	switch (size) {
 	case BPF_B:
 		/* movsx rax, byte ptr [rax + r12 + off] */
@@ -1219,25 +1136,22 @@ static void emit_ldsx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32
 		EMIT2(add_3mod(0x48, src_reg, dst_reg, index_reg), 0x63);
 		break;
 	}
-	emit_insn_suffix_SIB(&prog, src_reg, dst_reg, index_reg, off);
-	*pprog = prog;
+	emit_insn_suffix_SIB(jit, src_reg, dst_reg, index_reg, off);
 }
 
-static void emit_ldx_r12(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
+static void emit_ldx_r12(struct jit_emit_context *jit, u32 size, u32 dst_reg, u32 src_reg, int off)
 {
-	emit_ldx_index(pprog, size, dst_reg, src_reg, X86_REG_R12, off);
+	emit_ldx_index(jit, size, dst_reg, src_reg, X86_REG_R12, off);
 }
 
-static void emit_ldsx_r12(u8 **prog, u32 size, u32 dst_reg, u32 src_reg, int off)
+static void emit_ldsx_r12(struct jit_emit_context *jit, u32 size, u32 dst_reg, u32 src_reg, int off)
 {
-	emit_ldsx_index(prog, size, dst_reg, src_reg, X86_REG_R12, off);
+	emit_ldsx_index(jit, size, dst_reg, src_reg, X86_REG_R12, off);
 }
 
 /* STX: *(u8*)(dst_reg + off) = src_reg */
-static void emit_stx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
+static void emit_stx(struct jit_emit_context *jit, u32 size, u32 dst_reg, u32 src_reg, int off)
 {
-	u8 *prog = *pprog;
-
 	switch (size) {
 	case BPF_B:
 		/* Emit 'mov byte ptr [rax + off], al' */
@@ -1263,15 +1177,13 @@ static void emit_stx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 		EMIT2(add_2mod(0x48, dst_reg, src_reg), 0x89);
 		break;
 	}
-	emit_insn_suffix(&prog, dst_reg, src_reg, off);
-	*pprog = prog;
+	emit_insn_suffix(jit, dst_reg, src_reg, off);
 }
 
 /* STX: *(u8*)(dst_reg + index_reg + off) = src_reg */
-static void emit_stx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32 index_reg, int off)
+static void emit_stx_index(struct jit_emit_context *jit, u32 size, u32 dst_reg, u32 src_reg,
+			   u32 index_reg, int off)
 {
-	u8 *prog = *pprog;
-
 	switch (size) {
 	case BPF_B:
 		/* mov byte ptr [rax + r12 + off], al */
@@ -1290,20 +1202,18 @@ static void emit_stx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32 i
 		EMIT2(add_3mod(0x48, dst_reg, src_reg, index_reg), 0x89);
 		break;
 	}
-	emit_insn_suffix_SIB(&prog, dst_reg, src_reg, index_reg, off);
-	*pprog = prog;
+	emit_insn_suffix_SIB(jit, dst_reg, src_reg, index_reg, off);
 }
 
-static void emit_stx_r12(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
+static void emit_stx_r12(struct jit_emit_context *jit, u32 size, u32 dst_reg, u32 src_reg, int off)
 {
-	emit_stx_index(pprog, size, dst_reg, src_reg, X86_REG_R12, off);
+	emit_stx_index(jit, size, dst_reg, src_reg, X86_REG_R12, off);
 }
 
 /* ST: *(u8*)(dst_reg + index_reg + off) = imm32 */
-static void emit_st_index(u8 **pprog, u32 size, u32 dst_reg, u32 index_reg, int off, int imm)
+static void emit_st_index(struct jit_emit_context *jit, u32 size, u32 dst_reg, u32 index_reg,
+			  int off, int imm)
 {
-	u8 *prog = *pprog;
-
 	switch (size) {
 	case BPF_B:
 		/* mov byte ptr [rax + r12 + off], imm8 */
@@ -1322,35 +1232,32 @@ static void emit_st_index(u8 **pprog, u32 size, u32 dst_reg, u32 index_reg, int
 		EMIT2(add_3mod(0x48, dst_reg, 0, index_reg), 0xC7);
 		break;
 	}
-	emit_insn_suffix_SIB(&prog, dst_reg, 0, index_reg, off);
+	emit_insn_suffix_SIB(jit, dst_reg, 0, index_reg, off);
 	EMIT(imm, bpf_size_to_x86_bytes(size));
-	*pprog = prog;
 }
 
-static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
+static void emit_st_r12(struct jit_emit_context *jit, u32 size, u32 dst_reg, int off, int imm)
 {
-	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
+	emit_st_index(jit, size, dst_reg, X86_REG_R12, off, imm);
 }
 
-static void emit_store_stack_imm64(u8 **pprog, int reg, int stack_off, u64 imm64)
+static void emit_store_stack_imm64(struct jit_emit_context *jit, int reg, int stack_off, u64 imm64)
 {
 	/*
 	 * mov reg, imm64
 	 * mov QWORD PTR [rbp + stack_off], reg
 	 */
-	emit_mov_imm64(pprog, reg, imm64 >> 32, (u32) imm64);
-	emit_stx(pprog, BPF_DW, BPF_REG_FP, reg, stack_off);
+	emit_mov_imm64(jit, reg, imm64 >> 32, (u32) imm64);
+	emit_stx(jit, BPF_DW, BPF_REG_FP, reg, stack_off);
 }
 
-static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
+static int emit_atomic_rmw(struct jit_emit_context *jit, u32 atomic_op,
 			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {
-	u8 *prog = *pprog;
-
 	if (atomic_op != BPF_XCHG)
 		EMIT1(0xF0); /* lock prefix */
 
-	maybe_emit_mod(&prog, dst_reg, src_reg, bpf_size == BPF_DW);
+	maybe_emit_mod(jit, dst_reg, src_reg, bpf_size == BPF_DW);
 
 	/* emit opcode */
 	switch (atomic_op) {
@@ -1378,18 +1285,15 @@ static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 		return -EFAULT;
 	}
 
-	emit_insn_suffix(&prog, dst_reg, src_reg, off);
+	emit_insn_suffix(jit, dst_reg, src_reg, off);
 
-	*pprog = prog;
 	return 0;
 }
 
-static int emit_atomic_rmw_index(u8 **pprog, u32 atomic_op, u32 size,
+static int emit_atomic_rmw_index(struct jit_emit_context *jit, u32 atomic_op, u32 size,
 				 u32 dst_reg, u32 src_reg, u32 index_reg,
 				 int off)
 {
-	u8 *prog = *pprog;
-
 	if (atomic_op != BPF_XCHG)
 		EMIT1(0xF0); /* lock prefix */
 
@@ -1430,22 +1334,21 @@ static int emit_atomic_rmw_index(u8 **pprog, u32 atomic_op, u32 size,
 		pr_err("bpf_jit: unknown atomic opcode %02x\n", atomic_op);
 		return -EFAULT;
 	}
-	emit_insn_suffix_SIB(&prog, dst_reg, src_reg, index_reg, off);
-	*pprog = prog;
+	emit_insn_suffix_SIB(jit, dst_reg, src_reg, index_reg, off);
 	return 0;
 }
 
-static int emit_atomic_ld_st(u8 **pprog, u32 atomic_op, u32 dst_reg,
+static int emit_atomic_ld_st(struct jit_emit_context *jit, u32 atomic_op, u32 dst_reg,
 			     u32 src_reg, s16 off, u8 bpf_size)
 {
 	switch (atomic_op) {
 	case BPF_LOAD_ACQ:
 		/* dst_reg = smp_load_acquire(src_reg + off16) */
-		emit_ldx(pprog, bpf_size, dst_reg, src_reg, off);
+		emit_ldx(jit, bpf_size, dst_reg, src_reg, off);
 		break;
 	case BPF_STORE_REL:
 		/* smp_store_release(dst_reg + off16, src_reg) */
-		emit_stx(pprog, bpf_size, dst_reg, src_reg, off);
+		emit_stx(jit, bpf_size, dst_reg, src_reg, off);
 		break;
 	default:
 		pr_err("bpf_jit: unknown atomic load/store opcode %02x\n",
@@ -1456,18 +1359,18 @@ static int emit_atomic_ld_st(u8 **pprog, u32 atomic_op, u32 dst_reg,
 	return 0;
 }
 
-static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
+static int emit_atomic_ld_st_index(struct jit_emit_context *jit, u32 atomic_op, u32 size,
 				   u32 dst_reg, u32 src_reg, u32 index_reg,
 				   int off)
 {
 	switch (atomic_op) {
 	case BPF_LOAD_ACQ:
 		/* dst_reg = smp_load_acquire(src_reg + idx_reg + off16) */
-		emit_ldx_index(pprog, size, dst_reg, src_reg, index_reg, off);
+		emit_ldx_index(jit, size, dst_reg, src_reg, index_reg, off);
 		break;
 	case BPF_STORE_REL:
 		/* smp_store_release(dst_reg + idx_reg + off16, src_reg) */
-		emit_stx_index(pprog, size, dst_reg, src_reg, index_reg, off);
+		emit_stx_index(jit, size, dst_reg, src_reg, index_reg, off);
 		break;
 	default:
 		pr_err("bpf_jit: unknown atomic load/store opcode %02x\n",
@@ -1574,10 +1477,9 @@ static void detect_reg_usage(struct bpf_insn *insn, int insn_cnt,
  * l: vector length (128 bit or 256 bit) or reserved
  * pp: opcode prefix (none, 0x66, 0xf2 or 0xf3)
  */
-static void emit_3vex(u8 **pprog, bool r, bool x, bool b, u8 m,
+static void emit_3vex(struct jit_emit_context *jit, bool r, bool x, bool b, u8 m,
 		      bool w, u8 src_reg2, bool l, u8 pp)
 {
-	u8 *prog = *pprog;
 	const u8 b0 = 0xc4; /* first byte of 3-byte VEX prefix */
 	u8 b1, b2;
 	u8 vvvv = reg2hex[src_reg2];
@@ -1607,27 +1509,22 @@ static void emit_3vex(u8 **pprog, bool r, bool x, bool b, u8 m,
 	b2 = (w << 7) | ((~vvvv & 0xf) << 3) | (l << 2) | (pp & 3);
 
 	EMIT3(b0, b1, b2);
-	*pprog = prog;
 }
 
 /* emit BMI2 shift instruction */
-static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
+static void emit_shiftx(struct jit_emit_context *jit, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 {
-	u8 *prog = *pprog;
 	bool r = is_ereg(dst_reg);
 	u8 m = 2; /* escape code 0f38 */
 
-	emit_3vex(&prog, r, false, r, m, is64, src_reg, false, op);
+	emit_3vex(jit, r, false, r, m, is64, src_reg, false, op);
 	EMIT2(0xf7, add_2reg(0xC0, dst_reg, dst_reg));
-	*pprog = prog;
 }
 
-static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_ptr)
+static void emit_priv_frame_ptr(struct jit_emit_context *jit, void __percpu *priv_frame_ptr)
 {
-	u8 *prog = *pprog;
-
 	/* movabs r9, priv_frame_ptr */
-	emit_mov_imm64(&prog, X86_REG_R9, (__force long) priv_frame_ptr >> 32,
+	emit_mov_imm64(jit, X86_REG_R9, (__force long) priv_frame_ptr >> 32,
 		       (u32) (__force long) priv_frame_ptr);
 
 #ifdef CONFIG_SMP
@@ -1636,11 +1533,9 @@ static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_ptr)
 	EMIT3(0x03, 0x0c, 0x25);
 	EMIT((u32)(unsigned long)&this_cpu_off, 4);
 #endif
-
-	*pprog = prog;
 }
 
-#define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
+#define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (jit->prog - temp)))
 
 #define __LOAD_TCC_PTR(off)			\
 	EMIT3_off32(0x48, 0x8B, 0x85, off)
@@ -1652,10 +1547,9 @@ static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_ptr)
 #define PRIV_STACK_GUARD_SZ    8
 #define PRIV_STACK_GUARD_VAL   0xEB9F12345678eb9fULL
 
-static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
+static int emit_spectre_bhb_barrier(struct jit_emit_context *jit, u8 *ip,
 				    struct bpf_prog *bpf_prog)
 {
-	u8 *prog = *pprog;
 	u8 *func;
 
 	if (cpu_feature_enabled(X86_FEATURE_CLEAR_BHB_LOOP)) {
@@ -1665,9 +1559,9 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
 		ip += 2;
 
 		func = (u8 *)clear_bhb_loop;
-		ip += bpf_call_depth_emit_accounting(&prog, func, ip);
+		ip += bpf_call_depth_emit_accounting(jit, func, ip);
 
-		if (emit_call(&prog, func, ip))
+		if (emit_call(jit, func, ip))
 			return -EINVAL;
 		EMIT1(0x59); /* pop rcx */
 		EMIT1(0x58); /* pop rax */
@@ -1690,7 +1584,6 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
 		 */
 		EMIT5(0xF3, 0x48, 0x0F, 0x1E, 0xF8); /* ibhf */
 	}
-	*pprog = prog;
 	return 0;
 }
 
@@ -1701,10 +1594,9 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
  * arena NULL is offset 0. Return the number of emitted bytes.
  */
 static int emit_kfunc_arena_args(struct bpf_prog *bpf_prog,
-				 const struct btf_func_model *fm, u8 **pprog)
+				 const struct btf_func_model *fm, struct jit_emit_context *jit)
 {
-	u8 *prog = *pprog;
-	u8 *start = prog;
+	u8 *start = jit->prog;
 	int i;
 
 	for (i = 0; i < min_t(int, fm->nr_args, MAX_BPF_FUNC_REG_ARGS); i++) {
@@ -1717,20 +1609,19 @@ static int emit_kfunc_arena_args(struct bpf_prog *bpf_prog,
 			return -EINVAL;
 
 		/* mov eN, eN: truncate and clear the upper 32 bits */
-		emit_mov_reg(&prog, false, reg, reg);
+		emit_mov_reg(jit, false, reg, reg);
 		if (flags & BTF_FMODEL_NULLABLE_ARG) {
 			/* test eN, eN; jz over the 3-byte add */
-			maybe_emit_mod(&prog, reg, reg, false);
+			maybe_emit_mod(jit, reg, reg, false);
 			EMIT2(0x85, add_2reg(0xC0, reg, reg));
 			EMIT2(X86_JE, 3);
 		}
 		/* add rN, r12 */
-		maybe_emit_mod(&prog, reg, X86_REG_R12, true);
+		maybe_emit_mod(jit, reg, X86_REG_R12, true);
 		EMIT2(0x01, add_2reg(0xC0, reg, X86_REG_R12));
 	}
 
-	*pprog = prog;
-	return prog - start;
+	return jit->prog - start;
 }
 
 static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *addrs, u8 *image,
@@ -1738,6 +1629,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 {
 	bool tail_call_reachable = bpf_prog->aux->tail_call_reachable;
 	struct bpf_insn *insn = bpf_prog->insnsi;
+	struct jit_emit_context *jit = &ctx->jit;
 	bool callee_regs_used[4] = {};
 	int insn_cnt = bpf_prog->len;
 	bool seen_exit = false;
@@ -1748,12 +1640,14 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	void __percpu *priv_stack_ptr;
 	int i, excnt = 0;
 	int ilen, proglen = 0;
-	u8 *ip, *prog = temp;
+	u8 *ip;
 	u32 stack_depth;
 	int callee_saved_size;
 	s32 outgoing_arg_base;
 	int err;
 
+	jit->prog = temp;
+
 	stack_depth = bpf_prog->aux->stack_depth;
 	out_stack_arg_cnt = bpf_out_stack_arg_cnt(env, bpf_prog);
 	priv_stack_ptr = bpf_prog->aux->priv_stack_ptr;
@@ -1789,11 +1683,11 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 	detect_reg_usage(insn, insn_cnt, callee_regs_used);
 
-	emit_prologue(&prog, image, stack_depth,
+	emit_prologue(jit, image, stack_depth,
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
 		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
 
-	bpf_prog->aux->ksym.fp_start = prog - temp;
+	bpf_prog->aux->ksym.fp_start = jit->prog - temp;
 
 	/* Exception callback will clobber callee regs for its own use, and
 	 * restore the original callee regs from main prog's stack frame.
@@ -1803,12 +1697,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		 * register, as we throw after entry into the kernel, which may
 		 * overwrite r12.
 		 */
-		push_r12(&prog);
-		push_callee_regs(&prog, all_callee_regs_used);
+		push_r12(jit);
+		push_callee_regs(jit, all_callee_regs_used);
 	} else {
 		if (arena_vm_start)
-			push_r12(&prog);
-		push_callee_regs(&prog, callee_regs_used);
+			push_r12(jit);
+		push_callee_regs(jit, callee_regs_used);
 	}
 
 	/* Compute callee-saved register area size. */
@@ -1846,21 +1740,21 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	outgoing_rsp = out_stack_arg_cnt > 1 ? (out_stack_arg_cnt - 1) * 8 : 0;
 	if (bpf_prog->aux->exception_boundary)
 		bpf_prog->aux->stack_arg_sp_adjust = outgoing_rsp;
-	emit_sub_rsp(&prog, outgoing_rsp);
+	emit_sub_rsp(jit, outgoing_rsp);
 
 	if (arena_vm_start)
-		emit_mov_imm64(&prog, X86_REG_R12,
+		emit_mov_imm64(jit, X86_REG_R12,
 			       arena_vm_start >> 32, (u32) arena_vm_start);
 
 	if (priv_frame_ptr)
-		emit_priv_frame_ptr(&prog, priv_frame_ptr);
+		emit_priv_frame_ptr(jit, priv_frame_ptr);
 
-	ilen = prog - temp;
+	ilen = jit->prog - temp;
 	if (rw_image)
 		memcpy(rw_image + proglen, temp, ilen);
 	proglen += ilen;
 	addrs[0] = proglen;
-	prog = temp;
+	jit->prog = temp;
 
 	for (i = 1; i <= insn_cnt; i++, insn++) {
 		const s32 imm32 = insn->imm;
@@ -1885,7 +1779,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
 			EMIT_ENDBR();
 
-		ip = image + addrs[i - 1] + (prog - temp);
+		ip = image + addrs[i - 1] + (jit->prog - temp);
 
 		switch (insn->code) {
 			/* ALU */
@@ -1899,7 +1793,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		case BPF_ALU64 | BPF_AND | BPF_X:
 		case BPF_ALU64 | BPF_OR | BPF_X:
 		case BPF_ALU64 | BPF_XOR | BPF_X:
-			maybe_emit_mod(&prog, dst_reg, src_reg,
+			maybe_emit_mod(jit, dst_reg, src_reg,
 				       BPF_CLASS(insn->code) == BPF_ALU64);
 			b2 = simple_alu_opcodes[BPF_OP(insn->code)];
 			EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
@@ -1909,32 +1803,32 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			if (insn_is_cast_user(insn)) {
 				if (dst_reg != src_reg)
 					/* 32-bit mov */
-					emit_mov_reg(&prog, false, dst_reg, src_reg);
+					emit_mov_reg(jit, false, dst_reg, src_reg);
 				/* shl dst_reg, 32 */
-				maybe_emit_1mod(&prog, dst_reg, true);
+				maybe_emit_1mod(jit, dst_reg, true);
 				EMIT3(0xC1, add_1reg(0xE0, dst_reg), 32);
 
 				/* or dst_reg, user_vm_start */
-				maybe_emit_1mod(&prog, dst_reg, true);
+				maybe_emit_1mod(jit, dst_reg, true);
 				if (is_axreg(dst_reg))
 					EMIT1_off32(0x0D,  user_vm_start >> 32);
 				else
 					EMIT2_off32(0x81, add_1reg(0xC8, dst_reg),  user_vm_start >> 32);
 
 				/* rol dst_reg, 32 */
-				maybe_emit_1mod(&prog, dst_reg, true);
+				maybe_emit_1mod(jit, dst_reg, true);
 				EMIT3(0xC1, add_1reg(0xC0, dst_reg), 32);
 
 				/* xor r11, r11 */
 				EMIT3(0x4D, 0x31, 0xDB);
 
 				/* test dst_reg32, dst_reg32; check if lower 32-bit are zero */
-				maybe_emit_mod(&prog, dst_reg, dst_reg, false);
+				maybe_emit_mod(jit, dst_reg, dst_reg, false);
 				EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
 
 				/* cmove r11, dst_reg; if so, set dst_reg to zero */
 				/* WARNING: Intel swapped src/dst register encoding in CMOVcc !!! */
-				maybe_emit_mod(&prog, AUX_REG, dst_reg, true);
+				maybe_emit_mod(jit, AUX_REG, dst_reg, true);
 				EMIT3(0x0F, 0x44, add_2reg(0xC0, AUX_REG, dst_reg));
 				break;
 			} else if (insn_is_mov_percpu_addr(insn)) {
@@ -1951,11 +1845,11 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			fallthrough;
 		case BPF_ALU | BPF_MOV | BPF_X:
 			if (insn->off == 0)
-				emit_mov_reg(&prog,
+				emit_mov_reg(jit,
 					     BPF_CLASS(insn->code) == BPF_ALU64,
 					     dst_reg, src_reg);
 			else
-				emit_movsx_reg(&prog, insn->off,
+				emit_movsx_reg(jit, insn->off,
 					       BPF_CLASS(insn->code) == BPF_ALU64,
 					       dst_reg, src_reg);
 			break;
@@ -1963,7 +1857,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			/* neg dst */
 		case BPF_ALU | BPF_NEG:
 		case BPF_ALU64 | BPF_NEG:
-			maybe_emit_1mod(&prog, dst_reg,
+			maybe_emit_1mod(jit, dst_reg,
 					BPF_CLASS(insn->code) == BPF_ALU64);
 			EMIT2(0xF7, add_1reg(0xD8, dst_reg));
 			break;
@@ -1978,7 +1872,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		case BPF_ALU64 | BPF_AND | BPF_K:
 		case BPF_ALU64 | BPF_OR | BPF_K:
 		case BPF_ALU64 | BPF_XOR | BPF_K:
-			maybe_emit_1mod(&prog, dst_reg,
+			maybe_emit_1mod(jit, dst_reg,
 					BPF_CLASS(insn->code) == BPF_ALU64);
 
 			/*
@@ -2018,12 +1912,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 		case BPF_ALU64 | BPF_MOV | BPF_K:
 		case BPF_ALU | BPF_MOV | BPF_K:
-			emit_mov_imm32(&prog, BPF_CLASS(insn->code) == BPF_ALU64,
+			emit_mov_imm32(jit, BPF_CLASS(insn->code) == BPF_ALU64,
 				       dst_reg, imm32);
 			break;
 
 		case BPF_LD | BPF_IMM | BPF_DW:
-			emit_mov_imm64(&prog, dst_reg, insn[1].imm, insn[0].imm);
+			emit_mov_imm64(jit, dst_reg, insn[1].imm, insn[0].imm);
 			insn++;
 			i++;
 			break;
@@ -2059,7 +1953,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 			if (dst_reg != BPF_REG_0)
 				/* mov rax, dst_reg */
-				emit_mov_reg(&prog, is64, BPF_REG_0, dst_reg);
+				emit_mov_reg(jit, is64, BPF_REG_0, dst_reg);
 
 			if (insn->off == 0) {
 				/*
@@ -2069,7 +1963,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				EMIT2(0x31, 0xd2);
 
 				/* div src_reg */
-				maybe_emit_1mod(&prog, src_reg, is64);
+				maybe_emit_1mod(jit, src_reg, is64);
 				EMIT2(0xF7, add_1reg(0xF0, src_reg));
 			} else {
 				if (BPF_CLASS(insn->code) == BPF_ALU)
@@ -2078,18 +1972,18 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 					EMIT2(0x48, 0x99); /* cqo */
 
 				/* idiv src_reg */
-				maybe_emit_1mod(&prog, src_reg, is64);
+				maybe_emit_1mod(jit, src_reg, is64);
 				EMIT2(0xF7, add_1reg(0xF8, src_reg));
 			}
 
 			if (BPF_OP(insn->code) == BPF_MOD &&
 			    dst_reg != BPF_REG_3)
 				/* mov dst_reg, rdx */
-				emit_mov_reg(&prog, is64, dst_reg, BPF_REG_3);
+				emit_mov_reg(jit, is64, dst_reg, BPF_REG_3);
 			else if (BPF_OP(insn->code) == BPF_DIV &&
 				 dst_reg != BPF_REG_0)
 				/* mov dst_reg, rax */
-				emit_mov_reg(&prog, is64, dst_reg, BPF_REG_0);
+				emit_mov_reg(jit, is64, dst_reg, BPF_REG_0);
 
 			if (dst_reg != BPF_REG_3)
 				EMIT1(0x5A); /* pop rdx */
@@ -2100,7 +1994,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 		case BPF_ALU | BPF_MUL | BPF_K:
 		case BPF_ALU64 | BPF_MUL | BPF_K:
-			maybe_emit_mod(&prog, dst_reg, dst_reg,
+			maybe_emit_mod(jit, dst_reg, dst_reg,
 				       BPF_CLASS(insn->code) == BPF_ALU64);
 
 			if (is_imm8(imm32))
@@ -2116,7 +2010,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 		case BPF_ALU | BPF_MUL | BPF_X:
 		case BPF_ALU64 | BPF_MUL | BPF_X:
-			maybe_emit_mod(&prog, src_reg, dst_reg,
+			maybe_emit_mod(jit, src_reg, dst_reg,
 				       BPF_CLASS(insn->code) == BPF_ALU64);
 
 			/* imul dst_reg, src_reg */
@@ -2130,7 +2024,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		case BPF_ALU64 | BPF_LSH | BPF_K:
 		case BPF_ALU64 | BPF_RSH | BPF_K:
 		case BPF_ALU64 | BPF_ARSH | BPF_K:
-			maybe_emit_1mod(&prog, dst_reg,
+			maybe_emit_1mod(jit, dst_reg,
 					BPF_CLASS(insn->code) == BPF_ALU64);
 
 			b3 = simple_alu_opcodes[BPF_OP(insn->code)];
@@ -2164,7 +2058,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 					break;
 				}
 
-				emit_shiftx(&prog, dst_reg, src_reg, w, op);
+				emit_shiftx(jit, dst_reg, src_reg, w, op);
 
 				break;
 			}
@@ -2183,7 +2077,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			}
 
 			/* shl %rax, %cl | shr %rax, %cl | sar %rax, %cl */
-			maybe_emit_1mod(&prog, dst_reg,
+			maybe_emit_1mod(jit, dst_reg,
 					BPF_CLASS(insn->code) == BPF_ALU64);
 
 			b3 = simple_alu_opcodes[BPF_OP(insn->code)];
@@ -2284,7 +2178,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		case BPF_ST | BPF_MEM | BPF_DW:
 			if (dst_reg == BPF_REG_PARAMS && insn->off == -8) {
 				/* Arg 6: store immediate in r9 register */
-				emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31, (u32)imm32);
+				emit_mov_imm64(jit, X86_REG_R9, imm32 >> 31, (u32)imm32);
 				break;
 			}
 			EMIT2(add_1mod(0x48, dst_reg), 0xC7);
@@ -2322,15 +2216,15 @@ st:			insn_off = insn->off;
 				insn_off = outgoing_arg_base - outgoing_rsp - insn_off - 16;
 				dst_reg = BPF_REG_FP;
 			}
-			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
+			emit_stx(jit, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
 			break;
 
 		case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
 		case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
 		case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
 		case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
-			start_of_ldx = prog;
-			emit_st_r12(&prog, BPF_SIZE(insn->code), dst_reg, insn->off, insn->imm);
+			start_of_ldx = jit->prog;
+			emit_st_r12(jit, BPF_SIZE(insn->code), dst_reg, insn->off, insn->imm);
 			goto populate_extable;
 
 			/* LDX: dst_reg = *(u8*)(src_reg + r12 + off) */
@@ -2345,14 +2239,14 @@ st:			insn_off = insn->off;
 		case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
 		case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
 		case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
-			start_of_ldx = prog;
+			start_of_ldx = jit->prog;
 			if (BPF_CLASS(insn->code) == BPF_LDX) {
 				if (BPF_MODE(insn->code) == BPF_PROBE_MEM32SX)
-					emit_ldsx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
+					emit_ldsx_r12(jit, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
 				else
-					emit_ldx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
+					emit_ldx_r12(jit, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
 			} else {
-				emit_stx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
+				emit_stx_r12(jit, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
 			}
 populate_extable:
 			{
@@ -2413,7 +2307,7 @@ st:			insn_off = insn->off;
 					is_write = true;
 				}
 
-				ex->fixup = FIELD_PREP(FIXUP_INSN_LEN_MASK, prog - start_of_ldx) |
+				ex->fixup = FIELD_PREP(FIXUP_INSN_LEN_MASK, jit->prog - start_of_ldx) |
 					    FIELD_PREP(FIXUP_ARENA_REG_MASK, arena_reg) |
 					    FIELD_PREP(FIXUP_REG_MASK, fixup_reg);
 				ex->fixup |= FIXUP_ARENA_ACCESS;
@@ -2467,7 +2361,7 @@ st:			insn_off = insn->off;
 				u8 *end_of_jmp;
 
 				/* movabsq r10, VSYSCALL_ADDR */
-				emit_mov_imm64(&prog, BPF_REG_AX, (long)VSYSCALL_ADDR >> 32,
+				emit_mov_imm64(jit, BPF_REG_AX, (long)VSYSCALL_ADDR >> 32,
 					       (u32)(long)VSYSCALL_ADDR);
 
 				/* mov src_reg, r11 */
@@ -2475,40 +2369,40 @@ st:			insn_off = insn->off;
 
 				if (insn->off) {
 					/* add r11, insn->off */
-					maybe_emit_1mod(&prog, AUX_REG, true);
+					maybe_emit_1mod(jit, AUX_REG, true);
 					EMIT2_off32(0x81, add_1reg(0xC0, AUX_REG), insn->off);
 				}
 
 				/* sub r11, r10 */
-				maybe_emit_mod(&prog, AUX_REG, BPF_REG_AX, true);
+				maybe_emit_mod(jit, AUX_REG, BPF_REG_AX, true);
 				EMIT2(0x29, add_2reg(0xC0, AUX_REG, BPF_REG_AX));
 
 				/* movabsq r10, limit */
-				emit_mov_imm64(&prog, BPF_REG_AX, (long)limit >> 32,
+				emit_mov_imm64(jit, BPF_REG_AX, (long)limit >> 32,
 					       (u32)(long)limit);
 
 				/* cmp r10, r11 */
-				maybe_emit_mod(&prog, AUX_REG, BPF_REG_AX, true);
+				maybe_emit_mod(jit, AUX_REG, BPF_REG_AX, true);
 				EMIT2(0x39, add_2reg(0xC0, AUX_REG, BPF_REG_AX));
 
 				/* if unsigned '>', goto load */
 				EMIT2(X86_JA, 0);
-				end_of_jmp = prog;
+				end_of_jmp = jit->prog;
 
 				/* xor dst_reg, dst_reg */
-				emit_mov_imm32(&prog, false, dst_reg, 0);
+				emit_mov_imm32(jit, false, dst_reg, 0);
 				/* jmp byte_after_ldx */
 				EMIT2(0xEB, 0);
 
 				/* populate jmp_offset for JAE above to jump to start_of_ldx */
-				start_of_ldx = prog;
+				start_of_ldx = jit->prog;
 				end_of_jmp[-1] = start_of_ldx - end_of_jmp;
 			}
 			if (BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
 			    BPF_MODE(insn->code) == BPF_MEMSX)
-				emit_ldsx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
+				emit_ldsx(jit, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
 			else
-				emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
+				emit_ldx(jit, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
 			if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
 			    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
 				struct exception_table_entry *ex;
@@ -2516,7 +2410,7 @@ st:			insn_off = insn->off;
 				s64 delta;
 
 				/* populate jmp_offset for JMP above */
-				start_of_ldx[-1] = prog - start_of_ldx;
+				start_of_ldx[-1] = jit->prog - start_of_ldx;
 
 				if (!bpf_prog->aux->extable)
 					break;
@@ -2551,7 +2445,7 @@ st:			insn_off = insn->off;
 				 * End result: x86 insn "mov rbx, qword ptr [rax+0x14]"
 				 * of 4 bytes will be ignored and rbx will be zero inited.
 				 */
-				ex->fixup = FIELD_PREP(FIXUP_INSN_LEN_MASK, prog - start_of_ldx) |
+				ex->fixup = FIELD_PREP(FIXUP_INSN_LEN_MASK, jit->prog - start_of_ldx) |
 					    FIELD_PREP(FIXUP_REG_MASK, reg2pt_regs[dst_reg]);
 			}
 			break;
@@ -2579,26 +2473,26 @@ st:			insn_off = insn->off;
 				 */
 
 				/* Will need RAX as a CMPXCHG operand so save R0 */
-				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
+				emit_mov_reg(jit, true, BPF_REG_AX, BPF_REG_0);
 				if (src_reg == BPF_REG_0)
 					real_src_reg = BPF_REG_AX;
 				if (dst_reg == BPF_REG_0)
 					real_dst_reg = BPF_REG_AX;
 
-				branch_target = prog;
+				branch_target = jit->prog;
 				/* Load old value */
-				emit_ldx(&prog, BPF_SIZE(insn->code),
+				emit_ldx(jit, BPF_SIZE(insn->code),
 					 BPF_REG_0, real_dst_reg, insn->off);
 				/*
 				 * Perform the (commutative) operation locally,
 				 * put the result in the AUX_REG.
 				 */
-				emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
-				maybe_emit_mod(&prog, AUX_REG, real_src_reg, is64);
+				emit_mov_reg(jit, is64, AUX_REG, BPF_REG_0);
+				maybe_emit_mod(jit, AUX_REG, real_src_reg, is64);
 				EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
 				      add_2reg(0xC0, AUX_REG, real_src_reg));
 				/* Attempt to swap in new value */
-				err = emit_atomic_rmw(&prog, BPF_CMPXCHG,
+				err = emit_atomic_rmw(jit, BPF_CMPXCHG,
 						      real_dst_reg, AUX_REG,
 						      insn->off,
 						      BPF_SIZE(insn->code));
@@ -2608,19 +2502,19 @@ st:			insn_off = insn->off;
 				 * ZF tells us whether we won the race. If it's
 				 * cleared we need to try again.
 				 */
-				EMIT2(X86_JNE, -(prog - branch_target) - 2);
+				EMIT2(X86_JNE, -(jit->prog - branch_target) - 2);
 				/* Return the pre-modification value */
-				emit_mov_reg(&prog, is64, real_src_reg, BPF_REG_0);
+				emit_mov_reg(jit, is64, real_src_reg, BPF_REG_0);
 				/* Restore R0 after clobbering RAX */
-				emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
+				emit_mov_reg(jit, true, BPF_REG_0, BPF_REG_AX);
 				break;
 			}
 
 			if (bpf_atomic_is_load_store(insn))
-				err = emit_atomic_ld_st(&prog, insn->imm, dst_reg, src_reg,
+				err = emit_atomic_ld_st(jit, insn->imm, dst_reg, src_reg,
 							insn->off, BPF_SIZE(insn->code));
 			else
-				err = emit_atomic_rmw(&prog, insn->imm, dst_reg, src_reg,
+				err = emit_atomic_rmw(jit, insn->imm, dst_reg, src_reg,
 						      insn->off, BPF_SIZE(insn->code));
 			if (err)
 				return err;
@@ -2635,14 +2529,14 @@ st:			insn_off = insn->off;
 			fallthrough;
 		case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
 		case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
-			start_of_ldx = prog;
+			start_of_ldx = jit->prog;
 
 			if (bpf_atomic_is_load_store(insn))
-				err = emit_atomic_ld_st_index(&prog, insn->imm,
+				err = emit_atomic_ld_st_index(jit, insn->imm,
 							      BPF_SIZE(insn->code), dst_reg,
 							      src_reg, X86_REG_R12, insn->off);
 			else
-				err = emit_atomic_rmw_index(&prog, insn->imm, BPF_SIZE(insn->code),
+				err = emit_atomic_rmw_index(jit, insn->imm, BPF_SIZE(insn->code),
 							    dst_reg, src_reg, X86_REG_R12,
 							    insn->off);
 			if (err)
@@ -2664,20 +2558,20 @@ st:			insn_off = insn->off;
 				fm = bpf_jit_find_kfunc_model(bpf_prog, insn);
 				if (!fm)
 					return -EINVAL;
-				err = emit_kfunc_arena_args(bpf_prog, fm, &prog);
+				err = emit_kfunc_arena_args(bpf_prog, fm, jit);
 				if (err < 0)
 					return err;
 				ip += err;
 			}
 			if (priv_frame_ptr) {
-				push_r9(&prog);
+				push_r9(jit);
 				ip += 2;
 			}
-			ip += bpf_call_depth_emit_accounting(&prog, func, ip);
-			if (emit_call(&prog, func, ip))
+			ip += bpf_call_depth_emit_accounting(jit, func, ip);
+			if (emit_call(jit, func, ip))
 				return -EINVAL;
 			if (priv_frame_ptr)
-				pop_r9(&prog);
+				pop_r9(jit);
 			/*
 			 * A kfunc returning more than 8 bytes hands the second
 			 * half back in RDX (the native ABI's second return reg),
@@ -2685,7 +2579,7 @@ st:			insn_off = insn->off;
 			 * needed), while BPF R2 is RSI, so copy RDX into RSI.
 			 */
 			if (fm && fm->ret_size > 8)
-				emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_3);
+				emit_mov_reg(jit, true, BPF_REG_2, BPF_REG_3);
 			break;
 		}
 
@@ -2693,14 +2587,12 @@ st:			insn_off = insn->off;
 			if (imm32)
 				emit_bpf_tail_call_direct(bpf_prog,
 							  &bpf_prog->aux->poke_tab[imm32 - 1],
-							  &prog,
 							  ip,
 							  callee_regs_used,
 							  stack_depth,
 							  ctx);
 			else
 				emit_bpf_tail_call_indirect(bpf_prog,
-							    &prog,
 							    callee_regs_used,
 							    stack_depth,
 							    ip,
@@ -2729,7 +2621,7 @@ st:			insn_off = insn->off;
 		case BPF_JMP32 | BPF_JSGE | BPF_X:
 		case BPF_JMP32 | BPF_JSLE | BPF_X:
 			/* cmp dst_reg, src_reg */
-			maybe_emit_mod(&prog, dst_reg, src_reg,
+			maybe_emit_mod(jit, dst_reg, src_reg,
 				       BPF_CLASS(insn->code) == BPF_JMP);
 			EMIT2(0x39, add_2reg(0xC0, dst_reg, src_reg));
 			goto emit_cond_jmp;
@@ -2737,7 +2629,7 @@ st:			insn_off = insn->off;
 		case BPF_JMP | BPF_JSET | BPF_X:
 		case BPF_JMP32 | BPF_JSET | BPF_X:
 			/* test dst_reg, src_reg */
-			maybe_emit_mod(&prog, dst_reg, src_reg,
+			maybe_emit_mod(jit, dst_reg, src_reg,
 				       BPF_CLASS(insn->code) == BPF_JMP);
 			EMIT2(0x85, add_2reg(0xC0, dst_reg, src_reg));
 			goto emit_cond_jmp;
@@ -2745,7 +2637,7 @@ st:			insn_off = insn->off;
 		case BPF_JMP | BPF_JSET | BPF_K:
 		case BPF_JMP32 | BPF_JSET | BPF_K:
 			/* test dst_reg, imm32 */
-			maybe_emit_1mod(&prog, dst_reg,
+			maybe_emit_1mod(jit, dst_reg,
 					BPF_CLASS(insn->code) == BPF_JMP);
 			EMIT2_off32(0xF7, add_1reg(0xC0, dst_reg), imm32);
 			goto emit_cond_jmp;
@@ -2772,14 +2664,14 @@ st:			insn_off = insn->off;
 		case BPF_JMP32 | BPF_JSLE | BPF_K:
 			/* test dst_reg, dst_reg to save one extra byte */
 			if (imm32 == 0) {
-				maybe_emit_mod(&prog, dst_reg, dst_reg,
+				maybe_emit_mod(jit, dst_reg, dst_reg,
 					       BPF_CLASS(insn->code) == BPF_JMP);
 				EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
 				goto emit_cond_jmp;
 			}
 
 			/* cmp dst_reg, imm8/32 */
-			maybe_emit_1mod(&prog, dst_reg,
+			maybe_emit_1mod(jit, dst_reg,
 					BPF_CLASS(insn->code) == BPF_JMP);
 
 			if (is_imm8(imm32))
@@ -2855,7 +2747,7 @@ st:			insn_off = insn->off;
 						       nops);
 						return -EFAULT;
 					}
-					emit_nops(&prog, nops);
+					emit_nops(jit, nops);
 				}
 				EMIT2(jmp_cond, jmp_offset);
 			} else if (is_simm32(jmp_offset)) {
@@ -2868,7 +2760,7 @@ st:			insn_off = insn->off;
 			break;
 
 		case BPF_JMP | BPF_JA | BPF_X:
-			emit_indirect_jump(&prog, insn->dst_reg, ip);
+			emit_indirect_jump(jit, insn->dst_reg, ip);
 			break;
 		case BPF_JMP | BPF_JA:
 		case BPF_JMP32 | BPF_JA:
@@ -2912,7 +2804,7 @@ st:			insn_off = insn->off;
 						       nops);
 						return -EFAULT;
 					}
-					emit_nops(&prog, nops);
+					emit_nops(jit, nops);
 				}
 				break;
 			}
@@ -2937,7 +2829,7 @@ st:			insn_off = insn->off;
 						       nops);
 						return -EFAULT;
 					}
-					emit_nops(&prog, INSN_SZ_DIFF - 2);
+					emit_nops(jit, INSN_SZ_DIFF - 2);
 				}
 				EMIT2(0xEB, jmp_offset);
 			} else if (is_simm32(jmp_offset)) {
@@ -2958,23 +2850,23 @@ st:			insn_off = insn->off;
 			ctx->cleanup_addr = proglen;
 			if (bpf_prog_was_classic(bpf_prog) &&
 			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
-				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
+				if (emit_spectre_bhb_barrier(jit, ip, bpf_prog))
 					return -EINVAL;
 			}
 			/* Deallocate outgoing args 7+ area. */
-			emit_add_rsp(&prog, outgoing_rsp);
+			emit_add_rsp(jit, outgoing_rsp);
 			if (bpf_prog->aux->exception_boundary) {
-				pop_callee_regs(&prog, all_callee_regs_used);
-				pop_r12(&prog);
+				pop_callee_regs(jit, all_callee_regs_used);
+				pop_r12(jit);
 			} else {
-				pop_callee_regs(&prog, callee_regs_used);
+				pop_callee_regs(jit, callee_regs_used);
 				if (arena_vm_start)
-					pop_r12(&prog);
+					pop_r12(jit);
 			}
 			EMIT1(0xC9);         /* leave */
-			bpf_prog->aux->ksym.fp_end = prog - temp;
+			bpf_prog->aux->ksym.fp_end = jit->prog - temp;
 
-			emit_return(&prog, image + addrs[i - 1] + (prog - temp));
+			emit_return(jit, image + addrs[i - 1] + (jit->prog - temp));
 			break;
 
 		default:
@@ -2988,7 +2880,7 @@ st:			insn_off = insn->off;
 			return -EINVAL;
 		}
 
-		ilen = prog - temp;
+		ilen = jit->prog - temp;
 		if (ilen > BPF_MAX_INSN_SIZE) {
 			pr_err("bpf_jit: fatal insn size error\n");
 			return -EFAULT;
@@ -3012,7 +2904,7 @@ st:			insn_off = insn->off;
 		}
 		proglen += ilen;
 		addrs[i] = proglen;
-		prog = temp;
+		jit->prog = temp;
 	}
 
 	if (image && excnt != bpf_prog->aux->num_exentries) {
@@ -3023,11 +2915,10 @@ st:			insn_off = insn->off;
 }
 
 static void clean_stack_garbage(const struct btf_func_model *m,
-				u8 **pprog, int nr_stack_slots,
+				struct jit_emit_context *jit, int nr_stack_slots,
 				int stack_size)
 {
 	int arg_size, off;
-	u8 *prog;
 
 	/* Generally speaking, the compiler will pass the arguments
 	 * on-stack with "push" instruction, which will take 8-byte
@@ -3059,14 +2950,12 @@ static void clean_stack_garbage(const struct btf_func_model *m,
 	arg_size = m->arg_size[m->nr_args - 1];
 	if (arg_size <= 4) {
 		off = -(stack_size - 4);
-		prog = *pprog;
 		/* mov DWORD PTR [rbp + off], 0 */
 		if (!is_imm8(off))
 			EMIT2_off32(0xC7, 0x85, off);
 		else
 			EMIT3(0xC7, 0x45, off);
 		EMIT(0, 4);
-		*pprog = prog;
 	}
 }
 
@@ -3094,26 +2983,23 @@ static int get_nr_used_regs(const struct btf_func_model *m)
  * subtraction both truncates and clears the upper half, so the stored
  * value satisfies the JIT invariant for arena pointer registers.
  */
-static void emit_arena_arg_conv(u8 **pprog, u32 src_reg, bool nullable, u32 base_lo)
+static void emit_arena_arg_conv(struct jit_emit_context *jit, u32 src_reg, bool nullable,
+				u32 base_lo)
 {
-	u8 *prog = *pprog;
-
 	if (nullable) {
 		if (src_reg != BPF_REG_0)
-			emit_mov_reg(&prog, true, BPF_REG_0, src_reg);
+			emit_mov_reg(jit, true, BPF_REG_0, src_reg);
 		/* test rax, rax; jz over the 5-byte sub */
 		EMIT3(0x48, 0x85, 0xC0);
 		EMIT2(X86_JE, 5);
 	} else if (src_reg != BPF_REG_0) {
-		emit_mov_reg(&prog, false, BPF_REG_0, src_reg);
+		emit_mov_reg(jit, false, BPF_REG_0, src_reg);
 	}
 	/* sub eax, base_lo */
 	EMIT1_off32(0x2D, base_lo);
-
-	*pprog = prog;
 }
 
-static void save_args(const struct btf_func_model *m, u8 **prog,
+static void save_args(const struct btf_func_model *m, struct jit_emit_context *jit,
 		      int stack_size, bool for_call_origin, u32 flags,
 		      u64 arena_base)
 {
@@ -3162,12 +3048,12 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 			 * called indirectly, so rbp + 16.
 			 */
 			for (j = 0; j < arg_regs; j++) {
-				emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
+				emit_ldx(jit, BPF_DW, BPF_REG_0, BPF_REG_FP,
 					 nr_stack_slots * 8 + stack_args_off);
 				if (arena_arg)
-					emit_arena_arg_conv(prog, BPF_REG_0, nullable,
+					emit_arena_arg_conv(jit, BPF_REG_0, nullable,
 							    (u32)arena_base);
-				emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
+				emit_stx(jit, BPF_DW, BPF_REG_FP, BPF_REG_0,
 					 -stack_size);
 
 				if (!nr_stack_slots)
@@ -3190,20 +3076,20 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 				u32 src = nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs;
 
 				if (arena_arg) {
-					emit_arena_arg_conv(prog, src, nullable, (u32)arena_base);
+					emit_arena_arg_conv(jit, src, nullable, (u32)arena_base);
 					src = BPF_REG_0;
 				}
-				emit_stx(prog, BPF_DW, BPF_REG_FP, src, -stack_size);
+				emit_stx(jit, BPF_DW, BPF_REG_FP, src, -stack_size);
 				stack_size -= 8;
 				nr_regs++;
 			}
 		}
 	}
 
-	clean_stack_garbage(m, prog, nr_stack_slots, first_off);
+	clean_stack_garbage(m, jit, nr_stack_slots, first_off);
 }
 
-static void restore_regs(const struct btf_func_model *m, u8 **prog,
+static void restore_regs(const struct btf_func_model *m, struct jit_emit_context *jit,
 			 int stack_size)
 {
 	int i, j, arg_regs, nr_regs = 0;
@@ -3219,7 +3105,7 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog,
 		arg_regs = (m->arg_size[i] + 7) / 8;
 		if (nr_regs + arg_regs <= 6) {
 			for (j = 0; j < arg_regs; j++) {
-				emit_ldx(prog, BPF_DW,
+				emit_ldx(jit, BPF_DW,
 					 nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs,
 					 BPF_REG_FP,
 					 -stack_size);
@@ -3235,19 +3121,18 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog,
 	}
 }
 
-static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
+static int invoke_bpf_prog(const struct btf_func_model *m, struct jit_emit_context *jit,
 			   struct bpf_tramp_node *node, int stack_size,
 			   int run_ctx_off, bool save_ret,
 			   void *image, void *rw_image)
 {
-	u8 *prog = *pprog;
 	u8 *jmp_insn;
 	int ctx_cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
 	struct bpf_prog *p = node->link->prog;
 	u64 cookie = node->cookie;
 
 	/* mov rdi, cookie */
-	emit_mov_imm64(&prog, BPF_REG_1, (long) cookie >> 32, (u32) (long) cookie);
+	emit_mov_imm64(jit, BPF_REG_1, (long) cookie >> 32, (u32) (long) cookie);
 
 	/* Prepare struct bpf_tramp_run_ctx.
 	 *
@@ -3256,28 +3141,28 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	 *
 	 * mov QWORD PTR [rbp - run_ctx_off + ctx_cookie_off], rdi
 	 */
-	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_1, -run_ctx_off + ctx_cookie_off);
+	emit_stx(jit, BPF_DW, BPF_REG_FP, BPF_REG_1, -run_ctx_off + ctx_cookie_off);
 
 	/* arg1: mov rdi, progs[i] */
-	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
+	emit_mov_imm64(jit, BPF_REG_1, (long) p >> 32, (u32) (long) p);
 	/* arg2: lea rsi, [rbp - ctx_cookie_off] */
 	if (!is_imm8(-run_ctx_off))
 		EMIT3_off32(0x48, 0x8D, 0xB5, -run_ctx_off);
 	else
 		EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
 
-	if (emit_rsb_call(&prog, bpf_trampoline_enter(p), image + (prog - (u8 *)rw_image)))
+	if (emit_rsb_call(jit, bpf_trampoline_enter(p), image + (jit->prog - (u8 *)rw_image)))
 		return -EINVAL;
 	/* remember prog start time returned by __bpf_prog_enter */
-	emit_mov_reg(&prog, true, BPF_REG_6, BPF_REG_0);
+	emit_mov_reg(jit, true, BPF_REG_6, BPF_REG_0);
 
 	/* if (__bpf_prog_enter*(prog) == 0)
 	 *	goto skip_exec_of_prog;
 	 */
 	EMIT3(0x48, 0x85, 0xC0);  /* test rax,rax */
 	/* emit 2 nops that will be replaced with JE insn */
-	jmp_insn = prog;
-	emit_nops(&prog, 2);
+	jmp_insn = jit->prog;
+	emit_nops(jit, 2);
 
 	/* arg1: lea rdi, [rbp - stack_size] */
 	if (!is_imm8(-stack_size))
@@ -3286,11 +3171,11 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 		EMIT4(0x48, 0x8D, 0x7D, -stack_size);
 	/* arg2: progs[i]->insnsi for interpreter */
 	if (!p->jited)
-		emit_mov_imm64(&prog, BPF_REG_2,
+		emit_mov_imm64(jit, BPF_REG_2,
 			       (long) p->insnsi >> 32,
 			       (u32) (long) p->insnsi);
 	/* call JITed bpf program or interpreter */
-	if (emit_rsb_call(&prog, p->bpf_func, image + (prog - (u8 *)rw_image)))
+	if (emit_rsb_call(jit, p->bpf_func, image + (jit->prog - (u8 *)rw_image)))
 		return -EINVAL;
 
 	/*
@@ -3302,42 +3187,37 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	 * value of BPF_PROG_TYPE_STRUCT_OPS prog.
 	 */
 	if (save_ret)
-		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
+		emit_stx(jit, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 
 	/* replace 2 nops with JE insn, since jmp target is known */
 	jmp_insn[0] = X86_JE;
-	jmp_insn[1] = prog - jmp_insn - 2;
+	jmp_insn[1] = jit->prog - jmp_insn - 2;
 
 	/* arg1: mov rdi, progs[i] */
-	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
+	emit_mov_imm64(jit, BPF_REG_1, (long) p >> 32, (u32) (long) p);
 	/* arg2: mov rsi, rbx <- start time in nsec */
-	emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
+	emit_mov_reg(jit, true, BPF_REG_2, BPF_REG_6);
 	/* arg3: lea rdx, [rbp - run_ctx_off] */
 	if (!is_imm8(-run_ctx_off))
 		EMIT3_off32(0x48, 0x8D, 0x95, -run_ctx_off);
 	else
 		EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
-	if (emit_rsb_call(&prog, bpf_trampoline_exit(p), image + (prog - (u8 *)rw_image)))
+	if (emit_rsb_call(jit, bpf_trampoline_exit(p), image + (jit->prog - (u8 *)rw_image)))
 		return -EINVAL;
 
-	*pprog = prog;
 	return 0;
 }
 
-static void emit_align(u8 **pprog, u32 align)
+static void emit_align(struct jit_emit_context *jit, u32 align)
 {
-	u8 *target, *prog = *pprog;
-
-	target = PTR_ALIGN(prog, align);
-	if (target != prog)
-		emit_nops(&prog, target - prog);
+	u8 *target = PTR_ALIGN(jit->prog, align);
 
-	*pprog = prog;
+	if (target != jit->prog)
+		emit_nops(jit, target - jit->prog);
 }
 
-static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
+static int emit_cond_near_jump(struct jit_emit_context *jit, void *func, void *ip, u8 jmp_cond)
 {
-	u8 *prog = *pprog;
 	s64 offset;
 
 	offset = func - (ip + 2 + 4);
@@ -3346,48 +3226,44 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
 		return -EINVAL;
 	}
 	EMIT2_off32(0x0F, jmp_cond + 0x10, offset);
-	*pprog = prog;
 	return 0;
 }
 
-static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
+static int invoke_bpf(const struct btf_func_model *m, struct jit_emit_context *jit,
 		      struct bpf_tramp_nodes *tl, int stack_size,
 		      int run_ctx_off, int func_meta_off, bool save_ret,
 		      void *image, void *rw_image, u64 func_meta,
 		      int cookie_off)
 {
 	int i, cur_cookie = (cookie_off - stack_size) / 8;
-	u8 *prog = *pprog;
 
 	for (i = 0; i < tl->nr_nodes; i++) {
 		if (tl->nodes[i]->link->prog->call_session_cookie) {
-			emit_store_stack_imm64(&prog, BPF_REG_0, -func_meta_off,
+			emit_store_stack_imm64(jit, BPF_REG_0, -func_meta_off,
 				func_meta | (cur_cookie << BPF_TRAMP_COOKIE_INDEX_SHIFT));
 			cur_cookie--;
 		}
-		if (invoke_bpf_prog(m, &prog, tl->nodes[i], stack_size,
+		if (invoke_bpf_prog(m, jit, tl->nodes[i], stack_size,
 				    run_ctx_off, save_ret, image, rw_image))
 			return -EINVAL;
 	}
-	*pprog = prog;
 	return 0;
 }
 
-static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
+static int invoke_bpf_mod_ret(const struct btf_func_model *m, struct jit_emit_context *jit,
 			      struct bpf_tramp_nodes *tl, int stack_size,
 			      int run_ctx_off, u8 **branches,
 			      void *image, void *rw_image)
 {
-	u8 *prog = *pprog;
 	int i;
 
 	/* The first fmod_ret program will receive a garbage return value.
 	 * Set this to 0 to avoid confusing the program.
 	 */
-	emit_mov_imm32(&prog, false, BPF_REG_0, 0);
-	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
+	emit_mov_imm32(jit, false, BPF_REG_0, 0);
+	emit_stx(jit, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 	for (i = 0; i < tl->nr_nodes; i++) {
-		if (invoke_bpf_prog(m, &prog, tl->nodes[i], stack_size, run_ctx_off, true,
+		if (invoke_bpf_prog(m, jit, tl->nodes[i], stack_size, run_ctx_off, true,
 				    image, rw_image))
 			return -EINVAL;
 
@@ -3403,11 +3279,10 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 		 * are replaced with a conditional jump once do_fexit (i.e. the
 		 * start of the fexit invocation) is finalized.
 		 */
-		branches[i] = prog;
-		emit_nops(&prog, 4 + 2);
+		branches[i] = jit->prog;
+		emit_nops(jit, 4 + 2);
 	}
 
-	*pprog = prog;
 	return 0;
 }
 
@@ -3486,12 +3361,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	struct bpf_tramp_nodes *fentry = &tnodes[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_nodes *fexit = &tnodes[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_nodes *fmod_ret = &tnodes[BPF_TRAMP_MODIFY_RETURN];
+	struct jit_emit_context jit_ctx = {}, *jit = &jit_ctx;
 	void *orig_call = func_addr;
 	int cookie_off, cookie_cnt;
 	u8 **branches = NULL;
 	u64 arena_base;
 	u64 func_meta;
-	u8 *prog;
 	bool save_ret;
 
 	/*
@@ -3596,13 +3471,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		orig_call += X86_PATCH_SIZE;
 	}
 
-	prog = rw_image;
+	jit->prog = rw_image;
 
 	if (flags & BPF_TRAMP_F_INDIRECT) {
 		/*
 		 * Indirect call for bpf_struct_ops
 		 */
-		emit_cfi(&prog, image,
+		emit_cfi(jit, image,
 			 cfi_get_func_hash(func_addr),
 			 cfi_get_func_arity(func_addr));
 	} else {
@@ -3610,12 +3485,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		 * Direct-call fentry stub, as such it needs accounting for the
 		 * __fentry__ call.
 		 */
-		bpf_call_depth_emit_accounting(&prog, NULL, image);
+		bpf_call_depth_emit_accounting(jit, NULL, image);
 	}
 	EMIT1(0x55);		 /* push rbp */
 	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
 	if (im)
-		im->ksym.fp_start = prog - (u8 *)rw_image;
+		im->ksym.fp_start = jit->prog - (u8 *)rw_image;
 
 	if (!is_imm8(stack_size)) {
 		/* sub rsp, stack_size */
@@ -3627,24 +3502,24 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
 		EMIT1(0x50);		/* push rax */
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
-	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
+	emit_stx(jit, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
 
 	func_meta = nr_regs;
 	/* Store number of argument registers of the traced function */
-	emit_store_stack_imm64(&prog, BPF_REG_0, -func_meta_off, func_meta);
+	emit_store_stack_imm64(jit, BPF_REG_0, -func_meta_off, func_meta);
 
 	if (flags & BPF_TRAMP_F_IP_ARG) {
 		/* Store IP address of the traced function */
-		emit_store_stack_imm64(&prog, BPF_REG_0, -ip_off, (long)func_addr);
+		emit_store_stack_imm64(jit, BPF_REG_0, -ip_off, (long)func_addr);
 	}
 
-	save_args(m, &prog, regs_off, false, flags, arena_base);
+	save_args(m, jit, regs_off, false, flags, arena_base);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
-		emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
-		if (emit_rsb_call(&prog, __bpf_tramp_enter,
-				  image + (prog - (u8 *)rw_image))) {
+		emit_mov_imm64(jit, BPF_REG_1, (long) im >> 32, (u32) (long) im);
+		if (emit_rsb_call(jit, __bpf_tramp_enter,
+				  image + (jit->prog - (u8 *)rw_image))) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
@@ -3653,13 +3528,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	if (bpf_fsession_cnt(tnodes)) {
 		/* clear all the session cookies' value */
 		for (int i = 0; i < cookie_cnt; i++)
-			emit_store_stack_imm64(&prog, BPF_REG_0, -cookie_off + 8 * i, 0);
+			emit_store_stack_imm64(jit, BPF_REG_0, -cookie_off + 8 * i, 0);
 		/* clear the return value to make sure fentry always get 0 */
-		emit_store_stack_imm64(&prog, BPF_REG_0, -8, 0);
+		emit_store_stack_imm64(jit, BPF_REG_0, -8, 0);
 	}
 
 	if (fentry->nr_nodes) {
-		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off, func_meta_off,
+		if (invoke_bpf(m, jit, fentry, regs_off, run_ctx_off, func_meta_off,
 			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image,
 			       func_meta, cookie_off))
 			return -EINVAL;
@@ -3671,7 +3546,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		if (!branches)
 			return -ENOMEM;
 
-		if (invoke_bpf_mod_ret(m, &prog, fmod_ret, regs_off,
+		if (invoke_bpf_mod_ret(m, jit, fmod_ret, regs_off,
 				       run_ctx_off, branches, image, rw_image)) {
 			ret = -EINVAL;
 			goto cleanup;
@@ -3679,8 +3554,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_regs(m, &prog, regs_off);
-		save_args(m, &prog, arg_stack_off, true, flags, 0);
+		restore_regs(m, jit, regs_off);
+		save_args(m, jit, arg_stack_off, true, flags, 0);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
 			/* Before calling the original function, load the
@@ -3690,19 +3565,19 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 
 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
-			emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, 8);
+			emit_ldx(jit, BPF_DW, BPF_REG_6, BPF_REG_FP, 8);
 			EMIT2(0xff, 0xd3); /* call *rbx */
 		} else {
 			/* call original function */
-			if (emit_rsb_call(&prog, orig_call, image + (prog - (u8 *)rw_image))) {
+			if (emit_rsb_call(jit, orig_call, image + (jit->prog - (u8 *)rw_image))) {
 				ret = -EINVAL;
 				goto cleanup;
 			}
 		}
 		/* remember return value in a stack for bpf prog to access */
-		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
-		im->ip_after_call = image + (prog - (u8 *)rw_image);
-		emit_nops(&prog, X86_PATCH_SIZE);
+		emit_stx(jit, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
+		im->ip_after_call = image + (jit->prog - (u8 *)rw_image);
+		emit_nops(jit, X86_PATCH_SIZE);
 	}
 
 	if (fmod_ret->nr_nodes) {
@@ -3711,12 +3586,16 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		 * Coding Rule 11: All branch targets should be 16-byte
 		 * aligned.
 		 */
-		emit_align(&prog, 16);
+		emit_align(jit, 16);
 		/* Update the branches saved in invoke_bpf_mod_ret with the
 		 * aligned address of do_fexit.
 		 */
 		for (i = 0; i < fmod_ret->nr_nodes; i++) {
-			emit_cond_near_jump(&branches[i], image + (prog - (u8 *)rw_image),
+			struct jit_emit_context branch_jit = {
+				.prog = branches[i],
+			};
+
+			emit_cond_near_jump(&branch_jit, image + (jit->prog - (u8 *)rw_image),
 					    image + (branches[i] - (u8 *)rw_image), X86_JNE);
 		}
 	}
@@ -3724,10 +3603,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	/* set the "is_return" flag for fsession */
 	func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
 	if (bpf_fsession_cnt(tnodes))
-		emit_store_stack_imm64(&prog, BPF_REG_0, -func_meta_off, func_meta);
+		emit_store_stack_imm64(jit, BPF_REG_0, -func_meta_off, func_meta);
 
 	if (fexit->nr_nodes) {
-		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off, func_meta_off,
+		if (invoke_bpf(m, jit, fexit, regs_off, run_ctx_off, func_meta_off,
 			       false, image, rw_image, func_meta, cookie_off)) {
 			ret = -EINVAL;
 			goto cleanup;
@@ -3735,17 +3614,17 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_regs(m, &prog, regs_off);
+		restore_regs(m, jit, regs_off);
 
 	/* This needs to be done regardless. If there were fmod_ret programs,
 	 * the return value is only updated on the stack and still needs to be
 	 * restored to R0.
 	 */
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		im->ip_epilogue = image + (prog - (u8 *)rw_image);
+		im->ip_epilogue = image + (jit->prog - (u8 *)rw_image);
 		/* arg1: mov rdi, im */
-		emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
-		if (emit_rsb_call(&prog, __bpf_tramp_exit, image + (prog - (u8 *)rw_image))) {
+		emit_mov_imm64(jit, BPF_REG_1, (long) im >> 32, (u32) (long) im);
+		if (emit_rsb_call(jit, __bpf_tramp_exit, image + (jit->prog - (u8 *)rw_image))) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
@@ -3758,25 +3637,25 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	/* restore return value of orig_call or fentry prog back into RAX */
 	if (save_ret)
-		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
+		emit_ldx(jit, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
 
-	emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
+	emit_ldx(jit, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
 
 	EMIT1(0xC9); /* leave */
 	if (im)
-		im->ksym.fp_end = prog - (u8 *)rw_image;
+		im->ksym.fp_end = jit->prog - (u8 *)rw_image;
 
 	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
 		/* skip our return address and return to parent */
 		EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
 	}
-	emit_return(&prog, image + (prog - (u8 *)rw_image));
+	emit_return(jit, image + (jit->prog - (u8 *)rw_image));
 	/* Make sure the trampoline generation logic doesn't overflow */
-	if (WARN_ON_ONCE(prog > (u8 *)rw_image_end - BPF_INSN_SAFETY)) {
+	if (WARN_ON_ONCE(jit->prog > (u8 *)rw_image_end - BPF_INSN_SAFETY)) {
 		ret = -EFAULT;
 		goto cleanup;
 	}
-	ret = prog - (u8 *)rw_image + BPF_INSN_SAFETY;
+	ret = jit->prog - (u8 *)rw_image + BPF_INSN_SAFETY;
 
 cleanup:
 	kfree(branches);
@@ -3850,9 +3729,10 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	return ret;
 }
 
-static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image, u8 *buf)
+static int emit_bpf_dispatcher(struct jit_emit_context *jit, int a, int b, s64 *progs, u8 *image,
+			       u8 *buf)
 {
-	u8 *jg_reloc, *prog = *pprog;
+	u8 *jg_reloc;
 	int pivot, err, jg_bytes = 1;
 	s64 jg_offset;
 
@@ -3865,15 +3745,13 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image,
 			return -1;
 		EMIT2_off32(0x81, add_1reg(0xF8, BPF_REG_3),
 			    progs[a]);
-		err = emit_cond_near_jump(&prog,	/* je func */
-					  (void *)progs[a], image + (prog - buf),
+		err = emit_cond_near_jump(jit,	/* je func */
+					  (void *)progs[a], image + (jit->prog - buf),
 					  X86_JE);
 		if (err)
 			return err;
 
-		emit_indirect_jump(&prog, BPF_REG_3 /* R3 -> rdx */, image + (prog - buf));
-
-		*pprog = prog;
+		emit_indirect_jump(jit, BPF_REG_3 /* R3 -> rdx */, image + (jit->prog - buf));
 		return 0;
 	}
 
@@ -3893,9 +3771,9 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image,
 	} else {
 		EMIT2(X86_JG, 0);
 	}
-	jg_reloc = prog;
+	jg_reloc = jit->prog;
 
-	err = emit_bpf_dispatcher(&prog, a, a + pivot,	/* emit lower_part */
+	err = emit_bpf_dispatcher(jit, a, a + pivot,	/* emit lower_part */
 				  progs, image, buf);
 	if (err)
 		return err;
@@ -3905,16 +3783,15 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image,
 	 * Coding Rule 11: All branch targets should be 16-byte
 	 * aligned.
 	 */
-	emit_align(&prog, 16);
-	jg_offset = prog - jg_reloc;
+	emit_align(jit, 16);
+	jg_offset = jit->prog - jg_reloc;
 	emit_code(jg_reloc - jg_bytes, jg_offset, jg_bytes);
 
-	err = emit_bpf_dispatcher(&prog, a + pivot + 1,	/* emit upper_part */
+	err = emit_bpf_dispatcher(jit, a + pivot + 1,	/* emit upper_part */
 				  b, progs, image, buf);
 	if (err)
 		return err;
 
-	*pprog = prog;
 	return 0;
 }
 
@@ -3932,10 +3809,10 @@ static int cmp_ips(const void *a, const void *b)
 
 int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_funcs)
 {
-	u8 *prog = buf;
+	struct jit_emit_context jit = { .prog = buf };
 
 	sort(funcs, num_funcs, sizeof(funcs[0]), cmp_ips, NULL);
-	return emit_bpf_dispatcher(&prog, 0, num_funcs - 1, funcs, image, buf);
+	return emit_bpf_dispatcher(&jit, 0, num_funcs - 1, funcs, image, buf);
 }
 
 static void priv_stack_init_guard(void __percpu *priv_stack_ptr, int alloc_size)
-- 
2.54.0

