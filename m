Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708867;
	b=W+bjaBHPlqSs9fov5MjVQ/t5uaNPsTQTfBR2Thl7FcA3DmuDLXR1/Wox4PJ9uJG0NghJ
	 7dEYUDdSi8L/yBJmeT/jyIrrbeyF3zuLFCN9BM+gus9uisPy124qkhTM0w5oOP5ldGg4q
	 aqglkckyeaNTcSiUfaopgftraX/bdNqaoybj9xagpfU3tpxH4N09LU/cQIZDrM8aFb/Yc
	 ofzKvnutdImENYZLEJk5zG09tDLbLXKLmMZzKWF8mzoPPRXxaIfKYFKRhpeeJtno/VoBO
	 HxhfRh1ESw2nW++fI85Uzoy4SBOa67kHS3mBtsWMANnImBrTAzKpmTDv0jYzdzumf8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708867;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=WQ92LYIXJ1rI3CeacbYwyK+3myzkIR2pkCcPldMqk+g=;
	b=if5PfSofwrUJ0OxGy9hoRPE6q5RUqf9rVBS9sLOnB0pw0zfzy1QreiH7j1cxDnPVeRxL
	 cIKdW1OEkU5WQG1/o6qmXPG2kQRTts922iWhrc30DSbesDyI4yHfGKpt88M1VKf/pEU7Y
	 vCpvDZ/jAXL7yJ1JrYFd6BzK8uN384W2VZ2xEOBFhgfzjZ8sHFM76AE8uJaplx6A6kO1R
	 lU/C/g93wKf96Pw7w8rQXwVnl2+zhWjNkYv2Ej8rM4foVY4/PFWHIo5srETNKayu/LO9R
	 5pjS1yrWrWRdij4QOAvkUxzdfArxjLFc22owiH7F6kSjmgb2QJOgP4HlqzQxioT5UnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=CDFcGskS;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C53606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7C53606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=CDFcGskS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=WQ92LYIXJ1rI3CeacbYwyK+3myzkIR2pkCcPldMqk+g=; b=CDFcGskSFqo1WnTIByw9vNJJoc
	Z6bhPVHnmXyHRiUOzVDQUMIJ+leNtXnCz/pKgRWzQ1cR2bi5TBdFRWnPs39Hr+CP7unoXlY52lpUA
	VVTuIhx2dKfmUyqUi6C94apihuOAx98UBEjBd0Oa/Wks74dssFzt5ny5sDCkEo/qe6VlB5CScqcUo
	AaONxKLSGLETsH2wtGgLGtDflVXKR2uTELqiGZr5Cvoxo+EYanFwV2JA9E3Lgi5wcDYS5GdeVaMAf
	/tG80hVGh3+X0XoKU+EHFHp09etV4sar2prUMe7ZldWUVRsPgU5ouiExtEqDrA85bxXWgi9fwBMXV
	7A0hqf6w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xODc8-000MSN-0g;
	Tue, 03 Nov 2026 13:27:44 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 17/20] bpf, arm64: Use cbz, cbnz, tbz and tbnz for zero, sign and bit tests
