Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBFA2D8393
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 02:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780106683; cv=none; b=fB2AoniiRqK0kKx3itDHwDEJ0y7VuGt/Xpo+hERTx4YN7S3TS61WsUS9yAAr3rjESTJPrT9MmGHzdEEJlQhRgyuHfgtubhkeRrJWgt8rc+lCnAGKrvWxYOzYyNgRVkPxjQan5zK6cLgUemoTpOinJFtn9kiJ83hVZVjm8KJLIEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780106683; c=relaxed/simple;
	bh=7x3g2yKZzahEp9eVu9h6doQtC5pNf0FT1K9qUyLtQIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZNZYfYXbVCHaH2O+un3xV9F+cybbCKEA2BkqurHNwT4Mu2GMmDdipaZ4wW+6uz1WNrSsy7aD6CgCv43GCbzFLWz7+0O3bA8mVSAFNMZZojG39PhfElvetYCJLm++xwsO5mZY3Fuk7eAAMMYyrDi0XgN9gjPOLX9pxPbzPYzFSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Qow31pQW; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Qow31pQW"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ccd86df7d4so30335736d6.0
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 19:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780106679; x=1780711479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jAfLH0/JyU6jSxnsmUzgYT+Ykc2SX6vKy6PcvKQo0OU=;
        b=Qow31pQW56Y4BY+5bxRU7YOehEo/BZpN01swV+01FFGe7u8NlkzltT+Uq7Q5LYIRjL
         /gBNa1zQdgAe7CJrLxyx0doZTt7zE+mGbKa/Sf8czMFd7ZKxWIN+dfV6PMu3gp30RpkI
         AQL/zAo8BnM8WjBM/IAlESw9RKLP+mExbuQwZK9/OU/CcRTooLzb8wgtLgTVk1GLrm1K
         Ggwv7DS/edn3W8qjt7XWs/NJKGXa+FXXN1bLoWcYLcK83/dA39SwGVZJywCx9D9JEDtU
         7SlxelNMFARUQwA2e2koSgI/0WVhCMsHLfWqm/ncQSVGY0aIwoIS90Yg//xNsPpBe9eS
         vvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780106679; x=1780711479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAfLH0/JyU6jSxnsmUzgYT+Ykc2SX6vKy6PcvKQo0OU=;
        b=FGZVWTmqH2I7Fb9ZKkNdvZkzec85K290gpNmy2a7kLuSAZxOdxtDSmp0H6KHSg8D0B
         KP6NWqTD+GXu8cMYzRQLW7nd1LC+xNFvJ60+3CGmG/w/GTB/Rr4GGTHu1N6AaQQ/Zw6M
         AHe6WjiKRGAP+im9MBbyW3xfdfxCqzO8T8lgB9OmT05qXoJtGXGuUH31EUE7aQKZnxqx
         Bkr72ZYZNYYigM/GSZgnzshscbxkwc2SYYcPtVqOR1o+R2AajPjywlzt0e7qBfTHwwvK
         lJuIztmP33ZXE/QNarkJ89gMljrG1GU3PTSvS7FBoaU4GLixwxBMiLe2sY6ERYu2TR6M
         mJIA==
X-Gm-Message-State: AOJu0Yzz0lBx78xQD4blmOOrdMrfHnTWFRsjAaUyMgzRH/1IBs8J7WxX
	Z41MuwDM6uBzM3m99TZanMDT6uuSgTDKtqTbOFN8URPP71JiGIg9R3M+6/LfSWqL5ek=
X-Gm-Gg: Acq92OHUp7sGQfGXmcKwpE+dlT3/+FV4D2OG0mM8h+ZMs5QQ8r5lFv4vQYjZ5PY7y/h
	zKykSI3NQAqGdr6rVW4kVT8KO0baacV8nhvxg4cd+tlJ8M4QOua+AbdWXMzELkqWJCFo7i0Bvof
	X9LdKEjeuKlHOp4ndvSYZd77Op1kO5hpm/ujGRkfqNx/zn1/YY2/bniEcgxT/l+vMZUPXAlCYR0
	jnBLKzjaja10+cLlxp6aV7hUPKU4HsKMzwCwlaJ7gLaYk9aAT69g4JgX07y219X7wUG7Da81IBq
	BbUwoIF4aP5sKNbZ906hifbXbqDuZQEkYv208fGMOS+CnHUMkyYUwXKK2txcGhIrga68ljDg86I
	HohpQet1YGujVBPfYt7dAC1tYHLGmDaOBckftZBrS9Jqh4jeMBu0vZi7TYxCSMD4CRSCi6ZZDml
	5nr4YWJWH+eB0Vgc1YKoF6KD/VZTyCqgAWyA==
