Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C473655EC;
	Tue,  2 Jun 2026 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414709; cv=none; b=QYiylwGllG4F/1EQgXr8161AvJzZxjaib4zoFx6kA6UohG8laLcqN8HgiAh/3hpI4V1J5z8Skte7vbgEbWsWkTQNDg5637lAGJsfpQUUDro81D5EqVfc2UB3Nr93yd+2yI/WvtFyeyp1z6xCM8SbLH9CBWQsPcrMZWYSso7SX4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414709; c=relaxed/simple;
	bh=sw1/94OefMqA9AfMWSwoSn6e8cJqsh0npePFZbzbjhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFx2NupFH0jqNjzVz+OcFCL74yRkz9F4iahMESJ23eGxKuYN6FrniSgZjaGO/dTFZfleZQrVyXEbzUe9GBwjs7dJLEdYMf6q/rWFIHJTwU1dkQOb+tOns7yeD1PtyqudI3A+m8PnG+Te3AzkOZTKZbiLMV6lg6mAfWDcsryOYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=kR+Dy3Ta; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="kR+Dy3Ta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1780414677;
	bh=sw1/94OefMqA9AfMWSwoSn6e8cJqsh0npePFZbzbjhQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kR+Dy3Tatk/A+rWyOz8NrA6HpQeYL8RQzC6dICtM183EemFTX48d/JOabxPqJG5M4
	 3D/rcpM8yZo3iEvRuAO73M8u361gvL+NTLmu/zvSpuzbSDxkL7Pxml5Uuxi8y+K9mB
	 VkcYHwPLBlTKTKDjXjIFnIPu+SVO9P5MrHJo3jC0=
Received: from [129.217.186.133] ([129.217.186.133])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 652FbuRY029237
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 2 Jun 2026 17:37:56 +0200 (CEST)
Message-ID: <53dc682c-f3df-485a-91f6-74212554cd10@tu-dortmund.de>
Date: Tue, 2 Jun 2026 17:37:52 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
        hawk@kernel.org, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-6-hawk@kernel.org>
 <2affe9f4-56a7-4482-931f-9d98cfdf09fd@tu-berlin.de>
 <db5b7f7e-135c-40f0-a740-057bc6623e6c@tu-dortmund.de>
 <865f31e5-4e90-4dc0-890f-b5796948b590@tu-berlin.de>
 <55b23925-9676-4005-8c13-ea7001190abb@tu-dortmund.de>
 <e3d28da7-0fe3-4970-865c-9f51346e01fd@tu-berlin.de>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <e3d28da7-0fe3-4970-865c-9f51346e01fd@tu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/2/26 09:24, Jonas Köppeler wrote:
