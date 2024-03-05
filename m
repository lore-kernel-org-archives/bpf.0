Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154191272CB
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652788; cv=none; b=RxFHw+0c9KxGvaHJpt7C/peffCCTDGTpgBe93YsclV/2bWEmSt4oL4kqq2vFUDEpI4irRukqu/4UAzoQwquAYGlnJR1GqIJ7p6VomA80qCDGo8V47/NFYrBlewkV+Jvr80tovvGJgdss9irA4AUwhIQ52yn7kDonXEpJZPZyryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652788; c=relaxed/simple;
	bh=dyLpAemXt5pVNnHmghn6IPXPVYR1xCgqubCzLUx41cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJlb/icvvJqVsH28dQGDeYmHCWV/rWTB3fhh4Vw9jbj6O2DFqteRYnBZrAKeGjVTsSnfIuEuJv2J0pyBPsrOOtFKmmRsW5ELcBU5nqY8UH9z8ucXwfYFey7XbEHyekhYiY0XZeXdztyswlIWx3MNw4KzhLSmLfFkcMrZbs3jdrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RPHDQCFA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RPHDQCFA"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d153254b7so3854752f8f.0
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 07:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709652784; x=1710257584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8r7IHy7kVKfRTqD23CgO2t0WRZctdWLP4DagcY/UzEU=;
        b=RPHDQCFALmXiKAcFUgFxO5MndwZjJr5DgxKMSQdsUAJ/xKAo/xkEHyjXOFVrW3ljy7
         gsDFoxDXnc69kZUZE04fnDG3OVRB/Rpp/7D9Doa7aiDoJHLs9KfJsFmE3tW24D4l7IeU
         gtdt32MHgSF8Fi/bKkvd1h30GUkH2N3WjP2/AxNy1pyQxy9n9V5k0QZhD4pATMBTJpjV
         Nz6Uf2GNl7HSSg9NgGedMD+aTIx3pN03j5Cv00t1sovm9AKNnEOmkwDMHCiBUMzLp7Qq
         0mwFv/TQrNSSeQ2RvbOmigcZc7MPVbMmQ49Ypj2XcoKYJb7+mYYbPaM7HVczW9WPwqFk
         3Iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709652784; x=1710257584;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8r7IHy7kVKfRTqD23CgO2t0WRZctdWLP4DagcY/UzEU=;
        b=wAKFq7O1kbme8kCiX1N+PGASUOA45EUxbE4FF6BRzVtEvwirqzzXYVyA0uo/v2702u
         GRJisJDfXG6yn7fL2ksIzwTRfBikYdAYSFqw5K5XFJK2HuxeHptczPQKEwBesAhbNFa3
         qLEYI2GkZYMQyi2My6uOcLJOL8TNGu4mp/LGe5/bjSlaNBSEQj6lJLCuG5NEqXcpV1kz
         trCoUhyA+TiLFbgOk39DvZ9eM1iljTO1Ca/2zI153zTeyeO18NWwW0jJnsq8dPoOzcSj
         hV/zJPdaxuE7ma/RTppVDX42u9ZH0kyjZBJR+pJlJ+S45Q+ogDxxzmSD6Z3d//n4T8qu
         qJ9g==
X-Forwarded-Encrypted: i=1; AJvYcCUnBfvPfHKgQffgrYSVbyPv792qYs3R20TE37kyNiVr2IY2LpgDkrJ53zstQqJDkJvi1zR8yhHEFzVXQCgy1LvXa5kg
X-Gm-Message-State: AOJu0Yzy11det50XGSKBGSztInIGKfZgW7/ZrQhAk/mKE4nHWD+fe7SS
	jq4dFU3bYE0GzveulGO4C3eGqEhOsOq4PLSn65A5gzDP/LNgNvmsZeMFj6KKP18=
