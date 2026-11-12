Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442140;
	b=kAQKpQTPXSOxl+pdKVY7L9uz3H62Dj4P/wMvMOdlLNHy6K2nIym2wF+lX8C6EhF9YxQt
	 osHqvrBbBZw3CYD/WYBfbo3EKnQuDy2zpaNPVKSijxhepbCJarVbXEZY968CsvK5hK3+Q
	 A+a0FQBcyHIYLCXEBkJXJNbIBKqirM85dr0DIDK2ZcnSnjSnYnA4Iz3bx6l1AxxcO9lHf
	 L2OMO6MSAESbeO0LFE2ZGZMIUATJgT/idcWxngQSVpqM+oSZxbN8uGjJ8Hc7E5E45ZE8P
	 E45SxWOiiGhCZWbhfxRdFRYjmK4FyOXbWmnF8Q0g0INYLwmJzq0gXEYG9YBFpgprjbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dvexS2Z4egippfwHCEkXxIVcEpMLb9Dji4bRj1waghA=;
	b=uDuMXrUqVzimt45dt5JgTOoo5M/KElPNJ+xSp6xWYXRtWXp6GxIvms0/Nrufw1Y2NjRg
	 n4+nYhxOC1ItA8FQ6O03Ad27Lmrv+wNaVKj5wogMfieOYgz2JU/eIuexCBcQrywWjmNN2
	 w3hPpvmwKTz0+6Y4Iwl+Y1B/lXePrzfVz7cW9RbpOe5x6JuJ3T04YHXTuFoSsItgv9lIL
	 qxqGvqTtjK6WYqPtoo6xQJp29urOMNMu5iYoIbzklQpSWcr5D5i87EuA61T2gFiqOvXPx
	 DqCte9zhXgWzTbwLVNlGien/YaUPDjW+UNIsiPnMfP/amyrf2TQL1QmgshoQIvejsUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iIOxoeUP;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7398C606A321
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 00:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7398C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iIOxoeUP
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b612fd74e1so1340831b3a.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794442139; x=1795046939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dvexS2Z4egippfwHCEkXxIVcEpMLb9Dji4bRj1waghA=;
        b=iIOxoeUP5VaYKBsE46zEtbYUrNgdVcTfchPKGvRDHTJ/kLgTT/1mEwf1Sncu9cXXo8
         SRz/zRxS+XI8bvm5TEpvw3bUbfy8cp0R08gEvvcLR9eAjQ4+UNM2J5ARog/PncTyvtpl
         +W7nTyYpNQsPh/Y0BVDEVy8C1Nua9mBRCZpExrlwpkQWK/or0VXpKhud/Kfs9awx5Ip5
         mP+tGBfsXfQAugYva2wCI8IALie39iQYBHAAvLEAIgHyVuOhmfH6TzOkfzHo9dF8hJ8y
         Kgf0C/BUwpKuyp6Uw5SNqKBhbA3QgwU4ifD2/b67fXfS6eQOhqrBwO2dG3HaDiMCt7HZ
         t77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442139; x=1795046939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dvexS2Z4egippfwHCEkXxIVcEpMLb9Dji4bRj1waghA=;
        b=AH5KJqcY1VJb42kuDHJGio4SCnuq5dvwdqRp9+yVHFq8UojZwgAf6KMeW3A7kYrKpF
         XsFN7pqMxSDfaq4kvGLVCqQuZXUEqH1Ae0D1hzF/aCi9RtwqVmEMjYZvXWaM/dZpvPr9
         9byzYNuwZwB2CGgGqy91PrMtSVVbWXh1TAUMdOafaYBKEA06e7K7aRRJ8VEr27A0erqg
         ZgdTH/o+i6liXK0aJgWc/QutThHKHkFrcs7A4xYL88wibnMNfoVfLw9koSgmfEqaFlrW
         YkbeiVQpn1/YCVG+1OfK+IpIaKAakWiErQMebbs7uVkC9i0xw9J/tv1JKJYMEsf/Up5R
         5UAw==
X-Gm-Message-State: APuU4Z+H05XwWezDyIbJwpn+E8c1JRtGCffETtLOY/IqUJ8QsWyn2fSH
	xPxQqVEieKSs4B23azDBXDr8+EosYCTtVSM8S2oRyYrsuF+Pv1MlRZPAlpY3JA==
