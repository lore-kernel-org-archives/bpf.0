Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2173EB81E;
	Tue, 25 Aug 2026 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653944; cv=none; b=ZlxA9zoXvuUqUCF7/8oLejSYGIOiMu40u6qOZaia4vNEjMIfmpwUqzm7C22EbPJkdke/12BE8mvpRA7WGwG63eXbhr9XJyfXWV9Mjmg9JLuv7BrAtYW5b+2U9TVa8E988Nyz+rWbYg+yjYdvbCAyptUHE+UAR4NN6+tikGFAGpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653944; c=relaxed/simple;
	bh=0WNjgJnsu02Mc+YWV3b0/WiwbaSQM847h53rcpertIE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dYezbnnMHzq5BQchqpVxYYJxiMPeK5yYl0/JL7tGfDMkUlMdCSVqoDyy4QvAbUxKzKj8BVrQjv8N7lmZtfjHYspgGtMGfB09ih9T7SNvoPJ4/CX6LMIS9dUY2046un4aJXcc/O8/i38JBo65F/kBp5SXohDtuKIaUu0v2/nSeNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioyc6jm/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioyc6jm/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7EA1F00A3A;
	Tue, 25 Aug 2026 10:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787653942;
	bh=kveuabh/u/+RXLi+J+apP5kupJs8BeHUbaUPhyZhhRI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ioyc6jm/Ve11nELThYcpv0DbwO4w99JXJyOWxzGcRnRqTl8T9/AOOgGfU+els5qOw
	 KNksxv85rn87Dm3nG1BWIMJMxXTWn4rTUGiyf2Qb+CA22kLlSFeO5Po5QK9fnoDqJP
	 TsfBy8EqiVLfbBVSf6Hfr76s8pao5EuILI2MGwdfsqdA3oACmgMIyBBau0htaN20XJ
	 VCxv2OwTg0KP9vhBD2gvdBL5WQu481hWP1jCT8MGg8LimmkUsLlSLEwLcP1japQ67C
	 5CUJq2gzufq3A1mnD/y6kqCZQVAvGztlWaqVcqTicqUMqbPpk+s9PEEW7jYpJa/dg6
	 5Gdomo8bissgw==
Content-Type: multipart/mixed; boundary="===============5677623048595104980=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d76005cb1d9f57bfe9aa669d6d35d25096622c6ce91fb21623f6f63b15f748a1@mail.kernel.org>
In-Reply-To: <20260825094955.83240-2-ahemadkhawar123@gmail.com>
References: <20260825094955.83240-2-ahemadkhawar123@gmail.com>
Subject: Re: [PATCH bpf-next v6 1/4] bpf: Add a sleepable page allocator for map memory
From: bot+bpf-ci@kernel.org
To: ahemadkhawar123@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,jiayuan.chen@linux.dev,emil@etsalapatis.com,ahemadkhawar123@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 25 Aug 2026 10:32:22 +0000 (UTC)

--===============5677623048595104980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b3cd28d9e3b5..c817c99d2906 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2784,6 +2784,7 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
>
>  int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
>  			unsigned long nr_pages, struct page **page_array);
> +struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map);
>  #ifdef CONFIG_MEMCG
>  void bpf_map_memcg_enter(const struct bpf_map *map, struct mem_cgroup **old_memcg,
>  			 struct mem_cgroup **new_memcg);

[ ... ]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6874ba1424af..f9b81638e537 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -636,6 +635,20 @@ int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
>  	return ret;
>  }
>
> +/*
> + * For callers that know they run in a sleepable context, e.g. a user page
> + * fault handler. can_alloc_pages() is a conservative guess made for BPF
> + * program context - notably it is always false on PREEMPT_RT - so going
> + * through bpf_map_alloc_pages() there would needlessly pick the
> + * non-blocking allocator, which never reclaims and never engages the OOM
> + * machinery.
> + */
> +struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map)
> +{
> +	might_sleep();
> +	return alloc_pages_node(map->numa_node, BPF_PAGE_GFP, 0);
> +}

In v4 review, Michal Hocko asked how bpf_map_alloc_page_sleepable() achieves
safety from mm reentrancy, noting that sleepable context alone doesn't
guarantee safety. Kumar Kartikeya Dwivedi replied that it's only for the
arena fault handler in task context. Michal's follow-up was:

  "So you rely on callers to know what they are doing. If that is the case
   and generally acceptable by the BPF community (no real saying from me in
   that matter) then make sure all that is properly documented. Because
   sleepable context is not merely enough."

https://lore.kernel.org/bpf/aoxNTXWCCndiuewO@tiehlicka

Should the comment explain the reentrancy safety expectations? The current
documentation emphasizes PREEMPT_RT and the sleepable context, but doesn't
clarify when it's safe to call this from an mm reentrancy perspective, or
that the caller must ensure it's not in a context where the allocator might
reenter mm code that's already on the stack.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32835197153
--===============5677623048595104980==--
