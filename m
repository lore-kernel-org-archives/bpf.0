Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74294332ED6
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514693; cv=none; b=HsI+94Xy4JaPC79nIbf7x9AGSoTttS2ki6z+lLsnL++rcNEJG+6MZNMxQsItPKo8+OSADfRxsEpPuBlMIYjOTu2g9D5TJvlFXA5jiST99/ZomrC9u7+bPlOQFaRvYkMWPTyWT6X3Le2jYsBU9IYoUMqrBl4uZ4w3rfhWvgaiObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514693; c=relaxed/simple;
	bh=Vbu5PACT4T7O3OmyyBHY/rjzeb/PVkHfYZlD/NFzqSA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lHGyolT2MrTm73sCEwv7WVOjimnTUshkJYPzrcOvOwUQ9JqvXQsBuRUv68yF9/dBUkbHMWWMwxY52Farw1kiCQIlXh6nhC3fmSc/pEL5q2/+vaafNIgN9BEJ9wL7288J0m0pFuPm/2RkM6mzPJrvtiY7+8BeYKwOisKfbhIWIpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFR/3RQ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFR/3RQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF801F000E9;
	Sun, 23 Aug 2026 19:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787514689;
	bh=f3E6TZjBnDgHchxF+AQvjh7IWgr7d8tq1NLD6ar4ESs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oFR/3RQ4RHfisRvOJkv7d/tS+9+Hsb/SBIEiKbwt7DgsZoLp2YSERneHxH2O4+yiH
	 rivqy9f0/Cion/s+VEp9+IPRg+ejhnpU3vMrXTL6GoBjAwZvCjMHfljfYt/ROExlU/
	 PZKhuvFdIaBWTFzRzSGiGngzgYiiJt1/QhRSwFfF5jO4v0pGjpBLtR3eGf/EuPiOuY
	 oUsibAgYHSolu0XszxxArM5b17iHXcZEwNG+RF1cd1IDFSk6aDX8zC+te4ZK4xHoEN
	 f3nhDPY3KM3M2R4jVZFDNs0LsQsk8FpWbKk6QSgARLOujEIeAt67+3fRIv1xkDJWA/
	 zeiWmJIhHlHBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 3/9] selftests/bpf: factor the
 permissive-mode skip suffix into a helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykola Lysenko" <nickolay.lysenko@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260823194241.3415152-4-nickolay.lysenko@gmail.com>
References: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
 <20260823194241.3415152-4-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 19:51:28 +0000
Message-Id: <20260823195129.2FF801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing space in "SKIP-LINK" message for skipped benchmarks.
--

--- Patch [3]: [PATCH bpf-next v7 3/9] selftests/bpf: factor the permissive=
-mode skip suffix into a helper ---
commit 390f83151721ccaeb21976f48c2d352d76658f37
Author: Mykola Lysenko <nickolay.lysenko@gmail.com>

selftests/bpf: factor the permissive-mode skip suffix into a helper

This commit factors out the duplicated permissive-mode skip suffix across
multiple Makefile recipes into a single skip_on_fail helper macro. This
reduces duplication while maintaining the original behavior and messages.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index c7c7f27dd8605..e4c8efd1e6f1b 100644
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

[ ... ]

> @@ -1016,8 +1006,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
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
This isn't a bug, but does the resulting string lack a space between the
target name and the note?

GNU Make ignores whitespace following a comma in function arguments. Because
of this, $(if $(3), $(3)) in the skip_on_fail macro will evaluate without
a leading space, even if one is provided in the invocation or in the string
itself.

Could this cause the printed message to become "bench(some benchmarks may
have been skipped)" instead of the original "bench (some benchmarks may have
been skipped)"?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823194241.3415=
152-1-nickolay.lysenko@gmail.com?part=3D3
