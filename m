Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD7C40D57D
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782573151; cv=none; b=k6Pns6ZKs2NHWErz2H+ap3R4tK7si01Z8eZAX23fDNhPFZqc4wmlVLCMlXbgboXUxbrTi/6bkAEjleySsB/eQvBzFW/QqkSi+DMOjU7cRUi9fDdGap5D0Y49xL5gKjZLVjjqHCmTSUXDk1JxO/J34KUCMjWJ7NN6LatdCQEAPZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782573151; c=relaxed/simple;
	bh=dOofpu4BeBmujabaPNv2OVanQGo6zI5FSiAgCqRRcMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ay6MrPGz4LIwDQc1zKthVaGPlZUoUYeBZ/U0w7v1adSOalgU4W7hRzzm2rxjrR5+SQT/fT1lw4IJ8QRbvgIMK7Hlg4IYMEGXxn5cufwXCv9P0FnFgZs5ypngGIY/xQm29x/FQbt2kjk8TaW5eb0QFcdLB9oN5Vmr2xHjmCdt8hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eD2JH0oQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eD2JH0oQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1B41F000E9;
	Sat, 27 Jun 2026 15:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782573148;
	bh=R7r9Q70I63i7UB2+2z6o4iX2k3W/kVFfFIWBMM+hQ4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eD2JH0oQlhNWYky/Lg4JFdBh/nGO3WwP0H2XN/RyNPZehccY3thVV4F0+hMQHUt0n
	 hLF5fnAaAKjdJUlIGIBqRdgKeygyaa3MkUjys34Xp3XtK8Onuq2FKxdbngKDeCngzC
	 HucHtE9WWbuFckh9vy+l6rBwmNBIYYpiJ+wJGqycG6MDUn5YruS4/A/tFlSRp24PiI
	 YzF4S15+FN2tc4/HnM9JpRBOMEAvtPCXQtb6s5KBQSLrXUdAq20+E/G249KtgXSJY7
	 YLhKHu9N8dHyRBU+3Wfn9QTcuGeZtoSQ1Qv7eXfUCyXWcFAWB0g4agsRygeQ08dD2U
	 ozddkp2MiweGw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 09/12] bpf: Add kernel support to load SDT
 observer program
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <e5e991c7573600676c0de49b7b794e1f2b6d956a.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <e5e991c7573600676c0de49b7b794e1f2b6d956a.1782571533.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 15:12:27 +0000
Message-Id: <20260627151227.ED1B41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Reference count leak of `dst_prog` due to pointer overwrite in `bp=
f_prog_load()`.
- [High] Error paths in `BPF_TRACE_SDT` handling bypass `put_sdt` cleanup, =
leaking `attach_btf` and `dst_prog`.
- [High] Memory leak of `prog->aux->sdt_probe` on early load failures in `b=
pf_prog_load()`.
- [Medium] bpf_insn_array_get_sdt_probe_by_name returns an incorrect semant=
ic error code when a probe is not found.
--

commit 02476bf5b9d80f3ff0471539243d877d096c0806
Author: Xu Kuohai <xukuohai@huawei.com>

bpf: Add kernel support to load SDT observer program

Add kernel support to load SDT observer program. The program is
verified as a normal tracing type program while the target FUNC_PROTO
is resolved in the SDT map of the target program using the probe name
passed by the user.

> diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> index a9564ef4b2efa..067cc1b817d5f 100644
> --- a/kernel/bpf/bpf_insn_array.c
> +++ b/kernel/bpf/bpf_insn_array.c
[ ... ]
> +int bpf_insn_array_get_sdt_probe_by_name(struct bpf_prog *prog, const ch=
ar *name,
> +					 struct bpf_insn_array_value *val,
> +					 unsigned long *ip)
> +{
[ ... ]
> +		for (j =3D 0; j < map->max_entries; j++) {
> +			if (insn_array->values[j].xlated_off =3D=3D INSN_DELETED)
> +				continue;
> +			if (!strcmp(insn_array->values[j].name, name)) {
> +				*val =3D insn_array->values[j];
> +				*ip =3D (unsigned long)insn_array->ips[j];
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	return -EEXIST;

[Severity: Medium]
Is -EEXIST the correct error code when a probe is not found? Would -ENOENT =
be
more appropriate to indicate a missing entry?

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index dc881e5ad4114..8b2c73bb6c2a8 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
[ ... ]
> @@ -3082,33 +3085,75 @@ static int bpf_prog_load(union bpf_attr *attr, bp=
fptr_t uattr, struct bpf_log_at
>  		btf_get(attach_btf);
>  	}
> =20
> +	/*
> +	 * find the probe site in the target program at load time of the
> +	 * observer program, so the verifier can check the observer's context
> +	 * arguments from the probe's FUNC_PROTO.
> +	 */
> +	if (attr->expected_attach_type =3D=3D BPF_TRACE_SDT) {
> +		struct bpf_insn_array_value sdt_val;
> +		struct bpf_sdt_probe_info *sdt_probe;
> +		unsigned long probe_ip;
> +
> +		if (!bpf_jit_supports_sdt_probe()) {
> +			err =3D -EOPNOTSUPP;
> +			goto put_token;
> +		}
> +		if (!attr->sdt.target_prog_fd) {
> +			err =3D -EINVAL;
> +			goto put_token;

[Severity: High]
Does jumping to put_token here bypass the cleanup of attach_btf and dst_pro=
g?
If those resources were acquired earlier in bpf_prog_load(), it looks like
they might be leaked since the put_sdt label is skipped.

> +		}
> +		dst_prog =3D bpf_prog_get(attr->sdt.target_prog_fd);

[Severity: High]
Could overwriting dst_prog here leak the BPF program reference? If the call=
er
populated both attr->attach_prog_fd and attr->sdt.target_prog_fd, dst_prog
would already hold a reference that seems to get lost on this assignment.

> +		if (IS_ERR(dst_prog)) {
> +			err =3D PTR_ERR(dst_prog);
> +			dst_prog =3D NULL;
> +			goto put_token;
> +		}
[ ... ]
>  	prog->expected_attach_type =3D attr->expected_attach_type;
>  	prog->sleepable =3D !!(attr->prog_flags & BPF_F_SLEEPABLE);
>  	prog->aux->attach_btf =3D attach_btf;
> -	prog->aux->attach_btf_id =3D multi_func ? bpf_multi_func_btf_id[0] : at=
tr->attach_btf_id;
> +	if (prog_sdt_probe)
> +		prog->aux->attach_btf_id =3D attach_btf_id;
> +	else
> +		prog->aux->attach_btf_id =3D
> +			multi_func ? bpf_multi_func_btf_id[0] : attr->attach_btf_id;
>  	prog->aux->dst_prog =3D dst_prog;
> +	prog->aux->sdt_probe =3D prog_sdt_probe;
> +	/* ownership of dst_prog/attach_btf/prog_sdt_probe moved to prog->aux */
> +	dst_prog =3D NULL;
> +	attach_btf =3D NULL;
> +	prog_sdt_probe =3D NULL;

[Severity: High]
Will early load failures after this point leak prog->aux->sdt_probe?

On subsequent errors, the code jumps to free_prog which calls bpf_prog_free=
().
Since bpf_prog_free() and its deferred cleanup routines don't seem to free
sdt_probe (unlike __bpf_prog_put_noref() which is bypassed on early failure=
s),
does this leave the probe info allocated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782571533.gi=
t.xukuohai@huawei.com?part=3D9
