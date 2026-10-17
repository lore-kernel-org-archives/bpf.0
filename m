Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A3237C908
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200556; cv=none; b=TjkLZYT58W2MDw7UWCpq7d/MbYjlhtExAreXmmE5/v0X3TRdSO06LutBhNC0MMA7mwChA0xdc7fGI6WSKvjTm9GOaDyqVq5NUrj5T0PJEjhIXAOi6m+J0QuPLJd256ZA2ZE1RhB3GqmPWNtkSgPnV4NZbnMRyqSnqRSc6fDdMJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200556; c=relaxed/simple;
	bh=HOC3f4wYKeihCCx7M67grB4sLfOb3gIb1j1MUfldKcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4rQtXeL1outz75cpi8IFBIRbUdL5asartmqePUb62HfFHz0ChXvWwbxTw2i6VT75pNoQ6N73A9dBcqt07UuRedAexZskWOvSFkKQf69BvzK4tbEqoyVLEPRpf+9ZcRwCyeiPZJJk+OWbYTyLsqNc/qqM5xgPLLTAbku48d82qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Av2E7A2n; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av2E7A2n"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38759bcd877so360335a91.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200554; x=1792805354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yEkUfH9dWm2FgN91nraymB6h/l1GHWLaUCIls5VIPac=;
        b=Av2E7A2nSvQn60LRwYVm3JfvxLFfhe/MnDguDpcU49DwwqcmShDSJZYFcowzh1xAP7
         4Wp6D6Fe/n/3pj3yTnb9dvF/2pUwAnwhNfRGpuEqeR71juex5vWoX6sE9BnCXBbMehJd
         MzZ5DKlaSF/PVHa66fSjwUP8CVbJH4KKglAf7fZWjexrzrbfuRzMERKzX/HlsxJHxFqN
         oAL5GcJuST9BNotoLhJ54Z8L7K3R6maywUih/RahC1EqolD4OWLScJJ6mmGy89zQaULR
         1UJ7KdhvMa9c22q1+VceJpXrIPLviGoI2o98sAR758mh6tCGmUGINfVr9kNKgjcvWr5P
         B6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200554; x=1792805354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yEkUfH9dWm2FgN91nraymB6h/l1GHWLaUCIls5VIPac=;
        b=nTJyOF+oHLdIaZi/Vut75e7z+KMwEaHGegK4/2I4PTnIhDXEL8cVyxdglhBjYz2O2c
         lvSrHDoMPvCcU0+N+x/mXTBL1g7/Px1qfuSzAgdIWdzeV/OFkjVZKc+/uEwaQHctxPfD
         aksDZrifpZBR5ryWN77RAQXmGs/1S2eWFpj7i3Ui54nypxZc9ouA9Ujw27L6QcjIxRI+
         qsoGBVEDrw9l6ssZYgJfL11rzGQoJ5G+j4uWGc47EZMIcfFrTLUEdlYuD3lNec3aOYAq
         wtWu178UQELB/PdwFIXK/PztlZvt3B4oOIGcolMUPSSVtNxR82f4CfrUhPHPePq8mTnh
         zzkg==
X-Gm-Message-State: AFq9FYJD0MEXPkVWb7DJegZvDAs9HKdHZVDoxzBjDYyU2oa6D25wYVh4
	/dv/Ws44dAYFWmUqwHFWInKZ6Z7aavZr4q99oQIMTekm/OBpxij0UFECH3ooV419
X-Gm-Gg: AYBFou0uc8HNWLmCazXZMNWuQ5xCTi9RpinF+twCt8CUi6qtLAuVwC1uhQ4s8lCMeKE
	2AAVr7nMbJzHWJreLKvLMv4LgRFeVumJDh0gFMDAo/I/GwlC5SZFZJuFIbanjDWX+IBgNZjL1zS
	G+NuwaEKRpTaKm9sHlqqBzQoU+EvMvacpc/uQoXZMWiRwTMhmw2qKh63or2is36bLr8A/u9fcq5
	krog9E2Sbj46LORA2wMQ5zmbhFdWbpPF9gI8HwJajs5VEBqAlqovV2BOPupfC0sdr2lJlUnNgI4
	F4/H6Zyj/6WOB7lOm9ZQRBZ8yNrSI1/+2D8lhb8RMLR6WhuMlLlMHH+X3hMzTKQZtoCBHqR4rNt
	8DA6B/OpyQsJ7wm5cnnq943H7CTj7gcAlTZLrhsVn4ZQvZ3Z6tWAjeaMyyzLEj68TdDMLS8EpLm
	cW+zPtqhcrYEIjt6Cw33XENCuvztV/6WBmzs9g3WuR80ZUUJJbV9x0IiM/rYO8t9Rn9l2DdbUW3
	gmrnOjBxH0LdzOmHRjI987ivEWMOk4ItJAWGsg03qqzkBVA5lpBJPWKt1/dyv8+OMF5TcMSver0
	K+DdjeGHuJa/h0gEhQccyCrZOgbLvokyKi3s+2J8Z/CyPmO9RZnEiA==
X-Received: by 2002:a17:90b:1805:b0:3ab:c6d:2bf9 with SMTP id 98e67ed59e1d1-3acef5b0dd5mr1243649a91.57.1792200554335;
        Fri, 16 Oct 2026 18:29:14 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acddc37958sm3916663a91.14.2026.10.16.18.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:29:13 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 21/38] bpf: Keep a program until its bpf_wq callback has ended
Date: Sat, 17 Oct 2026 01:24:34 +0000
Message-ID: <20261017012451.364800-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
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
index 3fb3c7d22d99..6f93bd1414e5 100644
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
index 4a9f28131791..755529888a72 100644
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

