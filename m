Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795663878;
	b=MtVeAM7tzj7gt8FNrPt3PdF4t1Tq0pfUF/cucN1gdATuucHCramaXdvf8QnO6YB8RNr4
	 PzG/Oa2c/X7r3usxl7bkw9sLuhgLTgWeOBjM22jNDDTx34/45B3T6Cmh3chGpVft2H1FX
	 qe4586OyiH44MAmWk2iZfQhp+ZVqqdA0UkA4siQZNIdub2WFU1OJsEm7mPHrOb3W/Smj1
	 HLiXS85ERmUcgJgEleUEykS/GIJ6YC+uJ3WDWUKN9Efgq1ZkfM9UOzNAuIFJUaxkn9YN/
	 MfgQ1EFDbvxLonjqJidnYePpUnRy5rkRh9+v3EO4eXbmxR+k1FOLqNUUZMmXmV1Oovw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vQDjKL7nrjcU97QTUg+Sc6BRlUr7oS58yqxm5kVaxaM=;
	b=R524/gK6yb12t7hAD5SuRNo7/ClVqwtsyPrhEHZNUs1BCvI0m7LYHCkTywYYM3VKD+6t
	 ng7vjnbtg1u2AJDWt8Y3Qk2laUDAyZ7YMAWiBAyiS/Uc0JyEmrkmZRui81ilBgrxUXm59
	 Nnt4y4tHt0UNyAmoQVOMNHZDCg/bRWd/PNIZUYJyrWgK7F3ppPR9peZY+76Ea3Vo1MyMo
	 QWqA39VaxK4oENNggrcAwoVt2oCRF9yL8yj7gZAe22QiEXa3YrywG72mUgz3WGSoQgmDI
	 2w+iKGx86dbt3CfXUdKf6jVfo9EMrafb0YpDv+VRcT1ybuu/KsDGkCnEiG8IFfyrPyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=muV9PHi3;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A482606A323
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A482606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=muV9PHi3
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso2694923a12.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 19:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795663877; x=1796268677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vQDjKL7nrjcU97QTUg+Sc6BRlUr7oS58yqxm5kVaxaM=;
        b=muV9PHi3I9vz81jfhPOQ+vJIxyNR2jjcf5eDk6FgQJ/dRSydCPKaERLns+cs+Kfj4V
         dfKbzhIQvRuBwAYEnzMVbh/EGCDVWFjbolke8QgIPS3hma74Rq90/Wh9pmoreTYtiDdz
         4judnpjS6Thv4BBwXx2meFHicx2I+3XJSM48jxiOC7hDQWzXOZzn71f8vsapy6uu0MpQ
         zBWUWUFpfVnvqdUz/elJx+XP9KVjwbyjVc7EHP2n9Qx2mjpRsbV62Qc/qh4vKZYx63Xn
         bMnD4+ZshasXEZd5YtfSDD4tMTlgWyCveqhQ0PMTqAf3p9GxwuEzRJGRskp12exTl7rd
         GvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795663877; x=1796268677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vQDjKL7nrjcU97QTUg+Sc6BRlUr7oS58yqxm5kVaxaM=;
        b=Tasl2PT0RZUCSX1tstXWTawMSXXo64hnywkjifUIFkm6kcuDGlHp/vY4TiwhhuxPEj
         9XNhy22lf+SC1lus/GRghVkQd1dcbE8q6TIx6gB8NHQPQcjzZpo5JHvtj1bjA9XbgVG4
         npUgTFh/HqPf0ZdCDCCZyXuAc44ThLInu1/rtnGsmWC7umu/q0qK1mt6fObC6u6flxH3
         KK4O/7prDzRqd6QJErl0bI2/AhV4Q9Cb+2oif3HiIEAz1JuAlj6210Y+3SVs1g21n0uJ
         s0rmAKCs3vXoHWgsDRtgtvCc+mf/MEWg39Ql803v5cRh+HDko0dmN1oWk0vK5RLB/28t
         tFrQ==
X-Gm-Message-State: APuU4Z9+C1VZ5JSqqBJVpHpxeHl6w5qD+afO/ykpXK7jblI9bvOCl4qH
	1nc/TZhyaOyfv/l3IQU77IbeK7uLpogCHQV5Hv8dU44vlKo4C+jd0dTxTL9Xrw==
