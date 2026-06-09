Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8263B3E1208
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040721; cv=none; b=UIEBs16g/rVQdTg6nsZ/pjud2g6GZOrQ9ryug+YxmxleY27yWX/Axy2hpPtgeFHZHBMaVqEBU1MyJBC5fi+jskyiutnSnmBnYva/GW55AGxjbr1bZpzm9J2x9Z1VcbPsV98geUGb2bEMUQRw6FNVX1FTUx2U4gptkHSsL674CQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040721; c=relaxed/simple;
	bh=WAiXRaxAM4Z1bZ828ygiu2QGKA8btwndyvH6LWkBmvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czPk+CdNR4anBA4LVlx8XozmYEw2VDxaLWxM/OQgAGkwmpjSbPmhQhXZdv1MEXQZTkuKvw+D65YhWjTAmoIvs2g3PZieuZvnxIabX6G+cHhePeDHbAuipzMRXlbONxbniZmcxJ4SoKJYIMVZ/W09JaJxzIGXPrc4cE6zb9y2OO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=uoS8Wc2e; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="uoS8Wc2e"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-486503ae8f0so4496833b6e.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 14:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1781040718; x=1781645518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQKbERiB0ntPOS/R2wMXRwGJAn2HHwIq3s8Tu7uVMO4=;
        b=uoS8Wc2e1VeGoY7G1XUBEHm43nmS5gaWrdYwUmiNUbR6nAUt8w6us5wXqa8zvD0j8H
         pElFvyvcXDwQRbA7XsXg25ZJRHvM8K6goHxTNObZ69eH7g4DY9o3ebLH0iTTxx0j3y5M
         VKauDGWMkjgBFheiP8YjscG+JfsiNeZJp9RizPBwnWb2BY01EYdCMVKjHh58PXuq6py0
         aKLhGhGkk7vUvFMeaqQ3OwEj7d8vo+rsKGKph1+Ix/B9kDz3fL8ZlaUpliFLu5oek+3b
         oYjsUvyheB3NSko8ugKmu0mQq0yhwZCWmxtPvlx7+eF5c3u1n/XFljjOak4mPeOyK6q4
         D2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781040718; x=1781645518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQKbERiB0ntPOS/R2wMXRwGJAn2HHwIq3s8Tu7uVMO4=;
        b=C2qAY72xIWwVGmJsw7cz+8irtwFfbbxtctxK7aJqWC3LXHgYkcWmpsSvcbsREaUdAU
         m74unVSok2yvHy2iUVQ+SdEZShBcOmZx8WXCUCiNi8p08vcp/ZPM+FB+opJ2mzsqKAwL
         /AQw09JDcIT0db4D+dRWT1mA1H24RLE3pztznpEWRTJEcXYShlH+f0zP1/bI7XSECPwl
         sknI0pU2DUKIk1MvlvEt9fQzYAs5vQZ11nReotdzrmGVyP/GuyHZiC10WujTqO3Gcze5
         GRWPzYgBeZUgPLg4SDjnzo4PW/5B3yKpzLxU2Upj651J1YcLNWVB1j33J7QwAzpBXybr
         ZBDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/F6H8x/8KU8RU3s84vqzdolJlATT1LwBRL2UrpetUp7FHlhVRXWDMtd+kYbpzsmY3PxiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsM3yn+JNsKpkzAwxqa7SVImnwzD8d8elYruRrtaFueX3Ech+f
	kqPmNZkBfZfnfOIGzlta3uMs20NXMI0bebMBsNBjsmlK47xAMEsCo4qI+vjeX91I0hY=
X-Gm-Gg: Acq92OEwG4FFt6pUkDQPCQIoiVdtuzK+5wG6VbZCxMPsxS3R8jM5CMUUkHl9M2V8rnu
	hcuZCWVz+dx4UxD6YlOH4KS5VtAlKUohLaTzr6xBU20qaUl5GLyPwzGr1hbt24HY1oHs9+DQmxh
	S68qCuDZ+WSeCD7CS0sqwZNhmQORK0S4m9N0l+hvkv9ISBGMeXfL0bVyUwZ6QoNm9ji+Gs1eCPF
	jSSYKlPVtki8kZV4Tj+auwqfexK0lIQFLqcoOfbJAVdRqYt+kMwCh1n3xMUMqvbq0mBAej1tRf0
	mq6W/VdMKZuSTHvQYpklHXVDDBcnYkAkYSZivUlRkfZAl7UjAFi5a2dIBeLaehyrCNYG4MOo87p
	UTxmVhc0IuqwgNf9S0irDR9uLGr2g5ueOfRw1TVa6CpqT2tCWp+AnZPcnMzMe2wme3wZZVUn4ri
	Xia0/El5iG2lt+g7EpsF9dqgRsQaA7GnXzcPIaLQV2qRZb
X-Received: by 2002:a05:6808:4fe2:b0:485:a9b2:5457 with SMTP id 5614622812f47-4868df63ae3mr15052790b6e.35.1781040718541;
        Tue, 09 Jun 2026 14:31:58 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b5a5a64sm17024127b6e.4.2026.06.09.14.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 14:31:58 -0700 (PDT)
