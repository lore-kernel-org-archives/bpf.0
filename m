Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467964B8260
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597592; cv=none; b=NSUHtqZ1SK+6BfKBdjAXa9vQw3kTwLhV84l22+P/NiR28VK/DMertZSdna4qZWqgBz6pZP+Jdi9TtZ8DQPBpBYJe79dg/9/DYP0jfe7V3Pg/ulF62l9GPe1OoD2tNvjGg2/G9BLhTafTDbEPBtNZjL5rqU3DoGaN3oM8TAnyTM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597592; c=relaxed/simple;
	bh=pAjRehj8F2j7YLpJBXjI5H4PFUnfO1AJMSx44eoRbVk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pihm6J22+PH8oLXxfNUWD24n+T4B4Py6gmZI0BWCZwhvXD1XVhJVE+VCvi9mVLQDLppYHja0ojk/xjzp+FIZFDg13e7uhGUfLY2rHXuAHc/ziGxOVSCQx5/LkLGT4p8rfQKQ+qmNXwSHq7I9sMLlB7ep0RfH63FkG6amgFOAu2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pG531J3D; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pG531J3D"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5ce9914dso185000985a.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 05:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790597589; x=1791202389; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bxl5WCUMMfk8Oam1N+6ZJljVTjYwuVFvrDnpSkfKV00=;
        b=pG531J3D1AnTLru/UdUfCK82CNJ1HPIz3WdkCnYwlTF4hlJn3KI/KimUkzsocGHY+S
         kgBWsVMsMdIYze0wPFK5MZzVdudTcyORwMRBm9v9jkgAqr57W4+QDexRLeu9OVzbchB+
         vVnGTLcU5lCBWcNhSK7wAX0oLk41YJ+RAdo73506IK1fj40fkOsoeqeJ//KipD5XmYIS
         UcP2FqbZq7U5QShfnd+SmbksEIT/ROOZuVObR/do4+dAAtH8gnvCtlnRsjZhWRBsDUVh
         x4r1HkAQHcD7RFSUSEr2Gm0HRgIue9UjLXszXezqDbMMf44K3LqP1rUTS+xiLolwfAdQ
         eYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790597589; x=1791202389;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bxl5WCUMMfk8Oam1N+6ZJljVTjYwuVFvrDnpSkfKV00=;
        b=UnE10915Is0jyLzqb8H3LnsNhbFHLOKfIaJ/bO9xx0rPvnxk/+FIPC9QTfuXDaFT8A
         xhE28QxhkhXZw6PqrzNwZWDKT3WH/uTaG+SEDXrXnzSCjOpXsfb80a2ybtvgtW6mQf0j
         QlpqoySJ5tdVjOC3/M/JxCFAGxzAL6nYx8aQlyzBWxtPihmy0w8OAJ11m+eLxbQ69uhx
         g7Imzj/XBtyKFqjuHU7RCe+YjCAxA6y10kKJqjX217jWLAMX9QrmAY6InE92nEEBkWHW
         H3vhC9E6+89GgVuBsXUT18K61NYgGcFABpMocl90FpY3ap6eyxrJrAzpm1d0a2zQd65J
         Lb/Q==
X-Forwarded-Encrypted: i=1; AKwUvBza7cUHj706im6C31thxAHcbq8osWvo7xnblh9gRZo+52osj6QL15SNBR9KwN9jzcU0LpA=@vger.kernel.org
X-Gm-Message-State: AFuF++mhtaXgEqa917XKylc17j5DN7N4yiMAQkwe69nP/G8vreWZbO38
	jKBy6qZK/wsMGHG1GXu9XfA93MnWGrYxthYYzpPXVWjJCNmyb71S5dRk
