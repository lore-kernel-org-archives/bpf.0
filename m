Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E40435971B
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029107; cv=none; b=FYadPCGbUucc5rVPNjwgVDuqNiur/vinZN8v+QNgSoo9hWBrIe9KZVPvUx5ziri+GOJlZZz1xj3jfkSYHfU/fztd7J1UIybDj5Dgg9IZ4hcfXJv41u4NWoMxQNLpKsAuEGO9g+LVc+lBt9s5j6dnE73rAF8fx1gbPgdE00zWOfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029107; c=relaxed/simple;
	bh=Hm1IVE+G6iXo/jEq3/yAFEJAstywpn2z+Tb9Wg41c3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSdvRJsDQJCarxXNgsQNXUzn1PNLAAwy/vOnKiE0w/NLQbe2kWpQaoegO5fBaxNC33h15/PRgvkP/CIim7i9CctlCAtC20yyf6AW1w5ZGLt9XF9VbLTI0vZniwXHD710kHiAMSqbT7g6yWTSYe7Qrn445IgLtbgzICGEO2kOHec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLeoO1du; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLeoO1du"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3FAC116C6;
	Mon,  2 Feb 2026 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770029107;
	bh=Hm1IVE+G6iXo/jEq3/yAFEJAstywpn2z+Tb9Wg41c3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fLeoO1duGCV9FX7tOP0c7luywYqpx/GMKity0dz1x17X3+FkfGz5zEliW59dhXC1M
	 EWcVx6TGRqWJi1Xt6d4ObzfloARS0QTZEPWG8A/Wvgfz+lQm8HKZUD7SuZ32spW6Yg
	 mC1cDaiRolMVodoigZuUHiKeHGLQbwNCCJa6ah8m9dpw8KQk445wF1iv6iL77P6iC0
	 2deJbTa5VwESd1eeK0kSSH5zOz7zyAj6UTVxGPoVjKKAV/h2WghXSSPPUCeZq26g2W
	 WQ6km9ulTlHg7xP2ZS56jhV++Xu4SRHxQ18YDE2Yn0QjwLfITKob/Jhjul/BfL1dZs
	 o28G9qxAeO9tA==
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
Subject: [PATCH bpf-next 4/4] bpf: verifier: Relax scalar id equivalence for state pruning
Date: Mon,  2 Feb 2026 02:44:06 -0800
Message-ID: <20260202104414.3103323-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202104414.3103323-1-puranjay@kernel.org>
References: <20260202104414.3103323-1-puranjay@kernel.org>
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
index 9c14dbe7c10d..65c499867566 100644
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
@@ -19624,11 +19640,21 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
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
@@ -19652,9 +19678,22 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
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

