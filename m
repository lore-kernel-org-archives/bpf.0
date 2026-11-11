Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415730;
	b=aPvRnQ4CaGgp74STUxvPMYW3We5Npu2Zdom2P9SdDR03lR9erPhkkNBg7ke9eSt774NI
	 f01w2l8GrOZOk/gq+Wsd4ELMAlY+NRE/1HaNBuK6ksrwgEutTlzzwbtd1BGIDEM3FbZdI
	 OMAfwsKtdrSeb1zowMWt1kqB8+N6MPJR1mHvXXL5LMU6rtf4v1SmT6Q11KIt7YkmW71eJ
	 OC48ddkD5TeChg0wyVcL2ZMxCwwwcG3can1ob3uweZzHD9Uf+54p6Nh/vefTsPWlhVGBN
	 +FERdmF+7dxsgfmfYTUNnvSWLOfueonGQLTIqNitXzezSw2QaYGLrdAgWJ24JfjHTTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=/I2tBFmn4qxuEeVrhTEjUoZJl+yDT7rmJ9EfAnouz8Y=;
	b=xRuU+jIaHHrZcglex6VQP4f4eBzblzDXydZIPGE1I/Cmdweyt73TkiECy99pwipWb7Eh
	 OqUbRPGgd51liyy3wHI7k6Av6od1uc70fyFIMLowiRJ3CMxxZLSF9ZNY9BEa6kvaOotqX
	 dd1taaiqiqEZPb0GAiBVBpkJQtyTopGOcPSBXYkW6OooZq2SshU8OmOc1Zj/JTlNxnWjJ
	 HUpynj7YsfMGXPnVKpgDdOPS7xgVM/6ZDzWGt0RjZVcofWwnbxo05p2R0+g2FgAqQn8Az
	 P49LGweuiIvvgtHlgaPksncN+RIVdPbiw+B8l+r/yjkuEKQTFWVbU1rXQ67+0lR030A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TRI3NSrk;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF26606A330
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCF26606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TRI3NSrk
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso1671859a12.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415728; x=1795020528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/I2tBFmn4qxuEeVrhTEjUoZJl+yDT7rmJ9EfAnouz8Y=;
        b=TRI3NSrkINdVc3zxM6tekSbvMmtH8c6qQpCm27W4LwgT1WwwAAeZuN8uu8yF06GzvX
         wwgLzlOEYSRERsWPMSVjnULLj6PQuI1dqB75Eh/VQ8ceUCjQI+o33OT3iSV+lZvapvf0
         ffNxwIdkk1Pwv94mnRHhU2ABb7fP8Z9oqL120ZdUXi49R6Gt1DM1jiOoV4zzVZkEcEOw
         yApHelIyjS5cY3oHBh7jlAnzhK12Z+KI7vrqJW79Oy7mwI7e64PXR7B4Fl0y2LyDPafi
         YhasAziOQQOcRBn+4v+F8rD9PqiYgtpqUW2oXlw9BSNc4yfa4Jdm3QgbOX3fZWqi7R9/
         bTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415728; x=1795020528;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/I2tBFmn4qxuEeVrhTEjUoZJl+yDT7rmJ9EfAnouz8Y=;
        b=f+uX2FdjwlXXo+nqgP7ygmSwCpFd35IZxbIlqMoBZuHdU+/h7lkyG871BqcTxtkYCK
         RI8t+YITBnpkCQDmsl32Pydz001rYQP1QGoiIzXv+uaa7JNIldVoY83KagKPaSR3S8Gh
         R3lnCTgOL7hgGpy8Ja7duVB290vE7kKt2pB8RzrhUsSmQq4HPUHotveGJDX+PPVX0ZF/
         IRRVfHYIfdAXq044wJQzcmEZ0tVsdlQi/8J45KHLl7ylc9X7J7E6WnzI1fGzuQE3+H8j
         v+ZBBB+Vh6al9YvWk/L/Q3FFlyCI3Ttxu7DgcUi+8ZLnwrnbTboweJO2sxJGJmFJDXYO
         O/Ew==
