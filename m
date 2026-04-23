Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2D6495E5
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776938451; cv=none; b=ADz2kPAxMy03dl+89zSN3dURidVGOixSQY3raff/zswjLX29DDsn64jfoK6SFaIV2VBtMq1lhB5V3Rn9VOaMQBKrMJfXO23NhkdPoAsLX8gYqJDF7JTj3VQNGESbr2g6f1SYKwDn5nWX74ny4cT7AkF12QVcPksuIfIFQ+FEhTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776938451; c=relaxed/simple;
	bh=6YSRFx/xLUfwsStb1hOKtfHOIBZE0clVGW0Gy0xvhGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekZjOm2qt0JeNSM3fXm7sXW8hIG9Jdv8/vF0MqM8l8nppiqgY/HatlcKQ4sZ4NzcLU9N2jNhtMEXfQlX+Vyf4sjwVLX2iNtRWf/7PbDNkzJhnYLFcfs3lqn2kCvFdN+a9O1loNNGdY68a8V1czR8sh5VWOTV3/WeIveAQ7m6e0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rJpsT7o0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rJpsT7o0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1sRmxUIkJG+hj/Rc5f5WwbTnwNnoECnWRHUdSGe3FhU=; b=rJpsT7o0J5kdc/DUwJ39RpXrLq
	DLbQf618Xevm+wxJdFXWHAEr+7uk+CM0x9VJNsogIdBK+PjzUXGaPsaLw8EprQxuye9EOyMZc4xGs
	iiz9gR2h3RK03YV12A14k0BklcisilrhwPQrvGqGhu2ltFczKuoD7BQ37bVAt7BgjMypfam73DnOm
	wKZtNEhgYO5ITm3POnu7sJ29hrp11P2oQuXMysQYnq21DUOwSoRkOzQ9mhTmU9gAVIkyHX35odzqp
	fnX9x7CNP3K0wvpR20cZZ66w7nVmXSw/b0H7K3P2GXRQYnPD5eS+FRZSJobA0LAyXL3vXt4v1UCDc
	gB+LR5nA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFqrS-0000000DE0Y-2COT;
	Thu, 23 Apr 2026 10:00:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1B0CD300BD2; Thu, 23 Apr 2026 12:00:42 +0200 (CEST)
Date: Thu, 23 Apr 2026 12:00:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com,
	memxor@gmail.com, rostedt@goodmis.org,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v11 2/6] bpf: Add bpf_prog_run_array_sleepable()
Message-ID: <20260423100042.GC3126523@noisy.programming.kicks-ass.net>
References: <20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com>
 <20260421-sleepable_tracepoints-v11-2-d8ff138d6f05@meta.com>
 <DHZ4I3RWVVCU.16XRZX1HPFI8K@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHZ4I3RWVVCU.16XRZX1HPFI8K@gmail.com>

On Tue, Apr 21, 2026 at 01:42:25PM -0700, Alexei Starovoitov wrote:
> > +static __always_inline u32
> > +bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
> > +			     const void *ctx, bpf_prog_run_fn run_prog)
> > +{
> > +	const struct bpf_prog_array_item *item;
> > +	struct bpf_prog *prog;
> > +	struct bpf_run_ctx *old_run_ctx;
> > +	struct bpf_trace_run_ctx run_ctx;
> > +	u32 ret = 1;
> > +
> > +	might_fault();
> > +	RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock held");
> 
> The only caller of this function is in the next patch trace_call_bpf_faultable()
> that does 
> +	might_fault();
> +	guard(rcu_tasks_trace)();
> 
> imo above two lines are redunant.
> We can defensive programming when another caller appears.
> 
> > +
> > +	if (unlikely(!array))
> > +		return ret;
> > +
> > +	migrate_disable();
> > +
> > +	run_ctx.is_uprobe = false;
> > +
> > +	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> > +	item = &array->items[0];
> > +	while ((prog = READ_ONCE(item->prog))) {
> > +		/* Skip dummy_bpf_prog placeholder (len == 0) */
> > +		if (unlikely(!prog->len)) {
> > +			item++;
> > +			continue;
> > +		}
> > +
> > +		if (!prog->sleepable)
> > +			rcu_read_lock();
> > +
> > +		if (unlikely(!bpf_prog_get_recursion_context(prog))) {
> > +			bpf_prog_inc_misses_counter(prog);
> > +			bpf_prog_put_recursion_context(prog);
> > +			if (!prog->sleepable)
> > +				rcu_read_unlock();
> 
> Why grab rcu_read_lock() and undo it?
> imo it would be cleaner and faster to do 
> bpf_prog_get_recursion_context() here ...
> 
> > +			item++;
> > +			continue;
> > +		}
> > +
> > +		run_ctx.bpf_cookie = item->bpf_cookie;
> > +		ret &= run_prog(prog, ctx);
> 
> ... and then here:
> if (!prog->sleepable) {
>   guard(rcu)();
>   ret &= run_prog(prog, ctx);
> } else {
>   ret &= run_prog(prog, ctx);
> }

Right, but the whole thing is called bpf_prog_run_array_sleepable(), why
are we doing silly things like this instead of hard assuming things
are sleepable and calling it a day?
