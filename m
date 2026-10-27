Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125495;
	b=fw1c2GU5A+6dm+eFQKsXwv3tH6AtyAo4pLPvJsym2YzjB8n4iTqKnilQivS1rfDxoBqS
	 JF4eUZDcA/0AhHkAuBZhuHYGUSi23TsbQDjsexE1hHaF+6gW0NSsLFnPMzYrrRgVHYeyE
	 j2XRiPyGZ3xlVaGb5UIw3Foq9agbZjWrSJ/89AjL4+WIVDn/ME7x+GE2aIw4OYmuxq+qy
	 ApDWRAgNLa5RO+IlBxJSrUvJK0thJhITQ1z0rXjVmSrfi+DoqX4e3nc3JjQj2JLQuH/UJ
	 vwW01JUSflPbe/Qqb5tybSSnFPx8n7OVWBq/iUEWdsYPfvRvDr2TV+7u9g08jNlhKjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125495;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=5YMM3S9lsjoPu0Kltrz/VKSXJj5G1lS2EUTXNYGBy7o=;
	b=tgFgA+Du6SDXJpb1+J5eSzznpW9Up2lLsctDDtLPGhBDgQtjIAdk43EY/DWGZ3zn1txN
	 oPwwjGPVPjG8bBI1pjhjGsL5HmLBHeSqHO8Rya7xFOTQVFp8QbAy9apB7/qlbouOyouzA
	 SMCTMS1Ymp1PV1r6VVFVycCjMc1hbhcE8LSFz649NQce2P0lmVZp6RFOHrfxO1cCFEzJO
	 WBpyzPEdSPSnsFznvF+dq7wjVlvTtKcKocTdzMeqrIPBsgGJ2iQkKkkAdLYWPiH7yMVdc
	 SjVmfuT7xQGCV/2doisjjFVXk8b6QME6kc3vAlGb/gKYmt6B6nK6eCHS9Aub/GhM0jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=G1g5bwga;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE71606A32F
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE71606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=G1g5bwga
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5YMM3S9lsjoPu0Kltrz/VKSXJj5G1lS2EUTXNYGBy7o=; b=G1g5bwgaLdceDD5Wz8qo2YtSvr
	L0fiSUqmSuGgCW4tOQHbXKffT9sKMwwrxbRyLo6NH8H0gTb0cMfwPPrIZoaA7S1bfO+7U67vbiOzk
	aD4WC6hCaFM0odoXjM15iVsln8qih/Pq4rAU36FHtdvBJEOm6oBZ/ySWbRhTaifuoACIXg9vOzzg9
	TGyVip6fSNjQKvEQd4Jjx915AFuwdUlPNrZ907Yza75fb4QIAgbjo6y210qRw5r+4aWG55WbPgJYo
	BuquDJi7Jm1uvy/cN1MwLw3im+D5VNQGNcu4VoUNd8uJKoXga0bbzvvNw/wPHuGJDBO3iTIV+OXQb
	ewWENtkQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqu-000IlW-2S;
	Tue, 27 Oct 2026 19:24:52 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 11/21] bpf, arm64: Zero extend the arena offset in register offset accesses
Date: Tue, 27 Oct 2026 19:24:35 +0100
Message-ID: <20261027182445.1156335-12-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027182445.1156335-1-daniel@iogearbox.net>
References: <20261027182445.1156335-1-daniel@iogearbox.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)

An arena access added the register holding the 32-bit arena offset to
the kernel base of the arena with a 64-bit add and went through the sum
with the immediate offset. That relies on the verifier to keep the upper
32 bits of the register zero, and any slip there would let the access
escape the 4GB arena into whatever the kernel maps next to it.

Take the register offset form with UXTW instead, which zero extends the
offset register in the access itself, so that it stays within the arena
and its guard pages whatever the upper half holds. Without an immediate
offset this also saves the add and its cycle on every access. With one,
the offset is added to the arena base first, off the path of the offset
register, which shortens that path by a cycle. The add takes offsets up
to 4095 in magnitude and multiples of 4K as its immediate, two
instructions, one fewer than before for negative offsets below -256,
unaligned ones above 255 and multiples of 4K beyond the reach of the
scaled forms, and any other offset needs a move, three instructions
where the load or store took two for most aligned offsets from 4K on.
The atomics, whose base must be a register, add the extended offset onto
the base, a cycle more on that path without an immediate offset at the
same number of instructions. The exception handler is unaffected, it
reports the fault from the offset register, which the access leaves
intact, and the immediate offset.

