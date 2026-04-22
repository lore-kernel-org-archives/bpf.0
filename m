Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917F02E06EA
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886951; cv=none; b=kL6LJUTCBPyNtiQOWwNlJdmMG2nyVMhkbSxUGjI7AXESk5T/V59O9RIs5VPI2U/qQ1HxBe8jFau0cTG64U8uvkCHnrxMM+pCuY+S/oRvakZ+HbHe020DIrJKvs0QgsjyfGMdRPtyW3I9b/Hvc50B/p9XIc+LXZXOaVqwM5DaKH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886951; c=relaxed/simple;
	bh=C7qbsP7dactKUzWMniUqLSmXGpKCE6FlAZrrq5NECmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bv9D0+R1Br46d7v92vcaytdnwFYgJQ8QwlTtQABfkcjHlTujqzlLJ/0h4zy5ELhsmrr2nEUhQiNbl11QL/pXor72ILNI2jWkKmNYuaFCaEXeWecZMQEftYUiaH3njjxGs0Ln9s7cPM1ckj2GYRlvgUEwHvkySbSyd6/ft77Iymo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6DROrZh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6DROrZh"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so95372745e9.2
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 12:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776886948; x=1777491748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8phqV9SLEcqCOyGTd2OpaTZYEx+kV+mXMt9fsMGOdOI=;
        b=V6DROrZhAYV9tCxyE7NU9W1EenDi5fg+7NU6McXmoPGoshp5C4YvXlJ3ARYlycBBsi
         4RscS/c40fTH9pI0HHkb4YUvwqoecB1oNqVnP897rb0XHpBOE1/Fe02k/6p7NgMb2KuQ
         adN5GWQHfpwy5yiQ7LHWBKoDBZU+vBBDCW+ih3VOwNyuds+2Pgy51s9jm8dA6bQ8D5wW
         XGv4K08O67AgeNMNlm3jRu3ers1sm/8mpvVc17qqWLw9Bs+hV+SXzn2VnHJF1cU6kWpj
         QqEVX/cQBuwZCkDZAQIdZDzTpXHxCnvc3LxUuG6m5mKb5JWeZPa/1RyghE5lJFv0fyY/
         JLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776886948; x=1777491748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8phqV9SLEcqCOyGTd2OpaTZYEx+kV+mXMt9fsMGOdOI=;
        b=FwUCE2QcS6+Ls1ZUSktS5m/ZYXryeVifmnl1raU+8D9Py0oFrecp9SFjUvnerJ/LyJ
         f0pXWINdHD6ZppZxpn0mQdjhX/r71RgrT1UvJheLpWQC1ouon7r4Pne5M20eptS3Uqqe
         J9GJUi91swokw97DBtYifYHXKCtSC3i2NNH8pOzs/wRhHxJFnp0ks01eRsx+O5fEe+as
         CDKg+t4LJIzDeugTMsHIgGJqvsYb+x0HoUVY2hK3jl7IpODVclql6CoqnBGEtrLBnUrI
         DWRhq+bNXDO0kUQoeTVpssS2uBKCKAi5p73sCWWNBbaLJvZTRBZ2brvTxwHABrP1q2tK
         jZwA==
X-Gm-Message-State: AOJu0YwXgIE3ESSJ93UoLJeUk/WFOF+mEJ0NdjtxAxX95ceumDHEBa1u
	qtLIb4n0H50l1h8V5ScXKUadIDXWdd+lDgytlWxexTTIyKt3Z5dBTadT
X-Gm-Gg: AeBDievJUHpTm4NTMkoFPWMkVJIsPhtSEmHwhtfnS4TLCsfHRhYoupj0b0MtrIM/bn0
	/NLZozhjN+riTb2RYTBiwb55MV/xO1N5BCkjkjrOgckHf7ld8kPUjLPCwlWsDH9uG+bljz9bn5V
	VqR112PvsohPglZmsVFTRa3QQ1lQfjLFCySM3QS7L2Xx4U99IG8rg1ZdhvH2Gu9jrW4NwvbTNR+
	UK5v/Xhon+KD/eEPRGhxwAaNceJbGhXucr3DKa/CZpO9db6cGZXvIdjhGY/ZP1jpxVHJDAg9LCa
	lBk+edkke40rrkLjwG/HMX3tcu1lj5w4m8wsyk2Xyj/fttWyK4TuFy6sQQsxWYur9UBUU+HI4ZB
	gZvgWFBla+CYXTEFc2RNxPNSztpE1BeakJqIz31XL28XGB1Y5RvphnFlqREtr+Q3VAQry0fAm1z
	BcqUkrdVD86HxhCI93CFaYpeS2
X-Received: by 2002:a05:600d:8408:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-488fb74c61fmr266826895e9.13.1776886947712;
        Wed, 22 Apr 2026 12:42:27 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f8188sm492212985e9.2.2026.04.22.12.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 12:42:27 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 22 Apr 2026 12:41:06 -0700
Subject: [PATCH bpf-next v13 1/6] bpf: Add sleepable support for raw
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-sleepable_tracepoints-v13-1-99005dff21ef@meta.com>
References: <20260422-sleepable_tracepoints-v13-0-99005dff21ef@meta.com>
In-Reply-To: <20260422-sleepable_tracepoints-v13-0-99005dff21ef@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776886944; l=6207;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=tCcV2LN6OqH112mRvVMqaHyVGkIUsmc5w5uH6YMCZpo=;
 b=MyTdvh/JOkITIXt6bgWrcskl1LDHWdf+bNe5JVZHcPtLyICZNbJpm5Fx9YnPkubYllyUE+eOK
 WrZCvQgnbBtDvf4xybp1/I+oyaaLDlhifMbMGL+9W8G4KXfTLoLxboN
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

