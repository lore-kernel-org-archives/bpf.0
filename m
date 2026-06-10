Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F762421EE0
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103857; cv=none; b=MxvSeX689rEsZix2ptW+z16/Y+F2Jw1Z/Eu1zzTXuxmS0TN7dyxftj0f1KISxPektx9TkQHDJWBSx7Y4bmzonRZe6YbYpz7RWWMj4yr/nZjye/TstjtnnSajAOqW8C76m1mKrLA/S3KpNjzRvLhVtIY5lgD1dT0+D2wZyfVmkj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103857; c=relaxed/simple;
	bh=c/7TkxqKGdvK14xyggfF7AXa18MJI9sctEVSWkAWf6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YoefAECJnUlZK9ANGGqBuUCSv9Yn62Z36XQvndNiyRkTEfuPJ5/vq0AFXwEVVNzI/E20xGibcQm6hHntFjRUiSsqhjKpC9xPtg5qwLfNPLBiYlrJBjpe67nH7Aozr3md7XgfQKYPYpKRsVfZUnIMDXq2/hmvTMiemYufuiukelA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftrWKmGx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftrWKmGx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F315F1F00893;
	Wed, 10 Jun 2026 15:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781103856;
	bh=P2tW3AjxDTa1vR/2hgBrs43Onz/e5e6ykRh32mN7lr0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ftrWKmGxByOrRYm5qRQplk8H7eftrNK+DQLmfFmckUAjay9GI1IKR26AMxeEGyu3I
	 MqrQCxTR4KEeunI9gI2r9XUHLp2SwhjjuGkDfjeJsjfcfcAKcX1kAvxI8/n/++kOae
	 kMNPtV/lkvhA0x0YAaOoFfhzjyiVJPKi+/sfl+md+WdeVlboJC8mFRbEsG2IgbsNTM
	 fm8FDy+zmxspwfrRESatYp1Ct+tJkXtolNkKgNJs3hIUdJjJWGfVEFa3572Q3tLBjc
	 qHSWsQ6wAG/flRerXtPbCirI/YoBxE8wqz1JWmcoCh03QfZ2ikfDDhZk77TIoRHz6s
	 cWoeAxCSZVp9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] libbpf: fetch probeable prog type from
 token for feature probes
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260610145059.113412-3-chenyuan_fl@163.com>
References: <20260610145059.113412-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 15:04:15 +0000
Message-Id: <20260610150415.F315F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Feature probes for FEAT_BPF_COOKIE and FEAT_PROBE_READ_KERN will u=
nconditionally fail because they test helpers unsupported by the dynamicall=
y selected BPF_PROG_TYPE_SOCKET_FILTER.
--

commit 0109a2d3173a7dbf585e1f1ba9c12c5a9120c9eb
Author: Yuan Chen <chenyuan@kylinos.cn>

libbpf: fetch probeable prog type from token for feature probes

This commit updates feature probes to dynamically select a program type
based on the provided BPF token instead of hardcoding SOCKET_FILTER or
TRACEPOINT. If no token is provided, it defaults to SOCKET_FILTER.

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b7e388f99d0bb..f008ee50e2466 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c

[ ... ]

> @@ -257,8 +318,13 @@ static int probe_kern_probe_read_kernel(int token_fd)
>  		BPF_EXIT_INSN(),
>  	};
>  	int fd, insn_cnt =3D ARRAY_SIZE(insns);
> +	int prog_type;
> =20
> -	fd =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn=
_cnt, &opts);
> +	prog_type =3D token_probeable_prog_type(token_fd);
> +	if (prog_type < 0)
> +		return 1;
> +
> +	fd =3D bpf_prog_load(prog_type, NULL, "GPL", insns, insn_cnt, &opts);

[Severity: High]
Will this unconditionally fail the probe for FEAT_PROBE_READ_KERN?

If no token is provided, or the token allows SOCKET_FILTER,
token_probeable_prog_type() returns BPF_PROG_TYPE_SOCKET_FILTER.

Because SOCKET_FILTER does not support the bpf_probe_read_kernel helper,
the verifier will reject the load with an unknown func error.

Does this result in libbpf falsely reporting the feature as missing for
all applications?

[ ... ]

> @@ -435,8 +507,13 @@ static int probe_kern_bpf_cookie(int token_fd)
>  		.prog_flags =3D token_fd ? BPF_F_TOKEN_FD : 0,
>  	);
>  	int ret, insn_cnt =3D ARRAY_SIZE(insns);
> +	int prog_type;
> =20
> -	ret =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, ins=
n_cnt, &opts);
> +	prog_type =3D token_probeable_prog_type(token_fd);
> +	if (prog_type < 0)
> +		return 1;
> +
> +	ret =3D bpf_prog_load(prog_type, NULL, "GPL", insns, insn_cnt, &opts);

[Severity: High]
Similarly, will this break the FEAT_BPF_COOKIE probe?

If prog_type resolves to BPF_PROG_TYPE_SOCKET_FILTER, it will not support
the bpf_get_attach_cookie helper being tested here, causing the verifier
to reject the probe program.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610145059.1134=
12-1-chenyuan_fl@163.com?part=3D2
