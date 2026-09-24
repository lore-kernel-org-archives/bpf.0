Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC0B3E51DE
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241205; cv=none; b=PMU/94M8H0/YptDpYmZlNcowm2Xj3yGIs04KnacQ38WiYxujSTJlIsW92rY7pd5R1wlYy8JqD9eJjeEh4f6THpEkcFd+mflxFZAiG0c6BdATog/jKZJiCYhSbV1vPXxXThhXmCbQPYe4dvV+wlnSwuzJLbtkBZLk4QJe+XwHY7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241205; c=relaxed/simple;
	bh=AR9eEDftDgXMiP/bbz2YVNmywHy5Yxp+LYLAh4R6QOE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tDhbqB0sEZNXknFw4CwGkOFqITcUCbP34YnDz2ba4Du4Uej7jAruW1kwHl8guRUb9ae+Ykn0Doj6xvx9eV0xnxpCBh63uQboY2GccF5GOJJvBZpedgrkRr6o4BBQdw3if0AKkDLqAyVlg+O2wH9BnyTCRbtAzbV37z+hLZT18HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTS+MylF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTS+MylF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B260D1F00893;
	Thu, 24 Sep 2026 09:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790241203;
	bh=KIPUnQv2BH5VliI1DzCdr3m/eJXHRQeBDPTgZEJYImI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NTS+MylFDpXw4hRv0BIUwA1SgsBiGVluLBm9PvkzvdsQyfQe8sxPV8oy6ApOv9Xfe
	 OSNzubTo27rxRNkaqfKlbq3beP9RJ/BdpH4lHTikGCpvdLcXccEA94jFYQh7CjOq42
	 W6/hLzhcaoiCSvHRbL5mnAjDNsC5/uxSX9TSjAW0aigWIRVNCu69+kJ9qZS0ev7icA
	 I+mba9x3O54uER9grofXmDVossxOJDaudL+dZx2lxRgOWcTxo+QsA3VwItf00ugyTT
	 ybwv+X6RwhEQp8aHVvuhEgFJ6Ip4/2jXy0s0X628+9pwgONM789JeFE3pCnfgkJice
	 F4kn+RI6xM7xA==
Content-Type: multipart/mixed; boundary="===============5606410506558495473=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a0d61b61004d7351500248ef2a9e84ad6634dea366fe9bb15cd0a0887b301a82@mail.kernel.org>
In-Reply-To: <20260924082607.2695649-19-memxor@gmail.com>
References: <20260924082607.2695649-19-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 18/18] selftests/bpf: Test the 2 KiB stack budget
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 09:13:21 +0000 (UTC)

--===============5606410506558495473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

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
> +
> +SEC("socket")
> +__description("single frame of 2048 bytes")
> +__load_if_large_stack()
> +__success __success_unpriv __retval(42)
> +__naked void single_frame_2048(void)
> +{
> +	asm volatile ("					\
> +	r1 = r10;					\
> +	r1 += -2048;					\
> +	r0 = 42;					\
> +	*(u64*)(r1 + 0) = r0;				\
> +	r0 = *(u64*)(r1 + 0);				\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("single frame of 2048 bytes without large stack support")
> +__load_if_no_large_stack()
> +__failure __msg("invalid write to stack R1 off=-2048 size=8")
> +__naked void single_frame_2048_no_large_stack(void)
> +{
> +	asm volatile ("					\
> +	r0 = 0;						\
> +	exit;						\
> +"	::: __clobber_all);
> +}

Does the single_frame_2048_no_large_stack test body match its expected
failure message?

This test is meant to verify that a 2 KiB frame is rejected on systems
without large stack support (the interpreter, bpf_jit_enable=0, and JITs
without bpf_jit_supports_large_stack() like s390x, riscv64, loongarch,
and powerpc).

The test is marked __failure with the expected message "invalid write to
stack R1 off=-2048 size=8", but the test body is:

    r0 = 0;
    exit;

This 2-instruction program never touches fp-2048, so it verifies fine on
all configurations. The __failure annotation then causes
ASSERT_ERR(err, "unexpected_load_success") to trip in run_subtest() in
test_loader.c, failing the test on every configuration it targets.

Looking at single_frame_2048 above, the expected error message matches
this sequence:

    r1 = r10;
    r1 += -2048;
    r0 = 42;
    *(u64*)(r1 + 0) = r0;

Should single_frame_2048_no_large_stack repeat that write sequence so the
verifier rejects it with the expected message on systems without large
stack support?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35976322553
--===============5606410506558495473==--
