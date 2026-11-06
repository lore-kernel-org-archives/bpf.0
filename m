Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937297;
	b=JjINy5itkphjyNuCr8errr1579Xnyd/l36qJ9KcHpucB0oC+P7jVcEnH9GdwJD5Vi4QY
	 kLFxq2sktHryjXDddFgm8BWMlxxc1Qoj7jbzS76Mo0dErDVaLpB5KU3z7sK7EpitrDLm8
	 5ShGj772qfyW6WA+2g8xQEg252HHphh17pwrnwf+h9dBMST+xlhPhjzJquIx5Z55Egk/I
	 zIdak5kbcPQan94oec9bxREKoDxOsnWOqzIlggfU5M7lAejs6DpMi0zaeWQrzODty1um9
	 TnCGRDbLUNPyL3GjA2vZxY4hGuQluhs17oA+SLSFy1JfifWVLTgd/pMGhGsbK16ECBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lu9v2mqy40VewgJ00oNK5Ybvszc485atzwWnVh+Pqx8=;
	b=QbwTtUxzAjMPFNkDKqFOlrZuO+zbW5Rv/CdU/0V/1ruUe1Q5F0O23iHpjOUBfiO20m3m
	 4LCbCUDnmPQ8gv2wNASoF7Hnij5N1PS5hpzXPESvn4+2aF6UpL6/10iViL0npPCdvb/aI
	 omxci9R1Sv+kbVPX8KqdDP0jMZ57nNpNrwQryRY9fTJaWAzZhyKDuWMST3LiXTpnigS6p
	 WOIvHVCa8lYA5zlDlETVi+WoxpW2VJeAbOyMFN1/IDtcs/yWb41ubyAocQ1fnQnHHDxcT
	 gmqqUIPAuGcEXCvYa9bbDCRRZ00WR/H1gfx1qbAA0pSgWjf442C/+FiLRzpBAyAcbsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R9gOsDkv;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E12B606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E12B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R9gOsDkv
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e95bd1c14cso1800185ad.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937297; x=1794542097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lu9v2mqy40VewgJ00oNK5Ybvszc485atzwWnVh+Pqx8=;
        b=R9gOsDkvvOat1KrohtR7pwOfrVNsewF9LZr3cAJwcVSeUyfci/TsPdQhxeLkBqCvjq
         /mU65ak5TA0jFISbSh0P4BNPhpzk1gGsh8ZIwrabczbx5ChWWkVtCybXC/Ee7AViNW6S
         c0HV1jf6QLnuMziiZUj+R6kDNNT3zmGKC4/nF7uBQCxHwr/bldR1kZiktL007EGk+lcx
         ddLjlnoTvLPRr9rAFfVnTVtlQ2FYyHpfXaHs0tUeqUaF43fXrCgmbV61kfl7mW6E5I3I
         /rF6itlDIehsNj69p41doKuunL4q16lOx5Td8dKPS240b51e+CJ1Un1Qaxg5VIwLxkvR
         1ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937297; x=1794542097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lu9v2mqy40VewgJ00oNK5Ybvszc485atzwWnVh+Pqx8=;
        b=LJzYRnCrbVCD/jQ7yoQtKdHslljhhR+eAaxxtL1kEfrWhIRlCP/Ft2okhoKmC1upX3
         6rqZWZ4NqjYY+aQaozLk+TK1KIeJH9IJXR3TWLcfjshICKIXooOpTE6r67MVkZZcQFZP
         vIfhMzUkOLNl5jJhZqNzBQnvZyXgVN+GADQyw9L/nnN9Ga2dJsKXvVjVLlrifctR/nQB
         y3HeOE5I6lKKzT9vAzuuD8BbVBl1imNxcpU1+ylR9Bk+nTDqya+lzwkbSsVdG9pAkG1B
         J1J+dWFjDuot5fbl4Ef5cjFpiPIjo/pTe/QARQij6Oc1wlTO3eN+WA0/MDV+IQytBLMU
         vaGQ==
X-Gm-Message-State: APuU4Z+cLcc5AEub6KCsWV8jm6w46UiHIGPBta9Osgd/oHBAeC4YmY2R
	8zxF8mKbzsEUogV84l4sSfsZe1+tpPIMfaENLglY14x/8vBdafPSA4PwJJdVMA==
