Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125493;
	b=jHSAYMA3Nfc5ccZ/YKkR76HsQeMEs6x169qX+S/3hpVj/noGaLsBoQvhklKnVI9WSMWP
	 enKNeqNFWJQqXmu64jEvWUA2YWg1ymSo2sHmI1a1tix+AFrme4JJ+98Rcd96SpZ7bNWBg
	 HebpxJoquM6uCa+Bjc2Fvml7MnJsUXBk3EiieM9Xzi1KCzp2gixQicnM1TVdiZekCDl9B
	 Zal1PuVje7GIN9/CWUcDft76rF/yYdbfxG/Nx2yhV7KNLMJ8CgTd/lwMbS0FilRGSZTZ3
	 QxCb8LycohI7NM9FEmUKupC5w/CR2pCyY0QyurdpLS3BahyrSt3umBx5Yz9JkFiId/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125493;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=7yAPeUBnzkuDc2AJf/5TLOMdkLrCn7ppGZz1NX1aa5Y=;
	b=Hj2jBmp22z5uvgTc2eCeGY0Y5FBPQuMRLiNOX/wbQFoia9GvIRzuuNGy/JeLE6Up+JeX
	 3fisEOl7hFolZB/m/VE88BMvFSnqsc26laJs69fcCKHzGR563HTxMrCyQ9h0w/9L4qYoL
	 ngN84EQxpE0K+9lD5wRKXzKEBum4ECjYdvp499E9px+beVYKDxJ/XYaS2kspHrhysWMRc
	 ThEkSkp9mJallxV5+pcMCllYPHaXbr7+ZTrM8ExSPlxmBT6ta6rX2uiWpHmIkpu61eFNO
	 L9/FPnii8fntiZEAyhBOgi5QcRuLsVnsrMArsjTIXJsdwF+sCalfa+6RAFa8TQpPjNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=T7q3dhs9;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5214606A322
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5214606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=T7q3dhs9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7yAPeUBnzkuDc2AJf/5TLOMdkLrCn7ppGZz1NX1aa5Y=; b=T7q3dhs9TQiHmS/hcAL3g1CJ/w
	/rambXh6ele8NlsU7Ww0/T1mpRsDoA9jXhPDRI5cUfDTTEu7qscjW3S1YXC86IlF+p/A6reSGwR/g
	PFqNWRV7826sSd1GLin/NjIXyg2jALSb18FSz1aTybYS+kLiMgLLqiGfuVuDBdwkMrlgPnJp2mGBe
	K/AzCDJOiITMrBDn8GCqqZ4eafrExIn0rPRhrlAqcW6O5q8zpRYp4Onl+SRU4NYQuNOALl5Mvm2i9
	CGQ5tRQauIu/z4uol+MyXugxcfHg6lh5wkr5BNhTzx/U1diZzHKB04nK20IjWBAtTR+oI4ph4dnjp
	s3kHj11w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqt-000Ikz-1C;
	Tue, 27 Oct 2026 19:24:51 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 08/21] bpf, arm64: Consolidate the load and store emission into a helper
Date: Tue, 27 Oct 2026 19:24:32 +0100
Message-ID: <20261027182445.1156335-9-daniel@iogearbox.net>
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

The BPF_LDX, BPF_ST and BPF_STX cases each pick the base and offset of
an access through the frame pointer, and then switch over the access
size to emit the immediate offset form or the register offset fallback,
three times the same code. Add emit_ldst() for it, with the A64 size
and type derived from the instruction. The emitted code is unchanged.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c | 227 +++++++++++-----------------------
 1 file changed, 71 insertions(+), 156 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index b651b4ba3e63..4dc465772937 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -346,6 +346,74 @@ static bool is_lsi_offset(int offset, int scale)
 	return true;
 }
 