X-Google-Smtp-Source: AGHT+IEVNqjI7TrOIyxyC0zXS0GjDY1acqoeUroBUXxj1W59e4andupDbOlOfQsujmcheNGf/bEuNg==
X-Received: by 2002:adf:b209:0:b0:33e:4797:5fa7 with SMTP id u9-20020adfb209000000b0033e47975fa7mr1964612wra.42.1709652784359;
        Tue, 05 Mar 2024 07:33:04 -0800 (PST)
Received: from [192.168.1.70] ([84.102.31.43])
        by smtp.gmail.com with ESMTPSA id y10-20020adff14a000000b0033e1be7f3d8sm12894093wro.70.2024.03.05.07.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 07:33:03 -0800 (PST)
Message-ID: <f0a9524a-08cd-4ec2-89f8-4dff9dd3e09e@baylibre.com>
Date: Tue, 5 Mar 2024 16:33:01 +0100
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
 <3a5f3950-e47f-409a-b881-0c8545778b91@baylibre.com>
 <be16d069-062e-489d-b8e9-19ef3ef90029@lunn.ch>
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <be16d069-062e-489d-b8e9-19ef3ef90029@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/5/24 14:28, Andrew Lunn wrote:
> On Tue, Mar 05, 2024 at 11:46:00AM +0100, Julien Panis wrote:
>> On 3/1/24 17:38, Andrew Lunn wrote:
>>> On Fri, Mar 01, 2024 at 04:02:53PM +0100, Julien Panis wrote:
>>>> This patch adds XDP (eXpress Data Path) support to TI AM65 CPSW
>>>> Ethernet driver. The following features are implemented:
>>>> - NETDEV_XDP_ACT_BASIC (XDP_PASS, XDP_TX, XDP_DROP, XDP_ABORTED)
>>>> - NETDEV_XDP_ACT_REDIRECT (XDP_REDIRECT)
>>>> - NETDEV_XDP_ACT_NDO_XMIT (ndo_xdp_xmit callback)
>>>>
>>>> The page pool memory model is used to get better performance.
>>> Do you have any benchmark numbers? It should help with none XDP
>>> traffic as well. So maybe iperf numbers before and after?
>>>
>>> 	Andrew
>> Argh...Houston, we have a problem. I checked my v3, which is ready for
>> submission, with iperf3:
>> 1) Before = without page pool -> 500 MBits/sec
>> 2) After = with page pool -> 442 MBits/sec
>> -> ~ 10% worse with page pool here.
>>
>> Unless the difference is not due to page pool. Maybe there's something else
>> which is not good in my patch. I'm going to send the v3 which uses page pool,
>> hopefully someone will find out something suspicious. Meanwhile, I'll carry on
>> investigating: I'll check the results with my patch, by removing only the using of
>> page pool.
> You can also go the other way. First add page pool support. For the
> FEC, that improved its performance. Then add XDP, which i think
> decreased the performance a little. It is extra processing in the hot
> path, so a little loss is not unsurprising.
>
> What tends to be expensive with ARM is cache invalidation and
> flush. So make sure you have the lengths correct. You don't want to
> operate on more memory than necessary. No point flushing the full MTU
> for a 64 byte TCP ACK, etc.
>
>        Andrew

I changed back code step by step and could find what makes a significant
difference. Here are the main tests achieved (results in Mbits/sec):

1) Page pool without XDP code -> res = 442
Conclusion: No difference with or without XDP code.

2) From 1), page pool removed and replaced by previous memory model
based on dev_alloc_page() function -> res =418
Conclusion: Your advice was good, that's better with page pool. :)

3) From 2), am65_cpsw_alloc_skb() function removed and replaced by
netdev_alloc_skb_ip_align(), as used by the driver before -> res = 506
Conclusion: Here is where the loss comes from.
IOW, My am65_cpsw_alloc_skb() function is not good.

Initially, I mainly created this 'custom' am65_cpsw_alloc_skb() function
because I thought that none of XDP memory models could be used along
with netdev_alloc_skb_ip_align() function. Was I wrong ?
By creating this custom am65_cpsw_alloc_skb(), I also wanted to handle
the way headroom is reserved differently.

Julien

