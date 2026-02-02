Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C502EAB6F
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064044; cv=none; b=LPhlHqNk1pelnSZOr0qzQqGgF+i6K/ISdn8vNMetJkkWReXiRXG6XxJlbb4kKLoccuvu5abgh7HK/qaE3+lhdEdkktAdVU0Da2sJ6j/EwxN+GpDENbcdP+JsVQA0674EHT5Mx+OfwtdZ1EbPtn5e6dFH5Q1OFjIkqT2x1uBqY8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064044; c=relaxed/simple;
	bh=efaqJY4Y4akGjy2wSsREJvsnbHR4fyNppoXIXcJqG2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXz9kB1qBXP8xPEgZ7m5A01yAroUHL7pJRtrRsrCQzroD4tSd+gvsPbS263ZPJuD4wYLC69aBF7IuCFj57xFBjEdzEGRB7tJYQZcN+g33pJChPCuWpjt40sXLhvb6AQSfuEU2pSZDPL8kzqU+zISEQw3hn71psA8DvOLCsUsljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tuhOFMIo; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tuhOFMIo"
Message-ID: <0ca47c0b-16a2-4a41-8990-2ec73e19563a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770064039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7DmDiMKWNORzGW7uB2SE6ZE4LS+pgjIFc42sklIo+Q=;
	b=tuhOFMIo7xjPiAM08YGM3Apph54a9KYTNsQEKT6NltNuqhWD+niFZFRY+8BRUQzetcB9sY
	Aqoc2K1Cm2hUk6+ybBaE7b5ROP02CwChLKtIGpVuy8j+wPQwvsUY89xUWkkC/aHgLMBKPp
	5FnIsPWgyzyxrC7qWgVyxTLsrxffA58=
Date: Mon, 2 Feb 2026 12:27:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 07/17] mm: introduce BPF OOM struct ops
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, Alexei Starovoitov <ast@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, JP Kobryn <inwardvessel@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Suren Baghdasaryan <surenb@google.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>,
 bpf@vger.kernel.org
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-8-roman.gushchin@linux.dev>
 <9483528f-83dd-4a30-9489-cf0fac4de5f7@linux.dev> <87qzr6znl0.fsf@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87qzr6znl0.fsf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/30/26 3:29 PM, Roman Gushchin wrote:
> Martin KaFai Lau <martin.lau@linux.dev> writes:
> 
>> On 1/26/26 6:44 PM, Roman Gushchin wrote:
>>> +bool bpf_handle_oom(struct oom_control *oc)
>>> +{
>>> +	struct bpf_struct_ops_link *st_link;
>>> +	struct bpf_oom_ops *bpf_oom_ops;
>>> +	struct mem_cgroup *memcg;
>>> +	struct bpf_map *map;
>>> +	int ret = 0;
>>> +
>>> +	/*
>>> +	 * System-wide OOMs are handled by the struct ops attached
>>> +	 * to the root memory cgroup
>>> +	 */
>>> +	memcg = oc->memcg ? oc->memcg : root_mem_cgroup;
>>> +
>>> +	rcu_read_lock_trace();
>>> +
>>> +	/* Find the nearest bpf_oom_ops traversing the cgroup tree upwards */
>>> +	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
>>> +		st_link = rcu_dereference_check(memcg->css.cgroup->bpf.bpf_oom_link,
>>> +						rcu_read_lock_trace_held());
>>> +		if (!st_link)
>>> +			continue;
>>> +
>>> +		map = rcu_dereference_check((st_link->map),
>>> +					    rcu_read_lock_trace_held());
>>> +		if (!map)
>>> +			continue;
>>> +
>>> +		/* Call BPF OOM handler */
>>> +		bpf_oom_ops = bpf_struct_ops_data(map);
>>> +		ret = bpf_ops_handle_oom(bpf_oom_ops, st_link, oc);
>>> +		if (ret && oc->bpf_memory_freed)
>>> +			break;
>>> +		ret = 0;
>>> +	}
>>> +
>>> +	rcu_read_unlock_trace();
>>> +
>>> +	return ret && oc->bpf_memory_freed;
>>> +}
>>> +
>>
>> [ ... ]
>>
>>> +static int bpf_oom_ops_reg(void *kdata, struct bpf_link *link)
>>> +{
>>> +	struct bpf_struct_ops_link *st_link = (struct bpf_struct_ops_link *)link;
>>> +	struct cgroup *cgrp;
>>> +
>>> +	/* The link is not yet fully initialized, but cgroup should be set */
>>> +	if (!link)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	cgrp = st_link->cgroup;
>>> +	if (!cgrp)
>>> +		return -EINVAL;
>>> +
>>> +	if (cmpxchg(&cgrp->bpf.bpf_oom_link, NULL, st_link))
>>> +		return -EEXIST;
>> iiuc, this will allow only one oom_ops to be attached to a
>> cgroup. Considering oom_ops is the only user of the
>> cgrp->bpf.struct_ops_links (added in patch 2), the list should have
>> only one element for now.
>>
>> Copy some context from the patch 2 commit log.
> 
> Hi Martin!
> 
> Sorry, I'm not quite sure what do you mean, can you please elaborate
> more?
> 
> We decided (in conversations at LPC) that 1 bpf oom policy for
> memcg is good for now (with a potential to extend in the future, if
> there will be use cases). But it seems like there is a lot of interest
> to attach struct ops'es to cgroups (there are already a couple of
> patchsets posted based on my earlier v2 patches), so I tried to make the
> bpf link mechanics suitable for multiple use cases from scratch.
> 
> Did I answer your question?

Got it. The link list is for the future struct_ops implementations to 
attach to a cgroup.

I should have mentioned the context. My bad.

BPF_PROG_TYPE_SOCK_OPS is currently a cgroup BPF prog. I am thinking of 
adding a bpf_struct_ops support to have similar hooks as in the 
BPF_PROG_TYPE_SOCK_OPS. There are some issues that need to be worked 
out. A major one is that the current cgroup progs have expectations on 
the ordering and override behavior based on the BPF_F_* and the runtime 
cgroup hierarchy. I was trying to see if there are pieces in this set 
that can be built upon. The linked list is a start but will need more 
work to make it performant for networking use.

> 
>>
>>> This change doesn't answer the question how bpf programs belonging
>>> to these struct ops'es will be executed. It will be done individually
>>> for every bpf struct ops which supports this.
>>>
>>> Please, note that unlike "normal" bpf programs, struct ops'es
>>> are not propagated to cgroup sub-trees.
>>
>> There are NONE, BPF_F_ALLOW_OVERRIDE, and BPF_F_ALLOW_MULTI, which one
>> may be closer to the bpf_handle_oom() semantic. If it needs to change
>> the ordering (or allow multi) in the future, does it need a new flag
>> or the existing BPF_F_xxx flags can be used.
> 
> I hope that existing flags can be used, but also I'm not sure we ever
> would need multiple oom handlers per cgroup. Do you have any specific
> concerns here?

Another question that I have is the default behavior when none of the 
BPF_F_* is specified when attaching a struct_ops to a cgroup.

 From uapi/bpf.h:

* NONE (default): No further BPF programs allowed in the subtree

iiuc, the bpf_handle_oom() is not the same as NONE. Should each 
struct_ops implementation have its own default policy? For the 
BPF_PROG_TYPE_SOCK_OPS work, I am thinking the default policy should be 
BPF_F_ALLOW_MULTI which is always on/set now in the 
cgroup_bpf_link_attach().


