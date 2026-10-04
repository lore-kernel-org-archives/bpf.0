Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9286439322
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121141; cv=none; b=X0U5IA1MnVfJ7+OqPgqbu/wTzuiTlIf0UChCExa+kizFVKZuuhs95qKzNOJUBE+KeTemPYhpj4VBUM+mobU7l2IcdLa+9S4hWLlJpUX6KguuUFFQZw4Y9RS7dXK0AtF+LAB4FHzKLwyMEl4GQZ9fJDML0LkfqeINYwpbwzC3ZBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121141; c=relaxed/simple;
	bh=UA/Ng3KROHd8W5wtcSR0ij5EgIfywv/CCHAsqOaNXFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJOYF/IA/0iBZL30Wba7l3f3gqHuMRGUaJbQtdsBU4uly8ege/M2UD3lEw7821bmS7UpUhSHMm2OBnoWsZXJKDdZMFWcajDQ770QM3WGSTql6ohlGhCuNrKa+RzKK3mxcQr6VdqExi/wC/PPBuwmZNOe5qwELhDdrbCqzecg87Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tEjqiets; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEjqiets"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469b355ffso239926b3a.1
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121139; x=1791725939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IPyLRYGNcoGAVp61kSyOsgClFCv2mTwynbfUldxGrkg=;
        b=tEjqietsklsTNAwvyRTsH3szTjN3a4eNZIKIwaEvZz5PUkWhT5ED5uKubFyZ06Qa8i
         /fCRL/F3hFN/d0mi04UFDXYHXuvJGdIVSwbFdrDVSy8l0gL68HDXMF4fDwU9N4HkOLJb
         PaF+622rTNdb97wUROx/CdtBx6CGCM/WqJwEZxou8mXS1vhuZdNsQiFDnPz5BXwd141t
         8jEBrBWzMi3G/Z8vQbB2ljzLkkIgiDJaQn7NAgr7e+t536E0cLRvq+u04urGwWgS0JVQ
         cdk8McmwTgSrx2mN97MqyslLabRvwYmGpXJthA4Ng7KgJvaUqq7ukdRxoORf+DF3m8xa
         AV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121139; x=1791725939;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IPyLRYGNcoGAVp61kSyOsgClFCv2mTwynbfUldxGrkg=;
        b=fqKnU6wFvlTNzeRGXhbH4Z3t8DyUk+AYgykUiMm09lHwNLuovtcbolgbX2RIoNhj2r
         UcEuZMX64hHvIIZ1bgi1MhKn/rZz9Qqc2CyY9HIo3f2/etNmCmktySp3DsCmUulaPHwX
         XrHQaqXCskyDFiqnNsmvAs7tpe7eihFUS9p/b+II0OjDPSg5EcNEj8T8U5X2DTkZEfdm
         r1tsyfkvvNxTSEzJDonpoibkujrmmNyik2nAHFQj2M3mKwQInaN3SkUo/vQzNys9klZ4
         kzIHQ2M7Ukbe4A/UEjAk2XXsUBXGUB2H88aPFbMKRwJns4gFQGqd6YrxX4OpdVt3gTjh
         eIkQ==
X-Gm-Message-State: AFuF++mgu2UYUrTGHVj8AD0QtRT4x575c3ILX8O9L+r2ImSgxTQ6Yxt0
	PPPx/rxRztewwTZHozHP75sYkmfPBJY5m7K7WeH0BhruSnijuu5GBntSXKaViQ==
X-Gm-Gg: AYBFou0BelIIcuea/Ur3qpx8KPMRv9om1/b7sxvcHWJG95II9KsbATKoRyublKEGEm5
	SvqeYBRLFVH1ZA2EEeGdoSjDpsG9pBtlYR7wC2gxgtK+zOlI0BAbYgmVZEMlFYUoUo/IqqY+fSD
	qLbeBYxj68hEwpJemexi2kf/POdix3w4PpoNQ4+hioY6zc5uDw6aDJdhyojU3lkNErLEHWW5rFf
	6kX/hORvJ+7YHxygZoZ6SVh3JtSR0e+pltDv9KJq27UCGoCr6Ctj3jhG4e73QOTLSEjywqgrv5N
	RlTLxjlXiMrEL/r6xs6EITW/7vGnCyx85qEVvHQTBTfJi3Ojrgp29rJtE5i5jMWe/SMzDtcVPgs
	giwe3v0ojDsYawngG185EnaZg7jPFHjS0QrPO2ejLD42AhZGQSvpi6UIVVfMzI19toWtrlyC2nn
	Ovfz7v/H89vYfGk2iVB3KuOZ6CcqUgyj1WFBQleESbLY6dqU4OlkiNLcuzG4RFYotBx2dJYTpyB
	iuCxPEjmasjg4Y=
X-Received: by 2002:a05:6a20:5493:b0:3dd:a195:dd5a with SMTP id adf61e73a8af0-3e0bcfe9a77mr9397153637.60.1791121139094;
        Sun, 04 Oct 2026 06:38:59 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:58 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 25/43] bpf: add bpf_split_cur_state()
Date: Sun,  4 Oct 2026 06:38:07 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-25-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
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
index 8c00a78575a1..13c7825bb8b5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1335,6 +1335,7 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
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
