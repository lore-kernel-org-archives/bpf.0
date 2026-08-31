Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C85426EBB
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198814; cv=none; b=NdEHlK0y0BDrQ2U93s3hrVRWnXqYD3zTfXb21jprPH/9a6Dh6tnbec2rvxGjgrPR601PWYEVQuaTpvGrbUzXAzSDuD13d+MtvmaUBGS/ak7fPNTVFQfBU0xPaywXHn9EaqYUyDN7w6kK/qAgUx0tQjtUyDMf7QON2yeU8JseZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198814; c=relaxed/simple;
	bh=e5bhNcE3j3k+0wOtgDPww4/m90nyB6IajejLJL7O1pA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jRBrfZuCcgST9WzYil942AaO/zMakBPumnfeM7cUUK+5EKr5GfI97VQJIIEIeSIIJ5at5mJogwH4hn3QwuxZxBRiYCJ1Hxmm74RofJwuoP8f2YMzUR1RiCn5sM3QlxEZA3hNq4nmzo0D8g7qVwGvQXQazl0l+DE+r38Beht2yiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLbeIBir; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLbeIBir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D091F000E9;
	Mon, 31 Aug 2026 17:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788198812;
	bh=gkuvQEZOrImOa3glRCNwUueHxxR3TD+ndlZC6vh2XZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WLbeIBir/lpzVyoJhMs4cmOPBeKEANg2IGRncJNYS0C5Mn7woFstGNXDPLWx/Pkgh
	 6m0aZEr53BMj8XxJI5ONfaUeDToF1M7NbMjdkoExyzQUWSquguh7xRSaIzYFB64NzG
	 w/qCoVB/tobtQEwWID2ZuI0JczSqm2b8D4VwyM6jXybyjW6TNtPwHmR9B/Ebzm22SS
	 iwPnWbyNjD7m73F1vuJ+lENEKtciPGjQrqEArorUZ25pF2QxlW7ZELi/I2ipgrTUV0
	 vw8cGWPI0ZDvzhhhWPOKDz9hOKbJKttM3E/s3UPvifvCMPrwfJM+7QDBZrdN9h9RWc
	 lOZ7thR+FhjhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: add RHASH iteration stress
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Su" <sh_def@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831140132.117755-2-sh_def@163.com>
References: <20260831140132.117755-1-sh_def@163.com>
 <20260831140132.117755-2-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:53:32 +0000
Message-Id: <20260831175332.84D091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing Error Check / Integer Signedness Bug in BPF map iteration
- [Medium] Flawed test logic caps maximum iterations at working set size, c=
ausing flaky failures on valid duplicate visits
--

commit a9ec4aae45f967791f38abbe6d019f58ee4a93fe
Author: Hui Su <sh_def@163.com>

selftests/bpf: add RHASH iteration stress test

This commit adds a stress test for bpf_for_each_map_elem() on
BPF_MAP_TYPE_RHASH. It concurrently updates and deletes entries from two
threads while repeatedly invoking the BPF callback to verify that the map
iterator handles concurrent rehashing correctly.

Link: https://lore.kernel.org/bpf/20260828183326.3330530-2-sh_def@163.com/

> diff --git a/tools/testing/selftests/bpf/progs/rhash.c b/tools/testing/se=
lftests/bpf/progs/rhash.c
> --- a/tools/testing/selftests/bpf/progs/rhash.c
> +++ b/tools/testing/selftests/bpf/progs/rhash.c
[ ... ]
> @@ -246,3 +267,23 @@ int test_rhash_delete_nonexistent(void *ctx)
>  	err =3D 0;
>  	return 0;
>  }
> +
> +SEC("syscall")
> +int test_rhash_iter_stress(void *ctx)
> +{
> +	/*
> +	 * Concurrent rehash may produce duplicate visits. Check that the
> +	 * helper still gives one walk a finite callback bound; no snapshot
> +	 * or unique-visit guarantee is expected here.
> +	 */
> +	long visits;
> +
> +	visits =3D bpf_for_each_map_elem(&stress_rhmap, stress_iter_cb, NULL, 0=
);
> +	if (visits > stress_max_visits)
> +		stress_max_visits =3D visits;

[Severity: Medium]
What happens if bpf_for_each_map_elem() encounters an error and returns a
negative error code like -EINVAL?

Because visits is a signed long and stress_max_visits is a volatile __u64,
the C integer promotion rules will convert the negative error code into a
large positive unsigned value (e.g., ~1.84e19).

Does this missing error check regression corrupt the stress_max_visits state
and mask the failure as a massive success count?

> +	if (visits > stress_working_set)
> +		stress_overruns++;

[Severity: Medium]
Could this condition cause sporadic test failures by incorrectly flagging
legitimate runtime behavior as an overrun?

The commit message notes that concurrent rehashing may cause duplicate visi=
ts,
which are permitted by RHASH's best-effort iteration semantics. If a walk
occurs when the map is fully populated with 4096 elements and encounters ev=
en
one permitted duplicate visit (e.g., due to a rehash moving a visited eleme=
nt
into a remaining bucket), the callback count will be 4097.

Since 4097 strictly exceeds stress_working_set (4096), stress_overruns will
increment, which will then cause the userspace assertion
ASSERT_EQ(skel->bss->stress_overruns, 0) in rhash_iter_stress() to fail.

Should there be headroom allowed above the working set size to account for
these permitted duplicate visits?

> +	if (visits =3D=3D stress_working_set)
> +		stress_full_walks++;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831140132.1177=
55-1-sh_def@163.com?part=3D2
