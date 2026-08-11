Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3EB3BB106
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456007; cv=none; b=LgnRYPs+T772DefeTo0DjLJJowb7uWG+IVcuT+NC+whXu/IH8h2VCIVhaFB4tgz5t3krKT4hgC7BFQNORfgr5KK12tJzf1+Ir06T6cFskgQW6l15BPETOTU17mL7D1mzEGbQ3XOy+Whw2NtoVI7Av5QM9u6wqSgcjWgiFwVDhjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456007; c=relaxed/simple;
	bh=TH9G91uof6RAw2w/hszikMzZYVW99dPv4NwWlB+q73w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nb4WOXKp4rXvyzZS4ZETcu/HGaggHJ9Aae946+Ojdl9IuxXccFvbUsobKDFZCGWgcjAfZ7hGLUAectqRYUzD/dekS0H6HTf3dKA8J9Qshl2QllJliv95FbkywZF1JD/16Z6u/TWkJwiBVuUSTrTAvaS4vIhQ66bgf7GXF31CgeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Y6LHolrA; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Y6LHolrA"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b0f19bea2fso3308305e87.1
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786455999; x=1787060799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FMhZi9etRWtnaHOdlgeIDPYPs8YW3ryoczmOB+92hZg=;
        b=Y6LHolrAb7fadoL5q4D37wG/DydqG/IPeiDV0iXZM/serosGcjYbVzBkG40FCblhDO
         JUVF6ejIkP2aiTtP4ZXPpGbfO+lh5qJzO7j4dIzc7sHU9dZY4ghNh/iAAzgcbsptVSYD
         3blX0BVi0juYPjIzh8ChRRqmuKnUpjcKBkHKH+Y8XP73n+BNtTEmTZNOQklXu98cRCRH
         vq4vCa8H/tDPy+Zm3RXak2wku3FErOgih6WtCxr3FtENyqoFvAeLOtfJz1oySfuN9VT8
         8UGD7XSq6IJKTdX8wCp+nU0MlEpk68V8i0qF1kNhZjkERcOXTm8lSbXZACV453HZZmaw
         uZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786455999; x=1787060799;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FMhZi9etRWtnaHOdlgeIDPYPs8YW3ryoczmOB+92hZg=;
        b=kIttbX/QHYLlHYPgTrDblm/lhXbrunUqFWHh28A838paFO09LZGTvPUkHJ8jCxlrfE
         Nnm/AkFQzgjWY7aEaoHl1rTUYOwOKfYtUuOT4VdcM7n8qrvjndESlelYavfECFn397wt
         5KVfCOb6qy9R061f/5+hMfY+jH3B7CQwuZ7AnDFQRUbKedNuFh2BtaM83cvivC9jrMjU
         lMeVxnyJJMvX90kuzln7JvbFmaieQSIsyW5IzxSlSobpQitiqK6gBBKE86ZZhXFabS2G
         RkK2RdkRGj66fw7laYsZOI8hV/2+lqG6tz4Npd5/D2gu3m0mmwMw365XP3FnjW8qrIhv
         iyqQ==
X-Forwarded-Encrypted: i=1; AHgh+RqOCrah0FMSp+u5//3FrNCGSk/1Kjl9q3P9PlIVHxtIwp9WfOf8IpOBx8ExDqyLSCuQQPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP9foe9FoLLSzJmPPF12uTMx9qowi0HHu5OVw6uTeCRDi3arAO
	ea2JTY0FkW4+2LkbCNJgJMNj43DfhwY2lKKciUQnbmglpxYSH+9CCMb2Cr60W7Kj1ow=
