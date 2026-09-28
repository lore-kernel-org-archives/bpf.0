Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC32433A9F8;
	Mon, 28 Sep 2026 00:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790553702; cv=none; b=g8C9cUCcC8CRt0/FiONrFeCRS7FZ16V2S/LPZ7w/LrrGbd+sT6JJu9Msq46778KizWu0Qa21uiz+NOBteSmI0narJ0fn2LaGl/wLa2H/oHk2MqUOpxhZs+AhnHzQnHTIZgL3Y5//cKmJwW5tgRtS9GjE0AGZ6XQSSrC7eLR+vfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790553702; c=relaxed/simple;
	bh=Qxl/feIeV+jLSTC4GYXne/UCaFm+0GjpGzJkNZupFxI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eU38IkC+5p1xfr6EJOxtxWxzLBI4MCuddzgRT7L9gGMr/q55becYnogflYsFFzhXXMD+I5ZZbObGsFOmfKyN2C3CMLPHXzSpu4JJ8h+9H0h67a6FPOrFDJLQ0oDWhqo2hmj2JvhGmBAX/uKyQe39uA4Q0JvEW1kB2nMfjYXssFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITGKima2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITGKima2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D2D1F000FF;
	Mon, 28 Sep 2026 00:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790553698;
	bh=g2y0ROSbOBCB9Xnoeix/ZIG8/wgCNd3TevwH5Fiuvn4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ITGKima27hGECZN6ECqgYb+MHd3dJNvAzCIlzH+NDghmZQeWL18VG/nWZ4lFD4jon
	 Hf5ZPYe5mYUSKDSDQTcesrJMbWugDUpgpkoeeNkj+sqdF8ZKpGifwKu/xSI6DAEYjT
	 bmHtgasgpWSpS+v7tMBRwyQpa0gqpO2Hda02Uuh9thKzGqSVv5Uke4Gh91bWXCQ7u6
	 VoftYM3vCCkeixXvyoi2yaFZK/lbu2VA8H+bQAl2kI7b+39Qe2NDiXrJT/MlPQps34
	 uP9GgGUT8qiimFzItXCA05v0PzzLvAitAf3/bniL6jDLICFHje4iY3spobto4ZbJKZ
	 Hn6RfFX0WV1jg==
Subject: Re: [PATCH net-next v2 1/8] eth: mpnic: add scaffolding for Meta
 Platforms NIC
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, dimitri.daskalakis1@gmail.com,
 mohsin.bashr@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Date: Mon, 28 Sep 2026 00:01:37 +0000
Message-ID: <179055369730.3145.8922011696640547930@kernel.org>
In-Reply-To: <20260924-linux-mpnic-v2-1-4badc9b58b9e@gmail.com>
References: <20260924-linux-mpnic-v2-1-4badc9b58b9e@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] eth: mpnic: missing PCI BAR0 length validation leads to out-of-
  bounds MMIO access

