Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983863;
	b=qVaoF7Sez98wXy+e33N8Qs4NMRLydI35SM+Ty0k2xc2DQZeg07Q+eJhMifrKhKKq24Lq
	 RCbJkQ/vnxEtDfxn5FDTqzSXxzV8aHb3zmCzbnHlmX1eW9iVqZQ+ge0dQUCdTJhT3qBeD
	 1ROSUzDwgqy0G2eo1/2VOWOZuUkYdgxxsAqTlRqqQYbbhr1PK0V//4wjL8eM0iFfHE/0l
	 tBx6lQssDp9BspKVLn9CclNpvhsC+rXyEOgU5xzYmwmH/FR72qPRJs5NxM0zNinlNAryn
	 lGkI0viL8SiHAcR9AE0c1YUyz7yyYo8rR9mCOFLn6Glk1TAS1VqkMjHf4Zqfjgodb/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bDzA/KoHn5ZO+IkfUwunHDJPN1qHloUNO0nZl2iaEAI=;
	b=NZF6qdpHlQuP9I9JP+vhQmfMiOPLXkD2oUb+9I7f8CDBfsksvF8C6Jw0jr0HJEA0+ubp
	 KvB7lk2QHousCHs6NW8W4KDyJDliEYaP6ZSavJFV4U5cvyWrV0Ik+vCjWtaLitG0D0HQe
	 tRBgJo3jdLTT7/3AdSLjpOHzZzpm1TulYOjRqDchNcmLPHrLi6YjsvFk2VspMGtpvnPa4
	 ozRqRyw4KJIjJtb16YG9Bl0Z5WHpNvnhh8/+2L9xeUo7e2QWuuGphheXEYoc/Dp9sMR//
	 +u3Da1XJkN1RTvX0xHKTCmuKk3K7OsjHqiDLfPrAqAh7sydAhiHlfV6VZZWDzkosmvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DvLIr1QI;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D34606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56D34606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DvLIr1QI
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so1758131b3a.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983862; x=1793588662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bDzA/KoHn5ZO+IkfUwunHDJPN1qHloUNO0nZl2iaEAI=;
        b=DvLIr1QIWqdG79ccO3Tk7K/MNdQATJYTjqcBwjlbDVAoVRSCi2lsmmtIRSEAtN2DdE
         3DQm71mLNf//fXy5/WoNuxcl/h5ilboo73okFJdgQGamUhNZVrxe2MmXMD/I8mqY2PXk
         RD4KMzQlIIsehpusSDacsRN9h9mWKrZLhj8bQhmYgPdqxsLFM5WVa+elU63GYcNbVbj2
         87muzIBUZiWCeU0CXqIq84Na9TEL9bkl4iuK4LTHVOPPPIK/o2jekTfTogavulG4b2nt
         5ah2ABo+yWUsMpMfYiQzl6n+QtoEUJCAWDF8/Ub4jB83hrlRTKYsoddy/h5f4YuxCOJ7
         uVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983862; x=1793588662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bDzA/KoHn5ZO+IkfUwunHDJPN1qHloUNO0nZl2iaEAI=;
        b=yTQkU8RClpHtgdBRBUHy1NGb6af9UvxlDwGQdFrUmK3AYxiHM5ROqpRCnCtBpzBqLi
         D5QdvJwSTQg1sYaf3++TdpCBiz9wFlMgBYOiVnWak8PBRdpXz01F0lJ1eCcXTw1KFoBU
         RL1WKmvkGOkd/iAw42T0pFqXfn4s2Y140lHhDriSfcFzBFqla/7P2fXg07HJ0+cKVgR+
         qS7bRlhYCXxpHIWvSjv5ftEIP+P4592UUV2j9395Urgak1VKScHeV2QyBvkmFTkLUDXm
         txfr5q7LxAh0xVfxf1cQW2Sv/PczKLP7+s+3Imo2roS/rNwAKfXC2SQSO3b9cSsfVgUz
         L06w==
