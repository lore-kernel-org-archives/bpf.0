Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D8A3F9A00
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778867976; cv=none; b=L5X/5GvxT/YLzWqNqi0evKZi8MEU/FB0ykFyH9Alv1Pr7b28qTtuPLgoJingZvBfaQPq34QhRx5ws/b3SUcMxsAIpsD1cyAbke4Dw9dHQetIXBi2w7cRgOVmUUisJ2vKNPWhrMNzegjNInw90gjwZdX1DTyyh2FWAce8Wj/jDow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778867976; c=relaxed/simple;
	bh=4ZM/T/Iol4GdBJ3vAdj/xlPSEBECPVnDvDzu8h7m9FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mABKZqJTAkCo6BkvHfa3elDzKIGomM57PjZ6Ej4iHieJz+Lgj44SnafxjefqK2s7Eo2v+yUvN3VTdurRJ1qA9D/RUUh9iRRbyGnQy7nvLOkhxje41J/R+imLA+dCBYK6G9qucrLHi1zyJtIacWC5JgR6piSNdLxSqXVTi/taujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=qVh7ugvm; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="qVh7ugvm"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8b3d6b215cfso490876d6.3
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778867972; x=1779472772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8SB7g/SQE94W836Nonq8Wq3k7Nj7c32M69MG7wU2+o=;
        b=qVh7ugvmRPA8oUMn5B7aXPu//lBgoxkU+3CwDEXgSDMYUalqHGG/1XK3IbP5KUPikc
         d/1H867qtVCJ60jgRjrgnXJNtf/PIk0OlnHz6Cs4+NYvh5SA/hU7Wr1qR0XbJl1TnNG8
         tFVsSwteK9QKyqljdA6Go6NBSe+i5WHMVUImzeR4rnOIpgEEmdA33eLOrgyIfkcjKQsl
         wIyW69xAs/j3mlBoDiOxd7c9AbI0xsj/eRsw4/eQJl/JOG0c8xon1u66cNYaYOBv3Pby
         CVeh6W0l4CqSbHYDvBZl9DWxa2rARflP4HbiJhTLYIWVKg/l3RhDcHAABTgueqYYVLLZ
         Vskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778867972; x=1779472772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8SB7g/SQE94W836Nonq8Wq3k7Nj7c32M69MG7wU2+o=;
        b=D95lquZJY6nuvKeBIzpz7S+maq6lQ4Otmia2y1V58zZvckTuWwnzo59Q+bvCG4Awv8
         v9qLT2jdusnGSCxhD7O0iXnZUpvo61XYFJ0mcY2TmIXlvR9ExtRIW+5fyPojzyHjZKfO
         x59HQtHpwAUTbkdLPEwg2F5kT2RR9USBo0gaOY4QZYfJ483tGG2ViAxEHlyFWQifYTzc
         iOFSU+eTe0u1NmMOPVJhRr2igU92p3yb7C6E2iCaE6AfLHweyMYJDX8ZrK6mXdwEwY7S
         q/dkQFmq3P/FfwFim/sYYHAnLNGbyI6YrSItzg4EE9VOxHAj7b/IyJGYNjKraMsJZctF
         l8mQ==
X-Forwarded-Encrypted: i=1; AFNElJ/EoGiw2XhSiF++5QZUrZQ9BkN8QqOOESSQ1R4HRW71XDyBUuJum8vcszCzFu51J1aiHQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbJUswJt4a9Zv35NFIpoHADd6bBXsbVqfi0RhVvOWMidFMYveH
	GL8Ilpk+F62SKuMV6Vs19zc+QWhlOVgxZ8guoXe7toghQN7epIU+2KmV3ulKpfHpXfs=
