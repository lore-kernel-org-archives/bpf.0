Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3538734E
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682993; cv=none; b=uj7HbhuBgByQnbmTm7Y6C1sT8Au8VV5ZAPlBJe3yjS2yNmiDKb3StjkxEo2DnC7BXaUUj5jSMwlu4h60m1EN8234goYqSZDZlX5a50ju3a7z9ehVUbDjnjayoz9g+b9A3IebA943+nSv+Ye5RRHBXkmdDGT26wltnj80d/XSuP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682993; c=relaxed/simple;
	bh=ORMq1a98cTwPBAVVEwo/Jio6keLY4fN9LD6pQpnlI1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZ8E3YwZkCxh0BDLv5s9UPCjK2yl+2AXAM4lZL9hd3zj4CbPtAmrjE0mQHa/B3tb9X2PheX1LKkPCeFVeHGbOD4Xcsaz+lR1/xZMRt862/pASjJsv7pHDFlEoUkmoDVF7FCAbfRdNjmGCQwZyC+Pr8J7my2Z4esFr3OXOonsAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZv+PBDn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lt+EX4vF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZv+PBDn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lt+EX4vF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769682989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMoHfRFbbXK/0vhOEDHA+PnSmMGpVXQNKt6LSogbWH0=;
	b=RZv+PBDnGwAkvTkpeQgR5X3YiNkCpX/JVIuqcrRjv6kNktZfHU6RjCAvEhabFXlsmIqBQN
	tUdv/Jt5iT1zcYovoMdZG47Q1+MQcOiDglSRPihZA7Ig5gZyTYz/zBB/MUhpfhd3wpNEqM
	AcI24qgqnTaR+G99k/ZSItvBbqsf1T0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-tA7w9tmPMH6pm7k3wqC-Lg-1; Thu, 29 Jan 2026 05:36:27 -0500
X-MC-Unique: tA7w9tmPMH6pm7k3wqC-Lg-1
X-Mimecast-MFC-AGG-ID: tA7w9tmPMH6pm7k3wqC-Lg_1769682987
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d62cc05daso6618165e9.3
        for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 02:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769682986; x=1770287786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMoHfRFbbXK/0vhOEDHA+PnSmMGpVXQNKt6LSogbWH0=;
        b=lt+EX4vFNhkhSg+dskBFI0EvrJLmR7xq9RzunYz5gGWMb3Jbsz5z4+mt6sVTWvT+vX
         XoS9gWTsv/yjh1g7K8PlJ0Ue85vpNolLUUB84GqZr2JF6E9kyZU0QICwR3Wy6U9uYw9j
         9UA6U4j2z6QAqYQkWMzszm/ibv+pzriOJcrwPswXF/WtAvxGWKbWyT9POrCvbgRbY42b
         RZAluk76mYSqgX10kP0MSzHPJBZ7ehg5NeexqeyywhQhW5/GYMjOIUIJ08NI8hNP7RyR
         9CNImXm/XkpPJc50B61mUaAqFFHu4LhEDhb44J4ub8kz1mlKxXVHNlKi2kQ7MpPcMzw1
         OD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769682986; x=1770287786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMoHfRFbbXK/0vhOEDHA+PnSmMGpVXQNKt6LSogbWH0=;
        b=Ddvi9qX0KtgaNxP9BtmUWvksy1E+W+Mtu68numD2fcg/9ZoG5yOVv5VrEU9MmGnVqC
         /oPfnebRHPvDyPKrP9DIGpguv8zoN4is+wIXaF5RZTilI7SE+YJmQxNj78pPbRcAp0A5
         mlAc9wZ6EsmmDVwYNIm/ZhCaJIiCtTuM1haB6gAmQZ02r2vVdtDNTlX6xdJ3e4P6bPNd
         nwWmCBzPRk7JJ67alUD3wsz1QAKv3Vlj9u3HlIfxUtH+YywKbMx/gVQHGWCCEhFjeHAV
         Zj7Wmz/K8LxB25anTXb5SdU4+1QdOipNVUvTmoHgBZbHcPRlo3qnMY7mx08b7eo6tBba
         BWcA==
X-Gm-Message-State: AOJu0YzKQ3suQIGyougKQ1W/X7l/eEUOI0NyilfbtJqSHuaIzFqnn4aH
	HBEwXhzKLHMNF4KWYfvboQUedJW3lmEnm9dvP1+zdtB50+OfsOd9CfD5LqUe39ZgSHm57MJwOhp
	v/MIK7dLkjjLpBxpPgOxJmbSrEdWR3XehpbDy0lYUQcexSMz4q1tb8A==