X-Gm-Message-State: APuU4Z/XFUh7JjVaYukrKYrqU0xCL+zxr+UscFmvyW7gZqH0A1IpRlJm
	pK2QrA6rGWGpF0LZHlDqZ3u4eJxJ/mBBb2we0PUhhbZKiU5ESINyCBbV91t3Fw==
X-Gm-Gg: AYBFou2YPEtL2PEd1V/yhc1Eb/cl57ZLyOKpLLKm+ABuQ6ucIsaWI8resrU4fo68/B0
	541/8x49QnY0IYLd+kJQ7iMESo2ad1BsnSCYxawITxMT1MgwNSxWRdXlp/p1tVXTiitaDkSwGW7
	ien3RusYv5lkcVgp3xPOV4qPYAbYwk9KnEtphJA8aAa5qQW0MRGM37q+pifj1J/dlYU6WMb5ABN
	wIq9HGyJtdCjvv/nmnpNK4Clr33OJw5gFESMowtgcyzATC6NkGbSsdB5P9pARCcnTglurr9lF9R
	v+d5/qpvUTovDv1ZNFV1d1oWz4QlD5XOgOKg2f4SSwKgBVRP+dDriTDTyRDlWCLCCXmAqo+V1YH
	O3979VLcHrN8h5v1GKqushrvpoq0UsEcYGloEXWUkHs3eToXDHcCWpvxBI/lSmm0nGpQnisn+AQ
	Rr4qIusaObix11FvFNrjDaWagARK77fEtOJ7fRY8mCyuYA3G7qfx7zSEScymCzPFT/s/416Y963
	LCoITGrIuD/rdB8/bv6Om3ETlKlF8QvzFt5cgj9dOgk6jwFqZfAA68tTsHb8/pXNnEBUZ0eKsXU
	L3BCYFS5mRcJ6rSK1gs1w5oyiZwJZUKRcIzbWWr/QhRZNPTs/Z0ntPNVkQvRvb8QxFDLfyMLSwz
	Z6r/0MfrGoMyUA/TECHIFviG4+L3WjPGgk8Iz4wHmGygNLlZW6PxmbatAWq7oKzpBhrvwHO2HSK
	N6bgglqccVJd6aFXOLR2k=
X-Received: by 2002:a17:90b:4ac6:b0:3b0:9e2f:cfc3 with SMTP id 98e67ed59e1d1-3b182f26e60mr3041651a91.32.1794415727873;
        Wed, 11 Nov 2026 08:48:47 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c42a4csm80083a91.4.2026.11.11.08.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:48:47 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 28/29] bpf: Support sign-extended 32-bit linear scalar evolution
Date: Wed, 11 Nov 2026 16:45:51 +0000
Message-ID: <20261111164557.2659679-29-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
References: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A new ability: the recurrence (sext32 (linear rA IMM)), next to
(zext32 (linear ..)) and (spill32 (linear ..)). A loop over 'int i' as GCC
compiles it becomes a counted loop.

test_rhash_update_elements() of rhash.c has 'for (i = 0; i < 128; ++i)'.
GCC adds to an int in 32 bits and keeps the sign extension of the result:

	53: r3 = r7
	54: w3 += 1
	55: r7 = (s32)r3
	56: if w3 == 0x80 goto pc+27
	scev at header 57:
	  r7=(sext32 (zext32 (+ r7 1))) / ?

The backedge value of r7, before the '/', has no closed form. No iteration
count (header_count: how often the header is executed) is computed.
header_count = backedge-taken count + 1. The loop is walked: the verifier
unrolls the loop, one state per iteration; a counted loop is summarized,
one state for all iterations. A long loop that is walked ends with "more
than 1024 states that cannot be joined". It loaded when the verifier
explored each path. GCC compiles some 50 loops of the selftests that way,
most of them with i in a register.

