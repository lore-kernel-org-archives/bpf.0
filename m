Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B290C375F7B
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791703035; cv=none; b=RRijhmprTGH8X+NCg+/qFdJt/YR/mPBLbIiHgSp/2NIeuRUQ7YQaTZBUZnMf5/ZCXO6xJ2GTBgIM0TlQb+ToT6wNo8DsNub0gihNzUsKUbhcjJZF/nOqUVbvD2cdMCl3xxfbjjds64/Fq8y5HRCaCkIw7L+TQN24KtLYun5thPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791703035; c=relaxed/simple;
	bh=+gUfxdR+OQ+pG6CDkNofqImoDQA7GGuo4k0g5fJW9VE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Unq3Eoxxfo/YEOCwBcSKEJ5FbfawsnQmLamyP4SfrnSjkLvlRY54sJc+0+LMkqC48O4I4NoN91VrFjvZIWQ0K1cCPJZJr8NA7bies+kQMXxo2EwTWFWDw3VAhGMR56HUZIgyIHAA9QuqJQVf+F1vjHSS3v864mQ+wDmX2HaM+bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuV21nNi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuV21nNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DCC1F0089C;
	Sun, 11 Oct 2026 07:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791703034;
	bh=0nPInTTQTMU1Eb7JPGJkdF57kBPdH4HDEpMjNijRRRM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BuV21nNiDr/nn6/rPu70jvcYDVngGiVpsNXbDC4djoAmfVBFptyWYuYSf0nk0NL+s
	 W2tI5mPsBjAd6UA61zCsADE+5oO771nWaslRJbHF/zWpFUfS6CVYaNNPZUMD+QMQzs
	 7HvHDLynu6LoMSpymTkwNW+5094SeN0N/zCtXLtDwD3VuUUqd6WTcTR64WxsYOuEIN
	 l+danvafOTbx1xmijNbon32gDJbAx2sGp0AEybp1J8mO7/6oK/MY/zcqy6rsxmafRC
	 vW6HxW2R/Gd/+XobykmCvFa9zeI36C8kbavN9kbyuK1l33A7+CNtnIgd1wcHJo9rM5
	 8rS09BdSdZbJg==
Content-Type: multipart/mixed; boundary="===============7618495471217377789=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a91329727252a32182088bb876080db775b51bbdd9f9e01cdb49a6b5a7f0091e@mail.kernel.org>
In-Reply-To: <20261010-scev-minimal-v3-followups-v1-5-6000e95ef993@gmail.com>
References: <20261010-scev-minimal-v3-followups-v1-5-6000e95ef993@gmail.com>
Subject: Re: [PATCH bpf-next 5/9] selftests/bpf: static subprogram argument side liveness tests
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 11 Oct 2026 07:17:13 +0000 (UTC)

--===============7618495471217377789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: static subprogram argument side liveness tests

TL;DR: Test-only nit: __btf_func_path() and the new
btf__compute_live_registers.c (including its unused global_two()) may be
unnecessary, since unnamed params on static naked functions should load and
give the same liveness masks.

> diff --git a/tools/testing/selftests/bpf/progs/btf__compute_live_registers.c b/tools/testing/selftests/bpf/progs/btf__compute_live_registers.c
> new file mode 100644
> index 000000000000..b6633fa88030
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/btf__compute_live_registers.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +/* Use both parameters so clang keeps them in the static functions' BTF. */
> +static __noinline __used int static_two(int a, int b)
> +{
> +	return a + b;
> +}
> +
> +static __noinline __used int static_three(int a, int b)
> +{
> +	return a + b;
> +}
> +
> +__noinline __used int global_two(int a, int b)
> +{
> +	return a;
> +}

[ ... ]

> @@ -425,10 +437,15 @@ __noinline __used int global_two(int a, int b)
>  }
>
>  SEC("socket")
> -__log_level(2)
> -/* a static callee reads r1 only, a global callee its declared arguments */
> -__msg("2: .1........ (85) call pc+")
> -__msg("5: .12....... (85) call pc+")
> +__success __log_level(2)
> +__btf_func_path("btf__compute_live_registers.bpf.o")
                    ^^^^

This isn't a bug, but is __btf_func_path() needed for this test?

fixup_btf_from_path() in test_loader.c only rewrites FUNC entries whose
first parameter has no name, and it only does so when the parameter counts
match.  It keeps the parameter types from the program's own BTF, so all it
changes is the parameter names.

The liveness code only looks at counts and types: prepare_subprog_args()
sets arg_slot_cnt from btf_proto_slots(), which ignores names.  The kernel's
btf_func_check() also accepts unnamed parameters for BTF_FUNC_STATIC
functions, so the BTF from the naked static_two()/static_three() in
compute_live_registers.c should load and give arg_slot_cnt == 2 without the
fixup.  That would produce the same .12 and .123 masks.

Also, global_two() in btf__compute_live_registers.c can never be used,
because global_two() in compute_live_registers.c is plain C with named
parameters, so the fixup skips it.

The existing __btf_func_path() users (verifier_stack_arg_order.c,
stack_arg_precision.c) need the fixup because their naked subprograms are
global, and the kernel requires parameter names for global functions.

Could the test drop btf__compute_live_registers.c, or at least the unused
global_two() in it?

> +/*
> + * BTF declares r1 and r2 for each callee. static_two reads only r1,
> + * while static_three also reads r3, so its call must keep all three live.
> + */
> +__msg("2: .12....... (85) call pc+")
> +__msg("5: .123...... (85) call pc+")
> +__msg("8: .12....... (85) call pc+")
>  __naked void subprog_declared_args(void)
>  {
>  	asm volatile (


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38118645453
--===============7618495471217377789==--
