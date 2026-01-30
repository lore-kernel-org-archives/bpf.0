Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AC736A03A
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769815794; cv=none; b=OhsCUo/8cNVUjdGsM0MWTXCgS3tNTXOIqbPGtcGaIkx9rg03+hpWTG5d1NiR1tNIUMMbhQhWNPK9z69Cj8MtJYC7voFuj9eJwfrg3axr2BTkXja+dQr9zx4G8EO2zsEPYKY+Jggw6BjHSZH5rQQucj15K0qgqIqRgCo0re8w/bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769815794; c=relaxed/simple;
	bh=bxkwlGhWikPQehYupZNqAm8VQC1QZvfN4slZh/elru8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Flz7IRtuiyuREvhaOdZmXVu9kQDoAFH22R9jTQax1HX2Oc3eUlVUBwbVCo/MkZn2uSdoQ+VgpoOUC4+bWP+SLYLLLBXQsxNxhtykrMd5pcRYXdhK1Q+PWymFtpGlxkccqdvstz1BXddwGoiR7jcyF4/JiXjBdXZQCYG2YKgFxHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TjWkndFH; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TjWkndFH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769815780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QysXvGg4/WNW7ja6nSUtrR5V1p3ZPUnXLANtyVmNAWk=;
	b=TjWkndFHiWZPZypvlOjbUssQQgegJB0Nfm3nOT80hMMy13dBfusfFGYnpRGONiSv1yN0lD
	SOewWKlHjvaWx49VelxWNXVO0qyWnB64CoFNizdUo2Hn6h8EvksuLB79egcpIPIddpryBk
	TDn/BX27H7dQGZR92+4SXjhPN1cdBEI=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>,  Alexei Starovoitov <ast@kernel.org>,
  Matt Bobrowski <mattbobrowski@google.com>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  JP Kobryn <inwardvessel@gmail.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Suren Baghdasaryan
 <surenb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 07/17] mm: introduce BPF OOM struct ops
In-Reply-To: <9483528f-83dd-4a30-9489-cf0fac4de5f7@linux.dev> (Martin KaFai
	Lau's message of "Thu, 29 Jan 2026 13:00:11 -0800")
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
	<20260127024421.494929-8-roman.gushchin@linux.dev>
	<9483528f-83dd-4a30-9489-cf0fac4de5f7@linux.dev>
Date: Fri, 30 Jan 2026 15:29:31 -0800
Message-ID: <87qzr6znl0.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Martin KaFai Lau <martin.lau@linux.dev> writes:

> On 1/26/26 6:44 PM, Roman Gushchin wrote:
>> +bool bpf_handle_oom(struct oom_control *oc)
>> +{
>> +	struct bpf_struct_ops_link *st_link;
>> +	struct bpf_oom_ops *bpf_oom_ops;
>> +	struct mem_cgroup *memcg;
>> +	struct bpf_map *map;
>> +	int ret = 0;
>> +
>> +	/*
>> +	 * System-wide OOMs are handled by the struct ops attached
>> +	 * to the root memory cgroup
>> +	 */
>> +	memcg = oc->memcg ? oc->memcg : root_mem_cgroup;
>> +
>> +	rcu_read_lock_trace();
>> +
>> +	/* Find the nearest bpf_oom_ops traversing the cgroup tree upwards */
>> +	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
>> +		st_link = rcu_dereference_check(memcg->css.cgroup->bpf.bpf_oom_link,
>> +						rcu_read_lock_trace_held());
>> +		if (!st_link)
>> +			continue;
>> +
>> +		map = rcu_dereference_check((st_link->map),
>> +					    rcu_read_lock_trace_held());
>> +		if (!map)
>> +			continue;
>> +
>> +		/* Call BPF OOM handler */
>> +		bpf_oom_ops = bpf_struct_ops_data(map);
>> +		ret = bpf_ops_handle_oom(bpf_oom_ops, st_link, oc);
>> +		if (ret && oc->bpf_memory_freed)
>> +			break;
>> +		ret = 0;
>> +	}
>> +
>> +	rcu_read_unlock_trace();
>> +
>> +	return ret && oc->bpf_memory_freed;
>> +}
>> +
>
> [ ... ]
>
>> +static int bpf_oom_ops_reg(void *kdata, struct bpf_link *link)
>> +{
>> +	struct bpf_struct_ops_link *st_link = (struct bpf_struct_ops_link *)link;
>> +	struct cgroup *cgrp;
>> +
>> +	/* The link is not yet fully initialized, but cgroup should be set */
>> +	if (!link)
>> +		return -EOPNOTSUPP;
>> +
>> +	cgrp = st_link->cgroup;
>> +	if (!cgrp)
>> +		return -EINVAL;
>> +
>> +	if (cmpxchg(&cgrp->bpf.bpf_oom_link, NULL, st_link))
>> +		return -EEXIST;
> iiuc, this will allow only one oom_ops to be attached to a
> cgroup. Considering oom_ops is the only user of the
> cgrp->bpf.struct_ops_links (added in patch 2), the list should have
> only one element for now.
>
> Copy some context from the patch 2 commit log.

Hi Martin!

Sorry, I'm not quite sure what do you mean, can you please elaborate
more?

We decided (in conversations at LPC) that 1 bpf oom policy for
memcg is good for now (with a potential to extend in the future, if
there will be use cases). But it seems like there is a lot of interest
to attach struct ops'es to cgroups (there are already a couple of
patchsets posted based on my earlier v2 patches), so I tried to make the
bpf link mechanics suitable for multiple use cases from scratch.

Did I answer your question?

>
>> This change doesn't answer the question how bpf programs belonging
>> to these struct ops'es will be executed. It will be done individually
>> for every bpf struct ops which supports this.
>>
>> Please, note that unlike "normal" bpf programs, struct ops'es
>> are not propagated to cgroup sub-trees.
>
> There are NONE, BPF_F_ALLOW_OVERRIDE, and BPF_F_ALLOW_MULTI, which one
> may be closer to the bpf_handle_oom() semantic. If it needs to change
> the ordering (or allow multi) in the future, does it need a new flag
> or the existing BPF_F_xxx flags can be used.

I hope that existing flags can be used, but also I'm not sure we ever
would need multiple oom handlers per cgroup. Do you have any specific
concerns here?

Thanks!
