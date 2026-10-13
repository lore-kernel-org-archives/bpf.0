Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A479C50391D
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913034; cv=none; b=ebPLrD+Bttb2/rBSW9aP/U51NukG7FAwihMmdKzPyJxHWOL0vKhP+sj86IxVLLxSMs2n+SCYzVVO4Wxg+VmYvwAlVhv9NADWWNHRqP8GgTlTw6adANp7PZQtFFYbLNJ4levARj3thb6utw/GXQtNqWFgY/NKUtiYUKQhAvN2g2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913034; c=relaxed/simple;
	bh=pXs1MWkPUbNkKjRmFA0h+KBH862JqDlOTBl3E1g2NLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ndioj1lRAPtdlHJxcTpSf3NgCphHvQzGf+hW1xh4m/ajNBE4N5I84vrHzeqmhfZ43Hzud+Y4Xo1oaFog/wipqu2XJRIZlhhxUGIkjsMJWqckvy6rymXDWD8dtaMjTs86K5t+6vKfmIGijkx6aQJw8LiNJNwLgQ7BLh633BI5jfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=g7O/hK8t; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="g7O/hK8t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BDKQ+3hxPzNBL3ROAUp/3qMXBGSR0e86nNIXwxg10LU=; b=g7O/hK8tfhivFrM/e0pR7x/RsD
	ibhmjdgUF31ymBOkJs/c1eoMstxDkpmnC7P4O4rRsQ26WZRzwGmFfX5/2gnTAvowJtIQgSuhH0EEI
	WsaYCyWCfjO1y9MzrQ35YkLKZwXCKlNeqFMjzjKt0ySZ4T8gOuUCX7wLNAngTEPTj4w5r1t2RbXUM
	s0JJ5oJ9sdDr0rD8JKFgaVRp07sWU8iyGGGyaRNIDBrD6LBTfyljXbSSQgIyZQ+JIQhF7hj9DgfFy
	0IJ+w1skzeLqGYWGxOwXtGtu8wjE7MZewUEEdAwYPCstJulq/Fp2BbMFZ3feT7SPtkhwwe3bcVqJ0
	hspAHa1Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGg3H-000PQo-13;
	Tue, 13 Oct 2026 19:12:35 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 07/18] bpf, x86: Consolidate the ALU, shift and neg encodings into helpers
Date: Tue, 13 Oct 2026 19:12:19 +0200
Message-ID: <20261013171230.523677-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013171230.523677-1-daniel@iogearbox.net>
References: <20261013171230.523677-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28152/Tue Oct 13 08:26:14 2026)

The add, sub, and, or and xor with an immediate or a register, the shifts
by an immediate and neg are open coded in the ALU cases of do_jit(), the
add with an immediate once more in the tail call and KASAN check sequences.
Add emit_alu_imm(), emit_alu_reg(), emit_shift_imm() and emit_neg() for
them and use them there, together with emit_mov_reg(), emit_mov_imm32()
and emit_add_rsp() for the open coded moves and stack adjustment in the
tail call, the division and the trampoline. The emitted code is unchanged.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 144 +++++++++++++++++++-----------------
 1 file changed, 78 insertions(+), 66 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e7439fb5037d..3e367600a0ad 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -473,6 +473,8 @@ static void emit_nops(u8 **pprog, int len)
  */
 static int emit_call(u8 **prog, void *func, void *ip);
 static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off);
