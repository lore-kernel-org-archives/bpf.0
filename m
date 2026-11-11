Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374194;
	b=1BzNET0mS0UgKSq0hSvJ+TOmT478+xJaiq5SGI9nMLEBftUJC0bwsVTmoP4O8M8osFH2
	 L7RPqlACUHOuv7b2mio3uZwAOf29gLm7oCIxiYhncmUBKRmtfpypoSxKst3JdKTn7Q1R8
	 yvDp7qiluPQYKZEJ/B6z7S4rFxp5ikSvdbTRIOqvIZo3Xv5/L1O8k4ukpd10c6R6+3G44
	 clk754TCSo9Q9IQh3Yp5fnB5qZYqNf4QztWmO++l67S5OgWm1MnWrrZ3PM1HJoo21YzEO
	 2dKwGXzpvNVgOr244EodWXOwGW2MTuNkQP8p+nluRnzWKedxuj6lmJT+2IjNk/fqZBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=tkWV+L4v/FKc4rxXGryqUB57sR6lPh/CvfnXkCJrOOc=;
	b=ofubqz0Z64OZdhPsosQYUrRgc2PqmsKX3Rl6dYer90AuFfSeiT5nd0h1R0LIa8EelfHi
	 WJNHtnzop+jEpGugYnTF24NfSoXefh+oscawruMTIE2OoyXoIV/vO8QITDUyWwQj9HvCc
	 Dif4qYUucHBVgbhTd2yLe5PcEvfAucipj5+x2fjTNsGRQtjDSA4X0xhnuGdxcuHD1v2hS
	 azxF2Ullqmfn6RLjKn34p4WKrhkuussj3+/k7sv/Elp8j+2DjTtfuja3O/21ec5PwDod+
	 ySXGyAyRY0q6TXTPGHxYlH688St4F0lkbHhtr1ed437bb0ePj3d4iWU3wW+tuGNT3kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pQNwQM4a;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F14606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F14606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pQNwQM4a
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b18717a193so35075a91.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374193; x=1794978993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tkWV+L4v/FKc4rxXGryqUB57sR6lPh/CvfnXkCJrOOc=;
        b=pQNwQM4awZYI2Hpv3EITvpvaq1Zd0kx/pPwWllJSPLPFDF5DtsGriZbRaEL6kjzmQn
         CIzWL7VmQP55nStizpzHxzjOPQR0ADZJFrZa08l/fpfb23EZ2ZJFXLsxaZeBSzAQZ/4/
         9aIxU2i+pb/pd50PIxb83LWjo4HDdqXDtgmP6lxY4iB2zCSAIJTjvUlVIC/+fDjFOn93
         AkucrYLsu5bIjUoOV+GkAnY1PlZ0Qg/TvanRT2/4OnewHYZlto8TxeUIq5sTYwWldvR3
         0q761H++C1r+cNo4wkJB/6JhO9D8lUnYNklFaDTU3WkGjXEyDDo9x3S5RwJVVLXKUReL
         p05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374193; x=1794978993;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tkWV+L4v/FKc4rxXGryqUB57sR6lPh/CvfnXkCJrOOc=;
        b=wjueSJl2mVUMrpfnlNV+qeW8vSI3JoJxk6ETAHOhc0Urecx8vQWFAl/FLtkxu+eJuR
         MNUgXFV8Ilc9kbXNPaF8NeTZzAQyyUTvWFCuYUcauaqf9MaEqBfxFjDHVSd2kKp250Co
         qVSqoyd9bmhRArWvG/2bd1rXyvRnInJubmNg2Igm5KyZFJ3PcDt7tIGkXgEHdxFgH+nH
         OrJIz30kxTajjtuJiwnkeDUTgdEvqjkZFmmW+kcqWRkmpZkFPmTrS5HGPxhP1dy4MmMn
         AQ4sYF00jo+7/JhcfSNvQjK0v+se22/kONmAPgFaRLSKlJExqFnmGThJcMMO/mc+Joa0
         Cu9A==
X-Gm-Message-State: APuU4Z/hniJ2vZAVW15GYCR/yjlZerrNA5WxuNmIM9uefmgpRnJtiP0d
	0sGusOXiI0cyjuPkN2Yc0WTLULd50t0lQgJoUxXnNAxyMSD8WRwUpC5sxQiu6w==
