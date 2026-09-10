Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC138E11A
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065775; cv=none; b=CeqtT/gvtWfqMuvB07ohKyXBzC+LVyemzJFKhDKT3paBsrHHBd2Dh+mwEoyD6KJ5FAUlYzu0HjSGGjAzsju/Jk8NV6qs/NW/QzMEiwBb0Nrv2U4XpaiIiLGubGq1pOkgCNpxF5zdk/GgQUw0gCEMreUAprEdVs9qLYj3zj6a2aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065775; c=relaxed/simple;
	bh=Pf4rCG0iSZYQaP16DflSLZZFcyOEb1DkMhmEgDbrr0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gbZPZVvSkaQqZy0AmX54dj4H7KLExfVqF7jbDRIy5kyaFvcuoxxilPswInp6KC82H+bZpD+YXL+iX6KZpKeyEBzNyXMLN5esgob9cJf6kssjcesr+FyvOdSdLhrxoDnXC6po86HHp3H22InMk9tF8SJd0lYsFFbw7GE65uJOwK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Av75A5bC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av75A5bC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA0A1F000FF;
	Thu, 10 Sep 2026 18:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789065769;
	bh=hHLdsn23KJfb8+qBj30FJhDa8ot3s6ukoCE/+GUCdw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Av75A5bCG/IsV+j2+0tpWU/47bhW6re8Jd2JA6UWnBfkoDVhSca3Z1Q9Gvzd+8Mpc
	 Ae8omYQSzITuccE89hb2W2kjTwZSai8V24SLwD+v7cn7ctBVkRMTESJdeMa3m3LGHf
	 hVrPVH7qID3LSbsMGnOnLfKR7yco5Mr36ElruQd1o/3AxpEbc9ncidrti3E0Rci9ut
	 zqnBcm0wMcXfNuA7zKtOWF0Bha5AFkgCcjs7ZkydQogb0gWVLVdbiywhR/cse3N6V9
	 q8Aho+YvX34Vo4DMBhRS6Edykj5hmmCx3z5APLvN+Is0aQ73NxTBItkS/l93hl6CEi
	 K2AwgM0XgEzsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: Add assertions for
 bpf_program__{add,clear}_flags()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910183222.307208-2-toke@redhat.com>
References: <20260910183222.307208-1-toke@redhat.com>
 <20260910183222.307208-2-toke@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 18:42:49 +0000
Message-Id: <20260910184249.BAA0A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing early exit check on BPF skeleton load and flag manipulation=
 operations allows execution to proceed in an invalid state.
--

commit 1694db036efd5301fa9d3722ffe0c0854fa291b9
Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

selftests/bpf: Add assertions for bpf_program__{add,clear}_flags()
   =20
Add assertions that round-tripping through bpf_program__add_flags() and
bpf_program__clear_flags() ends up with the original flags value.
Arbitrarily add these to the kernel_flag test prog since that's where
we're already checking for the bpf_program__flags() value (and the test
name contains "flag").

> diff --git a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c b/tools=
/testing/selftests/bpf/prog_tests/kernel_flag.c
> index 25eb59f460abe..72c0ef8da409e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
> @@ -10,15 +10,31 @@ void test_kernel_flag(void)

[ ... ]

> +	ret =3D bpf_program__add_flags(prog, BPF_F_ANY_ALIGNMENT);
> +	ASSERT_OK(ret, "bpf_program__add_flags ret");

[Severity: Low]
Should this ASSERT_OK() call be wrapped in an if (!...) goto close_prog;
check?  If it fails, the test will continue executing instead of cleanly
aborting.

> +	ASSERT_EQ(bpf_program__flags(prog), flags | BPF_F_ANY_ALIGNMENT,
> +		  "bpf_program__add_flags value");
> +
> +	ret =3D bpf_program__clear_flags(prog, BPF_F_ANY_ALIGNMENT);
> +	ASSERT_OK(ret, "bpf_program__clear_flags ret");
> +	ASSERT_EQ(bpf_program__flags(prog), flags, "bpf_program__clear_flags va=
lue");
> +
> +	ret =3D test_kernel_flag__load(lsm_skel);
> +	ASSERT_OK(ret, "test_kernel_flag__load");

[Severity: Low]
Is it intentional to allow execution to proceed if the skeleton fails to
load?  Wrapping this in if (!ASSERT_OK(ret, ...)) goto close_prog; would
abort the test cleanly and avoid cascading test failures.

> +
>  	lsm_skel->bss->monitored_tid =3D sys_gettid();
> =20
>  	ret =3D test_kernel_flag__attach(lsm_skel);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910183222.3072=
08-1-toke@redhat.com?part=3D2
