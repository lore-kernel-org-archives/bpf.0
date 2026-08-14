Received: from mta0.migadu.com (out-77.mta0.migadu.com [91.218.175.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7726ED59
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 22:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786747217; cv=none; b=Lz0xwVYUM80tnlvbsxeTzp//FAWrD8BCDa27ThItk3J9diqm3crudlt190T9OT4Ue2ESXu9b11WV4lvgOobBHAeohOmPVWWMhZm6b4CzwRY9p06uBBF5AWVc3WXgZ2R2q+Cti+lz6LQdb3Z+w82sktazq6YgYiC2qyYFrQbPUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786747217; c=relaxed/simple;
	bh=IV2UV3chZCnHrDt7xljiy/hS29K/5lVpa/jkOtIILzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLlCjmxDRx7M/gz2kQlBm1cI4wFksq9wnpWko3VW7zb4z3736mqUuY9hRzR5hA51Qe6aCWa/vEl5Yc4Ug29XspXvLgu7FzyRgO6sFzV/0YP0ouD3vbR5A9428yuM6eWZ5LoABWnqASR0D/4tb2HzVVCx2JnqIEsKNiLs2rIxSkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hVvnj2Js; arc=none smtp.client-ip=91.218.175.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hVvnj2Js"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IV2UV3chZCnHrDt7xljiy/hS29K/5lVpa/jkOtIILzE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786747211; v=1; x=1787352011;
 b=hVvnj2JsARtvTrsb9GgO2VwIOTbxEOMDJMc547RA3XApTSQcV7f7z63C5DvHJeiNptKRoEds
 xaLjjopOmOzQgnouWjOx578577f1YqjwFaIrkFDcjyr4kow/SlIpPEIBxJ+DLCdRf2nyITOZrmt
 rrmvPwqJXdziT15crSBuHZs0=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1251:27:9295:e585:8bf6:fa24] (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id f4b8fbe0aa8df799;
	Fri, 14 Aug 2026 22:40:00 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <f651b905-eef2-41a3-ad55-ce2adede5d9c@linux.dev>
Date: Fri, 14 Aug 2026 15:39:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Check per-CPU address
 resolution per register
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260814220254.3797467-1-vineet.gupta@linux.dev>
 <20260814220254.3797467-3-vineet.gupta@linux.dev>
 <20260814222652.7600C1F000E9@smtp.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20260814222652.7600C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/14/26 3:26 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The test uses an unrecognized section name `SEC(".percpu")` for its global variable, preventing libbpf from loading the test.
> - [High] The test's inline assembly is missing the `mov_percpu_addr` instruction, causing the `__jited` assertions to always fail.
> --
>
> --- Patch [2]: [PATCH bpf v3 2/2] selftests/bpf: Check per-CPU address resolution per register ---
> commit 94ba39b00c54962b463da6e18c62f89978f29a3f
> Author: Vineet Gupta <vineet.gupta@linux.dev>
>
> selftests/bpf: Check per-CPU address resolution per register
>
> This commit adds a BPF selftest to verify that the x86 JIT correctly encodes
> the per-CPU address resolution. It loads a .percpu variable into all registers
> and matches the JITed add instruction against the expected register.
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
>> new file mode 100644
>> index 0000000000000..967f4e6e3a490
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
>> @@ -0,0 +1,72 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +
>> +#if defined(__TARGET_ARCH_x86)
>> +
>> +int percpu_data SEC(".percpu");
> [Severity: High]
> Does libbpf support the SEC(".percpu") section name?

Yes it does:

   - tools/lib/bpf/libbpf.c:544 — #define PERCPU_SEC ".percpu"

>
> When bpf_object__elf_collect runs, it skips the .percpu section as it doesn't
> match known data section prefixes like .data. Later, when
> bpf_object__relocate_data processes the R_BPF_64_64 relocation for the
> percpu_data load, bpf_object__section_to_libbpf_map_type returns
> LIBBPF_MAP_UNSPEC.
>
> Since the section is not the BTF maps section, this results in a bad map relo
> warning and returns -LIBBPF_ERRNO__RELOC, causing the test to fail to load.
>
> [ ... ]
>
>> +__naked void percpu_addr(void)
>> +{
>> +	asm volatile ("					\
>> +	r0 = %[percpu_data] ll;				\
>> +	r1 = %[percpu_data] ll;				\
> [Severity: High]
> Are the mov_percpu_addr instructions missing from this inline assembly?

They are inserted by the verifier.

Thx,
-Vineet

> The commit message notes that an ld_imm64 of a per-CPU map value is followed
> by a mov_percpu_addr, but the assembly here only emits a BPF_LD_IMM64
> instruction.
>
> The verifier processes this as BPF_PSEUDO_MAP_VALUE and converts it to a
> standard 64-bit immediate load. Without the BPF_MOV64_PERCPU_REG
> (mov_percpu_addr) instruction, the x86 JIT emits movabsq but never emits the
> addq %gs:..., %reg instruction. This causes the __jited assertions to fail.
>
>> +	r2 = %[percpu_data] ll;				\
>> +	r3 = %[percpu_data] ll;				\
>> +	r4 = %[percpu_data] ll;				\
> [ ... ]
>

