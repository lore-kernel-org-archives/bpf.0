Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDAF2D1907
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 00:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790382964; cv=none; b=P3mX2QN5NIWv2kGDDftzb/g9VcajaqozHMiNrlkj5oS6UpsC32WN6+CJ5T9Fg6m6cM6DixwIPTg4w33jkQw0zkjRpMXhgv++jo/PB9eI8q/Fx4a/fWVYHvoFMMvJlcXye6yXW+5NDNjqZzGY453IObfh+pCpz8Fx2QdAGzB6GAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790382964; c=relaxed/simple;
	bh=0HafhSlUTvnNJzDDjj2rHuuMqJt/vvUsC9kE4HXpzgY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QhdDP0qgEMUf8hrr0aKadRcZffRYBaLUHxqQXqm7Y/EM1Hfw6VllA8URmCWicUVAkZundQRlSTrkuKaLHz7a6hIyDMnoH1AUeWw3XP5nMIACP+Er67Lt71DMV5ruIjAkDAEyaf1SIM2/kijGy3CaduktQkuLGoKyRgTyNjAckrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOPlN25Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOPlN25Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848A31F00898;
	Sat, 26 Sep 2026 00:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790382962;
	bh=h+4gPSOTo2MTr0s4gKG77Mt+mTzo+1Qz/UcjlmKdyrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GOPlN25Yy30IfOZA/NW9GaC/EuY5cVn5bRlJTC+RQt9OX7yAatuKPoRoCX7k+yG0/
	 BeT29ynKtRPbHjw4MzH6rJe7J6SwvwQiEmpO0SYPMIPxWTqsnfflrW8Eo8/LeY2xJ8
	 6sIdigknEZI8rezpvpHS2/sEX9eyLU0fYZqobAkj5KZvN6TgNt2q8Zl4lfchgJuqoy
	 3nI5ptCjlLa2Izy/NUq7CeXTHfXipCGnfeAb+KRCCCreOXrBOSUylO4A+7k7zyeogf
	 7VdGT2JmaoHe/VLMvH1iFnnYvDhLfC6qbAkIEUYgcRUsZolW/k2+ZUSNw+HB4wW/m8
	 VgRlAlQUn5+0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 1/8] eth: mpnic: add scaffolding for Meta
 Platforms NIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260924-linux-mpnic-v2-1-4badc9b58b9e@gmail.com>
References: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>
 <20260924-linux-mpnic-v2-1-4badc9b58b9e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 00:36:02 +0000
Message-Id: <20260926003602.848A31F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] eth: mpnic: missing PCI BAR0 length validation leads to out-of-bou=
nds MMIO access
--

commit 716880959e1661559f15c4ddde5849a4394122ac
Author: Daniel Zahka <daniel.zahka@gmail.com>

eth: mpnic: add scaffolding for Meta Platforms NIC

This commit introduces a bare PCI driver for the Meta Platforms Network
Interface Controller (MPNIC). It maps BAR0 and provides basic 64-bit MMIO
accessors with a fallback check to detect removed devices.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic.h b/drivers/net/ethern=
et/meta/mpnic/mpnic.h
> new file mode 100644
> index 0000000000000..6b8bee93033ab
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic.h
[ ... ]
> +static inline void mpnic_wr64(struct mpnic_dev *mpd, u32 reg, u64 val)
> +{
> +	u32 __iomem *csr =3D READ_ONCE(mpd->uc_addr0);
> +
> +	if (csr)
> +		writeq(val, csr + reg);

[Severity: High]
Does this blind pointer arithmetic risk out-of-bounds MMIO writes?

The generic accessor lacks bounds checking on reg, which could result in
writing past the end of the mapped BAR.

[ ... ]
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
Can this fallback check cause a kernel panic if a malicious or spoofed PCIe
device advertises a small BAR0?

This unconditionally reads from MPNIC_BDQ_SPARE (index 0x42013e, byte
offset 0x10804F8). If the mapped BAR is smaller than ~17.3MB, reading from
this hardcoded offset will crash the kernel.

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
[ ... ]
> +	mpd =3D mpnic_alloc(pdev);
> +	if (!mpd)
> +		return -ENOMEM;
> +
> +	uc_addr0 =3D pcim_iomap_region(pdev, 0, MPNIC_DRV_NAME);

[Severity: High]
Should we verify the device-provided BAR length before mapping it here?

BAR0 is mapped without checking if pci_resource_len(pdev, 0) is large
enough to encompass the driver's register layout. An attacker plugging in
untrusted hardware could advertise a small BAR0 (e.g., 4KB) and return
all-ones to an initial read. This would force the driver to read from
csr + MPNIC_BDQ_SPARE and crash the system.

> +	if (IS_ERR(uc_addr0)) {
> +		err =3D PTR_ERR(uc_addr0);
> +		dev_err(&pdev->dev, "Mapping the register file failed: %d\n",
> +			err);
> +		goto err_free_mpd;
> +	}
> +	mpd->uc_addr0 =3D uc_addr0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-linux-mpni=
c-v2-0-4badc9b58b9e@gmail.com?part=3D1
