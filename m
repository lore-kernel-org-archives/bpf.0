Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF12C47D45B
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432469; cv=none; b=IE2lwQfuw3wXMvtLQykWUeoUaAll6r1mXR8oBCADd1lg2L6J6btsjAxyzbrY1mVR60AmFfxu8UOQkR85olQ37MBGCC4xSJw0MdwsCbE8D6hqNh4IQ2X3byQO+A1/hOk2j65lp13bCARYW5Dex7Wzzq/CVsa02aI+y4MIC3nGBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432469; c=relaxed/simple;
	bh=WIvGprRCkMrA5sid+9UqI4UJ2ja2jMf34BYZ3fzu/Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtUEV2aXOL1kQA/hBiG6MUvuXOcRFjR4G2qPav4e5O2xPs8+mvQnKfR/gZLVAb8NEEnTF+ejSOiuM9lkTIgMLo08aHBrc5r5kbpP2XG6uIJyCtWrIsS24JtcCLbLox23M2EfciOf0PyBhLsibzd/nlgHgHuNVaDB/xxH7L4+4Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9G/zL98; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9G/zL98"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso1075325a91.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432467; x=1791037267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tw5+coc6MRDRqijXbt/dsjDBETnMqD+0RhmWEEk0G8Q=;
        b=p9G/zL98O9d6kGc5VqQGeF0ZTe/nINW4VaScq5h+25uQSpaB1pELUXL4q/tyMjBE0m
         eqE0S1MD4dByPNWWDKxnHLGVPlkcP+54J9q0vBUMt93j9l0VtzCWwuFv62eYjDN9ijfC
         6KVaFzjyUIAfLZ3CVxjTWPsNoOIsNfGzCe9w3iuTX+CfakFzI8ZFuI37tquDb56mm7fD
         jdoVfNGqKw+j7GxOxmm1cKuVhRn+eoM6diwKnku3WZCrTeUxOf/robQl7MLZ/dI3y78G
         yqozkVX+Y5Jemkq3qILGcnxuWSj2t73LNWEQbi6B4xqEq9jZC3hvomFFrV05ogdbY+7+
         Or8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432467; x=1791037267;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tw5+coc6MRDRqijXbt/dsjDBETnMqD+0RhmWEEk0G8Q=;
        b=Z3I/fpZwCmr/6x11gqgOolF8mCtQrA1KhHyb93xXocBq9ZVgaDEGht1s3NRbp9p3Zm
         1rpl9tne/Yb1KV4b9APdLlxpZCb+nc/4E6rsqfFUIlB+FMPI8MCa9cBYCt9CgOdC/zZa
         J1rHFjHF6bCK/Os8GPAEC90Xm75kJfE/zHNdt/Bxmjlu2jnFvmwVr/IMtP9NkikgFmAd
         ibIwZW5bG0F5+Kt5fUh3kbaPSnTG7PyQW69VgE9DIZZwmf6Y1d8gfwLMfwFYcg/npWKF
         i3IVwL5hF+hknOBSiYrLdVZJ7NjBLsZdBQ21on/PtUDeMun5yDMDNmSjIWN2zcRf3S74
         VS5w==
X-Gm-Message-State: AFq9FYKkQC/LG1ld6B1Kse8MjKzFKIKU3knBbXYkRUW/Avv6jhiVgYhl
	uXCmN8ydVKRg9Le2Edsml3M5KVlZ2Q8+5ska4dzMCoWIhZ3PwdiGAt5wRa7x6E0GeCM=
X-Gm-Gg: AYBFou0bCZCKYYx+t3OZssqy1QPP/u47z4gXB5d4efMeCjIohSb/fEw6KB6v8IpQj3X
	B5IiMtJK3EIDhVxoPCE5nejZB4XCU9If+eaOlndhfKwgQOF/m/FqmZqNVvib/HgvLdRjhNU0lk/
	Tf8E1MnDhM+cYXqBfL5WSrRT8vkrtygacQ94V+9mNy+3S37zsifM6ILsGAXhr3u3pbF49PWJcCa
	3VYxFJ4nQGI4xfAqoz+lIkJpgXj+bhAkRy1VzhONBSFEYLSM6wTAv0BXkOHhT+ij4mDjyLKqhDI
	DmGjn/qJFFf5042JgJrAq/nQEldkTpjjI+WNuzCng6ARm3QoqIc9V/evOpvF7Hmdl7Anr/mt9ei
	nsO/IR/5XIevRjvP5lII7SZ54nZV+4UZDVTHbtjBNtiNI3Q+ZPSAJk1T8NO67jmfIiMCd2jQtwn
	FUrU3lS27MRbQfuiUoVSns1LmRu1ZwgpdaHK/moXua54OOZW44fcOPnZzaeBngJ8ifCKf5HxfUy
	vtLCQeyMNTBt03aXhDbQ9LiBZJ28zJpVopv8D3czQ==
