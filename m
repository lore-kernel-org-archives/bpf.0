Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022708;
	b=LoJbxdsGI4mhkJA+L0E71NstMvsgK87w81g+2Rx0IU2c7mcO0Hb7o7TnZzj3BWszHIL8
	 tx+MLgzCS4n8sruJw5s/LFFBiKR1uNkvy3VnUN5gYrLkLA/77ipuoz2FV3Vcs9EdHDlIb
	 A+Yi6arN6my2UytudAeqOXVEGodtas26NBAxjitraltEYL/OJALfSKVQNxVtJg3/4T8yk
	 grE4dYjP6Kr5rtOF1Lfgt7wQUYDM4vYSnoAnHyYoiexfFK/BiFfWn97/9e/PfUr8B2Qq5
	 SeU8oTC8MjrmANENqRHqsgsD5YtnR8cWrS7oSROSMItDPejCkYjIJGonifs7xr6hvwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TlRGQhZUGfmsumGLL+6gjl2myb0nThdw8OnaMGOl8r0=;
	b=LtNiTN+Bln3h1vEKU+zekc4o0PPGuqark9zEK5WiYxBeYz3lKniEl+/p2yqhouqRY87B
	 OcXSgVIfoY4Pbh/fwcGW0rC8oBqBh/OF3mvT+Y0HkDDUqHxEMKmd3HClShqFvfkbN74oD
	 h0s9wIkEA+x2orPA3wJW/QDF7bC+xSQFLGUBbsPKYHbMCwhV1YtrNmEfYcxg413T8G9y/
	 rsP10tePPjxCAlWDMg2ex9VR0SL4rKVUtkjwJ7El+BPccd7CB6poe0uqDYR3BC1vLSX4u
	 QUzutMFOQkBcrX8ecFR5f41vWYVI9NlnlqeTVPhStHHL5LvQEEL1+OhmDWFMB1Zjw3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MZgUBUX8;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B2E606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3B2E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MZgUBUX8
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e942864693so7329975ad.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022707; x=1794627507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TlRGQhZUGfmsumGLL+6gjl2myb0nThdw8OnaMGOl8r0=;
        b=MZgUBUX86fpnGe/Ap3aKr8OnGrMxgfzSgA5RowJFhCrVxMNCDFeAKJmq/i0hg+2/pY
         YgiUjcfdu+hr0HKJqYkLIsSQMrbHaIVwZOXKNIIhwFAHQJ3Kr/CJDGv2HxOsXvpV2B4W
         yN+PFFAPW8seagTf/m570B5bykJxFObosuZCFJHUHxR6uELaOLQNjTCb5/QkLlxVRpgh
         rau4n8oBk886PdTMUkaeWI9WbFId1eU/ftORPA90rgCl4FjfB61cv99RbNre1ekrCngL
         eY8XwNjhq5RY9ifOkzICagQOVrmRh2ie95Q3Ck/2gHLHBN6okdFsnASkeUeL2bnJAKsW
         oSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022707; x=1794627507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TlRGQhZUGfmsumGLL+6gjl2myb0nThdw8OnaMGOl8r0=;
        b=YqXP2uv0yyGYKnkwT6o1p18b6Wdj6K/gTGVpZ2Df1+3NgNaM6GxDZaeM0jAXF47ZuK
         bVjf9kZC4YnyEf7gezzrfzcVnOqIAiWzPcVYuNrLvuFrSQuREjt0bNVmJRhfQXExSg4P
         dbO3EK+ct0Jb/D+U7q4xi2XxZPUSEwfGP5JSlB/OVfNnD+OHUvIC32Ze3VRpCRHlVkCr
         Ilx5o0cjdVhypufg4O/oZqKW+LYkgj+zcQzb6sLQ4SEIqH6qZYNzgLduf6UhzLe4pnQ4
         y/36Dax+gIZ3hYIPo2PI8NKCbgaE3ThLybZhzvK2AQc07J8vd8HrGxP1LYY8wdc0pOK0
         PpLQ==
