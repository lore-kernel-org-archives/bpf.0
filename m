Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680B38E121
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537475; cv=none; b=pkDd1vG4ApKJ+ryKwT8bmDtHFiuRxkhsEnWnSBD6o298bNCVsbTWdC2830mh+iDHiDBurIAsSuEKXP5iyKnUe35K/ajv4c16JnigqdzZwjBjKlr2OrjAbplscTQ2u6xAs0kDpUCPyPiuOn0yPW68B+u7SG82r87p1dqnWl1roEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537475; c=relaxed/simple;
	bh=JVx5tan+Pyb392xEiopc/WBT3fDqmsN4cmKdX9DlPa8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D/N4d9+fy0qZ8BvoENt7mRa+nghGGk0tvaOftHkziMlNlNuSHvTG6Ga93XfKDCEUeThVjgjT1WZub3X6rkggAf3rXSrkQ27T7c5BCBPcAXHBE7IZ0XlyDzRe08GbzlqjLMAil7000NrO2L39m6cdFOsE8LQfbQThWPN9O9OxEus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcUS/3cu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcUS/3cu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072751F000E9;
	Mon, 20 Jul 2026 08:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784537474;
	bh=VAxiG7CW/ecZCnkPBPHbideqnXtKmZX5tms9G/bnJdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XcUS/3cuPTY90nR3zF8GsXl7W3/YAoGgJm1S3Hyqh/egYAURcy5Iq6yXgFrr8YUKd
	 1bQeRt8bb/duDyQLc+zfDj+cbbNgXAyyqzrtcPD9bskHu551t2KgNNQyd0JyK4tZRK
	 62S+hBJuvXQmCQN66eHu33U+RjztK3sETHBN/17ueNTrGD9JftK5sJ11cykinDpa2Q
	 QvyjN0KtIs2Vz4r9AWIe3TYbzi8M1i4fxH5ZCE/rVR42WRLG2PLB+hZoXDbQibyDAA
	 aA1gnIEhRrcCQqDP9YJxLdKV+lj3snT63jO7kSNXn579EWp96LUVfWe1i8TPDIdLli
	 rCTz6R6LoE3dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Test
 bpf_strcat,bpf_strncat kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rong Tao" <rtoax@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_1A540D31C1E052E8262BE0324005E7756D05@qq.com>
References: <cover.1784536164.git.rtoax@foxmail.com>
 <tencent_1A540D31C1E052E8262BE0324005E7756D05@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 08:51:13 +0000
Message-Id: <20260720085114.072751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] `__bpf_strncat` contains a critical out-of-bounds read and pot=
ential kernel panic when `dst` is not null-terminated.
- [High] The new failure tests passing scalar or invalid pointers to `bpf_s=
trcat` and `bpf_strncat` will be rejected by the verifier, breaking the sel=
ftest suite.
- [High] The `test_strncat_success` test asserts an incorrect return value =
and checks against the wrong string, guaranteeing runtime failure.
- [High] The `src` argument in `bpf_strcat` and `bpf_strncat` lacks a strin=
g or size suffix, causing the verifier to only enforce a 1-byte size, leadi=
ng to kernel memory disclosure.
- [High] `run_too_long_tests` asserts `-E2BIG` but `__bpf_strncat` returns =
`-EINVAL`, breaking the test suite.
--

--- Patch [2]: [PATCH bpf-next v4 2/2] selftests/bpf: Test bpf_strcat,bpf_s=
trncat kfuncs ---
commit 08f044c5d96948cad08013caa519f6e718db089c
Author: Rong Tao <rongtao@cestc.cn>

selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs

This patch adds selftests for the newly introduced bpf_strcat() and
bpf_strncat() kfuncs. It extends existing string kfunc failure and success
test suites to validate these operations. It also cleans up some extra
whitespace in string_kfuncs_failure1.c.

> diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/too=
ls/testing/selftests/bpf/prog_tests/string_kfuncs.c
> index 300032a194451..460567ef622a5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> @@ -24,6 +24,8 @@ static const char * const test_cases[] =3D {
>  	"strcasestr",
>  	"strnstr",
>  	"strncasestr",
> +	"strcat",
> +	"strncat",
>  };

[Severity: High]
Will run_too_long_tests() fail for these new test cases due to a mismatched
error code?

