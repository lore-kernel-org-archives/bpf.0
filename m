Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3AA2F49EB
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771457516; cv=none; b=PDuUXfOJHkFbJVozhegom/OF3Vin4ropfdNRg+eCsAI57hCF+mr71xF7hRf93oSoPzmLf9McGDhhncST/l+C1S4K7yGgYAvabjJyzzok9tsLu06Xb7PnkKb88RklN2w8WtINA3yP0VMmF9XvsR6ajM977Yw8haRPiCRup/+pDJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771457516; c=relaxed/simple;
	bh=agd0ikoVpXg+TY2cNtX3b5wBEDU+fuy485PvnzLgdPA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iYw67NfLP4TfMye8s57R5qEbpm1af+tkxIhoJSCScDcnDmBVEWpfMNhEeS0zdfk+mAE+3QAHZCtw9jjDuzELzg9JcA0PDs3WE2Z86fvI+lV/tWw8XlkAbgFL8xCUikjMmDMJPjt9zE+9IYIRoF7zKCTcN2vyIzh41mPV6T04P5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmDJlXTF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmDJlXTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87508C116D0;
	Wed, 18 Feb 2026 23:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771457515;
	bh=agd0ikoVpXg+TY2cNtX3b5wBEDU+fuy485PvnzLgdPA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ZmDJlXTFJOqcFjoEQlEE2YDPygAO4Pqjgm+LFI4kYNlbBOHW6NZgVysW4gwadsvli
	 Skmx7cVa/erSsFHq2Ni8IcO79jd+1C+4HZ2xczVtc+4AJIH3lmythSwSYviUsT8/qe
	 rp+DJkTwwCHccs9Rl4QRVmUzwe/wuQZp+n1z01Ufwhyt1BR/YbP+gCIEFN+tYEgCYy
	 1/ru8QgPQWcD8QNs6SdtomPvzUcp5IT3By48TmEgigww+CJV6gorJrEz3fJmKn5qtU
	 nTi1fm4jYWzkJuQVswl7Xhja1xmb/OGsnv7QEG5GvtrzczpfKPANgxBYRe8SXoCnys
	 LTVDlnQtmOh5A==
Content-Type: multipart/mixed; boundary="===============0453736819729938488=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fc27e12e35a33703e0eb5d9d61b4e73496d4cf59eb4149c8b290c6bb55de7303@mail.kernel.org>
In-Reply-To: <20260218225617.354858-2-andrey.grodzovsky@crowdstrike.com>
References: <20260218225617.354858-2-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [RFC PATCH bpf-next 1/2] libbpf: Handle duplicate kprobe symbols in attach_kprobe_opts
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,jolsa@kernel.org,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 18 Feb 2026 23:31:55 +0000 (UTC)

--===============0453736819729938488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0c8bf0b5cce4..684781d25859 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> +/* Callback to find vmlinux kernel text symbol address, skipping module symbols */
> +static int find_kaddr_cb(unsigned long long sym_addr, char sym_type,
> +			 const char *sym_name, const char *module_name, void *ctx)
> +{
> +	struct find_kaddr_ctx *data = ctx;
> +
> +	/* Skip module symbols - we only want vmlinux symbols */
> +	if (module_name != NULL)
> +		return 0;
> +
> +	/* Only match text section symbols ('T' or 't') */
> +	if (sym_type != 'T' && sym_type != 't')
> +		return 0;
> +
> +	/* Check if this is the symbol we're looking for */
> +	if (strcmp(sym_name, data->func_name) == 0) {

[ ... ]

> +		data->kaddr = sym_addr;

[ ... ]

> +	return 0;
> +}

find_kaddr_cb() skips module symbols and only matches vmlinux text
symbols. If the duplicate symbols that triggered -EADDRNOTAVAIL
happen to both be in modules (no vmlinux counterpart),
find_kaddr_cb() never matches anything. libbpf_kallsyms_parse()
returns 0 (success) but kaddr_ctx.kaddr remains 0.

In bpf_program__attach_kprobe_opts(), there is no validation that
kaddr was actually found before proceeding with the retry (see
below).

> @@ -11654,6 +11727,8 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
>  	size_t offset;
>  	bool retprobe, legacy;
>  	int pfd, err;
> +	const char *optional_func_name = func_name;
> +	struct find_kaddr_ctx kaddr_ctx = { .kaddr = 0 };
>
>  	if (!OPTS_VALID(opts, bpf_kprobe_opts))
>  		return libbpf_err_ptr(-EINVAL);
> @@ -11684,21 +11759,22 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
>  		return libbpf_err_ptr(-EINVAL);
>  	}
>
> +retry_create:
>  	if (!legacy) {
>  		pfd = perf_event_open_probe(false /* uprobe */, retprobe,
> -					    func_name, offset,
> +					    optional_func_name, offset,
>  					    -1 /* pid */, 0 /* ref_ctr_off */);
>  	} else {
>  		char probe_name[MAX_EVENT_NAME_LEN];
>
>  		gen_probe_legacy_event_name(probe_name, sizeof(probe_name),
> -					    func_name, offset);
> +					    optional_func_name, offset);