X-Gm-Gg: AYBFou1qS5ldQ+JCBo3I4GepOx4wi0shPQvd6xBitLTAYtpDZMafuM1snywh2RL6BkV
	ZdBMuLv65wjaC4J2fWzbcBmiGjR0/L6bo04JC4dQmzsi0dArSjP8QTjXkhX8OwdgTu6AJ7ogH1u
	4IAp7tN0U6v+EDg4okEY2Qnf9ryTHui5w9WOV+xYqK0pMtk21awjohqUsTBzqbjplNnmSPykhLP
	241R5rBm9csCQ4etjJBI9rNCB/LAVZW6l+7SEr172XGG62TOytePGaSRH5soFRtsDKwixpKRI9L
	5oTFqaXDgABZqWKiAPxEYaTjpX2kQv0A7QchFc6Z1Geq9asS6KTGWTtW9r6qImNEh41dqpSSbzu
	UAbD+QBishQzTLbQVVsSnHXO0zNNp53HW5rR5arHKrA6yKC2nYN/LPMW/LLPZ8D/DZiFyRonbLg
	KoyQnRCvn8p8fClMT+QNPGMeYgkhzDZpDdiVJWcZTkrYcwfo1aGZn5ka3Hr2Dr3kSfBgCtP9yxs
	Yk/CJFTJU9dcA==
X-Received: by 2002:a05:620a:404b:b0:93c:8544:6ad8 with SMTP id af79cd13be357-93c85446bcemr165910085a.28.1790597588505;
        Mon, 28 Sep 2026 05:13:08 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c813a4587sm130752085a.7.2026.09.28.05.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 05:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 08:13:07 -0400
Message-Id: <DLQXVBJ05DI0.3CGZJGFQTFXRU@gmail.com>
Cc: <alexanderduyck@fb.com>, <kuba@kernel.org>, <kernel-team@meta.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <dimitri.daskalakis1@gmail.com>, <mohsin.bashr@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/8] eth: mpnic: add scaffolding for Meta
 Platforms NIC
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: <netdev-bot+sashiko@kernel.org>, <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260924-linux-mpnic-v2-1-4badc9b58b9e@gmail.com>
 <179055369730.3145.8922011696640547930@kernel.org>
In-Reply-To: <179055369730.3145.8922011696640547930@kernel.org>

On Sun Sep 27, 2026 at 8:01 PM EDT, netdev-bot+sashiko wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] eth: mpnic: missing PCI BAR0 length validation leads to out-of-
>   bounds MMIO access
>
> --
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c b/drivers/net/e=
thernet/meta/mpnic/mpnic_pci.c
>> --- /dev/null
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
>> @@ -0,0 +1,147 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) Meta Platforms, Inc. and affiliates. */
>> +
>> +#include <linux/dma-mapping.h>
>> +#include <linux/err.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/slab.h>
>> +#include <linux/types.h>
>> +
>> +#include "mpnic.h"
>> +
>> +#define PCI_DEVICE_ID_META_MPNIC	0x0014
>> +
>> +static void mpnic_mmio_err(struct mpnic_dev *mpd, u32 reg)
>> +{
>> +	/* Hardware is giving us all 1's reads, assume it is gone */
>> +	WRITE_ONCE(mpd->uc_addr0, NULL);
>> +
>> +	dev_err(mpd->dev,
>> +		"Failed read (idx 0x%x AKA addr 0x%x), disabled CSR access, awaiting =
reset\n",
>> +		reg, reg << 2);
>> +}
>> +
>> +u64 mpnic_rd64(struct mpnic_dev *mpd, u32 reg)
>> +{
>> +	u32 __iomem *csr =3D READ_ONCE(mpd->uc_addr0);
>> +	u64 value;
>> +
>> +	if (!csr)
>> +		return ~0ULL;
>> +
>> +	value =3D readq(csr + reg);
>> +
>> +	/* If any bits are 0 value should be valid */
>> +	if (~value)
>> +		return value;
>> +
>> +	/* All ones can be a valid value, so confirm against a register
>> +	 * which never reads that way on a live device.
>> +	 */
>> +	if (reg !=3D MPNIC_BDQ_SPARE && ~readq(csr + MPNIC_BDQ_SPARE))
>> +		return value;
>> +
>> +	mpnic_mmio_err(mpd, reg);
>> +
>> +	return ~0ULL;
>> +}
>> +
>> +static struct mpnic_dev *mpnic_alloc(struct pci_dev *pdev)
>> +{
>> +	struct mpnic_dev *mpd;
>> +
>> +	mpd =3D kzalloc_obj(*mpd);
>> +	if (!mpd)
>> +		return NULL;
>> +
>> +	pci_set_drvdata(pdev, mpd);
>> +	mpd->dev =3D &pdev->dev;
>> +
>> +	return mpd;
>> +}
>> +
>> +/**
>> + * mpnic_probe - Device initialization routine
>> + * @pdev: PCI device information struct
>> + * @ent: entry in mpnic_pci_tbl
>> + *
>> + * Return: 0 on success, negative on failure
>> + **/
>> +static int mpnic_probe(struct pci_dev *pdev, const struct pci_device_id=
 *ent)