X-Gm-Gg: AYBFou3kdyv2BLMpgT93XXqCSfMq9WcVz5cIb9zWZGlntqp7ClaV23NGmoFoNNd4lDO
	TJpwkpg32Rd2QM0yGTyjrhWEqZMfaX2os0IG2PDGfgqbtm7taI8iiLlkTvp3dUOMYhSrx3YInld
	dWuGvq4fFLpB/2V27G1SneD6ca6qkH7rFRawIRmndwc5F+IZcSpregxS5D32hp3nNQTPesDXikd
	twJ1YUkDKLQLxTYKddOZKPUCmusgbwBO1NZ6jGg/8ml5EC6bChaVJ29i8g4SNB63vFZZhyMM1VX
	iA7B0sJWziT5JtA8RdsYN7J0HUX73ZvF8IERrgyixiEM5aKNpUTPAGrTk561SefAU5//KFxNZ07
	f/iX21m7EnTYjZF00XN2ksRtMf9W1/O7ZWfXTFrS8nooOMc454MMRWf73oOKmyaDEuM5ESdrcvJ
	v5hrDCjdNYhXZtfWr+14y1+5zl8hTJvfNbTUaIXSja6NHhXdcaZ20povK+wzBydi1KjII0nHvSr
	jv+3S2j6RaXfiy30we25q8jXsEwT+d2SLbcKz5OLMhMPWZ0mOTPegAffg3g/qXKIcx7SQ6djzpS
	yRJ1OTZHgbHtD1VZls9pAprYxLdcMVyQuht2gA2yK8dsKpz+R34EgjVnuY6YZy1r9wVRDWk5vQ0
	JcJiogMD6HULXSrzCwJm8OKUseDqHrbIlgbOO/0pOUSbIIfzxVN7JFLuGe4ahVXkAVFPx7FDroQ
	==
X-Received: by 2002:a17:902:f681:b0:2ea:de20:51cd with SMTP id d9443c01a7336-2ed40abb306mr22081625ad.9.1793937296274;
        Thu, 05 Nov 2026 19:54:56 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d837e6sm1198635ad.58.2026.11.05.19.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:54:55 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 38/45] bpf: Find where the jumps of a loop stop a number
Date: Fri,  6 Nov 2026 03:51:02 +0000
Message-ID: <20261106035111.3315285-39-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

  bpf_for(i, 0, 100)
          bpf_for(j, 0, 100)
                  if (n < 8)
                          v->a[n++] = j;
  return v->a[n];

  while (off < 8000) { l = v->big[off]; if (!l) break; off += l; }

n and off grow by what the data say, so there is no formula for them.
Widening moves the bound that grows to a fixed stop: 0, S32_MAX, U32_MAX or
S64_MAX. n is [0, S32_MAX] at the loop head. The jump limits it in the
loop, nothing limits it after the loop. clang tests off at the end of the
loop, so nothing limits it at the load. Both loaded before states were
joined:

  R6 unbounded memory access, make sure to bounds check any such access

The jumps of the loop tell where the bound stops. Examine one iteration
before the main pass, from the head to the back edges, and write what is in
a register or a stack slot as 'root + constant'. A root is the value at the
head, or a value that the iteration makes. A jump that compares 'root + c'
with a constant limits the root on each edge that stays in the loop. What
returns to the head is 'root + c' again, and the limits give a stop: 8 and
7999 here. bpf_reg_widen_range() takes the nearest of all stops.

A stop is a guess. What returns to the head next is compared with the
widened state as always. A wrong stop costs one more pass through the loop.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  24 +-
 kernel/bpf/fixups.c          |   1 +
 kernel/bpf/flow.c            | 438 ++++++++++++++++++++++++++++++++++-
 kernel/bpf/join.c            |  25 +-
 kernel/bpf/verifier.c        |  36 ++-
 5 files changed, 504 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index de2c5aa1567d..af10957af5ad 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -721,6 +721,23 @@ struct bpf_loop_exit {
 	int to; /* instruction outside the loop */
 };
 
