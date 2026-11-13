Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605988;
	b=iLIc7CUUQO/Qj4lXLRo18usT+OhT7WVQstOtam9aB9f25t0mJqSLDgK6ciuieRQ6lhUJ
	 MV7O7b354ixhAabNviZ4XniK6J7Z3YYXDo1vG3IW9WvJaiakKIhBVwa9YxGHVPo6h3PQJ
	 SrBJPNIfNlMdiAd6wNspT1dFqC7Df/N4s1SaSCg7Ynygcmu9O2Mb5ng5V7k8kIAVadbFA
	 NvGDvj+YXrHTlpacGdQTOMa1FkBhz/0ftD7UG+3l9xepRBCPkynJ5j+majWo3+h9zubVX
	 sxSimovKy8Hji6qif36GCfybsPOhxhnh5MiY12Y7Kfy3D/eoc3HESy2imGprwNN3K7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605988;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GahPQY0DePt8tSTWG3LQzMHqCYGWbuj3INZdzOXnxE0=;
	b=wxVKLJDEQNTaUJzykfcHZdqsIOst4T0EJ4IEDXGAq5jSGa6CUBtpnONBy8lt7AWQ2raE
	 LnWJ+p2Ad0Kbmgm2+nzbd1i4euLYLlvtBFGx/2VVxjrXgpYvzcn9U3hprY2wioyNh2Ycy
	 QDadk6mt3n8kpFa2yCn5jzkW+WGT/o4HQV+iBzD27d4wTmwSR9Z46UrOdyMP+4dOQ8qbA
	 Ln3wNUYzD9vQ8ckxR1t1oswspSUdBPXCmeWd4m5IH7mAhQwkyzjU9SGrWcadZA8cXuKdo
	 UEMjkSOJTpfLw3ZOxvY9oJ0sNx93rdpdRlfLuDbN5hXmEfPjBmJE3x5uUedsHs9j0ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=s+enShc4;
	arc=none smtp.remote-ip=95.215.58.95
Received: from mta1.migadu.com (out-95.mta1.migadu.com [95.215.58.95])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC8C60A2621
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CC8C60A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=s+enShc4
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mLakTUzohtDl0J8gy5CFib9UTOXhznW7sG46HDNPDBs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794605985; v=1; x=1795210785;
 b=s+enShc4aPWsUCh63hc/WUITuDxzPbao/8ek/KmMd19Zj0zn6N0/bVTvG0W1W2o/giEk/CsS
 el3t7JdSB/N5dzt2J2LZV3+eJ95xK2K6JUFjnHrDMJgp8bITKzdKVfm2zFDz9AUHwRNy3W9WuLO
 bfar6exFj39tQvWGILAhnyHg=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 006b73bf2f8ce240;
	Fri, 13 Nov 2026 21:39:44 +0000
X-Mizu-Trace-ID: 006b73bf2f8ce240
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
Subject: [PATCH bpf-next v4 2/6] bpf: Rely on callback frame initialization defaults
Date: Fri, 13 Nov 2026 14:39:17 -0700
Message-ID: <20261113213921.1646681-3-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113213921.1646681-1-ihor.solodrai@linux.dev>
References: <20261113213921.1646681-1-ihor.solodrai@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
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
index a3d4a2d6de6a..3462e9b50d66 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12242,9 +12242,6 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 
 	/* pointer to stack or null */
 	callee->regs[BPF_REG_4] = caller->regs[BPF_REG_3];
-
-	/* unused */
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	return 0;
 }
 
@@ -12313,11 +12310,6 @@ static int set_loop_callback_state(struct bpf_verifier_env *env,
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
@@ -12336,11 +12328,7 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
 	mark_map_callback_reg(&callee->regs[BPF_REG_3], &caller->regs[BPF_REG_1], PTR_TO_MAP_VALUE);
 	callee->regs[BPF_REG_3].id = ++env->id_gen;
 
-	/* unused */
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_async_callback_fn = true;
-	callee->callback_ret_range = retval_range(0, 0);
 	return 0;
 }
 
@@ -12363,10 +12351,6 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
 
 	/* pointer to stack or null */
 	callee->regs[BPF_REG_3] = caller->regs[BPF_REG_4];
-
-	/* unused */
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_callback_fn = true;
 	/* bpf_find_vma() runs the callback under mmap_lock and RCU. */
 	callee->in_rcu_callback_fn = true;
@@ -12383,15 +12367,9 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
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
@@ -12422,9 +12400,6 @@ static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
 	mark_reg_graph_node(callee->regs, BPF_REG_2, &field->graph_root);
 	ref_set_non_owning(env, &callee->regs[BPF_REG_2]);
 
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_callback_fn = true;
 	callee->callback_ret_range = retval_range(0, 1);
 	return 0;
@@ -12443,9 +12418,6 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
 	mark_map_callback_reg(&callee->regs[BPF_REG_3], &caller->regs[BPF_REG_3], PTR_TO_MAP_VALUE);
 	callee->regs[BPF_REG_3].id = ++env->id_gen;
 
-	/* unused */
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_async_callback_fn = true;
 	callee->callback_ret_range = retval_range(S32_MIN, S32_MAX);
 	return 0;
@@ -12463,9 +12435,6 @@ static int set_rcu_callback_state(struct bpf_verifier_env *env,
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

