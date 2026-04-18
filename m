Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A957325F7B9
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 00:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776473563; cv=none; b=DdzfTbsEcFWEnpKn5Xu7pa0wFABr/7SrfjczC7PVxIC9Z9YsF/jUN8dHxIL+OoN2R/tZTvEwyJ16ngilYpIT7jkrZsi4AWU8l4sXUhvO8pK/jR5dXs6MTKTROX0aFS5+t2a1Fyg8TMTegR46TE5j4PkTJhr4cGfBSOS3LrgmMPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776473563; c=relaxed/simple;
	bh=u4bjoRcq/QS2V13LLlLq9zIXovwMkj3JVZY+BjaOjt8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=di3xki3kGOCNlYF2bwFz2fIYskHR3vLzlO7d1NpwWymKxJDwYsF1DjFHJuF+huZLATuQYcrutzBCDuab+cmI9VozE7WttzzrKqaZaRZk+u5iUqhwHC5JKrQscB8uOixkNgGA0f6iiHYf6PwyZ/bD3LTgEFqRzD3F4kI4TIfzmVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJQCfpUT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJQCfpUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2452BC19425;
	Sat, 18 Apr 2026 00:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776473563;
	bh=u4bjoRcq/QS2V13LLlLq9zIXovwMkj3JVZY+BjaOjt8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=LJQCfpUTBVxgYS1m39q1sQLDS8Cu0LlCZSXXf53zLn42KeaMY8mC34FUPhUH36eLI
	 Wo0d/RbhppL38Rgb7n5DwO82q7+H6U/NILTRyOPLaPvqxaskA6HFGvUXCezonTEidc
	 dfqAWHd32ekK+6Z2P9gPe7fFY7Y+H18P/esbDatZFn3nBJvmBSi0vb7YFvRO7MGld2
	 4wwPpJFDn43oPNtwhcq/pdF0vkEO0YNhbeJtwEE7SU9wvqHXnB2jvoFbeeI1WQfziO
	 omTA96T0P7mB5hg92MkI2SaHkfukG0KjgxUm4UNqcbzbMqGVkM2dFxVU1GEZVbe5jX
	 KO0GeDVxo7fIg==
Content-Type: multipart/mixed; boundary="===============9051206681955690236=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b043233260f364926181102a9a5f5c5e0a8b339554403fe73f7518cf52d3a72a@mail.kernel.org>
In-Reply-To: <20260417034828.2634626-1-yonghong.song@linux.dev>
References: <20260417034828.2634626-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 14/16] selftests/bpf: Add tests for BPF function stack arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 00:52:43 +0000 (UTC)

--===============9051206681955690236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/stack_arg.c b/tools/testing/selftests/bpf/prog_tests/stack_arg.c
> new file mode 100644
> index 000000000000..130eaf1c4a78
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/stack_arg.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include "stack_arg.skel.h"
> +#include "stack_arg_kfunc.skel.h"
> +
> +static void run_subtest(struct bpf_program *prog, int expected)
> +{
> +	int err, prog_fd;
> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> +		.data_in = &pkt_v4,
> +		.data_size_in = sizeof(pkt_v4),
> +		.repeat = 1,
> +	);
> +
> +	prog_fd = bpf_program__fd(prog);
> +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> +	ASSERT_OK(err, "test_run");
> +	ASSERT_EQ(topts.retval, expected, "retval");
> +}

[ ... ]

> +static void test_async_cb_many(void)
> +{
> +	struct stack_arg *skel;
> +
> +	skel = stack_arg__open();
> +	if (!ASSERT_OK_PTR(skel, "open"))
> +		return;
> +
> +	if (!skel->rodata->has_stack_arg) {
> +		test__skip();
> +		goto out;
> +	}
> +
> +	if (!ASSERT_OK(stack_arg__load(skel), "load"))
> +		goto out;
> +
> +	run_subtest(skel->progs.test_async_cb_many_args, 0);
> +
> +out:
> +	stack_arg__destroy(skel);
> +}

Does this test adequately verify the asynchronous timer callback
execution and its result?

Since run_subtest() only runs the program and asserts the return value
is 0, the skeleton is immediately destroyed afterward. The timer
callback might not have time to execute and could be canceled during map
destruction.

The result of the callback (timer_result) is never verified in
userspace. Should there be a polling loop waiting for the timer to fire,
followed by an assertion checking that skel->bss->timer_result == 360?

Reference: https://lore.kernel.org/bpf/20260417042017.CF065C19425@smtp.kernel.org/

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24592562564
--===============9051206681955690236==--