+/* The places that the table of a loop knows: registers, then stack slots, fp-8 first */
+#define BPF_LOOP_SLOT	64
+#define BPF_LOOP_PLACES	128
+
+/*
+ * Where the bounds of the number in @place may come to rest at the head of a loop: the lowest and
+ * the highest upper bound, the highest and the lowest lower bound that the jumps of the loop
+ * let come back to the head, see flow_compute_rungs().
+ */
+struct bpf_loop_rungs {
+	s64 max[2];
+	s64 min[2];
+	bool has_max;
+	bool has_min;
+	u8 place;
+};
+
 struct bpf_loop {
 	struct bpf_backedge backedges[MAX_BACKEDGES];
 	/* edges exiting from this loop, includes edges from nested loops */
@@ -759,6 +776,10 @@ struct bpf_loop {
 	/* what gets a constant added in every iteration, in 64 and in 32 bits */
 	unsigned long linear_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
 	unsigned long linear32_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
+	/* the places that insns of the loop write, as far as the insns tell */
+	unsigned long writes[BITS_TO_LONGS(BPF_LOOP_PLACES)];
+	struct bpf_loop_rungs *rungs;
+	u32 rungs_cnt;
 };
 
 struct bpf_insn_aux_data {
@@ -2012,7 +2033,8 @@ int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_reg_state *b);
 void bpf_reg_union_range(struct bpf_reg_state *acc, const struct bpf_reg_state *src);
 void bpf_reg_forget_range(struct bpf_reg_state *reg);
-void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *old, int linear);
+void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *old,
+			 const struct bpf_loop_rungs *rungs, int linear);
 int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
 		  const struct bpf_reg_state *src);
 
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 3413c7addca8..108b2aa924a9 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -928,6 +928,7 @@ void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
 	for (i = start; i < end; i++) {
 		if (aux_data[i].loop) {
 			kvfree(aux_data[i].loop->exits);
+			kvfree(aux_data[i].loop->rungs);
 			kvfree(aux_data[i].loop);
 			aux_data[i].loop = NULL;
 		}
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 24e7f99277eb..db2ea93d25b6 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -1192,6 +1192,439 @@ bool bpf_flow_is_needed(struct bpf_verifier_env *env, int idx, u32 r)
 	return false;
 }
 
