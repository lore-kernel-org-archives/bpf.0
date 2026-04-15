Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10ED1DED40
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280658; cv=none; b=KekBiC6B9Z5Grkh7Xyc7AreXbImWU3KZ3LsKv1jO5FpYDPnEsCA7JI8jmaHfG5u3xAXbJMSBufucvpV4bA2S9a9ZVMjJYsADQXuJjO+X13iYQBk+AvJ+NxC9iPTiPujumUKKbxh7/gS2fDLTUo1s+6NSnQEi3qwhuLB+DTy2VeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280658; c=relaxed/simple;
	bh=BxKaXaaDCiwIDFgMrciT9rCxUW/OTkrQjioD/yp4tPE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CkQipg9U+hMCOAbTeHykcOjve9MekXBvUk5FGEf9Crt774MCpyb5lDPy6iS0eIsEgC6XAODVVBsAVzKOCDZtyNKCxWHXmrgXglBe1IM2sIGtQefuYGgXJtK5o7ujFMkuU3WRkkA5fXG92QHz9ZrU7+pdQ5rsH8V0+3HvGeIIJsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+sG8UeW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+sG8UeW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226BFC19424;
	Wed, 15 Apr 2026 19:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776280658;
	bh=BxKaXaaDCiwIDFgMrciT9rCxUW/OTkrQjioD/yp4tPE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=i+sG8UeWcrGnlwYyepUowOH3lD+9CrKar2PHr3iKxpTi5onx8+3Heivxkbbi3jObs
	 7PPafE1fluzcuo11b7UdrUSBnsxEWwENPE0zHBBam0zjcVrj3XOi93huzIdkBi9/ZO
	 LX2q+xOrOZbUuXALksZ60rbwVGm1fp1y5skpF9qXJhjHizLC8HWPD5vU3b/0xtRtFu
	 5XP2htpaplNVD63mZlnKkKTen97LLDC7wZTFlR2WjDQhelYggTaNaZtovMZ5tL3Gh1
	 p6qxW/SwFv54UaovvDKqbH7vipWgsKcJmtAJVyJot1iY5tIBsh3Hx4qmiayIbbQjRQ
	 j3IfHG8vfqEwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: verify kallsyms entries
 for token-loaded subprograms
Reply-To: sashiko@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415-subprog-token-fix-v3-2-6fefe1d51646@gmail.com>
References: <20260415-subprog-token-fix-v3-2-6fefe1d51646@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 19:17:37 +0000
Message-Id: <20260415191738.226BFC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Unchecked return values of `sysctl_set()` in `serial_test_token(=
)` can lead to confusing test failures.
--

commit e7dc629b9f37dc08742ff9bbddeaaf65c1e34956
Author: Eduard Zingerman <eddyz87@gmail.com>

selftests/bpf: verify kallsyms entries for token-loaded subprograms

This commit adds a test to verify that both the main XDP program and its
global subprogram appear in /proc/kallsyms when loaded using a user
namespace BPF token. It also introduces a sysctl_set utility to configure
system parameters needed to read kallsyms.

> diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
> index b81dde283052e..cf5b94512cff4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/token.c
> +++ b/tools/testing/selftests/bpf/prog_tests/token.c

[ ... ]

> @@ -1194,4 +1252,23 @@ void test_token(void)
> =20
>  		subtest_userns(&opts, userns_bpf_token_info);
>  	}
> +	if (test__start_subtest("obj_priv_prog_kallsyms")) {
> +		char perf_paranoid_orig[32] =3D {};
> +		char kptr_restrict_orig[32] =3D {};
> +		struct bpffs_opts opts =3D {
> +			.cmds =3D bit(BPF_BTF_LOAD) | bit(BPF_PROG_LOAD),
> +			.progs =3D bit(BPF_PROG_TYPE_XDP),
> +			.attachs =3D ~0ULL,
> +		};
> +
> +		sysctl_set("/proc/sys/kernel/perf_event_paranoid", perf_paranoid_orig,=
 "0");
> +		sysctl_set("/proc/sys/kernel/kptr_restrict", kptr_restrict_orig, "0");

Should the return values of these sysctl_set calls be checked?

If the test is executed in an environment where these sysctls are read-only
or inaccessible (such as inside a container), sysctl_set will silently fail.

This would cause load_kallsyms_local to read zeroed addresses because
kptr_restrict wasn't successfully disabled, resulting in confusing test
failures later at ASSERT_TRUE instead of catching the setup failure early.

Would it be better to wrap these with ASSERT_OK?

> +
> +		subtest_userns(&opts, userns_obj_priv_prog_kallsyms);
> +
> +		if (perf_paranoid_orig[0])
> +			sysctl_set("/proc/sys/kernel/perf_event_paranoid", NULL, perf_paranoi=
d_orig);
> +		if (kptr_restrict_orig[0])
> +			sysctl_set("/proc/sys/kernel/kptr_restrict", NULL, kptr_restrict_orig=
);
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415-subprog-to=
ken-fix-v3-0-6fefe1d51646@gmail.com?part=3D2
