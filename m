Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B7C63B9;
	Sat, 13 Jun 2026 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781359091; cv=none; b=u35mYmWIb7N1z8K/88GSGFA0X9jXBNMdtgkOwzgJqomG2/xQvFCm7LgOJsy8d4P3h77mMqoHacNOMiMhJlnXyZrZdQ7ekE/tZzlQdVUWtMceSktRpxh3a/klutaykhiahsXpeSJ8fA1OC10+xRfzNq4/5PUyEy8dtQ2oRqIeXbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781359091; c=relaxed/simple;
	bh=MGHTiIUOviutCRVwxnnDgRYWU2f8IfdfRQ1F5rszzU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ix3PcUptbns+EF88KOaByNmGeIsXNhRSNm2aKOO4uN27X+XgUROmPR+Yl5m++q8RPYdaULRVdsIyRtM2jZHsTWiuh9N8Z7KotnCvUqpGoYdon2VIvN5zFnxCOSydtT6l1Tt2qCst/NbjNCk1w7tC/5VCnQiHlKAvCte+L1Pg+TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=f6D5Q1/d; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="f6D5Q1/d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1781359053;
	bh=MGHTiIUOviutCRVwxnnDgRYWU2f8IfdfRQ1F5rszzU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=f6D5Q1/d50W4n8SSgF7rG2bLxSNoEGdr9bdFJ+EOXRNWggjl4kn1KceBDsXVmAp6c
	 OYalAEuVWUg/uWmIIGdKGvTReB38XuvjjpnCViuG9l0MgmTIaC1B8QDXDvGpguTiJ4
	 5TDjEkiSvSxKe04LZQcul3jrXqJBgEvOsAe2TED8=
Received: from [192.168.178.68] (pd9eaa69d.dip0.t-ipconnect.de [217.234.166.157])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 65DDvVHv018453
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 15:57:31 +0200 (CEST)
Message-ID: <74a6b90c-7d67-4047-8467-3757cd1f91a6@tu-dortmund.de>
Date: Sat, 13 Jun 2026 15:57:30 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/5] veth: add Byte Queue Limits (BQL) support
To: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
        hawk@kernel.org, netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Chris Arges <carges@cloudflare.com>,
        Mike Freemon <mfreemon@cloudflare.com>,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Breno Leitao <leitao@debian.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org
References: <20260612083530.1650245-1-hawk@kernel.org>
 <5c326cb0-9b7c-4d67-8f80-0c9be1e8fcba@tu-dortmund.de>
 <4ddf3bcb-db5d-4821-ab32-577de93973a7@tu-berlin.de>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <4ddf3bcb-db5d-4821-ab32-577de93973a7@tu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/26 19:21, Jonas Köppeler wrote:
> On 6/12/26 16:10, Simon Schippers wrote:
>> On 6/12/26 10:35, hawk@kernel.org wrote:
>>> From: Jesper Dangaard Brouer <hawk@kernel.org>
>>>
>>> This series adds BQL (Byte Queue Limits) to the veth driver, reducing
>>> latency by dynamically limiting in-flight packets in the ptr_ring and
>>> moving buffering into the qdisc where AQM algorithms can act on it.
>>
>> LGTM, thanks for the detailed changelog :)
>>
>> Maybe we should stop searching for the perfect tx-usecs value.
>> 100us is probably fine for most hardware to not have a performance
>> regression. And lowering it does not really improve the RTT anyways.
>> Do you agree?
> I agree, I already thought that it just might be a very lucky case when using 50us where something accidentally aligns nicely. Interestingly, I could also reproduce that 50us was consistently a little better compared to 100us on an Intel CPU. Maybe if I get the time, I'll have another look at it, but in general I think 50us or 100us does not really matter.
> 

Interesting.

I ran the benchmarks again, the results are at [1].
I tested values between 0-9us, 10-90us, 100, 500, 1000, 5000 and 10000us.

TLDR: Throughput is fine for everything > 0us. RTT only improves
      slightly for < 100us. So 100us is fine.

[1] https://github.com/simoschip2000/veth-backpressure-performance-testing/blob/v7/results/tx-usecs/text_sweep.txt

>>
>> Nevertheless, I will compile and run the benchmarks again.
>>
>> I will go on vacation from 15th to 24th of June, so I will not be able
>> to contribute code or run benchmarks then.
>>
>> Thanks,
>> Simon
>>
> 
