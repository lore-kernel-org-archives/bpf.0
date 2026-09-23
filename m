Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B01430CD7
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 05:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142709; cv=none; b=FuvGTyYkdAvfPS7m8ujmWdB5apyWCQhOQN+CqD2Kw6fY9pMtZESL0gvzuUPCLFtRoNczhYZtc35MTKWGMSlXzTYbWtF0yc+oo87Ur2R+RlFa5hIVzifZVbEoPI2en59Iqxp0uK9BB9UV47C/E7k9rNw1/WIz6O2UD1rzKtWt2gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142709; c=relaxed/simple;
	bh=7vFckdyUCcdgTyNmdZvGqt465SFLr1D+1xKqNNg1yKY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XkRV7s155c2A21fAGhMjnF5qQyktK2B8KFrHRtcNfRST4wgMjJKUqvJ/EdOIZp/ku+gwAChEJOYReIuV3K9vU4LgvTtL+d77uxq5mVVLtfG8yKkWRv61aEhr+JsSEnCiAGBhKifhh53ZKjCWWnyLVPxP2AoPW0nwu9nFC38hWFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqE+XCcM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqE+XCcM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B416A1F000FF;
	Wed, 23 Sep 2026 05:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790142708;
	bh=TKXNmpDSeN1emkpa0ceJqSgLRfAlHkxb4jqeXl3YnL4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XqE+XCcMXObTYdkWPvt7+L4Vk+qdU0JmZNnTJxyI4KaqajCx5Wqsd73OcWG6xwJOf
	 0nAxd4z72CxyrZhcii0AfL6LX+LrZEtq4BAWPXUl9DvJMnyszZhvWFkmrMLbLtQ410
	 asxoHB/0SugmrpIdgU4fYn9rstorVyqvFPsPPcA3J6h2F3xLeelG9+Hla4Y6VEU/CS
	 dUtH/G/3JDgnCLdRjPQr2QSJgzLBKLMhdGNVDjXzXGwfZa7E+1JfVfCnU0/YfVyXvE
	 /xT7nEHv/vIGePsNCZXkDT9jQTJLiLUV7n5FeJEHm/1OGSOxyN+TaIvUvlDCauir8m
	 yVkfwRGBbl4sw==
Content-Type: multipart/mixed; boundary="===============7831695193927161975=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d9f9a35916076ca4b8c4d1449a2ec8775d86acc89835fb785433c824afdf9a4a@mail.kernel.org>
In-Reply-To: <20260923050024.2427021-1-yonghong.song@linux.dev>
References: <20260923050024.2427021-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 19/21] selftests/bpf: Add an end-to-end .bpf_cleanup exception test
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 05:51:46 +0000 (UTC)

--===============7831695193927161975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> new file mode 100644
> index 000000000000..d9823023ec04
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c

[ ... ]

> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include "exceptions_cleanup.h"
> +#include "exceptions_cleanup.skel.h"
> +#include "exceptions_cleanup_fail.skel.h"
> +
> +/* foo3 threw: every frame that has a pad ran it. */
> +#define PADS_FOO3_THREW \
> +	(RAN_FOO3_PREEMPT | RAN_FOO2_RCU | RAN_FOO1V_PREEMPT | RAN_FOO2_DROP)
> +
> +/* foo2 threw after foo3 returned normally: foo3's pad must not run. */
> +#define PADS_FOO2_THREW \
> +	(RAN_FOO2_RCU | RAN_FOO1V_PREEMPT | RAN_FOO2_DROP)

[ ... ]

> +/*
> + * A table with more records than the program has instructions: no valid one
> + * can look like that, and it is refused before the kernel allocates for it.
> + */
> +static void test_cleanup_info_cnt(void)
> +{
> +	struct bpf_insn insns[] = {
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	struct bpf_cleanup_info rec = {
> +		.begin_off = 0,
> +		.end_off = 1,
> +		.landing_pad_off = 1,
> +	};
> +	char log[512] = {};
> +
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts,
> +		    .log_buf = log,
> +		    .log_size = sizeof(log),
> +		    .log_level = 1,
> +		    .cleanup_info = &rec,
> +		    .cleanup_info_cnt = 1 << 20,
> +		    .cleanup_info_rec_size = sizeof(rec));
> +	int fd;
> +
> +	fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
> +			   insns, ARRAY_SIZE(insns), &opts);
> +	if (!ASSERT_LT(fd, 0, "load")) {
> +		close(fd);
> +		return;
> +	}
> +	/*
> +	 * Turned away on the count, rather than on whatever the records past
> +	 * the one below happen to hold.
> +	 */
> +	ASSERT_HAS_SUBSTR(log, "cleanup info has 1048576 records for 2 instructions",
> +			  "log");
> +}

