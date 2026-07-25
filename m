Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1D1396D09
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784970530; cv=none; b=uZX2diWBLsg5TA6EVmGBj3QBusLWKdRfFRCdtvhLD/C92msSr/nFgrxzUeqOW4HLioRsgesywKclqY5g3ZAgmYb0/NnKfWioSSrFOlafstM25iC1p3no7bVVk/6YPt3QrhAerKS5EpslfvyWTu6VozxH8kTMC76RvbCbXAk5n60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784970530; c=relaxed/simple;
	bh=eaZZdBieHM9Ekzvqay49fi/fnnlrQBnYiL1lVFLqeSM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ozqX68enacuVetT+CI+y7fTwehaZHr43tYXyLAFC3ScthhcKW9jfNk+QcXJdARpcFcbM56f4XKAP36pWofXtWqLi6qP+R/khhSDIyDZe9j542eWmCsIIyTVQHgPXu3YxGOivHUa6B8NIA24wPl1yiUp2aLb0erqN/sxbFcuw4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnJ+q547; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnJ+q547"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3590F1F000E9;
	Sat, 25 Jul 2026 09:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784970527;
	bh=Q6kg1rxoPgtDoygSF5Zo5anii7Kim5PPMhJ/8ePRIso=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mnJ+q547a+1RfJUW6nv7wbb9wiBEYxK0kopz+jTpjNNa2KxgmOyU8Aq4IaZPYexEs
	 4or3exScSZ9XkrpDhHPCNiG5ZBNSkX6zYRNRqxjVI+be8msqM8vWX3SPFn7QGUy2c7
	 Gn+BbZM59mJDwBAJ2BUZVh13eKCjVSxF/MQwHNbRAdwvLeIUM1WnA0ApqS6lo2O4gs
	 iDaSidgwIn1GYyM7LgOwb2fERERsTDVGhPc2ddDX0Iams7Mj06PKOZbR1/6csy6Hhn
	 vT4fHFhaUePwwiipxM2db6cqLsa34nyVcSUcLRHx57pOFMH/hyOCxp7PC4K+TpbnFZ
	 l8wQAg4iallOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: atlantic: free stranded TX buffers
 on ring deinit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yangyu Chen" <cyy@cyyself.name>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_E5DA048E95B86B31EB21258D8E7CE1825308@qq.com>
References: <tencent_1F173E0FC1606D2AC704DC9C98AF10984607@qq.com>
 <tencent_E5DA048E95B86B31EB21258D8E7CE1825308@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 09:08:46 +0000
Message-Id: <20260725090847.3590F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix: PTP TX ring still uses `aq_ring_tx_clean()` on tea=
rdown, leading to memory/DMA leaks and a locking violation.
--

--- Patch [1]: [PATCH net-next v2 1/3] net: atlantic: free stranded TX buff=
ers on ring deinit ---
commit d506a87f11eebfd3878d7ddde798e451d9fd8627
Author: Yangyu Chen <cyy@cyyself.name>

net: atlantic: free stranded TX buffers on ring deinit

This commit brings back aq_ring_tx_deinit() to properly clean up TX rings=20
on teardown by iterating up to sw_tail. It replaces the call to=20
aq_ring_tx_clean() in aq_vec_deinit() to fix a memory and DMA mapping leak=
=20
that occurs during interface shutdown.

Cc: stable@vger.kernel.org # v4.11+

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
>  		aq_ring_rx_deinit(&ring[AQ_VEC_RX_ID]);
>  	}

[Severity: High]
This is a pre-existing issue, but should the PTP TX ring be updated to use=
=20
aq_ring_tx_deinit() as well?

Looking at the PTP TX ring teardown path:

drivers/net/ethernet/aquantia/atlantic/aq_ptp.c:aq_ptp_ring_deinit() {
    ...
    aq_ring_tx_clean(&aq_ptp->ptp_tx);
    ...
}

Since aq_ring_tx_clean() only cleans up to hw_head, won't any PTP descripto=
rs
between hw_head and sw_tail be leaked when the interface is stopped while
PTP TX packets are in flight?=20

Also, since aq_ring_tx_clean() updates u64_stats without disabling preempti=
on,
does keeping it here leave the teardown path vulnerable to a lockdep splat =
on
32-bit systems?

Does it make sense to update aq_ptp_ring_deinit() to use the newly restored
aq_ring_tx_deinit() for the PTP TX ring to fully close this leak?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_1F173E0FC16=
06D2AC704DC9C98AF10984607@qq.com?part=3D1
