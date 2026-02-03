Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDC92DE715
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 02:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085386; cv=none; b=ZBKqYqUUmlorOKOixXo2Ucqjq1BGyBKbPkuGkc4oKRSWUz1nxK1fQSRSGfl4kHvClRQ66SJZnqnBd0u1CnwC47suVT++1X+phIXtlIRv9mGlSeeGV03vjvnHeGBkLNtQjxkdn3wAwIB3OFTQS4pcxyG0AsIU06WxYo+5oVdwE5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085386; c=relaxed/simple;
	bh=xokwRqRV0djMDIYGjTPqqy3xPBDRZiWE83pwzLBSocM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROYJs3ncr/8tbTvaNDNKMLkPZQapjF0ZsfPvgTabQ2ja1Ctf1hE0Rkmb0n4uftFkaDmt9SZNEUCClyuh3ILaJ2B+ZFGmMk0VJwWh2u+6TygYsZ6XIlJW/6rLVD2SCjvMtUGomnI5TUmdi1+gnlVYMPlxDGpTKMFtbSlyT0kYxrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lvzsr6Dc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lvzsr6Dc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FC8C116C6;
	Tue,  3 Feb 2026 02:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770085386;
	bh=xokwRqRV0djMDIYGjTPqqy3xPBDRZiWE83pwzLBSocM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lvzsr6DcLxBlFUldOnZU5DkvOCISXDXdhb20biGscWeyyx0FnCNG5QcB2jG1hpj9T
	 ChdOzIsXSVK0LjrgNXOzo+XloyXQYuZ1NskdqDJ6tRY92laH5T8AL6gpJvOv3kWN15
	 E68yqVRm68yxhMrzx04XEHUm35pGvGMQOhY9R2Tu5NC4G1lma6MmEroWki45N7SfkC
	 pgyKmXFn4xpleEcRvD11xOrOnzWaT/5n1JPG1c6OoRtf8p521+UFOXuA9OsI86Kgmt
	 VbfQL5cHVWzf2iu4u2gXT5BrokDpOVr41IyO/qfMSomL5scc200ZpYgXJ4ZcFppfUU
	 DN5vYjxeS5thA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v2 4/5] bpf: verifier: Relax scalar id equivalence for state pruning
Date: Mon,  2 Feb 2026 18:22:27 -0800
Message-ID: <20260203022229.1630849-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203022229.1630849-1-puranjay@kernel.org>
References: <20260203022229.1630849-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scalar register IDs are used by the verifier to track relationships
between registers and enable bounds propagation across those
relationships. Once an ID becomes singular (i.e. only a single
register/stack slot carries it), it can no longer contribute to bounds
propagation and effectively becomes stale. The previous commit makes the
verifier clear such ids before caching the state.

When comparing the current and cached states for pruning, these stale
IDs can cause technically equivalent states to be considered different
and thus prevent pruning.

For example in the selftest added in the next commit, two registers - r6
and r7 are not linked to any other registers and get cached with id=0,
in the current state, they are both linked to each other with id=A.
Before this commit, check_scalar_ids, would give temperory ids to r6 and
r6 (say tid1 and tid2) and then check_ids() would map tid1->A, and when
it would see tid2->A, it would not consider these state equivalent.

Relax scalar ID equivalence by treating rold->id == 0 as "independent":
if the old state did not rely on any ID relationships for a register,
then any ID/linking present in the current state only adds constraints
and is always safe to accept for pruning. Implement this by returning
true immediately in check_scalar_ids() when old_id == 0.

Maintain correctness for the opposite direction (old_id != 0 && cur_id
== 0) by still allocating a temporary ID for cur_id == 0. This avoids
incorrectly allowing multiple independent current registers (id==0) to
satisfy a single linked old ID during mapping.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c                         | 63 +++++++++++++++----
 .../selftests/bpf/progs/verifier_scalar_ids.c |  8 ++-
 2 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5da1c6036e44..fc3991c343be 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19387,13 +19387,29 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 	return false;
 }
 
