Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9258357D05
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730068; cv=none; b=HppDdb1WMe2JT2hIrjbwvg3cU+dufcBHKFc6EcGNl7js4WsUlFNp4k63L9mUCEVh2iozzzHFKk0TWXnE8JYskpjDYCnsMO+DCBv+OmDyMlsg2Hxl9sMvsuWfBa00uV8taSWASG5msfrPaQWoUZ2zGgL4akeyCKPMvj+hlkiY64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730068; c=relaxed/simple;
	bh=XHr26YbR+8q2IB9jcjsK88Naw2+hDa036POdEySTM3E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tcryqR1o/TFLrNbaomxYrgWUPHlLxZOLWEhrff6giTQSoD6wxAqLUSqwW3eE+GrxHakHquOWKFrZv2FM/9rmxqsvX/kSOFlKjYqP419BGi1I7J63/G6ZQgI8H6sMzWm7VYG69PQ2budthbGK14M4VBju4CWUiHh7iqYRWTu8L/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXWLcgBJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXWLcgBJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2741F000E9;
	Wed, 22 Jul 2026 14:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784730067;
	bh=ZMsajgC6zXwMsRoDIrNMk3I8tDgLUrMZ7hNbAXtwRJk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mXWLcgBJhfitnHQq+wd/02NlQ5BNeVRsIIpDU23HIyV0s5C8prJNVdds3mTx1U2Mq
	 e0yT78PGkrMugHBVgfcybwcXAee6adPFklsMamS+7VIqEMarn4QJf+iGTEufqeQLXx
	 wt0bQa2Z5okDthgrUTRB10Y6JDFCOYvwXTXmek0VkPyJoZkFAvRi9LRU1VER/oVnv7
	 Il/9KhiI3yzuv6dcji4Mrb+4krCtMs2gV54/M0jbck5dP/0FGdM9DMLDpZdOdfpDes
	 vyedEJJBPtdmHI8ofwMm91t0FXLQoxRCcgcHqL1H52XRa5Nw4E4QkHTt+VpEpQ/VmB
	 U0nAYTQ6ILRRQ==
Content-Type: multipart/mixed; boundary="===============7814437896302883275=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f26db5c771dcf922b819665bef8e798746451df2235c6267a9cb44bbb533ef3d@mail.kernel.org>
In-Reply-To: <20260722132424.450230-7-puranjay@kernel.org>
References: <20260722132424.450230-7-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v3 6/6] selftests/bpf: Add bpf_for() benchmark
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 22 Jul 2026 14:21:06 +0000 (UTC)

--===============7814437896302883275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/bpf_for_bench.c b/tools/testing/selftests/bpf/progs/bpf_for_bench.c
> new file mode 100644
> index 0000000000000..2752de5c44f57
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_for_bench.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +u32 nr_loops;
> +long hits;
> +
> +static int outer_loop(__u32 index, void *data)
> +{
> +	int i;
> +
> +	/*
> +	 * Empty body: the work being measured is the open-coded numeric iterator itself
> +	 * (bpf_iter_num_new/next/destroy behind bpf_for()).
> +	 */
> +	bpf_for(i, 0, nr_loops)
> +		;

An earlier question about this benchmark does not seem to have been
answered yet: how does the bpf_for() loop here compare with a regular for
loop that also reads its counter?

The current benchmark only exercises bpf_for(). Would it be worth adding a
regular-loop variant so the two can be compared directly?

> +	__sync_add_and_fetch(&hits, nr_loops);
> +	return 0;
> +}
> +
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> +int benchmark(void *ctx)
> +{
> +	bpf_loop(1000, outer_loop, NULL, 0);
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29924758865
--===============7814437896302883275==--
