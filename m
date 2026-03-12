Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4765D8F0
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319194; cv=none; b=TLOVQPK46vOBt5B5rkTrAgoMthUaQIi4XejETIWoLKbW8OG0i6UGZOU5dXcGNRevQLcGSVY4AIRwzs5AOCxrrKZvLxYugjWblc4nIvfhhriUD+UC7wsBiE2X3emdGvOG4nUTVVmWVUv8/IVIjukQKDwCWT+386cpUSSO6jhlKF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319194; c=relaxed/simple;
	bh=yJE7TmVpzak2737yOceLZuLfEbjJw0atog4/kCv+aYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVdGcw43X/xSS5WQXZRa/P9rps4pndbsazDEF+Qeroa151rDwmXteyGxVH3CppDKX/nRe97I6mKF50BnHw1eVxF6XwCNyHGkePhKqnT7RkEWsjoSbuN7zEXI45nHyE2ebPWblANDX30I5w+yZ9873usXhfI+SvOCfpsTxtSKAxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IfXGuCJY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VOeU5bZY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfXGuCJY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOeU5bZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773319192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwq1D47F5ROQxQyd90bopM9phl1aU+B811r3GRsAdNI=;
	b=IfXGuCJYX/HxL7q6TYk68MKTcnprtAEkUrTGUahYRKCAPC9NEA1txHInyJO8B/xai2NBQ6
	zz/JE7HbgXz54xINR/6BYfUAhWqyoibcA4iNfxtCAWCJCeXoQk9d9HQe+0pFlGADJ5AwDV
	zuMEeSEedWPUnXzD6k+F+0ecye+mgos=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-sAv_8tTKNJaB2c2D1QZOqA-1; Thu, 12 Mar 2026 08:39:50 -0400
X-MC-Unique: sAv_8tTKNJaB2c2D1QZOqA-1
X-Mimecast-MFC-AGG-ID: sAv_8tTKNJaB2c2D1QZOqA_1773319189
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4852ccff333so7634805e9.2
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 05:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773319189; x=1773923989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwq1D47F5ROQxQyd90bopM9phl1aU+B811r3GRsAdNI=;
        b=VOeU5bZYXPCDZwaK4Rda7h7K3CTo5cxKcjQFXVGYsmr4pe95rgVM1dBankFdWfFwsD
         V4YoB8gtSxX/CPA8a4hVRkzKe3XUarj8SBrg2oCk+3CX6WdgWLrdfqyanfTWuNLH5EL+
         bL0IR0NNOjKk7EIVDRHK9ezCvkt0i+BtwGlRJPeObCqPSLQ3F3Fuh3fdw+mR8w1NIjbI
         uVAl+VMZA2ly9Vy8qOHXHHm1mhcbaNuYZ9BWmbVsZcshlWW4LIpEE0V8zxRgzux03rwY
         Lp9Ec3msev/1NS5XAtua0EyBMUUC3jmkA3hFsz5m+8xSBY9wDjMT8pUx4aa2JTA+U+FM
         mWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773319189; x=1773923989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwq1D47F5ROQxQyd90bopM9phl1aU+B811r3GRsAdNI=;
        b=I2utoNJDMRBcxHWr4Q4lZMFquamI1Nmby9iZ+lbbtax45cqt3GzLLCPkGJavw9WUpI
         rTinm9Tl6sV7Wb7p4uYtu6t61y9N5hR0KuhdE41C2tz8AvQb4GHGZ9uYo0k50IR7JOce
         CO7uXfgZ8s6n9XAXJQB2oKTaUhiEc/3Jtb6ofxcBPblZrfILrAAs8/FqDp6Pmgr9YD3F
         78YF7PD4U2ztl6frrPxS6VKRJj1GRQJbzeRQgx18n0G1YZbvPUbv7mN0U8T8lCTX52Lm
         8XbdLz2ZR4FM6SwAy++S5FUNMiE4n2+PECH23K93yAm8D49gt/NqpCJjIjfJWQuU+o7Y
         Vytw==
X-Forwarded-Encrypted: i=1; AJvYcCUday5KJh557zuGv10K8M1CBaBG2lPG7R4VH8K0hnFEVGXd2aeL17xf9ZTYu1WGSnIw1ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiZpbDf2xHIp94qAQpza0fdCg5armN7BChqLkuyePeufIpLeUz
	Q00697PFuQxYxPgTPJ8R5Jn09YLchbB7LznSZxVF8syy33nShwsiPLIZXmsWgOZMEOIyVthhorj
	j1dY0Z1HeWQBWHuLpLXVj1XdTXKQ0c0NjlsJMY957Rm4CbeyoRydYNw==
