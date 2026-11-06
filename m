Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793960604;
	b=2XMg877nE3SCF7g+R/zdqc2CuaUm2XlsJKHlXNdHWS8wJuOXktjVebm+L8rAS2T18asy
	 jxWEUUFJQ4//yrKwn3MhzHau/SEqGmLhBLm1QsQiAYmkgoFTn/JskgFrHaP5vF3o7Hr5S
	 lt+qvh8HXCQvhYhvxOtHRQ8xZrixPjsdmYQAd3MgjHzyrrrGDcfLtncXodz+40X6v1KE3
	 /ELX+HNoz6eC/iezlRO+jTAHI98IBQQzCaZPw778AjGQ2doFB29z74s/THgilhTAn3JLs
	 qaIQHY4y4HB4m+iL4uXq9XuD020pgFwhbqShqtYBIrD4X7/TEHykGZVx+Ypzmd0Qvsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960604;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=QHkhU6EAbsXZ7AmpzBxQowBOt1s29rJkgVkoU0SR6nU=;
	b=wESRSZJuChzSo77R1gTxrU74ABAnr7PgWCsx6JSa5FqlP2C6SBeizKcuWrzEwwMRNs/B
	 3r7482eoUchHEpHAhLE5n5qT4njwwb+u40uTRRHKvRHgr3UPlQ9W1jDmT/a4suS1B6tM9
	 andW1jqfAQ5WUSBKQxXYwonqsoMSRst/KAZqoFKdbn09pgGgSF0oRHikF4IOIFmsukY6s
	 9tQZAD7zNpzMZ8LRcCsa5rJcnTjK+8+UTjN6QK3Fv/pjg1UKnr91yN7McNItRHTQ7dESO
	 HinDFm9V08wHDatIQ5eKR5rH+f2RYDeAVfGV+CDDtsl8xBO7n95WMgOgXi6PY7F2MTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZLsRLZ1a;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69D1606A338;
	Fri,  6 Nov 2026 10:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D69D1606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZLsRLZ1a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QHkhU6EAbsXZ7AmpzBxQowBOt1s29rJkgVkoU0SR6nU=; b=ZLsRLZ1anrIEDdWGhjYpyiK/iA
	stiWlqIgtpykOSg/npvsMMEIWcrCsa49WAM+yVP5PYTni4AknOTHqSawa3r5C+44t5RcAUHC5vpZU
	AHiHu493j0GqAQthcdJD7NwUvVDpel+omqbTqYdpwFUDpLXP9CwdRTOYOeaH/Zc8FSVBUtMg8HH0L
	YbnL4o7xqEonndZFs+xIXKH41ZFQkbRim8n8g7l/3HxsWkiuURdkb+ParIWs66c5yGIyeqqFr1oUA
	ScY0y7POJHlXOZATAM3cpj9L1k4aATiEQwXWyUXleyzWsgM/m6ErdiwHhpAP8fIEW+KamYr3TWw4A
	Wa4GkOHA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPH6K-00000002wMm-1vAL;
	Fri, 06 Nov 2026 10:23:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 664C0300302; Fri, 06 Nov 2026 11:23:15 +0100 (CET)
Date: Fri, 6 Nov 2026 11:23:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Radu Toader <radu.m.toader@gmail.com>
Cc: mingo@redhat.com, tj@kernel.org, tglx@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, frederic@kernel.org,
	anna-maria@linutronix.de, bigeasy@linutronix.de, joshdon@google.com,
	haoluo@google.com, brho@google.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] softirq: Treat an interrupted idle task as idle in
 tick_irq_exit()
Message-ID: <20261106102315.GT1813469@noisy.programming.kicks-ass.net>
References: <20261106094343.174905-1-radu.m.toader@gmail.com>
 <20261106094343.174905-3-radu.m.toader@gmail.com>
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
In-Reply-To: <20261106094343.174905-3-radu.m.toader@gmail.com>

On Fri, Nov 06, 2026 at 09:43:43AM +0000, Radu Toader wrote:
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 7fc2200392cd..e7d649c29c0c 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -738,8 +738,16 @@ static inline void tick_irq_exit(void)
>  #ifdef CONFIG_NO_HZ_COMMON
>  	int cpu = smp_processor_id();
>  
> +	/*
> +	 * Make sure that timer wheel updates are propagated. An interrupted
> +	 * idle loop counts as idle even with runnable tasks queued on the
> +	 * CPU: forced idle under core scheduling, and the tasks sched_ext
> +	 * keeps on a CPU's run queue while its BPF scheduler holds them back.
> +	 * idle_cpu() would skip the idle bookkeeping of tick_nohz_irq_exit()
> +	 * for those, and with an unstable sched_clock the CPU's clock then
> +	 * isn't resynchronized when it leaves the idle loop.
> +	 */
> +	if ((is_idle_task(current) && !need_resched()) || tick_nohz_full_cpu(cpu)) {

So is_idle_task() is also true for idle-injection tasks. I *think* that
is also right in this case, but it wasn't mentioned.

That is, we can have tasks that are not rq->idle for which
is_idle_task()/PF_IDLE is true, those tasks will also 'run' an idle
state, see play_idle_precise() and its users.

>  		if (hardirq_count() == HARDIRQ_OFFSET)
>  			tick_nohz_irq_exit();
>  	}
> -- 
> 2.43.0
> 
