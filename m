Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56A855C1BE
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890830; cv=none; b=Kr+GWLNpL084isX5m8bEbGd5BFza5zZIn8xwDyIgKL7TGg4kmYfyd5bjHgN8gHtd3+oInIXnW2NFuN4SZJC560GI0j8rLiF0cIRRDC70/3MbzDJThe0Ff3TfopR7pE3TStElWE4yPr6rYTal8Mhdc4LfCtCZWcyffXCS2jXN4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890830; c=relaxed/simple;
	bh=dLuvjde+z0+P871EOmkFu0roSow2v3eFih0PapbP2j8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nH7mI3l0cb3Xn16BezuAwNo07kETbNBHMM3IOTFn+U7FsD6ubmMUp4ND4+lhxWWLUgZe3pTUMzipciJJKCQTyJurHBjiLPAWOBEIsDivFDgQUoHFTKtg5qGth5UWsO2t/p1IRk+kBGAVwTIg+lHo6Q7loLY5JEzJ85xz/6NnF30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZrlPxmb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZrlPxmb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8EA1F00A3A;
	Tue,  8 Sep 2026 18:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890828;
	bh=+NAlMuiP6O//jUWZntvlSQy7xuCvBCX5ljJ2GCNlD9s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GZrlPxmbJP6SQxLOk/lkj11lnOpeoZky1J6SKAMkb70A4GoQK8PRWoHaHfTWloT92
	 tTFwmCH56GePqYcFUFtPNUwa3K+aWm6swDtvrvMbkKeX0kVQuflNApFGVTa+LBJQTU
	 IiWImxqz3/JgExz6hbhUQSETpIvrWMvjM528iqG6fZsAh76iQW97qJH6NkfvIhxd39
	 tKjAIA1g9IGz81t3M7MC5BJNETunWSi5+U4X6uRUNQjnwFFixjmBB1fxoay82MOeqp
	 OPz4bqrSzJTXgNKkIvMu6wc7B5kyrV+VxhKyJ6PUVykLo/qS0964oXczNZ2WPCj+/+
	 hnW+9wbWux7uA==
Content-Type: multipart/mixed; boundary="===============3994823695299107588=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <73ef60c797a2c3c5e057f6d1ea6dbe878971ca4bbb7d77da855fa85281217586@mail.kernel.org>
In-Reply-To: <20260908-libbpf_arena_thing-v1-1-0092c0e0d91b@meta.com>
References: <20260908-libbpf_arena_thing-v1-1-0092c0e0d91b@meta.com>
Subject: Re: [PATCH bpf-next] libbpf: defer arena map size check to load time
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  8 Sep 2026 18:07:07 +0000 (UTC)

--===============3994823695299107588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: defer arena map size check to load time
>
> init_arena_map_data() used the build-host page size while it opened an
> object. This could reject skeleton generation when the build host and
> target use different page sizes.
>
> Validate the size during load, before libbpf calculates the arena data
> offset. This uses the running kernel page size and rejects an
> undersized map before relocation.
>
> This problem manifested when cross compiling BPF selftests for
> arm64 (64K page) on x86 (4K page). In this setup skeleton generation
> fails.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

This isn't a bug, but could the changelog say "before the arena data
offset is computed" rather than "before relocation"? The check sits
inside bpf_object__relocate(), after the CO-RE pass
(bpf_object__relocate_core) has already run.

This looks like a bug fix for cross-compilation with different page
sizes. Should this include a Fixes: tag pointing to the commit that
added init_arena_map_data()?

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c036e8a91ed8..413b8b305194 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -7489,12 +7476,20 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
>  		bpf_object__sort_relos(obj);
>  	}
>
> -	/* place globals at the end of the arena (if supported) */
> -	if (obj->arena_map_idx >= 0 && kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF)) {
> +	if (obj->arena_map_idx >= 0) {
>  		struct bpf_map *arena_map = &obj->maps[obj->arena_map_idx];
> +		size_t data_sz = roundup(obj->arena_data_sz, sysconf(_SC_PAGE_SIZE));
> +		size_t mmap_sz = bpf_map_mmap_sz(arena_map);
> +
> +		if (obj->arena_data && data_sz > mmap_sz) {
> +			pr_warn("map '%s': declared ARENA map size (%zu) is too small to hold global __arena variables of size %zu\n",
> +				arena_map->name, mmap_sz, obj->arena_data_sz);
> +			return -E2BIG;
> +		}

This isn't a bug, but is the obj->arena_data && term doing any work
here? Since data_sz is derived from obj->arena_data_sz and both
obj->arena_data and obj->arena_data_sz are set together in
init_arena_map_data(), data_sz > mmap_sz already implies
obj->arena_data_sz > 0, which means obj->arena_data != NULL.

> +		/* place globals at the end of the arena (if supported) */
> +		if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF))
> +			obj->arena_data_off = mmap_sz - data_sz;
>  	}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34258328082
--===============3994823695299107588==--
