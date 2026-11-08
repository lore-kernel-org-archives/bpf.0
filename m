Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166076;
	b=AcpwhWAjx/x/rGTwjketWi2VZUBzVn8hjMHLGV0abwsxK+zjigv/Mc+hL3zeD7LRsILZ
	 iN/hF2bI/HCEXf9hNf1PqK0d0S70RoXGwWOf7Aofn0oEjJ3iB0EEVXpuBaxeb2knL9swV
	 P5/e46dmNpmXeGTKEwpPXUGKD/+1PUmI5rYXRGuFvRoqSQ04138RbCe/T45uYa7ovrOeK
	 +H82JkgJtlU/2RVkU+lh3WRH4SqOIHyNFgYUofo4quDwtNMsOx9S0LRgccnGJVD5WFG6i
	 4U42firwFXonETzHXZgyFKKVoA2jhU8kj6TLyigmDgxVYK8Dh3fCtQR2PopyWIAo12w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166076;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=C97h08nfYMMqupnAQRv9e947RpQoiqZ91nTKWfyVKqc=;
	b=SHZUVVrbTgsLzCD1hSg/cJ/k/AgryXZa+BZPrwr7OOHMK2/x/Na93zWqFnVFheqLxjNx
	 dCP0a835IYCwgUl9pH3hL1bh28IJbjsvk9/JRiaNeYVQ+KVNtw3YxYCFSPojvKGb6p61O
	 oeRb3Nx1Qs0zByU6tibORr6fQ56WvcKfyypvMTSJV2ORrzBqcAAlY4d1nB86JZMe4c011
	 HXkx+gXDapf/erWRNSWgscgVfsS56JH/WIPajrYaF7RBWcfKH83JjnJwZENsXC9lpTZdY
	 ot1tDcP2x14u3JzCNReAfj8EzsVfNmePGsvMBkDxQPdEHzbE+IYgewqAoV2xbRBQ1PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=HoLsBRyA;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1350A606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1350A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=HoLsBRyA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=C97h08nfYMMqupnAQRv9e947RpQoiqZ91nTKWfyVKqc=; b=HoLsBRyADDAq05zZkh+5YCXCaS
	x76Mnpx+X4h3GoJgCxrgJ8HiPBrSGsSK1NH8jT1BPdmNrcdPADarEAaUK9pk3UAsXhpCkMrT5mNuf
	FJ6qBHDQsmrT9dekF5BBY15Q2/N9foB41ER1DL5rwcwAfRwogAkH+zh84alW5zErFDQbIscevilbj
	aYwkVG12ZcaJR1xemrCnc9tCOZKC4qb+pLpQXYNLt3jPTCM9CONifZQXJGD181sNUB3BdtjcPAo5H
	tUTNmYHU+jDvGwKxPFO3LwOdTxsJgzfh9d5wLdxQtr7F1FJ8elZg7oeGRh39mF3OADR/XLtpyj8OG
	qCeIQpYw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8YT-000Pnk-2u;
	Sun, 08 Nov 2026 20:27:54 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 12/24] bpf, arm64: Consolidate the load and store emission into a helper
Date: Sun,  8 Nov 2026 20:26:38 +0100
Message-ID: <b713e8dcb8cf050002ecdf42efb18fd441f2e275.1794165614.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794165614.git.daniel@iogearbox.net>
References: <cover.1794165614.git.daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28177/Sun Nov  8 07:23:52 2026)

