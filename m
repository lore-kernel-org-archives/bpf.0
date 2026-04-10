Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B76389101
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806997; cv=none; b=bnGGVatovOUKJ3pYsv/qi50CQN9PJgQbQkvvE1ygrW/TBwMjndRra1w55zXRTkYEUKec3x5pZW36wPuap+NYFLUY/JVdLOep+whbztE3qVMsHO49YwxqHLmb0niy15G2gjRQNaKJ1lQIprGc30P6hM+PHnrsu2n4ihoeoEtmBrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806997; c=relaxed/simple;
	bh=yC08SBMmv1GBfoPepoWD7l1EzWAvJFNrcYCSx/kIrew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iph1yIU7TTM8tDJgkEbBrnzLrvVcroY9M8pchLWSOIrb/DA/QY4HIKx5tek3LgMqCg+UTWbO87DwF8nV2tGrGKmFZqyn2Kj2KueuD6Hw9k+FGtgI8ZhYlZM7+4/88uid8H6VXaTxcmRpM92SkEDdjDFrAtTczR9gd7kdiXaPQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HqTfMdby; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="HqTfMdby"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso18883375e9.3
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 00:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1775806994; x=1776411794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9BHd5rH9baSCcHucQaINuf+AYXdmrmHiREhfjm+We78=;
        b=HqTfMdbyxpmNdYUDBUkjMlvi3Gq0Vng1yxiLWw5oeMhoNi4kUW3h4H6sP2y8Y5pa6B
         OBU7lEAVYJgW1BeaPDKpm0ZBH69GE74BOc4IB7AXhMotjPQWQ1U/ngduUzRLiyZN3a+M
         vJyRdP4zGnUWupmWgaM9LbS6/NBiPZwFTyRZPLjG+VjfkXUHABu2s/cE8abiIybskoPp
         8euv6CWSgA18QOKkodGHCU0j2wzuMfNXTSN+qQSPOxg4GiYG1NWtdFDtQ8/iM2VYZyhF
         /BeneAOLSVLcEA+KWwuZl5ZiCwWNpMrBBi07P5CoZ++FeArThDEOm3Oj5gSOT231DRp9
         KfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775806994; x=1776411794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BHd5rH9baSCcHucQaINuf+AYXdmrmHiREhfjm+We78=;
        b=Qwh2SyNV07Ot4v9hlkoTDxy9dp+S69pisqH8Ml+67EW0AS0b0sI7uYUAx2NiSbCkjY
         X7OJlqZqXvY+zAFYXHaMKJ2MWcuS8sezU31XZw1wMTFC0uC7s3xFu6O5tlx6KgoW/ct3
         bz8uHmSFK6T5G6LFyPKYv1mmuENd3WZcJR6xsjGccg3Gpd14y6QHfX4nAaKF2t58NFkG
         ZFIe3rkokLAK/wav93bVU55FSi9aeuYlZPpSOAqxC62C19n3QGhy9h7zd9pPDCX5lFmo
         WrGIPoA1g4Eodf6hEBiJOccHoSmFoR6oE/iwtzv87YrjIdm+AVRUp2rPJ5x6MjnHT5y9
         9+3Q==
X-Gm-Message-State: AOJu0Yz9AoHKgzq1C8SKlRDC0Y3/Gmghcd1fWh819D7f6S9eYCzcfDKV
	DJUnB5LC9jmxrHqvBJAuC59KAv5VrcEKLfYMVt4vciv7eJvZ1O7g4b/vpMWcifNyjd9NFFEPC16
	Su4KF
X-Gm-Gg: AeBDievfCutnCi71fESqOWgpzGjrpI3QDmJEWSX3UnuleKxEfhGAlCYZ0W5bMKZfp3N
	t+EgTdZR8FGmdEHOmiYmzZteoyzMBUU11xt1+c7qB/LGchtYFh14HdA1rzJG66Q1iwZ/Vu/qF2u
	N1BJ6Md9k8fWTFXQNxo5Kb6Gpn2H5suCygFYuZdUWDGezT/GpyMDnmm0uUM8MmDhOxgp/nkmBLL
	sN23C1EgKLm9YDA3s+Q02gME1LYgcxz8v3uvoIbgVunBfvhCY1zJ025sGHV8DGZsBFRqnJQXvkZ
	cMxvoWh0/nH5oqiroNzFwR3dkd4+xrmkx4RaBLBOHn21Gk2IL1XChgzxL+lVINwRzNQTrvq937q
	DBZjXlkChwe2TQca3iZgSfNyI27pF9YOJUE/qq5mgKZ7na8B1YY15l89MdN33SRSefdW5GsQTiO
	jBfEMi8lSOmjrzmJo1mXHrzsBiVhU6icYhTDf7Zu024bUzgHrRWchDX3I=
X-Received: by 2002:a05:600c:a11b:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-488d687c06bmr18264485e9.25.1775806994113;
        Fri, 10 Apr 2026 00:43:14 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b46ffsm17630445e9.6.2026.04.10.00.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 00:43:13 -0700 (PDT)
Message-ID: <a3dac5ce-250b-4d13-ade1-8036b454e21f@blackwall.org>
Date: Fri, 10 Apr 2026 10:43:12 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] netkit: Don't emit scrub attribute for single
 device mode
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, dw@davidwei.uk, pabeni@redhat.com
References: <20260410072334.548232-1-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260410072334.548232-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/26 10:23, Daniel Borkmann wrote:
> When userspace reads a single mode netkit device via RTM_GETLINK,
> it receives IFLA_NETKIT_SCRUB=NETKIT_SCRUB_DEFAULT attribute from
> netkit_fill_info(). If that attribute is echoed back to recreate
> the device, the seen_scrub presence check in netkit_new_link()
> causes creation to fail with -EOPNOTSUPP. Since it has no meaning
> for single devices at this point, just don't dump it.
> 
> Fixes: 481038960538 ("netkit: Add single device mode for netkit")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  drivers/net/netkit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 5619209329d5..7b56a7ad7a49 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -1214,7 +1214,8 @@ static int netkit_fill_info(struct sk_buff *skb, const struct net_device *dev)
>  		return -EMSGSIZE;
>  	if (nla_put_u32(skb, IFLA_NETKIT_MODE, nk->mode))
>  		return -EMSGSIZE;
> -	if (nla_put_u32(skb, IFLA_NETKIT_SCRUB, nk->scrub))
> +	if (nk->pair == NETKIT_DEVICE_PAIR &&
> +	    nla_put_u32(skb, IFLA_NETKIT_SCRUB, nk->scrub))
>  		return -EMSGSIZE;
>  	if (nla_put_u16(skb, IFLA_NETKIT_HEADROOM, dev->needed_headroom))
>  		return -EMSGSIZE;

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