X-Gm-Gg: AYBFou18krJyLo1cbCvXOLglqyozLwC44g0FBhy7Iy99a5NnCq5Z8iq3oixgNy5MZp1
	T+p4Xn8dicoobzFTlS/YzG+Iou1h8G2x5otGxc0tsyuh+vyexmL45iVPpZa2pbniW3CwfETjQJ8
	EMemk8gxFFZ5qUM2BHi4XpCz1r20g5rdJ/ER1hBEz2LJDfCNek5taQQXHrtCcTPjY93mxeBf5BJ
	kHgagm09nplT+4XlucdXx9NjjjhdVnvs1N2ErNPkhu9OWnstnnJCwBY36ymaRU1tyPeL6QoGbZg
	6lixOfSOlZWvilICTpwFKcpt5/lqhPW/vRFo3XtbzgqCaZGcbBJeVR2kGRpIrJguNLFz3eYbaJM
	4hWVcMmHmbuUqsWiyI+HFSYT/eeEHQ0wdqAvHRcVoPzjQpyjwgzS3lsxEl5wo0VrFOftS59zG30
	mjJidwANW3RMXtQKvz5lt+ag9rftXoZwc7hsd15t7nYbgtI3QzWV0hFae+RjtBjXfuyiyIHEwcI
	ppgp22b++5tgPxfbqveMJLAZL/CUfYoWl/tVIO0FwsKS2hlhD73ePfP38ag8R9RcQ5d7mbLxEHL
	R/rKqh2Vg+mBos93K4RCMmf5TMT+jVm8nVxXVqgFJCSMgIAlEirqDeMxFV7CEeOyF7MZea1Ov6J
	qtHWjHRpeByolh0M4RjcDpDGZ4t40ZBbQ/kkj/9CDlm5AWR+3FyjbBy70PP8WN4W9fGmXhW2dLA
	==
X-Received: by 2002:a17:90b:2649:b0:3ac:7749:2f0 with SMTP id 98e67ed59e1d1-3b182f2381fmr1374346a91.44.1794374192819;
        Tue, 10 Nov 2026 21:16:32 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17dba5ed0sm2711706a91.17.2026.11.10.21.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:16:32 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 28/29] bpf: Support sign-extended 32-bit linear scalar evolution
Date: Wed, 11 Nov 2026 05:13:39 +0000
Message-ID: <20261111051341.2800252-29-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
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
index b46eb37234a3..e36181a00858 100644
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
@@ -4538,10 +4543,14 @@ static bool is_iv_at_header(struct bpf_verifier_env *env, int h, int iv_reg, u32
 	return r == iv_reg || (const_diff_at_header(env, h, iv_reg, r, &delta) && !delta);
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
@@ -5081,7 +5090,7 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 				return err;
 			linear_bounds(reg, iters->max_header_count, &coefs, &bounds);
 			if (is_iv_at_header(env, insn_idx, iters->iv_reg, coefs.base_reg))
-				iv_bounds(&bounds, iters->iv_range);
+				iv_bounds(&bounds, &coefs, iters->iv_range);
 			if (log->level & BPF_LOG_LEVEL2) {
 				bpf_log(log, "loop header at %d, widening ", insn_idx);
 				log_reg(env, r);
@@ -5127,6 +5136,7 @@ static bool is_moved_linear(struct scev *scev, u32 id, struct linear_coefs *out,
 	u32 base, slope, l, r;
 
 	out->spill32 = false;
+	out->sext32 = false;
 	return is_linear_or_linear32(scev, id, &base, &slope, &out->zext32) && !out->zext32 &&
 	       is_add(scev, base, &l, &r) && is_reg(scev, l, &out->base_reg) &&
 	       is_imm(scev, r, moved) && is_simple_slope(scev, slope, &out->slope);
@@ -5207,7 +5217,7 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 		 * of its header value. @reg went through that insn and has what holds of the range.
 		 */
 		if (!behind && is_iv_at_header(env, insn_idx, entry->iv_reg, coefs.base_reg))
-			iv_bounds(&bounds, entry->iv_range);
+			iv_bounds(&bounds, &coefs, entry->iv_range);
 		if (moved) {
 			/* a sum that can wrap has another residue, see scalar_step_add() */
 			if (check_add_overflow(cnum64_smin(bounds.r64), moved, &sum) ||
-- 
2.55.0

