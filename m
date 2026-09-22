Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A58341A4E2;
	Tue, 22 Sep 2026 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065476; cv=none; b=aeRXLsG0fSSjlnuuJ9WNLTzUGkKshVPCpt1JLk5oKLAZvuCjXbRmSmZOtg4cX2ylFW1rA4UMLQewz4/FIwjJqQvxgmg/BguIkXdhhd3ixu2P+nBO4xkkcugwUXjCncGewUo1q/sKZ6pmOZfAY91shaarxuJzh4SvBrdqygDDw5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065476; c=relaxed/simple;
	bh=EHn4LVKXiu/vDB5HR2ps7KF1AH1QvkeJmwe5X9Dspks=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TKEtc93eQZGf8FrpvelLDxeG4T1eWdEjX5Bqyzg3HU2dW0HRaiGVQF6hgXqh7hFPOcuHDmXo97bKuMGJkwEI64cLMv3Q2/WDpEDzS7lmZyNjLHAvokU+FtJHef+6jwY4Df9mVoPx8qCITTfPQRMHq75dmA9Hd7S4mNfU8VGkapQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgmCECQx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgmCECQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5635D1F000FF;
	Tue, 22 Sep 2026 08:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790065475;
	bh=MEzqrZbkrRkeXVyXks8YClxTm4fkFoHGMVYQie29ZPs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZgmCECQxLxEv87uw0y4EjbIxcdeXoSQTdJyLl/WHRGMD1QSKv14D4toovKi99rvxv
	 J1s4IndGN0dV6593LRjmTW6iggNT9XZd9b3+OJEMaDeUPLgdRs3biF+YLD7LbMQn7/
	 O/lpJiP1ql7A1Y6oPnR+Br70y3VDz5TIEnnfeSusnLsaMllvIcBJ832QsBRtGt0KAs
	 DIXNTHBQBH9XfV5Dpw3n+DmJxHarAkRneNUIjTUJ/PPhme6H5zVEUysTJGzQ3xMAcy
	 uw9hNQrcSZPWTU2vYooe+ZUajPRQaEDXSOiu+QeeIxC2+BMhmVkSLM8mTTV+cznMQs
	 SkgeBHxb0aTWg==
Content-Type: multipart/mixed; boundary="===============2057901504599120647=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <42ad057a0f2196a218bf603a0bb66169098f966a9f9f578eedb2186ea177c4ad@mail.kernel.org>
In-Reply-To: <20260922072102.3570856-1-chenyuan_fl@163.com>
References: <20260922072102.3570856-1-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v6 2/3] bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,alexei.starovoitov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 08:24:33 +0000 (UTC)

--===============2057901504599120647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> index 15b588377a769..0420ab715f206 100644
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
> @@ -208,20 +209,40 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
>  	if (left && left->rn_start <= start && left->rn_last >= last)
>  		return 0;
>
> +	/*
> +	 * The pre-clear probe only decides whether a fresh node is needed;
> +	 * adjacency on either side is invariant across the clear, so it can
> +	 * run before the tree is modified and -ENOMEM leaves it untouched.
> +	 * The merge below re-fetches its handles after the clear instead of
> +	 * relying on the overlapping nodes being updated in place.
> +	 */

This isn't a bug, but would it read closer to the rest of the file if
this block were trimmed to the one non-obvious point - that a node
covering start-1 or last+1 cannot disappear across the clear, so the
probe is safe to do first?

Looking at other comments in this file, they're all single terse lines
like "/* Clear out everything in the range we want to set. */" or
"/* Do we have a left-adjacent range ? */", and the middle two
sentences here describe what the code already shows (the two
range_it_iter_first() calls below and the "/* No adjacent ranges; use
the pre-allocated node */" comment later).

> +	left = range_it_iter_first(rt, start - 1, start - 1);
> +	right = range_it_iter_first(rt, last + 1, last + 1);
> +	if (!left && !right) {
> +		new_rn = kmalloc_nolock(sizeof(struct range_node),
> +					__GFP_ACCOUNT, NUMA_NO_NODE);
> +		if (!new_rn)
> +			return -ENOMEM;
> +	}
> +
>  	/* Clear out everything in the range we want to set. */

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35700555218
--===============2057901504599120647==--
