Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911540;
	b=w8YsPUSfIaGZViaeHwwONEdPClz7sgmOmf+WMu6RcKn5+soL1Nr8PzORP27NY7svMmyg
	 8sc7FsK2IzjJKp4HK3wpS77rQ5kxUO/V9PRxDltgOBRiqkorNFgl7xxyxxJRY0Uiv7Ski
	 qHGMpDtI6xCcvFNVB2XX7gHQRU/r3KZWnKTtDtellojk/wKYIlV5YEVNN+EHmdsJH+e00
	 jv43jtJ3O+nulJyW+BrJ2KZOjzcLq4KMtgiWmSI1gfLuO7QiQd94HeuE9cRzNi/kjOig1
	 xbbVgoLWwQ/sUjJm93lAfuABYvzWBMpkxto6ZkKNr3H9Wqe7CBGop0Lyh97vU8O7T9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4bDM6OdZTUde2mRB5/i2XWeGRQvQvFajDQXG6RIdyZI=;
	b=5rh4pYLfiKYxf4nDTfazKltcmGiAc350HyKybIhQpA/uVCQL1b2jqGhxNwFSCuNC9a/3
	 lUIrlzloMkbagjgLtBAJAMG5lCHxo9CCVbTvwCiWpAUHOlZrr2SGsbFEllfoPe6f+pWTr
	 79lGFeJ3dSAkH9Y+iHD9aSfOEff1QKW4shk634dMq9POpNFwSpNqks9d5ihvDHaKdLxVY
	 iruDzbiTtKkSv92Lm9TVilCOQmafFLytCCYADVwz34FSaBnG0x9jgUbGumb9V4kpwv497
	 MsHxN+IfvS12bbCnI1cp8ztVhjDBcgvAy14ZISFjgXNwZcCVoZ0RizlG2c9VI38Ae3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qffNf5I+;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2B1606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D2B1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qffNf5I+
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9995ce866so18959835ad.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911539; x=1794516339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4bDM6OdZTUde2mRB5/i2XWeGRQvQvFajDQXG6RIdyZI=;
        b=qffNf5I+UnkiTVdNAKeCD4FLh9tHMk2ylVjytzFA8JfFeWIkvB4uqs19zIHtfWR3QI
         yC8L5fgE2hHBHw2qtYc6ffD8nz26pmyIO3eIr7LwNEAdGVvm3hmoIqW9HMDlsk00lmef
         emffHNCePv1chWvMIypUGlKNX/B/K9r0oSGH+lA1C+TcG7O2FnL+6dPKZ1TA2zXyOTi3
         OGwZc3YAjdQJ/q1dIolSOc9vSGA9+qpyF9dCKKnUx8nA5BwEtbI8bSxezfAUSDBxINQv
         408F+s6Q4nviVy8sT0ePZNuE8BY/jh1GOg8Lrbomz6PXzE88aTHTuf2wE9BvHxkRSqr2
         Z7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911539; x=1794516339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4bDM6OdZTUde2mRB5/i2XWeGRQvQvFajDQXG6RIdyZI=;
        b=S7GRZ82eInOTjup6JRi9zul+HAo4F5qituRwMXgi9asZL2MT0EP7GDdQDM7MV7WbFa
         kSpicZLzj3Uj0Fz/DmGYX3fmeA1zREDv63ZLbWySgEx3sepcoPDBu5upzUOetY7Sa8FW
         iqd5O8KYXtKX0l5Gqi8Fcb1OBgkOML1W/E/jeV5DOATuvwcAvMPgaIRlWgmuNP28EQe5
         WcI3vMrV2he37gJ8HGBFNJpDnSIdNL/zT1Q6q4O0WcRtuf7y9qo8xs9/EsVoDDOPQCdl
         +S2w7vkex/coprIc7k9COac5yU7cdyIvWP7zmSBnEH2ED/ioe9+36ABYBBstDuHQwbEF
         O9pg==
X-Gm-Message-State: APuU4Z9kVdMCYAeaTULyzZHLb6ODbwA/9UBvh1+E3B5uYO1Gvxwd/lgy
	2YpGmatXyB0l53ARpMOYR+VPw9cIK2kuCJqLxC74bWzfYveHKf5C/QoTd9Gv2Q==
