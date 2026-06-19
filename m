Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185BF3CF05E
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902792; cv=none; b=MnMUm+GSPpY3xOQIbpMXUElnvJ+YBO9/mHXAkpgtPdSHLvBuUKfmsBEwO1fAvanOOnrf6oj3HPwWVMhcBkmlnAMWV/5V7djtCePfNvAwCowosmawWzd+E/GsCMnhQsf6J+mregXfncGqRgXfHIexMDycUF0IhotmMQeDc7q2468=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902792; c=relaxed/simple;
	bh=Yoa5vWQXzoAw5tubqkOln4LGHtY1uVEVlPMeklvOLHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDxXBTLSgg4YHWw5yRDt8X9L5Jg/vvYVfHmKbQKJ65HAMaVIOb/b6i8u7BZQTXMLtzcNhyu3hJ2jKLxpdYaFd5/0tRzPkPf4r49g04LExvcpQ+ycv0xv5pb03jTw4Nd1aFgJ3UdmEQKZ8aHim2lFlcRnEMmdri+osAKwLRMyb0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qXO9y4xA; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXO9y4xA"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4905529b933so23676725e9.0
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781902780; x=1782507580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gbib7M1o9UbF/fZTC+HhfJlwqn0I63zxWUF9BEKGSe8=;
        b=qXO9y4xAUUy0G++uT1xhkMzWEdhZyAkBHz7Z8bn6b1EkOCG3NspWGBr2h3L+kT//Jw
         GodJ/0WgJo/G+P4RU2an0Y+VR06t7iQ3HnD+DSoHbdegRke/XYAEPWNfNHoFbSCw035k
         WMw48kGgY2rzrZIJB3FTgue3DnF5+zntwnQdpLbNI2cb0oP7YWf3vEGvdOmmUGXFWujl
         4hTRFKw0FFbzBNeuUv/HeCTp/SoN+gcrq6hf0C4bAnfknDTeqDIzJhxVaP8SK5ao1kEv
         O7HYIzUj8c051sHqf/gqvGY6655ke7tjh7vEHLa9PAlbtQ3yqT392hNSiKx9jb1RzIAy
         gQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902780; x=1782507580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gbib7M1o9UbF/fZTC+HhfJlwqn0I63zxWUF9BEKGSe8=;
        b=c4Pdgau5J7ssURK6jfZ3KEReJikojdI935zq2oKKgqv6rJjf+yNz0pmvHBaPER26+4
         eLqFsi50QixgFqeaPYwlfQYpqb9RvAIB5vExFj5Q0dHRTUhNRBtcX9inKGg6UPiBOQdU
         bslbShL5JC9oflXw4dMNcYHv7iKTY9BrvhJR6yjfRqAThasE8gwMUQjmIvZYNFs1KaRM
         5VuaTim1rINSXoUtNff2H47C/INt2qIdA40ZfAhNvUE5S0onx8AsonQhW+2j/Udyw4LE
         u0ZqYGZJnF2a2hw+MTaM6lByPQ92WrkSSIYHDB+1tCM5jPCUj8GGQz/cayIF4sKJsUxD
         eOFg==
X-Gm-Message-State: AOJu0Ywqcjj9Rnn14+w1Y6MMo/A5hsWsD3c+10tKBU76dYJ6MuM6c5m6
	54Z6ed33zZY/P4bI0bUbkPi5YTz1UtlTcqrhIvtg4A39/uHgtOwccpbx2V6mOr9N
X-Gm-Gg: AfdE7clbIatU8iz0hifSL6ktzK/0/Ax62DeD0f6CaZP/Fmrjjww2BitriHR6XWDX9l4
	NZvorXO+j4h7FFMVDWY/pgbDF5WLN2CgaHLN+9YJu6l7nIJtxw9zVRxtn/dCQ+1CcRPBJaysSuR
	uQu+/F0jzJzSazHMz9CtHiLmdJYzssJkCxIbn7saHZg8kDlSaWOVEku4hHqajE++GV5/XwvKB6Q
	6R3vDSyeayCdgg83+ddWxkp9GjIUAp9lQyWmKCmR6pU8aRS3CjpY6ufouvjNxceXBcsGB2Pnp1W
	7fx/b8QC+Kclm9ZyHjSeQE5JEMj47Med6xkxeILRyVbEUd+yEQgF77dwZ7dI76YwgTo7hEU+tFx
	GkkIxv3fpoTj2Grz5N2Mlo3rbOCOdo/DWsmaDmDAMj+jSctxy7EtxvJ6+PL9CBnmzQGASnhh1mV
	LpjnDWr+rJa966tXtCW35OVu7fuoJlgbAKugR6DZjXLocKeqhohu+4g9xEuE/w1e4sTK0kioGjr
	P0Rxii1fSK201CVMUeAloPRSOM4J3c4wL91sbByljB/SNW3Uw2+bKbGTIxeVmx75g==
X-Received: by 2002:a05:600c:8716:b0:492:28be:6098 with SMTP id 5b1f17b1804b1-49240e44473mr80073655e9.11.1781902780096;
        Fri, 19 Jun 2026 13:59:40 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c698dsm1997969f8f.16.2026.06.19.13.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:59:39 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 04/17] bpf: Prune verifier diagnostics on backtracking