X-Gm-Message-State: AFq9FYIH/amXrE+7zIgp2TPjwlgH9nVKrxzh1O821EYslAxxx/hzoPjH
	XdeBJAWGUT4PH2MovJpGqzLP4oiPDIXWWfasdavWIQjm9M91edCxd8dI2LYGqw==
X-Gm-Gg: AYBFou2iZNA4suwFJMjTB8yLfJF3YSv12ShtM/Kr98dcMatCkC5HHtSC03+8gtazetP
	iuxyoz95wupZ+cXA+srEPw9+j9ieYrPHxd/iRCv6dLwh5MZybhSLQnt5ejBAsfpyRfJ1JkYJ/uo
	BtHV0OkpDXmJILSotizA/gJ+sR0b8CqXAFRacawGuUihssATxINkoiP0K0IANSWgoY+Qy8fIsT+
	RDWARbVr7FakBNZZYcFeZkjRXC47fffoO1oxfhhIrm6HhXksB/7etKVcGWdMCMwdHpVgGR96Uxw
	hgA9NO6LE4S8svvquYFCSqmsO+4Wjem98EYxbPU0XDSBcZNjplbBD2vF1Lu9L194QXXoCzdGimv
	tbNDMZPeA7tQM9hvELsZAIffPESfymVfgTTe8T0Z9hqla1CVaGWUo25XxmA2S+ylLDv5AjZDbpm
	zBVpxcdZQFfWW4YdP/gJUuC/No8reWYkhvFyrGRo2Pel+q27pTXUSBcyWVYzkF3No8XJDLkbHLA
	SfLnctOBEE7ueZ1L471vt1XrtiWTitNDaZqXRTpNiOHsNbW37TE6C8VYTGSz0H7tOM8mXtnT246
	3A0K/t4t9OC2+0xtqv2uanvoXOW7we1aaRAdbuXytLLAIL5zZPPvz8iweW4vnjyvubUtbXTE4Qw
	oHW0uFphIHhZ+iEOqiqKwlVL7
X-Received: by 2002:a05:6a00:12dd:b0:886:bb44:631f with SMTP id d2e1a72fcca58-8a367159490mr5410367b3a.10.1792983861530;
        Sun, 25 Oct 2026 20:04:21 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36bb2a7e8sm745171b3a.39.2026.10.25.20.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:04:21 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 47/81] bpf: Add join of verifier states
Date: Mon, 26 Oct 2026 02:59:08 +0000
Message-ID: <20261026025943.404450-48-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

The verifier follows each path of a prog. When two paths meet at an insn,
it compares the new state with the states that it saw at this insn before.
If none of them covers the new state (states_equal()), the verifier
verifies the remaining part of the prog again. Thus each 'if' can double
the work.

Add the join of two states: one state that covers the two. A caller that
replaces two states with their join verifies the subsequent code one time.

       follow each path                      join

    3: if r0 > 100 goto 5              3: if r0 > 100 goto 5
       |          \                       |          \
       |        4: r7 += 20               |        4: r7 += 20
    r7=[0,7]      |                    r7=[0,7]      |
       |        r7=[20,27]                |        r7=[20,27]
       v          v                       v          v
    5: r1 += r7                        5: r1 += r7
    verified 2 times                   verified 1 time, r7=[0,27]

The rule is to join only numbers: scalars, and the variable offsets of
pointers. All other parts of the two states must be equal. If they are not,
there is no join, and the caller keeps the two states.

  state a                   state b                   join
  ------------------------  ------------------------  -------------------
  scalar [0,7]              scalar [20,27]            scalar [0,27]
  map value + [0,7]         same map value + [20,27]  map value + [0,27]
  map value + 8             same map value + 16       no join
  scalar                    pointer                   no join
  pointer to map A          pointer to map B          no join
  not initialized           scalar or pointer         not initialized
  a lock or a reference     no lock, no reference     no join
  called from insn 2        called from insn 7        no join

A prog can do nothing with a register that is 'a pointer or a scalar'. Two
constant offsets in one object are two fields, not a range. Only live
registers and stack slots count, thus a dead register cannot prevent a
join.

