Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7B4B2044
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542933; cv=none; b=MyTMLEQcI8XoFkLQIlRxFoizTWR6hhRELrmK4Q7Bmd0rFEgapuig8ap6dkjBnCByHX5xFdbLf4yEYtmwnqwM72lczxEsNIRgHiRuAj1TMrEUaBBqefk/GLLCucie3NX+aHqvAz+ZLOmDp4Cy9YgSZL8FRK4ihScdel7SLzzBKiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542933; c=relaxed/simple;
	bh=B1qMlwjQFsUJGKweD4YU5BsmnPJtl8z2aM1VrE9ElbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoJNhxHze3q5IaOcClFWKjtoezt3DVk3AqsSRMbf/rWQSSZud0TFszwdtBrEogVnW/7DgotZiZNJxouAkygAddkW1Y0Vf6Tl7sbVOlJLZtxnHWcEA+7TYFRALHgmHwMwp8eObuhI+xp+SNOmkSmfCNzrpcuJgZflueyWwaBaCRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTMW7c/3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTMW7c/3"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-398a5aad413so4405932a91.3
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542919; x=1792147719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nWhvNJXf35rFulqnEEswGH/47TRX+yQFzBBkHaTltJA=;
        b=HTMW7c/3alvzeIdmoCTo6py8GYjPg1OGQTQQ+ty4omordSjzpHwd59vJ5OqX1yPtl1
         ICGyLgTLIzrhIUeFu1hlUV625q1UQcYUTnJ9+DQA1UvyEVT4y8UMnCLP2VkunRLATQ61
         fY+xvcL+ir2lxl6GGkSbF5nLFZLCwLly5DY0DnOmd2X524MT5yGtcORiCnRUcE5G5KIt
         1d9WvvA2gCAnAL7+pe7hXPg8b6IVlT3LHDbMbfVaWM3cto5s90NItPW6GUCHBcae3jlU
         gQQWTQGr9TItdV3yAKiBwIVchAAivgjer1YjOQZWlVcGXlTpXCnFMdlGCwZQ42bpSNrs
         NQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542919; x=1792147719;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nWhvNJXf35rFulqnEEswGH/47TRX+yQFzBBkHaTltJA=;
        b=UeQ6TnAveaDCBze5YEW5/ZJasAF1747J/TruHUxgJ3bR2uLQd+/5FnWhhIMjzUc3LC
         dN++NfHe+Jd0/e3HVh439p556M+vAC/x8maHx5b2c4mAaVYrB+aekWifsxNQgTUu4vzX
         81zauOA1RqDi/b5Gs7CY1teizb/QKiSvkgbGnEUqYJkPq8heOq5v1H6QjvXh/jcbkeWg
         xPkg53ghjJLbqldKDWNrKvujStQbjGcJqioDpC5ZbHUdS6ieGtqVZ5drX5uno2mhr0xf
         PXPma90oy/NM4zyHGSmPEa2HF+r9pOgFt0rj+bgvsCNObrrHUWn4v8i86aUh8JLm307H
         9iEQ==
X-Gm-Message-State: AFq9FYIIi+J4Qr8IF76UVN6ncsKOKNmYm8TpP+1HvKzWKkS7R+S3lj7v
	6C0VE61sjqErJutT3jaFhFUAAEOsKAPNato2AS8xtbOni9EUT3jhPKk+86IhibTn
X-Gm-Gg: AYBFou1tAgZbmDYUGHnzIIGK1xm6RiIjPOmolStA0HcQ8h1xdPSwmcRD+3eNSIkYhhP
	GkV10GisM5IvCykHPvI5Rh4W0VuINSaMDIaYYtqHcjFK2yymim9CTuEUkJMjPxK2Ig9/OSFqYuD
	XfU1LBLQJJenMWMzTrJguJNvQfbQQlhEtCoUVKBGGLjft5Dt0vxtMP4uAIEa0385ZgUoWpQamC2
	69AaRcd6OaARM8Kd7dVQCV5IV1eNRv1gJW3EBUtt7ifW1RzRH/Abdxsg0ihnqURIwK21jKbtxlv
	uUiuzhFiYEiBRE5sYJarXdFvAM8I0UBOvdWg2Ljf/ulEpgL6UU+alNU8UukaWLe07kx4V/HwUrd
	rNfu0Nci65x6m0Nzk9pF2xTklQ3Wpl9r/Pe5G2AOxBQkWzwsOqHvU1IBGg4xZaS9NS6N/a02yCi
	ijn7qnRx27+wCWFm2RIzFkq9KsllHHA/nKS/0BJ2D5sbatSBuHuVjPLPuE/fbQu1xxDYbzYokjI
	F83h5585nPuvPmFrSVIvFEa6g==
X-Received: by 2002:a17:90b:4ace:b0:3a8:59d3:530f with SMTP id 98e67ed59e1d1-3ab3a97a06bmr1581097a91.57.1791542919453;
        Fri, 09 Oct 2026 03:48:39 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:39 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 28/51] bpf: add bpf_split_cur_state()
Date: Fri,  9 Oct 2026 03:47:46 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-28-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
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
index 1d0a0b64b1f3..711a4cb24c06 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1339,6 +1339,7 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
 int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx);
+int bpf_split_cur_state(struct bpf_verifier_env *env);
 int bpf_update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 
 void bpf_clear_jmp_history(struct bpf_verifier_state *state);
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 2f6a7620eb72..b1e2daefc264 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1262,11 +1262,61 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
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
@@ -1594,44 +1644,5 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
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
2.53.0
