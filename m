Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBEB32D7F8
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770233717; cv=none; b=EVviz9a71dlgtFolWK/6gpXpH1Pnan16EqZgR1R8lMf8edoOmv2yJLfZzI3jY8XSXBnlmTPrq08r/zyF2rGmGXZWKEd1KhU7nWVg+80N/DotsSBTUB+VLoGxmQ7WAW3FzFqY5VZYH9QKcMiu/2WnmWO44O5WFrP7vhqSJwNDWNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770233717; c=relaxed/simple;
	bh=oRXL6nJqlL2yTdNv84UikPOBNAJklykc8eInyHmn0B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WsoBkmJoLFtCfICMyqE/1+XIstmq2NlxNGBukW6tUj0d0w4ZbsF1uf2oHrwoooYX2XokVr59arfCiZnknaHBH2/xl7QBiq4O4g1xxAz8x/ixUfXikohTb/06X6qU9H6qGr2H0gwzRdkyL3kyGH+70FlarCQ9OHNFmB/aJy6Lg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fkjqhAjz; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fkjqhAjz"
Message-ID: <0f8ec4c7-5de4-4e0b-a50e-cf4f8d59709b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770233705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tq5IxtlfEzqqlPKZNOU5fTXTvEnREFrUTM8jWKZxzVU=;
	b=fkjqhAjzpyy2TyxX004b5T/c/TlM/IfSQ3EavqFi1IDDfK87IeZdroetvE63Yvugus+lHk
	hu56G+/VkyRwIX6YM2T2z/NiO9No6LHHCke5XpUfMih6DJDO4Jzi0CVU4T7DdaM28wRJco
	eUaK+Q8mOPJgw7R0NQYHQYPmHeEbCFQ=
Date: Wed, 4 Feb 2026 11:34:55 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto
 update
To: Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, jakub@cloudflare.com,
 john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co>
 <20260203200242.404131-1-kuniyu@google.com>
 <80865b12-7786-4787-81c8-08b754716a5d@linux.dev>
 <CAAVpQUCshzAAHZQQ7sVE+3UdKmBV42bKudcdDR0KtaTcTqn5gA@mail.gmail.com>
 <408569e7-2b82-4eff-b767-79ce6ef6cae0@rbox.co>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <408569e7-2b82-4eff-b767-79ce6ef6cae0@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/4/26 7:41 AM, Michal Luczaj wrote:
>>>>>> If the concern is the bpf iterator prog may use a released unix_peer(sk)
>>>>>> pointer, it should be fine. The unix_peer(sk) pointer is not a trusted
>>>>>> pointer to the bpf prog, so nothing bad will happen other than
>>>>>> potentially reading incorrect values.

I misremembered that following unix->peer would be marked as 
(PTR_TO_BTF_ID | PTR_UNTRUSTED). I forgot there are some legacy supports 
on the PTR_TO_BTF_ID (i.e. without PTR_UNTRUSTED marking).

>>>>>
>>>>> But if the prog passes a released peer pointer to a bpf helper:
>>>>>
>>>>> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0x95/0xb0
>>>>> Read of size 1 at addr ffff888110654c92 by task test_progs/1936
>>>
>>> hmm... bpf_skc_to_unix_sock is exposed to tracing. bpf_iter is a tracing
>>> bpf prog.
>>>
>>>>
>>>> Can you cook a patch for this ? probably like below
>>>
>>> This can help the bpf_iter but not the other tracing prog such as fentry.
>>
>> Oh well ... then bpf_skc_to_unix_sock() can be used even
>> with SEQ_START_TOKEN at fentry of bpf_iter_unix_seq_show() ??

It is fine. The type is void.

>>
>> How about adding notrace to all af_unix bpf iterator functions ?

but right, other functions taking [unix_]sock pointer could be audited. 
I don't know af_unix well enough to assess the blast radius or whether 
some useful functions may become untraceable.

>>
>> The procfs iterator holds a spinlock of the hashtable from
>> ->start/next() to ->stop() to prevent the race with unix_release_sock().
>>
>> I think other (non-iterator) functions cannot do such racy
>> access with tracing prog.
> 
> But then there's SOCK_DGRAM where you can drop unix_peer(sk) without
> releasing sk; see AF_UNSPEC in unix_dgram_connect(). I think Martin is
> right, we can crash at many fentries.
> 
> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
> Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> Call Trace:
>   dump_stack_lvl+0x5d/0x80
>   print_report+0x170/0x4f3
>   kasan_report+0xe1/0x180
>   bpf_skc_to_unix_sock+0xa4/0xb0
>   bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
>   bpf_trampoline_6442564662+0x47/0xab
>   unix_shutdown+0x9/0x880
>   __sys_shutdown+0xe1/0x160
>   __x64_sys_shutdown+0x52/0x90
>   do_syscall_64+0x6b/0x3a0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e

This probably is the first case where reading a sk pointer requires a 
lock. I think it will need to be marked as PTR_UNTRUSTED in the verifier 
for the unix->peer access, so that it cannot be passed to a helper. 
There is a BTF_TYPE_SAFE_TRUSTED list. afaik, there is no untrusted one now.

