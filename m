Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A536F434
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700613; cv=none; b=HwbtONWmEdOnZwdYTViQZVV5MSVbmbfWV8FEOfNOJiUUnNhUwwBYgeOTCK+Ttnkrhkw0QkMR6UMMQRDIBHMMhleHxz/bkV5JhtbO+qz+wipIfeC/LVxPM8DMu0EnNMRBSGDuIG+OxIciHRxUIkCtnNII5syaEzqZF0qaZg7OxjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700613; c=relaxed/simple;
	bh=sgOri5QTXE9qk/EwB+iL7c8r2tp5w5CfQcXHCznh3LI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=E2aQH0b+OC7j1IhR3SpZhwCz9m3p9B05065EaC2xxRyoIgnFBxQbi3tQw1xmvx8nzWJRVHKrbN25znme9mM3igQ5FUWEejJfUiwMbRJTAC3SAZz/jyG3pKf30SWLg84JVcv0ORR00swWTwSf5fbjXb8OzGLA28hUqNjXjDJnqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFgqRQpS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFgqRQpS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF7EC19421;
	Mon, 16 Mar 2026 22:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773700612;
	bh=sgOri5QTXE9qk/EwB+iL7c8r2tp5w5CfQcXHCznh3LI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=WFgqRQpSV7YtNXFQFtPX1e4WkeKaMbNbmulSTUVzZ076foHuK7WzfKrXYgHEn/zY+
	 cmnLW/hKE9YUw2FqIa/bEag2+PTKlhFFNxXeOWZ81U0ClsZ/gybDrAHcH0NvD+OdsM
	 vFHoOnt41hoCJle5euEvghphjKK4qeEDNOOKktR+y+FwR+QD1kM/KtNH6zwEYXrxN5
	 PjguFC254jT3OlUuskxctnfcwEh3qxtX6Ic5M420vdtaGaRGgI1zgDqBEjI9+W1pMv
	 uiFzPU9wEZUOnJIjmfVF/khbulaZMGIhH6i1PP85Wdyr4HqWovWNO8lvSCZgyfLZv5
	 Ee5Dq3MP70taQ==
Content-Type: multipart/mixed; boundary="===============5393731023955883849=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <26086ca2aeee46cd545ae1f44e5ef0a2f387c367b2aa776c9fa7d333897d663b@mail.kernel.org>
In-Reply-To: <20260316-veristat_prepare-v3-1-94e5691e0494@meta.com>
References: <20260316-veristat_prepare-v3-1-94e5691e0494@meta.com>
Subject: Re: [PATCH bpf-next v3 1/2] libbpf: Introduce bpf_program__clone()
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 16 Mar 2026 22:36:52 +0000 (UTC)

--===============5393731023955883849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Non-zero fields in
> opts override the defaults derived from the program and object
> internals; passing NULL opts populates everything automatically.

This claim in the commit message does not hold for all fields.
For SEC_ATTACH_BTF programs (fentry, fexit, fmod_ret, lsm) where
bpf_program__set_attach_target() has not been called before clone,
prog->attach_btf_id is 0 after bpf_object__prepare().

The prog_prepare_load_fn callback (libbpf_prepare_prog_load) runs
after the opts merging and checks !prog->attach_btf_id -- not the
merged opts value.  When it finds prog->attach_btf_id == 0, it
resolves BTF from sec_name and overwrites opts->attach_btf_id:

tools/lib/bpf/libbpf.c:libbpf_prepare_prog_load() {
    ...
    if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
        ...
        err = libbpf_find_attach_btf_id(prog, attach_name,
                                        &btf_obj_fd, &btf_type_id);
        ...
        prog->attach_btf_id = btf_type_id;
        opts->attach_btf_obj_fd = btf_obj_fd;
        opts->attach_btf_id = btf_type_id;
    }
    ...
}

So if a caller passes a non-zero attach_btf_id in opts, this callback
silently overwrites it with the sec_name-based resolution.  Could the
commit message note this exception, or should the callback check the
already-merged opts value before resolving?

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0662d72bad20..0f6b9e773c52 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> +int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts *opts)
> +{
> +	LIBBPF_OPTS(bpf_prog_load_opts, attr);
> +	struct bpf_object *obj;
> +	int err, fd;

[ ... ]

> +	/* Copy caller opts, fall back to prog/object defaults */
> +	attr.expected_attach_type =
> +		OPTS_GET(opts, expected_attach_type, 0) ?: prog->expected_attach_type;
> +	attr.attach_btf_id = OPTS_GET(opts, attach_btf_id, 0) ?: prog->attach_btf_id;
> +	attr.attach_btf_obj_fd = OPTS_GET(opts, attach_btf_obj_fd, 0) ?: prog->attach_btf_obj_fd;

The comment "Copy caller opts, fall back to prog/object defaults"
is also not quite right for these fields, since the callback below
can overwrite whatever was merged here.

> +	attr.attach_prog_fd = OPTS_GET(opts, attach_prog_fd, 0) ?: prog->attach_prog_fd;

[ ... ]

> +	/* Resolve BTF attach targets, set sleepable/XDP flags, etc. */
> +	if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
> +		err = prog->sec_def->prog_prepare_load_fn(prog, &attr, prog->sec_def->cookie);
> +		if (err)
> +			return libbpf_err(err);
> +	}

This callback also mutates prog->attach_btf_id, prog->attach_btf_obj_fd,
and potentially prog->expected_attach_type as a side effect.  Since
bpf_program__clone() is designed to be called multiple times for the
same program, it may be worth noting in the API documentation that the
first call can modify prog state through this callback.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23168321532
--===============5393731023955883849==--
