Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B034397945;
	Fri, 18 Sep 2026 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695096; cv=none; b=h5GEieJ3FsiTCajimMVxqzc4qwQP3i/vqWFhjemennhdF1b04CaoA7kpGms8sws5qlMnQMSMQNuK9OV9F8gyuLwQRrCdp7WCMdbQ5UqVIdNQ1WsxJZUP4NOYOhiXi2iDJFmh+OwxISIWK4hZgfY9iXC6D1PCKhZHsalmeerEs2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695096; c=relaxed/simple;
	bh=KcvIEKDbuHaSZeVIuvf/LZGzwrzfBHO5EJbBtNbuUBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q05p7gWu+F+7Gq6orwHelBhLdqc5JZsj/n5Cq/iafJjQjSelFuBWakeEKWBJT2A4ZvXjs8rdEXvfu8AXy22W+n+xfRsU6qSwef3CqXAt6hWayxMx/pGKqsQuQYevQv5ZIUCi4l8zsOL1jZrTxQvo6T5HLeeb3emb1jA7Zc0V5pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9w5twsB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9w5twsB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA281F000FF;
	Fri, 18 Sep 2026 01:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789695094;
	bh=QS9nIJ3FvUZ63E7dpFZbqyaI/csq1+1IMiM7Bt7yE8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n9w5twsBM6EzMXlxvcWG4u/vYk2lqGpSEyjvZ+w/lx+KsrBL9AsgAfnTj9YcM/VvQ
	 KhwpJ+VBMdAqTDp0K2Mit49WC4iVAWXyHGpH+C9A/JFAimcxytx6ykFU7oMxehEbHH
	 5nQerTdmRBLFhhZXdXZ06ni5GUavO9XvfvwZ7isK3JFGdxqDV2ByviJK0Z8di8ewc+
	 PFVKXlrFUG6sLDA8FGGEPSc3gBzQi7R/Dm8LBAGSueQtwIdntC7EeJQLhc5Ot7dKr3
	 jlvy0KyKep/mYA5llKFugdPAMuQhR62IEBEeRiWKCjgRyV4zbh23d+woIf0XJirnNR
	 1qqt0iSpHt7+w==
From: Jakub Kicinski <kuba@kernel.org>
To: jiayuan.chen@linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	bpf@vger.kernel.org,
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
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	kuniyu@google.com,
	liuhangbin@gmail.com,
	mkarsten@uwaterloo.ca,
	toke@redhat.com,
	lorenzo.bianconi@oss.qualcomm.com,
	echaudro@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf, veth: xdp: fix page_pool page leak on skb-backed XDP
Date: Thu, 17 Sep 2026 18:31:28 -0700
Message-ID: <20260918013128.3451350-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911135711.109338-2-jiayuan.chen@linux.dev>
References: <20260911135711.109338-2-jiayuan.chen@linux.dev>
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

This adds an XDP_FLAGS_FRAGS_PAGE_POOL xdp_buff flag that the two skb-cow
sites (generic XDP and veth) set, so bpf_xdp_shrink_data() frees a released
frag to the page_pool instead of using xdp->rxq->mem.type. The flag is
stripped on buff -> frame conversion and re-derived from frame->mem_type on
frame -> buff conversion.

Closes: https://syzkaller.appspot.com/bug?extid=237bbeed8dfe0699b7f5

> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c358..8fd4139e9cbd3 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h

[ ... ]

> @@ -394,6 +412,15 @@ void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
>  	xdp->data_meta = frame->data - frame->metasize;
>  	xdp->frame_sz = frame->frame_sz;
>  	xdp->flags = frame->flags;
> +	/*
> +	 * frame->flags never carries XDP_FLAGS_FRAGS_PAGE_POOL (it is stripped
> +	 * in xdp_update_frame_from_buff()); re-derive it from the frame's own
> +	 * memory type. veth and devmap rebuild a buff here and run a program
> +	 * whose rxq says MEM_TYPE_PAGE_SHARED, so without this a shrink would
> +	 * free a page_pool frag through page_frag_free().
> +	 */
> +	if (frame->mem_type == MEM_TYPE_PAGE_POOL)
> +		xdp_buff_set_frag_pp(xdp);
>  }

[ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 532405988fd98..861c878d0a6d6 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4377,6 +4377,13 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
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

[Severity: High]
The new flag only overrides mem_type in one direction (towards
MEM_TYPE_PAGE_POOL), while mem_type is still initialized from the shared
xdp->rxq->mem.type:

net/core/filter.c:bpf_xdp_shrink_data() {
	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
	...
}

The commit message says veth's rq->xdp_rxq.mem "is shared per-queue state"
that "can be clobbered under a packet still in flight". veth also writes a
frame's memory type into it and never restores it:

drivers/net/veth.c:veth_xdp_rcv_one() {
	case XDP_TX:
		orig_frame = *frame;
		xdp->rxq->mem.type = frame->mem_type;
	...
	case XDP_REDIRECT:
		orig_frame = *frame;
		xdp->rxq->mem.type = frame->mem_type;
}

Only veth_disable_xdp_range() puts rq->xdp_rxq.mem back to rq->xdp_mem.

So can the opposite direction still go wrong on a veth queue?

1) A multi-buff frame with frame->mem_type == MEM_TYPE_PAGE_POOL (e.g.
   redirected in from a page_pool NIC) takes XDP_TX or XDP_REDIRECT, and
   rq->xdp_rxq.mem.type stays MEM_TYPE_PAGE_POOL for every later packet on
   that queue.

2) A later multi-buff frame whose frame->mem_type is MEM_TYPE_PAGE_SHARED
   (the peer's veth_xdp_rcv_skb() XDP_TX/XDP_REDIRECT path stamps
   xdp->rxq->mem = rq->xdp_mem into the frame) or MEM_TYPE_PAGE_ORDER0
   arrives. xdp_convert_frame_to_buff() does not set
   XDP_FLAGS_FRAGS_PAGE_POOL for it, and it does not clear the flag either,
   so bpf_xdp_shrink_data() picks up the stale MEM_TYPE_PAGE_POOL from the
   rxq.

3) If the program then calls bpf_xdp_adjust_tail() with a negative offset
   that consumes a whole frag, the release path ends in:

net/core/xdp.c:__xdp_return() {
	case MEM_TYPE_PAGE_POOL:
		netmem = netmem_compound_head(netmem);
		...
		/* No need to check netmem_is_pp() as mem->type knows this a
		 * page_pool page
		 */
		page_pool_put_full_netmem(netmem_get_pp(netmem), netmem,
					  napi_direct);
}

There is no netmem_is_pp() validation here, so netmem_get_pp() on a plain
page returns whatever occupies the overlaid field, and NULL for a page that
veth already released from its pool. Can that dereference a garbage or NULL
struct page_pool *, or hand a foreign page to an unrelated pool's cache?

Would it be more robust for bpf_xdp_shrink_data() to derive the frag memory
type entirely from the buff (i.e. also express "not page_pool" instead of
falling back to rxq->mem.type), so the shared and clobberable veth rxq type
is not consulted at all?

Note this residual path is not addressed later in the series: the diff of
net/, drivers/net/veth.c and include/net/xdp.h between this commit and
6c9c432f is empty, the following patch only adds a selftest.
