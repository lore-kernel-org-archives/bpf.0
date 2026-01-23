Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684C7346E4C;
	Fri, 23 Jan 2026 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769165953; cv=none; b=jGTFPFBBhjJANMiR/7zD5Y6nF3DAFi1gsl6MJ2szYxQt0VE2AoDqk1UaEuDXqDDkvStF1BtcKz/Q7gUoBJ5BXLyLHNgzCMGDUKZZzJLPAvs2R1J6sdktW0K8azgokWd0asJbDQN4HSybR4ar6LFDCXIuImN0g4RMPWGLr+xQgPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769165953; c=relaxed/simple;
	bh=jb65O2/Bio1rZLzUlCPrtU9qyJ2dyfIAeGMPxF6fupM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIXEx/moAj2+clTtI/25vCDnHVe/pkBWJuXJKWyPBT9GpFMUkvnoFrzOZk9HDn03Y0rmLt8h+d9Qnalgw3kQ+u5I2mC/gtZE4Y5iBsI9/giieb5v2k7h7i4S1agPsoXc5AFL2Yo1pRuTwDmUFjfP1lagyz7sMJWK6YM4X2X/5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EK3RUFZH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EK3RUFZH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B38C4CEF1;
	Fri, 23 Jan 2026 10:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769165952;
	bh=jb65O2/Bio1rZLzUlCPrtU9qyJ2dyfIAeGMPxF6fupM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EK3RUFZHlbcY4fzQJ27jyz0Ukr94SmdfUkSFrrYQCfCOL8XxIUBtLq5rqrZLgYYNN
	 shd3nl5Q+JZRs5MCuddlvhXZoN/+voIqp3mqn3NVZg2sVQgYDidE9WAMClrGavFpw+
	 o6oQ4ysGHXGtzj9RxxWceznd9x8Yre0g1oLi18Dd2qp2cZaGDR+p7MP0b3HnEdGUmp
	 He0xmXhy8UU15M1kQFh7Lmx9H/oKAgDqDSrElsCI4vAUNJLwjgfirxGzaiTnWteyL+
	 zwkba0Q00mJPyF0P3i+7p6Yf9k5hVmiCWrVPVoZ0z4Y92Sdw8nnIAwKwn3ZNRzJdPy
	 rD8EJItIVt1zg==
Message-ID: <eece25d7-1196-46f6-b3c8-2f88cbff960d@kernel.org>
Date: Fri, 23 Jan 2026 11:59:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: sched: sfq: add detailed drop reasons
 for monitoring
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 carges@cloudflare.com, kernel-team@cloudflare.com,
 Yan Zhai <yan@cloudflare.com>
References: <176847978787.939583.16722243649193888625.stgit@firesoul>
 <1bbbb306-d497-4143-a714-b126ecc41a06@kernel.org>
 <20260120162616.463c8af1@kernel.org>
 <412b91a2-15f3-4a5f-8f1a-249c9d79cb41@kernel.org>
 <20260121172155.6ec96ef8@kernel.org>
 <28911dac-6aec-42ce-9101-9071e18e1522@kernel.org>
 <20260122175919.590601b6@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260122175919.590601b6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/01/2026 02.59, Jakub Kicinski wrote:
> On Thu, 22 Jan 2026 16:33:00 +0100 Jesper Dangaard Brouer wrote:
>>> The kfree_skb tracepoint does not have netdev,
>>
>> Correct, the kfree_skb tracepoint does not have netdev avail.
>> I'm also saying that I don't want the netdev, because that would
>> explode/increase the Prometheus metric data.
> 
> Perhaps cutting someones reply mid-sentence is not the most effective
> way to communicate.
> 
>>> so if you're saying you have the ability to see the netdev then
>>> presumably there's some BPF in the mix BTF'ing the netdev info out.
>>> And if you can read the netdev info, you can as well read
>>> netdev->qdisc->ops->id and/or netdev->_tx[0]->qdisc->ops->id
>>>
>>> It kinda reads to me like you're trying to encode otherwise-reachable
>>> metadata into the drop reason.
>>
>> This feels like a misunderstanding. We don't want to (somehow) decode
>> extra metadata like netdev or qdisc.  First of all we don't want to
>> spend extra BPF prog cycles doing this (if it's even possible), and
>> secondly we want to keep metric simple (see cardinality explosion).
>>
>> I'm simply saying let us keep Eric's current approach of having qdisc
>> specific drop-reason *when* those relates to qdisc specific tunables.
>> And I'm arguing that FQ flow_limit and SFQ depth are two different
>> things, and should have their own enums.
>>     I have a specific production use-case, where I want configure SFQ to
>> have small flow "depth" to penalize elefant flows, so I'm okay with
>> SKB_DROP_REASON_SFQ_MAXDEPTH events.  So, I want to be able to tell this
>> apart from FQ drops (SKB_DROP_REASON_FQ_FLOW_LIMIT). I hope that this
>> makes it clear why I want this to be separate enums(?)
> 
> It really sounds to me like _in your setup_ there's some special
> meaning associated with some traffic being in SFQ and other
> traffic in FQ. And you can get the relevant information with BPF,
> you're just saying that you don't want to spend cycles (with no
> data to back that up).
> 
> I'm not gonna lose sleep over this, if you convince another maintainer
> to merge it it's fine. To me having per qdisc drop reasons. When qdiscs
> are *pluggable modules* and drop reasons are a core thing makes
> no sense. You're encoding arbitrary metadata into the drop reason for
> the convenience of your narrow use case.

Fair enough. I understand your concern about encoding qdisc identity
into drop reasons. My view is that qdisc-specific drop reasons help
pinpoint exact code paths and tunables, which is valuable for production
debugging. Eric's FQ commit (5765c7f6e317) already established this
pattern with FQ_BAND_LIMIT, FQ_HORIZON_LIMIT, and FQ_FLOW_LIMIT.

I'll send a v3 and expect other maintainers to review this.

--Jesper