A join loses information. In the example it loses that r7 is never 8..19. A
join can also leave open a jump that each path decides. Then dead code
stays in the prog.

Registers with the same id have the same value, or point to the same
object. An id in the join represents a pair: the id in state a and the id
in state b. The pairs must be one to one, as in check_ids(). If they are
not, a scalar loses its id, and a pointer or a reference has no join.

At a loop head a range can grow by a small step each time the verifier goes
through the loop. With the argument 'widen' the join moves the bound of a
scalar that grew to the next of these stops:

  lower bound:  S64_MIN <- S32_MIN <- 0
  upper bound:                        0 -> S32_MAX -> U32_MAX -> S64_MAX

Thus a range can grow only a few times. The offset of a pointer that grew
becomes unknown. This includes two constant offsets, which have a join in
this mode.

bpf_states_join() examines each result with the comparison that pruning
uses: the join must cover state a and state b. If it does not, the verifier
reports a verifier bug and rejects the prog. Thus an error in join.c does
not cause an unsafe prog to load.

The Makefile does not build join.c in this patch.
"bpf: Verify programs as a fixpoint over the control flow graph" builds it
and calls it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  10 +
 kernel/bpf/join.c            | 650 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |  67 ++++
 3 files changed, 727 insertions(+)
 create mode 100644 kernel/bpf/join.c

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5c5851cb048c..8001be4c3626 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1236,6 +1236,7 @@ struct bpf_verifier_env {
 	struct bpf_iarray *gotox_tmp_buf;
 	int *idoms;
 	struct scev *scev;
+	struct bpf_join_state *join;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
@@ -1417,6 +1418,12 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
 int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx);
+/* join.c */
+int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst,
+		    const struct bpf_verifier_state *a, const struct bpf_verifier_state *b,
+		    bool widen);
+void bpf_join_free(struct bpf_verifier_env *env);
+
 int bpf_insert_unwound_reports(struct bpf_verifier_env *env);
 int bpf_split_cur_state(struct bpf_verifier_env *env);
 int bpf_update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
@@ -1918,6 +1925,9 @@ int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		      struct cnum64 r64, struct cnum32 r32, u16 base, u16 step);
 bool bpf_reg_range_is_empty(struct cnum64 r64, struct cnum32 r32, u16 base, u16 step);
 bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_reg_state *b);
