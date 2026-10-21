Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571178;
	b=nA11PAbLxB8sOadz/x3dzja85YSuyBrAYeP3IiDIKNyhisiVb9/9+8s41i/Eh0RSJW6z
	 qaspS1VzAn1HNIIC6bmlAJYib8XuJf0SzS9BJde5+dpFvWie3c7/RYyzXcglcaqfdtZe7
	 m3wXSDex1Ynp5IqhiqexjV4e3FHG4zWNdYugouZAl6b7sAlKKWjET+FXk4fN3Gm9DU6CS
	 a3IM4l+GwaFLoq/+nFeSHYpu6dfQaYb4+nSghJjd00plIYy8xleStscDSCUMBI9UoNwfy
	 lMt3rQQDuZm2s1MUfpOd++gSze80h6R/yDbw+i2dxHJuoVI9lNzLg5kOyg3U3hIe7hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571178;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=F54D21K1objmsAiJjjGq1fpJPBej+JQYWf+LanDUQ6g=;
	b=p0nkfmZqJThRTE3T0ltdX1jLsORL1Ous5jMf1V26U/t5L/Il3hhZDefuKs5CPPhEptAi
	 ZQ7b9LZoopOI5jj4AyrhcfPlZABO5qtsTH2fGo70OAgA9rNdCynKxp3XYCIPGfmx49iMx
	 xre4a73vbPFRwLFPcJRDP0S+rBaETyGYZrLQVQhFawAJaAwgsuvmzFcW/EAjf14WDTXJW
	 GOaL8GhWhEMmjiy5WAYzpKyInAgpDI87LzPcGFLelFCcz2/EaGTM/Vxx21EuyQnCneoAl
	 5OXXtH/YQU6bkSf8QvbfpHJ2eXztmVyyp2JyG0S5dgXKYu+kyQ3aeePpxV/l69u3fug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Je7dhhbv;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=s4Hai8Ay;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D1E606A31B
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 08:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53D1E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Je7dhhbv;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=s4Hai8Ay
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792571177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F54D21K1objmsAiJjjGq1fpJPBej+JQYWf+LanDUQ6g=;
	b=Je7dhhbvzNER1jHVuKlpmIXv1qvSzdI21/eKKZDmTsRSOTv114jamxt782T0ZTq+4MX2jI
	e+bLvQapiaa2M5YHW9KOLoI6Kh5E/SRIJ+g7wdmYw11DoVklGqScR8tMW2keFtbcmxzfbS
	gAeGTyedHTQ/wzWhWtn14+0mN0jPaJE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-mc8XlBkmN3qpO3rCRlzTXQ-1; Wed, 21 Oct 2026 08:26:16 +0000
X-MC-Unique: mc8XlBkmN3qpO3rCRlzTXQ-1
X-Mimecast-MFC-AGG-ID: mc8XlBkmN3qpO3rCRlzTXQ_1792571175
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48dea677afcso363771f8f.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 01:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792571175; x=1793175975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F54D21K1objmsAiJjjGq1fpJPBej+JQYWf+LanDUQ6g=;
        b=s4Hai8AyrXwfJ4ythQ96hnncBtu7korBgLD5zKy8UQztPmsXsxD8eGCBI7ufxiclw2
         1t+snpuNGCz9FpYzHlt7Scxbn28FoW6wJYzjcQ73t0XQPC4zgWMP2Mwq8zZWuiKBT8BY
         t6drvno7tlNBoqjtjeCewKp2spFI00/V4UQhTKmO6EJ1Yt/cZ05QKmFpyHzdtJUUc/0S
         wZSaVzerGgqP0aE6qDFHuGIPLqyCMk7dwxFoslorPuojq/rod7fRlR4XLbt5bETpoti9
         g1ioA5cdYbeOrCeNeiCzfyyojsNYC83KeGzAUPDeMLu1pHu56azpnhDFn9egH0jSSqOp
         CJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571175; x=1793175975;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F54D21K1objmsAiJjjGq1fpJPBej+JQYWf+LanDUQ6g=;
        b=A6aIHh0De59nzT7nq9H+baBllDrhTyC7CNjs4vTDX9LOCEDw0rh9hea9j8BhCLc/fm
         cdBRc0ViW4qt2uXRENB9HSQZaU2f2Jwz4fr9pMses9Yol5TfE5p4y7u4+OuW5JE3iRce
         t3FyUHK7Y6th+RaqyURzFvfsY2yc07b9GGCDyO/Z8VX3ZGApPPViGrE8hd7Ndx32T8Yk
         +9LO7Ip23Axetbd9Ps/RdMxbzTaUBcPd/HHnDPfLLSQX2Z3aoUBIsUBAFw3lMUS5XPhP
         QOPoYWsmbGLLXwM0QC+lD+yHRnanXtfQD2ZsbJ3e/srRfpiE7afKwLsTalxnuHd2DETU
         oloQ==
X-Forwarded-Encrypted: i=1; AKwUvBwChFCVsyrqpjyiTcPlAhmfiL9PW/+EF/vxr9A6CIOejjeXB5zHpOv7CrL3c+t+wNpUPSU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFRH9vfGc/UZUoqJ2TUyrjy4mzo62ps3ntvlGIkrjZuARSHh7+
	G6jYECYKI2TZoAM4IbN7P2qNqTbXivwOP5Ugb5n+GwxoSorw8lqgVjxmB9aruigt/0IG39Jxwft
	sdxkBuCI/6x6v4qZ0srd3kI4di5dz2FXQUai8lHrOntLEmcp1DtDAug==
