Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DEC632
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 00:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785284309; cv=none; b=NY/rYQ7xhLjROe2eOstLLlSZ8tzQDI0MaMKT8u0qIZG4IQiAKDPd4ZpTGy/dAAXNtUyBkCYewwJNCotFXg9AcLxgBDpnBI0HyR2FkP6rLcRVzslCAE+HgPwdAWw3TE6kbr645HwWYnY8KhSm7gpbcY6mWedvZOHsyM8K4m+RCZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785284309; c=relaxed/simple;
	bh=bITADJx8Odb/BlbWBXnfjmukNUHVf++La2q07Xgia3g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fSnFMhtEykVHBAmibJXwqBff0gYTZkPa5rQ8QOCIIbRG6pyPhS40b7Ohs9t23MeCIw+4BP38LW4Vl4+HTFTDR0RwxCXa0aHn8JWk0yYySRC50oskbCcyds7C8vzwDEjWaNtUnEM3nIDvpn4zD2wPbj7YTTcZy6Lke48GyDujC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkQ71hkh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkQ71hkh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC341F000E9;
	Wed, 29 Jul 2026 00:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785284308;
	bh=dAeHYoVcHhDLN3jUQIsj5IMjUVP7U7VEZSHSIC0U6j8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LkQ71hkhoWFHM/gQbht50SFfuGl9ZxlfKzJ2CPzBGe8pv24IcDtCk/ma0zmd0MdNR
	 X7OWi1poBS0yJntcmXJremCn50UTtIIxwpr1u3GE2vtevDuV3uqxQgQcLhyTOVgfjw
	 WsQECB6jqbtGwHsBFRAA6Ogzds+oJ5SGtuQBCrHUkXhUkoXiBIVk6ew/6UX68/P3om
	 5+f0U+mZyzJ/g21M5agkcsTQjJ2nRM6cqfad+KgubMEYUajLlykXqaLvPPXgPl7Yq2
	 qD8ZSg7XwpRot6iTe+sp/xEzNvGZLbMjHHzS6gQyw9+S9SXucRcYZHbATa8AB0eee8
	 OemPQ27NwkiVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] selftests/bpf: Route libarena build artifacts to
 OUTPUT
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?= <ricardo@marliere.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260728-selftests-bpf_oot-v1-2-05feb15d94db@marliere.net>
References: <20260728-selftests-bpf_oot-v1-0-05feb15d94db@marliere.net>
 <20260728-selftests-bpf_oot-v1-2-05feb15d94db@marliere.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 00:18:27 +0000
Message-Id: <20260729001828.0FC341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `clean` rule in `selftests/bpf/Makefile` fails to pass the over=
ridden `OUTPUT` path to the `libarena` sub-make, causing out-of-tree builds=
 to leak libarena artifacts.
--

--- Patch [2]: [PATCH 2/3] selftests/bpf: Route libarena build artifacts to=
 OUTPUT ---
commit b4bd21c68fbd2a022ffbf1208ac0ac06aa993754
Author: Ricardo B. Marli=C3=A8re (SUSE) <ricardo@marliere.net>

selftests/bpf: Route libarena build artifacts to OUTPUT

This commit adds OUTPUT support to libarena's Makefile and propagates it
from the parent bpf Makefile. It ensures generated files like BPF objects
and skeleton headers are correctly written into the out-of-tree build
directory.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index b289183475d4c..7d42632f9d424 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
[ ... ]
> @@ -826,7 +826,8 @@ LIBARENA_MAKE_ARGS =3D \
>  		CLANG=3D"$(CLANG)" \
>  		BPF_CFLAGS=3D"$(BPF_CFLAGS) $(CLANG_CFLAGS)" \
>  		BPF_TARGET_ENDIAN=3D"$(BPF_TARGET_ENDIAN)" \
> -		Q=3D"$(Q)"
> +		Q=3D"$(Q)" \
> +		OUTPUT=3D"$(OUTPUT)/libarena"

[ ... ]

> diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testin=
g/selftests/bpf/libarena/Makefile
> index 5e2ab514805e4..195d5f833186a 100644
> --- a/tools/testing/selftests/bpf/libarena/Makefile
> +++ b/tools/testing/selftests/bpf/libarena/Makefile
[ ... ]
>  clean:
> -	$(Q)rm -f *.skel.h *.bpf.o *.linked*.o
> +	$(Q)rm -f $(OUTPUT)/*.skel.h $(OUTPUT)/*.bpf.o $(OUTPUT)/*.linked*.o

[Severity: Low]
Will this fail to clean the libarena artifacts when building out-of-tree?

In the parent bpf/Makefile, the clean target invokes make without the
LIBARENA_MAKE_ARGS override:

tools/testing/selftests/bpf/Makefile:
    clean:
        ...
        $(Q)$(MAKE) -C libarena clean

Since OUTPUT is inherited unmodified from the parent Makefile, it resolves
to the parent directory instead of $(OUTPUT)/libarena/.

Will this cause make clean to inadvertently run rm -f against the parent's
$(OUTPUT) directory, leaving the actual libarena artifacts behind?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-selftests-=
bpf_oot-v1-0-05feb15d94db@marliere.net?part=3D2
