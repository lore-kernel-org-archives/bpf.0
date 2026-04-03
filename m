Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7189296BCB;
	Fri,  3 Apr 2026 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222558; cv=none; b=DP7KhhOocTwLZuFump0ZFl21hzlfIeoP/sVXGNNLHXiwBcPVtrySe6fYxZCB4UDScSf4q5KI21FuS6SjtWTXvn/okoElBYLzA7uNBGEmKPRcQhCSqyLjeJ7w10QAx4NDrQ0gJkkATfe+RN65dp8Hw6woL0PyLt5QM/xZigl/GGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222558; c=relaxed/simple;
	bh=Zj9q+TVODJpfjS2vcRhdusfSHjOW4kXn6PdZ+wYpSW0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LIO/sRmt0/iXQRY9qau309obmKL3s8r1S19kepIaHr/juPWQqvbi+lhnSlpySS2+QgvWhmAKPjz6r30BKvMOSsRHixBi7XvU8cT3JqurrUPFYRFOQV9bZW5GBo1jFe6cGlM8GhofSDjf7WtxUBhlyvE3hNAkkExTsubtNFZRUFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZy3/gAX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZy3/gAX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7098C4CEF7;
	Fri,  3 Apr 2026 13:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775222558;
	bh=Zj9q+TVODJpfjS2vcRhdusfSHjOW4kXn6PdZ+wYpSW0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=YZy3/gAX9o90yNa/q1XkMU3spJ1hgbJlcItioV4MMjLmLdhyovtWfl8+4qf5K00HL
	 x6kxhcZlZgVBx9p5vbrsayY/HmipGbzECGpNbeV90dyAthaFN3NIGKJvZEl1h10Stm
	 YF3kEoITFDx6akW73V294QNJ2G3wBXzclx2NV4n5xceKvdGaE6Hjh78k4gIu3vcu1e
	 QHraETS+uuV9vCt3hp3E9iFndWsBSSomKO/wp0Uoe6jPiePbNZAEhfKRW8/O0F5QoM
	 j6b9WoRnO7xRcNggOpQRNOAxoiGmg0ZKNZQuX36IYqQUM100Uu4DzQtE4955P7nsmP
	 xSLbgKReUfniw==
Content-Type: multipart/mixed; boundary="===============6398938197273600736=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3b7a777be44a7aaea75f1dc3084b3adfb32357c4bedde08d0666f6f9f3d65ba4@mail.kernel.org>
In-Reply-To: <20260403124412.37449-3-varunrmallya@gmail.com>
References: <20260403124412.37449-3-varunrmallya@gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 2/3] libbpf: Add FEAT_KPROBE_MULTI_LINK feature probe.
From: bot+bpf-ci@kernel.org
To: varunrmallya@gmail.com,bpf@vger.kernel.org,jolsa@kernel.org,leon.hwang@linux.dev,andrii@kernel.org,alan.maguire@oracle.com
Cc: ast@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,daniel@iogearbox.net,linux-kernel@vger.kernel.org,memxor@gmail.com,song@kernel.org,menglong8.dong@gmail.com,varunrmallya@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  3 Apr 2026 13:22:37 +0000 (UTC)

--===============6398938197273600736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index 4f19a0d79b0c..01ded8a1e3c4 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -424,6 +424,41 @@ static int probe_uprobe_multi_link(int token_fd)
>  	return link_fd < 0 && err == -EINVAL;
>  }
>
> +static int probe_kprobe_multi_link(int token_fd)
> +{

[ ... ]

> +	/* attaching to a valid symbol should succeed */

The operation is designed to fail with E2BIG (the count is intentionally
set above MAX_KPROBE_MULTI_CNT). Should this comment say something like
"use a stable, always-present symbol" instead? As written, it reads like
the attach is expected to succeed, which contradicts the comment two
lines below about making it fail.

> +	link_opts.kprobe_multi.syms = &sym;
> +	/* MAX_KPROBE_MULTI_CNT is defined as (1U << 20) in kernel/trace/bpf_trace.c,
> +	 * so we create one more than the allowed limit to make it fail with E2BIG.
> +	 */
> +	link_opts.kprobe_multi.cnt = (1U << 20) + 1;
> +	link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_KPROBE_MULTI, &link_opts);
> +	err = -errno;
> +	if (link_fd >= 0)
> +		close(link_fd);
> +	close(prog_fd);
> +	/* Fails with E2BIG on kernels where kprobe_multi is supported */
> +	return link_fd <= 0 && err == -E2BIG;
                    ^^^^

Should this be "link_fd < 0" rather than "link_fd <= 0"?  The
reference function probe_uprobe_multi_link() just above uses
"link_fd < 0 && err == -EINVAL" for the same pattern.  fd 0 is
a valid file descriptor, so "<= 0" treats a successful fd 0 as
a failure.  In practice bpf_link_create() goes through
ensure_good_fd() which dup's fds below 3, so fd 0 cannot be
returned, but the check is still inconsistent with the
existing code pattern.

> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23947048141
--===============6398938197273600736==--
