Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397B62F1FD5
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 02:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085368; cv=none; b=d/sYp5rI6JcGqmYjkUC76USab8HMMkTK36dBivSHR/Abgigls1URJKOGnnw1TopEiXnkh0i7UBmE8JX+YkU1KqkVivy6jANYogsO5lHUDccV9dYM4918x2PaNtBJmwyMKvwRUADhR5OvHq//26HzLw2JyIC5+xgyp5868tHfQmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085368; c=relaxed/simple;
	bh=1KM7io6THEdt9VpotiDlTcOU5pJY3KGdWXSdzu0J4Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pN4R+YTHs8egmZfj02OxWa45rVgqfCJswMZzCsaGb1POeQfAhdrUYCwNwuHzuerq/ZbNuBkE3kR2VlBQj0Fae/71Bhd3vaJbGSmCg9osXP4pB83CcwNNMNqbj+GzNjiDyQYKS4d54S3/fVTbxRDvXK2+JJ2+qOFTSXzD5j5YvfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpQiHJmI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpQiHJmI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B362C116C6;
	Tue,  3 Feb 2026 02:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770085367;
	bh=1KM7io6THEdt9VpotiDlTcOU5pJY3KGdWXSdzu0J4Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fpQiHJmIlsA2FJpg/h0u4aaNjbZ5qKqEH2rAbWRjsEdjPiyTexCOG377EIblto3ov
	 4KeHOeD0yFIzGjUYt1k4TgdU5SXw3M6oZgsmZ72PNfE124FiqvzAEVQr8TBjuxmBQv
	 LWxCgdRmMLfWBlHpCieqbr5gTeDVQgeKfJqnlLlT8Qr0V949TH+SAblwAOsFJ4lnBz
	 eBkmTdqD3CGyAYmWbySLsHeqwUiFaPk/i3IITAR5yfHpQ83fOyQWar00qc5IFK6zAr
	 xdjV47yeT3Ekg1KF6P5Xqf35/KZj4xvZu6Mf/wCipSlC73u0tmSM8PsS3fHF5bnKL8
	 Tt/QXt7CLVhFg==
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
Subject: [PATCH bpf-next v2 2/5] bpf: verifier: Clear singular ids for scalars
Date: Mon,  2 Feb 2026 18:22:25 -0800
Message-ID: <20260203022229.1630849-3-puranjay@kernel.org>
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

