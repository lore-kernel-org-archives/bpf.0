Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AC2489FC6
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045310; cv=none; b=VuwZ+St1mufNccJs54dsNYQimZnmWm17nBNtrOVPcRW9aQrf7SPaAmCqq0+MNrhNCvApzbfgvk782FtIwHhMP0R1WGnzkEMIfyfMPQvC7eBvyWeABte8KGX6je3J8d5d66/ZrYacOESZ1alnvzjlxr0hfIqNlFJUlKvyflQQeU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045310; c=relaxed/simple;
	bh=RaZEjx78NtPb5+VcwVixJJ6uw57dzkCifG9JcUDeyD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HQGCscK56k/1vzFag8UqHcaC63YflH2BItOPnZf7D4GxXn8seR7m7I58hxQn9UqZL+zFtzIaeQlISP1F0AzPIEYfcUjs15alNNggg9MWwlNg7FEjIjsheIPb6FyPRQ9sA+mgQOY4DUbtkY1U6qfu9Y6CpdyqUxrKiYceT7j0gYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwL8YWCi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwL8YWCi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8F91F0089B;
	Thu, 10 Sep 2026 13:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045308;
	bh=imilj8QC+5J25Vw4qhgdBzYT9XqkhExCwG20txtcNfw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TwL8YWCieq/IMSfbreE8cUwxFNaUJmdDhWjlcJSE4JhDC2FiL3yeMer/YPYdvtt2s
	 kT4LpBGI8VD7tUyQoTqIKwPWswQsBVSnd1QhStOXQe1TPLrPzgjWVnnGN5KszPGwi2
	 9jp9SesKbdHoHrO9lSzgEcZukRpyLfMqaD4Ybch7GnEl/vF6z21hdWZwNXmZ1hqD/j
	 3sX5GfA8WxhGBme8TSSGoxpzm/2JUjev6/ZnjPj9HmHtw36cEbYyI7u4NQ3XPbiK1O
	 mvPvtcbzT78LwAsAq88zH6awTOSHGGfQ1N5Mzlv9XXmnhK565cMWmMkT4G/lcnoEqx
	 XHpgdxgvVKjXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 11/14] net: lan966x: add PCIe FDMA MTU
 change support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909-lan966x-pci-fdma-v6-11-6f48dab9d671@microchip.com>
References: <20260909-lan966x-pci-fdma-v6-0-6f48dab9d671@microchip.com>
 <20260909-lan966x-pci-fdma-v6-11-6f48dab9d671@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 13:01:47 +0000
Message-Id: <20260910130148.4B8F91F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Netdev TX queues are awakened before the hardware CPU port is re=
-enabled, causing potential packet drops.
--

commit 0b30c07a5d133116fb650402972844467ddebe05
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add PCIe FDMA MTU change support

This commit introduces MTU change support for the PCIe FDMA path. It handles
reallocating contiguous ATU-mapped RX and TX buffers with the new size, reu=
sing
old ones if reallocation fails.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
[ ... ]
> @@ -374,9 +381,164 @@ static int lan966x_fdma_pci_init(struct lan966x *la=
n966x)
[ ... ]
> +static int lan966x_fdma_pci_reload(struct lan966x *lan966x, int new_mtu)
> +{
[ ... ]
> +	napi_enable(&lan966x->napi);
> +	lan966x_fdma_rx_start(&lan966x->rx);
> +	lan966x_fdma_pci_wakeup_netdev(lan966x);
> +
> +	return err;
> +restore:
[ ... ]
> +	napi_enable(&lan966x->napi);
> +	lan966x_fdma_rx_start(&lan966x->rx);
> +	lan966x_fdma_pci_wakeup_netdev(lan966x);
> +
> +	return err;
> +}
> +
> +static int __lan966x_fdma_pci_reload(struct lan966x *lan966x, int max_mt=
u)
> +{
> +	int err;
> +	u32 val;
> +
> +	/* Disable the CPU port. */
> +	lan_rmw(QSYS_SW_PORT_MODE_PORT_ENA_SET(0),
> +		QSYS_SW_PORT_MODE_PORT_ENA,
> +		lan966x, QSYS_SW_PORT_MODE(CPU_PORT));
[ ... ]
> +	err =3D lan966x_fdma_pci_reload(lan966x, max_mtu);
> +
> +	/* Enable back the CPU port. */
> +	lan_rmw(QSYS_SW_PORT_MODE_PORT_ENA_SET(1),
> +		QSYS_SW_PORT_MODE_PORT_ENA,
> +		lan966x, QSYS_SW_PORT_MODE(CPU_PORT));

[Severity: Medium]
Does this create a window where packets can be dropped?=20

In lan966x_fdma_pci_reload(), we awaken the netdev TX queues by calling=20
lan966x_fdma_pci_wakeup_netdev(). However, the hardware CPU port is still=20
disabled at this point, and it only gets re-enabled after returning back to=
=20
__lan966x_fdma_pci_reload().=20

If the network stack injects frames immediately after the queues are awaken=
ed,=20
won't they hit a disabled CPU port and be dropped by the switch fabric? Sho=
uld=20
the CPU port be re-enabled before the netdev queues are awoken?

> +
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-lan966x-pc=
i-fdma-v6-0-6f48dab9d671@microchip.com?part=3D11
