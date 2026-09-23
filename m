Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB28D57F721
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194378; cv=none; b=Xei5nPWI6cmfcr2BZe6rYcvRgEKUY+YVjSOIBwQN+trkiKW6z8ml/xqDsFYc25xeRFRN51emZ3AD2ijRv+iQlLNOVLo+xYv0GFApteku89ucJUUPceqHy/StDCpfbkWc5zwnLxFUIY+HoH2YXEIP/9O975WJqzWvaAeGoA4ctgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194378; c=relaxed/simple;
	bh=No7mrmR+8LHwu/43B5Yygh4Ij/nyTImdTnzaR/3FG94=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=D+c9SF8UH6pgjtDGzEzhx19F+ty1MxWUZoMEFf6FfBQgSqX2DZjxdosWWf8lLO/kegCk74te//9sQyNRlit5pOtUSIsnykCSqzmwSTe5bCmlXiYoN/HZHWhq6HbxzEX+Rraw6pmjT8ZZgvYAwhtIszfAOQQigAfbPXdxuSFm+uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXJQpUPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXJQpUPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D661F0089B;
	Wed, 23 Sep 2026 20:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790194360;
	bh=50b6NN5voQOs96uzuuiZLerCN+UkebC4BDwX01LsdKk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bXJQpUPJisqbGZTS/IuXaHAscTyDoP1e59Qb2zNDWBDXUl9E5GghobtN9CsfJIqDY
	 RvITutelxUktSktu0d3hvUvR3AiTAj0GUQe6XIYUiif3DxcISm2fvHZnJwJ+i2+g3y
	 ZPjrM9FDsbYf5ArKqOyqot3nqfePgKjckSGDhfUybMOdY2IwFH91KKjkWRBHexoRRf
	 2Bo4zxmozVpJFV9vaJV/BZNzfZpiNuU4z2WIxCgGuacudrrIll+E1cQYFl6kSgbz5e
	 Q4YXmyUwTJJfhNbtc1CKUE2hiqkMvUrEN+/xavpxjlnRJhmqoimD3NxBrZrUyQXvEF
	 doDhoc49xbcrA==
Content-Type: multipart/mixed; boundary="===============6040287993884596337=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0c79a8882d6a3efb42ca407727b2a03ac66675272e0610b319996f582c22cd31@mail.kernel.org>
In-Reply-To: <20260923191139.2816206-19-memxor@gmail.com>
References: <20260923191139.2816206-19-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 18/18] selftests/bpf: Test the 2 KiB stack budget
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 20:12:38 +0000 (UTC)

--===============6040287993884596337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> index 98db9bafa44b..2b3ec2b79091 100644
> --- a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> +++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c

[ ... ]

> @@ -78,6 +79,34 @@ static void test_private_stack_recur(void)
>  	struct_ops_private_stack_recur__destroy(skel);
>  }
>
> +/* Two frames of 2 KiB each on the private stack */
> +static void test_private_stack_large(void)
> +{
> +	struct struct_ops_private_stack_large *skel;
> +	struct bpf_link *link;
> +
> +	if (!is_large_stack_supported()) {
> +		test__skip();
> +		return;
> +	}

A subsystem pattern flags this as potentially concerning: The BPF
selftests guide recommends always including a reason string in the skip
message so future debuggers know why the test was skipped. When the probe
gets a clean "invalid write to stack" rejection, is_large_stack_supported()
prints nothing, and the subtest shows only SKIP with no indication that
the reason is missing large stack support.

The test_loader's run_subtest() prints a reason
(printf("%s:SKIP: %s\n", __func__, spec->skip_reason)) before calling
test__skip(), but here the skip is silent. On the other hand, a bare
test__skip() with no printf is the most common idiom in prog_tests
(about 90 of 149 call sites follow this pattern, and the #else branch
of this same file does the same). Could this include a skip reason,
or is silent skipping acceptable BPF selftest convention?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> index c5c9d6c359bb..c5e3f198ca7f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c

[ ... ]

> @@ -1953,6 +1954,45 @@ static void test_tailcall_bpf2bpf_fexit_links(void)
>  	tailcall_bpf2bpf2__destroy(skel_tc);
>  }
>
> +/*
> + * test_tailcall_large_stack runs a tail call made from a subprog with a 1536
> + * byte frame, under a 240-byte caller, into a program with a 2 KiB frame:
> + *
> + * entry (240) --call-> subprog_tail (1536) --tailcall-> classifier_0 (2048)
> + */
> +static void test_tailcall_large_stack(void)
> +{
> +	struct tailcall_large_stack *skel;
> +	int err, prog_fd, map_fd, key = 0;
> +	char buff[128] = {};
> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> +		    .data_in = buff,
> +		    .data_size_in = sizeof(buff),
> +		    .repeat = 1,
> +	);
> +
> +	if (!is_large_stack_supported()) {
> +		test__skip();
> +		return;
> +	}

The same pattern appears here: when is_large_stack_supported() returns
false, test__skip() is called with no reason string. Could this also
benefit from a skip message?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_large_stack.c b/tools/testing/selftests/bpf/progs/verifier_large_stack.c
> new file mode 100644
> index 000000000000..2d4c81a3f0cb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_large_stack.c
> @@ -0,0 +1,377 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +/*
> + * Programs may use MAX_BPF_STACK_JIT (2 KiB) of stack on JITs that support
> + * large stacks, combined over a call chain, with no separate limit on a
> + * single frame. Interpreted programs and other JITs keep 512 bytes.
> + */

A subsystem pattern flags this as potentially concerning: Several tests
in this new file appear to be 2 KiB versions of tests that already
exist elsewhere in the same directory.

For instance, frame_2048_with_may_goto is the same program as
stack_check_size_512_with_may_goto_jit in verifier_stack_ptr.c
(r1 = r10; r1 += -512; r0 = 42; *(u32*)(r1 + 0) = r0; may_goto ...; exit),
with only -512 changed to -2048 and __load_if_JITed() changed to
__load_if_large_stack().

Similarly, single_frame_2048 / single_frame_2048_no_large_stack check
the single-frame boundary that verifier_stack_ptr.c already covers with
stack_check_size_gt_512 and the new stack_check_size_gt_2048 (fp-2056).

The var_off_write_to_2048/2056 tests check variable-offset stack bounds,
which verifier_var_off.c already covers (it gained
access_min_out_of_bound_large in the earlier patch in this series).

The private_stack_two_frames test follows verifier_private_stack.c's
"Private stack, subtree > MAX_BPF_STACK" test, including the same
__log_level(4) "stack depth max" / "subprog N (...) stack" messages.

The BPF selftests guide asks whether variants like these belong as new
cases in the existing files instead of a new file, especially since
the earlier patch in this series (2d0faaadf6a8) already places its
2 KiB versions next to the originals.

On the other hand, this new file does group tests for the 2 KiB stack
feature, and several behaviors (four 512-byte frames that fit, a tail
call from a 1 KiB frame, 1536-byte global subprogs and callbacks) cannot
occur under the 512-byte budget, so they have no existing counterpart.
Adding one verifier_<feature>.c file per feature is also common in BPF
selftests (verifier_private_stack.c is an example). Could you clarify
whether the overlap cases should be integrated into existing files, or
is a new file the intended organization here?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35909853278
--===============6040287993884596337==--
