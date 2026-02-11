Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33847352C39
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770799615; cv=none; b=ENmiuc8P67Xm+VWGL1PERE/HS+hc+SxMO98RHL93YdIcIOSmdRCIUEWxy4B6ml8XFIgSz64bT2Q6RJYEnaMgQ+eCJzQLSnLn/lxGcQpP+3B+WTldNOKJ1Sxv6s8sakFtDEYPpEQOdgDykaj3TPzYi/HAuELXX9kENIX9xd3nLiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770799615; c=relaxed/simple;
	bh=+6vukVA0/H10G5i+xywqgG4wJ1OTLqt6f510aloB/C4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a2j6dloSxJRON1Ga8tP1jertE4vJ/LsUaVmDkjGlWAZ6bwxFSN2r51Awn2RupDoiGMZbEyAI+GmCfOpmHKGwe60gU42niuA+AlcTW5jJiBUSajnRq2wIyzHT6WHkTcyHhIvPhRwWHcTlAsEmiXirtOt0f4PwSpQvJJ1WOlckHzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CC5aTaJW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dC13Ilnt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CC5aTaJW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dC13Ilnt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770799612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2NUfxY3dgOQc6Up8CPv860MldCejLy3p2EwnH2qBy8=;
	b=CC5aTaJW9cuDyF0YrxfDfYMy+Rhlj7jXNnVoigelOF4J5x0Ez+A/UeEK18woIroKHcCsyT
	eXnG723BXdR68/6jwFFlP1KB5ZOcE9dJ/4OsBY5s9OeHeU5pUu5/COEXqBH3lKGHqPviAw
	mfAlqAG4NBmz60BVGX+kQgwOgiSaE2Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-BulL_M-1OS6AB_bwAIU-ng-1; Wed, 11 Feb 2026 03:46:51 -0500
X-MC-Unique: BulL_M-1OS6AB_bwAIU-ng-1
X-Mimecast-MFC-AGG-ID: BulL_M-1OS6AB_bwAIU-ng_1770799610
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-437159d3ff2so2351854f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 00:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770799610; x=1771404410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z2NUfxY3dgOQc6Up8CPv860MldCejLy3p2EwnH2qBy8=;
        b=dC13Ilnt8g763AzwB7o6onZdzHwNh5j//lrgNQ4MqU90G8nooxIj5TimZkkoJCoW1a
         AVpfbN9lJAIG2imlxH04+lyr7cPztW9flzJaI7qKt6Z7kLRGyccDEU7ExnAlcpJnWtv5
         bcevmQ1Uz+oIGmHmTQ+FIZ1Hn2j07XUIiTyW1NOnNtfYmGM+L9Ak1AnZaDf7lre13B4G
         ne18ZiaNgLp97azNIpDJFQrZXL4vTzr/GhainO8SfMO5ODzDLxNLY+Q4bMPz3b9GIhW8
         ZWq358GyWcgfjo6VJDeFw3pJGF5pfKmeNJyIKra9o47q16wwpo9R1EtIydLo8a2gGPo7
         Qbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770799610; x=1771404410;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2NUfxY3dgOQc6Up8CPv860MldCejLy3p2EwnH2qBy8=;
        b=THuxXpmuhPJ8v2diuCMWVW0ejalb7y8CeOjVeg94EBvINQ1YXqdlNNIl3T3TgZe+gC
         UESVyp1i493pdxogPxELY77O/sRRCZk/Ym/uqMnaYC3PElmYJ6iLSEVH1gR3+3lttlCu
         8ygXf+YUlpaowiNOn2HwcQb0FnfI19UhuvTHaTYf8Fo2+2fDYoyIzSh0FMh5Gl1fk7/E
         Lbxm5SAJAccp0wNjMAEOV3cnBwQC9arc6qfzwUCiGcR/4iCqxeCNL0dvPYwZQf9fV7yI
         qDsUz2pTKnJk1JF1TdSEI9k3G9F9RIMsO8e6bsGFrMeZubjMPAM+SxMCKyi8o6L3P6IB
         FoaA==
