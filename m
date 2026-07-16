Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10569382291
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219066; cv=none; b=E1OgPr6yAomLorgCUqNSK84ES3GAGRw7f3DHMXtLL+enCsUV9+qoBrXxyiKjDMmpsdNgtfAKR6j+8wGphqz6oea4oIz2ehxYyhbnXuxWIXi03YMCnYEsH9iA+xU1MRUTLIDqfxo/fc7jES17HQd0Lch6IO405udok8TThc5CYVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219066; c=relaxed/simple;
	bh=UpDAhW2ValPQeX/cu4q1GgaspWqJM2TSkYVG7a8nayE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjnszhsQ3qUO8cOE/houMr8R6PTuwG6752ROauL6fP097wjREDZ7k2jJDzVPc5DFfvWqsVVFGCCQ6bEyxWXaJjSdDLbWTqXG7GI25ac4jz6OHV7H62xhSAAJBXOcg0oLrHk56mxA5cLDCcl6nc51AFA6WU5CuZrSsYVCxAuovyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Z+saZih2; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Z+saZih2"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e602d2c0fso33100285a.0
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 09:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1784219059; x=1784823859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g6rfA8E/nTTUH3FZ9wbpw5nWZ5aMILnFKMF2quaGc0c=;
        b=Z+saZih2SDdCpVcmSsvqOOJna3PAFrFV/Iv4r7GOD/UwfDPa6eeybkFDIMaTxO5DvZ
         3gTTNfVWhtv8j5sOw6O94PX75kYqPkuqrr10iXI1V20Jit+s3jE5rxXIUqT4H9AFCyYO
         cA1pyaIWaCumo3lKQMleWtiITYhRbYBj+QHXrjuiCzlJhJlhshCBgkO648318qgOzFeI
         LPezl5Y50wEssMayPQVvDokEr94wBDme12SC69taDrJmdxuwFdRF2OwY1pgoq8wIzRd1
         yAYYckUofn6hRdtiQq80vLYfdrPu7jPTY9bb3Vdnr1mqssrVQFIYdt6FGBJT8YPxJ/p9
         0Vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784219059; x=1784823859;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g6rfA8E/nTTUH3FZ9wbpw5nWZ5aMILnFKMF2quaGc0c=;
        b=J8krnXn8zFxwk+8VPdi9E8r4XVPjm+cBhRQNNZKGbo8W9qcp8627brsU24vSXQ5Jse
         0EKFtLjyAiFlltoDvUOJFk6VDXAxqQLsnv/KhK9WWcfbsUfboeXE9JQmFZ+EQU6Ogvmh
         grQ3+lzFuXZeNucE3U6IZHFIm+fG54DkPduz0YG4jGRtZvztUWXH/QrPKdPy/aMEzd16
         19qECo9O7jxPjqmWngELAX76YKZlYka5dRZVJwhA8bfzaTCsNPNf4x3PSxWz/ROF+CBp
         A4JZjGDGdt1KFthfakRRl52NCQDH8rcKBsZnyPc0pll63CdJG3VmIQmtRHVtIRJ8zVmR
         nVQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7ye+ALI7sPdUPofac4nu9WHNbpJsC1PdJ21KiGu5BLx8UdojBybDuSk9DuRRMw+59nrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRvcGpxBfUuNn1D9WIRFNTey7Sy1YaicqBw+LowZ/aPCyrqYgo
	OU5YLgNlQIgLjkIBW1dCa+CxTSXLLBCMCTJPoT4W7SF0Jp6BTwHyOrw3XdY/SAl/eu0=
X-Gm-Gg: AfdE7cn+bj26ch6JJu0nfG6y/34N++38sDlLp7gO4gnb2PAmChyU8D1hQzba6zOL7B/
	VQ8OiqWa6OHz/MdKuox3J92VPnxMbsDzAThjMRHmAEViQqnspO7/8bAie1oQWxV9fHASM3qY3tW
	UuXVTWPRiwawgY3ICdfFYslONHg84HlhH4dnDLusfN2+jcU3TsdFpbdAljR1rmWjv3WTY/Fu8Q9
	lP3vTcUTSVLdkICG4T5+am3UbPiV072xiVBvzettH0rnvit4b/i4VnG4uq5GlxU+ztD1cTNp2Hk
	fc+jHZ+PH3b/hRhG04Em0e1nuC15UbLi16NMSOERuE9ZuXxznqelvxvE3CzXwD3mLpJUWtaz7yR
	Oh60/Z9t6qAhFgO7kTSFX44knpzdLuvzrXeU+2n7XWZr5BdxXmmKIon+tvp0NAeFAbrIB2gZF5h
	MhNg==
