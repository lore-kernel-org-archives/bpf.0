Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D862E06D2
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786664258; cv=none; b=rXGZAShYHeSYVXItR8gKJIBIuzld5VDKjgbTgTLgh4MdvfNS5SX+xkTLduSsRaZ7rUIR+KKAdlDdh5+bvvSdpcy9bZ9RYrXa9Gbv/iXkngIhd538WNolPv4SM1UKmB2M0XCbVMlyy93gswHGVBlHapJXCc9LFqKK1kG6BPmyBLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786664258; c=relaxed/simple;
	bh=HI8/MpqWtM5fjqoPw9OH72qocZ/jAmOYsZHWvRUM39c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XeemRtjlp8qtk8MDxlR6tCh6d/zPrb8nzONTIds1aOhkpRfKwAFHBUbwuSUU8BVkKlAqeqkpivkPpuMD5XX0rLdm7/xs4+Pz0LXb3PE5B8bnMAQGP9UD3+hCBBjieHGA1vKW27ULRwUO6Tf67YLyjvrKEBWgQVnISio5R5dtSAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPNrwOEU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPNrwOEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61E31F000E9;
	Thu, 13 Aug 2026 23:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786664257;
	bh=eVE9NfoKzRcQaHUW4X4wrQy+m2g/ivh17jiCeEP/iLI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lPNrwOEUWze0hUfpzVEyBmH4aW7fsZhs05Ukb0oR6K7XBj/klcAYz/jY4GUo+5CUl
	 08rBXf1pDyPVgkQsiB8PsTsOndirbQiUY/5FgnWt9TORiW5vqmXxfCKj2lb1w1AaL1
	 NC811qPxFcI5ba32SBAHe44u7+GVqZJQONQeDFy2AavZjozKpGXa2GdSwnh47+ZA55
	 1i82JuoTPZX6GRWtZN0/ytEYsxSp7zr6NqnYBbMHco+10+ltLisTj5oBqugNxYCeg0
	 w4HMAzcyDbgRnBC7BZBNiyV93q4qld6mMVSFUOl2kBO9mtBaqzAoVLgimPNn68O0Ka
	 4D/UrI+UIoIXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/10] selftests/bpf: Tolerate test file compilation
 failures
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260406-selftests-bpf_misconfig-v4-5-9914f50efdf7@suse.com>
References: <20260406-selftests-bpf_misconfig-v4-5-9914f50efdf7@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:37:32 +0000
Message-Id: <20260813233736.E61E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Masking test compilation failures breaks the linking step and abor=
ts the test runner, completely breaking the test suite.
--

--- Patch [5]: [PATCH v4 05/10] selftests/bpf: Tolerate test file compilati=
on failures ---
commit fa90c61b664da4eb761a6d8759626a636f99483a
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Tolerate test file compilation failures

This commit modifies the BPF selftests Makefile to make individual test
compilation non-fatal. It removes the output object on failure, prints a
SKIP-TEST marker, and skips BTFIDS post-processing for absent objects.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 72f576a8236a1..e67f9c4cb5d70 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -688,11 +688,14 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:		=
	\
>  		      $(TRUNNER_TESTS_DIR)/%.c				\
>  		      | $(TRUNNER_OUTPUT)/%.test.d
>  	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
> -	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$=
(LDLIBS) -o $$(@F)
> +	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$=
(LDLIBS) -o $$(@F) || \
> +		($(RM) $$(@F); printf '  %-12s %s\n' 'SKIP-TEST' '$$(notdir $$@)' 1>&2)

[Severity: High]
Will masking the compilation failure here break the subsequent linking step
and the test runner?

Because Make evaluates $$^ in the linker command line, it expands to all
defined .test.o prerequisites, including the missing ones. The missing
.test.o file is then passed to the compiler during linking, which fails wit=
h a
'No such file or directory' error and halts the build.

Furthermore, even if the linker step is bypassed by filtering out missing
files, the test runner itself aborts execution entirely if a test function
is NULL:

tools/testing/selftests/bpf/test_progs.c:main() {
    ...
    if ((test->run_test =3D=3D NULL && test->run_serial_test =3D=3D NULL) ||
        (test->run_test !=3D NULL && test->run_serial_test !=3D NULL)) {
        fprintf(stderr, "Test %d:%s must have either test_%s() or "
                "serial_test_%sl() defined.\n", test->test_num,
                test->test_name, test->test_name, test->test_name);
        exit(EXIT_ERR_SETUP_INFRA);
    }
    ...
}

When test_progs initializes, it enumerates all tests by scanning .c files.
The missing .test.o file causes its weak function symbol to resolve to NULL,
aborting the entire test suite on startup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260406-selftests-=
bpf_misconfig-v4-0-9914f50efdf7@suse.com?part=3D5
