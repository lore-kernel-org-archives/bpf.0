Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EBB3A7F4A
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777901767; cv=none; b=P+RCnH7sK6Wapg2kNy7xgi2J/QQxQyP2/H4B7XsIp/AEEMv+cPN+qHFwLcuDOqF+U3ml4npcRylu1fZC2gosACqo+XfONBaCjG8O9PUos9BTTlVdisyrzxk192n6q5iRpXnS4DidDOZh8ZnLKP/6jRWumuphYgOBJckzch9Zjn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777901767; c=relaxed/simple;
	bh=LERfixZ4A/mCAlL4UIEjVNTDqF1ZRae/7FZpoHehMsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ueb4AE7LZClaTQ4lsU15IYwvVo0+OGI1D48JsEHn23pBJp5b8MLZjRA+AVwC8Abxw5abilTeHf36u0GgxbyNy/z9z5X3Qkl9INl7KopEm745z/FabeU4AYJjZyQ+O1jZ8b6i2J+KojW6MiBmdFRxNvWDbc+iltzdSkwOloRwREU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=uincUZpy; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="uincUZpy"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8ef2118b478so405077485a.0
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 06:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777901765; x=1778506565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z9fU46qFzoianaIQCMZvMdojbyNNsa2tYadi8NkaEg8=;
        b=uincUZpyQyXqvG2nseIYqBdFhOtC/F998c4JWNN8VIz83igZnlmBwOJO7uMXmPKHgG
         7NPHDCkjxrVkjG+nXRtngo2rOAATdDdK/Pephk+Y04/pYrGPkfOHuG/WytkaGqU8B3Y0
         aJSvi1PcaZbSTnWYZEuH3t4m6uJpNDU7ZlGtd6xivvb4/jyPhy4UekcKkD3R7mM/OuXb
         RSvD/eJ/Fkg2ihVaziysfOxQpCPXPDT4RXNhvk7t0Z82tFzidLa+RS/LRCm1U2bNyYEV
         71UyuKiqYKWVcHV5CBLhU0g+waujWIaKq5LgKL/2PFW0GViTXbMS4In5FrnwIqfnbp2a
         9dIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777901765; x=1778506565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9fU46qFzoianaIQCMZvMdojbyNNsa2tYadi8NkaEg8=;
        b=qaYF1EpxW7va4tT/19NFc5GLYdkLrZPEk3/6LF7g3uYZzUJka/tA0q3u59uc3al+AT
         METZ0xlXQIBznul5bzViOarsYsa/rCq04SGejD2EtnqWF6WmjwDexJvQAVxEEb+3iiqC
         VeLysHpE1IboWoCmnmSpRxNS9MOY7ri94iJH8NhVlqlslkID3HOqZefDGuvmmspH8Rde
         fr/N4P97c/wuGZ6r1AG1mco8IDn5DPLtBmNH9yUZ0wsOlUCnLi0RKcRcA7Pm4R5kJGt/
         BPU7B1uXbV9y32H5+Tzb2Pa5Dmz4jaB8A5V7Kfjrrbu/FhHUtbkNhePcdXogl1a4/7cO
         OVRA==
X-Forwarded-Encrypted: i=1; AFNElJ/qHhyi6YuTy+iVJ/5J3U97Wk4bB5DqfQK3yf+hmwmktUSe0ESmA+IxdD/QXcJm1ObLiNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAnlku7eIv0itYGIoWh/q0pY6YMwC3gDuwUCmn9m5vNXxfaWXj
	Ev6a4Vwb6HKpyEAT7kz3KX37vbKXvfLVzrNlHjuKAK4i3Tcwv+FKc/Jq73rVZdJ2g7M=
X-Gm-Gg: AeBDiesvOY6dmaSOyWbYar+ZqyoHN9l/cT1UD6Q0sKZ10E/3V8ShwCR9t7xqv5hUKcp
	uY0iGGVWJn76sV03h4LZfIgaJmy/daVW5Tt96zwuctpERcIZLMfe0AuIAkDFgKn4qhp9qBAYZZD
	FqSNeJsbarN8Arf1598lyXn636YDqzlPq0XMLr/hHClJ/avuO6+7xzOTSR/XW28MaOJkg8qGoie
	jAE9QnDIT4KdqFNDhlR1XWyf7sGVnBY5RPnkpfWYpu9meoDxxjQIRRfe3rfVhaJfVT8jzExQPjj
	uzJbmrIop3eO83rV528jEZTD9t0Na81oBvdm+olr9yjKuSfPUV5xW+qkdTOKxiWqAAA2zoXxkie
	dMYMVlKZcnUY4gKk9QnVIP/IHsDabVW4aZn8blDtTmOEpEeoXnRi+c0jD+1a9Y69rqZf4TQINsN
	EI/4bwlpIdExUQvl37Tx/3QJxMSP+VGd5gbsJY/246RN3DcR4IEuC+ozTXC/Uw4I9anO1YfaLFv
	A==
X-Received: by 2002:a05:620a:2905:b0:8eb:f3c7:224a with SMTP id af79cd13be357-8fd17d49626mr1448021685a.30.1777901764463;
        Mon, 04 May 2026 06:36:04 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29a80784sm1058189985a.12.2026.05.04.06.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 06:36:04 -0700 (PDT)
Message-ID: <7fbb8bb4-5626-4908-ba80-2db35661e30a@riscstar.com>
Date: Mon, 4 May 2026 08:36:00 -0500
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
 <539b9de3-4a78-44cf-9085-06cd0cab2d17@riscstar.com>
 <4cbe1a04-4a49-4e4d-95f4-ed4df1afa24f@lunn.ch>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <4cbe1a04-4a49-4e4d-95f4-ed4df1afa24f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/26 3:55 PM, Andrew Lunn wrote:
> On Fri, May 01, 2026 at 01:06:23PM -0500, Alex Elder wrote:
>> On 5/1/26 12:13 PM, Andrew Lunn wrote:
>>>>    	if (priv->dma_cap.host_dma_width) {
>>>> -		ret = dma_set_mask_and_coherent(device,
>>>> -				DMA_BIT_MASK(priv->dma_cap.host_dma_width));
>>>> +		u64 mask = DMA_BIT_MASK(priv->dma_cap.host_dma_width);
>>>> +
>>>> +		ret = dma_set_mask_and_coherent(priv->dma_device, mask);
>>>
>>> I'm nitpicking, but i don't think you need to introduce mask.
>>> DMA_BIT_MASK... is already on a line of its own, and is within the 80
>>> limit. Nothing changes here with s/device/priv->dma_device/
>>>
>>> 	Andrew
>>
>> I did this.  It was simply to silence a checkpatch.pl warning
>> about a long line.
>>
>> I don't care either way, I'll gladly put it back the way it was.
> 
> Please pull checkpatch fixes out into a patch of their own.

That's what we'll do in the next version.  I'll undo this particular
change, and will add it to the end of the series.

Thanks.

					-Alex


> 
>         Andrew

