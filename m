Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A5355F49
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255204; cv=none; b=uHkPm/ATMuJHEtwrzBeQjP+HwM8wAGlQM/LZLSMi1wtG7VOA6Un3oThj6kZr8iDeLuRpZik0kOAQv0gq1uTF6SU3ZSmS4jWEcuGDMv5oKMl8xrxS5q9GeZUjpJ6IwMvFw9ZyjZ6BlvbjQ3UrAIR4m84YDI+ArB+1vACqU9jFf4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255204; c=relaxed/simple;
	bh=E/z/N3A9zcWZ651ZoueLgUhwl8rmk1/hKIVTKgOhZd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TckO/NTc4pUS+3u73rkg2yV3Wio6NxOdqnCXmufqkYEky25s9/hkCl+HWRNuJBd0aVBBwFadY9GjZj/AQ0POunXDjcRJ+eVE2/BuHgb9MyQW5Dz2OwE1UvwgWJBCMRb270KxIbCVbZoL28LhEDiI+4AT5da6Q1FkBT5efEov96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJZORssi; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJZORssi"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so371974a12.3
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255202; x=1792860002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0C6xYm0YTXCiCvlHkrrtgytbqEoX1+SgiHi7ijNd3hc=;
        b=VJZORssigFL4RUy6JNOExEc6xl1Vju6SiaRq7DgDqDLa72eoN1povFw1cSmoza48hJ
         n1U9rRr1P79lg70PmPHc8sgnvJ2TnfMkBtliWFkD/9I/5nz9RpX96zULNCPc/op/nESr
         1MXgbU2t6PIyiEWNw0mI6pxhHWlIbSp8L3ebyMiHY2ls62V2xm7satY32WzUGsA24fc4
         EsDxGUZMnBzpJflBIuWii+ok/pFH5TQ6AqxH+EkCPuDu8DuPJGROmRCT8QTfGNVb3CYv
         OmpdjjIbkVGTyp4si1cvt+ohWv2TIPuPDL4eQTnt3Mm0c/l+n97V9uPckcMyqCXFcEQY
         AWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255202; x=1792860002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0C6xYm0YTXCiCvlHkrrtgytbqEoX1+SgiHi7ijNd3hc=;
        b=Fn49CLieyWXxDoZI0vImh09bU6bIEd2Hyx1QqdCpYrgG28R1Vupu5jvu2tZiytRq5z
         CSeoErJQxsHelkdahJtPv6hXxZE+ymLMCrv1OSnLcOH/C0NbnUCqWhe4WiVTvz0l2B7O
         sQ8P9qZ8wrTSUMqjhHqMDcUo6E5rcX6RJohxT1U5LzgANZW873AZBmkDamv/xF+zcKIo
         JJkR8BSmxs/Nzqsa6UVbyJQRi124sGkvPTzblbWLdjVM89rVQVRV2y4xbBwkDJpIoYYo
         RKz2NYHo2HvpdLQdumKOJLEu2DL7SRVqIxW6Za2o91o0ESUPAtbNrRq2eWRs9XGiI1mF
         KX8g==
X-Gm-Message-State: AFq9FYIgN/ddfk6+DValdu/qlEWNeb0Hu0prxHS+eWvMYAoG1Iu+8WjX
	5xEf8XuIsGsFshmVSyHvG5uvHuBveO2omAcaD/0GChf2J9t84odcUxdz9LPkiA==
X-Gm-Gg: AYBFou1U0mEckzk2owyEgybKfGn0NwWMNnTMu7qvX0J8NHsg+yRrjZFHV167BzwnA0L
	a5Sxq1cgaMSBzySJXLJ9rcC+hLQWvOVapuTYezMWgcq68aKNkYtK1EKB0jyQsk/QLjbsrbKKBYp
	LxGLZ+k3om2CaY6SkCjGUHK/yRhHfkozTWGlIi1TGT2B7tRil1vQ7bgojvFHIlcWT7SBR9mN+wk
	GO8vv/IYY8A/BuV3eMSV6N/rkWz62yjPBVyJpTz3Nr5kwBOwyw5+4AV6kJRcE/sP/3bXnzV1Qba
	n3VMHO7JAJYNczU+V64JIyNXOcBm5avrk5s0YBvuv401fQjeextE0VOchsP4sl3UbpSrh00bOBG
	2R1LdDMSia4ka6rQ8P95tzQJn1QUgFOy1T0fjauFCGxvt7lWQKand9CI/bOMLJ/KoosbklTqoGv
	lEt2A7fWqxd0Gn2eoY84uHk7BXZHLLcVtmwflqBLTKH04RLdJJ2gV+YnwHV33GLtwODvjUSeQtq
	CY3wTPtz4yz5ns7VRKOdPTOdFapLsfLBcGOM24MDP3EBglUI0dI5bllQxUnVh6l+QX+mRbREsPj
	MEkql9qMYFKoysaTZGzXMhxu8n5OVa8wvoxoxqJQAc1xh9CwXPOSKw==
