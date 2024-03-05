Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7941C6AD
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635567; cv=none; b=ILetCqTtiTpuKWMc/jy3Sk4+mFbkyFYn0ZdqRtlK6z2/w29qWnXgX3MvcB/qAKEw/IlvPJRYIskMEVTHN/1WpuOH/DXIcGeU2fH0zWk2BJUko+kJTQh6p8Sbb7I26GuaH1hnvAHroKidssZGx+GqNI2yKT7/mm1+68w1rmzCfYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635567; c=relaxed/simple;
	bh=XklbFoUwOSii+y74bxc36aiADpTAj4ZlGh81v8WRHIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTs9ITIABZthauu1BY5kE+xgQ92i0up9hk+iZcWEBRagTZqOJ8Ziq5w9KZPQvITcvjo5qExBomsbpBPSIN4m59hq6014Jj3E8ov15lcbmpVNHi5j7dbZqkXrF43PavtEJVmCrbNsE80eX0veCEViHKYIr7sVlUdN7JEjA6i+dzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1TKr1Kug; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1TKr1Kug"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412eced6d1aso3226585e9.3
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 02:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709635563; x=1710240363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVA1JqDTMPvckuRaTHq5sqq6pnFxGrbQ8TF6seYnelo=;
        b=1TKr1KugBceesEMwMGGzcf/55Y5czeuKgOSW8hUF2A4z7TvXPZbUOYgeR1XgC1W/Xg
         fKqN5vLnGGhZQyCuRQJSNo5wDVwWgzN+wl/3+IgVxcE/a9NgkVomCTb26LqDu5keSi2p
         ADFNs7kMiKQom8xrncsefJ69WNlttJumkg5B3ok8fALTscJr7sHXGdRQIWawG8CKkn8v
         8NBwMQPflifIgKMGDtNLbRnndmhwfDKlJ5sP7q99z8un65B8i2ph7TBDP4NDHH1zoqVO
         hew7XKZ4Y74A56I0i3IaOqyfe6sQq/8lYaTAN1cPZ9s5xelmmU2PJgnuMZtXFOwWpdM3
         gOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709635563; x=1710240363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVA1JqDTMPvckuRaTHq5sqq6pnFxGrbQ8TF6seYnelo=;
        b=Qdz/2qF0VDsPq7Y9u5H3SBF8rns0BxjPM/QlPoe6bsG+78WaMFVPku6wEzCiASjvjw
         v9o6Wciv5gORX99QFNBYaHfFDYlsbNuAysHF7VLLp+J21wLWVeYJ4YNb3YE9awXakS3p
         Kj+K6bGz8nj9nXjfEyLsIFRkPscrzGBhpYhUSMKIlIUxukjMUCwyI8yvzxeiCFjjE2MB
         Eq52nMeRbur1rC+AiSaq0DtGxsexovh55lrdLfMUBdlnyY9qnGjVyUYxFCssOUVXxY5J
         ekljIcSzT/I146rUSkSagXAlhER1qViE5sf0FdqCwSKRNin7s40bPKlQ3kGIqecjLfMW
         EVVA==
X-Forwarded-Encrypted: i=1; AJvYcCUr0/pMIuKhc0dPIcHFvMYj4VU+Whl3HwEPCtjkFChbBazXm73dsxct7FuFdjhB/DQm+drSdcD97ocRijybVZGxPlp/
X-Gm-Message-State: AOJu0YxEXwjrgxDFZdn/w2Wg92tVfuKX0e33YuI42Ycq2GagckSZY99b
	7tzQdAKuFDhJDX4o+T3WtOodlPB/Kgs4pgvgqM6poxHXuC3oJlEdDXgmfCcfSas=
X-Google-Smtp-Source: AGHT+IE/L4A6bnauZ4LpcW6naeeYuRNA8WEWJrlnt645s9ZaWVjgn/tE11DGJ0F5XhXa7k+kx2lEzw==
X-Received: by 2002:a05:6000:1249:b0:33d:2226:a28b with SMTP id j9-20020a056000124900b0033d2226a28bmr7827513wrx.37.1709635563236;
        Tue, 05 Mar 2024 02:46:03 -0800 (PST)
Received: from [192.168.1.70] ([84.102.31.43])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033e052be14fsm14577187wrw.98.2024.03.05.02.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 02:46:02 -0800 (PST)
Message-ID: <3a5f3950-e47f-409a-b881-0c8545778b91@baylibre.com>
Date: Tue, 5 Mar 2024 11:46:00 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] net: ethernet: ti: am65-cpsw: Add minimal XDP
 support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20240223-am65-cpsw-xdp-basic-v2-0-01c6caacabb6@baylibre.com>
 <20240223-am65-cpsw-xdp-basic-v2-2-01c6caacabb6@baylibre.com>
 <356f4dd4-eb0e-49fa-a9eb-4dffbe5c7e7c@lunn.ch>
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <356f4dd4-eb0e-49fa-a9eb-4dffbe5c7e7c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/24 17:38, Andrew Lunn wrote:
> On Fri, Mar 01, 2024 at 04:02:53PM +0100, Julien Panis wrote:
>> This patch adds XDP (eXpress Data Path) support to TI AM65 CPSW
>> Ethernet driver. The following features are implemented:
>> - NETDEV_XDP_ACT_BASIC (XDP_PASS, XDP_TX, XDP_DROP, XDP_ABORTED)
>> - NETDEV_XDP_ACT_REDIRECT (XDP_REDIRECT)
>> - NETDEV_XDP_ACT_NDO_XMIT (ndo_xdp_xmit callback)
>>
>> The page pool memory model is used to get better performance.
> Do you have any benchmark numbers? It should help with none XDP
> traffic as well. So maybe iperf numbers before and after?
>
> 	Andrew

Argh...Houston, we have a problem. I checked my v3, which is ready for
submission, with iperf3:
1) Before = without page pool -> 500 MBits/sec
2) After = with page pool -> 442 MBits/sec
-> ~ 10% worse with page pool here.

Unless the difference is not due to page pool. Maybe there's something else
which is not good in my patch. I'm going to send the v3 which uses page pool,
hopefully someone will find out something suspicious. Meanwhile, I'll carry on
investigating: I'll check the results with my patch, by removing only the using of
page pool.

Julien



