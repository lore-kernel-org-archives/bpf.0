Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83B403E93
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780640824; cv=none; b=FM9zTsDamnQ2osnEnY5ykJwL6FypRGiWe6xlLSSazn9MwjJXKmq7BoaVS1rLryUXZd7RNTgatAtj7lVfPygAb2Dbmb73csCnbcr449gW/CJ+J2nbDtwTMY3IgkLgW5wrnTjvxHjs+nOuqH5Da9osA3WtxLUWqBQBsGlROVpCJMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780640824; c=relaxed/simple;
	bh=XTdMRW7xuzKszm4MBXFtcZ9+NxKWkyL54OfOcYA0vrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEMiYS283ckcQNHAeCBtESatfBxwVtPpmTOopuW8Kc8xRhnrWndGY9DSM5boyQ8mxRZ0JDhWuRGi0Z9N1XsKUPVIlLadAMD2YxFtMxjCVUzyK7JDKx9k5bDcjaGcEpRxht/iSdjeHhXgdXZPJfSH5YrwDpQhW5zGXlAVOH+ik8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SekQfSAX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SekQfSAX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BDF1F00893;
	Fri,  5 Jun 2026 06:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780640822;
	bh=82oF7SteqPJKLjGIvCqxjPneO9OR8LiL3IIZL4gz+R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SekQfSAXYJ77G/dsAoWpBq4nV7btqVgfes/JzQqrl9PhHg965A5u33c9RjH6iJlvr
	 wPTm+llxvDyKbuFvfG7Z7gm0miFmc+0N8BpiW5d3pDEcRJWzPrOPor4LRs9PbtwBkd
	 VF3tUpof9gY/JyPmfK4XA718saOFuTPlwYxoNElgrAc6T7xbYBWy9RzAkCuw3wiu9n
	 qsTOA8opuRK4lK6We4RDL/2L0xLieLIf0rJ/KKb6j4aTD+l1gGnHasyA6Vm4h40155
	 Rmk6XSjra3vvyShGb1w/6T5PAxJFfswMLQos7D47P2Bo1gZj5rSBTRtrZADLM+wlRq
	 x8CkOSSjN/grw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 55E89F40070;
	Fri,  5 Jun 2026 02:27:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 05 Jun 2026 02:27:01 -0400
X-ME-Sender: <xms:NWwiai-EWHEsfxcbT6HBKGstrtimgX72D73-2ZxUPDBZNqooLqPHxQ>
    <xme:NWwiagiQ5j-ped3VXH0sloZ0doCJXWnT8Y9Vicu1zF5PGUscsNuaFnG_E-NTHhfRJ
    D0wlIFbNUIjVbjpt_ocH3ipFmpGH6Lfd-Opwl-JYMTY2b3v676r0g>
X-ME-Received: <xmr:NWwiaie5M78am-yFoD1nDvmN7c6psSSu2ZI9dRSnbkGDad3HvFic2vsX3fs>
X-ME-Proxy-Cause: dmFkZTGmBpRejcFHokcxaZs/oyOYFDeu25Tilw2lGB0djfv7yRf9i5ZSk/TcsqR0f4PUvD
    xfh7Kih9gMoOeuKv9VfhkabtEPrLZMn1DUZDvx5lJTyLepRyBg8S2xE91BFG7bvVH+UY8X
    JNcaIe6woVI47iSwASiaxOH5FTXaWLQFIbCLidooXWv+hzV46P7kConPEo1Y0qRe2H+9Zz
    t12GpmjAxvWypcOdEPOiOgNf47xrZ14dXjECZ2MZuWguEe12yGG2poxoovkzaS2pOB2mb1
    Mg7W/vzW1LhzfCZWmPcUhKYdhlmJo8x7ikX8GXHPiyRfkk/0x2upuq9x6geQ6wIml3pfax
    RrkF9WpRUTebu/auELKeRVnD8DuERg/V6g4rKHCMea4x08dwkOIIimwj7q6tup3wf/pO2d
    Em764LRQT4URc5XeGcj9mEjQEqeIJj9wMybyHxgpDb9CEdJQHzYurZv96eMfccHgSVtqX7
    ElZFNTemxdObt4GzKAdbXc34etla7Y/pqDVftVdnNOLTIEIfejhtHWclgU2k+vi2svlwr9
    bH95vWlt2jPhA7LPxZNpOF6m1cZzzyeZkcZuNedis5uDa9oiIz9CPt35fcnxdHufnOA8Qp
    wofSo7q2eHO2indkT9LMN8e0xKbxtKWNo89uDZUk+z3O3xWnEWhTj4snBi7w
