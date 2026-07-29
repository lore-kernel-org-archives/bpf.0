Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD2017D6
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785284182; cv=none; b=X6YDVXEz4OV1CpsxCDZNtZ938jp73th+xCeknG9DlWYH9Oh6XGAzUcf20PHqvYThmGxeA/IrNRxIkwE3Vt8Xrn9Cfm8CGPdCzo+m9qlyrGJmKuHNJezn5uCTMySrOFeueTVrau9AeM/rJcFIsPMxEdT0IJUvtMQ58/oU2ZGqBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785284182; c=relaxed/simple;
	bh=iqmnq2WLnl/8Dkt4x9E42H8YqAebj339W7kILU9LhsM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UQE7spIqXP9+aCyJl/e0ZO6McPEfhyhbfRCAUTygCdXjyHEImW8pugcYotTltTxF6gLVaqs9xVqgtMXSfa9obwJD7KBZPaCladFT5tzeKwCVRrrz13AcPDRR4/xIx6/J/nFMsNDzEBXMmKSAAPDmfdjyn7jlTrWex04gikSuLic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkRHplKP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkRHplKP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FA31F000E9;
	Wed, 29 Jul 2026 00:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785284181;
	bh=tn/yVPBDPIf6BPaPzLaz9jA8XZn2sYsrhIETZmod7Gs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SkRHplKPxG2M1FWDYfVQd8IJqXD3Pu34Rrh9WgNQsUIJ4tvPItBPec5Q6ekg63WIE
	 /+rhbRpIXUuJWor3tiX6QVhxCdhgsIR77XuHp2Dd9rh+Q5tc/fJ/IRd9/wV5LLwqHG
	 B2VJDQKmOZ4vID6xdL+UqGv7T8k6bJjp1DG/L48i1QZ0Qit32ainong8mS/pGOXaOM
	 enmL1I1eCAiNmQM8uPF80PycePIN4MJETtpPsIP7uW/VC35rMvrRpx2UJErGYhDvXy
	 fXrXu0s6CEd1KSDtJm673tEuzpPkO4fOktCitbeX8UP0yAJIPg54cTGtH44qTGbxTz
	 WABE12zKiprUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] selftests/bpf: Route generated test headers to
 OUTPUT
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?= <ricardo@marliere.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260728-selftests-bpf_oot-v1-1-05feb15d94db@marliere.net>
References: <20260728-selftests-bpf_oot-v1-0-05feb15d94db@marliere.net>
 <20260728-selftests-bpf_oot-v1-1-05feb15d94db@marliere.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 00:16:20 +0000
Message-Id: <20260729001621.34FA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unescaped path injection in `sed` with the `@` delimiter can cau=
se verifier tests to be silently skipped if the build path contains an `@` =
character.
- [Low] Generated test headers moved to $(OUTPUT) are not cleaned during ou=
t-of-tree builds because EXTRA_CLEAN is not updated.
--

--- Patch [1]: [PATCH 1/3] selftests/bpf: Route generated test headers to O=
UTPUT ---
commit 63d1e1deab06130ae6d45a6e98fd6e8bf85c23ef
Author: Ricardo B. Marli=C3=A8re (SUSE) <ricardo@marliere.net>

selftests/bpf: Route generated test headers to OUTPUT

This commit updates the Makefile to write generated test-runner enumeration
headers, verifier test lists, and signing certificate headers to $(OUTPUT)
instead of the source tree during out-of-tree builds. It modifies the
target prerequisites to ensure the output subdirectories are created before
generating these headers.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index b642ee489ea64..b289183475d4c 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -923,14 +923,14 @@ $(eval $(call DEFINE_TEST_RUNNER,test_maps))
>  # It is much simpler than test_maps/test_progs and sufficiently differen=
t from
>  # them (e.g., test.h is using completely pattern), that it's worth just
>  # explicitly defining all the rules explicitly.
> -verifier/tests.h: verifier/*.c
> -	$(shell ( cd verifier/; \
> +$(OUTPUT)/verifier/tests.h: verifier/*.c | $(OUTPUT)
> +	$(shell mkdir -p $(OUTPUT)/verifier && ( \
>  		  echo '/* Generated header, do not edit */'; \
>  		  echo '#ifdef FILL_ARRAY'; \
> -		  ls *.c 2> /dev/null | sed -e 's@\(.*\)@#include \"\1\"@'; \
> +		  ls verifier/*.c 2> /dev/null | sed -e 's@\(.*\)@#include "$(CURDIR)/=
\1"@'; \

[Severity: Medium]
Does this change introduce a regression if the build path $(CURDIR) contains
an @ character?

If the user's working directory contains an @ symbol (such as in Jenkins
workspaces like @tmp), sed fails with a syntax error because @ is used
as the replacement delimiter.

Since the failure occurs within a subshell (...) > $(OUTPUT)/verifier/tests=
.h,
Make ignores the failure and writes an empty test array to the header.

Will this cause the verifier test suite to compile successfully but run zero
tests?

>  		  echo '#endif' \
> -		) > verifier/tests.h)
> -$(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(=
OUTPUT)
> +		) > $(OUTPUT)/verifier/tests.h)
> +$(OUTPUT)/test_verifier: test_verifier.c $(OUTPUT)/verifier/tests.h $(BP=
FOBJ) | $(OUTPUT)
>  	$(call msg,BINARY,,$@)
>  	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@

[Severity: Low]
With the generated test headers moving to $(OUTPUT), will they be left behi=
nd
during a clean build?

Looking at EXTRA_CLEAN further down in tools/testing/selftests/bpf/Makefile:

EXTRA_CLEAN :=3D $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
	...

Since EXTRA_CLEAN still hardcodes the old relative paths, does this mean
`make clean O=3Dout` will miss the newly relocated headers in the output
directory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-selftests-=
bpf_oot-v1-0-05feb15d94db@marliere.net?part=3D1
