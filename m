Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4E9368D69
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783705096; cv=none; b=H3vzNxe1mFugqRfItDivmxV8sDA7auiBkLbdBXDXJtl9KmhAa2gpSHgMlHuAayoBzBgtPyRoaZuVxNcZjqhH0m3pE9ex6QTDU9K06pba1sbDm8GMcbL+9ERImuNWA9MoNr4vnLD7juG41L3JEGVr4Ok81XW2PvptPit+7Xcf5jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783705096; c=relaxed/simple;
	bh=f/TZEVrX6anFOg/ecW4/KqjZnmcFZd6vTMr6QBPwXHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FOL4iNNA05COmj0V8baPmnoxEtL0W2MuvlmVFOpQRzPFKNL+lAEviyFYu73huZKI9u97EYEnKUjVZeQoZeQwdmZeen9RPjrlszRoMJsv2tcrLm2lmBl5b/lpHwWx+SSeQ0ynRVRbUdMKZfsEyCpcRaKcYWT8h5+U4E4PrzqOGqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6BjYLWY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6BjYLWY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0741F000E9;
	Fri, 10 Jul 2026 17:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783705095;
	bh=z02ZxiH+10xlB+MwwRKKmHW1pU1RDvEH/1CD3gvmgIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h6BjYLWYw+wYGWAjawiPET9k60qKGTINSa34V6woI1o5uDDrOKNVk4V5u26Ko/1b4
	 vn9sjrkkPBqctxnt7xa3vh6Yl7uPO2NutARI6MDESO0MHD6/0qwbbmOQ9s9F6gDuIa
	 GAN2RO64o7VuCalegraNstG+vZ9zbmP9FfatQ7HbnDuOAQ8yujBc5dhpFme3MWQswA
	 OCEGJDqmxCvrw4B+ifZra7704ViVJxdYUMG5/kQMXYJorSPTBjPegmLpjAjoMmZ/wC
	 TT5mx084JINRpLutJ3C9Q4lRc0e6C5T6f4WV4oK0a3tcYKzbO67uA+dMmz7tnqib++
	 oGIuI4xTTYLPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/2] net: atlantic: free stranded TX buffers on
 ring deinit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yangyu Chen" <cyy@cyyself.name>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_8FE30FDFA32089B69BA3112E4A4C5E886D06@qq.com>
References: <tencent_7DB01BE7F8FA056BB5F11D3570CF636C4309@qq.com>
 <tencent_8FE30FDFA32089B69BA3112E4A4C5E886D06@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 17:38:14 +0000
Message-Id: <20260710173815.2E0741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes a resource leak of stranded TX buffers on interfac=
e teardown by replacing `aq_ring_tx_clean()` with the restored `aq_ring_tx_=
deinit()` in `aq_vec_deinit()`, but misses the identical leak pattern in `a=
q_ptp_ring_deinit()`.
--

--- Patch [1]: [PATCH net-next 1/2] net: atlantic: free stranded TX buffers=
 on ring deinit ---
commit 0bceee292a00058408f6f3baf2ae8103a4e90f9c
Author: Yangyu Chen <cyy@cyyself.name>

net: atlantic: free stranded TX buffers on ring deinit

This commit brings back aq_ring_tx_deinit() to properly drain TX rings
during teardown. This prevents silent memory leaks of stranded buffers and
stalls during page pool destruction when the interface goes down under
TX or XDP_TX load.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/ne=
t/ethernet/aquantia/atlantic/aq_vec.c
> index 2f9033ceed8ce..05814fea0f5f7 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
[ ... ]
> @@ -275,7 +275,7 @@ void aq_vec_deinit(struct aq_vec_s *self)
> =20
>  	for (i =3D 0U; self->tx_rings > i; ++i) {
>  		ring =3D self->ring[i];
> -		aq_ring_tx_clean(&ring[AQ_VEC_TX_ID]);
> +		aq_ring_tx_deinit(&ring[AQ_VEC_TX_ID]);

[Severity: High]
This is a pre-existing issue, but should aq_ptp_ring_deinit() also be
updated to use aq_ring_tx_deinit() instead of aq_ring_tx_clean()?

In drivers/net/ethernet/aquantia/atlantic/aq_ptp.c:aq_ptp_ring_deinit():

	aq_ring_tx_clean(&aq_ptp->ptp_tx);
	aq_ring_rx_deinit(&aq_ptp->ptp_rx);

Since aq_ring_tx_clean() stops at hw_head and applies a budget, any
in-flight SKBs and their DMA mappings on the PTP TX ring might still be
permanently leaked when the hardware is stopped and the interface is
brought down.

Does the PTP ring teardown need the same fix applied here?

>  		aq_ring_rx_deinit(&ring[AQ_VEC_RX_ID]);
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_7DB01BE7F8F=
A056BB5F11D3570CF636C4309@qq.com?part=3D1