X-Gm-Message-State: AOJu0YxUksipskl5n17t33xsdmuKGK2/3j7YaT3wlDTdpHD5guvvfwD+
	Vj8ahHfAAyLMiCsxfmglIyXle378Hy6LL7oDqOFfGQ0Kb99qtVYJPvAGoNv1FvQMRsadEEBGBUT
	oNii26GVvte5fdN5gjuExbbwhY+mTegezJo9vQPXSCtm55bLxF8Cnjw==
X-Gm-Gg: AZuq6aLBuIubhBbvC6nwaGtPnqSo+gRT/HpcYqTSkJa++wvSmKYgCnIobjdFhZAos30
	22tROFkIAtLQY4Qt1vqEcFknkUNOAX9oFrxC+qEmAqxIwmfMkYdD9qdc3kT3bkQfmWav2HjaFcC
	ZpIL8znmOtQS/iQ29Xp8PEGuMEDbQVfQh+O5+JuFA/lPsDokJ6Uve1xRZKCQ6X5iZMI2e/yLEI6
	UPd9HPwpafHFk7RMoqs8RXP4Qp5hanee7+yDValRrBihfni0hn6KWGqWyyZxn7EiTlimSo0PNWH
	wt0I4OiU/Jv08wOY+VHGIa3pjrxObloN5dQQ3L4tZrVd7PL3026du5XBG6CJk6AUFPBwg8W9vhV
	JuqYsWeIR/BJvBar6uDrRf5nxSg==
X-Received: by 2002:a5d:5e01:0:b0:436:3267:3ed4 with SMTP id ffacd0b85a97d-43784548a6amr1674573f8f.17.1770799609671;
        Wed, 11 Feb 2026 00:46:49 -0800 (PST)
X-Received: by 2002:a5d:5e01:0:b0:436:3267:3ed4 with SMTP id ffacd0b85a97d-43784548a6amr1674542f8f.17.1770799609237;
        Wed, 11 Feb 2026 00:46:49 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d310c6sm3305848f8f.2.2026.02.11.00.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 00:46:48 -0800 (PST)
Message-ID: <dda23104-3ca9-4f81-aa79-b0517a9cc5a2@redhat.com>
Date: Wed, 11 Feb 2026 09:46:47 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/6] net: sched: introduce qdisc-specific drop
 reason tracing
From: Paolo Abeni <pabeni@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>
Cc: bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, horms@kernel.org,
 jiri@resnulli.us, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, atenart@redhat.com, carges@cloudflare.com,
 kernel-team@cloudflare.com
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
 <177039506239.2258217.7863252279149995024.stgit@firesoul>
 <f1827414-b6c4-47de-827a-9f9f4c796cf8@redhat.com>
Content-Language: en-US
In-Reply-To: <f1827414-b6c4-47de-827a-9f9f4c796cf8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/26 9:36 AM, Paolo Abeni wrote:
> On 2/6/26 5:24 PM, Jesper Dangaard Brouer wrote:
>> @@ -593,7 +591,7 @@ static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
>>  	while ((skb = dequeue_packet(sch, q, &credit_change, now))) {
>>  		if (!q->drop_early && must_drop(sch, q, skb)) {
>>  			drop_and_retry(q, skb, sch,
>> -				       SKB_DROP_REASON_QDISC_CONGESTED);
>> +				       QDISC_DROP_CONGESTED);
> 
> An explicit cast is needed above to avoid compiler warning (or you can
> change drop_and_retry() signature).

I see that the type confusion issues are handled for good by later
patches in the series, but I still think it would be better to avoid
introducing them with explicit casts as needed (removed by later patches).

> Also a few lines below there is another drop_and_retry() calls that is
> not converted.

I see it's handled by a later patch. I guess it would be useful to
mention such fact in the commit message.

Thanks,

Paolo

