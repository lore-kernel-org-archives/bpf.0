Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9BD3A63FB
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639317; cv=none; b=AA8Bwi3VEgaLMe7dxcvXHWZ0mkvevoM9UVQIAYCLp1V6OVtLIammnK/xnatkdU326ZeqTvOyyHOhrMznbrnhg80N201lUcnG/MlSnBsqW7d6lGjm/JTS6fmlMbAKpxvB/6ASD+vNAs2JQLp7zGI5pl7Nyd3uDakAVSmLdCmm6R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639317; c=relaxed/simple;
	bh=7WfBhLBSyB7BSnLIVfzJYK7rfADXt6lQbsVs+7NwthM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gCNnYiYrbRtrtwCqvyBZXLZINJTz+Uf/Z0frSuYP8H5OsnFADOAuXNyCf/wFKaOWIvf4sRQlJe/S2jFfJAtK5EH0cyP6QE5dd2tZg/v9nyjTf0QHwCbwEIj9qT7tJfMFqfDcynxUDQG/lLmxm8Wn1c/gdNafCFv8TUbvYErtoDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIogFAbs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIogFAbs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D562C1F00893;
	Fri,  5 Jun 2026 06:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780639316;
	bh=94JmUxW974MMra4QsyUVLZreqBmKKD0Kp1tGDFZN/3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZIogFAbseFM3a5wtJWhVd6cmDlpiMIn2deTjbl8ZrAvj6zdPktkcPdG3OgN3LAm/X
	 2yoYId16XalZOPdNLwv88p1PLtI0c+Ux8LeoRQqCktuFGJEK74yUSasvU3/JDkj+Q4
	 nmFDv7Cr3gB/MImjyCzFvTA0HJnavA/Y9AdRHqlQfBRS1iyuh3hHHd92SNka19WbOO
	 zl44kROKjLXe5tQouINXANLbaJVFtiV+9+ZAIfFxKFRuwncMSpRXW9QLuzgYG8N08H
	 q7R/t2ovU3ybxNbfqfUJaVf4OSiMi7tX4v2ZZcM4tIqx9Ian7Y6vnGVLE8YEoPo3Ze
	 MdCw9gwBDcoLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/13] irq & spin_lock: Add counted interrupt
 disabling/enabling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Boqun Feng" <boqun@kernel.org>
Cc: bpf@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260605054128.5925-6-boqun@kernel.org>
References: <20260605054128.5925-6-boqun@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:01:55 +0000
Message-Id: <20260605060155.D562C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] local_interrupt_enable() fails to invoke deferred softirqs and re-=
arm hrtimers, leading to indefinite stalls.
--

commit de449b5be29a59d42df6ee590a2de395da7bbacc
Author: Boqun Feng <boqun@kernel.org>

irq & spin_lock: Add counted interrupt disabling/enabling

This commit introduces a new set of interrupt disabling APIs:
local_interrupt_disable() and local_interrupt_enable(). These save the
interrupt state to a per-cpu variable and use a per-cpu counter to track
nesting levels, preventing accidental enablement.

Link: https://patch.msgid.link/20260121223933.1568682-6-lyude@redhat.com

> diff --git a/include/linux/interrupt_rc.h b/include/linux/interrupt_rc.h
> new file mode 100644
> index 0000000000000..dd4444c613307
> --- /dev/null
> +++ b/include/linux/interrupt_rc.h

[ ... ]

> +static inline void local_interrupt_enable(void)
> +{
> +	int new_count;
> +
> +	new_count =3D hardirq_disable_exit();
> +
> +	if ((new_count & HARDIRQ_DISABLE_MASK) =3D=3D 0) {
> +		unsigned long flags;
> +
> +		flags =3D raw_cpu_read(local_interrupt_disable_state.flags);
> +		local_irq_restore(flags);
> +		/*
> +		 * TODO: re-read preempt count can be avoided, but it needs
> +		 * should_resched() taking another parameter as the current
> +		 * preempt count
> +		 */
> +#ifdef CONFIG_PREEMPTION
> +		if (should_resched(0))
> +			__preempt_schedule();
> +#endif
> +	}
> +}

[Severity: High]
When the hardirq disable count drops to 0 here, does this miss checking for
deferred softirqs?

Because __irq_exit_rcu() is updated later in this patch to skip invoking
softirqs and re-arming hrtimers if hardirq_disable_count() is non-zero, the
responsibility appears to shift to this function. Without a check for
local_softirq_pending() when the count reaches 0, could softirqs and hrtime=
rs
deferred during the vulnerable window be indefinitely stalled until the next
hardware interrupt fires?

> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 10af5ed859e73..d1ab1799794ca 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c

[ ... ]

> @@ -728,7 +731,16 @@ static inline void __irq_exit_rcu(void)
>  #endif
>  	account_hardirq_exit(current);
>  	preempt_count_sub(HARDIRQ_OFFSET);
> -	if (!in_interrupt() && local_softirq_pending()) {
> +	/*
> +	 * Interrupts may happen between hardirq_disable_enter() and
> +	 * local_irq_save() in local_interrupt_disable(), if irq_exit() invokes
> +	 * softirq here, we may have a softirq handler calling
> +	 * local_interrupt_disable() but it won't disable the irq because
> +	 * hardirq disabling count is already 1, hence we need to prevent
> +	 * invoking softirq when a local_interrupt_disable() is ongoing.
> +	 */
> +	if (!in_interrupt() && !hardirq_disable_count() &&
> +	    local_softirq_pending()) {
>  		/*
>  		 * If we left hrtimers unarmed, make sure to arm them now,
>  		 * before enabling interrupts to run SoftIRQ.
>  		 */
> +		hrtimer_rearm_deferred();
> +		invoke_softirq();
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605054128.5925=
-1-boqun@kernel.org?part=3D5
