Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCCB37C90A
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774982131; cv=none; b=kDfe1fOh+tmyMpGLD2pJM6oe+jZBnw3CH4yArcHURE3Hjd0u+HXbEAHZKHzbRKRPXrqSdujNjTvUNI4nWU7KY5r4R1jpf1/+twEwDjLcSRbg8PZBSVTzxsCpN9dBo4RpiqLfbR9Bk/waimiAB5Ixh6DGisHrVRuVCgz+ACmPoP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774982131; c=relaxed/simple;
	bh=2WJCq4y0huYo2AcFGPMC2HSVhJDkkrpAB5oozDLEttI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Dq1pnGnKDlpK2pJPARQ/hsgpgJbbKqBag5VyY3tniP9QkdfryIjDVitDwlLwluL+V33y6xRYKUmzZI2yK9LlQ3Al5TtOXSZOTfGjIa/i7rGAdsNXbNXXybZ0cW/lv7zihQq3cAcV9xjFZ2gLqCTNtKrrPHO7WyPPaxc4q2+25x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqE0zAvc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqE0zAvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CCAC19423;
	Tue, 31 Mar 2026 18:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774982130;
	bh=2WJCq4y0huYo2AcFGPMC2HSVhJDkkrpAB5oozDLEttI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=hqE0zAvcn5zCNtmrDXx5ZFR+rJltpuPMJhFVXKonyzdcpb3FI89FdIs6blOOsly8E
	 XwlR10BYnWw6sdBcFlLWxNnvUNrZpnGykjxYVs0IvTHFyHGKaOjpx/rqglAsxXry6E
	 tLEAgSQBWRjb8ZWv/eOAf1s97jjR0eWACCI+9n4VzwP1bznBfORctiPvCY6uColJYy
	 6v2hBpEruLC+e4LNFBZ8sun1QYyeziPT4JXz33Eymx+rN/gsD6Nw4jDRyY8Ox6BfS2
	 Ckt+AdRvnaNidkVxDo8WRvs33jVR5APugvIPw1P/kS9ECgAiao5pOe6r41X7l5o1rU
	 jxgMsxaqlso4A==
Content-Type: multipart/mixed; boundary="===============3347442018451071404=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <29afc1f08868691fee1ea4273e01ee669cfdbb2ca960fc1ee71fc4ed486cd069@mail.kernel.org>
In-Reply-To: <20260331172634.57402-1-mykyta.yatsenko5@gmail.com>
References: <20260331172634.57402-1-mykyta.yatsenko5@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Fix BTF handling in bpf_program__clone()
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 31 Mar 2026 18:35:30 +0000 (UTC)

--===============3347442018451071404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> -	/* BTF func/line info */
> -	if (obj->btf && btf__fd(obj->btf) >= 0) {
> -		attr.prog_btf_fd = OPTS_GET(opts, prog_btf_fd, 0) ?: btf__fd(obj->btf);
> +	prog_btf_fd = OPTS_GET(opts, prog_btf_fd, 0);
> +	if (!prog_btf_fd && obj->btf)
> +		prog_btf_fd = btf__fd(obj->btf);
> +
> +	/* BTF func/line info: only pass if kernel supports it */
> +	if (kernel_supports(obj, FEAT_BTF_FUNC) && prog_btf_fd > 0) {

The commit message says this aligns with bpf_object_load_prog(), but
that function checks btf__fd(obj->btf) >= 0:

    if (obj->btf && btf__fd(obj->btf) >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {

Should the check here be prog_btf_fd >= 0 rather than prog_btf_fd > 0,
to match the reference implementation?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23811027187
--===============3347442018451071404==--
