Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795358;
	b=sxftd0PHMhyifyALV712ooY4hTjK/bIx6K5s1PQyNty8wtqp/pHaFpS8mwlP/2lHfkNb
	 yYw4+1vLBbH4ywUs82Z7sfPGPjkQGZJGTF3f/zKQK8KcPRPCqq1SepEXivEnTNpTiIGZn
	 9CSN2MzEW7F09zHhyFovoodkOzE+ldS53mDr9Lod6ZwguQd8zaw6Wt/8lutAbz0XxCGHv
	 czyRt3IxQacQyDF58zdaUEO4+vD9YW9Iwg6agWGSQwLNotCKYe+//YWkBbDEyKLScRSOu
	 kcviK3pEWtNvZmBms1xfdAZdRm2Jw4S9SK+KFj8KHeIfZbKrzfC0GafLfJpTalbqUrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795358;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+80zo6bg+yMtPNv0jRWvkyzPOBCV5Q9bKhJtsVDnb+U=;
	b=RxGqQyXAPs0xXzs91i6s/bQQUcmoq53lRai0swfvXU4ADGZicEBQkvwQZUgVtuAceyOj
	 CLFaVVBdu9T/WeHHHChv22LgUkjQRjBrf4izENdR6b3FtcUtSfSF4jlUzFKiiqUmXYlG0
	 ztLNOqDhxbMAx7WRVYbR5awrDkgSW3Q2jD1m5b9NJHvGcDRAtc83ANsjC+lInV3L95hGj
	 u5y2EPT5WEJEx4m7Rt3C+Iqs0CbujDXtG1RqFdvbUwD2/Ig3gWgLw1OXYTvH5jpNMMCXa
	 SFDZ9+Q7nIEmibEweKg6sH3WIMqU2J1NSxJIKGrUzSYilrh9RteSgzlU3+zq0mI/vGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lTN/kyuQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C8B606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lTN/kyuQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9851F000C1;
	Wed,  4 Nov 2026 12:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793795358;
	bh=+80zo6bg+yMtPNv0jRWvkyzPOBCV5Q9bKhJtsVDnb+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lTN/kyuQ8D/p4JkbPhg7pVCtKx3kgHF/wrAnQ9vcWS1qa3s7NagpzY3sQJI7zRk/l
	 ciOxWURgfaFJzJgNxSNDVoPBO2H40uQTkGPEBkp/sOT2QRFm3FCxUjN1fF4u55fqe/
	 ZLfCjsU9knKatxvXMC7GOxJb6686jEdG7sXmmzm9zlpgeZRLmykGEfCiJ4H8edJMc7
	 3b078lhgot/Fy4+IzH1sSWBCgwVtWFsdwGlVkHz5KFGtKOaQACU/zh0+V0a2vn1IHn
	 bhw6XA1vrCpr1H4DYpdrvee+xBjSzpLydpeU/HP26zwlXZTqLa9+JvTRZbEA5izewR
	 HkxU3/DaoExpw==
Message-ID: <sashiko-outbox-197255@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 bpf 1/3] xdp: introduce xdp_convert_skb_to_buff()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Slawomir Stepien" <sst@poczta.fm>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261104121316.1155680-2-sst@poczta.fm>
References: <20261104121316.1155680-1-sst@poczta.fm>
 <20261104121316.1155680-2-sst@poczta.fm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 12:29:17 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] xdp: shared xdp_rxq.mem.type mutation in xdp_convert_skb_to_buff()
--

commit cc30acfe8407351451e1a0085dbc31d3b426757f
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

xdp: introduce xdp_convert_skb_to_buff()

This commit introduces the xdp_convert_skb_to_buff() helper to initialize an
xdp_buff from an sk_buff for generic XDP and sets xdp->rxq->mem.type to
MEM_TYPE_PAGE_POOL so page_pool-backed fragments are properly released when
shrinking tail data.

> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 07231adfb5f82..28bd78dbef207 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -389,6 +389,42 @@ struct sk_buff *xdp_build_skb_from_frame(struct xdp_=
frame *xdpf,
>  					 struct net_device *dev);
>  struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
> =20
> +/**
> + * xdp_convert_skb_to_buff - build an xdp_buff on top of an skb
> + * @skb: skb to describe, packet data is taken from its MAC header onwar=
ds
> + * @xdp: xdp_buff to initialize
> + * @xdp_rxq: Rx queue info to attach to @xdp
> + *
> + * The memory type set on @xdp_rxq is only used to release fragments that
> + * the XDP program consumes; the head can not be freed from under the sk=
b.
> + * A non-linear @skb is expected to have gone through skb_pp_cow_data(),=
 so
> + * all of its fragments are page_pool backed.
> + */
> +static inline
> +void xdp_convert_skb_to_buff(struct sk_buff *skb, struct xdp_buff *xdp,
> +			     struct xdp_rxq_info *xdp_rxq)
> +{
> +	u32 frame_sz, pkt_len;
> +
> +	/* SKB "head" area always have tailroom for skb_shared_info */
> +	frame_sz =3D skb_end_pointer(skb) - skb->head;
> +	frame_sz +=3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +	pkt_len =3D skb_tail_pointer(skb) - skb_mac_header(skb);
> +
> +	xdp_init_buff(xdp, frame_sz, xdp_rxq);
> +	xdp_prepare_buff(xdp, skb->head, skb->mac_header, pkt_len, true);
> +
> +	if (skb_is_nonlinear(skb)) {
> +		skb_shinfo(skb)->xdp_frags_size =3D skb->data_len;
> +		xdp_buff_set_frags_flag(xdp);
> +	} else {
> +		xdp_buff_clear_frags_flag(xdp);
> +	}
> +
> +	DEBUG_NET_WARN_ON_ONCE(skb_is_nonlinear(skb) && !skb->pp_recycle);
> +	xdp->rxq->mem.type =3D MEM_TYPE_PAGE_POOL;
> +}

[Severity: High]
Does mutating xdp->rxq->mem.type in place on the shared netdev_rx_queue::xd=
p_rxq
cause a regression for bpf_prog_test_run_xdp()?

In net/core/dev.c, bpf_prog_run_generic_xdp() looks up the persistent device
queue via netif_get_rxqueue(skb) and passes &rxqueue->xdp_rxq to
xdp_convert_skb_to_buff(), which permanently sets rxqueue->xdp_rxq.mem.type=
 to
MEM_TYPE_PAGE_POOL.

In net/bpf/test_run.c, bpf_prog_test_run_xdp() (and xdp_convert_md_to_buff()
when ingress_ifindex is specified) attaches the device's &rxqueue->xdp_rxq
without resetting mem.type:

net/bpf/test_run.c:bpf_prog_test_run_xdp() {
	...
	rxqueue =3D __netif_get_rx_queue(current->nsproxy->net_ns->loopback_dev, 0=
);
	rxqueue->xdp_rxq.frag_size =3D PAGE_SIZE;
	xdp_init_buff(&xdp, rxqueue->xdp_rxq.frag_size, &rxqueue->xdp_rxq);
	...
			page =3D alloc_page(GFP_KERNEL);
			if (!page) {
				ret =3D -ENOMEM;
				goto out_put_dev;
			}

			frag =3D &sinfo->frags[sinfo->nr_frags++];

			data_len =3D min_t(u32, kattr->test.data_size_in - size,
					 PAGE_SIZE);
			skb_frag_fill_page_desc(frag, page, 0, data_len);
	...
}

When a multi-buffer BPF_PROG_TEST_RUN runs on that queue after (or concurre=
ntly
with) generic XDP and the program shrinks and releases a fragment via
bpf_xdp_adjust_tail() or bpf_xdp_pull_data(), the call chain is:

bpf_xdp_shrink_data()
  -> __xdp_return(netmem, MEM_TYPE_PAGE_POOL, false, NULL)
    -> page_pool_put_full_netmem()
      -> page_pool_unref_netmem()

Because the fragment page in bpf_prog_test_run_xdp() was allocated with
alloc_page(GFP_KERNEL) rather than a page_pool, atomic_long_sub_return() in
page_pool_unref_netmem() underflows pp_ref_count from 0 to -1, triggering
WARN_ON(ret < 0) and leaking the page since sinfo->nr_frags has already been
decremented. If the buddy page previously came from a page_pool where
page_pool_return_netmem() cleared page->pp to NULL while leaving
pp_ref_count =3D=3D 1, page_pool_put_unrefed_netmem() will also dereference=
 a NULL
pool pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104121316.1155=
680-1-sst@poczta.fm?part=3D1
