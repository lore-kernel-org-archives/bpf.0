Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020510;
	b=v+Rh2XljKR8uLp64Bvr+b3Oswk8t6tBOMLBDLcshDLg9/fSX7uTbhg+b0fZpHRW0TL2m
	 1MPjV1Z8XDsZ1k75sXj0m1Ng548pxf3dIvOd+tNzRb+eUzcO2dhFn38LZhmQDqRJDteO6
	 h1VNetQ0LOw38qoSpRF3GuU0PPSRjZGdpDJ39Zi2gcAOxs/RnHOYvKq5U61jQxIoao0Zb
	 uqAN4j2sPa4Q515bC/9TzvlvfRKxd2wdP+1lIBtuv41fO02XvbSOPCerqXsA/zovtX3Aa
	 hYpBODbJBuVizUj6tRLL4YUXKiERgF/ZinSPLJxjS1bDZJASWk5Ouu5Gv9Qy4bSCSbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020510;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pSncgZwNYeUB7FJRMBBJ3HUNYTHSU93NGXgRxyGYpGw=;
	b=ue465yLQT3zhMKoBhHCLfl4isACkYUgEyAauYWNpQF35O0R3Zgqdw2We3ePxIxxN73Wv
	 lj23gRMDYCcY9P2Mtge8j7u/iAwdO4V8gsoti9PMUnAWWPquK2gT+nZs2oh12oiiiw4r3
	 FFqDkcDjjBpxacs9mqkV9wTy79snHqGqwEKP/9oVoWBMucz118/YEU2fOIl3tfy5jyQjt
	 UMTjFr5VDkRzKvuU0a2PVAQKmasxKNs4DRa5G0o/rDyYhCVrRBo/kl/SeuJMCO0gX7CyF
	 eF7AMGuf2mXGPovewjxq1Uq7QBjruHl1J/cvraSjHk0F6SBtTfTiFc1VTJXhKLYLtzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frDkl5WV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6319F606A320
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frDkl5WV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C6A1F000C4;
	Wed, 18 Nov 2026 16:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020510;
	bh=pSncgZwNYeUB7FJRMBBJ3HUNYTHSU93NGXgRxyGYpGw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=frDkl5WVtXt/KRPJSCVNNN9oXvelEKwrZn5a7jL3GYlGd/g1Qe9lyX56bCosUvmXc
	 KwFR/ZKI6k/vndiqQdxkj5DnBavNzi+n7t+CE8zUUvahMDd6vzyzJYDPP36iBG3W0I
	 /krS/btibl96Otr4Gw2aXJrIr49yChK2EeP1qx+3pWBSzazJdqcRlhniuvG9x/xzC0
	 IYD746erfcoYmsAjxI45kf1kl9tmMq1b6Pmrano0IKKncnl6HZn05sVDJGtT1HrxUW
	 //u0FlY5PA6mOSQfW3m5URLlqEdQKrIdO9jMzfJ2Lu/WHU8n7LpW6FDvlhoNqN06/2
	 fPIoxNsQgwcrg==
Message-ID: <sashiko-outbox-221557@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 7/7] selftests: net: Test XDP on io_uring RX
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org
In-Reply-To: <20261117164700.2157816-8-bjorn@kernel.org>
References: <20261117164700.2157816-1-bjorn@kernel.org>
 <20261117164700.2157816-8-bjorn@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:48:29 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] selftests: drv-net: broken HDS check and restore in
  xdp_setup()
- [Medium] selftests: drv-net: xdp_setup() leaves RSS table
  user-configured
--

commit b83bbac3d08069e4bdafe35dfbe5badfc8c67e47
Author: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

selftests: net: Test XDP on io_uring RX

This commit adds a selftest that compares page-backed and io_uring-backed RX
queues under a multi-buffer native XDP program, verifying packet memory acc=
ess
restrictions and payload reception via recv() and RECV_ZC.

> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/t=
esting/selftests/drivers/net/hw/iou-zcrx.py
> index 5047fdb560057..e6b765c523ed3 100755
> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py

[ ... ]

