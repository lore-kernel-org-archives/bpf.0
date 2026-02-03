Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5953D3318
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137483; cv=none; b=dOVVXKt4OydOZfCiiGUgh5m+0NL0zVNMP55x4r6V019K4Y4We3qwi5hvDTi1IKYIPhfnWBx/Anz+hCXci3aa3zyx4kJA1739BJi+9Tg2zJK+iehx4pODPihiqnE0FzokuB7zqYw5oltPTz2ZlqXZAEdeDv78NKvf+qqKO2sykHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137483; c=relaxed/simple;
	bh=+TnJsVdsbTwFmEWOaf9sKSP0YiUIPg29SDnTkOmmU20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2WH3Jev3kUvG/BWqpCUvHy/8j71bfYoGx4Ivix+9+ZIZZB6sH2blEH/dTH+VZ5DQXTIJNlWWrB4PqtBxJb/ZXKcPY7Dxx1CFlKTGQjZpc8zZHXfH3NjiKUFRpOVHxUPgajKc87Md7dkJuurcSe5jQ+HjtN5D+DEgHMVFFxgix0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFM8uduI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFM8uduI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E93C116D0;
	Tue,  3 Feb 2026 16:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770137483;
	bh=+TnJsVdsbTwFmEWOaf9sKSP0YiUIPg29SDnTkOmmU20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uFM8uduIC13OihfObB+Mmk4oJgYZJLMRcG8cDd4I5xme8sgXqp7nWtJWi2zGKxD6C
	 JYyuG66+JUA80xrj2ZgIFOPmYztY2dfrGz2pQoAif+BYDsB30JoOS1NDXvp1cIMjSj
	 kV8S6aXDST5A4bu4luLti1BaUZs/hLD4waIRnf6uxDRLEqwShE+vwgYkSJIUSeEIOf
	 kuU4606j2t5aIKeuF6rj9MfVR2UM1E82olO0dmJekuPt/OYm+8534Vtvy7b61z3x0a
	 3VviKXKPay52sKQYGw5V60eE6T/8vwRaxLQ07b8UUAYKTrIp0EhV3do0PDD3M3tktX
	 N9F71xzF+nSEg==
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
Subject: [PATCH bpf-next v3 2/5] bpf: verifier: Clear singular ids for scalars
Date: Tue,  3 Feb 2026 08:50:58 -0800
Message-ID: <20260203165102.2302462-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203165102.2302462-1-puranjay@kernel.org>
References: <20260203165102.2302462-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verifier assigns ids to scalar registers/stack slots when they are
linked through a mov or stack spill/fill instruction. These ids are
later used to propagate newly found bounds from one register to all
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/bpf_verifier.h |  7 ++--
 kernel/bpf/verifier.c        | 68 ++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 2 deletions(-)

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
index 17b499956156..d92e10d4c2cc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19461,6 +19461,72 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
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
+	bpf_for_each_reg_in_vstate(st, func, reg, ({
+		if (reg->type != SCALAR_VALUE)
+			continue;
+		if (!reg->id)
+			continue;
+		idset_cnt_inc(idset, reg->id & ~BPF_ADD_CONST);
+	}));
+
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
@@ -20459,6 +20525,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	if (env->bpf_capable)
 		mark_all_scalars_imprecise(env, cur);
 
+	clear_singular_ids(env, cur);
+
 	/* add new state to the head of linked list */
 	new = &new_sl->state;
 	err = copy_verifier_state(new, cur);
-- 
2.47.3

