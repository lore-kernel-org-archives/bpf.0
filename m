Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621BF42DA5A;
	Mon, 24 Aug 2026 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582122; cv=none; b=UjwS/URUB/411ueUjGnvSOOjCo82Abf4dmP5wiZRU3YthNVqEXA4fP5q7Y2qje1IUSq8hWJ3LALhO05yL6yPYy9MEHO72HU5DmlTcknu29qXaPfXCIt2piuP154VnyZW7xk5tcVYsovIBVNdCrQCmZepnWXxTdIto1rpN1FfR8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582122; c=relaxed/simple;
	bh=EtUqrhyu06Z0PGs8BYFn0qmqg+ru8bpo15BzLPZ3PZw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lAjS4bUIz0xPnwZDJo59HA0LvGsXYbiF4FkoNvJK8Uypb+hAP6YBOHvK3mvFWv188YVVfM1B2c7ByVcESGHVbsPZ1q3sRzYnRLsQGWx+6lVYrFu9uuY2z5Hn0UVZt2rIX8I3vDFO59OSI0CfTB696qiauYALLbqnoKG78mSn3l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSxOY47O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSxOY47O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03F21F000E9;
	Mon, 24 Aug 2026 14:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787582121;
	bh=MyGsc1qrhi+/sjiNyCW2VWri1gblw8ELwNshPXt4F7A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hSxOY47OH9b4ov/ziu45Ai6dnB24RCPKPMnlCEjSrVG2RHH450ENhVerngOlyPSbu
	 iC1+IqZMID+QGVYdJTWv3a+4NNrdLAMszLtJhpALA5Bltp5MqtMcJW0eKnja9V01A/
	 Du81AtlX+7wyHZ3pF7yyHXmpqv8WTcg6BXNMT7Yr1C98dgiAz1ZN7EUpHBp9HfckqG
	 SQLkOFvlhKUlZwBnGPpKwSnq+r+razzwNCm2Fhjt4qbzlai0Nn+3uMM2ZmlvAzJeiS
	 WWF9+dL2hsBzzovNnjeHKUhDo0wjERKvN1ztopTNVgWAFQOicZkwuzifHJ4CZW4D1b
	 JSuvYwg4v26mA==
Content-Type: multipart/mixed; boundary="===============5605689462910105328=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <34bd1d98a657d5e3f6572c52342439b7e12467d0c5d7bc981831ab4ed3adeeaa@mail.kernel.org>
In-Reply-To: <20260824134016.2006188-2-chenyuan_fl@163.com>
References: <20260824134016.2006188-2-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpf, arena: fix range_tree_clear inconsistency on kmalloc_nolock failure
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 14:35:20 +0000 (UTC)

--===============5605689462910105328==
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

This isn't a bug, but would it read better to keep the "Overlaps with
the entire clearing range" comment at the top of the branch, next to
the condition it describes, rather than having it appear in the middle
after the new allocation block?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32736729475
--===============5605689462910105328==--
