Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8F536CDFE;
	Tue, 22 Sep 2026 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041643; cv=none; b=FWNkpwisqWURQBnGgi+elQB0KgFrcNSdJwxOqWzLf7gAx7StM75JutZAjtSDxLO9dTOX/NJQRIOZRuAHu1sEvTnqzW2IIe8CewaTP4fGuaqtvdrQFHpettDnF2Uc/4A2IBkxZUxJM+3cDrLksxnHap5t1pLkQYz70Xpmsq+F2iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041643; c=relaxed/simple;
	bh=7pFPxq+NpeOlbnjQO8SraXZb7pJWwEBdclRDEF07WXw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GR8yF7dkcY7V8lFCalHakCsbDOsqSBVqBsHtiopf0+vm8w72m75OwQP4HChapEF0WLUiSzh7rs0Ik1+0fEhlxFDqrvBJEQ3F/Dfs1XuY3teLCj2RqUFmNz2IcdlqeyhDKQo+iEFiHFCTLsDJ28JiicntXKqj4CymjPl3WN8biKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MH/7kgAI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MH/7kgAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367371F000FF;
	Tue, 22 Sep 2026 01:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790041641;
	bh=prK9X1K9VD4nIBv0PH9zuxTPFg/V9+IvoRRtsUUSkHw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MH/7kgAIC8Vn63BqWeQouP2Fw1WJOvrbDAnOhS+Jup9vyRPhAjBejVgD3VyufxWYo
	 2Pv0RLKYewtBDDtxYAySm66fz3/WfbUyfk7SKFprCsTQ9xyJtRZU28Y0DObE4AUxMn
	 DJLkYVTRMr9E2P7Gd1iSXCYzpBQCRwogH9I5UXlGMv9wfmuqaiROTBZGk6842DIt6T
	 0Uq1xtfKDDECPbvjAooN1ISWnqPl6Mrza1TJta07L8c9qfziXqJSq5aD4rgMX3E3hX
	 ozgGGPryXKhRdMeahly0HoBNUTyHSkMPNAmvbuVxe5lpsQG1Tq7xP3WnP/DB4wD+RN
	 Ps3f+jeaWuo2A==
Content-Type: multipart/mixed; boundary="===============0301420144489931996=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0a8bfca1d3ae9ed8184f1a5138247e04244d20b3532f1f2510436fba46b2412b@mail.kernel.org>
In-Reply-To: <20260922010333.1226537-5-ihor.solodrai@linux.dev>
References: <20260922010333.1226537-5-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 4/6] selftests/bpf: Cover the user ringbuf callback dynptr lifetime
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: ameryhung@gmail.com,emil@etsalapatis.com,npc@anthropic.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 01:47:20 +0000 (UTC)

--===============0301420144489931996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit ffea6db696c062005bd2724d8b3888fa7eaa4768
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> Date:   Mon Sep 21 18:03:31 2026 -0700
>
>     selftests/bpf: Cover the user ringbuf callback dynptr lifetime
>
>     Add a rejection test for each route the bpf_user_ringbuf_drain() callback
>     dynptr can take out of its frame:
>
>       - the CONST_PTR_TO_DYNPTR register parked in callback_ctx
>       - a bpf_dynptr_data() slice
>       - a bpf_dynptr_slice() slice
>       - a bpf_dynptr_clone() written into the caller's frame
>       - a slice taken from that clone after the drain returns
>       - an inner drain's dynptr escaping into an outer callback
>
>     The first also checks that the diagnostic names the callback.
>
>     bpf_throw() from the callback reaches check_reference_leak() with the
>     frame reference still live, and is rejected afterwards by
>     check_max_stack_depth(). It matches that rejection in full, because
>     "bpf_throw" alone also matches the reference-leak wording the callback
>     must not produce.
>
>     Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

This isn't a bug, but the changelog says "The first" also checks the
diagnostic names the callback, yet four of the six programs match "the
callback that owned this value returned" - would it help to say that the
parked-dynptr/slice/nested routes all pin that wording and only the clone
routes differ?

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
> index 22503cf62e9f..86a0667ba348 100644
> --- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
> +++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
> index c0d0422b8030..a8d3acfa2bd2 100644
> --- a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
> +++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
> @@ -1,9 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
>
> +#include <stdbool.h>
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>  #include "bpf_misc.h"
> +#include "bpf_kfuncs.h"
>
>  char _license[] SEC("license") = "GPL";

[ ... ]

> @@ -243,3 +245,144 @@ int user_ringbuf_callback_const_ptr_to_dynptr_reg_off(void *ctx)
>  			       callback_adjust_bpf_dynptr_reg_off, NULL, 0);
>  	return 0;
>  }
> +
> +/* The sample goes back to the producer as soon as the callback returns. */
> +struct dynptr_ctx {
> +	struct bpf_dynptr *saved;
> +};
> +
> +static long callback_park_dynptr(struct bpf_dynptr *dynptr, void *context)
> +{
> +	struct dynptr_ctx *c = context;
> +
> +	c->saved = dynptr;
> +	return 0;
> +}

[ ... ]

> +static long callback_park_inner(struct bpf_dynptr *dynptr, void *context)
> +{
> +	struct dynptr_ctx *c = context;
> +
> +	c->saved = dynptr;
> +	return 0;
> +}

This isn't a bug, but callback_park_inner looks identical to
callback_park_dynptr - could the nested test pass callback_park_dynptr to
the inner drain instead, the way callback_park_clone is already shared by
the two clone tests?

> +
> +/* An inner drain's dynptr must not escape into the outer callback either. */
> +static long callback_park_outer(struct bpf_dynptr *dynptr, void *context)
> +{
> +	struct dynptr_ctx inner = {};
> +	char buf[8] = {};
> +
> +	bpf_user_ringbuf_drain(&user_ringbuf, callback_park_inner, &inner, 0);
> +	if (inner.saved)
> +		bpf_dynptr_read(buf, sizeof(buf), inner.saved, 0, 0);
> +	return buf[0] ? 1 : 0;
> +}
> +
> +SEC("?raw_tp")
> +__failure __msg("the callback that owned this value returned")
> +int user_ringbuf_callback_nested_park_inner(void *ctx)
> +{
> +	bpf_user_ringbuf_drain(&user_ringbuf, callback_park_outer, NULL, 0);
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35674974944
--===============0301420144489931996==--
