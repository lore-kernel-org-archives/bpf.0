Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310742;
	b=zSjcP95hsoZ7CKWqiFi/laZlH5rVwoz7NaonGbzQ5D8f8rRhBYqkhvzgtacmxD7YVTdg
	 epkldaW6HO/XXiptYItiw1UkWOGletAxa3jfXqySUVoUbjKGHHeRDrgug1ofoK+77HuM2
	 eotQcTeRj72b5FYsrIwvnWAKhNFQmAcC3Ytw1tQmj0n1leyW3JSI+m1i10VtCX7SWs7Tf
	 /A5w2QxS2EUydKDz5iMFuTjGulNczgQPZ1x4Qn3fh4uOM+SBXncpgW4zBJAB0lLbrc0tK
	 peNviCJAlvHXuI44ASNoTVpyBLpriFf4KbwEngXilNgQhTJJaIsH6+V4tXlqhIwvipQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310742;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P5qj50oObsRnvpDWDnPdrgs/tv9URcN2/eR/tgC+Jkg=;
	b=Qd34jpsDhfgvY0HNyTRGXWyQn0Y3MKSBG0RoLX/j3xpwtbV00TqWc0FXSF6P+AC0v5va
	 elaMMCxs66SnTd7yIK4PCdYP/GBhWSf+HZo4lMk6jInSq2yz4JDBcfbYG4D/JUs2tNWZX
	 MHrpIaaike9zf9Rz+jCfkuzkEOQMG6w1cTFFpSLQ+EIMNyk+8kEcutDd8Yrhi/COyjtxi
	 ba9+Iux4LdCFUO8xAqKcH8cHIFddheKPH9ch12MVboeWo8GdYCIRVFJ7hzInaNsMheGj8
	 /vBGRkki3IPsIaulwL+qzaya0N8hfcr9ezjIobWiB74Fg8WbSOsfqdQXZICaQkImSvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lP5EKg8U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5923606A333;
	Tue, 10 Nov 2026 11:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lP5EKg8U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA7B1F008A1;
	Tue, 10 Nov 2026 11:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310741;
	bh=P5qj50oObsRnvpDWDnPdrgs/tv9URcN2/eR/tgC+Jkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lP5EKg8U43A9gZCgDQbdUF4nruHly9B4p7AEWzKmAlWPwujjpCM6BF8Gc2UbiPQNP
	 41DsjvgefLMSkkOFB2jQePZQXiQQi/Vobr6oaEuQ9kIpxOVR64CzCtYsSvCs8UUugg
	 IJtRd/BGmX3ujUarYBWoAKdsDhz4xtdfnQtsWEv8+OYtKtgpLjTFrArSlJzntAKgn2
	 V6CRj6T3whV2ZOFd1DR+CAyvGyleCEsDsWibZ2YaA0Sguu8UEYrr0JaNDkgcsL5Q4Q
	 9U597QJ7tpXfyVSIyTi8eErliLztOI167FF3jlS/vf2SFJDsyXAzfUMIqyiOUUTCnE
	 PNmoZ7M+qwe8A==
Message-ID: <sashiko-outbox-206945@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] sched_ext: charge BPF scheduler tasks to cpu.max
 bandwidth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fernand Sieber" <sieberf@amazon.com>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <3977ed2471c6fdc19c672b2dcd13c70f997b9eff.1794303670.git.sieberf@amazon.com>
References: <cover.1794303670.git.sieberf@amazon.com>
 <3977ed2471c6fdc19c672b2dcd13c70f997b9eff.1794303670.git.sieberf@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:39:00 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] sched/fair: lost refills and wrong runtime in
  cfs_bandwidth_task_runtime()
- [High] sched/fair: cfs_bandwidth_task_runtime() returns RUNTIME_INF on
  zero runtime
- [Medium] sched/fair: cfs_bandwidth_return_task() strands unpaid debt
  on old CPU
- [Medium] sched/fair: stale cfs_b->debt persists across cpu.max
  reconfiguration
