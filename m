Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD5B547063
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790466386; cv=none; b=DGtE/Xhhs3Y5EPVn4T2DuuP04fQdtHX3jFMtT0oqCrNUv6Dh+vpIcjgJJafrx5klYIokU4MNkBJjfsaNw/zNLFMbKsG5ZsKA1bZUqgpDmfNZNSLGJ+qMmTt35wFipX1JFqMFPjLKJADAj2CtLBugy/L2te5W8+iIFoV9xgBk154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790466386; c=relaxed/simple;
	bh=EjMyg0ZiLmUHHvMgKKM4xyaEprXmpfwNgDnMIC0k5xw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FPHnGJcvqwMNM5aGZhzggN+LGCtLOCpdy8w124qXQzd5THVkk4H4BYXafPwtJCXm0345bMvWZNr49s4XawMezx1L/kgWTARwDttanaHF2MyaIZTRdBXWp9RTOBdb/50XJCum2l5DOZcoL4yVvfr5ThgPb21I32KPH3J/zYNjUaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbvoDgXE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbvoDgXE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4385E1F000FF;
	Sat, 26 Sep 2026 23:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790466385;
	bh=u38p390o8bbJekNsjfGkkIOfmRKkYXN+5PwmoIL63dk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BbvoDgXEC0iCXIeCO6ord/rLTQBVkY41wbcdkguV5mkjZANHsemEqo1ERsasZ1AZC
	 RCLQIWD5tFGYXTAAgakhr2NM5ZZktwHdCk9Kar/TxpWX9kvCG2eodPn7apn4W+TvqE
	 hM97KCseR7puyBTMNgugucBcdBgw4GgMOHfH4AizxLKYYkKLnxHhVv9eqsEguPcXWM
	 wesQMS8q0u3gk1Scyiggp+H3TyPzWm+UnQodeinW0j7Sm7YxQB6weqKK0LwTielonn
	 KtaGtv9QgQ5JRogFVcwEBfsD94xq8qNtLy4giwhN9gOg753efnAmp8LFO7urNfkP2C
	 0oyL3T7VLqDbg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 12/16] selftests/bpf: Build BPF objects
 with compiler-inserted typed arena casts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926233503.3114147-13-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
 <20260926233503.3114147-13-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 23:46:24 +0000
Message-Id: <20260926234625.4385E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: missing typed-arena feature flag propagation to libarena sub-m=
ake
--

commit b75aa4c5a8315082b286ae6d14b710be82785867
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Build BPF objects with compiler-inserted typed arena casts

This commit probes clang for typed arena cast support and defines
CLANG_TYPED_ARENA if available. It then appends this new flag to BPF_CC_FLA=
GS
when building test_progs and its various flavors.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index afa589a27b151..bd1f84f55edc5 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -510,7 +517,7 @@ BINARY :=3D test_progs
>  BPF_CC :=3D $(CLANG)
>  BPF_CC_MSG :=3D CLNG-BPF
>  BPF_SYS_INCLUDES :=3D $(CLANG_SYS_INCLUDES)
> -BPF_CC_FLAGS :=3D -O2 $(BPF_TARGET_ENDIAN) -mcpu=3Dv3
> +BPF_CC_FLAGS :=3D -O2 $(BPF_TARGET_ENDIAN) -mcpu=3Dv3 $(CLANG_TYPED_AREN=
A)

[Severity: Low]
Should the newly introduced CLANG_TYPED_ARENA flag also be propagated to the
libarena sub-make?

When building libarena, BPF compilation flags are explicitly passed down
without the new compiler feature flag:

LIBARENA_MAKE_ARGS =3D \
...
		CLANG=3D"$(CLANG)" \
		BPF_CFLAGS=3D"$(BPF_CFLAGS) $(CLANG_CFLAGS)" \
...

While there are currently no typed arena tests within libarena, omitting th=
is
flag means any future typed arena programs added to libarena might fail to
compile or get unexpectedly skipped. Does it make sense to include it here
for consistency?

>  BPF_DEFINES :=3D -DENABLE_ATOMICS_TESTS
>  include Makefile.skel

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926233503.3114=
147-1-memxor@gmail.com?part=3D12