+static void emit_mov_reg(u8 **pprog, bool is64, u32 dst_reg, u32 src_reg);
+static void emit_alu_imm(u8 **pprog, u32 op, u32 dst_reg, s32 imm, bool is64);
 
 static void emit_fineibt(u8 **pprog, u8 *ip, u32 hash, int arity)
 {
@@ -840,7 +842,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	 * if (index >= array->map.max_entries)
 	 *	goto out;
 	 */
-	EMIT2(0x89, 0xD2);                        /* mov edx, edx */
+	emit_mov_reg(&prog, false, BPF_REG_3, BPF_REG_3); /* mov edx, edx */
 	EMIT3(0x39, 0x56,                         /* cmp dword ptr [rsi + 16], edx */
 	      offsetof(struct bpf_array, map.max_entries));
 
@@ -894,8 +896,8 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	/* goto *(prog->bpf_func + X86_TAIL_CALL_OFFSET); */
 	EMIT4(0x48, 0x8B, 0x49,                   /* mov rcx, qword ptr [rcx + 32] */
 	      offsetof(struct bpf_prog, bpf_func));
-	EMIT4(0x48, 0x83, 0xC1,                   /* add rcx, X86_TAIL_CALL_OFFSET */
-	      X86_TAIL_CALL_OFFSET);
+	/* add rcx, X86_TAIL_CALL_OFFSET */
+	emit_alu_imm(&prog, BPF_ADD, BPF_REG_4, X86_TAIL_CALL_OFFSET, true);
 	/*
 	 * Now we're ready to jump into next BPF program
 	 * rdi == ctx (1st arg)
@@ -1204,6 +1206,67 @@ static void maybe_emit_1mod(u8 **pprog, u32 reg, bool is64)
 	*pprog = prog;
 }
 
+/* add/sub/and/or/xor dst_reg, imm with the imm8 and the rax short forms */
+static void emit_alu_imm(u8 **pprog, u32 op, u32 dst_reg, s32 imm, bool is64)
+{
+	/* ModR/M opcode extension and rax short form per operation */
+	static const u8 modrm[] = {
+		[BPF_ADD] = 0xC0, [BPF_SUB] = 0xE8, [BPF_AND] = 0xE0,
+		[BPF_OR] = 0xC8, [BPF_XOR] = 0xF0,
+	};
+	static const u8 short_op[] = {
+		[BPF_ADD] = 0x05, [BPF_SUB] = 0x2D, [BPF_AND] = 0x25,
+		[BPF_OR] = 0x0D, [BPF_XOR] = 0x35,
+	};
+	u8 *prog = *pprog;
+
+	maybe_emit_1mod(&prog, dst_reg, is64);
+	if (is_imm8(imm))
+		EMIT3(0x83, add_1reg(modrm[op], dst_reg), imm);
+	else if (is_axreg(dst_reg))
+		EMIT1_off32(short_op[op], imm);
+	else
+		EMIT2_off32(0x81, add_1reg(modrm[op], dst_reg), imm);
+
+	*pprog = prog;
+}
+
+/* add/sub/and/or/xor dst_reg, src_reg */
+static void emit_alu_reg(u8 **pprog, u32 op, u32 dst_reg, u32 src_reg, bool is64)
+{
+	u8 *prog = *pprog;
+
+	maybe_emit_mod(&prog, dst_reg, src_reg, is64);
+	EMIT2(simple_alu_opcodes[op], add_2reg(0xC0, dst_reg, src_reg));
+
+	*pprog = prog;
+}
+
+/* shl/shr/sar reg, imm */
+static void emit_shift_imm(u8 **pprog, u32 op, u32 reg, u8 imm, bool is64)
+{
+	u8 *prog = *pprog;
+
+	maybe_emit_1mod(&prog, reg, is64);
+	if (imm == 1)
+		EMIT2(0xD1, add_1reg(simple_alu_opcodes[op], reg));
+	else
+		EMIT3(0xC1, add_1reg(simple_alu_opcodes[op], reg), imm);
+
+	*pprog = prog;
+}
+
+/* neg dst_reg */
+static void emit_neg(u8 **pprog, u32 dst_reg, bool is64)
+{
+	u8 *prog = *pprog;
+
+	maybe_emit_1mod(&prog, dst_reg, is64);
+	EMIT2(0xF7, add_1reg(0xD8, dst_reg));
+
+	*pprog = prog;
+}
+
 static int emit_kasan_check(struct bpf_verifier_env *env, u8 **pprog,
 			    u32 addr_reg, s32 off, u32 bpf_size, u8 *ip,
 			    bool is_write)
@@ -1258,15 +1321,8 @@ static int emit_kasan_check(struct bpf_verifier_env *env, u8 **pprog,
 	EMIT_mov(BPF_REG_1, addr_reg);
 
 	/* add rdi, off (if offset is non-zero) */
-	if (off) {
-		if (is_imm8(off)) {
-			/* add rdi, imm8 */
-			EMIT4(0x48, 0x83, 0xC7, (u8)off);
-		} else {
-			/* add rdi, imm32 */
-			EMIT3_off32(0x48, 0x81, 0xC7, off);
-		}
-	}
+	if (off)
+		emit_alu_imm(&prog, BPF_ADD, BPF_REG_1, off, true);
 
 	/* Adjust ip to account for the instrumentation generated so far */
 	ip += (prog - *pprog);
@@ -2207,7 +2263,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		u32 dst_reg = insn->dst_reg;
 		u32 src_reg = insn->src_reg;
 		bool accesses_stack_only;
-		u8 b2 = 0, b3 = 0;
+		u8 b3 = 0;
 		u8 *start_of_ldx;
 		s64 jmp_offset;
 		s32 insn_off;
@@ -2247,10 +2303,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		case BPF_ALU64 | BPF_AND | BPF_X:
 		case BPF_ALU64 | BPF_OR | BPF_X:
 		case BPF_ALU64 | BPF_XOR | BPF_X:
-			maybe_emit_mod(&prog, dst_reg, src_reg,
-				       BPF_CLASS(insn->code) == BPF_ALU64);
-			b2 = simple_alu_opcodes[BPF_OP(insn->code)];
-			EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
+			emit_alu_reg(&prog, BPF_OP(insn->code), dst_reg, src_reg,
+				     BPF_CLASS(insn->code) == BPF_ALU64);
 			break;
 
 		case BPF_ALU64 | BPF_MOV | BPF_X:
@@ -2311,9 +2365,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			/* neg dst */
 		case BPF_ALU | BPF_NEG:
 		case BPF_ALU64 | BPF_NEG:
-			maybe_emit_1mod(&prog, dst_reg,
-					BPF_CLASS(insn->code) == BPF_ALU64);
-			EMIT2(0xF7, add_1reg(0xD8, dst_reg));
+			emit_neg(&prog, dst_reg, BPF_CLASS(insn->code) == BPF_ALU64);
 			break;
 
 		case BPF_ALU | BPF_ADD | BPF_K:
@@ -2341,42 +2393,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				break;
 			}
 
-			maybe_emit_1mod(&prog, dst_reg,
-					BPF_CLASS(insn->code) == BPF_ALU64);
-
-			/*
-			 * b3 holds 'normal' opcode, b2 short form only valid
-			 * in case dst is eax/rax.
-			 */
-			switch (BPF_OP(insn->code)) {
-			case BPF_ADD:
-				b3 = 0xC0;
-				b2 = 0x05;
-				break;
-			case BPF_SUB:
-				b3 = 0xE8;
-				b2 = 0x2D;
-				break;
-			case BPF_AND:
-				b3 = 0xE0;
-				b2 = 0x25;
-				break;
-			case BPF_OR:
-				b3 = 0xC8;
-				b2 = 0x0D;
-				break;
-			case BPF_XOR:
-				b3 = 0xF0;
-				b2 = 0x35;
-				break;
-			}
-
-			if (is_imm8(imm32))
-				EMIT3(0x83, add_1reg(b3, dst_reg), imm32);
-			else if (is_axreg(dst_reg))
-				EMIT1_off32(b2, imm32);
-			else
-				EMIT2_off32(0x81, add_1reg(b3, dst_reg), imm32);
+			emit_alu_imm(&prog, BPF_OP(insn->code), dst_reg, imm32,
+				     BPF_CLASS(insn->code) == BPF_ALU64);
 			break;
 
 		case BPF_ALU64 | BPF_MOV | BPF_K:
@@ -2429,7 +2447,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				 * xor edx, edx
 				 * equivalent to 'xor rdx, rdx', but one byte less
 				 */
-				EMIT2(0x31, 0xd2);
+				emit_mov_imm32(&prog, false, BPF_REG_3, 0);
 
 				/* div src_reg */
 				maybe_emit_1mod(&prog, src_reg, is64);
@@ -2493,14 +2511,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		case BPF_ALU64 | BPF_LSH | BPF_K:
 		case BPF_ALU64 | BPF_RSH | BPF_K:
 		case BPF_ALU64 | BPF_ARSH | BPF_K:
-			maybe_emit_1mod(&prog, dst_reg,
-					BPF_CLASS(insn->code) == BPF_ALU64);
-
-			b3 = simple_alu_opcodes[BPF_OP(insn->code)];
-			if (imm32 == 1)
-				EMIT2(0xD1, add_1reg(b3, dst_reg));
-			else
-				EMIT3(0xC1, add_1reg(b3, dst_reg), imm32);
+			emit_shift_imm(&prog, BPF_OP(insn->code), dst_reg,
+				       imm32, BPF_CLASS(insn->code) == BPF_ALU64);
 			break;
 
 		case BPF_ALU | BPF_LSH | BPF_X:
@@ -4206,7 +4218,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
 		/* skip our return address and return to parent */
-		EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
+		emit_add_rsp(&prog, 8); /* add rsp, 8 */
 	}
 	emit_return(&prog, image + (prog - (u8 *)rw_image));
 	/* Make sure the trampoline generation logic doesn't overflow */
-- 
2.43.0

