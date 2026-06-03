Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CAC3ABD88
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486912; cv=none; b=WCMIKHQyOFqtdnLDuYeGJxMn44GsymRctycOpz9Cie6rVbcG6o5N8KUurqZlCn3dhUjaB3pvZ2z6cnhr8ivje6V3JMq/BYRokxLG/yrg2ft3GeBV4ggN/h1/f5dN4Q1puxYvlz2fIp90hS+tvsB7xMBu+QcwYNCm0rb3+vaB5uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486912; c=relaxed/simple;
	bh=X4gPgLDUe2YMdmGdyynAmRsmkUl9cMB1OYy46EjKNAE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V01yNpDG71LJhFQP+H9OSEtfUnNkiuPHD+ElY4fBRCR0+OcK78WbQQfjKFarvPLTXP3nD7Qh9B/FsoA5CrBjQRfU8Df3plt8yJqI0S+rn0lRZ6iufDboxCCm8y+dde3pU6FSnCUonRm6H7O8qcgfvx0RPqwQYosFikuMFk6yG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1G1bYEt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1G1bYEt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB61C1F00898;
	Wed,  3 Jun 2026 11:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780486910;
	bh=neYIkg1eFHdAiblKDEgQoZCw3+Tmy1vu3n7d9m7/7/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e1G1bYEtUrhlnnbSYPEF1c5y6P+a22FrRq8R9cZJyGy5MM83Y0qOUuKDiy5p2qN9V
	 k5v2bRnSmRpJVgLrgKuKsGLiD5J6s2OSwEw3wG1a1Ifl51AKobyRLC1eggc/MIv9UC
	 aMVWpLYKa1ukMm7ZVXEBnGX6G9qyCHMaS0SsYb8gkPjqlgKvMCL0E17KktfVxi4CYa
	 kDb94W4YWsj9TKI8W/6LICiujVgeUlmu8daQqSpMMuoId8W7+SWZZvAnCt4HkfAORu
	 7Yuc4B/76cTMQVSDplpBmVNWn2nQ3HLbR0A2LE7nnE3Yb+LhyLjhE0tbfB6V9lC7ph
	 JdEUAOufI/nWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv7 bpf-next 13/29] bpf: Add support for tracing multi
 link
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603110554.29590-14-jolsa@kernel.org>
References: <20260603110554.29590-14-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 11:41:50 +0000
Message-Id: <20260603114150.AB61C1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch references multiple undefined symbols (`struct bpf_tracin=
g_multi_link`, `bpf_trampoline_multi_attach`, `bpf_trampoline_multi_detach`=
, and `is_tracing_multi`), which results in compilation failures.
--

commit 4e3377b79034e4eafa802e1a2382a4ca893a956f
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Add support for tracing multi link

This commit adds a new link type to allow attaching a BPF program to
multiple function BTF IDs. It introduces the tracing_multi configuration
fields in bpf_attr::link_create and implements the attachment logic.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 625a4366fe6d7..6f72ede0c8f04 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5842,6 +5842,8 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
>  			ret =3D bpf_iter_link_attach(attr, uattr, prog);
>  		else if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
>  			ret =3D cgroup_bpf_link_attach(attr, prog);
> +		else if (is_tracing_multi(prog->expected_attach_type))

[Severity: Low]
Is is_tracing_multi() defined anywhere in this series? It appears this might
cause an implicit declaration error during the build, as the function or ma=
cro
seems to be missing.

> +			ret =3D bpf_tracing_multi_attach(prog, attr);
>  		else
>  			ret =3D bpf_tracing_prog_attach(prog,

[ ... ]

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d853f97bd154f..9e3cb547651e5 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3641,3 +3642,132 @@ __bpf_kfunc int bpf_copy_from_user_task_str_dynpt=
r(const struct bpf_dynptr *dptr
>  }
> =20
>  __bpf_kfunc_end_defs();
> +
> +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && \
> +    defined(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS)
> +
> +static void bpf_tracing_multi_link_release(struct bpf_link *link)
> +{
> +	struct bpf_tracing_multi_link *tr_link =3D
> +		container_of(link, struct bpf_tracing_multi_link, link);
> +
> +	WARN_ON_ONCE(bpf_trampoline_multi_detach(link->prog, tr_link));

[Severity: Low]
Where is bpf_trampoline_multi_detach() declared? It looks like the declarat=
ion
and definition for this function are missing, which will break the build.

> +}

[ ... ]

> +int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr=
 *attr)
> +{
> +	struct bpf_tracing_multi_link *link =3D NULL;
> +	struct bpf_link_primer link_primer;
> +	u32 cnt, *ids =3D NULL;

[ ... ]

> +	err =3D check_dup_ids(ids, cnt);
> +	if (err)
> +		goto error;
> +
> +	link =3D kvzalloc_flex(*link, nodes, cnt);

[Severity: Low]
Is struct bpf_tracing_multi_link defined anywhere? Evaluating the size of an
incomplete type in this allocation macro will lead to a compiler error.

> +	if (!link) {
> +		err =3D -ENOMEM;
> +		goto error;
> +	}

[ ... ]

> +	link->nodes_cnt =3D cnt;
> +
> +	err =3D bpf_trampoline_multi_attach(prog, ids, link);

[Severity: Low]
Does bpf_trampoline_multi_attach() exist yet? Like the detach function, this
seems to be undeclared and undefined, leading to a build failure.

> +	kvfree(ids);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603110554.2959=
0-14-jolsa@kernel.org?part=3D1