- [Medium] sched_ext: scx_can_stop_tick() stops tick for cpu.max
  constrained tasks
- [Medium] sched/fair: cfs_bandwidth_charge_task() consumes 1ns async
  unthrottle grant
- [Medium] selftests/sched_ext: cgroup and memory leaks in setup_ctx()
  and setup_debt()
- [Low] selftests/sched_ext: head-only peek in cgroup_runtime_dispatch()
--

commit 0c5e278d21c97ca5fabb3de9616fe36039f5635b
Author: Fernand Sieber <sieberf@amazon.com>

sched_ext: charge BPF scheduler tasks to cpu.max bandwidth

This commit adds the SCX_OPS_CHARGE_CPU_MAX flag and the
scx_bpf_task_cpu_max_runtime() kfunc so BPF schedulers can charge task
execution against a cgroup's CFS cpu.max bandwidth pool and share a single
quota with the fair class.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 265a80dd93282..6ffc9ca2c5c9f 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -1625,6 +1625,11 @@ static void expire_task_slice(struct task_struct *=
p)
>  		scx_set_task_slice(p, 0);
>  }
> =20
> +static bool scx_task_charges_cpu_max(const struct task_struct *p)
> +{
> +	return scx_task_sched(p)->ops.flags & SCX_OPS_CHARGE_CPU_MAX;
> +}
> +
>  static void update_curr_scx(struct rq *rq)
>  {
>  	struct task_struct *donor;
> @@ -1650,6 +1655,9 @@ static void update_curr_scx(struct rq *rq)
>  	if (unlikely(donor =3D=3D scx_rescuee(rq)))
>  		scx_rescue_charge(rq, delta_exec);
> =20
> +	if (scx_task_charges_cpu_max(donor))
> +		cfs_bandwidth_charge_task(rq, donor, delta_exec);
> +
>  	dl_server_update(&rq->ext_server, delta_exec);
>  }

[Severity: Medium]
Can scx_can_stop_tick() still stop the scheduler tick on a CONFIG_NO_HZ_FULL
CPU when a bandwidth-constrained task runs with SCX_SLICE_INF?

set_next_task_scx() sets SCX_RQ_CAN_STOP_TICK whenever
p->scx.slice =3D=3D SCX_SLICE_INF && !p->is_blocked, and __need_bw_check() =
in
kernel/sched/core.c only checks fair_sched_class tasks.  If a BPF scheduler
with SCX_OPS_CHARGE_CPU_MAX dispatches a task with SCX_SLICE_INF on a
nohz_full CPU, stopping the tick stops update_curr_scx() and ops.tick() from
running while the task stays in userspace, so cpu.max is neither charged nor
enforced.

[ ... ]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bc068b3fa4ed1..9ff239f122bda 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6875,6 +6875,11 @@ void __refill_cfs_bandwidth_runtime(struct cfs_ban=
dwidth *cfs_b)
>  	}
> =20
>  	cfs_b->runtime =3D min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
> +
> +	/* pay the debt cfs_bandwidth_charge_task() left */
> +	runtime =3D min(cfs_b->runtime, cfs_b->debt);
> +	cfs_b->runtime -=3D runtime;
> +	cfs_b->debt -=3D runtime;
>  	cfs_b->runtime_snap =3D cfs_b->runtime;
>  }

[Severity: Medium]
Does cfs_b->debt stay stale across cpu.max and cpu.max.runtime writes?

In tg_set_cfs_bandwidth(), setting cpu.max to "max" sets cfs_b->quota to
RUNTIME_INF and resets each CPU's cfs_rq->runtime_remaining to 1, but
__refill_cfs_bandwidth_runtime() returns early on RUNTIME_INF without
clearing cfs_b->debt.  Lowering cfs_b->quota (for example from 100ms to
10ms) also leaves prior cfs_b->debt up to the old quota, starving the group
for multiple periods under the new quota.  Similarly,
cfs_bandwidth_set_runtime() overwrites cfs_b->runtime without clearing
cfs_b->debt, and __return_cfs_rq_runtime() adds returned slack to
cfs_b->runtime without paying down cfs_b->debt.

