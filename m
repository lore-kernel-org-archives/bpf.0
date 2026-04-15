Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3D43D8123
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264589; cv=none; b=Y2RdtgP8pTriBzHnRs5angIforMi2SmMhg6fHaHKlr5x0Eh2THBrqiGNONi4lxfqFKN8BhzYqA/2VN3oq++LiqVnR9/73xT+KlczKwy0iieRXLUFdxD8f/LPzCAR0xhCkOSjEOrlfWUr+8qelv4hC295z5UrNbsoKze/x7WLqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264589; c=relaxed/simple;
	bh=O2/aCVkttSX8YMT+2N8oXdFQjgk+iht85IhAyoeEW4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FO+sUwN19Lypvc0OUcsx8iZZnC/AuZO9uTSHiI8HLn2Cosph+2bO03ULExKvwJ8aPFXrGzMYMwc9G7NjRQXWtkmKUZ5M4PqKbYmzDYi05+v0zBVzc5J4gyacWpZiQ9s6qBrJ91mqzN/4YM+DiIVcHMAFa7uHRvnw4nuVjH1OgCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSeo9SZW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSeo9SZW"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a29e6110so74090615e9.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 07:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776264585; x=1776869385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5W17eWRIhe/rNQW7I92yrFJ2J/B7J01IvI1WMT4Ub4=;
        b=QSeo9SZWVnyT3fT0Dve4SMWOsobROhpjBlER71eT36Dk+hFLVrSm71ORQ4FiGYsUV+
         S1Pt4uEo7JTAn3sCXHRKHyafjdJ/nsHMOOVVo4RkovZ3+iefxuHODYgQkrtd8cUMfz1J
         IX0QWxawAipBqb/2U7/U4L93lHlcR8wOqBe+aYvxa289jiVCWqmBPlHmMuY8oVfgShis
         077xj9L4h9dIFhNSVYFUQkVnSVUriOL4vRmGy57lH9j3TUlML/lig+GgOS0A1unz0rnA
         I9Hr9tD2taMSJV22N7hzNyhASE1NHMVk7xUvHBeNK74ADoDP/r/jGdWVVdMX0CjfWhiQ
         c/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264585; x=1776869385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r5W17eWRIhe/rNQW7I92yrFJ2J/B7J01IvI1WMT4Ub4=;
        b=liPZp19AA6Jt4ENcNTtMXXc1G85DnKxrXv3VYIeaJCm+c1wdtMamd0esdAt/Stxt61
         nb2+8BJrH11hUEXzBSybB+hMDvrHA01aVQfB6bp5TNKfzi9vmxVwLxwg6CxYBXyridNh
         rUbtUQ0k/ac4Z7WH4i5SP2jg7Jm9fg8KQvS1VJZvhwAYpEjhmd68t2desQHOflM6EoHo
         DfoGX0WnjSg/K6bF05MlTL3IInw+cOmchx8r1m1xaFsfYjRz3ajp9RpwKWU3YaagYnIJ
         ZhylJzRk6kS12KTWTPtUcpjyiiAGn1VRVE0c+d4uvS6YgM+hBp57yfRIQWK4AcbC649J
         MpsQ==
X-Gm-Message-State: AOJu0YwQYdTQ3eV+owsoohW98McEKkpLo/9dlrSoI3fDwFZT/k5z1929
	gVU65AXJbVgB+VMxLaoiwSSgtAq3ecnQKAh7LTjKjxXqifNEsPaFdL5s
X-Gm-Gg: AeBDieue6M61NQGI+zGrRy3agWcaG0Cd4xso0vJiP9mL8++/8KHo+ZMVGy/rJ8D11bY
	5SZ3/BVPtwBmGuGgs9/+rw18pVY3cgVs9WhjIGvN9aTReooFKv4d61r9jCH7d6c8gs6QFUDYO90
	o1470tfJoZjDF8chws2qzKVOeag4Ur0DV1HEL8U0KvSOzv/e+SEmqdKACt09hJzDOnQWqk5azN4
	GqVjrSxesJK93TNQSkHSl3nWBBer/wUG1LWnL9i5RnNnJvGvgB/sh/JXLNKCkZhQy1/RGst4jvs
	lj+obI2A64PKUpcCsRy/ldnzCIx30ju1TxIXQqukVAGKbhyF87DH8NkmSBOHIF/jwZTx/khco9E
	6UxpuzhHR9igRf7MzN6lWthBnFwPc/Fjcc2ZqBBvgGUQfUOW9Y2j7IvOv0usSrep1fNylyYoE/n
	896P6RqaaGMkP+4w==
X-Received: by 2002:a05:600d:d:b0:487:2439:b7c8 with SMTP id 5b1f17b1804b1-488d67eb7a7mr234805065e9.1.1776264585264;
        Wed, 15 Apr 2026 07:49:45 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f1e87e93sm65912035e9.11.2026.04.15.07.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:49:44 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 15 Apr 2026 07:49:03 -0700
Subject: [PATCH bpf-next v10 1/6] bpf: Add sleepable support for raw
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-sleepable_tracepoints-v10-1-161f40b33dd7@meta.com>
References: <20260415-sleepable_tracepoints-v10-0-161f40b33dd7@meta.com>
In-Reply-To: <20260415-sleepable_tracepoints-v10-0-161f40b33dd7@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776264581; l=6207;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=FR5BlpddZppKrGfnsDUznIb+qacqYw8IIG62Hu6BnbM=;
 b=lXpzw2Q8kklt4YEq8QwFH+qcYLC82T2b2MYWGi1hKFas9em/wCFT2F7f/0ekNJmbo99v1Gwzi
 bYScESevRrSCEh2ok+u5jWlbvW6RPJ+EBdY+h/N7ZxVDVruA15JyyMR
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

