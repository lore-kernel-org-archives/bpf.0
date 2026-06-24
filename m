Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B933B7759
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308021; cv=none; b=E8Uc6sGBCI2ZR3tzhyz1SvyGY/ia2KcZVlyHeNHp4ayXX2JvcY4l378c8GS7mgky3YP7RLFjHSI1NN/Em23L3tyMEMVrLa83z79NE5KjP6+KC9KEMcDswyB2QVD41AOoPdjgu8UuN9zqvysP+7NYYIgbc+9HHZzatp4XIkhfWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308021; c=relaxed/simple;
	bh=QH0BgmQkbALh51LHOsmxs6rsVWPTXyipJ1BwfHwGHog=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=beaoeICpTLcdojnc7h31Wp9QbILpsWeMy81TObiqb5Jvm2rmDBg3XfgaJHVBdhnNUjVcsHZ8oOnFkVuiAnIAxjHMGWp5NAYYwMdJmewoXCozaFM29ET66+fk/F4GsHtjr+lA6hV2qHUWsI5xZceHkxOfUamEIfDOC2QF6IsQC5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfHDXg2a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfHDXg2a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8B31F00A3A;
	Wed, 24 Jun 2026 13:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782308020;
	bh=jiSpqMYbc7cmw1qnsR5gmwu62VRjdRZMnVglpAJlk7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kfHDXg2ahlQ9WjX+Eg2clALSSc9tW7LHw5ys+8sIg41faqv5BT3clXLAAzvh8sjRK
	 lun/e0MSZn4WqM9tt+MzbIfHxiRWCoKYu6hAgQVIlGCyrlSLwLa41HNOoBl5t+E/oS
	 yCck2dZ/UpMWKDUrGl+3644ZWQI1o0LVy878Ler2yLv+RkNV1LfRp7WUM5KwQRMVqR
	 zE+BXacyB7o25qzqkwyFxcYUkVZoS5737iFYWjR68XvAd2SsClyDC/kOH8I1A1UpBz
	 qGciLqF/CNDoPZFUKM2MNl9L0LWJwD01O28HFShNZD+de7mYNKuJH4saBrkK9ncM2T
	 +D/7T02rjwsRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 4/7] xsk: reclaim offending invalid desc in generic
 multi-buffer Tx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623133240.1048434-5-maciej.fijalkowski@intel.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <20260623133240.1048434-5-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 13:33:39 +0000
Message-Id: <20260624133340.0C8B31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incomplete reclaim of the first invalid descriptor in a multi-buff=
er packet, leaking a completion.
- [Medium] Artificial inflation of the tx_invalid_descs counter when the co=
mpletion queue is full.
--

commit 94ab243e4d16baca076b39e394196d66b2624dbb
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

xsk: reclaim offending invalid desc in generic multi-buffer Tx

The patch aims to reclaim invalid descriptors found in __xsk_generic_xmit()
by adding them to the completion ring before releasing them from the Tx rin=
g.
This targets failed descriptors belonging to already-started or
already-draining multi-buffer packets.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index c489fadc36087..43791647cf182 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1125,8 +1125,22 @@ static int __xsk_generic_xmit(struct sock *sk)
>  	}
> =20
>  	if (xskq_has_descs(xs->tx)) {
> +		bool reclaim_desc =3D xs->skb || xs->drain_cont;

[Severity: High]
Does this logic correctly handle the first invalid descriptor of a
multi-buffer packet?

If the very first descriptor of a multi-buffer packet is invalid, both
xs->skb and xs->drain_cont will be false, meaning reclaim_desc evaluates
to false. The invalid descriptor will then be dropped without submitting
an address to the completion queue.

However, xs->drain_cont is subsequently set to true below because
xp_mb_desc(&desc) evaluates to true. Subsequent valid descriptors of the
same packet will then be processed in the drain path and have completions
generated, leaving userspace with N-1 completions for an N-fragment packet.

> +
> +		if (reclaim_desc) {
> +			err =3D xsk_cq_reserve_locked(xs->pool);
> +			if (err) {
> +				err =3D -EAGAIN;
> +				goto out;

[Severity: Medium]
Could returning -EAGAIN here artificially inflate the tx_invalid_descs
statistic?

If xsk_cq_reserve_locked() fails, the function returns -EAGAIN without
consuming the descriptor since xskq_cons_release(xs->tx) is skipped.

On subsequent retries, when xskq_cons_peek_desc() evaluates this exact same
invalid descriptor, it unconditionally increments q->invalid_descs (in
xskq_cons_is_valid_desc() in net/xdp/xsk_queue.h). Since the descriptor
is never consumed when the completion queue is full, the counter will be
incremented repeatedly on each retry.

> +			}
> +		}
> +
>  		if (xs->skb)
>  			xsk_drop_skb(xs->skb);
> +
> +		if (reclaim_desc)
> +			xsk_cq_submit_addr_single_locked(xs->pool, &desc);
> +
>  		xskq_cons_release(xs->tx);
>  		xs->drain_cont =3D xp_mb_desc(&desc);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623133240.1048=
434-1-maciej.fijalkowski@intel.com?part=3D4