The BPF_LDX, BPF_ST and BPF_STX cases each repeat the frame pointer
adjustment and the switch over the access size. Move that into a new
emit_ldst() helper, and remove the A64_LDR*() and A64_STR*() macros
that lose their last user. The emitted code is unchanged.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit.h      |  17 ---
 arch/arm64/net/bpf_jit_comp.c | 230 +++++++++++-----------------------
 2 files changed, 73 insertions(+), 174 deletions(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index 3dcc2d2cf035..882404b884e1 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -62,16 +62,7 @@
 		AARCH64_INSN_LDST_##type##_REG_OFFSET)
 #define A64_LS_REG(Rt, Rn, Rm, size, type) \
 	A64_LS_REG_EXT(Rt, Rn, Rm, UXTX, 0, size, type)
-#define A64_STRB(Wt, Xn, Xm)  A64_LS_REG(Wt, Xn, Xm, 8, STORE)
-#define A64_LDRB(Wt, Xn, Xm)  A64_LS_REG(Wt, Xn, Xm, 8, LOAD)
-#define A64_LDRSB(Xt, Xn, Xm) A64_LS_REG(Xt, Xn, Xm, 8, SIGNED_LOAD)
-#define A64_STRH(Wt, Xn, Xm)  A64_LS_REG(Wt, Xn, Xm, 16, STORE)
-#define A64_LDRH(Wt, Xn, Xm)  A64_LS_REG(Wt, Xn, Xm, 16, LOAD)
-#define A64_LDRSH(Xt, Xn, Xm) A64_LS_REG(Xt, Xn, Xm, 16, SIGNED_LOAD)
-#define A64_STR32(Wt, Xn, Xm) A64_LS_REG(Wt, Xn, Xm, 32, STORE)
 #define A64_LDR32(Wt, Xn, Xm) A64_LS_REG(Wt, Xn, Xm, 32, LOAD)
-#define A64_LDRSW(Xt, Xn, Xm) A64_LS_REG(Xt, Xn, Xm, 32, SIGNED_LOAD)
-#define A64_STR64(Xt, Xn, Xm) A64_LS_REG(Xt, Xn, Xm, 64, STORE)
 #define A64_LDR64(Xt, Xn, Xm) A64_LS_REG(Xt, Xn, Xm, 64, LOAD)
 
 /* Load/store register (immediate offset) */
@@ -79,15 +70,7 @@
 	aarch64_insn_gen_load_store_imm(Rt, Rn, imm, \
 		AARCH64_INSN_SIZE_##size, \
 		AARCH64_INSN_LDST_##type##_IMM_OFFSET)
-#define A64_STRBI(Wt, Xn, imm)  A64_LS_IMM(Wt, Xn, imm, 8, STORE)
-#define A64_LDRBI(Wt, Xn, imm)  A64_LS_IMM(Wt, Xn, imm, 8, LOAD)
-#define A64_LDRSBI(Xt, Xn, imm) A64_LS_IMM(Xt, Xn, imm, 8, SIGNED_LOAD)
-#define A64_STRHI(Wt, Xn, imm)  A64_LS_IMM(Wt, Xn, imm, 16, STORE)
-#define A64_LDRHI(Wt, Xn, imm)  A64_LS_IMM(Wt, Xn, imm, 16, LOAD)
-#define A64_LDRSHI(Xt, Xn, imm) A64_LS_IMM(Xt, Xn, imm, 16, SIGNED_LOAD)
-#define A64_STR32I(Wt, Xn, imm) A64_LS_IMM(Wt, Xn, imm, 32, STORE)
 #define A64_LDR32I(Wt, Xn, imm) A64_LS_IMM(Wt, Xn, imm, 32, LOAD)
-#define A64_LDRSWI(Xt, Xn, imm) A64_LS_IMM(Xt, Xn, imm, 32, SIGNED_LOAD)
 #define A64_STR64I(Xt, Xn, imm) A64_LS_IMM(Xt, Xn, imm, 64, STORE)
 #define A64_LDR64I(Xt, Xn, imm) A64_LS_IMM(Xt, Xn, imm, 64, LOAD)
 
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 3403f4327de8..05ba44f47313 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -365,6 +365,73 @@ static bool is_lsi_offset(int offset, int scale)
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
+ * Load or store of a BPF access size at rn + off, from the (private) stack
+ * pointer with the frame size added for the frame pointer, which the register
+ * offset form keeps.
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
+						     0, size, a64_ldst_type(code, true)), ctx);
+	}
+}
+
 /* generated main prog prologue:
  *      bti c // if CONFIG_ARM64_BTI_KERNEL
  *      mov x9, lr
@@ -1468,9 +1535,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	const u8 tmp = bpf2a64[TMP_REG_1];
 	const u8 tmp2 = bpf2a64[TMP_REG_2];
 	const u8 tmp3 = bpf2a64[TMP_REG_3];
-	const u8 fp = bpf2a64[BPF_REG_FP];
 	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
-	const u8 priv_sp = bpf2a64[PRIVATE_SP];
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
 	const int i = insn - ctx->prog->insnsi;
@@ -1479,11 +1544,8 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	u8 jmp_cond;
 	s32 jmp_offset;
 	u32 a64_insn;
-	u8 src_adj;
-	u8 dst_adj;
 	int off_adj;
 	int ret;
-	bool sign_extend;
 
 	if (bpf_insn_is_indirect_target(env, ctx->prog, i))
 		emit_bti(A64_BTI_J, ctx);
@@ -1976,15 +2038,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
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
+		off_adj = off;
 		if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
 		    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
 			/*
@@ -1995,69 +2049,15 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 			 */
 			if (off) {
 				emit_a64_add_i(1, tmp2, src, tmp, off, ctx);
-				src_adj = tmp2;
+				src = tmp2;
 				off_adj = 0;
 			}
-			emit(A64_TST_I(1, src_adj, BIT(55)), ctx);
+			emit(A64_TST_I(1, src, BIT(55)), ctx);
 			emit(A64_B_(A64_COND_NE, 3), ctx);
 			emit(A64_MOVZ(1, dst, 0, 0), ctx);
 			emit(A64_B(2), ctx);
 		}
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
+		emit_ldst(code, dst, src, off_adj, tmp, ctx);
 
 		ret = add_exception_handler(insn, ctx, dst);
 		if (ret)
@@ -2092,51 +2092,9 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
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
@@ -2161,49 +2119,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
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