Does the comment point in the right direction? It says "the one below"
but the single supplied record 'rec' is declared roughly twenty lines
above this comment, not below it. Should this read "above" instead of
"below", or name 'rec' directly?

The substance is correct - check_cleanup_info() rejects on the count
before reading past the first record - only the direction word seems
inverted.

> +
> +void test_exceptions_cleanup(void)
> +{
> +	char log[8192] = {};
> +
> +	LIBBPF_OPTS(bpf_object_open_opts, opts,
> +		    .kernel_log_buf = log,
> +		    .kernel_log_size = sizeof(log));
> +	struct exceptions_cleanup *skel;
> +	int err;
> +
> +	skel = exceptions_cleanup__open_opts(&opts);
> +	if (!ASSERT_OK_PTR(skel, "open"))
> +		return;
> +
> +	err = exceptions_cleanup__load(skel);
> +	if (err) {
> +		if (err == -EOPNOTSUPP &&
> +		    strstr(log, "exception cleanup needs a JIT that can dispatch landing pads")) {
> +			printf("%s:SKIP:JIT cannot dispatch exception cleanup landing pads\n",
> +			       __func__);
> +			test__skip();
> +		} else if (!ASSERT_OK(err, "load")) {
> +			fprintf(stderr, "%s", log);
> +		}
> +		exceptions_cleanup__destroy(skel);
> +		return;
> +	}

Is the cleanup_info_cnt subtest reachable on architectures whose JIT
cannot dispatch landing pads?

The skip path here returns immediately after destroying the skeleton,
which means the code after this block never runs, including:

    if (test__start_subtest("cleanup_info_cnt"))
        test_cleanup_info_cnt();

bpf_jit_supports_cleanup_pads() is only implemented on x86 and arm64;
everywhere else the __weak stub returns false. When that happens
exceptions_cleanup__load() returns -EOPNOTSUPP, the test calls
test__skip() and returns early, skipping everything below.

test_cleanup_info_cnt() only exercises the UAPI count check in
check_cleanup_info(), which runs from bpf_check_btf_info() before
bpf_prepare_cleanup_exceptions() and therefore never reaches the JIT
gate. It loads its own 2-instruction BPF_PROG_TYPE_SOCKET_FILTER program
and would pass on any architecture.

Could test_cleanup_info_cnt() run before the skeleton load, or could
the skip path fall through to it, so the UAPI validation stays covered
on non-x86/arm64 builds?

> +
> +	/* No throw: foo3 returns 1 ^ 1 == 0, foo2 adds one, no pad runs. */
> +	if (test__start_subtest("no_throw"))
> +		run(skel, 1, 1, 0);
> +
> +	/* foo3 throws; every pad runs and the cookie is delivered at entry. */
> +	if (test__start_subtest("throw_from_foo3"))
> +		run(skel, 101, THROW_COOKIE, PADS_FOO3_THREW);
> +
> +	/*
> +	 * foo3 returns 2 ^ 1 == 3, so foo2 throws from its own second region;
> +	 * foo3's frame is long gone, so its pad must not run.
> +	 */
> +	if (test__start_subtest("throw_from_foo2"))
> +		run(skel, 2, THROW_COOKIE, PADS_FOO2_THREW);
> +
> +	exceptions_cleanup__destroy(skel);
> +
> +	RUN_TESTS(exceptions_cleanup_fail);
> +
> +	if (test__start_subtest("cleanup_info_cnt"))
> +		test_cleanup_info_cnt();
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35821138073
--===============7831695193927161975==--
