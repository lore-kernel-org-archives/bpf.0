Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204062;
	b=0iq6wo1ekSqX1AOhWMKG7PhG0OhMv0yLBJQaReh5oMImSku/hz1JyjLzENb6LrfRUgEo
	 67Ce0Wxx/ZZf1eA7uufa9ifBVf6NHAkdAGWM43p9vjcou6YTm3amb2TMVTKK0gFwbG87b
	 oYifjkSu9Pc7OxnEgwpVSu3bkXWwTfUicGeW3N119ptPL+J3Pxd+dKDTmNargtvCLrF2e
	 dC0fIbuSDczvX9EytPsudgxMXMh4k8ss59LAQi59BEe8/n1Zd5F3tVzDyU9a5lZ2T2Ry0
	 ldnd4yxkkg0lpoOx3pdka8imFbpQOZsGhIPXU/WS149v2YJBy/2c41u77tl0e2qYZ1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204062;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=jZHvoOT2EeUjl0qBRVikSa4VHep/t0Mtn1K16RSX0t4=;
	b=OEUfrXtMUNzcgmrEGo9c9EzP1D9ZuaPQd7GCOIF7t/WtmSr/CvbO/p2SQoYl9BQul57d
	 A5lFl1LmhtkbBsutC1Zz9xwdmz2KxdOEL0zcVnrq3Ti7DQt5pJlUpm1M88DqsYmBIXzNa
	 d6ZrWsbYxW9P+Tm75kQvspxPueSgYDBmQzlQiHRmKL/AuKKs2RgS9fy3UM/DLDaW2dX+t
	 2/fKCfWPJWgmMrX9XV/Pn02hLBRIO5Vmas5tomLsoYDF+DQhsagFoM7bG14O3ozWke5vK
	 lKH5b3DzGI8FJeLZ+dO7oxQG6rWxqR9CE3XocGvwoZkSr//BKH8Xqp0plT+DBco9yeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JU4E2+wG;
	arc=none smtp.remote-ip=91.218.175.185
Received: from mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DC1606A31D
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 16:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94DC1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JU4E2+wG
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KjiL5I9h8+VMhUetGyLFAB5E576LUSfxA1guJ+4SAJQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793204059; v=1; x=1793808859;
 b=JU4E2+wGxuahI8xwCHVkilV0rLBydbzkq5oI1GHRnFC2qcfEAKnGijlUVPt9Cfh0pIObroUO
 s1t+vfD4rHzPpfrcV9O384txe25dtP+IvaATbdTCYEgYUeHP4A4A/ebGhYj6KHcRUmGAg8V2w/x
 BuEzoWDbpLTUMLve9Sg+fVNM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d491d59290f9609b;
	Wed, 28 Oct 2026 16:14:19 +0000
X-Mizu-Trace-ID: d491d59290f9609b
X-Migadu-Flow: FLOW_OUT
Message-ID: <40dde029-432a-4794-a491-8f1c9d5a2b4e@linux.dev>
Date: Wed, 28 Oct 2026 09:14:16 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 3/7] selftests/bpf: report SKIP for arena
 tests a compiler cannot build
To: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
References: <20261028000411.4010967-4-vineet.gupta@linux.dev>
 <sashiko-outbox-187262@kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-187262@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/26 5:13 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] selftests/bpf: missing __skip_without_arena fallback in jit_insns_arena.c
> --
>
> commit f37e4c1aa3e5f2decfc920dfa156617c4a66522b
> Author: Vineet Gupta <vineet.gupta@linux.dev>
>
> selftests/bpf: report SKIP for arena tests a compiler cannot build
>
> This commit adds a __skip_without_arena macro and #else fallback programs
> to BPF selftest files guarded by __BPF_FEATURE_ADDR_SPACE_CAST so that
> test_progs reports those subtests as skipped when built with a compiler
> that lacks arena address space support.
>
>> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
>> index 1b264480e128f..ed1ed1b5bd097 100644
>> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
>> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
>> @@ -156,6 +160,16 @@
>>   #define __success		__test_tag("test_expect_success")
>>   #define __description(desc)	__test_tag("test_description=" desc)
>>   #define __skip(reason)		__test_tag("test_skip=" reason)
>> +
>> +/*
>> + * Without compiler arena support, report the test as SKIP rather than let it
>> + * pass vacuously or fail to load.
>> + */
>> +#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
>> +#define __skip_without_arena
>> +#else
>> +#define __skip_without_arena	__skip("compiler does not support the arena address space")
>> +#endif
> [Severity: Medium]
> Should tools/testing/selftests/bpf/progs/jit_insns_arena.c also receive an
> #else fallback with a dummy arena_unsupported() program marked
> __skip_without_arena?
>
> In tools/testing/selftests/bpf/progs/jit_insns_arena.c, both BPF programs
> in the file (arena_zero_off() and cast_to_user()) are inside a
> __BPF_FEATURE_ADDR_SPACE_CAST guard without an #else branch:
>
> tools/testing/selftests/bpf/progs/jit_insns_arena.c:
>      #if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>      SEC("syscall")
>      __success __retval(0)
>      int arena_zero_off(void *ctx)
>      {
>          ...
>      }
>
>      SEC("syscall")
>      __success __retval(0)
>      int cast_to_user(void *ctx)
>      {
>          ...
>      }
>      #endif
>
>      char _license[] SEC("license") = "GPL";
>
> When built with a compiler that does not define
> __BPF_FEATURE_ADDR_SPACE_CAST, such as stock bpf-gcc, jit_insns_arena.c
> compiles to an object with zero BPF programs. When test_jit_insns() in
> tools/testing/selftests/bpf/prog_tests/jit_insns.c runs:
>
>      test_jit_insns() -> RUN_TESTS(jit_insns_arena) -> test_loader__run_subtests()
>
> it silently executes zero subtests for jit_insns_arena instead of reporting
> a skipped subtest.

Indeed this was a miss because my prev testing baseline (before rebase) 
didn't have it.
Added in v2.

Thx,
-Vineet

