Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2E5274652
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 03:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185185; cv=none; b=ImVeq1cakGIjQLd2Czqs0iZgswnvpkNaHG7pDbb6JqekkX4xh8Q0LLEA0si1UUqPDzNsYsoHT3IZA7ZKBPW7UHoyV0VtzjmFi9wOVIc49eucV6t+ALPtEHQl9ShGX9mnx2VOMoamTiBwlnErwwWaNuZcLX+eN1EBz8LQwH6Eg64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185185; c=relaxed/simple;
	bh=3qXaKFM7QAXYtMHWkDNFPG7rJQHzI+cJAPUUmQWOGi4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=py68JJtaqo6ixWE5vYuhqNcB07SqOBUT1ReWcGnCgBQtAsKZgP93LfJRFZBzcMGyJzDw0zbyWFdda76a1PIiYX4TPnM9I1DmTfZOoveS7DqADN5e6kkFmHa4wzjfAXHggOMtgMCd0dRQhuEFrgsXWghg9NDCjTqYZMRf3bHGisE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvrCqn2m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvrCqn2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A576B1F000E9;
	Tue, 23 Jun 2026 03:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782185183;
	bh=jukQCj8bAXeisMR0/lvmKysovlGRfIavv8p4sGNPncA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YvrCqn2mpupIKonT1qomS9b3pBhI8Eo5wi6SuqkoAQhzKk5lCD8g+aixDvBHYva2S
	 uFuhW6IQDTV9PUriubQ3W0rO+uUKN1XfnEgU/vAeMApe79j1ZXHTS8zTtF1kSATlxf
	 KusX2pblmPfiQZcjNl8UUXZmtfDLHlPw57BGNoQIhixqdsp1slgZ+G9SlA+f8/Ezia
	 hzGGCTxIaOvxbSHAtU7Zm2nYmJly1HfktDsRXm/O25XU5jIKAu4Tqp1iSO55AP5GPT
	 Uy2eoIq8CQvRCFkBU/u3xhwFdSHQ0fSdcLQ4GJ6fJfa5oYuRhbi0zbeQymHmLDKslQ
	 MxBzsXRGkGiag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: add tests for bpf_memcmp
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Tang" <lange_tang@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623030803.44798-4-lange_tang@163.com>
References: <20260623030803.44798-1-lange_tang@163.com>
 <20260623030803.44798-4-lange_tang@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 03:26:23 +0000
Message-Id: <20260623032623.A576B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The `__ign` suffix in `bpf_memcmp` and other string kfuncs byp=
asses BPF verifier checks, allowing arbitrary kernel memory reads and bypas=
sing CAP_PERFMON capability restrictions.
--

commit 7bc905114c7536361d9f8dec63d9c798b78c1718
Author: Longjun Tang <tanglongjun@kylinos.cn>

selftests/bpf: add tests for bpf_memcmp
   =20
Add functional tests for equality, ordering, zero-size, and null-byte
handling. Add negative tests for NULL, user-space, and invalid kernel
pointer arguments.

> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b=
/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> index bddc4e8579d24..a85d64605d0e7 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> @@ -9,6 +9,9 @@
>  char *user_ptr =3D (char *)1;
>  char *invalid_kern_ptr =3D (char *)-1;
> =20
> +extern int bpf_memcmp(const void *ptr1__ign, const void *ptr2__ign,
> +		      size_t size) __ksym;

[Severity: Critical]
This is a pre-existing issue, but does using the __ign suffix in the kfunc
declaration of bpf_memcmp allow BPF programs to bypass verifier capability
checks?

Looking at check_kfunc_args() in kernel/bpf/verifier.c, it appears the
verifier completely skips validation for arguments with the __ign suffix:

        if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(met=
a, i))
                continue;

Since bpf_memcmp() is available in common_kfunc_set without requiring
CAP_PERFMON, could an attacker pass an arbitrary kernel address as a
SCALAR_VALUE to ptr1__ign or ptr2__ign?

Because bpf_memcmp() uses copy_from_kernel_nofault_allowed() and safely
handles the memory access without crashing, this could potentially provide =
an
oracle to leak kernel memory byte-by-byte, acting as an unrestricted bypass
for bpf_probe_read_kernel.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623030803.4479=
8-1-lange_tang@163.com?part=3D3
