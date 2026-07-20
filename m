Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC4C403EAF
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555539; cv=none; b=YfzPEr03QIE2suLcpsBmYDbcdSyD0gGN4m/SneQo7ktm2DxzcJNf11eUXqX1PwE+3wA54q/Omq3ssgDg/Gs+cxeIl58WUIp8AZdThcAhmnRKJYctyDExke42rfRNGst8vrEb8astdbggFqbrZ2PYeo3ulJ0RpipKawaJJ0HGNMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555539; c=relaxed/simple;
	bh=pVPk6hHan87/9lR/Uy7QlMDPlmxouiwdQ+5gaaUTEBA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Er0Z3ChNTV0jaS3WraKmYtzxDypVnNvbX7PSET2yBq6QM+HKi+oqrVazoG2vPv+LUPR5ohKrzlmd8k4mJthGBycfm+s6CkSF4AGQRbzVtEnG3I+xZ0QybHXLImNrIXDKbRdT9XUPi9ogITPNjwaNrzyD8bYe/+M71pHP0Xiv2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ujtf1SyH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ujtf1SyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EE61F00A3D;
	Mon, 20 Jul 2026 13:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784555538;
	bh=QKtRt90WVtehLuR8QUC86CeJ5wX+Ib6lyt3da1KIdnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ujtf1SyHCJwFAZ+KGy6egoCMAjWpq7XaJOZM1DZn95qNUvxK8sQNUx2jZYGUc7ae1
	 Tkkzmqa9APDs3uRPzrAMqp5pgtkeUoE4w+cHjpUvuVDNtENf6BysHS2pP5LQShIRK+
	 y+NIec7ZchiXplvUi9ApO3COMeFrZaYqe7RDrQS2+yg1rkRe8jnUXzdpXF75vxU0Q5
	 yNWbqUQOSLa9PzC7ATbUOnXWyZgzEqJ0Z+ncvJ+b3TrMHZKqo/tAgayUJNcvsC+6AK
	 3BR/CWJc/UpvdFviKIw8TiT/zzbOQthiPK5bEHwE7GHVQYn0tD+hs2w1bSQV3sGD0x
	 goMxRhPCdOdAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] e1000e: Fix out-of-bounds MMIO access by
 validating BAR0 size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720133049.1289167-1-pulehui@huaweicloud.com>
References: <20260720133049.1289167-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 13:52:18 +0000
Message-Id: <20260720135218.92EE61F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver unconditionally maps BAR0 with `ioremap()`, without ver=
ifying that BAR0 is an `IORESOURCE_MEM` region. A spoofed PCI device could =
expose BAR0 as an I/O region, which could bypass the new length check on so=
me architectures and lead to `ioremap()` being called on an I/O port addres=
s.
--

--- Patch [1]: [PATCH net v2] e1000e: Fix out-of-bounds MMIO access by vali=
dating BAR0 size ---
commit 939eee77005bb32587689d8e06aa2cec8c38f7e9
Author: Pu Lehui <pulehui@huawei.com>

e1000e: Fix out-of-bounds MMIO access by validating BAR0 size

This commit fixes an out-of-bounds MMIO access in the e1000e driver
by ensuring the length of BAR0 is at least 64K before performing ioremap.

> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/eth=
ernet/intel/e1000e/netdev.c
> index 844f31ab37ad4..46e58e926f7b4 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c

[ ... ]

> @@ -7450,6 +7450,11 @@ static int e1000_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>  	mmio_len =3D pci_resource_len(pdev, 0);
> =20
>  	err =3D -EIO;
> +	if (mmio_len < E1000_MMIO_LEN_MIN) {
> +		dev_err(&pdev->dev, "MMIO len is too small\n");
> +		goto err_ioremap;
> +	}
> +
>  	adapter->hw.hw_addr =3D ioremap(mmio_start, mmio_len);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for ioremap()=
=20
to be called on an I/O port region here?

Earlier in e1000_probe(), pci_select_bars() filters out non-memory BARs. If=
=20
a device is bound via sysfs and exposes BAR0 as an IORESOURCE_IO region=20
instead of IORESOURCE_MEM, the driver fails to request the region but still=
=20
unconditionally passes mmio_start to ioremap() at this location.

Could this cause a kernel panic on architectures where I/O space is distinc=
t=20
from memory space when the returned address is subsequently dereferenced?

>  	if (!adapter->hw.hw_addr)
>  		goto err_ioremap;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720133049.1289=
167-1-pulehui@huaweicloud.com?part=3D1
