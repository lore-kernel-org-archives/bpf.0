Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30FF401A2A
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164456; cv=none; b=eQkR1Nxw6kSw1UtWF1SeE0iAWp2sClt+k2ALeNNHMIWjJaAz5d5HZ7iKpS90TBIxrPQrnaVfnmoo5EXOkSPUpdINMNVVxdZfeyOn0j0a/zHb+B4D9GqdCZUIjYG3FOJxe93htbdMiz46d3AOzpsILUuw07HhiMou/fmUSRViRKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164456; c=relaxed/simple;
	bh=REMXR87aQf+FeEBUtnHfLNXYS9O6phyTNdtm6aANwSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dc3J8Z0jXodXNmkRTXm6aGWmSOSvNxBvj9WbI3l3BZR4mr1hL/95H0wNyiJ0HyC7oU1ZmZyKLuBs12d5P/sAso/hI10aMaBi/uY2aWCxG2dPee5SvcatplXZye50k01cdtIeNrGzINZITSoZ6w38p1URqk0gu+yQ/fty1rABbos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AstMe03e; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eahzJnwx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AstMe03e";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eahzJnwx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778164453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YfqPv4kAzqZ0NRYAwjXSQgvfmomJWQGhAYSphsjCSpg=;
	b=AstMe03e8JTl0GFguTD/Xms+rIswXvyoYbDTvuN+q2esLDWTVmovbKPz7aEz0gku3T7PNe
	yWm55irlT2Aq41mrOQ42Tbc7F7/4H+SIIAPvi72Pk52UcP5OJ6YIRZouKlGRPGvPTDsydr
	+r0GIzS9fxiH8wcWXtF8DrTvQSnFEuI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-nYrCeRdvN7uzX5o7yubpbQ-1; Thu, 07 May 2026 10:34:11 -0400
X-MC-Unique: nYrCeRdvN7uzX5o7yubpbQ-1
X-Mimecast-MFC-AGG-ID: nYrCeRdvN7uzX5o7yubpbQ_1778164450
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5a87c6e101aso1150776e87.1
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 07:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778164450; x=1778769250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfqPv4kAzqZ0NRYAwjXSQgvfmomJWQGhAYSphsjCSpg=;
        b=eahzJnwx6U4GSR2lErHWzM8JmrbIvVRjds9r6QBA3nzOUZrSouWzsZpK4kloZYmZMq
         jOVIwJFCtL97QF0JrBtuoKX/sQX114lHAfSo5dYPcwZkQZOfETAZ9BWTf408KhV2goKJ
         7YJ6Y0l9TwLpFUtkX8YgwHeQlbJ7c21R8LI6WPH5StR2VJ0jJUBRGyiRDv9gTdjxGVYU
         +PUEa5SAqgpE+FzUADOOmapWbg/3QAdraaLIHeVwzuG4oaincaAFS4EijG67LIeAHJbw
         xTs8nbhVn7yzepeqmj8oUdGZsp6Ev+J4i/evi2IYR1fuAE0DEOFjjmymTi3TUxE6COj8
         NerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778164450; x=1778769250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfqPv4kAzqZ0NRYAwjXSQgvfmomJWQGhAYSphsjCSpg=;
        b=PzpFnCZuoF9MzADL7LO9DLRjF2QgLHjMvn80NzoCN+wvBvkL02VctuoI6dScEb5run
         goELJu54MgJbZnOSFoGFYp1LCwSJPVLPNeV4dFcZbCPEcU2lUGqlkzjlRH8U0bnok88V
         eYuF8ZczC0FAFRhuU6e39u1pjqQIapd1NRlEVvwkLMTKc1lMJqKSe7jZoVwSLKwparjB
         jz3JkoolM+d3e5Dph2nwQqx6vcAA1yd55eMGB9WR78JMI9M/0JNkHBt6htrPSOXomfIk
         5kQmveMQu4oiXeGTd++KK+CsMJsny2a2+y7aXRqVseuktMkG5EoPOH2TzQFKAH9hrucc
         jg6w==
