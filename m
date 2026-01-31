Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ACE330D22;
	Sat, 31 Jan 2026 05:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769837608; cv=none; b=H9UM0NE92kqWQMiS6AOPfek6OSLWvJEjItPcqUNseQXABvTtLwkMjh+tK4JipkHV7SARneHaYCry7LXzOBQcGxKf4BR0s2/nzpuBy8oO2gvDI3ObAboPwrsO+fjzILMoWHz5xx2VpxaSobh+JhCgU9Bxiw+OstwsrVTSxP6oSD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769837608; c=relaxed/simple;
	bh=8ffLlQi5yu6y2CoYrGheNppIvKGqGUsruKHAdfTnxsU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ik8eosOxc3nOI+WxDo8yVEgnfADxpwECvuinjbWfz62VuB4mFcTOIltHbmbLyRyuMGIqWyS6z6rdi0GFHWefHyoxvNlXBHHsDedvFkbXvS2yx22aI/aS1baVtkSXmJY5cfsL+BmX4bpTR/OkUOD8Q51IFkpMQylTVIkfQ9vPxDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwyb52KT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwyb52KT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F24C4CEF1;
	Sat, 31 Jan 2026 05:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769837608;
	bh=8ffLlQi5yu6y2CoYrGheNppIvKGqGUsruKHAdfTnxsU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=hwyb52KTuCEMFnfoLRmVberydugwfW8kimp+FvBdOh4lS8Ob6bnuuYgHCmtyZDsH9
	 KGq2Bkie8ZTu/K1pOC+H+bvKtPlngme+5NQwGIqDsH/D6MxKOnGEpzPf1KZ3rOop2n
	 8TpvoSYqWBasMaaljDHmhLeI8oPJDM3ZAbuZJCoYT6rQs+NPU3zMTxWqxkMukWDJ1i
	 VM5hESgRTZw/h16l4Fgms0msUNzbMR4jrcE0xZOlNpCrLe62yAOvtueNmJ66HSK7Hc
	 gOsB/9dLoXN54SSvWXtKB9RuBYY7l044jDXSFzbfXj4Foi40X0Wx74n5DtmPOZymAv
	 vg8JjO+VOUvww==
Content-Type: multipart/mixed; boundary="===============8438482101024718409=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0a0eaa11c4b429d41ea2adfc36b56b75b61eacd777dffb2a25cd2857f72d5f2d@mail.kernel.org>
In-Reply-To: <20260131050920.2574084-6-ameryhung@gmail.com>
References: <20260131050920.2574084-6-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v4 05/16] bpf: Change local_storage->lock and b->lock to rqspinlock
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,song@kernel.org,haoluo@google.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 31 Jan 2026 05:33:28 +0000 (UTC)

--===============8438482101024718409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 824d05325..7661319ad 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c

[ ... ]

> @@ -572,7 +591,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>  	if (!alloc_selem)
>  		return ERR_PTR(-ENOMEM);
>
> -	raw_spin_lock_irqsave(&local_storage->lock, flags);
> +	err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
> +	if (err)
> +		return ERR_PTR(err);

If the lock acquisition fails here, doesn't this leak alloc_selem? The
allocation at the top of this function succeeded:

    alloc_selem = selem = bpf_selem_alloc(smap, owner, value, ...);
    if (!alloc_selem)
        return ERR_PTR(-ENOMEM);

But on lock failure, the early return bypasses the cleanup at the end of
the function:

    if (alloc_selem) {
        mem_uncharge(smap, owner, smap->elem_size);
        bpf_selem_free(alloc_selem, true);
    }

Should this goto unlock instead of returning directly, or add explicit
cleanup before returning?

[ ... ]

This isn't a bug, but the commit message has a minor wording issue:

> Change bpf_local_storage::lock and bpf_local_storage_map_bucket::lock to
> from raw_spin_lock to rqspinlock.

"to from" should be "from".

> For, __bpf_local_storage_map_cache(), instead of handling the error,
> skip updating the cache.

There's an extra comma after "For".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21539340647

AI-authorship-score: low
AI-authorship-explanation: The commit follows standard kernel development patterns with appropriate technical detail and no AI-typical phrasing or structure.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Memory leak on error path in bpf_local_storage_update when rqspinlock times out; affects only rare lock failure scenarios.

--===============8438482101024718409==--