+/*
+ * A number that grows from one iteration of a loop to the next is not followed step by step. The
+ * bound that moved is put where it may come to rest, see bpf_reg_widen_range(). The jumps of
+ * the loop tell where that is:
+ *	do { a[i] = 0; i += 3; } while (i < 30);		29 at most comes back to the head
+ *	while (i < 30) { a[i] = 0; i += 3; }			32
+ *	loop { if (...) { if (n >= 64) break; a[n++] = x; } }	64
+ *
+ * One iteration is looked at, from the head to the jumps back. What a register or a stack slot
+ * holds is written as root + constant. A root is what a place held at the head, or what was made
+ * in a place since. A copy, an extension, a spill and a fill keep the root. += and -= of a constant
+ * change the constant. Everything else makes a new root. Where paths meet two constants become
+ * a range of them, and two roots a new one.
+ * A jump that compares root + c with a constant bounds the root on each of its edges that stays in
+ * the loop. What comes back to the head in a place is root + c again: that, with the bounds of
+ * the root, is where the place may come to rest.
+ *
+ * It's a guess. The state that comes back to the head is compared with it like with any other
+ * state. So it's fine to take a 32-bit add for an add, to miss a store through a pointer, to mix up
+ * two numbers that are made in one place, and to know nothing of the edges that the verifier adds.
+ */
+struct flow_sym {
+	s32 lo, hi;
+	u8 root;
+};
+
+#define FLOW_NO_PLACE	U8_MAX
+/* How many of them the look at one loop may take. A loop that needs more has no table. */
+#define BPF_FLOW_MAX_SYMS	(4 << 20)
+
+static_assert(FLOW_SLOT == BPF_LOOP_SLOT && FLOW_PLACES == BPF_LOOP_PLACES);
+
+/* @insn makes the place *@to a copy of the place *@from, extended or cut to its low bits */
+static bool flow_copies_place(const struct bpf_insn *insn, u8 *to, u8 *from)
+{
+	u8 class = BPF_CLASS(insn->code);
+	int slot;
+
+	if (class == BPF_ALU || class == BPF_ALU64) {
+		*to = insn->dst_reg;
+		*from = insn->src_reg;
+		return flow_is_copy(insn) && *to < BPF_REG_FP && *from < BPF_REG_FP;
+	}
+	if (class != BPF_LDX && class != BPF_STX)
+		return false;
+	slot = flow_fp_slot(insn, class == BPF_LDX ? insn->src_reg : insn->dst_reg);
+	if (slot < 0)
+		return false;
+	*to = class == BPF_LDX ? insn->dst_reg : FLOW_SLOT + slot;
+	*from = class == BPF_LDX ? FLOW_SLOT + slot : insn->src_reg;
+	return *to != BPF_REG_FP && *from != BPF_REG_FP;
+}
+
+/* An ALU insn that leaves a small number as it is: an extension, or half of one */
+static bool flow_extends(const struct bpf_insn *insn)
+{
+	if (BPF_SRC(insn->code) != BPF_K)
+		return false;
+	if (flow_is_shift(insn))
+		return insn->imm == 32 || insn->imm == 48 || insn->imm == 56;
+	return BPF_OP(insn->code) == BPF_AND &&
+	       (insn->imm == 0xff || insn->imm == 0xffff || insn->imm == -1);
+}
+
+static void flow_written_places(const struct bpf_insn *insn, unsigned long *places)
+{
+	u8 class = BPF_CLASS(insn->code);
+	int p;
+
+	bitmap_zero(places, FLOW_PLACES);
+	if (class == BPF_ALU || class == BPF_ALU64 || class == BPF_LDX || bpf_is_ldimm64(insn)) {
+		__set_bit(insn->dst_reg, places);
+	} else if (class == BPF_LD || (class == BPF_JMP && BPF_OP(insn->code) == BPF_CALL)) {
+		bitmap_set(places, BPF_REG_0, BPF_REG_5 + 1);
+	} else if (class == BPF_ST || class == BPF_STX) {
+		p = bpf_atomic_load_reg(insn);
+		if (p >= 0)
+			__set_bit(p, places);
+		p = flow_mem_place(insn, insn->dst_reg);
+		if (p >= FLOW_SLOT)
+			__set_bit(p, places);
+	}
+}
+
+/*
+ * The jump at @idx compares the register *@reg with a constant: it's taken if "reg op k".
+ * The constant has 32 bits, so does what is added to it below: nothing wraps.
+ */
+static bool flow_jump_cmp(struct bpf_verifier_env *env, int idx, u8 *reg, u8 *op, s64 *k)
+{
+	const struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
+	const struct bpf_insn *insn = &env->prog->insnsi[idx];
+	u8 class = BPF_CLASS(insn->code);
+
+	*op = BPF_OP(insn->code);
+	if ((class != BPF_JMP && class != BPF_JMP32) || *op == BPF_JA || *op == BPF_CALL ||
+	    *op == BPF_EXIT || *op == BPF_JCOND || *op == BPF_JSET)
+		return false;
+	*reg = insn->dst_reg;
+	if (BPF_SRC(insn->code) == BPF_K) {
+		*k = insn->imm;
+	} else if (aux->const_reg_mask & BIT(insn->src_reg)) {
+		*k = aux->const_reg_vals[insn->src_reg];
+	} else if (aux->const_reg_mask & BIT(insn->dst_reg)) {
+		*k = aux->const_reg_vals[insn->dst_reg];
+		*reg = insn->src_reg;
+		*op = bpf_flip_opcode(*op);
+	} else {
+		return false;
+	}
+	if (class == BPF_JMP32)
+		*k = *op == BPF_JSGT || *op == BPF_JSGE || *op == BPF_JSLT || *op == BPF_JSLE ?
+		     (s64)(s32)*k : (s64)(u32)*k;
+	return *reg < BPF_REG_FP;
+}
+
+static void flow_add_max(struct bpf_loop_rungs *r, s64 max)
+{
+	r->max[0] = r->has_max ? min(r->max[0], max) : max;
+	r->max[1] = r->has_max ? max(r->max[1], max) : max;
+	r->has_max = true;
+}
+
+static void flow_add_min(struct bpf_loop_rungs *r, s64 min)
+{
+	r->min[0] = r->has_min ? max(r->min[0], min) : min;
+	r->min[1] = r->has_min ? min(r->min[1], min) : min;
+	r->has_min = true;
+}
+
+/* "x op k" holds. What does that say about the root of @x? */
+static void flow_note_cmp(struct bpf_loop_rungs *root, const struct flow_sym *x, u8 op, s64 k)
+{
+	bool has_max = true, has_min = true;
+	s64 max = k, min = k;
+
+	switch (op) {
+	case BPF_JEQ:
+		break;
+	case BPF_JNE:
+		/* it cuts off the end of a range */
+		max = k - 1;
+		min = k + 1;
+		break;
+	case BPF_JLT:
+		max = k - 1;
+		fallthrough;
+	case BPF_JLE:
+		/* the ranges are signed: nothing is said by a constant above S64_MAX */
+		min = 0;
+		has_max = max >= 0;
+		has_min = max >= 0;
+		break;
+	case BPF_JGT:
+		min = k + 1;
+		fallthrough;
+	case BPF_JGE:
+		has_max = false;
+		has_min = k >= 0;
+		break;
+	case BPF_JSLT:
+		max = k - 1;
+		fallthrough;
+	case BPF_JSLE:
+		has_min = false;
+		break;
+	case BPF_JSGT:
+		min = k + 1;
+		fallthrough;
+	case BPF_JSGE:
+		has_max = false;
+		break;
+	default:
+		return;
+	}
+	if (has_max)
+		flow_add_max(root, max - x->lo);
+	if (has_min)
+		flow_add_min(root, min - x->hi);
+}
+
+/* @cur is what the @n places hold in front of @insn. Make it what they hold behind it. */
+static void flow_sym_step(const struct bpf_insn *insn, struct flow_sym *cur, const u8 *idx, u32 n)
+{
+	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code), to, from;
+	DECLARE_BITMAP(written, FLOW_PLACES);
+	struct flow_sym *x;
+	s64 c = insn->imm;
+	int p;
+
+	/* both are among the places or none is, see flow_compute_loop_rungs() */
+	if (flow_copies_place(insn, &to, &from)) {
+		if (idx[to] != FLOW_NO_PLACE)
+			cur[idx[to]] = cur[idx[from]];
+		return;
+	}
+	if ((class == BPF_ALU || class == BPF_ALU64) && idx[insn->dst_reg] != FLOW_NO_PLACE) {
+		x = &cur[idx[insn->dst_reg]];
+		if (flow_extends(insn))
+			return;
+		if (op == BPF_SUB)
+			c = -c;
+		if ((op == BPF_ADD || op == BPF_SUB) && BPF_SRC(insn->code) == BPF_K &&
+		    x->lo + c >= S32_MIN && x->hi + c <= S32_MAX) {
+			x->lo += c;
+			x->hi += c;
+			return;
+		}
+	}
+	flow_written_places(insn, written);
+	for_each_set_bit(p, written, FLOW_PLACES)
+		if (idx[p] != FLOW_NO_PLACE)
+			cur[idx[p]] = (struct flow_sym){ .root = n + idx[p] };
+}
+
+/* One more path leads to where @to holds */
+static void flow_sym_meet(struct flow_sym *to, const struct flow_sym *from, u32 n)
+{
+	u32 j;
+
+	if (to[0].root == FLOW_NO_PLACE) {
+		memcpy(to, from, n * sizeof(*to));
+		return;
+	}
+	for (j = 0; j < n; j++) {
+		if (to[j].root != from[j].root) {
+			to[j] = (struct flow_sym){ .root = n + j };
+			continue;
+		}
+		to[j].lo = min(to[j].lo, from[j].lo);
+		to[j].hi = max(to[j].hi, from[j].hi);
+	}
+}
+
+static u8 flow_place_set(u8 *set, u8 p)
+{
+	while (set[p] != p) {
+		set[p] = set[set[p]];
+		p = set[p];
+	}
+	return p;
+}
+
+/* @at: the insns in the order. The insns of a loop are next to each other, the head first. */
+static int flow_compute_loop_rungs(struct bpf_verifier_env *env, const u32 *at, u32 total, int h)
+{
+	const struct bpf_insn *insns = env->prog->insnsi, *insn;
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_loop_rungs *roots = NULL, *rungs, *r;
+	u8 set[FLOW_PLACES], idx[FLOW_PLACES], to, from, reg, op;
+	u32 first = env->flow->pos[h], nr, n = 0, back_cnt = 0, cnt = 0, j, k;
+	DECLARE_BITMAP(tested, FLOW_PLACES) = {};
+	DECLARE_BITMAP(moves, FLOW_PLACES) = {};
+	struct flow_sym *syms, *cur, *back, *x;
+	struct bpf_loop *loop = aux[h].loop;
+	const u32 *pos = env->flow->pos;
+	struct bpf_iarray *succ;
+	int i, p, t, err = -ENOMEM;
+	bool carry = false;
+	s64 c;
+
+	nr = min(loop->nr_insns, total - first);
+
+	/*
+	 * The places to look at: what a jump compares with a constant, and what that is copied
+	 * from and to. One of them has to change in the loop.
+	 */
+	for (p = 0; p < FLOW_PLACES; p++)
+		set[p] = p;
+	for (k = 0; k < nr; k++) {
+		i = at[first + k];
+		if (flow_copies_place(&insns[i], &to, &from))
+			set[flow_place_set(set, to)] = flow_place_set(set, from);
+		else if (flow_jump_cmp(env, i, &reg, &op, &c))
+			__set_bit(reg, tested);
+	}
+	for_each_set_bit(p, tested, FLOW_PLACES)
+		__set_bit(flow_place_set(set, p), moves);
+	bitmap_copy(tested, moves, FLOW_PLACES);
+	bitmap_zero(moves, FLOW_PLACES);
+	for_each_set_bit(p, loop->writes, FLOW_PLACES)
+		__set_bit(flow_place_set(set, p), moves);
+	for (p = 0; p < FLOW_PLACES; p++) {
+		i = flow_place_set(set, p);
+		idx[p] = test_bit(i, tested) && test_bit(i, moves) ? n++ : FLOW_NO_PLACE;
+	}
+	if (!n || (u64)n * nr > BPF_FLOW_MAX_SYMS)
+		return 0;
+
+	/* for each insn, for the current insn, for each jump back */
+	syms = kvmalloc_array((size_t)nr + 1 + loop->backedges_cnt, n * sizeof(*syms),
+			      GFP_KERNEL_ACCOUNT);
+	/* for each root, and the result for each place */
+	roots = kvcalloc(3 * n, sizeof(*roots), GFP_KERNEL_ACCOUNT);
+	if (!syms || !roots)
+		goto out;
+	memset(syms, 0xff, (size_t)nr * n * sizeof(*syms));
+	cur = syms + (size_t)nr * n;
+	back = cur + n;
+	rungs = roots + 2 * n;
+	for (j = 0; j < n; j++)
+		syms[j] = (struct flow_sym){ .root = j };
+
+	for (k = 0; k < nr; k++) {
+		i = at[first + k];
+		insn = &insns[i];
+		if (!carry)
+			memcpy(cur, syms + (size_t)k * n, n * sizeof(*cur));
+		/* nothing but a jump back leads here */
+		for (j = 0; !carry && j < n; j++)
+			if (cur[j].root == FLOW_NO_PLACE)
+				cur[j] = (struct flow_sym){ .root = n + j };
+		/* a loop in the loop: nobody knows how many times it does what it does */
+		if (k && aux[i].loop)
+			for_each_set_bit(p, aux[i].loop->writes, FLOW_PLACES)
+				if (idx[p] != FLOW_NO_PLACE)
+					cur[idx[p]] = (struct flow_sym){ .root = n + idx[p] };
+
+		if (flow_jump_cmp(env, i, &reg, &op, &c) && idx[reg] != FLOW_NO_PLACE) {
+			x = &cur[idx[reg]];
+			if (pos[i + insn->off + 1] - first < nr)
+				flow_note_cmp(&roots[x->root], x, op, c);
+			if (pos[i + 1] - first < nr)
+				flow_note_cmp(&roots[x->root], x, bpf_rev_opcode(op), c);
+		}
+		flow_sym_step(insn, cur, idx, n);
+
+		succ = bpf_insn_successors(env, i);
+		carry = succ->cnt == 1 && !test_bit(succ->items[0], env->flow->point) &&
+			pos[succ->items[0]] == first + k + 1;
+		if (carry)
+			continue;
+		iarray_for_each(t, succ) {
+			if (t == h && back_cnt < loop->backedges_cnt)
+				memcpy(back + (size_t)back_cnt++ * n, cur, n * sizeof(*cur));
+			else if (pos[t] > pos[i] && pos[t] - first < nr)
+				flow_sym_meet(syms + (size_t)(pos[t] - first) * n, cur, n);
+			if (t == h || pos[t] > pos[i] || pos[t] - first >= nr)
+				continue;
+			/* jump back of an inner loop: what it adds moves the bounds of the root */
+			for (j = 0; j < n; j++) {
+				r = &roots[cur[j].root];
+				if (r->has_max && cur[j].hi > 0)
+					flow_add_max(r, r->max[1] + cur[j].hi);
+				if (r->has_min && cur[j].lo < 0)
+					flow_add_min(r, r->min[1] + cur[j].lo);
+			}
+		}
+	}
+
+	for (k = 0; k < back_cnt; k++) {
+		for (j = 0; j < n; j++) {
+			x = &back[(size_t)k * n + j];
+			r = &roots[x->root];
+			/* it is what it was */
+			if (x->root == j && !x->lo && !x->hi)
+				continue;
+			if (r->has_max) {
+				flow_add_max(&rungs[j], r->max[0] + x->hi);
+				flow_add_max(&rungs[j], r->max[1] + x->hi);
+			}
+			if (r->has_min) {
+				flow_add_min(&rungs[j], r->min[0] + x->lo);
+				flow_add_min(&rungs[j], r->min[1] + x->lo);
+			}
+		}
+	}
+	for (j = 0; j < n; j++)
+		cnt += rungs[j].has_max || rungs[j].has_min;
+	err = 0;
+	if (!cnt)
+		goto out;
+	loop->rungs = kvcalloc(cnt, sizeof(*loop->rungs), GFP_KERNEL_ACCOUNT);
+	if (!loop->rungs) {
+		err = -ENOMEM;
+		goto out;
+	}
+	for (p = 0; p < FLOW_PLACES; p++) {
+		if (idx[p] == FLOW_NO_PLACE || (!rungs[idx[p]].has_max && !rungs[idx[p]].has_min))
+			continue;
+		loop->rungs[loop->rungs_cnt] = rungs[idx[p]];
+		loop->rungs[loop->rungs_cnt++].place = p;
+	}
+out:
+	kvfree(syms);
+	kvfree(roots);
+	return err;
+}
+
+static int flow_compute_rungs(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	u32 total = env->cfg.cur_postorder, depth, k, *at;
+	DECLARE_BITMAP(written, FLOW_PLACES);
+	struct bpf_loop *loop;
+	int h, i, err = 0;
+
+	for (h = 0; h < env->prog->len && !aux[h].loop; h++)
+		;
+	if (h == env->prog->len)
+		return 0;
+	at = kvmalloc_array(total, sizeof(*at), GFP_KERNEL_ACCOUNT);
+	if (!at)
+		return -ENOMEM;
+	for (k = 0; k < total; k++) {
+		i = env->cfg.insn_postorder[k];
+		at[env->flow->pos[i]] = i;
+		flow_written_places(&env->prog->insnsi[i], written);
+		for (h = bpf_loop_at_index(env, i); h >= 0; h = aux[h].loop_header)
+			bitmap_or(aux[h].loop->writes, aux[h].loop->writes, written, FLOW_PLACES);
+	}
+	for (h = 0; h < env->prog->len && !err; h++) {
+		loop = aux[h].loop;
+		/* the order says little about a loop with more than one entry */
+		if (!loop || loop->irreducible || loop->backedges_overflow)
+			continue;
+		/* the main pass doesn't get that deep */
+		depth = 0;
+		for (i = aux[h].loop_header; i >= 0; i = aux[i].loop_header)
+			depth++;
+		if (depth >= LOOP_STACK_SIZE)
+			continue;
+		if (signal_pending(current)) {
+			err = -EAGAIN;
+			break;
+		}
+		cond_resched();
+		err = flow_compute_loop_rungs(env, at, total, h);
+	}
+	kvfree(at);
+	return err;
+}
+
 int bpf_flow_prepare(struct bpf_verifier_env *env)
 {
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
@@ -1279,7 +1712,10 @@ int bpf_flow_prepare(struct bpf_verifier_env *env)
 		return err;
 	for (i = 0; !err && i < kinds; i++)
 		err = flow_compute_need_const(env, &flow->need[i], i);
-	return err;
+	err = err ?: flow_compute_rungs(env);
+	if (err)
+		return err;
+	return 0;
 }
 
 static void flow_free_state(struct bpf_verifier_env *env, struct flow_state *s)
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index 88fe3d32a6de..cc4494aef187 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -39,7 +39,7 @@ struct bpf_join_state {
 	bool widen;
 	/* the states came around this loop in the frame that is joined, NULL if not */
 	const struct bpf_loop *loop;
-	/* the register or stack slot that is joined, as scalar evolution numbers it, or -1 */
+	/* the register or stack slot that is joined, as in struct bpf_loop_rungs, or -1 */
 	int place;
 };
 