X-Received: by 2002:a05:622a:406:b0:517:383d:11f with SMTP id d75a77b69052e-5173a6dc42fmr31153931cf.24.1780106679593;
        Fri, 29 May 2026 19:04:39 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea06d4casm32658206d6.16.2026.05.29.19.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 19:04:38 -0700 (PDT)
Message-ID: <1ec59b99-318b-4403-8b8e-fbcf3eb393d1@riscstar.com>
Date: Fri, 29 May 2026 21:04:38 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/12] dt-bindings: net: toshiba,tc965x-dwmac:
 add TC956x Ethernet bridge
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org, Daniel Thompson <daniel@riscstar.com>
References: <20260501155421.3329862-9-elder@riscstar.com>
 <20260502155615.AF378C19425@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260502155615.AF378C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/26 10:56 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The binding adds GPIO provider capabilities but omits `gpio-controller` and `#gpio-cells` from the `required` list.
> - [Medium] The Ethernet endpoint is incorrectly modeled as a PCI bridge, applying bus properties to an endpoint.
> --
> 
> commit c5a5d0d7a89f5ad66c878c805902efc5e0bd117a
> Author: Daniel Thompson <daniel@riscstar.com>
> 
> dt-bindings: net: toshiba,tc965x-dwmac: add TC956x Ethernet bridge
> 
> This commit adds devicetree bindings for the Toshiba TC956x family of
> Ethernet-AVB/TSN bridges.
> 
>> diff --git a/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml b/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
>> new file mode 100644
>> index 000000000000..d95d22a3761d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
>> @@ -0,0 +1,111 @@
> 
> [ ... ]
> 
>> +allOf:
>> +  - $ref: /schemas/pci/pci-bus-common.yaml#
> 
> Is it correct to reference pci-bus-common.yaml# here? Since the tc956x_emac0
> node is a PCI endpoint (an Ethernet controller attached to an internal PCIe
> switch) rather than a PCI bus or bridge, applying bridge-specific properties
> could be semantically invalid.

As Rob pointed reinforced, this is not correct.  It will not be
present in the next version of this patch.

> 
>> +  - $ref: /schemas/pci/pci-device.yaml#
>> +
>> +unevaluatedProperties: false
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
> 
> [ ... ]
> 
>> +required:
>> +  - compatible
>> +  - reg
> 
> Should gpio-controller and #gpio-cells be explicitly included in this
> required list?
> 
> The binding defines gpio-controller and #gpio-cells above, indicating the
> hardware acts as a GPIO provider. Omitting them from the required list could
> allow incomplete device tree nodes to silently pass schema validation.

The GPIO controller was meant to be implemented only by PCIe
function 0 (only--not function 1).  It was furthermore intended
to be optional (depending on whether the platform used these
GPIOs for something, like reset control).

However we plan to change how the GPIO controller is modeled
after version 2 of the series, and I don't want to try to
explain how things will look until that work is done.

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
> 
> Does this endpoint node need bridge properties like device_type = "pci",
> #address-cells = <3>, #size-cells = <2>, and ranges?

No, it doesn't.  Using the PCI bridge binding definitions was
a mistake.  We'll try to improve this in version 2 of the series
but again, revising how we model the chip will have an affect on
how the binding looks.

					-Alex

> The child of this node is an mdio bus, which does not use PCI addresses and
> does not require PCI bridge translation. Using device_type = "pci" on an
> endpoint might confuse OS PCI enumeration logic, which expects nodes with
> this device_type to be actual PCI-to-PCI bridges.
> 
> [ ... ]
> 