The latch tests the 32-bit add, which is supported. What is missing is to
look through the extension, and the range of all 64 bits:

 - An extension and a partial spill truncate their operand. How it was
   extended or spilled before does not matter, below an add too:
   (sext32 (zext32 a)) is (sext32 a). Two rules of simplify() say so for
   all widths, in place of six.
 - The backedge value (sext32 (+ rA IMM)) is (sext32 (linear rA IMM)) at
   the header. Its range is the sign extension of the range of the low 32
   bits. A wrap is handled, not excluded: the range is all of s32 then.
 - iv_range, the range that the latch condition implies, is a range of the
   zero-extended low 32 bits. iv_bounds() ignores it if bit 31 can be set.
 - For i in a stack slot, zero or sign extended, little endian only:
   iterate_wakeupsources() of plain_c_test_wakeup_source.c has a 64-bit
   spill and a 32-bit fill of i. The half-slot with the upper 32 bits is
   dead, see the new bpf_half_slot_live_before(), and the states don't
   have it: 'fp-16=pppp1000'. A recurrence over 64 bits has no entry value
   there. (spill32 (linear (zext32 rA) IMM)) describes the low 32 bits
   only, so it holds too: use it.

With the patch:

	  r7=(sext32 (+ r7 1)) / (sext32 (linear r7 1))
	loop header at 57, header_count is [0..128]

The selftests as GCC builds them: no verdict changes, 2.6 % fewer insns.

	test_rhash_update_elements (rhash.c)                  6074 ->  105
	iterate_wakeupsources (plain_c_test_wakeup_source.c)  4402 ->  131
	nested_loops (loop1.c)                                4558 ->  702
	test1 (timer.c)                                       3973 ->  173

Precision that is lost. With 'size_t off', 'int n' and 'u32 sz' clang
-mcpu=v4 emits 'r1 = (s32)r0; r1 += r9; w3 = w1' for

	off += n;
	sz = off <= MAX ? HDR + off : HDR;

r3 was (zext32 (+ (sext32 r0) r9)). Now it is (zext32 (+ r0 r9)), which has
no base in common with r1: the test of off does not refine sz any more.

Three loops of these selftests keep a sign-extended i in a stack slot. Two
load before and after with the same insns. The third, in
dump_task_sleepable() of bpf_iter_tasks.c, is still rejected with the
message above: one of its two backedges has no linear latch, so the loop
has no iteration count.

Fixes: 5395aa9bbeb5 ("bpf: Verify programs as a fixpoint over the control flow graph")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/liveness.c        |  13 +++
 kernel/bpf/scev.c            | 154 +++++++++++++++++++----------------
 3 files changed, 96 insertions(+), 72 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e7bfb2bcd954..598763d128ab 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2049,6 +2049,7 @@ int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_
 const unsigned long *bpf_may_write_mask(struct bpf_verifier_env *env, u32 insn_idx);
 bool bpf_needs_fixed_stack_off(struct bpf_verifier_env *env, int insn_idx);
 bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 spi);
+bool bpf_half_slot_live_before(struct bpf_verifier_env *env, u32 insn_idx, u32 half_spi);
 int bpf_compute_live_registers(struct bpf_verifier_env *env);
 
 #define BPF_MAP_KEY_POISON	(1ULL << 63)
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index c52f0435193b..63d23d28f2a5 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -760,6 +760,19 @@ static void compute_may_write_masks(struct bpf_verifier_env *env)
 	}
 }
 
