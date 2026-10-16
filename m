Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DBE3C062D
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145910; cv=none; b=U402mI36y8cEWz/etEHe0DzMqZ/AdX3X6PRQVbCJFMYSccRkPzow3ReCUr9WDvm+NlutzNhHFisioeqffSyUpZfroyAQvRBp1tq3ocMiOkrHOp/Mf9bY5e/yaNIM5XKnUxMny1CzUBPS1RfUN2AbpVuyGwskOueu199oqUESV6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145910; c=relaxed/simple;
	bh=PWu+iAlId9hujcWMYeBkchiKiI7yi12Qcl5o9RpWx0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ra0bIFbRmjh3miYVmC2FpEZzA3gEkHowGC8dsYVQAKbJB+hhJvOLSE21G8gQ31MabgE6P+LmophYI/IFruazfPfE5pGWZmEgLoOIt7S6zQANTZUS/Yqq3ligHBlCt5Bv/uWE7s9gG1oW61BGfiU37qLVM+z92OmMlO0ATnUMcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=jtB/VXKz; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="jtB/VXKz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=C5iwrWVJVc/NoiSn4UQxidnqKJAl2bNfT/gw1UtXYDU=; b=jtB/VXKzF+JS1a7N+C/pJgUKrB
	nmILKXIxmOpZSqnZUqEqlV6M2qI55MYtk5G7U51K5fBIw3lJZh07/4SQEv/EG+m4ebjuTdIMcT/lA
	fnldeB1PLkTkElzuT0OVFbU5XLr0WS+bcldFQUaaNTZNgHpI8khLBESqYwmV22S+DRmnEurI7lYJs
	G4Zk6H0vz+GA2cSf813yukwOQI4YuUzkWFTk+FZvBxlTEjKT4zIFWoczqW7emB3h/3Gw7ApV+teoK
	gBu9k6NjNt/Z+bvknad6kgn7sheZfnIgS5MLpsrK1izdv8ic+edcW9rQ3zjSH5zlNNRUUkxp20wCx
	NXc445Ig==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHf16-0009jm-0s;
	Fri, 16 Oct 2026 12:18:24 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Follow-up to JIT instruction tests
Date: Fri, 16 Oct 2026 12:18:22 +0200
Message-ID: <20261016101822.632891-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101822.632891-1-daniel@iogearbox.net>
References: <20261016101822.632891-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28155/Fri Oct 16 08:24:17 2026)

Close gaps in the JIT instruction tests found by earlier Sashiko review,
by comparing the programs with what reaches the JIT, and by a sweep
through RFC9669 to construct tests for corner cases. Non-exhaustive list:

- The staggered jumps loaded their operands once, so the verifier decided
  the later guards of ja and gotol and the later jumps of jeq_k and
  jlt32_k, and a landing short of the target passed with r0 at zero.
  Reload the operands per region and let r0 carry the region number
  from the jump to its target.
- The matching 32-bit cmpxchg compared an r0 the mismatching one had zero
  extended. Reload r0 with the full value first and check that the source
  register keeps its upper half, as test_bpf did.
- The 32-bit atomics wrote and read back only their word, so a JIT touching
  all 64 bits passed when the other half was zero. Fill and read back the
  whole slot.
- The sub-word loads of the zero offset, offsets and probe_mem tests landed
  in a register holding nothing in particular. Set it to all ones first.
- Let probe_mem load every size, sign extending too, and run ld_imm64 into
  every register, not only r1.
- Drop the load-acquire probe: a JIT without the instruction fails like for
  any other one instead of skipping.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t jit_insns
  [...]
  #191/1   jit_insns/arena access with zero offset:OK
  #191/2   jit_insns/cast to a user address:OK
  #191/3   jit_insns/alu_imm:OK
  #191/4   jit_insns/alu_reg:OK
  #191/5   jit_insns/alu_imm_regs:OK
  #191/6   jit_insns/div_const:OK
  #191/7   jit_insns/alu_reg_pairs:OK
  #191/8   jit_insns/alu_edges:OK
  #191/9   jit_insns/shifts:OK
  #191/10  jit_insns/shift_counts:OK
  #191/11  jit_insns/atomics:OK
  #191/12  jit_insns/atomic_reg_pairs:OK
  #191/13  jit_insns/xadd_chain:OK
  #191/14  jit_insns/ld_imm64:OK
  #191/15  jit_insns/jmp_imm:OK
  #191/16  jit_insns/jmp_reg:OK
  #191/17  jit_insns/jmp_reg_pairs:OK
  #191/18  jit_insns/jmp_edges:OK
  #191/19  jit_insns/staggered_jumps:OK
  #191/20  jit_insns/max_jmp:OK
  #191/21  jit_insns/convergence:OK
  #191/22  jit_insns/calls:OK
  #191/23  jit_insns/helper_calls:OK
  #191/24  jit_insns/ldst_zero_off:OK
  #191/25  jit_insns/ldst_offsets:OK
  #191/26  jit_insns/acq_rel:OK
  #191/27  jit_insns/movsx:OK
  #191/28  jit_insns/jset_imm:OK
  #191/29  jit_insns/cmp_imm:OK
  #191/30  jit_insns/alu_consts:OK
  #191/31  jit_insns/bswap:OK
  #191/32  jit_insns/probe_mem:OK
  #191     jit_insns:OK
  #192/1   jit_insns_blinded/alu_imm:OK
  #192/2   jit_insns_blinded/alu_imm_regs:OK
  #192/3   jit_insns_blinded/alu_edges:OK
  #192/4   jit_insns_blinded/div_const:OK
  #192/5   jit_insns_blinded/shifts:OK
  #192/6   jit_insns_blinded/xadd_chain:OK
  #192/7   jit_insns_blinded/ld_imm64:OK
  #192/8   jit_insns_blinded/jmp_imm:OK
  #192/9   jit_insns_blinded/jmp_edges:OK
  #192/10  jit_insns_blinded/ldst_zero_off:OK
  #192/11  jit_insns_blinded/ldst_offsets:OK
  #192/12  jit_insns_blinded/jset_imm:OK
  #192/13  jit_insns_blinded/cmp_imm:OK
  #192/14  jit_insns_blinded/alu_consts:OK
  #192     jit_insns_blinded:OK
  Summary: 2/46 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/jit_insns.c      | 1104 ++++++++++++++---
 1 file changed, 913 insertions(+), 191 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns.c b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
index dabf8a4abdfe..dabefdb8a353 100644
--- a/tools/testing/selftests/bpf/prog_tests/jit_insns.c
+++ b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
@@ -16,18 +16,18 @@
 
 struct sweep_ctx {
 	__u64 in[NR_CASES][2];
-	__u64 out[NR_CASES][3];
+	__u64 out[NR_CASES][4];
 };
 
 #define IN_OFF(k, j)	(offsetof(struct sweep_ctx, in) + ((k) * 2 + (j)) * 8)
-#define OUT_OFF(k, j)	(offsetof(struct sweep_ctx, out) + ((k) * 3 + (j)) * 8)
+#define OUT_OFF(k, j)	(offsetof(struct sweep_ctx, out) + ((k) * 4 + (j)) * 8)
 
 /* The cases of one program: operands in, results out, expected results */
 struct batch {
 	struct bpf_insn *insns;
 	int cnt, cap;
 	struct sweep_ctx ctx;
-	__u64 exp[NR_CASES][3];
+	__u64 exp[NR_CASES][4];
 	__u8 nr_out[NR_CASES];
 	int nr;
 	char desc[80];
@@ -149,6 +149,65 @@ static int scratch_reg(int r1, int r2)
 	return BPF_REG_9;
 }
 
+static int size_bits(int size)
+{
+	switch (size) {
+	case BPF_B:
+		return 8;
+	case BPF_H:
+		return 16;
+	case BPF_W:
+		return 32;
+	default:
+		return 64;
+	}
+}
+
+/* The first size bytes of v in memory, as a load of that size reads them */
+static __u64 head_bytes(__u64 v, int size)
+{
+	int bits = size_bits(size);
+
+	if (bits == 64)
+		return v;
+#if __BYTE_ORDER == __BIG_ENDIAN
+	return v >> (64 - bits);
+#else
+	return v & ((1ULL << bits) - 1);
+#endif
+}
+
+/* v with its first size bytes in memory replaced by those of w */
+static __u64 head_merge(__u64 v, __u64 w, int size)
+{
+	int bits = size_bits(size);
+	__u64 mask;
+
+	if (bits == 64)
+		return w;
+	mask = (1ULL << bits) - 1;
+#if __BYTE_ORDER == __BIG_ENDIAN
+	return (v & ~(mask << (64 - bits))) | ((w & mask) << (64 - bits));
+#else
+	return (v & ~mask) | (w & mask);
+#endif
+}
+
+/* v as a sign extending load of that size reads it */
+static __s64 sign_extend(__u64 v, int size)
+{
+	switch (size) {
+	case BPF_B:
+		return (__s8)v;
+	case BPF_H:
+		return (__s16)v;
+	case BPF_W:
+		return (__s32)v;
+	default:
+		return v;
+	}
+}
+
 static const char *alu_name(int op)
 {
 	switch (BPF_OP(op)) {
@@ -189,12 +248,13 @@ static const char *jmp_name(int op)
 	}
 }
 
-/* ALU result computation, false when the operands are not valid */
+/* ALU result computation, with the ISA result for every operand */
 enum { F_ALU32 = 1, F_SIGNED = 2 };
 
