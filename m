Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B4D3BB9ED;
	Mon, 10 Aug 2026 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358712; cv=none; b=P1sfAgL7Nnk7Df6JLPmvoQX8WbIuLi87i0SIIJSQJFzAZOLQ8uDWPdx2W3670sl5zCNXRre7HmXnO0VH2YR9TcLsJ5pj/YfsM9emNulBj4BcddNCDMK53HkAzskVLgHfBvx3gWzU92aFYPVai/y1kP98HRBXGfo3sH5Yh3kXyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358712; c=relaxed/simple;
	bh=FpT3MACyc0VpHGcCoXoY5F523i77BlJiaCNjQrKc0R4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=E0O8TRH3R5L4Msg2xXL/a7faoRT/dscy5pzOdcNqJNrRj5k4E3YlB4D4qXWacU8n5R2G+V4KxsvKsPvCRTUIvSU2+A5g7LBQPfNe4qvToP68Wik0/873eB995er4mg7AXnSmzK+4H80UMoUh4STufrXAG0U+pcAYZDTbmmx2xkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SllqX/Fu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SllqX/Fu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9288B1F000E9;
	Mon, 10 Aug 2026 10:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786358711;
	bh=YiVS01HVwmjHtEcyresmnVZbFtKJ+qrXTT5jRW/oskg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SllqX/FuEWkZyh2DJs5KwWDwr0cSTo/FXqinWlkUkv7k8oJaLy4qvm08L7Faa2S5I
	 Cok81wOoAdd261w4eT8S6Li75jcXOItTxt0Jmo4Wh92QPD9gtn7tU9815pFXgwqFCh
	 p/PhTrj340LpFJjNH5loNP0s9mB8jD/AS/aQQ6mKX2/w7/WQ3rsFA3bCEKi5KkM8Xd
	 dZtOIq7AAnzIqdmcHUoj835A7OUzLUJgffKK+rHzltVqK1hwLOcDh5vVW3ZesTx8G0
	 q95C+ckNW8yN9BicZBIkhbhRL1u5PRIN23JCzQGGE6JIIwjD+CoxezWLXYVwCY3hEF
	 X9clQxrqIrErw==
Content-Type: multipart/mixed; boundary="===============2040896362550893805=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eef3da9def5fc191df9f954558e4ab6c114082534f6d8901a32393b70473db4f@mail.kernel.org>
In-Reply-To: <20260810094634.2723213-2-chenyuan_fl@163.com>
References: <20260810094634.2723213-2-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf, arena: fix range_tree_clear inconsistency on kmalloc_nolock failure
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 10:45:10 +0000 (UTC)

--===============2040896362550893805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> index 2f28886f3ff7..15b588377a76 100644
> --- a/kernel/bpf/range_tree.c
> +++ b/kernel/bpf/range_tree.c
> @@ -143,16 +143,22 @@ int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
>  		if (rn->rn_start < start && rn->rn_last > last) {
>  			u32 old_last = rn->rn_last;
>
> +			/*
> +			 * Pre-allocate the right-half node before modifying
> +			 * the tree. If allocation fails we return -ENOMEM
> +			 * without altering the range tree.
> +			 */
> +			new_rn = kmalloc_nolock(sizeof(struct range_node),
> +						__GFP_ACCOUNT, NUMA_NO_NODE);
> +			if (!new_rn)
> +				return -ENOMEM;
> +
>  			/* Overlaps with the entire clearing range */
>  			range_it_remove(rn, rt);
>  			rn->rn_last = start - 1;
>  			range_it_insert(rn, rt);
>
> -			/* Add a range */
> -			new_rn = kmalloc_nolock(sizeof(struct range_node), __GFP_ACCOUNT,
> -						NUMA_NO_NODE);
> -			if (!new_rn)
> -				return -ENOMEM;
> +			/* Add right-half range */
>  			new_rn->rn_start = last + 1;
>  			new_rn->rn_last = old_last;
>  			range_it_insert(new_rn, rt);

This isn't a bug, but could the changelog also state what went wrong
with the old ordering? The sibling patch d453da244bfd ("bpf, arena:
fix range_tree_set inconsistency on kmalloc_nolock failure") spells
out the consequence ("previously the overlapping nodes were already
removed by range_tree_clear() before the allocation was attempted,
permanently losing the cleared sub-ranges"), while this changelog only
describes the new behavior. Without explaining that the right sub-range
[last + 1, old_last] was permanently lost from the free tree when
kmalloc_nolock() failed after the left half had already been shrunk,
the two changelogs read inconsistently.

This looks like a bug fix for the original range_tree implementation.
Should this include:

  Fixes: b795379757eb ("bpf: Introduce range_tree data structure and use it in bpf arena")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31377360587
--===============2040896362550893805==--
