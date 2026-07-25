Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7580396560
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784970531; cv=none; b=W16DQyIGlVNlhEVvl6gxv0NWwgUFnHioKq9PVYNJ5ululVZPcK6NJZGYyWucblAQq5z4zHT8/PMuqjun2sgT6KMQ1IvHwYD8NiYYrohG8JbT63XAiKWEb1ADigknfaP9me1QtazOprkz5VwxmDPyDZn9Ttp7mpb5larH2qXGPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784970531; c=relaxed/simple;
	bh=XzqttnwN/LCfwC31lJCWbAS9SwF7cmnWRyYnLNCqU6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bHZcWzJ1ymE74ck9cLDWDaT2kWjgtwCsbpiKEg2jIyAgXLLyoVRN0Tn6UjUY6QQksoB/S+XoOui/imAOUdvl1geDVArhh1i0OS1UjXvDnFd3kkqbSMLgoBK6fG6nrYJJQ3+YYu0bZ/WFkVpYKkpiCK23SD1nyn6bWZkA8HW9mG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmUA6/dp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmUA6/dp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B621F00A3A;
	Sat, 25 Jul 2026 09:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784970527;
	bh=Gfsw4hTl5d8o/5FpA1DDn/VPVLHXk6RNxXh7L2IwTSU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jmUA6/dpWEDwNH5OSE+0r7xUTbmYOSBgO+ZNtrIbbmZb8CudWs1ibzug7L6lSX+In
	 I8UYwkaFKOwjGBnWxSxN8ldo7nx2MdowlpPQ1JHVTaEAVQBmfNj7nhB6YMyRN04qz7
	 NIblYit4ZqvL5VWibFcO4DQ8TkG8RNFwZAgrVPHUgoHo/wUl9foMM8PFk8PeLeYPHS
	 /I0pb7771Z3KI1UUkNSxM+ixIyFBW/7lESMKJLxgAqvhCy/eQTPYk+MhmDe2XGKGhs
	 KPOQZLEzUTPDKihX0RuwL18lLi5XaNDUcrVg/VXrQsBGeYj4Jyx554SuzRcKr1c9+A
	 qa6unQ13t5hyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: atlantic: convert RX path to
 page_pool
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yangyu Chen" <cyy@cyyself.name>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_771AEE718C41884FA30CDF85E092F693E306@qq.com>
References: <tencent_1F173E0FC1606D2AC704DC9C98AF10984607@qq.com>
 <tencent_771AEE718C41884FA30CDF85E092F693E306@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 09:08:47 +0000
Message-Id: <20260725090847.C8B621F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Encountering an RX packet with more than MAX_SKB_FRAGS fragments c=
auses an infinite NAPI polling loop.
- [High] In the XDP path, if a packet exceeds MAX_SKB_FRAGS, the remainder =
of its fragments are erroneously parsed as independent new packets.
- [High] NULL pointer dereference when an XDP program returns XDP_TX for a =
packet received on the PTP ring.
- [High] Incorrect reporting of dropped XDP frames in `ndo_xdp_xmit` causes=
 dropped frames to be leaked and successfully transmitted frames to be doub=
le-freed.
--

--- Patch [3]: [PATCH net-next v2 3/3] net: atlantic: convert RX path to pa=
ge_pool ---
commit 18978fa8fbab5efde73aa39b92ef15e773290438
Author: Yangyu Chen <cyy@cyyself.name>

net: atlantic: convert RX path to page_pool

The driver currently allocates RX buffers with dev_alloc_pages(), maps
them with dma_map_page(), and uses a hand-rolled page-flip scheme to
subdivide high-order pages. Behind an IOMMU, the map/unmap churn is a
major RX cost. This patch converts RX buffers to page_pool fragments.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.c
> index e1193c6719d9d..9dd8817105942 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c

[ ... ]

> @@ -437,22 +379,15 @@ int aq_xdp_xmit(struct net_device *dev, int num_fra=
mes,
>  }

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for
aq_xdp_xmit() to mislead the caller into freeing the wrong frames?

