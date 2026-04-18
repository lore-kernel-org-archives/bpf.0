Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32C122B8C5
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776536867; cv=none; b=CypoIA9Hu9CH87/dUBWVkfnl72Bf0oGpa28FYWWMZBAnUZPRM8LNS7m/gmSZTn81wwk0du40RuSLK/YYZNqbUa49kwrcx8aAy7UsFZ3Dv2g2e0Nwltmn9DBm05KpUecHinRBC5h5O4SvU5FmH7UpovjlakntKCcOPvcVd/AAgBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776536867; c=relaxed/simple;
	bh=Rwggko1OyTboeOutWkz5VnG0UiBdSrLndbby9jBW2Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3IF2WsbbvZZPsIxVFMzT1tVgY9o6NFju7TABdZAHfG8ZKySoa3dnYki/XpGQ2/wa+nrnRxdbR3+LKhzI+B+GMnx60ORBI9gfJzSA7N0TP3VYU/dqwmSYv6khQCa3jc2eVu141DnMqFf2K0qlJpvrzxV+Q79aVKieY3sFP6kqqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xwzAXXH2; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xwzAXXH2"
Message-ID: <b6171543-66a7-44e6-99f7-b45404c04fb8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776536863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/EJO18bNiswrOUZ8JysmSXdI1S/Xl4H2P/cPdOX1mw=;
	b=xwzAXXH2km0+/VXk9IytfpvMY+tXQcKAzC5KJNml1P9P6SxQ4F5S6dQ2xXC+No8HyuDSZW
	d81qfexfe3CPZqb+8HC0yIfsrh3FLlRgzWhjQhYA10cgcRai1h1colKQLwb6KeLTEP2u0K
	Yvx66FDcs2I9DO7Nen5Cxh8a32SgZ7Y=
Date: Sat, 18 Apr 2026 11:26:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 14/16] selftests/bpf: Add tests for BPF
 function stack arguments
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260417034828.2634626-1-yonghong.song@linux.dev>
 <b043233260f364926181102a9a5f5c5e0a8b339554403fe73f7518cf52d3a72a@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b043233260f364926181102a9a5f5c5e0a8b339554403fe73f7518cf52d3a72a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/17/26 5:52 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/stack_arg.c b/tools/testing/selftests/bpf/prog_tests/stack_arg.c
>> new file mode 100644
>> index 000000000000..130eaf1c4a78
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/stack_arg.c
>> @@ -0,0 +1,133 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +
>> +#include <test_progs.h>
>> +#include <network_helpers.h>
>> +#include "stack_arg.skel.h"
>> +#include "stack_arg_kfunc.skel.h"
>> +
>> +static void run_subtest(struct bpf_program *prog, int expected)
>> +{
>> +	int err, prog_fd;
>> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
>> +		.data_in = &pkt_v4,
>> +		.data_size_in = sizeof(pkt_v4),
>> +		.repeat = 1,
>> +	);
>> +
>> +	prog_fd = bpf_program__fd(prog);
>> +	err = bpf_prog_test_run_opts(prog_fd, &topts);
>> +	ASSERT_OK(err, "test_run");
>> +	ASSERT_EQ(topts.retval, expected, "retval");
>> +}
> [ ... ]
>
>> +static void test_async_cb_many(void)
>> +{
>> +	struct stack_arg *skel;
>> +
>> +	skel = stack_arg__open();
>> +	if (!ASSERT_OK_PTR(skel, "open"))
>> +		return;
>> +
>> +	if (!skel->rodata->has_stack_arg) {
>> +		test__skip();
>> +		goto out;
>> +	}
>> +
>> +	if (!ASSERT_OK(stack_arg__load(skel), "load"))
>> +		goto out;
>> +
>> +	run_subtest(skel->progs.test_async_cb_many_args, 0);
>> +
>> +out:
>> +	stack_arg__destroy(skel);
>> +}
> Does this test adequately verify the asynchronous timer callback
> execution and its result?
>
> Since run_subtest() only runs the program and asserts the return value
> is 0, the skeleton is immediately destroyed afterward. The timer
> callback might not have time to execute and could be canceled during map
> destruction.
>
> The result of the callback (timer_result) is never verified in
> userspace. Should there be a polling loop waiting for the timer to fire,
> followed by an assertion checking that skel->bss->timer_result == 360?

Okay, the timer test is incomplete. Let me add more meet to actually get
a timer result.

>
> Reference: https://lore.kernel.org/bpf/20260417042017.CF065C19425@smtp.kernel.org/
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24592562564

