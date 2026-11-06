Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793960137;
	b=uaoozhCOljXZlmm9pMSoEa6UZ2l844YyINmsCo78IOO48C64OQqqKAS3N9y5kup2f0Oy
	 IM2VaduKom7a1eonJ9NZXgld4wSEYk/5oQPp0t0NJigh81yKVaOd5q/LZvqixQ7Ek2AZU
	 rOqDOfs0ogoBTQK7Qwau3cVU41Ok9H+s8IpXlsSMGFUH6Vi3hS6bWd+eN45iOkm+WMndO
	 w2Hgqd5ILEHHIPpoyJmgLtY57btHBH2FaG6xw51szykIc2Uf01lyUE+U6nNUxBQjf0Zaz
	 qSBo71c0N79B1KH5WeE69KndCej0kPlld26dYtNtK2HU88ruuDKZDjrc1zHBvlHNJbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960137;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U7R4mynCktpF01Azj77bkwoBpQmdEfcPb9I37TsrAZs=;
	b=VqIEBAsKhM2o08G6Tb1td/rzTe6QnPyaGGaLYLSnm/Nr9S+4lEWlpfFzWQHnTQGX1CJW
	 uKOwmIjgJB9sBqLfA8Aih0kaVGkVwkqN60Sn6xuKYHbUrOWnafyVaj6UQtQ2BwBp9//B/
	 L0a3RNlT0IIHJPtORB0U190xvEQBygiC5S4CdfINWyQOT17edygueylJnJfzOxGeOPg5Q
	 SYsID9EbA3eLEH0bwjpObLxyvwZXDE4gB9dPnydQmJRqvOGS3s65WEYLQ6ErSPOghYg9a
	 DLoFEzSdMPYGconrikcD33z8jiGJCNmPhD2I/WQXr4CHs0ynJzpFSwO8Peb91Bb4VDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ScNkp43P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604BE606A326;
	Fri,  6 Nov 2026 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ScNkp43P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D201F0089F;
	Fri,  6 Nov 2026 10:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793960137;
	bh=U7R4mynCktpF01Azj77bkwoBpQmdEfcPb9I37TsrAZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ScNkp43PTAg/AHOCR475U45KZ+9/1vj0FOc0PFFCyOo2bpl8RE71F6Ai+SG8euB52
	 aiwp0pANRasMSLX/mkQtxzETU8Y9aQ+va6+N4q0sh1qLnOfoEp/WVlSSC2r92QezSN
	 xLBYAC1v/AK92BzZ7dzjmWZWlmshUkgMAmdEvfZUIBaHI47TPfMfFJOCB991DfkARe
	 PSVdRVTu+Iwp72eu8riq9Ot88pwdU7NFQHAsYjK/RfpPZh9HHQdjYwMwRIO2DrU91T
	 Jfox6y1Sd93lWH9T5NbOt9AnSbw2HFu+dW9+JxLE14fnkXPG/XDN0KwuR5FZkl//CO
	 kONGemp18c7uQ==
Message-ID: <sashiko-outbox-201192@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add scx_tickbug, a scheduler that holds
 a task on an idle CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Radu Toader" <radu.m.toader@gmail.com>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20261106094343.174905-2-radu.m.toader@gmail.com>
References: <20261106094343.174905-1-radu.m.toader@gmail.com>
 <20261106094343.174905-2-radu.m.toader@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 10:15:36 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] sched_ext: stale hold_q entry consumed in release_one() after
  dequeue
- [Medium] sched_ext: skipped hold and local DSQ trap in handle_tagged()
- [Medium] sched_ext: untagged SCX_ENQ_LAST tasks kept on target_cpu in
  tickbug_enqueue()
- [Medium] sched_ext: untagged wakeups disturb target_cpu in
  tickbug_select_cpu()
--

commit 36aa4109ffa11a9bc7eddd270c091950516a7eb6
Author: Radu Toader <radu.m.toader@gmail.com>