X-Gm-Gg: ATEYQzwlCMHSj4qcduG9A3PPbWf03AuqBIoLo9XQK3ZsRJk5In/TRHafpfmrLTHdDR/
	mFkAGrot7c1TdAVJ9i9HmSOWbrzxKZzb0uLnbhZKZlslgukEEDDe1AeTZbXySLveTWgQx+nXAtN
	D3dF5Za9C7Kh8Yifbs/75+8pd529YaTuniH9nwIxFj80tpme0JpvOazLxZ+JG3Km5HgCYf6YeKD
	8X01O03+rDMEcidrQZ6RqmQhwHCt68xmmbkO6rcH+WqWP7f7F4mcmm0qiMPXtVpKuYVZF1V8tWg
	UbaeHuXrdgkctt+hOQoLhrqdarfjyyvNZPnlp4Z7XTSxEAiHDYwgoF4aN+wCl3wCm3anL66A7ox
	UZogZMPFYYkeZkD6HpJ1o3OJ5wzkKMR3XWy/hRiA+hUP8GxCmJbwdSPY=
X-Received: by 2002:a05:600c:a44:b0:485:4100:1eee with SMTP id 5b1f17b1804b1-4854b10c539mr102303875e9.24.1773319189476;
        Thu, 12 Mar 2026 05:39:49 -0700 (PDT)
X-Received: by 2002:a05:600c:a44:b0:485:4100:1eee with SMTP id 5b1f17b1804b1-4854b10c539mr102303525e9.24.1773319189051;
        Thu, 12 Mar 2026 05:39:49 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0caccasm97722845e9.6.2026.03.12.05.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 05:39:48 -0700 (PDT)
Message-ID: <a544e971-a22e-47f0-b085-70ea743a4dc9@redhat.com>
Date: Thu, 12 Mar 2026 13:39:47 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] xsk: remove doubled defines
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 kuba@kernel.org, horms@kernel.org
References: <20260310134327.422540-1-maciej.fijalkowski@intel.com>
 <abCOYwySxuQnkq_k@mini-arch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <abCOYwySxuQnkq_k@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/26 10:34 PM, Stanislav Fomichev wrote:
> On 03/10, Maciej Fijalkowski wrote:
>> Seems we have been carrying around doubled defines for unaligned mode
>> logic. Remove one of them.
>>
>> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> ---
>>  include/net/xsk_buff_pool.h | 7 -------
>>  1 file changed, 7 deletions(-)
>>
>> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
>> index 0b1abdb99c9e..ccb3b350001f 100644
>> --- a/include/net/xsk_buff_pool.h
>> +++ b/include/net/xsk_buff_pool.h
>> @@ -174,13 +174,6 @@ static inline void xp_dma_sync_for_device(struct xsk_buff_pool *pool,
>>  	dma_sync_single_for_device(pool->dev, dma, size, DMA_BIDIRECTIONAL);
>>  }
>>  
>> -/* Masks for xdp_umem_page flags.
>> - * The low 12-bits of the addr will be 0 since this is the page address, so we
>> - * can use them for flags.
>> - */
>> -#define XSK_NEXT_PG_CONTIG_SHIFT 0
>> -#define XSK_NEXT_PG_CONTIG_MASK BIT_ULL(XSK_NEXT_PG_CONTIG_SHIFT)
>> -
>>  static inline bool xp_desc_crosses_non_contig_pg(struct xsk_buff_pool *pool,
>>  						 u64 addr, u32 len)
>>  {
>> -- 
>> 2.43.0
>>
> 
> All consumers seem to be in net/xdp/xsk_buff_pool.c, 

AFAICS there are users in xsk_buff_pool.h, too:

$ git grep XSK_NEXT_PG_CONTIG_MASK include/
include/net/xsk_buff_pool.h:#define XSK_NEXT_PG_CONTIG_MASK
BIT_ULL(XSK_NEXT_PG_CONTIG_SHIFT)
include/net/xsk_buff_pool.h:    xskb->frame_dma = (dma_pages[addr >>
PAGE_SHIFT] & ~XSK_NEXT_PG_CONTIG_MASK) +
include/net/xsk_buff_pool.h:#define XSK_NEXT_PG_CONTIG_MASK
BIT_ULL(XSK_NEXT_PG_CONTIG_SHIFT)
include/net/xsk_buff_pool.h:           !(pool->dma_pages[addr >>
PAGE_SHIFT] & XSK_NEXT_PG_CONTIG_MASK);

> so why not remove the defines from xsk.h instead?

Indeed it looks like the macro definition is duplicated multiple times.
@Maciej: could you please drop all the unneeded dups?

Thanks,

Paolo