+void bpf_reg_union_range(struct bpf_reg_state *acc, const struct bpf_reg_state *src);
+void bpf_reg_forget_range(struct bpf_reg_state *reg);
+void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *old);
 int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
 		  const struct bpf_reg_state *src);
 
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
new file mode 100644
index 000000000000..dde40dc4ff4f
--- /dev/null
+++ b/kernel/bpf/join.c
@@ -0,0 +1,650 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Join of verifier states.
+ *
+ * bpf_states_join(dst, a, b) computes the state that describes every concrete
+ * state described by 'a' or by 'b'. With @widen what is larger in the result
+ * than in 'a' is not known at all in the result, so that a sequence of states
+ * at a loop head ends.
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
+ * both sides then.
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
+/*
+ * Join of the range of two registers of the same type, numbers or pointers
+ * with variable offset. @dst is a copy of @ra.
+ */
+static void join_range(struct bpf_join_state *js, struct bpf_reg_state *dst,
+		       const struct bpf_reg_state *ra, const struct bpf_reg_state *rb)
+{
+	if (range_equal(ra, rb))
+		return;
+	bpf_reg_union_range(dst, rb);
+	if (!js->widen || range_equal(dst, ra))
+		return;
+	if (dst->type == SCALAR_VALUE)
+		bpf_reg_widen_range(dst, ra);
+	else
+		bpf_reg_forget_range(dst);
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
+		if (!js->widen && !ra->id && !rb->id && ra->range >= 0 &&
+		    tnum_is_const(ra->var_off) && tnum_is_const(rb->var_off) &&
+		    ra->var_off.value != rb->var_off.value &&
+		    ra->var_off.value <= MAX_PACKET_OFF && rb->var_off.value <= MAX_PACKET_OFF)
+			return false;
+		/* how much of the packet was checked goes with numbers elsewhere in the state */
+		if (!js->widen && ra->range != rb->range)
+			return false;
+		/* displacements between pointers that share an id are kept */
+		if ((ra->id || rb->id) && ra->r64.base != rb->r64.base)
+			return false;
+		if (pass == 1) {
+			jid_note(js, ra->id, rb->id, true);
+			return true;
+		}
+		if (!jid_strict_ok(js, ra->id, rb->id))
+			return false;
+		if (rb->range != ra->range)
+			dst->range = min(ra->range, rb->range);
+		join_range(js, dst, ra, rb);
+		return true;
+	case PTR_TO_ARENA:
+		/* The offset is not tracked. */
+		return true;
+	case PTR_TO_INSN:
+		if (!reg_fixed_part_equal(ra, rb))
+			return false;
+		if (pass == 2)
+			join_range(js, dst, ra, rb);
+		return true;
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
+	join_range(js, dst, ra, rb);
+	return true;
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
+static bool slot_is_full_spill(const struct bpf_stack_state *s)
+{
+	int i;
+
+	for (i = 0; i < BPF_REG_SIZE; i++)
+		if (s->slot_type[i] != STACK_SPILL)
+			return false;
+	return true;
+}
+
+/* All bytes are initialized and none of them is a part of a spill */
+static bool slot_is_data(const struct bpf_stack_state *s)
+{
+	int i;
+
+	for (i = 0; i < BPF_REG_SIZE; i++)
+		if (s->slot_type[i] != STACK_MISC && s->slot_type[i] != STACK_ZERO)
+			return false;
+	return true;
+}
+
+/* what a byte that is not initialized in one of the states becomes */
+static u8 stype_uninit(struct bpf_join_state *js)
+{
+	return js->env->allow_uninit_stack ? STACK_INVALID : STACK_POISON;
+}
+
+static void slot_poison(struct bpf_join_state *js, struct bpf_stack_state *ds)
+{
+	int i;
+
+	for (i = 0; i < BPF_REG_SIZE; i++)
+		if (ds->slot_type[i] != STACK_POISON)
+			ds->slot_type[i] = stype_uninit(js);
+	bpf_mark_reg_not_init(js->env, &ds->spilled_ptr);
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
+		/* iter.depth is not a part of the state, see stacksafe() */
+		if (ra->type != rb->type || ra->iter.btf != rb->iter.btf ||
+		    ra->iter.btf_id != rb->iter.btf_id || ra->iter.state != rb->iter.state)
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
+	bool a_ptr, b_ptr, had_spill;
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
+	/* scalar spills, MISC, ZERO, INVALID, POISON: no ids are kept */
+	if (pass == 1)
+		return true;
+
+	had_spill = slot_has_spill(sa) || slot_has_spill(sb);
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
+			res[i] = stype_uninit(js);
+		else if (x == y)
+			res[i] = x;
+		else
+			res[i] = STACK_MISC;
+	}
+	/*
+	 * When reads of uninitialized stack are not allowed stacksafe() accepts
+	 * MISC in place of a spilled scalar only for whole slots.
+	 */
+	if (had_spill && !js->env->allow_uninit_stack) {
+		bool ok = (slot_is_full_spill(sa) || slot_is_data(sa)) &&
+			  (slot_is_full_spill(sb) || slot_is_data(sb));
+
+		for (i = 0; ok && i < BPF_REG_SIZE; i++)
+			ok = res[i] == STACK_MISC;
+		if (!ok) {
+			slot_poison(js, ds);
+			return true;
+		}
+	}
+	memcpy(ds->slot_type, res, sizeof(res));
+	bpf_mark_reg_not_init(js->env, &ds->spilled_ptr);
+	return true;
+}
+
+static bool join_loop_stack(const struct bpf_func_state *fa, const struct bpf_func_state *fb)
+{
+	u32 i;
+
+	if (fa->loop_stack_cnt != fb->loop_stack_cnt)
+		return false;
+	/* what is known about a counted loop comes from the state it was entered with */
+	for (i = 0; i < fa->loop_stack_cnt; i++)
+		if (fa->loop_stack[i].loop_id != fb->loop_stack[i].loop_id ||
+		    fa->loop_stack[i].terminates != fb->loop_stack[i].terminates ||
+		    fa->loop_stack[i].apart != fb->loop_stack[i].apart ||
+		    fa->loop_stack[i].trip != fb->loop_stack[i].trip ||
+		    fa->loop_stack[i].max_header_count != fb->loop_stack[i].max_header_count ||
+		    fa->loop_stack[i].entry_state != fb->loop_stack[i].entry_state)
+			return false;
+	return true;
+}
+
+static bool join_func(struct bpf_join_state *js, struct bpf_func_state *fd,
+		      const struct bpf_func_state *fa, const struct bpf_func_state *fb,
+		      u16 live_regs, int pass)
+{
+	static const struct bpf_reg_state not_init = { .type = NOT_INIT };
+	struct bpf_verifier_env *env = js->env;
+	u32 i, nslots_b;
+
+	if (pass == 1) {
+		if (fa->callsite != fb->callsite || fa->frameno != fb->frameno ||
+		    fa->subprogno != fb->subprogno)
+			return false;
+		if (fa->in_callback_fn != fb->in_callback_fn ||
+		    fa->in_async_callback_fn != fb->in_async_callback_fn ||
+		    fa->in_exception_callback_fn != fb->in_exception_callback_fn ||
+		    fa->in_rcu_callback_fn != fb->in_rcu_callback_fn ||
+		    fa->async_entry_cnt != fb->async_entry_cnt ||
+		    memcmp(&fa->callback_ret_range, &fb->callback_ret_range,
+			   sizeof(fa->callback_ret_range)))
+			return false;
+		if (!join_loop_stack(fa, fb))
+			return false;
+	}
+
+	for (i = 0; i < MAX_BPF_REG; i++) {
+		if (!(live_regs & BIT(i))) {
+			if (pass == 2 && i < BPF_REG_FP)
+				bpf_mark_reg_not_init(env, &fd->regs[i]);
+			continue;
+		}
+		if (!join_reg(js, &fd->regs[i], &fa->regs[i], &fb->regs[i], pass))
+			return false;
+	}
+
+	nslots_b = bpf_stack_nr_slots(fb);
+	for (i = 0; i < bpf_stack_nr_slots(fa); i++) {
+		const struct bpf_stack_state *sb = i < nslots_b ? bpf_stack_slot(fb, i) : NULL;
+
+		if (!join_slot(js, bpf_stack_slot(fd, i), bpf_stack_slot(fa, i), sb, pass))
+			return false;
+	}
+	/* Slots that exist only in 'b' are STACK_INVALID in the result. */
+	for (i = bpf_stack_nr_slots(fa); pass == 1 && i < nslots_b; i++) {
+		const struct bpf_stack_state *sb = bpf_stack_slot(fb, i);
+
+		if (slot_is_special(sb) ||
+		    (slot_has_spill(sb) && sb->spilled_ptr.type != SCALAR_VALUE))
+			return false;
+	}
+
+	if (fa->out_stack_arg_cnt < fb->out_stack_arg_cnt)
+		return false;
+	for (i = 0; i < fa->out_stack_arg_cnt; i++) {
+		const struct bpf_reg_state *rb;
+
+		rb = i < fb->out_stack_arg_cnt ? &fb->stack_arg_regs[i] : &not_init;
+		if (!join_reg(js, &fd->stack_arg_regs[i], &fa->stack_arg_regs[i], rb, pass))
+			return false;
+	}
+
+	if (pass == 2) {
+		fd->no_stack_arg_load = fa->no_stack_arg_load || fb->no_stack_arg_load;
+		fd->callback_depth = min(fa->callback_depth, fb->callback_depth);
+	}
+	return true;
+}
+
+/* Things that can't be different in two states that are joined */
+static bool join_check_state(const struct bpf_verifier_state *a,
+			     const struct bpf_verifier_state *b)
+{
+	int i;
+
+	if (a->curframe != b->curframe || a->insn_idx != b->insn_idx)
+		return false;
+	if (a->speculative != b->speculative || a->in_sleepable != b->in_sleepable ||
+	    a->in_callback != b->in_callback || a->callers_unknown != b->callers_unknown ||
+	    a->unwound != b->unwound)
+		return false;
+	if (a->active_locks != b->active_locks ||
+	    a->active_preempt_locks != b->active_preempt_locks ||
+	    a->active_rcu_locks != b->active_rcu_locks ||
+	    a->active_lock_ptr != b->active_lock_ptr ||
+	    !a->active_irq_id != !b->active_irq_id ||
+	    !a->active_lock_id != !b->active_lock_id)
+		return false;
+	if (a->acquired_refs != b->acquired_refs)
+		return false;
+	for (i = 0; i < a->acquired_refs; i++) {
+		if (a->refs[i].type != b->refs[i].type)
+			return false;
+		switch (a->refs[i].type) {
+		case REF_TYPE_PTR:
+		case REF_TYPE_IRQ:
+			break;
+		default:
+			if (a->refs[i].ptr != b->refs[i].ptr)
+				return false;
+		}
+	}
+	return true;
+}
+
+static void join_refs_note(struct bpf_join_state *js, const struct bpf_verifier_state *a,
+			   const struct bpf_verifier_state *b)
+{
+	int i;
+
+	jid_note(js, a->active_irq_id, b->active_irq_id, true);
+	jid_note(js, a->active_lock_id, b->active_lock_id, true);
+	for (i = 0; i < a->acquired_refs; i++) {
+		jid_note(js, a->refs[i].id, b->refs[i].id, true);
+		if (a->refs[i].type == REF_TYPE_PTR)
+			jid_note(js, a->refs[i].parent_id, b->refs[i].parent_id, true);
+	}
+}
+
+static bool join_refs_check(struct bpf_join_state *js, const struct bpf_verifier_state *a,
+			    const struct bpf_verifier_state *b)
+{
+	int i;
+
+	if (!jid_strict_ok(js, a->active_irq_id, b->active_irq_id) ||
+	    !jid_strict_ok(js, a->active_lock_id, b->active_lock_id))
+		return false;
+	for (i = 0; i < a->acquired_refs; i++) {
+		if (!jid_strict_ok(js, a->refs[i].id, b->refs[i].id))
+			return false;
+		if (a->refs[i].type == REF_TYPE_PTR &&
+		    !jid_strict_ok(js, a->refs[i].parent_id, b->refs[i].parent_id))
+			return false;
+	}
+	return true;
+}
+
+/* The result has to describe everything that an input describes */
+static int join_check(struct bpf_join_state *js, struct bpf_verifier_state *dst,
+		      const struct bpf_verifier_state *in, const char *which)
+{
+	struct bpf_verifier_env *env = js->env;
+
+	if (bpf_state_subsumes(env, dst, (struct bpf_verifier_state *)in))
+		return 0;
+	bpf_log(&env->log, "join:");
+	print_verifier_state(env, dst, dst->curframe, true);
+	bpf_log(&env->log, "input %s:", which);
+	print_verifier_state(env, in, in->curframe, true);
+	verifier_bug(env, "join of states at insn %u does not subsume input '%s'",
+		     dst->insn_idx, which);
+	return -EFAULT;
+}
+
+/*
+ * Compute in @dst the state that describes everything that @a or @b describe.
+ * @dst has to be a valid state (zeroed is fine) different from @a and @b, its
+ * previous content is released. Bookkeeping fields are copied from @a.
+ *
+ * Returns 0 on success, 1 if there is no join, negative error otherwise.
+ * When 1 is returned the content of @dst is undefined, but it's a valid state.
+ */
+int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst,
+		    const struct bpf_verifier_state *a, const struct bpf_verifier_state *b,
+		    bool widen)
+{
+	struct bpf_join_state *js = join_state(env);
+	int pass, fr, err;
+
+	if (!js)
+		return -ENOMEM;
+	js->widen = widen;
+	js->npairs = 0;
+	js->pairs_overflow = false;
+
+	if (!join_check_state(a, b))
+		return 1;
+	err = bpf_copy_verifier_state(dst, a);
+	if (err)
+		return err;
+
+	for (pass = 1; pass <= 2; pass++) {
+		if (pass == 1)
+			join_refs_note(js, a, b);
+		else if (!join_refs_check(js, a, b))
+			return 1;
+		for (fr = 0; fr <= a->curframe; fr++) {
+			u32 insn_idx = bpf_frame_insn_idx((struct bpf_verifier_state *)a, fr);
+			u16 live_regs = env->insn_aux_data[insn_idx].live_regs_before;
+
+			if (!join_func(js, dst->frame[fr], a->frame[fr], b->frame[fr],
+				       live_regs, pass))
+				return 1;
+		}
+	}
+
+	return join_check(js, dst, a, "a") ?: join_check(js, dst, b, "b");
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b44a5c63a922..bb42c2707db2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17867,6 +17867,73 @@ bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_re
 	       a->id == b->id && a->parent_id == b->parent_id && a->map_uid == b->map_uid;
 }
 
