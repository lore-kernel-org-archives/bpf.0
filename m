Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEC3388E6E
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214278; cv=none; b=uJLgNafLvv2BkraIypwCez34ykWdjiRxYhKeVLOzMngR3RysFFOiCeb4XWGASK3c2pdlkVuNlEDP++0djEvU5t7kZhlG68S+2QpJy/84+vr64ly2yo/lIx6X7AKOAOP/eIjMB2OoxwfLY6SYwSPvxkfjQtTPOFxEzjIvyeDU+aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214278; c=relaxed/simple;
	bh=PUCp6otpaAG2a9GZ3AiPoqod+oP6BeLS35egB/bgg+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hDN5Q1rbH8xMYGWF6lS8H0J1gK3dfprOspDtOiyxdqPsLImY4wEFWWSCYERJlVk0aIYydeo4I+wqVg/YYOJktzp6JkNpAmLcv/iXAiZ3xB+YcPxxQJ9kA7T8h5Ui/u8eoE3S/bNN4TAso6fOL3BUzSWhd6dXlm7qwQODBmh8SNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THnO3aW3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THnO3aW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31001F000FF;
	Thu, 24 Sep 2026 01:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790214276;
	bh=gZ/ZZXRfBz2rjn9Vc1p9+MSp1EBzmNJsXB9yoz/LkZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=THnO3aW3djV+nJQOh8fR+LKRF87HeqBAsKze1pD1jSlI6DBM3XFsW2jUW0+xIrsAB
	 CGUFKn4nIFGZ4CuXnnOkOkAm3aHZgJ4t6kqu9GSv86ewukhRSldYsOAVtiHJvqD/4A
	 pIICvKo7wkzdOE90kOZbUUyV9f7Uy6JMnxopeqtNHlXmEQ5JPbIzEHC3qfjKHScoSo
	 oCrukSSnNrY75MaQd5Kn3htcfdoFmYn970DctLi2ke6KSlU9YHTuvPw7LAMLiUGEBk
	 EgrbkoDrthrh5vZULlikXuTKnpYiNu/a+MaWp3Y5PLHym4/2PihbUc1KgxFc5yDHrs
	 LJhjkippoMm/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/8] eth: mpnic: add scaffolding for Meta
 Platforms NIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922-linux-mpnic-v1-1-236844f53072@gmail.com>
References: <20260922-linux-mpnic-v1-0-236844f53072@gmail.com>
 <20260922-linux-mpnic-v1-1-236844f53072@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 01:44:35 +0000
Message-Id: <20260924014435.D31001F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mpnic: Missing PCI BAR size validation causing OOB MMIO access
--

commit 04a97e4905a47ed1a317515fbb919eef32a497b2
Author: Daniel Zahka <daniel.zahka@gmail.com>

eth: mpnic: add scaffolding for Meta Platforms NIC

This commit adds the initial bare PCI driver scaffolding for the Meta
Platforms Network Interface Controller. It introduces basic MMIO read/write
operations and PCI device registration.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c b/drivers/net/et=
hernet/meta/mpnic/mpnic_pci.c
> new file mode 100644
> index 0000000000000..96393e7812418
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c

[ ... ]

> +u64 mpnic_rd64(struct mpnic_dev *mpd, u32 reg)
> +{
> +	u32 __iomem *csr =3D READ_ONCE(mpd->uc_addr0);
> +	u64 value;
> +
> +	if (!csr)
> +		return ~0ULL;
> +
> +	value =3D readq(csr + reg);
> +
> +	/* If any bits are 0 value should be valid */
> +	if (~value)
> +		return value;
> +
> +	/* All ones can be a valid value, so confirm against a register
> +	 * which never reads that way on a live device.
> +	 */
> +	if (reg !=3D MPNIC_BDQ_SPARE && ~readq(csr + MPNIC_BDQ_SPARE))

[Severity: High]
Could this unconditionally read at a large offset (~16.5MB) regardless of t=
he
actual mapped BAR size? If a device (or an attacker via hotplug/virtualizat=
ion)
presents a smaller BAR, wouldn't this cause an out-of-bounds MMIO access
and potentially a kernel page fault?

> +		return value;
> +
> +	mpnic_mmio_err(mpd, reg);
> +
> +	return ~0ULL;
> +}

[ ... ]

> +static int mpnic_probe(struct pci_dev *pdev, const struct pci_device_id =
*ent)
> +{
> +	void __iomem *uc_addr0;
> +	struct mpnic_dev *mpd;
> +	int err;

[ ... ]

> +	mpd =3D mpnic_alloc(pdev);
> +	if (!mpd)
> +		return -ENOMEM;
> +
> +	uc_addr0 =3D pcim_iomap_region(pdev, 0, MPNIC_DRV_NAME);

[Severity: High]
Does this code map the PCI BAR without first validating that the resource
length is large enough to cover the expected register offsets? Should this
validate pci_resource_len(pdev, 0) before mapping to ensure that accesses
like MPNIC_BDQ_SPARE remain within bounds?

> +	if (IS_ERR(uc_addr0)) {
> +		err =3D PTR_ERR(uc_addr0);
> +		dev_err(&pdev->dev, "Mapping the register file failed: %d\n",
> +			err);
> +		goto err_free_mpd;
> +	}
> +	mpd->uc_addr0 =3D uc_addr0;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-linux-mpni=
c-v1-0-236844f53072@gmail.com?part=3D1
