Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE63AB291
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179455; cv=none; b=Zj8faa2r8jsIBpzo/yqRG+oLUhuP3MWwIjQrmx6RNO5G0Avs+H4VtbmOpw1xDJDuzK7cD9euLP8Z8ve/vuh+CGGrKSbDUlipssLb4cfqhLVqZyOc/6bqJN1Oc44NipnnMbjQRF9v6a/QbE4cDlfRNTe4jQTvMT2kf4VEBQyPiRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179455; c=relaxed/simple;
	bh=OSzlYQw2h6gcRQVmUKR53Ckl2/E4R/U/cGa1oPYYTlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hw++V2YIa3FrBy46ixke1djHhGZFtJ+TjYcCefcEc/GKHvJ5EJJtDYwXN5oZTvjbkYSTnU2r0joiSlEr7kc1wq4+vEPbxzOvoC21/w94oRX7M73DCIEm+Wf5xqbn/dZtJ/kIQRX4PPNRkYlSGE/BUVaRY9av8BFhJweDSnX2Rqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=XxFN21KK; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="XxFN21KK"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506251815a3so8916521cf.0
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 11:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778179453; x=1778784253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1OHugVXwVYl4EIQGFzGx4AQVN+wMQGiAhztZolIIb7Q=;
        b=XxFN21KKeIEUXbAGo/6Ib+7hUGTlZX/8XuZzfJbo4yl6PSap3BZOrtaZqZvc1Woa0x
         0TvN9aEcZ4+js8z68j+MUt90r3LhtiXIbw6GBdwg9q24mniraMXZ0Vvge1WjQqtz8mQc
         wnb4NwKJ2So0FhLQ4UU9Ej5D+YrrYrDhweEMM4rfVO5sA+1tuVk7/V+5x72FaCnYpwSY
         xkoc5EHJoWePAMfv2RAHc4k2vsCVzgkDN8jl02GAzFudANcX7iezGiutl4yi5yWunYrI
         9pNxEHt5AqTVXWNcfG7GvuP8sOJHtqUQbxIWRmTus46EYlpu0w9nrzY9OcsAahURAauT
         CcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179453; x=1778784253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1OHugVXwVYl4EIQGFzGx4AQVN+wMQGiAhztZolIIb7Q=;
        b=pAPVqpcivVE5OsvpSRPMtzEgFufQsJAqT1XA5Feugu/yH+1r/qyKW8U6ViGYgboOsU
         zkaHMaqLvKmvemGA4JuDq1c/bT7Th0LDQkJ3U3ftzME8Bjcw/g/49oilzy7Ks1f7FK+Y
         bDPHuAvqOzqxKeJkSjJzoLbVRE9R1d4jTYQdAQRAqUPUB2GbzI8MRt9m65c/SHuOvKEI
         yoDGALcfe1c7f3uOfJxIpjpyJqIxxj8XPn7L7xkDDLtM214fTmvrGjqNXUCIoma/LcYh
         Ta5hIZBpsvgmnyMQDGM02oYJQqAoUutwMOpVO4uvSh7CP9ZORWKhXBgFwHEg1ca6kkbf
         otTg==
X-Forwarded-Encrypted: i=1; AFNElJ8jjKzS41WvifcWNxTWojRi+At78YxlAObzBvPTiSiIi1FTpaX3p473quZJbG5t6Oignqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8uif6++braA9xpG+58sRWefIWHK4WyE2Z9tMQ6xGkoNTf4cP9
	kPJoKx2jr5XyA1At7xy9J6xgWOXz82BHWE4306HBGuamgPenPz1kMLFvzqSfD0vKQXI=
X-Gm-Gg: AeBDievbAfA/t1Gei/Mw1e3LqpvL4YsMqJ1VOUuPw4ly6YXZCxYpptfWUMbS1zQj/ZH
	m/cSJY4UrUPvXrJvIR4Moj6cKMQW4LugvC3afSTygkCnXGahw/9GXwqIKvVp67a5cKyKD0zn1Qc
	BzxY4FZfJzuya8ZbVHM6jgsHWrKqLVQOrEZZlvtBanXGkandg6A3fLZyJBt6fNP/6hqwZSQjNh7
	vBmuMpBY4iil5B/KByclpDYnf/geAUBPE/Jfi/F0YEo+E0BbT5D1A8A3c+P5Q8jmeazGcjMMnN6
	U6BhMnptroQO6QZeGwswI3c0Afxd5Tq2yQ2HUcfRQwBJHisAMjfxlAD54W6DEAvzrW8XQqIXUyA
	esY0vM1hAUtbKHO5aYBfT8POA0vidTfiXbZ5J8Kp2EPDG1UPtujksOmZOMQ0Ld4/780aa5B48F5
	5jXEUHCxmYaBtbHS2ewIPAohdovrlYkg/kLHavD6a56Qm3urzrT+/lvFimx74i9XRL4OU69d269
	3o=
X-Received: by 2002:a05:622a:8c7:b0:50e:5fe2:83a9 with SMTP id d75a77b69052e-51461bf0515mr133144421cf.5.1778179453134;
        Thu, 07 May 2026 11:44:13 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-514850d0d82sm5022531cf.5.2026.05.07.11.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 11:44:12 -0700 (PDT)
Message-ID: <ae90a4c9-f027-4373-a378-d0d4b7796ff3@riscstar.com>
Date: Thu, 7 May 2026 13:44:09 -0500
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
 <224E233C593EF171+8c8a43dd-5061-40f8-9eb7-f360eabf2ecc@radxa.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <224E233C593EF171+8c8a43dd-5061-40f8-9eb7-f360eabf2ecc@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/6/26 7:59 AM, Xilin Wu wrote:
> On 5/1/2026 11:54 PM, Alex Elder wrote:
>> +    /* AXI Configuration */
>> +    axi = &td->axi;
>> +    axi->axi_lpi_en = 1;
>> +    axi->axi_wr_osr_lmt = 31;
>> +    axi->axi_rd_osr_lmt = 31;
>> +    /* All sizes (2^2..2^8) are supported */
>> +    axi->axi_blen_regval = DMA_AXI_BLEN_MASK;
>> +    plat->axi = axi;
>> +
>> +    plat->mac_port_sel_speed = speed;
>> +    plat->flags = STMMAC_FLAG_MULTI_MSI_EN | STMMAC_FLAG_TSO_EN;
> 
> I got WoL working only after adding STMMAC_FLAG_USE_PHY_WOL here. I 
> guess it's required, since the driver clocks down the MAC/PMA/XPCS in 
> its suspend hook?

I just want to respond to this with a summary of our plans.

We will *not* be implementing wake-on-LAN (WoL) initially.  We
will work to get support for the eMACs upstream for TC956x, and
then as a separate step, we will enable WoL.

It's great to know you have it working, and our plan is to
implement it via the PHYs and not involve the MAC.  It seems
it will be relatively easy, but we have no plans to add it to
the current series.

					-Alex
