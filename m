Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374176;
	b=WrzQPTm8oj8ZuNJblf/XvsohDIQS9Sy5i+HelDM2w9OzxMmb5EGQsmZan/GKrk3WbJJ5
	 zCQ3z4Ha+nfODSns7gqbJcXHBxi5enfggIHKAUUnVAbGpNFVzGD4aGnCpOEqfnqbOevnk
	 DVvyAhOcj/IiE4gFLnC/xfY1AQ4iwiAzD/MA0v6x0m6eE/ElGSNmOtKZ9EWYgpDc/jgOZ
	 khvkpiEMfGLsfvhP7hQ6rcUf/U8P8JYnoTV17fpwW5LFTuZWCIBP0ZOQ0UJzg+k7vevlR
	 OhILrnPjwu3jfAhNyYqZtotij6DaIYDIaPrULPoZWn5QMkckYFy2t6mObG4KfQS/yOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SV/TFw71evXCc3On3O5RFN9svtP8CyNH0qk2xPLOXB0=;
	b=0PSQxSqXFTRzp0BYZmQ3cKevpnYgbBYyWKSRPhw/ouPkyo0sxeCaKx7sn0xO384qAknD
	 ujYDpcDA3nXU0SB57KyYs5MjjVWlOG3KPyaodj0sRUfbfchAOYmhjWFmQoUsTieWO6xol
	 X4xkRL6wtJ6DzRnIWiuWsdud9BL8oEHzLFNLvEZ9vtcUPu6Cc5Y4EGcB1czzy4SqMV3ms
	 MjQpGQabnQh2ffV6VrDj05WfZ6ShvxMM8R0Y8CMTvmVskJtydmbcPsf4G3PAaA8J13EI1
	 5fv2fHRa6L0sFmcSXZPwDOiDh046SOBra3a4sAIpbKe7SP/+qvVixmzRhugwMvHIS0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xYIaHw1b;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE5606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62AE5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xYIaHw1b
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b179528d56so471053a91.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374176; x=1794978976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SV/TFw71evXCc3On3O5RFN9svtP8CyNH0qk2xPLOXB0=;
        b=xYIaHw1bmZZep1eB0NvRUAgNmbr5oU7NwoakBALQP5j9Eses5kR8uMqqNYgDAbSwf+
         2dl7agoWoOU/5mGcuCses2zPpZBpS9A1kYOX1bRFf4j0lCxnBPshLWT63oEmMMY2MU/e
         p0GHDrKUNu33/zIMgoW1VAcvhKMItZu/Jy38US0xE3J/1aRpL2zB/IhH6zeNkECII30a
         tC8lBUws27KRgshr0s0vblxoX7u9N0cTZRhNaY6VDx0Bv7DAWumaL4B7st7iLQuS6rn9
         yr9fRYITWuZR9HnVUGkGh3E5rsakUkODVDdXc/r66Fl8kAw3ymQmAJ2EjkHiTWvOhq5O
         E0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374176; x=1794978976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SV/TFw71evXCc3On3O5RFN9svtP8CyNH0qk2xPLOXB0=;
        b=OYHO2hRvRr0sqXRlbUkDDtVTfxJ///j4BbJSIry9+VH1IF0KM+TfqbhRvQIt47VaPG
         xjQEhbwaLq1RRnR5aSbpdPgD9/1/2PiQR8SDs9E7tC1VyB2bT5hW+o+DDoJlvblTaqXe
         BWx+yY1zRnboJ+H4dpuJvy/fEkt+YH89NGOPGhC8n3VDnplOfK7PCDaNZtmIFGen9WhE
         ixQFw3KwpI56RdSTPqA7GgdKUjCLY6I330cblubhOlMzefDZkKfxPaZn/EuKBomcFcmg
         oJxo3WyZoxiThz0WMVl9fCPPjZl/GBWn9CvCvJMLwOKcxWxt2Kpba0UMOwiRX/8TtLc1
         CHAg==
X-Gm-Message-State: APuU4Z8isj3mH6Ni2Q7uqxafy+mF25QFpMEEwhMGlDkut4kGBzcbI8Yq
	Aiz0ORfYIB4wQLSikn/aUt4joF+1O4h2Lv92c+sHXqEMnxZJ7z5fWvJfVOVQlQ==
