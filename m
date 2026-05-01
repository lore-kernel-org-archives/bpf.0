Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8229429B764;
	Fri,  1 May 2026 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777660655; cv=none; b=UURCox3xZ9ISqxr1eSUfsfazHoapwA3UlEvviMflaxkdvVNMdGxqIbN8FhdO5WsEvJ/hE6CYPiIu0q74sD5AE5FSP2ZwWc43EkzTN0T1q7yVPZ0X61KrLh0zTUrRjLO1FmkAvJza2dHZTbTakbU1HtCu4IvtBpmUVzOrICuSN3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777660655; c=relaxed/simple;
	bh=yI00MkhF9bomGhcCylF5Q3Pm+aWUHu/ocfHHTUCEpjU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EqGLkJrR6hM2RR+m2QAWWC7S8wPHECTjqaMHOSPx33xWemReupqVXO63HDuTJy+UHmcq7hg4uO9/hwtL151C1pl+WSMT0vMmx2D7D4Ql0ts4x8ZI9ThHPWTFh99whi2+wG+ry1HtksNKijQuo6jiXVCtsntXz9bSlBJnYL78ZOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ew5u1Zql; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ew5u1Zql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6B1C2BCB4;
	Fri,  1 May 2026 18:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777660655;
	bh=yI00MkhF9bomGhcCylF5Q3Pm+aWUHu/ocfHHTUCEpjU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Ew5u1ZqlZ7MxzHc7fl6tbBjovPA5YwXDH3l9RRe1SKoWpCJhIihPQK+G900Vi5cjL
	 3oDPkDvDap1gj1+zxHMcaYq9GmCROwSQSeAiD4qIMssvVoSI2lZJ77vN4YTxvhBEeq
	 6qNqeGEauPama8CAHfc7hdvGj8lBvaHpZg7HUEddvL6WQQsg6pFYU/SYZFbGvHA5Vl
	 yPsQOeOIn03QfujxYCB+GJxOHDCRmFrg/xvbBfW/g/xG2PhqbPjJEGfVovj6DmtGpA
	 YvX23RNEq1QxKLbEZUwRRNCY9Mm8G54cKXEv3nmltbHW/HCY056HiVx1VqKa1mKd7N
	 zn7Lrz5BbBP2A==
Content-Type: multipart/mixed; boundary="===============8112821106864314574=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <808e8f59081bf5e3a5c4e94806e2f07fcb823d1ee67c028aa93a2de6170fe419@mail.kernel.org>
In-Reply-To: <20260501175829.9833-1-hadrien.patte@protonmail.com>
References: <20260501175829.9833-1-hadrien.patte@protonmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Resolve libcrypto link flags via pkg-config
From: bot+bpf-ci@kernel.org
To: hadrien.patte@protonmail.com,bpf@vger.kernel.org
Cc: qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,linux-kernel@vger.kernel.org,hadrien.patte@protonmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  1 May 2026 18:37:33 +0000 (UTC)

--===============8112821106864314574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 0febf60e1b64..d9ab860a6cce 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -103,7 +103,17 @@ SKIP_LLVM ?=
>  SKIP_LIBBFD ?=
>  SKIP_CRYPTO ?=
>  ifneq ($(SKIP_CRYPTO),1)
> -  CRYPTO_LIBS := -lcrypto
> +  # Resolve libcrypto link flags via pkg-config so transitive dependencies
> +  # (e.g. libjitterentropy on distros where libcrypto.a references it) are
> +  # included for static builds. Pass --static when the user requested a
> +  # static build via EXTRA_LDFLAGS=-static. Fall back to -lcrypto if
> +  # pkg-config or libcrypto.pc is unavailable.
> +  ifneq ($(findstring -static,$(EXTRA_LDFLAGS)),)

Will this findstring check match other flags unintentionally? If a user
passes flags like -static-pie, -static-libasan, or a custom directory path
like -L/opt/static-libs/, this condition would still evaluate to true and
pass the --static flag to pkg-config for what might be a dynamically linked
build.

Could the filter function be used instead to match the exact word, similar to
other BPF makefiles?

> +    CRYPTO_LIBS := $(shell pkg-config --libs --static libcrypto 2>/dev/null)

Will hardcoding pkg-config directly break cross-compilation environments?
When cross-compiling, invoking pkg-config directly queries the host system's
library paths and might inject host-specific linker flags into the
cross-compiler's link line, leading to architecture mismatches.

Should a target-aware variable like $(PKG_CONFIG) be used here instead?

> +  else
> +    CRYPTO_LIBS := $(shell pkg-config --libs libcrypto 2>/dev/null)
> +  endif
> +  CRYPTO_LIBS := $(if $(CRYPTO_LIBS),$(CRYPTO_LIBS),-lcrypto)
>  endif

Is it safe to share these resolved link flags between the target build and
the host-compiled bootstrap build? Because CRYPTO_LIBS is appended to both
LIBS and LIBS_BOOTSTRAP later in the Makefile, a cross-compilation setup
might fail. It passes the exact same architecture-specific pkg-config output
to both the host and target compilers.

Would it be better to resolve dependencies separately using $(HOSTPKG_CONFIG)
for the bootstrap tool and $(PKG_CONFIG) for the main tool?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25226582670
--===============8112821106864314574==--
