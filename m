Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35A64C635
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569016; cv=none; b=duyLkB5E05BF3bz+D5s7FD/pTQFVY7gxj6fIxDjQA8CMq9hNlShIFbRXSLzK48jRA22aIdOJe1kcCldmPZbz0VZbIOLbLMNz2NnLy9RpQ8MVigH6eaC7vOsh9m+vC/PkJ6Q599V1fKUTSs42BgRpOHwhqpobX36lmZ6/bvcoKtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569016; c=relaxed/simple;
	bh=4qX90gAaeAFrZRINJudmZ0QqdDhJAmm6o0qc1B/GWAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=takYY2XUKsFJHgbXnra7csOTQhFeSwIJP8/kyDYoGrG3efGijjJOxS4bi1AVaifCDuQTcuz5I4kxAgQkrvUsHcJnZs1d1dRSJhamGq+IewcSIfBHVu7CG/5E/p/IBw3dabHMHjnEhR1Cyw/eUYQUSmDzqoxO80L7n6Psh1zyKqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MoTW53kM; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MoTW53kM"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5131c48055cso4612838e87.1
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 08:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709569012; x=1710173812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CdaQvHwf+ypTWs9CggIGE65EMaPW1/VFzdPOqyKDsys=;
        b=MoTW53kMZVcrVCLu/YQstYE4WEbBX3gmujRjc8U3j437q9pstrWz8W/TjdzN4qtLsm
         sc7RUTWf+NWTZR+QZfrL7wWAqhXgR/TBQJ9gmJyZ/dn0rPImZ6YOETetzviUh+pdQqxd
         fvN5Cpv6JbD8wFM3yS8bBqCygF0daj5nMvvhuVdDSq8nmqlTgF97fgFO2xB8MAx92bBy
         IAn/RIAJrPDRfkato24SdHlnGBdG61+fIcxwGbcbGSZMTeZ40SWTp6p2LhlRlzbP0KQZ
         G7ADPSkf8BEJVy30z+TpxSWf/GGfWaksNY3kNWyzGJlm2tOgeRWDau9WoRm9k3YZ/dg5
         Kqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709569012; x=1710173812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdaQvHwf+ypTWs9CggIGE65EMaPW1/VFzdPOqyKDsys=;
        b=Zg79ErPL+OxtHe0sPXoC66bNlh4ayfyBKRCnwEQgC/WIn0fJo70oSKDDizkUiGzN6j
         Ox9iFeNVUdclnd3tiS/yD4QSbS27WdQG9s/W8zF/pKc/MitU6xp+3Vc8Sc95bTEdiJ+J
         xp/II7tyB3STZ9FeVgAAab3EuMWtAP0L9MG456UM154vN+/c9BZtxSwbKeZfauGSS3PX
         sYdEmtoDMlGpPfMEZx6mgPxkKJN8hfPy9VQcRnmIp02uDgDziNwrCXlxqyt1UpZMheW1
         qNfZVCRtz2Gkeg8kXDza9z/0Of9enC8e2659NjCInlu78lMSRMT25dLrasKLNYHybw7J
         zNWA==
X-Forwarded-Encrypted: i=1; AJvYcCVIi4O8Q3WOtppiFFtG+B/nrQWmLc8nZZfH8ufWHZ4JDgJ/k1uvJ3sMM8PG84q6DzXO/MmmCERHNpJNXlfTNnaNXOyJ
X-Gm-Message-State: AOJu0Ywe6n+hGFyl7Ey5UQgwSNlJC6o163Mzmf6+evn6kjsI0b4tD0aT
	7DnAszFbaz4Eb1iHwNzfVbbHupoDSXsstV4jCBwHmSSAoH38+KO5jPc3gYoVBrM=
X-Google-Smtp-Source: AGHT+IHyM3uVBBXYWUwq/rKQH24A4FuocxVtTgvm3M0iSLCuJw6g5bXx5w3HG6HcSOEzQFYA4xHIZQ==
X-Received: by 2002:a05:6512:251:b0:512:d877:df6f with SMTP id b17-20020a056512025100b00512d877df6fmr5958110lfo.2.1709569011686;
        Mon, 04 Mar 2024 08:16:51 -0800 (PST)
Received: from [192.168.1.70] ([84.102.31.43])
        by smtp.gmail.com with ESMTPSA id i27-20020a170906265b00b00a441c8c56d0sm5000056ejc.218.2024.03.04.08.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 08:16:51 -0800 (PST)
Message-ID: <52952362-dea8-40ec-a0f3-2bdbe26cb83f@baylibre.com>
Date: Mon, 4 Mar 2024 17:16:48 +0100
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

OK, I will add benchmark numbers in the next version.

I will also fix a potential issue with TX buffer type, which is not properly
handled in this v2. It should be set for each buffer, I think (instead of just
being set for the tx channel before initiating xmit).

Julien