The run_too_long_tests() loop expects all over-long string tests to return
-E2BIG. However, looking at __bpf_strncat() in kernel/bpf/helpers.c, if the
destination buffer is full because it lacks a null terminator within dsz
bounds:

    if (dlen >=3D dsz || sz =3D=3D 0 || dsz =3D=3D 0)
        return -EINVAL;

Since the test string is completely filled without a null terminator, would=
n't
it return -EINVAL instead of -E2BIG, causing the ASSERT_EQ to fail?

> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b=
/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> index bddc4e8579d24..d432d4990f802 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
[ ... ]
> @@ -30,29 +31,31 @@ char *invalid_kern_ptr =3D (char *)-1;
> =20
>  /* Passing NULL to string kfuncs (treated as a userspace ptr) */
[ ... ]
> +SEC("syscall") __retval(USER_PTR_ERR)int test_strcat_null1(void *ctx) { =
return bpf_strcat(kern_buf, sizeof(kern_buf), NULL); }
> +SEC("syscall") __retval(USER_PTR_ERR)int test_strncat_null1(void *ctx) {=
 return bpf_strncat(kern_buf, sizeof(kern_buf), NULL, 2); }
> =20
>  /* Passing userspace ptr to string kfuncs */
[ ... ]
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcat_user_ptr1(void *ct=
x) { return bpf_strcat(user_ptr, 1, kern_buf); }

[Severity: High]
Will these tests fail to load during verification rather than failing at
runtime?

Because the dst and src parameters in bpf_strcat() lack the __ign or
__nullable suffix in their kernel definitions, the verifier treats them as
strictly typed KF_ARG_PTR_TO_MEM.

If we pass a scalar like user_ptr or NULL, won't the verifier reject the
program during the load phase, breaking the test suite when the skeleton is
loaded?

> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b=
/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> index 412c53b87b182..2dbd1349689ea 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
[ ... ]
> @@ -23,5 +24,7 @@ SEC("syscall") int test_strstr_too_long(void *ctx) { re=
turn bpf_strstr(long_str,
>  SEC("syscall") int test_strcasestr_too_long(void *ctx) { return bpf_strc=
asestr(long_str, "hello"); }
>  SEC("syscall") int test_strnstr_too_long(void *ctx) { return bpf_strnstr=
(long_str, "hello", sizeof(long_str)); }
>  SEC("syscall") int test_strncasestr_too_long(void *ctx) { return bpf_str=
ncasestr(long_str, "hello", sizeof(long_str)); }
> +SEC("syscall") int test_strcat_too_long(void *ctx) { return bpf_strcat(l=
ong_str, sizeof(long_str), str); }

[Severity: Critical]
Could this test trigger an out-of-bounds read and kernel panic?

Looking at __bpf_strncat() in kernel/bpf/helpers.c, when calculating dlen
there is no bounds check against dsz:

    while (dst[dlen] !=3D '\0')
        dlen++;

If test_strcat_too_long() passes a completely filled long_str without a null
terminator, won't this loop read past the end of the BPF-provided buffer in=
to
adjacent kernel memory?

> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/=
tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> index f65b1226a81a3..71fbbe97b4c50 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
[ ... ]
> +__test(0) int test_strcat_success(void *ctx) {
> +	char buf[32] =3D "hello";
> +	bpf_strcat(buf, sizeof(buf), str);
> +	return bpf_strcmp(buf, "hellohello world");
> +}

[Severity: High]
Does the signature of bpf_strcat() allow arbitrary kernel memory disclosure?

The src parameter in bpf_strcat() is annotated simply as const char *src,
lacking a __str suffix or a paired size argument in kernel/bpf/helpers.c:

    __bpf_kfunc int bpf_strcat(char *dst, u32 dst__sz, const char *src)

This causes the verifier to check only the size of the base type (1 byte).
If a BPF program passes a valid 1-byte memory region, could
strncpy_from_kernel_nofault() safely copy past the 1-byte verified region,
exposing adjacent kernel memory into dst?

> +__test(8) int test_strncat_success(void *ctx) {
> +	char buf[32] =3D "hello";
> +	bpf_strncat(buf, sizeof(buf), str, 3);
> +	return bpf_strcmp(buf, "hellohe");
> +}

[Severity: High]
Is the expected return value correct here?

The test uses __test(8), expecting the program to return 8. However,
bpf_strcmp() evaluates to 0 on a successful match. Wouldn't the program
return 0 instead of 8, causing this test to fail reliably?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784536164.gi=
t.rtoax@foxmail.com?part=3D2
