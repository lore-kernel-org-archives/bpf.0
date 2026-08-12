Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC12C310779
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573171; cv=none; b=RoIXz/90xOqy6lj4Jiq12OtJbr5LGhiZnQykgoZOahdeI5M7ph9vdOM6CHDhcYX8ioSP/EFH9crV1QDSD7I1Yw4+wAwkTP5gtRoBrJL9RHuK82wxvYHwnqEUj4iCr4r79R8WZkm+VpAoGwifvcG6mQN5TPc+wXHy1Yzi9iJEXfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573171; c=relaxed/simple;
	bh=09H8C1hW/glq/4LPM7p2xj3zx4g1wqgM9/aQEOWO1wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXWyoQwP9WIQGiMuTxrX9rPHV9bwIisrLZZRexa5KDYWoZQc2xSPbaRE+rtpAZ9sP/R42v8fvdnWvKWQcTbJcigysNZTsX8OHRFls13PUAxsVjl2wGfLCNOjSMPrLSOFOxNN/fOQvlGYc0J2qUTZ2KjBiXvqEj6FcwJk3v4eq0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAzjTz4r; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAzjTz4r"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so5866085e9.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 15:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786573168; x=1787177968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8coeUqJ3uXdHxUjLck6LwXkasyjFLzPjjbEG6poP8ek=;
        b=bAzjTz4rNZAH6pma4ojaYnULCmTyMK7JPR2cSRfkNnAR0jTzuufYViV58d+h9gZ01/
         4qCMWrI81WFH3E7vRPTe2KtXKLpDXMJP+kVBBFSZuXC1achya2opHJ3zQnI+eCQBljh3
         R3tH4VBjV/UasmWrUOmO1ZEmOPvuHnkp7TcqScQOmP8h/FVXs/6IqNBGQeQ7GBSFZ9Ln
         88A/QylTWkL4xtIsMhtX+Z1RaCTh08aSXFqx3WKIN6S6tMoi2uVQ/yy4uiZIyJpqLiuU
         T94VW3kgizi1KuneeDY4cABGcF3D3pvKyXtO6Gz6SGDEhYQ+Mbfvhfb79Q3wALNFB5U8
         nnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786573168; x=1787177968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8coeUqJ3uXdHxUjLck6LwXkasyjFLzPjjbEG6poP8ek=;
        b=OlYhZUIOfc12QamkSiQl0RhGObuzSCt1uCcKy7o2/kXAL8n1G95QFrCjQKNSaPv49p
         wMIdNQscdZiriJzg3y431sofcgAWLJtvT8P3H6s9yS8DBtqrHzydLkYqMZuhI2d8sVEh
         HUHOXHo6tXgt6+Ot1BpkXjYQlu+HxdoOsXJ0GzfhSeqb0tHmUZqqH/gX+eNKCLvre9TV
         9WPRCknxI7tXQFbKF9TJeFeby3euy5wwAzqai2I8YiiljuJGjC7+rU0LQmJE0K644dOS
         vvqa1gcMbMSJhFXekLVPZ1vb2I0hIwu7qaQ8CDeu5hy9QTSS/kuJCutN8WCz3a3XHDTq
         5SXA==
X-Gm-Message-State: AOJu0Yy6CpIweiI9jmww0E7q/SQsogXECK8cWLIRGiJZM0udk9S1IwBM
	pONg58u4c5TTodZDHHKOJe7IPc3Pq9S81XmQvAKn9GnC6va4PeRIfqOCKRrqnz6H
X-Gm-Gg: AR+sD13S2lbIvZhHpaIT3i0OgIFxAPA7kZ/4Hlob9djfQ5mjl2d60Mo9yE0Dj6SUGNx
	CGqL/c5DZqhRCec6OBhHKHvVVxQTT6O02GMIfcjO7kIGx0VRHFcRQp4iMNXiP+lXgXE81RGlWrf
	iyeVdbMbCjtVYdAIHFOh4VCnmOm3yvBqaSwb2oZgKxRYA2PzpfZG13KZ0lgWIMLr26BN6R3sECF
	Mep8PKWhSBZa19cn+kaWbxWOjCxZm/zZkcipaMG83Hw9RpSj6MDmascPZKpwK4HgQ5kllTKCjwu
	xHO1vc7TufHOXpVylsUOTQsDxA3V03zKhK4XRPlq6RKeCGVq2d9hCP5SOfdHxPdMeiM9AU+JqIY
	aHMWTvLbrt8mYR/+ZbkMTAPMPd7tDv70T06FaWtL2FxlPY9JZWA+Ps4aEIQlcYtjhZYnI2M8U00
	Y8kyj7EtVbJazmBGwmxpFUUGuUusAk0nI1IAgP+xlQORdXiIrc2S4m1Xb6KQmr8yapDsmh17w9Z
	nH4ICeH7MD2w+qy021paiI8Bt8QOqd1zlt5dVkhBE9UFCoqmt0VuH8IIJF8lS/IbSPSN44ZPkUG
	dXpe5VocPYPZ6TzUDDSLgQnStN8=