sched_ext: Add scx_tickbug, a scheduler that holds a task on an idle CPU

This commit adds the scx_tickbug test scheduler, which parks tasks named
"spin" in a BPF queue on a target CPU's run queue without kicking the CPU,
releasing them periodically via a timer pinned to another CPU.

> diff --git a/tools/sched_ext/scx_tickbug.bpf.c b/tools/sched_ext/scx_tick=
bug.bpf.c
> new file mode 100644
> index 0000000000000..3d7ce74236289
> --- /dev/null
> +++ b/tools/sched_ext/scx_tickbug.bpf.c
[ ... ]
> +s32 BPF_STRUCT_OPS(tickbug_select_cpu, struct task_struct *p,
> +		   s32 prev_cpu, u64 wake_flags)
> +{
> +	if (is_tagged(p))
> +		return target_cpu;
> +	return prev_cpu;
> +}

[Severity: Medium]
When an untagged task with prev_cpu =3D=3D target_cpu wakes up while target=
_cpu
is idling with a held task, doesn't returning prev_cpu here break
target_cpu out of the idle loop under test?

ttwu_do_activate() activates the task on target_cpu's run queue and
wakeup_preempt() calls resched_curr() because ext_sched_class is above
idle_sched_class.  That forces target_cpu out of do_idle() through
tick_nohz_idle_exit() and back into tick_nohz_idle_enter(), resetting
TS_FLAG_IDLE_ACTIVE mid-hold, while tickbug_enqueue() places the task into
SHARED_DSQ without kicking an idle non-target CPU to run it.

[ ... ]

> +static bool handle_tagged(struct task_struct *p, struct task_ctx *tctx,
> +			  u64 enq_flags)
> +{
[ ... ]
> +	if (!(enq_flags & SCX_ENQ_LAST) && scx_bpf_task_running(p)) {
> +		/*
> +		 * Re-enqueued while it is the current scheduling context, e.g.
> +		 * after a kthread preempted it. Holding it here would take CPU
> +		 * away from work already in progress, which is not the state
> +		 * under test: the hold belongs at the start of a run, not in
> +		 * the middle of one. Put it straight back so it carries on.
> +		 *
> +		 * %SCX_ENQ_LAST is excluded because it is not that case. It
> +		 * arrives from put_prev_task_scx(), where rq->donor is still
> +		 * @p - put_prev_set_next_task() asserts as much - so
> +		 * scx_bpf_task_running() is true for every enqueue on that
> +		 * path, while the CPU is in fact about to go idle with @p as
> +		 * the only runnable task. That is what has to be held.
> +		 */
> +		__sync_fetch_and_add(&nr_requeue, 1);
> +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, slice_ns, enq_flags);
> +		return true;
> +	}

[Severity: Medium]
Can a tagged task exhausting its slice in put_prev_task_scx() hit this
branch and skip being held when next is not the idle task?

When a running tagged task on target_cpu runs out of slice,
do_pick_task_scx() calls tickbug_dispatch() before put_prev_task_scx()
enqueues the outgoing task.  Because nr_held_now is 0 during
tickbug_dispatch(), target_cpu pulls from SHARED_DSQ; if an untagged task
is moved to the local DSQ, put_prev_task_scx() sees going_idle =3D=3D false=
 and
enqueues the slice-expired tagged task without SCX_ENQ_LAST while rq->donor
is still that task, so handle_tagged() inserts it into SCX_DSQ_LOCAL
instead of holding it.

Similarly, if two tagged tasks are held in hold_q, the timer firing for the
second task while the first is running preempts the first task and
dispatches the second into SCX_DSQ_LOCAL.  put_prev_task_scx() then
re-enqueues the first task without SCX_ENQ_LAST into SCX_DSQ_LOCAL, after
which both tasks stay in SCX_DSQ_LOCAL trading slices forever without
calling tickbug_dispatch() or being held again.

