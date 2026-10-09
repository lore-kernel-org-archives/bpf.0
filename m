Received: from mta1.migadu.com (out-119.mta1.migadu.com [95.215.58.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAD83D3CE6
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577721; cv=none; b=VVu5PsgPSlKmBPoptaqdr1ChqS8L6W2ggd02liXKtbCopNoBeVnozfMIn87nc5AVX4s30mlCceEwi8p1+i41xNDwSk1O5C/qwJcelFFai0PEySTRCez7sExiaGgDaHuhf6D/bfWmx7IwixiiqZlJxhfi0EcyL6R50yj52/Cai2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577721; c=relaxed/simple;
	bh=6Re81oY0edmO+AhjHDJZGAzC1BS3SW0NiWS+BFYBwEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZU+KORZXhy8grFegaAtKVRAVNS6ms1ezmLo/27yA06ZYfdMH+YLS027JwGS4m6LK9Nb4AA4Ty3av9zo+Tf3dfwltdON+MECs4Es+QHNdCVqXLsvOKdhKcWd9U/UKSMKXfBufDWF4d8bfD9TY5eLHLSknTIChEKhSy/MNp+z6uks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rBN2Xkl5; arc=none smtp.client-ip=95.215.58.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rBN2Xkl5"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6Re81oY0edmO+AhjHDJZGAzC1BS3SW0NiWS+BFYBwEc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791577718; v=1; x=1792182518;
 b=rBN2Xkl58xlvW88+ZapqZKlawAuLegyMiPDzwhV2sNODY2+fdKRSbRcGOZkTg7nuJ0DqIxvo
 VSFzGyzXoTpdMUvR7fj3CFVK8HfVDD8MP3VtxFkFeRl+L/dmCYzYq1nbORfeL3bQ1xwdfePBP1+
 WbrcmXJdfnqnJmDCF2pSwXo4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 79d63f40f98a50de;
	Fri, 09 Oct 2026 20:28:37 +0000
X-Mizu-Trace-ID: 79d63f40f98a50de
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
Subject: [PATCH bpf-next v2 06/11] bpf: Rely on callback frame initialization defaults
Date: Fri,  9 Oct 2026 13:27:53 -0700
Message-ID: <20261009202759.50520-7-ihor.solodrai@linux.dev>
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

Both callback entry paths call init_func_state(), which initializes all
registers to NOT_INIT and the callback return range to zero.

Callback setters repeat resets for unused registers, and the timer setter
repeats the default return range. Leave those defaults to frame
initialization and set only arguments and callback-specific state in the
setters.

No functional change.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/verifier.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8f2125c6e348..67a61570a9ab 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11295,9 +11295,6 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 
 	/* pointer to stack or null */
 	callee->regs[BPF_REG_4] = caller->regs[BPF_REG_3];
-
-	/* unused */
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	return 0;
 }
 
@@ -11341,11 +11338,6 @@ static int set_loop_callback_state(struct bpf_verifier_env *env,
 	callee->regs[BPF_REG_1].type = SCALAR_VALUE;
 	callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3];
 
-	/* unused */
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
-
 	callee->in_callback_fn = true;
 	callee->callback_ret_range = retval_range(0, 1);
 	return 0;
@@ -11365,11 +11357,7 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
 	mark_map_callback_reg(&callee->regs[BPF_REG_3], &caller->regs[BPF_REG_1], PTR_TO_MAP_VALUE);
 	callee->regs[BPF_REG_3].id = ++env->id_gen;
 
-	/* unused */
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_async_callback_fn = true;
-	callee->callback_ret_range = retval_range(0, 0);
 	return 0;
 }
 
@@ -11393,10 +11381,6 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
 
 	/* pointer to stack or null */
 	callee->regs[BPF_REG_3] = caller->regs[BPF_REG_4];
-
-	/* unused */
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_callback_fn = true;
 	callee->callback_ret_range = retval_range(0, 1);
 	return 0;
@@ -11412,15 +11396,9 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
 	 *			  callback_ctx, u64 flags);
 	 * callback_fn(const struct bpf_dynptr_t* dynptr, void *callback_ctx);
 	 */
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_0]);
 	mark_dynptr_cb_reg(env, &callee->regs[BPF_REG_1], BPF_DYNPTR_TYPE_LOCAL);
 	callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3];
 
-	/* unused */
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
-
 	callee->in_callback_fn = true;
 	callee->callback_ret_range = retval_range(0, 1);
 	return 0;
@@ -11452,9 +11430,6 @@ static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
 	mark_reg_graph_node(callee->regs, BPF_REG_2, &field->graph_root);
 	ref_set_non_owning(env, &callee->regs[BPF_REG_2]);
 
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_callback_fn = true;
 	callee->callback_ret_range = retval_range(0, 1);
 	return 0;
@@ -11474,9 +11449,6 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
 	mark_map_callback_reg(&callee->regs[BPF_REG_3], &caller->regs[BPF_REG_3], PTR_TO_MAP_VALUE);
 	callee->regs[BPF_REG_3].id = ++env->id_gen;
 
-	/* unused */
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_async_callback_fn = true;
 	callee->callback_ret_range = retval_range(S32_MIN, S32_MAX);
 	return 0;
@@ -11495,9 +11467,6 @@ static int set_rcu_callback_state(struct bpf_verifier_env *env,
 	mark_map_callback_reg(&callee->regs[BPF_REG_2], &caller->regs[BPF_REG_2], PTR_TO_MAP_KEY);
 	mark_map_callback_reg(&callee->regs[BPF_REG_3], &caller->regs[BPF_REG_2], PTR_TO_MAP_VALUE);
 
-	/* unused */
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_async_callback_fn = true;
 	callee->callback_ret_range = retval_range(S32_MIN, S32_MAX);
 	return 0;
-- 
2.56.0

