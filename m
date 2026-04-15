Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9920D2C08BC
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776216066; cv=none; b=nuiXucdzN2WKdxseOUopohEYBWJi4XFaD//QBHh8t1pop10kRJ7yFW2JHUb7aKUYViLH+rwdTbRFXgkk8d5FsgWeyeVnLqEb+wJXvAJn93RKTni70PE2tAzjstdNqDPdjymEzaVEet9ueutVoGerhZfet9vzTpbdgfDzOOpCsGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776216066; c=relaxed/simple;
	bh=ELDzSRYIArY3PqS7ANfGmaFcXQZx+0bAVMcKbrvdsmE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HOX++19EPptHY/RZlBvtdzlwvCG41yePhowJ/qh3vyDt6Iww2aOdO/VdWPkwptsleG8tmoJ6Ibq/hkk/bFQT2/UNuxxVueya73xadVBYK34RaJZx06n2r61Xf3G7JvdNmdhXDkMTJfuR9QcrdxAwV3qzd6amIAhcwwAzk0SwZkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luqfcHzZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luqfcHzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C63CC19425;
	Wed, 15 Apr 2026 01:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776216066;
	bh=ELDzSRYIArY3PqS7ANfGmaFcXQZx+0bAVMcKbrvdsmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=luqfcHzZnWhKaRiNOOGWtkhlQXdM6nA0U2jqzDln/MoAX0pT9fllQCD3m3ISYrQb8
	 Nq6jAPeIDYJjLmQxlwiMhUNOi87A3lo/JzW0mBOB3TpdM3tpy6vDGY5tWrrbKbrXBj
	 q3ifPxKNarDI+4X17PY1YcC1NQgmD1jtOzrNQaeRsWL9W+MgF39hXnq27/mZ3YSFej
	 tjaAKLL0q8ZGA7I4c+4pzid9cBVOCm5t01S9gBNXZxxHqM8QrNyObSLCrOgng4SeWp
	 SgOGb9Y007uyqTMpdV9kHDkFxIgHTcYtu/z4IOMiMxVcKMm68fIiUZ7aGF+Pb7mBNg
	 jprGrqgiDpqGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: verify kallsyms entries
 for token-loaded subprograms
Reply-To: sashiko@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260414-subprog-token-fix-v2-2-59146c31f6f1@gmail.com>
References: <20260414-subprog-token-fix-v2-2-59146c31f6f1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 01:21:05 +0000
Message-Id: <20260415012106.5C63CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The test modifies global sysctls (`perf_event_paranoid` and `kpt=
r_restrict`) while running in parallel, causing race conditions and potenti=
al host state leakage.
--

commit 9e0a167112286dfb5b44d5686732b8297533a10b
Author: Eduard Zingerman <eddyz87@gmail.com>

selftests/bpf: verify kallsyms entries for token-loaded subprograms

This commit adds a test to verify that both the main program and its global
subprogram appear in /proc/kallsyms when loaded using a user namespace BPF
token. It temporarily modifies global sysctl variables to allow reading
kallsym addresses.

> diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
> index b81dde283052e..89da527ed9304 100644
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

The BPF selftest framework executes test_token() concurrently with other
tests because it lacks the serial_test_ prefix.

If another parallel test modifies or relies on these sysctls simultaneously,
can this create a race condition where the parallel test reads the
already-modified "0" as its original state?=20

This could result in the host permanently retaining the lowered security
settings once the tests complete.

Should this test be renamed to serial_test_token() to prevent concurrent
modification of global system state?

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414-subprog-to=
ken-fix-v2-0-59146c31f6f1@gmail.com?part=3D2
