Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125497;
	b=bDIHAR3J922Ejp1dPwLQeoabFdQuNHC/AV9BAw0kwsxkVV57JKcEkmwLP4hqJEG1beZk
	 XIPqfTdzlmQ9ZR220dR+xh4VhHg8CxLFZndXJw/fAtQGy8uyVyc7u3/tVNthW7Nsi20Iw
	 VTOeKe9jAFBXzDGaO/IpWIC5NkzzgdmKEOJmnMDBXZ3YJX+TicFVklM2ta3SlNgNWFo69
	 ayTv/3ALJKXIPk5OJrcAN5b5Ood1m+3DIKTkUt9iDO5HJhB1SD6xmwG8MM0MJ8VmrNpou
	 6iUUbNCi6ipSVBslCmjwjYM0qW2YNpo128zCs13+3Zd2dY8YLi1KWK0xIiTZXOxeHhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125497;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=YUcBlvQWJllsNX5DQlajK3Nzo5N+n8xsXolP9x1XOh8=;
	b=00XBjchKfkD7QXTmdACBK9VepurJTTu018isM2IEMKVt1IUjhXkgwKVAw4ze99Pxk8k+
	 ZNeDQxVlcQglT3eHTCNWhav212y8rvVpuzvyB+c5vcmZidecVtolZlcet3tcWXH6wYeye
	 qil902KMRvrlyE6omVuWf6KY4UhFYXJ+7x9fius95PXC0+tQ1aDIjt9Ph3kdCCLZBQX4I
	 N6wne4F+YEHDtubha3as8scxOzYf3uMAC/mR0GTkhADkp79hLk7hiF90/BpMNlagZkyoO
	 DjLiYeu5rfKrPG6DqJwLS4qrkCfi6UQ89+H9WdwPyf49t6Xr6UvmcNvakzQu544lGcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=FYJpHeM5;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BFE606A324
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26BFE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=FYJpHeM5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YUcBlvQWJllsNX5DQlajK3Nzo5N+n8xsXolP9x1XOh8=; b=FYJpHeM5HhDXzJxLysxNuWH498
	vmuKcanj5WA1FoRDxiXPQ7Q7HD/9Pp9Bl4gl0HpVnNZU8pOlMCRpoVj4xAF+sU7sDUGfwXvrLHTln
	j+trsJmsQtjuBeNSOs5BOH08ruYeInga52goH5uQHRD7g1laREzxxfbcXKJAStuLzvC7zHpYg10SX
	qhgak4tkUAtrXGycvAvk859PNyankHeA0AUS4SWlzr9EWX1GTotqJILxMoamE4n5ZAxOHjQDxZnye
	l4DhSJl86m1v9+W4RXA4peHyqj9sn3gQVR3sE2fKyEVCrQtBt2lERA1Td4JrQCS2HKOzDZC/BB7KT
	e9Npk4AA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqx-000Imn-1z;
	Tue, 27 Oct 2026 19:24:55 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 17/21] bpf, arm64: Use cbz, cbnz, tbz and tbnz for zero, sign and bit tests
Date: Tue, 27 Oct 2026 19:24:41 +0100
Message-ID: <20261027182445.1156335-18-daniel@iogearbox.net>
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

A compare against zero for equality, a test of the sign and a test of a
single bit were a cmp or tst followed by a conditional branch. CBZ and
CBNZ compare against zero and branch in one instruction with the same
19-bit offset as B.cond, and TBZ and TBNZ test a bit and branch. The
null check of a map lookup or pointer argument is the most frequent
compare in BPF programs, and LLVM emits the error checks as "if r s< 0"
and "if r s> -1", which test the sign, as do the unsigned 32-bit
compares at the sign bit. Neoverse N2, V2, V3 and N3 fuse a cmp or tst
with the following B.cond, so there the gain is the code size and a
decode slot, on cores without the fusion also the uop.

TBZ and TBNZ only reach 8K instructions where B.cond reaches 256K, so a
test takes them when its target is within reach. The sizing pass is
repeated with the offsets of the previous one until the code settles,
and where it has not after a few passes, all tests of the program keep
the compare and the branch. A branch back takes its distance from its
own position, as the offsets after it are still those of the previous
pass, which would overestimate the distance by what the code in front of
the branch shrank. The decisions are kept in a bitmap for the passes
over the image, which must not grow. A program without such a test takes
a single sizing pass as before.

Before/after for if r0 == 0 goto ..., if w0 s< 0 goto ... and
if r1 & 0x8 goto ...:

  f100011f  cmp x8, #0x0
  54000040  b.eq ...
  b4000048  cbz x8, ...

  7100011f  cmp w8, #0x0
  5400004b  b.lt ...
  37f80048  tbnz w8, #0x1f, ...

  f27d001f  tst x0, #0x8
  54000041  b.ne ...
  37180040  tbnz w0, #0x3, ...

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c | 163 ++++++++++++++++++++++++++++++++--
 1 file changed, 157 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c49f962ac229..08b95e3acaab 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -92,8 +92,17 @@ struct jit_ctx {
 	bool fp_used;
 	bool priv_sp_used;
 	bool write;
+	bool no_tb;
+	unsigned long *tb;
+	int tb_long;
 };
 
