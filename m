Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD152367B70
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 05:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789883987; cv=none; b=OkT/En4l4AjlUen7aOkBwNoGHJvpVuddxF2OGdqykkpFeAf9XyxR0FRI70Od5+7M1A+/my+xH5uY207s2P7QKHKi7qYJ8gSb58HKodItT+MRQ7po70GNcg7KQaziwpb1A0t0azw5wQYoyfMlyjTh5FRnraFxXQ6iJ+AzbELL8dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789883987; c=relaxed/simple;
	bh=EKRTUk/g6YlvwL+Dv44EsSKfyGf6UHwBKWYiUs8UMSc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mpKDzAUm2NkU4tneeN83Fz1c6rOP4ryxJu6Ib2+ObHZVG8FB5ZYkcu7LmLJpzaHlxKJZWYSnH0mTaEajJugdKPrliNExwstdiNwxPXiPCuw3pS/sk1qbu5zvG/RD/i5Uq5PwLThEWsMzjSFTG7BzcdsKCy/+9vcE9T/cpaaYSIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPeZHocP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPeZHocP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5E91F000FF;
	Sun, 20 Sep 2026 05:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789883985;
	bh=ugJ4NWlw4g0A+I8VfOm9wiKtJmXYDQGJVcFT0EdaHrE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nPeZHocPKdLYtkHaXQyjAWJIUpvGFIrqz9u9IFlYvqD3DTrmZotz9g/2uUjZnXb5S
	 6oaTaPQlaqVJTMo5Mj/KfBJrFY0MM/vT+JchVgDXinqO2989fgrjXe3eAOJr2ZcdiN
	 luERDjPB/+9mDvhl710avnM8XarAvnIxpLpAFeXgWWngy0SkC0o0xAN05vr8h+OIFI
	 /8SUOIIEoy5poIEnVvgPGel44NpuSYQKDATxYATsbICFHjFgrFuZWfa3nF1aR7uqwd
	 YaN28e3xYBMZMU9YHXDVrFVU6ylqohCwP1xTat2N1VaZDZPASNKCJI2MtxEba28ZM0
	 ZkNVVHbX/BGVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 18/20] selftests/bpf: Add an end-to-end
 .bpf_cleanup exception test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260920054358.872840-1-yonghong.song@linux.dev>
References: <20260920054225.864535-1-yonghong.song@linux.dev>
 <20260920054358.872840-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:59:44 +0000
Message-Id: <20260920055945.3A5E91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comments violate mandatory subsystem style
--

commit f500599d1234044cd45952e76c1ac50f7c35ab78
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add an end-to-end .bpf_cleanup exception test

This commit introduces end-to-end tests for the .bpf_cleanup exception
handling mechanism. It verifies both successful cleanup paths and various
scenarios where the kernel correctly rejects invalid landing pads or unwind
behaviors.

> diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c =
b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> new file mode 100644
> index 0000000000000..a951045d21355
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
[ ... ]
> @@ -58,11 +58,11 @@ void test_exceptions_cleanup(void)
> +
> +	/* foo3 throws; every pad runs and the cookie is delivered at entry. */
> +	if (test__start_subtest("throw_from_foo3"))
> +		run(skel, 101, THROW_COOKIE, PADS_FOO3_THREW);
> +
> +	/* foo3 returns 2 ^ 1 =3D=3D 3, so foo2 throws from its own second regi=
on;
> +	 * foo3's frame is long gone, so its pad must not run.
> +	 */

[Severity: Low]
This isn't a bug, but does this violate the BPF subsystem's multi-line
comment style in test_exceptions_cleanup()? The guidelines require the
opening /* to be on its own line.

> +	if (test__start_subtest("throw_from_foo2"))
> +		run(skel, 2, THROW_COOKIE, PADS_FOO2_THREW);
> +
> +	exceptions_cleanup__destroy(skel);

[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c =
b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
> new file mode 100644
> index 0000000000000..db6ac7d8bd6de
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
[ ... ]
> @@ -15,10 +15,10 @@ static __used __noinline void __kfunc_btf_anchor(void)
> +	bpf_preempt_enable();
> +	bpf_unwind_resume();
> +}
> +
> +/* 1. A subprogram that may unwind, also used as a helper callback:
> + * bpf_loop()'s own kernel frame would end the walk before it found a
> + * boundary.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment format violate the BPF
subsystem style just above throwing_cb()? Similar to the above, the opening
/* should be on its own line. It appears several other comments in this file
follow this same pattern.

> +static int throwing_cb(__u32 idx, void *ctx)
> +{
> +	bpf_throw(0xbad);
> +	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920054225.8645=
35-1-yonghong.song@linux.dev?part=3D18
