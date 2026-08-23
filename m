Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940511B4F0A
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 01:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787447932; cv=none; b=f9E6nnPkkj42d+3iShTlRfs/EkR9VXCq3r53DAaPZ1xpptMCZup/ahoxmYmNbkoVa1QdTfwtLQ4qBqdr72vr26UMkI+948Tol5qH1tDcYVbU+ys2uDHhiboEYZr+ZNPv6LBBMJrUXt+0iObSWHvhHHWKsDFC7rNAd0Ul1qOwFXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787447932; c=relaxed/simple;
	bh=2kpFwR6IhOLjDGujq8+NYzWexlOruedYCmvRPz0CfRI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eSYFdt4XJVzTvKmGc1a2cm9F2cQ2BMOKPFySw1AX0sFNBoL23ovuAMqFFKBJHow5Ssx4ogLE1rX5IuLVtvMPNB916HWRFVD3T7ObWBjjA5UKFdq3Tbr2i8bYQ2fjk2ufsxiRMs8gCyPSm+Tbk43HwUD9aKjMb11c9HvJpnHKZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3Eih9CY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3Eih9CY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0213D1F000E9;
	Sun, 23 Aug 2026 01:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787447931;
	bh=g2tXMXlf7Zeb8Z/wFmAASL5CXC5bymXvnjV7FKgOH2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b3Eih9CYj+c1qGOpbDeyuuF3IPNn12GGA04ROZywn7f6Y+dRcIx8O1uEn+xrCFlEa
	 u08o2bE7qc4+wMdOnCYQC8U9y+QCO4eOZyx5KMmtN8+QGGiSBqusDsG9+QUa9VU+hZ
	 1NKsNr8yoaUSNTJsRS6xvMCwxncFbmnwiu/ee5umIxi5aqjIoEEQRXeM5T+9hapbns
	 H7ahFQTzebGl7sfjDIamkYki3W8qS2su43Z0Fq5i/kbtiql/bEpaOUDaQ724iD6DA9
	 sRaUrv1Xy5Lpd/dLa+4WOCjmDw9WFBUpkoZbaANVgl8FbI/K4i+R4J7gid4JWu+2CF
	 x5vr7hmAdW5SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 3/9] selftests/bpf: factor the
 permissive-mode skip suffix into a helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykola Lysenko" <nickolay.lysenko@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260823010900.1730708-4-nickolay.lysenko@gmail.com>
References: <20260823010900.1730708-1-nickolay.lysenko@gmail.com>
 <20260823010900.1730708-4-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 01:18:50 +0000
Message-Id: <20260823011851.0213D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing space in the SKIP message for the LINK step causes merged t=
ext output.
--

--- Patch [3]: [PATCH bpf-next v6 3/9] selftests/bpf: factor the permissive=
-mode skip suffix into a helper ---
commit 0c0b26d03c8f590d99a07e3db037b9c093922751
Author: Mykola Lysenko <nickolay.lysenko@gmail.com>

selftests/bpf: factor the permissive-mode skip suffix into a helper

With BPF_STRICT_BUILD=3D0, eleven recipes append the same tail. This patch
factors the tail into skip_on_fail, parameterized by the SKIP tag, optional
extra files to remove, and an optional note. Every call site is intended to
keep its exact message and behavior.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 8d71345c2e86c..04eea6ebc75cd 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -48,6 +48,14 @@ SKIP_CRYPTO	?=3D
>  BPF_STRICT_BUILD ?=3D 1
>  PERMISSIVE :=3D $(filter 0,$(BPF_STRICT_BUILD))
> =20
> +# Permissive-mode recipe suffix: on failure, remove the target, emit a
> +# SKIP marker and report success so the rest of the build continues.
> +# $(1) - SKIP tag (BPF, TEST, BENCH, SKEL, LINK, ...)
> +# $(2) - optional extra files to remove alongside the target
> +# $(3) - optional note appended to the SKIP message
> +skip_on_fail =3D $(if $(PERMISSIVE),|| { $(RM) $@ $(2); \
> +	printf '  %-12s %s\n' 'SKIP-$(1)' '$(notdir $@)$(if $(3), $(3))' 1>&2; =
})

[Severity: Low]
Does this formatting behave exactly as intended when the note is appended?

Because GNU Make strips the leading space after the comma in the then-part
of the $(if) function, it appears that $(if $(3), $(3)) will strip the
leading space.

Would this result in appending the note directly to the target name without
any whitespace separation?

[ ... ]

> @@ -1018,8 +1008,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>  		 $(OUTPUT)/usdt_2.o \
>  		 #
>  	$(call msg,BINARY,,$@)
> -	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@ $(i=
f $(PERMISSIVE),|| \
> -		($(RM) $@; printf '  %-12s %s\n' 'SKIP-LINK' '$(notdir $@) (some bench=
marks may have been skipped)' 1>&2))
> +	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@ $(c=
all skip_on_fail,LINK,,(some benchmarks may have been skipped))

[Severity: Low]
When this build fails in permissive mode on the bench target, the
skip_on_fail macro is called with the note as the third argument.

With the space-stripping behavior above, won't this result in the SKIP
message being formatted incorrectly as:

bench(some benchmarks may have been skipped)

instead of the previous behavior:

bench (some benchmarks may have been skipped)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823010900.1730=
708-1-nickolay.lysenko@gmail.com?part=3D3
