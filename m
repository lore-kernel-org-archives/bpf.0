Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973223DC4CE
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777901684; cv=none; b=h9HREOA6eEtFErsPAwd3cylwxIs79J7ydHfbZowU0f8YSW5pXF55SZpFPwDOAg+fDx0tOstx9AWQ8cfT1Z3hVUIc3QlUf2rjipWb/SjLj7Znrv+tGTUD31AkEqBA7YXmVij0NsjAzgf6E78by4mfyF7TBQivQldOqk1dpihinqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777901684; c=relaxed/simple;
	bh=fE/FMqRtr05uo+J0w0E8qsFyUlmDDBPKI19czQaErzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GsLVA8Mk11yAkUgtxoxGKra9ugXu6yVWan9wEIe1/YxfK+2G2JGD4ShYQO6k1fnxAzKW+b5z7BBZmBYo4++SDikyW37FbQitoZ2Ch6y+ZsWjJ0OyJxpP9XcwA3m+AwSM+eOOJjrsbXkJNrXuUzn1FakXUNsoy2nED1SXU9TYZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=IARYnIuF; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="IARYnIuF"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5102582e23eso31434661cf.1
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 06:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777901678; x=1778506478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1O51d4ds85yTh8lyD3JZ4q7u8vPdQtNHSLTt8d3PVfM=;
        b=IARYnIuF1jJJrB45HAzJaAtwE+AeyXoN91edqT8qe4dqB9eycPEBOeLfpbjRndv2p7
         b1KTlNc/O7xHE8z8JpMGnwfuvFJOsigZyTVXl9Dzv3zHK3rS12ZhVun3jts6+mXEGbmw
         70OKRfGlkhCJrz8BtUen4+30f0EA2u0RZqvTLPUb4ZInITmwks28S48SG273UIh+Dafz
         J+dLHOlNYGpwQGzTTLA8thF81/iZcz62YxDr6puMELr40aJJPq99InHfWYgqNGBkjfhA
         saRoIlS47YYiU6OqLCOdreoTIPFJVBwtTe2xXAvwWc3S+wjEVEfKGKHCJVvDqdaWHouy
         U3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777901678; x=1778506478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1O51d4ds85yTh8lyD3JZ4q7u8vPdQtNHSLTt8d3PVfM=;
        b=AyAvJB2MOP52hzhAXeoC9Wj0NyLc55EOQghfXZ9tRnQA5T9dyiEu2JVA1ED+mieOhp
         HJC1w5y3T83M5CiVG9+jRMduw8Yo+0Z9BcxsgwcOuM7U4+17dtLckI4ZhRz/22AldQqy
         I8ozpis2i5p3EzBf7pv/J9uQRTM9Sy+eHUWCedqKKTmMOLVqZoi5nmSLxZZuUTwyCRkK
         wQ0lefnx4oLgnzMNYmMqKwPFN6EOA96ugxH9OF83pZUsB2EUrIGaO5GmkIUPmIPtIe8p
         xU3WNPcpNeLV19j9BkTWISZjBlJUVO4U1ZM6nRL616+6xO1Wls8j9t5y3YO4hweMDzXX
         +J4g==
X-Forwarded-Encrypted: i=1; AFNElJ8JuVDGgSn6h9D2BA6qL02teitMrYnQfqPwZrzdPfxKr9UJpZqMRiG1jw21nUtcWzYY97A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDEW/rm/KJyePCg1w8A+BSuCpXEDiNNqKar+trpBbsrzHdIK0I
	/aAOkeSwQFnu/xp57DiNlGlNeUmkevsVujVooJIBxr/l6CKH0DOTTZQ284L3Fl5ce1M=
X-Gm-Gg: AeBDiettOPxewvlGnfJuR5LyeNSfbAZTRf/xl6WBeAMEh/Z8WbB/NAPnj52hsDwfs6y
	msL2NflmYshuI8cLXXdjT5S8rm/nElhIG8026grbPRCvDPxuJ51fIvDtoxG2C6ekJGybjROzria
	Mw45DE1LEhK4AY45HANt2toR+8k2wR4nmCmolW2QPglIgMTpdfY2BX4mojEiMSOFhuAf3WPMC7x
	dGJzlA6Cm304J1EKbX0a575aQIKaNOOub3xygle1x2IIqghzH/jcdVCGEqV4Wm4LikC+mhoScSY
	OaBzyOkJKgr7tPKlPloyJqFwgthDYOEE4Xe8pkyS0vppkecMWZXTm2+/fK/ktdsP7E07DGfBzRR
	G0NIITNH06xuGVDJXApfIBCMnD0Eq5ljUrksTWKqeMvDuPvZP3Lo6dp0OIkTjMlwVaPME6QrKZq
	1FTpJfT92r5GLYA4y16IpT3PlCQFNYcD3HLzzj0L5B6PBJ6uXCaoFwb3XuTxjtyL6WXi2fV347v
	g==
X-Received: by 2002:a05:622a:48a:b0:50d:9e8d:9837 with SMTP id d75a77b69052e-5104bde3d42mr142601201cf.11.1777901678300;
        Mon, 04 May 2026 06:34:38 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91c807sm1137764785a.32.2026.05.04.06.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 06:34:37 -0700 (PDT)