+/* live_stack_before of the insn at @insn_idx for one half-slot */
+bool bpf_half_slot_live_before(struct bpf_verifier_env *env, u32 insn_idx, u32 half_spi)
+{
+	struct func_instance *instance;
+	int bkt;
+
+	hash_for_each(env->liveness->func_instances, bkt, instance, hl_node)
+		if (insn_idx - instance->subprog_start < instance->insn_cnt &&
+		    is_live_before(instance, insn_idx, instance->depth, half_spi))
+			return true;
+	return false;
+}
+
 const unsigned long *bpf_may_write_mask(struct bpf_verifier_env *env, u32 insn_idx)
 {
 	return env->insn_aux_data[insn_idx].may_write_mask;
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index e08777e0fdaa..8438313e7b4a 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -511,6 +511,23 @@ static bool is_spill32(struct scev *scev, int id, u32 *left)
 	return is_spill(scev, id, &bits, left) && bits == 32;
 }
 
+/* (zextN x), (sextN x) or (spillN x) with N >= @bits: the low @bits bits are those of @left */
+static bool is_low_bits(struct scev *scev, int id, u32 bits, u32 *left)
+{
+	u32 op = scev->exprs[id].op;
+
+#ifdef __BIG_ENDIAN
+	/* see is_spill() */
+	if (op == SPILL8 || op == SPILL16 || op == SPILL32)
+		return false;
+#endif
+	/* nothing looks through a phi, see struct expr_def */
+	if (op_low_bits(op) < bits || scev->exprs[id].def.phi)
+		return false;
+	*left = scev->exprs[id].params[0];
+	return true;
+}
+
 static bool is_any(struct scev *scev, int id, u32 *left, u32 *right)
 {
 	return is_binop(scev, ANY, id, left, right);
@@ -792,6 +809,19 @@ static bool reg_alive_at(struct bpf_verifier_env *env, u32 reg, u32 insn_idx)
 	       : test_bit(reg - MAX_BPF_REG, aux[insn_idx].live_stack_before);
 }
 
+/* The first bytes of a stack slot are its high bits */
+static bool is_big_endian_slot(u32 reg)
+{
+	return IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) && reg >= MAX_BPF_REG;
+}
+
+/* Are the upper 32 bits of @reg live before the insn at @insn_idx? */
+static bool hi32_alive_at(struct bpf_verifier_env *env, u32 reg, u32 insn_idx)
+{
+	return reg < MAX_BPF_REG || is_big_endian_slot(reg) ||
+	       bpf_half_slot_live_before(env, insn_idx, (reg - MAX_BPF_REG) * 2);
+}
+
 static void print_env(struct bpf_verifier_env *env, struct env *e, u32 insn_idx)
 {
 	struct bpf_verifier_log *log = &env->log;
@@ -2157,12 +2187,6 @@ static bool match_linked_add(struct bpf_verifier_env *env, int h, u32 tested, u3
 	return true;
 }
 
-/* The first bytes of a stack slot are its high bits */
-static bool is_big_endian_slot(u32 reg)
-{
-	return IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) && reg >= MAX_BPF_REG;
-}
-
 /*
  * const_diff() for the SCEV register @reg, which has the expression @id_b. A fill from byte
  * *@fill_off of a slot reads these bits. On big endian the low bytes of a spill are the last ones,
@@ -2637,7 +2661,7 @@ static int transform_expr_once(struct scev *scev, u32 lvl, u32 root, void *priv,
 static int simplify(struct scev *scev, u32 id)
 {
 	int a, b, l, r, t, base, slope;
-	u32 bits, op = scev->exprs[id].op;
+	u32 op = scev->exprs[id].op, bits = op_low_bits(op);
 	s64 imm1, imm2;
 
 	/* (- x imm) -> (+ x -imm) */
@@ -2679,50 +2703,22 @@ static int simplify(struct scev *scev, u32 id)
 	if (is_zext32(scev, id, &l) && is_imm(scev, l, &imm1))
 		return imm_expr(scev, (u64)(u32)imm1);
 
