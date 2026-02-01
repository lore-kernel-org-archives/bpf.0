Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B093EBF35
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 22:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769983774; cv=none; b=YED2KEgcUdmhnQPDiemtRjKAZi+M68bXFFhm+xYw+AaUloOf8JE1q4dN9F6Fm9YIcmVxRs3kA+leH7CszkhvryS1muHjXPZVdlusL01uJtueWk+0zUxWjRaXbRSvqlwEQbHbQtEm53BqZWo12uV8lA8jLyDOqclDHuxVCtjXmBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769983774; c=relaxed/simple;
	bh=JM15UKXeJzdijzrGgJ2NdmQsbx2yOp3QX/8hr3ooJnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOhiKCm2UA8M9l+ZJ6l391RPb+JX7XEqeRk8Ed6Qlyf+MV3jCs0l3QpNEtNPeOl19IHJrB/dbXxXG3LzepZZ82c4/kY6x+nGOL58TQ0B5HK/s+hkq2QC6QOqjnH/N31rscQ4sAraigHFJXg4axRL4dsAwu3hkksf1BexCYFt/Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=due/wvn7; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="due/wvn7"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c708702dfso1972070a91.1
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 14:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1769983772; x=1770588572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSollAbkysYIn6q3WBkPyjvDyYQliySWNckXJuEYpIs=;
        b=due/wvn7jkrcJYb4gMKEuXtMPclw+Z3ntYt+N/sRQUPdo/fc4iX67IeCOc/Sl/AHlF
         Igpkx4ulYYmd2DsP7Y0sTQbk7lVye0o/lQonANspNBtmEjg2Ui41FBWJt28xa9pzoRxx
         6Gc0GL1XwuXvU1VBAfUYXdvEKeG9j8jFokMEImxds1uXsXKXk3DDq0ewR36otJc1QpCz
         YMX2BeE0l8XEeW6l8KVr0n+250zsNZmLPia3+yUrwwvRGD+2VpcWvA9Pkdki/mZf5+OR
         0lonD+S4tlYW3s1MbqYB2rqzNqeNnIYwR7AyQS5L4ubNNPZLTntc3FzLPmA3oE4RzeLQ
         BJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769983772; x=1770588572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSollAbkysYIn6q3WBkPyjvDyYQliySWNckXJuEYpIs=;
        b=OX36nF5vi/FsqhWAMDLV7GazuSY0JsPuQmoyhD3JlAVFdvQWReqJkCa9e4WRSKHpEV
         l351I/4PoChTbXDw2tbJ3aCvoqQNvdpTwihOF9CJe2kPL/xGssYC8VTfxcS2cc/7E/h4
         8sUji3H4pgtbqpI7162qUM1ur6N2py8RfZwfAKBP+VW1tdvY4A7ExYHI5ozQQSm6/N3u
         C1VpZwXwhFH36Z5iaHJ7fYZrD/0eeCu048nzsKXMk6mC6Rq0DOFE2rkneRm6kEvApJYy
         oI9wrPkyerh5X89CzSX+yE/kpxAPKh+DjPav4c2NUguJauuz/B3XbqgVOFGezbVuzEX4
         jR8A==
X-Forwarded-Encrypted: i=1; AJvYcCVA8bUq0aHcegAbZjOuA2CHIllu5jDXFrhrYj2o1++In1tvfr1iuvDNBEosMZVP441+lF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTjImHRjNLgLbyQ2gVsdztrZWX3+PDnKbLT5C7MUGEICjfbc+W
	KA8XTUG4z3To8Y6RQH0NqbBNPB85eu+eQu0Aq7K2Z8cfQsAOmzlCZoTIf0RJWtLT8Ck=
X-Gm-Gg: AZuq6aLG5KAlIGKmLehwf6WtpLTKLtKgasd7TdZqe4VbJalf1zpfjx4qlsON81Fc+RK
	eaxHC98QX2fV4IeI0eYPqXWChpFr0/nEU5WZV6wYUBjkl6ygJXgnZ2U5vVXbK4tbpYP4rnoU18Q
	PZSVllxZPeR3qWL2edKg0eZ9q79VvfEZeSNICoDnHnTAwRaafMrmeiLlEeuuRHB3ZeR6UDYdgsR
	aGYBUJGNuaeJ9LYaHH1a9uMpiP0+1TfxnsZSSDBAamS7yXEVcrvSFZ8IVT3N2EI824lZFLZE8bF
	ocAhj+YwlFybNFPdtWidIG4/tTkJQFx04Rtptf5JVw/ZE8v15uYn1WWdN5kKVv3IACSpGmYMzBR
	CaYPWf4g8tPINVKwxrTpchqQiZ54lXAk9HqdMzf/JemzNTjGVqxR4+HWud0wUyzKwZd55C+GyhI
	576jSCVhJHpdYuXYSd2hVEOH2wclcT1gr9if1v/OWMiiGnshl/hz3AvXlhvKbPkZ6vcBWi/x6hY
	KWbkEo2dk5juyg6iw==
