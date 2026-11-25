Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.63
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601549;
	b=KeP7l7Enl3ttz3xsjPg8jV4LWetfA8p4G+yddUn9prna5K8uIiKUJhJe4Hqinfe2+sbH
	 z+63gNcFIFFrELZ8Pti71QF0pZC4RXQL4vUgMHrOMicBF3dDiRIxrlVlDa3WdDw1Lq7/J
	 A18KGf9o7n6es6PUZ1TpVMglg2QKtxyiqgyOY6RDTm5vX93SqPJKQv0WTemiVYR9Qk+R0
	 w73WcQvPqXUNRTFS71MFndC98Y0QOQGn6BIM/1CLwVa5OZqjiZIQDO7huErwapcXipwe6
	 p2DlJy+YaFKLWPtVAv2ayQvMhKmulSH3Fu5ruJk0XS8Yo5+7TY/ShuU7Fg084bgl8Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601549;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 DKIM-Signature;
	bh=gNLzY4BwVKCseo7jPGBp/FH18c7BfmwO0rueLWEHRog=;
	b=xFym/cPIL810elLmvjXqmTBQbt9cq0cdZzvFYNoZ4iLnp58r7GBWX1mHHgY4qRf8MMjp
	 02lbZFJf+jzz8PFeE98SIOZYIFaVf9jv4hafFJYk5SWGr2IUUj85+Faj3aQKFNKyR4viX
	 50F0NkkKjOCuWW8hwkIjnpt4Uy7S+h14Z3VS9ojAh+imjDVTCAncWk5GkF0+hkG6cjh/t
	 jmTwhmLJLw5M++9omVI6nZk+1dUOJrGaAnNUVIATEv9ftsuIo0bfXPtBh7YJ5IswqY2aV
	 s55mocHP64NhHaLGQJNS5gqERKn3CdFQy1MoxNUnjysy+T4EKOu5wC3MrLpv8QZcUlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b="CkSW/lbI";
	arc=none smtp.remote-ip=217.74.67.63
Received: from smtpo63.interia.pl (smtpo63.interia.pl [217.74.67.63])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2141606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 10:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2141606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=CkSW/lbI
Received: from nr200 (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Wed, 25 Nov 2026 11:12:16 +0100 (CET)
Date: Wed, 25 Nov 2026 11:12:14 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	jiayuan.chen@linux.dev
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tianyi Gao <tianyi@cloudflare.com>,
	Octavian Purdila <tavip@google.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 bpf 0/7] xdp: fix page_pool leaks
Message-ID: <awa0fvxzngTtIYVd@nr200>
References: <20261124104016.532341-1-sst@poczta.fm>
 <DN3QVHST3PUQ.3NINFUW0FL9IW@gmail.com>
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
In-Reply-To: <DN3QVHST3PUQ.3NINFUW0FL9IW@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1795601540; bh=gNLzY4BwVKCseo7jPGBp/FH18c7BfmwO0rueLWEHRog=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=CkSW/lbIqxnu8SM9tcMd1jFWP+JUPVIDM2ul10ZUK7lVhSvMMJzkHv7Xp+aJxyrbJ
	 wDgTnnHiqKXewKZWk7C019oOIGT1rQGLx5j3f0qVM9Bp6wP6hixWKM7PL/zSLaM4fh
	 bB8oAhTY6n2EL6PjyrxTj/ycnOiSLEIgMXvIMZ/Y=

On lis 24, 2026 21:04, Alexei Starovoitov wrote:
> On Tue, Nov 24, 2026 at 02:40 AM Slawomir Stepien <sst@poczta.fm> wrote:
> > Patch 1 prepares bpf_prog_test_run_xdp() for patch 3. Generic XDP runs
> > on the rxq info of the device queue, which is shared with test_run; with
> > patch 3 alone, any packet through generic XDP on lo makes later
> > multi-buffer test runs free their frags as page_pool pages. Restoring
> 
> The store into the shared rxq is the problem.
> Patch 3 does it for every packet on every CPU, for linear skbs too.
> The comment in include/net/xdp.h says that rxq must not be updated
> during NAPI poll.
> On Dudu's patch I proposed to put rxq on stack:
> https://lore.kernel.org/bpf/DMAP8LNBJRPN.2THUHLKURP25G@gmail.com/
> It works for veth too.
> An skb leaves veth as a MEM_TYPE_PAGE_SHARED frame, like today.
> No need for xdp_convert_skb_to_buff(), veth_xdp_get_pp(), pp_cow,
> rq->xdp_mem and patch 6.

Thanks for these points. This approach is less complex. Let me play with it and I will respin it in
v9.

> Patches 6 and 7 never free a page_pool frag. Jiayuan's test does:
> https://lore.kernel.org/bpf/20260911135711.109338-3-jiayuan.chen@linux.dev/