+/* The A64 size of a BPF load or store, and the scale of its offset */
+static enum aarch64_insn_size_type a64_ldst_size(const u8 code, int *scale)
+{
+	switch (BPF_SIZE(code)) {
+	case BPF_B:
+		*scale = 0;
+		return AARCH64_INSN_SIZE_8;
+	case BPF_H:
+		*scale = 1;
+		return AARCH64_INSN_SIZE_16;
+	case BPF_W:
+		*scale = 2;
+		return AARCH64_INSN_SIZE_32;
+	default:
+		*scale = 3;
+		return AARCH64_INSN_SIZE_64;
+	}
+}
+
+/* The A64 type of a BPF load or store, in the immediate or register offset form */
+static enum aarch64_insn_ldst_type a64_ldst_type(const u8 code, bool reg_offset)
+{
+	if (BPF_CLASS(code) != BPF_LDX)
+		return reg_offset ? AARCH64_INSN_LDST_STORE_REG_OFFSET :
+				    AARCH64_INSN_LDST_STORE_IMM_OFFSET;
+	if (BPF_MODE(code) == BPF_MEMSX || BPF_MODE(code) == BPF_PROBE_MEMSX ||
+	    BPF_MODE(code) == BPF_PROBE_MEM32SX)
+		return reg_offset ? AARCH64_INSN_LDST_SIGNED_LOAD_REG_OFFSET :
+				    AARCH64_INSN_LDST_SIGNED_LOAD_IMM_OFFSET;
+	return reg_offset ? AARCH64_INSN_LDST_LOAD_REG_OFFSET :
+			    AARCH64_INSN_LDST_LOAD_IMM_OFFSET;
+}
+
+/*
+ * Load or store of a BPF access size at rn + off. An access through the
+ * frame pointer goes from the stack pointer, or from the private stack
+ * pointer, with the offset adjusted by the frame size, and takes the
+ * frame pointer register for the register offset form.
+ */
+static void emit_ldst(const u8 code, const u8 rt, const u8 rn, const s32 off,
+		      const u8 tmp, struct jit_ctx *ctx)
+{
+	enum aarch64_insn_size_type size;
+	s32 off_adj = off;
+	u8 rn_adj = rn;
+	int scale;
+
+	size = a64_ldst_size(code, &scale);
+	if (rn == bpf2a64[BPF_REG_FP]) {
+		if (ctx->priv_sp_used) {
+			rn_adj = bpf2a64[PRIVATE_SP];
+			off_adj += ctx->stack_size;
+		} else {
+			rn_adj = A64_SP;
+			off_adj += ctx->stack_size + ctx->stack_arg_size;
+		}
+	}
+
+	if (is_lsi_offset(off_adj, scale)) {
+		emit(aarch64_insn_gen_load_store_imm(rt, rn_adj, off_adj, size,
+						     a64_ldst_type(code, false)), ctx);
+	} else {
+		emit_a64_mov_i(1, tmp, off, ctx);
+		emit(aarch64_insn_gen_load_store_reg(rt, rn, tmp, AARCH64_INSN_EXTEND_UXTX,
+						     size, a64_ldst_type(code, true)), ctx);
+	}
+}
+
 /* generated main prog prologue:
  *      bti c // if CONFIG_ARM64_BTI_KERNEL
  *      mov x9, lr
@@ -1444,9 +1512,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	const u8 tmp = bpf2a64[TMP_REG_1];
 	const u8 tmp2 = bpf2a64[TMP_REG_2];
 	const u8 tmp3 = bpf2a64[TMP_REG_3];
-	const u8 fp = bpf2a64[BPF_REG_FP];
 	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
-	const u8 priv_sp = bpf2a64[PRIVATE_SP];
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
 	const int i = insn - ctx->prog->insnsi;
@@ -1455,11 +1521,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	u8 jmp_cond;
 	s32 jmp_offset;
 	u32 a64_insn;
-	u8 src_adj;
-	u8 dst_adj;
-	int off_adj;
 	int ret;
-	bool sign_extend;
 
 	if (bpf_insn_is_indirect_target(env, ctx->prog, i))
 		emit_bti(A64_BTI_J, ctx);
@@ -1952,70 +2014,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 			emit(A64_ADD(1, tmp2, src, arena_vm_base), ctx);
 			src = tmp2;
 		}
-		if (src == fp) {
-			src_adj = ctx->priv_sp_used ? priv_sp : A64_SP;
-			off_adj = off + ctx->stack_size;
-			if (!ctx->priv_sp_used)
-				off_adj += ctx->stack_arg_size;
-		} else {
-			src_adj = src;
-			off_adj = off;
-		}
-		sign_extend = (BPF_MODE(insn->code) == BPF_MEMSX ||
-				BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
-				 BPF_MODE(insn->code) == BPF_PROBE_MEM32SX);
-		switch (BPF_SIZE(code)) {
-		case BPF_W:
-			if (is_lsi_offset(off_adj, 2)) {
-				if (sign_extend)
-					emit(A64_LDRSWI(dst, src_adj, off_adj), ctx);
-				else
-					emit(A64_LDR32I(dst, src_adj, off_adj), ctx);
-			} else {
-				emit_a64_mov_i(1, tmp, off, ctx);
-				if (sign_extend)
-					emit(A64_LDRSW(dst, src, tmp), ctx);
-				else
-					emit(A64_LDR32(dst, src, tmp), ctx);
-			}
-			break;
-		case BPF_H:
-			if (is_lsi_offset(off_adj, 1)) {
-				if (sign_extend)
-					emit(A64_LDRSHI(dst, src_adj, off_adj), ctx);
-				else
-					emit(A64_LDRHI(dst, src_adj, off_adj), ctx);
-			} else {
-				emit_a64_mov_i(1, tmp, off, ctx);
-				if (sign_extend)
-					emit(A64_LDRSH(dst, src, tmp), ctx);
-				else
-					emit(A64_LDRH(dst, src, tmp), ctx);
-			}
-			break;
-		case BPF_B:
-			if (is_lsi_offset(off_adj, 0)) {
-				if (sign_extend)
-					emit(A64_LDRSBI(dst, src_adj, off_adj), ctx);
-				else
-					emit(A64_LDRBI(dst, src_adj, off_adj), ctx);
-			} else {
-				emit_a64_mov_i(1, tmp, off, ctx);
-				if (sign_extend)
-					emit(A64_LDRSB(dst, src, tmp), ctx);
-				else
-					emit(A64_LDRB(dst, src, tmp), ctx);
-			}
-			break;
-		case BPF_DW:
-			if (is_lsi_offset(off_adj, 3)) {
-				emit(A64_LDR64I(dst, src_adj, off_adj), ctx);
-			} else {
-				emit_a64_mov_i(1, tmp, off, ctx);
-				emit(A64_LDR64(dst, src, tmp), ctx);
-			}
-			break;
-		}
+		emit_ldst(code, dst, src, off, tmp, ctx);
 
 		ret = add_exception_handler(insn, ctx, dst);
 		if (ret)
@@ -2050,51 +2049,9 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 			emit(A64_ADD(1, tmp3, dst, arena_vm_base), ctx);
 			dst = tmp3;
 		}
-		if (dst == fp) {
-			dst_adj = ctx->priv_sp_used ? priv_sp : A64_SP;
-			off_adj = off + ctx->stack_size;
-			if (!ctx->priv_sp_used)
-				off_adj += ctx->stack_arg_size;
-		} else {
-			dst_adj = dst;
-			off_adj = off;
-		}
 		/* Load imm to a register then store it */
 		emit_a64_mov_i(1, tmp, imm, ctx);
