Received: from mta1.migadu.com (out-153.mta1.migadu.com [95.215.58.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF49C46AF0A
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646630; cv=none; b=dHyCBrsdDQkd3mzE7mno55nTyKazqsenA/H2HAG8GnjRTqz1FAV9MZ18supYKO2jv666QD9KubeFZ4LV/2YZpavD9mI+vxafxundTx2x6BdgGYFic75bdLkUMbm6FEEvFIWie6a4w4SHIxby9M4cNqvVcp8QTGF6rXTJlH/8w8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646630; c=relaxed/simple;
	bh=jDzUtJv+bm4xBlAKD9OaG1FnQWn+8Dk7PeYCuphZl9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cM2S262Z2V6W7/obWNXePHK/41WD6vRy7vH8Vc6gCSTRAxG3glp8uteZPwg+meU3FjjcrxuQTEG5xndsnRqxyNRd0gCK5VZbjSYbmGEr04PAThEnrcPbTABISS+b7vgJMG5R+H0Eb6o8DLS2k5s28KJDgP2Fx3Q/JMTFx9bAr+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QZm4qnHF; arc=none smtp.client-ip=95.215.58.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QZm4qnHF"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jDzUtJv+bm4xBlAKD9OaG1FnQWn+8Dk7PeYCuphZl9o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786646626; v=1; x=1787251426;
 b=QZm4qnHFI22vszEwUYhV5X0PVieaPdsz26XUQmvYUssCgZ9pWIkwDyw+49xpefktqbsZ2huG
 ezOQ3osrT9+E7kcRNeRtg8NuJVhc0VxaQyN46xkAbL7He4PmWtl6v1nBSs0j/BP6Be3Iyy90Tj5
 AcMFoWDlNf8uQsk0pvFc+uNg=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost (2a03:2880:10ff:b::)
	by smtp.migadu.com with ESMTPS id f89b51daf9b6a4b4;
	Thu, 13 Aug 2026 18:43:36 +0000
X-Migadu-Flow: FLOW_OUT
Date: Thu, 13 Aug 2026 11:43:31 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, KP Singh <kpsingh@kernel.org>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Leon Hwang <leon.hwang@linux.dev>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Tobias Klauser <tklauser@distanz.ch>, Eyal Birger <eyal.birger@gmail.com>, Rong Tao <rongtao@cestc.cn>, 
	Hao Luo <haoluo@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	mkoutny@suse.com, Jan Hendrik Farr <kernel@jfarr.cc>, 
	Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Brian Gerst <brgerst@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Lance Yang <lance.yang@linux.dev>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Barry Song <baohua@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next 1/4] mm/bpf: Add
 bpf_try_to_free_mem_cgroup_pages kfunc
Message-ID: <an4GCBl_c4ub5Iit@linux.dev>
References: <cover.1786086076.git.zhuhui@kylinos.cn>
 <5cd3efa9a4c614ba0b03cf4a3bd459dea67a9f61.1786086076.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cd3efa9a4c614ba0b03cf4a3bd459dea67a9f61.1786086076.git.zhuhui@kylinos.cn>

Hi Hui,

Please narrow down your CC list, I would suggest to CC only memcg and bpf
folks.

On Fri, Aug 07, 2026 at 03:01:49PM +0800, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>

[...]

First of all, good decision to decouple this series from the struct_ops for
memcg as the struct_ops for cgroup series is still in flux and I have different
plans on how memcg struct_ops should look like. We can discuss and collaborate
on how that should look like which satisfies the real use-cases we have instead
of arbitrary or imaginery use-cases.

Others are already discussing the bpf side of things, so let me focus on the
memcg side.

> 
> +/**
> + * bpf_try_to_free_mem_cgroup_pages - attempt to reclaim pages from
> + *                                    a memory cgroup
> + * @memcg:           the target memory cgroup to reclaim from
> + * @nr_pages:        the number of pages to reclaim
> + * @gfp_mask:        GFP flags controlling the reclaim behavior
> + * @reclaim_options: bitmask of MEMCG_RECLAIM_* flags to tune
> + *                   reclaim strategy
> + * @swappiness:      swappiness override value, or a sentinel to use
> + *                   the default
> + *
> + * BPF-facing wrapper around try_to_free_mem_cgroup_pages() that
> + * validates and translates the @swappiness argument before
> + * delegating to the core reclaim path.
> + *
> + * The @swappiness parameter follows these semantics:
> + *   - Values in [MIN_SWAPPINESS, SWAPPINESS_ANON_ONLY] are passed
> + *     through as an explicit swappiness override.
> + *   - Values below MIN_SWAPPINESS are treated as "use the system
> + *     default"; the override pointer is set to NULL and the cgroup's
> + *     own swappiness setting takes effect.
> + *   - Values above SWAPPINESS_ANON_ONLY are rejected as invalid.
> + *   - If @reclaim_options does not include MEMCG_RECLAIM_PROACTIVE,
> + *     the @swappiness override is ignored entirely by the core
> + *     reclaim path and the system default is used regardless.
> + *
> + * Swap usage during reclaim is gated on @reclaim_options: swap is
> + * considered only when MEMCG_RECLAIM_MAY_SWAP is set.  Without this
> + * flag, reclaim is restricted to file-backed pages regardless of the
> + * @swappiness value or the cgroup's swappiness setting.
> + *
> + * Return:
> + *   The number of pages actually reclaimed on success, or 0
> + *   if @swappiness exceeds SWAPPINESS_ANON_ONLY.
> + */
> +__bpf_kfunc unsigned long
> +bpf_try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
> +				 unsigned long nr_pages,
> +				 gfp_t gfp_mask,
> +				 unsigned int reclaim_options,
> +				 int swappiness)
> +{
> +	int *swapiness_ptr;
> +
> +	if (swappiness > SWAPPINESS_ANON_ONLY)
> +		return 0;
> +	else if (swappiness < MIN_SWAPPINESS)
> +		swapiness_ptr = NULL;
> +	else
> +		swapiness_ptr = &swappiness;
> +
> +	return try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask,
> +					    reclaim_options, swapiness_ptr);
> +}

This is just a wrapper on try_to_free_mem_cgroup_pages. We don't want that. At
the moment try_to_free_mem_cgroup_pages is used by limit reclaims (memory and
memsw, high) and proactive reclaim and has become a weird looking interface. We
should not expose it as is to the bpf programs.

Let's go back to the use-case for which you want to expose this interface. Your
cover letter says proactive reclaim. Let's focus on (existing) proactive reclaim
use-case (in future we may want more functionality). Proactive reclaim is done
on a given memcg, amount of memory to reclaim and swappiness.

Let's start with just:
unsigned long bpf_proactive_reclaim(memcg, size);

And if we clearly have a swappiness use-case then let's add one more kfunc:
unsigned long bpf_proactive_reclaim_swappiness(memcg, size, swappiness);

So, my main point is let's drive the kfuncs from the real use-cases.

thanks,
Shakeel