Jiayuan Chen, can I use your selftest then in v9? :)

> Below replaces patches 1-5.
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index faa837a..8bb015c 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -63,7 +63,6 @@ struct veth_rq {
>  	struct napi_struct __rcu *napi; /* points to xdp_napi when the latter is initialized */
>  	struct net_device	*dev;
>  	struct bpf_prog __rcu	*xdp_prog;
> -	struct xdp_mem_info	xdp_mem;
>  	struct veth_rq_stats	stats;
>  	bool			rx_notify_masked;
>  	struct ptr_ring		xdp_ring;
> @@ -642,6 +641,7 @@ static int veth_xdp_tx(struct veth_rq *rq, struct xdp_buff *xdp,
>  }
>  
>  static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
> +					  struct xdp_rxq_info *rxq,
>  					  struct xdp_frame *frame,
>  					  struct veth_xdp_tx_bq *bq,
>  					  struct veth_stats *stats)
> @@ -657,7 +657,8 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
>  		u32 act;
>  
>  		xdp_convert_frame_to_buff(frame, xdp);
> -		xdp->rxq = &rq->xdp_rxq;
> +		rxq->mem.type = frame->mem_type;
> +		xdp->rxq = rxq;
>  		vxbuf.skb = NULL;
>  
>  		act = bpf_prog_run_xdp(xdp_prog, xdp);
> @@ -669,7 +670,6 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
>  			break;
>  		case XDP_TX:
>  			orig_frame = *frame;
> -			xdp->rxq->mem.type = frame->mem_type;
>  			if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
>  				trace_xdp_exception(rq->dev, xdp_prog, act);
>  				frame = &orig_frame;
> @@ -681,7 +681,6 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
>  			goto xdp_xmit;
>  		case XDP_REDIRECT:
>  			orig_frame = *frame;
> -			xdp->rxq->mem.type = frame->mem_type;
>  			if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
>  				frame = &orig_frame;
>  				stats->rx_drops++;
> @@ -746,6 +745,9 @@ static void veth_xdp_get(struct xdp_buff *xdp)
>  	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
>  	int i;
>  
> +	/* the buff holds plain page references from here on */
> +	xdp->rxq->mem.type = MEM_TYPE_PAGE_SHARED;
> +
>  	get_page(virt_to_page(xdp->data));
>  	if (likely(!xdp_buff_has_frags(xdp)))
>  		return;
> @@ -755,6 +757,7 @@ static void veth_xdp_get(struct xdp_buff *xdp)
>  }
>  
>  static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
> +					struct xdp_rxq_info *rxq,
>  					struct xdp_buff *xdp,
>  					struct sk_buff **pskb)
>  {
> @@ -773,7 +776,9 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>  	/* SKB "head" area always have tailroom for skb_shared_info */
>  	frame_sz = skb_end_pointer(skb) - skb->head;
>  	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> -	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
> +	/* the prog can free only frags and they came from skb_pp_cow_data() */
> +	rxq->mem.type = MEM_TYPE_PAGE_POOL;
> +	xdp_init_buff(xdp, frame_sz, rxq);
>  	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
>  			 skb_headlen(skb), true);
>  
> @@ -794,6 +799,7 @@ drop:
>  }
>  
>  static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
> +					struct xdp_rxq_info *rxq,
>  					struct sk_buff *skb,
>  					struct veth_xdp_tx_bq *bq,
>  					struct veth_stats *stats)
> @@ -815,7 +821,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>  	}
>  
>  	__skb_push(skb, skb->data - skb_mac_header(skb));
> -	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
> +	if (veth_convert_skb_to_xdp_buff(rq, rxq, xdp, &skb))
>  		goto drop;
>  	vxbuf.skb = skb;
>  
> @@ -830,7 +836,6 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>  	case XDP_TX:
>  		veth_xdp_get(xdp);
>  		consume_skb(skb);
> -		xdp->rxq->mem = rq->xdp_mem;
>  		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
>  			trace_xdp_exception(rq->dev, xdp_prog, act);
>  			stats->rx_drops++;
> @@ -842,7 +847,6 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>  	case XDP_REDIRECT:
>  		veth_xdp_get(xdp);
>  		consume_skb(skb);
> -		xdp->rxq->mem = rq->xdp_mem;
>  		if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
>  			stats->rx_drops++;
>  			goto err_xdp;
> @@ -914,6 +918,11 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  			struct veth_xdp_tx_bq *bq,
>  			struct veth_stats *stats)
>  {
> +	struct veth_priv *priv = netdev_priv(rq->dev);
> +	struct xdp_rxq_info rxq = {
> +		.dev = rq->dev,
> +		.queue_index = rq - priv->rq,
> +	};
>  	int i, done = 0, n_xdpf = 0;
>  	void *xdpf[VETH_XDP_BATCH];
>  
> @@ -928,7 +937,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  			struct xdp_frame *frame = veth_ptr_to_xdp(ptr);
>  
>  			stats->xdp_bytes += xdp_get_frame_len(frame);
> -			frame = veth_xdp_rcv_one(rq, frame, bq, stats);
> +			frame = veth_xdp_rcv_one(rq, &rxq, frame, bq, stats);
>  			if (frame) {
>  				/* XDP_PASS */
>  				xdpf[n_xdpf++] = frame;
> @@ -943,7 +952,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  			struct sk_buff *skb = ptr;
>  
>  			stats->xdp_bytes += skb->len;
> -			skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
> +			skb = veth_xdp_rcv_skb(rq, &rxq, skb, bq, stats);
>  			if (skb) {
>  				if (skb_shared(skb) || skb_unclone(skb, GFP_ATOMIC))
>  					netif_receive_skb(skb);
> @@ -1149,9 +1158,6 @@ static int veth_enable_xdp_range(struct net_device *dev, int start, int end,
>  						 NULL);
>  		if (err < 0)
>  			goto err_reg_mem;
> -
> -		/* Save original mem info as it can be overwritten */
> -		rq->xdp_mem = rq->xdp_rxq.mem;
>  	}
>  	return 0;
>  
> @@ -1180,7 +1186,6 @@ static void veth_disable_xdp_range(struct net_device *dev, int start, int end,
>  	for (i = start; i < end; i++) {
>  		struct veth_rq *rq = &priv->rq[i];
>  
> -		rq->xdp_rxq.mem = rq->xdp_mem;
>  		xdp_rxq_info_unreg(&rq->xdp_rxq);
>  
>  		if (delete_napi)
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index d6c9dc6..1d89b6f 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1349,6 +1349,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>  	struct netdev_rx_queue *rxqueue;
>  	struct skb_shared_info *sinfo;
>  	struct xdp_buff xdp = {};
> +	struct xdp_rxq_info rxq;
>  	int i, ret = -EINVAL;
>  	struct xdp_md *ctx;
>  	void *data;
> @@ -1417,8 +1418,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>  	}
>  
>  	rxqueue = __netif_get_rx_queue(current->nsproxy->net_ns->loopback_dev, 0);
> -	rxqueue->xdp_rxq.frag_size = PAGE_SIZE;
> -	xdp_init_buff(&xdp, rxqueue->xdp_rxq.frag_size, &rxqueue->xdp_rxq);
> +	xdp_init_buff(&xdp, PAGE_SIZE, &rxqueue->xdp_rxq);
>  	xdp_prepare_buff(&xdp, data, headroom, linear_sz, true);
>  	sinfo = xdp_get_shared_info_from_buff(&xdp);
>  
> @@ -1426,6 +1426,11 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>  	if (ret)
>  		goto free_data;
>  
> +	/* generic XDP uses the same rxq and its frags can be smaller */
> +	rxq = *xdp.rxq;
> +	rxq.frag_size = PAGE_SIZE;
> +	xdp.rxq = &rxq;
> +
>  	size = linear_sz;
>  	if (unlikely(kattr->test.data_size_in > size)) {
>  		void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 6140fd9..fe9f222 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5684,6 +5684,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>  	void *orig_data, *orig_data_end, *hard_start;
>  	struct netdev_rx_queue *rxqueue;
>  	bool orig_bcast, orig_host;
> +	struct xdp_rxq_info rxq;
>  	u32 mac_len, frame_sz;
>  	__be16 orig_eth_type;
>  	struct ethhdr *eth;
> @@ -5707,6 +5708,13 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>  	if (skb_is_nonlinear(skb)) {
>  		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
>  		xdp_buff_set_frags_flag(xdp);
> +		/*
> +		 * The frags came from skb_pp_cow_data(). xdp_rxq is shared
> +		 * with other CPUs and with BPF_PROG_TEST_RUN, so use a copy.
> +		 */
> +		rxq = rxqueue->xdp_rxq;
> +		rxq.mem.type = MEM_TYPE_PAGE_POOL;
> +		xdp->rxq = &rxq;
>  	} else {
>  		xdp_buff_clear_frags_flag(xdp);
>  	}
> @@ -5719,6 +5727,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>  	orig_eth_type = eth->h_proto;
>  
>  	act = bpf_prog_run_xdp(xdp_prog, xdp);
> +	xdp->rxq = &rxqueue->xdp_rxq;
>  
>  	/* check if bpf_xdp_adjust_head was used */
>  	off = xdp->data - orig_data;
> 
> pw-bot: cr

-- 
Slawomir Stepien
