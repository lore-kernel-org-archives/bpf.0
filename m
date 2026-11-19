Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795062012;
	b=TqMP7zQEdR+jyr+qYwhL2VmGXCtIsnw4ZQTnJ5s+REiasL4QiuHzqkiVidrAM7xJrPaM
	 yEScpEn/d2ZjqaNAko1ExMXM5cCuKbWndTG5uhJOBDDcf8woP+fDeMnNABUbiXlhl0gVr
	 sQ+SJIOolh+fSwD5RW6BfIQ3K8yOBXvY3SiXpzgfO9Ej6HbRPTndAvgohpMsS2/tCR1fz
	 EtJ6v1d2SQPEJhSF+/cWy65vyHKzS7tcPxYzXlfWDZmW6WLRj/jZOt658t4zgJR1uiQks
	 1fzVN8Z05KPg9c40ZRMbbhG4IhFXkp7CZFR+bOtxZkwSd0xhtM8wlYFDdsUEtMfOgpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795062012;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=7ixHF2HGKlFx8/CYffymgiIc7STbUt+Jrd1wzEkRZ7c=;
	b=P+DPaMR/i88Uk5OKfzzzyK9vjfWtJVlBvL3Z/gAlzHAeoUw8y+G68Q7or0cPtp1cQYgT
	 ldli+Gb9giouf/UTTHkVPg4rfcKdQpNH2My/3WGqK9BDtvr1DeWAmWB7wQEVZgewH4O/n
	 PKdMF9AZTamj06KfJklGuzBpu/wnkgaVVKcxY0CRewM354PDbEcBrAM4FfUYLyugzXQfm
	 7qgCEhSAFHmCbGpNACTpnum+xxZdhZVRxIkkd4U2pJ2fjHEpKotm2DCpfa30zvXfhjqPe
	 0HMRciiTqdysehggZIrNIC6Xo4QTUP+OIKUWN5iZEaYqXS5/H9AeJfODvPjbw/+/pIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OTfTW87y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E560606A331
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 04:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OTfTW87y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D631F000C4;
	Thu, 19 Nov 2026 04:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795062011;
	bh=7ixHF2HGKlFx8/CYffymgiIc7STbUt+Jrd1wzEkRZ7c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OTfTW87yFOElxvbB1H6HDh/xcez4u1gxKaQNt+xbZVypLM+sMbrgYvoJeTT7V+KmB
	 S9B+8b86tOE4fC6K2wkUz+hoHtVImq4MOROZt7ClKnJkQC77ip/ibPFO28y/ccIH1M
	 eCXqx4FE+Icit0Uh1mS18IofLU79cUgBuNo99PaZY8DrA0Ph3yrVJfZ9jGYztk4UuU
	 CzwUzkSbnyhHlTMXyJlrslDQrYQKDuU0y+n2C7XL4XWKh21cBwuRerfku0TQqc1JT5
	 UUyisRbnyEYRwQhUo34dccMhvnUhXFfsz0wPs+WOmXPv69aeGYbTC+zJMA0BS7mgrp
	 NpuI+cihn+yZA==
Content-Type: multipart/mixed; boundary="===============3763517115450284656=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <9c8bd5d33fa804ae1113d006bc1549f6ab8c7a4ed8e6fe2faa586394056010c0@mail.kernel.org>
In-Reply-To: <20261119033051.196177-6-luyun_611@163.com>
References: <20261119033051.196177-6-luyun_611@163.com>
Subject: Re: [PATCH bpf-next v4 5/6] bpf: Check async callback membership and user references
From: bot+bpf-ci@kernel.org
To: luyun_611@163.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 19 Nov 2026 04:20:10 +0000 (UTC)

--===============3763517115450284656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Check async callback membership and user references

TL;DR: The new membership check in __bpf_async_set_callback() may mark LRU
hash elements as referenced on every timer/wq set_callback, perturbing LRU
eviction order; a lookup that avoids marking is suggested.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -1552,11 +1552,34 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
>  				    struct bpf_prog *prog)
>  {
>  	struct bpf_async_cb *cb;
> +	struct bpf_map *map;
>  
>  	cb = READ_ONCE(async->cb);
>  	if (!cb)
>  		return -EINVAL;
>  
> +	/*
[ ... ]
> +	 */
> +	smp_mb();
> +	map = READ_ONCE(cb->map);
> +	if (!map || !bpf_map_value_is_linked(map, cb->value))
> +		return -ENOENT;

bpf_map_value_is_linked() goes through the program-facing
map->ops->map_lookup_elem().  For BPF_MAP_TYPE_LRU_HASH that is
htab_lru_map_lookup_elem() -> __htab_lru_map_lookup_elem(map, key, true),
which does:

    if (l) {
        if (mark)
            bpf_lru_node_set_ref(htab_elem_lru_node(l));

Does this mean every bpf_timer_set_callback() and bpf_wq_set_callback() on an
LRU element now marks it as referenced as a side effect of the membership
check?

A timer or wq callback gets its value pointer directly from bpf_timer_cb() or
bpf_wq_work() and can re-set its callback with no lookup beforehand, for
example when alternating callbacks.  An element that only its own timer
touches would then be kept alive in the LRU, and an element used by real
traffic could be evicted in its place.

The syscall path avoids this by using htab_lru_map_lookup_elem_sys()
(mark == false) through .map_lookup_elem_sys_only, which
bpf_map_copy_value() prefers.  Could bpf_map_value_is_linked() use
map_lookup_elem_sys_only when the map provides one, so the membership probe
does not change LRU eviction order?

The same helper is also used by bpf_task_work_acquire_ctx() earlier in the
series.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44453425101
--===============3763517115450284656==--
