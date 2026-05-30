Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95522BD5B4
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780106669; cv=none; b=hQaP+kFeurtpDACVzKh6xkvJjwVWGFYshsgNEW+gUAckfYlo5EM142nli8NdoJXqJzMDSFNCcWQEoIaH4l3gtOM/DqYwInXJXownWKdh3D9W1T319R0kCWLYboHA0BtC82ntgereGryk/BG+YHGrvMibhebbDLOgFlKMJyppGSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780106669; c=relaxed/simple;
	bh=72dSbvgXmThG29Wy9DC9W2hWdmDc/JhxBLXeNZoXfbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+enrLQaOu5rMVpcfy4VjvXQ8GdMhKyzbVy8VRoNmV2eI78WHxoR8+XwE5DZfaDDsezU5OH+LqRnkf1dpPq4gkvGaz4jU17sP1Xa0BYiP4qimykbYF+7MBFt9hdLnvV+uLB5h0MjvwBmaSvRPkZr7aX/QyPOa72RbS1fe73nXvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=LVyiTtQw; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="LVyiTtQw"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so190554736d6.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 19:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780106668; x=1780711468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UoipIVTXqr3vqIuBxViPLpH3VtK6s1uF7OWKVaQToZ4=;
        b=LVyiTtQwbrbUlLoqUmqXW3P3yZyuObb7h3c2WHqnnELkjYtkOyHufzvBkvKny33DYy
         UUOMOlN2MB8dJGlGLIGr5sSxeR9RLjeh/AlfgvAR23S8BLkWln1bXT6TMOu5xVO5YAXr
         OvRQAC+JEVE9lrssndDzCT8MDSGeNG0JLEsx+DFMLuMHBXpRd8kpTrchwSyEtJhUdaE3
         aDysD5s9w1TNC5H29QAyHxyfjRnMA7uHARCpe/UWta9NlRr4V3fiCl+CzylqU2uerGU9
         T1pnrvDOzf+TF5Yi3/UlaIQtnCCuBMItPWrop0jkaWfGDa2umkFHF6JOR01Ut9RoR6pE
         kkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780106668; x=1780711468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UoipIVTXqr3vqIuBxViPLpH3VtK6s1uF7OWKVaQToZ4=;
        b=ToyudTwDbioh1kMxLT4uIsWhWZbp78L4yF5BQN0HjEi0jENnP6G9aKEhEW+AFYycAr
         mUDNyDeBODKfCabF0vZB2SFsWyPS2gkj7jLm8Zzo3sc3aDuBB2y9/Urrh38uuif8K6om
         rIS66fnUop+uEZ86wjJHEPUkRVVPQwwZbVSl2+FeFOaVCsoA8oF7mQ7EQqnPMvG991o+
         mtmjbP8ALqPrIuRCs/P8u0Ssv2EPrH5CC/ZroV3O6cfXKlL5KoIo/w/9hC5XHtCq1Uac
         H8GDqsDEKN4gM8zAI9soTB/bWSiWafrc5D6ADjttd1XcdYZ9km50r6TaD4/l+DkSv+4X
         YPQg==
X-Gm-Message-State: AOJu0YwBjZVp1OKX11SHHNeUxWjO6exdw389p4RVuO2ou8l7VIoQboSH
	jpLuFnkYpICIkY7995xj+KUYvBJ+5lS0ItYf5/dRcklZvgq3s7J1JEBQQzPBnCT7LMKU5GEYJoN
	NM3KtgFY=