X-Received: by 2002:a17:90a:597:b0:3a0:a055:1759 with SMTP id 98e67ed59e1d1-3a0bb60e55amr3031338a91.40.1790432466458;
        Sat, 26 Sep 2026 07:21:06 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:06 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 22/36] bpf: add bpf_split_cur_state()
Date: Sat, 26 Sep 2026 07:20:20 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-22-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

SCEV widening needs an explicit checkpoint preserving the original
loop-entry state, independently of ordinary state-cache heuristics.
This commit extracts checkpoint creation logic from
bpf_is_state_visited() into a separate utility function.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/states.c          | 95 ++++++++++++++++++++++++--------------------
 2 files changed, 54 insertions(+), 42 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 728567bde055..76833c2ad452 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1329,6 +1329,7 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
 int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx);
+int bpf_split_cur_state(struct bpf_verifier_env *env);
 int bpf_update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 
 void bpf_clear_jmp_history(struct bpf_verifier_state *state);
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 3eaae1452c54..d7f9f879bd87 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1268,11 +1268,61 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
 	}
 }
 
-int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
+int bpf_split_cur_state(struct bpf_verifier_env *env)
 {
+	struct bpf_verifier_state *cur = env->cur_state, *new;
 	struct bpf_verifier_state_list *new_sl;
+	struct list_head *head;
+	int insn_idx = cur->insn_idx;
+	int err;
+
+	head = bpf_explored_state(env, insn_idx);
+	new_sl = kzalloc_obj(struct bpf_verifier_state_list, GFP_KERNEL_ACCOUNT);
+	if (!new_sl)
+		return -ENOMEM;
+	env->total_states++;
+	env->explored_states_size++;
+	update_peak_states(env);
+	env->prev_jmps_processed = env->jmps_processed;
+	env->prev_insn_processed = env->insn_processed;
+
+	/* forget precise markings we inherited, see __mark_chain_precision */
+	if (env->bpf_capable)
+		mark_all_scalars_imprecise(env, cur);
+
+	bpf_clear_singular_ids(env, cur);
+
+	/* add new state to the head of linked list */
+	new = &new_sl->state;
+	err = bpf_copy_verifier_state(new, cur);
+	if (err) {
+		bpf_free_verifier_state(new, false);
+		kfree(new_sl);
+		return err;
+	}
+	new->insn_idx = insn_idx;
+	verifier_bug_if(new->branches != 1, env,
+			"%s:branches_to_explore=%d insn %d",
+			__func__, new->branches, insn_idx);
+	err = maybe_enter_scc(env, new);
+	if (err) {
+		bpf_free_verifier_state(new, false);
+		kfree(new_sl);
+		return err;
+	}
+
+	cur->parent = new;
+	cur->first_insn_idx = insn_idx;
+	cur->dfs_depth = new->dfs_depth + 1;
+	bpf_clear_jmp_history(cur);
+	list_add(&new_sl->node, head);
+	return 0;
+}
+
+int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
+{
 	struct bpf_verifier_state_list *sl;
-	struct bpf_verifier_state *cur = env->cur_state, *new;
+	struct bpf_verifier_state *cur = env->cur_state;
 	bool force_new_state, add_new_state, loop;
 	int n, err, states_cnt = 0;
 	struct list_head *pos, *tmp, *head;
@@ -1600,44 +1650,5 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	 * When looping the sl->state.branches will be > 0 and this state
 	 * will not be considered for equivalence until branches == 0.
 	 */
-	new_sl = kzalloc_obj(struct bpf_verifier_state_list, GFP_KERNEL_ACCOUNT);
-	if (!new_sl)
-		return -ENOMEM;
-	env->total_states++;
-	env->explored_states_size++;
-	update_peak_states(env);
-	env->prev_jmps_processed = env->jmps_processed;
-	env->prev_insn_processed = env->insn_processed;
-
-	/* forget precise markings we inherited, see __mark_chain_precision */
-	if (env->bpf_capable)
-		mark_all_scalars_imprecise(env, cur);
-
-	bpf_clear_singular_ids(env, cur);
-
-	/* add new state to the head of linked list */
-	new = &new_sl->state;
-	err = bpf_copy_verifier_state(new, cur);
-	if (err) {
-		bpf_free_verifier_state(new, false);
-		kfree(new_sl);
-		return err;
-	}
-	new->insn_idx = insn_idx;
-	verifier_bug_if(new->branches != 1, env,
-			"%s:branches_to_explore=%d insn %d",
-			__func__, new->branches, insn_idx);
-	err = maybe_enter_scc(env, new);
-	if (err) {
-		bpf_free_verifier_state(new, false);
-		kfree(new_sl);
-		return err;
-	}
-
-	cur->parent = new;
-	cur->first_insn_idx = insn_idx;
-	cur->dfs_depth = new->dfs_depth + 1;
-	bpf_clear_jmp_history(cur);
-	list_add(&new_sl->node, head);
-	return 0;
+	return bpf_split_cur_state(env);
 }

-- 
2.55.0
