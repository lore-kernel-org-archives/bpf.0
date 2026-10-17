Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7733A9DA5
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255083; cv=none; b=eIfFPM4LbeZZTBvQPl+1uL5udW3iWOyTmOcrvHfzL2fTw9AMcu1qOVk4tnV9LgcY+tb7cshP1gp/yrTjYZOYUNKAxzb+vwKBfRCzPhYDaUF5zZvQRGoPDDaffhOpC//dKcxo1i9eapSXAuhXEhHlk0Sq8Ik56x7daUxpL4ojzeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255083; c=relaxed/simple;
	bh=FKqteCSXO1CbRVOSlk9/EvC/7gM2fsr0/PRO0BW8AjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hY3l4QTJJ5aI9PLxKEFIBT1O4wTbMGiFNl136xwxhQ8SD4x8JdPnB2f5BSa9+LhOwGQ53CK2RaFiYM7vqVoTswdtql8UHBz/k+hPk8XnlZ7jhwjE6pECnG60O/a+GRlMwOw7Wco1USRiKILHKdhN7e3qCpwS7JhmYQ73B+lBlC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EytWKGHL; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EytWKGHL"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc502d509c0so354885a12.2
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255082; x=1792859882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zLOTcel4mG6H6gLmD7SemEC02pAxD8Wu1dMrbttEvSQ=;
        b=EytWKGHLIlscd6Iv7ivBDhksN1qYR4Isn0+r3DKD0ldR4FeYXtCd60L8GxEqsac8ZH
         t8HS9mjiDWTbOJn68fq1VB+vH28eQ2S9D03ZWhNq2o925gv7dIKdQ0xnmt9T5Ojqm9/L
         T6b3IpF8FA0ryD7nyhSbi2yHT7QdL5zZu+tpNDamSQrIs/WNIzTYDGbl1yEF/hFFUC3G
         vXlexjQhDkKAOfjLbs+LDnH/wMr+9eNx6uLsccFjCVvoEhTvLafFITvMIlkCewo/5DCB
         4BnLjWojAFA1x4DRLl3+cPbaiMjnU+xJrNulfNvHFmb8+8nWky8zvpzJ2goA2sI+k7jG
         MN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255082; x=1792859882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zLOTcel4mG6H6gLmD7SemEC02pAxD8Wu1dMrbttEvSQ=;
        b=vvs0WYJjMaUUKD9ayjigI1y5IXrT6V+YFm+Kv9EuWnsz3VVpkeNsnhLCCjmDZ3JlvC
         3HquC90biAj5MjyqVFOpqHWIqNXixqvQpm+Xpdw5mG9kCNcgutnzbVrSvor1td0OLqm+
         FiHsbZPMTL+IAY5EtAWxpSLkQwYYrcNHQ8Mvpcp0hEiuVD8wa9wVmSvNm9FJkFx7VsFt
         FAhRQ16c6BDLiuZtg9dooSH4CHjoDdYvWYuej9F3jH4ilzlD8WvbkbURy+C2XAGqJeW9
         BYxm/591avT6q3ITdtwFOuxyCF86eDvc66nYO6lyIDPVGf4uh0WCnHz2iuaEH5b3eCHQ
         0VuA==
X-Gm-Message-State: AFq9FYI1nkR0Cd6hgvN1nvKEOop+y2I87l164SDM1/9xvPJN+TIoHj+U
	YmbgaA39uuL2DS7gW8LcecgsAEAAn2Ep2zmO1pd1G1ve0PIzAEUalXEJMnao+Q==
X-Gm-Gg: AYBFou0bH2T322gzBtlMJ0mC17T6jwS4tUUDfwnc2cJn+KKWRRXW+nSlDSyxNBR+ydn
	a973vGxkChQ00tXLjutL68VtGG/aI5icShU9zqBMgPcNASdwpxlgGRWEEgOVy9L7dycELmP0uM+
	dFvUPqCrExZrEQng2i8uMuNjK+Vh9/X0HazhSDUNIdJN6xAf6mpDfBNAXtpz4SCG19m+qGnWfse
	ZLoqGb2Mx5yP+MNcrKJtOwFitRPE7Q3razPxjy+6pJpE1USZTN1BC7LA602HAj7wzIrQrNN59g0
	yfyqn+GPlUDSt1s4Ra4O/aOU/MXpMS2Zk6dqr2wWcnrqv/1gATbaSy1PWLaHP5Vhqp1x2GLcgtq
	Jzf6fFAp/i/GG6BcV3shehwwAI6NlqE10CslNtK/inJ7LqixxzhO/3g7aNW7lxDO5BHOiSvzSDs
	zEPfMeLz+J6PZRce74nJ9z4dkd5/+LZ3CKv38xaV4frBPOhNWyI6/47r7/rkBMVGjlQSMyNNO+9
	2Nvgw8MwPIIij+lS4FH7aLXTvguwfQrDXf4Jeee72TI2NdkYpmrkGhMSlK+nYGFP7U/CnniAwBB
	NKEw0tfmtAlGOVzUvduwSnps4VcEcAOiVVFVjQwJ+XY=
X-Received: by 2002:a17:90b:278d:b0:3ac:9706:772c with SMTP id 98e67ed59e1d1-3acef5cc100mr2799243a91.60.1792255081507;
        Sat, 17 Oct 2026 09:38:01 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc9d266d6sm4323835a91.1.2026.10.17.09.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:38:01 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 02/43] bpf: forbid sleeping in hash map for_each callbacks
