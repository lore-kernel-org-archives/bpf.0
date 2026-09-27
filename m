Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5CF3BFE44
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540832; cv=none; b=EdUpgGc59lgLWjETvjg71HPOzFnbajANq3oEUQyw7rLPMSIFgdCbGgG6vJ5ErE0IgiIP6Ui1nFO3xP/dhNVplb1f4s3NRflgTodMxckvEHZTdMyyxh0JtaY8YfisfJoHJ23mSAQuAsinJzbcGZSED+PecmnAhtGAYKfeXI/kyV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540832; c=relaxed/simple;
	bh=dJnwACzhe9Wu871j8XZxjLrKZFLKyhdGglL7KaQvRxY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=K0v2IojPLc9h7fmGsW7x73zGYCtrSUP9M3l++ovGuroMXNTreXk9tmsNEB90Rc1i31vr6aXdw+6PxlcMdI90od3eyQeA7MlKDFZYtmctgyv5PiQ6V9jCJsIQKvKOhB0PuoL3XK5n3XAGTgLl2ac7OXoNT48W6k6axb1lO/77pXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ6xDezI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ6xDezI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224641F00893;
	Sun, 27 Sep 2026 20:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790540830;
	bh=ZKFmgZEVU0PMDjBaemZDC9ZBqMdVtWnQaIkCagXVNh8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fZ6xDezIix5yFmPJdSlN6ZjLdrIush3sRji4KU6PQgF6MASf+yWewHyC6gkGxaLs5
	 UrAE6tewSwJE3YdeA/T8KPknvYbJwkFzl5A6ORLs6QZ6SQam/kwxeuZCYhZZhp5TWY
	 p1y8Vpwfe+o4ZfYMyZAoDHkQUB8mDljsoJ3Y1UK0A1oACX0lrEWVI1FRqH76Nt+QEi
	 eXbcQ1H11gKtnfRv4L6l2GRzZ/qwz03ZeTeG/wn+2AKcXi2O50MY71JZDfTZQdb1LI
	 N4lLxadhcNxjkHI1VH3DmOtG2JprIUtSG4j/3sYmnG875S0QahmOMPjgmTBgxxvy1m
	 XwM8zolV/SSZQ==
Content-Type: multipart/mixed; boundary="===============2851503015534698539=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <25f99a22b434f9c3cbee7034aa6d542c711e994eabaa17fc75d8a658ebda97b6@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-35-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-35-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 35/36] selftests/bpf: tests for immediate dominator computation
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:27:10 +0000 (UTC)

--===============2851503015534698539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index be4fd187ba5f..82b21ec472ba 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_idoms.c b/tools/testing/selftests/bpf/progs/verifier_idoms.c
> new file mode 100644
> index 000000000000..a29d6332baa4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_idoms.c
> @@ -0,0 +1,390 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +#include "../../../include/linux/filter.h"

[ ... ]

> +/*
> + * Simple loop: the header (insn 1) is dominated by the pre-header (insn 0). The
> + * back edge (insn 2 -> insn 1) must not change idom(1); the back-edge
> + * predecessor folds up via idoms_intersect().
> + */
> +SEC("socket")
> +__success
> +__log_level(2)
> +__msg("Program dump")
> +__msg("{{.*}} -1   0: {{.*}} (b7) r0 = 0")
> +__msg("{{.*}}  0   1: {{.*}} (07) r0 += 1")
> +__msg("{{.*}}  1   2: {{.*}} (a5) if r0 < 0xa goto pc-2")
> +__msg("{{.*}}  2   3: {{.*}} (95) exit")
> +__naked void simple_loop(void)
> +{
> +	asm volatile ("					\
> +	r0 = 0;						\
> +1:	r0 += 1;					\
> +	if r0 < 10 goto 1b;				\
> +	exit;						\
> +"	::: __clobber_all);
> +}

