Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12DE393DD3
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 05:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778649153; cv=none; b=sq/YemP3xJsdt3ZUAACb0mQ29vvMUzGjHooZVin3I+7uPWLqqLQPfJhEg/aiWn5K/8RkIUQoMJUZ6ZJZUgIedWIljCh+FOkbCPz6s851XaI3bpiRO8kqa3V63NohWSOzlndeDgz9F/fP9K1BN5fFaQP/02BNZ+ATZ1WSb6O3wc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778649153; c=relaxed/simple;
	bh=20piQX2EOqq5GEX+CvsETgZTDumCWmHey2VqVB9qcb0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rSyRXPJXdAaVysjNiJrO6SkGj02bmDMigS6ZWQBJGmfQTDyG1p5YlsMWZ+mw96KFZ+i37J/118xaTWgHFoUKAsK/6oi43q0vhdxOGhMQY441gEAkzKKHBN8Jn6Q2OBUpsDYhHwjMj+7kr+0ykB4m+vg/+07qa9qUYvrAG3XQmsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGf/iSdW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGf/iSdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFF7C2BCB7;
	Wed, 13 May 2026 05:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778649153;
	bh=20piQX2EOqq5GEX+CvsETgZTDumCWmHey2VqVB9qcb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uGf/iSdWNrjcTyjzfAsXOwBepX/c23IESDBbn71nUxC+LYtjjKVbyaMuQmfGrDphS
	 YaAlv3kX5PNmsCiTM9Ol8QuTKTcI9MFHTXnf+ERmMi02p0KUOGY782Ep/pIwDjrPVe
	 qtUGl9vBQQ/kEqzexYIYFodAMpI6tv91DdZVJuTaLoUztdYAQZTbE7WNqTVeoKieDW
	 OehW/saGBXdvm+LsOOoY6dPbLw7KZh+K2INek6Xyje171jH6xRr812VLIU92ZJF6nM
	 VqJ8Or10A4vffekb1x+hEg4YwDClfN0erxsLcMM6zHtZIYkDOmKkxSzuyu5yhMGOXl
	 mq5hfWESfTJKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 6/8] selftests: drv-net: refactor devmem
 command builders into lib module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260511-tcp-dm-netkit-v4-6-841b78b99d74@meta.com>
References: <20260511-tcp-dm-netkit-v4-6-841b78b99d74@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 05:12:32 +0000
Message-Id: <20260513051233.1AFF7C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] NIC ring and RSS configurations are permanently leaked on the ph=
ysical host if `configure_nic()` encounters an error midway through executi=
on.
- [Low] The newly created shared helper file `lib/py/devmem.py` is missing =
from `TEST_FILES` in the subsystem Makefile.
--

commit c5e5518c4c4e4b7d059077276ec59958fe094dd8
Author: Bobby Eshleman <bobbyeshleman@meta.com>

selftests: drv-net: refactor devmem command builders into lib module

This commit refactors netkit-based devmem test commands into a shared libra=
ry
module. This allows the command builders to be reused transparently across
both plain and netkit environments while keeping a shared environment across
test runs.

> diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/devmem.py b/to=
ols/testing/selftests/drivers/net/hw/lib/py/devmem.py
> new file mode 100644
> index 0000000000000..d3e7a3645cba5
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/lib/py/devmem.py

This isn't a bug, but should this new shared helper file be added to
TEST_FILES in the subsystem Makefile?=20

According to the selftests documentation, any file referenced via import in
test scripts must be added to TEST_FILES to ensure it is installed correctl=
y.

[ ... ]

> +def configure_nic(cfg):
> +    """Channels, rings, RSS, queue lease for netkit devmem."""
> +    cfg.require_ipver('6')
> +    ethnl =3D EthtoolFamily()

[ ... ]

> +    ethnl.rings_set({'header': {'dev-index': cfg.ifindex},
> +                     'tcp-data-split': 'enabled',
> +                     'hds-thresh': 0,
> +                     'rx': min(64, cfg.orig_rx_rings)})
> +
> +    cfg.src_queue =3D channels - 1
> +    ethtool(f"-X {cfg.ifname} equal {cfg.src_queue}")
> +
> +    with NetNSEnter(str(cfg.netns)):
> +        netdevnl =3D NetdevFamily()
> +        lease_result =3D netdevnl.queue_create({
> +            "ifindex": cfg.nk_guest_ifindex,
> +            "type": "rx",
> +            "lease": {
> +                "ifindex": cfg.ifindex,
> +                "queue": {"id": cfg.src_queue, "type": "rx"},
> +                "netns-id": 0,
> +            },
> +        })
> +        cfg.nk_queue =3D lease_result['id']

If queue_create() or the ethtool command fails and raises an exception, does
this leave the physical NIC rings and RSS configuration permanently modifie=
d?

Since the cleanup_nic() function wouldn't be called if this setup fails
midway, would it make sense to handle exceptions here to restore the
original ring and RSS settings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-tcp-dm-net=
kit-v4-0-841b78b99d74@meta.com?part=3D6