X-Gm-Gg: Acq92OFdZIZYir+dEN80yV54XEer0AzzKf2qWoSBLIZWSkWh1dDkMs7FJ9iI2v7xslN
	pMc3LNJH/OG3pHvhZxKu5EvajuohtoJzJ1HrWFwzBi/WbBrhNdpG6nSojQMBbUm4um8L/FqCQZt
	AQAIa1A5XVeE28ZxR1ZuVJiLskroQxO+VLfliMZvT1tRwyliauGAnvjwyy7yD5hSX5STumN3oDs
	ACuzYPDSXca6HG8/QD3RTksIJvZyMBNJrgwqXsDIQwjr1/c+vC8DGuDOu/9y0+52+ihYmLQ2boq
	5sXTcpdFzT3gG7k5IomT3ItGpmJfkcYfzW9J7NR6m7xEG1TjGBQ2IHdEQpocyWr3wCOYiyc5D+n
	vdXb2AGPxuy1b7dL8ChHyEX35tHv2vPSSiDekJ7NM5KHnkRM/2uFrrpWdDDib48sY4QX1T3cXv5
	vGzLKcdvmrwUsFQKkwz9cIV5XqJdvFdyoXz6vTkJcB8mQWjmenCxPuFeNTTgHYbPM=
X-Received: by 2002:a05:6214:5541:b0:8be:143c:955f with SMTP id 6a1803df08f44-8ca0f710315mr86073156d6.49.1778867972151;
        Fri, 15 May 2026 10:59:32 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90bf6720asm62107926d6.39.2026.05.15.10.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 10:59:31 -0700 (PDT)
Message-ID: <2414c9e9-0672-417a-a3d1-993bd06d62db@riscstar.com>
Date: Fri, 15 May 2026 12:59:27 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/12] net: enable TC956x support
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org,
 brgl@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: daniel@riscstar.com, mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
 alexandre.torgue@foss.st.com, ast@kernel.org, boon.khai.ng@altera.com,
 chenchuangyu@xiaomi.com, chenhuacai@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, hkallweit1@gmail.com, inochiama@gmail.com,
 john.fastabend@gmail.com, julianbraha@gmail.com, livelycarpet87@gmail.com,
 matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260501155421.3329862-1-elder@riscstar.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260501155421.3329862-1-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/26 10:54 AM, Alex Elder wrote:
> This series introduces stmmac driver support for the Toshiba TC9564
> (also known as Qualcomm QPS615).  This is an Ethernet-AVB/TSN bridge IC
> that provides a high-speed connection between a host SoC and Ethernet
> devices on a network.  It incorporates a PCIe switch, and implements
> two 10 Gbps capable Ethernet MACs (along with other IP blocks), and
> is essentially a small and highly-specialized SoC.  The TC9564 is a
> member of a family of similar chips, and the driver code uses "tc956x"
> to reflect this.

I'm writing now to just state what the plan is for version 2
of this series.  I had hoped to get something out this week,
but it won't be available today, so I wanted to at least let
people know what to expect.

First, we received a great deal of really good feedback on
this series.  I/we sincerely appreciate it, and have already
addressed almost all of the suggestions people have made.

Andrew Lunn asked a number of questions about the way that
the TC956x device is represented, and in particular questioned
whether having the GPIO controller as a device subordinate to
a PCIe function even made sense.  This led to some additional
discussion, including some offline work exploring what other
options might be reasonable.

The plan for version 2 is to submit it fairly soon, to include
updates that address *most* of the feedback received so far.
(I have sent e-mail with clear confirmation of what we intend
to do--and these changes would be incorporated in version 2).

However, because there remain other outstanding issues,
including "big picture" questions about how to represent the
hardware, the series will be sent as RFC.

This will allow others to see the changes we made based on
feedback, but also makes it clear there is more work that
needs to be done before we're confident in our final proposal.

					-Alex