X-Gm-Gg: AR+sD11GssEjVfU7Q4+gSEdoJwblsT/K2uRmED0Eb5WOsHS8uFbAHlOCmnJE+p45Vof
	OAq72ZqYqhND5H3xeabJKQF85SwOqZJ95ge5f4jZjYueNdhQeyj3Po7HW072cuCxKiqu4nB4Fzl
	jdVsE4WXnNj3nRg8bImqE26gtKzPtoX1J7UGioe4ljMaUx0EbMjtaK5bSuz6lECMt8F5OjaT/SX
	6B4q2Pr/g0HKIMRCUerxtM++n+dOHBp42eMqdMe6U7IY3+Kpvjj+KPuVjcIRAPBYpiq+KD0EkXQ
	PaqP4gGigLcNMRYPqI7Bd8vK6wAg8ptx3BIe3JtJC3mfhW8bOUX2MIlasWCZr5jn3EQQj+DS8WQ
	M0ovPY2zUnYqWwj8YFdy60g/nBSPUOb5FQqWfUa6/bgW69IaUlR8ZJylcsciHa+HtOAG1YpXqwl
	R6b8FNUQiLGtmUeBtOQuWdzgbkpg2DR46E3du5n8dqZw/eTRoPuXBfU4pg1HAI
X-Received: by 2002:a05:6512:1386:b0:5b0:eda:de2c with SMTP id 2adb3069b0e04-5b4485f7b4cmr557681e87.17.1786455998165;
        Tue, 11 Aug 2026 06:46:38 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b448724cdcsm316327e87.49.2026.08.11.06.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 06:46:37 -0700 (PDT)
Message-ID: <43047f17-7cb4-435d-8313-91c9362f085e@riscstar.com>
Date: Tue, 11 Aug 2026 08:46:26 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/14] net: enable TC956x support
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
 mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260605010022.968612-1-elder@riscstar.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260605010022.968612-1-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/26 8:00 PM, Alex Elder wrote:
> (A fairly detailed list of changes since v1 is included below.
> Because there are so many changes listed, they are not repeated
> in the individual patches that follow.  Note also that this
> series depends on two prerequisite commits, as explained below.)

We are now ready to send version 3 of this series.  It has undergone
a complete restructuring, though many detailed bits of code remain
the same as before.  Because of this we intend to use a new strategy
in posting the code for review.  I describe that here; if you think
there are things we could do differently to improve this process,
please say so.

I can provide a longer explanation for how the new model works if
that is requested, but here is a summary of the process:
- There will be no "version 3" of the original series.
- Instead, the TC9564 will be treated as an SoC that consists
   of a set of distinct components (clock, reset, interrupts,
   GPIO, etc.).
- Support for each of these components will be provided by
   distinct platform device drivers.
- These platform drivers will be upstreamed independently.
   I.e., the clock driver will be sent to clock maintainers for
   review, the reset driver will be sent to reset maintainers,
   and so on.
- One of these platform drivers will provide support for the
   XGMAC 10 Gbit Ethernet interface (whose support was the
   the original, primary goal of this series).
- The anchor driver is a PCI endpoint/function driver, which
   implements the framework necessary to support the pci-ep-bus
   that all the other devices use for their MMIO.

We will send the code for all of these parts out for review
separately.  Upstreaming each can proceed independently, and
when all are eventually accepted (including devicetree updates),
the originally-desired XGMAC functionality will be supported.

Here is a list of the "components":
- PCI driver (drivers/misc/tc9564-pci.c)
- Clock driver (drivers/clk/clk-tc9564.c)
- Reset driver (drivers/reset/reset-tc9564.c)
- Interrupt controller driver (drivers/irqchip/irq-tc9564-msigen.c)
- Address translation unit driver (drivers/misc/tc9564-translate.c)
- XGMAC driver (drivers/net/ethernet/stmicro/stmmac/dwmac-tc9564.c)

There was previously a GPIO driver included.  That has been
reimplemented to be accessed via I2C rather than PCIe BARs.
The new version will be associated with the PCI pwrctl driver,
pci-pwrctrl-tc9563.c, and will be posted for review separately.

					-Alex

