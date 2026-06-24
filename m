Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C423B2D1A
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294503; cv=none; b=b/goJZG1z+bYPMpp/ubn16m3pg+WHC3X7pWtXsess0ueBhlU+ql/GRo49YjCeXLjGQOWTQEwNMoA7wMXgE9CZhJTeGpQK4ExlsF3xKX8dBSDeZg6cmNNTg+nYPR08vpP7xkhgEQgDtA690+pJhW9qvvCafhv418AgGdGQqFXFUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294503; c=relaxed/simple;
	bh=kggxYFwc6rACgy7NXjbxK+d3AyyEil2M1fE0SmCNlO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=evSBOFkZ818SwyZJU7nyzzTHRY6z+yVDzcCtF7NeKJXFBA9tIPyHeji7LhT0IpnfLc+hTUGL5UdHSJO902NXt6OSGc7Tn84s7z3jwNaEsmaljA195SE70zbKl5WF7Hq++xf21akremd40LY8RD7mcn8k7mIqvtw2n2NejuxyKxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFSGwkvs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFSGwkvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37EB1F000E9;
	Wed, 24 Jun 2026 09:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782294501;
	bh=FhNpx8C3BaITcny0Fd21ZwqseKGawOiEPedoWDh69J0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WFSGwkvsdnr+sTTWJVYsnIqYDVgHBdqiJ5tnhIeI+8vIUm2orXYMCEXd2EQtkMfKA
	 kTa/IF7r7lvJynQ+uYEI8SuLisPuQSleKsK7YCn3RO0yJX58NawYz2+LiMR8ORbveK
	 cl3Wf5p7BSMV09zZ0AF9kXGCRZigcY2JZFXotbf90SkS2ZDAyTvI2pQzqiy3paSx6v
	 Ik8qzcgTmcah5eOAQr6fMiwn0KNZr1H0eO+UYkm3/D5D8xWbyI0oPKg4otmeiJ9hdA
	 uaHti4bbKfZHYEcrgtZnjJ4NvhTgxFeVvFED5STRXV7ZGh39vSmkiAF7jtKPNVNULf
	 dKgAPk6waxOOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: add tests for
 bpf_strpbrk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Tang" <lange_tang@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260624093638.117062-6-lange_tang@163.com>
References: <20260624093638.117062-1-lange_tang@163.com>
 <20260624093638.117062-6-lange_tang@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 09:48:20 +0000
Message-Id: <20260624094820.C37EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The string search kfuncs (bpf_strpbrk, bpf_strspn, bpf_strcspn) ha=
ve an O(N*M) algorithmic complexity that can trigger up to 4.29 billion mem=
ory reads in the kernel, stalling the CPU. The newly added tests explicitly=
 mask this vulnerability.
--

commit 8efd73628e6ad8d84061c17ed578ece973a232c2
Author: Longjun Tang <tanglongjun@kylinos.cn>

selftests/bpf: add tests for bpf_strpbrk
   =20
Add functional tests for first-match, multiple-match, not-found, and
empty-accept cases. Add negative tests for NULL, user-space, and
invalid kernel pointer arguments.

> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b=
/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> index 412c53b87b182..d3b978e453bd7 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> @@ -19,6 +19,8 @@ SEC("syscall") int test_strspn_str_too_long(void *ctx) =
{ return bpf_strspn(long_
>  SEC("syscall") int test_strspn_accept_too_long(void *ctx) { return bpf_s=
trspn("b", long_str); }
>  SEC("syscall") int test_strcspn_str_too_long(void *ctx) { return bpf_str=
cspn(long_str, "b"); }
>  SEC("syscall") int test_strcspn_reject_too_long(void *ctx) { return bpf_=
strcspn("b", long_str); }
> +SEC("syscall") int test_strpbrk_str_too_long(void *ctx) { return bpf_str=
pbrk(long_str, "z"); }
> +SEC("syscall") int test_strpbrk_accept_too_long(void *ctx) { return bpf_=
strpbrk("b", long_str); }

[Severity: High]
This is a pre-existing issue, but by only testing a single large string
against a 1-byte string, do these tests mask an O(N*M) algorithmic
complexity in the underlying implementation?

Looking at the nested loops in bpf_strpbrk():

kernel/bpf/helpers.c:bpf_strpbrk() {
	...
	for (i =3D 0; i < XATTR_SIZE_MAX; i++) {
		__get_kernel_nofault(&cs, s__ign, char, err_out);
		if (cs =3D=3D '\0')
			return -ENOENT;
		for (j =3D 0; j < XATTR_SIZE_MAX; j++) {
			__get_kernel_nofault(&ca, accept__ign + j, char, err_out);
	...
}

Since XATTR_SIZE_MAX is 65536, if a BPF program passes two 64KB buffers
constructed to avoid early loop termination (e.g., no matching characters
and a null-terminator only at the very end of the inner string), couldn't
the function perform up to 4.29 billion calls to __get_kernel_nofault()?

Could this stall the CPU for several seconds, bypassing BPF execution time
limits and potentially triggering a watchdog soft-lockup?

Would it be worth adding a test case that passes long_str for both arguments
to expose how the kernel handles this worst-case scenario?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624093638.1170=
62-1-lange_tang@163.com?part=3D5
