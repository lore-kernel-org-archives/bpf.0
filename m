Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7A11D798E
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871648; cv=none; b=loJ8CrEuhNcjLsJXI4pkPEh+qChB9YAY5676bA38AkCPOpjJlrj4MX/XMCOaoKuH0KDly6L9N5OQR6J8mFtgBuIFp4uEF0EGu8+5WB1IiAHccSDLAbYKBGzlMC2VI7U3+irIt4mlpC3jzAKIcxTEqjJr9DSYJD43/Xfh4i2kn3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871648; c=relaxed/simple;
	bh=C7qbsP7dactKUzWMniUqLSmXGpKCE6FlAZrrq5NECmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nS4b/vdv/Tpu30y1vnESj/FAoMTBvjK+GfwE4fXU/1WN0mrSH5E5WHJFXLRP4C3IKjocLn4y+kZDIwQW0ERY2xBOf6G3WE7kxNelzUcJkyzbC+sVuRP5dtQ7qcFUSh6rW5+t3HIBxC0DF6MtB6Y8/Wsx36ZQNeW507LVpzMjxT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ogigmwNj; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogigmwNj"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso2780421f8f.2
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 08:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776871645; x=1777476445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8phqV9SLEcqCOyGTd2OpaTZYEx+kV+mXMt9fsMGOdOI=;
        b=ogigmwNjrOmUhIkjkGM1hDQWum0h5cne6vY9DieW4oOiYQQSbozZb4rgsOYns/8IXE
         H+BJLEN+Y7ufZ81Axo6Z66x4waQcAJ9fukqddYZCbgVJJXO2Uec1hXXWvOJ7SjjI9ues
         83OuCZKt7S6jkfD/86Wco3qTrBanrKVuZ/3LjT/xopHl6NuOFqm8ZMwyd9JkHMesTBUB
         QHvkJi3a5H0KaB6en18v/6BVxJJQgsDMgsdIRF9fwLoGaNlAsizVsr0QWm8d7EIafqUm
         RxQDQ9kSa1kpQmY2jOH0Xa3MVlQtm4WuSJYFz+BXOo/cbY2wqI/lHT66jPx10ov7N5MX
         UUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871645; x=1777476445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8phqV9SLEcqCOyGTd2OpaTZYEx+kV+mXMt9fsMGOdOI=;
        b=Zm1eIp1rJi61bzzGQFa80U1QJDXOMRuS6Mas0/LefRAhCjsQmPov14ydV4gYQiscJl
         HO8RQlxeQ7jcB+hVESN+W6QEvtnxXyE2mRVCaeT19if2g8Fu1zuXEO/555j26C5X3PWr
         nDky+LmZfJzJ/2MLyMCO6fuIjWFmYHrmRogjmj5d3E5cn3ZVSs29GCtrFaYYcfCSG2Ds
         6wQ4Zi/5B1Ovg1yhcY0tn4j8D+kI0wWNLPQO9TeLZGVJKnB3t5S0hz5VU4alzRhOZ8zd
         7qMF5vaHG5GvfJzLBCJQ8z0pY8NzwG8yR3j/3FYpUIOAUFhP6XX8vHLLnHDLq6fLD+S/
         zWhw==
X-Gm-Message-State: AOJu0YzfVBgqXfPPMRdfTipR/eLu66S9+cAQhh5kRdMX+dxqraXFvaq6
	YcFHUYq0BzTwUikCLIUVtE2cymHL3pLvQNGBNOQ/yP/wE2LQt489G2gC
X-Gm-Gg: AeBDiet04yw95SNaBMDl67NefC68kf8KfOCedQkcD9Elfa7XGpT2Cdao/YDeFuhGqyt
	qbJCz7DK++17iYUx5LFxxirBGQ5h5D5LmdbKd6MwE/ZKr+vggwVJYHNohefnYG0TfIeojBrGv46
	CJGlg7lsZGltGuPacqTXPalP2nbX7y7ctJcLpFVltenYAM1uMlX2DCvENWhFOX+4sU4qJbsiv6U
	Yp6H0WDPohinaFURBnyQSBiN41hjg9jN9eumpSJNwzzDmU1bjN6ZRQia0DQw/2IzGBcbPbV4Icz
	AYgH3HI0Xs30qjhZZgb91DIpy2sxxOMXVMWj8nIxfcQe03DAmTpd4UVa1zX2yETIyW+3mcPGfV8
	bfDY0xb0PXZJGOHJQXkEmLxnSPQ8f0E+QVea6QPxsMVGhPJMGoxTrd3jH3lmmC11sS8nzUuiWlj
	KYS2YvycmzA/LHDEXOnett2r4=