> This series introduces stmmac driver support for the Toshiba TC9564
> (also known as Qualcomm QPS615).  This is an Ethernet-AVB/TSN bridge IC
> that provides a high-speed connection between a host SoC and Ethernet
> devices on a network.  It incorporates a PCIe switch, and implements
> two 10 Gbps capable Ethernet MACs (along with other IP blocks), and
> is essentially a small and highly-specialized SoC.  The TC9564 is a
> member of a family of similar chips, and the driver code uses "tc956x"
> to reflect this.
> 
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
> a 2.5Gbps Qualcomm PHY on port B.  (The Marvell PHY is not populated
> on all RB3gen2 boards, and only the 2.5 Gbps Qualcomm PHY is supported
> initially.)
> 
> TC956x chips also implement several other blocks of functionality,
> including a GPIO controller, interrupt controllers (MSIGEN), I2C
> and SPI, a UART, and an Arm Cortex M3 CPU with 128KB SRAM.  The GPIO
> interface exposes several lines to manage external resets.  The
> interrupt controllers are used internally by the eMAC functions.  The
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
>    - A "chip" driver, associated with the PCIe functions
>    - A driver for the GPIO controller
>    - Code enabling the TC956x-specific eMAC/MSIGEN hardware
> 
> To manage the common functionality (including configuring address
> translation and controlling internal reset and clock signals), a
> "chip" driver is implemented.  The chip driver binds to PCI
> functions 0 and 1, and creates a shared data structure describing
> the common chip elements shared by the two driver instances.  PCIe
> function 1 defers probing until after PCIe function 0 has created
> this shared data structure.
> 
> Common/shared functionality is handled by PCIe function 0.  This
> common code uses PCIe function 0's mapped BARs to configure the
> hardware.  If the TC9564 GPIO controller is needed (i.e., defined
> in a node in devicetree), it is created as an auxiliary device
> when PCIe function 0 is probed.
> 
> Both PCIe function 0 and function 1 implement an Ethernet
> controller as well, though one or the other might be unused on
> a given platform.  If a PCIe function node defines an ethernet
> subnode in devicetree, the corresponding eMAC is enabled, and
> the PCIe function driver will create an auxiliary device to
> represent it.
> 
> The GPIO driver is implemented separately because in some hardware
> configurations, these GPIO lines are used to manage resets for
> external Ethernet PHYs.  We describe these PHYs via devicetree,
> where the GPIO-based reset signals are defined using phandles.
> 
> The code for eMAC and MSIGEN consists of a new source file that
> populates hardware-specific details about the two MACs, and integrates
> with the existing stmmac driver.  This also required implementing some
> enhancements to the core stmmac driver, described further below.
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
> NOTE:
>      This series is based on net-next/main, but depends on these
>      two commits found in linux-next/master:
> 
> 	68d801eabda52 gpio: regmap: Support sparsed fixed direction
> 	806e7acf7f331 gpio: regmap: Don't set a fixed direction line
>         
> 					-Alex (and Daniel)
> 
> This series is available here:
>    https://github.com/riscstar/linux/tree/tc956x/stmmac-v2
> 
> Changes between version 1 and version 2:
> 
> NEW
>    - The qca808x.c PHY driver now supports enabling up to four optional
>      regulators
> 
> GENERAL
>    - The order of patches has been rearranged a bit.  One consequence
>      is that the TOSHIBA_TC956X_PCI Kconfig symbol is now defined
>      before it's used.
> 
> PATCH 00/12
>    - MAINTAINERS entries have been added for all new files
> 
> PATCH 01/12
>    - devm_xpcs_regmap_register() now ensures the xpcs_destroy() is
>      called when the device is unbound (suggested by Sashiko).
> 
> PATCH 02/12
>    - Reworked how the quirky behavior was handled.  Now:
>      - A soft reset is issued in xpcs_pre_config() *before* calling
>        xpcs_switch_interface_mode() calls txgbe_xpcs_switch_mode().
>        It does this now for an SGMII interface, not just if the
>        need-reset flag is set
>      - xpcs_switch_interface_mode() calls txgbe_xpcs_switch_mode(),
>        preserving previous behavior
>      - For other (non-Wangxun) platforms, if the XPCS supports
>        10Gbase-R, xpcs_switch_interface_mode() programs the interface
>        operating mode to use a reserved value rather than the default
> 
> PATCH 03/12
>      - This change has been removed; the default_an_inband platform
>        data flag is set instead (in what was previously patch 10)
>        
> PATCH 04/12
>      - Two issues were pointed out by Sashiko, both of which were
>        problems related to DMA handling.  They were pre-existing
>        issues, and I plan to send separate patches to address
>        them.
>      - A mask local variable (to shorten a long line) is no longer
>        created.  Checkpatch no longer complains about that line.
> 
> PATCH 05/12
>      - The description was clarified a bit in response to a comment
>        from Andrew
> 
> PATCH 06/12
>    - No comments received, no changes
> 
> PATCH 07/12
>    - Sashiko suggested that exporting some symbols from the stmmac
>      core might not be desirable, and suggested using the standard
>      DMA API to accomplish the same thing.  For now we are igoring
>      this suggestion--not finding a way to do what was suggested.
> 
> PATCH 08/12
>    - The description has been revised to focus on the hardware and
>      not the "node".
>    - The ASCII art (copied from below) has been incorporated into the
>      binding
>    - The file name has been changed to "toshiba,tc9564-dwmac.yaml" and
>      the $id value matches the file name
>    - Only one example is provided now
>    - The references and unevaluatedProperties have been moved later
>      in the file
>    - We no longer reference "pci-bus-common.yaml".  We are describing
>      a device, not a bridge.
>    - Subnodes have been added to represent the GPIO controller (on
>      PCIe function 0) and the Ethernet interfaces (possible on PCIe
>      functions 0 and 1).
> 
> PATCH 09/12
>    - The GPIO controller is now implemented using regmap-gpio
>    - The Kconfig entry for the GPIO driver has been updated to select
>      GPIO_REGMAP, and to define its default value as "m" unconditionally
>    - The Kconfig entry is now defined in the memory-mapped GPIO section
>    - The regmap use has been adjusted so it's clear it is MMIO-based,
>      which normally does not require error checking.
>    - We no longer call drv_get_drvdata()
> 
> PATCH 10/12
>    - The name of the IRQ domain now includes the MAC ID (0 or 1)
>    - SP_SEL_SGMII_2500M is now named SP_SEL_2500BASEX
>    - A typo in the commit has been fixed, and the error check after creating
>      the RX IRQ mapping now checks the right pointer for an error
>    - The Kconfig entry now selects GENERIC_IRQ_CHIP
>    - The PHY interface is now taken into account in the fix_max_speed
>      callback
>    - We now check the correct pointer for an error when creating the RX
>      IRQ mappings
>    - We are not implementing a shutdown driver callback
>    - Xilin has other discussion related to WoL, which we should save
>      and use, but we're not acting on it now.
>    - In four function, Sashiko noted that a 32-bit dma_addr_t can't hold
>      TC956X_SLV00_SRC_ADDR, so the type of local variable has been changed
>      to be u64: tc956x_dma_init_rx_chan(), tc956x_dma_init_tx_chan(),
>      tc956x_desc_set_addr(), and tc956x_desc_set_sec_addr().
>    - tc956x_mac_disable() is now called if stmmac_dvr_probe() fails;
>      suggested by Sashiko.
>    - Sashiko noted the MDIO device tree node was being leaked.  This
>      has been resolved.
>    - Sashiko also pointed out that IRQ mappings were not being freed,
>      and this too is fixed.
> 
> PATCH 11/12
>    - The reset and clock functions are no longer defined inline
>    - The REFCLK clock name has been renamed REFCLKO, and a comment
>      has been added to explain it is an (unused) output clock.
>    - If the PCI device has no DT node it is reported with dev_err().
>    - <linux/bitfield.h> is now included, to avoid errors in various
>      non-Arm64 builds.
>    - The devicetree Ethernet node is no longer leaked in adev_device_add()
>      (noticed by Sashiko).
>    - The Kconfig entry now depends on ARM64 or COMPILE_TEST
>    - The Kconfig entry now selects REGMAP and REGMAP_MMIO
>    - Sashiko reported that the reference count on the PCIe slot
>      for function 0 was being leaked.  This has been fixed.
>    - Sashiko questioned whether the cleanup action to delete
>      a created device link was associated with the wrong device.
>      It was, and this has been fixed.
>    - Sashiko also suggested that the allocated PCI IRQ vector
>      was not properly getting removed.  It now is.
>    - Sashiko suggested that function 1 might proceed with probing
>      even though there was still a chance that function 0's probe
>      failed.  The platform_data pointer that function 1 uses to
>      decide it's OK to probe is now assigned later.
> 
> PATCH 12/12
>    - The PHY interrupt is now defined as a level interrupt.
>    - A typo in the PHY name has been corrected in the patch description
> 
> Here is the initial version of the series.
>    https://lore.kernel.org/netdev/20260501155421.3329862-1-elder@riscstar.com/
> 
> Alex Elder (3):
>    net: stmmac: dma: create a separate dma_device pointer
>    misc: tc956x_pci: add TC956x/QPS615 support
>    gpio: tc956x: add TC956x/QPS615 support
> 
> Daniel Thompson (11):
>    dt-bindings: net: qca,qca808x: Add regulator properties
>    net: phy: qcom: qca808x: Add regulator management
>    net: pcs: pcs-xpcs-regmap: support XPCS memory-mapped MDIO bus via
>      regmap
>    net: pcs: xpcs: re-order xpcs_pre_config() to update after the reset
>    net: pcs: pcs-xpcs: select operating mode for 10G-baseR capable PCS
>    net: stmmac: dwxgmac2: Add multi MSI interrupt mode
>    net: stmmac: dwxgmac2: Add XGMAC 3.01a support
>    net: stmmac: dwxgmac2: export symbols for XGMAC 3.01a DMA
>    dt-bindings: net: toshiba,tc9654-dwmac: add TC9564 Ethernet bridge
>    net: stmmac: tc956x: add TC956x/QPS615 support
>    arm64: dts: qcom: qcs6490-rb3gen2: enable TC9564 with a single QCA8081
>      phy
> 
>   .../devicetree/bindings/net/qca,qca808x.yaml  |  14 +
>   .../bindings/net/toshiba,tc9564-dwmac.yaml    | 120 +++
>   MAINTAINERS                                   |  12 +
>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  |  48 +
>   drivers/gpio/Kconfig                          |  12 +
>   drivers/gpio/Makefile                         |   1 +
>   drivers/gpio/gpio-tc956x.c                    | 130 +++
>   drivers/misc/Kconfig                          |  12 +
>   drivers/misc/Makefile                         |   1 +
>   drivers/misc/tc956x_pci.c                     | 741 ++++++++++++++++
>   drivers/net/ethernet/stmicro/stmmac/Kconfig   |  14 +
>   drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +
>   .../net/ethernet/stmicro/stmmac/chain_mode.c  |  12 +-
>   .../ethernet/stmicro/stmmac/dwmac-tc956x.c    | 818 ++++++++++++++++++
>   .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  12 +
>   .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |   1 +
>   .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |   1 +
>   .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  79 +-
>   .../net/ethernet/stmicro/stmmac/ring_mode.c   |  12 +-
>   drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   1 +
>   .../net/ethernet/stmicro/stmmac/stmmac_main.c |  58 +-
>   .../net/ethernet/stmicro/stmmac/stmmac_xdp.c  |   2 +-
>   drivers/net/pcs/Makefile                      |   4 +-
>   drivers/net/pcs/pcs-xpcs-regmap.c             | 219 +++++
>   drivers/net/pcs/pcs-xpcs.c                    |  93 +-
>   drivers/net/phy/qcom/qca808x.c                |  30 +
>   include/linux/pcs/pcs-xpcs-regmap.h           |  20 +
>   include/linux/stmmac.h                        |   1 +
>   include/soc/toshiba/tc956x-dwmac.h            |  84 ++
>   29 files changed, 2478 insertions(+), 76 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml
>   create mode 100644 drivers/gpio/gpio-tc956x.c
>   create mode 100644 drivers/misc/tc956x_pci.c
>   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
>   create mode 100644 drivers/net/pcs/pcs-xpcs-regmap.c
>   create mode 100644 include/linux/pcs/pcs-xpcs-regmap.h
>   create mode 100644 include/soc/toshiba/tc956x-dwmac.h
> 
> base-commit: 07c4bca9d92e51ab6b46797a86c6ea559812351a