> TC956x chips incorporate a PCIe gen 3 switch, with one upstream and
> three downstream ports.  Its PCIe functionality is already supported
> upstream, including a power control driver that performs some early
> configuration of the PCI ports ("pci-pwrctrl-tc9563.c").
> 
> One of the PCIe switch's downstream ports has an internal PCIe endpoint,
> which implements two PCIe functions, each of which has an Ethernet MAC
> (eMAC) subsystem. The eMAC is composed of a Synopsis Designware XGMAC
> combined with an XPCS and PMA.  Each MAC is capable of operating at
> 10M/100M/1G/2.5G/5Gps and 10Gps.  The initial target platform is the
> Qualcomm RB3gen2, which supports a 10Gbps Marvell PHY on port A, and
> a 2.5Gbps Qualcomm PHY on port B.  (The Marvell PHY is not populated on
> all RB3gen2 boards, and only 2.5 Gbps support is included initially.)
> 
> TC956x chips also implement several other blocks of functionality,
> including a GPIO controller, interrupt controllers (MSIGEN), I2C
> and SPI, a UART, and an Arm Cortex M3 CPU with 128KB SRAM.  The GPIO
> interface exposes several lines to manage external resets.  The
> interrupt controllers are used internally by the MAC functions.  The
> UART, SPI, microcontroller, and SRAM are currently unused.
> 
>                ----------------------------------
>                |              Host              |
>                ------+...+----------+........+---
>                      |i2c|          |  PCIe  |
>      ----------------+...+----------+........+------
>      | TC956x        |I2C|          |upstream|     |
>      |               -----        --+--------+---  |
>      |  -----  ------  -------    | PCIe switch |  |
>      |  |SPI|  |GPIO|  |reset|    |             |  |
>      |  -----  ------  |clock|    | DS3 DS2 DS1 |  |
>      |                 -------    ---++--++--++--  |
>      |  -----  ------     downstream//    \\  \\   |  downstream
>      |  |MCU|  |SRAM|    /==========/      \\  \===== PCIe port 1
>      |  -----  ------   //PCIe port 3       \\     |
>      |                  ||                   \======= downstream
>      |  ----+-----------++-----------+----         |  PCIe port 2
>      |  | M | internal PCIe endpoint | M |         |
>      |  | S |------------------------| S |  ------ |
>      |  | I |   PCIe   |  |   PCIe   | I |  |UART| |
>      |  | G |function 0|  |function 1| G |  ------ |
>      |  | E |----++----|  |----++----| E |         |
>      |  | N |  eMAC 0  |  |  eMAC 1  | N |         |
>      --------+.......+------+.....+-----------------
>              |USXGMII|      |SGMII|
>            --+.......+--  --+.....+--
>            |  ARQ113C  |  | QEP8121 |
>            |    PHY    |  |   PHY   |
>            -------------  -----------
> 
> The primary objective for this series is to support the Ethernet
> functionality provided by the TC956x.  The code providing this
> support has been structured into three distinct modules.
>    - A driver for the GPIO controller
>    - Code enabling the TC956x-specific eMAC/MSIGEN hardware
>    - A "chip" driver, associated with the PCIe functions
> 
> The GPIO driver is implemented separately because in some hardware
> configurations, these GPIO lines are used to manage resets for
> external Ethernet PHYs.  We describe these PHYs via devicetree,
> where the GPIO-based reset signals are defined using phandles.
> 
> The code for the eMAC/MSIGEN consists of a new source file that
> populates hardware-specific details about the two MACs, and integrates
> with the existing stmmac driver.  This also required implementing some
> enhancements to the core stmmac driver, described further below.
> 
> To manage the common functionality (including configuring address
> translation and controlling internal reset and clock signals), a
> "chip" driver is implemented.  This chip driver is associated with
> the PCIe function *itself*, not the eMAC associated with the function.
> 
> The driver binds to the internal PCI functions 0 and 1, and creates
> a shared data structure describing the common chip elements the two
> driver instances share.  Three auxiliary bus devices are created to
> represent the GPIO controller and the two Synopsys MAC controllers.
> 
> The driver instance for PCIe function 0 has responsibility for
> controlling the common chip functionality--creating the GPIO
> controller auxiliary device, configuring address translation
> between PCIe address space and internal addresses, and controlling
> clocks and resets.  It creates a data structure--shared via its
> platform data pointer with PCIe function 1--to represent shared
> "chip" information.  In addition, PCIe function 0 creates an
> auxiliary device to represent its attached eMAC.  It allocates
> IRQs and maps BAR address ranges for use by the stmmac driver,
> passing them in a structure via the auxiliary device's platform
> data.
> 
> PCIe function 1 defers probing until after PCIe function 0 has
> created the shared data structure.  After that its only job is
> to set up IRQs and mapped memory and create the eMAC1 auxiliary
> device.
> 
> The version of the Synopsys MAC IP is 3.01, which is largely compatible
> with version 2.20.  The core stmmac driver required several changes to
> enable support for the TC956x.
>    - A change to dwxgmac2 support changes the interrupt mode when
>      multi_msi_en is enabled.
>    - While most support for version 3.01 simply uses the 2.20 code,
>      an erratum related to the RX ring length is implemented for
>      3.01 DMA operations.
>    - Having the PCIe device be separate from an auxiliarly device
>      implementing the eMAC required allowing a distinct DMA device
>      to be maintained for an stmmac interface.
> 
> In addition:
>    - A new source file provides memory-mapped access to XPCS using
>      regmap.  The alignment of the TC956x MDIO registers aren't
>      suitable for using simple MMIO.
>    - Two additional XPCS changes are implemented that provides
>      support for the XPCS as implemented in the TC956x.
> 
> This series is available here:
>    https://github.com/riscstar/linux/tree/tc956x/stmmac-v1
> 
> 					-Alex (and Daniel)
> 
> Alex Elder (3):
>    net: stmmac: dma: create a separate dma_device pointer
>    gpio: tc956x: add TC956x/QPS615 support
>    misc: tc956x_pci: add TC956x/QPS615 support
> 
> Daniel Thompson (9):
>    net: pcs: pcs-xpcs-regmap: support XPCS memory-mapped MDIO bus via
>      regmap
>    net: pcs: pcs-xpcs: select operating mode for 10G-baseR capable PCS
>    net: pcs: pcs-xpcs: Preserve BMCR_ANENBLE during link up
>    net: stmmac: dwxgmac2: Add multi MSI interrupt mode
>    net: stmmac: dwxgmac2: Add XGMAC 3.01a support
>    net: stmmac: dwxgmac2: export symbols for XGMAC 3.01a DMA
>    dt-bindings: net: toshiba,tc965x-dwmac: add TC956x Ethernet bridge
>    net: stmmac: tc956x: add TC956x/QPS615 support
>    arm64: dts: qcom: qcs6490-rb3gen2: enable TC9564 with a single QCS8081
>      phy
> 
>   .../bindings/net/toshiba,tc956x-dwmac.yaml    | 111 +++
>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  |  45 +-
>   drivers/gpio/Kconfig                          |  11 +
>   drivers/gpio/Makefile                         |   1 +
>   drivers/gpio/gpio-tc956x.c                    | 209 +++++
>   drivers/misc/Kconfig                          |  10 +
>   drivers/misc/Makefile                         |   1 +
>   drivers/misc/tc956x_pci.c                     | 667 +++++++++++++++
>   drivers/net/ethernet/stmicro/stmmac/Kconfig   |  13 +
>   drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +
>   .../net/ethernet/stmicro/stmmac/chain_mode.c  |  12 +-
>   .../ethernet/stmicro/stmmac/dwmac-tc956x.c    | 791 ++++++++++++++++++
>   .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  12 +
>   .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |   1 +
>   .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |   1 +
>   .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  78 +-
>   .../net/ethernet/stmicro/stmmac/ring_mode.c   |  12 +-
>   drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   1 +
>   .../net/ethernet/stmicro/stmmac/stmmac_main.c |  59 +-
>   .../net/ethernet/stmicro/stmmac/stmmac_xdp.c  |   2 +-
>   drivers/net/pcs/Makefile                      |   4 +-
>   drivers/net/pcs/pcs-xpcs-regmap.c             | 203 +++++
>   drivers/net/pcs/pcs-xpcs.c                    |  43 +-
>   include/linux/pcs/pcs-xpcs-regmap.h           |  20 +
>   include/linux/stmmac.h                        |   1 +
>   include/soc/toshiba/tc956x-dwmac.h            |  84 ++
>   26 files changed, 2341 insertions(+), 53 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
>   create mode 100644 drivers/gpio/gpio-tc956x.c
>   create mode 100644 drivers/misc/tc956x_pci.c
>   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
>   create mode 100644 drivers/net/pcs/pcs-xpcs-regmap.c
>   create mode 100644 include/linux/pcs/pcs-xpcs-regmap.h
>   create mode 100644 include/soc/toshiba/tc956x-dwmac.h
> 
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731

