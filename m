Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5676937D10F
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468204; cv=none; b=I6J5ro/AYG76+yxH+7O9S+iI3dnUpVsOgMeKCTZtVF+Pcgu5B08viMyM+ZFr6U9KopxIlR+dqeVQcAwqPgUO7voWH9VxNEftbSI7kKpjfoYh3g9Lzd+/WLdEaAGXBhAIFUKHTq7aB2kPPN13bohSIZoH6pMqSoYwW6oAycen0wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468204; c=relaxed/simple;
	bh=ya/M4uvLAhv9zPgGB1SezWFMl4uSm1ObgqIRkSKsojs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tji9601hrdGyMdoQsnPJUBS3WJOWU9l20/wAi6LxTJbYFTqcIBMG119ceaKYxn4xW35QK+TI5z3HIFQAMnppKrL5fGlrmlmQjrH3vJawiBMLAOien/JtFQOlxsvbKO9AR0LGWGFRVYevGPJ4rkLUKwGSPno5AV01Qwjt4STXntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3FSgYh8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3FSgYh8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA485C2BCB8;
	Wed, 29 Apr 2026 13:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468204;
	bh=ya/M4uvLAhv9zPgGB1SezWFMl4uSm1ObgqIRkSKsojs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=T3FSgYh8t90ovZ/IHMAB1p4zDc/HHnD99VgsFQzkKLZfY+mI/KWErlwQxcrkfP2QR
	 BfEIQvmP6jWZTLshvnylA6sxYDmDAo4bAq5kI+v8isjkvVRB+mr86SdBRtIOcCbwfs
	 jtOcPPWn5k/uzsW7ZZVSu/+s9XjI5fYkgkkEtbh9F8K2McppwP2kkvBOzMUl8Fbh/a
	 SRcUAHT0WNfjoZ4sr+qZulCcG2HTRZ1YR579TVYntdb29Gw7Py61xwZO5C7TlMoYgA
	 GIJVJ3vpmzxiiMXINzVkk09uK2VRFegYDNR0D8IbVjpf5HS44BYyWsmiudn3sGuHtU
	 rn5WHULpOUB9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 06/13] net: lan966x: add FDMA ops dispatch
 for PCIe support
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428-lan966x-pci-fdma-v2-6-d3ec66e06202@microchip.com>
References: <20260428-lan966x-pci-fdma-v2-6-d3ec66e06202@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 13:10:03 +0000
Message-Id: <20260429131003.BA485C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Calling netif_napi_del() on an active NAPI instance without prior =
disablement if fdma_init() fails.
- [High] unregister_netdev() is called on an unregistered network device if=
 register_netdev() fails during probe.
--

commit 01a8933fefad605649fbdd137d3cd5c5de3e8ada
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add FDMA ops dispatch for PCIe support
   =20
Introduce lan966x_fdma_ops to support different FDMA implementations
for platform and PCIe. Plumb fdma_init, fdma_deinit, fdma_xmit,
fdma_poll and fdma_resize through the ops table, and select the
implementation at probe time based on runtime PCI bus detection.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 47752d3fde0b..9f69634ebb0a 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c

[ ... ]

> @@ -1232,7 +1247,7 @@ static int lan966x_probe(struct platform_device *pd=
ev)
>  	if (err)
>  		goto cleanup_fdb;
> =20
> -	err =3D lan966x_fdma_init(lan966x);
> +	err =3D lan966x->ops->fdma_init(lan966x);
>  	if (err)
>  		goto cleanup_ptp;

This isn't a regression from this patch, but does this error path leave an
active napi instance?

In lan966x_probe(), the port initialization loop calls
lan966x_fdma_netdev_init(), which adds and enables napi via napi_enable().

Later in the probe sequence, lan966x->ops->fdma_init() is called. If it
fails, the error handling jumps to the cleanup_ptp label, bypassing
cleanup_fdma (which would have called fdma_deinit and napi_disable()).

The error path then proceeds to lan966x_cleanup_ports(), which calls
lan966x_fdma_netdev_deinit() to invoke netif_napi_del() on the
still-enabled napi instance.=20

Could this corrupt the CPU's poll list and cause a use-after-free?

> @@ -1245,7 +1260,7 @@ static int lan966x_probe(struct platform_device *pd=
ev)
>  	return 0;
> =20
>  cleanup_fdma:
> -	lan966x_fdma_deinit(lan966x);
> +	lan966x->ops->fdma_deinit(lan966x);
> =20
>  cleanup_ptp:
>  	lan966x_ptp_deinit(lan966x);

This also isn't a regression from this patch, but can this error path lead
to unregister_netdev() being called on an unregistered network device?

In lan966x_probe_port(), lan966x->ports[p] and port->dev are populated
before calling register_netdev(). If register_netdev() fails, the function
returns an error without clearing these pointers.

lan966x_probe() catches the error and jumps to cleanup_ports.

lan966x_cleanup_ports() iterates over all populated lan966x->ports[p] and
unconditionally calls unregister_netdev(port->dev).

Since the device failed to register, its reg_state is not NETREG_REGISTERED.
Will the networking core's unregister_netdevice() hit a BUG_ON() and crash
the system?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428-lan966x-pc=
i-fdma-v2-0-d3ec66e06202@microchip.com?part=3D6