Date: Tue,  3 Nov 2026 13:27:30 +0100
Message-ID: <20261103122733.1383002-18-daniel@iogearbox.net>
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
test takes them when its target is within reach, decided in the pass
over the image which settles the offsets: the sizing pass takes the
compare and the branch for every test and the indirect form for every
call, so the distance to an instruction ahead known from it is the
largest it gets in any later pass, and the distance back is exact in
the pass itself, so a test that fits there fits in the image. A branch
back takes its distance from its own position, as the offsets after it
are still those of the previous pass, which would overestimate the
distance by what the code in front of the branch shrank. A test which
comes within reach only as the code between it and its target shrinks
keeps the compare and the branch, and the image keeps one or two unused
instructions for each test which takes the shorter form, as it keeps
three for each direct call. The decisions are kept in a bitmap for the
pass which writes the image. The extra pass of a program with
subprograms, whose calls turn direct, starts from the offsets of the
first image, which bound no later layout: a call of a helper can leave
the reach of the direct call as the code in front of it shrinks and
take the indirect form again, three instructions more between a test
ahead of it and its target. So the extra pass keeps the decisions for
the tests ahead and takes only those for the tests back again, which can
leave the image a word or two larger than the first one, within the
maximum image size the sizing pass counted, which the check after the
extra pass takes as its bound.

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
 arch/arm64/net/bpf_jit_comp.c | 141 ++++++++++++++++++++++++++++++++--
 1 file changed, 136 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 37fb1df53e30..b7d34525bf21 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -92,6 +92,7 @@ struct jit_ctx {
 	bool fp_used;
 	bool priv_sp_used;
 	bool write;
+	unsigned long *tb;
 };
 
 struct bpf_plt {
@@ -325,8 +326,13 @@ static inline int bpf2a64_offset(int bpf_insn, int off,
 	/*
 	 * Whereas arm64 branch instructions encode the offset
 	 * from the branch itself, so we must subtract 1 from the
-	 * instruction offset.
+	 * instruction offset. A branch back takes its own position,
+	 * the next one emitted, as the offsets from the next
+	 * instruction on are still those of the previous pass,
+	 * see emit_tb().
 	 */
+	if (off < 0)
+		return ctx->offset[bpf_insn + off] - ctx->idx;
 	return ctx->offset[bpf_insn + off] - (ctx->offset[bpf_insn] - 1);
 }
 
@@ -604,6 +610,94 @@ static bool adjust_cmp_imm(u8 *op, s32 *imm)
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
+ * test takes it is decided in the pass over the image which settles the
+ * offsets, see bpf_int_jit_compile(): the sizing pass takes the compare and
+ * the conditional branch for every test and the indirect form for every
+ * call, so the distance to an instruction ahead known from it is the
+ * largest it gets in any later pass, the distance back is exact in the pass
+ * itself, and a test that fits there fits in the image. The extra pass of a
+ * program with subprograms starts from the offsets of the first image, which
+ * bound no later layout, as a call of a helper can leave the reach of the
+ * direct call when the code in front of it shrinks and take the indirect
+ * form again, so it keeps the decisions for the tests ahead and takes only
+ * those for the tests back again, which can leave the image a word or two
+ * larger than the first one, within the maximum image size. The decisions
+ * are kept in the tb bitmap for the pass which writes the image. Returns
+ * false without emitting for the compare and conditional branch to take
+ * over.
+ */
+static bool emit_tb(bool nonzero, u8 reg, int bit, int i, s16 off, bool extra_pass,
+		    struct jit_ctx *ctx)
+{
+	int jmp_offset;
+
+	if (!ctx->image)
+		return false;
+	jmp_offset = bpf2a64_offset(i, off, ctx);
+	if (!ctx->write && (off < 0 || !extra_pass))
+		__assign_bit(i, ctx->tb, jmp_offset >= -SZ_8K && jmp_offset < SZ_8K);
+	if (!test_bit(i, ctx->tb))
+		return false;
+	if (nonzero)
+		emit(A64_TBNZ(reg, bit, jmp_offset), ctx);
+	else
+		emit(A64_TBZ(reg, bit, jmp_offset), ctx);
+	return true;
+}
+
 /*
  * Divide dst by the immediate of a 64-bit division through a multiplication
  * with the magic number from bpf_magic_div(): the high half of the product
@@ -1844,6 +1938,8 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	u8 jmp_cond;
 	s32 jmp_offset;
 	u32 a64_insn;
+	bool nonzero;
+	int bit;
 	int ret;
 
 	if (bpf_insn_is_indirect_target(env, ctx->prog, i))
@@ -2199,6 +2295,20 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	case BPF_JMP32 | BPF_JSLT | BPF_K:
 	case BPF_JMP32 | BPF_JSGE | BPF_K:
 	case BPF_JMP32 | BPF_JSLE | BPF_K:
+		/* A test of the sign within reach is a test bit and branch */
+		bit = tb_bit(jmp_op, is64, imm, &nonzero);
+		if (bit >= 0 && emit_tb(nonzero, dst, bit, i, off, extra_pass, ctx))
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
@@ -2212,6 +2322,10 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		goto emit_cond_jmp;
 	case BPF_JMP | BPF_JSET | BPF_K:
 	case BPF_JMP32 | BPF_JSET | BPF_K:
+		/* A test of a single bit within reach is a test bit and branch */
+		bit = tb_bit(jmp_op, is64, imm, &nonzero);
+		if (bit >= 0 && emit_tb(nonzero, dst, bit, i, off, extra_pass, ctx))
+			break;
 		a64_insn = A64_TST_I(is64, dst, imm);
 		if (a64_insn != AARCH64_BREAK_FAULT) {
 			emit(a64_insn, ctx);
@@ -2567,6 +2681,7 @@ struct arm64_jit_data {
 	u8 *ro_image;
 	struct bpf_binary_header *ro_header;
 	struct jit_ctx ctx;
+	int max_idx;
 };
 
 struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
@@ -2628,6 +2743,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	ctx.offset = kvzalloc_objs(int, prog->len + 1);
 	if (ctx.offset == NULL)
 		goto out_off;
+	ctx.tb = kvzalloc_objs(unsigned long, BITS_TO_LONGS(prog->len));
+	if (ctx.tb == NULL)
+		goto out_off;
 
 	if (bpf_prog_uses_arena_insns(prog)) {
 		ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
@@ -2649,6 +2767,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	 *
 	 * BPF line info needs ctx->offset[i] to be the offset of
 	 * instruction[i] in jited image, so build prologue first.
+	 *
+	 * The sign and bit tests take the compare and the conditional branch
+	 * here, the pass over the image decides which take the test bit and
+	 * branch instead, see emit_tb(), which leaves one or two instructions
+	 * of the image unused per test, as a direct call leaves three.
 	 */
 	if (build_prologue(&ctx, was_classic))
 		goto out_off;
@@ -2666,6 +2789,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 
 	/* Now we know the maximum image size. */
 	prog_size = sizeof(u32) * ctx.idx;
+	jit_data->max_idx = ctx.idx;
 	/* also allocate space for plt target */
 	extable_offset = round_up(prog_size + PLT_TARGET_SIZE, extable_align);
 	image_size = extable_offset + extable_size;
@@ -2675,7 +2799,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	if (!ro_header)
 		goto out_off;
 
-	/* Pass 2: Determine jited position and result for each instruction */
+	/*
+	 * Pass 2: Determine jited position and result for each instruction,
+	 * and the sign and bit tests which take the test bit and branch
+	 */
 
 	/*
 	 * Use the image(RW) for writing the JITed instructions. But also save
@@ -2731,11 +2858,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	if (!prog->is_func || extra_pass) {
 		/* The jited image may shrink since the jited result for
 		 * BPF_CALL to subprog may be changed from indirect call
-		 * to direct call.
+		 * to direct call, and grow back by a test back which takes
+		 * the compare and branch again, see emit_tb(), within the
+		 * maximum image size.
 		 */
-		if (extra_pass && ctx.idx > jit_data->ctx.idx) {
+		if (extra_pass && ctx.idx > jit_data->max_idx) {
 			pr_err_once("multi-func JIT bug %d > %d\n",
-				    ctx.idx, jit_data->ctx.idx);
+				    ctx.idx, jit_data->max_idx);
 			goto out_free_hdr;
 		}
 		if (WARN_ON(bpf_jit_binary_pack_finalize(ro_header, header))) {
@@ -2775,6 +2904,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			prog->aux->priv_stack_ptr = NULL;
 		}
 		kvfree(ctx.offset);
+		kvfree(ctx.tb);
 out_priv_stack:
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
@@ -3837,6 +3967,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 		if (jit_data) {
 			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
 			kvfree(jit_data->ctx.offset);
+			kvfree(jit_data->ctx.tb);
 			kfree(jit_data);
 		}
 		prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();
-- 
2.43.0