X-Received: by 2002:a17:90b:2ec3:b0:3ab:e588:c295 with SMTP id 98e67ed59e1d1-3acef51e29dmr2623426a91.42.1792255202040;
        Sat, 17 Oct 2026 09:40:02 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e74bcsm14085526a91.3.2026.10.17.09.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:40:01 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 22/43] bpf: Keep a program until its bpf_wq callback has ended
Date: Sat, 17 Oct 2026 16:37:24 +0000
Message-ID: <20261017163745.3341787-23-alexei.starovoitov@gmail.com>
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

bpf_wq_work() runs the callback under rcu_read_lock_trace() only, since
the callback may sleep.  The program it belongs to need not be sleepable,
and such a program is freed behind a plain RCU grace period.  The
reference that the bpf_wq holds is dropped when the map element goes, or
when another callback is set, no matter whether the work is running.

If that was the last reference the program is freed under the running
callback, and the worker goes on in the freed JIT image:

  Oops: int3: 0000 [#1] SMP NOPTI
  RIP: 0010:0xffffffffc0600947

All it takes is to close the map and the program while the callback runs.

Note in the program that it has a callback that runs sleepable, and wait
for an RCU Tasks Trace grace period, which implies a plain one, before
such a program is freed.  Let bpf_wq_work() enter its read side critical
section before it reads callback_fn.

bpf_task_work holds a reference to the program until the callback is done.

Fixes: 8e83da9732d9 ("bpf: add bpf_wq_start")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h   | 10 ++++++++++
 kernel/bpf/helpers.c  |  9 ++++++---
 kernel/bpf/syscall.c  |  4 ++--
 kernel/bpf/verifier.c |  2 ++
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0de5947dceaa..db56d5d07462 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1873,6 +1873,7 @@ struct bpf_prog_aux {
 	bool attach_btf_trace; /* true if attaching to BTF-enabled raw tp */
 	bool attach_tracing_prog; /* true if tracing another tracing program */
 	bool tramp_linked; /* true if it was ever linked to a trampoline */
+	bool sleepable_async_cb; /* has a bpf_wq or bpf_task_work callback */
 	bool func_proto_unreliable;
 	bool tail_call_reachable;
 	bool xdp_has_frags;
@@ -2006,6 +2007,15 @@ struct bpf_prog {
 	};
 };
 
+/*
+ * Does the program, or a callback of it, run under RCU Tasks Trace protection
+ * only, outside of any RCU read side critical section?
+ */
+static inline bool bpf_prog_runs_sleepable(const struct bpf_prog *prog)
+{
+	return prog->sleepable || prog->aux->sleepable_async_cb;
+}
+
 struct bpf_array_aux {
 	/* Programs with direct jumps into programs part of this array. */
 	struct list_head poke_progs;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 439370d73cc5..648abe1ba63a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1262,18 +1262,21 @@ static void bpf_wq_work(struct work_struct *work)
 
 	BTF_TYPE_EMIT(struct bpf_wq);
 
+	/* keeps the program that callback_fn belongs to */
+	rcu_read_lock_trace();
+
 	callback_fn = READ_ONCE(cb->callback_fn);
 	if (!callback_fn)
-		return;
+		goto out;
 
 	key = map_key_from_value(map, value, &idx);
 
-        rcu_read_lock_trace();
-        migrate_disable();
+	migrate_disable();
 
 	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
 
 	migrate_enable();
+out:
 	rcu_read_unlock_trace();
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0f5eb55d49d6..30d570c1c9a0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2477,7 +2477,7 @@ static void __bpf_prog_put_rcu_tasks(struct rcu_head *rcu)
 {
 	struct bpf_prog *prog = container_of(rcu, struct bpf_prog_aux, rcu)->prog;
 
-	if (prog->sleepable)
+	if (bpf_prog_runs_sleepable(prog))
 		call_rcu_tasks_trace(rcu, __bpf_prog_put_rcu);
 	else
 		call_rcu(rcu, __bpf_prog_put_rcu);
@@ -2497,7 +2497,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 	if (deferred) {
 		if (IS_ENABLED(CONFIG_TASKS_RCU) && prog->aux->tramp_linked)
 			call_rcu_tasks(&prog->aux->rcu, __bpf_prog_put_rcu_tasks);
-		else if (prog->sleepable)
+		else if (bpf_prog_runs_sleepable(prog))
 			call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_put_rcu);
 		else
 			call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d0ba7156ba4f..6b15862a15e8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11211,6 +11211,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 					 is_async_cb_sleepable(env, insn));
 		if (IS_ERR(async_cb))
 			return PTR_ERR(async_cb);
+		if (is_async_cb_sleepable(env, insn))
+			env->prog->aux->sleepable_async_cb = true;
 		callee = async_cb->frame[0];
 		callee->async_entry_cnt = state->frame[0]->async_entry_cnt + 1;
 
-- 
2.55.0

