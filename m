Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF3E4A33E9
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005377; cv=none; b=spYy6Kdw2LhdLan5bk6N324Ka0DR1Wqv2Rs9r03pA06JV6rSF1VzzxSmZbDqAifFdizTmkB47v07XQcvOFG64Jhif5nkjf8USrsDvUDDnsycWpVIJBj80xZ8BXQQmXdTBNtTgwnqhYfTc/y/Yqsm0CiZYpLi8xeDdlGiKC8lmic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005377; c=relaxed/simple;
	bh=MVvbWbiiSz15cUD6cd8+miXl8wjF+MmYskV1CskrZGo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kQ/QUV5fSDyOTkYM7fz+y+S6Edq5NwUiHlvK1oruIlFbDPAAUQeuwPj6466WwBFRnAQd+t3aRGMnFriSEAhHAfC4lqvNUKgj6VH73kPxlPIr0tFrnhKDjtcDdP6FbNKcPQZmFv2/nmhZhfm5cwqL3WoD1B7s9/JCwF9UNY7p7Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ux0aBu/h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ux0aBu/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623CAC2BCB4;
	Tue,  5 May 2026 18:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778005377;
	bh=MVvbWbiiSz15cUD6cd8+miXl8wjF+MmYskV1CskrZGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ux0aBu/hkEUez428Og82S0PUq5aRal6PyRnfTLvyWXI/a0m5q3Oir9VXyVyHkHPJh
	 UrgudmCpkT8PdGmf1RGkymUj4NNs7J6uxgQrQlTEQlgvzfME10AzVAbVt+QZwTZAZz
	 QoGmh8TYHdHUkpPZdWSOQcj27oU02clcuHsGisFYxIFdjsHwQeZKSziThJoUGvXbJN
	 8dQjKOCe2oAIVSEkwTtCF3ELjcM5Ai1PydFyWbyb9Kf8aOjKCjCD9cz3rRD3mhJxT6
	 PLpHiwkkyTIbok38GTvZhQ8qOgtChrJToCCRtcNHecxMA8g8OCMJDPg4Su6nMaQpx5
	 JH+EHQNQmUwpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 06/13] net: lan966x: add FDMA ops dispatch
 for PCIe support
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504-lan966x-pci-fdma-v3-6-a56f5740d870@microchip.com>
References: <20260504-lan966x-pci-fdma-v3-6-a56f5740d870@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 18:22:56 +0000
Message-Id: <20260505182257.623CAC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Teardown asymmetry in `lan966x_remove()` frees FDMA memory before =
network devices are unregistered, creating a UAF window.
- [High] Premature network device registration exposes the interface before=
 FDMA structures are allocated.
- [High] If `fdma_init()` fails during probe, the NAPI context is deleted w=
hile still enabled, violating networking subsystem rules.
--

commit 26b4dc8869b3940c369a8ef84d983f66881dd6b2
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add FDMA ops dispatch for PCIe support

Introduce lan966x_fdma_ops to support different FDMA implementations
for platform and PCIe. Plumb fdma_init, fdma_deinit, fdma_xmit,
fdma_poll and fdma_resize through the ops table, and select the
implementation at probe time based on runtime PCI bus detection.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 47752d3fde0b1..9f69634ebb0ae 100644
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

While reviewing this refactor, I noticed an existing issue regarding the
initialization order. Earlier in the probe sequence, the driver loops over
child nodes and calls lan966x_probe_port(), which executes register_netdev(=
).

Once register_netdev() returns, the network device is fully visible to the
system and transmission can be initiated.

However, the FDMA memory arrays (like tx.dcbs_buf) are not allocated until
lan966x->ops->fdma_init(lan966x) is called here.

If a packet is sent between register_netdev() and fdma_init(), could
lan966x->ops->fdma_xmit() execute and dereference the unallocated tx->dcbs_=
buf
array?

Additionally, if lan966x->ops->fdma_init() fails, the error path jumps to
cleanup_ptp. This explicitly bypasses cleanup_fdma and skips
lan966x->ops->fdma_deinit().

Since NAPI is enabled early inside lan966x_probe_port() via
lan966x_fdma_netdev_init(), and fdma_deinit() (which contains the
napi_disable() call) is skipped, the NAPI context remains active.

The error path then proceeds to lan966x_cleanup_ports(), which ultimately
calls netif_napi_del().

Can deleting an active NAPI context without disabling it first lead to cras=
hes
if the background polling task is concurrently scheduled?

>  	if (err)
>  		goto cleanup_ptp;

[ ... ]

> @@ -1273,7 +1288,7 @@ static void lan966x_remove(struct platform_device *=
pdev)
> =20
>  	lan966x_taprio_deinit(lan966x);
>  	lan966x_vcap_deinit(lan966x);
> -	lan966x_fdma_deinit(lan966x);
> +	lan966x->ops->fdma_deinit(lan966x);

There also appears to be a similar pre-existing issue here during teardown.

lan966x->ops->fdma_deinit() cleanly frees the FDMA RX/TX structures, but the
network interfaces are still active because lan966x_cleanup_ports() (which
unregisters the netdevs) has not executed yet.

During this window, if userspace or the network stack triggers a transmissi=
on,
lan966x_port_xmit() will see port->lan966x->fdma as true and invoke
lan966x->ops->fdma_xmit().

Could this transmission routine dereference the recently freed tx->dcbs_buf
buffers, resulting in a use-after-free?

>  	lan966x_cleanup_ports(lan966x);
> =20
>  	cancel_delayed_work_sync(&lan966x->stats_work);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504-lan966x-pc=
i-fdma-v3-0-a56f5740d870@microchip.com?part=3D6