--

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include "mpnic.h"
> +
> +#define PCI_DEVICE_ID_META_MPNIC	0x0014
> +
> +static void mpnic_mmio_err(struct mpnic_dev *mpd, u32 reg)
> +{
> +	/* Hardware is giving us all 1's reads, assume it is gone */
> +	WRITE_ONCE(mpd->uc_addr0, NULL);
> +
> +	dev_err(mpd->dev,
> +		"Failed read (idx 0x%x AKA addr 0x%x), disabled CSR access, awaiting reset\n",
> +		reg, reg << 2);
> +}
> +
> +u64 mpnic_rd64(struct mpnic_dev *mpd, u32 reg)
> +{
> +	u32 __iomem *csr = READ_ONCE(mpd->uc_addr0);
> +	u64 value;
> +
> +	if (!csr)
> +		return ~0ULL;
> +
> +	value = readq(csr + reg);
> +
> +	/* If any bits are 0 value should be valid */
> +	if (~value)
> +		return value;
> +
> +	/* All ones can be a valid value, so confirm against a register
> +	 * which never reads that way on a live device.
> +	 */
> +	if (reg != MPNIC_BDQ_SPARE && ~readq(csr + MPNIC_BDQ_SPARE))
> +		return value;
> +
> +	mpnic_mmio_err(mpd, reg);
> +
> +	return ~0ULL;
> +}
> +
> +static struct mpnic_dev *mpnic_alloc(struct pci_dev *pdev)
> +{
> +	struct mpnic_dev *mpd;
> +
> +	mpd = kzalloc_obj(*mpd);
> +	if (!mpd)
> +		return NULL;
> +
> +	pci_set_drvdata(pdev, mpd);
> +	mpd->dev = &pdev->dev;
> +
> +	return mpd;
> +}
> +
> +/**
> + * mpnic_probe - Device initialization routine
> + * @pdev: PCI device information struct
> + * @ent: entry in mpnic_pci_tbl
> + *
> + * Return: 0 on success, negative on failure
> + **/
> +static int mpnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	void __iomem *uc_addr0;
> +	struct mpnic_dev *mpd;
> +	int err;
> +
> +	if (pdev->error_state != pci_channel_io_normal) {
> +		dev_err(&pdev->dev,
> +			"PCI device still in an error state. Unable to load...\n");
> +		return -EIO;
> +	}
> +
> +	err = pcim_enable_device(pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "PCI enable device failed: %d\n", err);
> +		return err;
> +	}
> +
> +	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(46));
> +	if (err) {
> +		dev_err(&pdev->dev, "DMA configuration failed: %d\n", err);
> +		return err;
> +	}
> +
> +	mpd = mpnic_alloc(pdev);
> +	if (!mpd)
> +		return -ENOMEM;
> +
> +	uc_addr0 = pcim_iomap_region(pdev, 0, MPNIC_DRV_NAME);
> +	if (IS_ERR(uc_addr0)) {
> +		err = PTR_ERR(uc_addr0);
> +		dev_err(&pdev->dev, "Mapping the register file failed: %d\n",
> +			err);
> +		goto err_free_mpd;
> +	}
> +	mpd->uc_addr0 = uc_addr0;
> +
> +	pci_set_master(pdev);
> +	pci_save_state(pdev);
> +
> +	return 0;
> +
> +err_free_mpd:
> +	kfree(mpd);
> +
> +	return err;
> +}
> +
> +/**
> + * mpnic_remove - Device removal routine
> + * @pdev: PCI device information struct
> + **/
> +static void mpnic_remove(struct pci_dev *pdev)
> +{
> +	struct mpnic_dev *mpd = pci_get_drvdata(pdev);
> +
> +	kfree(mpd);
> +}
> +
> +static const struct pci_device_id mpnic_pci_tbl[] = {
> +	{ PCI_VDEVICE(META, PCI_DEVICE_ID_META_MPNIC) },
> +	/* required last entry */
> +	{}
> +};
> +MODULE_DEVICE_TABLE(pci, mpnic_pci_tbl);
> +
> +static struct pci_driver mpnic_driver = {
> +	.name		= MPNIC_DRV_NAME,
> +	.id_table	= mpnic_pci_tbl,
> +	.probe		= mpnic_probe,
> +	.remove		= mpnic_remove,
> +};
> +
> +module_pci_driver(mpnic_driver);
> +
> +MODULE_DESCRIPTION("Meta Platforms Network Interface Controller");
> +MODULE_LICENSE("GPL");
>

[Severity: High]
mpnic_probe() maps BAR0 with pcim_iomap_region() but never checks
pci_resource_len(pdev, 0) against the register file size the driver
expects. pcim_iomap_region() maps whatever length the device
advertises. A device exposing a small BAR0, including a spoofed one
behind Thunderbolt, ends up with a mapping much shorter than the CSR
indices in mpnic_csr.h assume.

mpnic_rd64() and mpnic_wr64() compute csr + reg with no bounds check.
The all-ones fallback in mpnic_rd64() also unconditionally does a
readq() at csr + MPNIC_BDQ_SPARE. That is byte offset 0x10804f8,
roughly 16.5MiB into the BAR.

Nothing calls the accessors in this patch yet. Once the follow-ups
start touching CSRs from probe, a short BAR plus a single all-ones
read would run past the end of the ioremap. That would fault, or hit
whatever else happens to be mapped there.

Could you reject the device in probe when BAR0 is too small to hold
the register file? For example, compare pci_resource_len(pdev, 0)
with the end of the highest CSR the driver touches (at least
MPNIC_BDQ_SPARE * 4 + 8) and fail with -ENODEV. What is the
architected size of BAR0 on this device?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-linux-mpnic-v2-0-4badc9b58b9e%40gmail.com
