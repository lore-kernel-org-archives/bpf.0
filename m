Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53BB45040A
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787232319; cv=none; b=U4KWkT+qZ1kbgbWbfuqlvYtQOj9Asnt58ctUSUZgZYxGfVOe3ZHIjppjmcAuY6JI3cNxSkIZVMcEp1LgMfqjjtHA/jCfLfMduKqbQhzJko6AnCTt4VNmu/vZbA2JqvzHZnMT+uQay6jhFdCwrzL6Fp91POTVEdP5bGeMrOI20YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787232319; c=relaxed/simple;
	bh=oodidHthKqnaocJR7FdH/865yN9AxJYR0G1qnoJ8P5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HQLtcFM08AFfsl9rrW8I/l/7qluZaJXDCTwUZQ+YYxFzB8flETBZ3fxDDjmOElOJQ5cTfBIDIjf3ohopG5l5ubjc+2kxfcd+YZivhq5SCtdOtRhOhTfVAXiyDFyZHFPcY2MsiKdlVzHTbk+Ws2Iq0MsMkSNtNnixtMHOfsBLyFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XhrF66+5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpSIZZEt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhrF66+5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpSIZZEt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787232316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/0v2ILIh5MBGsD0dXIHABcykS6dXc3s6xjBbGcHl2A=;
	b=XhrF66+5ogFluDxKDHOm/Dlv1ra5Qs3beGm/MQexBNDI2hk3P7nWjhrzvaK5axz5lvw1GZ
	eQemN8r6v9Q6QjBwGFXYGQ9UPuj8ZUXU7NAHsn1HWhLGc3ZdIjRIZDsQAzSvTwUAmbR0MT
	6czdKrYrmNfwq6kG3h7OAszcb7bj+pU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179--ynK4owSNC6E7S2oAYlt1Q-1; Thu, 20 Aug 2026 09:25:10 -0400
X-MC-Unique: -ynK4owSNC6E7S2oAYlt1Q-1
X-Mimecast-MFC-AGG-ID: -ynK4owSNC6E7S2oAYlt1Q_1787232309
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-473ac08a6a4so1531483f8f.0
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787232309; x=1787837109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a/0v2ILIh5MBGsD0dXIHABcykS6dXc3s6xjBbGcHl2A=;
        b=HpSIZZEtDm2WuTgE6YUUwteDAzT1GpcYXS/cUT13XnqIF3FfGYBUb1I48/va1XyRuw
         MOxbzs9lZW1uKtkpPQ8ytuz8x034VvlLH9pmvIpErWGTLn4HWCD9Q06YbgElca/8PxNS
         A8pi9I6It6dl64ThBcTCHCCsX4+Ie5F6l4NQ9+DWrfVuHM1k5qhC4Tz+nveBpGdSm7fn
         RP3TKQELNCqsORJ597Nf+ktjwj5PMKU0PVAmbmktyllab6vIuWJ+nFdKALviRg8hCU0c
         JkW0cMnZiQEZhDeCrVorpY/E6/ZIJU990ejsc7NOo9b2PA4SrX9peANovX+rDRJmB77u
         Hqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787232309; x=1787837109;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a/0v2ILIh5MBGsD0dXIHABcykS6dXc3s6xjBbGcHl2A=;
        b=hhZk9cbnbmwZVNGVRdY39RfnsKJtaSBKYaONjVv0S4C9K93LPfA8UKpJdRM6jA1jmi
         HH640AugelXQNbUJOJtXsAG+8qo2RUhAdgKezWOxLdlo10aiix2zsV/AChYAVm+3IHVU
         Jl2sgnXnDU0exKCJJAJ/iDaP7xeWYaEob9CFYbc+s2UJEb4byKXfl7laBOQg44JH6MB8
         2dotPxsN8uj8p5y/1ymyekpGzmqc01FOhvFr0hw0hhT7ZuY8308DKCOhD8iwqG/Wk5l0
         VV5YU7oIFM0ywedRxYqUN8u9kvL07rKiiNtNcLIpDcar4zRnk3XkDNWAc9oOu1X2ehN0
         icLA==
