Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604A140682D
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957161; cv=none; b=t1XZ1NCddrsxe7sy17ZX4unaKyPhAIRY0GwrZKxur7sLIjUdbarkueQxJSAy0P1PdNasv9nnKeOsCggFE5a2a3VDSzOqFq+WNtfx7IkVWiFBX6+c34u4CeoEavUFJ6elcYbi8dn+rzmESkid8RuEKY+p75v4TiNk9tHFYRu8CgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957161; c=relaxed/simple;
	bh=47JfbtIlL48SZY8oJ88z4lpY1ZegBF8/1RWTug1NyF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vq+h9weWPqUKNR14cyD6nniS1q+47s+v7acwTnMuLRsj0yPCLUYauy2DSmscznOlNiJec3Ep359/PlU5LvqnXkUQkpN7qWBH8E95VHs+DfZzgOcJcqJQNWE1F3Bh/vxHXxwg5Y2wxkLIXWiSNvFdhsYb+G4Uptf6y2frC9zCWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUKgNG+w; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUKgNG+w"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-493b4af7976so26041265e9.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957157; x=1784561957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JWnWtc7e0se6ZgYrtmiVw/Z/NgnuQdn9mhQpkmEF7mo=;
        b=WUKgNG+wWuIIxtCbNsbeA5WGOdPqTB8OZ/jjIGchOMr6vMA3wfR6vPK1VDCHWTJ+6i
         FlLCYdt8BC5EEukhI+vAtVykMNMgntRDsxYspVbbXdGT8dc9cGm+LAeyrmaWUD1Pwy+q
         zZolctTvInKBWDA9GC//RHlxGZ3rEYcA4Mr8LpAaRBTxlixZ9FQ4BHe19TnxmmCUd9sJ
         kK88Or+Ita9Lq1sKUV8BzEHKB3P/WQR+y78J3oxnbHeoT00oO/H4r+EZkO0CrDb1YBQs
         0CKV7zoKVp58WnmMze2VpuOnP58ZVSDcijp+Abnr7pOHHn098npniuWElm+YuAgtRmfm
         0S/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957157; x=1784561957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JWnWtc7e0se6ZgYrtmiVw/Z/NgnuQdn9mhQpkmEF7mo=;
        b=oIHCGE5hMBI3K294a60gqZ/BR2XN2Sr/Qn5D3WSGIAf7Gmz5cc1ssj4B394zk5LWwe
         q8S0TaytA7XFLjSmh2ZusTuzQuP3zRFa911qalfczbdgkqAN+8Lv7ZjhjUnxi4yQy6Bk
         GwAJ7knz+/TkVervG4hRGVLLpMVDoSsC/Z/9a5HQ/hxuOI6bmuj4hFf0WyHpaiD4p7iK
         XhNLlfU7CPnYxjyuFjyh5gzkF97uRJa2QwYQeWmIDr0ByDLiJ2+QGXcU6qfTp5HmJV+F
         yx5/01WBEpqUGy1zrx0hwh1ea0/cr40Pu87QkiUYrkVVZR2J3vkdhZGQXhoUMf6TjeA+
         3mQg==
X-Gm-Message-State: AOJu0YzJGgNPQBbqwRd4cDU03hy1JaVPn4lqbTsL1E2Fugo5+gKcWc7H
	YCRcT73rTwqyrgMrXoarpAKOT/vu1kn0ozDHokZanI8K7RxCi9Ay9db3eFkkj+lv
X-Gm-Gg: AfdE7clvqHUGLmazh0BqqByWZhtaTZJqHIuBc/DnnEarLIgEgnFBBe114RTcwEZuOF7
	nS5H5j4gbim39CvQ1uq1sGrBBFuLPcdQMEVV2Danw7zX7LyD/ddT7vSIFuQXwYo2ICcJ+dX9k21
	n5OXE8qFlZ3R/07EXsYp9GnVFCMuJyEi2MmthaEKyq3U9e12IIxZD0Bva0d92cHRnvMT8HOEjwP
	9SB+ied5ZwM7UCY1Ofk9ZEBWxHEnB/WbqWAKNLyxx+8rG09mm+Cvz7PYS4UqYMZUADeuIDub07e
	VRSf8XW/OodyEl3dC1jwxbzFCfQt5vyRXca6qnLIQ+XueRpxytUnEqDE/qJoKyKCphoCV5IoE2g
	YvtKUlyroplJiIROcqIUv8zH5cq4GLYyhh7aB7NsIFDcF6vMA+avZ0fOnGIK37b+cq/S4uakbBH
	8m02e4QE2arArDhnDC0s24tiLFWrHo713eWs3/onR653H8UucRTYoKHj3vRDstBtWndwUF4inAu
	YfMQ9HbB8t7WGvAobei5NFNLR7gAsY08EoBb4H2u8KQBl4jUHo5LU4=
X-Received: by 2002:a05:600c:1d0a:b0:493:e460:1f6 with SMTP id 5b1f17b1804b1-493f8784930mr96208125e9.0.1783957157091;
        Mon, 13 Jul 2026 08:39:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32b9f3sm4086575e9.13.2026.07.13.08.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:16 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 04/17] bpf: Prune verifier diagnostics when switching paths
