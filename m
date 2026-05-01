Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251FE33B6E8
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777658789; cv=none; b=BixHUMklywj7NQw7T4dS1BrDQDJGM+XwLpoNaN+GdwvBxu69ZSaJeeeTUpw2MrU3DUGTZfrk3ZhVw/Qa6DD6aHNcIZx+U2nkvaa//KWaiC9zXvwMp+AtxYHUYLFpvXYY5q55Y+iN/T2/66ZzypDp1UwP1YzE3i7IDlOnDI9Xm70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777658789; c=relaxed/simple;
	bh=oKkQnY5vlFNovbcjfh6JBo8TVogGXpyGhtvkDtTNy3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3nT0ea8eUkeJG+ZuPjpKfWLnk0Sj5SG5cdflEfEfGZd+BeRX23ECdEEqfW8EExICbjXrd2c0YPnpOzfFFlV3GCgMU1hyTrF8wuqpgyjxggC8/RQ/X/9vRZ9Oa7ulQaiGgqfULRf8zmV0+yjVJ3PrZKcKfXcjiNq7na14azN48A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=psJ3Fjh4; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="psJ3Fjh4"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79a46260385so28859617b3.3
        for <bpf@vger.kernel.org>; Fri, 01 May 2026 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777658787; x=1778263587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1DjW845zhModhDu44NYwmrHvDI4OE4s13MqVWiObLc=;
        b=psJ3Fjh4F/IvT+GnFPrExEwYlGYre21c/sJ635RZrszNYBXaXf5wN64XMn6ym7/psU
         Q2p+xXX2OyIDv3LMm6MTze4TlZkVqEoa5LBRKzq8SHUMpzTAWhKGajoUlT/6qaLDwchY
         5BnJcxhDXuQgHakxWjVfWWVVLyFWoIHmsKPMrAtEoUGU4SP3U/bJWLSo/wF43VT4VLU3
         JVzTAhYmNHQMjGVKGbxeLIpjZKHAtTc12qpZWpK/Atj7nRqy6PwkvuqCStFJ1iK3aWrp
         kNUE6XQc2lSrMSKr6TAQQe2G4Uo/xq82lf8T/LX65G1UDU74tl4CipLKYY0ErDW5fkzF
         Md4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777658787; x=1778263587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1DjW845zhModhDu44NYwmrHvDI4OE4s13MqVWiObLc=;
        b=dQcZKdde5Lamrm+R+9cO4JwxdRtdIwSqhDxUvaAF/foK5xGrNwnD+9zV/iDM7EpHMp
         WDrICf/8wJBtBfAXwDaqoUPQePw8fqmvTZnu8Qf1giaEP8EQZv/sXCj5GA82hkqs2gui
         qt8hm+VUYLqSp2PrgD4dXMtv0fM3HZOYLEaH0dtHMXVatgtin8z0tBQeajvMZDDf5s8A
         ckF3XCwWsGPY9rs0C7Pj4XfKYXSiXkWwICwh4umsUtsEbsP9G8o1OQGsTi3RU4DRGxm0
         KqJTFbTkJGFVcoLjNIGMXhuhQqI3SV4YqmWVet3z5j5CfNAIQ6EuJrmHQjLBZhmpQSgI
         vgMw==
X-Forwarded-Encrypted: i=1; AFNElJ8tv3N6QZxDdiWMUTuV3O2agxoFkcKR0AnzKcpVEslpLzdJKalAocgjowP46dyY0aN3eTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3v7SidiipciCjpueah6QHZP/6ORJ5syE37bbYLCiPp9JyAewh
	iDP80MnOJWd/EMf0KUA4e/gkIzQBWNDhnRyWZ1UTVQ02utRsFWkBAwIe43WOvNpCI9g=
X-Gm-Gg: AeBDievoYZ7cecOWR0ZCDGQ4Ti6bsPlqoNh2dMyAyhhQiMRT1Yw7bs2bf8CYb3rJ2Lj
	xkEMtNLO8xmIt6EFdgZpZJYWUbGguiIrIAxNr0L+x2/DFwhXNNIh/hCfiIkZepNkPfGs5dpvYNW
	Z37Qh8B2azbMBuccasC4Op6U3/9PW9tZIhW/+yzrfsHkN315Vrfc2PBzhu+OOSFEIVgAUgfMBv1
	h7giEZ8g8bPuGKCID0SXxEl1Hd9zQ27JW4rcEvjfZ3zhR+dfUX4ZfTDin+hmlYN/X+wg9yhqfkB
	N8Q4/7k3BUdytSf58LesL2NVIL+0hKAhgAVsrGTsoZyWybWa0IjEiMZ/Fq42k/NIIsRSdqcyOmQ
	gksu3iO/ZFXBNZHEDN0BJvVgWiAwRIazdc67valFgqH0FBCG5XZzQJVHBwt0Gy+HHJWjBgV3kMD
	9sQ7NGUJ5jLhAITOKk6UE+fNHJaaLC1yGYhG/y/5EgcprDmYJANFzJTCSozxkrfcKenqkCDNmr4
	w==
X-Received: by 2002:a05:690c:dd3:b0:7af:6904:3f3f with SMTP id 00721157ae682-7bd77170409mr4261187b3.45.1777658787005;
        Fri, 01 May 2026 11:06:27 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66019105sm14575347b3.0.2026.05.01.11.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 11:06:26 -0700 (PDT)
Message-ID: <539b9de3-4a78-44cf-9085-06cd0cab2d17@riscstar.com>
Date: Fri, 1 May 2026 13:06:23 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/12] net: stmmac: dma: create a separate
 dma_device pointer
To: Andrew Lunn <andrew@lunn.ch>
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
 matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-5-elder@riscstar.com>
 <9203d8dd-8ec0-415e-9c2e-5b06b1b8dc11@lunn.ch>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <9203d8dd-8ec0-415e-9c2e-5b06b1b8dc11@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/26 12:13 PM, Andrew Lunn wrote:
>>   	if (priv->dma_cap.host_dma_width) {
>> -		ret = dma_set_mask_and_coherent(device,
>> -				DMA_BIT_MASK(priv->dma_cap.host_dma_width));
>> +		u64 mask = DMA_BIT_MASK(priv->dma_cap.host_dma_width);
>> +
>> +		ret = dma_set_mask_and_coherent(priv->dma_device, mask);
> 
> I'm nitpicking, but i don't think you need to introduce mask.
> DMA_BIT_MASK... is already on a line of its own, and is within the 80
> limit. Nothing changes here with s/device/priv->dma_device/
> 
> 	Andrew

I did this.  It was simply to silence a checkpatch.pl warning
about a long line.

I don't care either way, I'll gladly put it back the way it was.

					-Alex
