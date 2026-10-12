Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01A4442FCD;
	Mon, 12 Oct 2026 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823408; cv=none; b=L8SB2vuz+2SPuKCHDcrHeiaIDMv/+EmbZiEkD+ubs+49kik+ij7DKnaLvZKZ1x9cKK/TsygWBGAuPFGmOlwjwsf32eRzsT1g4bIQzto6K5RgDrPrfKHrrdtvUH0nTxlFWN4BRGVNWS02rcwlg3ocGmuxDx5JFqcCLs6y3fwO6C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823408; c=relaxed/simple;
	bh=x4sgOIc7rsq6TY9/BXHnwHpv0tg3DsplDRpI5hH1IeQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oqWgxXi2hWyIMVwoh+L2E1NrBgtm/hTO+HRV58gMzYRQZfRoTXcYdOIHoUt1Wmf0Dq885jIRo8CqtUQdZAOjSRSjRFWafmO1srSicLekWwcdQ/5nQFmFFTzMWnqS3RrYT7wIPz+a/kBiGWxZTL7q21Zs17FKjnuQq9b/ULbQB8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mamqmG7v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mamqmG7v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110931F0089C;
	Mon, 12 Oct 2026 16:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791823407;
	bh=MMdI40SIqVIFk5X8A7qUoQwYy+szKjYqzLkyBtBazB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mamqmG7v0zC1CTaLFfJqvS8pu+rK1mEljCnxLERoFDc1r6MogAnEoeD1nPo3i54Jn
	 7e3kKOO5an/552QCbBFDROicsYhLjjA+bCuP33Bc+iXYkbQP49hMfN91tOPgW6PpI/
	 BfAJUcs8p9tecm7FUYTtVNPyQWKL+5JICEY6d40t6rOW5VEA05n0fzSjiz3zt4K8I8
	 HYNFVCTPfy5fLTmv9/aMSpcD8MpZ6vgcmDYBlSA2yloLq+3/5E/lHc04fYi7t79k3t
	 tjfVyqlptg82psF3o4TLz6a0anALKVP+qj3yttgmlFf/Gav+DTSSNZHZeq53ZhMMIN
	 QAgM4HyyDVugw==
Message-ID: <sashiko-outbox-168419@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 19/21] selftests/bpf: Add tracing_multi bpf
 prog link info test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261012154024.29423-20-leon.hwang@linux.dev>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
 <20261012154024.29423-20-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 16:43:26 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: Ineffective error check for libbpf_find_prog_btf_=
id due to __u32 cast
--

commit 208e2b6f875995feff87983db367727d95ea373b
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add tracing_multi bpf prog link info test
   =20
Verify the link info works well for bpf prog targets of tracing_multi link.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/to=
ols/testing/selftests/bpf/prog_tests/fill_link_info.c
> index 0918321c8e63d..422e94f134094 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> @@ -467,13 +489,49 @@ static int setup_tmulti_targets(const struct bpf_pr=
ogram *prog,
>  	return -1;
>  }
> =20
> +static int setup_tmulti_bpf_prog_targets(const struct bpf_program *prog,=
 int token_fd,
> +					 const __u64 *cookies,
> +					 const struct bpf_program * const *target_progs,
> +					 struct tmulti_target *targets,
> +					 __u32 *btf_obj_id)
> +{
> +	struct bpf_prog_info prog_info =3D {};
> +	__u32 len =3D sizeof(prog_info), func_btf_id;

[Severity: Medium]
libbpf_find_prog_btf_id() returns an int which can be negative to indicate
an error. Since func_btf_id is declared as an unsigned 32-bit integer,
does assigning the return value here cast any negative error code to a large
positive value?

> +	int err, i, prog_fd;
> +
> +	for (i =3D 0; i < TRACING_MULTI_BPF_CNT; i++) {
> +		memset(&prog_info, 0, sizeof(prog_info));
> +		len =3D sizeof(prog_info);
> +		prog_info.jited_ksyms =3D ptr_to_u64(&targets[i].addr);
> +		prog_info.nr_jited_ksyms =3D 1;
> +		prog_fd =3D bpf_program__fd(target_progs[i]);
> +		err =3D bpf_prog_get_info_by_fd(prog_fd, &prog_info, &len);
> +		if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
> +			return -1;
> +
> +		func_btf_id =3D libbpf_find_prog_btf_id(tmulti_bpf_funcs[i], prog_fd, =
token_fd);
> +		if (!ASSERT_GT(func_btf_id, 0, "libbpf_find_prog_btf_id"))

[Severity: Medium]
If a negative error code is cast to a large positive value in the
unsigned func_btf_id, will this greater-than-zero check incorrectly pass,
masking test failures during BTF ID lookup and allowing the test to
proceed with an invalid BTF ID?

> +			return -1;
> +
> +		targets[i].cookie =3D cookies[i];
> +		targets[i].id =3D prog_info.id;
> +		targets[i].func_btf_id =3D func_btf_id;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012154024.2942=
3-1-leon.hwang@linux.dev?part=3D19