X-Received: by 2002:a05:600c:45d5:b0:496:ca1f:a428 with SMTP id 5b1f17b1804b1-499821d26demr7412285e9.19.1786573167680;
        Wed, 12 Aug 2026 15:19:27 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49982131261sm18332495e9.8.2026.08.12.15.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 15:19:27 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v8 1/6] bpf: Track verifier instruction stats for each subprogram
Date: Thu, 13 Aug 2026 00:19:18 +0200
Message-ID: <20260812221925.3358041-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812221925.3358041-1-memxor@gmail.com>
References: <20260812221925.3358041-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7908; i=memxor@gmail.com; h=from:subject; bh=09H8C1hW/glq/4LPM7p2xj3zx4g1wqgM9/aQEOWO1wo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavmw4/kie8buMsmV7dwhhqlz9j68lRT3YtN/yMDddd16 bdOqOLvKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwESsTzAydAbfLjWU/7q33p3R afKhA5HZn+OFfzLYVr/cXXdky6sYb0aGv2+if2/S2zxnpd3ijGm/frDcnGDhzvedx5C3ai7bnz+ 67AA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The verifier currently records one instruction count for the main program
and each global subprogram checked independently. Static subprograms are
explored within callers, so their verification cost cannot be reported
separately.

Track both self and inclusive instruction counts for every subprogram.
Charge each processed instruction as self work to the current subprogram and
to a path-local subtotal in its function frame. When a function returns, add
the callee subtotal to its inclusive count and to its parent subtotal. Fold
any remaining frames when a path terminates or is pruned.

Instruction subtotals are accounting state, not semantic verifier state.
Clear them when a verifier state is copied so work before a path fork is
charged once, rather than again when a saved branch is explored. If copying
a saved state fails before all frames are allocated, skip missing frames
while folding the current path.

This generic frame accounting also records self and inclusive totals when an
asynchronous callback starts as a fresh frame-zero state. It does not yet
charge that independently explored callback path back to the main or global
exploration root which scheduled it. That will be done in subsequent
changes.

