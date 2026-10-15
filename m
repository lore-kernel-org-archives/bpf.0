Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C80370D49
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085761; cv=none; b=GyQGLxi320N553+Kah3yymOtG6v5i5oQigPCN5tvcfcn/5vRG8OHgZPhEjLuCZs073wkeI2wNiHnmSbeHZnrwfr75J1SucCDltxdFf1YFzFiut10GCyG/qF9L3csxhC6FpBxjftdkO0/ZVqEBHGyBeUGdJQxqZ6oJQEQMyUMEfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085761; c=relaxed/simple;
	bh=FpHjQGD/Pyw8C34+gLOi8XSJy9sATbJEkMJfg82DK/c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=LaE0oDsb22ZnqWnWH8FIRFNsJQoteUn+dGmsOUqhe7QU1PTWVTGWR8K7x6O2dZLn0M7EHZ0ZVbfdOgsS1M1v2fvW6UEY7YnMBTLJSpNCQ9cEDHpC4jBqCzPBrAerM1AoYOh7+ZaCPd4WHzny9QvtwrMaINZPIdCYya5qprgwD8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBPbzg6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBPbzg6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC251F000C4;
	Thu, 15 Oct 2026 17:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792085751;
	bh=yhd27hjuGR+5GS83SoYbw7wMccZ+khjt1Wc01Fjbe/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BBPbzg6u08eWfJZ3nOBsWYYGWKg1c7bnr9hORnUoCRjJVodQyDUoOuOTW4A2pONez
	 x4Wae4+i7UArMgTMXXF4irTagiQ1um9MC9zAmCX0V0NqZb51JLcD1K0NuP+6wFx/v6
	 NbPYIbJZ6i6rhpTsjZcoEtAfdN4GyVYhJb5RoWT2IOemAZuKiLUabLjHlXxM9DZ+OC
	 kRwkhbAfF7EIGirwF0gmdPz76cYdpw1xOZf0yaCiJYL99khCvIKitVhTY8S4Pqb8gC
	 YF6OXDumZOh5n0PMgSO6JXnNS+6YKvF+4dqsfzs06ik0FxQ1XE93rhgl67dTK1+HKJ
	 UFg2lAA5X4cUA==
Message-ID: <sashiko-outbox-173257@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/bpf: remove unused duration variable
Reply-To: sashiko-reviews@lists.linux.dev
To: pdsj2807@gmail.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20261015173142.1361483-1-pdsj2807@gmail.com>
References: <20261015173142.1361483-1-pdsj2807@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 17:35:51 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/bpf: build failure from removing duration variable used b=
y CHECK macro
--

commit 554358d3f4b47b8628cdfddabbecc7bb2c5d4380
Author: Palak Raval <pdsj2807@gmail.com>

selftests/bpf: remove unused duration variable

This commit removes the local duration variable from
cgroup_attach_override.c, stating that it is not referenced anywhere in the
file.

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_overrid=
e.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
> @@ -26,7 +26,6 @@ static int prog_load(int verdict)
>  void serial_test_cgroup_attach_override(void)
>  {
>  	int drop_prog =3D -1, allow_prog =3D -1, foo =3D -1, bar =3D -1;
> -	__u32 duration =3D 0;
> =20
>  	allow_prog =3D prog_load(1);
>  	if (CHECK(allow_prog < 0, "prog_load_allow",
>  		  "verifier output:\n%s\n-------\n", bpf_log_buf))

[Severity: Low]
Will this code continue to compile after removing the duration variable?

In BPF selftests, the legacy CHECK macro implicitly references a variable
named duration from the caller's scope to track test execution time. Removi=
ng
it here in serial_test_cgroup_attach_override() leaves the duration symbol
undeclared, which will cause the build to fail when the CHECK macro expands
immediately after this change.

Would it be better to migrate these checks to modern macros like ASSERT_OK()
first, so the duration variable can then be safely removed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015173142.1361=
483-1-pdsj2807@gmail.com?part=3D1