-static bool alu_result(__u64 *res, __u64 v1, __u64 v2, __u8 op, __u32 flags)
+static void alu_result(__u64 *res, __u64 v1, __u64 v2, __u8 op, __u32 flags)
 {
 	bool is_signed = flags & F_SIGNED;
+	int mask = flags & F_ALU32 ? 31 : 63;
 
 	/* Narrow operands for ALU32 */
 	if (flags & F_ALU32) {
@@ -225,12 +285,15 @@ static bool alu_result(__u64 *res, __u64 v1, __u64 v2, __u8 op, __u32 flags)
 		*res = v1 ^ v2;
 		break;
 	case BPF_LSH:
-		*res = v1 << v2;
+		*res = v1 << (v2 & mask);
 		break;
 	case BPF_RSH:
-		*res = v1 >> v2;
+		*res = v1 >> (v2 & mask);
 		break;
 	case BPF_ARSH:
+		if (flags & F_ALU32)
+			v1 = (__u64)(__s32)v1;
+		v2 &= mask;
 		*res = v1 >> v2;
 		if (v2 > 0 && v1 > INT64_MAX)
 			*res |= ~0ULL << (64 - v2);
@@ -244,30 +307,28 @@ static bool alu_result(__u64 *res, __u64 v1, __u64 v2, __u8 op, __u32 flags)
 	case BPF_MUL:
 		*res = v1 * v2;
 		break;
+	/* By zero: the quotient is zero and the dividend keeps, by -1: negation and zero */
 	case BPF_DIV:
 		if (v2 == 0)
-			return false;
-		if (!is_signed) {
+			*res = 0;
+		else if (!is_signed)
 			*res = v1 / v2;
-		} else {
-			if ((__s64)v2 == -1) /* Handled by the verifier */
-				return false;
+		else if ((__s64)v2 == -1)
+			*res = -v1;
+		else
 			*res = (__u64)((__s64)v1 / (__s64)v2);
-		}
 		break;
 	case BPF_MOD:
 		if (v2 == 0)
-			return false;
-		if (!is_signed) {
+			*res = v1;
+		else if (!is_signed)
 			*res = v1 % v2;
-		} else {
-			if ((__s64)v2 == -1)
-				return false;
+		else if ((__s64)v2 == -1)
+			*res = 0;
+		else
 			*res = (__u64)((__s64)v1 % (__s64)v2);
-		}
 		break;
 	}
-	return true;
 }
 
 /*
@@ -311,6 +372,27 @@ static void fill_pattern(struct batch *b, void *arg, int dbits, int sbits,
 	batch_flush(b);
 }
 
+/* Operands at the edges: zero, one and the limits of every width */
+static const __u64 edges[] = {
+	0, 1, 0x7f, 0x80, 0xff, 0x7fff, 0x8000, 0xffff, 0x7fffffff, 0x80000000,
+	0xffffffff, 0x100000000ULL, 0x7fffffffffffffffULL, 0x8000000000000000ULL,
+	0xffffffff80000000ULL, 0xffffffff7fffffffULL, 0xffffffffffffffffULL,
+};
+
+static void fill_edges(struct batch *b, void *arg, bool imm, emit_fn emit)
+{
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(edges); i++)
+		for (j = 0; j < ARRAY_SIZE(edges); j++) {
+			/* The immediate has to fit its 32 bits */
+			if (imm && (__s64)edges[j] != (__s32)edges[j])
+				continue;
+			emit(b, arg, edges[i], edges[j]);
+		}
+	batch_flush(b);
+}
+
 /* ALU operations with an immediate and with a register for all magnitudes */
 static const int alu_ops[] = {
 	BPF_MOV, BPF_AND, BPF_OR, BPF_XOR, BPF_ADD, BPF_SUB, BPF_MUL, BPF_DIV, BPF_MOD,
@@ -328,9 +410,16 @@ static void emit_alu_imm(struct batch *b, void *arg, __s64 dst, __s64 imm)
 	__u64 res;
 	int k;
 
-	if (!alu_result(&res, dst, (__s32)imm, a->op, a->flags))
+	/* The verifier rejects a zero divisor and a shift count beyond the width */
+	if ((a->op == BPF_DIV || a->op == BPF_MOD) && !imm)
+		return;
+	if ((a->op == BPF_LSH || a->op == BPF_RSH || a->op == BPF_ARSH) &&
+	    (__u64)imm >= (alu32 ? 32 : 64))
 		return;
-	k = batch_case(b, BPF_REG_3, dst, 0);
+	if (a->op == BPF_NEG)
+		imm = 0;
+	alu_result(&res, dst, (__s32)imm, a->op, a->flags);
+	k = batch_case(b, BPF_REG_3, dst, (__s32)imm);
 	LD_IN(b, k, 0, BPF_REG_3, BPF_REG_1);
 	EMIT(b, BPF_RAW_INSN((alu32 ? BPF_ALU : BPF_ALU64) | BPF_OP(a->op) | BPF_K,
 			     BPF_REG_1, 0, a->flags & F_SIGNED ? 1 : 0, imm));
@@ -345,8 +434,11 @@ static void emit_alu_reg(struct batch *b, void *arg, __s64 dst, __s64 src)
 	__u64 res;
 	int k;
 
-	if (!alu_result(&res, dst, src, a->op, a->flags))
+	/* Shift counts beyond the width have their own subtest */
+	if ((a->op == BPF_LSH || a->op == BPF_RSH || a->op == BPF_ARSH) &&
+	    (alu32 ? (__u32)src : (__u64)src) >= (alu32 ? 32 : 64))
 		return;
+	alu_result(&res, dst, src, a->op, a->flags);
 	k = batch_case(b, BPF_REG_3, dst, src);
 	LD_IN(b, k, 0, BPF_REG_3, BPF_REG_1);
 	LD_IN(b, k, 1, BPF_REG_3, BPF_REG_2);
@@ -398,6 +490,41 @@ static void test_alu_reg(void)
 	test_alu_magnitudes(true);
 }
 
