Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D090582BBB
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194386; cv=none; b=Vfhpp/QFNnUQhlD13TVXBVdlAp90I7z1/YcMQiI2E09O5jBXwT2mBf+euxg2YOE5i5GbG2IfL+aZ10R5AkdTE2tXoJMveGG6xkjjZUwlNK0PPOBZj82O77b3DCS9KEaVrCzyTD+E17dE2y/sSNuMX7Yz9XMVT55z4y+Lug3POdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194386; c=relaxed/simple;
	bh=XM4Ckcrcalte6iKpNpQcinlCvH+g3+ozvDaC9n9jexQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FTgaM8a2JYrPS7jS6QAww7LDCtjIOaftpbO+6Vm7dISwsFhekzFuzUNqo/EJPGGZM0BgT+JFa72F14cLmYTM7w0+mNG//ZCMHTL9ic69L0h1575uDSi+Hj4og3g/C7IxELZPzjJsrriWqJOCiG/wQmsfyE51qMnZZfaxeY6e+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT1sjmf9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT1sjmf9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAA11F0089C;
	Wed, 23 Sep 2026 20:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790194366;
	bh=uI/slZQRta1FwEl3bwy9TImffXABPcSDupFW9Saox/I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AT1sjmf9hJXrahbfyCnpMM2WnnJW1iX7mEGx8NtSALZVnXejwSyzAiBZt/sp3mRal
	 02QvnRut+0jgvxts3VxkyPc8JzlpAqWnBpCk7D+B327IAFLGOXYsyVTFjvFyFlY3a5
	 ONL49b+S0SqUaZdu/TMsA4BfeVHIQFvP4fe7vgEhX84diDi5L7sb5gUL+gkt1dXo51
	 QNnPyfdU4j5a6KYMDTNLEjDN5gL65or7UYqJ3tyxR6Um6XvTVPuEXkYpim8Y+Z51vT
	 QULrQkAgfGRZorkm7kopFkIdD3svE+ii1BtQgQl1eC0wPRittJHsUOx0YTd4WqdbZl
	 S1dnQ8x35QiAA==
Content-Type: multipart/mixed; boundary="===============6570378435790506242=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <28a022f0799e2e49ed8bc3df23a3cefe6aa25ace227b4bd0e3fe35fd7d1a7f9b@mail.kernel.org>
In-Reply-To: <20260923191139.2816206-15-memxor@gmail.com>
References: <20260923191139.2816206-15-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 14/18] selftests/bpf: Add load conditions on the program stack limit
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 20:12:45 +0000 (UTC)

--===============6570378435790506242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index 2ced1d751ace..f3dbc3b59bff 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -175,6 +175,9 @@
>  #define __prepare_priv		__test_tag("test_prepare_priv")
>  #define __load_if_JITed()	__test_tag("load_mode=jited")
>  #define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
> +/* Whether programs may use more than 512 bytes of stack on this kernel and JIT */
> +#define __load_if_large_stack()		__test_tag("stack_mode=large")
> +#define __load_if_no_large_stack()	__test_tag("stack_mode=small")
>  #define __stderr(msg)		__test_tag("test_expect_stderr=" msg)
>  #define __stderr_unpriv(msg)	__test_tag("test_expect_stderr_unpriv=" msg)
>  #define __stdout(msg)		__test_tag("test_expect_stdout=" msg)
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index a6e3fcc1079c..25eeb1c1248b 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c

[ ... ]

> @@ -1331,6 +1349,7 @@ void run_subtest(struct test_loader *tester,
>  {
>  	struct test_subspec *subspec = unpriv ? &spec->unpriv : &spec->priv;
>  	int current_runtime = is_jit_enabled() ? JITED : NO_JITED;
> +	int current_stack = is_large_stack_supported() ? LARGE_STACK : SMALL_STACK;
>  	struct bpf_program *tprog = NULL, *tprog_iter;
>  	struct bpf_link *link, *links[32] = {};
>  	struct test_spec *spec_iter;

[ ... ]

> @@ -1360,6 +1379,11 @@ void run_subtest(struct test_loader *tester,
>  		return;
>  	}
>
> +	if ((current_stack & spec->stack_mask) == 0) {
> +		test__skip();
> +		return;
> +	}
> +

A subsystem pattern flags this as potentially concerning: the new
stack-limit load condition skips the subtest with a bare test__skip() that
prints no reason. When a user sees a verifier_large_stack or
verifier_stack_ptr subtest reported as SKIP, they get no hint whether it
was skipped because is_large_stack_supported() found the 2 KiB budget
missing or present.

This matters more because the probe can also fall back to "assuming 512
bytes" when it fails for an unrelated reason. That fallback message goes to
stderr before test__start_subtest_with_desc() runs, so it is not attached
to the subtest that gets skipped.

Does the skip need a message like the existing skip_reason and
jited-disassembly skips in run_subtest do? Or is it acceptable for these
stack-mode skips to match the arch_mask and load_mask pattern right above
this check, which also skip without a message?

> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
> index d1d60451c5bc..47fe61a1ebff 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c
> @@ -517,6 +517,47 @@ bool is_jit_enabled(void)
>  	return enabled;
>  }
>
> +/*
> + * Whether the kernel accepts a program using more than 512 bytes of stack,
> + * which depends on the JIT in use. Probed once with a program that stores
> + * at the 2 KiB depth. Only the verifier's verdict on that store is cached:
> + * a load that fails for another reason, such as a missing capability, is
> + * reported and probed again on the next call.
> + */
> +bool is_large_stack_supported(void)
> +{
> +	static int supported = -1;
> +	struct bpf_insn insns[] = {
> +		BPF_ST_MEM(BPF_DW, BPF_REG_10, -2048, 0),
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	char log[1024] = {};
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts,
> +		.log_buf = log,
> +		.log_size = sizeof(log),
> +		.log_level = 1,
> +	);
> +	int fd;
> +
> +	if (supported >= 0)
> +		return supported;
> +
> +	fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, ARRAY_SIZE(insns),
> +			   &opts);
> +	if (fd >= 0) {
> +		close(fd);
> +		supported = 1;
> +	} else if (strstr(log, "invalid write to stack")) {
> +		supported = 0;
> +	} else {
> +		fprintf(stderr, "%s: probe failed with errno %d, assuming 512 bytes:\n%s",
> +			__func__, errno, log);
> +		return false;
> +	}
> +	return supported;
> +}
> +

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35909853278
--===============6570378435790506242==--