@@ -142,13 +142,26 @@ static bool range_equal(const struct bpf_reg_state *ra, const struct bpf_reg_sta
 	       ra->base == rb->base && ra->step == rb->step;
 }
 
+static const struct bpf_loop_rungs *join_rungs(const struct bpf_join_state *js)
+{
+	u32 i;
+
+	for (i = 0; js->loop && i < js->loop->rungs_cnt; i++)
+		if (js->loop->rungs[i].place == js->place)
+			return &js->loop->rungs[i];
+	return NULL;
+}
+
 /* Does every iteration add a constant to what is in the place? In 64 or in 32 bits, 0 if not */
 static int join_place_is_linear(const struct bpf_join_state *js)
 {
-	if (!js->loop || js->place < 0 || js->place >= BPF_SCEV_REGS_NUM)
+	/* the place as scalar evolution numbers it */
+	u32 r = js->place < BPF_LOOP_SLOT ? js->place : js->place - BPF_LOOP_SLOT + MAX_BPF_REG;
+
+	if (!js->loop || js->place < 0 || r >= BPF_SCEV_REGS_NUM)
 		return 0;
-	return test_bit(js->place, js->loop->linear_regs) ? 64 :
-	       test_bit(js->place, js->loop->linear32_regs) ? 32 : 0;
+	return test_bit(r, js->loop->linear_regs) ? 64 :
+	       test_bit(r, js->loop->linear32_regs) ? 32 : 0;
 }
 
 /*
@@ -172,7 +185,7 @@ static bool join_range(struct bpf_join_state *js, struct bpf_reg_state *dst,
 	 */
 	if (dst->type != SCALAR_VALUE)
 		return false;
