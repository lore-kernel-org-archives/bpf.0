Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B743559F5
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 20:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777841917; cv=none; b=X2KeL2b3VAAsr/fUmx6Y9h8F0Gmc7dhjV5qbPwDxBoOvHLojKA8D77OUxeS4gnoOPOP+dJnPgTi7c+SZFdz2/nAUbkxlhdoEbGXXOxv7sUxZO7FmzvguJQeIh3ZaM0xSq+JJ/dad78pvEbrPvLUXzfy7K2BgLoYzDhmHzmjxI7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777841917; c=relaxed/simple;
	bh=eJ+pbOtMM3LpSJu3hw5KkcT1IRFoqepE+ZMoA8v+HwY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kl0QONKcLSWmvpUZWaU3C/fUGbnU9Rsd1wY0rcbtF8/08Lzf44wlpUEuKtCEEl/9U8WlJgcp6y5gmSbPnFAhLdRL5tEzwJ4T+QwpceS3p4XWcZgHeQ9JCLh2o7ZB22/5B3Z04sYxu17OwumHiW+ZbIL+w5gb29y/BFhsvC6EUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETy6jiHi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETy6jiHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E511C2BCB4;
	Sun,  3 May 2026 20:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777841916;
	bh=eJ+pbOtMM3LpSJu3hw5KkcT1IRFoqepE+ZMoA8v+HwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ETy6jiHi+n0HmI5OTfzn4n7cgXVSUp8mJV/fPHaqBvS0zEk3TEbh/OMHSMb1sjGwX
	 y3LAU4OSoqiqFHGV53VWVfH2aXok3sa02S5386xJbD6r3fVFwpb/B+lhg8Xy/aqCM7
	 VAAwG7dOtCLL5zPZ77SZn+b33iGhGwdbeEOpvtuunqVC4dSKgdRdSUUG4g0l7O+ghX
	 rwoiw4qeUVEnFMhCt3cFYJdG48Tf6RUcpBdXnbm1OE5b/Z7AJs8fh1ULpD+IjmDgYf
	 P65LbUtaCfTM7PVEqYCDGmjIKBLY6lt+QnHq62LY0st6eB8GXfhoqrl1frjElFpYUM
	 cFs9nyBwqQyVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add new negative tests for
 xattr related BPF kfuncs
Reply-To: sashiko@lists.linux.dev
To: "Matt Bobrowski" <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260503200819.1530328-2-mattbobrowski@google.com>
References: <20260503200819.1530328-2-mattbobrowski@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 20:58:35 +0000
Message-Id: <20260503205836.5E511C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The BPF program will be unconditionally rejected by the verifier=
 because a mutable `.bss` variable is passed to a kfunc argument requiring =
a constant string, causing the test to fail and leak a temporary file.
- [Low] Mismatch between BPF program variable names and the generated skele=
ton fields accessed in the test, which will cause a build failure.
--

commit fced0fe9408f12be9c0811a441c1071b5b9e4b39
Author: Matt Bobrowski <mattbobrowski@google.com>

selftests/bpf: add new negative tests for xattr related BPF kfuncs

Add a set of negative tests to verify the newly enforced constraints
applied to xattr related BPF kfuncs.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/t=
esting/selftests/bpf/prog_tests/fs_kfuncs.c
> --- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
> @@ -128,6 +128,11 @@ static void test_set_remove_xattr(void)
>  	if (!ASSERT_OK_PTR(skel, "test_set_remove_xattr__open_and_load"))
>  		return;
> =20
> +	/* Prepare the long name for negative test */
> +	memset(skel->bss->long_name, 'a', 256);
> +	memcpy(skel->bss->long_name, "security.bpf.", 13);
> +	skel->bss->long_name[256] =3D '\0';
> +

Can this leak the temporary testfile on the filesystem? If open_and_load
fails due to verifier issues with long_name, this returns directly instead
of taking the goto out path to reach remove(testfile) called later in the
function.

[ ... ]

> @@ -188,6 +193,14 @@ static void test_set_remove_xattr(void)
>  	ASSERT_TRUE(skel->bss->locked_remove_security_selinux_fail,
>  		    "locked_remove_security_selinux_fail");
> =20
> +	ASSERT_EQ(skel->bss->ret_name_empty, -ERANGE, "ret_code_name_empty");
> +	ASSERT_EQ(skel->bss->ret_name_too_long, -ERANGE,
> +		  "ret_code_name_too_long");
> +	ASSERT_EQ(skel->bss->ret_value_too_large, -E2BIG,
> +		  "ret_code_value_too_large");
> +	ASSERT_EQ(skel->bss->ret_invalid_flags, -EINVAL,
> +		  "ret_code_invalid_flags");
> +

Will this cause a build failure? The BPF program declares these variables
with a ret_code_ prefix (such as ret_code_name_empty), so the generated
skeleton structure will not contain fields like ret_name_empty.

> diff --git a/tools/testing/selftests/bpf/progs/test_set_remove_xattr.c b/=
tools/testing/selftests/bpf/progs/test_set_remove_xattr.c
> --- a/tools/testing/selftests/bpf/progs/test_set_remove_xattr.c
> +++ b/tools/testing/selftests/bpf/progs/test_set_remove_xattr.c
> @@ -17,6 +17,14 @@ static const char xattr_selinux[] =3D "security.selinu=
x";
>  char value_bar[] =3D "world";
>  char read_value[32];
> =20
> +const char xattr_negative[] =3D "security.bpf.negative";
> +int ret_code_name_empty;
> +int ret_code_name_too_long;
> +int ret_code_value_too_large;
> +int ret_code_invalid_flags;
> +char long_name[257];

Will the verifier reject this program? The kfunc bpf_get_dentry_xattr
expects a constant string for its name__str argument. Because long_name
is declared without the const qualifier, it is placed in the writable
.bss map rather than the read-only .rodata map.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503200819.1530=
328-1-mattbobrowski@google.com?part=3D2
