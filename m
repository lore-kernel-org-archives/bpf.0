Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939101;
	b=kYI0MR9yar8inV4LCFAOdsZaizjHajxSn7OKSEWdjOfV4bCyvgFXTHx6J3oLvgM3iu9Q
	 2RdpI39mqyoO8Emx0QzLHqDEjTTTjZmkdNvTxSEpY9eM6tPrXwFAWWtUi7DQPGH//L/Sn
	 onMXKbYF7WBj/oke2t3s8rmdg8s59bgYAjuo/gLHUCyufZmxceNPGi99jL5KDQPXDhWg6
	 FSqxCgmArSfZ8By44Xg2pzsEm+Fyx6mcYfJmb/OQVpK86sKL98IcvDOs0D2pX74aOmeGD
	 OTCDvJz7PeKHSeYwzsZTeVOgHd1OY6eNMuEDYts1U6N7RUFoucKn8mrQDGPPx37gIjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939101;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=TEw9QeuW3OSrTGpmcrcWlF9c7dgbbOHo3YtXbWN4wuw=;
	b=KDiEafyXi/3mb0mvkZiTmarRDYPXEIzEXmnA4dZ5fdpqMdKHDcGZ0pzbLeWe8NRGs7z5
	 4WVQ+sxW+fOYtRR4cFBAA+AbyJoFAk5iFjPB3FDjI03ojuFiQ/2FXwn9hyRIxxp31TylN
	 fPkgh76ukDf5SNqX5vzg9lyhrkBiBXUtXc7hBY4h8DZ4jd+1WYTJ+ZTbroHhHde3kvy+4
	 +s4Y+NEz5MbN/Q/yC8PhnNuk6/rjLIYH14FtdByQmIVl4mKmo5z+E9ZWhEAp8o818p5VJ
	 LBeMEdnMaFRsFIqlQAc4A/5IbiJTR8mmijb/W40UCbSem3Aem+VMKMsmMDzuGZ/KOrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U3lkNLEF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A112606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U3lkNLEF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD1A1F0089F;
	Fri,  6 Nov 2026 04:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939100;
	bh=TEw9QeuW3OSrTGpmcrcWlF9c7dgbbOHo3YtXbWN4wuw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=U3lkNLEFHd7f/lMIJy3nhlHOnCdf2CboxesNgJPt1S3ZNbWPuc53Fi9Sp/ck/HtBw
	 BfAAvx9nLw/zAX7mj8r35B1OIrkNe1ua60GgcYJqp7VUQcd26lmvQ2Vsr+JAwgXoOV
	 nolE4Mk+1qwHXXfRq5HBtz1W0/OkeO0Bn56up9cK6xk+XEEuLQ65sMdJdCDFcnD/2I
	 yDWMaSvBBnqTBPK6pxaks0QCspoAInE7le3tK3nXyexYFaYUlv6lu1aPqAcIH6Sn/K
	 uArP8yWpQFvq2wM5+/oyIsWNU9zM8MawS3C1e4khD52kBZY+mcQlJOi7fwlVCf+Ytg
	 ssuu56uiX2rSQ==
Content-Type: multipart/mixed; boundary="===============2765349399270386642=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <81108c3275734829879dfcb4c72acd26596dc8d4d76054d7275cac040eb88d58@mail.kernel.org>
In-Reply-To: <20261106035111.3315285-41-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-41-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 40/45] selftests/bpf: Adjust tests to new verdicts, messages and order
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 04:25:00 +0000 (UTC)

--===============2765349399270386642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Adjust tests to new verdicts, messages and order

TL;DR: Nits only, in selftests: comments in iters.c left stale after the
prune-point and dfs_depth notes were removed, and a possibly unneeded
bpf_compiler.h include in verifier_scev.c.

> diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
> --- a/tools/testing/selftests/bpf/progs/iters.c
> +++ b/tools/testing/selftests/bpf/progs/iters.c

[ ... ]

> @@ -2398,7 +2370,7 @@ __naked void iter_remake_two_jmp(void)
>  /* Same loops with a prune point in front of bpf_iter_num_next() */
>  SEC("socket")
>  __description("iter: remake in the loop")
> -__failure __msg("infinite loop detected")
> +__success __retval(0)
>  __flag(BPF_F_TEST_STATE_FREQ)
>  __naked void iter_remake_inline(void)
>  {

This isn't a bug, but the prune-point sentence above iter_remake_jmp() and
the dfs_depth note in the C comment of loop_state_deps3() are removed,
while "Same loops with a prune point in front of bpf_iter_num_next()" and
the asm comment "/* loop to increase dfs_depth */" are still there.

Should these be updated as well, so the comments say what still separates
the two groups of loops?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
> --- a/tools/testing/selftests/bpf/progs/verifier_scev.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
> @@ -8,6 +8,7 @@
>  #include "../../../include/linux/filter.h"
>  #include "bpf_misc.h"
>  #include "bpf_kfuncs.h"
> +#include "bpf_compiler.h"
>  
>  #define COND_TEST(name, _initial, _step, _bound, msg, body)                     \
>  SEC("xdp")                                                                      \

This isn't a bug, but is the new bpf_compiler.h include needed here?
Nothing in verifier_scev.c seems to use its macros.

Was it meant to replace the open-coded #pragma block in
no_widen_dynptr_kfunc_arg() with __pragma_loop_no_unroll, or can the
include be dropped?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42160076968
--===============2765349399270386642==--