-	/* The rules below look through the operand, not through a phi: see struct expr_def */
-	if (op_low_bits(op) && scev->exprs[scev->exprs[id].params[0]].def.phi)
-		return id;
-
-	/*
-	 * (zext32 (+ (zext32 $a) $b)) -> (zext32 (+ $a $b))
-	 * (zext32 (+ $a (zext32 $b))) -> (zext32 (+ $a $b))
-	 */
-	if ((is_zext32(scev, id, &t) && is_add(scev, t, &l, &b) && is_zext32(scev, l, &a) &&
-	     !scev->exprs[l].def.phi) ||
-	    (is_zext32(scev, id, &t) && is_add(scev, t, &a, &r) && is_zext32(scev, r, &b) &&
-	     !scev->exprs[r].def.phi)) {
-		t = expr2(scev, BPF_ADD, a, b);
-		t = expr1(scev, ZEXT32, t);
-		return t;
-	}
-
-	/* (zext32 (zext32 X)) -> (zext32 X) */
-	if (is_zext32(scev, id, &a) && is_zext32(scev, a, &b))
-		return a;
-
-	/*
-	 * '*(u32 *)(r10 - 8) = rX' stores the low half of rX:
-	 * (spill32 (zext32 $a)) -> (spill32 $a)
-	 * (spill32 (+ (zext32 $a) $b)) -> (spill32 (+ $a $b))
-	 */
-	if (is_spill32(scev, id, &t) && is_zext32(scev, t, &a))
-		return expr1(scev, SPILL32, a);
-	if (is_spill32(scev, id, &t) && is_add(scev, t, &l, &b) && is_zext32(scev, l, &a) &&
-	    !scev->exprs[l].def.phi)
-		return expr1(scev, SPILL32, expr2(scev, BPF_ADD, a, b));
-
 	/*
-	 * 'rX = *(u32 *)(r10 - 8)' fills what was spilled, a narrower fill the low bits of it:
-	 * (zext32 (spill32 $a)) -> (zext32 $a)
+	 * An extension and a partial spill depend on the low bits of their operand only: look
+	 * through an extension and a partial spill that is not narrower, below an add too:
+	 * (sext32 (zext32 $a)) -> (sext32 $a)
 	 * (sext8 (spill16 $a)) -> (sext8 $a)
-	 * (zext32 (+ (spill32 $a) $b)) -> (zext32 (+ $a $b))
+	 * (zext32 (+ (sext32 $a) $b)) -> (zext32 (+ $a $b))
+	 * (spill32 (+ $a (zext32 $b))) -> (spill32 (+ $a $b))
 	 */
-	if (op_low_bits(op) && is_spill(scev, scev->exprs[id].params[0], &bits, &a) &&
-	    op_low_bits(op) <= bits)
+	if (!bits)
+		return id;
+	t = scev->exprs[id].params[0];
+	if (is_low_bits(scev, t, bits, &a))
 		return expr1(scev, op, a);
-	if (is_zext32(scev, id, &t) && is_add(scev, t, &l, &b) && is_spill32(scev, l, &a) &&
-	    !scev->exprs[l].def.phi)
-		return expr1(scev, ZEXT32, expr2(scev, BPF_ADD, a, b));
+	if (is_add(scev, t, &l, &r) && !scev->exprs[t].def.phi &&
+	    (is_low_bits(scev, l, bits, &l) || is_low_bits(scev, r, bits, &r)))
+		return expr1(scev, op, expr2(scev, BPF_ADD, l, r));
 
 	return id;
 }
@@ -2745,6 +2741,7 @@ static int compute_header_scevs(struct bpf_verifier_env *env, int h)
 	int l, r, t, id, ra, rb, ra_expr;
 	bool zext32;
 	s64 imm;