> @@ -8076,6 +8081,123 @@ bool cfs_task_bw_constrained(struct task_struct *=
p)
>  	return false;
>  }
> =20
> +/*
> + * Charge @delta_exec, which @p ran on @rq outside the fair class, to the
> + * bandwidth of its task group and of each ancestor with a quota, as
> + * account_cfs_rq_runtime() charges a fair task. A cfs_rq that runs out =
takes
> + * another slice from cfs_b, but @p is never throttled: the BPF schedule=
r that
> + * runs it stops it, and the group's fair tasks are throttled when they =
run.
> + *
> + * Debt below -slice that cfs_b cannot cover moves to cfs_b, up to a quo=
ta,
> + * and the next refill pays it, so that a scheduler which keeps running =
@p
> + * cannot put the group's fair tasks on @rq in more debt than a slice.
> + */
> +void cfs_bandwidth_charge_task(struct rq *rq, struct task_struct *p,
> +			       u64 delta_exec)
> +{
> +	s64 floor =3D -(s64)sched_cfs_bandwidth_slice();
> +	struct task_group *tg;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	if (!cfs_bandwidth_used())
> +		return;
> +
> +	for (tg =3D task_group(p); tg; tg =3D tg->parent) {
> +		struct cfs_bandwidth *cfs_b =3D tg_cfs_bandwidth(tg);
> +		struct cfs_rq *cfs_rq =3D tg_cfs_rq(tg, cpu_of(rq));
> +
> +		if (!cfs_rq->runtime_enabled)
> +			continue;
> +
> +		cfs_rq->runtime_remaining -=3D delta_exec;
> +
> +		/*
> +		 * A throttled cfs_rq gets runtime from distribute_cfs_runtime().
> +		 * Without runtime, an active period timer refills it, so skip
> +		 * the lock. A stopped one is restarted by the assign.
> +		 */
> +		if (cfs_rq->runtime_remaining <=3D 0 && !cfs_rq->throttled &&
> +		    (READ_ONCE(cfs_b->runtime) || !READ_ONCE(cfs_b->period_active))) {
> +			scoped_guard (raw_spinlock, &cfs_b->lock)
> +				__assign_cfs_rq_runtime(cfs_b, cfs_rq,
> +							sched_cfs_bandwidth_slice());
> +		}

[Severity: Medium]
Can cfs_bandwidth_charge_task() consume the 1ns runtime grant from
distribute_cfs_runtime() before the async unthrottle CSD runs, aborting the
unthrottle?

CPU0                                    CPU1
----                                    ----
/* cfs_rq->throttled =3D=3D 1,
 * SCX task running on CPU0
 */
                                        do_sched_cfs_period_timer()
                                          distribute_cfs_runtime()
                                            rq_lock(CPU0)
                                            cfs_rq->runtime_remaining =3D 1;
                                            unthrottle_cfs_rq_async(cfs_rq)
                                            rq_unlock(CPU0)
update_curr_scx()
  cfs_bandwidth_charge_task()
    cfs_rq->runtime_remaining -=3D delta;
    /* <=3D 0, but cfs_rq->throttled =3D=3D 1
     * so __assign_cfs_rq_runtime() is
     * skipped
     */
__cfsb_csd_unthrottle()
  unthrottle_cfs_rq()
    if (cfs_rq->runtime_remaining <=3D 0)
      return;  <-- aborts unthrottle

Because cfs_rq->h_curr is NULL while an SCX task is running on CPU0,
distribute_cfs_runtime() does not call update_curr(cfs_rq) before setting
cfs_rq->runtime_remaining =3D 1.  If update_curr_scx() runs on CPU0 before
__cfsb_csd_unthrottle(), cfs_rq->runtime_remaining drops back to <=3D 0 whi=
le
cfs_rq->throttled is still 1, so unthrottle_cfs_rq() bails out and leaves
the group's fair tasks on CPU0 throttled for the rest of the period while
subsequent SCX charges also skip __assign_cfs_rq_runtime().

> +
> +		if (cfs_rq->runtime_remaining < floor) {
> +			scoped_guard (raw_spinlock, &cfs_b->lock)
> +				cfs_b->debt =3D min_t(u64, cfs_b->debt + floor -
> +						    cfs_rq->runtime_remaining, cfs_b->quota);
> +			cfs_rq->runtime_remaining =3D floor;
> +		}
> +	}
> +}
> +
> +/*
> + * @p leaves @rq: give the runtime @rq holds for its groups back, less
> + * min_cfs_rq_runtime, as a fair dequeue does when a cfs_rq empties. Pay
> + * what @rq owes from cfs_b, as @p may not run on @rq again.
> + */
> +void cfs_bandwidth_return_task(struct rq *rq, struct task_struct *p)
> +{
> +	struct task_group *tg;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	if (!cfs_bandwidth_used())
> +		return;
> +
> +	for (tg =3D task_group(p); tg; tg =3D tg->parent) {
> +		struct cfs_bandwidth *cfs_b =3D tg_cfs_bandwidth(tg);
> +		struct cfs_rq *cfs_rq =3D tg_cfs_rq(tg, cpu_of(rq));
> +
> +		return_cfs_rq_runtime(cfs_rq);
> +
> +		if (cfs_rq->runtime_enabled && cfs_rq->runtime_remaining < 0 &&
> +		    !cfs_rq->throttled && READ_ONCE(cfs_b->runtime)) {
> +			scoped_guard (raw_spinlock, &cfs_b->lock)
> +				__assign_cfs_rq_runtime(cfs_b, cfs_rq, 0);
> +		}
> +	}
> +}

