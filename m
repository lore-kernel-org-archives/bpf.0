Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC894327BEC
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 01:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079777; cv=none; b=oLFaO0jsl28RRaciSgWgWwKOvGEvX8l3vmwIiVmTNC/Brol7s3nF5hv2sjGnqkDk7ARKr1GDfduE3dsE3ICmC/B052gF8wHIxX6mkVezowOmuMwXwpHw3tf1FOmknGFam3235mSfDRHJRTpd+1jiYGrRqhDhysrwp6ZnelxlRlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079777; c=relaxed/simple;
	bh=Lzoj8jECG6hQ5cSmm8AZByNYb9Ln1cLlYFdc4TVcQBs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fzbLalXYpA48KMc/VLt8TrYGknZ1zrjqFA/VNKPoagAMez825zDZ0J4tcQ21r8oIzAO1SrmdWrtlYUCVM+ptJiJ9fMVnrSDV5rECJVnYFrWJ9oMIFA+DX7eBeL8u+rg0mwcb+LJah4yokQUfvbzqE9hInYdu66xBYnn9fACf570=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Keo1AVlz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Keo1AVlz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E721F000E9;
	Wed, 15 Jul 2026 01:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784079776;
	bh=RPYpA9yPeG3UJppesgCqHY9Q1xcOCuuplQnwA169KME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Keo1AVlzyysHFo3KXgtTSS/qgR1L8Gm8RipSNTT7UoqAly1Q3Z+YmO1b9QfdwFX2Z
	 Bxd7Ec9oLg5ACEnyRife0oeWsc/Qov1L1pBH+t2PXqj5W/pp6JLkibexzS5Aedp1/n
	 Pp1N6BeS+OkLrjp8MkmYOl/FeybWWkzNaxWrs80q0JqDt+HbkVHi9njwloC2o2NVNt
	 ZcpPGde+hEu4t2HerB7+l62YNM+sXSNO+lV/KUN6OLVaCVhbsz2uXGJj113S8wact7
	 8o1e1+7P1HZh5NPsZ89exn2GqFRwP9nSCb8dqY/41sj+Zt01yXW5l6lsWG9W+/z9hg
	 JuHn/brvpky1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test
 bpf_strcat,bpf_strncat kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rong Tao" <rtoax@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_DB0510330C3A8574B3C62E6154165FCB4709@qq.com>
References: <cover.1784078494.git.rtoax@foxmail.com>
 <tencent_DB0510330C3A8574B3C62E6154165FCB4709@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 01:42:55 +0000
Message-Id: <20260715014256.15E721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The selftest `test_strncat_success` unconditionally fails becaus=
e it incorrectly expects a return value of 13, assuming the global buffer r=
etains state across subtests.
- [Medium] Six failure tests for `strcat` and `strncat` will fail to load i=
n the verifier because they pass invalid scalars (`NULL`, `1`, `-1`) to the=
 strictly typed `dst` memory pointer argument.

Pre-existing issues:
- [High] The `__bpf_strncat` kfunc unconditionally performs an out-of-bound=
s read of the source string to check for truncation, erroneously returning =
`-EFAULT` on perfectly valid memory.
--

--- Patch [2]: [PATCH bpf-next v2 2/2] selftests/bpf: Test bpf_strcat,bpf_s=
trncat kfuncs ---
commit a3847dce2f7db636af75a6ec747d26e7cc1b00dd
Author: Rong Tao <rongtao@cestc.cn>

selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs

Add tests for new kfuncs bpf_strcat() and bpf_strncat().

> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b=
/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> index bddc4e8579d24..29bc7eabbb6aa 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
[ ... ]
> @@ -53,6 +54,10 @@ SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr=
_null1(void *ctx) { return
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null2(void *ctx) =
{ return bpf_strnstr("hello", NULL, 1); }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null1(void *c=
tx) { return bpf_strncasestr(NULL, "hello", 1); }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null2(void *c=
tx) { return bpf_strncasestr("hello", NULL, 1); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strcat_null1(void *ctx) {=
 return bpf_strcat(NULL, 6, "hello"); }

[Severity: Medium]
Will this test, along with test_strcat_user_ptr1 and test_strcat_pagefault1
added below, fail to load in the verifier?

Because the dst argument in bpf_strcat() lacks the __ign suffix, the verifi=
er
strictly checks it as a KF_ARG_PTR_TO_MEM_SIZE. Passing NULL or scalar valu=
es
like 1 or -1 causes load-time rejection with -EACCES.

Since the __retval(...) annotation expects a successful load followed by a
runtime error, will these tests cause the test runner to abort with an
unexpected load failure?

> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strcat_null2(void *ctx) {=
 return bpf_strcat(kern_buf, sizeof(kern_buf), NULL); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strncat_null1(void *ctx) =
{ return bpf_strncat(NULL, 6, "hello", 2); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strncat_null2(void *ctx) =
{ return bpf_strncat(kern_buf, sizeof(kern_buf), NULL, 2); }
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/=
tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> index f65b1226a81a3..93996b0e9595e 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
[ ... ]
> @@ -59,5 +60,7 @@ __test(-ENOENT) int test_strncasestr_notfound1(void *ct=
x) { return bpf_strncases
>  __test(-ENOENT) int test_strncasestr_notfound2(void *ctx) { return bpf_s=
trncasestr(str, "hello", 4); }
>  __test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_s=
trncasestr("", "a", 0); }
>  __test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr=
(str, "", 1); }
> +__test(10) int test_strcat_success(void *ctx) { return bpf_strcat(buf, s=
izeof(buf), "world"); }
> +__test(13) int test_strncat_success(void *ctx) { return bpf_strncat(buf,=
 sizeof(buf), "world", 3); }

[Severity: Medium]
Does this test expect an incorrect return value?

The BPF test loader isolates subtests by reloading the skeleton for each te=
st
program. This resets the global variable buf back to its initial .data state
of "hello" (5 bytes) before this test runs.

Because bpf_strncat() appends "wor" (3 bytes) to "hello", won't the correct
return value be 8 instead of 13?

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem in the
__bpf_strncat() implementation being tested here.

kernel/bpf/helpers.c:__bpf_strncat() {
        ...
        __get_kernel_nofault(&cs, src, char, err_out);
        if (cs !=3D '\0' && sz > copied)
                return -E2BIG;
        ...
}

Does this unconditionally read past the requested size boundary?

If a caller requests exactly sz bytes, and the source string satisfies this
but ends at a page boundary, won't the unconditional read of the next byte
cause a spurious page fault and incorrectly return -EFAULT instead of succe=
ss?

>  char _license[] SEC("license") =3D "GPL";

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784078494.gi=
t.rtoax@foxmail.com?part=3D2
