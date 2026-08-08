Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE73238166
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 01:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786151014; cv=none; b=tSpqosHXYPiojIQvxJ28SSGcfDb3Oa/Flz/In4wejfGgi0NahGOJOXZ7BTA5S57TXMjRuoXCpsKS4pDCh6/O9EhDm+hLFHpyJXEoWwBJx8VfOhjtxnEwXHYzd7ew4omyhzq9/YUwU++rs36FtsqqvxiQII1IHFp8cLyygiWYFFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786151014; c=relaxed/simple;
	bh=FBbJm2anrEqzXBTYp1GyxNAXtEy0KveRX0Hn1WE48l8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K9BTLy9Ah0XI2mXcBNhusECmsK04PRW40zT2KnJsOXY3HNcKenkZtW00xFQCQghbn/UfoLXAWiprmEdg8O5jcoazFhr8FOdcdDd1DUrRaFbHiidRlCFqJhUb9KYfXjBrz1Q22ERAHVNgZCyG9As0Lc2iofRmspGnPY7f+99PN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayhSnWS6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayhSnWS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C021F000E9;
	Sat,  8 Aug 2026 01:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786151012;
	bh=vf4JYZapfeElGh38/cawM1dKKm8XB9S89rc/o9OTXo4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ayhSnWS6IBEcIvUQ/uaOqzCGdF+xk4vqk0lZTCTb6OpHICUxGJpn5INsLyXxYmwSR
	 2H3IvmpGKjHXDrv9dSRxBRXAjYZ1/PMPpjgf6UlMRgFz4v4x5bF+KevkgeHSH0JZ3M
	 SHRsqixHPny6AONuktLARgsrbiIaNbEvUHVTxmUBjvvWpTVwJz+xXW2nwuMaNV7orc
	 15mu8oW4mh/HN3cynLtkeSEokBbBkOxMVYkieMLMiPYoPxYuCXKQ+7ri87aMc15Nhf
	 f8N5fzzNrzRAtvHCK56bJQG2a64nSjs1UPR42J2gJRvKHnGeGGEyZifipcxdi0Wbf2
	 QtoG2tMg+KH9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 10/14] selftests/bpf: Add struct_ops __arena
 and __arena__nullable argument tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260808003938.3486067-11-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
 <20260808003938.3486067-11-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 01:03:31 +0000
Message-Id: <20260808010332.90C021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unsafe unconditional dereference of `st_ops3` and its callbacks in=
 the newly added kfuncs, leading to a kernel panic.
--

--- Patch [10]: [PATCH bpf-next v5 10/14] selftests/bpf: Add struct_ops __a=
rena and __arena__nullable argument tests ---
commit ca58e222e16e38d0927f0dd75956c9489242a175
Author: Tejun Heo <tj@kernel.org>

selftests/bpf: Add struct_ops __arena and __arena__nullable argument tests

This patch adds test_arena and test_arena_nullable members to bpf_testmod_o=
ps3
with arena-tagged arguments. It also introduces kfuncs that forward caller-
provided pointers to them to test end-to-end conversions of arena pointers.

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 2291bb4665178..1e6d632c6f836 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
[ ... ]
> @@ -406,6 +418,16 @@ __bpf_kfunc void bpf_testmod_ops3_call_test_2(void)
>  	st_ops3->test_2();
>  }
> =20
> +__bpf_kfunc int bpf_testmod_ops3_call_test_arena(u64 *ptr__arena)
> +{
> +	return st_ops3->test_arena(ptr__arena);

[Severity: High]
Does this code risk a NULL pointer dereference if st_ops3 has not been set =
yet?

The global pointer st_ops3 is initialized to NULL and only set when a struc=
t_ops
map is explicitly registered. A BPF program could trigger a kernel panic by
invoking this kfunc via BPF_PROG_RUN before the map is attached, or concurr=
ently
during teardown.

While this pattern is also used in the pre-existing bpf_testmod_ops3_call_t=
est_1()
kfunc, should st_ops3 be checked for NULL, potentially while holding
st_ops_mutex, before dereferencing it here?

> +}
> +
> +__bpf_kfunc int bpf_testmod_ops3_call_test_arena_nullable(u64 *ptr__aren=
a__nullable)
> +{
> +	return st_ops3->test_arena_nullable(ptr__arena__nullable);

[Severity: High]
Similarly, can this unconditionally dereference st_ops3 when it is NULL?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808003938.3486=
067-1-memxor@gmail.com?part=3D10