X-Gm-Gg: AZFdTZdcwhs04Dfv4eTLPjUHITcKwXZexZdiQPoIvCM6FlfGV8przbNw3egjvHa16/j
	/cGGkKRWD+NZ/rTK3a/ENwnCsJ/PxSqHSlawR+Qh9MS+m4Yb4+wqdurTPE4PPhT9dU+fOlX7qv+
	N9nkrWbc671K46c0/M2TjRe7LInbb3Pygo5DnE5CuC0YmDz9P/UrQqgXwf520gCgCtIKTGdiZrZ
	cZ1xbH5gxrIhM8Bsr7x3zc+/BqIE+VVKazAtwqb3l1I6H6af4IAr3uEPQCny/RoR5L/Xt07BgH2
	fwk/2Qixbna77vpzgCFyPTWxr+icmDvwbgVOYMhMraniHpqlUxwEiqSu/FuSg7KeWR+ogyNz8Uw
	b7JQstTdih0ZN4qvi8haOe3KsZudaZf1y1eyvzaCvwMr/t2h2zIZe+2AN5gZpr3mBxajYI4WVc7
	IbZ/BoP4FAPXwcrK58Q7ivdmVB4wW51a2BBGMBezmcc3xkVxhN8AjBqzSSBWfVdEQans+7OIe6Z
	EatUlW4O5IiTsTwh1kW4XmIpvGzbSq/xmGJLlN2iaqANXA1N/M4ORQnyLo3jJS0aAJ4QDzwSLuw
	Huc6Yh4hBGHANHivwf59QrIaI3UbgLV4WzPrW2LGM4iVyllIK8ucq00Uj8Xt8Nzpbptd2UiKFau
	aJdRDoUinHXok3cTgFXW8vGDYjuEtdsj27EAAeFf9LX/6wkMPVpUa2ewWuYOGKPGFDTHDBMpHky
	M=
X-Received: by 2002:a17:90b:3890:b0:3aa:548f:eb77 with SMTP id 98e67ed59e1d1-3b41c97deecmr19798775a91.56.1795663876615;
        Wed, 25 Nov 2026 19:31:16 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b7a8c64sm13568405a91.3.2026.11.25.19.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:31:16 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf] bpf: Set the run context for async callbacks
Date: Thu, 26 Nov 2026 03:31:14 +0000
Message-ID: <20261126033114.4111944-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_get_retval(), bpf_set_retval() and bpf_get_local_storage() use
current->bpf_ctx, which the hook sets. bpf_getsockopt() and
bpf_setsockopt() count on the hook to hold the socket lock.
bpf_sys_bpf(), bpf_sys_close(), bpf_btf_find_by_name_kind() and
bpf_kallsyms_lookup_name() use the credentials and the files of
current. An async callback runs in a timer, in a kworker, in an RCU
callback or in a task that the program has picked.

Give async callbacks a run context of their own, and make these helpers
fail in it. bpf_get_retval() returns 0. bpf_get_local_storage() cannot
fail. Refuse async callbacks in a program with cgroup storage.

Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h    | 13 +++++++++++++
 kernel/bpf/btf.c       |  3 +++
 kernel/bpf/cgroup.c    |  4 +++-
 kernel/bpf/helpers.c   | 35 ++++++++++++++++++-----------------
 kernel/bpf/syscall.c   |  7 +++++--
 kernel/bpf/verifier.c  |  6 ++++++
 net/core/filter.c      | 14 ++++++++++----
 net/ipv4/bpf_tcp_ops.c |  2 +-
 8 files changed, 59 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3a5a0380304d..a6976776e90b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3440,6 +3440,14 @@ static inline bool has_current_bpf_ctx(void)
 	return !!current->bpf_ctx;
 }
 
+/* An async callback runs in no hook, and current is not the task that has armed it */
+extern struct bpf_run_ctx bpf_async_run_ctx;
+
+static inline bool bpf_in_async_cb(void)
+{
+	return current->bpf_ctx == &bpf_async_run_ctx;
+}
+
 void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
 
 void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
@@ -3765,6 +3773,11 @@ static inline bool has_current_bpf_ctx(void)
 	return false;
 }
 