+/* Nothing is known about the number or the variable part of the offset anymore. */
+void bpf_reg_forget_range(struct bpf_reg_state *reg)
+{
+	reg->var_off = tnum_unknown;
+	__mark_reg_unbounded(reg);
+	reg_step_reset(reg);
+}
+
+/*
+ * @reg is what @old became after a trip around a cycle, @old included. The end
+ * of the range that moved is going to move again. Put it where it may come
+ * to rest. There are few such places, so this is done a few times at most.
+ */
+void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *old)
+{
+	s64 min = reg_smin(reg), max = reg_smax(reg);
+
+	if (max > reg_smax(old))
+		max = max <= 0 ? 0 :
+		      max <= S32_MAX ? S32_MAX :
+		      max <= U32_MAX ? U32_MAX : S64_MAX;
+	if (min < reg_smin(old))
+		min = min >= 0 ? 0 :
+		      min >= S32_MIN ? S32_MIN : S64_MIN;
+	if (min == S64_MIN && max == S64_MAX) {
+		bpf_reg_forget_range(reg);
+		return;
+	}
+	/* every part has to include what it did before, hence no reg_bounds_sync() */
+	reg->r64 = cnum64_union(reg->r64, cnum64_from_srange(min, max));
+	if (min >= 0 && max <= U32_MAX) {
+		reg->r32 = cnum32_union(reg->r32, cnum32_from_urange(min, max));
+		reg->var_off = tnum_union(reg->var_off, tnum_range(min, max));
+	} else if (min >= S32_MIN && max <= S32_MAX) {
+		reg->r32 = cnum32_union(reg->r32, cnum32_from_srange(min, max));
+		reg->var_off = tnum_unknown;
+	} else {
+		reg->r32 = CNUM32_UNBOUNDED;
+		reg->var_off = min >= 0 ? tnum_union(reg->var_off, tnum_range(min, max))
+					: tnum_unknown;
+	}
+	reg_step_reset(reg);
+}
+
+void bpf_reg_union_range(struct bpf_reg_state *acc, const struct bpf_reg_state *src)
+{
+	u16 base, step;
+
+	acc->r64 = cnum64_union(acc->r64, src->r64);
+	acc->r32 = cnum32_union(acc->r32, src->r32);
+	acc->var_off = tnum_union(acc->var_off, src->var_off);
+
+	/* Retain a common congruence if the bases agree modulo the gcd. */
+	step = gcd(acc->step, src->step);
+	base = acc->base % step;
+	if (base != src->base % step) {
+		reg_step_reset(acc);
+	} else {
+		acc->base = base;
+		acc->step = step;
+	}
+	/*
+	 * No reg_bounds_sync(): every part of the result has to include that
+	 * part of both inputs, and an input is not always in sync.
+	 */
+}
+
 /*
  * Extends acc's scalar range to include src's scalar range.
  * Caller must ensure that other kinds of metadata is compatible.
-- 
2.55.0

