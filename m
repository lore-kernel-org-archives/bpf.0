Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0FE3515DC
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735418; cv=none; b=lTVs1PISJg+dn0qcXb0nnt4YqiCA5qhKHSKKjsko4p1Ri8RxUTdsZlqI5PYVCOfvXDmFuQpl8yJu6So1KmPmpyb7KIhV/gymNHIknrkfPN46l0YK8F6f3pl6eKJx0KXH3E9ZmzbJIOBU9+mvEeErCzk9CFvtSoelAiIhXHFb26o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735418; c=relaxed/simple;
	bh=6MnXO5XHM9/z5MNCvqDINWWIF070LPbA4y5Nrm8GWHc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nBY5uHQBcx/n6i3Beq6bCpzI3eKqwKIEWms85mE+0Tu1RNRb6468idcwItR6dfxgqb+V/V7MGBW9D6Y+g3zOnw4SHEO/orNd1j6qfDP44FDt4Bu2Cv4NdflyqJoT8zFq9Y8lZ8FsDzDkNzB/VX+H6EIBENGLAebec947CyXHsFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpZWbNbK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpZWbNbK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A551F000FF;
	Wed, 30 Sep 2026 02:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735416;
	bh=EiX1am/CK+BkIPyaLOo7PBNIV7Wx/6Eq00GZ+LlUoCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GpZWbNbKWtCyqZtqWX23QJFYKAsSQ9iToTMBW2lj/Usxa/0Q+lgxHH4+Y00i1DJKR
	 XRRXahywweNDUMJFONItpDwPgrsXtwsBD1cdp8/8R13o7tZeHUBPmK/uw0YG0kDuL5
	 ubsaToXWeBccBDnEKiec++ylQyHbxwcHTyi8JZ90I4lHiTTJsIkwdUxLouPo0/UxYn
	 axYYAzNwQ/NeZAXnQsGzCJHNuTjrBElCJGbjVOswHFQ465str3Uxg95S9k8ReKsMq0
	 ndJ4VHklUKhj5ByoVtnzY6iovTMS4oiZmEk6T9iaMbCczikVhq+gnEDSTb4TwopnCh
	 gcKNLfc+RPcyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260929022915.2704627-2-rkannoth@marvell.com>
References: <20260929022915.2704627-1-rkannoth@marvell.com>
 <20260929022915.2704627-2-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 02:30:15 +0000
Message-Id: <20260930023016.21A551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: octeontx2: non-atomic flags sync clobbers concurrent atomic b=
itops
--

commit 7297391279ac6b1794cb03ec3bcedc49fd752258
Author: Ratheesh Kannoth <rkannoth@marvell.com>

octeontx2: use atomic bitops for PF/VF and rep flags

This commit switches PF/VF and representor flags from non-atomic masks to
unsigned long bitmaps using atomic bit operations. It also relocates
representor VF initialization bits and introduces a helper to locklessly
sync representor flags onto the PF mailbox context.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h

[ ... ]

> @@ -593,6 +607,32 @@ struct otx2_nic {
>  	unsigned long		*af_xdp_zc_qidx;
>  };
> =20
> +static inline void otx2_set_flag(struct otx2_nic *nic, unsigned int flag)
> +{
> +	set_bit(flag, &nic->flags);
> +}
> +

[ ... ]

> +static inline void otx2_sync_flags_from_rep(struct otx2_nic *dst,
> +					    unsigned long *src_flags)
> +{
> +	unsigned long src =3D READ_ONCE(*src_flags);
> +	unsigned long new_flags;
> +
> +	new_flags =3D (READ_ONCE(dst->flags) & ~OTX2_REP_SYNC_FLAGS_MASK) |
> +		    (src & OTX2_REP_SYNC_FLAGS_MASK);
> +	WRITE_ONCE(dst->flags, new_flags);
> +}

[Severity: High]
Can this cause lost atomic updates? The patch converts flags to be modified
by atomic bitops like set_bit() and clear_bit(). However, this helper
performs a non-atomic read-modify-write (READ_ONCE followed by WRITE_ONCE)
over the entire dst->flags word.

If a concurrent path atomically sets a flag (such as OTX2_FLAG_INTF_DOWN or
OTX2_FLAG_PORT_UP) right between the READ_ONCE and WRITE_ONCE, the
WRITE_ONCE will overwrite the memory with the stale value, silently erasing
the concurrent atomic bit operation. This is reachable from the TC flower
offload setup path which calls rvu_rep_setup_tc_cb().

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/dri=
vers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c

[ ... ]

> @@ -599,11 +599,11 @@ int otx2_napi_handler(struct napi_struct *napi, int=
 budget)
> =20
>  	if (workdone < budget && napi_complete_done(napi, workdone)) {
>  		/* If interface is going down, don't re-enable IRQ */
> -		if (pfvf->flags & OTX2_FLAG_INTF_DOWN)
> +		if (otx2_test_flag(pfvf, OTX2_FLAG_INTF_DOWN))
>  			return workdone;

[Severity: High]
Because the NAPI handler heavily relies on OTX2_FLAG_INTF_DOWN to halt
processing and prevent use-after-free scenarios during teardown, erasing
this flag via the race condition in otx2_sync_flags_from_rep() could result
in otx2_napi_handler() continuously polling freed resources.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/n=
et/ethernet/marvell/octeontx2/nic/rep.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c

[ ... ]

> @@ -632,7 +632,7 @@ void rvu_rep_destroy(struct otx2_nic *priv)
>  	int rep_id;
> =20
>  	rvu_eswitch_config(priv, false);
> -	priv->flags |=3D OTX2_FLAG_INTF_DOWN;
> +	otx2_set_flag(priv, OTX2_FLAG_INTF_DOWN);
>  	rvu_rep_free_cq_rsrc(priv);

[Severity: High]
If the OTX2_FLAG_INTF_DOWN flag set here is immediately overwritten by the
non-atomic flag sync mentioned above, NAPI polling can continue executing
concurrently while rvu_rep_free_cq_rsrc() tears down the queues, leading to
a use-after-free crash on teardown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929022915.2704=
627-1-rkannoth@marvell.com?part=3D1
