Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B685F4B8DF1
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089477; cv=none; b=W1r5j36q4NoeT9olB/rtMsbOX+fKdbrh4LJzSGHLX5k3SlWCp0Iz249WcJ38fM/NIt+RCnKaKenNs5ACLnFsvQuKfyar4Blo4ydkg8zlgY/Tle9uPnF6+e/bakKpu4F0Ewqm2XC3KyHeBoaIVq2WI04hLWD6J4iEDqf10HaLwww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089477; c=relaxed/simple;
	bh=/YjFQWxNpMQZ2f2KytppViSRzU0yZJvUee9ryGQwSOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlvSliiQCGcHrS7F/FAvTclWCTmfX+1VFr6FflzBKQ+DNG0CN6PgF3JSb60OtCdm+53/wwhDh5lJQkq8en00rAOcDYR7NMn7tIF70qpzzA5cxwRJXqcnCnNPFkhQ2mYFmoSMe7QIIu6dboUx2ezEq7GJt3xmuw/0LNBaC49ruCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=A/tWM9I+; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="A/tWM9I+"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8d65f4073bfso900892985a.3
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778089473; x=1778694273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k6wXO6STmxH+YsbEuPXhWzzsM6OvvesRxD9MxXwGEOY=;
        b=A/tWM9I+MidkfGgsZV3URMJGGeCgr+x0pwX/vDmp9qjFxG3qTM0C7yaPymIneMJsak
         00eo6ukEIws+rAbKxilEt8PE3bBQl/bdeIR843LD5oyHIoQlulo6XQ2P7r5eu8hR4feO
         KEVy7WEU2p/Ey/PiAiRMaz+tmrsQkdVuICkapNuYK1QpbWLQoF14Yl0qTNN55VLq3nHj
         tbr9KV5I1Xt75WkkNjVUdlujZzYhGTnfDX4KghuHirRo+pcUytReOCCL8DveJ7DESIQB
         UXqEHuL//GRfLjdNZXXg54F1QEu0gFapghqGj2IZcfZ9iImftmoCfFv33sIOaKewB+a6
         47XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778089473; x=1778694273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6wXO6STmxH+YsbEuPXhWzzsM6OvvesRxD9MxXwGEOY=;
        b=RM8m9LZABRTIEn3tsgY9vXUwesEp7TTX5A6dubcoZ/pAi4NDk5EJ3LrGt4H/ns9sJ1
         ZaYpYH4dxIYRw0RYOqSwLQhs5irZIaNxciPP55cVdqFWr0FT3ylq4BsfmDmpO4aoxh5+
         Be6hIr4dattUhI72x9s9HTV/JmOPIEqEID73GlpJ07wIKglFjPBrshZgsSmVvzTkU3mY
         zMty9r8IhQ6GdKCutD4CddkzClVryovS+/i1VyIcw4+1p0WPgKo9ANVLxX5JYDlnHs2T
         bpFPpPWIJczZ7TSETevOz3kzzBmZqtoyjAhfARzOUDNJpzuUksEJSjBmYqBDlnpH1xE/
         8Nzw==
X-Forwarded-Encrypted: i=1; AFNElJ+/5mACsxfhLOF0kSzeJ57lRw/3J0X+kcLgkh/mTHeS3mE+o9sPL/Z0If/pjsqj2fdP9P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRzAlt/YxZI5pO8TB2MVMx9dpg22WJt2u/zkW+Z65itrrbT5J4
	3ys4l10rCZYCXmFOTug/7bsip1svX/nV0/RX3ZvN9iw1s0UEN0iaP3vlVXVb8CLCnAA=
X-Gm-Gg: AeBDiesGs7Ube9ZxOkLMhkuEN+im4mqO0701R8M+IU0xCYt1LnreTWSw0l7AVfdRqqv
	GFZV1Z5Cdc2azL22JD5iCVsLgPOSL0h9d8s3flE1ghl6BMRW1U4TREQ77tRksJAjaVMohDXEgPN
	Dr8z1nPVBYd6h8yWLDMePZg3FZch10FQQa0LHaz+gwhsGJ0gnbN/vw1FVGYIvnpA/BRWqCewx6K
	R929HhOlBkgKHB+lZmqraJmhHvGdvdUWdQ1Yi0ondh8+j0Rrar/8ZGKzxq/3lNiNepblLhBKk50
	XkNBrKZo+T7STQB6O9liJRsLAQJEBuTN6vfobfM9Xrf0Ru1FDxllQhU2/AeW3nk3e/Le6aQ8f29
	8017yaWPU+dDiur1tLljQrT/evsScbAS1X9xc01ERZWbq06UiJBcIu12Y2bAOfd0Hi7WziMqv20
	1zlRMBg6IXjSgP7OI7NJp0o5kdWh82M2ilxOwAPaDfmogiq1kG4LNeqDFoLinN0CUr6uM0rcHnO
	A==
X-Received: by 2002:a05:620a:f0c:b0:8f1:9e59:220e with SMTP id af79cd13be357-904d63e7a90mr642596485a.39.1778089473124;
        Wed, 06 May 2026 10:44:33 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cdfbsm1736572285a.34.2026.05.06.10.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 10:44:32 -0700 (PDT)
Message-ID: <7f3a0f16-5159-4bbc-8b15-9b5841603bf6@riscstar.com>
Date: Wed, 6 May 2026 12:44:28 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/12] net: stmmac: tc956x: add TC956x/QPS615
 support
To: Xilin Wu <sophon@radxa.com>, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, rmk+kernel@armlinux.org.uk,
 andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org
Cc: Daniel Thompson <daniel@riscstar.com>, mohd.anwar@oss.qualcomm.com,
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
 <20260501155421.3329862-11-elder@riscstar.com>
 <DD71CDEABC7C16D5+02d052ff-13bb-4712-a847-91416f76c578@radxa.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <DD71CDEABC7C16D5+02d052ff-13bb-4712-a847-91416f76c578@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/5/26 9:30 PM, Xilin Wu wrote:
> On 5/1/2026 11:54 PM, Alex Elder wrote:
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
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/Kconfig   |  13 +
>>   drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +
>>   .../ethernet/stmicro/stmmac/dwmac-tc956x.c    | 791 ++++++++++++++++++
>>   include/soc/toshiba/tc956x-dwmac.h            |  84 ++
>>   4 files changed, 890 insertions(+)
>>   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
>>   create mode 100644 include/soc/toshiba/tc956x-dwmac.h
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/ 
>> net/ethernet/stmicro/stmmac/Kconfig
>> index e3dd5adda5aca..66bcfaccbe21f 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> @@ -404,6 +404,19 @@ config DWMAC_MOTORCOMM
>>         This enables glue driver for Motorcomm DWMAC-based PCI Ethernet
>>         controllers. Currently only YT6801 is supported.
>> +config DWMAC_TC956X
>> +    tristate "Toshiba TC956X DWMAC support"
>> +    depends on PCI
>> +    depends on COMMON_CLK
>> +    depends on TOSHIBA_TC956X_PCI
>> +    default m if TOSHIBA_TC956X_PCI
> 
> Hi Alex,
> 
> I think GENERIC_IRQ_CHIP should be selected here.

Yes there are a number of things missing in the Kconfig definitions
and I'm working through them this week.  And yes, since we use
irq_generic_chip_ops we must ensure CONFIG_GENERIC_IRQ_CHIP is
enabled here.

> Thank you for the driver.

Thank you for your feedback (this and others I see).

					-Alex


