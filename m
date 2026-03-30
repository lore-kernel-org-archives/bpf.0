Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E488D3E3149
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909233; cv=none; b=Z+jr35BiOTeS7N1FR66uxEJdw1u+YzdsXUPSOOi10kc7M3FBYKe6gWEZSCfKkbGYNtvT3nMcrwrFkoOW/pCAY2tRSAhzYvuwnv18hXNUsjXy3kRMWJYq1VxmTOKuReMJYWClD4XhsbW24fNY6NQQ9VnV00m/iLaH2PxQ1slzzow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909233; c=relaxed/simple;
	bh=cmSQRfLFf7Pg/DkPYdfF3qU3WXrayCaEeF9k4oro6rE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFURll4fnURcXI3MGkqIRR9TSdJvYhCf1I2vJF8l838fztSuKgFbPMHlF5hpJCpnTob+WLSkSsFHTeQ2Zp1cnqpV6p4PEASui5QxzqLNiglfL8V69a7J9mb1gLvhQ40e/2e/yVDpkvSdGfvPaOfbcY9w+aoDtUn9BeNW1y09EaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNmkFD0X; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNmkFD0X"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso60272325e9.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774909224; x=1775514024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRMyBEI8ybSb0mXJyPW7OQ3X6fyIm1PRBhfw7+0Ljcs=;
        b=XNmkFD0XJJdbvzeqgzPCDFO56DDBcDB+PuIq7uAVfxuWUXvdquJaHSZEeiuLPR7a7f
         w5NdgbyjbCPiPCMcZYgSAw5D2TMd1zemOLRaVA60FoVkSIGIQa4Rgmk6oWO+Rlx6shzY
         SkKB0jgSM7yzA2FKY5/ceF9dz/3jEFzqek1x6lGoH894IMCpnBmYL4Qgp2UvEyJDGzR1
         mAQfYcYkrxW4HO0DFOQxJT01B0nEzjap8y/yDv2O2F4c1AJEjgLFQG3eTYiFb3M8XA6M
         3VFaH8dmNdyfblWicxl0Hj+R0yzRB0SpXrmA+v0H5QWEUc3Up08qA/Niv2HqComAXm4o
         XKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909224; x=1775514024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qRMyBEI8ybSb0mXJyPW7OQ3X6fyIm1PRBhfw7+0Ljcs=;
        b=hpmpLQEyhCiQffHVM+yTzc9AT7BfOMQB/Yt6Q1ekCnnKoeJgtDBlkOx1xXMkneM761
         Yev/tF/eNChYICzEWQNOesRaFTJwgQU8fz5K+fw3oWZJuFSWgmCH9wRCy9Kqu2aHIHHk
         CVxCCoK/SYxBk0DHeschdXDWXVqEFzqT8ZCIiMqQI1spXzdmuRTUApogk7RURQ598z33
         osnZ7aenFu7n9m+UAXVhY+smseYe6XH7vVbj8AEVR0z8YS1w2kVL4iIgE1zuuwE5hEko
         LJc+1dfJIg1/kyiUbyar+JaDA6dFpaqlzApdKRBtQjr/VezoP6HFIKUtnmurQHMuo1md
         Tg8g==
X-Gm-Message-State: AOJu0YzHDOgDXl9j37Kio+N7liHBpBgA8CHBU5T74C2sLa5rGQr0Q+m/
	KGELtTkGYbSxgDetT4T0D1EdgnPpbLWjT5zDQFiXnbkZymHuVFqaCJus
X-Gm-Gg: ATEYQzzQPKz2ZefJxBPea5dHFpGlrzBEJXx+ShgxVYBxoMdQrcOv9xyMbsb2XVjLMuC
	CCfbbmtbwcKZNFCP/3EYkywQCj5D1h7dN88AwDN6PHciQ7dII+ZLtJ2y+rpjxk16yj8hVx1yHv7
	XsTCNbZlNZIMSslY2r1EiqouKMEJcLXU63xSfZ9aNCIDcv0bij822CxR58rjfmDcIA1fP0MleQ/
	uuqwi40U0f/zF6ThBrXWV9x3qJW7ZyYmiZP4QCtNg7+IIHEthZLd1n384XesTqggBnWkSz199w8
	gjjzAW2g9BYKLpHQpmWDHFI+LmyZzpJYjyP9NKZxNCx9nxU8CrGp3tvwLusMc7T74UURhCq/glc
	+Z4c51AN8RpEMXl4z1sSwWJiSO7RKHBxm5QUKtYb0Za6zNb49KRX2sWYwFieBSgloS+JUuW68ws
	Vf+bj0RrHW755jkQ==
X-Received: by 2002:a05:600c:8b63:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-48727eafa46mr210106935e9.15.1774909224064;
        Mon, 30 Mar 2026 15:20:24 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887ad477f6sm2538785e9.7.2026.03.30.15.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:20:22 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 30 Mar 2026 15:17:24 -0700
Subject: [PATCH bpf-next v8 1/6] bpf: Add sleepable support for raw
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-sleepable_tracepoints-v8-1-2e323467f3a0@meta.com>
References: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
In-Reply-To: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774909220; l=6069;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=EDuoBooNBclgBQF4Kr7Wxvp6ZOBuEQc3CFG4yccnkPM=;
 b=7+Bu9XiMVGsJoWwl2gN/H8LuaZ4QVTsluZACCGt3mKImQj/iHiV1CC3mzaKgnmR2LkzUhH7q2
 wJk8r871bM/AJtfvFhIPGIdGZtlbtX6SWhwMG1xs++EkzVEaWgumH/S
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

Adapt bpf_prog_test_run_raw_tp() for sleepable programs: select
RCU flavor per-program and reject BPF_F_TEST_RUN_ON_CPU since
sleepable programs cannot run in hardirq or preempt-disabled context.

This prepares the runtime execution path for both BTF-based raw
tracepoints (tp_btf) and classic raw tracepoints (raw_tp) to support
sleepable BPF programs on faultable tracepoints (e.g. syscall
tracepoints). The verifier changes to allow loading sleepable
programs are in a subsequent patch.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/trace/bpf_probe.h |  2 --
 kernel/trace/bpf_trace.c  | 20 ++++++++++++++---
 net/bpf/test_run.c        | 55 ++++++++++++++++++++++++++++++++++-------------
 3 files changed, 57 insertions(+), 20 deletions(-)

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
index 0b040a417442..8066249e4ba2 100644
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
index 4cd6b3ea1815..1281c32bcc9a 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -748,14 +748,27 @@ static void
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
 	info->retval = bpf_prog_run(info->prog, info->ctx);
-	rcu_read_unlock();
+
+	if (info->prog->sleepable) {
+		migrate_enable();
+		rcu_read_unlock_tasks_trace(scp);
+	} else {
+		rcu_read_unlock();
+	}
 
 	bpf_reset_run_ctx(old_run_ctx);
 }
@@ -783,6 +796,13 @@ int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
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
@@ -793,22 +813,27 @@ int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
 
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
+			/* smp_call_function_single() also checks cpu_online()
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

