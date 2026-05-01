Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E472036C5A1
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777670134; cv=none; b=X8NKn9TH2Lc9dFjB4NQfufcGhoA39o+05sgLNYIZEY0iekrh3945QkM1MX+Z3cD89ZV/JdLhZGWybEjof4/+sPk74Ju+DpqGKMzEOWogmYH+AfGWy9WQPlnlJ9D8sLtfC/NvpO2kHJ9CkxdcSxdXslFfPTbkD9o+WzzrA7v5soM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777670134; c=relaxed/simple;
	bh=ZO8trgCv3+hZQd3fyOckRou8w+eEVwJG0ITRasopDww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O1qmkcYidRK2PXPYV0ZdNO6q9eKfWeMkrZgXznCwCnqUegVf983rLVJxGjEq6fkI8ezXSjo+Sav2YvPKCacZbsF61tZWt1OW4i9pXL33q2fmO1yv2IBQdlTtH2Ws8496xVAtj5vyaCB0QGhzioTOBCMnYRsUNXDP4/5XFh+n1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3HQ/WpC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3HQ/WpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5A2C2BCB4;
	Fri,  1 May 2026 21:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777670133;
	bh=ZO8trgCv3+hZQd3fyOckRou8w+eEVwJG0ITRasopDww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=g3HQ/WpCDgE2v5ipl5gK9L9xUp6TPDgXafeG6hm27j0PLwkClGh+mXDQULooPLzRl
	 8KtHD1NRtfMS0AD6w+6t2rDXsWN1/OvSWwU1W0FQrtzbFnm5hX+a6iq/GFGXIg6dw/
	 Js7gQmtQdiMM/gi1XieU+dwbsKf0nnFG6faz2QAWUzrvbsDrzlbZJC8/FQxFedWtBC
	 MxIHQFrTlwJVoI0BdKbgmDyVNowHi9gj7/Wovk+qUGnhckznSTiGQxLMOpunxpWfnn
	 /UN51LZcaN/fn8/d0hkZJbAVbjrbk5XvmKC1u6yU9r/U8lkD2DYYuqhenK5u98Exre
	 81ptBAkTzq7XA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] bitops: Define generic __bitrev8/16/32 for reuse
Reply-To: sashiko@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260430211351.658193-4-ynorov@nvidia.com>
References: <20260430211351.658193-4-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 21:15:33 +0000
Message-Id: <20260501211533.9B5A2C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The #ifdef CONFIG_GENERIC_BITREVERSE guard in <asm-generic/bitops/_=
_bitrev.h> introduces build regressions (implicit function declarations) fo=
r modules and uninstantiated inline functions.
--

commit d29d1db3f8ae8fed09b1d7cc283d610df9bcb8b6
Author: Jinjie Ruan <ruanjinjie@huawei.com>

bitops: Define generic __bitrev8/16/32 for reuse

This commit extracts the generic bit reversal functions into a new
<asm-generic/bitops/__bitrev.h> header, allowing architectures to reuse the=
m.

> diff --git a/include/asm-generic/bitops/__bitrev.h b/include/asm-generic/=
bitops/__bitrev.h
> new file mode 100644
> index 0000000000000..f06af929678d6
> --- /dev/null
> +++ b/include/asm-generic/bitops/__bitrev.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_GENERIC_BITOPS___BITREV_H_
> +#define _ASM_GENERIC_BITOPS___BITREV_H_
> +
> +#ifdef CONFIG_GENERIC_BITREVERSE

Will this cause build regressions for modules when CONFIG_BITREVERSE=3Dm?

If CONFIG_GENERIC_BITREVERSE is a bool depending on CONFIG_BITREVERSE, when
CONFIG_BITREVERSE=3Dm, the bool evaluates to n. This causes
CONFIG_GENERIC_BITREVERSE to be n, meaning the generic___bitrev* declaratio=
ns
are removed. Any module calling bitrev8() would then fail to compile due to=
 an
implicit function declaration.

This also means that compiling bitrev.o based on CONFIG_GENERIC_BITREVERSE
prevents it from being built as a module.

> +#include <asm/types.h>
> +
> +extern u8 const byte_rev_table[256];
> +static __always_inline __attribute_const__ u8 generic___bitrev8(u8 byte)

[ ... ]

> diff --git a/include/linux/bitrev.h b/include/linux/bitrev.h
> index d35b8ec1c485c..11620a70e7762 100644
> --- a/include/linux/bitrev.h
> +++ b/include/linux/bitrev.h
> @@ -12,22 +12,10 @@
>  #define __bitrev8 __arch_bitrev8
> =20
>  #else
> -extern u8 const byte_rev_table[256];
> -static inline u8 __bitrev8(u8 byte)
> -{
> -	return byte_rev_table[byte];
> -}
> -
> -static inline u16 __bitrev16(u16 x)
> -{
> -	return (__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8);
> -}
> -
> -static inline u32 __bitrev32(u32 x)
> -{
> -	return (__bitrev16(x & 0xffff) << 16) | __bitrev16(x >> 16);
> -}
> -
> +#include <asm-generic/bitops/__bitrev.h>
> +#define __bitrev32 generic___bitrev32
> +#define __bitrev16 generic___bitrev16
> +#define __bitrev8 generic___bitrev8

Does this introduce header fragility if CONFIG_BITREVERSE=3Dn?

If CONFIG_BITREVERSE=3Dn, the guard in <asm-generic/bitops/__bitrev.h> is
skipped, but __bitrev32 is still unconditionally mapped to generic___bitrev=
32
here.

Any C file including <linux/bitrev.h> that contains an uninstantiated static
inline function using bitrev32() will fail to compile with
-Werror=3Dimplicit-function-declaration. Previously, unconditional declarat=
ions
in <linux/bitrev.h> safely deferred such errors to link-time.

>  #endif /* CONFIG_HAVE_ARCH_BITREVERSE */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430211351.6581=
93-1-ynorov@nvidia.com?part=3D3