> @@ -243,6 +253,91 @@ def test_zcrx_large_chunks(cfg) -> None:
>          cmd(tx_cmd, host=3Dcfg.remote)
> =20
> =20
> +def xdp_setup(cfg):
> +    """Reserve one RX queue without changing unrelated RSS contexts."""
> +    cfg.require_ipver('6')
> +    dev =3D cfg.netnl.dev_get({'ifindex': cfg.ifindex})
> +    if not {'basic', 'rx-sg'} <=3D set(dev.get('xdp-features', [])):
> +        raise KsftSkipEx('Device lacks native multi-buffer XDP')
> +    if 'xdp' in ip(f"-d link show dev {cfg.ifname}", json=3DTrue)[0]:
> +        raise KsftSkipEx('An XDP program is already attached')
> +
> +    queues =3D cfg.netnl.queue_get({'ifindex': cfg.ifindex}, dump=3DTrue)
> +    if any(key in q for q in queues
> +           for key in ('io-uring', 'dmabuf', 'xsk', 'lease')):
> +        raise KsftSkipEx('Device has an active queue provider or lease')
> +
> +    header =3D {'dev-index': cfg.ifindex}
> +    try:
> +        channels =3D cfg.ethnl.channels_get({'header': header})
> +        rings =3D cfg.ethnl.rings_get({'header': header})
> +        indir =3D cfg.ethnl.rss_get({'header': header})['indir']
> +    except NlError as error:
> +        if error.error !=3D errno.EOPNOTSUPP:
> +            raise
> +        raise KsftSkipEx('Device lacks channels, rings or RSS support') =
from error
> +    count =3D channels.get('combined-count', 0)
> +    if count < 2:
> +        raise KsftSkipEx('Test requires at least two combined channels')
> +    if rings.get('tcp-data-split', 'unknown') =3D=3D 'unknown':
> +        raise KsftSkipEx('Device lacks TCP header/data split')
> +
> +    _require_ntuple(cfg)
> +    cfg.target =3D count - 1
> +    old_rings =3D {'header': header,
> +                 'tcp-data-split': rings['tcp-data-split']}
> +    new_rings =3D {'header': header, 'tcp-data-split': 'enabled'}
> +    if 'hds-thresh' in rings:
> +        old_rings['hds-thresh'] =3D rings['hds-thresh']
> +        new_rings['hds-thresh'] =3D 0
> +    cfg.ethnl.rings_set(new_rings)
> +    defer(cfg.ethnl.rings_set, old_rings)

[Severity: Medium]
Does saving and restoring rings['tcp-data-split'] here leave header/data
split misconfigured or fail during cleanup?

On drivers such as fbnic and netdevsim, get_ringparam() reports
tcp-data-split as 'enabled' even when dev->cfg->hds_config is
ETHTOOL_TCP_DATA_SPLIT_UNKNOWN.  Restoring rings['tcp-data-split'] instead
of resetting 'tcp-data-split' to 'unknown' (as single() and rss() do
earlier in this file) leaves dev->cfg->hds_config set to
ETHTOOL_TCP_DATA_SPLIT_ENABLED after the test, causing dev_xdp_install() to
reject subsequent single-buffer XDP programs with -EBUSY.

In addition, bnxt_get_ringparam() can report 'disabled' while
bnxt_set_ringparam() rejects ETHTOOL_TCP_DATA_SPLIT_DISABLED with -EINVAL
on cleanup, and mlx5e_ethtool_get_ringparam() leaves tcp_data_split at
'unknown' until explicitly enabled, causing the pre-check above to skip on
mlx5.

> +
> +    cfg.ethnl.rss_set({'header': header,
> +                      'indir': [q if q !=3D cfg.target else 0 for q in i=
ndir]})
> +    defer(cfg.ethnl.rss_set, {'header': header, 'indir': indir})

[Severity: Medium]
Does restoring the saved indir list leave the RSS indirection table marked
as user-configured?

In ethnl_rss_set(), passing a non-empty indir array sets
dev->ethtool->rss_indir_user_size to a non-zero value rather than resetting
it to 0.  After test_zcrx_xdp() finishes (or skips in probe_xdp()),
netif_is_rxfh_configured() stays true with queue count - 1 referenced in
the table, so later tests or ethtool calls that reduce the channel count
fail in ethtool_check_max_channel() with -EINVAL.  Passing 'indir': None
resets the indirection table to its default state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117164700.2157=
816-1-bjorn@kernel.org?part=3D7
