Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31E492E22
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045310; cv=none; b=noLWH0YEDO4W0q354z4yF32jnOKYV+gU1CAqjOdK28P1Qvd4Kd2yKoNHTgnb71eDdMUHLLoW7NBvdHGB1P1723N9P0f3Szmd8smCWUDr7AFNyMlDMnDIaeFnhVQ15495Qb0j0tKIi93bkYX56O1+Z9ml/RHTg0gj0Gog1FRC7Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045310; c=relaxed/simple;
	bh=CM71wQH4XG4eT+jO6NWOOaDww9wTQUlvlVR+NUYjR4s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ETqMkB3P8tVhPmNkIEtR7cdzxhJH/7yQBx4R4Xd/riOIxpuNPvp2DLXR84Nq68EeCda/9xZhhKTSCcllGGc3im912IL/msU+q5MuZbSvvzmWI/Gi53cFthmPoU84/ErRipfiUA91ophvK8JDpRSF8IzkXQSyz3/wr70tMIKY7ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9lxqjAs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9lxqjAs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D94F1F00899;
	Thu, 10 Sep 2026 13:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045307;
	bh=jErQZXB097VNs4pvf2jzz/9d3QbgFmQXKqJelzuo+iI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l9lxqjAsiNP2xDOttSsU4h2Rzg5ayAsDFHTjQmmykCTAXNznBtOle20wI84/+Z4E8
	 cJMp+xLSf686LFWmmIHwlxBVgn0sZaL57/k/p/YG3hE5YxzPUr7O8P+aUsjsgJPRoG
	 caGjzZHU73oPE/iR7Igq3/mt4bEy00PqPEq1tiwGTm/iNyifTX9JV2sn9VxEd4R2ye
	 zQlbSc/jDgXEjBNM3tjJIv5Nvdam/ITanMYWUx/3RsP/3Mro4vGwMfE37az5Ni2TCH
	 OvgBPpOCv2MJDgUaXOAW9wjmV3sc8UOpEViS2U6NUu/UpEhYwfUIUVCBSCd1wYIWw8
	 pU5UqXSBWYEKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 07/14] net: lan966x: add FDMA ops dispatch
 for PCIe support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909-lan966x-pci-fdma-v6-7-6f48dab9d671@microchip.com>
References: <20260909-lan966x-pci-fdma-v6-0-6f48dab9d671@microchip.com>
 <20260909-lan966x-pci-fdma-v6-7-6f48dab9d671@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 13:01:47 +0000
Message-Id: <20260910130147.9D94F1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Network device is registered and exposed before FDMA initializatio=
n completes, leading to NULL pointer dereference.
- [High] FDMA data structures are freed before network devices are unregist=
ered, causing Use-After-Free on concurrent transmission.
- [High] Missing NULL check for partially populated `lan966x->ports` array =
when processing received frames.
--

commit ac4a299eb602b1195f379c3cd6e7672750ac4f72
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add FDMA ops dispatch for PCIe support

Introduce lan966x_fdma_ops to support different FDMA implementations
for platform and PCIe. Plumb fdma_init, fdma_deinit, fdma_xmit,
fdma_poll and fdma_resize through the ops table, and select the
implementation at probe time. Only the platform implementation exists
at this point; the PCIe implementation is added in a later patch.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index 15fc59cb4ad79..2695bc41e52a9 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -947,7 +947,7 @@ void lan966x_fdma_netdev_init(struct lan966x *lan966x=
, struct net_device *dev)
>  		return;
> =20
>  	lan966x->fdma_ndev =3D dev;
> -	netif_napi_add(dev, &lan966x->napi, lan966x_fdma_napi_poll);
> +	netif_napi_add(dev, &lan966x->napi, lan966x->ops->fdma_poll);
>  	napi_enable(&lan966x->napi);
>  }

[Severity: High]
This is a pre-existing issue, but looking at the RX path in
lan966x_fdma_rx_check_frame(), is there a missing NULL check for the port
array?

The lan966x->ports array is sparsely populated in lan966x_probe() depending=
 on
the provided device tree nodes. When checking the frame, the src_port is
extracted from the Inter-Frame Header (IFH):

lan966x_fdma.c:lan966x_fdma_rx_check_frame() {
    ...
    if (WARN_ON(*src_port >=3D lan966x->num_phys_ports))
        return FDMA_ERROR;

    port =3D lan966x->ports[*src_port];
    if (!lan966x_xdp_port_present(port))
    ...
}

While src_port is checked against lan966x->num_phys_ports, there is no chec=
k to
ensure lan966x->ports[*src_port] is non-NULL before passing it to
lan966x_xdp_port_present(port).

If the switch hardware generates or loops back a frame with an IFH source p=
ort
corresponding to an unconfigured physical port, could this cause a NULL poi=
nter
dereference?

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 2741f7c9fa4c0..6e6c08bb8eeab 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c

[ ... ]

> @@ -1250,7 +1260,7 @@ static int lan966x_probe(struct platform_device *pd=
ev)
>  	if (err)
>  		goto cleanup_fdb;
> =20
> -	err =3D lan966x_fdma_init(lan966x);
> +	err =3D lan966x->ops->fdma_init(lan966x);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential race
condition here during probe.

The network device is registered and exposed to userspace earlier in
lan966x_probe() via lan966x_probe_port() -> register_netdev().
NAPI is also enabled. However, fdma_init() is called only here, which means
there is a window where the netdev is up before the FDMA ring structures
like tx->dcbs_buf are allocated.

If a user-space application configures the interface up and initiates a
transmission concurrently before fdma_init() finishes allocating the DCB
buffers, could lan966x_fdma_get_next_dcb() access a NULL pointer?

>  	if (err)
>  		goto cleanup_ptp;
> =20

[ ... ]

> @@ -1291,7 +1301,7 @@ static void lan966x_remove(struct platform_device *=
pdev)
> =20
>  	lan966x_taprio_deinit(lan966x);
>  	lan966x_vcap_deinit(lan966x);
> -	lan966x_fdma_deinit(lan966x);
> +	lan966x->ops->fdma_deinit(lan966x);

[Severity: High]
This is a pre-existing issue, but I see a potential use-after-free in the
unload path.

In lan966x_remove(), ops->fdma_deinit() is called before
lan966x_cleanup_ports() unregisters the network devices. For the platform
implementation, lan966x_fdma_deinit() frees tx->dcbs_buf without stopping t=
he
netdev transmission queues using netif_tx_disable().

If a packet is transmitted concurrently from userspace via ndo_start_xmit
while the module is unloading, could lan966x_fdma_xmit() dereference the
already freed tx->dcbs_buf buffer?

>  	lan966x_cleanup_ports(lan966x);
> =20
>  	cancel_delayed_work_sync(&lan966x->stats_work);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-lan966x-pc=
i-fdma-v6-0-6f48dab9d671@microchip.com?part=3D7
