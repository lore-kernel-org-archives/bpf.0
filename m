Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B723183F;
	Sat, 15 Aug 2026 02:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761300; cv=none; b=mwD4KrWqw5U7AHjRwx3Pdl2bbAdyZCMjiMHTWPaeL2D726GwJEm//4NwgQd8ioKKjFmBRD1An+SwM3hlustIN1mcbQWcrg140iv4gJIp+jXSwOdMo/ng5WovRp6jX3PZu0WU/E+upAQaMKqyR+R+pYYNqb51iPDb8XGRUaz4tc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761300; c=relaxed/simple;
	bh=v9kZ4DiFfItfbLFq88oGrFDpMIcFv/d9OlIR32lh3w0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eqHNLhqDrJZhgrb5lzlQpKKkkqsQ5aevO+OoUc+wQ26rIbfleNxqi01bn0n64fWEGg3fGeVPhLjIe9oF+HHU3iTW23Rpmjj+IHw50rKeNhZTcxnvEnNXy8fcQrxCTZAPfxdKguFIZcB8Qd0m/KS/gqD6ri5YE0RX5HeO4Vyo+LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJtZPqs6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJtZPqs6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97F81F000E9;
	Sat, 15 Aug 2026 02:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761299;
	bh=ojtnXO4HxWnJ+nvelfGCYuXGtfKg/7nwMLhEgUFTNgg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nJtZPqs60/tWStPFwYb0TseFccm0vY77vx7oiSSOQBZ8py6K+2mh8VRr0e8FC3nqr
	 x3THss/sXuljYQgikvS+t8Vzrf/MB9xE4jJfneHqVSOSVkVRR+nrGT3xoJFERycPeV
	 bAtgtCssrhFZ3FxfrOGr0HeTB5SGfBE2dpyytJwyR7efxoYAk4FptT0/OTmpK5F32E
	 Hv5nCOr8sqSJVSA4aYv/mxYaP+TxVekRDqiyprmNq5V2AygjSaXs9iU4D5SUZEVwcB
	 A1KasbuNeS6autMoh4mis4mcgXB35+Xs1/O9A3hSjfw85Kht3Jttgt6W+Mt2Y+1/AX
	 xXkDNkTd3LXKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] sched_ext: Don't BUG_ON a destroyed DSQ in
 process_deferred_reenq_users
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260815022017.3305427-1-cui.tao@linux.dev>
References: <20260815022017.3305427-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 02:34:58 +0000
Message-Id: <20260815023458.C97F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Lockless double-read of `dsq->id` creates a Time-Of-Check to Time-=
Of-Use (TOCTOU) race that can still falsely trigger the `BUG_ON`, crashing =
the kernel.

Pre-existing issues:
- [Critical] Dereferencing `dsq->id` in `process_deferred_reenq_users()` ca=
uses a Use-After-Free because an RCU grace period can complete while the ta=
rget CPU is idle, freeing `dsq` before it is accessed.
--

--- Patch [1]: [PATCH v2] sched_ext: Don't BUG_ON a destroyed DSQ in proces=
s_deferred_reenq_users ---
commit f1934b9161ead6ceeb2cb6d00c64a01e1a233104
Author: Tao Cui <cuitao@kylinos.cn>

sched_ext: Don't BUG_ON a destroyed DSQ in process_deferred_reenq_users

This commit attempts to fix a BUG_ON triggered when process_deferred_reenq_=
users()
encounters a destroyed DSQ. It adds a check to skip processing if the DSQ I=
D=20
has been set to SCX_DSQ_INVALID.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 18183062f751c..1a059e5f09e80 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -4332,6 +4332,10 @@ static void process_deferred_reenq_users(struct rq=
 *rq)
>  		/* see schedule_dsq_reenq() */
>  		smp_mb();
> =20
> +		/* destroy_dsq() may have raced and invalidated @dsq, nothing to reenq=
 */

[Severity: Critical]
This is a pre-existing issue, but does dereferencing dsq->id here outside of
the rq->scx.deferred_reenq_lock critical section expose the pointer to a
concurrent kfree() in the RCU teardown path?

If CPU B is idle (in an RCU Extended Quiescent State), and CPU A queues a
deferred reenq for a DSQ to CPU B and calls destroy_dsq(), the RCU grace
period can end immediately without waiting for CPU B. The RCU callback
free_dsq_rcufn then runs on CPU C and calls exit_dsq().

Concurrently, if CPU B wakes up, enters process_deferred_reenq_users(),
removes dru from the list, and drops the lock:

CPU B:
scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
	...
	list_del_init(&dru->node);
}
// CPU B is now at the dsq->id check

CPU C's exit_dsq() then evaluates the list without locks:

CPU C:
exit_dsq() {
	...
	if (WARN_ON_ONCE(!list_empty(&dru->node))) {
		// Skips lock because list is empty
	}
	...
	kfree(dsq);
}

Would CPU B then read from the freed dsq memory when checking dsq->id?

> +		if (unlikely(dsq->id =3D=3D SCX_DSQ_INVALID))
> +			continue;
> +
>  		BUG_ON(dsq->id & SCX_DSQ_FLAG_BUILTIN);

[Severity: High]
Because dsq->id is accessed twice consecutively without READ_ONCE(), can
the compiler emit two separate memory loads?

If a concurrent destroy_dsq() sets dsq->id =3D SCX_DSQ_INVALID exactly
between the two loads, the first load would see a valid user DSQ ID and
bypass the continue. The second load would then observe SCX_DSQ_INVALID.

Since SCX_DSQ_INVALID evaluates to true for SCX_DSQ_FLAG_BUILTIN,
wouldn't this still trigger the BUG_ON?

>  		reenq_user(rq, dsq, reenq_flags);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815022017.3305=
427-1-cui.tao@linux.dev?part=3D1