+/*
+ * Sizing passes in which a sign or bit test may still take the test bit and
+ * branch, see emit_tb(): the size settles within two more passes after that.
+ */
+#define TB_PASSES 8
+
 struct bpf_plt {
 	u32 insn_ldr; /* load target */
 	u32 insn_br;  /* branch to target */
@@ -314,8 +323,13 @@ static inline int bpf2a64_offset(int bpf_insn, int off,
 	/*
 	 * Whereas arm64 branch instructions encode the offset
 	 * from the branch itself, so we must subtract 1 from the
-	 * instruction offset.
+	 * instruction offset. A branch back takes its own position,
+	 * the next one emitted, as in a repeated sizing pass the
+	 * offsets from the next instruction on are still those of
+	 * the previous pass, see bpf_int_jit_compile().
 	 */
+	if (off < 0)
+		return ctx->offset[bpf_insn + off] - ctx->idx;
 	return ctx->offset[bpf_insn + off] - (ctx->offset[bpf_insn] - 1);
 }
 
@@ -593,6 +607,96 @@ static bool adjust_cmp_imm(u8 *op, s32 *imm)
 	return true;
 }
 
+/*
+ * A compare against zero or minus one for the sign, an unsigned 32-bit
+ * compare at the sign bit and a test of a single bit test a bit of the
+ * register: returns the bit, with *nonzero set when the branch is taken
+ * with it set, or -1.
+ */
+static int tb_bit(u8 op, bool is64, s32 imm, bool *nonzero)
+{
+	const int sign = is64 ? 63 : 31;
+	u64 mask;
+
+	switch (op) {
+	case BPF_JSLT:
+	case BPF_JSGE:
+		/* x < 0, x >= 0 */
+		if (imm)
+			return -1;
+		*nonzero = op == BPF_JSLT;
+		return sign;
+	case BPF_JSGT:
+	case BPF_JSLE:
+		/* x > -1, x <= -1 */
+		if (imm != -1)
+			return -1;
+		*nonzero = op == BPF_JSLE;
+		return sign;
+	case BPF_JGT:
+	case BPF_JLE:
+		/* x > 0x7fffffff, x <= 0x7fffffff in 32 bits */
+		if (is64 || imm != 0x7fffffff)
+			return -1;
+		*nonzero = op == BPF_JGT;
+		return 31;
+	case BPF_JGE:
+	case BPF_JLT:
+		/* x >= 0x80000000, x < 0x80000000 in 32 bits */
+		if (is64 || imm != INT_MIN)
+			return -1;
+		*nonzero = op == BPF_JGE;
+		return 31;
+	case BPF_JSET:
+		mask = is64 ? (u64)(s64)imm : (u32)imm;
+		if (!is_power_of_2(mask))
+			return -1;
+		*nonzero = true;
+		return ilog2(mask);
+	default:
+		return -1;
+	}
+}
+
+/*
+ * The test bit and branch reaches 8K instructions either way. Whether a
+ * test takes it is decided in the sizing passes, see bpf_int_jit_compile():
+ * the first one does not know the offsets of the instructions ahead and a
+ * later one knows them from the previous pass only, the distance back is
+ * exact in the current pass. The decision is kept in the tb bitmap for the
+ * passes over the image, where the code only shrinks as calls turn direct,
+ * so a test that fit keeps fitting, and a test that did not keeps the
+ * compare and the conditional branch, as the image must not grow. Returns
+ * false without emitting for the compare and conditional branch to take
+ * over, counted in the sizing passes for the last pass to be known.
+ */
+static bool emit_tb(bool nonzero, u8 reg, int bit, int i, s16 off, struct jit_ctx *ctx)
+{
+	int jmp_offset;
+
+	jmp_offset = bpf2a64_offset(i, off, ctx);
+
+	if (ctx->image) {
+		if (!test_bit(i, ctx->tb))
+			return false;
+	} else {
+		bool take = !ctx->no_tb &&
+			    (off < 0 || (ctx->offset[i + 1] && ctx->offset[i + 1 + off])) &&
+			    jmp_offset >= -SZ_8K && jmp_offset < SZ_8K;
+
+		__assign_bit(i, ctx->tb, take);
+		if (!take) {
+			ctx->tb_long++;
+			return false;
+		}
+	}
+	if (nonzero)
+		emit(A64_TBNZ(reg, bit, jmp_offset), ctx);
+	else
+		emit(A64_TBZ(reg, bit, jmp_offset), ctx);
+	return true;
+}
+
 /*
  * Divide dst by the immediate of a 64-bit division through a multiplication
  * with the magic number from bpf_magic_udiv() or bpf_magic_sdiv(): the high
@@ -1859,6 +1963,8 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	u8 jmp_cond;
 	s32 jmp_offset;
 	u32 a64_insn;
+	bool nonzero;
+	int bit;
 	int ret;
 
 	if (bpf_insn_is_indirect_target(env, ctx->prog, i))
@@ -2214,6 +2320,20 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	case BPF_JMP32 | BPF_JSLT | BPF_K:
 	case BPF_JMP32 | BPF_JSGE | BPF_K:
 	case BPF_JMP32 | BPF_JSLE | BPF_K:
+		/* A test of the sign within reach is a test bit and branch */
+		bit = tb_bit(jmp_op, is64, imm, &nonzero);
+		if (bit >= 0 && emit_tb(nonzero, dst, bit, i, off, ctx))
+			break;
+		/* A compare against zero for equality is a compare and branch */
+		if (!imm && (jmp_op == BPF_JEQ || jmp_op == BPF_JNE)) {
+			jmp_offset = bpf2a64_offset(i, off, ctx);
+			check_imm19(jmp_offset);
+			if (jmp_op == BPF_JEQ)
+				emit(A64_CBZ(is64, dst, jmp_offset), ctx);
+			else
+				emit(A64_CBNZ(is64, dst, jmp_offset), ctx);
+			break;
+		}
 		if (!is_addsub_imm(imm) && !is_addsub_imm(-(u32)imm))
 			adjust_cmp_imm(&jmp_op, &cmp_imm);
 		if (is_addsub_imm(cmp_imm)) {
@@ -2227,6 +2347,10 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		goto emit_cond_jmp;
 	case BPF_JMP | BPF_JSET | BPF_K:
 	case BPF_JMP32 | BPF_JSET | BPF_K:
+		/* A test of a single bit within reach is a test bit and branch */
+		bit = tb_bit(jmp_op, is64, imm, &nonzero);
+		if (bit >= 0 && emit_tb(nonzero, dst, bit, i, off, ctx))
+			break;
 		a64_insn = A64_TST_I(is64, dst, imm);
 		if (a64_insn != AARCH64_BREAK_FAULT) {
 			emit(a64_insn, ctx);
@@ -2600,6 +2724,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	int body_idx;
 	int exentry_idx;
 	int out_cnt;
+	int pass;
 
 	if (!prog->jit_requested)
 		return prog;
@@ -2643,6 +2768,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	ctx.offset = kvzalloc_objs(int, prog->len + 1);
 	if (ctx.offset == NULL)
 		goto out_off;
+	ctx.tb = kvzalloc_objs(unsigned long, BITS_TO_LONGS(prog->len));
+	if (ctx.tb == NULL)
+		goto out_off;
 
 	if (bpf_prog_uses_arena_insns(prog)) {
 		ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
@@ -2664,14 +2792,35 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	 *
 	 * BPF line info needs ctx->offset[i] to be the offset of
 	 * instruction[i] in jited image, so build prologue first.
+	 *
+	 * Whether a sign or bit test takes the test bit and branch depends on
+	 * the distance to its target, which a pass knows for the instructions
+	 * ahead from the previous pass only, see emit_tb(). Repeat the pass
+	 * until the body settles: while the form may be taken, the code only
+	 * shrinks from one pass to the next, so a branch that fit keeps
+	 * fitting, and the form is given up after a few passes, which settles
+	 * the size within two more. A pass in which no test took the compare
+	 * and the conditional branch is the last, the next would decide the
+	 * same. The passes over the image keep the decisions, as the image
+	 * allocated for the size settled on here must not grow.
 	 */
-	if (build_prologue(&ctx, was_classic))
-		goto out_off;
+	for (pass = 1; ; pass++) {
+		int prev_end = ctx.epilogue_offset;
 
-	if (build_body(env, &ctx, extra_pass))
-		goto out_off;
+		ctx.idx = 0;
+		ctx.tb_long = 0;
+		if (build_prologue(&ctx, was_classic))
+			goto out_off;
 
-	ctx.epilogue_offset = ctx.idx;
+		if (build_body(env, &ctx, extra_pass))
+			goto out_off;
+
+		ctx.epilogue_offset = ctx.idx;
+		if (!ctx.tb_long || (pass > 1 && ctx.epilogue_offset == prev_end))
+			break;
+		if (pass == TB_PASSES)
+			ctx.no_tb = true;
+	}
 	build_epilogue(&ctx, was_classic, false);
 	build_plt(&ctx);
 
@@ -2790,6 +2939,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			prog->aux->priv_stack_ptr = NULL;
 		}
 		kvfree(ctx.offset);
+		kvfree(ctx.tb);
 out_priv_stack:
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
@@ -3852,6 +4002,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 		if (jit_data) {
 			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
 			kvfree(jit_data->ctx.offset);
+			kvfree(jit_data->ctx.tb);
 			kfree(jit_data);
 		}
 		prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();
-- 
2.43.0

