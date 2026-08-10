Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6863B3793BF
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388992; cv=none; b=dEn0sP8YNqdJDb/IJB1YTCRDl8RP+Lf16Seqwi0vrNvXS9fi8c4m+OHgSwi9fTe2mQihu0U+dxsUtyu15ovvnvdD79H54Y9O/m9RRVhuWL/IIRSLQS6/1cilJOIcW0OoFzpuUBBlWeXghjHRzY/LHzFivs2oqtcyDs29gy94ZJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388992; c=relaxed/simple;
	bh=RhkX96dHrTdD9HJ/ilwpY/WCrjNa3WAw7hR/deiRAOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxYUHPWACK+nPoVmk9EPQ/WvOPaO9vqgkDIjpo53LiI+gdetJdRLnEq3d+J+cs2k9YYHCsbu5P54JwJ7smJxdPNqz2i9pPpW+oG5rwPvsUC8TW79YC+yVXMv/tQZBf9MWelClhrx6c/Hp89z5WzRvEuiBbFSRCPCv/3YRZoM/Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLxxyKAP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLxxyKAP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631841F000E9;
	Mon, 10 Aug 2026 19:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786388991;
	bh=vy80FNDOjR9DUbODFGEU0rEfK8r8kqmxqWf+p989/UU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LLxxyKAPElqPOll2RihG05GKRmIFZaeNeYCneb3yuiMnYrqtbqGpiDleDFl3663q3
	 egKhasziM94cXsIvaIWaNU//oJddGAGTmt2sVbQdMy3oYHIxlEhTHgPC+etK3kRaPX
	 TS5h5PEUBeKTFbhQ282xAZ4AUTMfMJ4APWhEMrkr41ff+GZQ6iNi4T+dWFDOS0a+74
	 5jjzio09VASlf/YkYAe8d1+Oeaxt9viEnHpdt82Eq0/FPhiqynT4qDbiqt3jTElh0j
	 1NcHU4Ikpnr1zoBeJhklN+kNXFFS06e9ek6WxqL1+jwvdVwBWpWcbGoMkLtnep2M85
	 plxRwQ0Tc5REw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH bpf-next 3/7] bpf, arm64: JIT __arena kfunc argument rebasing
Date: Mon, 10 Aug 2026 12:09:16 -0700
Message-ID: <20260810190922.3408757-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810190922.3408757-1-puranjay@kernel.org>
References: <20260810190922.3408757-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement arena argument rebasing for kfunc calls on arm64. x28 already
holds kern_vm_start whenever the prog has an arena, and the newly added
extended-register add zero-extends the 32-bit arena offset in place, so
an unconditional argument costs a single instruction emitted right
before the call:

  add xN, x28, wN, uxtw

A nullable argument first truncates into wN so that a zero offset leaves
xN holding a real NULL, then tests it and jumps over the add:

  mov wN, wN
  cbz wN, 1f
  add xN, x28, wN, uxtw
1:

The rebase is native code generated after constant blinding has run on
the BPF instruction stream, so blinding never sees it and needs no
special handling. The emitted count depends only on the kfunc model, so
it is identical across JIT passes.

bpf_jit_supports_arena_args() is not flipped yet; that happens when the
struct_ops trampoline side is in place as well.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit.h      | 11 +++++++++
 arch/arm64/net/bpf_jit_comp.c | 42 +++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index d13de4222cfb7..b2fe6e6dcf447 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -243,6 +243,17 @@
 /* Rn - Rm; set condition flags */
 #define A64_CMP(sf, Rn, Rm) A64_SUBS(sf, A64_ZR, Rn, Rm)
 
+/* Add/subtract (extended register) */
+#define A64_ADDSUB_EREG(sf, Rd, Rn, Rm, ext, shift, type) \
+	aarch64_insn_gen_add_sub_extended_reg(Rd, Rn, Rm, \
+		AARCH64_INSN_EXTEND_##ext, shift, A64_VARIANT(sf), \
+		AARCH64_INSN_ADSB_##type)
+/* Rd = Rn + (EXT(Rm) << shift) */
+#define A64_ADD_EXT(sf, Rd, Rn, Rm, ext, shift) \
+	A64_ADDSUB_EREG(sf, Rd, Rn, Rm, ext, shift, ADD)
+/* Rd = Rn + (u32)Rm */
+#define A64_ADD_UXTW(Rd, Rn, Rm) A64_ADD_EXT(1, Rd, Rn, Rm, UXTW, 0)
+
 /* Data-processing (1 source) */
 #define A64_DATA1(sf, Rd, Rn, type) aarch64_insn_gen_data1(Rd, Rn, \
 	A64_VARIANT(sf), AARCH64_INSN_DATA1_##type)
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 4af5a98b84e19..7aad17a51f006 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1249,6 +1249,43 @@ static void emit_stack_arg_store_imm(s32 imm, s16 bpf_off, const u8 tmp, struct
 	}
 }
 
+/*
+ * Rebase the __arena args of a kfunc call to arena kernel addresses,
+ * xN = kern_vm_start + (u32)xN, with the arena base register holding
+ * kern_vm_start. A nullable arg preserves NULL by skipping the add, tested
+ * on the truncated value as arena NULL is offset 0.
+ */
+static int emit_kfunc_arena_args(struct jit_ctx *ctx, const struct bpf_insn *insn)
+{
+	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
+	const struct btf_func_model *fm;
+	int i;
+
+	fm = bpf_jit_find_kfunc_model(ctx->prog, insn);
+	if (!fm)
+		return -EINVAL;
+
+	for (i = 0; i < min_t(int, fm->nr_args, MAX_BPF_FUNC_REG_ARGS); i++) {
+		const u8 reg = bpf2a64[BPF_REG_1 + i];
+		u8 flags = fm->arg_flags[i];
+
+		if (!(flags & BTF_FMODEL_ARENA_ARG))
+			continue;
+		if (WARN_ON_ONCE(!ctx->arena_vm_start))
+			return -EINVAL;
+
+		if (flags & BTF_FMODEL_NULLABLE_ARG) {
+			/* 32-bit mov clears the upper 32 bits */
+			emit(A64_MOV(0, reg, reg), ctx);
+			/* skip the add so that NULL stays NULL */
+			emit(A64_CBZ(0, reg, 2), ctx);
+		}
+		emit(A64_ADD_UXTW(reg, arena_vm_base, reg), ctx);
+	}
+
+	return 0;
+}
+
 /* JITs an eBPF instruction.
  * Returns:
  * 0  - successfully JITed an 8-byte eBPF instruction.
@@ -1671,6 +1708,11 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 					    &func_addr, &func_addr_fixed);
 		if (ret < 0)
 			return ret;
+		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
+			ret = emit_kfunc_arena_args(ctx, insn);
+			if (ret < 0)
+				return ret;
+		}
 		emit_call(func_addr, ctx);
 		/*
 		 * Call to arch_bpf_timed_may_goto() is emitted by the
-- 
2.53.0-Meta