Message-ID: <164fb5ca-9c42-46ad-a13c-3757ff5d2fdd@riscstar.com>
Date: Mon, 4 May 2026 08:34:33 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/12] dt-bindings: net: toshiba,tc965x-dwmac:
 add TC956x Ethernet bridge
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org,
 brgl@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 Daniel Thompson <daniel@riscstar.com>, mohd.anwar@oss.qualcomm.com,
 a0987203069@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 boon.khai.ng@altera.com, chenchuangyu@xiaomi.com, chenhuacai@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, hkallweit1@gmail.com,
 inochiama@gmail.com, john.fastabend@gmail.com, julianbraha@gmail.com,
 livelycarpet87@gmail.com, matthew.gerlach@altera.com,
 mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-9-elder@riscstar.com>
 <20260504-fascinating-teal-tarsier-b116c8@quoll>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260504-fascinating-teal-tarsier-b116c8@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/4/26 6:00 AM, Krzysztof Kozlowski wrote:
> On Fri, May 01, 2026 at 10:54:16AM -0500, Alex Elder wrote:
>> From: Daniel Thompson <daniel@riscstar.com>
>>
>> Add devicetree bindings for the Toshiba TC956x family of Ethernet-AVB/TSN
>> bridges.
>>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   .../bindings/net/toshiba,tc956x-dwmac.yaml    | 111 ++++++++++++++++++
>>   1 file changed, 111 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml b/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
>> new file mode 100644
>> index 0000000000000..d95d22a3761da
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
>> @@ -0,0 +1,111 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/toshiba,tc956x-dwmac.yaml#
> 
> Filename and here: toshiba,tc9564-dwmac
> (s/x/4/)
> 
> 
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Toshiba TC956x Ethernet-AVB/TSN Controller
>> +
>> +maintainers:
>> +  - Alex Elder <elder@riscstar.com>
>> +  - Daniel Thompson <daniel@riscstar.com>
>> +
>> +description: |
>> +  This node provides properties for configuring the Ethernet PCI functions
>> +  that are attached to the internal downstream port of the TC956x's PCIe
>> +  switch.
> 
> Describe rather the hardware directly, not the DTS or the binding
> itself.
> 
> Just say what is the hardware, what is consists of, what is less
> obvious or usual (if there is such).

I understand what you're saying.  We will reword this to focus
on the hardware in version 2.

> 
>> +
>> +  TC956x are a family of Ethernet-AVB/TSN bridge chips that combine a PCIe
>> +  switch together with a number of Ethernet controllers. These bindings
>> +  cover only the Ethernet functions of these devices.
> 
> What about the rest of the hardware - a PCIe switch? Shouldn't it be
> described?

It maybe should, just to provide a more complete picture.  It's
a little strange, because the PCIe switch support (or at least
its power controller) was already upstreamed:

  
https://lore.kernel.org/all/20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com/

That introduced DeviceTree bindings for a PCI device, which is
itself sort of spanning two worlds of discoverability.

That code focused on the *switch*.  This series is focused on
the *Ethernet interfaces*.  But the "chip" has several other
components, some of which (GPIO anyway, for now) also need to
be modeled.

I want to talk more with Daniel about this but either way we
will revisit this and will attempt to describe the hardware in
a more complete way when we send out v2.

>> +
>> +allOf:
>> +  - $ref: /schemas/pci/pci-bus-common.yaml#
>> +  - $ref: /schemas/pci/pci-device.yaml#
>> +
>> +unevaluatedProperties: false
> 
> Place both (allOf+unevaluatedProperties) after "required:".

OK.

> 
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - pci1179,0220 # Toshiba TC9564 (a.k.a. Qualcomm QPS615)
>> +
>> +  "#gpio-cells":
>> +    const: 2
>> +
>> +  gpio-controller: true
>> +
>> +  # We can't allOf reference Ethernet-controller.yaml because we end up with
> 
> s/Ethernet-controller.yaml/ethernet-controller.yaml/

OK.

> 
>> +  # contradictory $nodename rules (`ethernet@` versus `pci@`). Happily only a
> 
> But which schema requires pci@ for devices? If I am not mistaken, only
> dtschema/schemas/pci/pci-bus-common.yaml requires it, and it does not
> apply to actual PCI device.

We'll revisit this and will simplify/clarify if possible in v2.

>> +  # small number of the properties are useful on TC956x so we can just reference
>> +  # what we need.
>> +  phy-connection-type:
>> +    $ref: ethernet-controller.yaml#/properties/phy-connection-type
>> +
>> +  phy-handle:
>> +    $ref: ethernet-controller.yaml#/properties/phy-handle
>> +
>> +  phy-mode:
>> +    $ref: ethernet-controller.yaml#/properties/phy-mode
>> +
>> +  mdio:
>> +    $ref: snps,dwmac.yaml#/properties/mdio
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +examples:
>> +  - |
>> +    pcie {
>> +      #address-cells = <3>;
>> +      #size-cells = <2>;
>> +
>> +      tc956x_emac0: pci@0,0 {
>> +        compatible = "pci1179,0220";
>> +        reg = <0x50000 0x0 0x0 0x0 0x0>;
>> +        #address-cells = <3>;
>> +        #size-cells = <2>;
>> +        device_type = "pci";
>> +        ranges;
>> +
>> +        gpio-controller;
>> +        #gpio-cells = <2>;
>> +
>> +        phy-mode = "10gbase-r";
>> +        phy-handle = <&tc956x_emac0_phy>;
>> +
>> +        mdio {
>> +          compatible = "snps,dwmac-mdio";
>> +          #address-cells = <1>;
>> +          #size-cells = <0>;
>> +
>> +          tc956x_emac0_phy: ethernet-phy@1c {
>> +            compatible = "ethernet-phy-id311c.1c12";
>> +            reg = <0x1c>;
>> +          };
>> +        };
>> +      };
> 
> Keep only one example, unless you have different properties (not their
> values, but their presence),

OK.  Thanks a lot for your review Krzysztof.

					-Alex
> 
> 
> Best regards,
> Krzysztof
> 

