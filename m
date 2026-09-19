Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CABD2C0F7F;
	Sat, 19 Sep 2026 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789838677; cv=none; b=Vgsw74PlELy/OOeyBZX000/DGZv/ZA/IgwBlE7JEK2h9n6av1OoppyRDng5vmtq/UqhiL6VgkMHzRp8iizRnfqqCwQnPqBsB1n6uIVyfVowers1LOErjTzBfBgh4Hu5oR+QKpgpK1UDugHAOo9COwuhQtC8YtDGEcObzuMzPE0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789838677; c=relaxed/simple;
	bh=NL8V09Q6u01VhFxHqUAioylOD2cM+3iuSrQCSDc7epA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cg2YTx7FWfw2cEeGtaxZ4fgT5SrCDB48QBW4hohUaKmU5jKT1CdsaHJJmNTyuNe2urfu3eS0zd6guexjlQygYCs9PM3mJzfMXaORL4ezdCksrYbSUerqSPlBAYPizTlZCAVK3V4cJfKilQ7iLMmINrZ6O1hMqW4HVSAKfTp5JYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hh54c9Gl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh54c9Gl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78C61F000FF;
	Sat, 19 Sep 2026 17:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789838676;
	bh=yFoYUW8L5Pr3/ncIv3dUGYKBJIvbDHs5bbEy4fzn7w4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hh54c9GlK1vhCPVQ/WTqRJMamZy8T2TKlkO94ur3nmZAfGA0DHPQ4uFklAOZIjTFC
	 tJIfc3bj6ib4j/0uf+vTfHsgylYigOEEMKD9XER7c+wXTQbI8ewStjHuJ46yOuDSvB
	 ydwX3Pp330/BMAqABk+z9xiWHp74OE6DaAC8SBTFhQkJy+vlap2FC7N2tMXEr7UpLM
	 HYmWTXR+RdE8UnnYnIyE+AQRVxJWrybzduFWBqQl3wNI+OfghUNNEEvRYhijXPTPMk
	 rtbJFqOsrZ6jhCw0RdOR1h1rnGjYN+A4LOmScyhQGVs8mL5M6yWVHR9U023cnSejSf
	 /gg5dzwvZo5ZA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm: restrict can_spin_trylock() to preemptible
 context on PREEMPT_RT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260919171443.90512-1-kmehltretter@gmail.com>
References: <20260919171443.90512-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 17:24:35 +0000
Message-Id: <20260919172435.B78C61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: can_spin_trylock() uses !preemptible() causing persistent ba=
ilout
--

commit da2bda4aca43320be916d709a95e77705d7bd75f
Author: Karl Mehltretter <kmehltretter@gmail.com>

mm: restrict can_spin_trylock() to preemptible context on PREEMPT_RT

This patch resolves a deadlock on PREEMPT_RT during kmalloc_nolock() by
restricting can_spin_trylock() to preemptible contexts only. It prevents
nested lock acquisition of the pi_lock when called from sched_waking
tracepoints inside try_to_wake_up().

> diff --git a/mm/internal.h b/mm/internal.h
> --- a/mm/internal.h
> +++ b/mm/internal.h
[ ... ]
> @@ -1641,10 +1641,14 @@ static inline bool can_spin_trylock(void)
>  	 * confuse PI logic, so return immediately if called from hard IRQ or
>  	 * NMI.
>  	 *
> -	 * Note, irqs_disabled() case is ok. spin_trylock() can be called
> -	 * from raw_spin_lock_irqsave region.
> +	 * Task context with a raw spinlock held is not safe either. The
> +	 * caller may hold a pi_lock, like a BPF program on a tracepoint in
> +	 * try_to_wake_up(). rt_spin_trylock() takes the rtmutex wait_lock
> +	 * and can take a pi_lock under it. rt_spin_unlock() wakes a waiter
> +	 * if there is one, which takes a pi_lock again. The locks held by
> +	 * the caller are not known here, so allow preemptible context only.
>  	 */
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())

[Severity: Medium]
Does this !preemptible() check create a persistent bailout for ALLOC_TRYLOCK
paths on PREEMPT_RT?

BPF programs attached to non-faultable tracepoints run with preemption
disabled via guard(preempt_notrace). When they attempt to create task local
storage using kmalloc_nolock(), it calls can_spin_trylock().

Because preemption is always disabled inside the tracepoint, this check
acts as a persistent bailout rather than a transient one, unconditionally
failing the allocation on PREEMPT_RT. Will this permanently break BPF task
storage creation in tracepoints on PREEMPT_RT?

>  		return false;
> =20
>  	/* On UP, spin_trylock() always succeeds even when it is locked */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919171443.9051=
2-1-kmehltretter@gmail.com?part=3D1
