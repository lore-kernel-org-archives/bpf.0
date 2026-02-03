Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D0241665;
	Tue,  3 Feb 2026 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113644; cv=none; b=S78FlBtynkho2eOOnCCfyMtAHjWDyUqrPMtRBvKAF4V+Fp/QOwDFBHUQcWFln0/Pfps5yAxW6JgcqF5ulX6zaZHQxA2NtInx8oYucYIE2AoFurU5ZPPMMFX2qaZMkdSW2F1mv6UA6g0ty3SDkTYvLJ6BLLgEXSr4q5U2g1xDKSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113644; c=relaxed/simple;
	bh=a95bCYVZNHnwNGshFP5zAsHsBfRps5vXxmAS+fYJJNM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EnIXeKQHqMsrspXK/4bqdyYF/rI7QdQlEPxsMNXKWouEfUurULs8yaQFaEt3a0sbfysVdVxRxxpcWtZOs+QeTdxpzIFR/PWs1TKv5KHV0csakg75pD3nmNZ7RaMpxv86JbWqcLNr74uoK+uKWtZEEDLaCjuOfCJQLs9lU6mWhrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ega2Z0tM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ega2Z0tM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C110EC116D0;
	Tue,  3 Feb 2026 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770113644;
	bh=a95bCYVZNHnwNGshFP5zAsHsBfRps5vXxmAS+fYJJNM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Ega2Z0tMvl6HkCOgIJvbVDmIywM0T6AW0owaUXk/JiHxTGjWS77p1FGZcAXNN6lyA
	 c5jXP/MFDWkZ7mQQs6KLsfRLMEafl+8/D3vL3rk5WuFqxDWT85F+VtWg6hjxPIAeME
	 pRXxXjdpoLxFfcUnM92ua6QIIrIeaE/jt2De6iWxVziqwDnsdoqvOcIQwIXPZXZTWN
	 gvMKNbyuPK+K38+OudKChnnp3Lm7yl6eSnszB247V+1IocUNzCZL/WtS4O80U8/jCg
	 YKAUTFjoRjJAEV5nTVRS+Baiwt3Tc0A9RKNhRBe36qhuq9kC1eP6pNiAC+cLWA+Q8b
	 lWV0NJopYPMDw==
Content-Type: multipart/mixed; boundary="===============1783507459544833468=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9c8e4f31ee1d79f8ae145ec1c4d388f0829a77f1a75e8ec80e1d4bcf00bde751@mail.kernel.org>
In-Reply-To: <20260203093819.2105105-10-jolsa@kernel.org>
References: <20260203093819.2105105-10-jolsa@kernel.org>
Subject: Re: [RFC bpf-next 09/12] libbpf: Add support to create tracing multi link
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Feb 2026 10:14:03 +0000 (UTC)

--===============1783507459544833468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0c8bf0b5c..a16243300 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> +struct bpf_link *
> +bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pattern,
> +				  const struct bpf_tracing_multi_opts *opts)
> +{
> +	LIBBPF_OPTS(bpf_link_create_opts, lopts);
> +	__u32 *btf_ids, cnt, *free_ids = NULL;
> +	int prog_fd, link_fd, err;
> +	struct bpf_link *link;
> +
> +	btf_ids = OPTS_GET(opts, btf_ids, false);
> +	cnt = OPTS_GET(opts, cnt, false);
> +
> +	if (!pattern && !btf_ids && !cnt)
> +		return libbpf_err_ptr(-EINVAL);
> +	if (pattern && (btf_ids || cnt))
> +		return libbpf_err_ptr(-EINVAL);
> +
> +	if (pattern) {
> +		err = bpf_object__load_vmlinux_btf(prog->obj, true);
> +		if (err)
> +			return libbpf_err_ptr(err);
> +
> +		cnt = btf__find_by_glob_kind(prog->obj->btf_vmlinux, BTF_KIND_FUNC,
> +					     pattern, NULL, &btf_ids);
> +		if (cnt <= 0)
> +			return libbpf_err_ptr(-EINVAL);
> +		free_ids = btf_ids;
> +	}
> +
> +	lopts.tracing_multi.btf_ids = btf_ids;
> +	lopts.tracing_multi.btf_ids_cnt = cnt;
> +
> +	link = calloc(1, sizeof(*link));
> +	if (!link)
> +		return libbpf_err_ptr(-ENOMEM);

If calloc fails here and pattern was provided, btf__find_by_glob_kind() will
have allocated btf_ids (tracked by free_ids). Does this leak free_ids? The
error label below frees it properly, but this return bypasses that path.

Something like:

    if (!link) {
        free(free_ids);
        return libbpf_err_ptr(-ENOMEM);
    }

or using goto error would fix this.

> +	link->detach = &bpf_link__detach_fd;
> +
> +	prog_fd = bpf_program__fd(prog);
> +	link_fd = bpf_link_create(prog_fd, 0, prog->expected_attach_type, &lopts);
> +	if (link_fd < 0) {
> +		err = -errno;
> +		pr_warn("prog '%s': failed to attach: %s\n", prog->name, errstr(err));
> +		goto error;
> +	}
> +	link->fd = link_fd;
> +	free(free_ids);
> +	return link;
> +error:
> +	free(link);
> +	free(free_ids);
> +	return libbpf_err_ptr(err);
> +}
> +
> +static int attach_tracing_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> +{
> +	const char *spec;
> +	char *pattern;
> +	bool is_fexit;
> +	int n;
> +
> +	/* no auto-attach for SEC("fentry.multi") and SEC("fexit.multi") */
> +	if (strcmp(prog->sec_name, "fentry.multi") == 0 ||
> +	    strcmp(prog->sec_name, "fexit.multi") == 0)
> +		return 0;
> +
> +	is_fexit = str_has_pfx(prog->sec_name, "fexit.multi/");
> +	if (is_fexit)
> +		spec = prog->sec_name + sizeof("fexit.multi/") - 1;
> +	else
> +		spec = prog->sec_name + sizeof("fentry.multi/") - 1;
> +
> +	n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
> +	if (n < 1) {
> +		pr_warn("tracing multi pattern is invalid: %s\n", pattern);

When sscanf fails to match (n < 1), pattern is never assigned because %m only
allocates on successful match. Should this print spec instead of the
uninitialized pattern? Compare with attach_kprobe_multi() which uses:

    pr_warn("kprobe multi pattern is invalid: %s\n", spec);

> +		return -EINVAL;
> +	}
> +
> +	*link = bpf_program__attach_tracing_multi(prog, pattern, NULL);
> +	return libbpf_get_error(*link);

Is pattern being leaked here? sscanf with %m allocates the string, but there
is no free(pattern) before returning. Compare with attach_kprobe_multi():

    *link = bpf_program__attach_kprobe_multi_opts(prog, pattern, &opts);
    free(pattern);
    return libbpf_get_error(*link);

> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21625440628

AI-authorship-score: low
AI-authorship-explanation: The commit contains typical human copy-paste errors (forgetting to add free(), using wrong variable in error message) and a minor grammatical mistake, suggesting human authorship.
issues-found: 3
issue-severity-score: medium
issue-severity-explanation: Memory leaks on every use of fentry.multi/fexit.multi auto-attach and potential undefined behavior from using uninitialized variable in error path.

--===============1783507459544833468==--