X-Gm-Gg: AYBFou1v+0RJGkEJ54LuC35BOIV5XrwyYPbq7igBxJajUCfLeslcp4CmUFl5BZnei02
	JMSrhZHhCPTI/2dK7tXbszDY/rbaGsK4TwEEojRGXHO4jCi3iMyUKhHewWv+E1uiy3TYsyMD+Be
	ki7OJsPgFjRQCgVCaqXbecQr0nbzrSCZELTVmtQdQqH9XuIjzA4nI6uIDDBXypuEMb0FrCTzzS4
	/0EElGMvikfj/B2sLZ6Q649XkJPiaKHlBNh+M52/38RFCbP9NqgFz7K5grB7VOoU3h9CmQtSfDb
	z2qz7+4LnNJprmuFIj8Sv2wgDjwmOXA6Lvuoac0IlfEH/yHYBxEBR4L5CxDKyHuMEajTmuf5PDV
	3XaT9K/HcAMcbfGRaVTM/Yu9bxwHQw9xG2HsSOLk3zyUjm2iWE1iPpfnMmZV2Y2bJCGT0vFzVbw
	==
X-Received: by 2002:a5d:5e06:0:b0:48c:69b3:6114 with SMTP id ffacd0b85a97d-48e1e754ca1mr11104931f8f.3.1792571174675;
        Wed, 21 Oct 2026 01:26:14 -0700 (PDT)
X-Received: by 2002:a5d:5e06:0:b0:48c:69b3:6114 with SMTP id ffacd0b85a97d-48e1e754ca1mr11104866f8f.3.1792571174210;
        Wed, 21 Oct 2026 01:26:14 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25841b5bsm4076306f8f.47.2026.10.21.01.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 01:26:13 -0700 (PDT)
Message-ID: <68046007-3737-4f85-bcd1-559daa5835d4@redhat.com>
Date: Wed, 21 Oct 2026 10:26:12 +0200
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/4] eth: mpnic: count packets, bytes, and
 drops per ring
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Zahka <daniel.zahka@gmail.com>,
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
 <20261012-mpnic-counters3-v2-1-8afba81c2d5a@gmail.com>
 <20261016220930.i32JEcqe@linutronix.de>
 <DM8U47F4MNK3.2V54CCQ9YTNBY@gmail.com>
 <20261019215405.OCzrrKYw@linutronix.de> <20261019190543.419e70bc@kernel.org>
 <20261020212155.47v0ot4g@linutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261020212155.47v0ot4g@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/26 23:21, Sebastian Andrzej Siewior wrote:
> On 2026-10-19 19:05:43 [-0700], Jakub Kicinski wrote:
>> On Mon, 19 Oct 2026 23:54:05 +0200 Sebastian Andrzej Siewior wrote:
>>> On 2026-10-19 09:04:38 [-0400], Daniel Zahka wrote:
>>>>> Why do you have the two mpnic_base_stats and fold the stats into into
>>>>> it? My guess would be that on stop the counters are reset and you want
>>>>> to preserve the stats.
>>>>>   
>>>>
>>>> Not sure I understand. I think you are asking about two things:
>>>>
>>>> 1. Why have two mpnic_base_stats?
>>>>
>>>> To avoid a separate heap allocation that can fail. Handling an
>>>> allocation failure in the ndo_stop path when doing the aggregation into
>>>> the base stats is tricky.
>>>
>>> Right. But looking at hinic3_get_stats64() for instance (I just grabbed
>>> a random one) it simply does query the stats for each queue, add up,
>>> return. It probably does not drop the queues on down, just reallocates
>>> them while changing the number of queues (and maybe MTU).
>>
>> I don't think pre-allocating stats for chips which supports thousands
>> of queues is reasonable.
> 
> I don't mean to pre-allocate stats. If device-down removes queues then
> the stats gone, so what. The queues could remain.
> 
>>>> 2. Why split stats into base stats and per queue stats, and why reset
>>>> the per queue counts when the device transitions down?
>>>>
>>>> This is the way the stats in netdev.yaml are exposed depending on the
>>>> 'scope' request attribute. My reading of the relevant kernel docs is
>>>> that the per queue counters are counting events for the current live
>>>> queue, so it makes sense to reset them and fold those counts into the
>>>> base stats when the interface is transitioned down.
>>>
>>> Is there any other driver doing this?
>>> There is ::get_sset_count() and so on for the per-queue stats.
>>
>> You may be mixing up queue stats (netlink) with the old ethtool -S
>> kitchen sink / garbage dump.
> 
> The statistics is folded on device-down into a global counter. So on
> device-up the statistics is still available. At least that is my
> understanding. This means the per-queue stats are lost and global stats
> don't match the per queue stats anymore.
> 
>>> If the interface goes down and frees all its queues, then the stats are
>>> gone, true. But preserving them at the price of two (down+up) forced RCU
>>> grace period, I don't know. It looks like a bit too much.
>>
>> This is a modern driver, the down / up path is not taken when interface
>> is reconfigured. It's only taken when the interface is actually taken
>> down or bought up. Which virtually never happens for a datacenter NIC.
> 
> So if this never happens, it might not be needed to preserve this. That
> force-RCU might not be needed. This does happen on down and I would
> assume that the device is no longer processing packets.
> 
>> I don't mean to dismiss your concerns, we agonized over this off-list
>> for a week, and don't love the resulting flow, either. But I strongly
>> prefer the RCU grace period that never really runs, but is easy to
>> reason about, to more advanced fixes which use memory barriers etc.
> 
> Right. If you think is all makes sense and is needed then why not. It
> just looks odd.
Sebastian, my understanding is that your doubts are mostly because you
are unfamiliar with the current reference NIC stats scheme. That has
evolved significantly in recent time.

I think the approach here is actually quite nice, I don't see blockers.

/P