X-Gm-Gg: AYBFou3m0G/e+n0P7Poz/lzOqD7MfC7s2zd+Q5CyvpGBmhTHYlHRNOwnXpvQex6WOx0
	h0t9sWXRjvTk/lwpQb6FL5TqIkmmwqjjYEd5dXlcX2SypzMl8EX+ITyM5wLiKCgnZchZ1R2ju3k
	e1xzTQDFOrEpZEkPPN2K2iFX775TzC1XoEHjElE3njnOFjydNaeucmlZEEqrPmdPE+3T14bPoZJ
	IFrPslZ7VsBhlW6KD9w050OF5QCg3/X8zo2XJbpY0gI0AFajX2ckx0ue8ZtbcSW5AiK49ZSoKSv
	jRrlvLx/khOhBMjG5qFe5H+7n37OtGn9+NX96Mu5zr+s77aVj2CoxZb38N8mXsppMD8Doqrho/7
	/p3a7rYAR6fXTCQpPrKy9RfmLTs/wcONEY/jgCuMZPEOokw6IFBiTeYVItcDhKc2HJRIaR0a9qB
	HIWjalGNmCYytjLezDy6ly0bAj99uAZcuykcxy0OCIANdQj04qCYJ7zFhORUgsHDNDn3B7yAJqH
	5xMgeY0FPEbssLeNopPo5ZnamOhGYvQIVG9JN5PgK0VTqA0SIcRrlVFv7XbxqGRLz1DeY9bhZjw
	FRmVmyXHUDS9dbxkBLE98QVv5UeXnq4Rl86AnHnD76lQMlgbxzhmipuw/R4zOAlnyGZRgllhpVq
	MDEvgbYtl8WE3oNJp2t6Xp7tQCKMSQdhVOIba2t+evxJJ6hugIZX3FJpp+eQoh1kxHXHKfkMtGw
	==
X-Received: by 2002:a05:6a00:170b:b0:8b6:59a:2ae with SMTP id d2e1a72fcca58-8bc1d819c34mr3815460b3a.52.1794442138454;
        Wed, 11 Nov 2026 16:08:58 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaae3da61sm2562242b3a.35.2026.11.11.16.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:08:57 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 3/7] bpf: Add struct scalar
Date: Thu, 12 Nov 2026 00:08:31 +0000
Message-ID: <20261112000836.3138846-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112000836.3138846-1-alexei.starovoitov@gmail.com>
References: <20261112000836.3138846-1-alexei.starovoitov@gmail.com>
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

The union is named by its member raw: two unsigned long, half of the union
on a 32-bit kernel. They become u64, and a static_assert() says that raw
ends where the union ends.

No functional change.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 116 ++++++++++++++++++++++-------------
 kernel/bpf/flow.c            |  26 +++++---
 kernel/bpf/join.c            |  22 +------
 kernel/bpf/states.c          |   8 +--
 kernel/bpf/verifier.c        |  11 ++--
 5 files changed, 102 insertions(+), 81 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 598763d128ab..673956376c2a 100644
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
@@ -134,8 +169,8 @@ struct bpf_reg_state {
 
 		/* Max size from any of the above. */
 		struct {
-			unsigned long raw1;
-			unsigned long raw2;
+			u64 raw1;
+			u64 raw2;
 		} raw;
 
 		struct { /* for PTR_TO_FUNC */
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
@@ -195,8 +193,42 @@ struct bpf_reg_state {
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
 
+/* reg->raw stands for the union where it is compared, hashed, copied or cleared */
+static_assert(offsetofend(struct bpf_reg_state, raw) == offsetof(struct bpf_reg_state, parent_id));
+
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
index 6512909600f4..4a973b77cd69 100644
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
@@ -18318,7 +18317,7 @@ bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_re
 		return false;
 	if (a->type == SCALAR_VALUE)
 		return true;
-	return !memcmp(a, b, offsetof(struct bpf_reg_state, var_off)) &&
+	return reg_fixed_part_equal(a, b) &&
 	       a->id == b->id && a->parent_id == b->parent_id && a->map_uid == b->map_uid;
 }
 
@@ -19622,8 +19621,8 @@ static int refine_live_branch(struct bpf_verifier_env *env, struct bpf_insn *ins
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

