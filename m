Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211EA174EC1
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347543; cv=none; b=kBZ3iEu+CmqJiK2oMysX4Sq5vof0D4DouEB99kS9T8utpoedjaP+m+GeKGKh++lpjj5u4uz6amcA/dVH35CAxtPs6DW/yOifH/99s2aXB8AVv1shNI3q/CDtvfY9xYczV0PR2azxxPnCLqUL7wBxknwrvTrmNkxwkjgKAAsjFyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347543; c=relaxed/simple;
	bh=C0CtMZtmQCeuKDYQo4wpeJjYRqup5wtnS1BpVLL4oDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aX3QUGTiP+rhC3tA9Czi+PhP00ULtf2W8NbZmxVyvOOALo3wyJSKcTnSrpFPaWN+cZUMLPr5HjuPi902zSBHdvdkNPSeoOCU26KmYQ3emFpOpEucPdJyiyaLGt7qzwqfM5bW78UfEu1l7fCIW8l+8fMfRGHwaYk7DWyVW1kkoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lmuTgqxL; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lmuTgqxL"
Message-ID: <33482ac2-5fca-4616-a868-47467b6fbb5c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712347539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4G6coollK8AQzFKdfCukMtZFebRIpGO5zMaWhszU7g4=;
	b=lmuTgqxL7nj3hSuXZtzv2tLc3O81IAZeYNRjeQQqrtNEo0WLNZvo6FGTS+uK3E+B0yht2p
	/7KG7hFBpkgSIzZBGc2WU2SYE8r9p7XfVDADMDTWz0UI5uXoYkUeDhyNzjikv8Bf5HFxug
	ln6/fewCrdC+xWmkbi0Hp/eklEV3f84=
Date: Fri, 5 Apr 2024 13:05:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
Content-Language: en-GB
To: John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jakub Sitnicki
 <jakub@cloudflare.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240404025305.2210999-1-yonghong.song@linux.dev>
 <20240404025310.2211688-1-yonghong.song@linux.dev>
 <66101695d69a7_5803020833@john.notmuch>
 <c9db2abb-2391-415b-ba71-db80dc42cc54@linux.dev>
 <6610258cb977b_5a9cb20838@john.notmuch>
 <71218766-13fe-48c9-a24d-b897d7c428fd@linux.dev>
 <6610546f51fff_60c8a2088c@john.notmuch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6610546f51fff_60c8a2088c@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/5/24 12:43 PM, John Fastabend wrote:
> Yonghong Song wrote:
>> On 4/5/24 9:23 AM, John Fastabend wrote:
>>> Yonghong Song wrote:
>>>> On 4/5/24 8:19 AM, John Fastabend wrote:
>>>>> Yonghong Song wrote:
>>>>>> Add bpf_link support for sk_msg and sk_skb programs. We have an
>>>>>> internal request to support bpf_link for sk_msg programs so user
>>>>>> space can have a uniform handling with bpf_link based libbpf
>>>>>> APIs. Using bpf_link based libbpf API also has a benefit which
>>>>>> makes system robust by decoupling prog life cycle and
>>>>>> attachment life cycle.
>>>>>>
>>>>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>>>>> ---
>>>>>>     include/linux/bpf.h            |   6 +
>>>>>>     include/linux/skmsg.h          |   4 +
>>>>>>     include/uapi/linux/bpf.h       |   5 +
>>>>>>     kernel/bpf/syscall.c           |   4 +
>>>>>>     net/core/sock_map.c            | 268 ++++++++++++++++++++++++++++++++-
>>>>>>     tools/include/uapi/linux/bpf.h |   5 +
>>>>>>     6 files changed, 284 insertions(+), 8 deletions(-)
>>>>>>
>>>>> LGTM one question below.
>>>>>
>>>>>> +/* Handle the following two cases:
>>>>>> + * case 1: link != NULL, prog != NULL, old != NULL
>>>>>> + * case 2: link != NULL, prog != NULL, old == NULL
>>>>>> + */
>>>>>> +static int sock_map_link_update_prog(struct bpf_link *link,
>>>>>> +				     struct bpf_prog *prog,
>>>>>> +				     struct bpf_prog *old)
>>>>>> +{
>>>>>> +	const struct sockmap_link *sockmap_link = container_of(link, struct sockmap_link, link);
>>>>>> +	struct bpf_prog **pprog;
>>>>>> +	struct bpf_link **plink;
>>>>>> +	int ret = 0;
>>>>>> +
>>>>>> +	mutex_lock(&sockmap_mutex);
>>>>>> +
>>>>>> +	/* If old prog is not NULL, ensure old prog is the same as link->prog. */
>>>>>> +	if (old && link->prog != old) {
>>>>>> +		ret = -EINVAL;
>>>>>> +		goto out;
>>>>>> +	}
>>>>>> +	/* Ensure link->prog has the same type/attach_type as the new prog. */
>>>>>> +	if (link->prog->type != prog->type ||
>>>>>> +	    link->prog->expected_attach_type != prog->expected_attach_type) {
>>>>>> +		ret = -EINVAL;
>>>>>> +		goto out;
>>>>>> +	}
>>>>>> +
>>>>>> +	ret = sock_map_prog_lookup(sockmap_link->map, &pprog,
>>>>>> +				   sockmap_link->attach_type);
>>>>>> +	if (ret)
>>>>>> +		goto out;
>>>>>> +
>>>>>> +	/* Ensure the same link between the one in map and the passed-in. */
>>>>>> +	ret = sock_map_link_lookup(sockmap_link->map, &plink, link, false,
>>>>>> +				   sockmap_link->attach_type);
>>>>>> +	if (ret)
>>>>>> +		goto out;
>>>>>> +
>>>>>> +	if (old) {
>>>>>> +		ret = psock_replace_prog(pprog, prog, old);
>>>>>> +		goto out;
>>>>>> +	}
>>>>>> +
>>>>>> +	psock_set_prog(pprog, prog);
>>>>>> +
>>>>>> +out:
>>>>>> +	if (!ret) {
>>>>>> +		bpf_prog_inc(prog);
>>>>>> +		old = xchg(&link->prog, prog);
>>>>>> +		bpf_prog_put(old);
>>>>> Need to check old? I don't think we can clal bpf_prog_put on null?
>>>>>
>>>>>      if (old)
>>>>>         bpf_prog_put(old)
>>>> The 'old' here represents the *old* link->prog program and
>>>> link->prog should not be NULL at this point.
>>> Ah ok. Maybe instead of using the input old var make it
>>> explicit?
>>>
>>>       if (!ret) {
>>>          struct bpf_prog *old_link;
>>>
>>>          bpf_prog_inc(prog);
>>>          old_link = xchg(&link->prog, prog);
>>>          bpf_prog_put(old)
>>>       }
>>>
>>> Is a bit more obious to me at least. Up to you I have a slight preference
>>> for the explicit more verbose above.
>> Regarding naming convention, yes, it is hard. My above code similar to
>> kernel/bpf/net_namespace.c:
>>
>> static int bpf_netns_link_update_prog(struct bpf_link *link,
>>                                         struct bpf_prog *new_prog,
>>                                         struct bpf_prog *old_prog)
>> {
>>           struct bpf_netns_link *net_link =
>>                   container_of(link, struct bpf_netns_link, link);
>>           enum netns_bpf_attach_type type = net_link->netns_type;
>>           struct bpf_prog_array *run_array;
>>           struct net *net;
>>           int idx, ret;
>>           
>>           if (old_prog && old_prog != link->prog)
>>                   return -EPERM;
>> 	...
>> 	old_prog = xchg(&link->prog, new_prog);
>>           bpf_prog_put(old_prog);
>> 	...
>> }
>>
>> The 'old_prog' is reused in the above.
>>
>> I am okay to change
>> 	old = xchg(&link->prog, prog);
>> to
>> 	old_link_prog = xchg(&link->prog, prog);
>>
>> in next revision (if requested or additional changes needed)
>> or as a followup.
> I'm good with this series as is LGTM. We can do a follow up if we want.

Thanks! Sounds good to me.

> Although the xchg is exactly one line above so I'm not sure its even necessary.

the xchg inpsock_set_prog() is used to set prog in pprog. The xchg I added is for 
&link->prog. I didn't make a change to psock_set_prog() since it is used 
in different places and I do not want to polute it with extra link 
parameter.

>
>>> Otherwise for the series.
>>>
>>> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
>