Message-ID: <b89fe088-496f-4281-9d27-7f8b0b3f38cb@riscstar.com>
Date: Tue, 9 Jun 2026 16:31:55 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 13/14] net: stmmac: tc956x: add TC956x/QPS615
 support
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org,
 Daniel Thompson <daniel@riscstar.com>, mohd.anwar@oss.qualcomm.com,
 a0987203069@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 boon.khai.ng@altera.com, chenchuangyu@xiaomi.com, chenhuacai@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, hkallweit1@gmail.com,
 inochiama@gmail.com, john.fastabend@gmail.com, julianbraha@gmail.com,
 livelycarpet87@gmail.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260605010022.968612-1-elder@riscstar.com>
 <20260605010022.968612-14-elder@riscstar.com>
 <20260605144758.GB3659201-robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260605144758.GB3659201-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/26 9:47 AM, Rob Herring wrote:
> On Thu, Jun 04, 2026 at 08:00:20PM -0500, Alex Elder wrote:
>> From: Daniel Thompson <daniel@riscstar.com>
>>
>> Toshiba TC956x is an Ethernet AVB/TSN bridge and is essentially a
>> small and highly-specialized SoC. TC956x includes an "eMAC" subsystem
>> that can be accessed, along with several other peripherals, via two
>> PCIe endpoint functions. There is a main driver for the endpoint that
>> decomposes things and creates auxiliary bus devices to model the SoC.
>>
>> The eMAC consists of a Designware XGMAC, XPCS and PMA. Each eMAC is
>> supported by an MSIGEN that bridges TC956x level interrupts to PCIe
>> MSIs.
>>
>> Add a driver for the eMAC/MSIGEN combination.
>>
>> Co-developed-by: Alex Elder <elder@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> 
> The order is wrong here unless you worked on it and then Daniel took
> over. Tags should be chronological order.

I think this was a dumb reorder I did to address a complaint
from checkpatch, but in any case I'll fix this.  Yes, my
signoff should "wrap" the others.

>> ---
>>   MAINTAINERS                                   |   2 +
>>   drivers/net/ethernet/stmicro/stmmac/Kconfig   |  14 +
>>   drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +
>>   .../ethernet/stmicro/stmmac/dwmac-tc956x.c    | 818 ++++++++++++++++++
>>   4 files changed, 836 insertions(+)
>>   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0439607d1155f..418537cbefbbb 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -27059,6 +27059,8 @@ S:	Maintained
>>   F:	Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
>>   F:	drivers/gpio/gpio-tc956x.c
>>   F:	drivers/misc/tc956x_pci.c
>> +F:	drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
>> +F:	include/soc/toshiba/tc956x-dwmac.h
>>   
>>   TOSHIBA WMI HOTKEYS DRIVER
>>   M:	Azael Avalos <coproscefalo@gmail.com>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> index e3dd5adda5aca..8d247e033e356 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> @@ -404,6 +404,20 @@ config DWMAC_MOTORCOMM
>>   	  This enables glue driver for Motorcomm DWMAC-based PCI Ethernet
>>   	  controllers. Currently only YT6801 is supported.
>>   
>> +config DWMAC_TC956X
>> +	tristate "Toshiba TC956X DWMAC support"
>> +	depends on PCI
>> +	depends on COMMON_CLK
>> +	depends on TOSHIBA_TC956X_PCI
>> +	default TOSHIBA_TC956X_PCI
>> +	select GENERIC_IRQ_CHIP
>> +	help
>> +	  This selects the Toshiba TC956X (and Qualcomm QPS615) support in the
>> +	  stmmac driver.
>> +
>> +	  This provides support for the ethernet controllers found on these
>> +	  devices.
>> +
>>   config STMMAC_PCI
>>   	tristate "STMMAC PCI bus support"
>>   	depends on PCI
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
>> index a1cea2f57252e..e8e7f95dbe3e8 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
>> +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
>> @@ -51,4 +51,6 @@ obj-$(CONFIG_STMMAC_PCI)	+= stmmac-pci.o
>>   obj-$(CONFIG_DWMAC_INTEL)	+= dwmac-intel.o
>>   obj-$(CONFIG_DWMAC_LOONGSON)	+= dwmac-loongson.o
>>   obj-$(CONFIG_DWMAC_MOTORCOMM)	+= dwmac-motorcomm.o
>> +obj-$(CONFIG_TC956X_PCI)	+= tc956x-pci.o
>> +obj-$(CONFIG_DWMAC_TC956X)	+= dwmac-tc956x.o
>>   stmmac-pci-objs:= stmmac_pci.o
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
>> new file mode 100644
>> index 0000000000000..c77585e4a50e6
>> --- /dev/null
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
>> @@ -0,0 +1,818 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/*
>> + * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
>> + *
>> + * Derived from code having the following copyrights:
>> + * Copyright (C) 2011-2012  Vayavya Labs Pvt Ltd
>> + * Copyright (C) 2025 Toshiba Electronic Devices & Storage Corporation
>> + */
>> +
>> +#include <linux/auxiliary_bus.h>
> 
> Based on the block diagram, these are PCI devices. Auxiliary bus is the
> wrong thing to use here.

As I said in the other message, I'm going to rearrange this
to use pci-ep-bus and platform drivers.  Most of the core
code should be stay the same but the overall structure will
change.

Thanks for your suggestions.

					-Alex

> 
> Rob

