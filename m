Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9543161AB
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662332; cv=none; b=JhGX+q12TWSTF+yhxh6gql1c3ktGtij2Wj+jL0cpAxqsfCpRevhE+64MIQGR0WZmP4wnDV9F9VVhbuQyrHnNhIruOVh9cBsnR/4U+pHTDSrH6YV7RwWdTNYYQ9aWxmEsu9OuIP+4O9dXAs1g8Ms56VpZXDFedmw6m7Nz98o7xyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662332; c=relaxed/simple;
	bh=Cco+vFiWz8nH8jHJl25YPtjf0AjyxuJKLseQuLXyV6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MP/g3GjG391o7agKBAVo9nYnSsTvMP8csowmom8qFHLZCqLDiAN9iTvcoOEI+inx0grqQmxbneXjwl0XY/48+koF1l9jgS9K68VvVNzhRldgLttWNsCLl57bxkKZeBWLUKcH/ZNi1hRfKKI6DvwM9nNRKUpM4RjP30eOfoVUrdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=tUMtqLec; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="tUMtqLec"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e6d37b7098so1861732a34.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780662330; x=1781267130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hOWy2W3C8F0epU9cKoqDrCPhuhX/iOel8Vt4x+uvwak=;
        b=tUMtqLecdeNiQfmnCangw9uIxBJT/E1QFVahFrNmyeF4vG+kGclSuDkVfdn/cTn2FE
         y96Whio74QV2/5QtORKyOzL05kuZVCGVjvaqhCiCgqmsO6GRYdyGZsEcyxEhZtHgynHx
         LdzzGk8Q59EzezCjYkyEKO69UK+xv0YFKRuzF7t4CErPNlFQirp98qROPXTkpfc2wb7r
         qbdcaPCGEbcpxMxtlV94hIXpYi6Sd2LmW2P8cfioGpodNFZ02i2Xi8vUL9opx68VX68T
         wz2XTSACWkijiS6GtkoDT+Z5q6QthEC9Exl2raiI8iIvLtqNwAPe0hIkQH0LiZCRPf3r
         4hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780662330; x=1781267130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOWy2W3C8F0epU9cKoqDrCPhuhX/iOel8Vt4x+uvwak=;
        b=WvJMUwn+/U0uV6CWQ3HM+KNGnFZ8l+0+bqbbk0L6ji1WAGpR99C1qIsQmlX08rSAR5
         8k/d7QVYOaV9WVzmGdI6BI95kOs/rnzOUkBQ/T8lwCqDzQtMLcqMDTqr2ZeS9TFkxxEn
         D9mjAoZakbLG+UC3ponJG6LKQfsoeRiEJ7BK3raHQ34zuGZDPrmORSrw6RpjHHh6tF15
         MdSy5MQPQkATm2cHA8/FpaBsohs5z4IjltSD2ggcBUqoPQJsQxgMK4/LLbQglmEgt0tY
         /idIGM73XfFyPBMMHyPOT5uatM7ByQFZzjExICV6c7rl8/j9lOf/xni5MG4UGEjtK8TI
         FTqA==
X-Forwarded-Encrypted: i=1; AFNElJ8HhoX3x7mo/kiNDj/WydnZWXyZF94OsLpbg07cXhC/RKv5Uj5WutwbbUfv+05EIPnPDr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGU4JITPvzFeF5aabyR5OIVGsR2oLqbfHVJoh4O6pHG6TB9otg
	9AJZaoWuGKE8Ya9aKirwEmpsYutjqXRJJF4SNxyr/1t7RVHzWU3HX5nPNv6JlvJBZt8=