X-Gm-Gg: AYBFou2Ngl5aS3W4aJ5VyT3snTIM/vV49BvoWvlRpQRgXj8ajuwf4ZBQ5M2d1qNzWrV
	ixQ1MvfiySQDkTtdU3pQOeYT66iP3rfF17UhpLSnc92dBtGdlevoHboIDh/ieoMwG18EQCyFVYF
	88ufpmDWH5/FuOdvgyOSNGMpyChJNMAc7Ry+5gJjsmqnTAWS6GSzTS6no/WJ1c40y9uYijtmCiN
	xhWYxsHVpG14mQODVKDUYOmH6bu8RRlzJsS3ac0Lq9lr6qLuuQpmqXbsNu0xAJsTnJ7ZLB4pU/P
	uDb5BlzA97FGO2+9uJph4dAdn7xkWtLOvpVBtEVSgRvVPM1BkC7v5s7x9iON09kCls79TqM+BVG
	9A4EkPlK8znQcSfzG2aV0zPpqdy7rnAXRL5hqiWmS4pwShrbt+BDJz+C9NofgbiW++pFfhZ5o9Q
	y737pBGv4B/3tkemsG3Q3uv9gr0Te0rHQC9tASiODjf1EWdqtQEcIeW5xkkE/98TkcQ4GA3ZKDj
	3T/yd3BFBWe6t21Hcp5Wa2kJnS1cpXvBQ7U0Uz4kIcz7IiDeqZ3t7+dDUJJ7TnlKX+9CJFwzc7B
	ZfdaIkjtwb8zZ/RPS6Io2g6ZE1OUiERgwC0GGPoAPpLdVDeRthfvhPWjL5ahPf355ewo4KytA+U
	deP3hRGShvCF0iXDxS8WTi6dDQXFpxDwPtjxemZ1bTnvn+7zsynA1MxX6Sbx9vKvtIgk7H78znP
	8=
X-Received: by 2002:a17:90b:1e51:b0:3b0:e2a9:345a with SMTP id 98e67ed59e1d1-3b182fcdf84mr1302825a91.64.1794374175331;
        Tue, 10 Nov 2026 21:16:15 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b182de1dafsm956279a91.3.2026.11.10.21.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:16:15 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 25/29] bpf: Remove scalar ids from regsafe()
Date: Wed, 11 Nov 2026 05:13:36 +0000
Message-ID: <20261111051341.2800252-26-alexei.starovoitov@gmail.com>
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
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Removal of dead code. Scalars have no ids any more, so every check of
a scalar id in regsafe() passes. No prog is verified differently.

	4: r6 = r7
	5: if r6 > 10 goto ..
	6: use r7

While a jump refined all scalars with the id of the tested register,
a state in which r6 and r7 have the same id was stronger than a state with
the same ranges and two ids: in the first one insn 5 bounds r7. So
regsafe() did not stop at the ranges. check_scalar_ids() mapped the ids of
the old state to those of the current one, an id that the current state
did not have got a temporary one, BPF_ADD_CONST and delta had to be equal.

Now no state says that two scalars hold the same value. What insn 5
refines are its linked registers. Scalar evolution computes them before the
main pass, and a link holds on every path to insn 5, whatever state gets
there. The stack slot of a caller that a jump refines is found through
a pointer in the state, and regsafe() compares pointers as before. For two
scalars range_within() and tnum_in() are enough. Remove check_scalar_ids()
and the table of cases in regsafe().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/states.c | 108 ++------------------------------------------
 1 file changed, 3 insertions(+), 105 deletions(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index b60676349655..48359e789faa 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -58,7 +58,7 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 		return true;
 
 	/* a name of what the caller has, see BPF_INHERITED_ID */
-	if (((old_id | cur_id) & ~BPF_ADD_CONST) >= BPF_INHERITED_ID)
+	if ((old_id | cur_id) >= BPF_INHERITED_ID)
 		return old_id == cur_id;
 
 	for (i = 0; i < idmap->cnt; i++) {
@@ -85,49 +85,6 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 	return false;
 }
 
-/*
- * Compare scalar register IDs for state equivalence.
- *
- * When old_id == 0, the old register is independent - not linked to any
- * other register. Any linking in the current state only adds constraints,
- * making it more restrictive. Since the old state didn't rely on any ID
- * relationships for this register, it's always safe to accept cur regardless
- * of its ID. Hence, return true immediately.
- *
- * When old_id != 0 but cur_id == 0, we need to ensure that different
- * independent registers in cur don't incorrectly satisfy the ID matching
- * requirements of linked registers in old.
- *
- * Example: if old has r6.id=X and r7.id=X (linked), but cur has r6.id=0
- * and r7.id=0 (both independent), without temp IDs both would map old_id=X
- * to cur_id=0 and pass. With temp IDs: r6 maps X->temp1, r7 tries to map
- * X->temp2, but X is already mapped to temp1, so the check fails correctly.
- *
- * When old_id has BPF_ADD_CONST set, the compound id (base | flag) and the
- * base id (flag stripped) must both map consistently. Example: old has
- * r2.id=A, r3.id=A|flag (r3 = r2 + delta), cur has r2.id=B, r3.id=C|flag
- * (r3 derived from unrelated r4). Without the base check, idmap gets two
- * independent entries A->B and A|flag->C|flag, missing that A->C conflicts
- * with A->B. The base ID cross-check catches this.
- */
-static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
-{
-	if (!old_id)
-		return true;
-
-	cur_id = cur_id ? cur_id : ++idmap->tmp_id_gen;
-
-	if (!check_ids(old_id, cur_id, idmap))
-		return false;
-	if (old_id & BPF_ADD_CONST) {
-		old_id &= ~BPF_ADD_CONST;
-		cur_id &= ~BPF_ADD_CONST;
-		if (!check_ids(old_id, cur_id, idmap))
-			return false;
-	}
-	return true;
-}
-
 static void __clean_func_state(struct bpf_verifier_env *env,
 			       struct bpf_func_state *st,
 			       u16 live_regs, int frame)
@@ -272,65 +229,8 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 			/* explore_alu_limits disables tnum_in() and range_within()
 			 * logic and requires everything to be strict
 			 */
-			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
-			       check_scalar_ids(rold->id, rcur->id, idmap);
+			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0;
 		}
