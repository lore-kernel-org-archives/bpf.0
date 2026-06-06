Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97390246762;
	Sat,  6 Jun 2026 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780707687; cv=none; b=UdF9fqSLXsJj4FUG7fSpe4SjN+x5BifdGUj3R/Br7sAcwTDHJdQs6FCw7tvG7I9sU84HtZpPAHCkpo3+8WruRBhwuAaSwLe5QOaKingdKQFeqZg3HQ9xPLcOf24motVOyUxlM5wvruEh2v4/dMkQvSH3feyASKdFs6Xo7zsyxcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780707687; c=relaxed/simple;
	bh=ccKw5Xkhyrwt/h60VT4qagbDK+JsIIxGuxwnzfjEMrE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MMbofXAx54TExdhLUQyKLLKVgpJ2lynmP6EiM76HyGOwu9e/uCiTJM73xZ2FDRILUnI4qScFfR+TsAVBhXEDgR1pQlf/3Altymhl8gWIVR4GjcS6oc61ekudqv/tVefnULomqrDUc8ZTkvefqqW/Kvx/NP2jDZhVsVNjqgRQ1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyK9Oy/F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyK9Oy/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4085F1F00898;
	Sat,  6 Jun 2026 01:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780707685;
	bh=F8IR1xev0YFj4fyr1/R/+3sqKf5STgMVzQX5qRh+Llo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RyK9Oy/FHnC68EoCaAj42yfLWZm07A8hq6RWyVgl/KBGlrbbXKUl9Gi4FaW90/J2X
	 LNYbS0Vwbkp4bNx3ojEhQLoBoKvwaTQH8mPUYcqZpJluJ6Zf0zTuVzlI2QPYSqMB9F
	 s/qLrIUfAYMRAiVa1lsyC5n/+ad2VrPzTcdQMdBwZSZXmZmkZ89cywimgKyYcO4Zb9
	 DOI/kk5uLIa+B7AdE4nQ7GbZYfqC8hCgTNbuZleoThKne7UfjZyHpVhAYbcw/UfRLR
	 AbPzPfBRgg/L0auMy1NzP1cxVEi3t6neHPdlg4EFD6qe2ZY3uJLPKt6dacGtIr7zB+
	 YhGZBOwRLy/0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 11/14] misc: tc956x_pci: add TC956x/QPS615
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: conor+dt@kernel.org, bpf@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260605010022.968612-12-elder@riscstar.com>
References: <20260605010022.968612-12-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 01:01:24 +0000
Message-Id: <20260606010125.4085F1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] Custom pcim_alloc_irq_vectors() bypasses devres registration on su=
ccess, leaking IRQs on probe errors, and manual cleanup conflicts with devr=
es.
- [High] Missing pci_dev_put() in the success path of chip_get() leaks a PC=
I device reference.
- [High] Stateless device link between PCI functions allows unbind ordering=
 violations, leading to a Use-After-Free of the `chip` structure.
- [High] Premature hardware teardown in remove() causing active child devic=
es to access disabled hardware.
- [High] `regmap_update_bits` is called from a `noirq` PM callback without =
a raw spinlock, causing a sleep-in-atomic deadlock on PREEMPT_RT.
- [Medium] Incorrect devicetree property names `gpio-controllerX` and `#gpi=
o-cellsX` break GPIO controller detection.
- [Medium] Missing memory barriers when publishing and reading the shared `=
chip` structure.
- [Medium] Address translation (TAMAP) is enabled before the translation ad=
dresses are fully programmed.
--

commit 5c68969ec59d12e7df704f4552de14c677e77240
Author: Alex Elder <elder@riscstar.com>

misc: tc956x_pci: add TC956x/QPS615 support
   =20
The Toshiba TC956x is an Ethernet AVB/TSN bridge, and is essentially a
small and highly-specialized SoC. It implements a number of internal
functions, including a GPIO controller, registers that manage internal
reset and clock control signals, a PCIe switch, an internal PCIe endpoint,
and mapping hardware that translates between PCIe and internal addressing.

> diff --git a/drivers/misc/tc956x_pci.c b/drivers/misc/tc956x_pci.c
> index 0000000000000..88865712f00de
> --- /dev/null
> +++ b/drivers/misc/tc956x_pci.c

[ ... ]

