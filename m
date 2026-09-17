Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476AD4A2047
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680890; cv=none; b=KQmAFkiNkxJqGLU4SwVdYdnC7i9bxsEJdlCgSPnMICQj5jV1LgdfbiDxVDIdagkxXNzVMV0xbIfGxhBG69UwgFzIpVrLHiNAUdkuukHBH0OXUzC4HlTzPUE4ClSINpQvb/zNNXaxv5Yi1nK6mM920ib+vSnO3O3roTzNbrIbCT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680890; c=relaxed/simple;
	bh=YXbg23fGpyab2QpXG6wr2CU8mfUa7VjnqRGJS4c6az4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kntmocfjErC17DnXcDPdB8juZaQg+jpD658RQsHXcIrPeXnuLGWmLUbRfQKC7OdFGyCUpbAlo2MADXK5qKe5CKiGHXCcST8EcXddVsVsXM3co8J2mwEYDByld46DjQLxfoysmLpJJUwUnZcPMBn10w17XPzNKE609+UVrxNuE6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2JA5G+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2JA5G+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A841F000FF;
	Thu, 17 Sep 2026 21:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680888;
	bh=cHk0loZvo8IHKRPkBRtBzKVhY9ee8U/LKs9mmvEORl0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=X2JA5G+MeyV7R9OitTh0A46nKK8tGdUV2iqBki2B4X09hR6T7S+G09mDeu+Dlyqq6
	 unI38/8AF96GT/9YE/97aQfVFM7PN1JExMmcteOHqSoSZ+4lX9mauMTDuqMaQPU50c
	 tJjH3eRq8OhlIgC9nuoXDWJ20b+2Gnh1WDOnKbEd9LHQPfOCJB39HJufYqTvVfc5oL
	 BepjkVnE+MghixzdPX8lO66yQYWydeLMv6Oapb0NzOBWAb4a8aRtZJ+4yg9u8bRB5V
	 CfcnC0BvEbfDsLMzitAscQgt+OCmxluG1az20/hHfXj6coykMgfNi/yiA8dC1iMrx0
	 H6/IcDCVgyhqw==
Content-Type: multipart/mixed; boundary="===============1540645368260883315=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <37e3c48e661282c3701e5105ed732429bd97c516aba1ae1bf0474e44f40aa19d@mail.kernel.org>
In-Reply-To: <20260917203040.3150212-4-andrey.grodzovsky@crowdstrike.com>
References: <20260917203040.3150212-4-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v3 3/6] libbpf: Support declarative manual load via SEC("!...") prefix
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org
Cc: ast@kernel.org,martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 21:34:48 +0000 (UTC)

--===============1540645368260883315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index acb8caffa442e..c9a184d9626db 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -872,16 +872,25 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
>  	/* libbpf's convention for SEC("?abc...") is that it's just like
>  	 * SEC("abc...") but the corresponding bpf_program starts out with
>  	 * autoload set to false.
> +	 *
> +	 * Similarly, SEC("!abc...") marks the program for manual loading:
> +	 * it is skipped by the bulk auto-load pass and must be explicitly
> +	 * loaded later via bpf_program__load_manually().
>  	 */
>  	if (sec_name[0] == '?') {
>  		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_DISABLED;
>  		/* from now on forget there was ? in section name */
>  		sec_name++;
> +	} else if (sec_name[0] == '!') {
> +		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_MANUAL;
> +		/* from now on forget there was ! in section name */
> +		sec_name++;
>  	} else {
>  		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_AUTO;
>  	}

The declarative SEC("!...") path sets BPF_PROG_LOAD_STRATEGY_MANUAL here in
bpf_object__init_prog(), which runs during bpf_object__open(). But the
imperative API enforces a gen_loader guard when switching to MANUAL:

tools/lib/bpf/libbpf.c:bpf_program__set_load_strategy() {
    case BPF_PROG_LOAD_STRATEGY_MANUAL:
            /*
             * Manually-loaded programs are not supported for gen_loader.
             * This is because bpf_object_load_prog is not called for
             * manually-loaded programs, so such programs are not visible
             * to gen_loader. ...
             */
            if (obj->gen_loader)
                    return libbpf_err(-EOPNOTSUPP);
}

The ordering makes that guard unreachable for SEC("!prog"): this code
runs before obj->gen_loader is installed by bpf_object__gen_loader().

Can this sequence occur?

    SEC("!prog")
    bpf_object__open()
        -> bpf_object__init_prog() sets MANUAL
    bpf_object__gen_loader() installs gen_loader
    bpf_object__load()
        -> skips prog (pr_debug), undercounts gen->nr_progs
        -> bpf_gen__finish() wires wrong FDs into skeleton

bpf_object__gen_loader() does not check whether any programs are already
MANUAL:

tools/lib/bpf/libbpf.c:bpf_object__gen_loader() {
    ...
    if (!OPTS_VALID(opts, gen_loader_opts))
            return libbpf_err(-EINVAL);
    gen = calloc(1, sizeof(*gen));
    ...
    obj->gen_loader = gen;
    return 0;
}

So a MANUAL program set via SEC("!...") is silently accepted with
gen_loader, while the same program marked via the imperative API would be
rejected.

The commit message in commit 2ebb83ef300359043b537ca514069942624cc2b8
("libbpf: Reject gen_loader for objects with already-manual programs")
later in the series documents exactly this failure mode. Should that guard
be part of this commit to avoid introducing and then fixing the same issue
within the series?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35272462686
--===============1540645368260883315==--
