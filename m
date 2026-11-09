Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206968;
	b=zG2IcTQ6I+BWJjh6HDW0BZSWqi4fFHKjZLh2Mm+q/N6gKE9nwDaGd7u6+2orwRgpTf+k
	 Kgdhydq+/6PAccAvTggNca21A8mUDSqsdHu6S3z8mfviUqEogefIX8W21FRYZ009UO7NG
	 vgIW55QOdXHejJVbRZoLlHgzDdwkSQyKOcuPsqKAuNsOsgLM5rGMQiq9ty+JeW7Gtguqd
	 Cf0T+PZDfNmrJ54haQ7gIU6Gq3JtIW1me8nGokn7AhAOWpJI6UNGGmlG2/Ek/Ih8GDkgR
	 RC7VQWQIo5rvOTv1eHhoimcA9kdq/5bGYzxxXIBZ5e5ZYIZPgH8Rz6YQzvfrmCzdOIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BwZDJgsO5HNxhXhQgWhsz/Soth3IdSQ1hRMZf96JDjg=;
	b=0N+7yTgNap19ESEkVhmTMF2tEMNACJkeTLmrc38FdFsu4S46cHgRmLFGdu6fqa2QR+5k
	 LUcahNwDP9WpYyQBbQFRQIerswqhOv0HzT37D+csRwp9rEsA8IGNnJmkQ1rIWR4078f2g
	 pXOOsUfwnLcUD10nfWN//TnIv0gqDTGourL4vFcTB8FScztWak9vGFiAaY939U9ysgKi6
	 BJmL9vRfY6e1jgN1dAe+CXoz59hVlEfvkNUh9zWoK5oguqMlXHE/wy8algxr/udYQ3M1n
	 j3dTjSnBamVZplN9sAmyIsKPDIHWRYeDzpxW3nivtx4ixChU13YVjr8SclxTutZjOlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VkMbVWjD;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FED606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63FED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VkMbVWjD
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9995ce866so3697975ad.0
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206968; x=1794811768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BwZDJgsO5HNxhXhQgWhsz/Soth3IdSQ1hRMZf96JDjg=;
        b=VkMbVWjDjzQlGRDNVpxcnbz7UyKr5bLS0ebDxVneRLwhfgZULTzuGDOdlqp0eT5d2w
         dVccb3UUh2MwawcjDoTkGvPrqSqYDqo8cPr7xxGSIP0k8ChgGa8qjwgzUyrQefX2JOy4
         uo9JEn9ljo1V+V5WJHcEMJQ+sm6sXwh8Pq3Q4uNL01RHxqxNiq7tYLf8A8FsQUTtJvZp
         gpi7RK24oUvaiAkS3TIarOTEaCPJtWIGrfdkjLWfVv82ahw02fWCMVbgq0vmIle6szdy
         s/QV/57OW2coG+MMWu5CZ4DVLgT46Zq4NpWapJg4J+28NHUAMm0qf8iGgOK3goRLyG9d
         1f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206968; x=1794811768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BwZDJgsO5HNxhXhQgWhsz/Soth3IdSQ1hRMZf96JDjg=;
        b=FqlESdspf5/dx4qnGPt0qKR1SrxEPS7z7oBNkHxv6RL21KxiIg6CILh7O8uR5Ev9yg
         LO2kWOC0y8SGN7bUWVWTuvFtPo45yP3b1n7GX7fcHZIEmVgtH1a3GtRMgt5iBHnW3K9s
         SMnYE1ShYXKZEC/CivFPiigDX0YGznIM7sWw2Aqhij+iSa1Sa6BVMBdG2uSkSijbpZZh
         PMO5VleyYD7La6xTKUokd0NJlQjaeabOwEmbfmwtqtM740ieZBy9hMbzs3bKcnHeQCqZ
         yQiH1dXGe/ruL8vCaLx9A4wG1WJUvh1bWdH9j+Gz3OEOQrRQRcx+w5S8eshEI4JxJhJH
         Yy8w==
X-Gm-Message-State: APuU4Z///n2MTjs0GPo3vArw/9qclt/Bssb47iifc++PS1oKkbZvG2uP
	KHl0xGIKw+Fwax2YHUi+Ke9H0BzhJrYNV9ydvy7yTD6CK4c1VJdQtjczFaIOmw==
X-Gm-Gg: AYBFou20cOit6oMp6ey9dY3taq9QVg8NWXqbu00nR3o761NrJ5mqZtE/Rs2A7UYhTuR
	angSi+5GTc4BV2Ukptwi5nL4bWUNWDRduWGBJ+bwRcGiCKfidxomx0ccayLIodFUaIjX+U01+qC
	Kj/xsCb+ZhDHralwGtIyj7x1aNRQ0ZZ76JcRJPT23XSBO5reR5vLzJz3VnutYlzwb+n1ydH+kci
	bLZCKyuN1OV2gvjIc6TutF24fzGxRDteudqG+sFcnUc4DxpmLYO8j8zunb85NhZU+ZllWR4+WUF
	YIezeGgiTce2mdkVwpYKnYZOmoBdIHoil1n8cD+fI6XdelSFMx4cfV3Je/mxuhRzH0i8vayxWHk
	FWuCX3yII4HocoBwaZz5y5FhQ41RUURp6RwCYzB/EzTZVViJ/Le89d/p373G8SPO2jlwzW0VToM
	4hKjot7PDpnRp1IUuG7+QuxNhhn1I2y59mp3yi2MfFIpyidbFs4qEfj+30ueB1QiwJn0blmuvdK
	6zfW/2masKz0TfdZugk+x9GpDlVEmdjwPh7VKTbCG/HLENlfkmiRw9Vgy+O7ajQbcgvpoA4c+vz
	zwCO/CKSEa9xZG/8ox2McQt41bA7KjjcTYZhiqF7PEUHjUxFLbOWL4gAVFWxysC3CsJPqaX+7NN
	9Kqv8AD6eNzVyVIlhkQ46IJuQMLcXNvtxUALDBu9yx3p6QJLiJFlCYtZ4HyAjVrbkyi7h/G7pfA
	==
X-Received: by 2002:a17:902:e88e:b0:2e8:4066:d247 with SMTP id d9443c01a7336-2ed837d54dbmr30698195ad.33.1794206967547;
        Sun, 08 Nov 2026 22:49:27 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed815e72acsm8032665ad.13.2026.11.08.22.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:49:27 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 22/26] bpf: Remove scalar ids from regsafe()
Date: Mon,  9 Nov 2026 06:47:06 +0000
Message-ID: <20261109064715.2382452-23-alexei.starovoitov@gmail.com>
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
there. For two scalars range_within() and tnum_in() are enough. Remove
check_scalar_ids() and the table of cases in regsafe().

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