A subsystem pattern flags this as potentially concerning: four of the
new programs (simple_loop, nested_loops, loop_with_if_else_body, and
irreducible) are identical to programs that the previous commit in this
series (5be24395b013 "selftests/bpf: tests for loop hierarchy
computation") added to progs/verifier_loop_hierarchy.c. The earlier
tests already check the same idom column values, and they also check the
scc and loop_header columns.

For example, verifier_loop_hierarchy.c:loop_single already has the same
program as simple_loop above, including:

  __msg("         -1   0: {{.*}} (b7) r0 = 0")
  __msg("  1       0   1: {{.*}} (07) r0 += 1")
  __msg("  1   1   1   2: {{.*}} (a5) if r0 < 0xa goto pc-2")
  __msg("          2   3: {{.*}} (95) exit")

The same applies to nested_loops (== loop_nested),
loop_with_if_else_body (== loop_with_if_else), and irreducible
(== loop_irreducible). self_loop is also the same program as loop_self;
only the idom __msg lines are new there.

These four cases are covered, more strictly, by tests in the same
directory. Could they be dropped, or the missing idom __msg lines be
added to the existing verifier_loop_hierarchy.c cases, so the file only
keeps the cases that are new (ldimm64, asymmetric diamond, multiple back
edges, multiple subprogs, subprog entry as loop header, gotox)?

> +
> +/*
> + * Loop with an if-else in its body. The in-loop merge point (insn 5) is
> + * dominated by the in-loop branch (insn 3), combining a back-edge intersect
> + * with a forward-diamond intersect.
> + */

[ ... ]

> +/*
> + * Nested loops: the idom chain runs inner-header -> outer-body -> outer-header
> + * -> pre-header. Exercises intersect across back edges at two nesting depths.
> + */

[ ... ]

> +/*
> + * Irreducible CFG (loop with two entries, insn 3 and insn 5, reached from the
> + * insn 2 branch). Dominators remain well-defined; this is a convergence test
> + * for the fixpoint under irreducibility. Note insn 6 is dominated by the branch
> + * (insn 2), not by either arm.
> + */
> +SEC("socket")
> +__success
> +__log_level(2)
> +__msg("Program dump")
> +__msg("{{.*}} -1   0: {{.*}} (85) call bpf_get_prandom_u32#7")
> +__msg("{{.*}}  0   1: {{.*}} (b7) r1 = 0")
> +__msg("{{.*}}  1   2: {{.*}} (25) if r0 > 0x5 goto pc+2")
> +__msg("{{.*}}  2   3: {{.*}} (b7) r1 = 1")
> +__msg("{{.*}}  3   4: {{.*}} (05) goto pc+1")
> +__msg("{{.*}}  2   5: {{.*}} (b7) r1 = 2")
> +__msg("{{.*}}  2   6: {{.*}} (0f) r0 += r1")
> +__msg("{{.*}}  6   7: {{.*}} (a5) if r0 < 0x10 goto pc-5")
> +__msg("{{.*}}  7   8: {{.*}} (95) exit")
> +__naked void irreducible(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r1 = 0;						\
> +	if r0 > 5 goto 2f;				\
> +1:	r1 = 1;						\
> +	goto 3f;					\
> +2:	r1 = 2;						\
> +3:	r0 += r1;					\
> +	if r0 < 16 goto 1b;				\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

The comment says the loop's two entries are insn 3 and insn 5, but
looking at the program:

  2: if r0 > 5 goto pc+2   (-> 5)
  3: r1 = 1
  4: goto pc+1             (-> 6)
  5: r1 = 2
  6: r0 += r1
  7: if r0 < 16 goto pc-5  (-> 3)

The cycle is {3, 4, 6, 7}. Insn 5 is not in it: its only predecessor is
insn 2, and nothing in the loop reaches it. The two entry nodes are
insn 3 (from 2) and insn 6 (from 5). The previous commit's
loop_irreducible test checks exactly this for the same program: insn 5
has empty scc/loop_header columns ("          2   5:"), and insn 6 is in
loop 3 ("  1   3   2   6:").

Insns 3 and 5 are the targets of the insn 2 branch, not the loop
entries. Could the comment be corrected ("entries insn 3 and insn 6")?

[ ... ]

> +/*
> + * Self-loop: insn 1 is its own predecessor. idom(1) must be the pre-header
> + * (insn 0); the self-edge is ignored (idoms[pred] == -1 on the first pass, then
> + * idoms_intersect(a == b) short-circuits). Program is rejected later for an
> + * infinite loop, but the dump (and idoms) are printed before that.
> + */
> +SEC("socket")
> +__failure
> +__log_level(2)
> +__msg("Program dump")
> +__msg("{{.*}} -1   0: {{.*}} (85) call bpf_get_prandom_u32#7")
> +__msg("{{.*}}  0   1: {{.*}} (a5) if r0 < 0xa goto pc-1")
> +__msg("{{.*}}  1   2: {{.*}} (95) exit")
> +__msg("infinite loop detected")
> +__naked void self_loop(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +1:	if r0 < 10 goto 1b;				\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

The comment says "idoms_intersect(a == b) short-circuits", but preds[1]
is filled in ascending instruction order, so it is {0, 1}. On the second
pass of compute_subprog_idoms(), pred 0 gives new_idom = 0. Pred 1 then
has idoms[1] == 0, so the call is idoms_intersect(env, 1, 0), with
a != b. The loop walks a = idoms[1] = 0 once before the two values meet:

  while (a != b) {
          while (postorder_nums[a] < postorder_nums[b]) {
                  a = idoms[a];

The result, idom(1) = 0, is correct. Could the explanation be corrected
("idoms_intersect(1, 0) walks insn 1 up to its idom 0")?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============2851503015534698539==--
