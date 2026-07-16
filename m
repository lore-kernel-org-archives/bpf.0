Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C8E3C0602
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195399; cv=none; b=qrXyYFes4NvQmvuiN3fnFbT0EKmd/ZxJmT0sM2Pe6/drCVqO+iF6HAjHd0r4f6erGc9lF//qpikD4EMAcSfm/ms8yEOWLAXhzQCZ98XzHQ+5xnyQThZB78agVmo7V04dkO9EpwLrpcnLw/qnSzpiO9y3kGF/AWWww/BeZnC9qQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195399; c=relaxed/simple;
	bh=EXLoCgU84unkSOKqzyiV7ohBA0kAXe2GtArXHuJybDs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oNu/c8MbgSz7O9ua5huMQHsGA7JQYFlvv5ghZinckZIlGRtRC9Q32WLdj0+sT0b4pt5gY4tmRdRP+9mAcUViZvW3AhJ2vEIu4C0M4PLrGBKA+d4i8dZwPpd5+/jeRqb6ZZAo+DZq4W31oVlJTyVOSA6GdWJM7Z3nvA+8BjVyL/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LppP2LfP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LppP2LfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1351F000E9;
	Thu, 16 Jul 2026 09:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784195398;
	bh=yTS8/kEY+reKo+i9vFjFhyV7dgMS7evWMrH4Du4dChY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LppP2LfPS73LvZZedOYLQkngpyFSh2H59S4YOfJdURKDJjqjocgA5tmNBoE8uvGsW
	 VRFobbxPBb8jjMsqdI3yDZ4fHkdrE2HAIBGyVVRk76ciThP5tY1GWKtR8PonAY9NqL
	 wMwJJnoX38NaBn8MwPTPRfB3n62O4kxalVEONr7Z4RAtR3/4xrq2Lavgh79PNm1Bo6
	 Y1VwM57pL4XDtJzBYDt40WDBRAC6QpfaOtmKMYErxLFDGeQxA4id496EZrhl6p9tgz
	 /Y8K9J9VHiLQZ1y9DM4mH2Wc+ys1jEHMKT4ciu+LtK5LuQ7FDgdYINg10vhJ0Gd3Un
	 VXovT0TwUjvvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Test
 bpf_strcat,bpf_strncat kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rong Tao" <rtoax@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_C7A5E27560540491DBE052682ACBE1F24405@qq.com>
References: <cover.1784194024.git.rtoax@foxmail.com>
 <tencent_C7A5E27560540491DBE052682ACBE1F24405@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 09:49:57 +0000
Message-Id: <20260716094958.1F1351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] `__bpf_strncat` reads `sz + 1` bytes from `src` when no null termi=
nator is found within the first `sz` bytes, violating bounded string semant=
ics and potentially causing spurious `-EFAULT` errors.
- [High] When `sz` is `U32_MAX`, the expression `sz + 1` overflows to `0` i=
n `__bpf_strncat`, causing it to append zero bytes and silently fail to per=
form the concatenation.
--

--- Patch [2]: [PATCH bpf-next v3 2/2] selftests/bpf: Test bpf_strcat,bpf_s=
trncat kfuncs ---
commit d6f2c6815c7c6f9bb6e7aba87e72c1ed642b70c1
Author: Rong Tao <rongtao@cestc.cn>

selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs

This commit adds selftests for the newly introduced bpf_strcat() and
bpf_strncat() kfuncs. It includes various test cases verifying successful
operations, error handling for NULL pointers and invalid memory accesses, a=
nd
buffer overflow conditions.

> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/=
tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> index f65b1226a81a3..b24456ad3d43b 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
[ ... ]
> @@ -59,5 +61,7 @@ __test(-ENOENT) int test_strncasestr_notfound1(void *ct=
x) { return bpf_strncases
>  __test(-ENOENT) int test_strncasestr_notfound2(void *ctx) { return bpf_s=
trncasestr(str, "hello", 4); }
>  __test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_s=
trncasestr("", "a", 0); }
>  __test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr=
(str, "", 1); }
> +__test(10) int test_strcat_success(void *ctx) { return bpf_strcat(buf1, =
sizeof(buf1), "world"); }
> +__test(8) int test_strncat_success(void *ctx) { return bpf_strncat(buf2,=
 sizeof(buf2), "world", 3); }

[Severity: High]
While reviewing these tests, looking at the __bpf_strncat() implementation
added earlier in this series, could this result in an integer overflow if a
BPF program passes U32_MAX for the len argument (sz)?

kernel/bpf/helpers.c:__bpf_strncat() {
    ...
	copied =3D strncpy_from_kernel_nofault(dst + dlen, src,
				      min(space, sz + 1));
    ...
}

When sz is U32_MAX, sz + 1 overflows to 0, causing the copy routine to
append zero bytes and silently fail to perform the concatenation, instead of
returning an error.

[Severity: High]
Also looking at the same __bpf_strncat() implementation, can this cause a
spurious -EFAULT if the source string exactly aligns with the end of a mapp=
ed
memory page and does not contain a null terminator within the first sz byte=
s?

Because the copy routine evaluates sz + 1, it unconditionally attempts to
read one byte past the sz boundary specified by the user if no null
terminator is found earlier.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784194024.gi=
t.rtoax@foxmail.com?part=3D2