On the retry path, optional_func_name is NULL. gen_probe_legacy_event_name()
passes this directly to snprintf() as a %s argument:

    snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx",
             getpid(), ..., name, offset);

Passing NULL for %s is undefined behavior. Could this be given a
fallback string, or could gen_probe_legacy_event_name() handle a NULL
name?

>
>  		legacy_probe = strdup(probe_name);
>  		if (!legacy_probe)
>  			return libbpf_err_ptr(-ENOMEM);
>
> -		pfd = perf_event_kprobe_open_legacy(legacy_probe, retprobe, func_name,
> +		pfd = perf_event_kprobe_open_legacy(legacy_probe, retprobe, optional_func_name,
>  						    offset, -1 /* pid */);

Similarly, when the retry path passes NULL as optional_func_name to
perf_event_kprobe_open_legacy(), its internal pr_warn() messages use
kfunc_name with %s:

    pr_warn("failed to add legacy kprobe event for '%s+0x%zx': %s\n",
            kfunc_name, offset, errstr(err));

This is the same undefined behavior if the legacy probe creation
fails on the retry attempt.

>  	}
>  	if (pfd < 0) {
> @@ -11707,6 +11783,46 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,

[ ... ]

> +		if ((err == -EADDRNOTAVAIL || (legacy && err == -EINVAL)) && optional_func_name) {

[ ... ]

> +			optional_func_name = NULL;
> +
> +			err = libbpf_kallsyms_parse(find_kaddr_cb, &kaddr_ctx);
> +			if (err) {
> +				pr_warn("failed to get addr for %s\n",
> +					func_name);
> +				goto err_out;
> +			}
> +
> +			pr_debug("retrying %s using kaddr 0x%llx\n",
> +				 func_name, kaddr_ctx.kaddr);
> +
> +			offset += kaddr_ctx.kaddr;
> +			goto retry_create;

When libbpf_kallsyms_parse() returns 0 but find_kaddr_cb() never
found a matching symbol, kaddr_ctx.kaddr is still 0. The code then
does offset += 0 and retries with optional_func_name == NULL, which
would attempt to probe at the user's original offset as an absolute
address (typically 0x0).

Would it make sense to check kaddr_ctx.kaddr != 0 before proceeding
with the retry?

Also, when the retry path is taken in legacy mode, the previous
legacy_probe allocation from strdup() is overwritten without being
freed when the goto jumps back to retry_create and enters the
legacy branch again:

    legacy_probe = strdup(probe_name);

Does the old legacy_probe need to be freed before goto retry_create
to avoid a memory leak?

> +		}
> +
>  		goto err_out;
>  	}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22161347107

AI-authorship-score: medium
AI-authorship-explanation: Verbose explanatory comments and structured commit message suggest possible AI assistance, but domain-specific fscanf format and kprobe knowledge suggest human involvement.
issues-found: 4
issue-severity-score: medium
issue-severity-explanation: Memory leak of legacy_probe on retry path, missing validation of kaddr lookup result leading to probing at address 0, and undefined behavior from NULL passed to printf %s in legacy retry path.

--===============0453736819729938488==--