X-Gm-Message-State: APuU4Z/1hPVHTGaS4OrtNixstUzZtJRhDOEbDEuThSmI155iAjtYpPCE
	3LpA6VMh/1qVIg0sknY0Hx22rUIuwJoWIqczX4Z5Y6xxTIw2SDavINuucvW0Iw==
X-Gm-Gg: AYBFou2pXr9Og0+K8q9o4wcgICS+fHpK+Z4ckDX62GjbV9Qd0R1lgD6DGT5WoVm0C9N
	aaQi2h90Ub5Aa1iV4jRigVfYVo7rOZxp7eyVaSfRH2okuEz6cqcSN7/NM5voT5HdDG7saffVLjC
	Ish2NQGLcWA7Q4NXL7Ex76R0LAOVo0GDBxsF3FwUDeNOxU1uH4P005gu3WBCQ5542NNKYZsXw9V
	07UPT5jH1W3+6kwCnOa50FQ9dkFLlyPUCBlikcUHpmVY1/vFoPf7aA+28TlHvNX3WKmYzOEvjDb
	JseuGdUsDjYaUVyhiGclyBfY2ELhTQxoLi/07hEAgmedrX5h6kFRVciVlKPrzT97KQQafb40bZl
	ZcGuFwpQ2EwLbtUQOO04NCbWDayIrT09mEADGwLgyaEBJfjoHyqDD1uMV1oWd2KI81UQBnIJKfP
	xti6d2PI/OdNzMe/hLg4jIlkE/UcVebfWnijXlqidky0bNlEIu6efQLY6z9FxcPUif0Ps6irEnB
	rTiOQSWWkxu5+gRxoar+7cc1U12GsPZga3/zsXawOtm/7iRYFLoicPDCnX4NTjKvsE9wLMX7jaL
	3F38PbpmA9ACK2A7+xSE+P9zZN4HT7CebwRGOlNaSNg5gHR5RoJhlHrBV2yjw+5vsr/CIDPg5fu
	S2Vwt/o+pWVCYEKhynujSHiZTUpkwVI/DIkdadEOEFF/ijPMpbLhStA6CM9mWwF0VMbFFpUYOmQ
	==
X-Received: by 2002:a17:903:37c6:b0:2ed:2a1d:e36d with SMTP id d9443c01a7336-2ed40c7b5e1mr51071685ad.36.1794022706951;
        Fri, 06 Nov 2026 19:38:26 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f226sm10219685ad.44.2026.11.06.19.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:38:26 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 04/46] bpf: Add join of registers and stack slots
Date: Sat,  7 Nov 2026 03:37:12 +0000
Message-ID: <20261107033758.1547725-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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

ipv6_hdrlen_offset() of Cilium skips extension headers, unrolled:

  for (i = 0; i < IPV6_MAX_HEADERS; i++) {
          int hdrlen = ipv6_skip_exthdr(ctx, &newnh, l3_off + len);
          ...  8, (opthdr->hdrlen + 2) << 2 or (opthdr->hdrlen + 1) << 3
          len += hdrlen;
  }

The verifier follows each path. Three lengths for each header: the insn
behind this loop is verified 76 times, and each time the rest of the prog
follows, where more paths fork. tail_nodeport_nat_ingress_ipv6 of bpf_xdp,
as of May 2026, has 4095 insns, the verifier processes 182050.

Add the join of two states: one state that covers the two. Here hdrlen is
[8, 2048]. A caller that replaces two states with their join verifies the
code that follows one time. This prog: 3 times in place of 76, 7932 insns.
This is the first half of join.c: ids, registers, stack slots.

Only numbers are joined: scalars, and the variable offsets of pointers. A
join loses information. Where the prog needs it there is no join, and the
caller keeps the two states:
 - map value + 8 and map value + 16: two fields, not a range
   scx_rusty: create_save_cpumask(&kptr) for three kptrs in .data
   "R1 doesn't have constant offset. kptr has to be at the constant offset"
 - packet pointers that are checked up to different ends
   Cilium: l4_csum_replace(ctx, l4_off + csum->offset, ..)
   "invalid access to packet": 206 progs of bpf_xdp in 37 builds of Cilium
 - a scalar and a pointer, pointers to two objects: of no use to a prog

