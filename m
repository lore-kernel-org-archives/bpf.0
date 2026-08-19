Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4132E3F4DCF
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130746; cv=none; b=ttheBKFRCvfnIIcpM85VYrTpCQDcYU8L3kOsK2YT4sgH8JDk1q66CPpzI4gsUZYbQEEn+iQYgKmI6Q9hW7Ctbj7qK0wTHg5CFWz60Tvgo9ACilh2rNSdx8FtwdJQzJzuxy2spB40UEBgRWgkgS9dRHSi1dY9PMwUJoWSpKJeFqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130746; c=relaxed/simple;
	bh=wWsXxUAxW9Uv6vWuTfkpWbl+/olGaaBrRCztvovgLhM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PoyCvhU7VVrYy1IDjdk9E4QI5u2jngN4bY1ajnyNq7ItJYEaFiqvM25aVwnZo49HhBTnLIksnyuUPbRoOszFk/OTwggL1knbWU2M1B1Ho2JnVcn2BW0utTyc0NwELGRe+XZ4MIBwfxmfx3RIzhGnBHFXev7Wmf5TfXXJ48I1Q7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InTT3GxM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InTT3GxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5CB1F00A3D;
	Wed, 19 Aug 2026 09:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787130745;
	bh=qxALwQ6phVaYevk7vs1LeK5oCM0fXQtDciosgXlYVgY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=InTT3GxMNmCP+3MPxBhnYzcNzNe86hOaoa523b4uE4eQZ+vYDWqRu90c8yq5VMY7s
	 GEWIop3hfBUIt1ohHVFISsJVq4AvKodQBdjXzpCr3aJdGl7SayqjreAmcNwnhSUz9m
	 JSRT4pBOBCyWonTLOnUKkrDcQmGFx2W4IvX1lKlvSsjY7qa3smyqpJcFvJaFUKS/k9
	 XOJTTG4uKLoOXGD+keEMD15foi7BwuwosHp9j+c3X8A7ZzklcKgagKq16MZcJG9NHG
	 Rirk/iBjwy245R2oP60XhqOy/Rekt8vdoGmg/9K4BXjfT1L1NJz3Rv3hHj/5K2xhh9
	 m/RHE9eluO7Kw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/bpf: add tests for
 selective kmod BTF loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fuyu Zhao" <zhaofuyu@vivo.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260819090426.267-3-zhaofuyu@vivo.com>
References: <20260819090426.267-1-zhaofuyu@vivo.com>
 <20260819090426.267-3-zhaofuyu@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:12:24 +0000
Message-Id: <20260819091224.ED5CB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The custom libbpf print callback silently drops all non-matching=
 libbpf logs, hiding crucial diagnostic information if the test fails.
--

--- Patch [2]: [RFC PATCH bpf-next v3 2/2] selftests/bpf: add tests for sel=
ective kmod BTF loading ---
commit 17f3a2340dd7be0947e3baabf30a8c7722ec91fe
Author: Fuyu Zhao <zhaofuyu@vivo.com>

selftests/bpf: add tests for selective kmod BTF loading

This commit adds tests for the selective kmod BTF loading feature. It
covers scenarios such as valid modules, non-existent modules, duplicate
names, unneeded modules, and missing count properties.

> diff --git a/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c b/tools/t=
esting/selftests/bpf/prog_tests/kmod_btfs.c
> new file mode 100644
> index 0000000000000..61d2845a731ff
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "kmod_btfs.skel.h"

[ ... ]

> +static int libbpf_print_cb(enum libbpf_print_level level, const char *fm=
t,
> +			   va_list args)
> +{
> +	if (!strcmp(fmt, btf_skip_fmt)) {
> +		if (!strcmp(va_arg(args, char *), "bpf_test_no_cfi"))
> +			btf_skipped =3D true;
> +	} else if (!strcmp(fmt, dup_ignore_fmt)) {
> +		if (!strcmp(va_arg(args, char *), "bpf_testmod"))
> +			dup_ignored =3D true;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Does this unconditionally swallow all other libbpf debug, info, and error l=
ogs?

Since old_print_cb is stored as a local variable in the subtests (like
kmod_btfs_dup and kmod_btfs_skip) rather than globally, this callback has no
way to forward unmatched logs to the original handler. If a BPF program fai=
ls
to load during these tests, will the underlying verifier or libbpf errors be
completely hidden, making CI failures harder to debug?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819090426.267-=
1-zhaofuyu@vivo.com?part=3D2