X-Received: by 2002:a05:620a:31a6:b0:918:4374:bbb with SMTP id af79cd13be357-930a5ff44c2mr318207985a.23.1784219059017;
        Thu, 16 Jul 2026 09:24:19 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf9d9bsm2045063385a.28.2026.07.16.09.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 09:24:18 -0700 (PDT)
Message-ID: <df217d83-272a-4d4c-8aba-a87e4b8869fc@riscstar.com>
Date: Thu, 16 Jul 2026 11:24:15 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 12/14] gpio: tc956x: add TC956x/QPS615 support
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org,
 brgl@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 daniel@riscstar.com, mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
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
 <20260605010022.968612-13-elder@riscstar.com>
 <dhnylud7o5dhaaq6kvbes4vkml3ppa5ev542j2lyxdijibknzg@pfcy22wz6jav>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <dhnylud7o5dhaaq6kvbes4vkml3ppa5ev542j2lyxdijibknzg@pfcy22wz6jav>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/26 2:02 AM, Manivannan Sadhasivam wrote:
> On Thu, Jun 04, 2026 at 08:00:19PM -0500, Alex Elder wrote:
>> Toshiba TC956x is an Ethernet-AVB/TSN bridge and is essentially
>> a small and highly-specialized SoC.  TC956x includes a GPIO block that
>> can be accessed, alongside several other peripherals, via two PCIe
>> endpoint functions.  The PCIe function driver creates an auxiliary
>> device for the GPIO block, and that device gets bound to this auxiliary
>> device driver.
>>
>> This driver is implemented using the generic regmap-based GPIO driver.
>>
> 
> While the regmap over the switch BAR works for GPIO access post-enumeration,
> there is a blocker in using these GPIOs to control the power to endpoints.

We're aware of the power control driver and its use of these GPIOs.

I think the point you're making is not about the specific way we
are using GPIOs, but that someone could try to use this GPIO
controller in a way that would lead to a circular dependency
(between the controller and the PCIe device it depends on).

And you suggest a GPIO driver that uses I2C (and would be
used by the pwrctrl driver as well), and I think it's a pretty
reasonable suggestion.

> We have a design [1] where the GPIOs from the switch are used to control power
> and PERST# signals to the EP. With this current design, during the initial PCI
> bus scan, the switch will get enumerated, but the EP will not. Because, power to
> the EP depends on the GPIO Aux driver that will get probed only after the switch
> enumeration.

