Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187634;
	b=O2QSeijL1rFI6kwcUdXLZ2FADPa6/hKnAnzSZAlBUsTVaRG9yi6pjpeybr9kXdScLgiY
	 gpIr29dsTOoWS5xtC9Ejh5gOunde7bL39ZrxgkhoPeeqH6AKcIu1za3o36umAYpE6hE6l
	 XgPy8k46bxwBWDUCLR/c5ExJtvw9/4YNcsxQBHXwjrwvB3cQyXWhtxJ9axY0+PAsW1cuf
	 iiU4rW6h5wa93NOoZN0oj/kMmn++y5xIxWUrSBbTtW9WCN4LM69vwIMhDyTF2piAVnI+n
	 GO3E9HcV3J+RWjecpN5RlJZzKm9se047754+loetYStLhVqOKjV3Klzbea2Jf3u6HwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187634;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uR92nwhz4nZ+WiyBDnj/UdM8+GDOmj77b0H6bZXVnaM=;
	b=ss5V8wEMWFT1WojKISKgZD4oXEY7SInsCLZTIww4yd5v1kL6TzXVRF6C3EdF+7Tp9Fj1
	 0Ld31Svq7VJPoIhbpwgnWk7yGf8RNsELdFI6h/6xw23Ru9NBz3S6w1wixIKtwBFv/EwbQ
	 Igfhpam1e76NnUrdCoiIYqul2vgQcfpW7hOHzR+54L+xgkYscX47o4ZwgB/mKavBQDTmE
	 d4GpRZn+oZg85PYioqAiNvL0tiieN+CSKdEqPdJuit9VrfUOAx+ZHN9KS9/EIId3mMvnF
	 Q/xI3+KJWTyEsppzm46O3DiBEVSxBu3tfMU6VPN2cXqTLy8PObCLJ1BjkUo7Fg5Yk3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AK5qZwSp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9818360A2613
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AK5qZwSp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5B61F000CF;
	Fri, 20 Nov 2026 15:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795187633;
	bh=uR92nwhz4nZ+WiyBDnj/UdM8+GDOmj77b0H6bZXVnaM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AK5qZwSpMsjpCTfSF6X4xa6mWzV9SZEcM/Vxdr3tK7cY5Z2wnPXf4WR6OBRgBXPxC
	 vhl19+TgpWiUOilKsR9pRQmJS8nXbEo+73oADpudLdnfYqGvuNQEOzyBYUZc1KAu9A
	 wtDUXuLlTqu3+64SkPtlcimdTPF0p0Nqn3ogCrJS7MyvUk1+qwrQ31R5hAJ0dgykVV
	 nrp+1ppwYjElJoyOBTsUCDQm9+rfMwHKkhedtC34AWggabtYOK20RdwKPNxZ15So2R
	 bKIFmBtqPTv0wQ/Gt0vmF/byt2JjvkkU3k+zYRhi0AbAjEdQcVaoC9g2BsofByMgmS
	 yS3AKT0EObOJA==
Message-ID: <sashiko-outbox-225443@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next 2/2] ice: wait for one RCU grace period when
 destroying XDP rings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shitalkumar Gandhi" <shital.gandhi45@gmail.com>, intel-wired-lan@lists.osuosl.org
Cc: bpf@vger.kernel.org
In-Reply-To: <20261120150527.14649-3-shital.gandhi45@gmail.com>
References: <20261120150527.14649-1-shital.gandhi45@gmail.com>
 <20261120150527.14649-3-shital.gandhi45@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 15:13:53 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] ice: use-after-free in ice_vsi_clear_rings() [1]
--

commit 43d9078a23fe9ac7d73bcbe7267574a26a1906b4
Author: Shitalkumar Gandhi <shital.gandhi45@gmail.com>

ice: wait for one RCU grace period when destroying XDP rings

This commit replaces the per-ring synchronize_rcu() in
ice_destroy_xdp_rings() with a single synchronize_net() call before the
ring teardown loop.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
> index 0d823e7f4cdcd..254668d4e3963 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -2891,12 +2891,16 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi, en=
um ice_xdp_cfg cfg_type)
>  	}
>  	mutex_unlock(&pf->avail_q_mutex);
> =20
> +	/* Let in-progress ndo_xdp_xmit and ndo_xsk_wakeup calls finish before
> +	 * the rings they may be using are freed. The VSI is down at this
> +	 * point, so one grace period is enough for all rings.
> +	 */
> +	synchronize_net();
> +
>  	ice_for_each_xdp_txq(vsi, i)
>  		if (vsi->xdp_rings[i]) {
> -			if (vsi->xdp_rings[i]->desc) {
> -				synchronize_rcu();
> +			if (vsi->xdp_rings[i]->desc)
>  				ice_free_tx_ring(vsi->xdp_rings[i]);
> -			}
>  			kfree_rcu(vsi->xdp_rings[i]->ring_stats, rcu);
>  			vsi->xdp_rings[i]->ring_stats =3D NULL;
>  			kfree_rcu(vsi->xdp_rings[i], rcu);

[Severity: Critical]
This problem wasn't introduced by this patch, but can calling kfree_rcu()
on vsi->xdp_rings[i]->ring_stats and vsi->xdp_rings[i] before clearing
those pointers cause a use-after-free [1]?

An RCU reader entering between kfree_rcu() and the NULL assignment can
still observe the pointer after the grace period for reclaiming it has
already started, so the object can be freed while the reader is using it
(the same ordering also exists in ice_vsi_clear_rings() for vsi->tx_rings
and vsi->rx_rings).

[1] https://sashiko.dev/#/bug/linux-8bb69a7d-5d05-41df-ae26-5fe9622f437d

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120150527.1464=
9-1-shital.gandhi45@gmail.com?part=3D2