+static void test_alu_edges(void)
+{
+	static const struct alu_arg ops[] = {
+		{ BPF_MOV }, { BPF_AND }, { BPF_OR }, { BPF_XOR }, { BPF_LSH }, { BPF_RSH },
+		{ BPF_ARSH }, { BPF_ADD }, { BPF_SUB }, { BPF_MUL }, { BPF_DIV }, { BPF_MOD },
+		{ BPF_DIV, F_SIGNED }, { BPF_MOD, F_SIGNED }, { BPF_NEG },
+	};
+	struct batch b;
+	int o, f, r, i;
+
+	if (!batch_init(&b))
+		return;
+	for (f = 0; f < 2; f++) {
+		for (o = 0; o < ARRAY_SIZE(ops); o++) {
+			struct alu_arg a = { ops[o].op, ops[o].flags | (f ? F_ALU32 : 0) };
+
+			for (r = 0; r < (a.op == BPF_NEG ? 1 : 2); r++) {
+				snprintf(b.desc, sizeof(b.desc), "alu%d_%s%s_%c edges",
+					 f ? 32 : 64, a.flags & F_SIGNED ? "s" : "", alu_name(a.op),
+					 r ? 'x' : 'k');
+				if (a.op == BPF_NEG) {
+					for (i = 0; i < ARRAY_SIZE(edges); i++)
+						emit_alu_imm(&b, &a, edges[i], 0);
+					batch_flush(&b);
+				} else if (r) {
+					fill_edges(&b, &a, false, emit_alu_reg);
+				} else {
+					fill_edges(&b, &a, true, emit_alu_imm);
+				}
+			}
+		}
+	}
+	batch_fini(&b);
+}
+
 /* ALU operations with an immediate for every destination register */
 static const int alu_reg_ops[] = {
 	BPF_MOV, BPF_AND, BPF_OR, BPF_XOR, BPF_LSH, BPF_RSH, BPF_ARSH,
@@ -516,11 +643,7 @@ static __u64 div_result(int op, __u32 flags, __s32 imm, __u64 n)
 {
 	__u64 res;
 
-	/* LLONG_MIN / -1 == LLONG_MIN, LLONG_MIN % -1 == 0, same for INT_MIN */
-	if ((flags & F_SIGNED) && imm == -1)
-		res = op == BPF_MOD ? 0 : -n;
-	else
-		alu_result(&res, n, (__s32)imm, op, flags);
+	alu_result(&res, n, (__s32)imm, op, flags);
 	return flags & F_ALU32 ? (__u32)res : res;
 }
 
@@ -570,37 +693,46 @@ static void test_div_const(void)
 /* ALU operations for all combinations of operand registers */
 static void alu_reg_pairs(struct batch *b, int op, __u32 flags)
 {
-	bool alu32 = flags & F_ALU32;
-	__u64 dst, src, res, same;
-	int rd, rs, rc, k;
+	bool alu32 = flags & F_ALU32, divmod = op == BPF_DIV || op == BPF_MOD;
+	int code = (alu32 ? BPF_ALU : BPF_ALU64) | BPF_OP(op) | BPF_X;
+	int off = flags & F_SIGNED ? 1 : 0, rd, rs, rc, k, n, nr = 1;
+	__u64 dst, srcs[3], src, res, same;
 
 	if (flags & F_SIGNED)
 		dst = alu32 ? (__u64)-76543210LL : (__u64)-7654321076543210LL;
 	else
 		dst = alu32 ? 0x76543210ULL : 0x7edcba9876543210ULL;
-	src = alu32 ? 0x01234567ULL : 0x0123456789abcdefULL;
+	srcs[0] = alu32 ? 0x01234567ULL : 0x0123456789abcdefULL;
 	if (op == BPF_LSH || op == BPF_RSH || op == BPF_ARSH)
-		src &= 31;
-	alu_result(&res, dst, src, op, flags);
-	alu_result(&same, src, src, op, flags);
-	if (alu32) {
-		res = (__u32)res;
-		same = (__u32)same;
+		srcs[0] &= 31;
+	/* A zero divisor, in 32 bits also one with only the upper half set */
+	if (divmod) {
+		srcs[nr++] = 0;
+		if (alu32)
+			srcs[nr++] = 1ULL << 32;
 	}
 
 	snprintf(b->desc, sizeof(b->desc), "alu%d_%s%s_x register pairs", alu32 ? 32 : 64,
 		 flags & F_SIGNED ? "s" : "", alu_name(op));
-	for (rd = BPF_REG_0; rd <= BPF_REG_9; rd++) {
-		for (rs = BPF_REG_0; rs <= BPF_REG_9; rs++) {
-			rc = scratch_reg(rd, rs);
-			k = batch_case(b, rc, rd == rs ? src : dst, src);
-			LD_IN(b, k, 0, rc, rd);
-			if (rs != rd)
-				LD_IN(b, k, 1, rc, rs);
-			EMIT(b, BPF_RAW_INSN((alu32 ? BPF_ALU : BPF_ALU64) | BPF_OP(op) | BPF_X,
-					     rd, rs, flags & F_SIGNED ? 1 : 0, 0));
-			ST_OUT(b, k, 0, rc, rd);
-			batch_expect(b, k, 0, rd == rs ? same : res);
+	for (n = 0; n < nr; n++) {
+		src = srcs[n];
+		alu_result(&res, dst, src, op, flags);
+		alu_result(&same, src, src, op, flags);
+		if (alu32) {
+			res = (__u32)res;
+			same = (__u32)same;
+		}
+		for (rd = BPF_REG_0; rd <= BPF_REG_9; rd++) {
+			for (rs = BPF_REG_0; rs <= BPF_REG_9; rs++) {
+				rc = scratch_reg(rd, rs);
+				k = batch_case(b, rc, rd == rs ? src : dst, src);
+				LD_IN(b, k, 0, rc, rd);
+				if (rs != rd)
+					LD_IN(b, k, 1, rc, rs);
+				EMIT(b, BPF_RAW_INSN(code, rd, rs, off, 0));
+				ST_OUT(b, k, 0, rc, rd);
+				batch_expect(b, k, 0, rd == rs ? same : res);
+			}
 		}
 	}
 	batch_flush(b);
@@ -622,16 +754,17 @@ static void test_alu_reg_pairs(void)
 	batch_fini(&b);
 }
 
+static const __s64 shift_vals[] = {
+	0x0123456789abcdefLL, /* dword > 0, word < 0 */
+	0xfedcba9876543210LL, /* dword < 0, word > 0 */
+	0xfedcba0198765432LL, /* dword < 0, word < 0 */
+	0x0123458967abcdefLL, /* dword > 0, word > 0 */
+};
+static const int shift_ops[] = { BPF_LSH, BPF_RSH, BPF_ARSH };
+
 /* Shifts for all shift counts, by immediate, by register and by the shifted register */
 static void test_shifts(void)
 {
-	static const __s64 vals[] = {
-		0x0123456789abcdefLL, /* dword > 0, word < 0 */
-		0xfedcba9876543210LL, /* dword < 0, word > 0 */
-		0xfedcba0198765432LL, /* dword < 0, word < 0 */
-		0x0123458967abcdefLL, /* dword > 0, word > 0 */
-	};
-	static const int ops[] = { BPF_LSH, BPF_RSH, BPF_ARSH };
 	struct batch b;
 	int o, f, v, imm, k;
 
@@ -640,14 +773,14 @@ static void test_shifts(void)
 	for (f = 0; f < 2; f++) {
 		int bits = f ? 32 : 64;
 
-		for (o = 0; o < ARRAY_SIZE(ops); o++) {
-			int op = ops[o];
+		for (o = 0; o < ARRAY_SIZE(shift_ops); o++) {
+			int op = shift_ops[o];
 
 			snprintf(b.desc, sizeof(b.desc), "alu%d_%s all shift counts", bits,
 				 alu_name(op));
-			for (v = 0; v < ARRAY_SIZE(vals); v++) {
+			for (v = 0; v < ARRAY_SIZE(shift_vals); v++) {
 				for (imm = 0; imm < bits; imm++) {
-					__u64 reg = vals[v], res;
+					__u64 reg = shift_vals[v], res;
 
 					if (f)
 						reg = op == BPF_ARSH ? (__u64)(__s32)reg :
@@ -656,7 +789,7 @@ static void test_shifts(void)
 					if (f)
 						res = (__u32)res;
 
-					k = batch_case(&b, BPF_REG_3, vals[v], imm);
+					k = batch_case(&b, BPF_REG_3, shift_vals[v], imm);
 					LD_IN(&b, k, 0, BPF_REG_3, BPF_REG_1);
 					if (f)
 						EMIT(&b, BPF_ALU32_IMM(op, BPF_REG_1, imm));
@@ -665,7 +798,7 @@ static void test_shifts(void)
 					ST_OUT(&b, k, 0, BPF_REG_3, BPF_REG_1);
 					batch_expect(&b, k, 0, res);
 
-					k = batch_case(&b, BPF_REG_3, vals[v], imm);
+					k = batch_case(&b, BPF_REG_3, shift_vals[v], imm);
 					LD_IN(&b, k, 0, BPF_REG_3, BPF_REG_1);
 					LD_IN(&b, k, 1, BPF_REG_3, BPF_REG_2);
 					if (f)
@@ -696,6 +829,54 @@ static void test_shifts(void)
 	batch_fini(&b);
 }
 
+/*
+ * Shifts by register with counts at and above the width and negative ones,
+ * which the ISA masks by the width. Apart in a subtest of its own, as not
+ * every JIT does so.
+ */
+static void test_shift_counts(void)
+{
+	static const __s64 counts[] = { 32, 33, 63, 64, 65, 127, -1, -3, 1LL << 32 | 3 };
+	struct batch b;
+	int o, f, v, c, k;
+
+	if (!batch_init(&b))
+		return;
+	for (f = 0; f < 2; f++) {
+		int bits = f ? 32 : 64;
+
+		for (o = 0; o < ARRAY_SIZE(shift_ops); o++) {
+			int op = shift_ops[o];
+
+			snprintf(b.desc, sizeof(b.desc), "alu%d_%s_x counts beyond the width",
+				 bits, alu_name(op));
+			for (c = 0; c < ARRAY_SIZE(counts); c++) {
+				__u64 cnt = f ? (__u32)counts[c] : counts[c];
+
+				for (v = 0; v < ARRAY_SIZE(shift_vals); v++) {
+					__u64 reg = shift_vals[v], res;
+
+					if (f)
+						reg = op == BPF_ARSH ? (__u64)(__s32)reg :
+						      (__u32)reg;
+					alu_result(&res, reg, cnt & (bits - 1), op, 0);
+					k = batch_case(&b, BPF_REG_3, shift_vals[v], counts[c]);
+					LD_IN(&b, k, 0, BPF_REG_3, BPF_REG_1);
+					LD_IN(&b, k, 1, BPF_REG_3, BPF_REG_2);
+					if (f)
+						EMIT(&b, BPF_ALU32_REG(op, BPF_REG_1, BPF_REG_2));
+					else
+						EMIT(&b, BPF_ALU64_REG(op, BPF_REG_1, BPF_REG_2));
+					ST_OUT(&b, k, 0, BPF_REG_3, BPF_REG_1);
+					batch_expect(&b, k, 0, f ? (__u32)res : res);
+				}
+			}
+			batch_flush(&b);
+		}
+	}
+	batch_fini(&b);
+}
+
 /* Atomic operations on the stack for all magnitudes of memory and source operand */
 static const int atomic_ops[] = {
 	BPF_ADD, BPF_AND, BPF_OR, BPF_XOR,
@@ -723,16 +904,18 @@ static void emit_atomic(struct batch *b, void *arg, __s64 dst, __s64 src)
 	fetch = a->op & BPF_FETCH ? (w ? (__u32)dst : dst) : src;
 
 	k = batch_case(b, BPF_REG_3, dst, src);
+	/* The kept value fills the slot, a 32-bit operation leaves the other half alone */
+	emit_ld_imm64(b, BPF_REG_0, keep);
+	EMIT(b, BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, MEM_SLOT));
 	LD_IN(b, k, 0, BPF_REG_3, BPF_REG_1);
 	EMIT(b, BPF_STX_MEM(a->size, BPF_REG_10, BPF_REG_1, MEM_SLOT));
 	LD_IN(b, k, 1, BPF_REG_3, BPF_REG_2);
-	emit_ld_imm64(b, BPF_REG_0, keep);
 	EMIT(b, BPF_ATOMIC_OP(a->size, a->op, BPF_REG_10, BPF_REG_2, MEM_SLOT));
-	EMIT(b, BPF_LDX_MEM(a->size, BPF_REG_1, BPF_REG_10, MEM_SLOT));
+	EMIT(b, BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, MEM_SLOT));
 	ST_OUT(b, k, 0, BPF_REG_3, BPF_REG_1);
 	ST_OUT(b, k, 1, BPF_REG_3, BPF_REG_2);
 	ST_OUT(b, k, 2, BPF_REG_3, BPF_REG_0);
-	batch_expect(b, k, 0, w ? (__u32)res : res);
+	batch_expect(b, k, 0, head_merge(keep, w ? (__u32)res : res, a->size));
 	batch_expect(b, k, 1, fetch);
 	batch_expect(b, k, 2, keep);
 }
@@ -746,21 +929,30 @@ static void emit_cmpxchg(struct batch *b, void *arg, __s64 dst, __s64 src)
 
 	k = batch_case(b, BPF_REG_3, dst, src);
 	LD_IN(b, k, 0, BPF_REG_3, BPF_REG_1);
+	/* The inverted value fills the slot, a 32-bit operation leaves the other half alone */
+	EMIT(b, BPF_MOV64_REG(BPF_REG_0, BPF_REG_1));
+	EMIT(b, BPF_ALU64_IMM(BPF_XOR, BPF_REG_0, -1));
+	EMIT(b, BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, MEM_SLOT));
 	EMIT(b, BPF_STX_MEM(size, BPF_REG_10, BPF_REG_1, MEM_SLOT));
 	LD_IN(b, k, 1, BPF_REG_3, BPF_REG_2);
 	/* Mismatch: the memory keeps its value, r0 gets it */
-	EMIT(b, BPF_MOV64_REG(BPF_REG_0, BPF_REG_1));
-	EMIT(b, BPF_ALU64_IMM(BPF_XOR, BPF_REG_0, -1));
 	EMIT(b, BPF_ATOMIC_OP(size, BPF_CMPXCHG, BPF_REG_10, BPF_REG_2, MEM_SLOT));
 	ST_OUT(b, k, 0, BPF_REG_3, BPF_REG_0);
-	/* Match: the memory gets the source, r0 the old value */
+	/*
+	 * Match: the memory gets the source, r0 the old value. r0 holds the
+	 * full value, so the 32-bit compare has to ignore its upper half, and
+	 * the source register has to keep its own.
+	 */
+	LD_IN(b, k, 0, BPF_REG_3, BPF_REG_0);
 	EMIT(b, BPF_ATOMIC_OP(size, BPF_CMPXCHG, BPF_REG_10, BPF_REG_2, MEM_SLOT));
-	EMIT(b, BPF_LDX_MEM(size, BPF_REG_1, BPF_REG_10, MEM_SLOT));
+	EMIT(b, BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, MEM_SLOT));
 	ST_OUT(b, k, 1, BPF_REG_3, BPF_REG_1);
 	ST_OUT(b, k, 2, BPF_REG_3, BPF_REG_0);
+	ST_OUT(b, k, 3, BPF_REG_3, BPF_REG_2);
 	batch_expect(b, k, 0, old);
-	batch_expect(b, k, 1, w ? (__u32)src : src);
+	batch_expect(b, k, 1, head_merge(~(__u64)dst, w ? (__u32)src : src, size));
 	batch_expect(b, k, 2, old);
+	batch_expect(b, k, 3, src);
 }
 
 static void test_atomics(void)
@@ -797,7 +989,7 @@ static void atomic_reg_pairs(struct batch *b, int size, int op)
 	int rd, rs, rc, k, n;
 
 	if (w) {
-		mem = 0x01234567U;
+		mem = 0xfedcba9801234567ULL;
 		upd = 0x76543210U;
 	} else {
 		mem = 0x0123456789abcdefULL;
@@ -809,18 +1001,19 @@ static void atomic_reg_pairs(struct batch *b, int size, int op)
 		 op & BPF_FETCH ? "_fetch" : "");
 	for (rd = BPF_REG_0; rd <= BPF_REG_9; rd++) {
 		for (rs = BPF_REG_0; rs <= BPF_REG_9; rs++) {
-			__u64 regs[10], old = mem, new, src, cmp;
+			__u64 regs[10], old = w ? (__u32)mem : mem, new, src, cmp;
 
 			/* The source would be the pointer, r0 the compare value */
 			if (rs == rd || (op == BPF_CMPXCHG && rd == BPF_REG_0))
 				continue;
 			rc = scratch_reg(rd, rs);
 			k = batch_case(b, rc, mem, upd);
-			/* Memory from in0, r0 inverted, source from in1, pointer */
-			LD_IN(b, k, 0, rc, rs);
-			EMIT(b, BPF_STX_MEM(size, BPF_REG_10, rs, MEM_SLOT));
+			/* r0 inverted into the slot, memory from in0, source from in1, pointer */
 			LD_IN(b, k, 0, rc, BPF_REG_0);
 			EMIT(b, BPF_ALU64_IMM(BPF_XOR, BPF_REG_0, -1));
+			EMIT(b, BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, MEM_SLOT));
+			LD_IN(b, k, 0, rc, rs);
+			EMIT(b, BPF_STX_MEM(size, BPF_REG_10, rs, MEM_SLOT));
 			LD_IN(b, k, 1, rc, rs);
 			EMIT(b, BPF_MOV64_REG(rd, BPF_REG_10));
 			EMIT(b, BPF_ATOMIC_OP(size, op, rd, rs, MEM_SLOT));
@@ -829,7 +1022,7 @@ static void atomic_reg_pairs(struct batch *b, int size, int op)
 			if (rd != BPF_REG_0)
 				ST_OUT(b, k, n++, rc, BPF_REG_0);
 			ST_OUT(b, k, n++, rc, rs);
-			EMIT(b, BPF_LDX_MEM(size, rs, BPF_REG_10, MEM_SLOT));
+			EMIT(b, BPF_LDX_MEM(BPF_DW, rs, BPF_REG_10, MEM_SLOT));
 			ST_OUT(b, k, n, rc, rs);
 
 			/* Model with the register aliasing of r0 */
@@ -854,7 +1047,7 @@ static void atomic_reg_pairs(struct batch *b, int size, int op)
 			if (rd != BPF_REG_0)
 				batch_expect(b, k, n++, regs[BPF_REG_0]);
 			batch_expect(b, k, n++, regs[rs]);
-			batch_expect(b, k, n, new);
+			batch_expect(b, k, n, head_merge(~mem, new, size));
 		}
 	}
 	batch_flush(b);
@@ -905,13 +1098,14 @@ static void test_xadd_chain(void)
 	free(insns);
 }
 
-/* 64-bit immediate loads for all magnitudes and byte patterns */
-static void ld_imm64_case(struct batch *b, __u64 imm)
+/* 64-bit immediate loads for all magnitudes, byte patterns and registers */
+static void ld_imm64_case(struct batch *b, int rd, __u64 imm)
 {
-	int k = batch_case(b, BPF_REG_3, imm, 0);
+	int rc = scratch_reg(rd, rd);
+	int k = batch_case(b, rc, imm, 0);
 
-	emit_ld_imm64(b, BPF_REG_1, imm);
-	ST_OUT(b, k, 0, BPF_REG_3, BPF_REG_1);
+	emit_ld_imm64(b, rd, imm);
+	ST_OUT(b, k, 0, rc, rd);
 	batch_expect(b, k, 0, imm);
 }
 
@@ -925,7 +1119,13 @@ static void test_ld_imm64(void)
 		{ 1, 0x81, 0, 0xff },		/* positive and zero */
 		{ 0x80, 0x80, 0, 0xff },	/* negative and zero */
 	};
-	int block = 64, bit, adj, sign, p, pattern, index;
+	/* Zero, a 32-bit, a sign extended 32-bit and a full immediate for every register */
+	static const __u64 imms[] = {
+		0, 1, 0x7fffffff, 0x80000000, 0xffffffff, 0x100000000ULL,
+		0xffffffffffffffffULL, 0xffffffff80000000ULL, 0xffffffff7fffffffULL,
+		0x0123456789abcdefULL,
+	};
+	int block = 64, bit, adj, sign, p, pattern, index, rd, i;
 	struct batch b;
 
 	if (!batch_init(&b))
@@ -934,7 +1134,7 @@ static void test_ld_imm64(void)
 	for (bit = 0; bit <= 62; bit++)
 		for (adj = -block / 2; adj < block / 2; adj++)
 			for (sign = -1; sign <= 1; sign += 2)
-				ld_imm64_case(&b, sign * ((1LL << bit) + adj));
+				ld_imm64_case(&b, BPF_REG_1, sign * ((1LL << bit) + adj));
 	batch_flush(&b);
 
 	for (p = 0; p < ARRAY_SIZE(bytes); p++) {
@@ -956,10 +1156,15 @@ static void test_ld_imm64(void)
 				imm = (imm << 8) | (__u8)byte;
 			}
 			rand = rand * 1664525 + 1013904223;
-			ld_imm64_case(&b, imm);
+			ld_imm64_case(&b, BPF_REG_1, imm);
 		}
 		batch_flush(&b);
 	}
