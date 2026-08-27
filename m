Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174DA42E435;
	Thu, 27 Aug 2026 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858388; cv=none; b=KtRVlPEUMlSY4PobA6JIc/bYH65E3qAvyatEm7ALTZ+HCWnRchNzcrM0Q9BYz4xYpXEqNrZcQlnKGpMAd62XvvvwQf8PzMEV4CJieTNe9BsPWWRbGUQLfXgCdvAsQ2OuUinMAaV0Q4xpjqfXQvDxymiNVSjdjvXsHZmaqz+GUGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858388; c=relaxed/simple;
	bh=NQ5aDbI68dfVIprQJGaOPpQjMfOiPb/kMhr2+W2vzGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sI2qowv4FgReqje/HpJAdLjKdVQ0o892xl0pqwt54alRX+B8FOIm96DGLSAI9IyC8Pc3odRmZjvhmxQ4qHJb5qNQpwwxxvyfIlPA1T6qMMsmzLe+o+sOM2i7s48FilQxU5Ts9d1M7fCqj1gKfaMBXoz4iil4KOqUnxXG2UFM8OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/Bs3Saf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/Bs3Saf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51F91F000E9;
	Thu, 27 Aug 2026 19:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787858386;
	bh=FDSlhYpZ7SK0VWnxLFVVVQi00Pd+n+HLWSAlwciDTdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V/Bs3Safp1L8PscctK/tMZ2L3zg+eetFGpnefO1L1aK+Jl2u2Gz8O5a2viljUu68b
	 4OvzhBuzJbNJDvkqYhYKCkn8txyNsIBu2HarLlTNu9/SDgmDpZ/HEv/MbQB+/nTRlL
	 8P1SeZzKwcj5uumJDOpp9WjfvYduKeLMvnR7jcJGzd41h5gXVgApF4/eVpLVgNJhFY
	 EVswFaVZFWe++EC4nWOs/3TqxQUXW/mSUABJKTrnmEf9Yg4wc1P/IMS77XQ64fzXFP
	 ixyrVcs9kiSnwIP2RU3eg7DhSVndSE6IYAzEA3+fZFPxv0OSQCOX0CDfba/4fu7T4Y
	 TPpHTHiAwMitg==
From: Jakub Kicinski <kuba@kernel.org>
To: jiayuan.chen@linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	horms@kernel.org,
	martin.lau@linux.dev,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	kuniyu@google.com,
	liuhangbin@gmail.com,
	krikku@gmail.com,
	mkarsten@uwaterloo.ca,
	toke@redhat.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf, veth: xdp: fix page_pool page leak on skb-backed XDP
Date: Thu, 27 Aug 2026 12:19:43 -0700
Message-ID: <20260827191943.4007831-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824030705.266049-1-jiayuan.chen@linux.dev>
References: <20260824030705.266049-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
bpf, veth: xdp: fix page_pool page leak on skb-backed XDP

This adds a new xdp_buff flag, XDP_FLAGS_FRAGS_PAGE_POOL, which the two
skb-cow sites (generic XDP and veth) set when a non-linear skb has been
cow'd into page_pool memory.  bpf_xdp_shrink_data() then frees a released
frag to the page_pool instead of using xdp->rxq->mem.type.

Closes: https://syzkaller.appspot.com/bug?extid=237bbeed8dfe0699b7f5

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 6ed3ee81153fb..0afa0661ada16 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -775,6 +775,11 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>  	if (skb_shinfo(skb)->nr_frags) {
>  		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
>  		xdp_buff_set_frags_flag(xdp);
> +		/* A nonlinear skb was cow'd into rq->page_pool above, so the
> +		 * frags must be freed to that pool, not via the rxq's
> +		 * MEM_TYPE_PAGE_SHARED.
> +		 */
> +		xdp_buff_set_frag_pp(xdp);
>  	} else {
>  		xdp_buff_clear_frags_flag(xdp);
>  	}

[Severity: Critical]
Does this flag survive past the point where veth deliberately drops the
page_pool association?

In veth_xdp_rcv_skb(), the XDP_TX and XDP_REDIRECT arms do:

	case XDP_TX:
		veth_xdp_get(xdp);
		consume_skb(skb);
		xdp->rxq->mem = rq->xdp_mem;

veth_xdp_get() takes a plain get_page() on each frag, then consume_skb()
-> skb_release_data() -> napi_pp_put_page() finds page_ref_count() != 1,
so page_pool_return_netmem() -> page_pool_clear_pp_info() sets
netmem->pp = NULL.  veth then resets rxq->mem to MEM_TYPE_PAGE_SHARED,
which matches the now plain pages, but XDP_FLAGS_FRAGS_PAGE_POOL is never
cleared.

The flag then leaves the buff:

include/net/xdp.h:xdp_update_frame_from_buff() {
	...
	xdp_frame->flags = xdp->flags;
}

include/net/xdp.h:xdp_convert_frame_to_buff() {
	...
	xdp->flags = frame->flags;
}