X-ME-Proxy: <xmx:NWwianot6bGIDr04KKXUCAVdddP2S-J0_JkmBdkZT5J3pTxuCUWE4w>
    <xmx:NWwianAMh398NfKHdqAer_1GtXf-jKrpfrgw2YjU3b1vaUfo0XLJKQ>
    <xmx:NWwiakbSGVRU2Rtsfa_aClLwgteJrs3ilnwUapnC-24gfy_8G4TC4w>
    <xmx:NWwiaq7-gzEnpJp8a_LF4TxdTdz6EEu0DjRrOqZjWPTBD5Jr_984Bw>
    <xmx:NWwialbuDN7Tbro5FwgrhbDt2_oq4kwfY8Y3gTgi21YmKn9EwvdKwJiC>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 02:27:00 -0400 (EDT)
Date: Thu, 4 Jun 2026 23:27:00 -0700
From: Boqun Feng <boqun@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, ojeda@kernel.org
Subject: Re: [PATCH v3 05/13] irq & spin_lock: Add counted interrupt
 disabling/enabling
Message-ID: <aiJsNDshrr3j0hq1@tardis-2.local>
References: <20260605054128.5925-6-boqun@kernel.org>
 <20260605060155.D562C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260605060155.D562C1F00893@smtp.kernel.org>

On Fri, Jun 05, 2026 at 06:01:55AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] local_interrupt_enable() fails to invoke deferred softirqs and re-arm hrtimers, leading to indefinite stalls.
> --
> 
> commit de449b5be29a59d42df6ee590a2de395da7bbacc
> Author: Boqun Feng <boqun@kernel.org>
> 
> irq & spin_lock: Add counted interrupt disabling/enabling
> 
> This commit introduces a new set of interrupt disabling APIs:
> local_interrupt_disable() and local_interrupt_enable(). These save the
> interrupt state to a per-cpu variable and use a per-cpu counter to track
> nesting levels, preventing accidental enablement.
> 
> Link: https://patch.msgid.link/20260121223933.1568682-6-lyude@redhat.com
> 
> > diff --git a/include/linux/interrupt_rc.h b/include/linux/interrupt_rc.h
> > new file mode 100644
> > index 0000000000000..dd4444c613307
> > --- /dev/null
> > +++ b/include/linux/interrupt_rc.h
> 
> [ ... ]
> 
> > +static inline void local_interrupt_enable(void)
> > +{
> > +	int new_count;
> > +
> > +	new_count = hardirq_disable_exit();
> > +
> > +	if ((new_count & HARDIRQ_DISABLE_MASK) == 0) {
> > +		unsigned long flags;
> > +
> > +		flags = raw_cpu_read(local_interrupt_disable_state.flags);
> > +		local_irq_restore(flags);
> > +		/*
> > +		 * TODO: re-read preempt count can be avoided, but it needs
> > +		 * should_resched() taking another parameter as the current
> > +		 * preempt count
> > +		 */
> > +#ifdef CONFIG_PREEMPTION
> > +		if (should_resched(0))
> > +			__preempt_schedule();
> > +#endif
> > +	}
> > +}
> 
> [Severity: High]
> When the hardirq disable count drops to 0 here, does this miss checking for
> deferred softirqs?
> 

Yes, but it doesn't have any behavioral difference than a
local_irq_enable(), which won't trigger deferred softirqs either.

Regards,
Boqun

> Because __irq_exit_rcu() is updated later in this patch to skip invoking
> softirqs and re-arming hrtimers if hardirq_disable_count() is non-zero, the
> responsibility appears to shift to this function. Without a check for
> local_softirq_pending() when the count reaches 0, could softirqs and hrtimers
> deferred during the vulnerable window be indefinitely stalled until the next
> hardware interrupt fires?
> 
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index 10af5ed859e73..d1ab1799794ca 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> 
> [ ... ]
> 
> > @@ -728,7 +731,16 @@ static inline void __irq_exit_rcu(void)
> >  #endif
> >  	account_hardirq_exit(current);
> >  	preempt_count_sub(HARDIRQ_OFFSET);
> > -	if (!in_interrupt() && local_softirq_pending()) {
> > +	/*
> > +	 * Interrupts may happen between hardirq_disable_enter() and
> > +	 * local_irq_save() in local_interrupt_disable(), if irq_exit() invokes
> > +	 * softirq here, we may have a softirq handler calling
> > +	 * local_interrupt_disable() but it won't disable the irq because
> > +	 * hardirq disabling count is already 1, hence we need to prevent
> > +	 * invoking softirq when a local_interrupt_disable() is ongoing.
> > +	 */
> > +	if (!in_interrupt() && !hardirq_disable_count() &&
> > +	    local_softirq_pending()) {
> >  		/*
> >  		 * If we left hrtimers unarmed, make sure to arm them now,
> >  		 * before enabling interrupts to run SoftIRQ.
> >  		 */
> > +		hrtimer_rearm_deferred();
> > +		invoke_softirq();
> > +	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260605054128.5925-1-boqun@kernel.org?part=5
