Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E483C2781
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086869; cv=none; b=lkO1ucMou1kZhgKKAfY1CFeW5xZP6Yu9rkhNXGuI1jYPa9xGIlpGb5G5R72X6Uxqr/ApXR75tM32NlsF53UAg/f97x9ISJiL95klwqhsbKrau8zrwKrIqte9hf/ld72f3kXg6Is5QY+Fog6uVzJGPmmKiq2r9wX9aBFaEHMGUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086869; c=relaxed/simple;
	bh=rPlFonmXukCpTX5G3za5Kgwyo/+kYCig4pEOFHMPji0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dMy91Cee0XMzqkQgSjywjYxfjDe5po2tvG35/A6x6KicM9YHjYizL07if6d6CFVlAWmiUoQyign4CqArgDomzH6BS+rzNntpXSxS0+rmMe9+9w5B1CCFquxHlKkBpOgSGrdVSnsmGxsMRyiPDJIKWeb62ga7Mq09mrAV7VcTQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFesS1H7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFesS1H7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C4A1F000C4;
	Thu, 15 Oct 2026 17:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792086856;
	bh=SiLg0AhCcBqcdv3USE/yivhRIKL1PpP41SP6piX/Z3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FFesS1H79eAwCc22zJ3ymSwBX8z/PzwRF25VsZNwiLhoTEvTTOBaGVwWuRJXVlach
	 cCZd2owvwEtmLURuc61/ejg+/fr9smzcNdv6aaxMvN9gb2n8DNHNvqUDRlK6uCvNij
	 Esv4QY09dv0vF5V7eaVoiSdDznIANEnu+6S/w0FsRxO1X0BCHt/yW2UYvYQ/3SgZ3h
	 jyNL/JXr16tgdZx5lrHLQMomcFeWuapXN1no9pGlFhEBCu/+sHG9CufgUp2OjaQM9X
	 pgdjno2lPe0avo5yKjYvlHNalHmbOpTd25OuoHP9WvfpFpoawT70rW7HPvXZ+yYijJ
	 oFadf/wRUNRWA==
Message-ID: <sashiko-outbox-173267@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/bpf: remove unused duration variable from
 cgroup_attach_multi
Reply-To: sashiko-reviews@lists.linux.dev
To: pdsj2807@gmail.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20261015175022.1370503-1-pdsj2807@gmail.com>
References: <20261015175022.1370503-1-pdsj2807@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 17:54:15 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/bpf: build failure from removing duration required by CHE=
CK macro
--

commit d7de4f4763b56d10ac8f8dca1287b007d98057b7
Author: Palak Raval <pdsj2807@gmail.com>

selftests/bpf: remove unused duration variable from cgroup_attach_multi

This commit removes the duration variable from serial_test_cgroup_attach_mu=
lti()
under the assumption that it is unused.

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c=
 b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> index db0b7bac78d15..9037e98f6f760 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> @@ -81,7 +81,6 @@ void serial_test_cgroup_attach_multi(void)
>  	DECLARE_LIBBPF_OPTS(bpf_prog_attach_opts, attach_opts);
>  	int allow_prog[7] =3D {-1};
>  	unsigned long long value;
> -	__u32 duration =3D 0;
>  	int i =3D 0;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(allow_prog); i++) {

[Severity: Low]
Will removing this variable cause a build failure?=20

The BPF selftest framework's deprecated CHECK() macro implicitly requires t=
he
duration variable to be present in the caller's scope, as it expands to
_CHECK(condition, tag, duration, format...).

Because serial_test_cgroup_attach_multi() uses CHECK() right below this, and
extensively throughout its body:

	for (i =3D 0; i < ARRAY_SIZE(allow_prog); i++) {
		allow_prog[i] =3D prog_load_cnt(1, 1 << i);
		if (CHECK(allow_prog[i] < 0, "prog_load",
			  "verifier output:\n%s\n-------\n", bpf_log_buf))
			goto err;
	}

removing the duration variable causes an undeclared identifier compilation
error.

To safely remove the duration variable, the test must first be migrated to =
the
modern ASSERT_*() macros.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015175022.1370=
503-1-pdsj2807@gmail.com?part=3D1
