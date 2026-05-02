Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CBD3845C0
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777737380; cv=none; b=ahvYpxjdmlP9zQWr+yN2DcaZm7ClSZENGNQ9ZxCduEgkeJgsdw4RUwDkW8AkQCkb3GEUUmGAKIicxYPvuO+1vU931167YLml3UXNf76kq0KBCu+E/2rjNSjS360u0wc66WL5xVncuzpR6zYxi1KXZwOThUQAWDMMzQ3+LPLUVfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777737380; c=relaxed/simple;
	bh=s3pxqv69uaw9/ge2y+A/IMConfYhFCKwfeWUpaI0y8s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ba0kfoNC0ydlTa9HhtOy1IbAZ7XbrUnP3+6ZuyWzXg1ng7DhVZZYD25SVgx9Nem0uDlcX8qCOXWp7s9pM7jfg39gJQodz7WnFI12rq7D8EWlmrNJHdtKgumnptgMBnXKelsWfay/KoxCAdSHfR5DWmHODMaqHDDDMNyVa2dW8MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbrVwxKK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbrVwxKK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDFDC19425;
	Sat,  2 May 2026 15:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777737379;
	bh=s3pxqv69uaw9/ge2y+A/IMConfYhFCKwfeWUpaI0y8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YbrVwxKKcH/v9qcZmoXNe0xqwGJFXcFdrtw6FEjgjbvvSFAePGkoX+rnBYdfnhliu
	 XD9qA1h/vPB6031LlwLTA43rvwHcPAz9lYus19FEIAVxLqdMB8PzUg3MdoJJ+fY7/w
	 82pnCytVchsdS02ZLDPtMuo0r+R3inVIDo+cvSJ0yV4SMWr7D5Ebx8R+hhIjJvaU3e
	 MNkiJPJAHoRggDycDlFXJZLISJtjNOb/0UDA5vXMWyFuqJx+TWYSjphy9JrdWgzePY
	 +BG9wnq/+IhDndKFMAFvkwcizkk8N6W444aJeiagax9NGoSURdIU01EF8H+5BAtm1w
	 ZTiujc6PCr7RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 11/12] misc: tc956x_pci: add TC956x/QPS615
 support
Reply-To: sashiko@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260501155421.3329862-12-elder@riscstar.com>
References: <20260501155421.3329862-12-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 15:56:19 +0000
Message-Id: <20260502155619.BCDFDC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Dangling `platform_data` pointer and stateless device link lead to=
 Use-After-Free
- [High] Devres lifecycle violation causes memory leak of device links
- [High] Reference count leak of PCI peer device
- [High] Missing `pci_free_irq_vectors()` in error paths and remove function
--

commit 7eab7fd4b209226034d88bc445ad71c833dda6b7
Author: Alex Elder <elder@riscstar.com>

misc: tc956x_pci: add TC956x/QPS615 support

This commit introduces support for the Toshiba TC956x Ethernet AVB/TSN
bridge, configuring its PCI functions and creating auxiliary devices to
support the XGMAC interfaces.

diff --git a/drivers/misc/tc956x_pci.c b/drivers/misc/tc956x_pci.c
--- /dev/null
+++ b/drivers/misc/tc956x_pci.c

[ ... ]

> +static struct tc956x_chip *chip_get(struct pci_dev *pdev)
> +{

[ ... ]

> +	/* Function 1 has to get the chip structure from function 0 */
> +	peer =3D pci_get_slot(pdev->bus, PCI_DEVFN(PCI_SLOT(devfn), 0));
> +	if (!peer)
> +		return ERR_PTR(-ENXIO);

Does this leak the pci_dev reference count?

pci_get_slot() returns a device with its reference count incremented, but I
do not see a matching pci_dev_put(peer) in either the success path or when
returning -EPROBE_DEFER below.

> +
> +	/* If function 0 hasn't set up the chip yet, try again later */
> +	chip =3D dev_get_platdata(&peer->dev);
> +	if (!chip)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	/* Mark function 1's device as dependent on function 0 */
> +	link =3D device_link_add(dev, &peer->dev, DL_FLAG_STATELESS);

Is DL_FLAG_STATELESS safe to use here?

Stateless links do not enforce unbind ordering. If function 0 is unbound by
the user, its devres will free the chip structure and unmap the MMIO regions
while function 1 remains bound. Will function 1 cause a use-after-free if it
accesses the freed chip state or unmapped MMIO space?

> +	if (!link)
> +		return ERR_PTR(-ENODEV);
> +
> +	ret =3D devm_add_action_or_reset(&peer->dev, chip_link_del, link);

Should this cleanup action be attached to dev (function 1) instead of
peer->dev (function 0)?

If function 1's probe fails downstream, its own devres list is rolled back,
but this cleanup action remains attached to function 0. Will this leak the
device link and accumulate duplicate devres actions on function 0 each time
function 1 defers its probe?

> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return chip;
> +}

[ ... ]

> +static int
> +tc956x_function_probe(struct pci_dev *pdev, const struct pci_device_id *=
id)
> +{

[ ... ]

> +	/* We called pcim_enable_device() so this will be freed automatically */
> +	ret =3D pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
> +	if (ret < 1)
> +		return dev_err_probe(dev, ret ? : -EIO,
> +				     "failed to allocate IRQ vectors\n");

Is this comment accurate?

According to PCI subsystem guidelines, pci_alloc_irq_vectors() requires
explicit manual cleanup. Should the error paths below and the remove functi=
on
call pci_free_irq_vectors(pdev) to prevent leaking system IRQ resources?

> +
> +	ret =3D pci_irq_vector(pdev, 0);
> +	if (ret < 1)
> +		return dev_err_probe(dev, ret ? : -EIO, "failed to get IRQ\n");
> +	msigen_irq =3D ret;
> +
> +	ret =3D chip_init(chip, pdev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize chip\n");
> +
> +	/* We're ready; the other function can now probe */
> +	dev->platform_data =3D chip;
> +
> +	ret =3D function_xgmac_adev_add(pdev, chip, msigen_irq);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add xgmap device\n");

If function_xgmac_adev_add() fails, devm_kzalloc() will automatically free
the chip structure upon exit, but dev->platform_data is not cleared.

Will function 1's chip_get() retrieve this dangling pointer via
dev_get_platdata() and cause a use-after-free when it probes later?

> +
> +	return 0;
> +}
> +
> +static void tc956x_function_remove(struct pci_dev *pdev)
> +{
> +	struct tc956x_chip *chip =3D dev_get_platdata(&pdev->dev);
> +
> +	pci_clear_master(pdev);
> +
> +	if (&pdev->dev =3D=3D chip->dev)
> +		chip_msigen_disable(chip);
> +}

Does this function need a call to pci_free_irq_vectors(pdev) to clean up the
allocated IRQ vectors before returning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501155421.3329=
862-1-elder@riscstar.com?part=3D11