[Severity: Medium]
When a task overruns on rq and is dequeued while cfs_b->runtime is 0, does
cfs_bandwidth_return_task() leave the negative cfs_rq->runtime_remaining
stranded on the old CPU?

cfs_bandwidth_charge_task() already pulls from cfs_b->runtime whenever it is
non-zero, so cfs_rq->runtime_remaining is negative here primarily when
cfs_b->runtime has been exhausted to 0.  If p then migrates, sleeps, or
switches cgroups before the next period refill, cfs_bandwidth_return_task()
does nothing because cfs_b->runtime is 0 and never transfers the unpaid
cfs_rq->runtime_remaining to cfs_b->debt.  The task escapes up to a slice of
debt on each CPU it moves across, while the old CPU's cfs_rq keeps the debt
and later refills of cfs_b only pay cfs_b->debt.

> +
> +/*
> + * The runtime @p's groups have left for it on its CPU, without locks: t=
he
> + * least, over the groups with a quota, of what the CPU holds or owes and
> + * cfs_b's runtime. Debt counts up to a quota less 1ns, so that a full p=
eriod
> + * lets @p run and pay the rest. A group whose period timer is stopped d=
oes
> + * not count, as the next charge restarts the timer and refills what it =
owes.
> + * RUNTIME_INF if no group counts.
> + */
> +u64 cfs_bandwidth_task_runtime(struct task_struct *p)
> +{
> +	u64 runtime =3D RUNTIME_INF;
> +	struct task_group *tg;
> +	int cpu =3D task_cpu(p);
> +
> +	if (!cfs_bandwidth_used())
> +		return runtime;
> +
> +	guard(rcu)();
> +
> +	for (tg =3D task_group(p); tg; tg =3D tg->parent) {
> +		struct cfs_bandwidth *cfs_b =3D tg_cfs_bandwidth(tg);
> +		struct cfs_rq *cfs_rq =3D tg_cfs_rq(tg, cpu);
> +		s64 held;
> +
> +		if (!READ_ONCE(cfs_rq->runtime_enabled) ||
> +		    !READ_ONCE(cfs_b->period_active))
> +			continue;

[Severity: High]
Can skipping groups with !cfs_b->period_active make
cfs_bandwidth_task_runtime() return RUNTIME_INF when cfs_b->runtime is 0 and
no idle period refills are owed?

When only SCX tasks run, cfs_rqs are never throttled, so
do_sched_cfs_period_timer() sets cfs_b->idle =3D 1 at every period boundary.
If __refill_cfs_bandwidth_runtime() consumes the refill paying cfs_b->debt
(leaving cfs_b->runtime =3D=3D 0), neither holding tasks in BPF while
cfs_b->runtime is 0 nor charging further into cfs_b->debt in
cfs_bandwidth_charge_task() clears cfs_b->idle.  At the next period boundar=
y,
do_sched_cfs_period_timer() sees cfs_b->idle && !throttled and deactivates
the period timer (cfs_b->period_active =3D 0) with period_timer already
forwarded to the end of the new period.  cfs_bandwidth_task_runtime() then
sees !cfs_b->period_active and returns RUNTIME_INF even though
cfs_b->runtime is 0 and start_cfs_bandwidth() on the next charge will find 0
elapsed idle periods to refill.

Writing 0 to cpu.max.runtime while cfs_b->period_active is 0 hits the same
state: cfs_bandwidth_set_runtime() forwards period_timer via
cfs_bandwidth_refill_idle_periods() and sets cfs_b->runtime =3D 0 without
starting period_timer, so scx_bpf_task_cpu_max_runtime() returns U64_MAX
instead of 0.

> +
> +		held =3D max_t(s64, READ_ONCE(cfs_rq->runtime_remaining),
> +			     1 - (s64)READ_ONCE(cfs_b->quota));
> +		held +=3D READ_ONCE(cfs_b->runtime);
> +		runtime =3D min_t(u64, runtime, max_t(s64, held, 0));
> +	}
> +
> +	return runtime;
> +}