+	snprintf(b.desc, sizeof(b.desc), "ld_imm64 registers");
+	for (rd = BPF_REG_0; rd <= BPF_REG_9; rd++)
+		for (i = 0; i < ARRAY_SIZE(imms); i++)
+			ld_imm64_case(&b, rd, imms[i]);
+	batch_flush(&b);
 	batch_fini(&b);
 }
 
@@ -1066,6 +1271,27 @@ static void test_jmp_reg(void)
 	test_jmp_magnitudes(true);
 }
 
+static void test_jmp_edges(void)
+{
+	struct batch b;
+	int o, f, r;
+
+	if (!batch_init(&b))
+		return;
+	for (f = 0; f < 2; f++) {
+		for (o = 0; o < ARRAY_SIZE(jmp_ops); o++) {
+			for (r = 0; r < 2; r++) {
+				struct jmp_arg a = { jmp_ops[o], f, r };
+
+				snprintf(b.desc, sizeof(b.desc), "jmp%s_%s_%c edges", f ? "32" : "",
+					 jmp_name(a.op), r ? 'x' : 'k');
+				fill_edges(&b, &a, !r, emit_jmp);
+			}
+		}
+	}
+	batch_fini(&b);
+}
+
 /* A conditional jump on two registers, with the operands swapped for n == 1 */
 static void jmp_reg_pair(struct batch *b, bool is32, int op, int rd, int rs, int n)
 {
@@ -1136,10 +1362,14 @@ static struct bpf_insn jmp_insn(bool ja32)
 /*
  * Taken jumps over regions of doubling length, forward or backward, up to
  * the maximal offset of the jump: 16 bits, or 2^17 for the 32-bit
- * unconditional jump. The not taken path of a conditional jump and the
- * guard of an unconditional one lead to an exit with the region number, so
- * the verifier sees every instruction reachable and a jump landing anywhere
- * else than on its target fails the run.
+ * unconditional jump. The operands are reloaded in every region, so that
+ * the verifier cannot decide the jumps from the bounds of the region
+ * before and fold the regions away. r0 gains the region number before the
+ * jump and loses it again only on the target, so the not taken path of a
+ * conditional jump, the guard of an unconditional one and a jump landing
+ * short of its target, or forward past it, exit with a nonzero r0. A
+ * backward jump overshooting its target comes back to itself and hangs
+ * the run instead.
  */
 static void staggered_jumps(const struct bpf_insn *jmp, __s64 r1, __s64 r2, bool backward,
 			    const char *desc)
@@ -1152,18 +1382,20 @@ static void staggered_jumps(const struct bpf_insn *jmp, __s64 r1, __s64 r2, bool
 		.ctx_size_in = sizeof(ctx),
 	);
 	int max = ja32 ? 1 << 17 : INT16_MAX;
-	int len = 128 + 2 * max, i = 0, n = 0, gap, fd;
+	int len = 256 + 2 * max, i = 0, n = 0, gap, fd;
 	struct bpf_insn *insns;
 
 	insns = malloc(len * sizeof(*insns));
 	if (!ASSERT_OK_PTR(insns, "insns"))
 		return;
-	insns[i++] = BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8);
-	insns[i++] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
+	insns[i++] = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
 	insns[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0);
 	for (gap = backward ? 4 : 2; gap <= max; gap = gap < max / 2 ? gap * 2 : max) {
 		int k, a, t, x, g, j;
 
+		insns[i++] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0);
+		insns[i++] = BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_6, 8);
+		insns[i++] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, ++n);
 		if (backward) {
 			/*
 			 * Over the region to its guard and jump, which comes back
@@ -1172,7 +1404,8 @@ static void staggered_jumps(const struct bpf_insn *jmp, __s64 r1, __s64 r2, bool
 			 */
 			a = i++;
 			t = i;
-			for (k = 0; k < gap - 3; k++)
+			insns[i++] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, n);
+			for (k = 0; k < gap - 3 - ja; k++)
 				insns[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0);
 			x = i++;
 			g = i;