so a second-stage consumer that rebuilds a buff from the frame and runs a
program inherits it.  veth_xdp_rcv_one() does exactly that, with no
xdp_init_buff() to reset flags:

drivers/net/veth.c:veth_xdp_rcv_one() {
	...
	xdp_convert_frame_to_buff(frame, xdp);
	xdp->rxq = &rq->xdp_rxq;
	vxbuf.skb = NULL;

	act = bpf_prog_run_xdp(xdp_prog, xdp);
}

cpu_map_bpf_prog_run_xdp() and dev_map_bpf_prog_run() inherit frame->flags
the same way.

If that peer program calls bpf_xdp_adjust_tail() with a negative offset
that consumes a whole frag, bpf_xdp_shrink_data() takes the new branch and
forces mem_type = MEM_TYPE_PAGE_POOL for a page that is no longer a
page_pool page.  __xdp_return() skips the netmem_is_pp() check for that
type:

net/core/xdp.c:__xdp_return() {
	...
		/* No need to check netmem_is_pp() as mem->type knows this a
		 * page_pool page
		 */
		page_pool_put_full_netmem(netmem_get_pp(netmem), netmem,
					  napi_direct);
}

netmem_get_pp() is NULL here, so page_pool_put_unrefed_netmem() reads
pool->cpuid in page_pool_napi_local() (or pool->dma_sync on PREEMPT_RT)
off a NULL pool in softirq context.  Since pp_ref_count is still 1 for a
frag that owns a whole page, is this deterministic rather than
refcount-dependent?  A veth pair with an xdp.frags program on both sides
looks sufficient to reach it.

Would clearing the flag in the XDP_TX / XDP_REDIRECT arms next to
xdp->rxq->mem = rq->xdp_mem, or masking it out in
xdp_update_frame_from_buff(), be the right fix?

Related to this, the commit message says:

    So record it in the xdp_buff. Add a XDP_FLAGS_FRAGS_PAGE_POOL flag; the two
    skb-cow sites set it, and bpf_xdp_shrink_data() frees the frag to the
    page_pool when it is set, otherwise it keeps falling back to
    xdp->rxq->mem.type unchanged. No other path changes behaviour.

Given that xdp_frame->flags carries the bit into frame-based paths, is "No
other path changes behaviour" accurate?

> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c358..b389dc527adce 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -81,6 +81,10 @@ enum xdp_buff_flags {
>  	 * XDP program is not attached.
>  	 */
>  	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
> +	/* frags are page_pool memory even though rxq->mem.type is not: a
> +	 * skb-backed XDP buff (generic XDP, veth) is cow'd into a page_pool.
> +	 */
> +	XDP_FLAGS_FRAGS_PAGE_POOL	= BIT(3),
>  };

[Severity: Medium]
This comment documents a general ownership rule for frags, but is the rule
only implemented in bpf_xdp_shrink_data()?

The other frag release paths still key exclusively on rxq->mem.type or
xdpf->mem_type and never consult xdp_buff_is_frag_pp():

net/core/xdp.c:xdp_return_frag() {
	__xdp_return(netmem, xdp->rxq->mem.type, true, NULL);
}

net/core/xdp.c:xdp_return_buff() {
	...
	for (u32 i = 0; i < sinfo->nr_frags; i++)
		__xdp_return(skb_frag_netmem(&sinfo->frags[i]),
			     xdp->rxq->mem.type, true, xdp);
}

plus the frame-side loops used by xdp_return_frame(),
xdp_return_frame_rx_napi() and xdp_return_frame_bulk(), which use
xdpf->mem_type.

xdp_convert_buff_to_frame() also stores two independent descriptions of the
same memory in one frame:

include/net/xdp.h:xdp_convert_buff_to_frame() {
	...
	if (unlikely(xdp_update_frame_from_buff(xdp, xdp_frame) < 0))
		return NULL;

	/* rxq only valid until napi_schedule ends, convert to xdp_mem_type */
	xdp_frame->mem_type = xdp->rxq->mem.type;
}

so xdp_frame->flags can say page_pool while xdp_frame->mem_type says
MEM_TYPE_PAGE_SHARED.  I could not construct a live caller that frees a
flagged buff through the generic helpers today, but should the contract be
made consistent (either honour the flag in the generic release helpers, or
scope the comment to the shrink path only) so a future caller does not
silently reintroduce the same "Bad page state ... page_pool leak"?

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e7535523..d34ba56d79d8f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4378,6 +4378,13 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
>  	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
>  		netmem = 0;
>  		zc_frag = bpf_xdp_shrink_data_zc(xdp, shrink, tail, release);
> +	} else if (xdp_buff_is_frag_pp(xdp)) {
> +		/*
> +		 * Skb-backed XDP (generic XDP, veth) cow's the frags into a
> +		 * page_pool while the rxq stays MEM_TYPE_PAGE_SHARED, so free
> +		 * the frag to the pool, not via page_frag_free().
> +		 */
> +		mem_type = MEM_TYPE_PAGE_POOL;
>  	}
>  
>  	if (release) {

[ ... ]
