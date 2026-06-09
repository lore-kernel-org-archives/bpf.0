Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31694344DAE
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781037544; cv=none; b=JYYNB5fqy9BnuQJPG+juvD124dBMx7OKXhzxno7o1i5db1N4SG4OfvBK4kBfOHDboLNCwCi38ATwq+ooYwWOOr68wOGhdSGPaONgWnx80nyn57QPNuRU/MsBMSfKOobTVb4qGcONFuNNx3/p/dpNIF7wADesabzM49SaasEL+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781037544; c=relaxed/simple;
	bh=08cDWJ1AoJw7XTjy3VUEvgAlD0lie4xSJmxfcTku0Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MM3PBfcCiEFNdriLY+9m6Sfk2nwxO3HT9MGA6RvlyX+g61E6HNPFQmahX8glJt/UHgxgM4WuT71gVyL/BHFxG5uXY7B8qsphjHXBO5mnMqrj1iDL9vMnp+DdmnDCW7rGX3aCvpo8aOO+g6+FKlU5Dg853pMaJ8bCScW+I0v4s5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=oD4dgFfj; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="oD4dgFfj"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4863a7dac63so3132882b6e.1
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 13:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1781037541; x=1781642341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xG+PJcI9dU8eULLGgiwqpsuOnpbG0JGZGxHHivVcL3w=;
        b=oD4dgFfjWcy5YqsNv9HDDx6YWgurqp/+3/dsbW/psa+crQWdh3bLtJK3JgSua94zKx
         OGgxSJe6ygZ9UeHTcUBxf+Zq7pd73f5c0PipE4nAXgtDNNq7T5IRdnhKjcAooK6ySZqW
         h8hdqPMAxtxinkdPUm1ncSzy/ZNyr4+2vdsSyoduLQhCEPOXVTwyXjuFf/yYv1hG8t1n
         fPO01xG3LnWiXJIQ/VXI/zY1DtQ7JQRT075E8SFIvVJPbvfcfgxnw8lBQoxestXrAF9c
         r88Qbxski0tlH58kci7vaBylcFytMwmSrv7I1YoN/qYFTVnTE1MEqdGnT0nbrDng8JH/
         +8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781037541; x=1781642341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xG+PJcI9dU8eULLGgiwqpsuOnpbG0JGZGxHHivVcL3w=;
        b=BYV0liYrph24HFoC6wa4Z2FMwRd7tmV9cslYFFEMAhPDvls8IA8ZC+Kmtq7gCegbKt
         8mGck7tuWNA5AnwJppjzcfnYw5H9FSzqFeRKK5VrChpKsdhAv4k+F+Z/C+YKQ+SkIM9G
         8z0omAAC59+2wT6FcHG/CgjRNIJnrAisa4IrFRZlExmbmUiS1plZr87WAh9JH4kHFQ+m
         WEDM9mFVI7x1zQ9ACNbsPVg3o6x85Orx1wb48PQNDWEyYmlNY1guOnL5BKqck3i5lshO
         xuQQeNkI3M1Qb8RxmWWaYFDyRt6Tm56t85jFmRnpzw98/gWZcU0zqtQ0zkPeZmXZ3hDf
         zQ0A==
X-Forwarded-Encrypted: i=1; AFNElJ9zP5ZILzSLZ/w833m9zxCIzuQvB9jWcLFHqsrLRdZGSCI9tG4nN3hFzXKDAbNqNdbVvDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyrS03d2+0+0mMDee9BisCWMn/mV8lhghXQC+QHbai2ewT1XKS
	mEk6kRWMZUGWEy/jbI0o5+AMIfLx8O8U7yVHozBBapFKHfAiCI/FGp4ledLSCuXYRDw=
X-Gm-Gg: Acq92OHxQT+XBB1LOdIoAtzZM4/wuKdf33DZK9mZc9U+GoBZ58belp6QbgQ0GfcmfTe
	fCTXWZIt6NVhSSCiQp1pGztNFbp91PZwiN+oj21TKOZdS7VUar9n0pEsOj3SjHbTe0dxETdZZw3
	7AlwOpLetgOzk2CSOZwqKOcYuzXoBe1rXBKGqzJbN/F8L1vuJxSOAMUT5AFzLo8sulWNzRMDusT
	TNkF8KWrNE+jzKqHgD/1eovNoQTlVbo2xKycB29Ll54VtSQIL+W1/P1771YGN87hPKBEC/gstWW
	pQ4J6iSgBG1hMGsDefmPR4fYtY8Z2qUXlSXXONkStSZLWA6EuVFw/EisM8RoGGGz43QCp8oZscT
	iHoz9cdlaw+LewRlJJ20m7a0r8EFUprSDAtR1KDYk/FD01LuV6qOpWLLTREPtcoR3Kn2h1uz9lE
	pcRnD6GGfvp6r8FhMbBD9EJogK26POuyK08A==
X-Received: by 2002:a05:6808:d4d:b0:485:4601:9c84 with SMTP id 5614622812f47-4868de44d92mr12430789b6e.29.1781037541328;
        Tue, 09 Jun 2026 13:39:01 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e78e7f9csm15313928a34.17.2026.06.09.13.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 13:39:00 -0700 (PDT)
Message-ID: <c2d586ec-84ee-4c25-b5b5-19a0a9819d6c@riscstar.com>
Date: Tue, 9 Jun 2026 15:38:59 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 03/14] net: pcs: pcs-xpcs-regmap: support XPCS
 memory-mapped MDIO bus via regmap
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, bpf@vger.kernel.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org
References: <20260605010022.968612-4-elder@riscstar.com>
 <20260606010123.B07D01F0089A@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260606010123.B07D01F0089A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/26 8:01 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing colon ':' after 'F' in the MAINTAINERS file entry.
> --
> 
> commit 2d23c3db72012c33d05246dcd5eb68b21952d164
> Author: Daniel Thompson <daniel@riscstar.com>
> 
> net: pcs: pcs-xpcs-regmap: support XPCS memory-mapped MDIO bus via regmap
> 
> This commit introduces helpers to allow drivers to register an XPCS using a
> regmap for the memory-mapped MDIO bus. It addresses issues where the MDIO
> bus is allocated to a register window that does not align to a page boundary.
> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index eb8cdcc76324f..2aa6ea012c848 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -25931,8 +25931,10 @@ F:	drivers/net/ethernet/synopsys/
>>   SYNOPSYS DESIGNWARE ETHERNET XPCS DRIVER
>>   L:	netdev@vger.kernel.org
>>   S:	Orphan
>> +F:	drivers/net/pcs/pcs-xpcs-regmap.c
>>   F:	drivers/net/pcs/pcs-xpcs.c
>>   F:	drivers/net/pcs/pcs-xpcs.h
>> +F	include/linux/pcs/pcs-xpcs-regmap.h
> 
> [Severity: Low]
> This isn't a bug, but should this entry have a colon after the 'F'?

Yes.  This will be fixed in the next version.	-Alex

> 
>>   F:	include/linux/pcs/pcs-xpcs.h
> 

