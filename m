Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB04936D9F1
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777676339; cv=none; b=bUYdEfxZwVeeVK/Q7VwFgwPibLjZSIf+Ibc/nOrYqFA1rdLASsbRq3z6stO2QCdJI/iIE5t21SL1EcN/6bM8CQwboDLBbyCEBIiQD6tzsb6go1r+++pEOUUIc88yzsCSEUI7woxUIVVwS48k9vNhqfaOIwZzjX5Fw7LrD0gGmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777676339; c=relaxed/simple;
	bh=tgbZPhgs0iPo+W1s/admFw7dAGRaES87UWT+k02+9NI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BC6RuuRcTh3YDbkfeXnxDq5ppEwsoEaVMjfpLd/VEjflkGiz5qPRsUa5h03qgrFr3IZbE92zQql3hNqJRrpKSjklirCOEXafkzPAlx/1Mennak0m2bvwLPDP6qq8bt+gP2NlmYTs7RYmp0Ay+IV4C5UYEkGQhdtPpNU2t2MC+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrLXOWi+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrLXOWi+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39932C2BCB4;
	Fri,  1 May 2026 22:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777676339;
	bh=tgbZPhgs0iPo+W1s/admFw7dAGRaES87UWT+k02+9NI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MrLXOWi+Ig36GoC+2sjRRpwpPm6g8yLaSOFNc1dLfz5py0f24cdd4keEy/yUGwrf3
	 sPonwZTgZMmvKJiih8Oqq4SDm44TtuoueW2e+9AT5Dlo/DwYVfX4TNGjOxgQM4yR0L
	 oj5qEz/8x+SOeWbpO5yamN9ck1+gWgPfiCYNSmzVrGyGtOBxrd3g8ahckFfF7PHP0k
	 MGEdqVNe2YO0vlanwwEkNjLF8LqJbd1tKFpHIZSOBJSWMZuwgURGA/+2nLVN08PHwW
	 xQXGm7/ZNzA62O6yEVdUf9Sz7SfuhABfpscaIQHGerxY1Dn68RM+BhAyDoy9cZzG0u
	 NgxU8Jd2KUrnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] bpftool: Resolve libcrypto link flags via
 pkg-config
Reply-To: sashiko@lists.linux.dev
To: "hadrien Patte" <hadrien.patte@protonmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260501224346.12765-1-hadrien.patte@protonmail.com>
References: <20260501224346.12765-1-hadrien.patte@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 22:58:58 +0000
Message-Id: <20260501225859.39932C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The logic to conditionally pass `--static` to `pkg-config` only che=
cks `EXTRA_LDFLAGS`, missing static builds requested via `LDFLAGS`.
--

commit c4bd62b29823641ce51fa6b07b88d88891141b01
Author: Hadrien Patte <hadrien.patte@protonmail.com>

bpftool: Resolve libcrypto link flags via pkg-config

This commit resolves libcrypto link flags for bpftool via pkg-config to cor=
rectly
pull in transitive dependencies like libjitterentropy for static builds. It=
 also
adds a fallback to plain -lcrypto if pkg-config is not available.

> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
[ ... ]
> @@ -103,7 +103,35 @@ SKIP_LLVM ?=3D
>  SKIP_LIBBFD ?=3D
>  SKIP_CRYPTO ?=3D
>  ifneq ($(SKIP_CRYPTO),1)
> -  CRYPTO_LIBS :=3D -lcrypto
> +  PKG_CONFIG ?=3D $(CROSS_COMPILE)pkg-config
> +  HOSTPKG_CONFIG ?=3D pkg-config
[ ... ]
> +  # Resolve libcrypto link flags via pkg-config when available, so trans=
itive
> +  # dependencies (e.g. libjitterentropy on distros where libcrypto.a
> +  # references it) are included for static builds. Pass --static when the
> +  # user requested a static build via EXTRA_LDFLAGS=3D-static.
> +  ifneq ($(filter -static,$(EXTRA_LDFLAGS)),)

If a user requests a static build using LDFLAGS=3D-static instead of
EXTRA_LDFLAGS=3D-static, will this check miss it?

The Makefile natively supports passing flags directly via standard LDFLAGS
and aggregates them. By only checking EXTRA_LDFLAGS here, pkg-config might
omit the --static flag when LDFLAGS is used directly. This could drop
transitive dependencies and cause the build to fail with undefined
references.

Would it be better to check LDFLAGS as well?

> +    PKG_CONFIG_LIBCRYPTO :=3D --libs --static libcrypto
> +  else
> +    PKG_CONFIG_LIBCRYPTO :=3D --libs libcrypto
> +  endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501224346.1276=
5-1-hadrien.patte@protonmail.com?part=3D1
