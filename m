Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415711;
	b=vFY7wcOER0BJZc3Uu5m7swR7nIXkK3UIhLrMmYCX67AW8SY4ZmhS7FDwSxJzmJMeN3SR
	 yRfdmMJhjc3dlLRzteQUbXO9AGWQp/ZAMQwcHxSYuwSTfXytm7UHsyzzIPswBHcu7iHE+
	 BeHEFoj/uI9AU58IjoKu+c6Ix10AbWryiu8mjZZMtv8Xu2D2Q2mcqeRhQT7dEKFbubgn/
	 eqnJxpPO9lsoE1r47Bu2HPXHK8IryrAhFUdL9+5R5F1NgmvVuYIVOMB/0jKtqJS8AQm+V
	 C8vlPvqs5AjUirac/zx35mOseuKZnc0qwghsoljcx4GTbZQRTAUTuMBv/QhCVEM/ezQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SV/TFw71evXCc3On3O5RFN9svtP8CyNH0qk2xPLOXB0=;
	b=lz+K2GWfjur+tvMVMEA098HGMh9MI0aMlQ6gr5sY+md0n3j5Zu+qkvlL8GWrCrPOVNrH
	 084fChRjhn2sDCBlmRN544dv2/RSIonZkEik+nzGVMnOEEwaKDboIqaM3bfzFFetpdhMz
	 LTAqiOJ6MWN75QFEDkCI8BSrdrGXwUri36ng5SRlTRYA+geEVtTvgsz6/s4D+fES83v/V
	 mrrDQmuOv4V+7efCXtRueVi64yk1PkfyR6RnH/IlEZx6DNHMRLKKiczuGHy02arr1/93j
	 hXINbuoe96FkvvF25L3+6udVivtaw3Lvwr1XaEVkukmFPVangLdqPNEdrVxbz4bnDlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZJAUCMQ0;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD49606A88A
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFD49606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZJAUCMQ0
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so1967207a91.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415710; x=1795020510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SV/TFw71evXCc3On3O5RFN9svtP8CyNH0qk2xPLOXB0=;
        b=ZJAUCMQ0FYIJWhE2yIB85wpKm6KD7WvPDwbvG4oBj/Dw16Cdg0u9HAb6zy82x6Xo8B
         VQHSMQD0fsdx3LwOlKVztYqCNZ1zCjFOb+2HWn9kg6yqtoZj3yLZYS12bmw5jJd4spMN
         +nftb9n9+RMDHztqVNL9B2iq/ZV2VfGBxu9SQJW8LFYbxvjYhHcCBlaeoOBErPsxS6PA
         tX7UZEM6lFkAucC9dfRcXr8Xibvzegmyeelvl+cV3Ng4TqslZqpMX3403kSEZmbfUT07
         RPUSV6oqpO7pLdeDiYMjGCRn/HdJccmFoU0y611RSn32/3JX6BY7j5CCneT0+IJg2PB+
         UoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415710; x=1795020510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SV/TFw71evXCc3On3O5RFN9svtP8CyNH0qk2xPLOXB0=;
        b=zAIflGjyvZurcT048cqoPyKZPlq7GscPNES8AYdJVsCi6FdkWAiNh0ru9dgZHXTaA/
         nhKdJRC8QAOQD2oyGZVMmPTJyjstpwAosys9MxB+ahzH5OBh67pPjWtDLozq49jCGBn0
         mV1aQgqhZvdokztv7C3mnMao3w7MQYj5AqAAHSAlYN24z5Sl+6//+QjfH9uWhccT0RwI
         e49HBmB/ror5xOYrBTL3hKuFnepkwn994bhPVgqZJJLyG/fRLC6gv6dDw76hK67gX53d
         yM74EfJ+3103e6LXpd7DJZMcS3t3WhWqS2NSPugxZVAk4amgQZ9osEeRVNCYWTh9I5wh
         ZE9w==
X-Gm-Message-State: APuU4Z/0wnNQjoKRVE6wpFAE2V83hq9cB8yl/vP4SoCGWC0Ae9UR8fk5
	ToK+5HHmiYzSWPmAw0/A+e1Lq8F2OJfrnzMjvb4DVA7r1NfYqQUJi6tATLNHnw==
X-Gm-Gg: AYBFou0B3690iXRbYegKQ00YB0tX7OVQZGlmhL8XzjvJGB2OykusCgqsxqR30GCrWiX
	uy3IHDnaQVjoeVQUXCvfSvxQ5A+dE+g21+exnB39b9sqoNU9JBq29ggLnKKZ5Qd88bS5WU41z/e
	36U5CD9Wpat25aHcLvLCzinjZQTdx7XNkCFnAt7yc8rpsJXmPRuxlbXGteJ0DAmOBgOmeMmcqpK
	+Y3whG5vWbkkkiotHZu3+/4cvWKWTypUq+J2kH9JYxJ0VtwJa+tCxVXyWmsr6V59r8GOCXabFLf
	35cR2XX/3Ul/p5v/o7WipD6PhEwMZF9ZsKWuMc55kFfDtPeWgVgDH0wuhfEYpRud/1SW6SS/1pW
	kyYCbJAvzfSemRkfG4OuwZybPs8YDWFh5mFWYZALWF0eatpvaXUrlI9JqM+lc0Gu2GzCJGl1giZ
	LguZEvfk3InZ6Wuy1vwQP1CjjezqxLONoYOYy0vTL2gQCl5uZ6KkvYlvIAIjXTHnHvKH/Tk5I2s
	4TBR0XJy8sVlfcT3yIdMwUdcvqVRGD1bD60Y67FuDIS7yJZfCj8suS544Qr6Gvbqmg39jPMI61N
	QvbPfN2a2X0SwxxOxbKgaOMa1ZAuEw44e+ZgoKns+C0A6R4HMwQdUe7eDnjIh71qlkjPi4neXc4
	R9pHn5lfxQsMqnlQ081XSQh0211tg87IvY7DfrJnwvCryF63jnFz8nYh2FwOyJULRwDgALtPz6Q
	==
X-Received: by 2002:a17:90b:4b92:b0:3a7:bb1d:3688 with SMTP id 98e67ed59e1d1-3b182f26aa1mr3115415a91.27.1794415709504;
        Wed, 11 Nov 2026 08:48:29 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8b2cdsm57190a91.16.2026.11.11.08.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:48:29 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 25/29] bpf: Remove scalar ids from regsafe()
Date: Wed, 11 Nov 2026 16:45:48 +0000
Message-ID: <20261111164557.2659679-26-alexei.starovoitov@gmail.com>
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

