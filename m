Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D75371898
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776502720; cv=none; b=op0nfYixe1Io9SBtqtsU02DlHskdi3iuQrXBU7lQU141QedYhsYuIiswaYpGMXu8VlyuVh6IvUxBmb+ptmF5T67eIyv26DMhY9VR+udOWjFXilsDlm0jzqDCyQMBd0ZcHByCm73e6UuhMWbDTYtxF5nnbCaG0VzMBPxOlHrq0ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776502720; c=relaxed/simple;
	bh=A2C7fUhpsU97e5BBgMmlvP62B4h6UYXpUs8KSs9Dsiw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jVp+ILyC6UE83lQdoQz97wmdKx5I2hcS1kDSadCUOMNkESIZWDmR3xKXO6crCdaI22KrwCInWGZKej9xEDpLv0SDTI/rW+UDMg42B7PF1pF8bqaFa1sffQ1ewR2WC/vWYoJE1KZSfw0Fuaj4jSn0yI5dvcRelgeEhUKh88ArcIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KioMhmDc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KioMhmDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC19C19424;
	Sat, 18 Apr 2026 08:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776502719;
	bh=A2C7fUhpsU97e5BBgMmlvP62B4h6UYXpUs8KSs9Dsiw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KioMhmDcF2jiQ36axEyg2xKjpShgShAcqN9A7hId0L4idlI1WylpiwWnN0DcP6G4d
	 mtBY43caa8I+xoxoSTVcDQiPVPBiZHQfhIEWW/o5E2ojG5rIL3MoWzxjSewLKJDnvu
	 SMmo18/x4Z9Pakx9ETsrB9hf8BskF4C0dLKEPhHzdHsiIflhFx/PTVpRC+BnTucUzn
	 dUB7TSMsr0DkwBFaXiJztj0YElxmQefVfLOMu67CkzUqVDfELbrRt21iGYaJPFyNxK
	 NUeRuSbYBKagYyNaU6jIp+ZGJokFAqpFlti7jzCdW9WRcYXlDZfidMlQtc8D43ISAa
	 bAZIHVxXE14Lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv5 bpf-next 13/28] bpf: Add support for tracing multi
 link
Reply-To: sashiko@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417192502.194548-14-jolsa@kernel.org>
References: <20260417192502.194548-14-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 08:58:39 +0000
Message-Id: <20260418085839.ADC19C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] The patch references several undeclared identifiers and incomplete =
types, causing compilation failures.
--

commit fc7697083b71bebef41d2da3a91ca2a0741ad6f0
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Add support for tracing multi link

Adding a new link to allow attaching a BPF program to multiple function
BTF IDs, represented by struct bpf_tracing_multi_link.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a3c0214ca9341..da3e01dd7ee9a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
[ ... ]
> @@ -5748,6 +5748,8 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
>  			ret =3D bpf_iter_link_attach(attr, uattr, prog);
>  		else if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
>  			ret =3D cgroup_bpf_link_attach(attr, prog);
> +		else if (is_tracing_multi(prog->expected_attach_type))
> +			ret =3D bpf_tracing_multi_attach(prog, attr);

Is is_tracing_multi() defined anywhere? It doesn't appear to be declared
in this patch or the existing kernel tree, which could lead to a build
failure.

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index af7079aa0f36d..df06a733a2e71 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
[ ... ]
> +static void bpf_tracing_multi_link_release(struct bpf_link *link)
> +{
> +	struct bpf_tracing_multi_link *tr_link =3D
> +		container_of(link, struct bpf_tracing_multi_link, link);
> +
> +	WARN_ON_ONCE(bpf_trampoline_multi_detach(link->prog, tr_link));
> +}

Where is struct bpf_tracing_multi_link defined? It seems to be an
incomplete type here.=20

Similarly, bpf_trampoline_multi_detach() doesn't appear to be declared in
this patch. Will this cause compilation errors when dereferencing or
calling these?

[ ... ]
> +	err =3D bpf_link_prime(&link->link, &link_primer);
> +	if (err)
> +		goto error;
> +
> +	link->nodes_cnt =3D cnt;
> +
> +	err =3D bpf_trampoline_multi_attach(prog, ids, link);

Does bpf_trampoline_multi_attach() also miss a declaration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417192502.1945=
48-14-jolsa@kernel.org?part=3D1
