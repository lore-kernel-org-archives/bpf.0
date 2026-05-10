Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51857083C
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778434103; cv=none; b=UfliH2awu/9mdMaUGBakZ9wXz+UTkrTJtV51jT3Vkx0pKnMbvsaIx2sxUJ0ZY0Vy7rpOaI+IF2CTm86pkVo444K0tf65mI1b3xqH4hHNsV83UztDw6zk3Q8/iR3d7TZ2fnf265pfjpIDkx/vLb3ahBJA+uJXjRXMat21h34hXlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778434103; c=relaxed/simple;
	bh=UMi6FTQub2XT1SuvH/Q5k3dGJp7KQt5/wTk0uPhO22I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Br9PHcDlpJw/JtRhoqRtdkV98qjVZYr6F03rTYu5coxW0D7YdblR/xZyJ2oTs6dkk6zTnUignI0RlMGqQbgOJq9zysLF27ybGcOamXVZQLEIWpZT3DqTim9+wPayBQaa/Rb7a6hQvo5JcBM1dAYGKUUcod8iFqIKCPZza4cwzsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SxPa35PK; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SxPa35PK"
Message-ID: <5c09f378-07d3-4e3d-8eb2-f71f0a666f0b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778434090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtsGMmViYw5F7GkAbmCWVSQ6BgqkVr149RoWoECBLdQ=;
	b=SxPa35PKD/uATaGJC78zKZBH+bRcY0mqnxCplkcb7LKzq1twEagrjFPicueRVswtPoDBhR
	P/KlWZWQ0/CEVaGLCqwI0gZh102Z0LD9qpcl31MCdwvtEQgInleBcZRNM+Ohuc5IGL+xQs
	nYq7puk/iEoMGuodslzjCevIRswCJh8=
Date: Sun, 10 May 2026 10:27:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 19/23] selftests/bpf: Add verifier tests for
 stack argument validation
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260507213145.1139004-1-yonghong.song@linux.dev>
 <20260509013809.18E7DC2BCB0@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260509013809.18E7DC2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/9/26 3:38 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The tests in `verifier_stack_arg_order.c` are never executed because the file is not registered in the selftests runner.
> --
>
> commit 6834becc44d439e99d840e596d30164699006d53
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Add verifier tests for stack argument validation
>
> This commit adds new BPF selftests using inline assembly to validate the
> verifier's logic for stack arguments. It covers positive tests and various
> negative tests for verifier rejection and pointer/reference tracking.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
>> index a96b25ebff234..aef21cf2987be 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
>> @@ -91,6 +91,7 @@
>>   #include "verifier_sockmap_mutate.skel.h"
>>   #include "verifier_spill_fill.skel.h"
>>   #include "verifier_spin_lock.skel.h"
>> +#include "verifier_stack_arg.skel.h"
> Did you intend to include verifier_stack_arg_order.skel.h here as well?

Yes.

>
>>   #include "verifier_stack_ptr.skel.h"
>>   #include "verifier_store_release.skel.h"
>>   #include "verifier_subprog_precision.skel.h"
>> @@ -238,6 +239,7 @@ void test_verifier_sock_addr(void)            { RUN(verifier_sock_addr); }
>>   void test_verifier_sockmap_mutate(void)       { RUN(verifier_sockmap_mutate); }
>>   void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
>>   void test_verifier_spin_lock(void)            { RUN(verifier_spin_lock); }
>> +void test_verifier_stack_arg(void)            { RUN(verifier_stack_arg); }
> Could this be missing a RUN(verifier_stack_arg_order) entry?

Yes. Thanks for capturing this. Will fix.

>
> The patch introduces the new tests for load ordering validation below,
> but without registering them in the selftests runner, it looks like
> they will not be executed.
>
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
>> new file mode 100644
>> index 0000000000000..671c79969c6cd
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
>> @@ -0,0 +1,86 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */

