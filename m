Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415805;
	b=pFMGTqiDqQRUyVmKvD4wDBAaQiFJigJ44eew2/Vcu5sQdf4remvPLdrOlzZRsxet/Jrl
	 Uh1x3hg50ObFNmSnXZc+qvqFPPKuLTuCAUJriJ8V5GrFRFq2t1xiRlCyw+2BDrAk/sPmw
	 KcQ7TxySGFA/u2fKCmGqUlsFGlmoxZA2YA4r5lQhF2qNtMnq7EtshiHL9rqwZ5o+p4zKo
	 N118Es2wQ+jcVz+dCC1h/1JRQwu/Mb7SWemhNn1a3rZKq6Enekt+WOkx+qdoz7iCaj3ky
	 TbAVF5dBJkj6isEVA3v4tTM6bnnOGSqAx4GuXNIurApdDfD8EpvCAx7ZIbc9alYtKJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0RueakKcf/aAZBSGW9M7GoMEaRXQjHkK6zbCbzg5FXg=;
	b=t8NITtbMTbIvavjZThd2Sdeuh3eUD2fcSDCzJK/k+nrLWxKVnpCVU2qstez39B7RArPC
	 jieYIiTikiWwGI+U1ZfVzV9FpiwkAIUvbvbY2ZJzJi7pKlRDmxuvNYHZ8IAQZqMrKC/Oi
	 J4lxx8TTJ7fUpSnB/Vjt/wXp3McRPGIRiq6Qqrtr6T2NznrzLFCMZgU3yjlYzG6Ru2zII
	 nqmAr6yXkzrzk+pdaBtORShQAOlqbhWsHCSUUxePR4zonpxkMjeg0AIbhhwa17HYAcaWF
	 ap5Em3T5LJaKgyjCaCQLPTtfUk5O3+mta9oMRU902ZBh8gOO+U6sBU0MnpyBP1Iq9BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kmKd+A9p;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32907606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32907606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kmKd+A9p
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso19809a91.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415805; x=1795020605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0RueakKcf/aAZBSGW9M7GoMEaRXQjHkK6zbCbzg5FXg=;
        b=kmKd+A9pjnqC1TWT9MIjbXGb5h+eI9cPUrsENFKBp1jxkWnTi98+bFGDBK3JwUd7uF
         e6ftiufPIkhVkyMf8VD4AtPZQlGI0FQyeiKu6edifS+AUoBPvd91KeJv9hIKRQNhYH2u
         YXV1imXYFZ+EJ95k74wFTcumS8JqWE2pMGDbNZkXLWv/dEouwclHHBJ9KQkztlIDmBwr
         qizWa2eGKRYILpoMDf7HlXIXcZLOTphumG/IXKI50N+LQ+cn3CFWzDfNFzYcI3+hFlRZ
         fpOZkwLLBzDG2gqtJ0KuNcI1lfhehXVHqBDQW6pEkZnHVXg1wRLAquZcNsJ/nzMjWAzJ
         cQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415805; x=1795020605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0RueakKcf/aAZBSGW9M7GoMEaRXQjHkK6zbCbzg5FXg=;
        b=iR5h90gdaOHfZ+942//yJmq7nfHXXbyJepY6kDSfC54kchidLaeA5u0OZKIB+flqyC
         NPkKV/Xf+O63+9wH2gki+E4oMK1t3bM98D4AbcgNg/FUsfyW1tSl+7D58wVRGCOzf5H5
         11OOc+KgsFB+UGlNFSwdHkSSP2xF76OkugazkD7u73R06NY+EHQ1pCediRDwCdIJjw0w
         wXFLvSctxZatieZwRwSB5+oThlFirDz7qZvxX6d3XD9zPNzHokKMCjmMpSPiEpQt+/lS
         87tS/t5Yrd2j1wwt+d7vYMCZJ0+KFaz4kFLAlOJuiMIeNgZBEuPpAjJhDFocl+07YZoR
         cZng==
X-Gm-Message-State: APuU4Z8GZmuRsJwwAn/zZMRknJeVp96dfHFQX6d1YwvTZiPLRpjYwPRz
	pMD5ZLufOIThqr5of3ONjD1kd81FR4bAQxUG/F7SDd2CJe+xhOwOCuE7l9NQ0w==
X-Gm-Gg: AYBFou11CQ+eKfcfuDrY05Q5VnYmnRyctCPkjeqFe3bsCuf6IBoqOSa2A0KoxFcAyC4
	pztKWZnTsx5EJKQOyVlm6I7D99NBvGESHNL1Z76de7NOL54dAR46dCbDobzTsiyKBq1D6ucFWKk
	prph3SuLgsFNDrkPzmLV1Qk2b1gQLqguf+nW3RqJBpoSh4Y5ehy/O7MGvAgb/QH3KeND/4HhrP/
	1Y5/gYEpw5UOPOo3noD6RbjhTI8UQb62PpJGfbpKbQP3dftdiuzOqcJkOl4AdJCtPe6xrekrRq4
	bazQM0RgbR2goyCxpOK8ZCYyPb18CV0rGfr8QwoTO7eLC7TSOmmoKP6o24Q9nO5xC2XUl/puPAH
	Tx+X1LU7KdaoL7OVHKkmlFQuhk6d40PMBVk79ZGCwX6raemkgZz7lw2kBYRGUimDDw3Z5w9smVf
	Gm2YIjkcSLkEXS7CO53rWrP8fL9/bznaeTi3q82EgowW4C2E0gYnzDgFr3QXed81MlbNfuIH7x7
	tTs3IbrOO/5Z0RRATYv+Yng9QBT2qDdsJkIcOhHPIOPfhuBTFy4KcUDoJfVtUbiIfuGtp9gQj8j
	ykY05Msse35P0NTJyBBD0sHXUvTANZ4Zrzr4aOZ7qsjuXPsf79TJZBrey/KloLFGfDxFsTtq7ys
	F2249AIcbJIPK2UTMRnfW69c9ECj72SjOWqvjb1S+MljTPSdFEL1EHEvkaXGkhPdeuU9ebNEy8H
	xS
X-Received: by 2002:a17:90b:1812:b0:3aa:412f:b0a7 with SMTP id 98e67ed59e1d1-3b197c817e6mr34426a91.5.1794415804207;
        Wed, 11 Nov 2026 08:50:04 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c502b4sm104392a91.7.2026.11.11.08.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:50:03 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/6] bpf: Add struct scalar
Date: Wed, 11 Nov 2026 16:49:45 +0000
Message-ID: <20261111164950.2674588-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164950.2674588-1-alexei.starovoitov@gmail.com>
References: <20261111164950.2674588-1-alexei.starovoitov@gmail.com>
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

What the verifier knows about a value is five members of struct
bpf_reg_state: var_off, r64, r32, base and step. Code that computes with
values and has no register for them copies some of the five, or makes up
a register. scev.c has struct scev_value and struct bounds, each with its
own addition. verifier.c fills in fake registers of 80 bytes to add a
constant.

Give the five members a type. struct scalar is the reduced product of
known bits, a range, a range of the low 32 bits and a congruence. It is
an anonymous member of struct bpf_reg_state: reg->r64 stays reg->r64 and
no user changes. scalar_of(reg) points to it.

The five members have 44 bytes, a struct of them has 48. Where they are
now it would grow a register from 80 to 88 bytes and put 4 bytes of
padding into what regsafe() compares with memcmp(). So id takes the place
of 'u32 unused' and the scalar is the last member:

	 0  type			 0  type
	 4  unused			 4  id
	 8  union, 16 bytes		 8  union, 16 bytes
	24  var_off .. step		24  parent_id
	68  id				28  map_uid
	72  parent_id			32  struct scalar
	76  map_uid			76  padding
	80				80

11 lines depend on the old order: they compare, hash or clear a register
up to offsetof(struct bpf_reg_state, var_off) or up to its id. Now they
name what they mean. reg_fixed_part_equal() and reg_value_equal() move
from join.c to the header, range_equal() of join.c is scalar_equal().
refine_live_branch() compares whole registers with memcmp(), which would
read the padding. It calls reg_value_equal() now. flow_shape_ptr() hashes
the type, the union and the scalar one after the other. Its hash values
change. They are only compared with each other.

No functional change.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 109 ++++++++++++++++++++++-------------
 kernel/bpf/flow.c            |  26 ++++++---
 kernel/bpf/join.c            |  22 +------
 kernel/bpf/states.c          |   8 +--
 kernel/bpf/verifier.c        |  11 ++--
 5 files changed, 97 insertions(+), 79 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 598763d128ab..00f8680ecb3d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -57,11 +57,46 @@ struct bpf_stack_range {
 	u32 size;
 };
 
+/*
+ * What is known about a 64-bit value: the reduced product of known bits, a range, a range of the
+ * low 32 bits and a congruence. The value is in each of the four. reg_bounds_sync() is the
+ * reduction: what one of them knows refines the others.
+ */
+struct scalar {
+	struct tnum var_off;
+	struct cnum64 r64; /* 64-bit range as circular number */
+	struct cnum32 r32; /* 32-bit range as circular number */
+	/*
+	 * The value, interpreted as s64, lies on a line described by a linear
+	 * equation base + step * k.
+	 * Invariant: base < step.
+	 */
+	u16 base;
+	u16 step;
+};
+
+/* The struct scalar that is an anonymous member of *@p */
+#define scalar_of(p) container_of_const(&(p)->var_off, struct scalar, var_off)
+
 struct bpf_reg_state {
-	/* Ordering of fields matters.  See regsafe() */
 	enum bpf_reg_type type;
-	/* 0. regsafe() compares the bytes before var_off: there is no hole among them. */
-	u32 unused;
+	/*
+	 * For PTR_TO_PACKET, used to find other pointers with the same variable
+	 * offset, so they can share range knowledge.
+	 * For PTR_TO_MAP_VALUE_OR_NULL this is used to share which map value we
+	 * came from, when one is tested for != NULL.
+	 * For PTR_TO_MEM_OR_NULL this is used to identify memory allocation
+	 * for the purpose of tracking that it's freed.
+	 * For PTR_TO_SOCKET this is used to share which pointers retain the
+	 * same reference to the socket, to determine proper reference freeing.
+	 * For stack slots that are dynptrs, this is used to track references to
+	 * the dynptr to determine proper reference freeing.
+	 * Similarly to dynptrs, we use ID to track "belonging" of a reference
+	 * to a specific instance of bpf_iter.
+	 * A scalar has no id. The scalars that it is linked to are static: computed before the
+	 * main pass, see bpf_scev_next_linked_reg().
+	 */
+	u32 id;
 	union {
 		/* valid when type == PTR_TO_PACKET */
 		int range;
@@ -144,43 +179,6 @@ struct bpf_reg_state {
 			u32 func_set;
 		};
 	};
-	/* For scalar types (SCALAR_VALUE), this represents our knowledge of
-	 * the actual value.
-	 * For pointer types, this represents the variable part of the offset
-	 * from the pointed-to object, and is shared with all bpf_reg_states
-	 * with the same id as us.
-	 */
-	struct tnum var_off;
-	/* Used to determine if any memory access using this register will
-	 * result in a bad access.
-	 * These refer to the same value as var_off, not necessarily the actual
-	 * contents of the register.
-	 */
-	struct cnum64 r64; /* 64-bit range as circular number */
-	struct cnum32 r32; /* 32-bit range as circular number */
-	/*
-	 * The value described by this register, interpreted as s64, lies on
-	 * a line described by a linear equation base + step * k.
-	 * Invariant: base < step.
-	 */
-	u16 base;
-	u16 step;
-	/* For PTR_TO_PACKET, used to find other pointers with the same variable
-	 * offset, so they can share range knowledge.
-	 * For PTR_TO_MAP_VALUE_OR_NULL this is used to share which map value we
-	 * came from, when one is tested for != NULL.
-	 * For PTR_TO_MEM_OR_NULL this is used to identify memory allocation
-	 * for the purpose of tracking that it's freed.
-	 * For PTR_TO_SOCKET this is used to share which pointers retain the
-	 * same reference to the socket, to determine proper reference freeing.
-	 * For stack slots that are dynptrs, this is used to track references to
-	 * the dynptr to determine proper reference freeing.
-	 * Similarly to dynptrs, we use ID to track "belonging" of a reference
-	 * to a specific instance of bpf_iter.
-	 * A scalar has no id. The scalars that it is linked to are static: computed before the
-	 * main pass, see bpf_scev_next_linked_reg().
-	 */
-	u32 id;
 	/*
 	 * Tracks the parent object this register was derived from.
 	 * Used for cascading invalidation: when the parent object is
@@ -195,8 +193,39 @@ struct bpf_reg_state {
 	 * during state comparisons.
 	 */
 	u32 map_uid;
+	/*
+	 * For scalar types (SCALAR_VALUE), this represents our knowledge of
+	 * the actual value.
+	 * For pointer types, this represents the variable part of the offset
+	 * from the pointed-to object, and is shared with all bpf_reg_states
+	 * with the same id as us. It is used to determine if any memory access
+	 * using this register will result in a bad access.
+	 * The last member: its padding is at the end of the register.
+	 */
+	struct scalar;
 };
 
+static inline bool scalar_equal(const struct scalar *a, const struct scalar *b)
+{
+	return a->r64.base == b->r64.base && a->r64.size == b->r64.size &&
+	       a->r32.base == b->r32.base && a->r32.size == b->r32.size &&
+	       a->var_off.value == b->var_off.value && a->var_off.mask == b->var_off.mask &&
+	       a->base == b->base && a->step == b->step;
+}
+
+/* The type and what goes with it: the object that a pointer points to */
+static inline bool reg_fixed_part_equal(const struct bpf_reg_state *ra,
+					const struct bpf_reg_state *rb)
+{
+	return ra->type == rb->type && !memcmp(&ra->raw, &rb->raw, sizeof(ra->raw));
+}
+
+/* All but the ids */
+static inline bool reg_value_equal(const struct bpf_reg_state *ra, const struct bpf_reg_state *rb)
+{
+	return reg_fixed_part_equal(ra, rb) && scalar_equal(scalar_of(ra), scalar_of(rb));
+}
+
 static inline s64 reg_smin(const struct bpf_reg_state *reg)
 {
 	return cnum64_smin(reg->r64);
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index abbadba1e79f..f4edf411e81f 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -2173,12 +2173,16 @@ static bool flow_needed_consts_differ(const struct bpf_flow *flow, enum flow_nee
 	return false;
 }
 
+/* flow_shape_ptr() hashes a struct scalar up to its padding: there is no hole in front of it */
+static_assert(offsetofend(struct scalar, step) == sizeof(struct tnum) + sizeof(struct cnum64) +
+						  sizeof(struct cnum32) + 2 * sizeof(u16));
+
 /* regsafe() and join_reg() say what each type needs */
 static void flow_shape_ptr(struct flow_shape *sh, u32 place, const struct bpf_reg_state *reg)
 {
 	u32 ids = (reg->id != 0) | (reg->parent_id != 0) << 1 | (reg->map_uid != 0) << 2;
-	u32 len = offsetof(struct bpf_reg_state, var_off);
-	bool has_off = false, var_off = false;
+	bool fixed_part = true, exact = false, has_off = false, var_off = false;
+	u32 *ptrs = &sh->word[FLOW_PTRS];
 	u64 off = reg->var_off.value;
 
 	switch (base_type(reg->type)) {
@@ -2187,12 +2191,12 @@ static void flow_shape_ptr(struct flow_shape *sh, u32 place, const struct bpf_re
 		return;
 	case PTR_TO_ARENA:
 		/* the offset is not tracked */
-		len = sizeof(reg->type);
+		fixed_part = false;
 		ids = 0;
 		break;
 	case PTR_TO_PACKET_META:
 	case PTR_TO_PACKET:
-		len = sizeof(reg->type);
+		fixed_part = false;
 		ids &= 1;
 		/* behind the end of the packet, or at the end: the same in both states */
 		if (reg->range < 0)
@@ -2224,11 +2228,15 @@ static void flow_shape_ptr(struct flow_shape *sh, u32 place, const struct bpf_re
 		var_off = !tnum_is_const(reg->var_off);
 		break;
 	default:
-		len = offsetof(struct bpf_reg_state, id);
+		exact = true;
 	}
 	sh->word[FLOW_LAYOUT] = jhash_1word(place << 1 | var_off, sh->word[FLOW_LAYOUT]);
-	sh->word[FLOW_PTRS] = jhash2((const u32 *)reg, len / sizeof(u32),
-				     sh->word[FLOW_PTRS] + ids);
+	*ptrs = jhash_1word(reg->type, *ptrs + ids);
+	if (fixed_part)
+		*ptrs = jhash2((const u32 *)&reg->raw, sizeof(reg->raw) / sizeof(u32), *ptrs);
+	if (exact)
+		*ptrs = jhash2((const u32 *)scalar_of(reg),
+			       offsetofend(struct scalar, step) / sizeof(u32), *ptrs);
 	if (has_off && !var_off)
 		sh->word[FLOW_OFFS] = jhash_2words(lower_32_bits(off), upper_32_bits(off),
 						   sh->word[FLOW_OFFS]);
@@ -2605,7 +2613,7 @@ static bool flow_join_makes_up(const struct bpf_flow *flow, struct bpf_verifier_
 	struct bpf_func_state *fa = a->frame[a->curframe], *fb = b->frame[b->curframe];
 	const struct bpf_reg_state *ra, *rb, *one_a = NULL, *one_b = NULL;
 	const struct flow_need *tested = flow->need[FLOW_NEED_JUMP], *need;
-	u32 fr, i, len = offsetof(struct bpf_reg_state, id);
+	u32 fr, i;
 
 	if (!tested)
 		return false;
@@ -2623,7 +2631,7 @@ static bool flow_join_makes_up(const struct bpf_flow *flow, struct bpf_verifier_
 			if (flow_gap(ra, rb))
 				return true;
 			/* copies of a scalar count once: same range and tnum in each state */
-			if (one_a && (memcmp(ra, one_a, len) || memcmp(rb, one_b, len)))
+			if (one_a && (!reg_value_equal(ra, one_a) || !reg_value_equal(rb, one_b)))
 				return true;
 			one_a = ra;
 			one_b = rb;
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index 2b8c94b7dc50..9db52e8f36ca 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -129,14 +129,6 @@ static bool jid_strict_ok(struct bpf_join_state *js, u32 ida, u32 idb)
 	return jid_good(js, ida, idb);
 }
 
-static bool range_equal(const struct bpf_reg_state *ra, const struct bpf_reg_state *rb)
-{
-	return ra->r64.base == rb->r64.base && ra->r64.size == rb->r64.size &&
-	       ra->r32.base == rb->r32.base && ra->r32.size == rb->r32.size &&
-	       ra->var_off.value == rb->var_off.value && ra->var_off.mask == rb->var_off.mask &&
-	       ra->base == rb->base && ra->step == rb->step;
-}
-
 static const struct bpf_loop_rungs *join_rungs(const struct bpf_join_state *js)
 {
 	u32 i;
@@ -166,10 +158,10 @@ static int join_place_is_linear(const struct bpf_join_state *js)
 static bool join_range(struct bpf_join_state *js, struct bpf_reg_state *dst,
 		       const struct bpf_reg_state *ra, const struct bpf_reg_state *rb)
 {
-	if (range_equal(ra, rb))
+	if (scalar_equal(scalar_of(ra), scalar_of(rb)))
 		return true;
 	bpf_reg_union_range(dst, rb);
-	if (!js->widen || range_equal(dst, ra))
+	if (!js->widen || scalar_equal(scalar_of(dst), scalar_of(ra)))
 		return true;
 	/*
 	 * The bound of a number that grows around a cycle is put where it may come to rest. If
@@ -184,16 +176,6 @@ static bool join_range(struct bpf_join_state *js, struct bpf_reg_state *dst,
 	return true;
 }
 
-static bool reg_fixed_part_equal(const struct bpf_reg_state *ra, const struct bpf_reg_state *rb)
-{
-	return !memcmp(ra, rb, offsetof(struct bpf_reg_state, var_off));
-}
-
-static bool reg_value_equal(const struct bpf_reg_state *ra, const struct bpf_reg_state *rb)
-{
-	return !memcmp(ra, rb, offsetof(struct bpf_reg_state, id));
-}
-
 /*
  * Join two registers, regsafe() documents what each type needs.
  * Pass 1 records id pairs, pass 2 computes @dst, which is a copy of @ra on entry.
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 48359e789faa..9ff067dba497 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -185,7 +185,7 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 		       const struct bpf_reg_state *rcur,
 		       struct bpf_idmap *idmap)
 {
-	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
+	return reg_value_equal(rold, rcur) &&
 	       check_ids(rold->id, rcur->id, idmap) &&
 	       check_ids(rold->parent_id, rcur->parent_id, idmap) &&
 	       check_ids(rold->map_uid, rcur->map_uid, idmap);
@@ -229,7 +229,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 			/* explore_alu_limits disables tnum_in() and range_within()
 			 * logic and requires everything to be strict
 			 */
-			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0;
+			return reg_value_equal(rold, rcur);
 		}
 		return range_within(rold, rcur) && tnum_in(rold->var_off, rcur->var_off);
 	case PTR_TO_MAP_KEY:
@@ -242,7 +242,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		/* If the new min/max/var_off satisfy the old ones and
 		 * everything else matches, we are OK.
 		 */
-		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, var_off)) == 0 &&
+		return reg_fixed_part_equal(rold, rcur) &&
 		       range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off) &&
 		       check_ids(rold->id, rcur->id, idmap) &&
@@ -275,7 +275,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 	case PTR_TO_ARENA:
 		return true;
 	case PTR_TO_INSN:
-		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, var_off)) == 0 &&
+		return reg_fixed_part_equal(rold, rcur) &&
 		       range_within(rold, rcur) && tnum_in(rold->var_off, rcur->var_off);
 	default:
 		return regs_exact(rold, rcur, idmap);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1f33e69b4aee..eabefa35631c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2002,9 +2002,8 @@ static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
  */
 static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 {
-	/* Clear off and union(map_ptr, range) */
-	memset(((u8 *)reg) + sizeof(reg->type), 0,
-	       offsetof(struct bpf_reg_state, var_off) - sizeof(reg->type));
+	/* Clear union(map_ptr, range) */
+	memset(&reg->raw, 0, sizeof(reg->raw));
 	reg->id = 0;
 	reg->parent_id = 0;
 	reg->map_uid = 0;
@@ -18312,7 +18311,7 @@ bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_re
 		return false;
 	if (a->type == SCALAR_VALUE)
 		return true;
-	return !memcmp(a, b, offsetof(struct bpf_reg_state, var_off)) &&
+	return reg_fixed_part_equal(a, b) &&
 	       a->id == b->id && a->parent_id == b->parent_id && a->map_uid == b->map_uid;
 }
 
@@ -19616,8 +19615,8 @@ static int refine_live_branch(struct bpf_verifier_env *env, struct bpf_insn *ins
 	int err;
 
 	/* is_branch_taken() knew the branch before it refined anything */
-	if (!memcmp(reg1, &regs[insn->dst_reg], sizeof(*reg1)) &&
-	    (BPF_SRC(insn->code) == BPF_K || !memcmp(reg2, &regs[insn->src_reg], sizeof(*reg2))))
+	if (reg_value_equal(reg1, &regs[insn->dst_reg]) &&
+	    (BPF_SRC(insn->code) == BPF_K || reg_value_equal(reg2, &regs[insn->src_reg])))
 		return 0;
 	/*
 	 * The fall-through branch of JSET forgets the ranges. Or this branch is dead too: the path
-- 
2.55.0