Update the arm64 expectations of the Arena LDSX Disasm test of
verifier_ldsx to the new form.

Before/after for r0 = *(u64 *)(r1 + 0) and r0 = *(u64 *)(r1 + 8) in the
arena:

  8b1c000b  add x11, x0, x28
  f9400168  ldr x8, [x11]
  f8604b88  ldr x8, [x28, w0, uxtw]

  8b1c000b  add x11, x0, x28
  f9400568  ldr x8, [x11, #8]
  9100238b  add x11, x28, #0x8
  f8604968  ldr x8, [x11, w0, uxtw]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c                 | 91 +++++++++++++------
 .../selftests/bpf/progs/verifier_ldsx.c       | 24 ++---
 2 files changed, 77 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c54f39a8b679..8b416c74858e 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -443,6 +443,29 @@ static void emit_ldst(const u8 code, const u8 rt, const u8 rn, const s32 off,
 	}
 }
 
+/*
+ * Load or store at an arena address: the register holds the offset into
+ * the arena in its low 32 bits, which the register offset form adds zero
+ * extended to the base register, the arena base with the immediate offset
+ * added into tmp_addr first, off the path of the register. The verifier
+ * keeps the upper 32 bits zero, the extension keeps the access in the
+ * arena and its guard regardless.
+ */
+static void emit_arena_ldst(const u8 code, const u8 rt, const u8 reg, const s32 off,
+			    const u8 tmp_addr, const u8 tmp, struct jit_ctx *ctx)
+{
+	u8 base = bpf2a64[ARENA_VM_START];
+	int scale;
+
+	if (off) {
+		emit_a64_add_i(1, tmp_addr, base, tmp, off, ctx);
+		base = tmp_addr;
+	}
+	emit(aarch64_insn_gen_load_store_reg(rt, base, reg, AARCH64_INSN_EXTEND_UXTW,
+					     a64_ldst_size(code, &scale),
+					     a64_ldst_type(code, A64_LDST_REG)), ctx);
+}
+
 /* generated main prog prologue:
  *      bti c // if CONFIG_ARM64_BTI_KERNEL
  *      mov x9, lr
@@ -823,6 +846,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const u8 dst = bpf2a64[insn->dst_reg];
 	const u8 src = bpf2a64[insn->src_reg];
 	const u8 tmp = bpf2a64[TMP_REG_1];
+	const u8 tmp2 = bpf2a64[TMP_REG_2];
 	u8 reg;
 
 	switch (imm) {
@@ -837,12 +861,21 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		return -EINVAL;
 	}
 
-	if (off) {
-		emit_a64_add_i(1, tmp, reg, tmp, off, ctx);
-		reg = tmp;
-	}
+	/*
+	 * The arena base with the offset first and the arena offset zero
+	 * extended onto it, see emit_arena_ldst()
+	 */
 	if (arena) {
-		emit(A64_ADD(1, tmp, reg, arena_vm_base), ctx);
+		u8 base = arena_vm_base;
+
+		if (off) {
+			emit_a64_add_i(1, tmp, base, tmp, off, ctx);
+			base = tmp;
+		}
+		emit(A64_ADD_UXTW(tmp2, base, reg), ctx);
+		reg = tmp2;
+	} else if (off) {
+		emit_a64_add_i(1, tmp, reg, tmp, off, ctx);
 		reg = tmp;
 	}
 
@@ -896,17 +929,27 @@ static int emit_lse_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const u8 src = bpf2a64[insn->src_reg];
 	const u8 tmp = bpf2a64[TMP_REG_1];
 	const u8 tmp2 = bpf2a64[TMP_REG_2];
+	const u8 tmp3 = bpf2a64[TMP_REG_3];
 	const bool isdw = BPF_SIZE(code) == BPF_DW;
 	const bool arena = BPF_MODE(code) == BPF_PROBE_ATOMIC;
 	const s16 off = insn->off;
 	u8 reg = dst;
 
-	if (off) {
-		emit_a64_add_i(1, tmp, reg, tmp, off, ctx);
-		reg = tmp;
-	}
+	/*
+	 * The arena base with the offset first and the arena offset zero
+	 * extended onto it, see emit_arena_ldst()
+	 */
 	if (arena) {
-		emit(A64_ADD(1, tmp, reg, arena_vm_base), ctx);
+		u8 base = arena_vm_base;
+
+		if (off) {
+			emit_a64_add_i(1, tmp, base, tmp, off, ctx);
+			base = tmp;
+		}
+		emit(A64_ADD_UXTW(tmp3, base, reg), ctx);
+		reg = tmp3;
+	} else if (off) {
+		emit_a64_add_i(1, tmp, reg, tmp, off, ctx);
 		reg = tmp;
 	}
 