Date: Mon, 13 Jul 2026 17:38:53 +0200
Message-ID: <20260713153910.2556007-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713153910.2556007-1-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5373; i=memxor@gmail.com; h=from:subject; bh=47JfbtIlL48SZY8oJ88z4lpY1ZegBF8/1RWTug1NyF4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuURW73HLWfvB8CmJQfGi37k2Tn4fbBzGTf3Sle7nu2P z9/4q5lRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACayLpeR4WpwXsThvC/Mzbof BZo33hNZrJFVFXntxNq6sIh/kfIK7gx/JU68dtTQslu8YoLIQ2GWacuuXzE/aPJUqK/i8ybLfcq feQE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Save the diagnostic event-log position with each verifier stack entry and
reset the environment-owned stream together with the normal verifier log
when a queued state is popped. Also reset the diagnostic stream after
successful subprogram verification even when level-2 logging preserves the
normal verifier log.

Record branch outcomes as true or false. Later reports use those events to
show the path that reached a verifier error. For queued branches, save the
queued outcome with the verifier stack entry and append it when that state is
popped; record the active branch immediately before continuing.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 46 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d0d399b879e5..648adf3b7aaa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -189,11 +189,15 @@ struct bpf_verifier_stack_elem {
 	 * and after processing instruction 'prev_insn_idx'
 	 */
 	struct bpf_verifier_state st;
+	/* Only conditional-branch states have a queued diagnostic branch. */
+	u8 diag_branch_valid : 1;
+	u8 diag_branch_cond_true : 1;
 	int insn_idx;
 	int prev_insn_idx;
 	struct bpf_verifier_stack_elem *next;
 	/* length of verifier log at the time this state was pushed on stack */
 	u32 log_pos;
+	u32 diag_log_pos;
 };
 
 #define BPF_COMPLEXITY_LIMIT_JMP_SEQ	8192
@@ -1706,8 +1710,8 @@ void bpf_free_backedges(struct bpf_scc_visit *visit)
 	visit->backedges = NULL;
 }
 
-static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
-		     int *insn_idx, bool pop_log)
+static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx, int *insn_idx, bool pop_log,
+		     bool activate_diag_branch)
 {
 	struct bpf_verifier_state *cur = env->cur_state;
 	struct bpf_verifier_stack_elem *elem, *head = env->head;
@@ -1723,6 +1727,12 @@ static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
 	}
 	if (pop_log)
 		bpf_vlog_reset(&env->log, head->log_pos);
+	bpf_diag_event_log_reset(env, head->diag_log_pos);
+	if (activate_diag_branch && head->diag_branch_valid) {
+		err = bpf_diag_record_branch(env, head->prev_insn_idx, head->diag_branch_cond_true);
+		if (err)
+			return err;
+	}
 	if (insn_idx)
 		*insn_idx = head->insn_idx;
 	if (prev_insn_idx)
@@ -1763,6 +1773,7 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	elem->prev_insn_idx = prev_insn_idx;
 	elem->next = env->head;
 	elem->log_pos = env->log.end_pos;
+	elem->diag_log_pos = bpf_diag_event_log_pos(env);
 	env->head = elem;
 	env->stack_size++;
 	err = bpf_copy_verifier_state(&elem->st, cur);
@@ -1789,6 +1800,20 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	return &elem->st;
 }
 
+static struct bpf_verifier_state *push_stack_with_branch_diag(struct bpf_verifier_env *env,
+							      int insn_idx, int prev_insn_idx,
+							      bool speculative, bool cond_true)
+{
+	struct bpf_verifier_state *st;
+
+	st = push_stack(env, insn_idx, prev_insn_idx, speculative);
+	if (!IS_ERR(st)) {
+		env->head->diag_branch_valid = true;
+		env->head->diag_branch_cond_true = cond_true;
+	}
+	return st;
+}
+
 static const char *reg_arg_name(struct bpf_verifier_env *env, argno_t argno)
 {
 	char *buf = env->tmp_arg_name;
@@ -2287,6 +2312,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	elem->prev_insn_idx = prev_insn_idx;
 	elem->next = env->head;
 	elem->log_pos = env->log.end_pos;
+	elem->diag_log_pos = bpf_diag_event_log_pos(env);
 	env->head = elem;
 	env->stack_size++;
 	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
@@ -16171,7 +16197,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			return err;
 	}
 
-	other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx, false);
+	other_branch =
+		push_stack_with_branch_diag(env, *insn_idx + insn->off + 1, *insn_idx, false, true);
 	if (IS_ERR(other_branch))
 		return PTR_ERR(other_branch);
 	other_branch_regs = other_branch->frame[other_branch->curframe]->regs;
@@ -17607,8 +17634,7 @@ static int do_check(struct bpf_verifier_env *env)
 			err = bpf_update_branch_counts(env, env->cur_state);
 			if (err)
 				return err;
-			err = pop_stack(env, &prev_insn_idx, &env->insn_idx,
-					pop_log);
+			err = pop_stack(env, &prev_insn_idx, &env->insn_idx, pop_log, true);
 			if (err < 0) {
 				if (err != -ENOENT)
 					return err;
@@ -18464,7 +18490,8 @@ static void free_states(struct bpf_verifier_env *env)
 
 	bpf_free_verifier_state(env->cur_state, true);
 	env->cur_state = NULL;
-	while (!pop_stack(env, NULL, NULL, false));
+	while (!pop_stack(env, NULL, NULL, false, false))
+		;
 
 	list_for_each_safe(pos, tmp, &env->free_list) {
 		sl = container_of(pos, struct bpf_verifier_state_list, node);
@@ -18643,8 +18670,11 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 	ret = do_check(env);
 out:
-	if (!ret && pop_log)
-		bpf_vlog_reset(&env->log, 0);
+	if (!ret) {
+		if (pop_log)
+			bpf_vlog_reset(&env->log, 0);
+		bpf_diag_event_log_reset(env, 0);
+	}
 	free_states(env);
 	return ret;
 }
-- 
2.53.0

