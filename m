Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63DB3F0748
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659066; cv=none; b=ScRq4uUd8dcUM4rl2DfOCxBmcbdDg/wbxsT1EFT4QYjcjgEdGGmu+a/NG+I25X+HV/M4FZ/Y8lOWIOM0DxqUy8LG8cRH/akI5gQrbNRQ3o4N2mL3B8/Mdnlf0YvitifRJQBqE1BqRWngHfQ/ovRYESBkb2eDMwofqlG2xK36WNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659066; c=relaxed/simple;
	bh=SXaVzCkLIKz/udTgbAc1cGqZcfIAGpUoCkGIiOvUWJg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H5gNqLWCSeIzGhgixKkCuTsTtKZBHkRQCBkcaZRq7aqCABYAmXWMGZmPzPgJ1HYf2DtGBkoIgnbAiKhf1HfVzcrUXUddwRU/bsWkNV7nG39daVX2lNFFJf4v08Or5gXoFGcm2qS2bIBSEKLiIaFWd4rmATqeJz3T0n/0stJRxXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVabILRZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVabILRZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265E9C2BCB4;
	Fri,  1 May 2026 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777659064;
	bh=SXaVzCkLIKz/udTgbAc1cGqZcfIAGpUoCkGIiOvUWJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sVabILRZB1f42uYWDjOLcQhDlsjLjqj0J9m/wGSH8UwGS2M94uLvrF0eeEmt6ebUU
	 +UKDX2cwt5tgZT76IkrIXgRxxIEYGZMzCs73zxMV7KMHmIHZ3sGzVuHZyOHHvcssiO
	 n37371494PwzqBgIyrwAVqXbcD7sTLWAr5Sca9dkNc7RIVV1NSGsW5AM/55SEiRYX8
	 P/xbsYx4puS0zAzpHKeVu7lsfMF7wBVMz3SfLNBQYpKVuVG1+jOvbAPB/8G7BkLpEl
	 DxwurvNjCLYGkFgtgq1uOzlse50+1y90Ltxj6rvwqIZyfpFWexWPRQYU9L8B+mHjlm
	 N7N8dJH1u194w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpftool: Resolve libcrypto link flags via
 pkg-config
Reply-To: sashiko@lists.linux.dev
To: "hadrien Patte" <hadrien.patte@protonmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260501175829.9833-1-hadrien.patte@protonmail.com>
References: <20260501175829.9833-1-hadrien.patte@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 18:11:03 +0000
Message-Id: <20260501181104.265E9C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Hardcoding `pkg-config` directly executes the host's pkg-config en=
vironment, breaking cross-compilation.
- [High] The resolved `libcrypto` link flags (`CRYPTO_LIBS`) are improperly=
 shared between the target build (`bpftool`) and the host-compiled bootstra=
p build (`bpftool-bootstrap`), causing linker failures in cross-compilation.
- [Medium] Using `findstring` to detect the `-static` flag in `EXTRA_LDFLAG=
S` yields false positives due to substring matching.
--

commit aa775c0d6fcc0ef9be036e5edb76f38528db0dd3
Author: Hadrien Patte <hadrien.patte@protonmail.com>

bpftool: Resolve libcrypto link flags via pkg-config

This patch modifies the bpftool Makefile to resolve libcrypto linker flags
using pkg-config instead of hardcoding them. It also attempts to pass --sta=
tic
to pkg-config if a static build is requested via EXTRA_LDFLAGS.

> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -103,7 +103,17 @@ SKIP_LLVM ?=3D
>  SKIP_LIBBFD ?=3D
>  SKIP_CRYPTO ?=3D
>  ifneq ($(SKIP_CRYPTO),1)
> -  CRYPTO_LIBS :=3D -lcrypto
> +  # Resolve libcrypto link flags via pkg-config so transitive dependenci=
es
> +  # (e.g. libjitterentropy on distros where libcrypto.a references it) a=
re
> +  # included for static builds. Pass --static when the user requested a
> +  # static build via EXTRA_LDFLAGS=3D-static. Fall back to -lcrypto if
> +  # pkg-config or libcrypto.pc is unavailable.
> +  ifneq ($(findstring -static,$(EXTRA_LDFLAGS)),)

Does this findstring check cause a regression by matching other flags?

If a user passes flags like -static-pie, -static-libasan, or a custom
directory path like -L/opt/static-libs/, this condition would still evaluate
to true and pass the --static flag to pkg-config for what might be a
dynamically linked build.

Could we use the filter function instead to match the exact word, similar to
other BPF makefiles?

> +    CRYPTO_LIBS :=3D $(shell pkg-config --libs --static libcrypto 2>/dev=
/null)
> +  else
> +    CRYPTO_LIBS :=3D $(shell pkg-config --libs libcrypto 2>/dev/null)

Will hardcoding pkg-config directly break cross-compilation environments?

When cross-compiling, invoking pkg-config directly queries the host system's
library paths and might inject host-specific linker flags into the
cross-compiler's link line, leading to architecture mismatches.

Should a target-aware variable like $(PKG_CONFIG) be used here instead?

> +  endif
> +  CRYPTO_LIBS :=3D $(if $(CRYPTO_LIBS),$(CRYPTO_LIBS),-lcrypto)

Is it safe to share these resolved link flags between the target build and
the host-compiled bootstrap build?

Because CRYPTO_LIBS is appended to both LIBS and LIBS_BOOTSTRAP later in
the Makefile, a cross-compilation setup might fail. It passes the exact
same architecture-specific pkg-config output to both the host and target
compilers.

Would it be better to resolve dependencies separately using $(HOSTPKG_CONFI=
G)
for the bootstrap tool and $(PKG_CONFIG) for the main tool?

>  endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501175829.9833=
-1-hadrien.patte@protonmail.com?part=3D1
