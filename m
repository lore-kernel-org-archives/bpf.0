Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DAC37FF6F
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791709; cv=none; b=jyBE6X7dSA02Kf7ZrEywZtkhYLxwVp31kRpNR5NCkUSsM64PyFpE3gwUWbyrZ7e25zP4uTb+5csn8ED2u0rqHjwVJswSZt8XfuL5lTjoZrlL2dC70rHto55i6iOqWOtO1rpk5Bm8949RHpoKpKs42YIBXq9UTI5OAF1+pTFfDQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791709; c=relaxed/simple;
	bh=C7qbsP7dactKUzWMniUqLSmXGpKCE6FlAZrrq5NECmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bEWiwVfskMnnzFTZh6x+hyIoUA6kfB3RfIE3NtFxGNqVVku9QX8HXfgq9FSLKGj+UEwcWapVmFcmladKD/DTqErJpaZQaOXdYujnWszQJowpE7x74HXCGAmiP08XH4Ewu9SYUJiK1oHn5sjcpzWWQSU0fe2U/FEhpcsbnrI0WPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJPLnPyy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJPLnPyy"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so14701885e9.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776791706; x=1777396506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8phqV9SLEcqCOyGTd2OpaTZYEx+kV+mXMt9fsMGOdOI=;
        b=oJPLnPyy43K4emynVoQwRTcmkaI7BeHzaLCwOvUNeBw0oHeBsWfS1D/sY0tx4zdDd0
         PGVJmHMztLJBvlxhBcB0EO4HFWEZ3sEjpUNhPKSHaRArPVlDCpPgXUmX6G27VZPw2t+W
         fKlJ/a7D7qjjoblcTT+U/n51N5MVvdYsljIqvC34pBATKgwnXQoOo66OtLrRkT4qpUmO
         2ujn0uG5YFdxD/9fNwmiUy4CgXfbvGVdbScQvyM95ubLrnj8rGdBh5wv5O+a312keZsQ
         NRnCMLnRQ8Est1ytMhpVj1QXGPl7osy9fLBxvLi6IpE15qczr9/mAL9lR1tQACnk/uTX
         x1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776791706; x=1777396506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8phqV9SLEcqCOyGTd2OpaTZYEx+kV+mXMt9fsMGOdOI=;
        b=a/60OjdBHrPKMylEnEmtkwmhELCnYPlpaIJnTjIXKcCgIY3uye6Lqf9wcTu5tKWniA
         a8Pn4UwQLwjjJXWO9O40s3ISs/IxUSwDSpFKE/ZG6a+u0xoxjthnUI3tKtfLOXe3goF4
         MBlRQGGoyXqnTY/T7zUx3sXSwgwH4RW63Lv5KZCHHzS8+4IjNPnmo2Sm3LNCXyDe18RL
         QOQuBz4ozqeXH4W0SOAxsL5P7zJVcMuDcvlTQ/1DgCSlRrcxm+HSmQxNluZJ6T0sKAxW
         XUxkPdLPgLhmUaVTk61uUW+qEZxZqhjW5n5KDPBGAKUMBEGrJ65j7/HFq75EPWVFYlkX
         4YVA==
X-Gm-Message-State: AOJu0YyYh2rE1jsGqVqf2zb0VEfHb9Qg+e/1v/fMHDgQjfS1g7/EcwUv
	rq+TrxIgfth6X6OxCc6mxsOY6h/PTZ/OaiiBDjwMUxKtjsUj2U8SEvJP
X-Gm-Gg: AeBDieuUh1tnn/0mjdB5AqEKR5bv6TNETTwtVuaTHP8CY/BXaRXO96l1zjRlavBLmUv
	pqErhw1I3gW20cf90p5457YexgUwv1/Qtmajql3TagCdS7bFhKS6R3NcupnX49y0SETbF3uHhaH
	3nf9w515CkjEKwdE0nYGoW0yQG5adK2214HuuqFOa9PBkOQxzyNc8gY4stQEVl5l3S/Ty5Cig8h
	dfX4qDrMFCbpVlfwixRQcBUBI07pS6fYQV6OBWon6x7xRKHyRMhwCoSLKw7OKbYnX+KFTpO5o04
	TrDzmClXzPDx+jo/j3Oh6ADMGyFMGITU/jPdaIbTSwHgBuRR9IWScKvZcyLQfwRG5MDWMroGtB3
	pJsE8bkXc51elsNO2Pp/f7gUyfAUY+2Wb/hdPXONblMI/KFg4RNBhD1nNl3tL6fdu6e69aNkKAf
	DaIytAwo/owIrnyoChGJeTnLV4
X-Received: by 2002:a05:600c:c112:b0:486:fe83:861c with SMTP id 5b1f17b1804b1-488fb896910mr210306775e9.7.1776791705812;
        Tue, 21 Apr 2026 10:15:05 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a4b329542sm200422255e9.3.2026.04.21.10.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:15:05 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 21 Apr 2026 10:14:17 -0700
Subject: [PATCH bpf-next v11 1/6] bpf: Add sleepable support for raw
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-sleepable_tracepoints-v11-1-d8ff138d6f05@meta.com>
References: <20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com>
In-Reply-To: <20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776791702; l=6207;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=tCcV2LN6OqH112mRvVMqaHyVGkIUsmc5w5uH6YMCZpo=;
 b=XXXADPV4r/N+y0gik7x20b/3v572veDJkvK6W2ybsEocGIJ+7BQhCIDUk5fWvE4QEQpz2YEq+
 y4s8otmmsy1CL9fUZpJUxjNskU5vOYznTqrDZBmouazZZ3h9+FcAfnv
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