Date: Fri, 19 Jun 2026 22:59:17 +0200
Message-ID: <20260619205934.1312876-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619205934.1312876-1-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5870; i=memxor@gmail.com; h=from:subject; bh=Yoa5vWQXzoAw5tubqkOln4LGHtY1uVEVlPMeklvOLHE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct05d95yWnW7fo3q/+ZHPkzhbtxj/klhifVLGX9e/pqV cX0LjzsKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwETs5jL8s+ZXKyvcH1Ufry97 Rze6bc1nbRXPKX//J/lc+LlWOLjpGSPDpZ6eDdKT9VbEm8pYtSVZJVRNs8ht33r7nbSra3/sOwY eAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Save the diagnostic event-log position with each verifier stack entry and
reset the environment-owned stream together with the normal verifier log
when a queued state is popped. Also reset the diagnostic stream after
successful subprogram verification even when level-2 logging preserves the
normal verifier log.

Record branch outcomes as true or false. Later reports use those
events to show the path that reached a verifier error. For queued branches,
append the queued outcome before push_stack() so the saved diagnostic
position includes it, then reset back to the active path before continuing.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 44 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e81fdb0e22ae..ca4bba163418 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -192,6 +192,9 @@ struct bpf_verifier_stack_elem {
 	struct bpf_verifier_stack_elem *next;
 	/* length of verifier log at the time this state was pushed on stack */
 	u32 log_pos;
+	u64 diag_log_pos;
+	bool diag_branch_valid;
+	bool diag_branch_cond_true;
 };
 
 #define BPF_COMPLEXITY_LIMIT_JMP_SEQ	8192
@@ -1704,7 +1707,7 @@ void bpf_free_backedges(struct bpf_scc_visit *visit)
 }
 
 static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
-		     int *insn_idx, bool pop_log)
+		     int *insn_idx, bool pop_log, bool activate_diag_branch)
 {
 	struct bpf_verifier_state *cur = env->cur_state;
 	struct bpf_verifier_stack_elem *elem, *head = env->head;
@@ -1720,6 +1723,10 @@ static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
 	}
 	if (pop_log)
 		bpf_vlog_reset(&env->log, head->log_pos);
+	bpf_diag_event_log_reset(env, head->diag_log_pos);
+	if (activate_diag_branch && head->diag_branch_valid)
+		bpf_diag_record_branch(env, head->prev_insn_idx,
+				       head->diag_branch_cond_true);
 	if (insn_idx)
 		*insn_idx = head->insn_idx;
 	if (prev_insn_idx)
@@ -1760,6 +1767,7 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	elem->prev_insn_idx = prev_insn_idx;
 	elem->next = env->head;
 	elem->log_pos = env->log.end_pos;
+	elem->diag_log_pos = bpf_diag_event_log_pos(env);
 	env->head = elem;
 	env->stack_size++;
 	err = bpf_copy_verifier_state(&elem->st, cur);
@@ -1786,6 +1794,21 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	return &elem->st;
 }
 
+static struct bpf_verifier_state *
+push_stack_with_branch_diag(struct bpf_verifier_env *env, int insn_idx,
+			    int prev_insn_idx, bool speculative,
+			    bool cond_true)
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
@@ -2284,6 +2307,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	elem->prev_insn_idx = prev_insn_idx;
 	elem->next = env->head;
 	elem->log_pos = env->log.end_pos;
+	elem->diag_log_pos = bpf_diag_event_log_pos(env);
 	env->head = elem;
 	env->stack_size++;
 	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
@@ -16027,6 +16051,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		}
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
+		bpf_diag_record_branch(env, *insn_idx, true);
 		*insn_idx += insn->off;
 		return 0;
 	} else if (pred == 0) {
@@ -16042,6 +16067,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		}
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
+		bpf_diag_record_branch(env, *insn_idx, false);
 		return 0;
 	}
 
@@ -16060,7 +16086,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			return err;
 	}
 
-	other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx, false);
+	other_branch = push_stack_with_branch_diag(env, *insn_idx + insn->off + 1,
+						   *insn_idx, false, true);
 	if (IS_ERR(other_branch))
 		return PTR_ERR(other_branch);
 	other_branch_regs = other_branch->frame[other_branch->curframe]->regs;
@@ -16074,6 +16101,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	other_branch_regs[insn->dst_reg] = env->true_reg1;
 	if (BPF_SRC(insn->code) == BPF_X)
 		other_branch_regs[insn->src_reg] = env->true_reg2;
+	bpf_diag_record_branch(env, *insn_idx, false);
 
 	if (BPF_SRC(insn->code) == BPF_X &&
 	    src_reg->type == SCALAR_VALUE && src_reg->id &&
@@ -17484,7 +17512,7 @@ static int do_check(struct bpf_verifier_env *env)
 			if (err)
 				return err;
 			err = pop_stack(env, &prev_insn_idx, &env->insn_idx,
-					pop_log);
+					pop_log, true);
 			if (err < 0) {
 				if (err != -ENOENT)
 					return err;
@@ -18292,7 +18320,8 @@ static void free_states(struct bpf_verifier_env *env)
 
 	bpf_free_verifier_state(env->cur_state, true);
 	env->cur_state = NULL;
-	while (!pop_stack(env, NULL, NULL, false));
+	while (!pop_stack(env, NULL, NULL, false, false))
+		;
 
 	list_for_each_safe(pos, tmp, &env->free_list) {
 		sl = container_of(pos, struct bpf_verifier_state_list, node);
@@ -18471,8 +18500,11 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
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

