Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144B133F8A6
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790220208; cv=none; b=Xqz912EvFGXntNiVv+IM6ZO6jm4/ARegSYWOexll1R0wx99UniDeiRgCOVDh8KaCvxFHAU0wi3YgWZnBws3FVh5DMZK5QvSy9jAz7YI0E12OzYn29D9W93ncLoNV/kfeU5F8oK03Fp2x35Pj9LZj54Kq8orpE1E3PG1WwxjODyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790220208; c=relaxed/simple;
	bh=7j68uBAjN0Nos9pKxocccLhVwb2ZqyqPYfEreksTefY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ozioJ33uQ3i8VcT4gtsWqDzSf6pRxFarfNCC43Elw0vpIld4Q98bzVYlLjdy+EiKHHSWUfYmp4iH5pmw0aJj8HXPj4Mf/ZSWlGzX9iAWbbsVHpGdnbtxmmmjMY/ra4lYRkypF558xo5eFBvzpVKvqloG7zaKHnfOM1M3em36Oa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9lcZPOC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9lcZPOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7927A1F000FF;
	Thu, 24 Sep 2026 03:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790220206;
	bh=D84nWeZlkIYksXx6LmfWYne/U1vuJSpQsMOiHnC30rQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b9lcZPOC14qWizuerHM//CysfgZYze2Pfh85c2zWbgDxe0PpxHS3rd5uaK+z5aJvT
	 7Gt2A+1B49jWFAvFfOgLMGlATZGkWwmlWV4khg/Fvsk2TnA4eX4OPxbQ4Y8qGljDpF
	 8feBFon2EBNsvr4MC0ggTxwiDnlzN1+iTBnf08KN4rfMcDpXHqH4NnhJuR1bz1ilJL
	 4cVoSphlD7/SaAhRJRPgXqw3LOeqeMExsCP9kDxpi8VvXj0jjsIzfwofOCQdomnXqb
	 4SQ6+x1slYiBC2S9Nne9mT3PHPdRK090+VjWx7Xdsf+O4wBsrE4IYmUKTgprNhrFwA
	 nw2/+qYDJju2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260923032217.1732753-2-rkannoth@marvell.com>
References: <20260923032217.1732753-1-rkannoth@marvell.com>
 <20260923032217.1732753-2-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 03:23:26 +0000
Message-Id: <20260924032326.7927A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: octeontx2: lost updates to nic->flags due to non-atomic RMW i=
n otx2_sync_flags_from_rep()
--

commit 5abf537369dcb5cbbccf3809e8b59256537cd8b9
Author: Ratheesh Kannoth <rkannoth@marvell.com>

octeontx2: use atomic bitops for PF/VF and rep flags

This commit changes the flags field in PF/VF and representor structures
from a u64 bitmask to an unsigned long bitmap manipulated via atomic
bitops. It also introduces otx2_sync_flags_from_rep() to copy
representor-owned flags onto the PF context.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index 5850bc1870a1d..b146ca4be5db1 100644
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
> +static inline void otx2_clear_flag(struct otx2_nic *nic, unsigned int fl=
ag)
> +{
> +	clear_bit(flag, &nic->flags);
> +}
> +
> +static inline bool otx2_test_flag(struct otx2_nic *nic, unsigned int fla=
g)
> +{
> +	return test_bit(flag, &nic->flags);
> +}
> +
> +static inline void otx2_sync_flags_from_rep(struct otx2_nic *dst,
> +					    unsigned long *src_flags)
> +{
> +	unsigned long src =3D READ_ONCE(*src_flags);
> +	unsigned long new_flags;
> +
> +	new_flags =3D (READ_ONCE(dst->flags) & ~OTX2_REP_SYNC_FLAGS_MASK) |
> +		    (src & OTX2_REP_SYNC_FLAGS_MASK);
> +	WRITE_ONCE(dst->flags, new_flags);

[Severity: High]
Does this non-atomic read-modify-write on dst->flags race with concurrent
atomic bit updates?

If another thread modifies a bit in dst->flags (for example, setting
OTX2_FLAG_PORT_UP from an asynchronous mailbox event workqueue) between the
READ_ONCE() and the WRITE_ONCE(), that update would be silently overwritten
and lost.

> +}
> +
>  static inline bool is_otx2_lbkvf(struct pci_dev *pdev)
>  {
>  	return (pdev->device =3D=3D PCI_DEVID_OCTEONTX2_RVU_AFVF) ||
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/n=
et/ethernet/marvell/octeontx2/nic/rep.c
> index 0f5d5642d3f7a..7df82c22cc12b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> @@ -109,14 +109,14 @@ static int rvu_rep_setup_tc_cb(enum tc_setup_type t=
ype,
>  	struct rep_dev *rep =3D cb_priv;
>  	struct otx2_nic *priv =3D rep->mdev;
> =20
> -	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
> +	if (!test_bit(OTX2_FLAG_REP_VF_INITIALIZED, &rep->flags))
>  		return -EINVAL;
> =20
> -	if (!(rep->flags & OTX2_FLAG_TC_FLOWER_SUPPORT))
> +	if (!test_bit(OTX2_FLAG_TC_FLOWER_SUPPORT, &rep->flags))
>  		rvu_rep_mcam_flow_init(rep);
> =20
>  	priv->netdev =3D rep->netdev;
> -	priv->flags =3D rep->flags;
> +	otx2_sync_flags_from_rep(priv, &rep->flags);

[Severity: High]
Is it possible for this call to race with concurrent hardware link events?

Because otx2_sync_flags_from_rep() performs a non-atomic update to=20
priv->flags, if an asynchronous hardware event attempts to set or clear a=20
bit in priv->flags while this is executing, the hardware state change=20
could be discarded, leading to incorrect device state.

>  	priv->pcifunc =3D rep->pcifunc;
>  	priv->flow_cfg =3D rep->flow_cfg;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923032217.1732=
753-1-rkannoth@marvell.com?part=3D1
