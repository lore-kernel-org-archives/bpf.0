Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE643B498
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791123883; cv=none; b=eBpJkUuJAmNee6xN/6btfSXnlZOpsaz3GrHLiUz9XPoWNbDnJYk/F6OBeMJKAhILo52KRD8KTsUejmBzLi4hyi8w0xIEaEOalHmeAWoJ7qHM0tKhPel11Nv73DeiA87xr3K+m6Sge7VRiAXgkJoy3coYQcTowrNqhBsSEFO8LuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791123883; c=relaxed/simple;
	bh=iyG/5MiEZbSZYhPtyn7A2rgeSGmM6GNdu+xEXjXm0sU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CwPIgS46qFynzNYPj5IE8yeXkdreGtiJSNi2HW5cY8NhRjHmuAuGpAdKYIUPRAwQ48s64S7kH2hol7MvXmgVfB/sv937/OW8M11GNuZYGRqOW/vPDC4wFuPSwmxPsEh/cPYCYJz49r5ErRfSfvsdMM2+MczkfVKZyxDGAvBRT7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USiY4ARI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USiY4ARI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144E61F000FF;
	Sun,  4 Oct 2026 14:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791123881;
	bh=YpiX1DuM1IFQmsjxE97G3ZepWxJ8VNwexC2U/3pGwsc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=USiY4ARIJ7AqIOet2sxAR3LNY5c6bboWf6GeEsmT2d7bibHd3EWzGVYFBYzAUlMkR
	 FPtnV3p/rPwmgM0Mg11SZo5Cj1P16g/7Mz8XMi8ge/fgEQl2pwxY8u52m1X9VhdT3i
	 sdjRmT2MX2TMb3zKfuLiv1bAJEtTgmd+UP2S/5FkbgFt7GtZkPfE7AitVbL2TMSyY1
	 89Ym2OqxSlPFZiBdF/Jm/oDGD32QOsmSqv7rtdPxdkGv52IVnDRSFiqHVYQddiMbb1
	 bPmed6UdnqPoe3ABYII5Z5AORR64aB6WeGoP0lwNVByMDCPr9yYn+Psrr/S5SYbmL4
	 V9pwz3jMag0Dg==
Content-Type: multipart/mixed; boundary="===============3767047305169868826=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <314e44fe183f0b6171ab00e44aabb99e9c6868d404f233684d3aeadf85567c65@mail.kernel.org>
In-Reply-To: <20261004-scev-minimal-rebase-v2-41-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-41-f6254e29fdf2@gmail.com>
Subject: Re: [PATCH bpf-next v2 41/43] selftests/bpf: tests for loop hierarchy computation
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  4 Oct 2026 14:24:40 +0000 (UTC)

--===============3767047305169868826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: tests for loop hierarchy computation

TL;DR:
- Stray "dominators test case" line after Signed-off-by in commit message
- Test comments only: wrong function name (compute_loops) and possibly wrong
  "Case C" label in loop_with_if_else

>     selftests/bpf: tests for loop hierarchy computation
>
>     Test cases covering the following branches in bpf_compute_loops():
>     - Case B: simple backedge creating a loop (loop_single)
>     - Case B: two independent loops (loop_two_independent)
>     - Case B + D: nested loops where the inner header's loop_header points
>       to the outer header (loop_nested)
>     - Case C: diamond CFG with no loops (fwd_edges_no_loop)
>     - Case D: sibling inner loops within one outer loop
>       (loop_nested_siblings)
>     - Three levels of loop nesting (loop_three_levels)
>     - Loop with an if-else body containing forward branches
>       (loop_with_if_else)
>     - Case E: An irreducible loop (loop_irreducible)
>     - A self-loop (loop_self)
>     - A test with sibling loops nested in outer loops
>       (loop_nested_siblings_common_ancestors)
>     - A test case with outer loop's backedge originating
>       from an inner loop (loop_outer_backedge_from_inner).
>
>     Cases B, C, D and E are described in loops.c:compute_loops_in_subprog().
>
>     Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>     Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>
>     dominators test case

Should the trailing "dominators test case" line after the Signed-off-by
trailer be dropped?

It is not part of the changelog, and it looks like leftover text from a
squash or fixup.  The next patch in the series, "selftests/bpf: tests for
immediate dominator computation", is the dominators test patch.  As written,
this line would end up in git history after the trailer block.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
> new file mode 100644
> index 000000000000..0f49108c0e50
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +/*
> + * kernel/bpf/loops.c:compute_loops() distinguish between
> + * the following cases:
> + * - B: backedge -> simple loop
> + * - C: cross edge to non-loop node -> no-op
> + * - D: edge to node whose header is in DFS path -> nested loop
> + * - E: edge to node whose header is NOT in DFS path -> irreducible
> + *
> + * Below test cases cover the above branches in various combinations.
> + */

This isn't a bug, but there is no function named compute_loops() in
kernel/bpf/loops.c.

The B/C/D/E branches live in compute_loops_in_subprog(), which is called
from bpf_compute_loops().  The commit message already names
compute_loops_in_subprog() correctly.

Could this comment name compute_loops_in_subprog() so readers can find the
case labels it lists?  Also, "distinguish" should probably be
"distinguishes".

[ ... ]

> +/* Loop with an if-else body (forward branch inside loop, Case C). */
> +SEC("socket")
> +__success
> +__log_level(2)
> +__msg("loop at 1")
> +__msg("Program dump")
> +__msg("         -1   0: {{.*}} (b7) r0 = 0")
> +__msg("  1       0   1: {{.*}} (07) r0 += 1")
> +__msg("  1   1   1   2: {{.*}} (bf) r1 = r0")
> +__msg("  1   1   2   3: {{.*}} (25) if r1 > 0x5 goto pc+1")
> +__msg("  1   1   3   4: {{.*}} (b7) r1 = 1")
> +__msg("  1   1   3   5: {{.*}} (0f) r0 += r1")
> +__msg("  1   1   5   6: {{.*}} (a5) if r0 < 0x64 goto pc-6")
> +__msg("          6   7: {{.*}} (95) exit")
> +__naked void loop_with_if_else(void)
> +{
> +	asm volatile ("					\
> +	r0 = 0;						\
> +1:	r0 += 1;					\
> +	r1 = r0;					\
> +	if r1 > 5 goto 2f;				\
> +	r1 = 1;						\
> +2:	r0 += r1;					\
> +	if r0 < 100 goto 1b;				\
> +	exit;						\
> +"	::: __clobber_all);
> +}

This isn't a bug, but is "Case C" the right label in the comment above
loop_with_if_else()?

In compute_loops_in_subprog(), bpf_insn_successors() returns the fallthrough
first, so the DFS goes 3 -> 4 -> 5 -> 6 and, when it returns, sets
aux[5].loop_header = 1.  When the edge 3 -> 5 (the "if r1 > 5 goto 2f" jump)
is examined afterwards, insn 5 is fully explored and its loop_header is 1,
not -1.  Since dfs_pos[1] != 0, the "else if (dfs_pos[aux[s].loop_header])"
branch runs, which is Case D.

Case C only fires for aux[s].loop_header == -1, and the file header defines
it as a "cross edge to non-loop node".  Insn 5 is inside the loop at 1.  The
result is the same if the DFS order is reversed, because then 4 -> 5 would be
the cross edge into a loop node.

Only fwd_edges_no_loop() really covers Case C (the 4 -> 5 cross edge).  Should
this comment say Case D, or name no case, as the commit message does for this
test?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37207249098
--===============3767047305169868826==--
