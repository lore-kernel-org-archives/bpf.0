Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CAD33E37B;
	Fri, 20 Feb 2026 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771585073; cv=none; b=MxDq8iauE4vJAT5+XacWYPGi6yAeSiuvbCszLhgqlSCk+y6hcaqLpCDmpKcbY9/St0yu2agCevE5MPtEIXeGM4lIb2DUfb0qAPCHpEJqBYyiczdd7qLvCvMqanR+vkhYiPgwJ93X1uKb0Zhokd2M0Hp1gY+RfOe3rYNmLFrJGYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771585073; c=relaxed/simple;
	bh=BZ1Qx0pz7T9XJwsw1OwN7tyBHdRtSZboopR749YYuY4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FkANVZOxDi0Tv+JguBWrXhwgCo50hrxjAXEKFyHWbHGK+/6yt7IN6WPVThfsyCKjD7fcGH4LXIryfzhn9kQJnDMK0DXx6jC4nCNsC8igiB3/xj25Scb7aVuZJoKUvVkEP+pRmZCUm/mlZewyeHS6NVlJaoDfJzXx9rp6LRATNEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HB9A3jg5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB9A3jg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176D3C116C6;
	Fri, 20 Feb 2026 10:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771585073;
	bh=BZ1Qx0pz7T9XJwsw1OwN7tyBHdRtSZboopR749YYuY4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=HB9A3jg5kH0PDxnt8EbOX9nLEqbM15jiJcFrEgcWA8NaXbXHx8WIDrwgqWjrGqEgE
	 4i1JhUE+TY68nUi08o0mj1s49unHawo3pbTeq3Junrab9KugmsECpBaUp8l+L/xfro
	 XD+GBv7NUrCeI0rBbULI4NqT+KaWKRpc0ltzXfWH0WxDcQzKfEzwkkjsWab5QJCozQ
	 lZYsUqQjFPlWWN83qjqmowAC+d9CsanSUflaNM5UNnAKZRAboR+Ny9LjXKpUypqtpA
	 iGbv2Tp3vrFjqaZn76I4a//Au1LX30YCzIdnmU0DGvj7qFpj1ySsvWOX3eux+ebZh6
	 1lyfY/YoF8HbA==
Content-Type: multipart/mixed; boundary="===============7466916940232166129=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <56ab264977d669e52dc1cbb2fa6224443cae58e723b4757ea59d21fd160f1b9f@mail.kernel.org>
In-Reply-To: <20260220100649.628307-12-jolsa@kernel.org>
References: <20260220100649.628307-12-jolsa@kernel.org>
Subject: Re: [PATCH bpf-next 11/17] libbpf: Add support to create tracing multi link
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 20 Feb 2026 10:57:53 +0000 (UTC)

--===============7466916940232166129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The provided <pattern> is used as 'pattern' argument in
> bpf_program__attach_kprobe_multi_opts function.

