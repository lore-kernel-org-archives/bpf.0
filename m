Received: from mta0.migadu.com (out-36.mta0.migadu.com [91.218.175.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F87C31F9B9
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850085; cv=none; b=WIfSs4L+5aKVmxHocSGHCVWM9hxBD89/9MZtnSSrL7GXrcwOkGp3gDvTDEGaSfwHQ9aVcCFy42jJ4Hd4kHR9ClemBMsr0WhNZ6E+m/k3MyrD79gS/NzXmwI+EzuGeh/0QTAJfMgbQ/uqjR6tiBmzQPtcgaBXglUo5OQo1CqOKGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850085; c=relaxed/simple;
	bh=epG3RsGzBNODacxO9AdsSydjWMnlNnoZ7Q5FJbRdw8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VotsUbfrOhAtKX3UWjQGJVJ0s88Efcfbpe1suDX38F+lx8H934dI2amY8LEZe7qYmKgFYECd5IC5Ew9nhwz7FChfXFjV+orSluAnxMSQ9yR4iuBN9u61bsEHx97iIp+vifDft3uwszRnSHFIabOKEU1pvDGgtRh1zpRG7OvIW/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BgWvZJp4; arc=none smtp.client-ip=91.218.175.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BgWvZJp4"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=epG3RsGzBNODacxO9AdsSydjWMnlNnoZ7Q5FJbRdw8g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789850081; v=1; x=1790454881;
 b=BgWvZJp44mP0idQO4ESgr7anKqcRPvuUGAjla3wr+Xpv7AR6hxmOeorf1ForHjr7SWbTNsW7
 6/n1h1UedjhszKSGF3/Fiwf1e3pSqzpXbx5P0sebApqlrCQyaWqTDr5gk5Rb3F6/bebUyPkhBiu
 IWo9wWkg7AouhN7NnP2qv8w0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6136f18c9920cc33;
	Sat, 19 Sep 2026 20:34:41 +0000
X-Mizu-Trace-ID: 6136f18c9920cc33
X-Migadu-Flow: FLOW_OUT
Message-ID: <fb58c781-ddde-45ae-bc54-efdcc972c653@linux.dev>
Date: Sat, 19 Sep 2026 13:34:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 18/20] selftests/bpf: Add an end-to-end
 .bpf_cleanup exception test
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260918044332.3293447-1-yonghong.song@linux.dev>
 <112c4c6755b0b925b20a58097d943b45c23723b8e561267fb39cd06ee39378e6@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <112c4c6755b0b925b20a58097d943b45c23723b8e561267fb39cd06ee39378e6@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/26 10:58 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
>> new file mode 100644
>> index 0000000000000..ce2dac306a84c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
>> @@ -0,0 +1,600 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_experimental.h"
>> +#include "bpf_misc.h"
>> +#include "../test_kmods/bpf_testmod_kfunc.h"
>> +#include "exceptions_cleanup.h"
>> +
>> +__u64 input = 0;
>> +
>> +static __used __noinline void __kfunc_btf_anchor(void)
>> +{
>> +	bpf_throw(0);
>> +	bpf_preempt_disable();
>> +	bpf_preempt_enable();
>> +	bpf_unwind_resume();
>> +}
> Is bpf_unwind_resume() declared anywhere?  It is called from C here but
> bpf_experimental.h declares only the other kfuncs this anchor exists for:
>
> tools/testing/selftests/bpf/bpf_experimental.h declares bpf_throw():
>
>      extern void bpf_throw(u64 cookie) __ksym;
>
> and the preempt pair:
>
>      void bpf_preempt_disable(void) __weak __ksym;
>      void bpf_preempt_enable(void) __weak __ksym;
>
> but bpf_unwind_resume() does not appear in any header. vmlinux.h contains
> type definitions only, not kfunc prototypes.
>
> BPF objects are built with BPF_CFLAGS = -g -Wall -Werror -std=gnu11
> (tools/testing/selftests/bpf/Makefile). -Wimplicit-function-declaration
> is part of -Wall, and in C99+ mode modern Clang promotes it to an error,
> which with -Werror becomes fatal:
>
>    progs/exceptions_cleanup_fail.c:17:2: error: call to undeclared
>      function 'bpf_unwind_resume'; ISO C99 and later do not support
>      implicit function declarations
>
> This would break the build of the whole BPF selftests tree. The same C-level
> call appears in the three other new prog files added by this series
> (progs/exceptions_cleanup.c, and in follow-ups progs/exceptions_cleanup_shapes.c
> and progs/exceptions_cleanup_light.c), so all of them would fail to compile.
>
> The anchor cannot simply drop the call either: the C call is what makes Clang
> emit the BTF extern FUNC for bpf_unwind_resume, which libbpf needs to resolve
> the inline-asm "call bpf_unwind_resume;" relocations. The fix would be to add
> the declaration:
>
>      extern void bpf_unwind_resume(void) __ksym;
>
> in bpf_experimental.h alongside bpf_throw(). For comparison,
> progs/exceptions_cleanup_shapes.c (commit 198e7e8d6d72) does declare its
> sibling explicitly:
>
>      extern void _Unwind_Resume(void) __ksym;

I didn't find anything wrong with this patch set and with my normal environment,
the test works fine.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711

