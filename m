Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBD0329E49
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720436; cv=none; b=JdZjBqS2Zgw1yzg1WgpkaQbmuorfM2FFWVYJHacP8GprpRxY32rJFZH3xbiud5wfoMB0OdItphY3gVla9vrfGXfA3WO65gByjr0AOjmoR1vnMFAPEdxTtZfmW0YmDURISua2azK0hxW5HDa20iRwzklxeqXHfzlE6jejSiCS/Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720436; c=relaxed/simple;
	bh=p8G1yCJ2PT3EfWcnunBl7uj9aT4mggD4NGblAU1sORo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZYSi2grWqSVyO8lBM/3xyjL18BJUNOnK01LSs4Geki06REbdEhGOg0cNvJ3VS/rKTFCLusxQp7nu7dY0P6bteRh96FZHMJQGmOssW0bkhQgmMQcWQkP+oOhVMhinweLtA5kR2I3iL55OftKHlqmivi8RykIh5IthvvoZp4Gsx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=csaD1u4M; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="csaD1u4M"
Message-ID: <9483528f-83dd-4a30-9489-cf0fac4de5f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769720421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TiUXe0NVa0kF6pHW07f/TCaF9Zrsenq0NZUbxUvg1RM=;
	b=csaD1u4MYsjHmIWe956H+UP13R4IH4CaoZsV2DHzoLXw9+Ikq2QV14+phqkKjGLmpV/i8Y
	G4gR+n5y9+2azJ5ifRuKhVCSkUMwiNkHPP+lEi5sHXarFx0qBnM1wfC3EY72pa9LiMQUq/
	TaHFSRDConbjBi9kbFgeBFfPCY7/xZ0=
Date: Thu, 29 Jan 2026 13:00:11 -0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20260127024421.494929-8-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/26/26 6:44 PM, Roman Gushchin wrote:
> +bool bpf_handle_oom(struct oom_control *oc)
> +{
> +	struct bpf_struct_ops_link *st_link;
> +	struct bpf_oom_ops *bpf_oom_ops;
> +	struct mem_cgroup *memcg;
> +	struct bpf_map *map;
> +	int ret = 0;
> +
> +	/*
> +	 * System-wide OOMs are handled by the struct ops attached
> +	 * to the root memory cgroup
> +	 */
> +	memcg = oc->memcg ? oc->memcg : root_mem_cgroup;
> +
> +	rcu_read_lock_trace();
> +
> +	/* Find the nearest bpf_oom_ops traversing the cgroup tree upwards */
> +	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
> +		st_link = rcu_dereference_check(memcg->css.cgroup->bpf.bpf_oom_link,
> +						rcu_read_lock_trace_held());
> +		if (!st_link)
> +			continue;
> +
> +		map = rcu_dereference_check((st_link->map),
> +					    rcu_read_lock_trace_held());
> +		if (!map)
> +			continue;
> +
> +		/* Call BPF OOM handler */
> +		bpf_oom_ops = bpf_struct_ops_data(map);
> +		ret = bpf_ops_handle_oom(bpf_oom_ops, st_link, oc);
> +		if (ret && oc->bpf_memory_freed)
> +			break;
> +		ret = 0;
> +	}
> +
> +	rcu_read_unlock_trace();
> +
> +	return ret && oc->bpf_memory_freed;
> +}
> +

[ ... ]

> +static int bpf_oom_ops_reg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *st_link = (struct bpf_struct_ops_link *)link;
> +	struct cgroup *cgrp;
> +
> +	/* The link is not yet fully initialized, but cgroup should be set */
> +	if (!link)
> +		return -EOPNOTSUPP;
> +
> +	cgrp = st_link->cgroup;
> +	if (!cgrp)
> +		return -EINVAL;
> +
> +	if (cmpxchg(&cgrp->bpf.bpf_oom_link, NULL, st_link))
> +		return -EEXIST;
iiuc, this will allow only one oom_ops to be attached to a cgroup. 
Considering oom_ops is the only user of the cgrp->bpf.struct_ops_links 
(added in patch 2), the list should have only one element for now.

Copy some context from the patch 2 commit log.

 > This change doesn't answer the question how bpf programs belonging
 > to these struct ops'es will be executed. It will be done individually
 > for every bpf struct ops which supports this.
 >
 > Please, note that unlike "normal" bpf programs, struct ops'es
 > are not propagated to cgroup sub-trees.

There are NONE, BPF_F_ALLOW_OVERRIDE, and BPF_F_ALLOW_MULTI, which one 
may be closer to the bpf_handle_oom() semantic. If it needs to change 
the ordering (or allow multi) in the future, does it need a new flag or 
the existing BPF_F_xxx flags can be used.