X-Received: by 2002:a17:90b:3949:b0:353:2e1:95f6 with SMTP id 98e67ed59e1d1-3543b4021admr9000467a91.32.1769983772225;
        Sun, 01 Feb 2026 14:09:32 -0800 (PST)
Received: from [192.168.100.174] (p94025-ipoefx.ipoe.ocn.ne.jp. [153.246.129.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2f02aasm13536653a91.7.2026.02.01.14.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 14:09:31 -0800 (PST)
Message-ID: <5f8a0b59-0ca8-43bd-8d28-99d306ff5bbf@davidwei.uk>
Date: Mon, 2 Feb 2026 07:09:25 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 06/16] net: Proxy net_mp_{open,close}_rxq for
 leased queues
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260129222830.439687-1-daniel@iogearbox.net>
 <20260129222830.439687-7-daniel@iogearbox.net>
 <20260131160237.07789674@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260131160237.07789674@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-01 09:02, Jakub Kicinski wrote:
> On Thu, 29 Jan 2026 23:28:20 +0100 Daniel Borkmann wrote:
>> @@ -191,24 +214,15 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(netdev_rx_queue_restart, "NETDEV_INTERNAL");
>>   
>> -int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>> -		    const struct pp_memory_provider_params *p,
>> -		    struct netlink_ext_ack *extack)
>> +static int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>> +			     const struct pp_memory_provider_params *p,
>> +			     struct netlink_ext_ack *extack)
>>   {
>>   	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
>>   	struct netdev_queue_config qcfg[2];
>>   	struct netdev_rx_queue *rxq;
>>   	int ret;
>>   
>> -	if (!netdev_need_ops_lock(dev))
>> -		return -EOPNOTSUPP;
>> -
>> -	if (rxq_idx >= dev->real_num_rx_queues) {
>> -		NL_SET_ERR_MSG(extack, "rx queue index out of range");
>> -		return -ERANGE;
>> -	}
>> -	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
>> -
> 
>> +int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>> +		    const struct pp_memory_provider_params *p,
>> +		    struct netlink_ext_ack *extack)
>> +{
>> +	struct net_device *orig_dev = dev;
>> +	int ret;
>> +
>> +	if (!netdev_need_ops_lock(dev))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (rxq_idx >= dev->real_num_rx_queues) {
>> +		NL_SET_ERR_MSG(extack, "rx queue index out of range");
>> +		return -ERANGE;
>> +	}
>> +
> 
> nit: delete this empty line please, like it was in the original code.

Yes.

> 
>> +	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
>> +
>> +	if (!netif_get_rx_queue_lease_locked(&dev, &rxq_idx)) {
>> +		NL_SET_ERR_MSG(extack, "rx queue leased to a virtual netdev");
>> +		return -EBUSY;
>> +	}
>> +	if (!dev->dev.parent) {
>> +		NL_SET_ERR_MSG(extack, "rx queue belongs to a virtual netdev");
>> +		ret = -EOPNOTSUPP;
>> +		goto out;
>> +	}
>> +
>> +	ret = __net_mp_open_rxq(dev, rxq_idx, p, extack);
>> +out:
>> +	netif_put_rx_queue_lease_locked(orig_dev, dev);
>> +	return ret;
> 
> Please:
> 
> 	if (!netif_queue_is_a_lease())
> 		return __net_mp_open_rxq(dev, rxq_idx, p, extack);
> 
> 	..explicit code that deals with the lease, no conditional locking
> 	...
> 	ret = __net_mp_open_rxq($dev, $rxq_idx, p, extack);
> 	...

Understood.

> 
> 
>> -	rxq = __netif_get_rx_queue(dev, ifq_idx);
>> +	rxq = __netif_get_rx_queue(dev, rxq_idx);
> 
> Indeed good to cleanup the ifq_idx naming that sneaked in, but IDK if
> this belongs in this commit :S

It really annoyed me haha. I'll remove this from this series and send it
as a follow up.
