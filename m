Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751C3597B
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 05:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782882221; cv=none; b=IgtxoJjcxavMZQFlsOgSwnd774is5DcxK/9Mk4eu1Q0EHqblh8bAKcAxKs9fTjQAaNuxm4/ShIWG3994Z7xo82nkoyztfRWbQqUJeiNcm//DA6wNhcYNR7AcmYxRAQFDb7nF9HWIqiPOOnIMbc0oSllsbSkogAWszpe6XNM/6iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782882221; c=relaxed/simple;
	bh=oxbMbODushhC7pgEE9L6PR2gFzNlyiACUXcfsuicEIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIA2M0e+3dO2iRLMcVuqrrus37hoKUCc7nNkt0Oj8ZoYJcPOs6wSnPqpauXmwazE7VWlpx7vh9wn4qkjKCEvDXunK0OtdhDotDQCT2PKudlsSv1pr9PRGBonaB1ZXl/eoEiPAYF1OlI+tvhlXOngpGYnpDM5dCqPo3mpPt3riCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K9pGLR0V; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K9pGLR0V"
Message-ID: <b24d5fa0-81c0-4690-b9a7-f29b79740272@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782882216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icl4iM8H8kjQY8I0E4w6SCKCBCCsjMFSCKrymXKcac8=;
	b=K9pGLR0VqRXVIaZtsgJfO00PbLThrU3L1kVvL3dD2Pw4mqEHie36a5V+LK7kwZNv4P5DKt
	m7pYZ0FFkhDQP8frdwKpKMBA9lPUrAvgaOmQ37kJ5Er/XLliB/A3B4wcqfSoxxuSmFcFMi
	0gcVmdXm6rxJAdanEqceqRiZ9NBpYow=
Date: Wed, 1 Jul 2026 13:03:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 0/3] bpf, sockmap: reject a packet-modifying
 SK_SKB stream parser
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Sechang Lim <rhkrqnwk98@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Bobby Eshleman
 <bobby.eshleman@bytedance.com>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260620024423.4141004-1-rhkrqnwk98@gmail.com>
 <e3a91acd-2b4d-4e93-a3bb-a0e9ee5ede0f@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <e3a91acd-2b4d-4e93-a3bb-a0e9ee5ede0f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/1/26 12:48 PM, Ihor Solodrai wrote:
> On 2026-06-19 7:44 p.m., Sechang Lim wrote:
>> A BPF_PROG_TYPE_SK_SKB stream parser runs on strparser's message head,
>> which can chain skbs through frag_list. A parser that resizes the skb
>> frees the frag_list segments that strparser still tracks through
>> skb_nextp, leading to a use-after-free.
>>
>> A stream parser is only meant to measure the next message, not to modify
>> the packet, so reject a packet-modifying parser at attach time.
>>
>> v5:
>>   - target bpf-next instead of bpf
>>   - add Reviewed-by tag (Jiayuan Chen)
>>
>> v4:
>>   - 
>> https://lore.kernel.org/all/20260619062959.3277612-1-rhkrqnwk98@gmail.com/
>>
>> v3:
>>   - 
>> https://lore.kernel.org/all/20260618102718.2331468-1-rhkrqnwk98@gmail.com/
>>
>> v2:
>>   - 
>> https://lore.kernel.org/all/20260612123553.2724240-1-rhkrqnwk98@gmail.com/
>>
>> v1:
>>   - 
>> https://lore.kernel.org/all/20260609112316.3685738-1-rhkrqnwk98@gmail.com/
>>
>> Sechang Lim (3):
>>    selftests/bpf: don't modify the skb in the strparser parser prog
>>    bpf, sockmap: reject a packet-modifying SK_SKB stream parser
>>    selftests/bpf: test rejection of a packet-modifying SK_SKB stream
>>      parser
>
>
> Hi Sechang, all,
>
> This series broke test_maps (test_sockmap subtest) on the bpf
> tree. Currently on BPF CI the test fails on bpf, but passes on
> bpf-next (it doesn't have the series yet).
>
> test_maps fails with:
>
>     + taskset 0xF ./test_maps
>     [    8.352378] clocksource: Watchdog remote CPU 2 read timed out
>     Failed sockmap unexpected timeout
>
> See test_maps.c:995 in test_sockmap(): the 30s select() times out and
> test_maps exits 1. Note there is no "Failed stream parser bpf prog
> attach" message, the parser attaches fine.
>
> The series was merged into bpf on 2026-06-26 00:42 UTC
>
> CI runs:
>   last good (pre-merge, 06-25): 
> https://github.com/kernel-patches/bpf/actions/runs/28158326456
>   first bad (post-merge, 06-26): 
> https://github.com/kernel-patches/bpf/actions/runs/28210181858
>   recent bad (06-30): 
> https://github.com/kernel-patches/bpf/actions/runs/28475936023
>
> Confirmed locally reverting the 3 commits and rebuilding makes
> test_sockmap pass again.
>
> Could you please help investigate?

I'll work on this.


