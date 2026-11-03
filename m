Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708867;
	b=D4LNpPpcEI2Cu5VoAH+YI29u+5Dn+QsDaFEyW3KkIXQ7WQrh3QjlbfDtzL6AQqk+KMq8
	 g5bi4RrvSE7ZbFQVA27xonmVYqCbqpaNpGFmobfIc8UGmczYxjWK5KQhNdRfkv1jNwNOF
	 HzlSw4ZKqb20NcjUxrSpxFgUtov8N9UlRYrxDi4Q0ivGRHhvl1r9E4gQSSSwnHgt8M1M9
	 wgafDvrbgSMX4tgFKnQK87B2E7yjAmBA2HS2ldYo5HgtAfUxByfq4Mhf2pNmaT+PKpadC
	 iYi0Pq9uBUPVCwy7gi6tV02Aia0cY+dVqmelnH+kCIivJgPmcDQIdDnekj93HkrJPXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708867;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=mcfBWFu+TLh6VHxlrGSI4KBwJabDRpuzgnM/MEaxr1c=;
	b=llJm4SDgQCZ92P4AN4jn6TechV1qt4uwy8wHc4JV77bjriJCkgpC1Wnozk6P6udaamBw
	 lBSBNGaDcOXZZXj6UP046Ov5z+3NZnfpdZXK7vcaJXxKDFEi1An9+Vq7FrcY0DsrFP06Q
	 qpwRDMybyVEPZqugULshl+gpac0N3kdwq4ZcUH0GwQaPm7dgdJsAkCotqzhZeIry3bE8R
	 ebWaE2+CbB5a6CJN8UPsGjekGpJM7yhBLRk9F+kifb5l3LPynaDH4Yvaz8iVD1LTab5qB
	 LfSAGCqEH1s6Sh5Gh7aKoak+elpSSKqMwEF7LD+9/uTfYLU9Qo8cJ81wi+bEe62EMwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b="j0Y/VTH4";
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35209606A333
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35209606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=j0Y/VTH4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mcfBWFu+TLh6VHxlrGSI4KBwJabDRpuzgnM/MEaxr1c=; b=j0Y/VTH45ryJGbTvsvEfr5eWFR
	Di2q2mhSpQo8m5MIWWL+rx6r6Fy5FEUV8AMYkMbN2wVw3gNt6S0susekOrvO8ywhQ+vdzta2bJ10U
	+InvhNmKkm0y+Y4jSsbWcc9asoi5p3o1tE4GSbvBEBpPiiqgNcMiwwbRLx/qwERxOxIq6LAy4i2Ij
	C0+FGb6MUPe6j0SpG3VCfaC9VUG2EM5VXGyQYL7eGm1fqZGO9C879nAKAz4utRGMCGHEyB8e+rjU0
	PMbMH3+IaLi8FP2IMahxY/sv/GmKyqy3Ghzod/79FJNAJQvMBqg9vRb4x5VrOlReHM0PcV0589Jjs
	Fa9ajEBg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xODc3-000MQz-1e;
	Tue, 03 Nov 2026 13:27:39 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 08/20] bpf, arm64: Consolidate the load and store emission into a helper
Date: Tue,  3 Nov 2026 13:27:21 +0100
Message-ID: <20261103122733.1383002-9-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103122733.1383002-1-daniel@iogearbox.net>
References: <20261103122733.1383002-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28173/Tue Nov  3 07:27:52 2026)

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
index 99f1d9bd13ea..41e2d1aef71f 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -357,6 +357,74 @@ static bool is_lsi_offset(int offset, int scale)
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
+						     false, size, a64_ldst_type(code, true)), ctx);
+	}
+}
+
 /* generated main prog prologue:
  *      bti c // if CONFIG_ARM64_BTI_KERNEL
  *      mov x9, lr
@@ -1455,9 +1523,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	const u8 tmp = bpf2a64[TMP_REG_1];
 	const u8 tmp2 = bpf2a64[TMP_REG_2];
 	const u8 tmp3 = bpf2a64[TMP_REG_3];
-	const u8 fp = bpf2a64[BPF_REG_FP];
 	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
-	const u8 priv_sp = bpf2a64[PRIVATE_SP];
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
 	const int i = insn - ctx->prog->insnsi;
@@ -1466,11 +1532,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
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
@@ -1963,70 +2025,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
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
@@ -2061,51 +2060,9 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
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
@@ -2130,49 +2087,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
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

