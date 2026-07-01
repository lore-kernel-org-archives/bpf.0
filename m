Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEBD406822
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900227; cv=none; b=GLAAKas3QVMu+bnFmKBoG3jHCTMnLRm0+XFw4rInnjCU4Bsh+KN+Lt1qy48RSpCH0gVvXRDTzxfLBGlGSaFCJZIbIB7nJMg44FmxbXKRIKXDliFuYUT5j9r9svNhUYFSirvJZ9N0pZ6ZItMmqoQH9bwsR7kQv6g+JVxnhFU0ij4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900227; c=relaxed/simple;
	bh=mW9hoKX9M0jsFD89FrvfnIVxa2czTbzc9IBvPpXI4KY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y/1SJL3/uFYDytLaKixwt2CqMsgCGXn+p4tt1m7yWHdf+3jCP+c/1fiIf9eFAqFpeE8rHF4jDs6YPnn5i0f9tGTI5ZtyxELvcKTjzUcGjks6MHnI+Bx9UjvODGxtmts5lyGme2Z6XNMGPRjHDqNZvE9zkZ0KCoRvF8qYf5tXoJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nDksq9At; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nDksq9At"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8024D1A0DAF;
	Wed,  1 Jul 2026 10:03:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5352C60288;
	Wed,  1 Jul 2026 10:03:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 65EFC104C9A83;
	Wed,  1 Jul 2026 12:03:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782900222; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CXdxHGhy7WugD0lmxp83xTSrkKxOPvYHfK+XFfD/Xhk=;
	b=nDksq9At22gDCoVnk89cBaOSDU1Y0EI/QWsNlLQDB1vrtD0JOOzdsHwKcpi7BDr/c9YXGI
	0LBB/FWwOp5vS67mfmyPpkMSA4Iyc0AtxMAsItzMPKmRXYiVR68nVbpGEZMEwKiufdr18F
	+X1gzYYgtF7Ih1NBqvZ25lKLvJPX9CmYQBhyuYH22FaRshiq+w2cRgaYK1ck2K5Thq8QGT
	Pudo4oy+YVsHOnBQKk03MFIsFo/Z0StLQ1yJr20xv4cXvduSxfaeJt+dFT2j1jZ/g4LEDy
	HEa/vgxUGQ7JpukvaQkF/R19RPSFqSxciTpa4mC8WTq+6JkGxEOJf5VDCZuznQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 01 Jul 2026 12:02:54 +0200
Subject: [PATCH bpf-next v3 06/10] bpf, x86: emit KASAN checks into x86
 JITed programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260701-kasan-v3-6-bd09bb942d86@bootlin.com>
References: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
In-Reply-To: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
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
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
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
  emit_kasan_check silently skips the instrumentation, as we already
  have page guards to monitor stack accesses.
- if the load/store instruction is a BPF_PROBE_MEM or a BPF_PROBE_ATOMIC
  instruction, we do not instrument it, as the passed address can fault
  (hence the custom fault management with BPF_PROBE_XXX instructions),
  and so the corresponding kasan check could fault as well.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- fix LLVM23 build failure