X-Received: by 2002:a5d:64e3:0:b0:43e:aa88:f1a1 with SMTP id ffacd0b85a97d-43fe3dfd649mr36028415f8f.30.1776871645153;
        Wed, 22 Apr 2026 08:27:25 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a166sm45398659f8f.19.2026.04.22.08.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:27:24 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 22 Apr 2026 08:27:06 -0700
Subject: [PATCH bpf-next v12 1/6] bpf: Add sleepable support for raw
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-sleepable_tracepoints-v12-1-744bf0e3b311@meta.com>
References: <20260422-sleepable_tracepoints-v12-0-744bf0e3b311@meta.com>
In-Reply-To: <20260422-sleepable_tracepoints-v12-0-744bf0e3b311@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776871642; l=6207;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=tCcV2LN6OqH112mRvVMqaHyVGkIUsmc5w5uH6YMCZpo=;
 b=GAXx1Am2AiT7OeogqxUc/BxNSQhIAO7fJErjk12AUDpk8MwbavqmEWynrdbgu2ClzGteP16zM
 kPzXMTsg8HtC8eMDcYUaQvEyWgvTXrNmPIDPVGoaDLMWYRRmUJhhvHZ
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Rework __bpf_trace_run() to support sleepable BPF programs by using
explicit RCU flavor selection, following the uprobe_prog_run() pattern.

For sleepable programs, use rcu_read_lock_tasks_trace() for lifetime
protection with migrate_disable(). For non-sleepable programs, use the
regular rcu_read_lock_dont_migrate().

Remove the preempt_disable_notrace/preempt_enable_notrace pair from
the faultable tracepoint BPF probe wrapper in bpf_probe.h, since
migration protection and RCU locking are now handled per-program
inside __bpf_trace_run().

Adapt bpf_prog_test_run_raw_tp() for sleepable programs: reject
BPF_F_TEST_RUN_ON_CPU since sleepable programs cannot run in hardirq
or preempt-disabled context, and call __bpf_prog_test_run_raw_tp()
directly instead of via smp_call_function_single(). Rework
__bpf_prog_test_run_raw_tp() to select RCU flavor per-program and
add per-program recursion context guard for private stack safety.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/trace/bpf_probe.h |  2 --
 kernel/trace/bpf_trace.c  | 20 ++++++++++++---
 net/bpf/test_run.c        | 65 ++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 67 insertions(+), 20 deletions(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 9391d54d3f12..d1de8f9aa07f 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -58,9 +58,7 @@ static notrace void							\
 __bpf_trace_##call(void *__data, proto)					\
 {									\
 	might_fault();							\
-	preempt_disable_notrace();					\
 	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));	\
