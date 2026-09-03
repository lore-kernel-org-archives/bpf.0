Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2120D4B1B4E;
	Thu,  3 Sep 2026 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443538; cv=none; b=s/acT12AknByyIy7rZxIME5eOT4d1kpN7UTWKNFuhgRw8ywjO5pt/eH372/lVFKJ/P/FiG64cGnoAeQq9QigT5jn5v+yylpr6P1uBY+aRo1QotSGe92nqEWcgkWF+Ka1ZrjEsLOtuleJCSxwrTtFhgljcL2s2gJ1rVGYJKgUEls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443538; c=relaxed/simple;
	bh=JoyJj8VdqLxTl7xiLD7nbDDWDGm0oEZAMOmPtXAhbsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rc6LcIZPIS3jPPTEj4fmGwTR8Mkby/GOuJ+0ttRDO0Ivtn/2syhJGbKSes4v0JSXRmGo+d7ZTi9uHVVOuH5WjaIPIXaJOwkvbwybWekR+kJo5bWeCXi6BPZYUxt54likDOBa/P1ptmsCJJPBAAk1nAiJIL2sIx3Ac3NX9k9T/8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c1dPLACc; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c1dPLACc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D72D94E414EF;
	Thu,  3 Sep 2026 13:51:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A4853602B8;
	Thu,  3 Sep 2026 13:51:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A9A411C7A0F8;
	Thu,  3 Sep 2026 15:51:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788443517; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=c5SCdlmP5PEMnFUDrFZtPhsjpnDubQQEkFokgk15qTM=;
	b=c1dPLACcib7jjw8z/dRc/HuZi26QBUFv6E2exwxWuYRr+JSbHbiMnGH0seYe6WTCQCRnzV
	mNoQTCguCsdg/nG5HQUg5TJ1DsbxgtBucaI7BsGlBHq8iJ/w1J8dY+87gJtzEkTwbZCJbu
	qNDKs1pBG9JDurZV4UGMrJSVTZsdUV7QJ/z+47NtZdrzJnKDHvfTuzCjpL1K0nFxaAv0lA
	mLqF45viyYXDEtun+wJMCmnwdBZb2qWQQPETObB6t9PJhtxNOWhrRNWJYAQfTMkZBm05PL
	E41FCPhHUyOpcrUiOVDfyx/zbgMO+Us16STqJTfF6O1lsGCskftvXoWXLoPwLA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 03 Sep 2026 15:51:33 +0200
Subject: [PATCH bpf-next v9 4/8] bpf, x86: emit KASAN checks in x86 JITed
 programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-kasan-v9-4-2407fe99255a@bootlin.com>
References: <20260903-kasan-v9-0-2407fe99255a@bootlin.com>
In-Reply-To: <20260903-kasan-v9-0-2407fe99255a@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Yafang Shao <laoar.shao@gmail.com>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Insert KASAN shadow memory checks before memory load and store
operations in JIT-compiled BPF programs. This helps detect memory safety
bugs such as use-after-free and out-of-bounds accesses at runtime.

The main instructions being targeted are BPF_ST, BPF_STX and BPF_LDX,
but not all of them are being instrumented:
- if the load/store instruction is in fact accessing the program stack,
  emit_kasan_check silently skips the instrumentation, as we can already
  benefit from guard pages to monitor stack accesses.
- if the load/store instruction is a BPF_PROBE_MEM or a BPF_PROBE_ATOMIC
  instruction, we do not instrument it, as the passed address can fault
  (hence the custom fault management with BPF_PROBE_XXX instructions),
  and so the corresponding kasan check could fault as well.

To support those new instructions insertion, create the
emit_kasan_check() helper that emits KASAN shadow memory checks before
memory accesses in JIT-compiled BPF programs. The implementation relies
on the existing __asan_{load,store}X functions from KASAN subsystem. The
helper:
- saves registers. This includes caller-saved registers, but also
  temporary registers, as those were possibly used by the
  affected program.
- computes the accessed address and stores it in %rdi
- calls the relevant function, depending on the instruction being a load
  or a store, and the size of the access.
- restores registers

The special care needed when inserting this instrumentation comes at the
cost of a non negligeable increase in JITed code size. For example, a
bare

  mov 	0x0(%si),rbx # Load in rbx content at address stored in rsi

