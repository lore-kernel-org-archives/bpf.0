Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.93
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794007289;
	b=aFoe9aJdWu3XKC/i3Qopi+OU5zlL2Aj5Rjm/mLDPNFtlOlHzZls9hsO4mIgSve9h1CUv
	 RZpqJpH1spmIxd5Gg91ballJ/AHDk5fvH94X3lciL6sqvZlJ7vj+Skjg5KShzCjmglo3W
	 fvpVDs7OISDBieJ6Lql5VojvSLLjAzxgcKawEvd/lu2cAzX0Y69aleupLmfMmSpzDk7uR
	 zjnAafLRZhIn8N/Lrx7UOlKKMVmP/XTj2eWfwpiPr+aYDJDf/tWldynIUEQGYbgRYjYRj
	 F6MTT+Wlh6ATZoOzIriR1TUkr1oFcH+NhJBrHYlK0elLSTtzWzNMESdLeeGoVmSFZOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007289;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/6mjwhvUPYfBktNYk4jCXPQcQS3Khf5jIEW4r3kX/eM=;
	b=1oAY510PN2SlpXBlAJnumkyPiJqNe8G68XgeFQYRrC2KaUDd+yWvuaZ4wrAApV2YVI8d
	 BDrcec2I/JNJNt5xpt0JjfEF16IVwmmbmY4f606NPFBKokt4crv8g8yUbidlYyXQ3x4ua
	 f1PD6TohTD+teTq2fTJfd71meRiDqH+U7b35DzcYEDUBKRxiJ4M4uQ9CvAgjj0UiZxt9v
	 3poKmHfvPAtxdMMC0a8wDL0TsYbPs7mr2gUO/pa6O8uq9QGPSuJwMD3py7q2Wnm3EeUmF
	 yAGOGdHhx/mBKIXGxZQDNW7mPpo9ncJyxf+FtfL7mGsCls1q2xA/V8JTfpzv6YHxPcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UKI1ywDp;
	arc=none smtp.remote-ip=91.218.175.93
Received: from mta0.migadu.com (out-93.mta0.migadu.com [91.218.175.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4059606A332
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 23:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4059606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UKI1ywDp
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dCRhnLUVfPlgEJax3a0w5YXFwJniK7rZCL1uwkZbOs0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794007285; v=1; x=1794612085;
 b=UKI1ywDpKbxWnSGWV19wffrz+dNOTYuj3iugThnTqz2yYb3KcCwLZKLYJUrZ/xE2L+uvVrOT
 fCjQvO7pq2JIEQWYXCQjwQexLX0xCBPEF+lNvG2gdYmZ/yhZZZMu8HiVdtOwXu1qwH3YGR9GOr5
 oXb4iBXQuG00lLbHRmjUFgyQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id ec85b21f32246eb3;
	Fri, 06 Nov 2026 23:21:25 +0000
X-Mizu-Trace-ID: ec85b21f32246eb3
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
Subject: [PATCH bpf-next v1 2/2] bpf: Rely on callback frame initialization defaults
Date: Fri,  6 Nov 2026 16:21:10 -0700
Message-ID: <20261106232110.2867412-2-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106232110.2867412-1-ihor.solodrai@linux.dev>
References: <20261106232110.2867412-1-ihor.solodrai@linux.dev>
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
index 389488e4e7a7..831a9c0f8c45 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11985,9 +11985,6 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 
 	/* pointer to stack or null */
 	callee->regs[BPF_REG_4] = caller->regs[BPF_REG_3];
-
-	/* unused */
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	return 0;
 }
 
@@ -12056,11 +12053,6 @@ static int set_loop_callback_state(struct bpf_verifier_env *env,
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
@@ -12079,11 +12071,7 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
 	mark_map_callback_reg(&callee->regs[BPF_REG_3], &caller->regs[BPF_REG_1], PTR_TO_MAP_VALUE);
 	callee->regs[BPF_REG_3].id = ++env->id_gen;
 
-	/* unused */
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_async_callback_fn = true;
-	callee->callback_ret_range = retval_range(0, 0);
 	return 0;
 }
 
@@ -12106,10 +12094,6 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
 
 	/* pointer to stack or null */
 	callee->regs[BPF_REG_3] = caller->regs[BPF_REG_4];
-
-	/* unused */
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_callback_fn = true;
 	/* bpf_find_vma() runs the callback under mmap_lock and RCU. */
 	callee->in_rcu_callback_fn = true;
@@ -12126,15 +12110,9 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
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
@@ -12165,9 +12143,6 @@ static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
 	mark_reg_graph_node(callee->regs, BPF_REG_2, &field->graph_root);
 	ref_set_non_owning(env, &callee->regs[BPF_REG_2]);
 
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_callback_fn = true;
 	callee->callback_ret_range = retval_range(0, 1);
 	return 0;
@@ -12186,9 +12161,6 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
 	mark_map_callback_reg(&callee->regs[BPF_REG_3], &caller->regs[BPF_REG_3], PTR_TO_MAP_VALUE);
 	callee->regs[BPF_REG_3].id = ++env->id_gen;
 
-	/* unused */
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_async_callback_fn = true;
 	callee->callback_ret_range = retval_range(S32_MIN, S32_MAX);
 	return 0;
@@ -12206,9 +12178,6 @@ static int set_rcu_callback_state(struct bpf_verifier_env *env,
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