>> +{
>> +	void __iomem *uc_addr0;
>> +	struct mpnic_dev *mpd;
>> +	int err;
>> +
>> +	if (pdev->error_state !=3D pci_channel_io_normal) {
>> +		dev_err(&pdev->dev,
>> +			"PCI device still in an error state. Unable to load...\n");
>> +		return -EIO;
>> +	}
>> +
>> +	err =3D pcim_enable_device(pdev);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "PCI enable device failed: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	err =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(46));
>> +	if (err) {
>> +		dev_err(&pdev->dev, "DMA configuration failed: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	mpd =3D mpnic_alloc(pdev);
>> +	if (!mpd)
>> +		return -ENOMEM;
>> +
>> +	uc_addr0 =3D pcim_iomap_region(pdev, 0, MPNIC_DRV_NAME);
>> +	if (IS_ERR(uc_addr0)) {
>> +		err =3D PTR_ERR(uc_addr0);
>> +		dev_err(&pdev->dev, "Mapping the register file failed: %d\n",
>> +			err);
>> +		goto err_free_mpd;
>> +	}
>> +	mpd->uc_addr0 =3D uc_addr0;
>> +
>> +	pci_set_master(pdev);
>> +	pci_save_state(pdev);
>> +
>> +	return 0;
>> +
>> +err_free_mpd:
>> +	kfree(mpd);
>> +
>> +	return err;
>> +}
>> +
>> +/**
>> + * mpnic_remove - Device removal routine
>> + * @pdev: PCI device information struct
>> + **/
>> +static void mpnic_remove(struct pci_dev *pdev)
>> +{
>> +	struct mpnic_dev *mpd =3D pci_get_drvdata(pdev);
>> +
>> +	kfree(mpd);
>> +}
>> +
>> +static const struct pci_device_id mpnic_pci_tbl[] =3D {
>> +	{ PCI_VDEVICE(META, PCI_DEVICE_ID_META_MPNIC) },
>> +	/* required last entry */
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(pci, mpnic_pci_tbl);
>> +
>> +static struct pci_driver mpnic_driver =3D {
>> +	.name		=3D MPNIC_DRV_NAME,
>> +	.id_table	=3D mpnic_pci_tbl,
>> +	.probe		=3D mpnic_probe,
>> +	.remove		=3D mpnic_remove,
>> +};
>> +
>> +module_pci_driver(mpnic_driver);
>> +
>> +MODULE_DESCRIPTION("Meta Platforms Network Interface Controller");
>> +MODULE_LICENSE("GPL");
>>
>
> [Severity: High]
> mpnic_probe() maps BAR0 with pcim_iomap_region() but never checks
> pci_resource_len(pdev, 0) against the register file size the driver
> expects. pcim_iomap_region() maps whatever length the device
> advertises. A device exposing a small BAR0, including a spoofed one
> behind Thunderbolt, ends up with a mapping much shorter than the CSR
> indices in mpnic_csr.h assume.
>
> mpnic_rd64() and mpnic_wr64() compute csr + reg with no bounds check.
> The all-ones fallback in mpnic_rd64() also unconditionally does a
> readq() at csr + MPNIC_BDQ_SPARE. That is byte offset 0x10804f8,
> roughly 16.5MiB into the BAR.
>
> Nothing calls the accessors in this patch yet. Once the follow-ups
> start touching CSRs from probe, a short BAR plus a single all-ones
> read would run past the end of the ioremap. That would fault, or hit
> whatever else happens to be mapped there.
>
> Could you reject the device in probe when BAR0 is too small to hold
> the register file? For example, compare pci_resource_len(pdev, 0)
> with the end of the highest CSR the driver touches (at least
> MPNIC_BDQ_SPARE * 4 + 8) and fail with -ENODEV. What is the
> architected size of BAR0 on this device?

This complaint was addressed in v1. For a pci device, we are assuming a
malicious or spoofed device is out of scope.
