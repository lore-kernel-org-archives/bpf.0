Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206928;
	b=zPqedq8dGFi/OpJmi3AWXlXrOrrgr68xWOZrm26JLa7Rkm6IixhLqqJZ2tTDYqsx/yLc
	 iwJQeCG2nOORKYWxcY6bUCHBfb0f7I48jgnSf15U/HRAV9Bg99sHqvz2KQRQb/cQ/pvlE
	 777Ql7XS1i+betljq7HMGyVRf4ReyHIyp0fSQIsFdtKLzt0h61nNqgmMsyPYSxuhYp5Ji
	 IlLvKmwD0uFwAKBesopU6Zd5VEglemGM9J+pn2wR5tC+SyPVr2X1yF0go/+1c8DoMa6zn
	 eyP4nrlkz8x/pgwL1O98f2uKdSgXhA8Ut2v+hEFmVhWuXUsQS44uPqFMst6PM6U6NWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=phYaBaZG0Yujdj2wqsdaT8fS36wHjlOvTRpM8DH33rw=;
	b=ePhofeCHw/fQkK4NePN8KMH9dHSIGCf/iyIMQn/YazE7J30mt1YzZx0gcXHjFCeReUn0
	 Mo9Z+Dn8vz8iOPeyJA9ZcGWvFg0zNdKcz8P7HoPYIIzN4aAfAZ+OKBr6zpxluhKFrNKp3
	 gc7ZTHVrj8dZHlgs5g76QhPcikY60lvkq3VV9+QXJe1ehhha+2uBMDD4j3vPjZu+bZ48z
	 g8xXL+WDQQqUabp7K4ihEOlzSdetrfdkCiB0DCyqPWHa+MGAMQpI78sJO1QENyBZKsr9I
	 ES555xPQjvJz5bi+pVjzJY2lcf3RMj9XXN/PSFBNSPyK2H83SHaqmTGCVdU0nfoOnWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XgYl8OHb;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14F6606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C14F6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XgYl8OHb
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b9c51097e2so45883b3a.1
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206927; x=1794811727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=phYaBaZG0Yujdj2wqsdaT8fS36wHjlOvTRpM8DH33rw=;
        b=XgYl8OHbmP5/yyxKIylSN3BVGnCNdgQLNaJBswoWASrIfz5hbnvMH1MwUayOHpsRMu
         0bNLpJFVFnSZ1IG8ZjscMUwFYLGZ+ItrnW884pVcWmRYEB0kdecEsvKY275HqsDZMN3R
         RXfMptofCico45ne1ASNHcZlkB+GOMpDCPC3btGZrek7eSE43mpG4Arj/gEuF2z+eDP1
         RL1f6/BD8PYV6OiFAUOGNec9BVQdJY6pPtTBrY02c0Zm0RupbBOKqhycnO2fB2hi2qKX
         ZbB+2t0HOwD7+9f/hD53CQo8suN/RYaLVPs+Hej7xmHvQLraue+smltjJJOp98vtjchx
         lUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206927; x=1794811727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=phYaBaZG0Yujdj2wqsdaT8fS36wHjlOvTRpM8DH33rw=;
        b=F87gNXIfjc2Mp9GVee2BixliImH3TmQhvFBJEG1j7aHC9DeNwPa4PzuJEV8NsVrewi
         Ibgt+aPrARHBkCEfYZn0ZQJmRRVZkb7E8UBMt0BqK2ylZmf8EGCjuwcL8uVkMQs1cEUs
         1br1WPd8FTK5gwzYLeIuVqHQ6YTn/MhF8pnuFCwXz/L/LEibsDfj23ylobXlQvWsbpDR
         bs6NW1tGAi9slOzcd+wI9iMxUl7e/GqGFWM2ccRWwJwccfJGTt0wuN9xS+kNAiiLU4LE
         3X3U95y8COKh91uhsT2ySRyuQmzISC1vFnoSk4CiVD8wtuf71z4fH0Let4HKB3a81ZQO
         FePg==
X-Gm-Message-State: APuU4Z+CguUcrJkw9TdQTQselnKTtabaVNIMoAnSev1UB8MojPJuSMOo
	a0r8mrmhvq3/jG3lWG4imetUbS8U5C9VFu6SCTMgZLpauKXn6ozRmEmImc4+8Q==
X-Gm-Gg: AYBFou0g/dpODPxPEhcaVujkUzhIPoom+RA+H4Iv9U0irTpvV8SqxNaZ22///qp4Mc8
	nFRyCbr2tZGp9J+z46hvPPyILC8Z7gsUHqo/d6taN4SZ0m4ea2Q8Wtc/gMFG3nuw74smpdNJDBm
	bgNUNyVkVLM9Ua/FwWHd1X9BZG+Gcu3nGTwHMku96DcqqNOHdGm2gjcpd2Mby2qDk9tz3YyEWf+
	Nsj7G9MqR8JmKtzh/B3tidhxXGWXYDtl4VTLTIYYWuqnx1Oc6yKqiz1psajiPIRBsEOpjVm9t8M
	K/OdNPq6FAXUaly0PU367Nst9YicVVn+jF025xXh3us1uFIuOaOH3w6cZc+d8rrkIZjBJ8i/tot
	nskx0A41BtJ4LNGlNp5HmqPUcfbDj0ZNNQoPi+xQIwnn1JYJGnsfnqYhFV4hlPM5CZc4ZvBQ3DZ
	KondpDHv+sYTbaBHzpO0KNm+bK8lHpeNAMKErYrImU+OE8wnQfmlMlhVkym6gpL0Rr3aQpY/iVw
	aJudIqh+gIFh/4Fnfa9rwgxyV6C89ZhIxgdCiG/+5EYLtAloT6e8irKop1LsTA1SaZQr3MeWKW1
	b9GBczDEzd6Fbz4yTP4VfjSf1rPemJb+OVxUvA3TOnZ8V0KDb5nOU3j7b5MgBiYTl8BQG9k3y5h
	YO9x20mQbj3mYVzFU7q8aEc+RLgn4bKWKa/+2tGQxTHZyS+rZ8AO8+sLTw8U7Na4bzAkheXMKCw
	==
X-Received: by 2002:a05:6a21:8217:b0:3e1:2881:1c0e with SMTP id adf61e73a8af0-3eecfb7977cmr3836380637.2.1794206926692;
        Sun, 08 Nov 2026 22:48:46 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb9681871asm1388997a12.9.2026.11.08.22.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:48:46 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 15/26] bpf: Recompute a pointer after the jump that bounds its index
Date: Mon,  9 Nov 2026 06:46:59 +0000
Message-ID: <20261109064715.2382452-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
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

A new ability. It extends the patch that refines linked registers at
conditional jumps to 'p = buf + i' that is computed before i is bounded.
Nothing links a pointer to its index today.

	while (buf[i]) {
		if (i < 0 || i > 32)
			break;
		if (bpf_map_lookup_elem(&names, buf + i))
			return 0;
		while (buf[i++] && i < 32)
			;
	}

Strings are stored back to back in a map value of 64 bytes, a key has 32.
clang computes 'buf + i' for the load at the end of an iteration and tests
i at the start of the next one. The jumps bound r8, the offset of r2 stays:

	27: r2 = r6
	28: r2 += r8
	30: r1 = *(u8 *)(r2 +0)
	36: if r8 s> 0x20 goto pc-4
	38: if r8 s< 0x0 goto pc-6
	41: call bpf_map_lookup_elem#1
	invalid access to map value, value_size=64 off=33 size=32

The linked registers of a conditional jump are the live registers and
stack slots that are a tested register + a constant on every path to the
jump. bpf_scev_next_linked_reg() gets one more result. A linked register
can be a pointer: *base_regno + regno + delta. *base_regno is the address
base, as in store_base_regs. Here r2 == r6 + r8.

So 'r2 = r6; r2 += r8' after the jump would change no value at run time,
and a state that is sound before two insns is sound after them.
recompute_ptr() applies their transfer function. Type, object and offset of
r2 are taken from r6 as it is now; how r2 was computed does not matter. The
range is that of r8 after the jump.

match_linked_add(): the expression of r2 is (+ x y), y has a constant
difference from the tested register, and a live register or stack slot has
one from x. At a loop header r2 is a phi. There ADD_SCEV has its operands:

	scev at header 35:
	  r2=(+ r6 %r8.21?) / (add r6 r8)
	  r8=%r8.21?

(add r6 r8): r2 == r6 + r8 at the header in every iteration. It holds at
loop entry, where r2 is r6 and r8 is 0. Every backedge preserves it: the
backedge values, before the '/', are r6 + %r8.21? and %r8.21?, the def of
r8 by the nested loop at 21. r6 and r8 are the header phis here, not the
entry values as below LINEAR_SCEV.

recompute_ptr() replaces r2 only if
 - r6 is a pointer that may have a variable offset, and no packet pointer,
 - type, object and ids of r6 are those of r2,
 - the new range is a subset of the old one,
 - the loader has CAP_PERFMON: the cpu can speculate past the jump with an
   out-of-bounds index.
The old offset is replaced, not intersected: a state cannot distinguish two
values of a hash map, so the two offsets may belong to two objects. In
a prog with an arena the add has a def, %r2.28=(add r6 r8), and is trusted
once the main pass has verified insn 28 without an arena pointer.

Not found: 'buf += i', which overwrites the base, and an add whose base is
dead at the jump. No register holds buf there.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   4 +-
 kernel/bpf/scev.c            | 174 +++++++++++++++++++++++++++++++----
 kernel/bpf/verifier.c        |  49 +++++++++-
 3 files changed, 204 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 18f0736fccb7..651174144f5f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2226,7 +2226,9 @@ void bpf_free_scev(struct bpf_verifier_env *env);
 int bpf_compute_scev(struct bpf_verifier_env *env);
 int bpf_scev_jump_counts(struct bpf_verifier_env *env, int header, int n, bool taken_leaves);
 bool bpf_scev_next_linked_reg(struct bpf_verifier_env *env, int insn_idx, u32 regno, u32 *pos,
-			      u32 *linked_regno, u32 *fill_off, s64 *delta, u32 *bits);
+			      u32 *linked_regno, u32 *fill_off, int *base_regno, s64 *delta,
+			      u32 *bits);
+bool bpf_is_widenable_reg_type(const struct bpf_reg_state *reg);
 bool bpf_scev_in_slice_slots(struct bpf_verifier_env *env, int off, u32 size);
 
 int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index dfbad71bba55..0bb52ca8aa56 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -50,6 +50,11 @@ enum expr_op {
 	 * equal when the loop is entered. Not known otherwise.
 	 */
 	COPY_SCEV,
+	/*
+	 * (add rB rC) is the SCEV of rA: rA == rB + rC at the header in every iteration. rB and rC
+	 * are the header phis here, not the entry values as below LINEAR_SCEV.
+	 */
+	ADD_SCEV,
 };
 
 /*
@@ -65,9 +70,9 @@ enum expr_op {
  * In the env of loop H a phi at H merges the backedge values only, the header phi itself is
  * (REG r). In the env of the enclosing loop a phi at H merges the entering edges.
  * Op and params of a def by an insn are what that insn computes, see alu64_with_def():
- * set_expr_base() looks through such an add, split_const_offset() checks prevent_zext of the insn.
- * Those of a phi are the shape that its operands share, no insn computes them: nothing looks
- * through a phi.
+ * set_expr_base() and match_linked_add() look through such an add, split_const_offset() and
+ * match_linked_add() check prevent_zext of the insn. Those of a phi are the shape that its operands
+ * share, no insn computes them: nothing looks through a phi.
  */
 struct expr_def {
 	u32 set:1;	/* 0: the expression has no def */
@@ -250,6 +255,8 @@ static bool expr_is_vn(struct scev *scev, struct expr *e)
 	/* a function of the iteration number */
 	case LINEAR_SCEV:
 	case COPY_SCEV:
+	/* a relation between header phis */
+	case ADD_SCEV:
 		return false;
 	}
 	for (i = 0; i < op_params_num(e->op); i++)
@@ -553,6 +560,7 @@ static const char *op_str(u32 op)
 	case ANY:      return "any";
 	case LINEAR_SCEV:  return "linear";
 	case COPY_SCEV:    return "copy";
+	case ADD_SCEV:     return "add";
 	}
 	return NULL;
 }
@@ -576,6 +584,7 @@ static u32 op_params_num(u32 op)
 	case ANY:
 	case LINEAR_SCEV:
 	case COPY_SCEV:
+	case ADD_SCEV:
 		return 2;
 	case BPF_NEG:
 	case SEXT8:
@@ -1846,6 +1855,41 @@ static bool const_diff_at_header(struct bpf_verifier_env *env, int h, u32 ra, u3
 	       bits_a == 64 && bits == 64;
 }
 
+/*
+ *	p = buf + i; if (i > 100) return 0; *p = 0;
+ * @tested is the expression of the tested register and @id that of p, in one env as for
+ * const_diff(). Is @id an add, and one operand @tested + a constant? Then
+ * @id == *@other + @tested + *@delta (mod 2^*@bits). A header phi can be an add, see ADD_SCEV. For
+ * an add with a def see split_const_offset(). Which operand is the pointer is not known here.
+ */
+static bool match_linked_add(struct bpf_verifier_env *env, int h, u32 tested, u32 id, u32 *other,
+			     s64 *delta, u32 *bits)
+{
+	struct scev *scev = env->scev;
+	u32 reg, r, b, op = BPF_ADD;
+	struct expr_def def;
+	s64 c;
+
+	split_const_offset(env, id, &id, delta, bits);
+	if (h >= 0 && is_reg(scev, id, &reg)) {
+		id = find_header_env(scev, h)->reg2scev[reg];
+		op = ADD_SCEV;
+	}
+	def = scev->exprs[id].def;
+	if (!is_binop(scev, op, id, other, &r) || def.phi)
+		return false;
+	if (def.set && !env->insn_aux_data[def.idx].prevent_zext)
+		*bits = min(*bits, 32);
+	if (!const_diff(env, h, tested, r, &c, &b)) {
+		swap(*other, r);
+		if (!const_diff(env, h, tested, r, &c, &b))
+			return false;
+	}
+	*delta = (u64)*delta + c;
+	*bits = min(*bits, b);
+	return true;
+}
+
 /* The first bytes of a stack slot are its high bits */
 static bool is_big_endian_slot(u32 reg)
 {
@@ -1897,9 +1941,10 @@ static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h,
 	u32 dst = e->reg2expr[insn->dst_reg], src = dst;
 	struct insn_envs *envs = env->scev->envs[idx];
 	struct scev *scev = env->scev;
-	u32 r, id, fill_off, base, base_dst, base_src, bits, cap, tested = 0;
+	u32 r, q, other, id, fill_off, base, base_dst, base_src, bits, cap, tested = 0;
 	u32 first = scev->linked_cnt;
 	DECLARE_BITMAP(live, REGS_NUM) = {};
+	DECLARE_BITMAP(found, REGS_NUM) = {};
 	void *tmp;
 	s64 delta;
 
@@ -1916,12 +1961,27 @@ static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h,
 		id = e->reg2expr[r];
 		/* most are not linked */
 		split_const_offset(env, id, &base, &delta, &bits);
-		if (base != base_dst && base != base_src && (h < 0 || !is_op(scev, base, REG)) &&
-		    !is_big_endian_slot(r))
+		if (base != base_dst && base != base_src && !is_op(scev, base, BPF_ADD) &&
+		    (h < 0 || !is_op(scev, base, REG)) && !is_big_endian_slot(r))
 			continue;
-		if (!const_diff_reg(env, h, dst, r, id, &fill_off, &delta, &bits) &&
-		    (src == dst || !const_diff_reg(env, h, src, r, id, &fill_off, &delta, &bits)))
+		if (const_diff_reg(env, h, dst, r, id, &fill_off, &delta, &bits) ||
+		    (src != dst && const_diff_reg(env, h, src, r, id, &fill_off, &delta, &bits))) {
+			__set_bit(r, found);
+			continue;
+		}
+		if (!match_linked_add(env, h, dst, id, &other, &delta, &bits) &&
+		    (src == dst || !match_linked_add(env, h, src, id, &other, &delta, &bits)))
 			continue;
+		/* an add is of use only with a live register that holds its other operand */
+		for_each_set_bit(q, live, REGS_NUM) {
+			if (q == r || !const_diff(env, h, e->reg2expr[q], other, &delta, &bits))
+				continue;
+			__set_bit(r, found);
+			__set_bit(q, found);
+			break;
+		}
+	}
+	for_each_set_bit(r, found, REGS_NUM) {
 		if (scev->linked_cnt == scev->linked_cap) {
 			cap = max(scev->linked_cap * 2, 16);
 			tmp = kvrealloc(scev->linked, array_size(cap, sizeof(*scev->linked)),
@@ -1933,7 +1993,7 @@ static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h,
 		}
 		tested += r == insn->dst_reg || (src != dst && r == insn->src_reg);
 		scev->linked[scev->linked_cnt].reg = r;
-		scev->linked[scev->linked_cnt++].id = id;
+		scev->linked[scev->linked_cnt++].id = e->reg2expr[r];
 	}
 	/* nothing but the tested registers */
 	if (scev->linked_cnt - first == tested) {
@@ -1957,14 +2017,18 @@ static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h,
  * the same frame. It is a register, or MAX_BPF_REG + the index of a stack slot: a fill from byte
  * *@fill_off of the slot reads these bits. *@pos is the position of the search, 0 at first. False:
  * no more links are known. Types are not known here: the caller checks them in its state.
+ * A linked register can be a pointer: *base_regno + regno + delta. *base_regno is the address base,
+ * as in store_base_regs. It is -1 for a link without a base.
  */
 bool bpf_scev_next_linked_reg(struct bpf_verifier_env *env, int insn_idx, u32 regno, u32 *pos,
-			      u32 *linked_regno, u32 *fill_off, s64 *delta, u32 *bits)
+			      u32 *linked_regno, u32 *fill_off, int *base_regno, s64 *delta,
+			      u32 *bits)
 {
 	struct insn_envs *envs = env->scev->envs[insn_idx];
 	int h = bpf_loop_at_index(env, insn_idx);
 	struct scev_linked_reg *linked;
-	u32 i;
+	u32 i, j, other, b;
+	s64 c;
 
 	if (!envs || !envs->linked_cnt)
 		return false;
@@ -1975,10 +2039,22 @@ bool bpf_scev_next_linked_reg(struct bpf_verifier_env *env, int insn_idx, u32 re
 			return false;
 	for (; *pos < envs->linked_cnt; ++*pos) {
 		*linked_regno = linked[*pos].reg;
-		if (*pos != i &&
-		    const_diff_reg(env, h, linked[i].id, *linked_regno, linked[*pos].id, fill_off,
+		*base_regno = -1;
+		if (*pos == i)
+			continue;
+		if (const_diff_reg(env, h, linked[i].id, *linked_regno, linked[*pos].id, fill_off,
 				   delta, bits))
 			return true;
+		if (!match_linked_add(env, h, linked[i].id, linked[*pos].id, &other, delta, bits))
+			continue;
+		for (j = 0; j < envs->linked_cnt; j++) {
+			if (j == *pos || !const_diff(env, h, linked[j].id, other, &c, &b))
+				continue;
+			*base_regno = linked[j].reg;
+			*delta = (u64)*delta + c;
+			*bits = min(*bits, b);
+			return true;
+		}
 	}
 	return false;
 }
@@ -2445,6 +2521,64 @@ static int compute_header_scevs(struct bpf_verifier_env *env, struct env *header
 	return 0;
 }
 
+/*
+ * Find a SCEV register with the entry value @x and the backedge value @l, and one with @y and @r.
+ * All that match are copies of each other at the header: take the first.
+ */
+static bool find_operands(struct env *entry_env, struct env *header_env, u32 x, u32 y, u32 l, u32 r,
+			  u32 *rb, u32 *rc)
+{
+	for (*rb = 0; *rb < REGS_NUM; ++*rb)
+		if (entry_env->reg2expr[*rb] == x && header_env->reg2expr[*rb] == l)
+			break;
+	for (*rc = 0; *rc < REGS_NUM; ++*rc)
+		if (entry_env->reg2expr[*rc] == y && header_env->reg2expr[*rc] == r)
+			break;
+	return *rb < REGS_NUM && *rc < REGS_NUM;
+}
+
+/*
+ *	p = buf; i = 0; while (*p) { if (i > 512) break; use(p); i += len(p); p = buf + i; }
+ * rA == rB + rC holds at the header in every iteration: it holds at loop entry and every backedge
+ * preserves it. The backedge values are rA = (+ l r), rB = l, rC = r. The entry values, by the env
+ * of the enclosing loop at @h, are rA = x, rB = x, rC = 0 or rA = (+ x y), rB = x, rC = y.
+ * (add rB rC) keeps the def of (+ l r), see alu64_with_def().
+ */
+static int compute_header_adds(struct bpf_verifier_env *env, int h)
+{
+	struct scev *scev = env->scev;
+	struct env *entry_env = find_loop_env(scev, env->insn_aux_data[h].loop_header, h);
+	struct env *header_env = find_header_env(scev, h);
+	u32 ra, rb, rc, l, r, x, y, entry_expr;
+	struct expr_def def;
+	int id, zero = imm_expr(scev, 0);
+
+	if (zero < 0)
+		return zero;
+	for (ra = 0; entry_env && ra < REGS_NUM; ra++) {
+		entry_expr = entry_env->reg2expr[ra];
+		if (header_env->reg2scev[ra] != UNKNOWN_EXPR_ID ||
+		    !is_add(scev, header_env->reg2expr[ra], &l, &r) ||
+		    !scev->exprs[entry_expr].is_vn || !scev->exprs[l].is_vn ||
+		    !scev->exprs[r].is_vn)
+			continue;
+		if (!find_operands(entry_env, header_env, entry_expr, zero, l, r, &rb, &rc) &&
+		    !find_operands(entry_env, header_env, zero, entry_expr, l, r, &rb, &rc) &&
+		    (scev->exprs[entry_expr].def.set || !is_add(scev, entry_expr, &x, &y) ||
+		     (!find_operands(entry_env, header_env, x, y, l, r, &rb, &rc) &&
+		      !find_operands(entry_env, header_env, y, x, l, r, &rb, &rc))))
+			continue;
+		/* expr2() can move exprs[] */
+		def = scev->exprs[header_env->reg2expr[ra]].def;
+		id = expr_with_def(scev, expr2(scev, ADD_SCEV, REG_EXPR_ID(rb), REG_EXPR_ID(rc)),
+				   def);
+		if (id < 0)
+			return id;
+		header_env->reg2scev[ra] = id;
+	}
+	return 0;
+}
+
 /*
  * 'sum += a[i]', 'if (..) { len -= n; len -= 2; }': is 'id', what an iteration makes of
  * register 'r', the register plus or minus something, or the register as it was?
@@ -2613,9 +2747,13 @@ int bpf_compute_scev(struct bpf_verifier_env *env)
 					   find_loop_env(scev, header, idx));
 		if (err)
 			return err;
-		if (aux[idx].loop)
+		if (aux[idx].loop) {
 			scev_compute_linear_regs(scev, aux[idx].loop,
 						 find_header_env(scev, header));
+			err = compute_header_adds(env, idx);
+			if (err)
+				return err;
+		}
 		err = find_linked_regs(env, aux[idx].loop ? &scev->identity_env :
 				       find_loop_env(scev, header, idx), header, idx);
 		if (err)
@@ -3850,7 +3988,7 @@ static bool is_const_scev_reg(struct bpf_verifier_env *env, int insn_idx, u32 r)
 }
 
 /* Main logic in verifier.c forbids varying offsets for certain register types. */
-static bool is_widenable_reg_type(const struct bpf_reg_state *reg)
+bool bpf_is_widenable_reg_type(const struct bpf_reg_state *reg)
 {
 	if (type_may_be_null(reg->type))
 		return false;
@@ -3897,7 +4035,7 @@ static bool is_widenable_any(struct bpf_verifier_env *env, struct bpf_func_state
 	if (!is_any(scev, id, &l, &rr))
 		return false;
 	reg = scev_reg_for_read(env, loop_entry, r);
-	if (!reg || !is_widenable_reg_type(reg))
+	if (!reg || !bpf_is_widenable_reg_type(reg))
 		return false;
 
 	scev->stack_sz = 0;
@@ -4430,7 +4568,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		}
 		/* If SCEV for r is (linear <reg> <slope>) */
 		if (reg && is_linear_at_header(scev, cur_func, r_scev, r, &coefs) &&
-		    is_widenable_reg_type(reg)) {
+		    bpf_is_widenable_reg_type(reg)) {
 			/* 32-bit ALU operations on pointers convert them to scalars */
 			if (coefs.zext32 && reg->type != SCALAR_VALUE)
 				goto cant_widen;
@@ -4773,7 +4911,7 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 		 * bpf_compute_loop_iters() gives no range to a pointer to arena that moves, and
 		 * it does not look at dead registers. Set a range only where it would.
 		 */
-		if (!is_widenable_reg_type(entry_reg) ||
+		if (!bpf_is_widenable_reg_type(entry_reg) ||
 		    (coefs.zext32 && entry_reg->type != SCALAR_VALUE))
 			continue;
 clamp:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d980e2c60805..970211dfe38c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19774,6 +19774,39 @@ static struct bpf_reg_state *scev_reg_for_fill(struct bpf_func_state *frame, u32
 	return &ss->spilled_ptr;
 }
 
+/*
+ *	p = buf + i; if (i > 100) return 0; *p = 0;
+ * p is @dst_reg, x is @ptr_reg, i is @off_reg. Scalar evolution says that p == x + i. So the insns
+ * 'p = x; p += i' are a no-op at run time, and a state that is sound before them is sound after
+ * them: apply their transfer function. Type, object and offset of p are taken from x as it is now;
+ * how p was computed does not matter.
+ * The old p is replaced, not intersected: a state does not distinguish two values of one hash map,
+ * and the intersection of an offset into the one with an offset into the other holds for neither.
+ * It is replaced only if the new range is a subset of the old one.
+ */
+static bool recompute_ptr(struct bpf_verifier_env *env, struct bpf_reg_state *dst_reg,
+			  const struct bpf_reg_state *ptr_reg, const struct bpf_reg_state *off_reg)
+{
+	struct bpf_reg_state sum = *ptr_reg;
+
+	/* the cpu can speculate past the jump with an out-of-bounds index */
+	if (!env->bypass_spec_v1)
+		return false;
+	/* 'p += i' assigns a new id to a packet pointer */
+	if (ptr_reg->type == SCALAR_VALUE || type_is_pkt_pointer(ptr_reg->type) ||
+	    !bpf_is_widenable_reg_type(ptr_reg))
+		return false;
+	__mark_reg32_unbounded(&sum);
+	scalar_step_add(&sum, ptr_reg, off_reg);
+	sum.r64 = cnum64_add(ptr_reg->r64, off_reg->r64);
+	sum.var_off = tnum_add(ptr_reg->var_off, off_reg->var_off);
+	reg_bounds_sync(&sum);
+	if (!bpf_reg_union_compatible(dst_reg, &sum) || !cnum64_is_subset(dst_reg->r64, sum.r64))
+		return false;
+	*dst_reg = sum;
+	return true;
+}
+
 /*
  * The jump at @idx refined @regno. A register that scalar evolution links to it holds
  * @regno + delta on every path to the jump: intersect the two. The intersection is empty: no
@@ -19783,22 +19816,29 @@ static void refine_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier
 			       int idx, u32 regno)
 {
 	struct bpf_func_state *frame = vstate->frame[vstate->curframe];
-	struct bpf_reg_state *reg, implied, saved;
+	struct bpf_reg_state *reg, *base_reg, implied, saved;
 	u32 pos, linked_regno, fill_off, bits;
+	int base_regno;
 	s64 delta;
 
 	if (frame->regs[regno].type != SCALAR_VALUE)
 		return;
 	for (pos = 0;
-	     bpf_scev_next_linked_reg(env, idx, regno, &pos, &linked_regno, &fill_off, &delta,
-				      &bits);
+	     bpf_scev_next_linked_reg(env, idx, regno, &pos, &linked_regno, &fill_off, &base_regno,
+				      &delta, &bits);
 	     pos++) {
 		reg = scev_reg_for_fill(frame, linked_regno, fill_off, bits);
-		if (!reg || reg->type != SCALAR_VALUE)
+		if (!reg || (base_regno < 0 && reg->type != SCALAR_VALUE))
 			continue;
 
 		implied = frame->regs[regno];
 		add_scalar_to_reg(&implied, delta);
+		if (base_regno >= 0) {
+			base_reg = scev_reg_for_fill(frame, base_regno, 0, 64);
+			if (base_reg && bits == 64 && recompute_ptr(env, reg, base_reg, &implied))
+				goto scratch;
+			continue;
+		}
 		if (regs_fit_in_bits(reg, &implied, bits))
 			bits = 64;
 		if (bits < 32)
@@ -19811,6 +19851,7 @@ static void refine_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier
 			*reg = saved;
 			continue;
 		}
+scratch:
 		if (linked_regno < MAX_BPF_REG)
 			mark_reg_scratched(env, linked_regno);
 		else
-- 
2.55.0

