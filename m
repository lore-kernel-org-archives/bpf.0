Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1BC171C4
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 01:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712365842; cv=none; b=Fxjq+HFQ8hU+F5IPmdF50owaecPsVPkXw0CovVlyaIavdmecRhrIiux3qZSEqZffGUQH7qmyYb7Ub+cXHRyjAdZwvX8z/+V2znDVDgC0/gQurTg5AhsKQpo4Onxn4daVuSWufYFGXDedKcf0G/nnpr+XdYJj58gBpkM1tM4td4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712365842; c=relaxed/simple;
	bh=driOq+BE3wCtCMDe7h+qwBYQWpJvrQLNYxv9KN0pRco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rv7QEwo0/J/HqXmm7D7J6/VkctiEyjkKuR0W/LzQ/jOpHLng3mEXRKZMRnNbtP0TnxlXkkCLcpiNX3OC3GzJ2TwncDnJefmxiM4S1602PR0PlRjElPFHHz7SW5YMOBHBj35doKpJ0mP77F4/O5ep683G1UNErY76DOlhrEETOR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gu4GIEyP; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gu4GIEyP"
Message-ID: <f2336e29-6d2f-44ba-8bb5-556ee654bf4d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712365838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHxFMSFBLujiyoKafgp2KFZ1+RLgUn18EG39vw1jQNU=;
	b=Gu4GIEyP0PelMTeqyfd2S5jUwHT79ZCMol7GFNi9eAPILIDp8CN68rfEhJ5uYQqNSwCldi
	c+E86Sb8xMkuJn5oYgMI2XYzL6MwSrsZn9vcH0pK/LdzVuwGTDuUU/iuj3JahOST6Iq1VW
	rL3XX3SMGdaKARdUmiCvaA58ZMUNPww=
Date: Fri, 5 Apr 2024 18:10:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: run bpf prog w/o sockmap [was: bpf: Add bpf_link support for
 sk_msg and sk_skb progs]
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jakub Sitnicki <jakub@cloudflare.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
 <20240326022158.656285-1-yonghong.song@linux.dev>
 <CAEf4BzbkcKFVEWaHSavbRi9+9VQMbqCgP36p9fzk6Hai2v2izA@mail.gmail.com>
 <27046774-e3d6-40c2-b3e3-ae6e64ecd33b@linux.dev>
 <CAEf4BzaYh6q_0TUUARd8m0eK+5RBxWQJ8=-n84vdayPPh4Z61g@mail.gmail.com>
 <660d964a1444b_1cf6b20885@john.notmuch>
 <e49ccf43-ae90-4df1-bc10-5ee180ec47ec@linux.dev>
 <660dfe2f46769_24afa20845@john.notmuch>
 <d3c6024d-f57a-4e41-ba1e-07ca6d5fcd79@linux.dev>
 <660f80dd964ec_50b87208d1@john.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <660f80dd964ec_50b87208d1@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/4/24 9:41 PM, John Fastabend wrote:

>>>> How do you see the interface will look like (e.g. attaching the bpf prog to a sk) ?
>>> I would propse doing it directly with a helper/kfunc from the sockops
>>> programs.
>>>
>>>     attach_sk_msg_prog(sk, sk_msg_prog)
>>>     attach_sk_skb_prog(sk, sk_skb_prog)

or the whole 'struct sk_psock_progs'

attach_sk_parser(struct sock *sk, struct sk_psock_progs *progs).

>>>
>>>> It will be nice if the whole function (e.g. sk->sk_data_ready or may be some of
>>>> the sk->sk_prot) can be implemented completely in bpf. I don't have a concrete
>>>> use case for now but I think it will be powerful.
>>> Perhaps a data_ready prog could also replace the ops?
>>>
>>>     attach_sk_data_ready(sk, sk_msg_data_ready)

Other than sk_data_ready, I am also wondering how much of the 'struct proto' can 
be written in bpf. For example, the {tcp,udp}_bpf_prots.
May be with some help of new kfunc and some of the functions can just use the 
kernel default one.

>>> The attach_sk_data_ready could use pretty much the logic we have for
>>> creating psocks but only replace the sk_data_ready callback.
>>
>> sounds a good idea. Do we need to support detach function or atomic
>> update function as well? Can each sk has multiple sk_msg_prog programs?
> 
> I've not found any use for multiple programs, detach functions, or updating
> the psock once its created to be honest. Also why syzbot finds all the bugs
> in this space because we unfortunately don't stress this area much. In the
> original design I had fresh in my head building hardware load balancers and the
> XDP redirect bits so a map seemed natural. Also we didn't have a lot of the
> machinery we have now so went with the map. As I noted above the L7 LB
> hasn't really got much traction on my side at least not yet.
> 
> In reality we've been using sk_msg and sk_skb progs attaching 1:1
> with protocols and observing, auditing, adding/removing fields from
> data streams.
> 
> I would probably suggest for first implementation of a sk msg attach without
> maps I would just make it one prog no need for multiple programs and even
> skip a detach function. Maybe there is some use for multiple programs but

I would at least keep the detach (and update) program possibility open. Is it 
still too hard to support them without a map get into the way?

