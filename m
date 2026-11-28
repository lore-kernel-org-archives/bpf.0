Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795860240;
	b=y7fVAdkuguRvXDH7jKfcGI28EAJRl45TeiB0s/eOC0z0FzK3Dcj9tM9iu/3XSwj2bneV
	 Povqt3rkTo7pMe26b6XSnPE0N5ttgqN+JM8gf7P9QYDYPcd4CcwUOY1pk6ZDmBxZvLDwZ
	 5eEflURZXgQozK33Jb6Lqm4LCJBpt8WHDzSSw3D2cSO6XNIR65mnTaUhmUO5EnD3J/7kO
	 P6C8r8SSh+bw1NS2ETNTEFfaNFiliejGG1FiA5gvsHCIx+2J1jYKnmsr5WbJEs4ptGE0q
	 l618RE56vj6cAB8VEL/GBg4FA4H9/uv2syj2MPe3V+Enf3EYZIuFxKBGmqg5kzBc86Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795860240;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cqPxtPyOFKb6uO8nwJlphwDuGUng3FGbn1dSPlT7TjQ=;
	b=qhwB+OXY7y1KtnsF4I7GGfbxqPKEmMAUznLCHBa1Xlc8dqZxbMqOrUk+EGYoDyGRvWg6
	 NNAJusuxD4TuBv+wunXsDbpGjD84/PEOOWX3r6fNXU93UcQgx2GmO4eJqKQJSDFtLVq+U
	 /3LEe2eG7mivmOY5f4OMYs4DftkxDqCHzpfh8C0x1Jgh5MD4ECq5cQM9VjWw2PCqxzi9a
	 k+jwNwKfgoIx7nUAkOQldvguquz5qwM70ZuQDRrwrn5kWtMrflmZ1m0SVOAhS7d+qpX1q
	 ajgfpx2h9Po2pO+PUuFy2AQKFY61lhHMqLYbZyYmrAx//zo4GDyvA8FzNHO10tqVEYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L2RUwJrz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864AE606A32E;
	Sat, 28 Nov 2026 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L2RUwJrz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8C41F000C1;
	Sat, 28 Nov 2026 10:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795860239;
	bh=cqPxtPyOFKb6uO8nwJlphwDuGUng3FGbn1dSPlT7TjQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L2RUwJrzxxZKmmo/OXjN51WpWsDN2oue9EWqn5z+aDhwG1cjslI7NAiBsU6E/a5Mg
	 cIOfMjMFIzZ4W5cVyIqCV3YFDr/0nIWBvGGrvjau00AvtsZ7BZqJ1PPpky2sF4lxvt
	 GcMAHczSe9Q8nan/IfCMfO8HHqnkU1yy6E0Z/NMbpm4DliVExhlEYBY1+l3mm7aokp
	 Ydbt2pwNAhR2k7oULkJg8L64pqnksn6366dA18jOtpy1YmHxhBrGxjW+bNa8scQa1Y
	 QfouXGouOwlmZ0kgvPth/be4ojDYgvBRqNEVVMcNyEtYj/XFYTu74T/ENmJtDtrhbx
	 04tuj57vYHLfg==
Subject: Re: [PATCH net v9 4/6] veth: use the page_pool mem type when running
 XDP on an skb
From: netdev-bot+sashiko@kernel.org
To: sst@poczta.fm
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, bpf@vger.kernel.org,
 netdev@vger.kernel.org, jiayuan.chen@linux.dev, phx0fer@gmail.com,
 maciej.fijalkowski@intel.com, tianyi@cloudflare.com, tavip@google.com,
 toke@redhat.com, aleksander.lobakin@intel.com, lorenzo@kernel.org,
 lorenzo.bianconi@oss.qualcomm.com, ihor.solodrai@linux.dev,
 andrew+netdev@lunn.ch, willemb@google.com, horms@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, memxor@gmail.com,
 emil@etsalapatis.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