+	u32 op;
 
 	/*
 	 * Note:
@@ -2779,30 +2776,24 @@ static int compute_header_scevs(struct bpf_verifier_env *env, int h)
 			header_env->reg2scev[ra] = id;
 			continue;
 		}
-		/* rA = (is_zext32 (+ rA IMM)) -> (is_zext32 (linear rA IMM)) */
-		if (is_zext32(scev, ra_expr, &t) &&
-		    is_add(scev, t, &l, &r) &&
-		    is_reg(scev, l, &rb) &&
-		    is_imm(scev, r, &imm) &&
-		    ra == rb) {
-			id = expr2(scev, LINEAR_SCEV, l, r);
-			id = expr1(scev, ZEXT32, id);
-			if (id < 0)
-				return id;
-			header_env->reg2scev[ra] = id;
-			continue;
-		}
 		/*
+		 * A 32-bit induction variable:
+		 * rA = (zext32 (+ rA IMM)) -> (zext32 (linear rA IMM))
+		 * rA = (sext32 (+ rA IMM)) -> (sext32 (linear rA IMM))
 		 * rA = (spill32 (+ rA IMM)) -> (spill32 (linear (zext32 rA) IMM))
-		 * The low half of the slot counts. Nothing is known about the other half.
+		 * The last SCEV leaves the upper 32 bits of the slot unknown, so it holds for the
+		 * first two as well. They get it if these bits are dead: the states have a
+		 * 32-bit spill then, see bpf_clean_verifier_state().
 		 */
