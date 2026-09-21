Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DF643801F
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789978193; cv=none; b=U27ApdUk79areBmx8QT4wNVOyxKrws44p+erjHL/8VFHh3Y4w+422wfs00aj2W7Krmju1FS6R8dhJCP64GO6mIGtqropaFjOiSAZAtxYgm9K9zFTHPDv0jhbNBLpKW1a1f5/fDKuQXOY3Zn5YavVsBC3roH6S/0/qYaa4l7ipmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789978193; c=relaxed/simple;
	bh=Hoh5fxQR+hcbyi92wxgXghlXwHdKnRO45YFwhOKZPs0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sEgqnFnCMT5JPsoQcs5KeC0uyaSOsTrwiEaTHf9SfgqTvGbd1xoD37YrKtqnaUz5HmX1+9iP1ntIRW4dSpLzY7JMb1pcm605yyLtoLHHwtGT0ErVAgBxpk55WNbWketZI9tVWlSs1MGvm8/69Lx5zwm0HvnsOoCbgqKhzKaBv4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZHYlCSz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZHYlCSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4FF1F000FF;
	Mon, 21 Sep 2026 08:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789978192;
	bh=MElyN4dyu9ZvjML0HNMFNOJ709QH4r1rFptK+H9gGUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mZHYlCSzuZAAWTMJ0ff0ZuGELJ8iRMsCna/0EQFedNZN+2U9ZhdXJO3pZS8e3DR2Z
	 ICtgsiL88YZQhBsy1smMNRFuNGASrmGk4U9Ijq0ruwJ1QXR0VPjOsZ3PZWvDhsoMyi
	 PfTYse+56VN1Wk/ZhSZxCDOqmWpXvdx1x/nOKbGtDOB+xqT763EVsEIvNaAKEtayG1
	 JDN2b0PiKDxxpsIyQMidsiTnwmC3bPL4ehQs7QYCNZBh/jhtm/cOieK79ubvOkE6ZU
	 IGAZrBJnHYFVt7Mj2IaPbPNqCexBGTOFA84Mw4n2aA3QqsRmKuexEXLhrrtlL3pe6x
	 3Z5vvFQzocBVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 3/9] selftests/bpf: factor the
 permissive-mode skip suffix into a helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykola Lysenko" <nickolay.lysenko@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921075855.2065871-4-nickolay.lysenko@gmail.com>
References: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>
 <20260921075855.2065871-4-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 08:09:51 +0000
Message-Id: <20260921080951.EB4FF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] build: missing space in skip_on_fail formatting
--

commit a3e18474fd48a50d84abcafc18805d61a8736ce1
Author: Mykola Lysenko <nickolay.lysenko@gmail.com>

selftests/bpf: factor the permissive-mode skip suffix into a helper

With BPF_STRICT_BUILD=3D0, eleven recipes append the same "|| { remove the
target, print a SKIP marker, report success }" tail, each spelled out
inline. Factor the tail into skip_on_fail; every call site keeps its
exact message and behavior.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 3606ee8ab7949..11bd8997aea5d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -46,6 +46,14 @@ SKIP_CRYPTO	?=3D
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
Does this formatting result in a missing space between the target name and =
the
note?

GNU Make strips unescaped leading whitespace following commas in function
arguments, so the space in `$(if $(3), $(3))` is discarded during expansion.

[ ... ]

> @@ -1014,8 +1004,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
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
Because the space is stripped, the invocation above doesn't provide a leadi=
ng
space either. Will this log output as `bench(some benchmarks may have been
skipped)` instead of `bench (some benchmarks may have been skipped)`?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921075855.2065=
871-1-nickolay.lysenko@gmail.com?part=3D3
