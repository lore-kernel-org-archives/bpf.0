Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B397430567F
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 06:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935144; cv=none; b=VpbrxrU/d2KGpz39zVMO4WD7iw4Lr2M9D4/zheQUQC7dThJWJsEZRVzvBJC7nGcWcV1mRa0AQj6PytStHl8Tncf3b1slkF/8xQ5DHqj+2zK1UcCjuiPJE7f5rHEAySbfhY/itOZeBvZdxbJivNK/k8rSieFOPErgbXWbbszJ0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935144; c=relaxed/simple;
	bh=IalU4VNeJHk8ML5KLI5OspeqrIr8RTuzI6eVNKkAjVI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pq+D9GZ+ZanM3golzQeuEiFXxzJUr5pSVHRKX1Yu2EddTy2qnmRYXgyKbtmKTZGtQyiXTaYDtWPbY12Gn1F9eymLufSrtuTBlyJmkzUHdvRToiRQiA9t8mtkdulrtlGLm3UE/C8vXQEZytvoOTsLdYSujL4eCr8Bdag+LGiTteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeDk+Ls7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeDk+Ls7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851BF1F00A3A;
	Wed,  9 Sep 2026 06:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788935143;
	bh=eLf+x/iSmt02QWz7GDMow65kHhgGM401kL+QiPHeeNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PeDk+Ls70W5h1p7f/QfTmgP5P0Af7Y++TnUwrNCumN7LsSjYOUmoXWe7+E7ClDllE
	 bGAwwf/5bVHGnvpBUdfbJYW8dSGu3sDZGpSaRZUcKNjWE8dprhbD4AwGlB1gbBmqFv
	 HRBzXg1zqOMuzC4/mOL8ReyACh1UloT5UZZCqR8NvwKvJ9mv/ZSLmsJ4PiXCXrCobi
	 krPJdEEZ3+jmN4q5SzxTIUa8WD5burMqwWSC4ffbTOWBLXid8ezjfX14m8kOTzAJZV
	 RHzTMrc2NkHKOP/2l8wdtN+w4F6dMzwNVvov0QAB6AX/lKC87lGR0z873mjx9u+bF7
	 OGojzbYiG+brA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260908062437.251739-1-rkannoth@marvell.com>
References: <20260908062437.251739-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 06:25:43 +0000
Message-Id: <20260909062543.851BF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Data Race / Invalid Cast: Mixing atomic bit operations with non-at=
omic bitwise operations on `u64 pf->flags` causes data races and memory cor=
ruption.
- [Medium] State Desynchronization: Failing to clear hardware shapers in `o=
tx2_mqprio_down()` skips software state cleanup, permanently bricking mqpri=
o state.
--

commit e74bdebdda4c26c75ad9a6fe1f2ba38bec570025
Author: Ratheesh Kannoth <rkannoth@marvell.com>
Subject: octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

This commit adds mqprio bandwidth offload for channel-mode mqprio with
TC_MQPRIO_SHAPER_BW_RATE. It programs per-queue MDQ CIR/PIR through the NIX
TX scheduler mailbox for each non-QoS transmit queue. The patch also manages
the tearing down and rebuilding of the TX scheduler hierarchy when adding or
replacing the qdisc.

Link: https://lore.kernel.org/netdev/20260904031553.3196916-1-rkannoth@marv=
ell.com/

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -907,11 +907,13 @@ static int otx2_mbox_up_handler_rep_event_up_notify=
(struct otx2_nic *pf,
> =20
>  	if (info->event =3D=3D RVU_EVENT_PORT_STATE) {
>  		if (info->evt_data.port_state) {
> -			pf->flags |=3D OTX2_FLAG_PORT_UP;
> +			set_bit(__builtin_ctzll(OTX2_FLAG_PORT_UP),
> +				(unsigned long *)&pf->flags);

[Severity: High]
Could mixing atomic bit operations here with non-atomic bitwise operations
elsewhere cause data races and memory corruption?

For example, otx2_open() updates pf->flags using non-atomic read-modify-wri=
te
operations:

    pf->flags &=3D ~OTX2_FLAG_INTF_DOWN;
    pf->flags &=3D ~OTX2_FLAG_PORT_UP;

If an asynchronous link event triggers the mbox handler to update
OTX2_FLAG_PORT_UP atomically while otx2_open() is non-atomically
modifying pf->flags, the atomic updates could be overwritten and lost.

Additionally, casting a u64 pointer to an unsigned long pointer for
atomic operations can corrupt memory on 32-bit big-endian architectures.

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
[ ... ]
> +int otx2_mqprio_down(struct otx2_nic *pfvf)
> +{
> +	int err =3D 0;
> +
> +	if (!pfvf->mqprio.rate_limit)
> +		return 0;
> +
> +	if (netif_running(pfvf->netdev) &&
> +	    otx2_mqprio_mdq_allocated(pfvf))
> +		err =3D otx2_nix_tm_clear_queue_shaper(pfvf);
> +
> +	if (err) {
> +		netdev_err(pfvf->netdev,
> +			   "mqprio: failed to clear hardware shapers: %d\n",
> +			   err);
> +		return err;

[Severity: Medium]
Does returning early here permanently desynchronize the software state if
clearing the hardware shapers fails?

When removing the mqprio qdisc via a tc qdisc del command, the kernel
calls ndo_setup_tc with hw=3D0 and ignores the return value. If
otx2_nix_tm_clear_queue_shaper() fails (for instance, due to a mailbox
timeout), returning early skips the call to otx2_mqprio_clear_sw().

Since the kernel unconditionally destroys the qdisc software object, the
driver will continue to incorrectly enforce rates during ndo_open and
reject features like XDP, PFC, and HTB because it falsely believes
mqprio is still active.

> +	}
> +
> +	otx2_mqprio_clear_sw(pfvf);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908062437.2517=
39-1-rkannoth@marvell.com?part=3D1