> +static const struct regmap_config reset_clock_regmap_config =3D {
> +	.name		=3D "tc956x-clk-reset",
> +	.reg_bits	=3D 32,
> +	.reg_stride	=3D 4,
> +	.reg_base	=3D 0x1000,	/* Register NCTLSTS */
> +	.val_bits	=3D 32,
> +	.max_register	=3D 0x1010,	/* Register NRSTCTRL1 */
> +};
> +
> +/* Common clock/reset register update function (also used for MACs) */
> +void tc956x_reset_clock_set(const struct tc956x_chip *chip, bool reset,
> +			    bool reg0, bool set, u8 bit)
> +{
> +	u32 mask =3D BIT(bit);
> +	u32 offset;
> +
> +	if (reset)
> +		offset =3D reg0 ? RSTCTRL0_OFFSET : RSTCTRL1_OFFSET;
> +	else
> +		offset =3D reg0 ? CLKCTRL0_OFFSET : CLKCTRL1_OFFSET;
> +
> +	/* Note: no need to check for errors on read/write for MMIO regmap */
> +	(void)regmap_update_bits(chip->reset_clock_regmap, offset, mask,
> +				 set ? mask : 0);

[Severity: High]
This regmap config does not set .use_raw_spinlock =3D true. Because this is
called from tc956x_chip_suspend_noirq(), which executes with local hardware
interrupts disabled, won't taking the sleepable rt_mutex (on PREEMPT_RT)
produce a sleep-in-atomic bug?

[ ... ]

> +static struct device_node *dev_node_child_gpio(struct device *dev)
> +{
> +	struct device_node *np;
> +
> +	/* The GPIO sub-node is not required (platform might not need it) */
> +	for_each_child_of_node(dev->of_node, np)
> +		if (!strcmp(np->name, "gpio"))
> +			break;
> +	if (!np)
> +		return NULL;
> +
> +	/* If it's there, make sure it contains its required properties */
> +	if (!of_property_present(np, "gpio-controllerX"))
> +		dev_err(dev, "gpio node contains no gpio-contrller property\n");
> +	else if (!of_property_present(np, "#gpio-cellsX"))
> +		dev_err(dev, "gpio node contains no #gpio-cells property\n");

[Severity: Medium]
Are these property names correct? A correctly written devicetree uses
gpio-controller and #gpio-cells. The trailing "X" seems like a typo that
could cause valid devicetree nodes to fail validation, silently disabling t=
he
embedded GPIO controller auxiliary device.

[ ... ]

> +static void chip_tamap_config(struct tc956x_chip *chip)
> +{
> +	void __iomem *table_base =3D chip->bridge_config;
> +	void __iomem *entry_base;
> +	u32 trsl_param_val;
> +	u32 atr_size_val;
> +	u32 val;
> +	u32 i;
> +
> +	/*
> +	 * The lower bits of the source address must be zero, because the
> +	 * SRC_ADDR_LO register encodes the address translation space size
> +	 * and "implmented" bit there.  The size field defines the size of
> +	 * the translation space (2^(ATR_SIZE + 1)).  The minimum size is
> +	 * 4096 bytes, so ATR_SIZE value must be 11 or more.
> +	 */
> +	BUILD_BUG_ON(!!u32_get_bits(lower_32_bits(TC956X_SLV00_SRC_ADDR),
> +						  ATR_SIZE_MASK));
> +	BUILD_BUG_ON(TC956X_SLV00_SRC_ADDR & ATR_IMPL);
> +	BUILD_BUG_ON(SLV00_ATR_SIZE < 11);
> +
> +	/*
> +	 * We only use the first AXI4 slave TAMAC table:
> +	 *	EDMA address region:	0x10 0000 0000 - 0x1f ffff ffff
> +	 *	is translated to:	0x00 0000 0000 - 0x0f ffff ffff
> +	 */
> +	entry_base =3D table_base + AXI4_ENTRY_BASE(0);
> +
> +	atr_size_val =3D u32_encode_bits(SLV00_ATR_SIZE, ATR_SIZE_MASK);
> +	atr_size_val |=3D ATR_IMPL;
> +	val =3D lower_32_bits(TC956X_SLV00_SRC_ADDR) | atr_size_val;
> +	writel(val, entry_base + SRC_ADDR_LO_OFFSET);

[Severity: Medium]
Does writing ATR_IMPL here enable the translation window before the
destination addresses (TRSL_ADDR_LO_OFFSET and TRSL_ADDR_HI_OFFSET) are
fully programmed? This could create a race condition where any DMA transfer
or bus access occurring in this brief window will be translated using stale
or uninitialized address registers. Should the enable bit be set after all
other registers are programmed?

[ ... ]

> +static struct tc956x_chip *chip_get(struct pci_dev *pdev)
> +{
> +	unsigned int devfn =3D pdev->devfn;
> +	struct device *dev =3D &pdev->dev;
> +	struct tc956x_chip *chip;
> +	struct device_link *link;
> +	struct pci_dev *slot0;
> +	int ret;
> +
> +	/* Function 0 just allocates the chip structure */
> +	if (!PCI_FUNC(devfn)) {
> +		chip =3D devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> +		if (!chip)
> +			return ERR_PTR(-ENOMEM);
> +
> +		/*
> +		 * The function whose device pointer matches the chip's
> +		 * device pointer manages common resources (like MSIGEN).
> +		 */
> +		chip->dev =3D dev;
> +
> +		return chip;
> +	}
> +
> +	/* Function 1 has to get the chip structure from function 0 */
> +	slot0 =3D pci_get_slot(pdev->bus, PCI_DEVFN(PCI_SLOT(devfn), 0));
> +	if (!slot0)
> +		return ERR_PTR(-ENXIO);
> +
> +	/* If function 0 hasn't set up the chip yet, try again later */
> +	chip =3D dev_get_platdata(&slot0->dev);

[Severity: Medium]
Since function 0 locklessly assigns dev->platform_data =3D chip, and
function 1 retrieves it here locklessly, could concurrent probing or sysfs
binding cause function 1 to observe the pointer but read uninitialized or
partially initialized fields? Would it be safer to use smp_store_release()
and smp_load_acquire() when publishing and reading this shared pointer?

> +	if (!chip) {
> +		ret =3D -EPROBE_DEFER;
> +		goto err_put_slot;
> +	}
> +
> +	/* Mark function 1's device as dependent on function 0 */
> +	link =3D device_link_add(dev, &slot0->dev, DL_FLAG_STATELESS);

[Severity: High]
Does creating a stateless device link correctly enforce unbind ordering? Wi=
th
DL_FLAG_STATELESS, if Function 0 is manually unbound via sysfs, its devres
actions will immediately free the shared chip structure and unmap its PCI
BARs. Meanwhile, Function 1 and its auxiliary devices would remain bound,
potentially leading to a use-after-free and bus faults when they access the
freed structure and disabled hardware.

> +	if (!link) {
> +		ret =3D -ENODEV;
> +		goto err_put_slot;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(dev, chip_link_del, link);
> +	if (ret)
> +		goto err_put_slot;
> +
> +	return chip;

[Severity: High]
Does this success path leak the PCI device reference? pci_get_slot()
acquires a reference to Function 0's device, which is dropped in the error
paths via pci_dev_put(slot0), but it appears the reference is never released
here. Over multiple bind/unbind cycles, this could prevent the PCI device
from ever being freed.

> +
> +err_put_slot:
> +	pci_dev_put(slot0);
> +
> +	return ERR_PTR(ret);
> +}

[ ... ]

> +static int pcim_alloc_irq_vectors(struct pci_dev *pdev, unsigned int min=
_vecs,
> +				  unsigned int max_vecs, unsigned int flags)
> +{
> +	int ret;
> +
> +	ret =3D pci_alloc_irq_vectors(pdev, min_vecs, max_vecs, flags);
> +	if (ret)
> +		return ret;

[Severity: High]
pci_alloc_irq_vectors() returns the number of allocated vectors on success,
which is a positive number. Does this check cause the function to return
early on success, bypassing the devm_add_action_or_reset() below? This would
leak IRQs if the probe fails later.

> +
> +	return devm_add_action_or_reset(&pdev->dev, pcim_free_irq_vectors, pdev=
);
> +}
> +
> +static int
> +tc956x_function_probe(struct pci_dev *pdev, const struct pci_device_id *=
id)
> +{

[ ... ]

> +	ret =3D chip_init(chip, pdev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize chip\n");
> +
> +	ret =3D function_xgmac_adev_add(pdev, chip, msigen_irq);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add xgmap device\n");
> +
> +	/* We're ready; the other function can now probe */
> +	dev->platform_data =3D chip;
> +
> +	return 0;
> +}
> +
> +static void tc956x_function_remove(struct pci_dev *pdev)
> +{
> +	struct tc956x_chip *chip =3D dev_get_platdata(&pdev->dev);
> +
> +	if (&pdev->dev =3D=3D chip->dev)
> +		chip_msigen_disable(chip);
> +
> +	pci_free_irq_vectors(pdev);
> +
> +	pci_clear_master(pdev);
> +}

[Severity: High]
Does this premature hardware teardown cause active child devices to access
disabled hardware? Auxiliary child devices registered using devres will
execute their remove callbacks after this tc956x_function_remove()
completely finishes. However, the parent here actively resets hardware,
disables clocks, clears PCI bus mastering, and frees IRQs before the
children are dismantled. This could result in bus faults or system crashes
when child devices later execute their teardown.

Also, calling pci_free_irq_vectors() here explicitly conflicts with the
devres management established in pcim_alloc_irq_vectors() and could lead to
a double-free once the success path in pcim_alloc_irq_vectors() is fixed.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605010022.9686=
12-1-elder@riscstar.com?part=3D11
