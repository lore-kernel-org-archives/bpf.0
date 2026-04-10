Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005ED3A169B
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840991; cv=none; b=Rfwqb5j22hCcZ/NoAmIPTp85+bSqtHg508Gv8iOqALqW/u6BMQr16M2rCvC3UfojPG8JkWCY1kNsBn8M2m0pffDdPLm+5uS7X+zn4/wUZUeAg2VzBGjLv9DQmxab9R8K8ptgP4lyS3n+9xqUTVyByDWOO1rGcr7su93Y9m5NgBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840991; c=relaxed/simple;
	bh=HdHclFXVkEdjNU1FGg2XE5Q1lmFAEKR71E9EbtcwcIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMk9hRg+Mg0h7IwotRjM2ZYs4aRBepW6BWfksRgeakgnJqT3ImK7T7NxgR0wL9D91IQD7ZaUmrztho8d2y19EhQKFDWiNu/ndHELRsT47MfOYRUy0t6wngOTzPcDzYqDPfOQcX1UQBLA6vqHuGp7X8w4oOua+hbz9S13Rm+pYzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcEeMKpN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcEeMKpN"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b983bb07eso1470570f8f.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775840988; x=1776445788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmZDR8jApvhbXaLXxIRDq5/rLlvlvHRrBMlvWhITg3g=;
        b=KcEeMKpNV54cwlrFnJZphLSoSQhK22Qxfl3hGmGZWx7W82nPSrw/PPvx4lE8bJbkqW
         4pxDjE9hGmA+sRPE85m9XEv1g7nrjcArexTzl8NfQ1IK/3SNs/d1zSyd2pb3FUgU/8bD
         xNws08I5I3ht1c0TcuKjSbN2I5yh5DVV0dHlC+R577g9muXNUNUVZbTId2Iqpwp9jsOQ
         hd3T1yFf7w4BL4RHQ2pVHjLzJz+CjpMWjlq+U70RxFTNyxWksXqU6rGHsE0WiXgV8bjr
         LzIOSnJ0C7INHKDIzQcRckMcL7awPI3aSYivmh03I8sM6uRr21UnTZc97ucHGZ27n4K1
         1lZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775840988; x=1776445788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vmZDR8jApvhbXaLXxIRDq5/rLlvlvHRrBMlvWhITg3g=;
        b=H1C/BkpGhM4TK353DZqBAciAm4aororj8eUVDksc6uup2TsUUCnx5gbKAlFqcsTtCo
         MRDRgb9hejrEwfHL6H1jf+CUYqTN6LwtYduksytNbNzFUYHDk0pCX/3X+xuNLx7lMvN1
         /NUldfb+xfAdnFvu6CeGoDBS43YopmkdEeGUxfYYVPROoL1Q+Y8IJTJS3rNVej9gH4ZY
         Ik9aCasaFMXuQ9fxrB85bRCLPmEMXbMBTgp0wyiVJaUdgrd1nHLJjlTRsITZGFNLWN3W
         YV8nGn9o/AbIj2tGHdP78zZXaRqbBJMEE8mCEXUVh1/tz/3XwkrFAhVN7ow2CKy2G882
         kq4A==
X-Gm-Message-State: AOJu0YzIwflcu2lY4agy9uQFLbXwQBctC+Q5LjuA++IhZ/Wxzxy8jFTu
	ffmv8ppDtimztZVaiM16Px8e/ErPmNVWOgoYyovVkItyQgHaznGakFc3
X-Gm-Gg: AeBDieu/DAIKE7Z6xmLG9dtEFqhsGspBxkVXMThATNsqAItKvKUP/Ww8AlJ0fxmS7i/
	uOlVd94laCh4tXa/kbKBvxCpsrX2SdZsm3mXmD4kXaCtYRyjLSTZa2OAoPGejdTEufN6830OGVu
	2jlCWVSxSZle7NrRxqWvD3EZ5TIMkYmeoqqY8pNhfzYs5FcmThes+Q0O8HfqqxeJy/DznkgXXbu
	iORhhMlJrAxt44C9Sjau3VcBbKy+lJdibxXHYp6FKPiGtfbI88BGp69FdI/3g/WQYf1St2gQOSj
	8AGTIdg/I59kn1jff4cjuiafcSUcXGgJlwBMiqy1R2P9lsXkfJjfIWHFxIWd+HbMj7JRNW+umv5
	KqGDTATOGtL+KPy4IF2KkJC+Xb17AS+gp+Nk7GKlqXdJG69f5lReZAvsQenV7LSaHyUckWUSFgB
	K1Dg/j9xytC9ciFQ==
X-Received: by 2002:a05:600c:34d3:b0:488:a25e:14b2 with SMTP id 5b1f17b1804b1-488d67d2534mr49592595e9.9.1775840988212;
        Fri, 10 Apr 2026 10:09:48 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d70891sm27003745e9.2.2026.04.10.10.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:09:46 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 10 Apr 2026 10:09:29 -0700
Subject: [PATCH bpf-next v9 1/6] bpf: Add sleepable support for raw
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-sleepable_tracepoints-v9-1-e719e664e84c@meta.com>
References: <20260410-sleepable_tracepoints-v9-0-e719e664e84c@meta.com>
In-Reply-To: <20260410-sleepable_tracepoints-v9-0-e719e664e84c@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775840982; l=6077;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=VKunYKi4bjrZkW4wFscNkQ9e7rUwMw2R6s65f6Fg5TE=;
 b=2Jk5gi5tehxonr5/biIJG79ZJOjKX5WD+CYpu65YtehPPW6jOD5OlMhAd52Mh3d1dXFkfg6Kq
 ViC+nQs3f1YCkDStKcR/gTarTY4rRwhywa6uqD6Hhig7Grd/QyZV5JJ
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
RCU flavor per-program, add per-program recursion context guard for
private stack safety, and reject BPF_F_TEST_RUN_ON_CPU since
sleepable programs cannot run in hardirq or preempt-disabled context.

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
index af7079aa0f36..4e763dd2aa2b 100644
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
index 4cd6b3ea1815..63427a333730 100644
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

