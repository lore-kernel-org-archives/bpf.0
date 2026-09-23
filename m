Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DD344C664;
	Wed, 23 Sep 2026 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156072; cv=none; b=trlRaoqmkps4gpV/m+xP67Ii8vU9xd+IWdor/A6fVvHm2ugxvw6PeEaY30vdbFcbNunv66/jHHYFy/pc4m8girT8QzwYGih7JXiJpqHmHGvkkf8hNWK5dIfmSXkO6vcA3B/FACiPR947vLsg9MiRNUdB1Finxo3bQDaSU+YWUX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156072; c=relaxed/simple;
	bh=Q3vW3SICVve9PoetQo6zjR7Ikkj4tMXY0yJ63vH3jN4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=b93getioCyS3NM71O5fKimSdOBElBKAdhrpSE19bOJXD4F7lpyU/NL4sDSdA24BeFBIZTog/6h8DWJGMfA7WmpIypRFJv6ig/J7gTytAjYefaOfvk6HFATY/O9vGMd4QZf/e1U85Z6P0mDUSdgnw2IXtHuR/PLJdX4mVVetI4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKt9cK/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKt9cK/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777CA1F000FF;
	Wed, 23 Sep 2026 09:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790156071;
	bh=AUI0hBxuW7NvImtz7LBpForG5GVkujHw6D0cEnm9nxw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hKt9cK/tbBDMlggivGOxfTJw//v6aRMb/7LHnOnk6kgp4r5gxKJ659Ss+cBKcWPb2
	 I2S56bSqZMlOcS1ysKjTkIradvixH1dmdYdGtfl0rAuDrghG/LuAAD8EjB7NNozpzp
	 Lx71PafXwXS0D0AJS29sbMEn9Fz8uSvqpeInDsGjXu3WeYiM/zUjA+9whCtY/CIynX
	 ufVrrslCwziiQ6Xvo79RRVahfrWk8H0hOQ5ZjggnG3rVtO4Erh4Xzy6IYQIBJcR8EM
	 22jbJXNXvGWbQ9tZZWoIZxneHJotvBaGA4XlRz7WR1l5Qws+TTcJg+PRHL2lak1dvW
	 BslxMJtVgh6RQ==
Content-Type: multipart/mixed; boundary="===============5052728861814005513=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2b8ec13b3f1928edb5cd898ae1a3be2b195680f433cc456941501b4371b30698@mail.kernel.org>
In-Reply-To: <20260923085817.365930-3-chenyuan_fl@163.com>
References: <20260923085817.365930-3-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v7 2/2] bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,alexei.starovoitov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 09:34:29 +0000 (UTC)

--===============5052728861814005513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure
>
> range_tree_set() pre-allocates the node needed for a brand-new range
> before calling range_tree_clear(), so an allocation failure returns
> -ENOMEM without having modified the tree (previously the overlapping
> nodes were already removed by range_tree_clear() before the allocation
> was attempted, permanently losing the cleared sub-ranges).
>
> The adjacency lookups done before the clear already return the nodes
> that the merge below needs: range_tree_clear() frees only the nodes
> that lie entirely inside [start, last], trims the overlapping ones in
> place, and the split case cannot happen because of the 'already set'
> check above. Do the lookup once and drop the unreachable -EFAULT
> checks.
>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

This looks like a bug fix for the clear-before-allocate ordering in
range_tree_set(). Should this include:

  Fixes: b795379757eb ("bpf: Introduce range_tree data structure and use it in bpf arena")

> diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> index 15b588377a76..2460e78d6a55 100644
> --- a/kernel/bpf/range_tree.c
> +++ b/kernel/bpf/range_tree.c
> @@ -199,6 +199,7 @@ int is_range_tree_set(struct range_tree *rt, u32 start, u32 len)
>  int range_tree_set(struct range_tree *rt, u32 start, u32 len)
>  {
>  	u32 last = start + len - 1;
> +	struct range_node *new_rn = NULL;
>  	struct range_node *right;
>  	struct range_node *left;
>  	int err;
> @@ -208,20 +209,19 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
>  	if (left && left->rn_start <= start && left->rn_last >= last)
>  		return 0;
>
> +	left = range_it_iter_first(rt, start - 1, start - 1);
> +	right = range_it_iter_first(rt, last + 1, last + 1);

This isn't a bug, but could a short comment above these lookups record
why they are still valid after range_tree_clear() runs, the way the
changelog explains it? The correctness now rests on a non-obvious
argument: range_tree_clear() only trims a node overlapping start-1 or
last+1 in place (never frees it), so these pointers and their endpoints
are still the ones the merge branches below need. Every other decision
point in this function carries a one-line comment, so the two bare
lookups are the odd ones out, and the rationale currently lives only in
the changelog.

> +	if (!left && !right) {
> +		new_rn = kmalloc_nolock(sizeof(struct range_node),
> +					__GFP_ACCOUNT, NUMA_NO_NODE);
> +		if (!new_rn)
> +			return -ENOMEM;
> +	}
> +
>  	/* Clear out everything in the range we want to set. */
>  	err = range_tree_clear(rt, start, len);
>  	if (err)
> -		return err;

This isn't a bug, but since the changelog argues range_tree_clear()
cannot fail here (the split path is unreachable because of the 'already
set' check), is the new out_free_new path kept deliberately as
future-proofing, or could it go the same way as the -EFAULT checks? The
asymmetry is what reads oddly: the patch removes two unreachable checks
precisely for being unreachable, while keeping error propagation from an
int-returning helper that the changelog says cannot fail.

> +		goto out_free_new;
>
[ ... ]

> @@ -241,14 +241,16 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
>  		right->rn_start = start;
>  		range_it_insert(right, rt);
>  	} else {
> -		left = kmalloc_nolock(sizeof(struct range_node), __GFP_ACCOUNT, NUMA_NO_NODE);
> -		if (!left)
> -			return -ENOMEM;
> -		left->rn_start = start;
> -		left->rn_last = last;
> -		range_it_insert(left, rt);
> +		/* No adjacent ranges; use the pre-allocated node */
> +		new_rn->rn_start = start;
> +		new_rn->rn_last = last;
> +		range_it_insert(new_rn, rt);
>  	}
>  	return 0;
> +
> +out_free_new:
> +	kfree_nolock(new_rn);
> +	return err;
>  }
>
>  void range_tree_destroy(struct range_tree *rt)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35841441642
--===============5052728861814005513==--