-		if (is_spill32(scev, ra_expr, &t) &&
+		if (is_low_bits(scev, ra_expr, 32, &t) &&
 		    is_add(scev, t, &l, &r) &&
 		    is_reg(scev, l, &rb) &&
 		    is_imm(scev, r, &imm) &&
 		    ra == rb) {
-			id = expr2(scev, LINEAR_SCEV, expr1(scev, ZEXT32, l), r);
-			id = expr1(scev, SPILL32, id);
+			op = hi32_alive_at(env, ra, h) ? scev->exprs[ra_expr].op : SPILL32;
+			if (op == SPILL32)
+				l = expr1(scev, ZEXT32, l);
+			id = expr1(scev, op, expr2(scev, LINEAR_SCEV, l, r));
 			if (id < 0)
 				return id;
 			header_env->reg2scev[ra] = id;
@@ -4402,8 +4393,10 @@ struct linear_coefs {
 	u32 base_reg;
 	s64 slope;
 	bool zext32;
-	/* the low half of a stack slot */
+	/* with zext32: the low 32 bits of a stack slot */
 	bool spill32;
+	/* with zext32: the low 32 bits are sign extended */
+	bool sext32;
 };
 
 static bool is_simple_slope(struct scev *scev, u32 id, s64 *slope)
@@ -4419,8 +4412,12 @@ static bool is_simple_linear(struct scev *scev, u32 id, struct linear_coefs *out
 	u32 base, slope;
 
 	out->spill32 = false;
-	return is_linear_or_linear32(scev, id, &base, &slope, &out->zext32) &&
-	       is_reg(scev, base, &out->base_reg) &&
+	out->sext32 = is_unop(scev, SEXT32, id, &id);
+	if (!is_linear_or_linear32(scev, id, &base, &slope, &out->zext32) ||
+	    (out->sext32 && out->zext32))
+		return false;
+	out->zext32 |= out->sext32;
+	return is_reg(scev, base, &out->base_reg) &&
 	       is_simple_slope(scev, slope, &out->slope);
 }
 
@@ -4452,6 +4449,7 @@ static struct bpf_reg_state *spill32_counter(struct scev *scev, struct bpf_func_
 		return NULL;
 	out->zext32 = true;
 	out->spill32 = true;
+	out->sext32 = false;
 	return scev_reg_for_spill32(st, r);
 }
 
@@ -4460,6 +4458,11 @@ static struct cnum64 cnum64_zext32(struct cnum32 r32)
 	return cnum64_from_urange(cnum32_umin(r32), cnum32_umax(r32));
 }
 
+static struct cnum64 cnum64_sext32(struct cnum32 r32)
+{
+	return cnum64_from_srange(cnum32_smin(r32), cnum32_smax(r32));
+}
+
 /* Compute the range an induction variable in `reg` spans over the loop. */
 static void linear_bounds(struct bpf_reg_state *reg, u32 max_header_count,
 			  struct linear_coefs *coefs, struct bounds *out)
@@ -4489,12 +4492,14 @@ static void linear_bounds(struct bpf_reg_state *reg, u32 max_header_count,
 	r32 = CNUM32_UNBOUNDED;
 	if (coefs->zext32) {
 		r32 = cnum32_from_cnum64(r64);
-		r64 = cnum64_zext32(r32);
+		r64 = coefs->sext32 ? cnum64_sext32(r32) : cnum64_zext32(r32);
 		/*
 		 * 32-bit iteration overflow is equivalent to subtracting N * 2**32:
 		 * (base + slope * k) % slope ≠ (base + slope * k - N * 2**32) % slope.
 		 */
-		overflow |= cnum32_contains(r32, 0) && cnum32_contains(r32, U32_MAX);
+		overflow |= coefs->sext32 ?
+			    cnum32_contains(r32, S32_MAX) && cnum32_contains(r32, S32_MIN) :
+			    cnum32_contains(r32, 0) && cnum32_contains(r32, U32_MAX);
 		/*
 		 * The entry and zero-extended values must agree on how they define `base`,
 		 * otherwise `base + slope * k` would define different sets of points between
@@ -4547,10 +4552,14 @@ static bool is_iv_at_header(struct bpf_verifier_env *env, const struct bpf_func_
 	       const_diff_at_header(env, h, iv_reg, r, &delta) && !delta;
 }
 
-static void iv_bounds(struct bounds *bounds, struct cnum64 iv_range)
+static void iv_bounds(struct bounds *bounds, const struct linear_coefs *coefs,
+		      struct cnum64 iv_range)
 {
 	struct cnum64 r64 = cnum64_intersect(bounds->r64, iv_range);
 
+	/* The latch bounds the zero extension. With bit 31 set the sign extension differs. */
+	if (coefs->sext32 && cnum64_umax(iv_range) > S32_MAX)
+		return;
 	if (!cnum64_is_empty(r64))
 		bounds->r64 = r64;
 }
@@ -5091,7 +5100,7 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 			linear_bounds(reg, iters->max_header_count, &coefs, &bounds);
 			if (is_iv_at_header(env, entry_func, insn_idx, iters->iv_reg,
 					    coefs.base_reg))
-				iv_bounds(&bounds, iters->iv_range);
+				iv_bounds(&bounds, &coefs, iters->iv_range);
 			if (log->level & BPF_LOG_LEVEL2) {
 				bpf_log(log, "loop header at %d, widening ", insn_idx);
 				log_reg(env, r);
@@ -5137,6 +5146,7 @@ static bool is_moved_linear(struct scev *scev, u32 id, struct linear_coefs *out,
 	u32 base, slope, l, r;
 
 	out->spill32 = false;
+	out->sext32 = false;
 	return is_linear_or_linear32(scev, id, &base, &slope, &out->zext32) && !out->zext32 &&
 	       is_add(scev, base, &l, &r) && is_reg(scev, l, &out->base_reg) &&
 	       is_imm(scev, r, moved) && is_simple_slope(scev, slope, &out->slope);
@@ -5218,7 +5228,7 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 		 */
 		if (!behind &&
 		    is_iv_at_header(env, entry_st, insn_idx, entry->iv_reg, coefs.base_reg))
-			iv_bounds(&bounds, entry->iv_range);
+			iv_bounds(&bounds, &coefs, entry->iv_range);
 		if (moved) {
 			/* a sum that can wrap has another residue, see scalar_step_add() */
 			if (check_add_overflow(cnum64_smin(bounds.r64), moved, &sum) ||
-- 
2.55.0

