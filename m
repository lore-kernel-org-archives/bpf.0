Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09B30274D;
	Thu, 16 Jul 2026 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185383; cv=none; b=asnt/sCyn+XfZYa+7VPCtm2ZdBgX05hGXDP9WsfOCTTYumG19FUhVCipWauJ+C/wIAgomXB5G1zE3ndbK+KiuPSjTYobA+/4Fmqw8lYYzIQmRguA/DuItg4lqhLBwKFGGLv0KWTk8fKAXhlu6vnxT6zJbjcnF89iJtE5AjUFwhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185383; c=relaxed/simple;
	bh=UJuRDBMkimoGr8tdAvZJiI+C7gbzOM2S6oiD9Cv/mZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrRK59rR1lRJzNio0BeJ11WefriOjRWcwKqdhsRNUNXMhsnNDNyB7LWtQWNB7ZbHxGJaPUO+YNpQ2AjA8eDJybgsWRHylHrD6xsfA4v5G3+x48kOS1p4Nn/ArulC+sTbKRVSuVWvsr9S1W8C8hmLM7dl42bv+m9Eg5qjFPY0O3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNtlpbDG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNtlpbDG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC6E1F000E9;
	Thu, 16 Jul 2026 07:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784185382;
	bh=FFNUu0XXRGHNtH40B1tomItE0NdjZli+GhoQ7HxIkQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MNtlpbDGcyUioUCN12h0sq/BaPNYcp3CTPfrl3k4yclHMwUiT0FKbToKL0v1p9GF1
	 A4Qe73qDyOWUrWqlxv7XeaAa/kMufIqD9W/sXZ1Dya/gML2/ABdtcyc+5qyVQlTY+u
	 KWt3XeJQ9HdwS2PpOiQefYOHtLvffdn6FUKXu3Yz32FhClnnzX8EIXgVkvHC6vKXJn
	 hO/AnRBwTqRxsg//fzq68A0dksQpiNHhMxys6I7ANN2swVPTyc52dmGqUe0h6VMgMu
	 1ms+hEojgD+9pEYegFTWYOyWVxG2xI9egyHr+D5WPU66s1QzzHVzejah5of6iifxWz
	 4KgTCPF6Rhbbw==
Date: Thu, 16 Jul 2026 09:02:39 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com, 
	rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, daniel@riscstar.com, 
	mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com, alexandre.torgue@foss.st.com, 
	ast@kernel.org, boon.khai.ng@altera.com, chenchuangyu@xiaomi.com, 
	chenhuacai@kernel.org, daniel@iogearbox.net, hawk@kernel.org, hkallweit1@gmail.com, 
	inochiama@gmail.com, john.fastabend@gmail.com, julianbraha@gmail.com, 
	livelycarpet87@gmail.com, mcoquelin.stm32@gmail.com, me@ziyao.cc, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com, rohan.g.thomas@altera.com, 
	sdf@fomichev.me, siyanteng@cqsoftware.com.cn, weishangjuan@eswincomputing.com, 
	wens@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 12/14] gpio: tc956x: add TC956x/QPS615 support
Message-ID: <dhnylud7o5dhaaq6kvbes4vkml3ppa5ev542j2lyxdijibknzg@pfcy22wz6jav>
References: <20260605010022.968612-1-elder@riscstar.com>
 <20260605010022.968612-13-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260605010022.968612-13-elder@riscstar.com>

On Thu, Jun 04, 2026 at 08:00:19PM -0500, Alex Elder wrote:
> Toshiba TC956x is an Ethernet-AVB/TSN bridge and is essentially
> a small and highly-specialized SoC.  TC956x includes a GPIO block that
> can be accessed, alongside several other peripherals, via two PCIe
> endpoint functions.  The PCIe function driver creates an auxiliary
> device for the GPIO block, and that device gets bound to this auxiliary
> device driver.
> 
> This driver is implemented using the generic regmap-based GPIO driver.
> 

While the regmap over the switch BAR works for GPIO access post-enumeration,
there is a blocker in using these GPIOs to control the power to endpoints.

We have a design [1] where the GPIOs from the switch are used to control power
and PERST# signals to the EP. With this current design, during the initial PCI
bus scan, the switch will get enumerated, but the EP will not. Because, power to
the EP depends on the GPIO Aux driver that will get probed only after the switch
enumeration.

But this creates a chicken-and-egg problem with the PCI Pwrctrl design.
pcie-qcom driver uses the Pwrctrl framework to power on the PCI endpoints before
the initial PCI bus scan. It calls pci_pwrctrl_create_devices() and
pci_pwrctrl_power_on_devices() APIs to create the platform device for all PCI
devices defined in DT (that require pwrctrl support), waits for their respective
pwrctrl drivers to get probed and then power ON all of them. This step is
required because in DT platforms, many Root Ports are not hotplug capable and
also BIOS doesn't assign bridge windows during boot. So all the devices has to
appear during the initial PCI bus scan so that the PCI core can allocate the
resources properly.

