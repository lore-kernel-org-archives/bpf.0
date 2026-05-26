Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7F74219FA
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818051; cv=none; b=Jwb54JZOHjLPp6NDkGmFzR+H1OPafddE0U/E4rMeW6iyWX3aQfto0QUACNqTR1yL2NwBxDnPg7pABgKDKHKugfP6Ao+5UOMySqdUW7uBnIRxqqfDMIAaimpzwGJ154//sHFrBBIHNjqnFdahQxGMHUmNt8maNaHalTSAlRCEn3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818051; c=relaxed/simple;
	bh=O261xfHQ+PEf+uVmnIwUmJpjinAF5/zq8NqM5NsbMsY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bZofisaXJvWB+yJcny2Kkf+ARt+3o8MoUClmdiwfHRIajs/GrVBtZiu0IgkUjxabUSH+CXahNCxTE8Gw7exf/i/LoctoH8wTQcpgcfgH9edjZYEFT7jGquuObaW+3zN8k0pZHNP5LnUivO2ynKY6Um1Gqaa+sXnRzPMy/suS21A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doA9BlEH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doA9BlEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFCC1F000E9;
	Tue, 26 May 2026 17:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779818049;
	bh=LB+xcBLJ3KDIL85FhSYp8ttGiWXOn2Qf7qfeBsBAZZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=doA9BlEHMG83jkbnqyYPaNx27Q8LqABn4KbM1FFlN/W+EFaTPb7WEXoxzeakTozgH
	 T+r0u3J6AFQeDKhz/yWrMA2UrAyFh0D+6QV/HJbaQbWaM4UDcOT8rjCZ7IRoPw77A3
	 TZKxnp/2GTHvpb+PY6vmN3eX/iDcJUhYtGicn4TZBl39wmMI01/Hln5c6A8zAzQapV
	 FYE0pn3JnsjYHb1h/odZd67su2/7MSv3KjgPH3m5YrDJlOP9Q6TNjFB7WqxnAi634N
	 O5Sl/50syV8C2ii5QFXX2WK6yZnHiv99cB4kKrc7JdEsN8veiveryNHw7MikU8Mvhl
	 rDpNEPsFqyarA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/12] irq & spin_lock: Add counted interrupt
 disabling/enabling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Boqun Feng" <boqun@kernel.org>
Cc: ojeda@kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260526152148.30514-6-boqun@kernel.org>
References: <20260526152148.30514-6-boqun@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 17:54:08 +0000
Message-Id: <20260526175409.7CFCC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] An NMI occurring inside local_interrupt_enable() corrupts the =
per-CPU saved IRQ flags, leading to permanently disabled hardware interrupt=
s.
- [High] Skipping softirq processing in `__irq_exit_rcu()` without re-trigg=
ering it in `local_interrupt_enable()` leads to indefinite softirq starvati=
on.
--

commit 2a089d1e2525d387b14ef2c6eb7f3576f07d6bc4
Author: Boqun Feng <boqun@kernel.org>

irq & spin_lock: Add counted interrupt disabling/enabling

This commit introduces new local interrupt disabling APIs that use a per-CPU
counter to support nesting. This avoids accidental early interrupt enabling
when locks are nested or used with guard facilities.

Link: https://patch.msgid.link/20260121223933.1568682-6-lyude@redhat.com

> diff --git a/include/linux/interrupt_rc.h b/include/linux/interrupt_rc.h
> new file mode 100644
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

[Severity: Critical]
Can the per-CPU saved IRQ flags be corrupted if an NMI occurs here?

After hardirq_disable_exit() decrements the count to zero, but before the
saved flags are read, there is an unprotected window. If an NMI fires in
this window, the interrupted thread's count is 0 but its hardware IRQs are
still disabled.

If the NMI handler or a function it calls uses local_interrupt_disable() or
spin_lock_irq_disable(), it will see the count is 0, assume it is the
outermost caller, and overwrite the per-CPU flags with its own IRQ state.

Since hardware IRQs were disabled when the NMI hit, the saved flags will
reflect disabled IRQs. When the NMI returns, the interrupted thread reads
these corrupted per-CPU flags and passes them to local_irq_restore(),
which would permanently disable hardware interrupts on that CPU.

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

[ ... ]
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

[Severity: High]
Does skipping softirq processing here lead to indefinite softirq starvation?

By skipping invoke_softirq() when hardirq_disable_count() > 0, any scheduled
softirqs (such as timers, RCU callbacks, or networking) are left pending.

When the critical section ends, local_interrupt_enable() decrements the
count and re-enables hardware interrupts, but it does not check
local_softirq_pending() to flush these deferred softirqs.

Will these pending softirqs stall indefinitely until another, unrelated
hardware interrupt fires, potentially causing RCU stalls or network hangs
in low-activity periods?

>  		/*
>  		 * If we left hrtimers unarmed, make sure to arm them now,
>  		 * before enabling interrupts to run SoftIRQ.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526152148.3051=
4-1-boqun@kernel.org?part=3D5