When a transmission fails, the loop increments drop but does not break
or reorganize the frames array:

        for (i =3D 0; i < num_frames; i++) {
                struct xdp_frame *xdpf =3D frames[i];

                if (aq_nic_xmit_xdpf(aq_nic, ring, xdpf) =3D=3D NETDEV_TX_B=
USY)
                        drop++;
        }

        return num_frames - drop;

If the failure occurs in the middle of the array, the kernel's XDP stack wi=
ll
assume the last drop frames failed and free them. Could this result in a
use-after-free of successfully transmitted frames while they are still being
accessed by hardware, and leak the actual dropped frames?

>  static struct sk_buff *aq_xdp_build_skb(struct xdp_buff *xdp,

[ ... ]

> @@ -503,7 +446,6 @@ static struct sk_buff *aq_xdp_run_prog(struct aq_nic_=
s *aq_nic,
>  		u64_stats_update_begin(&rx_ring->stats.rx.syncp);
>  		++rx_ring->stats.rx.xdp_tx;
>  		u64_stats_update_end(&rx_ring->stats.rx.syncp);
> -		aq_get_rxpages_xdp(buff, xdp);
>  		break;

[Severity: High]
This is a pre-existing issue, but could this dereference a NULL pointer
if an XDP program returns XDP_TX for a packet on the PTP ring?

The PTP RX ring shares the RX clean path, meaning __aq_ring_xdp_clean() and
aq_xdp_run_prog() are executed for it. If an XDP program returns XDP_TX:

        tx_ring =3D aq_nic->aq_ring_tx[rx_ring->idx];
        result =3D aq_nic_xmit_xdpf(aq_nic, tx_ring, xdpf);

Since the PTP TX ring is never placed into the aq_ring_tx array during
allocation, tx_ring would be NULL here.

>  	case XDP_REDIRECT:

[ ... ]

> @@ -546,8 +489,11 @@ static bool aq_add_rx_fragment(struct device *dev,
>  	do {
>  		skb_frag_t *frag;
> =20
> -		if (unlikely(sinfo->nr_frags >=3D MAX_SKB_FRAGS))
> +		if (unlikely(sinfo->nr_frags >=3D MAX_SKB_FRAGS)) {
> +			/* Attached frags must reach xdp_return_buff() */
> +			xdp_buff_set_frags_flag(xdp);
>  			return true;
> +		}

[Severity: High]
This isn't a bug introduced by this patch, but does the early return in
aq_add_rx_fragment() leave remaining descriptors uncleaned?

If a packet exceeds MAX_SKB_FRAGS, it seems aq_add_rx_fragment() aborts
and returns true without setting buff_->is_cleaned =3D 1 on the rest of the
fragments.

Then, in __aq_ring_xdp_clean(), the outer loop continues, increments sw_hea=
d,
and encounters those uncleaned fragments:

                if (!buff->is_eop) {
                        if (aq_add_rx_fragment(dev, rx_ring, buff, &xdp)) {
                                ...
                                xdp_return_buff(&xdp);
                                continue;
                        }
                }

Since their is_cleaned flag is false, could they be treated as the start of=
 a
brand new packet and erroneously passed to the XDP program?

>  		frag =3D &sinfo->frags[sinfo->nr_frags++];

[ ... ]

> @@ -674,6 +625,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self,=
 struct napi_struct *napi,
>  			err =3D -ENOMEM;
>  			goto err_exit;
>  		}
> +		skb_mark_for_recycle(skb);

[Severity: High]
This is a pre-existing issue, but I have a question about the error handling
in __aq_ring_rx_clean().

If hardware aggregates a packet resulting in more than MAX_SKB_FRAGS fragme=
nts
(for example, via LRO), the code takes this error path before getting here:

        if (unlikely(!is_rsc_completed) ||
            frag_cnt > MAX_SKB_FRAGS) {
                err =3D 0;
                goto err_exit;
        }

Does this exit the function without advancing sw_head or consuming the
malformed multi-fragment packet? On the next NAPI poll, it seems the exact
same state would be encountered, permanently stalling the queue in an infin=
ite
loop.

>  		if (is_ptp_ring)
>  			buff->len -=3D

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_1F173E0FC16=
06D2AC704DC9C98AF10984607@qq.com?part=3D3