Changes in v2:
- support BPF_ATOMICS
- support BPF_ST
- make sure to systematically pass correct instruction to kasan check
---
 arch/x86/net/bpf_jit_comp.c | 72 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 12 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index b70cecfec179..a383ffc8f289 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1576,17 +1576,31 @@ static int emit_atomic_rmw_index(u8 **pprog, u32 atomic_op, u32 size,
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
+		err = emit_kasan_check(env, pprog, src_reg, insn, ip, false,
+				       accesses_stack_only);
+		if (err)
+			return err;
 		/* dst_reg = smp_load_acquire(src_reg + off16) */
-		emit_ldx(pprog, bpf_size, dst_reg, src_reg, off);
+		emit_ldx(pprog, BPF_SIZE(insn->code), dst_reg, src_reg,
+			 insn->off);
 		break;
 	case BPF_STORE_REL:
+		err = emit_kasan_check(env, pprog, dst_reg, insn, ip, true,
+				       accesses_stack_only);
+		if (err)
+			return err;
 		/* smp_store_release(dst_reg + off16, src_reg) */
-		emit_stx(pprog, bpf_size, dst_reg, src_reg, off);
+		emit_stx(pprog, BPF_SIZE(insn->code), dst_reg, src_reg,
+			 insn->off);
 		break;
 	default:
 		pr_err("bpf_jit: unknown atomic load/store opcode %02x\n",
@@ -1964,10 +1978,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
@@ -1984,6 +2000,10 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			EMIT_ENDBR();
 
 		ip = image + addrs[i - 1] + (prog - temp);
+		insn_idx = i - 1 + bpf_prog->aux->subprog_start;
+		accesses_stack_only =
+			env ? !env->insn_aux_data[insn_idx].non_stack_access :
+			      false;
 
 		switch (insn->code) {
 			/* ALU */
@@ -2364,6 +2384,11 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		case BPF_ST | BPF_MEM | BPF_H:
 		case BPF_ST | BPF_MEM | BPF_W:
 		case BPF_ST | BPF_MEM | BPF_DW:
+			err = emit_kasan_check(env, &prog, dst_reg, insn, ip,
+					       true, accesses_stack_only);
+			if (err)
+				return err;
+
 			emit_st(&prog, insn, dst_reg, outgoing_arg_base,
 				outgoing_rsp);
 			break;
@@ -2383,6 +2408,10 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				insn_off = outgoing_arg_base - outgoing_rsp - insn_off - 16;
 				dst_reg = BPF_REG_FP;
 			}
+			err = emit_kasan_check(env, &prog, dst_reg, insn, ip,
+					       true, accesses_stack_only);
+			if (err)
+				return err;
 			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
 			break;
 
@@ -2544,6 +2573,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				/* populate jmp_offset for JAE above to jump to start_of_ldx */
 				start_of_ldx = prog;
 				end_of_jmp[-1] = start_of_ldx - end_of_jmp;
+			} else {
+				err = emit_kasan_check(env, &prog, src_reg,
+						       insn, ip, false,
+						       accesses_stack_only);
+				if (err)
+					return err;
 			}
 			if (BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
 			    BPF_MODE(insn->code) == BPF_MEMSX)
@@ -2605,14 +2640,14 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			}
 			fallthrough;
 		case BPF_STX | BPF_ATOMIC | BPF_W:
-		case BPF_STX | BPF_ATOMIC | BPF_DW:
+		case BPF_STX | BPF_ATOMIC | BPF_DW: {
+			bool is64 = BPF_SIZE(insn->code) == BPF_DW;
+			u32 real_src_reg = src_reg;
+			u32 real_dst_reg = dst_reg;
+			u8 *branch_target;
 			if (insn->imm == (BPF_AND | BPF_FETCH) ||
 			    insn->imm == (BPF_OR | BPF_FETCH) ||
 			    insn->imm == (BPF_XOR | BPF_FETCH)) {
-				bool is64 = BPF_SIZE(insn->code) == BPF_DW;
-				u32 real_src_reg = src_reg;
-				u32 real_dst_reg = dst_reg;
-				u8 *branch_target;
 
 				/*
 				 * Can't be implemented with a single x86 insn.
@@ -2626,7 +2661,19 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				if (dst_reg == BPF_REG_0)
 					real_dst_reg = BPF_REG_AX;
 
+				ip += 3;
+			}
+			if (!bpf_atomic_is_load_store(insn)) {
+				err = emit_kasan_check(env, &prog, real_dst_reg,
+						       insn, ip, false,
+						       accesses_stack_only);
+				if (err)
+					return err;
 				branch_target = prog;
+			}
+			if (insn->imm == (BPF_AND | BPF_FETCH) ||
+			    insn->imm == (BPF_OR | BPF_FETCH) ||
+			    insn->imm == (BPF_XOR | BPF_FETCH)) {
 				/* Load old value */
 				emit_ldx(&prog, BPF_SIZE(insn->code),
 					 BPF_REG_0, real_dst_reg, insn->off);
@@ -2658,15 +2705,16 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
2.54.0

