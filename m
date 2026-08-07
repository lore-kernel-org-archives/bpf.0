Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9454A41F7FD;
	Fri,  7 Aug 2026 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114731; cv=none; b=SyMwNMdk2iK/LaRq7fMUkoC3aDiMckWx24O+mCPMDdW/1XKvnAiMmzdMYhX/ZxvBxIRJjmxQecRJaD8l/O4rVuq/dop/N2oF39OcSSy6vHCkUTHGK9JVoyOwOm+zkN60iMBe66zP/EymAymjSxqdEjaRljRfwLtw7G0wYr82hyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114731; c=relaxed/simple;
	bh=GOkL4WVmlpJVZBVSr4EsdT2xUAyeSo3VRCx5HWus2z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdQy6Sm8a+nBatC347BfK1kx4myC9XvnQB5qETmHltUGdG9Hpi2vqNOgxjZdyn7R3pf0a5RVMXeP+c1yoKaeQ3K6QaPNv/61SOftR2GBvLT3oXNptQxoP4c8sOU3PWYQd8fgB+odRd0Eu5d+9ddFFbTN1Y9qZuhe8OwYarEi2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Jnal31Jt; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Jnal31Jt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vPaFLVPwMZ2tc6ueMFHHrqc2KtEDFinSge5uqs3yEHM=; b=Jnal31JtehGp27yZ/WmdwAmRjW
	C+2PEuQUfImj83GQ6mHDyopLL+2o5054MBkzZN88qnPDHfJUHqmN9GtxtvR4XPt10zIHdJ1GfVVIg
	gTRK5z4Z6wQ7FY3ay3PqKvTwvgMzMom6TAhmf9bG1qU4GXpykWMXl1JSAK6UWPW1opHHVHYu4kGVk
	XPitbuN06bhSM73p2KgNpw6A8GMnAyb1PL3st3R3p40KMDrJ3s4x1c9bSI0u3rVtN6z92tRY3Scdf
	Q3c1rnme/7wu8TFnI/48KfOBID1SMCWoGpQRk95Wp0q0KhH0UvBD2s8VFuUQJ3AXoFMDw1Vvkvc2f
	vZEYG+ZQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wsM1i-000VXB-2i;
	Fri, 07 Aug 2026 14:58:27 +0000
Date: Fri, 7 Aug 2026 07:58:21 -0700
From: Breno Leitao <leitao@debian.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, rmikey@meta.com, kernel-team@meta.com, 
	Vladimir Murzin <vladimir.murzin@arm.com>, Ada Couprie Diaz <ada.coupriediaz@arm.com>
Subject: Re: [PATCH RFC] arm64: entry: PSTATE_I_SET is leaking on pseudo NMI
 mode
Message-ID: <anXqMsJ14r3BAbMG@gmail.com>
References: <20260807-arm64_fix-v1-1-d069ccf9d71b@debian.org>
 <anXkO8YpoadRzm07@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anXkO8YpoadRzm07@J2N7QTR9R3>
X-Debian-User: leitao

On Fri, Aug 07, 2026 at 02:57:15PM +0100, Mark Rutland wrote:
> Hi Breno,
> 
> On Fri, Aug 07, 2026 at 04:45:31AM -0700, Breno Leitao wrote:
> > This is my understand of the current situation:
> > 
> > A) A task enters the kernel via a syscall.
> > 	* PSTATE_I_SET becomes set on the live PMR
> > 	* regs->PMR doesn't have PSR_I_SET set
> 
> At this point, regs->pmr will be the value of PMR when we were executing
> in userspace, which should be the value of regs->pmr the last time we
> returned to userspace. That should be GIC_PRIO_IRQON, as configured by
> start_thread_common().
> 
> The entry asm will set PMR to 'GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET', but
> that should be reset to GIC_PRIO_IRQON when el0_svc() calls
> local_daif_restore(DAIF_PROCCTX).
> 
> Within invoke_syscall(), we should have DAIF==0 and PMR==GIC_PRIO_IRQON.

local_daif_restore() keeps GIC_PRIO_PSR_I_SET on aborts, which is not
the case here.

so, as you said, GIC_PRIO_PSR_I_SET is set in PMR and then cleared in
local_daif_restore().

> > B) A BRK fires at EL1 and that is what leaves the live PMR
> >    with PSR_I_SET.
> > 	* At this stage PSTATE_I_SET is set on both on PMR and regs->PMR
> 
> The value in the regs->pmr should be GIC_PRIO_IRQON, without
> GIC_PRIO_PSR_I_SET.
> 
> As we don't unmask anything during BRK handling, the live PMR should
> contain 'GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET'.

Right, that was my reading as well.

> > C) A nested synchronous exception happens (Not sure why -- BPF related)
> > 	* Now both the live PMR and regs->pmr have PSR_I_SET.
> 
> The presence of 'el1_abort()' in the trace suggests that BPF tried to
> access memory which faulted. That looks to be a result of
> bpf_probe_read_kernel() and copy_from_kernel_nofault().
> 
> Regardless of BPF, we can probably trigger a synchronous exception with
> a WARN() or similar, so we will need to handle synchronous exceptions
> from the same contexts.

I think I can find a reproducer for us, give me a few hours.

> > I am not certain that we want to have PSTATE_I_SET ever be sent to
> > regs->pstate. Do we ever need PSTATE_I_SET in regs->pstate?
> 
> I'm not sure what you mean here. PSTATE_I_SET doesn't exist, and I'm not
> sure whether you're asking about the PSTATE.DAIF bits saved in
> regs->pstate, or the PMR value in regs->pmr.

Sorry, I meant PSTATE_I_SET. 

> Regardless of pseudo-NMI, is is essential that regs->pstate holds a
> complete snapshot of SPSR, including the I bit.
> 
> With pseudo-NMI, it is essential that the full PMR value (including
> GIC_PRIO_PSR_I_SET) is saved into regs->pmr.

For the live PMR register I follow it now: arch_local_save_flags()
returns the PMR and nothing there looks at PSTATE, so a context masked
by PSTATE.I has to advertise that in the PMR or irqs_disabled() lies.

What I don't follow is the saved copy. regs_irqs_disabled() already
consults both halves:

      return (regs->pstate & PSR_I_BIT) || !irqs_priority_unmasked(regs);

so GIC_PRIO_PSR_I_SET in regs->pmr looks redundant for anything querying
the frame.

That matters for the warning, because local_daif_inherit() reloading the
entry-time 'GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET' is what puts 0xf0 in
the live PMR before the handler body runs.

Meanwhile, I will try to ftrace the writes to PMR and regs->pmr to get
a better grasp of the states machine we are in (probably on Monday).

Thanks for the answers so far,
--breno
