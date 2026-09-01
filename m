Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AA24734D0;
	Tue,  1 Sep 2026 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256458; cv=none; b=UtFsntDXwyBn4VpbTUv5wcwfc/OJyPgfuVNaaPgUZ02wjvQFm7M88fuGiRMggTFVW+bA7l4F75hXMURh9pecbmeXshQGBS0bwtHCEuJJPec+ebGenQs5+KmkZu34rxMJq6tiXptZlH+aiZ9SBJJXY4zgK1nsbgU5snW3Y12eBmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256458; c=relaxed/simple;
	bh=Ile7kTUi57swMXIyWhgZMTRiwCfLcDArXeDmL9zIFNc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=D3QGzceOUzE5e4bGE8Ar/ThD4vqef9Za9i3eoCzZ+Q3r7BQBYEmOwe2MUMmG2TFZhsjtEkJwqvSRjwXdUUXU81wE0VyuyBJl6w5OaheYDDPLF2Ow//4aO3hHyp4ZViiMktogB6Wo/Av59yGQNdlTA2ST3FCEsO9hnpZnsIghhYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk+gOFZi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk+gOFZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1A61F00A3D;
	Tue,  1 Sep 2026 09:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788256457;
	bh=nwB6y/u7us3tN3IaUgCp0jfclCoh9XAOe815MX3+oOI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Dk+gOFZiy7LZV9IZjXtm2L+5QNN5Z/IJLx5huaYBZCtbeuplJUmiSHlErh7hDWiem
	 qaSinF4ekDCjEliekQQeAxOb1SXZuYpp+2WeVqXq2QT6cVxOsns0nT17v6hOLr7Nx4
	 W5MADL92ScWQV1yuey7GLT+2+EnCE0OLBzazF4hLll8bVYm7KahqGSEDuahCreq1fQ
	 krUSTeOXKaVvfl3yc+dOXgRc9ufMJSlQDO0/OPeLCyMZup5LC2+5WqfP8EQi8jpQ2J
	 2y3uIyeUtiP3OrY75dYwHgZNQ8nmpH68dQS/y1JysYN0G9K7eHDjasEL5vlnHs8+aJ
	 cNMvhZC//JYgQ==
Content-Type: multipart/mixed; boundary="===============7831815785475501820=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <140ef9fa6dc454d62eaf49b168850890f1617fba462dcc37288747f6fbc7dae8@mail.kernel.org>
In-Reply-To: <20260901-libbpf-frags-flags-v3-3-4eb6f14968b0@redhat.com>
References: <20260901-libbpf-frags-flags-v3-3-4eb6f14968b0@redhat.com>
Subject: Re: [PATCH bpf-next v3 3/4] libbpf: Move section-defined program flags to prog_flags
From: bot+bpf-ci@kernel.org
To: toke@redhat.com,qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,larysa.zaremba@intel.com,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,lorenzo@kernel.org
Cc: bpf@vger.kernel.org,netdev@vger.kernel.org,toke@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 09:54:16 +0000 (UTC)

--===============7831815785475501820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index f09cbfd8e729d..c036e8a91ed88 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7879,6 +7879,19 @@ static int tracing_multi_mod_fd(struct bpf_program *prog, int *btf_obj_fd)
>  	return 0;
>  }
>
> +static int libbpf_setup_prog_flags(struct bpf_program *prog, long cookie)
> +{
> +	enum sec_def_flags def = cookie;
> +
> +	if (def & SEC_SLEEPABLE)
> +		prog->prog_flags |= BPF_F_SLEEPABLE;
> +
> +	if (def & SEC_XDP_FRAGS)
> +		prog->prog_flags |= BPF_F_XDP_HAS_FRAGS;
> +
> +	return 0;
> +}
> +
>  /* this is called as prog->sec_def->prog_prepare_load_fn for libbpf-supported sec_defs */
>  static int libbpf_prepare_prog_load(struct bpf_program *prog,
>  				    struct bpf_prog_load_opts *opts, long cookie)
> @@ -7889,12 +7902,6 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
>  	if ((def & SEC_EXP_ATTACH_OPT) && !kernel_supports(prog->obj, FEAT_EXP_ATTACH_TYPE))
>  		opts->expected_attach_type = 0;
>
> -	if (def & SEC_SLEEPABLE)
> -		opts->prog_flags |= BPF_F_SLEEPABLE;
> -
> -	if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
> -		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
> -

Does this change break bpf_program__clone() when the caller passes
non-zero opts.prog_flags?

Before this patch, libbpf_prepare_prog_load() OR'd in the section flags
after the caller's override:

    /* in bpf_program__clone() */
    attr.prog_flags = OPTS_GET(opts, prog_flags, 0) ?: prog->prog_flags;
    ...
    prog->sec_def->prog_prepare_load_fn(prog, &attr, ...);

    /* in libbpf_prepare_prog_load() */
    if (def & SEC_SLEEPABLE)
        opts->prog_flags |= BPF_F_SLEEPABLE;

So a caller doing:

    LIBBPF_OPTS(bpf_prog_load_opts, opts, .prog_flags = BPF_F_TEST_STATE_FREQ);
    fd = bpf_program__clone(prog, &opts);

would get TEST_STATE_FREQ | SLEEPABLE for a program in SEC("fentry.s/...").

After this patch, the flags live only in prog->prog_flags, and the `?:`
in bpf_program__clone() discards prog->prog_flags entirely when the
caller passes non-zero opts.prog_flags:

    attr.prog_flags = OPTS_GET(opts, prog_flags, 0) ?: prog->prog_flags;
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                      returns TEST_STATE_FREQ, prog->prog_flags is ignored

So the same caller now gets only TEST_STATE_FREQ without SLEEPABLE. For
sleepable-only helpers like bpf_copy_from_user, this produces a verifier
rejection. For BPF_PROG_TYPE_SYSCALL, which requires prog->sleepable,
it fails at load. For xdp.frags programs, BPF_F_XDP_HAS_FRAGS is lost.

Looking at the pattern immediately below in the same function:

    if (attr.token_fd)
        attr.prog_flags |= BPF_F_TOKEN_FD;

should the section flags be OR'd in unconditionally, or should the
caller-override `?:` be removed for prog_flags? The commit message
mentions bpf_program__set_flags() and bpf_program__set_type() as
affected APIs but doesn't mention bpf_program__clone().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33489985893
--===============7831815785475501820==--
