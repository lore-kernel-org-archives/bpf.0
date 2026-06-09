Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BCF2D7DC6
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040715; cv=none; b=oO4QfuP4qY86tqmP1jhlCsi59jvzsyo+kRcM028M0AgYH1tjrJL40OYjhNfQoEPXrS/7UBG/NN0SiwxJyDxp3IaCCHRU8x5QWYjo7sgx7v1lymeU/DBumJOoVzIbVb4XVgXTA9/0Ew/XKOmJQm3ChfU/RSoN2GyUuKQMpc10fR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040715; c=relaxed/simple;
	bh=u02KRuZlQFzGkv6nJNfx75RixQFD4xM54PRC9sX+TeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzQW8jsZXIggs/LmRbWdRyUiXwC98uZ5DPpTqLxUEw7Qix8wLPtP/ugDKNqYv6DnkdSqsGS6YFXbvI0iRcfv55Bk7C+l4YPyQ8FiyYRxfbdvAM/RouI4/m5IHHR0Tr/7unIfWN4oV0fT+QTWeQNB8RdhirEEJj2w9Qn8LfAccy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=mfqFmqt+; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="mfqFmqt+"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-486badc02ecso1497074b6e.3
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 14:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1781040712; x=1781645512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aGjz6oXrvv0vYyL9h564g5u9rOXsQ9Yj+tb2sJWaYA0=;
        b=mfqFmqt+WJx8NSYfElhOBMTg++c3r8Yq+qOtPE6j+Rp39nGafXgFVejdw+XX6c1G8Y
         WtGm1CHAjgdwVPbNMbusNhxrPEgqJ8ftBfI1CDBJrDXH58mf1cQs3T3t56ngL+brvLLL
         mDkoPrurq+wWZP9/d3whgV2TL2M9jI29yrLoMadcZACt5Jkj7gMG0WC2DmIrIOQ1lWJ4
         C84XQsZVeKsgRr9YkfYO+eZ6f41JO+z9W/2xJUO0ziqf9pp4rDolAUM9CN+pWjUre6Ew
         KJLk2jUKoV5kpdOXgZjpUwWgg+0QmjaoZ/mmlgLndXknfUAZwyoJGFNJ8tQSbUdtBZ4z
         v8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781040712; x=1781645512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGjz6oXrvv0vYyL9h564g5u9rOXsQ9Yj+tb2sJWaYA0=;
        b=RYgssHh56j3FTgVLcio8ZVQqdPgB8TenvzB26tAOKLwL9Z5+GBovZgdeBIQawVe/WA
         b9Pva2KyVvlqKt/UlsnU1HRPzQvNRCVHaCGQnHI9DgS+IwURcLf63bIaK340Fo9aokQU
         aGHtZUr3+xZ1qniyWWYq83JDmu/UwmDMw6ZgBP1DfM/iwdeOpHiEPTJocN76d2nxpV1Z
         Kth6F1BjbCck60Pffk9Bwe/6PUXUug7RBMBXDvcR4eWZmlAbn1hvWk0Uc9/DAZKSt8Jt
         QHkX33iNo4hhBvfUcjl5i8l/YrXGIuigHV4LJUXvFI4ySbdAimhWjl3RKkEGX6QMY5z4
         1Z6A==
X-Forwarded-Encrypted: i=1; AFNElJ+upVRUKHMJ2bzS9zSQAerh/d8Ug7Z8d91vWC6z2ATVJ7dg2qhIvNdJ0mgfrtZMV7wXKFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaEbDrjFNwjyGT179fW+WFlb0ZFeSCysxAutEVQx2PvUpMM/0X
	2OCvKPVCcD+Vt6B4WSdl39kTM4DkmbIyaUumRWycN5Mg3W19tsgxo/JR0kZJSVCSVy2Skqv4xQn
	D1NUFiAI=