This isn't a bug, but the commit message references
bpf_program__attach_kprobe_multi_opts when the code actually calls
bpf_program__attach_tracing_multi. Looks like a leftover from
the kprobe_multi code this was modeled after.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> +struct bpf_link *
> +bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pattern,
> +				  const struct bpf_tracing_multi_opts *opts)
> +{
> +	LIBBPF_OPTS(bpf_link_create_opts, lopts);
> +	__u32 *ids, cnt, *free_ids = NULL;

cnt is declared as __u32 here, but collect_btf_func_ids_by_glob()
returns int. When that function returns a negative error such as
-ENOMEM, the value wraps to a large unsigned number.

> +	__u64 *cookies;
> +	int prog_fd, link_fd, err;
> +	struct bpf_link *link;

[ ... ]

> +	if (pattern) {
> +		err = bpf_object__load_vmlinux_btf(prog->obj, true);
> +		if (err)
> +			return libbpf_err_ptr(err);
> +
> +		cnt = collect_btf_func_ids_by_glob(prog->obj->btf_vmlinux, pattern, &ids);
> +		if (cnt < 0)
> +			return libbpf_err_ptr(cnt);

Since cnt is __u32, this comparison is always false. On an allocation
failure inside collect_btf_func_ids_by_glob(), the error is silently
ignored. That function also does free(*ids) before returning -ENOMEM,
so ids becomes a dangling pointer. The code then continues with a
freed ids pointer and a garbage cnt, and eventually double-frees ids
through the error label via free_ids.

Should cnt be declared as int instead of __u32?

> +		if (cnt == 0)
> +			return libbpf_err_ptr(-EINVAL);
> +		free_ids = ids;
> +	}

[ ... ]

> +error:
> +	free(link);
> +	free(free_ids);
> +	return libbpf_err_ptr(err);
> +}
> +
> +static int attach_tracing_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> +{
> +	bool is_fexit, is_fsession;
> +	const char *spec;
> +	char *pattern;
> +	int n;
> +
> +	/* Do not allow auto attach if there's no function pattern. */
> +	if (strcmp(prog->sec_name, "fentry.multi") == 0 ||
> +	    strcmp(prog->sec_name, "fexit.multi") == 0 ||
> +	    strcmp(prog->sec_name, "fsession.multi") == 0 ||
> +	    strcmp(prog->sec_name, "fentry.multi.s") == 0 ||
> +	    strcmp(prog->sec_name, "fexit.multi.s") == 0 ||
> +	    strcmp(prog->sec_name, "fsession.multi.s") == 0)
> +		return 0;
> +
> +	is_fexit = str_has_pfx(prog->sec_name, "fexit.multi/");
> +	is_fsession = str_has_pfx(prog->sec_name, "fsession.multi/");
> +
> +	if (is_fsession)
> +		spec = prog->sec_name + sizeof("fsession.multi/") - 1;
> +	else if (is_fexit)
> +		spec = prog->sec_name + sizeof("fexit.multi/") - 1;
> +	else
> +		spec = prog->sec_name + sizeof("fentry.multi/") - 1;

The sleepable variants with patterns don't seem to be handled here.
For a section name like "fentry.multi.s/my_func", none of the
str_has_pfx checks match because "fexit.multi/" and "fsession.multi/"
are not prefixes of "fentry.multi.s/..." (the character at position
11 or 14 is '.' not '/').

The else branch then computes spec using sizeof("fentry.multi/") - 1
which gives an offset of 13, pointing into "s/my_func" instead of
"my_func". The sscanf then extracts "s" as the pattern, and the
program attaches to any function matching the glob "s" rather than
"my_func".

Similarly for "fexit.multi.s/X" and "fsession.multi.s/X", the
offsets are wrong and produce either error returns or incorrect
patterns.

The SEC_DEF entries register all six sleepable variants, and
sec_def_matches() correctly distinguishes "fentry.multi.s+" from
"fentry.multi+" using the '/' separator check, so the matching
works but the pattern extraction here does not.

Would it work to also check for the ".s/" variants, for example:

    is_fexit = str_has_pfx(prog->sec_name, "fexit.multi/") ||
               str_has_pfx(prog->sec_name, "fexit.multi.s/");

with the corresponding sizeof adjustments for the spec offset?

> +
> +	n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
> +	if (n < 1) {
> +		pr_warn("tracing multi pattern is invalid: %s\n", spec);
> +		return -EINVAL;
> +	}
> +
> +	*link = bpf_program__attach_tracing_multi(prog, pattern, NULL);
> +	free(pattern);
> +	return libbpf_get_error(*link);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22220470181

AI-authorship-score: low
AI-authorship-explanation: Written by a well-known BPF maintainer with long contribution history; bugs are typical human copy-paste errors from modeling after existing kprobe_multi code, and the patch evolved through multiple RFC revisions on LKML.
issues-found: 3
issue-severity-score: medium
issue-severity-explanation: The __u32 cnt type bug creates dead error handling that can lead to a double-free under memory pressure, and the sleepable section parsing bug causes wrong functions to be attached silently; both affect correctness of a new public API.

--===============7466916940232166129==--
