Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB88380FE4;
	Fri,  5 Jun 2026 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670882; cv=none; b=Ch923Z+TN+aJrYJRRMXO8Rv+5uZFxpB/mHh1dUcPL6Q1PnzKTEuUpBC3Tj/TnMjaMDpQW6mFLRZqQ8F8m1pSKwJpp0W0+o1JzxRdxWtS8maXlcoKVq90IHLbqTVw0zseSO7kSwy1TS+X9QJ7TAl+Wg5CU5sBIuOm+OdgNGkZ7qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670882; c=relaxed/simple;
	bh=7VaHs4Hw2+bW+MLwlO7NNzAUukc9UC/1+NVhpE7Mqc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwI1iMYGtW5dTG7c1P4BgqvQ8BKVxeHmjI+XmzSj6RI9CuLCij2mPX7F1swYnLKZBgtMYiCgC9yBbRemslxciBQjgKKyofm33NNMea8E5MORfh+2ao1lqY6HINWCW/MnTMpp/Zsw3EoFL6cna/2qEPeGakGxuuWyacNpuPLImKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcDIn0z0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcDIn0z0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E051F00893;
	Fri,  5 Jun 2026 14:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780670879;
	bh=bfFH8ZVDSQVCgdkYKT1+TMLQUY2s3jnNF65qom08fFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YcDIn0z0biXIa+Od9GsBSTOJ6pAH9BCXCH0NzNYZHwJ4KR6orHsNPrVwhARZtUESp
	 OfefIB+JQzAYPEJuu2J3LvHDwoWFp8awD03ZQ6Ex/NhPDXM4YI/xPao97CuyJ2lPwk
	 5v3vGO29giHR0jblizx5wkkOoaJHIsI+0Cr8w2Pg4d1HeInCpGIZqsSNapx+UUhD00
	 hfR+J+9fg+K2ZMjd4ybYE1mn5/IZtuvlV6CvREIwCZsJViRaL/NVGtLTUt06naaEA0
	 lhrogLAmQTsiA59CvWJ7K0W0FmKbRwRUgp/eHEcZn4393IUGJDIZXYhJddrFW7TBIu
	 4kjMdRx3q74Eg==
Date: Fri, 5 Jun 2026 09:47:58 -0500
From: Rob Herring <robh@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk, andersson@kernel.org,
	konradybcio@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linusw@kernel.org, brgl@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, Daniel Thompson <daniel@riscstar.com>,
	mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
	alexandre.torgue@foss.st.com, ast@kernel.org,
	boon.khai.ng@altera.com, chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	hkallweit1@gmail.com, inochiama@gmail.com, john.fastabend@gmail.com,
	julianbraha@gmail.com, livelycarpet87@gmail.com,
	mcoquelin.stm32@gmail.com, me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
	rohan.g.thomas@altera.com, sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn, weishangjuan@eswincomputing.com,
	wens@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 13/14] net: stmmac: tc956x: add TC956x/QPS615
 support
Message-ID: <20260605144758.GB3659201-robh@kernel.org>
References: <20260605010022.968612-1-elder@riscstar.com>
 <20260605010022.968612-14-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605010022.968612-14-elder@riscstar.com>

On Thu, Jun 04, 2026 at 08:00:20PM -0500, Alex Elder wrote:
> From: Daniel Thompson <daniel@riscstar.com>
> 
> Toshiba TC956x is an Ethernet AVB/TSN bridge and is essentially a
> small and highly-specialized SoC. TC956x includes an "eMAC" subsystem
> that can be accessed, along with several other peripherals, via two
> PCIe endpoint functions. There is a main driver for the endpoint that
> decomposes things and creates auxiliary bus devices to model the SoC.
> 
> The eMAC consists of a Designware XGMAC, XPCS and PMA. Each eMAC is
> supported by an MSIGEN that bridges TC956x level interrupts to PCIe
> MSIs.
> 
> Add a driver for the eMAC/MSIGEN combination.
> 
> Co-developed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>

The order is wrong here unless you worked on it and then Daniel took 
over. Tags should be chronological order.

> ---
>  MAINTAINERS                                   |   2 +
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  14 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +
>  .../ethernet/stmicro/stmmac/dwmac-tc956x.c    | 818 ++++++++++++++++++
>  4 files changed, 836 insertions(+)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0439607d1155f..418537cbefbbb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27059,6 +27059,8 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
>  F:	drivers/gpio/gpio-tc956x.c
>  F:	drivers/misc/tc956x_pci.c
> +F:	drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
> +F:	include/soc/toshiba/tc956x-dwmac.h
>  
>  TOSHIBA WMI HOTKEYS DRIVER
>  M:	Azael Avalos <coproscefalo@gmail.com>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index e3dd5adda5aca..8d247e033e356 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -404,6 +404,20 @@ config DWMAC_MOTORCOMM
>  	  This enables glue driver for Motorcomm DWMAC-based PCI Ethernet
>  	  controllers. Currently only YT6801 is supported.
>  
> +config DWMAC_TC956X
> +	tristate "Toshiba TC956X DWMAC support"
> +	depends on PCI
> +	depends on COMMON_CLK
> +	depends on TOSHIBA_TC956X_PCI
> +	default TOSHIBA_TC956X_PCI
> +	select GENERIC_IRQ_CHIP
> +	help
> +	  This selects the Toshiba TC956X (and Qualcomm QPS615) support in the
> +	  stmmac driver.
> +
> +	  This provides support for the ethernet controllers found on these
> +	  devices.
> +
>  config STMMAC_PCI
>  	tristate "STMMAC PCI bus support"
>  	depends on PCI
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> index a1cea2f57252e..e8e7f95dbe3e8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> @@ -51,4 +51,6 @@ obj-$(CONFIG_STMMAC_PCI)	+= stmmac-pci.o
>  obj-$(CONFIG_DWMAC_INTEL)	+= dwmac-intel.o
>  obj-$(CONFIG_DWMAC_LOONGSON)	+= dwmac-loongson.o
>  obj-$(CONFIG_DWMAC_MOTORCOMM)	+= dwmac-motorcomm.o
> +obj-$(CONFIG_TC956X_PCI)	+= tc956x-pci.o
> +obj-$(CONFIG_DWMAC_TC956X)	+= dwmac-tc956x.o
>  stmmac-pci-objs:= stmmac_pci.o
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
> new file mode 100644
> index 0000000000000..c77585e4a50e6
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
> @@ -0,0 +1,818 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
> + *
> + * Derived from code having the following copyrights:
> + * Copyright (C) 2011-2012  Vayavya Labs Pvt Ltd
> + * Copyright (C) 2025 Toshiba Electronic Devices & Storage Corporation
> + */
> +
> +#include <linux/auxiliary_bus.h>

Based on the block diagram, these are PCI devices. Auxiliary bus is the 
wrong thing to use here.

Rob
