Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15A5488DAE
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807954; cv=none; b=WUI7utLGRllTxojALnCyf69HOzXGPGVkyJ29+bG72N+IoF7XR2jUYDkkPWKLe7h1V84qAslMcj7pYLxoGR+OAPEabQlufAQXIqtx/0slRs00AR/1QyVmbR34BA7LHXlAAsfZjNSPoN5hWUX0uWi0uMr8l2cVbZejabMdKd4LwlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807954; c=relaxed/simple;
	bh=ZLZjg65FO0HQBKhWAU8NXqwOZK0rt+cjwvFZc5Z7Gng=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pD1nrQnEYk8L/ZJneuZD0KDi/XX5YJnBSsdUF7rRw4mlcxZS90e9nAIZsbB0rm/tsPV+6PC52Jmex8en2QxarnTJ5cOuqSOWs3g5lG2VVfWqDPWBzKaQYp6YKF1Kij2hxwpEvK6zVddaoN7U3Bye0Y3nA+GaUGooaREuO7VbTmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/0xHvEZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/0xHvEZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463731F0089C;
	Mon, 12 Oct 2026 12:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791807953;
	bh=aKwYOqJiVFK5HQy11YEvS0/Qk7F2US2c8yGpFHu6yGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g/0xHvEZSe1H84GCyCJK2s4arOu4nkPrJEF5/fsK+jT7bnU8lrIRr4nw97ZBbRWDo
	 jEqe76Dq3o2qbeGZ3CCqE7L8Zd5ktz/HhV1NUdsgY2Awr0J7XglYYja5xLg22RtHxV
	 SOho8+R9QP2GQ+LWBGzta35r4ONM6I+/99NED5vpqtfUeFp2JXkbL8klPSOKIRYNY/
	 GTRX/ZjrVb9tWHmpoNvUlIj0rstotj9Oa/F4Mk+34BA2t/7FW9tFXuOIQq9YCQO4ql
	 BeG151AsMrbbGfXxu/KDBKSHY/4Mi+EklPFbOcEIiGTgvODhZShV9fpvNPA4cJsLZg
	 bVXMYcpr3eByw==
Message-ID: <sashiko-outbox-168093@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/3] sched: add per-cgroup NUMA balancing mode
 selection via BPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yafang Shao" <laoar.shao@gmail.com>
Cc: tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org, bpf@vger.kernel.org
In-Reply-To: <20261012120438.52849-3-laoar.shao@gmail.com>
References: <20261012120438.52849-1-laoar.shao@gmail.com>
 <20261012120438.52849-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 12:25:52 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] mm: folio_can_map_prot_numa() disables NORMAL NUMA balancing on to=
p-tier nodes when TIERING is active
- [High] sched: AB-BA deadlock in bpf_numab_mode (rq->lock -> pi_lock)
- [High] bpf: missing __nullable annotation in bpf_numab_ops leads to kerne=
l panic
- [Medium] sched: BPF NUMA balancing opt-in ignored by LLC scheduling
--

commit 3975a69bbe7653d443a34c5ce6984dadc110d558
Author: Yafang Shao <laoar.shao@gmail.com>

sched: add per-cgroup NUMA balancing mode selection via BPF

Global NUMA balancing is all-or-nothing: kernel.numa_balancing and
kernel.numa_balancing_mode pick the mode for every workload. A
latency-sensitive service wants the scheduler's NUMA statistics but
not tiering's promotion machinery. This patch adds a bpf_numab_ops
struct_ops to allow policies attached to a cgroup to pick a mode.

> diff --git a/include/linux/bpf_numab.h b/include/linux/bpf_numab.h
> --- /dev/null
> +++ b/include/linux/bpf_numab.h
[ ... ]
> +struct bpf_numab_ops {
> +	/**
> +	 * numab_mode - request a NUMA balancing mode
> +	 * @p: task the NUMA balancing machinery is about to act on, or NULL
> +	 * @folio: folio whose NUMA balancing semantics are being decided,
> +	 *	   or NULL
> +	 *
> +	 * Exactly one of @p and @folio is set. The kernel passes @p when
[ ... ]
> +	 * Return: bits from enum bpf_numab_mode.  Other bits are dropped.
> +	 */
> +	u32 (*numab_mode)(struct task_struct *p, struct folio *folio);

[Severity: High]
Could the lack of a __nullable annotation here lead to a NULL pointer
dereference in user BPF programs?=20

The BPF verifier relies on the __nullable suffix on struct_ops stub
arguments to mark them as PTR_MAYBE_NULL. Without it, the verifier assumes
they are strictly non-NULL and optimizes away any user-provided NULL checks.
When the kernel passes a NULL argument (as designed, since only one of p or
folio is set), the executing BPF program will crash the system.

> +};
[ ... ]
> diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/n=
uma_balancing.h
> --- a/include/linux/sched/numa_balancing.h
> +++ b/include/linux/sched/numa_balancing.h
[ ... ]
>  static inline bool task_numab_enabled(struct task_struct *p)
>  {
> +	u32 state =3D bpf_numab_mode(p, NULL);
> +
> +	/* A policy can always opt out, regardless of the global state. */
> +	if (state & BPF_NUMAB_DISABLED)
> +		return false;
> +	if (state & (BPF_NUMAB_NORMAL | BPF_NUMAB_TIERING))
> +		return true;
>  	return static_branch_unlikely(&sched_numa_balancing);
>  }

