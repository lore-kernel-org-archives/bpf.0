Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166112;
	b=HJK+w9Sq3rgTTJZnXTdNbHinzL0o9uWtOfDBr10doQbTmGxYxpLwBYV2XexSIr0t6rzv
	 59bQDSnvRJbfCRqKHot+4qCo/klu+rcpzJGfY6SAS397hxL024iOJ1UjY4k6UYlM0NeLn
	 cXMws/jpEi5/WTox2s4UC5XZZLzt4vL+AegT4NPjDxBMPab7yJVK27QvJyQ7oZxSEBwZq
	 xrRKYTEHYFyZcM/D4RdeUbAiw+bGLAQ+3XDNKRW2oaawejbQFQ+At3Z8880M4cS+J41l3
	 iyA8LrIcni3rEnhQqxKApIt99LccsmZtIyzHXucrLNOfKLYYN9uRMNZnmWCV/fznc3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166112;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=PA1B+LJJt491nJE8Fdrut69XzmN5n8USM4aNQEtW2vI=;
	b=uTgi4QXKyrd9Cn4Bqdnr+fZhOfviG7A542InAnbYS+/xusUgPG2dHTikJ2EG7sLd/y81
	 CQ/1VrvlS/Yddhl+Bj9oPd9FlNp+nmE4NK5EeDCTy/SXolnJJ42SG0kp0FTcrYWCExd1y
	 9AYhP3KyLKrtdPFHS+6twS9KauFleqFPskF5WT/H5+Im2tYTPRQd0StYpTFH2AHyMFiVi
	 rPlRo+hfJe2LDMHH4Vi/SPyD1Mo5QamsTsPKzBwjKCfL7XhPUUr99zD/Ek9LtJhh85vOz
	 i8AiEtR0VOjQN6n5HueCIsa+JsNjOXFdJsciY9zjKEFH8bQ4ZXrzxGmPnpbhyxXvPTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=fxOqKiJU;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F54606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2F54606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=fxOqKiJU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PA1B+LJJt491nJE8Fdrut69XzmN5n8USM4aNQEtW2vI=; b=fxOqKiJUsp9KGZM6k8W5k539u8
	CNu5oBuIYd8Ckqp1d/w3l5FTs2yTjRDBnQ6UJCIwKFOeHx0gQKMYoZ5Xi4J321N5cs8vmdbP/65NU
	rAUIMSOuYnL5V2kJHyjgYcN+u3FFJDoChKP0OsX6chERltEGfqyQcizD1AzN0ifrh95ByJFALu5NN
	AbrwRlCIBT9VXY2mAKmJzk2pMzbTxJWdodipMt4xmUQWP7I8vfyyPf1rxNKL+FV3Wl5PlOa0s5UOF
	qnTTuvQZLYZR/7EBA20WFLjNpXQPcajtPRPu5trecal4NrAvPAxzLTr1c0d0+h+BlMEXvx6DLm0uj
	VLKwVeFg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8Z3-000Psq-2p;
	Sun, 08 Nov 2026 20:28:30 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 20/24] bpf, arm64: Use cbz, cbnz, tbz and tbnz for zero, sign and bit tests
Date: Sun,  8 Nov 2026 20:26:46 +0100
Message-ID: <bcb6146505f3ae677d92b73da5f44ebc77dc43f5.1794165614.git.daniel@iogearbox.net>
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

A compare against zero for equality, a sign test and a single-bit test
each took a cmp or tst followed by a b.cond. CBZ/CBNZ and TBZ/TBNZ do
each in one instruction. That saves code size and a decode slot, and
also a uop on cores that do not fuse the pair. Null checks and sign
tests are the most frequent compares in BPF programs.

TBZ and TBNZ only reach +/-8K instructions, so a test uses them only
when its target is within reach in the sizing pass. The sizing pass has
the longest layout of all passes, the extra pass included, so the
target then stays in reach. The decisions are kept in a bitmap.

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
 arch/arm64/net/bpf_jit.h      |   9 +++
 arch/arm64/net/bpf_jit_comp.c | 116 ++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index 16c690c6cae9..7566698a38a8 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -30,6 +30,15 @@
 #define A64_CBNZ(sf, Rt, imm19) \
 	A64_COMP_BRANCH(sf, Rt, A64_BR_OFF(imm19), NONZERO)
 