[Severity: High]
Does splitting overrun debt between cfs_rq->runtime_remaining and
cfs_b->debt cause cfs_bandwidth_task_runtime() to return 0 across a refill,
discarding the unspent refill on the next period?

When a task overruns past -slice and waits in a BPF DSQ on the same CPU,
cfs_rq->runtime_remaining stays at -slice while the rest of the overrun goes
into cfs_b->debt.  At the next period refill,
__refill_cfs_bandwidth_runtime() adds cfs_b->quota to cfs_b->runtime and
immediately subtracts cfs_b->debt, leaving cfs_b->runtime =3D quota - debt
while cfs_rq->runtime_remaining is still -slice.  Whenever
quota - debt <=3D min(slice, quota - 1) (for example, any non-zerocfs_b->de=
bt
when quota <=3D slice), or whenever another CPU consumes any runtime from
cfs_b->runtime while this CPU owes -quota, held is <=3D 0 and
cfs_bandwidth_task_runtime() returns 0 for the whole period.  Because the B=
PF
scheduler does not run the task, __assign_cfs_rq_runtime() is never called =
to
apply cfs_b->runtime against cfs_rq->runtime_remaining, and the next period
refill caps cfs_b->runtime at quota + burst, losing the previous refill
while cfs_rq->runtime_remaining remains at -slice.

Conversely, when cfs_b->quota < sched_cfs_bandwidth_slice() and
cfs_b->debt =3D=3D 0 (for example quota =3D 1ms, slice =3D 5ms, and
cfs_rq->runtime_remaining =3D -4ms), clamping cfs_rq->runtime_remaining at
1 - quota makes held =3D 1ns after a single 1ms refill, letting the task run
every period despite owing multiple periods of debt on cfs_rq.  Finally,
held does not subtract READ_ONCE(cfs_b->debt) when cfs_b->runtime is
populated before a refill (e.g. via __return_cfs_rq_runtime() or
cfs_bandwidth_set_runtime()).

[ ... ]

> diff --git a/tools/testing/selftests/sched_ext/cgroup_runtime.bpf.c b/too=
ls/testing/selftests/sched_ext/cgroup_runtime.bpf.c
> new file mode 100644
> index 0000000000000..ec98a25d19c29
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/cgroup_runtime.bpf.c
> @@ -0,0 +1,195 @@

[ ... ]

> +void BPF_STRUCT_OPS(cgroup_runtime_dispatch, s32 cpu, struct task_struct=
 *prev)