-/* Similar to check_ids(), but allocate a unique temporary ID
- * for 'old_id' or 'cur_id' of zero.
- * This makes pairs like '0 vs unique ID', 'unique ID vs 0' valid.
+/*
+ * Compare scalar register IDs for state equivalence.
+ *
+ * When old_id == 0, the old register is independent - not linked to any
+ * other register. Any linking in the current state only adds constraints,
+ * making it more restrictive. Since the old state didn't rely on any ID
+ * relationships for this register, it's always safe to accept cur regardless
+ * of its ID. Hence, return true immediately.
+ *
+ * When old_id != 0 but cur_id == 0, we need to ensure that different
+ * independent registers in cur don't incorrectly satisfy the ID matching
+ * requirements of linked registers in old.
+ *
+ * Example: if old has r6.id=X and r7.id=X (linked), but cur has r6.id=0
+ * and r7.id=0 (both independent), without temp IDs both would map old_id=X
+ * to cur_id=0 and pass. With temp IDs: r6 maps X->temp1, r7 tries to map
+ * X->temp2, but X is already mapped to temp1, so the check fails correctly.
  */
 static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 {
-	old_id = old_id ? old_id : ++idmap->tmp_id_gen;
+	if (!old_id)
+		return true;
+
 	cur_id = cur_id ? cur_id : ++idmap->tmp_id_gen;
 
 	return check_ids(old_id, cur_id, idmap);
@@ -19618,11 +19634,21 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		}
 		if (!rold->precise && exact == NOT_EXACT)
 			return true;
-		if ((rold->id & BPF_ADD_CONST) != (rcur->id & BPF_ADD_CONST))
-			return false;
-		if ((rold->id & BPF_ADD_CONST) && (rold->off != rcur->off))
-			return false;
-		/* Why check_ids() for scalar registers?
+		/*
+		 * Linked register tracking uses rold->id to detect relationships.
+		 * When rold->id == 0, the register is independent and any linking
+		 * in rcur only adds constraints. When rold->id != 0, we must verify
+		 * id mapping and (for BPF_ADD_CONST) offset consistency.
+		 *
+		 * +------------------+-----------+------------------+---------------+
+		 * |                  | rold->id  | rold + ADD_CONST | rold->id == 0 |
+		 * |------------------+-----------+------------------+---------------|
+		 * | rcur->id         | range,ids | false            | range         |
+		 * | rcur + ADD_CONST | false     | range,ids,off    | range         |
+		 * | rcur->id == 0    | range,ids | false            | range         |
+		 * +------------------+-----------+------------------+---------------+
+		 *
+		 * Why check_ids() for scalar registers?
 		 *
 		 * Consider the following BPF code:
 		 *   1: r6 = ... unbound scalar, ID=a ...
@@ -19646,9 +19672,22 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 * ---
 		 * Also verify that new value satisfies old value range knowledge.
 		 */
-		return range_within(rold, rcur) &&
-		       tnum_in(rold->var_off, rcur->var_off) &&
-		       check_scalar_ids(rold->id, rcur->id, idmap);
+
+		/* ADD_CONST mismatch: different linking semantics */
+		if ((rold->id & BPF_ADD_CONST) && !(rcur->id & BPF_ADD_CONST))
+			return false;
+
+		if (rold->id && !(rold->id & BPF_ADD_CONST) && (rcur->id & BPF_ADD_CONST))
+			return false;
+
+		/* Both have offset linkage: offsets must match */
+		if ((rold->id & BPF_ADD_CONST) && rold->off != rcur->off)
+			return false;
+
+		if (!check_scalar_ids(rold->id, rcur->id, idmap))
+			return false;
+
+		return range_within(rold, rcur) && tnum_in(rold->var_off, rcur->var_off);
 	case PTR_TO_MAP_KEY:
 	case PTR_TO_MAP_VALUE:
 	case PTR_TO_MEM:
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index c0ce690ddb68..c8f8820336b7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -723,9 +723,9 @@ __success __log_level(2)
 /* The exit instruction should be reachable from two states,
  * use two matches and "processed .. insns" to ensure this.
  */
-__msg("13: (95) exit")
-__msg("13: (95) exit")
-__msg("processed 18 insns")
+__msg("15: (95) exit")
+__msg("15: (95) exit")
+__msg("processed 20 insns")
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void two_old_ids_one_cur_id(void)
 {
@@ -734,9 +734,11 @@ __naked void two_old_ids_one_cur_id(void)
 	"call %[bpf_ktime_get_ns];"
 	"r0 &= 0xff;"
 	"r6 = r0;"
+	"r8 = r0;"
 	"call %[bpf_ktime_get_ns];"
 	"r0 &= 0xff;"
 	"r7 = r0;"
+	"r9 = r0;"
 	"r0 = 0;"
 	/* Maybe make r{6,7} IDs identical */
 	"if r6 > r7 goto l0_%=;"
-- 
2.47.3