-		/*
-		 * Linked register tracking uses rold->id to detect relationships.
-		 * When rold->id == 0, the register is independent and any linking
-		 * in rcur only adds constraints. When rold->id != 0, we must verify
-		 * id mapping and (for BPF_ADD_CONST) offset consistency.
-		 *
-		 * +------------------+-----------+------------------+---------------+
-		 * |                  | rold->id  | rold + ADD_CONST | rold->id == 0 |
-		 * |------------------+-----------+------------------+---------------|
-		 * | rcur->id         | range,ids | false            | range         |
-		 * | rcur + ADD_CONST | false     | range,ids,off    | range         |
-		 * | rcur->id == 0    | range,ids | false            | range         |
-		 * +------------------+-----------+------------------+---------------+
-		 *
-		 * Why check_ids() for scalar registers?
-		 *
-		 * Consider the following BPF code:
-		 *   1: r6 = ... unbound scalar, ID=a ...
-		 *   2: r7 = ... unbound scalar, ID=b ...
-		 *   3: if (r6 > r7) goto +1
-		 *   4: r6 = r7
-		 *   5: if (r6 > X) goto ...
-		 *   6: ... memory operation using r7 ...
-		 *
-		 * First verification path is [1-6]:
-		 * - at (4) same bpf_reg_state::id (b) would be assigned to r6 and r7;
-		 * - at (5) r6 would be marked <= X, sync_linked_regs() would also mark
-		 *   r7 <= X, because r6 and r7 share same id.
-		 * Next verification path is [1-4, 6].
-		 *
-		 * Instruction (6) would be reached in two states:
-		 *   I.  r6{.id=b}, r7{.id=b} via path 1-6;
-		 *   II. r6{.id=a}, r7{.id=b} via path 1-4, 6.
-		 *
-		 * Use check_ids() to distinguish these states.
-		 * ---
-		 * Also verify that new value satisfies old value range knowledge.
-		 */
-
-		/*
-		 * ADD_CONST flags must match exactly: BPF_ADD_CONST32 and
-		 * BPF_ADD_CONST64 have different linking semantics in
-		 * sync_linked_regs() (alu32 zero-extends, alu64 does not),
-		 * so one doesn't stand for the other.
-		 */
-		if (rold->id &&
-		    (rold->id & BPF_ADD_CONST) != (rcur->id & BPF_ADD_CONST))
-			return false;
-
-		/* Both have offset linkage: offsets must match */
-		if ((rold->id & BPF_ADD_CONST) && rold->delta != rcur->delta)
-			return false;
-
-		if (!check_scalar_ids(rold->id, rcur->id, idmap))
-			return false;
-
 		return range_within(rold, rcur) && tnum_in(rold->var_off, rcur->var_off);
 	case PTR_TO_MAP_KEY:
 	case PTR_TO_MAP_VALUE:
@@ -468,8 +368,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		/*
 		 * 64 and 32-bit scalar spills vs MISC/INVALID slots and vice versa.
 		 * Load from MISC/INVALID slots produces unbound scalar.
-		 * Construct a fake register for such stack and call
-		 * regsafe() to ensure scalar ids are compared.
+		 * Construct a fake register for such stack and call regsafe().
 		 */
 		if (im == 0 || im == 4) {
 			old_reg = scalar_reg_for_stack(env, old_slot, im);
@@ -736,7 +635,6 @@ static void reset_idmap_scratch(struct bpf_verifier_env *env)
 {
 	struct bpf_idmap *idmap = &env->idmap_scratch;
 
-	idmap->tmp_id_gen = env->id_gen;
 	idmap->cnt = 0;
 }
 
-- 
2.55.0