-		switch (BPF_SIZE(code)) {
-		case BPF_W:
-			if (is_lsi_offset(off_adj, 2)) {
-				emit(A64_STR32I(tmp, dst_adj, off_adj), ctx);
-			} else {
-				emit_a64_mov_i(1, tmp2, off, ctx);
-				emit(A64_STR32(tmp, dst, tmp2), ctx);
-			}
-			break;
-		case BPF_H:
-			if (is_lsi_offset(off_adj, 1)) {
-				emit(A64_STRHI(tmp, dst_adj, off_adj), ctx);
-			} else {
-				emit_a64_mov_i(1, tmp2, off, ctx);
-				emit(A64_STRH(tmp, dst, tmp2), ctx);
-			}
-			break;
-		case BPF_B:
-			if (is_lsi_offset(off_adj, 0)) {
-				emit(A64_STRBI(tmp, dst_adj, off_adj), ctx);
-			} else {
-				emit_a64_mov_i(1, tmp2, off, ctx);
-				emit(A64_STRB(tmp, dst, tmp2), ctx);
-			}
-			break;
-		case BPF_DW:
-			if (is_lsi_offset(off_adj, 3)) {
-				emit(A64_STR64I(tmp, dst_adj, off_adj), ctx);
-			} else {
-				emit_a64_mov_i(1, tmp2, off, ctx);
-				emit(A64_STR64(tmp, dst, tmp2), ctx);
-			}
-			break;
-		}
+		emit_ldst(code, tmp, dst, off, tmp2, ctx);
 
 		ret = add_exception_handler(insn, ctx, DONT_CLEAR);
 		if (ret)
@@ -2119,49 +2076,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 			emit(A64_ADD(1, tmp2, dst, arena_vm_base), ctx);
 			dst = tmp2;
 		}
-		if (dst == fp) {
-			dst_adj = ctx->priv_sp_used ? priv_sp : A64_SP;
-			off_adj = off + ctx->stack_size;
-			if (!ctx->priv_sp_used)
-				off_adj += ctx->stack_arg_size;
-		} else {
-			dst_adj = dst;
-			off_adj = off;
-		}
-		switch (BPF_SIZE(code)) {
-		case BPF_W:
-			if (is_lsi_offset(off_adj, 2)) {
-				emit(A64_STR32I(src, dst_adj, off_adj), ctx);
-			} else {
-				emit_a64_mov_i(1, tmp, off, ctx);
-				emit(A64_STR32(src, dst, tmp), ctx);
-			}
-			break;
-		case BPF_H:
-			if (is_lsi_offset(off_adj, 1)) {
-				emit(A64_STRHI(src, dst_adj, off_adj), ctx);
-			} else {
-				emit_a64_mov_i(1, tmp, off, ctx);
-				emit(A64_STRH(src, dst, tmp), ctx);
-			}
-			break;
-		case BPF_B:
-			if (is_lsi_offset(off_adj, 0)) {
-				emit(A64_STRBI(src, dst_adj, off_adj), ctx);
-			} else {
-				emit_a64_mov_i(1, tmp, off, ctx);
-				emit(A64_STRB(src, dst, tmp), ctx);
-			}
-			break;
-		case BPF_DW:
-			if (is_lsi_offset(off_adj, 3)) {
-				emit(A64_STR64I(src, dst_adj, off_adj), ctx);
-			} else {
-				emit_a64_mov_i(1, tmp, off, ctx);
-				emit(A64_STR64(src, dst, tmp), ctx);
-			}
-			break;
-		}
+		emit_ldst(code, src, dst, off, tmp, ctx);
 
 		ret = add_exception_handler(insn, ctx, DONT_CLEAR);
 		if (ret)
-- 
2.43.0

