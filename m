Received: from mta0.migadu.com (out-29.mta0.migadu.com [91.218.175.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F2C48595E
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577709; cv=none; b=IHXswBXpbRKoN3f4zOXTKImYxLtd5dNX9fio2FUUHBNxx6KMEuooAsKCRCFUYsSLf8l9H7iisPuRCw/WUZmHh6wXcfFn+ZqoReyAtumLFmVVlqzne+peRT1bPKFZT+7HLzG+npNItTs1ynNpR9qnL1prFAFO5Cu2ILZ+yh1SPyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577709; c=relaxed/simple;
	bh=rysPVt9Yj5zECxDbpVQd2+z8Osam3sGqEDKMm0ia2GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRt/vzFckJFNqY+uyhCgdz1xwmJ5WMVuqgKt4sKbYzz1prqkFOwNs8FIIWwBu2F/f/cBMQZsZblhnpszc/ck00QFPJ45G+V9QijAQFW/b7C1T0Focd38+sngGsq88N11xR6EunKAnHzfnnRPTVQfD0edJ4jjx5krVwmfljX8vrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VG2gCpW0; arc=none smtp.client-ip=91.218.175.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VG2gCpW0"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rysPVt9Yj5zECxDbpVQd2+z8Osam3sGqEDKMm0ia2GM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791577703; v=1; x=1792182503;
 b=VG2gCpW0Pmf53OwG+kioEqmikYDvunX4/PwugnuZFBZ0qDAx0DdfHiyLDIrSMZVfMrj8TwwF
 WONKIolWNPhH9FfpS5vD/QVDAj+A53pSd3fVBHMyUAb48780poVWhTCgPPn6bkrn1M0TQP/hCWR
 F2lR6E4UCGmlEMeDo4n5rlfg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 227650c8984a35b4;
	Fri, 09 Oct 2026 20:28:23 +0000
X-Mizu-Trace-ID: 227650c8984a35b4
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 02/11] bpf: Pass the owning verifier state to callback setters
Date: Fri,  9 Oct 2026 13:27:49 -0700
Message-ID: <20261009202759.50520-3-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009202759.50520-1-ihor.solodrai@linux.dev>
References: <20261009202759.50520-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callback setters receive the caller and callee frames, but not the
verifier state that owns the callee. Synchronous callbacks use a queued
state and asynchronous callbacks use a separate state, neither of which
is env->cur_state.

Callback-local bookkeeping needs to be recorded in that owning state.
Pass it through the callback setters and the map callback setup hook.

No functional change.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 include/linux/bpf.h   |  3 +++
 kernel/bpf/verifier.c | 16 +++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 54144372281c..d5de9d49a168 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -39,6 +39,7 @@
 #include <asm/rqspinlock.h>
 
 struct bpf_verifier_env;
+struct bpf_verifier_state;
 struct bpf_verifier_log;
 struct perf_event;
 struct bpf_prog;
@@ -178,6 +179,7 @@ struct bpf_map_ops {
 
 
 	int (*map_set_for_each_callback_args)(struct bpf_verifier_env *env,
+					      struct bpf_verifier_state *state,
 					      struct bpf_func_state *caller,
 					      struct bpf_func_state *callee);
 	long (*map_for_each_callback)(struct bpf_map *map,
@@ -3183,6 +3185,7 @@ int bpf_iter_map_fill_link_info(const struct bpf_iter_aux_info *aux,
 				struct bpf_link_info *info);
 
 int map_set_for_each_callback_args(struct bpf_verifier_env *env,
+				   struct bpf_verifier_state *state,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a0310e093880..8d6812fee0c9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10817,6 +10817,7 @@ static void invalidate_outgoing_stack_args(struct bpf_verifier_env *env,
 }
 
 typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
+				   struct bpf_verifier_state *state,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee,
 				   int insn_idx);
@@ -11000,7 +11001,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		callee->async_entry_cnt = state->frame[0]->async_entry_cnt + 1;
 
 		/* Convert bpf_timer_set_callback() args into timer callback args */
-		err = set_callee_state_cb(env, caller, callee, insn_idx);
+		err = set_callee_state_cb(env, async_cb, caller, callee, insn_idx);
 		if (err)
 			return err;
 
@@ -11027,7 +11028,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	if (IS_ERR(callee))
 		return PTR_ERR(callee);
 
-	err = set_callee_state_cb(env, caller, callee, insn_idx);
+	err = set_callee_state_cb(env, callback_state, caller, callee, insn_idx);
 	if (err)
 		return err;
 
@@ -11257,6 +11258,7 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 }
 
 int map_set_for_each_callback_args(struct bpf_verifier_env *env,
+				   struct bpf_verifier_state *state,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee)
 {
@@ -11287,6 +11289,7 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 }
 
 static int set_map_elem_callback_state(struct bpf_verifier_env *env,
+				       struct bpf_verifier_state *state,
 				       struct bpf_func_state *caller,
 				       struct bpf_func_state *callee,
 				       int insn_idx)
@@ -11303,7 +11306,7 @@ static int set_map_elem_callback_state(struct bpf_verifier_env *env,
 		return -ENOTSUPP;
 	}
 
-	err = map->ops->map_set_for_each_callback_args(env, caller, callee);
+	err = map->ops->map_set_for_each_callback_args(env, state, caller, callee);
 	if (err)
 		return err;
 
@@ -11313,6 +11316,7 @@ static int set_map_elem_callback_state(struct bpf_verifier_env *env,
 }
 
 static int set_loop_callback_state(struct bpf_verifier_env *env,
+				   struct bpf_verifier_state *state,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee,
 				   int insn_idx)
@@ -11335,6 +11339,7 @@ static int set_loop_callback_state(struct bpf_verifier_env *env,
 }
 
 static int set_timer_callback_state(struct bpf_verifier_env *env,
+				    struct bpf_verifier_state *state,
 				    struct bpf_func_state *caller,
 				    struct bpf_func_state *callee,
 				    int insn_idx)
@@ -11370,6 +11375,7 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
 }
 
 static int set_find_vma_callback_state(struct bpf_verifier_env *env,
+				       struct bpf_verifier_state *state,
 				       struct bpf_func_state *caller,
 				       struct bpf_func_state *callee,
 				       int insn_idx)
@@ -11398,6 +11404,7 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
 }
 
 static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
+					   struct bpf_verifier_state *state,
 					   struct bpf_func_state *caller,
 					   struct bpf_func_state *callee,
 					   int insn_idx)
@@ -11421,6 +11428,7 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
 }
 
 static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
+					 struct bpf_verifier_state *state,
 					 struct bpf_func_state *caller,
 					 struct bpf_func_state *callee,
 					 int insn_idx)
@@ -11454,6 +11462,7 @@ static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
 }
 
 static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
+						 struct bpf_verifier_state *state,
 						 struct bpf_func_state *caller,
 						 struct bpf_func_state *callee,
 						 int insn_idx)
@@ -11489,6 +11498,7 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
 }
 
 static int set_rcu_callback_state(struct bpf_verifier_env *env,
+				  struct bpf_verifier_state *state,
 				  struct bpf_func_state *caller,
 				  struct bpf_func_state *callee,
 				  int insn_idx)
-- 
2.56.0