X-Gm-Gg: Acq92OFz5H5PHFzH6b97QAcuSmCFdasBEFS6YJiBzZ1y2XPPeWSBaYMwF/1++wSvbe6
	CDGrhrK5N2X0ZGs5t766UdSZWuAbsZwVeTJkDQfGZVv/eChAoD4TVhn8fZeqJd2ndLeSuZwh/rq
	q/mv5rfzJ0eKL7TOV4XLJpSIfOsauL9dob/fJUV6lUb5uB4XAWDVjdNQQFDyz2fzzP7E5K9h2RA
	OEprSKJdZuL1sQXv/+uyVS6Lc2F8cpELJHl+iy9QhPY24w4tKwU/lps6zImn3OvOB7/ib4w+sKN
	AflEpmHDPWkomp+5aIKVWsiEiGl1K0+TZzTTSHaDnaoV45vfIsRtlzgXhZdfAsK5LaIhjiYNCim
	12zraJLLv8dMTk2fUjxHca071M6Pr2FppLcclyBUFEDFmNYlGLwUX11EC8z9VDX/sfcgf2+1+XY
	Cqzv7LhTxRZjJLRzK/tNGM+uAlX7s4OYdw66Vyu8L4ZkSq
X-Received: by 2002:a05:6214:2f88:b0:8cc:60dc:a249 with SMTP id 6a1803df08f44-8ccefde0a77mr36709336d6.42.1780106667909;
        Fri, 29 May 2026 19:04:27 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea06d4casm32658206d6.16.2026.05.29.19.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 19:04:27 -0700 (PDT)
Message-ID: <07412401-d19e-48a3-98f7-a3342d264b35@riscstar.com>
Date: Fri, 29 May 2026 21:04:26 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/12] net: pcs: pcs-xpcs: Preserve BMCR_ANENBLE
 during link up
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org, Daniel Thompson <daniel@riscstar.com>
References: <20260501155421.3329862-4-elder@riscstar.com>
 <20260502155617.51FDCC19425@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260502155617.51FDCC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/26 10:56 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unconditionally forcing BMCR_ANENABLE for SGMII interfaces during out-of-band link configuration breaks forced and fixed links.
> --
> 
> commit 3fde24f4d6c6c8c6b563418e32cec40953863f8a
> Author: Daniel Thompson <daniel@riscstar.com>
> 
> net: pcs: pcs-xpcs: Preserve BMCR_ANENBLE during link up
> 
> This commit unconditionally sets the BMCR_ANENABLE bit for SGMII interfaces
> during link up. This change was introduced to resolve an issue on a specific
> hardware platform where the MAC fails to transmit packets despite negotiating
> the speed correctly.
> 
>> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
>> index b2c84b7e1e11..1d62d5b31c61 100644
>> --- a/drivers/net/pcs/pcs-xpcs.c
>> +++ b/drivers/net/pcs/pcs-xpcs.c
>> @@ -1263,11 +1263,14 @@ static void xpcs_link_up_sgmii_1000basex(struct dw_xpcs *xpcs,
>>   					 phy_interface_t interface,
>>   					 int speed, int duplex)
>>   {
>> +	u16 an_enable;
>>   	int ret;
>>   
>>   	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
>>   		return;
>>   
>> +	an_enable = (interface == PHY_INTERFACE_MODE_SGMII ? BMCR_ANENABLE : 0);
>> +
> 
> Will this break forced and fixed links by enabling auto-negotiation?

The next version of this code will handle this differently,
setting the plat_stmmacenet_data->default_an_inband flag to
true instead.

					-Alex

> 
> This function handles forcing the link state when in-band auto-negotiation
> is explicitly disabled, as indicated by the early return for
> PHYLINK_PCS_NEG_INBAND_ENABLED. When this function continues, phylink is
> requesting out-of-band negotiation or a fixed link.
> 
> By unconditionally setting BMCR_ANENABLE here, the hardware might ignore
> the fixed speed and duplex bits, instead waiting for auto-negotiation to
> complete. If the system uses a fixed link (e.g., MAC-to-MAC) or connects
> to a PHY with in-band signaling disabled, SGMII AN base pages will never
> arrive.
> 
> Could this cause the MAC PCS to wait indefinitely, failing to establish a
> link and dropping all traffic?
> 
> [ ... ]
> 
>>   	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
>> -			 mii_bmcr_encode_fixed(speed, duplex));
>> +			 mii_bmcr_encode_fixed(speed, duplex) | an_enable);
> 