[Severity: Medium]
Is this BPF opt-in overlooked by the LLC scheduling logic?

This new helper allows workloads to opt into NUMA balancing even when global
NUMA balancing is disabled. However, functions like get_pref_llc() and
get_scan_cpumasks() still check the global static key sched_numa_balancing
directly instead of using task_numab_enabled(p). For a workload that
explicitly opts in via BPF, its numa_preferred_nid and CPU scan masks will
be skipped.

[ ... ]
> diff --git a/kernel/sched/bpf_numab.c b/kernel/sched/bpf_numab.c
> --- /dev/null
> +++ b/kernel/sched/bpf_numab.c
[ ... ]
> +static u32 numab_mode_stub(struct task_struct *p, struct folio *folio)
> +{
> +	return BPF_NUMAB_GLOBAL;
> +}

[Severity: High]
Should this stub function also include the __nullable suffix on its
arguments?

As mentioned in include/linux/bpf_numab.h, omitting the __nullable suffix
(e.g., p__nullable) prevents the verifier from recognizing the arguments as
optional. This leads to dead-code elimination of user NULL checks and a
subsequent system crash.

[ ... ]
> +u32 bpf_numab_mode(struct task_struct *p, struct folio *folio)
> +{
[ ... ]
> +	bpf_cgroup_struct_ops_foreach(ops, item, cgrp, CGROUP_NUMAB_OPS) {
> +		if (ops->numab_mode)
> +			acc |=3D ops->numab_mode(p, folio) & BPF_NUMAB_VALID_MASK;
> +	}
> +
> +	cgroup_bpf_put(cgrp);

[Severity: High]
Could dropping the cgroup BPF reference here trigger an AB-BA deadlock?

The scheduler path calls task_tick_fair() under rq->lock, which invokes
bpf_numab_mode(). Dropping the cgroup BPF reference here via
cgroup_bpf_put() can trigger queue_work() if this is the final reference
while the cgroup is being offlined.=20

queue_work() acquires pool->lock and wakes up a worker by acquiring its
pi_lock. Because standard wakeup paths acquire pi_lock before rq->lock, this
inverted rq->lock -> pool->lock -> pi_lock sequence leads to a deadlock.

Since this code is already protected by rcu_read_lock(), is the reference
counting strictly necessary here?

> +out:
> +	rcu_read_unlock();
> +	return acc;
> +}
[ ... ]
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -884,11 +884,10 @@ bool folio_can_map_prot_numa(struct folio *folio, s=
truct vm_area_struct *vma,
>  		return false;
> =20
>  	/*
> -	 * Skip scanning top tier node if normal numa
> -	 * balancing is disabled
> +	 * Skip scanning top tier memory whose owner participates in
> +	 * tiering: hinting faults on it would buy nothing.
>  	 */
> -	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
> -	    node_is_toptier(nid))
> +	if (folio_numab_mode_tiering(folio) && node_is_toptier(nid))
>  		return false;

[Severity: High]
Does this unconditionally disable NORMAL NUMA balancing on top-tier nodes
when TIERING is active?

Previously, this skipped hinting faults on top-tier nodes only if
NUMA_BALANCING_NORMAL was explicitly disabled. The new logic skips top-tier
scanning entirely if tiering is enabled.

When the global sysctl_numa_balancing_mode is 3 (both NORMAL and TIERING
enabled), folio_numab_mode_tiering() returns true. This breaks standard NUMA
page placement optimization for fast memory on tiered systems by dropping
all top-tier scanning.

> =20
>  	if (folio_use_access_time(folio))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012120438.5284=
9-1-laoar.shao@gmail.com?part=3D2
