Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFEF2BEFF5
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101880; cv=none; b=PzoQQYWlKKOIxN0OP+c0R0t2txQ2D6SitrwcWIoswCiBrCc7HSikpkxcizMuqZQTYwXxmS05mGr9oJJPgYtWFUsTpPsjPV/D2XwPp9bqti81/QraKDVhfVGqFs0gI+E+yAe81cYCz28rzc5QzqWscfYbJy9oqhSsz76EdsiigI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101880; c=relaxed/simple;
	bh=qhggU2z2DYyVitCNTLz7LwrtDmOeM/nTYRgyACMCtwk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xbu84rP7y4hpVdxhc7VavTiMGFBD0lVFZdUs7h1z5xD45twpTjvs38bSXfMczIVEE3YIe/5jqs+M0AMrEX3P5p18+pLP9zvq35fr/L07UYn9VhWJ04S9qavhHxMHNaVBsw3nAKmhObqt1mHE2q2TDIKJRCHtGMtf2J/hfjPtjE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbBgGNOm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbBgGNOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC4B1F00893;
	Sat, 30 May 2026 00:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101879;
	bh=1Betip9F4Cayr791zjwo/xRwnVQcJCTFqAOgvLQFhkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZbBgGNOmX9LU/8F81EfmEuvycxmRn+DQ7H63OfZxsS1gZ3DKjiRSqJEEnZlRAAUtr
	 W9cpqDmgS1sqA0lkVu1UgJF7+72RLXAj7tyqH/7qrvE17KOyZxrdumzeMkshQ1Hkju
	 NLByg02VLC0BSM8CmObB6enzzx+7z94SvvInUcwypMLnO+dj+TO0ZmC87x3bWS+nbB
	 +tQjNv81LWmdAXNEMaeczb2Urp0gDr5pNc7sBPkebq48qQJcsAcS9IoLw49oTpRyFp
	 0oL8VpJzNCEEFKn94Y/h/xCqHaerXRxfhy6uQMwN1on+/rgsDpfQqhLJjHZxZh42x2
	 H/i2ekCtJjroQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 06/13] net: lan966x: add FDMA ops dispatch
 for PCIe support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520-lan966x-pci-fdma-v5-6-ca56197ae05b@microchip.com>
References: <20260520-lan966x-pci-fdma-v5-6-ca56197ae05b@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:44:38 +0000
Message-Id: <20260530004438.CBC4B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition leading to NULL pointer dereference, and improper e=
rror cleanup causing active NAPI deletion during probe.
--

commit 451c636b2ada8ed9e0353b85f81b6fd1d9682b69
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add FDMA ops dispatch for PCIe support

This commit introduces an ops table for FDMA operations to support
different implementations for platform and PCIe instances. It plumbs
the various FDMA functions through this new ops structure.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_main.c
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c

[ ... ]

> @@ -1234,7 +1249,7 @@ static int lan966x_probe(struct platform_device *pd=
ev)
>  	if (err)
>  		goto cleanup_fdb;
> =20
> -	err =3D lan966x_fdma_init(lan966x);
> +	err =3D lan966x->ops->fdma_init(lan966x);
>  	if (err)
>  		goto cleanup_ptp;

[Severity: High]
This isn't a bug introduced by this patch, but looking at the probe
sequence, could this late initialization of FDMA lead to a NULL pointer
dereference?

Earlier in lan966x_probe(), the ports are initialized and
lan966x_fdma_netdev_init() is called, which in turn calls napi_enable().
The FDMA interrupt is also requested early.=20

Since the FDMA queue backing memory isn't allocated until
lan966x->ops->fdma_init() is called here, what happens if an interrupt fires
before this point? It appears the interrupt handler could schedule the NAPI
instance, and the poll routine would execute fdma_has_frames(), which then
dereferences the unallocated fdma->dcbs pointer.

> =20
> @@ -1247,7 +1262,7 @@ static int lan966x_probe(struct platform_device *pd=
ev)
>  	return 0;
> =20
>  cleanup_fdma:
> -	lan966x_fdma_deinit(lan966x);
> +	lan966x->ops->fdma_deinit(lan966x);
> =20
>  cleanup_ptp:
>  	lan966x_ptp_deinit(lan966x);

[Severity: High]
This is a pre-existing issue, but does skipping fdma_deinit() here leave
the NAPI instance enabled during the rest of the error cleanup?

When jumping to cleanup_ptp, it skips the fdma_deinit() call which would
normally disable NAPI. The cleanup path eventually reaches
lan966x_fdma_netdev_deinit(), which calls netif_napi_del() on the
still-enabled NAPI structure.=20

Does this create a use-after-free vulnerability in softnet_data.poll_list by
deleting an active NAPI structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-lan966x-pc=
i-fdma-v5-0-ca56197ae05b@microchip.com?part=3D6
