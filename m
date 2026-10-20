Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792473015;
	b=QmuzjAppZ2EJfcV1jgywUsd88NGCchwPtPc4SvcZ6DqKLDVmUx/iWa8LNwM3MclRDvo6
	 q2Av0eXHBGgI1TiCE9ozlRxhWQMN7IrOFldYNDTJO9wZdoRqH6tBMwdURadQdBygwZMEb
	 m7BLxIbSK58xfg9lI3MQG2BKU5oCn717Ij5QeNEXxGX/e+jW02GUWYOmBo6TVo/GwUC1t
	 XzkSKcuarcNA74OekqDc53xDqrnk1VSONwlSO6AfiVxca0XdVfvEfDjN+s0E0cpTgjfpK
	 PRQwyDDqUZWZAAohgehUXu4Z2Mn4miCGr5PANShAHQIxsLpLrVVgs9VXMqGJgGyvMIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792473015;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=5qu38fsmlob6Tfel9iNVBfGAvFC0q+82bqHk7Ra3cmA=;
	b=K8Ukkzb62oSdYzs6UhR5+eR7nDXnkllXMyJerJzRsHgZ901vncvpC8QCQvHcre1znEma
	 l93ATxm/JNSqBpdI4l1Nr4sdX09ZpX9JkbA7g9ZZ7duoqoys7/eSx8/sRYN+t3dS0AQsr
	 mqVkB7zSu2GULlQZfTELSe70SMXOsvrKPELOA28GQkDrZbfmTpvdCD2y5iBaRP+8C7Gtu
	 H83nctut32YZ8Xko6tsYfR5NQnwZnpbzVQuSEmnv4ORd2rQx6aiZUt6kLTB69ryvQ480A
	 iZwGDrqdIQMjCZA2TnuI7E2GqnVN4xlLWRRxvkzUH2R1pYlsw0YW6ZpmkSyNx8t5HDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lAejuSRj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B562606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 05:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lAejuSRj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD1B1F000C4;
	Tue, 20 Oct 2026 05:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792473014;
	bh=5qu38fsmlob6Tfel9iNVBfGAvFC0q+82bqHk7Ra3cmA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lAejuSRjBF1R/qNEotPs7HJ00F4cbriCha3Kw6sl3vqBKbBCuw1hpv307fTMq6p28
	 xKPlW8GcN6JPGm2mYvM9Bsh79VFlGTllhALDMSz1wlrgaS/qtwalqQ2/KxCEtMpZQi
	 SpsATOqlHKjccx/4nXEno9LDluQewNbW1TJveNJohH9Sa54fGII7a9jCpjXmffmVi6
	 UZoHphONRbnTy3nAoADSWtYFw1SHBvtDy5eylYf3/X/Yy2ZtVva1pO/B9eZgg7nMyZ
	 TSwNRzmNCRR2NQjnd/I9F5sJHI/velnBcdcv0XB/MYZfHwNc7Si9rqlMXKE01dukZQ
	 RNqDN97aY4zQA==
Content-Type: multipart/mixed; boundary="===============0226481484572988726=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <cd7e834abfbe945a34f9375671b24e0465b5e3e67350169207e6fb2c4b5f0946@mail.kernel.org>
In-Reply-To: <20261020043319.3031996-5-alexei.starovoitov@gmail.com>
References: <20261020043319.3031996-5-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/6] selftests/bpf: Add tests for unwind_goto and unwind_exit
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 05:10:14 +0000 (UTC)

--===============0226481484572988726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add tests for unwind_goto and unwind_exit

TL;DR: Test issue: test_unwind_attach() may report a failure instead of
skipping when the JIT is disabled, because load returns -EINVAL; it likely
should check is_jit_enabled() first. Impact may be limited to interpreter-only
setups.

> diff --git a/tools/testing/selftests/bpf/prog_tests/unwind_attach.c b/tools/testing/selftests/bpf/prog_tests/unwind_attach.c
> new file mode 100644
> index 000000000000..92eab5b77f62
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/unwind_attach.c
> @@ -0,0 +1,111 @@

[ ... ]

> +void test_unwind_attach(void)
> +{
> +	struct verifier_unwind *tgt;
> +	struct bpf_program *prog;
> +	int tgt_fd, plain_fd, err;
> +
> +	tgt = verifier_unwind__open();
> +	if (!ASSERT_OK_PTR(tgt, "verifier_unwind__open"))
> +		return;
> +	bpf_object__for_each_program(prog, tgt->obj)
> +		bpf_program__set_autoload(prog, prog == tgt->progs.calls_global_unwinds ||
> +						prog == tgt->progs.calls_global_never_unwinds);
> +	err = verifier_unwind__load(tgt);
> +	if (err == -ENOTSUPP) {
> +		printf("%s:SKIP:JIT does not support unwinding\n", __func__);
> +		test__skip();
> +		goto out;
> +	}
> +	if (!ASSERT_OK(err, "verifier_unwind__load"))
> +		goto out;

A subsystem pattern flags this as potentially concerning: a test that fails
on a missing prerequisite instead of skipping.  Here the test skips only on
-ENOTSUPP, which is what the verifier returns when the arch JIT has no unwind
support.

What happens on x86-64 or arm64 when the JIT is turned off
(CONFIG_BPF_JIT_ALWAYS_ON=n and net.core.bpf_jit_enable=0)?
bpf_jit_supports_unwind() still returns true there, so check_unwind_insns()
sets prog->jit_required, and fixup_call_args() then rejects the program:

  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
  	if (prog->jit_required) {
  		verbose(env, "program requires BPF JIT compiler but it is not available\n");
  		return -EINVAL;
  	}

verifier_unwind__load() would return -EINVAL in that case, and
ASSERT_OK(err, "verifier_unwind__load") reports a failure rather than a
skip.

The verifier_unwind programs added in the same commit use __load_if_JITed()
for this situation.  Other prog_tests that need the JIT (callx_func_ptr_map.c,
callx_rodata_lskel.c, arena_scalar_blinded.c) check is_jit_enabled() first
and call test__skip().

Should test_unwind_attach() check is_jit_enabled() before loading and skip
when the JIT is off?

For context on the other side of this: the errno in the JIT-off case is
-EINVAL rather than a capability-absent value such as -EOPNOTSUPP, so this
matches the intent of the guideline more than its literal wording.  The
practical impact may be limited to interpreter-only setups, since the
fentry and freplace attach tests also need a JITed target and fail without
the JIT.  The case of an arch with no unwind support is handled correctly:
-ENOTSUPP is passed through by libbpf and the test skips with a reason.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39371273420
--===============0226481484572988726==--