X-Forwarded-Encrypted: i=1; AHgh+RqLt5bsLW+fNbjXIMxe/kNfkKGRnirCmDI3CeNhZNVO4lt3ProMvm36rwloyQXB1hDqAx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQygDJyU8LUYOaMKiiDgbwU6ddf7Uumc37TGkQVlUcYBoDPru7
	HWhOy9Ow1N9JTJGsuxJUet+IZmaj3Ml89xqkVkQk5JWgNrEKi/LIqs6x75geiKusVs0rng0JplJ
	Jgtg3a+9VjNLUY+SOZlGrl6gYPM1+zKeXT5TLCpZlOYRIR2W6V/jWLQ==
X-Gm-Gg: AR+sD107c8gmakdd9ohMhw9VEz5W+DuoKmBcLOnZtHKs/wCYGKAZ8XBwC7ZXLmV9hb5
	uNWV80ONq2KVTusyoXpcO1jzhuuRc2BibZJ2vqppSLoS0Hala1qq044aXkhTU91EXQhz0hddApX
	6DJXdooADzRmqbw4Q5WKJUTWchnUxtDp30GwW32Dj5L0TwkOQQlqBziXQ5PieAZ9ja3BHQIsz3S
	r+tEtAohGKFumzC15jRFII1zrQ74Uw/6eDfzxwVnxv8MKjDR+imRQ8S28hVX4QXS+a4vMfk8l5/
	giYjxmODiwTIbrhPRtTbKNPuDzBlowyh0A8rTBog9cXGEGeTbh9pawjAYFi8JQmwJhfq+PiZh97
	1FXz9sNgOCa43mg4MiFCV3vViQ1KqXcqu/eTtgQVfCYYTowJOXbKnBPrBvpC6DtDoQK5cNzGkTG
	0=
X-Received: by 2002:a05:600c:a47:b0:499:726a:a017 with SMTP id 5b1f17b1804b1-499aa14a6ebmr196855725e9.1.1787232308998;
        Thu, 20 Aug 2026 06:25:08 -0700 (PDT)
X-Received: by 2002:a05:600c:a47:b0:499:726a:a017 with SMTP id 5b1f17b1804b1-499aa14a6ebmr196853915e9.1.1787232308364;
        Thu, 20 Aug 2026 06:25:08 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b212fc11sm30099185e9.1.2026.08.20.06.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 06:25:07 -0700 (PDT)
Message-ID: <840b8084-3ee8-457c-8717-f3c20cea45d6@redhat.com>
Date: Thu, 20 Aug 2026 15:25:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next, v3] net/mlx5: Use dma_wmb() for completion queue
 doorbell updates
To: lirongqing <lirongqing@baidu.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Boris Pismenny <borisp@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>, Kees Cook <kees@kernel.org>,
 Akiva Goldberger <agoldberger@nvidia.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260816035605.1873-1-lirongqing@baidu.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260816035605.1873-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/16/26 5:56 AM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> dma_*() barriers are specifically for ordering writes to DMA
> coherent memory that is accessible to both the CPU and DMA capable
> devices.
> 
> The dma_wmb() barrier is lighter than wmb() on some architectures
> because it only ensures ordering for DMA writes, not for all writes
> including MMIO accesses.
> 
> In the MLX5 driver, completion queue (CQ) doorbell records are
> allocated as DMA coherent memory via mlx5_dma_zalloc_coherent_node().
> The CQ update pattern is:
>   1. Update CQ space (device reads via DMA)
>   2. Update doorbell record (device reads via DMA)
>   3. Memory barrier
>   4. Enable more CQEs
> Since only DMA coherent memory accesses are involved (no MMIO accesses
> follow), we can safely use dma_wmb() instead of wmb().
> 
> This change improves performance slightly on architectures where
> dma_wmb() is lighter than wmb().
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.3,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