Date: Sat, 28 Nov 2026 10:03:57 +0000
Message-ID: <179586023747.3135.10147454988994351806@kernel.org>
In-Reply-To: <20261127100132.1977890-5-sst@poczta.fm>
References: <20261127100132.1977890-5-sst@poczta.fm>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In drivers/net/veth.c, veth_convert_skb_to_xdp_buff() now
  always sets rxq->mem.type = MEM_TYPE_PAGE_POOL.

--

veth: use the page_pool mem type when running XDP on an skb

veth now runs the XDP program on an skb with an on-stack rxq info whose
mem type is MEM_TYPE_PAGE_POOL. Frags that the program shrinks away go
back to the page_pool they came from. On XDP_TX and XDP_REDIRECT,
veth_xdp_get() switches the mem type back to MEM_TYPE_PAGE_SHARED, and
the saved rq->xdp_mem is removed.

Link: https://lore.kernel.org/all/DN3QVHST3PUQ.3NINFUW0FL9IW@gmail.com/

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index cce253b58c2bc..8bb015c133760 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c

[ ... ]

> @@ -773,7 +776,9 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>  	/* SKB "head" area always have tailroom for skb_shared_info */
>  	frame_sz = skb_end_pointer(skb) - skb->head;
>  	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> -	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
> +	/* the prog can free only frags and they came from skb_pp_cow_data() */
> +	rxq->mem.type = MEM_TYPE_PAGE_POOL;
> +	xdp_init_buff(xdp, frame_sz, rxq);

[Severity: Medium]
Is the invariant in this comment guaranteed by the code?

Earlier in veth_convert_skb_to_xdp_buff(), the copy into page_pool
memory depends on skb_is_nonlinear(), which tests skb->data_len:

	if (skb_shared(skb) || skb_head_is_locked(skb) ||
	    skb_is_nonlinear(skb) ||
	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
		if (skb_pp_cow_data(rq->page_pool, pskb, XDP_PACKET_HEADROOM))
			goto drop;

The frags flag set just below depends on nr_frags instead:

	if (skb_shinfo(skb)->nr_frags) {
		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
		xdp_buff_set_frags_flag(xdp);

Take an skb that is unshared and unlocked, has enough headroom, and has
nr_frags > 0 but data_len == 0 (all frags are zero-length). It skips
skb_pp_cow_data() and keeps its original frag pages, which are not
page_pool pages. It still gets XDP_FLAGS_HAS_FRAGS and runs with
MEM_TYPE_PAGE_POOL.

Suppose a frags-aware program then calls bpf_xdp_adjust_tail() with a
negative offset. For each zero-size frag, bpf_xdp_frags_shrink_tail()
computes shrink = 0, and bpf_xdp_shrink_data() treats the frag as fully
consumed:

bpf_xdp_adjust_tail()
  bpf_xdp_frags_shrink_tail()
    bpf_xdp_shrink_data()        /* release = (size == shrink) */
      __xdp_return(netmem, MEM_TYPE_PAGE_POOL, ...)
        page_pool_put_full_netmem(netmem_get_pp(netmem), ...)

For MEM_TYPE_PAGE_POOL, __xdp_return() does not check netmem_is_pp().
Wouldn't netmem_get_pp() then read a pp pointer from a page that was
never part of a page_pool? Before this patch, the same frag went through
page_frag_free() under MEM_TYPE_PAGE_SHARED, which releases it correctly.

I could not find a concrete source of such an skb reaching veth_xmit(),
and the usual skb helpers avoid leaving zero-size frags behind. However,
nothing in veth rejects that state.

The sibling change "xdp: run generic XDP on frags with a copy of the rxq
info" uses skb_is_nonlinear() for the copy decision, the frags flag and
MEM_TYPE_PAGE_POOL. Could the frags flag here also be set from
skb_is_nonlinear()? Alternatively, MEM_TYPE_PAGE_POOL could be used only
when skb_pp_cow_data() actually ran, keeping MEM_TYPE_PAGE_SHARED
otherwise.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261127100132.1977890-1-sst%40poczta.fm