> +{
> +	struct task_struct *p =3D __COMPAT_scx_bpf_dsq_peek(HELD_DSQ);
> +
> +	if (p && runnable(p))
> +		scx_bpf_dsq_move_to_local(HELD_DSQ, 0);
> +}

[Severity: Low]
Since the two burner tasks are pinned to different CPUs and share HELD_DSQ,
can peeking only the head of HELD_DSQ check the wrong task's per-CPU runtim=
e?

If the head task in HELD_DSQ is pinned to CPU 1 and has no runtime on CPU 1,
cgroup_runtime_dispatch() on CPU 2 sees !runnable(p) and does not move the
second burner pinned to CPU 2 even if CPU 2 has runtime.  Conversely, if the
head task on CPU 1 is runnable while the second task on CPU 2 is not,
cgroup_runtime_dispatch() on CPU 2 calls scx_bpf_dsq_move_to_local(), which
skips the CPU 1 task and dispatches the non-runnable CPU 2 task.

[ ... ]

> diff --git a/tools/testing/selftests/sched_ext/cgroup_runtime.c b/tools/t=
esting/selftests/sched_ext/cgroup_runtime.c
> new file mode 100644
> index 0000000000000..86d50a63a6e73
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/cgroup_runtime.c
> @@ -0,0 +1,652 @@

[ ... ]

> +	if (cg_create(ctx->parent)) {
> +		SCX_ERR("Failed to create %s", ctx->parent);
> +		return SCX_TEST_FAIL;
> +	}
> +	ctx->parent_created =3D true;
> +	if (cg_write(ctx->parent, "cgroup.subtree_control", "+cpu")) {
> +		SCX_ERR("Failed to enable cpu in %s", ctx->parent);
> +		return SCX_TEST_FAIL;
> +	}
> +	if (cg_create(ctx->cg)) {
> +		SCX_ERR("Failed to create %s", ctx->cg);
> +		return SCX_TEST_FAIL;
> +	}
> +	ctx->cg_created =3D true;
> +
> +	if (access(cg_control(ctx->cg, "cpu.max.runtime"), F_OK))
> +		return SCX_TEST_SKIP;
> +
> +	if (write_str(ctx->cg, "cpu.max", "%lld %lld", quota, period) ||
> +	    write_str(ctx->cg, "cpu.max.burst", "%lld", burst) ||
> +	    write_str(ctx->cg, "cpu.max.runtime", "%lld", runtime)) {
> +		SCX_ERR("Failed to configure %s", ctx->cg);
> +		return SCX_TEST_FAIL;
> +	}
> +
> +	ctx->skel->bss->cgid =3D cgroup_id(ctx->cg);
> +	if (!ctx->skel->bss->cgid) {
> +		SCX_ERR("Failed to read the cgroup ID of %s", ctx->cg);
> +		return SCX_TEST_FAIL;
> +	}
> +	if (libbpf_num_possible_cpus() < NR_BURNERS + 1)
> +		return SCX_TEST_SKIP;
> +	return SCX_TEST_PASS;
> +}

[Severity: Medium]
Does returning SCX_TEST_SKIP or SCX_TEST_FAIL from setup_ctx() (and
setup_debt()) after cg_create() leak the cgroups and cause later tests in
the same runner to fail with EEXIST?

run_test() in tools/testing/selftests/sched_ext/runner.c only calls
test->cleanup() when test->setup() returns SCX_TEST_PASS.  Because all
cgroup_runtime_* tests in the runner share getpid() in the cgroup path
scx_cgroup_runtime_<pid>, any skip (such as having fewer than 3 CPUs, missi=
ng
cpu.max.runtime, or failing to write sched_cfs_bandwidth_slice_us in
setup_debt()) leaves ctx->parent and ctx->cg behind and makes subsequent
tests fail cg_create(ctx->parent).  Also, passing cg_control() directly to
access() leaks the string allocated by cg_control().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794303670.gi=
t.sieberf@amazon.com?part=3D4