Yes, on the RB3gen2 platform, reset signals (PERST#) for two of
the TC9563 PCIe switch ports (downstream 1 and downstream 2) are
managed by the GPIO controller that resides within the TC9563
itself.  The pwrctl driver takes special care to ensure the GPIO
controller is functional (powered) before trying to use it.

The TC9563 *chip* gets powered when its embedded PCIe switch is
probed--that is, when its upstream port begins its enumeration.
(It's a little unclear to me which of the supplies are required
for the various non-PCIe components on the chip, including I2C
and GPIO, to be functional.)

And so until the switch gets probed (and its pwrctl driver used),
the GPIO controller can't work.  So nothing internal to the TC956x 
should be dependent on any of the GPIOs supplied by this controller.
(Except the pwrctrl driver, which enables power before using GPIO.)


Two things to note:
- We are working with TC9564 (and there are other successors in
   the TC956x series).
- Downstream port 3 (which we are using) on the switch does not
   have such a distinct controlled reset line.

> But this creates a chicken-and-egg problem with the PCI Pwrctrl design.
> pcie-qcom driver uses the Pwrctrl framework to power on the PCI endpoints before
> the initial PCI bus scan. It calls pci_pwrctrl_create_devices() and
> pci_pwrctrl_power_on_devices() APIs to create the platform device for all PCI
> devices defined in DT (that require pwrctrl support), waits for their respective
> pwrctrl drivers to get probed and then power ON all of them.

The way I understood it was that certain parameters for the PCIe
links needed to be set before using them, and the pwrctrl framework
made that possible.  (I summarize what that driver does at the end
of this message.)

  This step is
> required because in DT platforms, many Root Ports are not hotplug capable and
> also BIOS doesn't assign bridge windows during boot. So all the devices has to
> appear during the initial PCI bus scan so that the PCI core can allocate the
> resources properly.

This part I didn't know before.  Yes, the bridge windows are
allocated by Linux rather than by firmware.  And if this host
bridge doesn't support hotplug, then yes, to correctly assign
address space, all PCIe devices must be available to report
their required memory space.

Are you saying that "setting those parameters" wouldn't be
needed if this particular root port supported hotplug?  (I'm
just curious; it's not relevant to the point you're making.)

> Now the issue with this Aux driver design is that, if an EP makes use of the
> switch GPIO for PERST# or power, like:
> 
> 	tc9563: pcie@0,0 {
> 		compatible = "pci1179,0623";
> 		reg = <0x10000 0x0 0x0 0x0 0x0>;
> 		...
> 
> 		pcie@1,0 {
> 			compatible = "pciclass,0604";
> 			reg = <0x20800 0x0 0x0 0x0 0x0>;
> 			#address-cells = <3>;
> 			#size-cells = <2>;
> 
> 			device_type = "pci";
> 			ranges;
> 			bus-range = <0x3 0xff>;
> 
> 			reset-gpios = <&tc9563 5 GPIO_ACTIVE_LOW>;
> 		};
> 	...
> 
> 	};
> 
> Then the pwrctrl driver (pci/pwrctrl/generic.c) will try to acquire the GPIO
> controller during its probe, but will fail with -EPROBE_DEFER as the GPIO
> controller won't be available at that time. So the whole PCIe instance will
> probe defer as the driver requires all pwrctrl drivers to be probed before
> starting the initial bus scan.

The only GPIOs we're using are for asserting reset on the two
Ethernet PHYs.  That doesn't occur until after the embedded
endpoint functions are probed, so this should be OK.

However you're right, the lines on this GPIO controller should
be restricted to avoid this circular dependency.
> So we need to make sure that the GPIO controller driver is available before
> enumerating the switch device. One way to achieve is by creating the GPIO Aux
> device in the pci/pwrctrl/pci-pwrctrl-tc9563.c driver and let the GPIO
> controller driver use I2C communication for setting up the GPIOs. Thankfully,
> the switch allows both I2C and BAR MMIO configurations for internal GPIOs.

Daniel and I have talked about this solution exactly, but opted
not to propose using it just yet (not unless someone like you
suggested it...).  Our solution for now was just to have the
(PCIe BAR-based) GPIO driver reserve the two GPIO lines used by
the pwrctrl driver, and rely on the fact that the pwrctrl driver
will only touch those shared registers at times the "real" GPIO
driver does not.


We could instead implement a "proper" I2C-based GPIO controller
driver.  This would be used by the pwrctrl driver (rather than
that driver just updating the registers directly), as well as
the Ethernet PHY for reset control, and for any other uses on
future platforms.

All uses so far are for managing resets, so the higher I2C
latency wouldn't be much of an issue.

> With this change, the GPIO driver will get probed by the time the pwrctrl
> generic driver acquires the 'reset-gpios' and will turn ON the EP.

One thing I'll point out is that the next version of this
code will define "pci-ep-bus" nodes, and will not use the
auxiliary bus model.  However the issue you raise remains
in that model too.

Thank you very much for raising this Mani.  Please see my
questions a little further below.

					-Alex

> Let me know your thoughts!
> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/e2inl7k5gsjj6oomv2k5ximuzpb3gfiz66ufet3b4hvov7zqt4@qz4pifbos7yf/


Here's what the pwrctrl driver does:

In drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c, the registers at
offset 0x1208 and 0x1210 from the base of the "SFR" address space
are updated to assert/deassert these two reset signals.  It does
so using the I2C interface--out of band from access via PCI BARs.
The reset signals are GPIO02 (for downstream endpoint 1 on the
switch) and GPIO03 (for endpoint 2), which are controlled by
bits 2 and 3 in the two registers, respectively.

The pwrctrl driver enables a set of regulators defined in the
devicetree node for the upstream port of the TC9564 embedded
PCIe switch.  It then asserts the main RESX (chip) reset signal,
and after a short delay asserts these other two resets.

At that point it uses properties defined in devicetree to
configure five "ports":  upstream, downstream 1-3, and Ethernet.
(I have some questions related to this--but I put them below.)
The properties configured are:  ASPM L0s entry delay; ASP L1 entry
delay; TX amplitude; Number of Fast Training Sequences (NTFS); and 
Decision Feedback Equalization (DFE).

Finally, the two resets and the main RESX reset are deasserted,
and the driver reports that the device is now ready, with:
   devm_pci_pwrctrl_device_set_ready();



Questions related to the "ports" configured by the pwrctrl driver:
- Given that downstream port 3 connects to the internal, embedded
   PCIe endpoint, does it still require these settings programmed?

- Does the TC9563 chip have only *one* function on its embedded
   endpoint, supporting just one Ethernet?
     - If so, this driver will have to be modified to support
       the second embedded function and Ethernet controller.

- Why is "Ethernet" configured like the PCIe ports, *in addition*
   to the downstream port 3 that it sits behind?


>> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   MAINTAINERS                |   1 +
>>   drivers/gpio/Kconfig       |  12 ++++
>>   drivers/gpio/Makefile      |   1 +
>>   drivers/gpio/gpio-tc956x.c | 130 +++++++++++++++++++++++++++++++++++++
>>   4 files changed, 144 insertions(+)
>>   create mode 100644 drivers/gpio/gpio-tc956x.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0924f7ec43cb0..0439607d1155f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -27057,6 +27057,7 @@ M:	Alex Elder <elder@kernel.org>
>>   M:	Daniel Thompson <danielt@kernel.org>
>>   S:	Maintained
>>   F:	Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
>> +F:	drivers/gpio/gpio-tc956x.c
>>   F:	drivers/misc/tc956x_pci.c
>>   
>>   TOSHIBA WMI HOTKEYS DRIVER
>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> index 020e51e30317a..36631ca722fa3 100644
>> --- a/drivers/gpio/Kconfig
>> +++ b/drivers/gpio/Kconfig
>> @@ -743,6 +743,18 @@ config GPIO_TB10X
>>   	select GPIO_GENERIC
>>   	select GENERIC_IRQ_CHIP
>>   
>> +config GPIO_TC956X
>> +	tristate "Toshiba TC956X GPIO support"
>> +	depends on TOSHIBA_TC956X_PCI
>> +	select GPIO_REGMAP
>> +	default m
>> +	help
>> +	  This enables support for the GPIO controller embedded in the Toshiba
>> +	  TC956X (and Qualcomm QPS615).  This device connects to the host
>> +	  via PCIe port, which is the upstream port on an internal PCIe
>> +	  switch.  On some platforms, a few of the GPIO lines are used to
>> +	  manage external resets.
>> +
>>   config GPIO_TEGRA
>>   	tristate "NVIDIA Tegra GPIO support"
>>   	default ARCH_TEGRA
>> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
>> index b267598b517de..c3584e7cba9b4 100644
>> --- a/drivers/gpio/Makefile
>> +++ b/drivers/gpio/Makefile
>> @@ -178,6 +178,7 @@ obj-$(CONFIG_GPIO_SYSCON)		+= gpio-syscon.o
>>   obj-$(CONFIG_GPIO_TANGIER)		+= gpio-tangier.o
>>   obj-$(CONFIG_GPIO_TB10X)		+= gpio-tb10x.o
>>   obj-$(CONFIG_GPIO_TC3589X)		+= gpio-tc3589x.o
>> +obj-$(CONFIG_GPIO_TC956X)		+= gpio-tc956x.o
>>   obj-$(CONFIG_GPIO_TEGRA186)		+= gpio-tegra186.o
>>   obj-$(CONFIG_GPIO_TEGRA)		+= gpio-tegra.o
>>   obj-$(CONFIG_GPIO_THUNDERX)		+= gpio-thunderx.o
>> diff --git a/drivers/gpio/gpio-tc956x.c b/drivers/gpio/gpio-tc956x.c
>> new file mode 100644
>> index 0000000000000..0dc6b1028d970
>> --- /dev/null
>> +++ b/drivers/gpio/gpio-tc956x.c
>> @@ -0,0 +1,130 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/*
>> + * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
>> + */
>> +
>> +/*
>> + * The Toshiba TC956X implements a PCIe Gen 3 switch that connects an
>> + * upstream x4 port to two downstream PCIe x2 ports.  It incorporates
>> + * an internal endpoint on a internal PCIe port that implements two
>> + * Synopsys XGMAC Ethernet interfaces.
>> + *
>> + * 35 GPIOs are also implemented by an embedded GPIO controller.  Three
>> + * registers control the first 32 GPIOs (other than 20 and 21, which are
>> + * reserved).  Three other registers control GPIOs 32 through 36. GPIOs
>> + * 22-24, 27-28, 31, and 34 are treated as "input only".
>> + *
>> + * There is a TC956X PCI power controller driver that accesses the
>> + * direction and output value registers for GPIOs 2 and 3.  These
>> + * GPIOs control the reset signal for the two downstream PCIe ports.
>> + * Their values will never change during operation of this driver, and
>> + * this driver reserves these two GPIOS.
>> + */
>> +
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/gpio/driver.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include <linux/gpio/regmap.h>
>> +
>> +#define DRIVER_NAME		"tc956x-gpio"
>> +
>> +#define TC956X_GPIO_COUNT	37	/* Number of GPIOs (20-21 reserved) */
>> +
>> +/* The GPIO offsets are relative to 0x1200 in TC956X SFR space. */
>> +#define GPIO_IN0_OFFSET		0x00		/* Input value (0-31) */
>> +#define GPIO_EN0_OFFSET		0x08		/* 0: out; 1: in (0-31) */
>> +#define GPIO_OUT0_OFFSET	0x10		/* Output value (0-31) */
>> +
>> +/*
>> + * There are two sets of registers, each representing (up to) 32 GPIOs with a
>> + * stride of 4 bytes (IN1 is 4 bytes past IN0, EN1 is 4 bytes past EN0, etc.).
>> + */
>> +#define GPIO_PER_REG		32
>> +#define GPIO_REG_STRIDE		4
>> +
>> +static int tc956x_gpio_init_valid_mask(struct gpio_chip *gc,
>> +				       unsigned long *valid_mask,
>> +				       unsigned int ngpios)
>> +{
>> +	/*
>> +	 * GPIOs 2 and 3 are used by the PCI power control driver, and
>> +	 * we don't allow them to be used.  GPIOs 20 and 21 are reserved
>> +	 * (and not usable).
>> +	 */
>> +	bitmap_fill(valid_mask, ngpios);
>> +	bitmap_clear(valid_mask, 2, 2);
>> +	bitmap_clear(valid_mask, 20, 2);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tc956x_gpio_probe(struct auxiliary_device *adev,
>> +			     const struct auxiliary_device_id *id)
>> +{
>> +	DECLARE_BITMAP(zeroes, TC956X_GPIO_COUNT);
>> +	DECLARE_BITMAP(fixed, TC956X_GPIO_COUNT);
>> +	struct gpio_regmap_config config = { };
>> +	struct gpio_regmap *gpio_regmap;
>> +	struct device *dev = &adev->dev;
>> +
>> +	/* We need the regmap pointer, stored in our platform data */
>> +	if (!dev->platform_data)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Only some of our GPIOs are fixed direction:
>> +	 *	22, 23, 24, 27, 28, 31, and 34	(all input-only)
>> +	 * Set up the fixed bitmap to indicate which are fixed.
>> +	 */
>> +	bitmap_zero(fixed, TC956X_GPIO_COUNT);
>> +	bitmap_set(fixed, 22, 3);
>> +	bitmap_set(fixed, 27, 2);
>> +	set_bit(31, fixed);
>> +	set_bit(34, fixed);
>> +
>> +	/* All fixed GPIOs are input; the zeroes bitmap indicates that. */
>> +	bitmap_zero(zeroes, TC956X_GPIO_COUNT);
>> +
>> +	config.parent = dev;
>> +	config.regmap = dev->platform_data;
>> +	config.label = DRIVER_NAME;
>> +	config.ngpio = TC956X_GPIO_COUNT;
>> +	config.reg_dat_base = GPIO_REGMAP_ADDR(GPIO_IN0_OFFSET);
>> +	config.reg_set_base = GPIO_REGMAP_ADDR(GPIO_OUT0_OFFSET);
>> +	config.reg_dir_in_base = GPIO_REGMAP_ADDR(GPIO_EN0_OFFSET);
>> +	config.reg_stride = GPIO_REG_STRIDE;
>> +	config.ngpio_per_reg = GPIO_PER_REG;
>> +	config.init_valid_mask = tc956x_gpio_init_valid_mask;
>> +	config.fixed_direction_mask = fixed;
>> +	config.fixed_direction_output = zeroes;
>> +
>> +	gpio_regmap = devm_gpio_regmap_register(dev, &config);
>> +	if (IS_ERR(gpio_regmap))
>> +		return PTR_ERR(gpio_regmap);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct auxiliary_device_id tc956x_gpio_ids[] = {
>> +	{ .name = "tc956x_pci.tc9564-gpio", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(auxiliary, tc956x_gpio_ids);
>> +
>> +static struct auxiliary_driver tc956x_gpio_driver = {
>> +	.name		= DRIVER_NAME,
>> +	.probe          = tc956x_gpio_probe,
>> +	.id_table       = tc956x_gpio_ids,
>> +	.driver = {
>> +		.name		= DRIVER_NAME,
>> +		.owner		= THIS_MODULE,
>> +		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
>> +	},
>> +};
>> +module_auxiliary_driver(tc956x_gpio_driver);
>> +
>> +MODULE_DESCRIPTION("Toshiba TC956X PCIe GPIO Driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("auxiliary:" DRIVER_NAME);
>> -- 
>> 2.51.0
>>
> 

