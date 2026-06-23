Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008C2749DF
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 03:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184800; cv=none; b=IWAjHbVSUUISACPzgbAJ//VY+ESwLVE6wh0CgnK7THmE0NX3xRlz70JDIfUmq4V/4CJDIaGsMD1KnGOtDuLcKl6GWnmyyTUIJRGOv/QaF68+mIW+OFCmVs9+9JucmGZZdpTD/2OYIUwOtXkG4LIoC1BFFUax0JUixq1WDOsKQpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184800; c=relaxed/simple;
	bh=OOSMfNjFt3o9qUGdMd1J/xkeHs/ddacbeCw6/NyiNDI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uqZUl33dVr575B4eJ9L+28rlnCWliIW46wUM9CuRcBRxTWUUreJxuAVfG0ZBkY4iETShZpWanN2LHcfQrCEMCqZKZy5cMYj24OYJ7VdHdCJBlmyZV6wSil3DS2WjY9sRQIo7aoO5c7cWWgda6237jAfOt6FP6pO6M72GhJ9I79M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1iZ2Zzs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1iZ2Zzs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEC01F000E9;
	Tue, 23 Jun 2026 03:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782184798;
	bh=rgebdMnAAYnELcJvvXyUk0/dRqmVIRY7aMwH0zUJQBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f1iZ2ZzsPvESF76skb1j+aF5Idl5KRNBJulmCMAVYKRP+5BP+UNaO9HSgYhxnog05
	 S1Vxp3eHgt5mXYpDRmhKTc9jLNazbNRuOyGMj8LhL4pC91k2iC6kyaqIUnfobZcLK1
	 brqAtXUAaHWLIRLkeOfvBkQT+Sz+wmPYl0PVx9TGVS9+SmeQ0jDGiu0L9KagLpkqsk
	 N2o6kNeKCs1vVoxQ2lmJGNj6h4r22KMhTtXCIYQnxWnKpcB0Qgpn1uDRlLTqjn8L6C
	 rxEmzWYTenJ68H/AftwsaM/KhXkscC2mM8sMYhqz7Us6SINMUJRVIaRFjtnqDNp/dJ
	 qpy5nHZDFPDhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: add tests for bpf_strpbrk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Tang" <lange_tang@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623030803.44798-6-lange_tang@163.com>
References: <20260623030803.44798-1-lange_tang@163.com>
 <20260623030803.44798-6-lange_tang@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 03:19:58 +0000
Message-Id: <20260623031958.AFEC01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The selftests for bpf_strpbrk lack negative tests for the -E2BIG (t=
oo long string) error paths, leaving this core logic completely untested.
- [Low] The test `test_strpbrk_found_multiple` does not actually test a mul=
tiple-match scenario as claimed in the commit message.

Pre-existing issues:
- [High] O(N*M) algorithmic complexity in string kfuncs (bpf_strpbrk, bpf_s=
trspn, bpf_strcspn) allows a malicious BPF program to stall the CPU and cau=
se a Denial of Service.
--

commit a3423f682404351839c3773b03881a48a31cc20c
Author: Longjun Tang <tanglongjun@kylinos.cn>

selftests/bpf: add tests for bpf_strpbrk
   =20
Add functional tests for first-match, multiple-match, not-found, and
empty-accept cases. Add negative tests for NULL, user-space, and
invalid kernel pointer arguments.

> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/=
tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> index c2be9edcd2821..e67b80ab3cd2c 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
[ ... ]
> @@ -63,6 +64,13 @@ __test(-ENOENT) int test_strncasestr_notfound2(void *c=
tx) { return bpf_strncases
>  __test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_s=
trncasestr("", "a", 0); }
>  __test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr=
(str, "", 1); }
> =20
> +/* bpf_strpbrk - functional tests */
> +__test(0) int test_strpbrk_found_first(void *ctx) { return bpf_strpbrk(s=
tr, "h"); }
> +__test(4) int test_strpbrk_found_middle(void *ctx) { return bpf_strpbrk(=
str, "ow"); }
> +__test(6) int test_strpbrk_found_multiple(void *ctx) { return bpf_strpbr=
k(str, "w"); }

[Severity: Low]
Does this test actually verify a multiple-match scenario?

The target string "hello world" only contains a single 'w', and the accept
string is just "w". Would it be better to test with a character that appears
multiple times, such as "l" or "o"?

> +__test(-ENOENT) int test_strpbrk_notfound(void *ctx) { return bpf_strpbr=
k(str, "xyz"); }
> +__test(-ENOENT) int test_strpbrk_empty_accept(void *ctx) { return bpf_st=
rpbrk(str, ""); }
> +
>  /* bpf_memcmp - functional tests */

[Severity: Low]
Are we missing negative tests for the -E2BIG (too long string) error paths?

It appears that the test_cases array in prog_tests/string_kfuncs.c was
not updated to include "strpbrk", and string_kfuncs_failure2.c is missing
the corresponding BPF programs for bpf_strpbrk.

Could this leave the bounds-checking logic untested?

[Severity: High]
This is a pre-existing issue, but does the algorithmic complexity in the
underlying string kfuncs allow for a Denial of Service?

Looking at kernel/bpf/helpers.c, functions like bpf_strpbrk(), bpf_strspn(),
and bpf_strcspn() use nested loops bounded by XATTR_SIZE_MAX (64KB):

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

If a BPF program calls one of these kfuncs with two strings up to 64KB in
length that do not share any characters, the loops will execute O(N*M)
times, resulting in up to 4.29 billion memory reads.

Since the verifier is unaware of this internal kfunc complexity, can this
deliberately stall the CPU for tens of seconds and trigger RCU stalls or
watchdog lockup panics?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623030803.4479=
8-1-lange_tang@163.com?part=3D5