This does not change the verification statistics output format. It only
prepares the counters for per-subprogram reporting.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  5 +++-
 kernel/bpf/verifier.c        | 55 ++++++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 93f7c2075eea..7c376451db82 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -380,6 +380,8 @@ struct bpf_func_state {
 	 *                           | number of simulations is tracked in frame N
 	 */
 	u32 callback_depth;
+	/* Instructions processed in this frame and callees on the current path. */
+	u32 insns_subtotal;
 
 	/* The following fields should be last. See copy_func_state() */
 	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
@@ -798,7 +800,8 @@ struct bpf_subprog_info {
 	u32 exit_idx; /* Index of one of the BPF_EXIT instructions in this subprogram */
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
-	u32 insn_processed;
+	u32 insns_total;
+	u32 insns_self;
 	/* offsets in range [stack_depth .. fastcall_stack_off)
 	 * are used for bpf_fastcall spills and fills.
 	 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 61ef43325c6f..51d754bdef5d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1593,6 +1593,8 @@ static int copy_func_state(struct bpf_func_state *dst,
 			   const struct bpf_func_state *src)
 {
 	memcpy(dst, src, offsetof(struct bpf_func_state, stack));
+	/* Instruction accounting is path-local, not part of verifier state. */
+	dst->insns_subtotal = 0;
 	return copy_stack_state(dst, src);
 }
 
@@ -9708,6 +9710,42 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
 
 static bool is_rbtree_lock_required_kfunc(u32 btf_id);
 
+static void account_processed_insn(struct bpf_verifier_env *env)
+{
+	struct bpf_func_state *frame = cur_func(env);
+
+	env->insn_processed++;
+	frame->insns_subtotal++;
+	env->subprog_info[frame->subprogno].insns_self++;
+}
+
+static void account_processed_insns(struct bpf_verifier_env *env,
+				    struct bpf_func_state *callee,
+				    struct bpf_func_state *caller)
+{
+	u32 insns;
+
+	if (!callee)
+		return;
+
+	insns = callee->insns_subtotal;
+
+	env->subprog_info[callee->subprogno].insns_total += insns;
+	if (caller)
+		caller->insns_subtotal += insns;
+	callee->insns_subtotal = 0;
+}
+
+static void account_current_path(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+	int frame;
+
+	for (frame = state->curframe; frame >= 0; frame--)
+		account_processed_insns(env, state->frame[frame],
+					frame ? state->frame[frame - 1] : NULL);
+}
+
 /* Are we currently verifying the callback for a rbtree helper that must
  * be called with lock held? If so, no need to complain about unreleased
  * lock
@@ -9804,6 +9842,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		verbose(env, "to caller at %d:\n", *insn_idx);
 		print_verifier_state(env, state, caller->frameno, true);
 	}
+	account_processed_insns(env, callee, caller);
 	/* clear everything in the callee. In case of exceptional exits using
 	 * bpf_throw, this will be done by copy_verifier_state for extra frames. */
 	free_func_state(callee);
@@ -17359,7 +17398,9 @@ static int do_check(struct bpf_verifier_env *env)
 		insn = &insns[env->insn_idx];
 		insn_aux = &env->insn_aux_data[env->insn_idx];
 
-		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
+		account_processed_insn(env);
+
+		if (env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
 			verbose(env,
 				"BPF program is too large. Processed %d insn\n",
 				env->insn_processed);
@@ -17500,6 +17541,7 @@ static int do_check(struct bpf_verifier_env *env)
 					    "speculation barrier after jump instruction may not have the desired effect"))
 				return -EFAULT;
 process_bpf_exit:
+			account_current_path(env);
 			mark_verifier_state_scratched(env);
 			err = bpf_update_branch_counts(env, env->cur_state);
 			if (err)
@@ -18544,6 +18586,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 	ret = do_check(env);
 out:
+	account_current_path(env);
 	if (!ret && pop_log)
 		bpf_vlog_reset(&env->log, 0);
 	free_states(env);
@@ -18575,7 +18618,6 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 	struct bpf_prog_aux *aux = env->prog->aux;
 	struct bpf_func_info_aux *sub_aux;
 	int i, ret, new_cnt;
-	u32 insn_processed;
 
 	if (!aux->func_info)
 		return 0;
@@ -18590,8 +18632,6 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 		if (!bpf_subprog_is_global(env, i))
 			continue;
 
-		insn_processed = env->insn_processed;
-
 		sub_aux = subprog_aux(env, i);
 		if (!sub_aux->called || sub_aux->verified)
 			continue;
@@ -18599,7 +18639,6 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 		env->insn_idx = env->subprog_info[i].start;
 		WARN_ON_ONCE(env->insn_idx == 0);
 		ret = do_check_common(env, i);
-		env->subprog_info[i].insn_processed = env->insn_processed - insn_processed;
 		if (ret) {
 			return ret;
 		} else if (env->log.level & BPF_LOG_LEVEL) {
@@ -18626,12 +18665,10 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 
 static int do_check_main(struct bpf_verifier_env *env)
 {
-	u32 insn_processed = env->insn_processed;
 	int ret;
 
 	env->insn_idx = 0;
 	ret = do_check_common(env, 0);
-	env->subprog_info[0].insn_processed = env->insn_processed - insn_processed;
 	if (!ret)
 		env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
 	return ret;
@@ -18650,10 +18687,10 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 		for (i = 1; i < subprog_cnt; i++)
 			verbose(env, "+%d", env->subprog_info[i].stack_depth);
 		verbose(env, " max %d\n", env->max_stack_depth);
-		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed);
+		verbose(env, "insns processed %d", env->subprog_info[0].insns_total);
 		for (i = 1; i < subprog_cnt; i++)
 			if (bpf_subprog_is_global(env, i))
-				verbose(env, "+%d", env->subprog_info[i].insn_processed);
+				verbose(env, "+%d", env->subprog_info[i].insns_total);
 		verbose(env, "\n");
 	}
 	verbose(env, "processed %d insns (limit %d) max_states_per_insn %d "
-- 
2.53.0

