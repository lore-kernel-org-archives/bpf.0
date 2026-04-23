Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F3936BCE8
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776938365; cv=none; b=fhwiDobSWLijJwS65wZ4vv9jYDOuatcMtL6uTVnrX+9QyifGzM+inAodS21XoipwZKlrqAKpM94bxTNjuGahymPAqmF6KxIPhlJYEduf2qVU6/4wFiycVMLELE8lSeeHlBq/jAX3c7j6sQRMcTvp0UFAeyCax7S+mv3hah2G0YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776938365; c=relaxed/simple;
	bh=P5yMVH5YJBF3iqbYWS1Ahbm0YOzndEIy0KOBRlfAoLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5e0TvdYxoXTeZ1NCGX3tpT/JNyyaGO8X1rP84TP8mnXY/Gg3W5F/a0U6oFc67UlH/x5lF4BhadsdvW1gkoKlFXgXhny3Sx2nYxdUqwHPNqFBxmtk+mWz005z+b3ciqGXmbZRLlu4kgUXbQsCtQWTxeH4MrpIPgh2Ay75vpV9GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oan86jiR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oan86jiR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ba8acbCvQDSBbQ/GKmR5KTzANcz/xW/ZoGOHLxFYq+Q=; b=oan86jiRQ8rxsaAof6SpD2Ld9C
	JB4/GQwsfe0aecqcq8E8qygo3/rum7WqQ8LjOcbmRWz2kJlwDH3u0YbM5Rq9r7pzvv9i41mH4D83z
	uE714n0e5CGVCqNgOBuBzoWi5j6LXOso+zJQeiHGyMV/xdxTRTchvFT3981T6BAA5zG9delKDfgaZ
	2ch8XIgp68OH+FvOa+yPL+hr5to/tIPoRmlcznS/C0yVXzWQ8bNZKZvaNRgpeL+I1kLMYDUsROmxv
	CzQoaGInsciiFXb7z9vewk/dfjTydXowiYcL+hugA3yzBssvEzFHf0IWnEHEqd2F6qHy5sdKfnE6H
	tqvFBaYA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFqq5-0000000Cn8a-2vk2;
	Thu, 23 Apr 2026 09:59:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3D16D300BD2; Thu, 23 Apr 2026 11:59:17 +0200 (CEST)
Date: Thu, 23 Apr 2026 11:59:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
	eddyz87@gmail.com, memxor@gmail.com, rostedt@goodmis.org,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v11 2/6] bpf: Add bpf_prog_run_array_sleepable()
Message-ID: <20260423095917.GB3126523@noisy.programming.kicks-ass.net>
References: <20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com>
 <20260421-sleepable_tracepoints-v11-2-d8ff138d6f05@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-sleepable_tracepoints-v11-2-d8ff138d6f05@meta.com>

On Tue, Apr 21, 2026 at 10:14:18AM -0700, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Add bpf_prog_run_array_sleepable() for running BPF program arrays
> on faultable tracepoints. Unlike bpf_prog_run_array_uprobe(), it
> includes per-program recursion checking for private stack safety
> and hardcodes is_uprobe to false.
> 
> Skip dummy_bpf_prog at the top of the loop. When
> bpf_prog_array_delete_safe() replaces a detached program with
> dummy_bpf_prog on allocation failure, the dummy is statically
> allocated and has NULL active, stats, and aux fields. Identify
> it by prog->len == 0, since every real program has at least one
> instruction.
> 
> Keep bpf_prog_run_array_uprobe() unchanged for uprobe callers.
> 
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/bpf.h | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3cb6b9e70080..b6e96c939846 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3079,6 +3079,61 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
>  void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
>  void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip);
>  
> +static __always_inline u32
> +bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
> +			     const void *ctx, bpf_prog_run_fn run_prog)
> +{
> +	const struct bpf_prog_array_item *item;
> +	struct bpf_prog *prog;
> +	struct bpf_run_ctx *old_run_ctx;
> +	struct bpf_trace_run_ctx run_ctx;
> +	u32 ret = 1;
> +
> +	might_fault();
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock held");
> +
> +	if (unlikely(!array))
> +		return ret;
> +
> +	migrate_disable();

Again, what is the purpose of this migrate_disable()?

> +	run_ctx.is_uprobe = false;
> +
> +	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> +	item = &array->items[0];
> +	while ((prog = READ_ONCE(item->prog))) {
> +		/* Skip dummy_bpf_prog placeholder (len == 0) */
> +		if (unlikely(!prog->len)) {
> +			item++;
> +			continue;
> +		}
> +
> +		if (!prog->sleepable)
> +			rcu_read_lock();
> +
> +		if (unlikely(!bpf_prog_get_recursion_context(prog))) {
> +			bpf_prog_inc_misses_counter(prog);
> +			bpf_prog_put_recursion_context(prog);
> +			if (!prog->sleepable)
> +				rcu_read_unlock();
> +			item++;
> +			continue;
> +		}
> +
> +		run_ctx.bpf_cookie = item->bpf_cookie;
> +		ret &= run_prog(prog, ctx);
> +
> +		bpf_prog_put_recursion_context(prog);
> +		item++;
> +
> +		if (!prog->sleepable)
> +			rcu_read_unlock();
> +	}
> +	bpf_reset_run_ctx(old_run_ctx);
> +	migrate_enable();
> +	return ret;
> +}
> +
>  #else /* !CONFIG_BPF_SYSCALL */
>  static inline struct bpf_prog *bpf_prog_get(u32 ufd)
>  {
> 
> -- 
> 2.52.0
> 