Each path makes its own ids. An id in the join stands for a pair: the id
in state a and the id in state b. The pairs must be one to one, as in
check_ids(). If not, a scalar loses its id, and a pointer has no join.
 - 'bpf_for(i, 0, 10) sum += i;' of iters_num: each bpf_iter_num_next()
   returns a pointer with a new id. If ids had to be equal, the main pass
   says "more than 1024 states that cannot be joined at insn 16".
 - scx_pandemonium: 'if (.. && (u32)src_cpu < MAX_CPUS) pair_warm_ns[..]'
   tests r5 and indexes with its copy in fp-88. Paths meet between copy
   and test. A join without ids: "R3 unbounded memory access".

With 'widen', at a loop head, a scalar that grew is widened. If each
iteration adds a constant to it, it becomes an unknown scalar of 64 or 32
bits at once: scev_compute_linear_regs() sets linear_regs, linear32_regs of
struct bpf_loop for that. So does sum of bpf_for() above: it is a register
plus or minus something (expr_is_sum()), and no jump of the loop depends on
it (tested_regs). 0, [0, S32_MAX], [0, U32_MAX], unknown are 4 passes
through the body, this is 2: 59 -> 43 insns. If a jump depends on the sum
the stops stay. A pointer whose offset grew has no join: no later
comparison gives it a bound.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  11 +
 kernel/bpf/join.c            | 400 +++++++++++++++++++++++++++++++++++
 kernel/bpf/scev.c            |  75 +++++++
 3 files changed, 486 insertions(+)
 create mode 100644 kernel/bpf/join.c

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 79faf084cbcd..749ebb1ad489 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -760,6 +760,17 @@ struct bpf_loop {
 	 * loops.
 	 */
 	unsigned long store_base_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
+	/*
+	 * Loop-entry registers used to compute the operands of conditional jumps, in this and
+	 * nested loops.
+	 */
+	unsigned long tested_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
+	/*
+	 * what gets a constant added in every iteration, in 64 and in 32 bits. A sum that is
+	 * not among tested_regs is taken for that too: nothing stops it either
+	 */
+	unsigned long linear_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
+	unsigned long linear32_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
 };
 
 struct bpf_insn_aux_data {
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
new file mode 100644
index 000000000000..fe513b7a8e88
--- /dev/null
+++ b/kernel/bpf/join.c
@@ -0,0 +1,400 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Join of verifier states.
+ *
+ * bpf_states_join(dst, a, b) computes the state that describes every concrete
+ * state described by 'a' or by 'b'. With @widen a number that is larger in the
+ * result than in 'a' gets the bound that moved put further out, so that a sequence
+ * of states at a loop head ends. A pointer whose offset is larger has no join.
+ *
+ * Numbers and offsets of pointers are joined. A pointer and a number, pointers
+ * to different objects, different references and locks are not: there is no
+ * join and the states stay apart.
+ *
+ * The contract is checked on every call: both inputs have to be within the
+ * result, see bpf_state_subsumes(). A violation is a verifier bug.
+ *
+ * Inputs have to be at the same insn and cleaned with
+ * bpf_clean_verifier_state(): dead registers and stack slots are the same on
+ * both sides then, but for dynptrs, iterators and irq flags: they stay.
+ */
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/cnum.h>
+#include <linux/tnum.h>
+#include <linux/filter.h>
+#include <linux/slab.h>
+
+struct join_idpair {
+	u32 a;
+	u32 b;
+	bool bad;
+};
+
+struct bpf_join_state {
+	struct bpf_verifier_env *env;
+	struct join_idpair pairs[BPF_ID_MAP_SIZE];
+	u32 npairs;
+	bool pairs_overflow;
+	bool widen;
+	/* the states came around this loop in the frame that is joined, NULL if not */
+	const struct bpf_loop *loop;
+	/* the register or stack slot that is joined, as scalar evolution numbers it, or -1 */
+	int place;
+};
+
+static struct bpf_join_state *join_state(struct bpf_verifier_env *env)
+{
+	if (!env->join) {
+		env->join = kvzalloc_obj(*env->join, GFP_KERNEL_ACCOUNT);
+		if (env->join)
+			env->join->env = env;
+	}
+	return env->join;
+}
+
+void bpf_join_free(struct bpf_verifier_env *env)
+{
+	kvfree(env->join);
+	env->join = NULL;
+}
+
+/*
+ * An id in the result stands for the pair (id in 'a', id in 'b'). For the
+ * result to be within both inputs the pairs have to form a bijection,
+ * see check_ids(). The first pass over all locations records the pairs. An id
+ * seen with two partners makes all pairs it takes part in bad.
+ * The second pass keeps the id of 'a' for good pairs.
+ */
+static void jid_mark_bad(struct bpf_join_state *js, u32 a, u32 b)
+{
+	u32 i;
+
+	for (i = 0; i < js->npairs; i++)
+		if ((a && js->pairs[i].a == a) || (b && js->pairs[i].b == b))
+			js->pairs[i].bad = true;
+}
+
+static void jid_note(struct bpf_join_state *js, u32 ida, u32 idb, bool consistent)
+{
+	u32 a = ida & ~BPF_ADD_CONST, b = idb & ~BPF_ADD_CONST;
+	struct join_idpair *p;
+	bool other = false;
+	u32 i;
+
+	if (!a || !b)
+		return;
+	for (i = 0; i < js->npairs; i++) {
+		p = &js->pairs[i];
+		if (p->a == a && p->b == b) {
+			if (!consistent)
+				jid_mark_bad(js, a, b);
+			return;
+		}
+		if (p->a == a || p->b == b)
+			other = true;
+	}
+	if (other) {
+		jid_mark_bad(js, a, b);
+		consistent = false;
+	}
+	if (js->npairs == ARRAY_SIZE(js->pairs)) {
+		js->pairs_overflow = true;
+		return;
+	}
+	p = &js->pairs[js->npairs++];
+	p->a = a;
+	p->b = b;
+	p->bad = !consistent;
+}
+
+static bool jid_good(struct bpf_join_state *js, u32 ida, u32 idb)
+{
+	u32 a = ida & ~BPF_ADD_CONST, b = idb & ~BPF_ADD_CONST;
+	u32 i;
+
+	if (!a || !b || js->pairs_overflow)
+		return false;
+	if ((ida ^ idb) & BPF_ADD_CONST)
+		return false;
+	for (i = 0; i < js->npairs; i++)
+		if (js->pairs[i].a == a && js->pairs[i].b == b)
+			return !js->pairs[i].bad;
+	return false;
+}
+
+/* Ids that have to match: both zero, or a good pair */
+static bool jid_strict_ok(struct bpf_join_state *js, u32 ida, u32 idb)
+{
+	if (!ida && !idb)
+		return true;
+	return jid_good(js, ida, idb);
+}
+
+static bool range_equal(const struct bpf_reg_state *ra, const struct bpf_reg_state *rb)
+{
+	return ra->r64.base == rb->r64.base && ra->r64.size == rb->r64.size &&
+	       ra->r32.base == rb->r32.base && ra->r32.size == rb->r32.size &&
+	       ra->var_off.value == rb->var_off.value && ra->var_off.mask == rb->var_off.mask &&
+	       ra->base == rb->base && ra->step == rb->step;
+}
+
+/* Does every iteration add a constant to what is in the place? In 64 or in 32 bits, 0 if not */
+static int join_place_is_linear(const struct bpf_join_state *js)
+{
+	if (!js->loop || js->place < 0 || js->place >= BPF_SCEV_REGS_NUM)
+		return 0;
+	return test_bit(js->place, js->loop->linear_regs) ? 64 :
+	       test_bit(js->place, js->loop->linear32_regs) ? 32 : 0;
+}
+
+/*
+ * Join of the range of two registers of the same type, numbers or pointers
+ * with variable offset. @dst is a copy of @ra. Returns false if there is no join.
+ */
+static bool join_range(struct bpf_join_state *js, struct bpf_reg_state *dst,
+		       const struct bpf_reg_state *ra, const struct bpf_reg_state *rb)
+{
+	if (range_equal(ra, rb))
+		return true;
+	bpf_reg_union_range(dst, rb);
+	if (!js->widen || range_equal(dst, ra))
+		return true;
+	/*
+	 * The bound of a number that grows around a cycle is put where it may come to rest. If
+	 * that is far out the number gets a bound again from the next comparison. The offset of
+	 * a pointer doesn't: there is no access through a pointer at an offset that is not
+	 * known. So there is nothing to gain from that join. If the offset stops to grow
+	 * the next state is within the last one.
+	 */
+	if (dst->type != SCALAR_VALUE)
+		return false;
+	bpf_reg_widen_range(dst, ra, join_place_is_linear(js));
+	return true;
+}
+
+static bool reg_fixed_part_equal(const struct bpf_reg_state *ra, const struct bpf_reg_state *rb)
+{
+	return !memcmp(ra, rb, offsetof(struct bpf_reg_state, var_off));
+}
+
+static bool reg_value_equal(const struct bpf_reg_state *ra, const struct bpf_reg_state *rb)
+{
+	return !memcmp(ra, rb, offsetof(struct bpf_reg_state, id));
+}
+
+static bool scalar_link_consistent(const struct bpf_reg_state *ra, const struct bpf_reg_state *rb)
+{
+	if ((ra->id ^ rb->id) & BPF_ADD_CONST)
+		return false;
+	if ((ra->id & BPF_ADD_CONST) && ra->delta != rb->delta)
+		return false;
+	return true;
+}
+
+/*
+ * Join two registers, regsafe() documents what each type needs.
+ * Pass 1 records id pairs, pass 2 computes @dst, which is a copy of @ra on entry.
+ * Returns false if there is no join.
+ */
+static bool join_reg(struct bpf_join_state *js, struct bpf_reg_state *dst,
+		     const struct bpf_reg_state *ra, const struct bpf_reg_state *rb, int pass)
+{
+	if (ra->type == NOT_INIT || rb->type == NOT_INIT) {
+		if (pass == 2 && ra->type != NOT_INIT)
+			*dst = *rb;
+		return true;
+	}
+
+	if (ra->type != rb->type)
+		return false;
+
+	switch (base_type(ra->type)) {
+	case SCALAR_VALUE:
+		if (js->env->explore_alu_limits && !reg_value_equal(ra, rb))
+			return false;
+		if (pass == 1) {
+			jid_note(js, ra->id, rb->id, scalar_link_consistent(ra, rb));
+			return true;
+		}
+		join_range(js, dst, ra, rb);
+		/* a link that exists on one side only is dropped */
+		if (ra->id && !jid_good(js, ra->id, rb->id)) {
+			dst->id = 0;
+			dst->delta = 0;
+		}
+		return true;
+	case PTR_TO_MAP_KEY:
+	case PTR_TO_MAP_VALUE:
+	case PTR_TO_MEM:
+	case PTR_TO_BUF:
+	case PTR_TO_TP_BUFFER:
+		if (!reg_fixed_part_equal(ra, rb))
+			return false;
+		/*
+		 * Two places in an object are two pointers: what is at a place
+		 * and how much is left behind it is lost in a range of them.
+		 */
+		if (!js->widen && tnum_is_const(ra->var_off) && tnum_is_const(rb->var_off) &&
+		    ra->var_off.value != rb->var_off.value)
+			return false;
+		break;
+	case PTR_TO_PACKET_META:
+	case PTR_TO_PACKET:
+		if ((ra->range < 0 || rb->range < 0) && ra->range != rb->range)
+			return false;
+		/* how much of the packet was checked goes with numbers elsewhere in the state */
+		if (!js->widen && ra->range != rb->range)
+			return false;
+		/*
+		 * Displacements between pointers that share an id are kept. No id is an id too:
+		 * the start of the packet plus a constant, see find_good_pkt_pointers().
+		 */
+		if (ra->r64.base != rb->r64.base)
+			return false;
+		if (pass == 1) {
+			jid_note(js, ra->id, rb->id, true);
+			return true;
+		}
+		if (!jid_strict_ok(js, ra->id, rb->id))
+			return false;
+		if (rb->range != ra->range)
+			dst->range = min(ra->range, rb->range);
+		return join_range(js, dst, ra, rb);
+	case PTR_TO_ARENA:
+		/* The offset is not tracked. */
+		return true;
+	case PTR_TO_INSN:
+		if (!reg_fixed_part_equal(ra, rb))
+			return false;
+		return pass == 1 || join_range(js, dst, ra, rb);
+	default:
+		if (!reg_value_equal(ra, rb))
+			return false;
+		break;
+	}
+
+	if (pass == 1) {
+		jid_note(js, ra->id, rb->id, true);
+		jid_note(js, ra->parent_id, rb->parent_id, true);
+		jid_note(js, ra->map_uid, rb->map_uid, true);
+		return true;
+	}
+	if (!jid_strict_ok(js, ra->id, rb->id) ||
+	    !jid_strict_ok(js, ra->parent_id, rb->parent_id) ||
+	    !jid_strict_ok(js, ra->map_uid, rb->map_uid))
+		return false;
+	return join_range(js, dst, ra, rb);
+}
+
+static bool slot_is_special(const struct bpf_stack_state *s)
+{
+	u8 t = s->slot_type[BPF_REG_SIZE - 1];
+
+	return t == STACK_DYNPTR || t == STACK_ITER || t == STACK_IRQ_FLAG;
+}
+
+static bool stype_is_invalid(u8 t)
+{
+	return t == STACK_INVALID || t == STACK_POISON;
+}
+
+static bool slot_has_spill(const struct bpf_stack_state *s)
+{
+	int i;
+
+	for (i = 0; i < BPF_REG_SIZE; i++)
+		if (s->slot_type[i] == STACK_SPILL)
+			return true;
+	return false;
+}
+
+static bool join_special_slot(struct bpf_join_state *js, const struct bpf_stack_state *sa,
+			      const struct bpf_stack_state *sb, int pass)
+{
+	const struct bpf_reg_state *ra = &sa->spilled_ptr, *rb = &sb->spilled_ptr;
+
+	if (memcmp(sa->slot_type, sb->slot_type, sizeof(sa->slot_type)))
+		return false;
+	switch (sa->slot_type[BPF_REG_SIZE - 1]) {
+	case STACK_DYNPTR:
+		if (ra->dynptr.type != rb->dynptr.type ||
+		    ra->dynptr.first_slot != rb->dynptr.first_slot)
+			return false;
+		break;
+	case STACK_ITER:
+		if (ra->type != rb->type || ra->iter.btf != rb->iter.btf ||
+		    ra->iter.btf_id != rb->iter.btf_id || ra->iter.state != rb->iter.state ||
+		    ra->iter.loops != rb->iter.loops)
+			return false;
+		break;
+	case STACK_IRQ_FLAG:
+		if (ra->irq.kfunc_class != rb->irq.kfunc_class)
+			return false;
+		break;
+	}
+	if (pass == 1) {
+		jid_note(js, ra->id, rb->id, true);
+		jid_note(js, ra->parent_id, rb->parent_id, true);
+		return true;
+	}
+	return jid_strict_ok(js, ra->id, rb->id) &&
+	       jid_strict_ok(js, ra->parent_id, rb->parent_id);
+}
+
+/*
+ * Join of one 8 byte stack slot, @ds is a copy of @sa on entry.
+ * stacksafe() documents which slot is within which.
+ */
+static bool join_slot(struct bpf_join_state *js, struct bpf_stack_state *ds,
+		      const struct bpf_stack_state *sa, const struct bpf_stack_state *sb, int pass)
+{
+	static const struct bpf_stack_state invalid_slot;
+	bool a_ptr, b_ptr;
+	u8 res[BPF_REG_SIZE];
+	int i;
+
+	if (!sb)
+		sb = &invalid_slot;
+
+	if (slot_is_special(sa) || slot_is_special(sb))
+		return join_special_slot(js, sa, sb, pass);
+
+	if (!memcmp(sa->slot_type, sb->slot_type, sizeof(sa->slot_type)) &&
+	    sa->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL)
+		return join_reg(js, &ds->spilled_ptr, &sa->spilled_ptr, &sb->spilled_ptr, pass);
+
+	a_ptr = slot_has_spill(sa) && sa->spilled_ptr.type != SCALAR_VALUE;
+	b_ptr = slot_has_spill(sb) && sb->spilled_ptr.type != SCALAR_VALUE;
+	/* a pointer and something else */
+	if (a_ptr || b_ptr)
+		return false;
+
+	/* the prog can't read uninitialized stack: slots of different kinds have no join */
+	if (!js->env->allow_uninit_stack)
+		return !memcmp(sa->slot_type, sb->slot_type, sizeof(sa->slot_type));
+
+	/* scalar spills, MISC, ZERO, INVALID, POISON: no ids are kept */
+	if (pass == 1)
+		return true;
+
+	for (i = 0; i < BPF_REG_SIZE; i++) {
+		u8 x = sa->slot_type[i], y = sb->slot_type[i];
+
+		if (x == STACK_SPILL)
+			x = STACK_MISC;
+		if (y == STACK_SPILL)
+			y = STACK_MISC;
+		if (stype_is_invalid(x) && stype_is_invalid(y))
+			res[i] = sa->slot_type[i];
+		else if (stype_is_invalid(x) || stype_is_invalid(y))
+			res[i] = STACK_INVALID;
+		else if (x == y)
+			res[i] = x;
+		else
+			res[i] = STACK_MISC;
+	}
+	memcpy(ds->slot_type, res, sizeof(res));
+	bpf_mark_reg_not_init(js->env, &ds->spilled_ptr);
+	return true;
+}
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index bb1c67176d78..9629a6bf80b1 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -1220,6 +1220,22 @@ static void collect_store_base_regs(struct bpf_verifier_env *env,
 			or_expr_regs(env, cur_env->reg2expr[r], mask);
 }
 
+/*
+ * Record the loop-entry registers that the operands of the conditional jump at 'idx' are
+ * computed from, best effort like or_expr_regs().
+ */
+static void collect_tested_regs(struct bpf_verifier_env *env, struct env *cur_env, int idx,
+				unsigned long *mask)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+
+	if (!bpf_insn_is_cond_jump(insn->code) || BPF_OP(insn->code) == BPF_JCOND)
+		return;
+	or_expr_regs(env, cur_env->reg2expr[insn->dst_reg], mask);
+	if (BPF_SRC(insn->code) == BPF_X)
+		or_expr_regs(env, cur_env->reg2expr[insn->src_reg], mask);
+}
+
 /* Find the topmost loop header containing idx inside cur_header, or -1 if none. */
 static int topmost_nested_loop(struct bpf_verifier_env *env, int idx, int cur_header)
 {
@@ -1325,6 +1341,7 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 			return -ENOMEM;
 		/* The freshly allocated environment has all expressions unknown. */
 		bitmap_fill(cur_loop->store_base_regs, REGS_NUM);
+		bitmap_fill(cur_loop->tested_regs, REGS_NUM);
 		header_env->empty = false;
 		return 0;
 	}