+/* Test bit & branch (immediate) */
+#define A64_TEST_BRANCH(Rt, bit, offset, type) \
+	aarch64_insn_gen_test_branch_imm(0, offset, Rt, bit, \
+		AARCH64_INSN_BRANCH_TEST_##type)
+#define A64_TBZ(Rt, bit, imm14) \
+	A64_TEST_BRANCH(Rt, bit, A64_BR_OFF(imm14), ZERO)
+#define A64_TBNZ(Rt, bit, imm14) \
+	A64_TEST_BRANCH(Rt, bit, A64_BR_OFF(imm14), NONZERO)
+
 /* Conditional branch (immediate) */
 #define A64_COND_BRANCH(cond, offset) \
 	aarch64_insn_gen_cond_branch_imm(0, offset, cond)
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index b1f438d85721..53b2647c6a1b 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -94,6 +94,7 @@ struct jit_ctx {
 	bool fp_used;
 	bool priv_sp_used;
 	bool write;
+	unsigned long *tb;
 };
 
 struct bpf_plt {
@@ -603,6 +604,95 @@ static bool adjust_cmp_imm(u8 *op, s32 *imm)
 	return true;
 }
 
+/*
+ * The bit that a sign test, an unsigned 32-bit compare at the sign bit or a
+ * single bit test checks, with *nonzero set if it branches on a set bit, or -1.
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
+ * Pass 1 takes the compare and branch for every test and the indirect form for
+ * every call, no later layout is longer, so a test within reach of the test bit
+ * and branch there is within reach in every image.
+ */
+static void find_tb(struct jit_ctx *ctx)
+{
+	const struct bpf_prog *prog = ctx->prog;
+	bool nonzero;
+	int i, d;
+
+	for (i = 0; i < prog->len; i++) {
+		const struct bpf_insn *insn = &prog->insnsi[i];
+		const u8 class = BPF_CLASS(insn->code);
+
+		if ((class != BPF_JMP && class != BPF_JMP32) ||
+		    BPF_SRC(insn->code) != BPF_K)
+			continue;
+		if (tb_bit(BPF_OP(insn->code), class == BPF_JMP, insn->imm, &nonzero) < 0)
+			continue;
+		d = ctx->offset[i + 1 + insn->off] - (ctx->offset[i + 1] - 1);
+		if (d >= -SZ_8K && d < SZ_8K)
+			__set_bit(i, ctx->tb);
+	}
+}
+
+static bool emit_tb(bool nonzero, u8 reg, int bit, int i, s16 off, struct jit_ctx *ctx)
+{
+	int jmp_offset;
+
+	if (!test_bit(i, ctx->tb))
+		return false;
+	jmp_offset = bpf2a64_offset(i, off, ctx);
+	if (nonzero)
+		emit(A64_TBNZ(reg, bit, jmp_offset), ctx);
+	else
+		emit(A64_TBZ(reg, bit, jmp_offset), ctx);
+	return true;
+}
+
 /* generated main prog prologue:
  *      bti c // if CONFIG_ARM64_BTI_KERNEL
  *      mov x9, lr
@@ -1740,6 +1830,8 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	s32 jmp_offset;
 	u32 a64_insn;
 	int off_adj;
+	bool nonzero;
+	int bit;
 	int ret;
 
 	if (bpf_insn_is_indirect_target(env, ctx->prog, i))
@@ -2091,6 +2183,20 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
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
@@ -2104,6 +2210,10 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
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
@@ -2539,6 +2649,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	ctx.offset = kvzalloc_objs(int, prog->len + 1);
 	if (ctx.offset == NULL)
 		goto out_off;
+	ctx.tb = kvzalloc_objs(unsigned long, BITS_TO_LONGS(prog->len));
+	if (ctx.tb == NULL)
+		goto out_off;
 
 	if (bpf_prog_uses_arena_insns(prog)) {
 		ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
@@ -2566,6 +2679,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 
 	if (build_body(env, &ctx, extra_pass))
 		goto out_off;
+	find_tb(&ctx);
 
 	ctx.epilogue_offset = ctx.idx;
 	build_epilogue(&ctx, was_classic, false);
@@ -2686,6 +2800,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			prog->aux->priv_stack_ptr = NULL;
 		}
 		kvfree(ctx.offset);
+		kvfree(ctx.tb);
 out_priv_stack:
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
@@ -3759,6 +3874,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 		if (jit_data) {
 			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
 			kvfree(jit_data->ctx.offset);
+			kvfree(jit_data->ctx.tb);
 			kfree(jit_data);
 		}
 		prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();
-- 
2.43.0

