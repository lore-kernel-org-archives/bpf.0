Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14DF425CEE
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554647; cv=none; b=VJvAMUMbmD3m9kccPJVbOUeSJeC/oYrOio3PVZUqj7Re7JLz3Aq3yvyodfLAwJPSDfYu3TqfsSGftdB/Pr0tY1WGQhMQdVd7etpl7/MnT+3RUnLsnMqt+YhJ8ml6+n+ZFslIgnx1FAb0PNBy07QTQoou0I/mYRnY+D8q2v9DV5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554647; c=relaxed/simple;
	bh=nNU348KDnizm40Hn8c1pbPoLWDHjeLSKeTa4mOhVOMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SLA++oWv8L6inYz4KCuhbWNr78AwXWZMRT/GbyH/Jk57UjpZ7haPW6D3cwbip/B851/rKZfu9qVNtutnnsW+TU4K9x+BI/NbZul/4S3ZrkWeNAWMzbBUbUHnV3aFLcdfDUbcf2jVR5qTsiZHwrm9EhTKi9igd6IpSfN3LZKusnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9gHhTvK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9gHhTvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1CB1F000E9;
	Mon, 20 Jul 2026 13:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784554645;
	bh=lvSE5NCvnMQxN8GVJI0sx6evNYGAgYs/OyjF4rDqqAU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T9gHhTvKBexOHgU2sUqLFFY2mQCLlJ4/MLGWlqgTB/yS/JRAws2gEEZlddZJvguhZ
	 panASJxNzzYH3AALYNIm3QtzqE7Leorhgx1zU0fVmh4X6j8PgFA9c/dyq5jbnoPnYp
	 uIL96bSggAoO4RPbM1JMDvBBj4i/xQfiZlYKbZdr5ncjk9NCG+P+S0pavcswbJ6PAG
	 uqrEf02ifuMVCpancoG4catLhUYvHDnHWnOjlLokrXNrdTYgqAyAvDIR40PzS8GGZg
	 EVWs9yw/4DbXIfthNDVaGZUVWQll7/iLQRoDKpsCtV10JmD0+lUei8XnnnrPJpq32o
	 lZF3JBtFTRs8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/kmemleak: report RCU-tasks quiescent states during
 the scan
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org>
References: <20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 13:37:25 +0000
Message-Id: <20260720133725.9C1CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix: Tasks RCU stalls persist in __kmemleak_do_cleanup(=
) and __kmemleak_scan().
- [High] Unbounded RCU critical section in kmemleak_clear() stalls Normal R=
CU.
--

--- Patch [1]: [PATCH] mm/kmemleak: report RCU-tasks quiescent states durin=
g the scan ---
commit 558fef0ac4a016de42546b6d38536df76b835edb
Author: Breno Leitao <leitao@debian.org>

mm/kmemleak: report RCU-tasks quiescent states during the scan

This patch replaces cond_resched() with cond_resched_tasks_rcu_qs() at vari=
ous
reschedule points during the kmemleak scan. This aims to report Tasks RCU
quiescent states and prevent Tasks RCU stalls and hung tasks, since
cond_resched() by itself is not a Tasks RCU quiescent state.

> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 85f18b17e79c4..f63dfacee7ca1 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
[ ... ]
> @@ -1708,7 +1708,7 @@ static void kmemleak_cond_resched(struct kmemleak_o=
bject *object)
>  	raw_spin_unlock_irq(&kmemleak_lock);
> =20
>  	rcu_read_unlock();
> -	cond_resched();
> +	cond_resched_tasks_rcu_qs();
>  	rcu_read_lock();
> =20
>  	raw_spin_lock_irq(&kmemleak_lock);

[Severity: High]
This is a pre-existing issue, but modifying kmemleak_cond_resched() here
might not fully resolve the Tasks RCU stall.

kmemleak_cond_resched() is only called in __kmemleak_scan() when
need_resched() is true:

	if (need_resched())
		kmemleak_cond_resched(object);

Since Tasks RCU does not actively set the need_resched flag on running tasks
(unlike normal RCU, which uses inter-processor interrupts during a stall),
need_resched() could remain false on an otherwise idle system.

Does this mean the Tasks RCU quiescent state update is never reached,
bypassing this new logic and leaving the stall bug intact?

[ ... ]

[Severity: High]
Additionally, this is a pre-existing issue, but does __kmemleak_do_cleanup()
need a similar fix?

It still uses the bare cond_resched() in its loop:

mm/kmemleak.c:__kmemleak_do_cleanup() {
	list_for_each_entry_safe(object, tmp, &object_list, object_list) {
		...
		/* Call cond_resched() once per 64 iterations to avoid soft lockup */
		if (!(++cnt & 0x3f))
			cond_resched();
	}
}

Will this cause Tasks RCU grace periods to stall during cleanup work, just
like they were stalling during the scan?

[Severity: High]
This is another pre-existing issue, but can the unyielding loop in
kmemleak_clear() stall normal RCU?

When a privileged user writes 'clear' to /sys/kernel/debug/kmemleak, it
invokes kmemleak_clear(), which iterates over the entire object_list:

mm/kmemleak.c:kmemleak_clear() {
	rcu_read_lock();
	list_for_each_entry_rcu(object, &object_list, object_list) {
		raw_spin_lock_irq(&object->lock);
		...
		raw_spin_unlock_irq(&object->lock);
	}
	rcu_read_unlock();
}

Since this loop runs fully inside an RCU read-side critical section with no
yielding mechanisms whatsoever, could iterating millions of objects
uninterrupted exceed the 21-second RCU stall timeout and trigger normal
RCU stall warnings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-kmemleak_r=
cu_task-v1-1-5b460ade777d@debian.org?part=3D1
