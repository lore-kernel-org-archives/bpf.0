Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137CC192B75
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776473552; cv=none; b=GFULofdbomMGKEtOXjaz2A1myJ4lgPm2MjSPwOK6LY0QsHE9aj0YU98mzosYjsYNlhyzCWlNOgOz4d80ES4CnMYthseQZEf+xmCdfuu0DOK57JcJbk0+celtyRoFEtV9U9q+DQvRFIRP0COBAhga9CYeMVUpSOzFcYXPVcDZobA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776473552; c=relaxed/simple;
	bh=ucXx9A33ld2k5JHJHOFLcct7aKg0ByaH7L4Iaf0iX8k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uAdOiUqrN1CqiIOEVXpALRVN92sG86QMMBE1U9hvbp4M0ZXnU3DkO7N2pejxhBvJ1cFw3I6St8xGSnz+tQAFGGSEP0ikXYW21IMtOSB8FPO9RNDtnF91IqizE0PdqjcRn8xWj48drY8T3GF48/XkrSEFcx9V0bbK1Ye45zxiMP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFLxDJVQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFLxDJVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A39C19425;
	Sat, 18 Apr 2026 00:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776473551;
	bh=ucXx9A33ld2k5JHJHOFLcct7aKg0ByaH7L4Iaf0iX8k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=rFLxDJVQlGMulcupXYuLnFZgsWdeq9RN7wt2hwU3A/+EliTeifK6cHsM8aGMinzVi
	 Hpv4KLX/9kvjA9URyQd8BoaOHga1H6aFVDyw4/QfJne9A1SRywXdY43lAcISwt7XQf
	 SH8f180T81+jgdEG7ZYCP6eIXBPgSoiSiL3yqI1H0cAi3I+U+ETk/nsEOFsHKANOgG
	 5ZxTSetVTG4gI4i1XzqxvKJMOTxHdV5UKo0ifFABSnQYBHMi63U4zSDv4py1pGo5g7
	 HmbNCK5Tz4OBaQ1QXTiBgEJfySR3j23E8RESBZqnlSRAb9PutieCNiwlHWQhOWwajr
	 +teFa4Iz1V7cg==
Content-Type: multipart/mixed; boundary="===============4289354194805889544=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d2b0749bcda92318766fe34d4df9492abd3990c2d8235a3fa552865206488b27@mail.kernel.org>
In-Reply-To: <20260417034833.2636781-1-yonghong.song@linux.dev>
References: <20260417034833.2636781-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 15/16] selftests/bpf: Add negative test for greater-than-8-byte kfunc stack argument
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 00:52:31 +0000 (UTC)

--===============4289354194805889544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/stack_arg_fail.c b/tools/testing/selftests/bpf/prog_tests/stack_arg_fail.c
> new file mode 100644
> index 000000000000..328a79edee45
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/stack_arg_fail.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <test_progs.h>
> +#include "stack_arg_fail.skel.h"
> +
> +void test_stack_arg_fail(void)
> +{
> +	struct stack_arg_fail *skel;
> +
> +	skel = stack_arg_fail__open();
> +	if (!ASSERT_OK_PTR(skel, "open"))
> +		return;
> +
> +	if (!skel->rodata->has_stack_arg) {
> +		test__skip();
> +		goto out;
> +	}
> +
> +	ASSERT_ERR(stack_arg_fail__load(skel), "load_should_fail");

Could this generic error assertion mask the actual verifier rejection reason?

If the program fails to load due to an unrelated issue, such as a missing
BTF, a syntax error, or the architecture-dependent size mismatch described
below, the test will incorrectly report success because it only checks that
the load operation failed.

Would it be better to refactor this test to use the standard test_loader
infrastructure (via RUN_TESTS) with __failure and __msg annotations in the
BPF program? That would ensure the rejection is explicitly due to the
argument size limit.

> +
> +out:
> +	stack_arg_fail__destroy(skel);
> +}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> index 2c1cb118f886..2a40f80b074a 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> @@ -50,6 +50,11 @@ struct prog_test_pass2 {
>  	} x;
>  };
>
> +struct prog_test_big_arg {
> +	long a;
> +	long b;
> +};

Does this structure achieve the intended >8 byte size on 32-bit architectures?

When the test kernel module is compiled on a 32-bit host, long is 32-bit,
making the struct exactly 8 bytes. Since the BPF target always treats long
as a 64-bit integer, this makes the struct 16 bytes in the BPF program.

This size discrepancy between the BPF program's BTF and the host kernel's
BTF might cause the verifier to reject the load for a BTF size mismatch
rather than the intended stack argument limit.

Could these fields use explicitly sized types like __u64 to ensure the
struct is consistently larger than 8 bytes across all architectures?

> +
>  struct prog_test_fail1 {
>  	void *p;
>  	int x;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24592562564
--===============4289354194805889544==--