@@ -1541,7 +1584,6 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	const u8 tmp = bpf2a64[TMP_REG_1];
 	const u8 tmp2 = bpf2a64[TMP_REG_2];
 	const u8 tmp3 = bpf2a64[TMP_REG_3];
-	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
 	const int i = insn - ctx->prog->insnsi;
@@ -2039,11 +2081,10 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
 	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
 		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
-		    BPF_MODE(insn->code) == BPF_PROBE_MEM32SX) {
-			emit(A64_ADD(1, tmp2, src, arena_vm_base), ctx);
-			src = tmp2;
-		}
-		emit_ldst(code, dst, src, off, tmp, ctx);
+		    BPF_MODE(insn->code) == BPF_PROBE_MEM32SX)
+			emit_arena_ldst(code, dst, src, off, tmp2, tmp, ctx);
+		else
+			emit_ldst(code, dst, src, off, tmp, ctx);
 
 		ret = add_exception_handler(insn, ctx, dst);
 		if (ret)
@@ -2074,14 +2115,13 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
-		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
-			emit(A64_ADD(1, tmp3, dst, arena_vm_base), ctx);
-			dst = tmp3;
-		}
 		/* A zero comes from the zero register, any other imm through a register */
 		if (imm)
 			emit_a64_mov_i(1, tmp, imm, ctx);
-		emit_ldst(code, imm ? tmp : A64_ZR, dst, off, tmp2, ctx);
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32)
+			emit_arena_ldst(code, imm ? tmp : A64_ZR, dst, off, tmp3, tmp2, ctx);
+		else
+			emit_ldst(code, imm ? tmp : A64_ZR, dst, off, tmp2, ctx);
 
 		ret = add_exception_handler(insn, ctx, DONT_CLEAR);
 		if (ret)
@@ -2102,11 +2142,10 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
-		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
-			emit(A64_ADD(1, tmp2, dst, arena_vm_base), ctx);
-			dst = tmp2;
-		}
-		emit_ldst(code, src, dst, off, tmp, ctx);
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32)
+			emit_arena_ldst(code, src, dst, off, tmp2, tmp, ctx);
+		else
+			emit_ldst(code, src, dst, off, tmp, ctx);
 
 		ret = add_exception_handler(insn, ctx, DONT_CLEAR);
 		if (ret)
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index 49e8cd4bb4f9..03adebb4acbc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -276,18 +276,18 @@ __jited("movslq	0x10(%rdi,%r12), %r15")
 __jited("movswq	0x18(%rdi,%r12), %r15")
 __jited("movsbq	0x20(%rdi,%r12), %r15")
 __arch_arm64
-__jited("add	x11, x8, x28")
-__jited("ldrsw	x21, [x11, #0x10]")
-__jited("add	x11, x8, x28")
-__jited("ldrsh	x21, [x11, #0x18]")
-__jited("add	x11, x8, x28")
-__jited("ldrsb	x21, [x11, #0x20]")
-__jited("add	x11, x0, x28")
-__jited("ldrsw	x22, [x11, #0x10]")
-__jited("add	x11, x0, x28")
-__jited("ldrsh	x22, [x11, #0x18]")
-__jited("add	x11, x0, x28")
-__jited("ldrsb	x22, [x11, #0x20]")
+__jited("add	x11, x28, #0x10")
+__jited("ldrsw	x21, [x11, w8, uxtw]")
+__jited("add	x11, x28, #0x18")
+__jited("ldrsh	x21, [x11, w8, uxtw]")
+__jited("add	x11, x28, #0x20")
+__jited("ldrsb	x21, [x11, w8, uxtw]")
+__jited("add	x11, x28, #0x10")
+__jited("ldrsw	x22, [x11, w0, uxtw]")
+__jited("add	x11, x28, #0x18")
+__jited("ldrsh	x22, [x11, w0, uxtw]")
+__jited("add	x11, x28, #0x20")
+__jited("ldrsb	x22, [x11, w0, uxtw]")
 __arch_riscv64
 __jited("add	t2, t6, s7")
 __jited("lw	s3, 0x10(t2)")
-- 
2.43.0