Now the issue with this Aux driver design is that, if an EP makes use of the
switch GPIO for PERST# or power, like:

	tc9563: pcie@0,0 {
		compatible = "pci1179,0623";
		reg = <0x10000 0x0 0x0 0x0 0x0>;
		...

		pcie@1,0 {
			compatible = "pciclass,0604";
			reg = <0x20800 0x0 0x0 0x0 0x0>;
			#address-cells = <3>;
			#size-cells = <2>;

			device_type = "pci";
			ranges;
			bus-range = <0x3 0xff>;

			reset-gpios = <&tc9563 5 GPIO_ACTIVE_LOW>;
		};
	...

	};

Then the pwrctrl driver (pci/pwrctrl/generic.c) will try to acquire the GPIO
controller during its probe, but will fail with -EPROBE_DEFER as the GPIO
controller won't be available at that time. So the whole PCIe instance will
probe defer as the driver requires all pwrctrl drivers to be probed before
starting the initial bus scan.

So we need to make sure that the GPIO controller driver is available before
enumerating the switch device. One way to achieve is by creating the GPIO Aux
device in the pci/pwrctrl/pci-pwrctrl-tc9563.c driver and let the GPIO
controller driver use I2C communication for setting up the GPIOs. Thankfully,
the switch allows both I2C and BAR MMIO configurations for internal GPIOs.

With this change, the GPIO driver will get probed by the time the pwrctrl
generic driver acquires the 'reset-gpios' and will turn ON the EP.

Let me know your thoughts!

- Mani

[1] https://lore.kernel.org/linux-pci/e2inl7k5gsjj6oomv2k5ximuzpb3gfiz66ufet3b4hvov7zqt4@qz4pifbos7yf/

> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  MAINTAINERS                |   1 +
>  drivers/gpio/Kconfig       |  12 ++++
>  drivers/gpio/Makefile      |   1 +
>  drivers/gpio/gpio-tc956x.c | 130 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 144 insertions(+)
>  create mode 100644 drivers/gpio/gpio-tc956x.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0924f7ec43cb0..0439607d1155f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27057,6 +27057,7 @@ M:	Alex Elder <elder@kernel.org>
>  M:	Daniel Thompson <danielt@kernel.org>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
> +F:	drivers/gpio/gpio-tc956x.c
>  F:	drivers/misc/tc956x_pci.c
>  
>  TOSHIBA WMI HOTKEYS DRIVER
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 020e51e30317a..36631ca722fa3 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -743,6 +743,18 @@ config GPIO_TB10X
>  	select GPIO_GENERIC
>  	select GENERIC_IRQ_CHIP
>  
> +config GPIO_TC956X
> +	tristate "Toshiba TC956X GPIO support"
> +	depends on TOSHIBA_TC956X_PCI
> +	select GPIO_REGMAP
> +	default m
> +	help
> +	  This enables support for the GPIO controller embedded in the Toshiba
> +	  TC956X (and Qualcomm QPS615).  This device connects to the host
> +	  via PCIe port, which is the upstream port on an internal PCIe
> +	  switch.  On some platforms, a few of the GPIO lines are used to
> +	  manage external resets.
> +
>  config GPIO_TEGRA
>  	tristate "NVIDIA Tegra GPIO support"
>  	default ARCH_TEGRA
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index b267598b517de..c3584e7cba9b4 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -178,6 +178,7 @@ obj-$(CONFIG_GPIO_SYSCON)		+= gpio-syscon.o
>  obj-$(CONFIG_GPIO_TANGIER)		+= gpio-tangier.o
>  obj-$(CONFIG_GPIO_TB10X)		+= gpio-tb10x.o
>  obj-$(CONFIG_GPIO_TC3589X)		+= gpio-tc3589x.o
> +obj-$(CONFIG_GPIO_TC956X)		+= gpio-tc956x.o
>  obj-$(CONFIG_GPIO_TEGRA186)		+= gpio-tegra186.o
>  obj-$(CONFIG_GPIO_TEGRA)		+= gpio-tegra.o
>  obj-$(CONFIG_GPIO_THUNDERX)		+= gpio-thunderx.o
> diff --git a/drivers/gpio/gpio-tc956x.c b/drivers/gpio/gpio-tc956x.c
> new file mode 100644
> index 0000000000000..0dc6b1028d970
> --- /dev/null
> +++ b/drivers/gpio/gpio-tc956x.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
> + */
> +
> +/*
> + * The Toshiba TC956X implements a PCIe Gen 3 switch that connects an
> + * upstream x4 port to two downstream PCIe x2 ports.  It incorporates
> + * an internal endpoint on a internal PCIe port that implements two
> + * Synopsys XGMAC Ethernet interfaces.
> + *
> + * 35 GPIOs are also implemented by an embedded GPIO controller.  Three
> + * registers control the first 32 GPIOs (other than 20 and 21, which are
> + * reserved).  Three other registers control GPIOs 32 through 36. GPIOs
> + * 22-24, 27-28, 31, and 34 are treated as "input only".
> + *
> + * There is a TC956X PCI power controller driver that accesses the
> + * direction and output value registers for GPIOs 2 and 3.  These
> + * GPIOs control the reset signal for the two downstream PCIe ports.
> + * Their values will never change during operation of this driver, and
> + * this driver reserves these two GPIOS.
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/gpio/regmap.h>
> +
> +#define DRIVER_NAME		"tc956x-gpio"
> +
> +#define TC956X_GPIO_COUNT	37	/* Number of GPIOs (20-21 reserved) */
> +
> +/* The GPIO offsets are relative to 0x1200 in TC956X SFR space. */
> +#define GPIO_IN0_OFFSET		0x00		/* Input value (0-31) */
> +#define GPIO_EN0_OFFSET		0x08		/* 0: out; 1: in (0-31) */
> +#define GPIO_OUT0_OFFSET	0x10		/* Output value (0-31) */
> +
> +/*
> + * There are two sets of registers, each representing (up to) 32 GPIOs with a
> + * stride of 4 bytes (IN1 is 4 bytes past IN0, EN1 is 4 bytes past EN0, etc.).
> + */
> +#define GPIO_PER_REG		32
> +#define GPIO_REG_STRIDE		4
> +
> +static int tc956x_gpio_init_valid_mask(struct gpio_chip *gc,
> +				       unsigned long *valid_mask,
> +				       unsigned int ngpios)
> +{
> +	/*
> +	 * GPIOs 2 and 3 are used by the PCI power control driver, and
> +	 * we don't allow them to be used.  GPIOs 20 and 21 are reserved
> +	 * (and not usable).
> +	 */
> +	bitmap_fill(valid_mask, ngpios);
> +	bitmap_clear(valid_mask, 2, 2);
> +	bitmap_clear(valid_mask, 20, 2);
> +
> +	return 0;
> +}
> +
> +static int tc956x_gpio_probe(struct auxiliary_device *adev,
> +			     const struct auxiliary_device_id *id)
> +{
> +	DECLARE_BITMAP(zeroes, TC956X_GPIO_COUNT);
> +	DECLARE_BITMAP(fixed, TC956X_GPIO_COUNT);
> +	struct gpio_regmap_config config = { };
> +	struct gpio_regmap *gpio_regmap;
> +	struct device *dev = &adev->dev;
> +
> +	/* We need the regmap pointer, stored in our platform data */
> +	if (!dev->platform_data)
> +		return -EINVAL;
> +
> +	/*
> +	 * Only some of our GPIOs are fixed direction:
> +	 *	22, 23, 24, 27, 28, 31, and 34	(all input-only)
> +	 * Set up the fixed bitmap to indicate which are fixed.
> +	 */
> +	bitmap_zero(fixed, TC956X_GPIO_COUNT);
> +	bitmap_set(fixed, 22, 3);
> +	bitmap_set(fixed, 27, 2);
> +	set_bit(31, fixed);
> +	set_bit(34, fixed);
> +
> +	/* All fixed GPIOs are input; the zeroes bitmap indicates that. */
> +	bitmap_zero(zeroes, TC956X_GPIO_COUNT);
> +
> +	config.parent = dev;
> +	config.regmap = dev->platform_data;
> +	config.label = DRIVER_NAME;
> +	config.ngpio = TC956X_GPIO_COUNT;
> +	config.reg_dat_base = GPIO_REGMAP_ADDR(GPIO_IN0_OFFSET);
> +	config.reg_set_base = GPIO_REGMAP_ADDR(GPIO_OUT0_OFFSET);
> +	config.reg_dir_in_base = GPIO_REGMAP_ADDR(GPIO_EN0_OFFSET);
> +	config.reg_stride = GPIO_REG_STRIDE;
> +	config.ngpio_per_reg = GPIO_PER_REG;
> +	config.init_valid_mask = tc956x_gpio_init_valid_mask;
> +	config.fixed_direction_mask = fixed;
> +	config.fixed_direction_output = zeroes;
> +
> +	gpio_regmap = devm_gpio_regmap_register(dev, &config);
> +	if (IS_ERR(gpio_regmap))
> +		return PTR_ERR(gpio_regmap);
> +
> +	return 0;
> +}
> +
> +static const struct auxiliary_device_id tc956x_gpio_ids[] = {
> +	{ .name = "tc956x_pci.tc9564-gpio", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(auxiliary, tc956x_gpio_ids);
> +
> +static struct auxiliary_driver tc956x_gpio_driver = {
> +	.name		= DRIVER_NAME,
> +	.probe          = tc956x_gpio_probe,
> +	.id_table       = tc956x_gpio_ids,
> +	.driver = {
> +		.name		= DRIVER_NAME,
> +		.owner		= THIS_MODULE,
> +		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +module_auxiliary_driver(tc956x_gpio_driver);
> +
> +MODULE_DESCRIPTION("Toshiba TC956X PCIe GPIO Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("auxiliary:" DRIVER_NAME);
> -- 
> 2.51.0
> 

-- 
மணிவண்ணன் சதாசிவம்