becomes

  push    %rax
  push    %rcx
  push    %rdx
  push    %rsi
  push    %rdi
  push    %r8
  push    %r9
  push    %r10
  push    %r11
  mov     %rsi,%rdi
  call    0xffffffff81da0a60 <__asan_load8>
  pop     %r11
  pop     %r10
  pop     %r9
  pop     %r8
  pop     %rdi
  pop     %rsi
  pop     %rdx
  pop     %rcx
  pop     %rax
  mov     0x0(%rsi),rbx

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v9:
- skip instrumentation if the base reg is FP or REG_PARAMS
- rename pprog in JIT compiler branch to avoid confusion
- keep branch_target computation local to the branch needing it
- pass adjusted insn offset in case we are dealing with params on stack
  (skipped anyway, but for the sake of correctness)

Changes in v8:
- add back r10/r11 save/restore in emit_kasan_check

Changes in v6:
- add a comment about r10/r11 being skipped in emit_kasan_check
- merge the commit defining the helper into the commit actually using
  it
- move non_stack_access check out of the emit_kasan_check helper
- replace hardcoded ip increment with actual computation

Changes in v5:
- (from former split commit) change access type (read -> write) for
  atomic RMW check

Changes in v4:
- (from former split commit) refactor BPF_FETCH handling

Changes in v3:
- skip kasan instrumentation if there is no verifier env (cBPF)
- move helper up in the file
- (from former split commit) fix LLVM23 build failure

Changes in v2:
- move asan functions declaration directly into jit compiler, and guard
  them with IS_ENABLED
- remove faulty stack alignment, no arg is passed to kasan funcs on the
  stack anyway
- make sure to emit call depth accounting code
- do not save unneeded registers
- update helper signature to let caller configure some values (eg:
  is_write)
- (from former split commit) support BPF_ATOMICS
- (from former split commit) support BPF_ST
- (from former split commit) make sure to systematically pass correct
  instruction to kasan check
---
 arch/x86/net/bpf_jit_comp.c | 197 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 179 insertions(+), 18 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index f907be3988b2..b8c2e935689e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -21,6 +21,17 @@
 #include <asm/unwind.h>
 #include <asm/cfi.h>
 
+#if IS_ENABLED(CONFIG_BPF_JIT_KASAN)
+void __asan_load1(void *p);
+void __asan_store1(void *p);
+void __asan_load2(void *p);
+void __asan_store2(void *p);
+void __asan_load4(void *p);
+void __asan_store4(void *p);
+void __asan_load8(void *p);
+void __asan_store8(void *p);
+#endif
+
 static bool all_callee_regs_used[4] = {true, true, true, true};
 
 static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
@@ -1110,6 +1121,93 @@ static void maybe_emit_1mod(u8 **pprog, u32 reg, bool is64)
 	*pprog = prog;
 }
 
