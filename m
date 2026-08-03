Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577862F8E9D
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772013; cv=none; b=dqj5WBgiu8pKW1mpNPqHAuIPly6VPodEM4Y7iW9IJKoM712Gkon7QuYAeKG9vnf3OFFOBZ5VwGhRkZYo4irC8Usteq6qxxfhuPDuX7cfJQdSAZqGfl8JGROg558jaeZifGNB0NpuuXFlZqLUdhX9kWnTHnFI9v73O7NEJpycQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772013; c=relaxed/simple;
	bh=D5XeTpMhy7wrWhy2lDXo+e9TWZiKH/3jGcnopJkhWL4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OMb2b8PIa6AYat5CMWcL1Mr2/H0DIYQPb+S/d+yb52CVgtmwEHoO77svSvIdqkKzFdjJD0+g0k0UBmD1dJcUM6tVvRgjf4lcqCBfo7fkNFtkXoxyM+6AYrF5d/NXReywabuOOd/ctIxQQYduTkjF0/GHFuZLO2BEW/huNPBr29Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDuD0qbU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDuD0qbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBA41F000E9;
	Mon,  3 Aug 2026 15:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785772012;
	bh=J+2Zcrm04n68cRcK+S79Htk+JG5PdOEJn1fvxchVfJM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EDuD0qbUTMkpAQoFlVzdm8JAwrgMyA790IAVFOhqytn0tzJqyHghC6F9RD28NAH5b
	 2O+c6KfDlUom+8OdvFRvdJA4PAtZX+V1LkdGU7d4sUMjnWa6FslAKL02drZ5T221Jl
	 H6Th8XwvICU06Ccvz51qFMYlaxwy/K6fsYeD0bxcf0FMA23jwCUm6QX8R0tG6fFV1J
	 lAL+UkL6vBq1tz+p4YCyC4L8pcMms29oyXdKPIggW6JFhctuAI+gAvHouqA0Ou0npm
	 9ugPOTGo3XrB/kEJZfQ1y8RxFIm5tpgnIYX8NlcH7RyjwY3m9aiByzIRrtG6+OGvU9
	 awp7v1A9URsqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] net: atlantic: free stranded TX buffers on ring
 deinit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yangyu Chen" <cyy@cyyself.name>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_EEDC35FAF2750A3A6A0B39BAE0E2C484860A@qq.com>
References: <tencent_29B860317921D68DE77C718242DA418EB608@qq.com>
 <tencent_EEDC35FAF2750A3A6A0B39BAE0E2C484860A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 15:46:50 +0000
Message-Id: <20260803154651.EFBA41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] `aq_xdp_xmit()` does not break on transmission failures or com=
pact the frames array, leading to double-frees and memory leaks.
- [High] `aq_ptp_ring_deinit()` uses `aq_ring_tx_clean()` instead of `aq_ri=
ng_tx_deinit()`, leaving the PTP TX ring vulnerable to the same stranded bu=
ffer memory leak.
--

--- Patch [1]: [PATCH net 1/2] net: atlantic: free stranded TX buffers on r=
ing deinit ---
commit 80ef845583443e3da7aeeb279e31f6845d6e1812
Author: Yangyu Chen <cyy@cyyself.name>
net: atlantic: free stranded TX buffers on ring deinit

This commit brings back aq_ring_tx_deinit() to replace aq_ring_tx_clean()
during TX ring deinitialization. This ensures that completed descriptors
beyond the clean budget and frames stuck between hw_head and sw_tail are
properly freed, resolving a memory leak when an interface goes down.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.c
> index 8ff07de2bd524..81685a4dc5a6d 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> @@ -360,6 +360,35 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
>  	return !!budget;
>  }
> =20
> +void aq_ring_tx_deinit(struct aq_ring_s *self)
> +{
> +	if (!self)
> +		return;
> +
> +	for (; self->sw_head !=3D self->sw_tail;
> +		self->sw_head =3D aq_ring_next_dx(self, self->sw_head)) {
> +		struct aq_ring_buff_s *buff =3D &self->buff_ring[self->sw_head];
> +		struct device *ndev =3D aq_nic_get_dev(self->aq_nic);
> +
> +		if (buff->is_mapped) {
> +			if (buff->is_sop) {
> +				dma_unmap_single(ndev, buff->pa, buff->len,
> +						 DMA_TO_DEVICE);
> +			} else {
> +				dma_unmap_page(ndev, buff->pa, buff->len,
> +					       DMA_TO_DEVICE);
> +			}
> +		}
> +
> +		if (buff->is_eop) {
> +			if (buff->skb)
> +				dev_kfree_skb_any(buff->skb);
> +			else if (buff->xdpf)
> +				xdp_return_frame(buff->xdpf);
> +		}
> +	}
> +}

[Severity: Critical]
This is a pre-existing issue, but while we are looking at XDP frame handling
in this file, does aq_xdp_xmit() handle transmission failures correctly?

In aq_xdp_xmit(), if aq_nic_xmit_xdpf() fails, it just increments a drop
counter and continues:

drivers/net/ethernet/aquantia/atlantic/aq_ring.c:aq_xdp_xmit() {
    ...
	for (i =3D 0; i < num_frames; i++) {
		struct xdp_frame *xdpf =3D frames[i];

		if (aq_nic_xmit_xdpf(aq_nic, ring, xdpf) =3D=3D NETDEV_TX_BUSY)
			drop++;
	}

	return num_frames - drop;
}

Callers of ndo_xdp_xmit (like bq_xmit_all() in kernel/bpf/devmap.c) assume a
return value of N means the first N contiguous frames in the array were
successfully transmitted, and they free the remaining frames starting at
index N.

If aq_xdp_xmit() processes 3 frames, fails on the first, and succeeds on the
next two, it returns 2.

Will the caller then free frames[2] which was successfully queued to the NI=
C,
causing a double-free, while leaking the failed frames[0]?

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/ne=
t/ethernet/aquantia/atlantic/aq_vec.c
> index 2f9033ceed8ce..05814fea0f5f7 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
> @@ -275,7 +275,7 @@ void aq_vec_deinit(struct aq_vec_s *self)
> =20
>  	for (i =3D 0U; self->tx_rings > i; ++i) {
>  		ring =3D self->ring[i];
> -		aq_ring_tx_clean(&ring[AQ_VEC_TX_ID]);
> +		aq_ring_tx_deinit(&ring[AQ_VEC_TX_ID]);

[Severity: High]
This isn't a bug introduced by this patch, but does the PTP TX ring need the
same fix?

Looking at aq_ptp_ring_deinit(), the PTP TX ring is still deinitialized
using aq_ring_tx_clean():

drivers/net/ethernet/aquantia/atlantic/aq_ptp.c:aq_ptp_ring_deinit() {
    ...
	aq_ring_tx_clean(&aq_ptp->ptp_tx);
	aq_ring_rx_deinit(&aq_ptp->ptp_rx);
}

If the interface is brought down while PTP traffic is in flight, will this
lead to the exact same memory leak of SKBs and DMA mappings for the PTP ring
when it is subsequently freed?

>  		aq_ring_rx_deinit(&ring[AQ_VEC_RX_ID]);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_29B86031792=
1D68DE77C718242DA418EB608@qq.com?part=3D1
