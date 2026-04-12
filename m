Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D381A2D0C84
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 18:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776018527; cv=none; b=Fb8+RA6oAX4AwEOJ/2Dely4j6O+6LlE9KyFqt5wy0xJInTmLLdnjqonF70tWFjs2c9FFvx+fpwP/Yui411wL8K525uuo8IRXhai7TZ5xvi+N/JISAUHIB2DwgT+/skmx6h81XdiNMA9VNFpO3xZWcD/Gx3ndRvu62TXEs81niU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776018527; c=relaxed/simple;
	bh=T+glPQPwYpC3OtbjiH4FyVSCa0uhrB0ziIETUnIHZs0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XExqkVFbM7hFavpMqq+uYGGOhf24qFSbceHotCUvP+RHA81bU7c4DvSyay1pLD5wic5+yBfGnQyXnHFsytFWhy20LnKSdmBRLWikEybKWo0CBRkzpJK5K1m0ap6fzuI7SzoBBZxuEnlBoXvpXjo9yPRwVjuJNBLZBOisnMHLbmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy+Xp5a3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy+Xp5a3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA46BC19424;
	Sun, 12 Apr 2026 18:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776018527;
	bh=T+glPQPwYpC3OtbjiH4FyVSCa0uhrB0ziIETUnIHZs0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Sy+Xp5a3p2XfVUO4asFfMllNKIdCwbS9ki/DZ7abISUVYkT39L1D/vo8nT6TwadzG
	 IVaQblDpLBg5wa9kwBPZBYBBOIs/TXpJ0FEr0DPdXxML2lKOiM9i7ptFZQqFPRHpFE
	 z5zCFp0eXc5ggmrBfobb4y2p45anJTEnpwA1Mbx0JrObnulIEDA4jDv3Z1p3qmlc2w
	 l8efRlya8ex4ZrF76U9arwCcEduByaoOzM3m+vrZD2uHdl+yKj1EYTlxo8x/xE/lDn
	 S1rE9RA1X4kDWkcqlRY54c+88wJI83qCbVan7LKJ9l2d35yz4+6pU/otliKfF+3tqu
	 mxNzmUu1r4PKQ==
Content-Type: multipart/mixed; boundary="===============0902857864348621858=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c06f36b021360e0d00ab3b8c9ba1916001937e8fcdfe1d721c11c5574bcf7830@mail.kernel.org>
In-Reply-To: <20260412174546.18684-7-emil@etsalapatis.com>
References: <20260412174546.18684-7-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v7 6/9] selftests/bpf: Add arena ASAN runtime to libarena
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,song@kernel.org,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 12 Apr 2026 18:28:46 +0000 (UTC)

--===============0902857864348621858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
> new file mode 100644
> index 000000000000..fff12ff50f26
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c

[ ... ]

> +SEC("syscall")
> +__weak __noasan int asan_init(struct asan_init_args *args)
> +{
> +	u64 globals_pages = args->arena_globals_pages;
> +	u64 all_pages = args->arena_all_pages;
> +	u64 shadow_map, shadow_pgoff;
> +	u64 shadow_pages;
> +
> +	if (asan_inited)
> +		return 0;
> +
> +	/*
> +	 * Round up the shadow map size to the nearest page.
> +	 */
> +	shadow_pages = all_pages >> ASAN_SHADOW_SHIFT;
> +	if ((all_pages & ((1 << ASAN_SHADOW_SHIFT) - 1)))
> +		shadow_pages += 1;
> +
> +	/*
> +	 * Make sure the numbers provided by userspace are sane.
> +	 */

Alexei Starovoitov flagged this comment as unhelpful in v4 review.
The validation checks below with their error messages are
self-documenting. Was the intent to remove this comment or
replace it with something more descriptive?

https://lore.kernel.org/bpf/CAADnVQLHFZE3AFzP3gtZKvcaX+3hbp3pCw3JLqEtpdoQ+OUf7g@mail.gmail.com/

> +	if (all_pages > (1ULL << 32) / __PAGE_SIZE) {
> +		arena_stderr("error: arena size %lx too large", all_pages);
> +		return -EINVAL;
> +	}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24313021445
--===============0902857864348621858==--
