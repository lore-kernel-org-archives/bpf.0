Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A22116F4
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777235297; cv=none; b=Md84vsxzbqgX3LQi02FKyAsF2D7pG3yamVuQCJhkYYcQigam8d9xXI8Jh0yNBSDhoR8OKSSFD9lUc4BzUOhZW1eMtczGgWqMZXlex8JrxEp60cUVadmnkQVIbM5Ygl0TeyWcFv2gPPsHTDvb40lysuaLq2fLcEirGkzuVFrALFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777235297; c=relaxed/simple;
	bh=Pa5UmOo1T7ESfF8s202MPkZ84ZY/cEMcCYaSxsJxxu4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LDX7Q1qgrkvRSfeplf0ouBe8UYcYzkgpLDg5A/u3KREELnPKPMSdvTjgKyytO6z6N4ATGIdj5G3uDuZTbY8slJvVLz6Hrwf0EY1PIa/Rx2Z73/JV5dzE3RHiFknlhPTv+Y4ajXaKdXTDdhMil8/MVP7k4eqljd0PSiL27Bsx7Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JF5fCeb6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JF5fCeb6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38FAC2BCB6;
	Sun, 26 Apr 2026 20:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777235297;
	bh=Pa5UmOo1T7ESfF8s202MPkZ84ZY/cEMcCYaSxsJxxu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JF5fCeb6UAuo5QKsTbBDeFUbAQMbHiGcVF1yqHdnJ0yYlYhtY9yr1vxBvMc7gip9u
	 NAMOssyWSBo4qBMVFWv6W4X0qYgs5hHlcLQVsYxlAgi+MXabbhpAc2snDeJzTn21+j
	 r4X+9dLaKRAunMQkAVIRN+0757Ch7S1a2nvFuhXfffJUUAPAQn/BnpihcjC9ZUdcHN
	 DqrNQEzSvC3g4iToyC/KtuCyt0ggWpi0Q4kEoUnrgLtemkkn53cIdQVvTS1bUnadDb
	 G6VeTPCnk4cdN/OgOGulT25aEZsb/BjFH6emy+m53uJKboWIeq03CnuFUfg3TEO7Zl
	 pdx+riN72n/7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 5/8] selftests/bpf: Add ASAN support for
 libarena selftests
Reply-To: sashiko@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260426190338.4615-6-emil@etsalapatis.com>
References: <20260426190338.4615-6-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Apr 2026 20:28:16 +0000
Message-Id: <20260426202816.F38FAC2BCB6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Medium] Logic error in `asan_validate_addr` fails to validate the ASAN v=
iolation address.
- [Medium] `print_asan_map_state` missing `__noasan` attribute triggers sec=
ondary ASAN violations.
- [Low] Missing header includes in `userspace.h` and `st_asan_common.h` cau=
se compilation errors.
- [Low] Standalone builds in the `libarena/` directory fail unconditionally=
 on older Clang versions.
--

commit 7f45bd9cc6e3fb019a16a17f2e11b1f1ab5702ad
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Add ASAN support for libarena selftests

Expand the arena library selftest infrastructure to support
address sanitization. Add the compiler flags necessary to
compile the library under ASAN when supported.

> diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testin=
g/selftests/bpf/libarena/Makefile
> index e85b3ad96890..5e2ab514805e 100644
> --- a/tools/testing/selftests/bpf/libarena/Makefile
> +++ b/tools/testing/selftests/bpf/libarena/Makefile
[ ... ]
> @@ -53,17 +61,32 @@ CFLAGS +=3D $(INCLUDES)
>  vpath %.bpf.c $(LIBARENA)/src $(LIBARENA)/selftests
>  vpath %.c $(LIBARENA)/src $(LIBARENA)/selftests
> =20
> +skeletons: libarena.skel.h libarena_asan.skel.h
> +.PHONY: skeletons

Will this unconditionally build libarena_asan.skel.h when running make
directly in the libarena/ directory? The parent BPF Makefile guards ASAN
compilation with CLANG_HAS_ARENA_ASAN, but that guard is missing here. Could
this cause the build to fail on older Clang versions?

[ ... ]
> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/usersp=
ace.h b/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h
> index 0438a751d5fd..88b68ac73cca 100644
> --- a/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h
[ ... ]
> @@ -97,3 +102,31 @@ static inline int libarena_get_globals_pages(int aren=
a_get_globals_fd,
>  	free(vec);
>  	return 0;
>  }
> +
> +static inline int libarena_asan_init(int arena_asan_init_fd,
> +				     int asan_init_fd,
> +				     size_t arena_all_pages)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct asan_init_args args;

This isn't a bug, but struct asan_init_args is instantiated here without
including <libarena/asan.h>. Could this cause compilation errors if the
header is included independently?

[ ... ]
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_commo=
n.h b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
> new file mode 100644
> index 000000000000..1d3edc4372ac
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#pragma once
> +

Similar to the above, this header uses macros and variables like
asan_violated, ASAN_GRANULE, and arena_stdout but does not include
<libarena/common.h> or <libarena/asan.h>.

> +#define ST_PAGES 64
> +
> +static inline void print_asan_map_state(void __arena *addr)
> +{
> +	arena_stdout("%s:%d ASAN %p -> (val: %x gran: %x set: [%s])",
> +			__func__, __LINE__, addr,
> +			*(s8a *)(addr), ASAN_GRANULE(addr),
> +			asan_shadow_set(addr) ? "yes" : "no");
> +}

Since addr is an address that triggered an ASAN violation, does this need
the __noasan attribute? Otherwise, the memory read *(s8a *)(addr) will trig=
ger
another ASAN violation.

> +
> +/*
> + * Emit an error and force the current function to exit if the ASAN
> + * violation state is unexpected. Reset the violation state after.
> + */
> +static inline int asan_validate_addr(bool cond, void __arena *addr)
> +{
> +	if ((asan_violated !=3D 0) =3D=3D cond) {

If a violation is expected when cond is true, does this code also need to
check if asan_violated =3D=3D (u64)addr? It looks like it only verifies that
any violation occurred, which could allow tests to erroneously pass if a
completely unrelated ASAN violation happens.

> +		asan_violated =3D 0;
> +		return 0;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260426190338.4615=
-1-emil@etsalapatis.com?part=3D5