+static inline bool bpf_in_async_cb(void)
+{
+	return false;
+}
+
 static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
 {
 }
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7b3291556e6e..23e8977164e7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9703,6 +9703,9 @@ BPF_CALL_4(bpf_btf_find_by_name_kind, char *, name, int, name_sz, u32, kind, int
 	if (name_sz <= 1 || name[name_sz - 1])
 		return -EINVAL;
 
+	if (bpf_in_async_cb())
+		return -EPERM;
+
 	ret = bpf_find_btf_id(name, kind, &btf);
 	if (ret > 0 && btf_is_module(btf)) {
 		btf_obj_fd = __btf_new_fd(btf);
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 1ff030f4314f..3bf3081bfa27 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2110,7 +2110,7 @@ BPF_CALL_0(bpf_get_retval)
 	struct bpf_cg_run_ctx *ctx =
 		container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
 
-	return ctx->retval;
+	return bpf_in_async_cb() ? 0 : ctx->retval;
 }
 
 const struct bpf_func_proto bpf_get_retval_proto = {
@@ -2124,6 +2124,8 @@ BPF_CALL_1(bpf_set_retval, int, retval)
 	struct bpf_cg_run_ctx *ctx =
 		container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
 
+	if (bpf_in_async_cb())
+		return -EOPNOTSUPP;
 	ctx->retval = retval;
 	return 0;
 }
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1b95fe795b4d..490dd14b6a70 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1219,12 +1219,25 @@ static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
 
 static void bpf_async_refcount_put(struct bpf_async_cb *cb);
 
+struct bpf_run_ctx bpf_async_run_ctx;
+
+static void bpf_run_async_cb(struct bpf_prog *prog, bpf_callback_t callback_fn,
+			     struct bpf_map *map, void *key, void *value)
+{
+	struct bpf_run_ctx *old_ctx = bpf_set_run_ctx(&bpf_async_run_ctx);
+	struct bpf_timed_may_goto saved;
+
+	bpf_timed_may_goto_save(prog, &saved);
+	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
+	bpf_timed_may_goto_restore(prog, &saved);
+	bpf_reset_run_ctx(old_ctx);
+}
+
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 {
 	struct bpf_hrtimer *t = container_of(hrtimer, struct bpf_hrtimer, timer);
 	struct bpf_map *map = READ_ONCE(t->cb.map);
 	struct bpf_prog *prog = READ_ONCE(t->cb.prog);
-	struct bpf_timed_may_goto saved;
 	void *value = t->cb.value;
 	bpf_callback_t callback_fn;
 	void *key;
@@ -1245,10 +1258,8 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 
 	key = map_key_from_value(map, value, &idx);
 
-	bpf_timed_may_goto_save(prog, &saved);
-	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
 	/* The verifier checked that return value is zero. */
-	bpf_timed_may_goto_restore(prog, &saved);
+	bpf_run_async_cb(prog, callback_fn, map, key, value);
 
 	this_cpu_write(hrtimer_running, NULL);
 out:
@@ -1259,7 +1270,6 @@ static void bpf_wq_work(struct work_struct *work)
 {
 	struct bpf_work *w = container_of(work, struct bpf_work, work);
 	struct bpf_async_cb *cb = &w->cb;
-	struct bpf_timed_may_goto saved;
 	struct bpf_prog *prog;
 	struct bpf_map *map;
 	bpf_callback_t callback_fn;
@@ -1282,9 +1292,7 @@ static void bpf_wq_work(struct work_struct *work)
 
 	migrate_disable();
 
-	bpf_timed_may_goto_save(prog, &saved);
-	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
-	bpf_timed_may_goto_restore(prog, &saved);
+	bpf_run_async_cb(prog, callback_fn, map, key, value);
 
 	migrate_enable();
 out:
@@ -4624,7 +4632,6 @@ static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx,
 static void bpf_task_work_callback(struct callback_head *cb)
 {
 	struct bpf_task_work_ctx *ctx = container_of(cb, struct bpf_task_work_ctx, work);
-	struct bpf_timed_may_goto saved;
 	enum bpf_task_work_state state;
 	u32 idx;
 	void *key;
@@ -4646,10 +4653,7 @@ static void bpf_task_work_callback(struct callback_head *cb)
 	key = (void *)map_key_from_value(ctx->map, ctx->map_val, &idx);
 
 	migrate_disable();
-	bpf_timed_may_goto_save(ctx->prog, &saved);
-	ctx->callback_fn((u64)(long)ctx->map, (u64)(long)key,
-			 (u64)(long)ctx->map_val, 0, 0);
-	bpf_timed_may_goto_restore(ctx->prog, &saved);
+	bpf_run_async_cb(ctx->prog, ctx->callback_fn, ctx->map, key, ctx->map_val);
 	migrate_enable();
 
 	bpf_task_work_ctx_reset(ctx);
@@ -4889,7 +4893,6 @@ static void bpf_rcu_run_callback(struct rcu_head *rcu)
 	struct bpf_rcu_head_kern *rh = container_of(rcu, struct bpf_rcu_head_kern, rcu);
 	bpf_callback_t callback_fn = rh->callback_fn;
 	struct bpf_prog *prog = rh->prog;
-	struct bpf_timed_may_goto saved;
 	struct bpf_map *map = rh->map;
 	void *value, *key;
 	u32 idx;
@@ -4901,9 +4904,7 @@ static void bpf_rcu_run_callback(struct rcu_head *rcu)
 	smp_store_release(&rh->armed, 0);
 
 	rcu_read_lock_dont_migrate();
-	bpf_timed_may_goto_save(prog, &saved);
-	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
-	bpf_timed_may_goto_restore(prog, &saved);
+	bpf_run_async_cb(prog, callback_fn, map, key, value);
 	rcu_read_unlock_migrate();
 
 	bpf_prog_put(prog);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7e1085d6a67e..91d078bb13d2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6618,6 +6618,9 @@ static bool syscall_prog_is_valid_access(int off, int size,
 
 BPF_CALL_3(bpf_sys_bpf, int, cmd, union bpf_attr *, attr, u32, attr_size)
 {
+	if (bpf_in_async_cb())
+		return -EPERM;
+
 	switch (cmd) {
 	case BPF_MAP_CREATE:
 	case BPF_MAP_DELETE_ELEM:
@@ -6707,7 +6710,7 @@ BPF_CALL_1(bpf_sys_close, u32, fd)
 	 * This helper is allowed in the following callchain only:
 	 * sys_bpf->prog_test_run->bpf_prog->bpf_sys_close
 	 */
-	return close_fd(fd);
+	return bpf_in_async_cb() ? -EPERM : close_fd(fd);
 }
 
 static const struct bpf_func_proto bpf_sys_close_proto = {
@@ -6727,7 +6730,7 @@ BPF_CALL_4(bpf_kallsyms_lookup_name, const char *, name, int, name_sz, int, flag
 	if (name_sz <= 1 || name[name_sz - 1])
 		return -EINVAL;
 
-	if (!bpf_dump_raw_ok(current_cred()))
+	if (bpf_in_async_cb() || !bpf_dump_raw_ok(current_cred()))
 		return -EPERM;
 
 	*res = kallsyms_lookup_name(name);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d4b31990fcb9..57fed2517e8e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11493,6 +11493,12 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		struct bpf_verifier_state *async_cb;
 
 		/* there is no real recursion here. timer and workqueue callbacks are async */
+		/* there is no cgroup to take the storage from */
+		if (env->prog->aux->cgroup_storage[BPF_CGROUP_STORAGE_SHARED] ||
+		    env->prog->aux->cgroup_storage[BPF_CGROUP_STORAGE_PERCPU]) {
+			verbose(env, "async callback in a program with cgroup storage\n");
+			return -EINVAL;
+		}
 		env->subprog_info[subprog].is_async_cb = true;
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
 					 insn_idx, subprog,
diff --git a/net/core/filter.c b/net/core/filter.c
index fb403e18a5d7..ea20fd2be65c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5866,10 +5866,16 @@ static int sol_ipv6_sockopt(struct sock *sk, int optname,
 				  KERNEL_SOCKPTR(optval), *optlen);
 }
 
+/* No hook has locked the socket for an async callback */
+static bool bpf_sockopt_allowed(const struct sock *sk)
+{
+	return sk && sk_fullsock(sk) && !bpf_in_async_cb();
+}
+
 static int __bpf_setsockopt(struct sock *sk, int level, int optname,
 			    char *optval, int optlen)
 {
-	if (!sk || !sk_fullsock(sk))
+	if (!bpf_sockopt_allowed(sk))
 		return -EINVAL;
 
 	if (level == SOL_SOCKET)
@@ -5892,7 +5898,7 @@ static bool is_locked_tcp_sock_ops(struct bpf_sock_ops_kern *bpf_sock)
 static int _bpf_setsockopt(struct sock *sk, int level, int optname,
 			   char *optval, int optlen)
 {
-	if (sk && sk_fullsock(sk))
+	if (bpf_sockopt_allowed(sk))
 		sock_owned_by_me(sk);
 	return __bpf_setsockopt(sk, level, optname, optval, optlen);
 }
@@ -5902,7 +5908,7 @@ static int __bpf_getsockopt(struct sock *sk, int level, int optname,
 {
 	int err, saved_optlen = optlen;
 
-	if (!sk || !sk_fullsock(sk)) {
+	if (!bpf_sockopt_allowed(sk)) {
 		err = -EINVAL;
 		goto done;
 	}
@@ -5929,7 +5935,7 @@ static int __bpf_getsockopt(struct sock *sk, int level, int optname,
 static int _bpf_getsockopt(struct sock *sk, int level, int optname,
 			   char *optval, int optlen)
 {
-	if (sk && sk_fullsock(sk))
+	if (bpf_sockopt_allowed(sk))
 		sock_owned_by_me(sk);
 	return __bpf_getsockopt(sk, level, optname, optval, optlen);
 }
diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index 2ba73dd6c52c..432ca0783771 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -207,7 +207,7 @@ BPF_CALL_0(bpf_tcp_ops_get_retval)
 	 * return value chained across the bpf_tcp_ops attached to the cgroup
 	 * and is this program's saved_run_ctx.
 	 */
-	if (WARN_ON_ONCE(!ctx->saved_run_ctx))
+	if (bpf_in_async_cb() || WARN_ON_ONCE(!ctx->saved_run_ctx))
 		return 0;
 
 	return container_of(ctx->saved_run_ctx, struct bpf_tramp_run_ctx,

base-commit: 3db9d99ba7b8d5a4a520f5abf785e17406f518a5
-- 
2.55.0

