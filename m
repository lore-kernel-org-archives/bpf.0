Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6AD373BF2
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563493; cv=none; b=GSYEt3Nd7Thg4hiZ5ICdN6gNmk31RRZn2YKUBfGktIqeeEtyw59mTLRkp2qFnUBbgnf7AysA49FX1rKSXNA+t9/uwmU8nOoceoBeqglYFKshA8SZKjfXS4oH8ltrPAw56wWTZVG3OL/lI3MrJzViUA/8z0xDm94fP3iKcvV0qik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563493; c=relaxed/simple;
	bh=PLQQxd3NJpb9gbYffGy7OqiMYxmhpyODdIsI++PboCg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=krS6uU2xt8+0zjVEWiD87aO6thTLYq7ILCXdnUw2ieCIHwkcPzu2bbSsrS9taB40LMPxo0mok3XVHP45OZUVhYYnlvTzWBI5Qwhu/U5bIl9w0LqCJpXZfEEc4xgZZvMaoNTvpRxjlVBKuHsr/Dg4z+OwwA6gPyHOYucxC5gBZqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuBHv5C9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuBHv5C9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484DA1F00A3A;
	Mon, 24 Aug 2026 09:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787563491;
	bh=M6JRaKMz6yrJEnxjYQsCDDmmdzkH6wl2ro5ahvbyGGo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DuBHv5C908TcUIOqGqPu3UktdHAuCWnayJ3s2FHwDsEFQM1OwaQZrXEZP6zLP6CBB
	 iYzYcZRUvMxS2ItkGUpp1eusQm31AeWfyaHY/UE4qlj8P071OxL/Z3Nbh4IXT0CsWB
	 qTwa0zfeQzmRasAqYdVPlxuzvZ9q1+4gefvoPkiPwwDfYrSS6410XXbxQ4UuPKRLo4
	 flpxsZP8bHvyDnm6TqvThc6HeSZtKR5UVJYjSjY5CmV+sO7kKG1/OksEjEZx7wuA8p
	 5LPIIkl+wFSGgzhb8IeEVV4RDYTLAVbtDYKc/2CUfmC99/aYUqfwdLqA2q69ogzRZi
	 99m8fm5wusYiw==
Content-Type: multipart/mixed; boundary="===============6320683923818825888=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ab19f87e539597f549ca944d08d3185bc9f788d9265890f01482c4c1285c83ab@mail.kernel.org>
In-Reply-To: <20260824082530.47553-2-emil@etsalapatis.com>
References: <20260824082530.47553-2-emil@etsalapatis.com>
Subject: Re: [PATCH 1/3] bpf: Factor out nonsleepable arena allocation logic
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 09:24:51 +0000 (UTC)

--===============6320683923818825888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 434fc482ce1027a7af536690a218094b882f2ad2
> Author: Emil Tsalapatis <emil@etsalapatis.com>
> Date:   Mon Aug 24 04:25:28 2026 -0400
>
>     bpf: Factor out nonsleepable arena allocation logic
>
>     The bpf_arena_alloc_pages() is supposed to transparently choose whether
>     to use _nolock() allocation variants or not depending on the caller's
>     context. This is implemented internally by testing the context a
>     __bpf_alloc_page call is made in. However, the implementation of
>     bpf_arena_alloc_pages() forces the use of the _nolock() variants by
>     calling __bpf_alloc_page after disabling IRQs by taking a spinlock.
>     This in turn causes spurious allocation failures for some workloads
>     like scx schedulers due to ZONE_NORMAL falling below the minimum
>     watermark, even though the caller is sleepable could wait until
>     there is memory available.

This isn't a bug, but could this sentence be reworded (e.g. "even though a
sleepable caller could wait until memory becomes available") so the
motivation reads cleanly?

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b43..da356989786a 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -661,68 +661,57 @@ static u64 clear_lo32(u64 val)
>  	return val & ~(u64)~0U;
>  }
>
> -/*
> - * Allocate pages and vmap them into kernel vmalloc area.
> - * Later the pages will be mmaped into user space vma.
> - */
> -static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt, int node_id,
> -			      bool sleepable)
> +
> +static int arena_adjust_tree(struct bpf_arena *arena, long uaddr, long page_cnt, long *pgoff)
> +{
> +	int ret;
> +
> +	/* Special case where user is requesting specific range. */
> +	if (uaddr) {
> +		ret = is_range_tree_set(&arena->rt, *pgoff, page_cnt);
> +		if (ret)
> +			return ret;
> +		return range_tree_clear(&arena->rt, *pgoff, page_cnt);
> +	}
> +
> +	ret = range_tree_find(&arena->rt, page_cnt);
> +	if (ret < 0)
> +		return ret;
> +
> +	*pgoff = ret;
> +
> +	return range_tree_clear(&arena->rt, *pgoff, page_cnt);
> +}
> +
> +static long arena_alloc_pages_internal(struct bpf_arena *arena, long page_cnt,
> +		long uaddr, long pgoff, int node_id, bool sleepable)

This isn't a bug, but would it read better to keep the existing
(uaddr, page_cnt) argument order in arena_alloc_pages_internal() so all
three functions agree, given both parameters are plain long?

arena_adjust_tree() uses (uaddr, page_cnt) and arena_alloc_pages() also
uses (uaddr, page_cnt), but arena_alloc_pages_internal() uses
(page_cnt, uaddr).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32709208315
--===============6320683923818825888==--