X-Gm-Gg: AZuq6aKoGWvDDkpvXCYbx5X/0WPD/LxhWJuaai0UZeM9bxBjDb9W3hd2Z++2QYAtLz0
	IZ1edvLAvJLclbWGErn6BCvedN++2Yr+BcQeFbEKRKxe66izIvBt5IhZR5LxWaN9a2csQX188Dj
	+UYaQ5OmGpKzXGCmN3tL08eRm0N8zXxkitNcu5uT6574ES14G4j8jZegLd8BwU+eHP7KYr2Gf+L
	LOB1dwKMnYcrTkOQD67SeLME0kihclmOhw4EPo39oWPXGjyTCKjaf+bSYIsj8ePDGouyGVhgVuG
	vnCDe3YIsP0qaW4R8lhFG4rXwWSLD7DQOz3LWoz+MpG/xRuz9LtvWGnwVZMhrRdr9hVvZ208pvr
	PztlXpjLgJvV3
X-Received: by 2002:a05:600c:1990:b0:47b:deb9:15fb with SMTP id 5b1f17b1804b1-48069c8a660mr114625375e9.33.1769682986548;
        Thu, 29 Jan 2026 02:36:26 -0800 (PST)
X-Received: by 2002:a05:600c:1990:b0:47b:deb9:15fb with SMTP id 5b1f17b1804b1-48069c8a660mr114625035e9.33.1769682986149;
        Thu, 29 Jan 2026 02:36:26 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd78d3sm124547535e9.1.2026.01.29.02.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 02:36:25 -0800 (PST)
Message-ID: <78899cbc-3e1f-4f84-83a1-a2a5e6301c05@redhat.com>
Date: Thu, 29 Jan 2026 11:36:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: sched: sfq: add detailed drop reasons
 for monitoring
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>
Cc: bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 horms@kernel.org, jiri@resnulli.us, edumazet@google.com,
 xiyou.wangcong@gmail.com, jhs@mojatatu.com, carges@cloudflare.com,
 kernel-team@cloudflare.com
References: <176917072608.1186611.11185920960590396939.stgit@firesoul>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <176917072608.1186611.11185920960590396939.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/26 1:18 PM, Jesper Dangaard Brouer wrote:
> Add specific drop reasons to SFQ qdisc to improve packet drop
> observability and monitoring capabilities. This change replaces
> generic qdisc_drop() calls with qdisc_drop_reason() to provide
> granular metrics about different drop scenarios in production
> environments.
> 
> Two new drop reasons are introduced:
> 
> - SKB_DROP_REASON_QDISC_SFQ_MAXFLOWS: Used when a new flow cannot
>   be created because the maximum number of flows (flows parameter)
>   has been reached and no free flow slots are available.
> 
> - SKB_DROP_REASON_QDISC_SFQ_MAXDEPTH: Used when a flow's queue
>   length exceeds the per-flow depth limit (depth parameter),
>   triggering either tail drop or head drop depending on headdrop
>   configuration.
> 
> The existing SKB_DROP_REASON_QDISC_OVERLIMIT is used in sfq_drop()
> when the overall qdisc limit is exceeded and packets are dropped
> from the longest queue.
> 
> The naming uses qdisc-specific drop reasons tied to SFQ tunables,
> following the pattern established by Eric's FQ commit 5765c7f6e317
> ("net_sched: sch_fq: add three drop_reason") which introduced
> FQ_BAND_LIMIT, FQ_HORIZON_LIMIT, and FQ_FLOW_LIMIT.
> 
> The new drop reasons are inserted in the middle of the enum after
> SKB_DROP_REASON_QDISC_CONGESTED to group all qdisc-related reasons
> together. While drop reason enum values are not UAPI, the enum
> names implicitly become UAPI as userspace tools rely on BTF to
> resolve names to values. This makes middle-insertion safe as long
> as names remain stable.
> 
> These detailed drop reasons enable production monitoring systems
> to distinguish between different SFQ drop scenarios and generate
> specific metrics for:
> - Flow table exhaustion (flows exceeded)
> - Per-flow congestion (depth limit exceeded)
> - Global qdisc congestion (overall limit exceeded)
> 
> This granular visibility allows operators to identify capacity
> planning needs, detect traffic patterns, and optimize SFQ
> configuration based on real-world drop patterns.
> 
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Given the lack of endorsing from any 3rd party, the possible BPF
alternative and the previous controversial conversation, I'm also not
going to apply this change, sorry.

Paolo