[ ... ]

> +void BPF_STRUCT_OPS(tickbug_enqueue, struct task_struct *p, u64 enq_flag=
s)
> +{
[ ... ]
> +	/*
> +	 * A %SCX_ENQ_LAST task stays on its own CPU. put_prev_task_scx() sets
> +	 * need_resched on the incoming idle task only if the enqueue landed on
> +	 * the local DSQ, so a task left in a shared DSQ here would sit there
> +	 * until some other CPU happened to drain it.
> +	 */
> +	if (last)
> +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, slice_ns, enq_flags);
> +	else
> +		scx_bpf_dsq_insert(p, SHARED_DSQ, slice_ns, enq_flags);
> +}

[Severity: Medium]
If an untagged task is running on target_cpu when a tagged task wakes up
and is parked in hold_q, won't inserting the untagged task into
SCX_DSQ_LOCAL on SCX_ENQ_LAST keep target_cpu busy throughout the hold?

When the untagged task's slice expires on target_cpu, tickbug_dispatch()
sees nr_held_now > 0 and returns early so target_cpu will enter the idle
loop.  That makes pick_next_task() select rq->idle, so put_prev_task_scx()
calls tickbug_enqueue() with SCX_ENQ_LAST for the untagged task; putting it
back into SCX_DSQ_LOCAL causes put_prev_task_scx() to set need_resched on
rq->idle and immediately run the untagged task again, inflating
total_held_ns and max_held_ns with time target_cpu spent running.

> +
> +void BPF_STRUCT_OPS(tickbug_dequeue, struct task_struct *p, u64 deq_flag=
s)
> +{
> +	struct task_ctx *tctx;
> +
> +	tctx =3D bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
> +	if (!tctx || !tctx->held)
> +		return;
> +
> +	/*
> +	 * A parked task is leaving BPF custody without going through
> +	 * release_one(): an affinity or property change, a class change, or
> +	 * exit. Give up the hold now. Its entry stays in @hold_q, where
> +	 * release_one() recognises it by this flag and drops it.
> +	 */
> +	tctx->held =3D false;
> +	__sync_fetch_and_add(&nr_undone, 1);
> +	__sync_fetch_and_sub(&nr_held_now, 1);
> +}
> +
> +/* Let one held task run on the CPU we are dispatching for. */
> +static bool release_one(void)
> +{
> +	struct hold_entry ent;
> +	struct task_ctx *tctx;
> +	struct task_struct *p;
> +
> +	bpf_repeat(BPF_MAX_LOOPS) {
[ ... ]
> +		tctx =3D bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
> +		if (!tctx || !tctx->held) {
> +			__sync_fetch_and_add(&nr_stale, 1);
> +			bpf_task_release(p);
> +			continue;
> +		}
> +
> +		tctx->held =3D false;
> +		__sync_fetch_and_sub(&nr_held_now, 1);

[Severity: Medium]
What happens in release_one() if a parked task goes through
tickbug_dequeue() and is re-enqueued into hold_q before its undone entry is
popped?

A property or affinity change on a parked task (such as setpriority() or
sched_setaffinity()) runs tickbug_dequeue(), which clears tctx->held while
leaving the older hold_entry in hold_q, and then immediately calls
tickbug_enqueue(), which sees tctx->held =3D=3D false, pushes a second
hold_entry for the same pid, and sets tctx->held =3D true.  When
release_one() pops the older undone entry first, it sees tctx->held =3D=3D =
true
and consumes the stale entry as live, leaving hold_q off by one for that
task and corrupting total_held_ns and max_held_ns with the older timestamp
on every subsequent release.  Storing the active hold timestamp (or a
sequence number) in task_ctx and matching it against ent.at in
release_one() would distinguish stale entries from the current hold.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106094343.1749=
05-1-radu.m.toader@gmail.com?part=3D1