-	bpf_reg_widen_range(dst, ra, join_place_is_linear(js));
+	bpf_reg_widen_range(dst, ra, join_rungs(js), join_place_is_linear(js));
 	return true;
 }
 
@@ -468,7 +481,7 @@ static bool join_func(struct bpf_join_state *js, struct bpf_func_state *fd,
 	for (i = 0; i < bpf_stack_nr_slots(fa); i++) {
 		const struct bpf_stack_state *sb = i < nslots_b ? bpf_stack_slot(fb, i) : NULL;
 
-		js->place = MAX_BPF_REG + i;
+		js->place = BPF_LOOP_SLOT + i;
 		if (!join_slot(js, bpf_stack_slot(fd, i), bpf_stack_slot(fa, i), sb, pass))
 			return false;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 06265d617f4c..554713c9c0bb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18414,23 +18414,27 @@ void bpf_reg_forget_range(struct bpf_reg_state *reg)
  * @reg is what @old became after a trip around a cycle, @old included. The end
  * of the range that moved is going to move again. Put it where it may come
  * to rest. There are few such places, so this is done a few times at most.
- * It's put at the nearest of these places: every value between the range and the place is
+ * @rungs: where the jumps of the loop stop it, if they do.
+ * It's put at the nearest of all these places: every value between the range and the place is
  * made up, and the program is checked with it. Wherever it's put, the range only gets larger.
  * @linear: every iteration adds a constant to it, in that many bits. Then nothing but a jump
- * stops it. It goes on until it wraps, and is any number of that many bits.
+ * stops it. If there is none ahead it goes on until it wraps, and is any number of that many bits.
  */
-void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *old, int linear)
+void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *old,
+			 const struct bpf_loop_rungs *rungs, int linear)
 {
 	bool moved = reg->r64.base != old->r64.base || reg->r64.size != old->r64.size ||
 		     reg->r32.base != old->r32.base || reg->r32.size != old->r32.size;
-	s64 min = reg_smin(reg), max = reg_smax(reg);
+	s64 min = reg_smin(reg), max = reg_smax(reg), stop;
 
 	/* Only the step got weaker. It comes to rest without help, see below. */
 	if (!moved && reg->var_off.value == old->var_off.value &&
 	    reg->var_off.mask == old->var_off.mask)
 		return;
 
-	if (linear && (max > reg_smax(old) || min < reg_smin(old))) {
+	if (linear &&
+	    ((max > reg_smax(old) && !(rungs && rungs->has_max && max <= rungs->max[1])) ||
+	     (min < reg_smin(old) && !(rungs && rungs->has_min && min >= rungs->min[1])))) {
 		if (linear == 64 || min < 0 || max > U32_MAX) {
 			bpf_reg_forget_range(reg);
 			return;
@@ -18438,13 +18442,21 @@ void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *
 		min = 0;
 		max = U32_MAX;
 	}
-	if (max > reg_smax(old))
-		max = max <= 0 ? 0 :
-		      max <= S32_MAX ? S32_MAX :
-		      max <= U32_MAX ? U32_MAX : S64_MAX;
-	if (min < reg_smin(old))
-		min = min >= 0 ? 0 :
-		      min >= S32_MIN ? S32_MIN : S64_MIN;
+	if (max > reg_smax(old)) {
+		stop = max <= 0 ? 0 :
+		       max <= S32_MAX ? S32_MAX :
+		       max <= U32_MAX ? U32_MAX : S64_MAX;
+		if (rungs && rungs->has_max && max <= rungs->max[1])
+			stop = min(stop, max <= rungs->max[0] ? rungs->max[0] : rungs->max[1]);
+		max = stop;
+	}
+	if (min < reg_smin(old)) {
+		stop = min >= 0 ? 0 :
+		       min >= S32_MIN ? S32_MIN : S64_MIN;
+		if (rungs && rungs->has_min && min >= rungs->min[1])
+			stop = max(stop, min >= rungs->min[0] ? rungs->min[0] : rungs->min[1]);
+		min = stop;
+	}
 	if (min == S64_MIN && max == S64_MAX) {
 		bpf_reg_forget_range(reg);
 		return;
-- 
2.55.0