X-Gm-Gg: Acq92OED4f+3pcDZ23UvXRoCvkDQcOPMq7zAUa+CzEkfMrc04/F4XFSGFiL9gKGyxhf
	XLSxJC1NC3+CBj9b37OGliAo2skf1nsYYhG377KTArj9ivrYqEzh2+dXzIvEoMph8fKQHqqB/iM
	oOoFthwaD3mzqBVd4d6zjcLNN6Z8ZzBvKRYeAsf69+oTTGgWqDWXc9c2PnwduHW1+aEVWdbfkeA
	SF5Ruo3RSWLZDxqQYKBN27ASsa5lkP2/AyWkfQeXgI7kz73h+0uGx3c2ikLN35Rq8GqMJkAqmNS
	Nf4Icpnbp2Hn87cidcwEkln97htHxuEf0ZVrfB0tVk9Wze35Q/xhx3vgeouliDJH3vd549+E3aO
	w74hy8TcOWJdrCwAuZo45mMliIBW0YJAYH5BL9qF+CksCvoa+k6+aAF/cT0wX7BJLqXy+8MM+Po
	/yV/ASs14HSfoPo/PlulFrrnzn5ihOUqX2Zwg=
X-Received: by 2002:a05:6830:6685:b0:7e6:deb1:484d with SMTP id 46e09a7af769-7e70c7b1386mr1725355a34.13.1780662284484;
        Fri, 05 Jun 2026 05:24:44 -0700 (PDT)
Received: from [172.22.22.234] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e7974f22sm5817653a34.25.2026.06.05.05.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 05:24:44 -0700 (PDT)
Message-ID: <bd2c09d4-462d-4392-bb3f-ca91b2f08bd7@riscstar.com>
Date: Fri, 5 Jun 2026 07:24:40 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 10/14] dt-bindings: net: toshiba,tc9654-dwmac:
 add TC9564 Ethernet bridge
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: weishangjuan@eswincomputing.com, linux-gpio@vger.kernel.org,
 inochiama@gmail.com, davem@davemloft.net, devicetree@vger.kernel.org,
 kuba@kernel.org, me@ziyao.cc, hawk@kernel.org, arnd@arndb.de,
 konradybcio@kernel.org, mohd.anwar@oss.qualcomm.com, hkallweit1@gmail.com,
 pabeni@redhat.com, ast@kernel.org, maxime.chevallier@bootlin.com,
 bpf@vger.kernel.org, boon.khai.ng@altera.com, linusw@kernel.org,
 andersson@kernel.org, sdf@fomichev.me, linux-kernel@vger.kernel.org,
 livelycarpet87@gmail.com, a0987203069@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com, daniel@iogearbox.net,
 john.fastabend@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, rmk+kernel@armlinux.org.uk, krzk+dt@kernel.org,
 conor+dt@kernel.org, rohan.g.thomas@altera.com, gregkh@linuxfoundation.org,
 Daniel Thompson <daniel@riscstar.com>, chenchuangyu@xiaomi.com,
 andrew+netdev@lunn.ch, mcoquelin.stm32@gmail.com, edumazet@google.com,
 siyanteng@cqsoftware.com.cn, wens@kernel.org, brgl@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 julianbraha@gmail.com, netdev@vger.kernel.org, chenhuacai@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com
References: <20260605010022.968612-1-elder@riscstar.com>
 <20260605010022.968612-11-elder@riscstar.com>
 <178062720108.1744752.12164392208085928081.robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <178062720108.1744752.12164392208085928081.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/26 9:40 PM, Rob Herring (Arm) wrote:
> 
> On Thu, 04 Jun 2026 20:00:17 -0500, Alex Elder wrote:
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
> 
> My bot found errors running 'make dt_binding_check' on your patch:

Thank you for this report.  After upgrading the "dtschema" package I
also see these errors.  The "gpio" and "ethernet" properties will
have an "unevaluatedProperties: false" constraint added in the next
version of this series.  The name of the binding file will also be
correct in the MAINTAINERS file.

					-Alex

> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml: gpio: Missing additionalProperties/unevaluatedProperties constraint
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml: ethernet: Missing additionalProperties/unevaluatedProperties constraint
> 
> doc reference errors (make refcheckdocs):
> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
> MAINTAINERS: Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
> 
> See https://patchwork.kernel.org/project/devicetree/patch/20260605010022.968612-11-elder@riscstar.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