Date: Sat, 17 Oct 2026 16:37:04 +0000
Message-ID: <20261017163745.3341787-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

A sleepable program (e.g. SEC("syscall"), lsm.s, fentry.s) can pass a
callback to bpf_for_each_map_elem() on a hash map and call a sleepable
helper or kfunc such as bpf_copy_from_user() from it. The verifier
accepts this, but at run time the callback is invoked from inside an RCU
read-side critical section:

    bpf_for_each_hash_elem()
      rcu_read_lock();
      callback_fn(map, key, val, ctx, 0);
        bpf_copy_from_user()       <- may fault and sleep
      rcu_read_unlock();

bpf_each_rhash_elem() does the same for BPF_MAP_TYPE_RHASH. Sleeping
there triggers the "Voluntary context switch within RCU read-side
critical section!" warning, delays grace periods, and with
CONFIG_PREEMPT_RCU=n silently ends the read-side critical section that
the bucket walk relies on.

Synchronous callbacks are verified with the caller's state, so
kernel/bpf/verifier.c:in_sleepable_context() only looks at the program's
sleepability and the locks the program took itself, and does not know
that the helper holds rcu_read_lock() around the callback.

With a SEC("syscall") program whose callback reads a page that has to be
read from disk first:

  BUG: sleeping function called from invalid context at include/linux/uaccess.h:169
  RCU nest depth: 1, expected: 0
   __might_fault+0x29/0x80
   _copy_from_user+0x26/0x90
   bpf_copy_from_user+0x23/0x60
   bpf_prog_17d44fa39eebd6cc_cb+0x35/0x46
   bpf_for_each_hash_elem+0xdb/0x280

Fix by marking the callback frame of hash map iteration as running under
RCU and making in_sleepable_context() false while such a frame is on the
call stack, so sleepable helpers, kfuncs and global functions are
rejected there as inside bpf_rcu_read_lock(). The rules for trusting RCU
protected pointers are left alone, which is conservative and keeps
callbacks that verify today and do not sleep working. The flag is
compared in func_states_equal() so that pruning never mixes the two
contexts. Array map callbacks run without any lock and keep the caller's
context.

Fixes: 314ee05e2fc6 ("bpf: Add hashtab support for bpf_for_each_map_elem() helper")
Fixes: 818e00848227 ("bpf: Implement iteration ops for resizable hashtab")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  5 +++++
 kernel/bpf/states.c          |  3 +++
 kernel/bpf/verifier.c        | 28 +++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 112ca1511da4..816948df8fff 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -379,6 +379,11 @@ struct bpf_func_state {
 	bool in_async_callback_fn;
 	bool in_exception_callback_fn;
 	bool no_stack_arg_load;
+	/*
+	 * The helper invokes this callback under rcu_read_lock(), so the
+	 * callback and its callees run in an RCU read-side critical section.
+	 */
+	bool in_rcu_callback_fn;
 	/* For callback calling functions that limit number of possible
 	 * callback executions (e.g. bpf_loop) keeps track of current
 	 * simulated iteration number.
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 953700822fa7..b3d250caaaa6 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -995,6 +995,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	if (!old->no_stack_arg_load && cur->no_stack_arg_load)
 		return false;
 
+	if (old->in_rcu_callback_fn != cur->in_rcu_callback_fn)
+		return false;
+
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (((1 << i) & live_regs) &&
 		    !regsafe(env, &old->regs[i], &cur->regs[i],
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ddfa0c6d2755..883cf148235c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11530,6 +11530,19 @@ static int set_map_elem_callback_state(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
+	switch (map->map_type) {
+	case BPF_MAP_TYPE_HASH:
+	case BPF_MAP_TYPE_PERCPU_HASH:
+	case BPF_MAP_TYPE_LRU_HASH:
+	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+	case BPF_MAP_TYPE_RHASH:
+		/* Hash tables run the callback under rcu_read_lock(). */
+		callee->in_rcu_callback_fn = true;
+		break;
+	default:
+		break;
+	}
+
 	callee->in_callback_fn = true;
 	callee->callback_ret_range = retval_range(0, 1);
 	return 0;
@@ -12273,10 +12286,22 @@ int bpf_get_helper_proto(struct bpf_verifier_env *env, int func_id,
 	return *ptr && (*ptr)->func ? 0 : -EINVAL;
 }
 
+/* Is any frame on the current path a callback that runs under RCU? */
+static bool in_rcu_callback(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+	int i;
+
+	for (i = 0; i <= state->curframe; i++)
+		if (state->frame[i]->in_rcu_callback_fn)
+			return true;
+	return false;
+}
+
 /* Check if we're in a sleepable context. */
 static inline bool in_sleepable_context(struct bpf_verifier_env *env)
 {
-	return !in_rcu_cs(env);
+	return !in_rcu_cs(env) && !in_rcu_callback(env);
 }
 
 static const char *non_sleepable_context_description(struct bpf_verifier_env *env)
@@ -12290,6 +12315,7 @@ static const char *non_sleepable_context_description(struct bpf_verifier_env *en
 			return "IRQ-disabled region";
 		if (env->cur_state->active_locks)
 			return "lock region";
+		return "callback running under rcu_read_lock";
 	}
 	return "non-sleepable prog";
 }
-- 
2.55.0

