Received: from mta0.migadu.com (out-40.mta0.migadu.com [91.218.175.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7189B380FE5
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787941734; cv=none; b=CjIvF62RflEZZMxKF64Pv6AZjMAqm0gBPrOhYKIO/a+eUZI0QwpNDnsC2gXgkJp0A2S+y9FcrCuO6D/pwF3E+LFGFs2WxfhpAR1TG/rvjHN79e2w6JFR1rIaEIw3HCGlhbqyzn72VAfTlLfqOpiTEDfCO2ff0rR5vNTyggkK7GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787941734; c=relaxed/simple;
	bh=ZICLzh87EjorNKSIaHujZnImUhu5UtVzMZzsPK0tvyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlqMH7vy4/loKT3CX/lr62Wyzxw8soWWlYEkPnLmLu13tZKdty0/mSPNsi2DOVeqTy3Zb1kpBuF6NSmyt5BR3K8WZFbuftdlZO72636lW3yLtdsXrydEuFeLByDJpVvUIuWLyR5k+8dpC+q3KrRmhfyMR/Upyir7m7YTQX+XWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hlypu5sb; arc=none smtp.client-ip=91.218.175.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hlypu5sb"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZICLzh87EjorNKSIaHujZnImUhu5UtVzMZzsPK0tvyw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787941730; v=1; x=1788546530;
 b=Hlypu5sb3+D4kXPrkBHkv3HlUqbVMnKwGlxawCzB1nTx1PjoBcolN/AZyzrqpQqk+/uGKS0c
 o8f9oBX/bDFjhLh8IjBfPi4c70siICSkGmLm8U5FobsHpLj3XrVNn91LIFtFYuCVfSPigjW2p2L
 1YwS/TkG6b64Csyf7ITHcDMU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id de368c8952d94c27;
	Fri, 28 Aug 2026 18:28:49 +0000
X-Mizu-Trace-ID: de368c8952d94c27
X-Migadu-Flow: FLOW_OUT
Message-ID: <42faf6da-b782-44f1-ab0b-767c703dd523@linux.dev>
Date: Fri, 28 Aug 2026 11:28:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 10/11] selftests/bpf: Test kfuncs returning
 arena pointers by value
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260827061206.2520351-1-yonghong.song@linux.dev>
 <465f8ac0b4ab71a0d3939e6bded8e52a1a1e54e7c6d57ef7447b1dad571ce9ae@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <465f8ac0b4ab71a0d3939e6bded8e52a1a1e54e7c6d57ef7447b1dad571ce9ae@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/27/26 12:17 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.c b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.c
>> new file mode 100644
>> index 0000000000000..94c35e1b547cd
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.c
>> @@ -0,0 +1,129 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf_arena_common.h>
>> +#include "bpf_misc.h"
>> +#include "../test_kmods/bpf_testmod_kfunc.h"
>> +
>> +#if defined(__clang_major__) && __clang_major__ >= 23
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_ARENA);
>> +	__uint(map_flags, BPF_F_MMAPABLE);
>> +	__uint(max_entries, 2);
>> +} arena SEC(".maps");
>> +
>> +/*
>> + * A returned member carries the arena type tag but not the address space
>> + * qualifier, so the program casts it into the arena address space itself
>> + * rather than the compiler doing it.
>> + */
>> +#define arena_ptr(p) ((u32 volatile __arena *)(p))
> This isn't a bug, but could the cast be spelled out at each use site, or
> the macro named after the type it produces (e.g. arena_u32p())? The name
> arena_ptr() reads as a generic address-space cast, but it hardcodes 'u32
> volatile', which matters for the load/store widths the test checks. Other
> arena selftest programs write the cast inline with the type visible at the
> use site (for example '(char __arena *)ptr' in progs/arena_mem_usage.c).

Okay, let us inline arena_ptr(p) directly in the code.

>
>> +
>> +SEC("syscall")
>> +__arch_x86_64 __arch_arm64
>> +__load_if_JITed()
>> +__success __retval(0)
>> +int aggregate_ret_kfunc_arena(void *ctx)
>> +{
>> +	u32 volatile __arena *page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
>> +	u32 volatile __arena *a, *b;
>> +	struct prog_test_ret_arena r;
>> +
>> +	if (!page)
>> +		return 1;
>> +
>> +	/* Both halves come back in R0:R2, pointing at page and page + 4. */
>> +	r = bpf_kfunc_call_test_ret_arena((u64)page);
>> +	if (!r.a || !r.b)
>> +		return 2;
>> +
>> +	a = arena_ptr(r.a);
>> +	b = arena_ptr(r.b);
>> +	*a = 1;
>> +	*b = 2;
>> +	if (*a != 1)
>> +		return 3;
>> +	if (*b != 2)
>> +		return 4;
>> +
>> +	/* The halves are the first two slots of the page the program allocated. */
>> +	page[0] = 7;
>> +	if (*a != 7)
>> +		return 5;
>> +	page[1] = 9;
>> +	if (*b != 9)
>> +		return 6;
>> +
>> +	return 0;
>> +}
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33045482525

