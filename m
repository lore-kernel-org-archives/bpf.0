Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416208;
	b=D/xAQfX1cjJhk2OKJmQfLRh5ij8gCWU7ivSnd9xTH1kg2Zv768D9NoC0AJV5vKUJmJIU
	 u6DyoA/ITkpn+3Wlx6j3QX47FfX1vRDeCL8mMibfDdxLOX7FSkizTbirBfUUmIPepqhfd
	 TxW6eiN0fjfDOD4HRE412R3JDpYmR/AT59wcK1OIyCHONWmmlojmdAdOnlVsqaHGDqzzA
	 46hF3PJL399Wz9IbQzz5csA1AMoM4nxhWgo6ITvmEs8Uc41AQhC7jamXa81pxlJs/FQnX
	 FTotRzOn/dc2aMaLwyhXorJFb/P/Dv6Je2oa8mdl/gOuMCSWLVmP7rDBkFpmxBq8sZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416208;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=479XHjyry+esrWGEqWJa1TbMqWU4kn9HwykCDUTXvDw=;
	b=htsbjh8Ukz63eG3ESryT3KVcAvru3RDcDf+5NjcIn6zIJmD+6NZkzuZ8eNFEu9XfijGd
	 1QuQXP63TR4ucU7Tk1DWENSfFFH+Sdi1xMnG6PhOZ4vJ2UdvBJo4eSHmSHlfuCCOQYxHl
	 2vqLv9pff3pQIq29zn6PrX+EJOhEcwg7WTdD1Tg0EyP0PCyweveptYaIGaK/RYES4odC7
	 RIgr2DxZqZJexlLaBafUZjrcPlM9WwWltNTrII8GAcM49s5+/jylEcuhDY+mnGLJ3hRmu
	 JOoj3MutUXrPedJhGgndi6vOYp8KY20NHQkKIa4tXgC8KgdhJ88unZQ4SlUymVQMm/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=utPeEWqs;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE708606A89C;
	Wed, 11 Nov 2026 16:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE708606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=utPeEWqs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=479XHjyry+esrWGEqWJa1TbMqWU4kn9HwykCDUTXvDw=; b=utPeEWqsu11ZRvRHShfJxKmH3b
	tsE+6dt9AXJKTWJBZDrEyUT2DFK9S8j+8tdtBVEqneXY40w6dkQeHnQ6iLsfCfaodm1Uc7upFM8xb
	JRzM10Wr/jXLi8cNqMDkhA0Cfp2jMm4H+dmAHXj8f1rDxtM0NXRK57f4fr6Umvq89sl0Wk1FaJNHE
	7dwaSw9Qh7ZVmQ6v7niM/njBzEFo2DLpIKnNEX5GQy9qcKe24eflIxpFbj2uAWkKX31s3vZ4p+HAV
	lQV7fXFXCNcBULuVbGMGt8faW2RsSMWbaHiHaiO+peQGlnHu+Ru+a0+laalqDLEPr/wAdLXs5oQv8
	qmaDGJDw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRBcn-0000000BhFe-2jRA;
	Wed, 11 Nov 2026 16:56:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A9661303154; Wed, 11 Nov 2026 17:56:40 +0100 (CET)
Date: Wed, 11 Nov 2026 17:56:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Radu Toader <radu.m.toader@gmail.com>, mingo@redhat.com,
	tglx@kernel.org, tglx@linutronix.de, tj@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	anna-maria@linutronix.de, bigeasy@linutronix.de, joshdon@google.com,
	haoluo@google.com, brho@google.com, boqun@kernel.org,
	joelagnelf@nvidia.com, enlin.mu@linux.dev, brads@mainlining.org,
	kmehltretter@gmail.com, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] softirq: Treat an interrupted idle task as idle in
 tick_irq_exit()
Message-ID: <20261111165640.GQ1779021@noisy.programming.kicks-ass.net>
References: <20261111112944.3868822-1-radu.m.toader@gmail.com>
 <avSTjihu0YXfFNUV@localhost.localdomain>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avSTjihu0YXfFNUV@localhost.localdomain>

On Wed, Nov 11, 2026 at 05:10:54PM +0100, Frederic Weisbecker wrote:

> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index 7fc2200392cd..e7d649c29c0c 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -738,8 +738,16 @@ static inline void tick_irq_exit(void)
> >  #ifdef CONFIG_NO_HZ_COMMON
> >  	int cpu = smp_processor_id();
> >  
> > -	/* Make sure that timer wheel updates are propagated */
> > -	if ((sched_core_idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
> > +	/*
> > +	 * Make sure that timer wheel updates are propagated. An interrupted
> > +	 * idle loop counts as idle even with runnable tasks queued on the
> > +	 * CPU: forced idle under core scheduling, and the tasks sched_ext
> > +	 * keeps on a CPU's run queue while its BPF scheduler holds them back.
> > +	 * idle_cpu() would skip the idle bookkeeping of tick_nohz_irq_exit()
> > +	 * for those, and with an unstable sched_clock the CPU's clock then
> > +	 * isn't resynchronized when it leaves the idle loop.
> > +	 */
> > +	if ((is_idle_task(current) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
> >  		if (hardirq_count() == HARDIRQ_OFFSET)
> >  			tick_nohz_irq_exit();
> 
> Works for me, but Peter might find something I haven't.
> 
> Acked-by: Frederic Weisbecker <frederic@kernel.org>

I looked at the previous version and didn't spot anything more than a
case missed in the verbiage passed around as Changelog. I think I'll
queue this thing, its simple enough, ableit the changelog is a chore to
read.