X-Gm-Gg: Acq92OEUrq82dSGLVn3itlHT47TjDc1xabMBi+W0Vc95YA7gTNnfZXVV2cKg8eOqRM4
	3qzQqztsj6FMz8TThT46fTV6EvqXwudCq6dThIygsZ66k11TBYpg9mJ8Q/mIY9zWK8u9yUJRC8c
	sch393d8B4V/Yy5uSv3jzBL9GmOsGHI/Rn9zlWvOz09eW6GgYLdRPZnb31nnbOABbNfmn8G7dbG
	43VXWhqTxtvXCMEoMJi4gp+K9wh+E/Bw4CHRHAhEsVlMUTPYEK8EDN9/GagfRwBi69I12YQQTly
	jfWGDpQa395JkhUjcP2rCxlTqgwQc2hOxDCl9D+urOHXR+B0hvLQwbGAy8p45EoMz9ca89xL3rf
	NgOIO3PNkgjbqaji/WMFduKmvIyoL8UG32M+oeVZKYDWwRSRB9QZ/IxrmKQ7vBmglYobqnkKndT
	kFPeWLsX840dhVwMnr+zqgmaVALzqL4rwGew==
X-Received: by 2002:a05:6808:191e:b0:47b:bd7b:10e5 with SMTP id 5614622812f47-4868db2d9eamr11794474b6e.3.1781040712262;
        Tue, 09 Jun 2026 14:31:52 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b5a5a64sm17024127b6e.4.2026.06.09.14.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 14:31:51 -0700 (PDT)
Message-ID: <e5c0fc2a-dcf0-4165-b2dc-d16c6cbe92df@riscstar.com>
Date: Tue, 9 Jun 2026 16:31:48 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 10/14] dt-bindings: net: toshiba,tc9654-dwmac:
 add TC9564 Ethernet bridge
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
 <20260605010022.968612-11-elder@riscstar.com>
 <20260605144032.GA3659201-robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260605144032.GA3659201-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/26 9:40 AM, Rob Herring wrote:
> On Thu, Jun 04, 2026 at 08:00:17PM -0500, Alex Elder wrote:
>> From: Daniel Thompson <daniel@riscstar.com>
>>
>> Add devicetree bindings for the Toshiba TC956x family of Ethernet-AVB/TSN
>> bridges.
>>
>> The TC9564 contains a PCIe switch with one upstream and three downstream
>> PCIe ports.  The third PCIe downstream port has an attached embedded PCIe
>> endpoint, and that endpoint implements two PCIe functions.  Each internal
>> PCIe function has a Synopsys XGMAC Ethernet interface capable of 10 Gbps
>> operation.
>>
>> The TC9564 also implements an embedded GPIO controller, which exposes
>> 10 lines externally.  Some platforms use these GPIO lines, so this
>> GPIO controller is managed by a separate driver.  Other embedded
>> peripherals (like a microcontroller, SRAM, and UART) are currently
>> unused.
>>
>> The GPIO controller is managed by registers accessed via MMIO on an
>> internal PCIe function's registers.
>>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   .../bindings/net/toshiba,tc9564-dwmac.yaml    | 120 ++++++++++++++++++
>>   MAINTAINERS                                   |   6 +
>>   2 files changed, 126 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml b/Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml
>> new file mode 100644
>> index 0000000000000..6e7a63dfcf86a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml
>> @@ -0,0 +1,120 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/toshiba,tc9564-dwmac.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Toshiba TC956x Ethernet-AVB/TSN Controller
>> +
>> +maintainers:
>> +  - Alex Elder <elder@riscstar.com>
>> +  - Daniel Thompson <daniel@riscstar.com>
>> +
>> +description: |
>> +  The Toshiba TC9564 (and more generally, TC956x) incorporates a PCIe
>> +  gen 3 switch with one upstream and three downstream ports.  The first
>> +  two downstream ports are exposed externally, while the third is used
>> +  by an internal PCIe endpoint.  The PCIe endpoint implements two PCIe
>> +  functions, and attached to each of these is a 10 Gbps capable Synopsys
>> +  Ethernet controller.
>> +
>> +  The TC956x additionally implements other internal IP blocks, and in
>> +  particular it implements a GPIO controller.  Ten of the 35 GPIO lines
>> +  implemented are exposed externally and are usable by the platform.
>> +  It is platform-dependent whether the GPIO function must be exposed,
>> +  and if it is, PCIe function 0 supplies it.
>> +
>> +              ----------------------------------
>> +              |              Host              |
>> +              ------+...+----------+........+---
>> +                    |i2c|          |  PCIe  |
>> +    ----------------+...+----------+........+------
>> +    | TC956x        |I2C|          |upstream|     |
>> +    |               -----        --+--------+---  |
>> +    |  -----  ------  -------    | PCIe switch |  |
>> +    |  |SPI|  |GPIO|  |reset|    |             |  |
>> +    |  -----  ------  |clock|    | DS3 DS2 DS1 |  |
>> +    |                 -------    ---++--++--++--  |
>> +    |  -----  ------     downstream//    \\  \\   |  downstream
>> +    |  |MCU|  |SRAM|    /==========/      \\  \===== PCIe port 1
>> +    |  -----  ------   //PCIe port 3       \\     |
>> +    |                  ||                   \======= downstream
>> +    |  ----+-----------++-----------+----         |  PCIe port 2
>> +    |  | M | internal PCIe endpoint | M |         |
>> +    |  | S |------------------------| S |  ------ |
>> +    |  | I |   PCIe   |  |   PCIe   | I |  |UART| |
>> +    |  | G |function 0|  |function 1| G |  ------ |
> 
> I don't see nodes for these PCI functions. Boot this platform with
> CONFIG_PCI_DYNAMIC_OF_NODES enabled and use the resulting DT node
> structure. Anything else is wrong. This will give you the DTS:
> 
> dtc -O dts /proc/device-tree
> 
> The ethernet nodes should be just these PCI function nodes. You need to
> make the DWMAC PCI driver (stmmac_pci.c) bind to those 2 PCI devices.
> And really, a DT node for them should be completely optional (unless
> there's some power on ctrl needed).
> 
> Everything else like SPI, GPIO, UART, etc. should be under the PCIe
> switch upstream node in a pci-ep-bus.

I unfortunately hadn't looked closely enough at pci-ep-bus
before.  It really looks like what we should use.  It's a
simple bus, and we'll use platform drivers and compatible
strings to match the devices on the bus.

I'll work toward converting things over to use this model.

> 
> 
>> +    |  | E |----++----|  |----++----| E |         |
>> +    |  | N |  eMAC 0  |  |  eMAC 1  | N |         |
>> +    --------+.......+------+.....+-----------------
>> +            |USXGMII|      |SGMII|
>> +          --+.......+--  --+.....+--
>> +          |  ARQ113C  |  | QEP8121 |
>> +          |    PHY    |  |   PHY   |
>> +          -------------  -----------
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - pci1179,0220 # Toshiba TC9564 (a.k.a. Qualcomm QPS615)
>> +
>> +  gpio:
>> +    type: object
>> +    description: Embedded GPIO controller
>> +    $ref: /schemas/gpio/gpio.yaml#
> 
> gpio.yaml alone does not define a GPIO controller. How many #gpio-cells
> needs to be defined.
> 
> Is there no address associated with the controller?
> 
>> +
>> +  ethernet:
>> +    type: object
>> +    description: XGMAC Ethernet controller
>> +    $ref: /schemas/net/ethernet-controller.yaml#
>> +    properties:
>> +      mdio:
>> +        $ref: snps,dwmac.yaml#/properties/mdio
> 
> Either all of snps,dwmac.yaml should apply or none of it. Generally, we
> only reference whole schema files (OF graph being a notable exception).

OK.

> 
>> +    required:
>> +      - mdio
>> +
>> +required:
>> +  - compatible
>> +
>> +allOf:
>> +  - $ref: /schemas/pci/pci-device.yaml#
>> +  - $ref: /schemas/pci/pci-bus-common.yaml#
> 
> These 2 are just pci-pci-bridge.yaml.

OK.

					-Alex

> 
> Rob