> On 6/1/26 6:16 PM, Simon Schippers wrote:
> 
>> On 6/1/26 16:03, Jonas Köppeler wrote:
>>> On 6/1/26 2:00 PM, Simon Schippers wrote:
>>>> On 5/28/26 09:46, Jonas Köppeler wrote:
>>>>> On 5/27/26 3:54 PM, hawk@kernel.org wrote:
>>>>>> From: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>>>>
>>>>>> Per-packet BQL completion forces DQL to converge on limit=2, causing
>>>>>> excessive NAPI scheduling overhead and qdisc requeues.
>>>>>>
>>>>>> Accumulate BQL completions and flush them when a configurable time
>>>>>> threshold is exceeded, letting DQL discover a limit that bounds actual
>>>>>> queuing delay to the configured interval. Coalescing state persists
>>>>>> across NAPI polls in struct veth_rq so completions can accumulate
>>>>>> beyond a single budget=64 cycle.
>>>>>>
>>>>>> Add ethtool tx-usecs support for runtime tuning. Default is 100 us;
>>>>>> setting tx-usecs to 0 disables coalescing and falls back to per-packet
>>>>>> completion.
>>>>>>
>>>>>>      ethtool -C <veth-dev> tx-usecs 500  # 500us coalescing
>>>>>>      ethtool -C <veth-dev> tx-usecs 0    # per-packet (no coalescing)
>>>>>>
>>>>>> Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>>> Tested-by: Jonas Köppeler<j.koeppeler@tu-berlin.de>
>>>>>
>>>> Thanks for your testing!
>>>>
>>>> However, I have issues reproducing.
>>>> I run bare metal (without virtme) with v6 + your pktgen patch
>>>> and I am on the branch pktgen-and-benchmark, commit
>>>> "results: add veth-bql measurements":
>>>>
>>>> 1. ping fails with 100% packet loss ~20% of the times with --pktgen.
>>>>      When this happens the avg ping of this run is mistakenly set
>>>>      to 0.0 ms, which distorts the results.
>>>>      I fixed it locally by rerunning when this happens.
>>>>
>>>> 2. pktgen runs with > 3 Mpps even with --nrules 10000, see log below.
>>>>      I see that this is because of qdisc drops.
>>>>      I also tried pfifo and sfq but with the same result.
>>>>      I spent quite some time on it but I do not know a fix.
>>>>
>>>> Do you have an idea?
>>>> Thanks!
>>> Hi,
>>> yes there are some changes missing in the test script.
>>> I have pushed it now, sorry. This should fix 1.
>> I pulled it and ran...
>>
>> sudo ./veth_bql_sweep.sh --runs 1 --pktgen --duration 20 --qdisc fq_codel --no-bpftrace
>>
>> ... but still 8/32=1/4 of the pings are zero, I do not see
>> a pattern.
>>
>>
>> I grabbed the logs from /tmp and this is what a failing
>> ping looks like:
>>
>> PING 10.99.0.2 (10.99.0.2) 56(84) bytes of data.
>>
>> --- 10.99.0.2 ping statistics ---
>> 97 packets transmitted, 0 received, 100% packet loss, time 19967ms
>>
>>
>> Feels like a race or something..
>> Can you reproduce with the exact command?
>> I think you need --runs 1, else it just averages over multiple
>> runs.
> 
> Sorry, no I could not reproduce this. I used the exact same
> command as you did, and I am using net-next/main + v6 patches.
> I have 0% ping loss across all tests. Does the ping loss
> happen regardless of the qdisc?
> 

Yes, it happens for each qdisc I tested.
As a fix I changed the script to rerun if this happens.

With that I ran the benchmark and also created a script to have
the result as an ASCII table.
I think it would make sense to include something like this in
the commit message.

Throughput (pps)
==================================================
nrules |   0us | 100us | 1000us | 10000us || stock
-------+-------+-------+--------+---------++------
     0 | 1.65M | 1.75M |  1.74M |   1.74M || 1.73M
   100 |  684K |  755K |   730K |    728K ||  744K
  1000 |  119K |  126K |   126K |    125K ||  126K
 10000 |   13K |   12K |    13K |     13K ||   13K


Ping RTT ms (avg)
==================================================
nrules |   0us | 100us | 1000us | 10000us || stock
-------+-------+-------+--------+---------++------
     0 | 0.016 | 0.138 |  0.137 |   0.135 || 0.133
   100 | 0.029 | 0.185 |  0.310 |   0.315 || 0.310
  1000 | 0.137 | 0.321 |   1.66 |    1.81 ||  1.78
 10000 |  1.22 |  1.87 |   3.02 |    16.0 ||  17.2

>>
>>> Regarding 2.: do not look at the pktgen output, in the
>>> new version you will see something like "goodput",
>>> which is the number you should look for.
>>> Pktgen will report at what speed it enqueued packets in
>>> the qdisc.
>> Exactly. Now it works. Had a single outlier but apart from that
>> everything is fine.
>>
>> Thanks,
>> Simon
>>
>>> Let me know if it worked.
>>> Best,
>>> Jonas
>>>
