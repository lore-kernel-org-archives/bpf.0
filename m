Received: from mta0.migadu.com (out-239.mta0.migadu.com [91.218.175.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33850353A71
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 04:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789100764; cv=none; b=d7Z1tNE1Sm9GppUC1rcWDcSPaUAd+SoWBDk0azHXkCxecaZM5pr7sAdfDkpQQ1JxBrU0BD+wdsQlbv1IK0fwxUsWNPbggpHkqGKX4IEWTK/g6hptXFB7J+irEzp13TJQ6h2fyNbC4ibpg5Ha7+UaQetHBZXuWDEy9y1UghyxSbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789100764; c=relaxed/simple;
	bh=Mh3NLDyamj1qprcRnO11jC1WhEgxNIZeMS2iEalJdGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6masfvDN28Yf38ewXEiL9dLcMIJuEHTKRjSFXWBLN7onmPAgw4fm5ZQRJyy3u2yWtNXfvDGyvxrtExxG6oOxJcFnul08pG7dMvW2+V/dU4Td9MlpUj8Y7dvptYni7Zx0FfMcdQr0fUNSCwwF/nkw/Si1v4vKi8D9Ab6tVlBtRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LK+cnGfx; arc=none smtp.client-ip=91.218.175.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LK+cnGfx"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Mh3NLDyamj1qprcRnO11jC1WhEgxNIZeMS2iEalJdGg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789100758; v=1; x=1789705558;
 b=LK+cnGfx36xtFvfAjSPts/7LVBr13nparvE3UKYfYiDqfTypR+kf4lLI6YXew2GXjkno97xz
 UdfsAUYu6qI/FkA7h1rjtmtBiF8eiClVXiks2sF4ImC6Q0rS2n/SB4GztzxvP2AcPUTwKQtG4e0
 K0ia9zZKvNRwy5KBrY7UGZLc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a0f004790152da85;
	Fri, 11 Sep 2026 04:25:48 +0000
X-Mizu-Trace-ID: a0f004790152da85
X-Migadu-Flow: FLOW_OUT
Message-ID: <a363f511-8c65-4098-ac95-4f5b47a1d0a7@linux.dev>
Date: Thu, 10 Sep 2026 21:25:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 01/12] selftests/bpf: Add a test for an
 __int128 by-value argument
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260909062528.4002148-1-yonghong.song@linux.dev>
 <5b5eb3abbefc69c22b09fb686c4ff7cc3d334c9b3f73110a064252f545ff88cb@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <5b5eb3abbefc69c22b09fb686c4ff7cc3d334c9b3f73110a064252f545ff88cb@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/9/26 12:13 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
>> index f7f94ccebce2..0d68b92d6692 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
>> @@ -50,6 +50,7 @@
>>   #include "verifier_helper_packet_access.skel.h"
>>   #include "verifier_helper_restricted.skel.h"
>>   #include "verifier_helper_value_access.skel.h"
>> +#include "verifier_int128_arg.skel.h"
> [ ... ]
>
>> @@ -214,6 +215,7 @@ void test_verifier_helper_access_var_len(void) { RUN(verifier_helper_access_var_
>>   void test_verifier_helper_packet_access(void) { RUN(verifier_helper_packet_access); }
>>   void test_verifier_helper_restricted(void)    { RUN(verifier_helper_restricted); }
>>   void test_verifier_helper_value_access(void)  { RUN(verifier_helper_value_access); }
>> +void test_verifier_int128_arg(void)           { RUN_TESTS(verifier_int128_arg); }
>>   void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
> This isn't a bug, but the name verifier_int128_arg describes only the
> one case progs/verifier_int128_arg.c holds at this commit. Two patches
> later in the same series, f4da9830f5a9 adds by-value struct argument
> tests (struct pair, struct small, struct with_ptr) to the same file,
> none of which are __int128. The sibling entry two lines up is
> test_verifier_aggregate_ret for the aggregate-return family.
>
> Since progs/verifier_int128_arg.c later grows to cover by-value struct
> arguments too, would a name in the same family as verifier_aggregate_ret
> -- say verifier_aggregate_arg -- fit the file better and save a rename
> later in the series?

Correct, will use verifier_aggregate_arg.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34320399441