@@ -1364,6 +1381,9 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 			/* Pull the nested loop's stack-store base dependencies up. */
 			for_each_set_bit(r, nested_loop->store_base_regs, BPF_SCEV_REGS_NUM)
 				or_expr_regs(env, cur_env->reg2expr[r], cur_loop->store_base_regs);
+			/* And what its jumps depend on. */
+			for_each_set_bit(r, nested_loop->tested_regs, BPF_SCEV_REGS_NUM)
+				or_expr_regs(env, cur_env->reg2expr[r], cur_loop->tested_regs);
 			forget_non_invariants(env, cur_env, idx);
 			if (log_level2)
 				log_env_changes(env, LOG_AT_TRANSFER, old_env, cur_env, idx);
@@ -1386,6 +1406,7 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 				if (log_level2)
 					memcpy(old_env, cur_env, sizeof(*old_env));
 				collect_store_base_regs(env, cur_env, idx, cur_loop->store_base_regs);
+				collect_tested_regs(env, cur_env, idx, cur_loop->tested_regs);
 				err = transfer(env, cur_env, idx);
 				if (err)
 					goto out;
@@ -1676,6 +1697,57 @@ static int compute_header_scevs(struct bpf_verifier_env *env, struct env *header
 	}
 	return 0;
 }
+
+/*
+ * 'sum += a[i]', 'if (..) { len -= n; len -= 2; }': is 'id', what an iteration makes of
+ * register 'r', the register plus or minus something, or the register as it was?
+ * 'low32': it's computed in 32 bits.
+ */
+static bool expr_is_sum(struct scev *scev, u32 id, u32 r, bool low32, int depth)
+{
+	u32 a, b;
+
+	if (is_reg(scev, id, &a))
+		return a == r;
+	if (!depth--)
+		return false;
+	if (low32 && is_zext32(scev, id, &a))
+		return expr_is_sum(scev, a, r, low32, depth);
+	if (is_any(scev, id, &a, &b))
+		return expr_is_sum(scev, a, r, low32, depth) &&
+		       expr_is_sum(scev, b, r, low32, depth);
+	if (is_add(scev, id, &a, &b) && expr_is_sum(scev, b, r, low32, depth))
+		return true;
+	return (is_add(scev, id, &a, &b) || is_binop(scev, BPF_SUB, id, &a, &b)) &&
+	       expr_is_sum(scev, a, r, low32, depth);
+}
+
+/*
+ * Find the registers and stack slots that nothing but a jump stops: what gets a constant added in
+ * every iteration of the loop, and a sum that no jump of the loop depends on.
+ */
+static void scev_compute_linear_regs(struct scev *scev, struct bpf_loop *loop,
+				     struct env *header_env)
+{
+	u32 r, same, base, slope, id;
+	bool low32;
+	int bits;
+
+	for (r = 0; r < REGS_NUM; r++) {
+		id = header_env->reg2expr[r];
+		bits = 0;
+		if (is_linear_or_linear32(scev, header_env->reg2scev[r], &base, &slope, &low32) &&
+		    is_reg(scev, base, &same) && same == r)
+			bits = low32 ? 32 : 64;
+		/* what the loop leaves alone is no sum */
+		else if (!is_reg(scev, id, &same) && !test_bit(r, loop->tested_regs))
+			bits = expr_is_sum(scev, id, r, false, EXPR_STACK_DEPTH) ? 64 :
+			       expr_is_sum(scev, id, r, true, EXPR_STACK_DEPTH) ? 32 : 0;
+		if (bits)
+			__set_bit(r, bits == 32 ? loop->linear32_regs : loop->linear_regs);
+	}
+}
+
 static int instantiate_header_scevs(struct scev *scev, u32 id, void *priv)
 {
 	u32 reg, *reg2scev = priv;
@@ -1784,6 +1856,9 @@ int bpf_compute_scev(struct bpf_verifier_env *env)
 					   find_loop_env(scev, header, idx));
 		if (err)
 			return err;
+		if (aux[idx].loop)
+			scev_compute_linear_regs(scev, aux[idx].loop,
+						 find_header_env(scev, header));
 	}
 
 	for (i = 0; i < env->prog->len; i++)
-- 
2.55.0

