Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA18D40BCDA
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618275; cv=none; b=Kcg86NtZXlvZgEkuDJkNwlXMyiSrL9XQjKhiqMA60JpS1oAD5aX6gOp+hpCn/CtEPcCuq+QzRxStV8XP2D+y4v7SlLGZMBEloqI1cyUuykT4Av/v8h6aIoarCTJRVevxpMF0qstL326VSJR4Oce+phhubXxpW0FcfQw/v2Ki3ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618275; c=relaxed/simple;
	bh=lnU3Xf0A3xL9OZ4qTMx1oBmgjpW5d+S+Uzm+Lg9unBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IU1qf+9Ix5Ff8YemZC7uZvi1WJsQKyv4/YYtqauhNIJcb5/MkGPhFxpoxxkYWI59abHyEHo8yZ5vkw/n54OlcamAt2Qilb2dNhQiWNlwzYjn476nb5ji6zVIMr8Hrw3pj1kZCa2l7qCZKE6TfUjUV5VbBRUu4e8Ctzp49hjaJn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZHT3htg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZHT3htg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E471F00A3A;
	Tue, 21 Jul 2026 07:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784618274;
	bh=Q1S6QdUoo8V+ZNCfBv0sBwH7enEXAn56T0Dqu0P3YBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OZHT3htgsFP0nRRXSb4m8fCQxxeJdpXO97noyJ0AwMWxB4O/MNVQ9vjl9PwJ5QQaT
	 RaIbphsS1LnO4Lav2EoSs1Syyl9ijIknUHLoU6tyBoaoS5/NCHxrDloRLQ87M5y+xf
	 u2Ueqg077Z8TmUlAbHFMPA+UaAIJTQ7Na2m8byHC/5ArxFP46iu0OxODzsIgcZ0WH7
	 mCh2DXHnbwsO9900V1ynVS98jf8VeEWytOnyeOogx4H+t6Zb82D4X/uz1l5LCoiUrB
	 9/4Zz1MhbJteEp/yOjC7tYqt3wHL3SqvDNSQt9Djosg6rmCMCVeGntho1V6uKgClX/
	 xUMiwCS5uCunw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 03/13] net: core: add XDP_MODE_HW offload
 hook for knod
Reply-To: sashiko-reviews@lists.linux.dev
To: "Taehee Yoo" <ap420073@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, bpf@vger.kernel.org
In-Reply-To: <20260719175857.4071636-4-ap420073@gmail.com>
References: <20260719175857.4071636-1-ap420073@gmail.com>
 <20260719175857.4071636-4-ap420073@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:17:54 +0000
Message-Id: <20260721071754.78E471F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The patch introduces an order-dependent state violation where at=
taching a memory provider and a hardware-offloaded XDP program succeeds or =
fails depending purely on the order of operations.

Pre-existing issues:
- [High] Blocking XDP uninstalls when a memory provider is active leads to =
a resource leak of the BPF program and a permanently active 'zombie' XDP pr=
ogram on slave devices.
--

--- Patch [3]: [RFC PATCH net-next 03/13] net: core: add XDP_MODE_HW offloa=
d hook for knod ---
commit 2719ee9dd236296c86e09fa87d5113250098ff78
Author: Taehee Yoo <ap420073@gmail.com>

net: core: add XDP_MODE_HW offload hook for knod

Route XDP program install/uninstall to the knod accelerator when a
device is attached, so BPF programs run on the accelerator instead of
the host.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 7c21bc0a1e349..5ba1c969029bc 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10334,7 +10334,7 @@ static int dev_xdp_install(struct net_device *dev=
, enum bpf_xdp_mode mode,
>  		return -EBUSY;
>  	}
> =20
> -	if (dev_get_min_mp_channel_count(dev)) {
> +	if (dev_get_min_mp_channel_count(dev) && mode !=3D XDP_MODE_HW) {

[Severity: High]
This is a pre-existing issue, but blocking XDP uninstalls when a memory
provider is active appears to lead to a resource leak and an inconsistent
state on slave devices.

If we attach an XDP program to a bonding device, it propagates to slave
devices without updating their individual dev->xdp_state. If we then bind a
memory provider to the slave device (which succeeds since its local prog co=
unt
is 0), what happens when we try to destroy the bond device?

netif_xdp_propagate() will fail because of the memory provider:

net/core/dev.c:netif_xdp_propagate() {
    ...
	if (dev_get_min_mp_channel_count(dev)) {
		NL_SET_ERR_MSG(bpf->extack, "unable to propagate XDP...");
		return -EBUSY;
	}
    ...
}

In dev_xdp_uninstall(), this failure is ignored:

net/core/dev.c:dev_xdp_uninstall() {
    ...
		WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL));

		/* auto-detach link from net device */
		link =3D dev_xdp_link(dev, mode);
		if (link)
			link->dev =3D NULL;
		else
			bpf_prog_put(prog);
    ...
}

Doesn't this result in the bond dropping its reference and clearing its sta=
te,
while the slave driver never unloads the program because ndo_bpf is not
called? Will this leave a zombie XDP program permanently executing on the
slave device and leak the BPF program memory?


[Severity: Medium]
Does modifying this check create an order-dependent state regression?

If a memory provider is attached first, this modified check allows an
XDP_MODE_HW program to be installed successfully.

However, if an XDP_MODE_HW program is installed first, a subsequent attempt
to bind a memory provider fails in __netif_mp_open_rxq() because it
unconditionally checks the program count:

net/core/netdev_rx_queue.c:__netif_mp_open_rxq() {
    ...
	if (dev_xdp_prog_count(dev)) {
		NL_SET_ERR_MSG(extack, "unable to custom memory provider...");
		return -EEXIST;
	}
    ...
}

Should __netif_mp_open_rxq() also check if the existing programs are hardwa=
re
offloaded to ensure the API behaves consistently regardless of the operation
order?

>  		NL_SET_ERR_MSG(extack, "unable to install XDP to device using memory p=
rovider");
>  		return -EBUSY;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719175857.4071=
636-1-ap420073@gmail.com?part=3D3
