Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B075156F45
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029100; cv=none; b=Bpk4wmjXr4Gg5pPi31g0Ozh8biIUcInOQ2YYTX9PhSAYhGtQ8Vd0mONhfLnFSzGaFLBElEpwHvneZpG2lrNKIt2HNs9ahnoRHGwvlEBYMtSF9vw1dD57zsaxLRY+eHXkClzQHZ7/0GM6qXbfoIYbBwlawPcdGIGSEIjb7tYLf6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029100; c=relaxed/simple;
	bh=ZgjYlZH5iz2CBUyuzZZO818dS2tf/jwsZqpBB31v7x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdHMkl0oqHzDZwjNJbMUjKfEtQvbS7lp+KEjD+v+ZYdO0xXOFB0d6wrDisP6VVktmZNuuo7CkWn4S8koz8PR8dZAYiTSy1X8G/Va8inMfY1S02M6c50TJ+5r5r3qLEBhI5og2z1LNkDXr/E381fUYFHjX4rNFEsNxhm0sq89xjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8u+LRcS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8u+LRcS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA2FC116C6;
	Mon,  2 Feb 2026 10:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770029100;
	bh=ZgjYlZH5iz2CBUyuzZZO818dS2tf/jwsZqpBB31v7x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o8u+LRcS9NUrOtzPHfMbWNzfjgJg1VRWa2OHmOGOvPQmhGRTBcrkBFd8C1BHYiq68
	 6gow51iCs0+j0KmY3+q8xo6gFNdIV77PKziBM/MxuCauJvZPVdeiGDCfhoEWRt/bSm
	 RAYesUs8YZii430p6IJgzRq2X5eBAkqxpP08hBEmmusO/chQUt3PgVkXrVkA7VoiIT
	 CBEwCCdKL8becI8/1jR6boQRZp6LjR69RM6h8ui4Xuf1Cmzd+Am76jL6wrwMea6vHj
	 CacDMak7qlEh/1q+yNi4eVywIRC6slVhhLRRK4JKNgfXm+wCgBJiH1huAfCoNH3BG3
	 ZJ1Uhn+P8zDXg==
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
Subject: [PATCH bpf-next 2/4] bpf: verifier: Clear singular ids for scalars
Date: Mon,  2 Feb 2026 02:44:04 -0800
Message-ID: <20260202104414.3103323-3-puranjay@kernel.org>
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

Verifier assigns ids to scalar registers/stack slots when they are
linked through a mov or stack spill/fill instruction. These ids are
later used to progagate newly found bounds to from one register to all
registers that share the same id. The verifier also compares the ids of
these registers in current state and cached state when making pruning
decisions.

When an ID becomes singular (i.e., only a single register or stack slot
has that ID), it can no longer participate in bounds propagation. During
comparisons between current and cached states for pruning decisions,
however, such stale IDs can prevent pruning of otherwise equivalent
states.

Find and clear all singular ids before caching a state in
is_state_visited(). struct bpf_idset which is currently unused has been
repurposed for this use case.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/bpf_verifier.h |  7 +++-
 kernel/bpf/verifier.c        | 75 ++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 8355b585cd18..746025df82c8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -697,8 +697,11 @@ struct bpf_idmap {
 };
 
 struct bpf_idset {
-	u32 count;
-	u32 ids[BPF_ID_MAP_SIZE];
+	u32 num_ids;
+	struct {
+		u32 id;
+		u32 cnt;
+	} entries[BPF_ID_MAP_SIZE];
 };
 
 /* see verifier.c:compute_scc_callchain() */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 17b499956156..9324d96aae92 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19461,6 +19461,78 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
  * doesn't meant that the states are DONE. The verifier has to compare
  * the callsites
  */
+
+/* Find id in idset and increment its count, or add new entry */
+static void idset_cnt_inc(struct bpf_idset *idset, u32 id)
+{
+	u32 i;
+
+	for (i = 0; i < idset->num_ids; i++) {
+		if (idset->entries[i].id == id) {
+			idset->entries[i].cnt++;
+			return;
+		}
+	}
+	/* New id */
+	if (idset->num_ids < BPF_ID_MAP_SIZE) {
+		idset->entries[idset->num_ids].id = id;
+		idset->entries[idset->num_ids].cnt = 1;
+		idset->num_ids++;
+	}
+}
+
+/* Find id in idset and return its count, or 0 if not found */
+static u32 idset_cnt_get(struct bpf_idset *idset, u32 id)
+{
+	u32 i;
+
+	for (i = 0; i < idset->num_ids; i++) {
+		if (idset->entries[i].id == id)
+			return idset->entries[i].cnt;
+	}
+	return 0;
+}
+
+/*
+ * Clear singular scalar ids in a state.
+ * A register with a non-zero id is called singular if no other register shares
+ * the same base id. Such registers can be treated as independent (id=0).
+ *
+ * Uses two passes to achieve O(N) complexity:
+ * 1. First pass: count occurrences of each unique id
+ * 2. Second pass: clear ids with count == 1 (singular)
+ */
+static void clear_singular_ids(struct bpf_verifier_env *env,
+			       struct bpf_verifier_state *st)
+{
+	struct bpf_idset *idset = &env->idset_scratch;
+	struct bpf_func_state *func;
+	struct bpf_reg_state *reg;
+
+	idset->num_ids = 0;
+
+	/* First pass: count occurrences of each unique id */
+	bpf_for_each_reg_in_vstate(st, func, reg, ({
+		if (reg->type != SCALAR_VALUE)
+			continue;
+		if (!reg->id)
+			continue;
+		idset_cnt_inc(idset, reg->id & ~BPF_ADD_CONST);
+	}));
+
+	/* Second pass: clear singular ids (count == 1) */
+	bpf_for_each_reg_in_vstate(st, func, reg, ({
+		if (reg->type != SCALAR_VALUE)
+			continue;
+		if (!reg->id)
+			continue;
+		if (idset_cnt_get(idset, reg->id & ~BPF_ADD_CONST) == 1) {
+			reg->id = 0;
+			reg->off = 0;
+		}
+	}));
+}
+
 static void clean_live_states(struct bpf_verifier_env *env, int insn,
 			      struct bpf_verifier_state *cur)
 {
@@ -20459,6 +20531,9 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	if (env->bpf_capable)
 		mark_all_scalars_imprecise(env, cur);
 
+	/* find singular ids and clear them */
+	clear_singular_ids(env, cur);
+
 	/* add new state to the head of linked list */
 	new = &new_sl->state;
 	err = copy_verifier_state(new, cur);
-- 
2.47.3