-	preempt_enable_notrace();					\
 }
 
 #undef DECLARE_EVENT_SYSCALL_CLASS
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e916f0ccbed9..7276c72c1d31 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2072,11 +2072,19 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 static __always_inline
 void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 {
+	struct srcu_ctr __percpu *scp = NULL;
 	struct bpf_prog *prog = link->link.prog;
+	bool sleepable = prog->sleepable;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
 
-	rcu_read_lock_dont_migrate();
+	if (sleepable) {
+		scp = rcu_read_lock_tasks_trace();
+		migrate_disable();
+	} else {
+		rcu_read_lock_dont_migrate();
+	}
+
 	if (unlikely(!bpf_prog_get_recursion_context(prog))) {
 		bpf_prog_inc_misses_counter(prog);
 		goto out;
@@ -2085,12 +2093,18 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 	run_ctx.bpf_cookie = link->cookie;
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 
-	(void) bpf_prog_run(prog, args);
+	(void)bpf_prog_run(prog, args);
 
 	bpf_reset_run_ctx(old_run_ctx);
 out:
 	bpf_prog_put_recursion_context(prog);
-	rcu_read_unlock_migrate();
+
+	if (sleepable) {
+		migrate_enable();
+		rcu_read_unlock_tasks_trace(scp);
+	} else {
+		rcu_read_unlock_migrate();
+	}
 }
 
 #define UNPACK(...)			__VA_ARGS__
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 2bc04feadfab..c9aea7052ba7 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -748,14 +748,35 @@ static void
 __bpf_prog_test_run_raw_tp(void *data)
 {
 	struct bpf_raw_tp_test_run_info *info = data;
+	struct srcu_ctr __percpu *scp = NULL;
 	struct bpf_trace_run_ctx run_ctx = {};
 	struct bpf_run_ctx *old_run_ctx;
 
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 
-	rcu_read_lock();
+	if (info->prog->sleepable) {
+		scp = rcu_read_lock_tasks_trace();
+		migrate_disable();
+	} else {
+		rcu_read_lock();
+	}
+
+	if (unlikely(!bpf_prog_get_recursion_context(info->prog))) {
+		bpf_prog_inc_misses_counter(info->prog);
+		goto out;
+	}
+
 	info->retval = bpf_prog_run(info->prog, info->ctx);
-	rcu_read_unlock();
+
+out:
+	bpf_prog_put_recursion_context(info->prog);
+
+	if (info->prog->sleepable) {
+		migrate_enable();
+		rcu_read_unlock_tasks_trace(scp);
+	} else {
+		rcu_read_unlock();
+	}
 
 	bpf_reset_run_ctx(old_run_ctx);
 }
@@ -783,6 +804,13 @@ int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
 	if ((kattr->test.flags & BPF_F_TEST_RUN_ON_CPU) == 0 && cpu != 0)
 		return -EINVAL;
 
+	/*
+	 * Sleepable programs cannot run with preemption disabled or in
+	 * hardirq context (smp_call_function_single), reject the flag.
+	 */
+	if (prog->sleepable && (kattr->test.flags & BPF_F_TEST_RUN_ON_CPU))
+		return -EINVAL;
+
 	if (ctx_size_in) {
 		info.ctx = memdup_user(ctx_in, ctx_size_in);
 		if (IS_ERR(info.ctx))
@@ -791,24 +819,31 @@ int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
 		info.ctx = NULL;
 	}
 
+	info.retval = 0;
 	info.prog = prog;
 
-	current_cpu = get_cpu();
-	if ((kattr->test.flags & BPF_F_TEST_RUN_ON_CPU) == 0 ||
-	    cpu == current_cpu) {
+	if (prog->sleepable) {
 		__bpf_prog_test_run_raw_tp(&info);
-	} else if (cpu >= nr_cpu_ids || !cpu_online(cpu)) {
-		/* smp_call_function_single() also checks cpu_online()
-		 * after csd_lock(). However, since cpu is from user
-		 * space, let's do an extra quick check to filter out
-		 * invalid value before smp_call_function_single().
-		 */
-		err = -ENXIO;
 	} else {
-		err = smp_call_function_single(cpu, __bpf_prog_test_run_raw_tp,
-					       &info, 1);
+		current_cpu = get_cpu();
+		if ((kattr->test.flags & BPF_F_TEST_RUN_ON_CPU) == 0 ||
+		    cpu == current_cpu) {
+			__bpf_prog_test_run_raw_tp(&info);
+		} else if (cpu >= nr_cpu_ids || !cpu_online(cpu)) {
+			/*
+			 * smp_call_function_single() also checks cpu_online()
+			 * after csd_lock(). However, since cpu is from user
+			 * space, let's do an extra quick check to filter out
+			 * invalid value before smp_call_function_single().
+			 */
+			err = -ENXIO;
+		} else {
+			err = smp_call_function_single(cpu,
+						       __bpf_prog_test_run_raw_tp,
+						       &info, 1);
+		}
+		put_cpu();
 	}
-	put_cpu();
 
 	if (!err &&
 	    copy_to_user(&uattr->test.retval, &info.retval, sizeof(u32)))

-- 
2.52.0

