Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E883451CC;
	Fri, 27 Feb 2026 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772227080; cv=none; b=Cf9vfW9s7o5zUwzIEDREMSp9qvHdLiyuCCDaPltSpt9FcKgSkwRF6qefVtEBoafhNIbrC9ju+Mx3Igk++JrlTIY5mef4p4Rz7LNF3KXefRuFczhUoQkXrhlwJEKPxaT5o9TTNh3frQjkY7WL62pnSzJYygmujDAqgIQtVKRiK2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772227080; c=relaxed/simple;
	bh=qSEa9ImM4nWeE9o4bCEWME8Gm2uFg9LDtjCLGnXzS2c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=i0CbFoGw5Fb8OtzwRzz1RBtXFZNB3w1IBUwcip4M9RxguAy+2gy++RcJFwM2eIWf8cKU36Pa9zx3oghnPf6FsSl6SRcq8iKscBHW6UPz3NCr8jhRyKPX5VUHYpm/sZJlPUrE21d28ld9BWbPcDc81/b9r8XsgRUel/PqgN+cfjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se5kcfgz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se5kcfgz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3228CC116C6;
	Fri, 27 Feb 2026 21:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772227080;
	bh=qSEa9ImM4nWeE9o4bCEWME8Gm2uFg9LDtjCLGnXzS2c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Se5kcfgz563R2FmYMH5h+3PcDpLGRuoInaPphVnOR+vS7Wo7Uf3LxKqfflShgG/jt
	 5A8ipPH4eXZuTj86+jcfT8ruKCHBvAsALn6WVkGWX2YOMdbXxYgW1xcxTOS4BGM1CJ
	 pgKBNag5nJBhg0fQ2gyQFGNAviayXtKGGkiIyBfxgqlgU5OMi+qFv+pzkxM0SWVIIo
	 Xatr+Ug9hLKY/QmTJFQg30uWlkApa9uUtGj1oNuDK/1rALf5KC2u16JQU6nMpIHeSk
	 0CFqGZNCyvVbggH8H1eLc7DS+Nf1bE8e6Efay342bv0ipTuQ08qznn0XElrnM0NkDW
	 A53SGUl/CSDmw==
Content-Type: multipart/mixed; boundary="===============4457659696450352404=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2d0e9de12b7bf49a0b5117da6d305b0e918785818b63798dfd85de1635b68e8b@mail.kernel.org>
In-Reply-To: <20260227204052.725813-2-andrey.grodzovsky@crowdstrike.com>
References: <20260227204052.725813-2-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [RFC PATCH bpf-next v3 1/3] libbpf: Optimize kprobe.session attachment for exact function names
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,linux-open-source@crowdstrike.com
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,jolsa@kernel.org,rostedt@goodmis.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 27 Feb 2026 21:17:59 +0000 (UTC)

--===============4457659696450352404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -12041,7 +12041,15 @@ struct kprobe_multi_resolve res = {
>  	if (addrs && syms)
>  		return libbpf_err_ptr(-EINVAL);
>
> -	if (pattern) {
> +	/*
> +	 * Exact function name (no wildcards): bypass kallsyms parsing
> +	 * and pass the symbol directly to the kernel via syms[] array.
> +	 * The kernel's ftrace_lookup_symbols() resolves it efficiently.
> +	 */
> +	if (pattern && !strpbrk(pattern, "*?")) {
> +		syms = &pattern;
> +		cnt = 1;
> +	} else if (pattern) {

When the fast path is taken here, unique_match is never checked.
The unique_match validation is inside the "else if (pattern)"
branch:

    if (unique_match && res.cnt != 1) {
        pr_warn("prog '%s': failed to find a unique match ...");
        err = -EINVAL;
        goto error;
    }

Before this change, a caller passing an exact function name with
unique_match = true would go through kallsyms parsing, which could
find multiple addresses for same-named static functions across
different translation units, and the unique_match check would
correctly return an error.

With the fast path, the name goes directly to the kernel's
ftrace_lookup_symbols(), which resolves only the first match via
kallsyms_callback() skipping duplicates:

    if (args->addrs[idx])
        return 0;

Should the fast path condition also check unique_match, for
example:

    if (pattern && !strpbrk(pattern, "*?") && !unique_match) {

This would preserve the optimization for the common case while
falling back to the slow path when unique_match is explicitly
requested.

> [ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22503275616

AI-authorship-score: medium
AI-authorship-explanation: Comments are unusually verbose for a simple optimization, and the commit message is well-structured with distinct sections, but the iterative v1-v3 refinement following reviewer feedback is typical of human development.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The fast path bypasses the unique_match check, which could silently attach to the wrong function among same-named statics, but requires the uncommon combination of unique_match=true with an exact name matching multiple kernel functions.

--===============4457659696450352404==--
