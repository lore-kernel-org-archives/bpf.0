Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AA130D3F6
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178873; cv=none; b=hN+DWf46yVj1Z5Cx8uuJHWiUwkdH24sBDGtMlX7vxCWC/g196T+jedWPN0sPEILTe7wAse0SRSjrIxk21KFpO4tW87mrxRynxKGko4L1f1VNiOsjByEY/EqTmjVUwYrGDK9tUw2ZiCrugiJpl7kU3w8vvV5+GG1kVjCTouXjbus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178873; c=relaxed/simple;
	bh=HrkMVNLlm1YnqQ/qrek+rgrnWsnk03ePdBmZSEiHei8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R/g/jZL3quq1LG58N1ObxcwxZa480Py1j0fWtOYAykHDYy/atmJNwfVWdfKfj7yV8fBh/OWKFu0fsuCccE460VpuwDw+F7+jOM22CvdIzRdC1O4VWTOKOHq3mTPARc/afcOwP03P0awRSJKImHxF9JiDCMqWyb0Ox8BN7N/Vff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfOuyABR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfOuyABR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEA01F00893;
	Thu, 11 Jun 2026 11:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781178872;
	bh=wo2xNs8wPBRDLqaOroQr27BWyOfouyVV5fqAPxdtZXY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GfOuyABRNubKz7eKC2Dy6M0wvxYjJBdNY6j5UgUzz1CtCy+pUxUWh6LecnGtum0VH
	 arrybz1Q9Hv6frqMN+x5UoVY8v5f+oyQ+Z+eRszwqcmu+k3iVql79TCsP5LlnU8b7U
	 k18NNUuYQ25zSzZoZiIRArPpHNq5/MoTwlsENBkUf2cSgON5QZlTNY07qIVw+fnPAi
	 PxqpM2pFL/HVUnGXeZInogCkeY3ago0SYFBA2PkkRPS8eZEW/RFwCBuDa0UxgPVqlU
	 eWZY60u1gbh+2w65Y9EXjWfokUbKTqOtPSPPSKY83onQpDYI2iLfIz8qH5PHXhOxoi
	 WDaUCWOXKZ+Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 bpf-next 6/7] selftests/bpf: Add uprobe_multi path_fd
 fail tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611114230.950379-7-jolsa@kernel.org>
References: <20260611114230.950379-7-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 11:54:31 +0000
Message-Id: <20260611115432.1FEA01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a compilation failure because it uses the unde=
clared macro BPF_F_UPROBE_MULTI_PATH_FD and references a non-existent struc=
t member 'path_fd' in struct bpf_link_create_opts.
--

commit acbff7cfc9a00c3bfed7027c436c6abc5a678d5d
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Add uprobe_multi path_fd fail tests

This commit adds new tests to the attach_api_fails suite in
uprobe_multi_test.c to ensure that incorrect setups using path_fd fail
as expected.

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index 56cbea280fbd2..58a7db7fba902 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
[ ... ]
> @@ -536,7 +536,37 @@ static void test_attach_api_fails(void)
>  	link_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
>  	if (!ASSERT_ERR(link_fd, "link_fd"))
>  		goto cleanup;
> -	ASSERT_EQ(link_fd, -EINVAL, "pid_is_wrong");
> +	if (!ASSERT_EQ(link_fd, -EINVAL, "pid_is_wrong"))
> +		goto cleanup;
> +
> +	/* wrong path_fd */
> +	LIBBPF_OPTS_RESET(opts,
> +		.uprobe_multi.path =3D NULL,
> +		.uprobe_multi.path_fd =3D -1,
> +		.uprobe_multi.flags =3D BPF_F_UPROBE_MULTI_PATH_FD,

[Severity: Low]
Does this cause a compilation failure? The struct member path_fd in
bpf_link_create_opts and the BPF_F_UPROBE_MULTI_PATH_FD macro appear to be
missing or undeclared here, which would typically cause the compiler to fail
with an undeclared identifier error.

> +		.uprobe_multi.offsets =3D (unsigned long *)&offset,
> +		.uprobe_multi.cnt =3D 1,
> +	);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611114230.9503=
79-7-jolsa@kernel.org?part=3D1
