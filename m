Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C203093DB
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209926; cv=none; b=LxVidra5epn+K8jnKiDXG9vfYd9aFTM5ABkTOmv6W7/WM4Vxd2PEQaEOGdiNw+A8X8BnUrAA3xK8jrZlmni9y6hZCPcDcA3J8o+dV94Wfpw6RxhfsE09Zkl8Oct1WkLWtUgvJd/3AiKkC71gJ78ChaHhkjQ+UaAtjH3IrlWzVzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209926; c=relaxed/simple;
	bh=JMjMhzrGJNzulWTYzurKPfcPysXg8NXSOjPbDHMc2lc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XbeKGSJ7sZoViP0QmnXbTNEf/zOlKws3rCi93GPtEBZEOthbRIxKUXea3rTXl15y/keoQI7udCv9qHrZ7yxYgNpsfh9q/cjP3PBkMUiiFyiR8jHixEIDXDYmLrfrY/tkQ6IVTwMkBZ7Dw02xOf5Rhzqv5ARM5Vkpwl+gAeHh8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRn+W+rn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRn+W+rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9F91F000FF;
	Thu, 24 Sep 2026 00:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209922;
	bh=3kS3LL69J02Hu6pkz5FqNDzbsZOrv8jT/+2moN0S7S4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WRn+W+rnuJmFE7+/1hlJPlxcOTlDd2RZHXV7y6oeRqf+XJjGAvNtfa4hk7L2X7pY7
	 HLRznPUa5BQ57/VV8njc6zTFxC4oYMNcGUBM+VON/7BSIfalpCPM3JXQDuC/qOkS8N
	 pSZEeiulgu8bsQdRK418oLZMfnLGlarzbqnCqyjJLQfw/cFJ3USGUfDsBfv5Xj/ezP
	 Z4SlCkAgOw4EZqWRYRBXuyTjJjZHych3x/y3adyzU4t64xX+oPLdVl9fU0obzuEWEq
	 w8FlgoSQG1bm7L4itk8T9cSmyrsm4P6i2j0f+fqcXdWr5FTconZ4PmEoa1F3j7P/AQ
	 mz6ep7s/xgA+g==
Content-Type: multipart/mixed; boundary="===============7337976780103712970=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <97ef66899ca20e1db5a05613ac522f8a1e48aa208de9d371e73fb8cae4ec81fb@mail.kernel.org>
In-Reply-To: <20260923232939.1886328-8-andrey.grodzovsky@crowdstrike.com>
References: <20260923232939.1886328-8-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v5 7/8] selftests/bpf: Cover BPF program manual loading
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org,ast@kernel.org
Cc: martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 00:32:01 +0000 (UTC)

--===============7337976780103712970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/dynamicload.c b/tools/testing/selftests/bpf/prog_tests/dynamicload.c
> new file mode 100644
> index 0000000000000..eaaa3e8bd54af
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/dynamicload.c
> @@ -0,0 +1,365 @@

[ ... ]

> +/*
> + * prog4 is marked SEC("!...") in the source instead of being set
> + * imperatively; verify that an explicit bpf_program__set_load_strategy() call
> + * before load overrides the declarative default.
> + */
> +static void dynamicload_verify_override(void)
> +{
> +	struct test_dynamicload *skel;
> +	int err;
> +
> +	skel = test_dynamicload__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	err = bpf_program__set_load_strategy(skel->progs.prog4, BPF_PROG_LOAD_STRATEGY_DISABLED);
> +	if (!ASSERT_OK(err, "set_load_strategy_disabled"))
> +		goto cleanup;
> +
> +	if (!ASSERT_EQ(bpf_program__load_strategy(skel->progs.prog4),
> +		       BPF_PROG_LOAD_STRATEGY_DISABLED, "prog4_load_strategy_overridden"))
> +		goto cleanup;
> +
> +	/*
> +	 * disable prog1/prog3 (also autoload by default) so this load only
> +	 * has to succeed for prog2 and the disabled prog4; prog2 loading is
> +	 * irrelevant to the assertion below and is left alone
> +	 */
> +	err = bpf_program__set_load_strategy(skel->progs.prog1, BPF_PROG_LOAD_STRATEGY_DISABLED);
> +	if (!ASSERT_OK(err, "set_load_strategy_disabled_prog1"))
> +		goto cleanup;
> +	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_DISABLED);
> +	if (!ASSERT_OK(err, "set_load_strategy_disabled_prog3"))
> +		goto cleanup;
> +
> +	err = test_dynamicload__load(skel);
> +	if (!ASSERT_OK(err, "skel_load"))
> +		goto cleanup;
> +
> +	/*
> +	 * prog4 was overridden to DISABLED, so its load_strategy != MANUAL
> +	 * and load() must reject it
> +	 */
> +	err = bpf_program__load(skel->progs.prog4);
> +	ASSERT_ERR(err, "load_after_override");

Does this negative assertion actually test that bpf_program__load() checks
the load strategy?

prog4 is DISABLED by the time test_dynamicload__load() runs, so
bpf_object__relocate() skips it:

    if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
        continue;

That leaves prog4's ld_imm64 instruction for the .bss variable
prog4_called unrelocated.

Suppose the strategy check in bpf_program__load() were missing:

    /* this check is what the test wants to verify */
    if (prog->load_strategy != BPF_PROG_LOAD_STRATEGY_MANUAL)
        return -EINVAL;

bpf_object_load_prog() would send the unrelocated instructions to the
kernel. The verifier would reject the store through a scalar pointer
with -EACCES:

    ; prog4_called = true;
    R0 w= 1
    (*u32 *)(r0 + 0) = r0;  /* r0 has not been relocated to the .bss map */
    R0 invalid mem access 'scalar'

ASSERT_ERR(err, ...) would still pass, since -EACCES is an error.

The subtest also never checks that the bulk load skipped prog4. If
bpf_object__load_progs() loaded it anyway, bpf_program__load() would
return -EINVAL from the strategy check, and nothing looks at
bpf_program__fd(prog4).

The other rejection checks in this file have the same issue.
dynamicload_verify_main_cycle's load_disabled check uses a DISABLED,
unrelocated prog1, and load_autoload returns -EBUSY because prog2 is
already loaded rather than because of the strategy check.

Would asserting the specific errno make the test discriminate?

    ASSERT_EQ(err, -EINVAL, "load_after_override");

A missing strategy check would then give -EACCES from the verifier
instead of -EINVAL.

Also, could the test add this after test_dynamicload__load():

    ASSERT_LT(bpf_program__fd(skel->progs.prog4), 0, ...);

to verify that the bulk load actually skipped prog4?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35934836796
--===============7337976780103712970==--
