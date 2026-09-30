Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42C48664A
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790810016; cv=none; b=cRXoTFzEJGngFeVlAVPNkP9+n0UAoosjQ2lbR2FG+5wLhmYAj0SzUA5+oVGu0g9iJ7H4dwVxEp/5qcSpHn2xBDEV6yVW7+RKB0vE6vt30VNxNO0mNZ9JETE0zBsj5VbMESJmBbk6TR2ZlIy+EgLH3Mrr77Y2Zj549I/SyF9HLPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790810016; c=relaxed/simple;
	bh=8mJ8guRN+jfnd/mk6kYAbNCZ8fFg9OHtX42MJ3+9pFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YRyRKHw3LfVyHCqEkhvie3WqZdPTMUWdAia3bJsrCKPlRfpfVx1dgYtjtyCuovWvxHM+ds4B2hnITwOpmJ+HLrVmxpabLFVrftrm0kQ2DHCHuP4Dv8GY07T/yRqDnvF8A7+kytzSwzVdWrf4g9zHaewGFqg/4HYoYNT4/24P+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOZSJ5UX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOZSJ5UX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2051F000FF;
	Wed, 30 Sep 2026 23:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790810011;
	bh=m/dbSeY0mZJErrHNySCBFT8/+xKJbeL+wUW4O4djKng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aOZSJ5UXy40VBt6rMel3aHQ0t9ck/JdYrvpppZfgsrnKtTsqd8yZDsy2vFaatmaZv
	 wlx8GFkt7+Ey3EiFhKZr2LeFWd3d12ogJDP+ydMK70h2/Vbk6XuYI+6isdSAHTRbL+
	 Ln1s27MrnYTRWuB2APFjok1bZj916kwYPP4zNxIlyEV9tEctWYs4B+c7kvkrX4t5b8
	 Ns3qi4Fv2zsiohs2PxAzelLZAuxSkQ848lQ5sUyk0oCpAFXJG5tv2Dntmk7rvIRDNp
	 SyWKGlWv2mZzr7LOMfhXevE1Uh4hEiBEOKW8PXDcLJxPtOsOejPkjd7OtZs388sVuW
	 ogbbVqG7ZmPKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/2] idpf: add flow-based XDP fallback for FWs
 without Tx FIFO support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tony Nguyen" <anthony.l.nguyen@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260929231305.1515873-2-anthony.l.nguyen@intel.com>
References: <20260929231305.1515873-1-anthony.l.nguyen@intel.com>
 <20260929231305.1515873-2-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 23:13:30 +0000
Message-Id: <20260930231331.1E2051F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] idpf: data race on pending_mask and last_ntu in XDP Tx finalize
- [High] idpf: out-of-bounds write in idpf_xdpsq_poll_fb due to unvalidated=
 completion tag
- [Medium] idpf: mixing goto-based cleanup and __free() in idpf_xdpsqs_get
--

commit 512d4db75f1d8f6ab37619b2712b334a77a2df35
Author: Alexander Lobakin <aleksander.lobakin@intel.com>

idpf: add flow-based XDP fallback for FWs without Tx FIFO support

This commit introduces a static-key guarded flow-based XDP fallback for
firmware that lacks queue-based scheduling support. It generates a
completion for each Tx descriptor and serializes them using a dynamically
allocated bitmap.

> diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet=
/intel/idpf/xdp.c
> index cbccd45467681..c771663677a52 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.c
> +++ b/drivers/net/ethernet/intel/idpf/xdp.c
> @@ -149,10 +151,12 @@ void idpf_xdp_copy_prog_to_rqs(const struct idpf_q_=
vec_rsrc *rsrc,
> =20
>  static void idpf_xdp_tx_timer(struct work_struct *work);
> =20
> -int idpf_xdpsqs_get(const struct idpf_vport *vport)
> +int idpf_xdpsqs_get(struct idpf_vport *vport)
>  {
>  	struct libeth_xdpsq_timer **timers __free(kvfree) =3D NULL;
> -	struct net_device *dev;
> +	unsigned long **masks __free(kvfree) =3D NULL;

[ ... ]

> +	masks =3D kvzalloc_objs(*masks, vport->num_xdp_txq);
> +	if (!masks)
> +		goto err_masks;

[ ... ]

> +err_masks:

[Severity: Medium]
Is it safe to mix goto statements with __free() scope-based cleanups in
idpf_xdpsqs_get?

The cleanup subsystem guidelines recommend that functions should either use
scope-based cleanups entirely or rely on goto-based cleanups, but never
mix both. Mixing them can lead to confusing ownership semantics and
double-free or resource leak bugs.

> +	vport->xdpsq_fb =3D false;
> +
> +	for (u32 i =3D 0; i < vport->num_xdp_txq; i++)
> +		kfree(timers[i]);
> +
> +	return -ENOMEM;
>  }

[ ... ]

> @@ -250,6 +308,65 @@ static int idpf_xdp_parse_cqe(const struct idpf_spli=
tq_4b_tx_compl_desc *desc,
>  	return upper_16_bits(val);
>  }
> =20
> +static u32 idpf_xdpsq_poll_fb(struct idpf_tx_queue *xdpsq, u32 budget)
> +{

[ ... ]

> +	for (done_frames =3D 0; done_frames < budget; ) {
> +		int ret;
> +
> +		ret =3D idpf_xdp_parse_cqe(&cq->comp[ntc].common, gen);
> +		if (ret >=3D 0) {
> +			__clear_bit(ret, mask);

[Severity: High]
Could this result in an out-of-bounds write?

The 16-bit completion tag parsed from hardware by idpf_xdp_parse_cqe() is
used directly as an index for __clear_bit(). Since the mask is sized based
on desc_count, a completion tag larger than desc_count returned from the
hardware or firmware might cause an out-of-bounds write in the kernel
heap.

Should the tag value be validated against desc_count before using it as a
bitmap index?

> +			done_frames++;


> diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet=
/intel/idpf/xdp.h
> index 63e56f7d43e00..95e47ea2ccba8 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.h
> +++ b/drivers/net/ethernet/intel/idpf/xdp.h
> @@ -93,12 +93,34 @@ static inline void idpf_xdp_tx_xmit(struct libeth_xdp=
_tx_desc desc, u32 i,
>  #endif
>  }
> =20
> -static inline void idpf_xdpsq_set_rs(const struct idpf_tx_queue *xdpsq)
> +static inline void idpf_xdpsq_set_rs_fb(struct idpf_tx_queue *xdpsq)
> +{
> +	u32 ntu =3D xdpsq->next_to_use;
> +	u32 old =3D xdpsq->last_ntu;
> +
> +	if (old > ntu) {
> +		bitmap_set(xdpsq->pending_mask, old, xdpsq->desc_count - old);

[Severity: High]
Could there be a data race on pending_mask and last_ntu here?

When idpf_xdp_tx_finalize() calls idpf_xdpsq_set_rs_fb(), the xdp_lock may
have already been released (for example, by the bulk flush callback).

If multiple CPUs submit XDP frames concurrently when xdpsq_share is true,
it appears we could have unprotected, concurrent, non-atomic bitmap_set()
operations and updates to last_ntu. This might also race with the
__clear_bit() operations from the consumer context in
idpf_xdpsq_poll_fb().

> +		if (ntu)
> +			bitmap_set(xdpsq->pending_mask, 0, ntu);
> +	} else {
> +		bitmap_set(xdpsq->pending_mask, old, ntu - old);
> +	}
> +
> +	xdpsq->last_ntu =3D ntu;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929231305.1515=
873-1-anthony.l.nguyen@intel.com?part=3D1