X-Forwarded-Encrypted: i=1; AFNElJ/Aqz045k+0xquA/IAW3O3KeE/+9RwZJo1wZNFEFi5To4QUFiumRaS9HSHVX9yRSOvT2vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaqJplOpP8IlpHxrJbb5ih7Aem9HTXYYC/t5sOulXoKurILKQb
	iZmvUg0Y7/sgDXv5qQGBLS8CAeF+5owgrSuojaUAd9GHiVLgRCOPbeiJQZsKzCWqHv0LCN0C2OE
	zbnZ8RMX4L4PA+rAxgdBeYd02VrQuY2l5zl9YjtJFksTwti6GweeFQw==
X-Gm-Gg: AeBDieuv1O1lzbJA9SzmfYmgNMqPE5M223OWo/pcVNa5Fwt4U+u+Qk8YVLr4ar7/WYh
	atKNrj5TfkJ6R59/CE8ExCOl3vaKS+udXdh1WclbqHAI9uJilD3eIyHKlItIVjpzWHxNnWO/YD2
	7FkuycUkiVuFqn2grs+fcmXqOuIqPQAZ4fcZlIQnX12gE1Caempl9seiquDzOMcpuH4ODZbMmYR
	Bl7LTHy7erRBPX2nTtt3QLz0TVnXbR1I6jl7Ni1viEird6G0/oRKSdV2LJ1IBOrxuEQnfb3/Fif
	u/N9TLM4Y0fZiV0lr/ogvNDsABIKa4Wv/Bo/agNizD8WbsbCrKIOuxr4mv987AFSoy3P+56PMvs
	hckQO6jPkBKL4qQzP79ks/KYZmVXL+DDszUOPNNlzSA0eUP6MpLq17r7Q8HmQBmV3OQ==
X-Received: by 2002:a05:6512:124a:b0:5a8:5eda:a0c9 with SMTP id 2adb3069b0e04-5a899bcd989mr1036582e87.18.1778164450068;
        Thu, 07 May 2026 07:34:10 -0700 (PDT)
X-Received: by 2002:a05:6512:124a:b0:5a8:5eda:a0c9 with SMTP id 2adb3069b0e04-5a899bcd989mr1036561e87.18.1778164449286;
        Thu, 07 May 2026 07:34:09 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a886d248a5sm1671466e87.56.2026.05.07.07.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 07:34:08 -0700 (PDT)
Message-ID: <8f2f7f2e-6aa2-4e5b-b52d-0025b2525579@redhat.com>
Date: Thu, 7 May 2026 16:34:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: Simon Schippers <simon@schippers-hamm.de>, hawk@kernel.org,
 netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260505132159.241305-1-hawk@kernel.org>
 <20260505132159.241305-4-hawk@kernel.org>
 <ee275aa6-af27-4dac-9afa-da88abde312b@schippers-hamm.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ee275aa6-af27-4dac-9afa-da88abde312b@schippers-hamm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/7/26 8:54 AM, Simon Schippers wrote:
> On 5/5/26 15:21, hawk@kernel.org wrote:
>> @@ -928,9 +968,13 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>  			}
>>  		} else {
>>  			/* ndo_start_xmit */
>> -			struct sk_buff *skb = ptr;
>> +			bool bql_charged = veth_ptr_is_bql(ptr);
>> +			struct sk_buff *skb = veth_ptr_to_skb(ptr);
>>  
>>  			stats->xdp_bytes += skb->len;
>> +			if (peer_txq && bql_charged)
>> +				netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_UNIT);
> 
> In the discussion with Jonas [1], I left a comment explaining why I think
> this doesn’t work.
> 
> I still think first that adding an option to modify the hard-coded
> VETH_RING_SIZE is the way to go.
> 
> Thanks!
> 
> [1] Link: https://lore.kernel.org/netdev/e8cdba04-aa9a-45c6-9807-8274b62920df@tu-dortmund.de/
In the above discussion a 20% regression is reported, which IMHO can't
be ignored. Still the tput figures in the data are extremely low,
something is possibly off?!? I would expect a few Mpps with pktgen on
top of veth, while the reported data is ~20-30Kpps.

/P

