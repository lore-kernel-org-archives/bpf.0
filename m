Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF694CCDC3
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336093; cv=none; b=sYncnm7R4NPHS06HWu0pstlh0qy93r0gbPHldh5SYxjiX3ClHAeMfrpMQ9fU/x1pCOlMyIxGMCGISG7W/Gy0U82+KA5MmDRApShbhXC6mNhSp1VISo8749nXohLh6KPKWJEk7MWHoZ3fpTik/ZyN+RXvP+uVCE5rRkGlNpjzQ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336093; c=relaxed/simple;
	bh=z5ctThaO7p6yP3cNtlXCIzXvkbvUaddzTfdhAE9MlVU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OHp4UvJVnC6yW2ngLSkEinA6ugh8oglzOnxuyXLi1KpNbkMiD/T5BKO8JGY0G3lse2jrdUgN0LM/G9JETo9MbtbJnkB+q17w92xFCw5MlPoq13xAVYDHVpiHT5kI4+GdPEg9j5uESINJonyMbXGS0ny8ekZmgqifhl5i0/xVFV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzXseR1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzXseR1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0D71F000E9;
	Wed,  2 Sep 2026 08:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788336092;
	bh=XAjDpDR2dqsmK4b/OzNKpDRCWmbvKWlhljDvY2pE1kQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NzXseR1Nm9DmZQG7VQfPAhie9dn4jxk2LPtvXkEDBgyG12Iii96KcwxjVS1fDAey0
	 CYFyZ1EfEtREztz7Y7Tk/y5kTl5cl9V8qjNZkz/CJ3UFaediGgl0pxO7nF2cQab9+Y
	 7H2lNzPqY60pmbAZtk3QDD5QpdkJiHK6itliFlyDaeiC6WxoFJHqxLE4kkTFxF39B+
	 cOPoZ4ka7lE+3xPLC+7/R0km3Oxn+jNDt9kbwZb2+nL3kiLDW19UcS/PkhyEfswVbF
	 lIoohu7H4E0ktPzGoxXJGSHCCWwCz53X5HfPHW8wLokhlCC0Y7Rxz34tmlX6Qdaoy3
	 McdKXi6U4RWrg==
Content-Type: multipart/mixed; boundary="===============5011965900040782750=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <76acf36a3de9493456b04c50491ea5b7751b9d86fb6e6bbadc0043c59a391ec3@mail.kernel.org>
In-Reply-To: <20260902070239.16968-2-emil@etsalapatis.com>
References: <20260902070239.16968-2-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Update is_range_tree_set to work for consecutive ranges
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,nickolay.lysenko@gmail.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  2 Sep 2026 08:01:31 +0000 (UTC)

--===============5011965900040782750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> index 2f28886f3ff75..6f6ba718887c4 100644
> --- a/kernel/bpf/range_tree.c
> +++ b/kernel/bpf/range_tree.c
> @@ -180,12 +180,21 @@ int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
>  int is_range_tree_set(struct range_tree *rt, u32 start, u32 len)
>  {
>  	u32 last = start + len - 1;
> -	struct range_node *left;
> +	struct range_node *rn;
>
> -	/* Is this whole range set ? */
> -	left = range_it_iter_first(rt, start, last);
> -	if (left && left->rn_start <= start && left->rn_last >= last)
> -		return 0;
> +	while ((rn = range_it_iter_first(rt, start, last))) {
> +		/* Make sure the range covers the start */
> +		if (rn->rn_start > start)
> +			return -ESRCH;
> +
> +		/* If it covers the entire range we're done. */
> +		if (rn->rn_last >= last)
> +			return 0;
> +
> +		start = rn->rn_last + 1;
> +	}
> +
> +	/* No range to cover [start, last] */
>  	return -ESRCH;
>  }

This isn't a bug, but since this loop doesn't modify the tree (unlike
range_tree_clear() just above), would __range_it_iter_next() work here
instead of re-descending from the root with range_it_iter_first() each
iteration?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33603499110
--===============5011965900040782750==--