X-Gm-Gg: AYBFou1emdC1eDVkuMiZgqR2PUy5CHhGji744NUxAxc/WE8GD+v8txxnOg9P5c3RFHk
	VAt/KseTUuhCMabUwZoAoJksX6ON2gwrktySFdRP4hkG+6P70JOPSPcGlolnY3YHKMlEgtZ2c66
	xSHoTY9O12xLR98/kmy6KHbx4QEZS6F4B2w2ZmnuuHwbneK8F3MjiA18E3ODKR5RZz7heOIUHhx
	NJl5Vihqowany70LzDbiXHpuLhwBJV/WH39OxK1vZd7JptBbyEnomZzhgynA3oPKz1CFwPw0lvn
	RbJB+WN7YJB2ks6V7RoFFrAAz7KMQXwDyHbse1TC5ryOy54GU5kn8Xr1L4TIE4dT4hhgICcdlPO
	wlmgmJ8rjQue66hIOdmvgJ2WM1zlRPYMtld9Nfvak8yy4oYXAJ1B8hbaBtntZPTomKjfiRMo8sc
	dAyoWiDjqGQloVPFnuLUnrC9ncAcfzpVHc0qopCZuKpPmcvj3VUI3Om0kTiSECzAXH+0U4SoGlT
	LtyClcEGcgJnBfSB1ZxIodTiLd7r4fjVY11hRy+J0n5u8zYIC4t9pSnKCSjKzxJuxn2Em8maHvl
	+8ccxp6k/m0mW7QAQ/2/oT4jc/9FBlZgMCa+Mt9qJSnorE68z2/nDyf5yTLoKjAWu+Bc013ZntJ
	kNodROZsMWrLkECR3ccrIcylhgykjghAMsmwzuhfda86wNXMG48Xa3GyJCxXLuRrEIQgjrvb8uf
	A=
X-Received: by 2002:a17:902:ec86:b0:2ed:d7b:2f5c with SMTP id d9443c01a7336-2ed412fc7c1mr7003715ad.5.1793911539146;
        Thu, 05 Nov 2026 12:45:39 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed08bd5ab2sm20341295ad.5.2026.11.05.12.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:45:38 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 04/35] bpf: Add join of registers and stack slots
Date: Thu,  5 Nov 2026 20:44:41 +0000
Message-ID: <20261105204513.2230344-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
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
struct bpf_loop for that. A pointer whose offset grew has no join: no later
comparison gives it a bound.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   3 +
 kernel/bpf/join.c            | 400 +++++++++++++++++++++++++++++++++++
 kernel/bpf/scev.c            |  17 ++
 3 files changed, 420 insertions(+)
 create mode 100644 kernel/bpf/join.c

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 79faf084cbcd..edddb25c4c12 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -760,6 +760,9 @@ struct bpf_loop {
 	 * loops.
 	 */
 	unsigned long store_base_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
+	/* what gets a constant added in every iteration, in 64 and in 32 bits */
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
index bb1c67176d78..819b563a5b54 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -1676,6 +1676,20 @@ static int compute_header_scevs(struct bpf_verifier_env *env, struct env *header
 	}
 	return 0;
 }
+
+/* Find the registers and stack slots that get a constant added in every iteration of the loop */
+static void scev_compute_linear_regs(struct scev *scev, struct bpf_loop *loop,
+				     struct env *header_env)
+{
+	u32 r, same, base, slope;
+	bool zext32;
+
+	for (r = 0; r < REGS_NUM; r++)
+		if (is_linear_or_linear32(scev, header_env->reg2scev[r], &base, &slope, &zext32) &&
+		    is_reg(scev, base, &same) && same == r)
+			__set_bit(r, zext32 ? loop->linear32_regs : loop->linear_regs);
+}
+
 static int instantiate_header_scevs(struct scev *scev, u32 id, void *priv)
 {
 	u32 reg, *reg2scev = priv;
@@ -1784,6 +1798,9 @@ int bpf_compute_scev(struct bpf_verifier_env *env)
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