+static int emit_kasan_check(struct bpf_verifier_env *env, u8 **pprog,
+			    u32 addr_reg, s32 off, u32 bpf_size, u8 *ip,
+			    bool is_write)
+{
+#ifdef CONFIG_BPF_JIT_KASAN
+	u8 *prog = *pprog;
+	void *kasan_func;
+
+	if (!env)
+		return 0;
+
+	if (addr_reg == BPF_REG_FP || addr_reg == BPF_REG_PARAMS)
+		return 0;
+
+	/* Derive KASAN check function from access type and size */
+	switch (bpf_size) {
+	case BPF_B:
+		kasan_func = is_write ? __asan_store1 : __asan_load1;
+		break;
+	case BPF_H:
+		kasan_func = is_write ? __asan_store2 : __asan_load2;
+		break;
+	case BPF_W:
+		kasan_func = is_write ? __asan_store4 : __asan_load4;
+		break;
+	case BPF_DW:
+		kasan_func = is_write ? __asan_store8 : __asan_load8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Save rax */
+	EMIT1(0x50);
+	/* Save rcx */
+	EMIT1(0x51);
+	/* Save rdx */
+	EMIT1(0x52);
+	/* Save rsi */
+	EMIT1(0x56);
+	/* Save rdi */
+	EMIT1(0x57);
+	/* Save r8 */
+	EMIT2(0x41, 0x50);
+	/* Save r9 */
+	EMIT2(0x41, 0x51);
+	/* Save r10 */
+	EMIT2(0x41, 0x52);
+	/* Save r11 */
+	EMIT2(0x41, 0x53);
+	/* mov rdi, addr_reg */
+	EMIT_mov(BPF_REG_1, addr_reg);
+
+	/* add rdi, off (if offset is non-zero) */
+	if (off) {
+		if (is_imm8(off)) {
+			/* add rdi, imm8 */
+			EMIT4(0x48, 0x83, 0xC7, (u8)off);
+		} else {
+			/* add rdi, imm32 */
+			EMIT3_off32(0x48, 0x81, 0xC7, off);
+		}
+	}
+
+	/* Adjust ip to account for the instrumentation generated so far */
+	ip += (prog - *pprog);
+	/* We emit a call, so update call depth counting */
+	ip += x86_call_depth_emit_accounting(&prog, kasan_func, ip);
+	/* call kasan_func */
+	if (emit_call(&prog, kasan_func, ip))
+		return -ERANGE;
+
+	EMIT2(0x41, 0x5B);
+	EMIT2(0x41, 0x5A);
+	EMIT2(0x41, 0x59);
+	EMIT2(0x41, 0x58);
+	EMIT1(0x5F);
+	EMIT1(0x5E);
+	EMIT1(0x5A);
+	EMIT1(0x59);
+	EMIT1(0x58);
+
+	*pprog = prog;
+#endif /* CONFIG_BPF_JIT_KASAN */
+	return 0;
+}
+
 /* LDX: dst_reg = *(u8*)(src_reg + off) */
 static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 {
@@ -1463,17 +1561,35 @@ static int emit_atomic_rmw_index(u8 **pprog, u32 atomic_op, u32 size,
 	return 0;
 }
 
-static int emit_atomic_ld_st(u8 **pprog, u32 atomic_op, u32 dst_reg,
-			     u32 src_reg, s16 off, u8 bpf_size)
+static int emit_atomic_ld_st(struct bpf_verifier_env *env, u8 **pprog,
+			     struct bpf_insn *insn, u8 *ip, u32 dst_reg,
+			     u32 src_reg, bool accesses_stack_only)
 {
+	u32 atomic_op = insn->imm;
+	int err;
+
 	switch (atomic_op) {
 	case BPF_LOAD_ACQ:
+		if (!accesses_stack_only) {
+			err = emit_kasan_check(env, pprog, src_reg, insn->off,
+					       BPF_SIZE(insn->code), ip, false);
+			if (err)
+				return err;
+		}
 		/* dst_reg = smp_load_acquire(src_reg + off16) */
-		emit_ldx(pprog, bpf_size, dst_reg, src_reg, off);
+		emit_ldx(pprog, BPF_SIZE(insn->code), dst_reg, src_reg,
+			 insn->off);
 		break;
 	case BPF_STORE_REL:
+		if (!accesses_stack_only) {
+			err = emit_kasan_check(env, pprog, dst_reg, insn->off,
+					       BPF_SIZE(insn->code), ip, true);
+			if (err)
+				return err;
+		}
 		/* smp_store_release(dst_reg + off16, src_reg) */
-		emit_stx(pprog, bpf_size, dst_reg, src_reg, off);
+		emit_stx(pprog, BPF_SIZE(insn->code), dst_reg, src_reg,
+			 insn->off);
 		break;
 	default:
 		pr_err("bpf_jit: unknown atomic load/store opcode %02x\n",
@@ -1894,10 +2010,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		const s32 imm32 = insn->imm;
 		u32 dst_reg = insn->dst_reg;
 		u32 src_reg = insn->src_reg;
+		bool accesses_stack_only;
 		u8 b2 = 0, b3 = 0;
 		u8 *start_of_ldx;
 		s64 jmp_offset;
 		s32 insn_off;
+		int insn_idx;
 		u8 jmp_cond;
 		u8 *func;
 		int nops;
@@ -1914,6 +2032,10 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			EMIT_ENDBR();
 
 		ip = image + addrs[i - 1] + (prog - temp);
+		insn_idx = i - 1 + bpf_prog->aux->subprog_start;
+		accesses_stack_only =
+			env ? !env->insn_aux_data[insn_idx].non_stack_access :
+			      false;
 
 		switch (insn->code) {
 			/* ALU */
@@ -2311,6 +2433,15 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 					   insn_off - 16;
 				dst_reg = BPF_REG_FP;
 			}
+			if (!accesses_stack_only) {
+				err = emit_kasan_check(env, &prog, dst_reg,
+						       insn_off,
+						       BPF_SIZE(insn->code), ip,
+						       true);
+				if (err)
+					return err;
+			}
+
 			emit_st(&prog, insn, dst_reg, insn_off);
 			break;
 
@@ -2329,6 +2460,14 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				insn_off = outgoing_arg_base - outgoing_rsp - insn_off - 16;
 				dst_reg = BPF_REG_FP;
 			}
+			if (!accesses_stack_only) {
+				err = emit_kasan_check(env, &prog, dst_reg,
+						       insn_off,
+						       BPF_SIZE(insn->code), ip,
+						       true);
+				if (err)
+					return err;
+			}
 			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
 			break;
 
@@ -2510,6 +2649,13 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				/* populate jmp_offset for JAE above to jump to start_of_ldx */
 				start_of_ldx = prog;
 				end_of_jmp[-1] = start_of_ldx - end_of_jmp;
+			} else if (!accesses_stack_only) {
+				err = emit_kasan_check(env, &prog, src_reg,
+						       insn_off,
+						       BPF_SIZE(insn->code), ip,
+						       false);
+				if (err)
+					return err;
 			}
 			if (BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
 			    BPF_MODE(insn->code) == BPF_MEMSX)
@@ -2571,28 +2717,42 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			}
 			fallthrough;
 		case BPF_STX | BPF_ATOMIC | BPF_W:
-		case BPF_STX | BPF_ATOMIC | BPF_DW:
-			if (insn->imm == (BPF_AND | BPF_FETCH) ||
-			    insn->imm == (BPF_OR | BPF_FETCH) ||
-			    insn->imm == (BPF_XOR | BPF_FETCH)) {
-				bool is64 = BPF_SIZE(insn->code) == BPF_DW;
-				u32 real_src_reg = src_reg;
-				u32 real_dst_reg = dst_reg;
-				u8 *branch_target;
-
+		case BPF_STX | BPF_ATOMIC | BPF_DW: {
+			bool is64 = BPF_SIZE(insn->code) == BPF_DW;
+			u32 real_src_reg = src_reg;
+			u32 real_dst_reg = dst_reg;
+			u8 *old_prog;
+			bool is_atomic_fetch =
+				(insn->imm == (BPF_AND | BPF_FETCH) ||
+				 insn->imm == (BPF_OR | BPF_FETCH) ||
+				 insn->imm == (BPF_XOR | BPF_FETCH));
+			if (is_atomic_fetch) {
 				/*
 				 * Can't be implemented with a single x86 insn.
 				 * Need to do a CMPXCHG loop.
 				 */
 
 				/* Will need RAX as a CMPXCHG operand so save R0 */
+				old_prog = prog;
 				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
 				if (src_reg == BPF_REG_0)
 					real_src_reg = BPF_REG_AX;
 				if (dst_reg == BPF_REG_0)
 					real_dst_reg = BPF_REG_AX;
-
-				branch_target = prog;
+				ip += (prog - old_prog);
+			}
+			if (!bpf_atomic_is_load_store(insn)) {
+				if (!accesses_stack_only) {
+					err = emit_kasan_check(
+						env, &prog, real_dst_reg,
+						insn->off, BPF_SIZE(insn->code),
+						ip, true);
+					if (err)
+						return err;
+				}
+			}
+			if (is_atomic_fetch) {
+				u8 *branch_target = prog;
 				/* Load old value */
 				emit_ldx(&prog, BPF_SIZE(insn->code),
 					 BPF_REG_0, real_dst_reg, insn->off);
@@ -2624,15 +2784,16 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			}
 
 			if (bpf_atomic_is_load_store(insn))
-				err = emit_atomic_ld_st(&prog, insn->imm, dst_reg, src_reg,
-							insn->off, BPF_SIZE(insn->code));
+				err = emit_atomic_ld_st(env, &prog, insn, ip,
+							dst_reg, src_reg,
+							accesses_stack_only);
 			else
 				err = emit_atomic_rmw(&prog, insn->imm, dst_reg, src_reg,
 						      insn->off, BPF_SIZE(insn->code));
 			if (err)
 				return err;
 			break;
-
+		}
 		case BPF_STX | BPF_PROBE_ATOMIC | BPF_B:
 		case BPF_STX | BPF_PROBE_ATOMIC | BPF_H:
 			if (!bpf_atomic_is_load_store(insn)) {

-- 
2.55.0