@@ -1181,7 +1414,6 @@ static void staggered_jumps(const struct bpf_insn *jmp, __s64 r1, __s64 r2, bool
 			j = i;
 			insns[i] = *jmp;
 			set_jmp_off(&insns[i++], ja32, t - (j + 1));
-			insns[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, ++n);
 			insns[i++] = BPF_EXIT_INSN();
 			insns[a] = jmp_insn(ja32);
 			set_jmp_off(&insns[a], ja32, g - (a + 1));
@@ -1193,10 +1425,10 @@ static void staggered_jumps(const struct bpf_insn *jmp, __s64 r1, __s64 r2, bool
 				insns[i++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, 1);
 			insns[i] = *jmp;
 			set_jmp_off(&insns[i++], ja32, gap);
-			insns[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, ++n);
-			for (k = 0; k < gap - 2; k++)
+			for (k = 0; k < gap - 1; k++)
 				insns[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0);
 			insns[i++] = BPF_EXIT_INSN();
+			insns[i++] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, n);
 		}
 		if (gap == max)
 			break;
@@ -1334,50 +1566,6 @@ static void prog_run(int fd, __u64 in0, __u64 in1, __u64 expected, const char *d
 		ASSERT_EQ(ctx.res, expected, buf);
 }
 
-static int size_bits(int size)
-{
-	switch (size) {
-	case BPF_B:
-		return 8;
-	case BPF_H:
-		return 16;
-	case BPF_W:
-		return 32;
-	default:
-		return 64;
-	}
-}
-
-/* The first size bytes of v in memory, as a load of that size reads them */
-static __u64 head_bytes(__u64 v, int size)
-{
-	int bits = size_bits(size);
-
-	if (bits == 64)
-		return v;
-#if __BYTE_ORDER == __BIG_ENDIAN
-	return v >> (64 - bits);
-#else
-	return v & ((1ULL << bits) - 1);
-#endif
-}
-
-/* v with its first size bytes in memory replaced by those of w */
-static __u64 head_merge(__u64 v, __u64 w, int size)
-{
-	int bits = size_bits(size);
-	__u64 mask;
-
-	if (bits == 64)
-		return w;
-	mask = (1ULL << bits) - 1;
-#if __BYTE_ORDER == __BIG_ENDIAN
-	return (v & ~(mask << (64 - bits))) | ((w & mask) << (64 - bits));
-#else
-	return (v & ~mask) | (w & mask);
-#endif
-}
-
 static void test_ldst_zero_off(void)
 {
 	static const int sizes[] = { BPF_B, BPF_H, BPF_W, BPF_DW };
@@ -1398,8 +1586,9 @@ static void test_ldst_zero_off(void)
 			for (k = 0; k < NR_PAIRS; k++) {
 				int rd = pair_reg(b, k);
 
-				/* Load with a zero offset, also into the base */
+				/* Load with a zero offset over all ones, also into the base */
 				prog_start(&p);
+				EMIT(&p, BPF_MOV64_IMM(rd, -1));
 				EMIT(&p, BPF_MOV64_REG(rb, BPF_REG_6));
 				EMIT(&p, BPF_LDX_MEM(size, rd, rb, 0));
 				prog_end(&p, rd);
@@ -1431,8 +1620,7 @@ static void test_ldst_zero_off(void)
 					for (j = 0; j < ARRAY_SIZE(inputs); j++) {
 						__s64 v = head_bytes(inputs[j], size);
 
-						v = size == BPF_B ? (__s8)v :
-						    size == BPF_H ? (__s16)v : (__s32)v;
+						v = sign_extend(v, size);
 						prog_run(fd, inputs[j], 0, v, desc);
 					}
 					close(fd);
@@ -1614,6 +1802,12 @@ static int other_reg(int r1, int r2)
 	return BPF_REG_9;
 }
 
+static void off_prog_ld_imm64(struct off_prog *p, int reg, __u64 imm)
+{
+	EMIT(p, BPF_RAW_INSN(BPF_LD | BPF_DW | BPF_IMM, reg, 0, 0, (__u32)imm));
+	EMIT(p, BPF_RAW_INSN(0, 0, 0, 0, imm >> 32));
+}
+
 /* Look up the value of key into r0, exit with 1 when the lookup fails */
 static void off_prog_lookup(struct off_prog *p, int map_fd, int key)
 {
@@ -1700,8 +1894,11 @@ static void load_offsets(struct off_mem *m, int kind, int size, int rb, int rd,
 
 	off_prog_start(&p, map_fd, rb);
 	for (i = 0; i < nr; i++) {
+		/* The base gets reloaded when it is the destination, all ones otherwise */
 		if (rd == rb)
 			EMIT(&p, BPF_LDX_MEM(BPF_DW, rb, BPF_REG_10, SLOT_BASE));
+		else
+			EMIT(&p, BPF_MOV64_IMM(rd, -1));
 		if (kind == K_LDX)
 			EMIT(&p, BPF_LDX_MEM(size, rd, rb, off[i]));
 		else
@@ -1722,7 +1919,7 @@ static void load_offsets(struct off_mem *m, int kind, int size, int rb, int rd,
 		__u64 v = load_bytes(m->mem + MEM_BASE + off[i], size);
 
 		if (kind == K_LDSX)
-			v = size == BPF_B ? (__s8)v : size == BPF_H ? (__s16)v : (__s32)v;
+			v = sign_extend(v, size);
 		if (res[i] != v) {
 			snprintf(desc, sizeof(desc), "%s size=%d base=r%d dst=r%d off=%d",
 				 kind == K_LDX ? "ldx" : "ldsx", size, rb, rd, off[i]);
@@ -1873,7 +2070,7 @@ static void test_movsx(void)
 }
 
 /* Branch on dst and imm, with 1 in res when taken and 0 otherwise */
-static void jmp_prog(struct prog *p, bool is64, int op, int d, __s32 imm)
+static void jmp_prog(struct prog *p, bool is64, int op, int d, __s32 imm, int off)
 {
 	int rd = pat_regs[d], rt = pair_reg(d, 1);
 
@@ -1881,9 +2078,9 @@ static void jmp_prog(struct prog *p, bool is64, int op, int d, __s32 imm)
 	EMIT(p, BPF_LDX_MEM(BPF_DW, rd, BPF_REG_6, IN0));
 	EMIT(p, BPF_MOV64_IMM(rt, 1));
 	if (is64)
-		EMIT(p, BPF_JMP_IMM(op, rd, imm, 1));
+		EMIT(p, BPF_JMP_IMM(op, rd, imm, off));
 	else
-		EMIT(p, BPF_JMP32_IMM(op, rd, imm, 1));
+		EMIT(p, BPF_JMP32_IMM(op, rd, imm, off));
 	EMIT(p, BPF_MOV64_IMM(rt, 0));
 	prog_end(p, rt);
 }
@@ -1903,7 +2100,7 @@ static void test_jset_imm(void)
 
 		for (is64 = false; ; is64 = true) {
 			for (m = 0; m < ARRAY_SIZE(masks); m++) {
-				jmp_prog(&p, is64, BPF_JSET, d, masks[m]);
+				jmp_prog(&p, is64, BPF_JSET, d, masks[m], 1);
 				snprintf(desc, sizeof(desc), "jset%d dst=r%d mask=0x%x",
 					 is64 ? 64 : 32, rd, masks[m]);
 				fd = prog_load(&p, desc);
@@ -1975,7 +2172,7 @@ static void test_cmp_imm(void)
 		for (is64 = false; ; is64 = true) {
 			for (o = 0; o < ARRAY_SIZE(ops); o++) {
 				for (m = 0; m < ARRAY_SIZE(imms); m++) {
-					jmp_prog(&p, is64, ops[o], d, imms[m]);
+					jmp_prog(&p, is64, ops[o], d, imms[m], 1);
 					snprintf(desc, sizeof(desc), "jmp%d op=0x%x dst=r%d imm=%d",
 						 is64 ? 64 : 32, ops[o], rd, imms[m]);
 					fd = prog_load(&p, desc);
@@ -1990,6 +2187,18 @@ static void test_cmp_imm(void)
 						prog_run(fd, inputs[j], 0, taken, desc);
 					}
 					close(fd);
+					if (m)
+						continue;
+					/* A jump over nothing lands on the same path either way */
+					jmp_prog(&p, is64, ops[o], d, imms[m], 0);
+					snprintf(desc, sizeof(desc), "jmp%d op=0x%x dst=r%d off=0",
+						 is64 ? 64 : 32, ops[o], rd);
+					fd = prog_load(&p, desc);
+					if (fd < 0)
+						return;
+					for (j = 0; j < ARRAY_SIZE(inputs); j++)
+						prog_run(fd, inputs[j], 0, 0, desc);
+					close(fd);
 				}
 			}
 			if (is64)
@@ -2122,7 +2331,15 @@ static void test_bswap(void)
 
 static void test_probe_mem(void)
 {
-	int kfunc_id, type_id, b, k, j, fd;
+	static const struct {
+		int size;
+		bool sx;
+	} loads[] = {
+		{ BPF_B, false }, { BPF_H, false }, { BPF_W, false }, { BPF_DW, false },
+		{ BPF_B, true }, { BPF_H, true }, { BPF_W, true },
+	};
+	int kfunc_id, type_id, b, k, l, j, fd;
+	struct bpf_insn call;
 	struct btf *btf;
 	struct prog p;
 	char desc[64];
@@ -2136,30 +2353,46 @@ static void test_probe_mem(void)
 	if (!ASSERT_GT(kfunc_id, 0, "bpf_rdonly_cast id") ||
 	    !ASSERT_GT(type_id, 0, "timespec64 id"))
 		return;
+	call = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, kfunc_id);
 
-	/* The kernel copy of the ctx through an untrusted pointer in every register */
+	/*
+	 * The kernel copy of the ctx through an untrusted pointer in every
+	 * register, in every size, zero and sign extending over all ones
+	 */
 	for (b = 0; b < ARRAY_SIZE(pat_regs); b++) {
 		int rb = pat_regs[b];
 
 		for (k = 0; k < NR_PAIRS; k++) {
 			int rd = pair_reg(b, k);
 
-			prog_start(&p);
-			EMIT(&p, BPF_MOV64_REG(BPF_REG_1, BPF_REG_6));
-			EMIT(&p, BPF_MOV32_IMM(BPF_REG_2, type_id));
-			EMIT(&p, BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL,
-					      0, kfunc_id));
-			if (rb != BPF_REG_0)
-				EMIT(&p, BPF_MOV64_REG(rb, BPF_REG_0));
-			EMIT(&p, BPF_LDX_MEM(BPF_DW, rd, rb, 0));
-			prog_end(&p, rd);
-			snprintf(desc, sizeof(desc), "probe_mem base=r%d dst=r%d", rb, rd);
-			fd = prog_load(&p, desc);
-			if (fd < 0)
-				return;
-			for (j = 0; j < ARRAY_SIZE(inputs); j++)
-				prog_run(fd, inputs[j], 0, inputs[j], desc);
-			close(fd);
+			for (l = 0; l < ARRAY_SIZE(loads); l++) {
+				int size = loads[l].size, mode = loads[l].sx ? BPF_MEMSX : BPF_MEM;
+
+				prog_start(&p);
+				EMIT(&p, BPF_MOV64_REG(BPF_REG_1, BPF_REG_6));
+				EMIT(&p, BPF_MOV32_IMM(BPF_REG_2, type_id));
+				EMIT(&p, call);
+				if (rb != BPF_REG_0)
+					EMIT(&p, BPF_MOV64_REG(rb, BPF_REG_0));
+				if (rd != rb)
+					EMIT(&p, BPF_MOV64_IMM(rd, -1));
+				EMIT(&p, BPF_RAW_INSN(BPF_LDX | mode | size, rd, rb, 0, 0));
+				prog_end(&p, rd);
+				snprintf(desc, sizeof(desc),
+					 "probe_mem%s size=%d base=r%d dst=r%d",
+					 loads[l].sx ? "sx" : "", size, rb, rd);
+				fd = prog_load(&p, desc);
+				if (fd < 0)
+					return;
+				for (j = 0; j < ARRAY_SIZE(inputs); j++) {
+					__s64 v = head_bytes(inputs[j], size);
+
+					if (loads[l].sx)
+						v = sign_extend(v, size);
+					prog_run(fd, inputs[j], 0, v, desc);
+				}
+				close(fd);
+			}
 		}
 	}
 
@@ -2171,8 +2404,7 @@ static void test_probe_mem(void)
 		EMIT(&p, BPF_RAW_INSN(BPF_LD | BPF_DW | BPF_IMM, BPF_REG_1, 0, 0, (__u32)addr));
 		EMIT(&p, BPF_RAW_INSN(0, 0, 0, 0, addr >> 32));
 		EMIT(&p, BPF_MOV32_IMM(BPF_REG_2, type_id));
-		EMIT(&p, BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL,
-				      0, kfunc_id));
+		EMIT(&p, call);
 		EMIT(&p, BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0));
 		prog_end(&p, BPF_REG_3);
 		snprintf(desc, sizeof(desc), "probe_mem addr=0x%llx", addr);
@@ -2184,24 +2416,6 @@ static void test_probe_mem(void)
 	}
 }
 
-/* Whether the JIT supports load-acquire and store-release */
-static bool acq_rel_ok(void)
-{
-	LIBBPF_OPTS(bpf_prog_load_opts, lopts, .prog_flags = BPF_F_SLEEPABLE);
-	struct prog p;
-	int fd;
-
-	prog_start(&p);
-	EMIT(&p, BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0));
-	EMIT(&p, BPF_ATOMIC_OP(BPF_DW, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_10, -8));
-	prog_end(&p, BPF_REG_0);
-	fd = bpf_prog_load(BPF_PROG_TYPE_SYSCALL, NULL, "GPL", p.insns, p.cnt, &lopts);
-	if (fd < 0)
-		return false;
-	close(fd);
-	return true;
-}
-
 /*
  * Load-acquire and store-release of every size with every register as
  * base, on a stack slot holding in0: the loads zero extend like the plain
@@ -2215,10 +2429,6 @@ static void test_acq_rel(void)
 	char desc[64];
 	int b, k, s, j, fd;
 
-	if (!acq_rel_ok()) {
-		test__skip();
-		return;
-	}
 	for (b = 0; b < ARRAY_SIZE(pat_regs); b++) {
 		int rb = pat_regs[b];
 
@@ -2340,6 +2550,502 @@ static void test_max_jmp(void)
 	max_jmp(true, false);
 }
 
+/*
+ * Fillers of two and three bytes of native code on x86-64: a 32-bit and a
+ * 64-bit move between two low registers, which give a region every length
+ * from two bytes on and which constant blinding leaves alone.
+ */
+static int fill_bytes(struct bpf_insn *insns, int n, int bytes)
+{
+	if (bytes & 1) {
+		insns[n++] = BPF_MOV64_REG(BPF_REG_2, BPF_REG_3);
+		bytes -= 3;
+	}
+	for (; bytes > 0; bytes -= 2)
+		insns[n++] = BPF_MOV32_REG(BPF_REG_2, BPF_REG_3);
+	return n;
+}
+
+static void prog_result(struct bpf_insn *insns, int *n)
+{
+	insns[(*n)++] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 10);
+	insns[(*n)++] = BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, RES);
+	insns[(*n)++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[(*n)++] = BPF_EXIT_INSN();
+}
+
+/* A region of x86-64 bytes through fill_bytes(), or of so many 64 and 32-bit moves */
+struct fill {
+	int bytes, wide, narrow;
+};
+
+static int fill_moves(struct bpf_insn *insns, int n, int wide, int narrow)
+{
+	while (wide-- > 0)
+		insns[n++] = BPF_MOV64_REG(BPF_REG_2, BPF_REG_3);
+	while (narrow-- > 0)
+		insns[n++] = BPF_MOV32_REG(BPF_REG_2, BPF_REG_3);
+	return n;
+}
+
+static int fill_region(struct bpf_insn *insns, int n, const struct fill *f)
+{
+	if (f->wide || f->narrow)
+		return fill_moves(insns, n, f->wide, f->narrow);
+	return fill_bytes(insns, n, f->bytes);
+}
+
+static int fill_insns(const struct fill *f)
+{
+	return f->wide + f->narrow + f->bytes / 2 + 1;
+}
+
+/*
+ * Jumps whose lengths depend on each other: a conditional jump forward
+ * over a region, a jump back from its end to its start or to the jump in
+ * front of it, and an unconditional jump out of it. The region takes every
+ * length around the short branch limit, in front of the exit and behind
+ * it, so the three jumps cross the limit at different lengths and in both
+ * directions. A chain of nop jumps in it, gone one per pass, shifts the
+ * phase in which the cycle meets the padding passes, as settling jumps
+ * elsewhere do. This is generic to any JIT with short and long branch
+ * forms: the ranges of the running one are probed, see find_ranges(), and
+ * the cycle swept across each of them. r0 goes in with 0 to 3 and picks
+ * one of the four paths through the jumps.
+ */
+static void jump_cycle(bool back_cond, bool to_start, int inner, const struct fill *front,
+		       const struct fill *back, const char *desc)
+{
+	struct bpf_insn *insns;
+	int n = 0, disp, head, chain, to_back[2], out, i, fd;
+
+	insns = malloc((32 + 2 * inner + fill_insns(front) + fill_insns(back)) * sizeof(*insns));
+	if (!ASSERT_OK_PTR(insns, desc))
+		return;
+	insns[n++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, IN0);
+	insns[n++] = BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_1, IN1);
+	insns[n++] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 3);
+	insns[n++] = BPF_MOV64_IMM(BPF_REG_3, 0);
+	/* The dispatch into the chain, see nop_chain() */
+	disp = n;
+	n += inner;
+	head = n++;
+	n = fill_region(insns, n, front);
+	chain = n;
+	for (i = 0; i < inner; i++) {
+		insns[disp + i] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 0x1000 + i, chain - disp - 1);
+		insns[n++] = BPF_JMP_IMM(BPF_JA, 0, 0, inner - 1 - i);
+	}
+	to_back[0] = n++;
+	to_back[1] = n++;
+	out = n++;
+	insns[to_back[0]] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, n - to_back[0] - 1);
+	insns[to_back[1]] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 3, n - to_back[1] - 1);
+	insns[n++] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1);
+	n = fill_region(insns, n, back);
+	/* Taken with 2 and not with 4, so the verifier keeps the condition */
+	if (back_cond)
+		insns[n] = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 4, head + to_start - n - 1);
+	else
+		insns[n] = BPF_JMP_IMM(BPF_JA, 0, 0, head + to_start - n - 1);
+	n++;
+	insns[head] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 2, n - head - 1);
+	insns[out] = BPF_JMP_IMM(BPF_JA, 0, 0, n - out - 1);
+	prog_result(insns, &n);
+
+	fd = load_prog(insns, n, desc);
+	free(insns);
+	if (fd < 0)
+		return;
+	prog_run(fd, 0, 0, 10, desc);
+	prog_run(fd, 1, 0, 12, desc);
+	prog_run(fd, 2, 0, 12, desc);
+	prog_run(fd, 3, 0, 14, desc);
+	close(fd);
+}
+
+/*
+ * A region which ends in a chain of jumps to its end: the last one jumps
+ * to the next instruction, which the JIT drops as a nop, whereupon the one
+ * before it becomes one, so the chain goes away one jump per pass and the
+ * jump over the region shrinks late, in the passes which pad the image.
+ * The filler in front of the chain puts that jump around the short branch
+ * limit, as a conditional and as an unconditional one, over a chain of ja
+ * and one of gotol. Each jump of the chain is the target of a conditional
+ * jump in front of the region on a value the verifier cannot see, as the
+ * chain is dead behind its first jump otherwise.
+ */
+static void nop_chain(bool over_cond, bool ja32, int len, int fill)
+{
+	struct bpf_insn insns[256];
+	int n = 0, disp, over, chain, i, fd;
+	char desc[64];
+
+	insns[n++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, IN0);
+	insns[n++] = BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_1, IN1);
+	insns[n++] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 3);
+	insns[n++] = BPF_MOV64_IMM(BPF_REG_3, 0);
+	/* The dispatch into the chain, filled in once the chain is placed */
+	disp = n;
+	n += len;
+	if (!over_cond)
+		insns[n++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 2, 1);
+	over = n++;
+	n = fill_bytes(insns, n, fill);
+	chain = n;
+	for (i = 0; i < len; i++) {
+		insns[disp + i] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 0x1000 + i, chain - disp - 1);
+		insns[n++] = ja32 ? BPF_RAW_INSN(BPF_JMP32 | BPF_JA, 0, 0, 0, len - 1 - i) :
+				    BPF_JMP_IMM(BPF_JA, 0, 0, len - 1 - i);
+	}
+	insns[n++] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1);
+	if (over_cond)
+		insns[over] = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 2, n - over - 1);
+	else
+		insns[over] = BPF_JMP_IMM(BPF_JA, 0, 0, n - over - 1);
+	prog_result(insns, &n);
+
+	snprintf(desc, sizeof(desc), "nop chain of %s under %s len=%d fill=%d",
+		 ja32 ? "gotol" : "ja", over_cond ? "jcc" : "ja", len, fill);
+	fd = load_prog(insns, n, desc);
+	if (fd < 0)
+		return;
+	prog_run(fd, 0, 0, 10, desc);
+	prog_run(fd, 1, 0, 11, desc);
+	prog_run(fd, 2, 0, 13, desc);
+	prog_run(fd, 3, 0, 13, desc);
+	close(fd);
+}
+
+/* The native length of a program's image, 0 without a JIT */
+static __u32 jited_len(int fd)
+{
+	struct bpf_prog_info info = {};
+	__u32 len = sizeof(info);
+
+	if (!ASSERT_OK(bpf_prog_get_info_by_fd(fd, &info, &len), "prog info"))
+		return 0;
+	return info.jited_prog_len;
+}
+
+/* A conditional jump over the moves, for the length of its image */
+static int probe_len(int wide, int narrow, __u32 *len)
+{
+	struct bpf_insn *insns;
+	int n = 0, fd;
+
+	insns = malloc((wide + narrow + 8) * sizeof(*insns));
+	if (!ASSERT_OK_PTR(insns, "probe insns"))
+		return -1;
+	insns[n++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, IN0);
+	insns[n++] = BPF_MOV64_IMM(BPF_REG_3, 0);
+	insns[n++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 2, wide + narrow);
+	n = fill_moves(insns, n, wide, narrow);
+	insns[n++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[n++] = BPF_EXIT_INSN();
+	fd = load_prog(insns, n, "branch range probe");
+	free(insns);
+	if (fd < 0)
+		return -1;
+	*len = jited_len(fd);
+	close(fd);
+	return 0;
+}
+
+/*
+ * The short branch ranges of the running JIT, as counts of 64-bit moves a
+ * conditional jump reaches over, and the native lengths of the two moves.
+ * The image of the probe grows by the moves alone until the jump does not
+ * reach over them any more and takes a longer form, which adds the
+ * difference of the forms: find the first count that does so in every
+ * power of two of moves up to the 16-bit offset of the jump, as a JIT may
+ * have several forms. Without a JIT or with fixed length branches there is
+ * none.
+ */
+static int find_ranges(int *ranges, int max, int *wide_bytes, int *narrow_bytes)
+{
+	__u32 base, len;
+	int excess, plateau = 0, c, lo, hi, mid, k = 0;
+
+	if (probe_len(8, 0, &base) || !base)
+		return 0;
+	if (probe_len(24, 0, &len))
+		return 0;
+	*wide_bytes = (len - base) / 16;
+	if (probe_len(8, 16, &len))
+		return 0;
+	*narrow_bytes = (len - base) / 16;
+	if (!*wide_bytes || !*narrow_bytes)
+		return 0;
+	for (c = 32; k < max && c <= 16384; c *= 2) {
+		if (probe_len(c, 0, &len))
+			return k;
+		excess = len - base - (c - 8) * *wide_bytes;
+		if (excess <= plateau)
+			continue;
+		lo = c / 2;
+		hi = c;
+		while (hi - lo > 1) {
+			mid = (lo + hi) / 2;
+			if (probe_len(mid, 0, &len))
+				return k;
+			if (len - base - (mid - 8) * *wide_bytes > plateau)
+				hi = mid;
+			else
+				lo = mid;
+		}
+		ranges[k++] = hi;
+		plateau = excess;
+	}
+	return k;
+}
+
+static int gcd(int a, int b)
+{
+	while (b) {
+		int t = a % b;
+
+		a = b;
+		b = t;
+	}
+	return a;
+}
+
+/* The jump cycle with the region in front of the exit and then behind it */
+static void cycle_bytes(int kind, int inner, int bytes)
+{
+	struct fill front = { .bytes = bytes }, back = {};
+	char desc[96];
+
+	snprintf(desc, sizeof(desc), "jump cycle %s back to %s inner=%d front=%d",
+		 kind & 1 ? "jcc" : "ja", kind & 2 ? "start" : "head", inner, bytes);
+	jump_cycle(kind & 1, kind & 2, inner, &front, &back, desc);
+	front.bytes = 0;
+	back.bytes = bytes;
+	snprintf(desc, sizeof(desc), "jump cycle %s back to %s inner=%d back=%d",
+		 kind & 1 ? "jcc" : "ja", kind & 2 ? "start" : "head", inner, bytes);
+	jump_cycle(kind & 1, kind & 2, inner, &front, &back, desc);
+}
+
+/* The jump cycle with a region of so many native bytes of moves */
+static void cycle_moves(int kind, int range, int bytes, int wide, int narrow)
+{
+	struct fill front = {}, back = {};
+	char desc[96];
+	int b;
+
+	for (b = 0; b * narrow <= bytes; b++)
+		if ((bytes - b * narrow) % wide == 0)
+			break;
+	if (b * narrow > bytes)
+		return;
+	front.wide = (bytes - b * narrow) / wide;
+	front.narrow = b;
+	snprintf(desc, sizeof(desc), "jump cycle %s back to %s range %d at %d bytes",
+		 kind & 1 ? "jcc" : "ja", kind & 2 ? "start" : "head", range, bytes);
+	jump_cycle(kind & 1, kind & 2, 0, &front, &back, desc);
+}
+
+static void test_convergence(void)
+{
+	/* The chain gone, the jump over it is at and below the limit */
+	static const int fills[] = { 100, 110, 116, 120 };
+	/* The last jump of a chain is a nop the verifier already removes */
+	static const int inners[] = { 0, 2, 3, 4, 5 };
+	int ranges[4], wide, narrow, g, nr, bytes, lo, hi, c, f, i, l, k;
+
+	/* The x86-64 imm8 range, byte by byte */
+	for (c = 0; c < 4; c++)
+		for (i = 0; i < ARRAY_SIZE(inners); i++)
+			for (f = 100; f <= 132; f++)
+				cycle_bytes(c, inners[i], f);
+	for (c = 0; c < 4; c++)
+		for (f = 0; f < ARRAY_SIZE(fills); f++)
+			for (l = 2; l <= 26; l++)
+				nop_chain(c & 1, c & 2, l, fills[f]);
+
+	/*
+	 * The short branch ranges of this JIT, which the fillers of 64 and
+	 * 32-bit moves approach at the granularity their lengths allow
+	 */
+	nr = find_ranges(ranges, ARRAY_SIZE(ranges), &wide, &narrow);
+	for (k = 0; k < nr; k++) {
+		printf("short branch range at %d bytes, moves of %d and %d bytes\n",
+		       ranges[k] * wide, wide, narrow);
+		g = gcd(wide, narrow);
+		lo = ranges[k] * wide - 128;
+		hi = ranges[k] * wide + 32;
+		for (c = 0; c < 4; c++)
+			for (bytes = lo; bytes <= hi; bytes += g)
+				cycle_moves(c, ranges[k] * wide, bytes, wide, narrow);
+	}
+}
+
+/*
+ * Calls into a subprogram with all five arguments, which clobbers a subset
+ * of r6-r9 and uses the deepest stack slot the budget leaves, directly or
+ * through another one clobbering the rest, so the JIT has to save and
+ * restore what it uses.
+ */
+/* Values to keep in r6-r9 across calls */
+static const __u64 kept[] = {
+	0x1111111111111111ULL, 0x2222222222222222ULL,
+	0x3333333333333333ULL, 0x4444444444444444ULL,
+};
+
+static void test_calls(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	__u64 expected = 1 + 2 + 3 + 4 + 5;
+	struct bpf_insn insns[64];
+	struct pat_ctx ctx;
+	char desc[64];
+	int nested, mask, n, call, r, fd, leaf;
+
+	/* The frames above the leaf take up to 32 bytes each of the budget */
+	leaf = (is_large_stack_supported() ? 2048 : 512) - 2 * 32;
+	for (r = 0; r < 4; r++)
+		expected += kept[r];
+	opts.ctx_in = &ctx;
+	opts.ctx_size_in = sizeof(ctx);
+	for (nested = 0; nested < 2; nested++) {
+		for (mask = 0; mask < 16; mask++) {
+			n = 0;
+			insns[n++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8);
+			for (r = 0; r < 4; r++) {
+				insns[n++] = BPF_RAW_INSN(BPF_LD | BPF_DW | BPF_IMM, BPF_REG_6 + r,
+							  0, 0, (__u32)kept[r]);
+				insns[n++] = BPF_RAW_INSN(0, 0, 0, 0, kept[r] >> 32);
+			}
+			for (r = 1; r <= 5; r++)
+				insns[n++] = BPF_MOV64_IMM(r, r);
+			call = n++;
+			for (r = 6; r <= 9; r++)
+				insns[n++] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, r);
+			insns[n++] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -8);
+			insns[n++] = BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, RES);
+			insns[n++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+			insns[n++] = BPF_EXIT_INSN();
+			insns[call] = BPF_CALL_REL(n - call - 1);
+			if (nested) {
+				/* Clobber the subset, pass the arguments on */
+				for (r = 0; r < 4; r++)
+					if (mask & (1 << r))
+						insns[n++] = BPF_MOV64_IMM(BPF_REG_6 + r, 0);
+				call = n++;
+				insns[n++] = BPF_EXIT_INSN();
+				insns[call] = BPF_CALL_REL(n - call - 1);
+			}
+			/* Clobber the rest, sum the arguments through the deepest slot */
+			for (r = 0; r < 4; r++)
+				if ((nested ? ~mask : mask) & (1 << r))
+					insns[n++] = BPF_MOV64_IMM(BPF_REG_6 + r, 0);
+			insns[n++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -leaf);
+			insns[n++] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_2);
+			for (r = 3; r <= 5; r++)
+				insns[n++] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, r);
+			insns[n++] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -leaf);
+			insns[n++] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
+			insns[n++] = BPF_EXIT_INSN();
+
+			snprintf(desc, sizeof(desc), "call%s clobbering 0x%x",
+				 nested ? " nested" : "", mask);
+			fd = load_prog(insns, n, desc);
+			if (fd < 0)
+				return;
+			memset(&ctx, 0, sizeof(ctx));
+			if (ASSERT_OK(bpf_prog_test_run_opts(fd, &opts), desc))
+				ASSERT_EQ(ctx.res, expected, desc);
+			close(fd);
+		}
+	}
+}
+
+/*
+ * Helper calls with up to five arguments and a kfunc call: a dynptr over a
+ * map value, a read from it into the stack and its size, with r6-r9 live
+ * across the calls. The returns, the bytes read, the size and r6-r9 add up.
+ */
+static void test_helper_calls(void)
+{
+	static const int offs[] = { 0, 8, 1000, 4088 };
+	struct off_prog p;
+	struct btf *btf;
+	__u8 mem[4096];
+	__u64 expected;
+	__u32 key = 0;
+	char desc[64];
+	int map_fd, kfunc_id, i, r, fd;
+
+	btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(btf, "vmlinux btf"))
+		return;
+	kfunc_id = btf__find_by_name_kind(btf, "bpf_dynptr_size", BTF_KIND_FUNC);
+	btf__free(btf);
+	if (!ASSERT_GT(kfunc_id, 0, "bpf_dynptr_size id"))
+		return;
+	for (i = 0; i < sizeof(mem); i++)
+		mem[i] = i * 7 + 3;
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "helper_mem", sizeof(key), sizeof(mem), 1,
+				NULL);
+	if (!ASSERT_GE(map_fd, 0, "helper_mem map"))
+		return;
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, mem, 0), "helper_mem update"))
+		goto out;
+
+	for (i = 0; i < ARRAY_SIZE(offs); i++) {
+		p.cnt = 0;
+		EMIT(&p, BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -64));
+		for (r = 0; r < 4; r++)
+			off_prog_ld_imm64(&p, BPF_REG_6 + r, kept[r]);
+		off_prog_lookup(&p, map_fd, key);
+		/* The dynptr at -80 over the value, the returns summed at -96 */
+		EMIT(&p, BPF_MOV64_REG(BPF_REG_1, BPF_REG_0));
+		EMIT(&p, BPF_MOV64_IMM(BPF_REG_2, sizeof(mem)));
+		EMIT(&p, BPF_MOV64_IMM(BPF_REG_3, 0));
+		EMIT(&p, BPF_MOV64_REG(BPF_REG_4, BPF_REG_10));
+		EMIT(&p, BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -80));
+		EMIT(&p, BPF_EMIT_CALL(BPF_FUNC_dynptr_from_mem));
+		EMIT(&p, BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -96));
+		/* Eight bytes from the offset into -88 */
+		EMIT(&p, BPF_MOV64_REG(BPF_REG_1, BPF_REG_10));
+		EMIT(&p, BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -88));
+		EMIT(&p, BPF_MOV64_IMM(BPF_REG_2, 8));
+		EMIT(&p, BPF_MOV64_REG(BPF_REG_3, BPF_REG_10));
+		EMIT(&p, BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -80));
+		EMIT(&p, BPF_MOV64_IMM(BPF_REG_4, offs[i]));
+		EMIT(&p, BPF_MOV64_IMM(BPF_REG_5, 0));
+		EMIT(&p, BPF_EMIT_CALL(BPF_FUNC_dynptr_read));
+		EMIT(&p, BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -96));
+		EMIT(&p, BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1));
+		EMIT(&p, BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -96));
+		/* The size through the kfunc */
+		EMIT(&p, BPF_MOV64_REG(BPF_REG_1, BPF_REG_10));
+		EMIT(&p, BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -80));
+		EMIT(&p, BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0,
+				      kfunc_id));
+		EMIT(&p, BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -88));
+		EMIT(&p, BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1));
+		EMIT(&p, BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -96));
+		EMIT(&p, BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1));
+		for (r = BPF_REG_6; r <= BPF_REG_9; r++)
+			EMIT(&p, BPF_ALU64_REG(BPF_ADD, BPF_REG_0, r));
+		EMIT(&p, BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -64));
+		EMIT(&p, BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, RES));
+		snprintf(desc, sizeof(desc), "helper calls off=%d", offs[i]);
+		fd = off_prog_load(&p, desc, false);
+		if (fd < 0)
+			goto out;
+		expected = sizeof(mem) + load_bytes(mem + offs[i], BPF_DW);
+		for (r = 0; r < 4; r++)
+			expected += kept[r];
+		prog_run(fd, 0, 0, expected, desc);
+		close(fd);
+	}
+out:
+	close(map_fd);
+}
+
 void test_jit_insns(void)
 {
 	RUN_TESTS(jit_insns_arena);
@@ -2353,8 +3059,12 @@ void test_jit_insns(void)
 		test_div_const();
 	if (test__start_subtest("alu_reg_pairs"))
 		test_alu_reg_pairs();
+	if (test__start_subtest("alu_edges"))
+		test_alu_edges();
 	if (test__start_subtest("shifts"))
 		test_shifts();
+	if (test__start_subtest("shift_counts"))
+		test_shift_counts();
 	if (test__start_subtest("atomics"))
 		test_atomics();
 	if (test__start_subtest("atomic_reg_pairs"))
@@ -2369,10 +3079,18 @@ void test_jit_insns(void)
 		test_jmp_reg();
 	if (test__start_subtest("jmp_reg_pairs"))
 		test_jmp_reg_pairs();
+	if (test__start_subtest("jmp_edges"))
+		test_jmp_edges();
 	if (test__start_subtest("staggered_jumps"))
 		test_staggered_jumps();
 	if (test__start_subtest("max_jmp"))
 		test_max_jmp();
+	if (test__start_subtest("convergence"))
+		test_convergence();
+	if (test__start_subtest("calls"))
+		test_calls();
+	if (test__start_subtest("helper_calls"))
+		test_helper_calls();
 	if (test__start_subtest("ldst_zero_off"))
 		test_ldst_zero_off();
 	if (test__start_subtest("ldst_offsets"))
@@ -2409,6 +3127,8 @@ void serial_test_jit_insns_blinded(void)
 		test_alu_imm();
 	if (test__start_subtest("alu_imm_regs"))
 		test_alu_imm_regs();
+	if (test__start_subtest("alu_edges"))
+		test_alu_edges();
 	if (test__start_subtest("div_const"))
 		test_div_const();
 	if (test__start_subtest("shifts"))
@@ -2419,6 +3139,8 @@ void serial_test_jit_insns_blinded(void)
 		test_ld_imm64();
 	if (test__start_subtest("jmp_imm"))
 		test_jmp_imm();
+	if (test__start_subtest("jmp_edges"))
+		test_jmp_edges();
 	if (test__start_subtest("ldst_zero_off"))
 		test_ldst_zero_off();
 	if (test__start_subtest("ldst_offsets"))
-- 
2.43.0

