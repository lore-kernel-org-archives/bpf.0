Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1D8367B6F
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 03:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786592264; cv=none; b=drZUi4DH2NcxHxiMLVsiWzQ4xGR4aSNsUz/1HuWj4YwjjRR1aa51WDhbAFdZjATwmQ81zAXFwXJ1xwdrcEfCBYkAJuqcrcY9Y6iC/4vIt01ptxXVK+jBpQBtu4qrvNAG5Ra0UXeXCMmTuWTqaQrp5229mOghLzr1hw+RaWrIR44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786592264; c=relaxed/simple;
	bh=vWXTKlju+kZNorxnF2Sm2sZn3RCbE1HbvUDdwURT4gU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PLUrA4yi2OAiHCRK/wMUnINZvv/b+1p0u2DgW6s9F+NHsrWjK+mEiysZZDQ1EMfrg31WubeLLmOUbBmko5PVAjDrZpZKjNGoqA/Y8u30ZcteB5WnB3Nn6DEYiUtiYra+pgiB8IEGQTmzXRaiCDSk+IaYU/8Qf3ZjfTzc0St5O44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/PNly++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/PNly++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102F91F000E9;
	Thu, 13 Aug 2026 03:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786592263;
	bh=WniDOR7mo6Y/pAYZHyD96n4SsMo2ydTGlYmrw3R6OF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V/PNly++Yd5UQ2TikYg0KpnNEcfafoy4XvKY1Ea4uh1DATngmUfjOlb8Y1ajB3UrK
	 NAqPv+xHyTxyv6V3xpPXYDhxLct4LNepeWgyiLU/XCy5vof6ePQ4BG4Nl8Bm2tahNt
	 dV64l+4XZFO1BSoNn9DMmQ5OtqNbWI6xtHvFmlEsb37FofmngmRe+sy4zJIh+OQ4gt
	 D46pe4DFwpULtoh45wkBGHzgKl4WGbyMlgt1QMna5DMIb18bcNi3pdUe7GodBff7EA
	 X11X67kyjxYZTWuZkFZl11lo6XGFMfFEZczgiWfX4EnXNBmnLAAFCRYiP+UM1KQhcf
	 etigXcH72ZGrw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v2 2/2] selftests/bpf: add tests for
 selective kmod BTF loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fuyu Zhao" <zhaofuyu@vivo.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813032613.2755-3-zhaofuyu@vivo.com>
References: <20260813032613.2755-1-zhaofuyu@vivo.com>
 <20260813032613.2755-3-zhaofuyu@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 03:37:42 +0000
Message-Id: <20260813033743.102F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The tracking counter `obj->kmod_btfs->nr_loaded` is never update=
d, rendering the early termination optimization for BTF loading completely =
ineffective.
--

--- Patch [2]: [RFC PATCH bpf-next v2 2/2] selftests/bpf: add tests for sel=
ective kmod BTF loading ---
commit 506359525a106f517e013e060ee2c6feb17720c8
Author: Fuyu Zhao <zhaofuyu@vivo.com>

selftests/bpf: add tests for selective kmod BTF loading

Add test cases to verify the new ".kmod_btfs" section logic in libbpf.
The added test cases cover three main scenarios: valid module, non-existent
module, and duplicates/unneeded modules.

> diff --git a/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c b/tools/t=
esting/selftests/bpf/prog_tests/kmod_btfs.c
> index 0000000000000..d875fcce6681d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "kmod_btfs.skel.h"
> +#include "kmod_btfs_nonexist.skel.h"
> +#include "kmod_btfs_mix.skel.h"
> +

[ ... ]

[Severity: Medium]
While reviewing these tests, I noticed a potential regression in the libbpf
code they exercise. In load_module_btfs():

tools/lib/bpf/libbpf.c:load_module_btfs() {
...
		if (obj->kmod_btfs &&
		    obj->kmod_btfs->nr_names =3D=3D obj->kmod_btfs->nr_loaded)
			break;
...
}

Is obj->kmod_btfs->nr_loaded ever incremented when a module BTF is
successfully loaded?

If it is not incremented, will this early termination condition ever be
met? It appears this might unnecessarily iterate over all remaining
system BTFs, which would bypass the intended performance optimization
of the .kmod_btfs section.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813032613.2755=
-1-zhaofuyu@vivo.com?part=3D2
