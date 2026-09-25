Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F367E3AFB06
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 06:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790319356; cv=none; b=a5bLqvCjSfSkdJ/BKo83Bvpc1WAMJjqaj2li+cjUokqUYkSDh1AUAj9JNo07mrAYvsiPTJSYPZxXkLt/9SpZReXVl56jvi9+wr5QhlliKniZrbCWRuZBcm0LvIUaacs8ZYoAkbSJbU7bOR+yhkU5thipcVaKfsV6MaX3MVbK7NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790319356; c=relaxed/simple;
	bh=FeczuV+9ClcSnOncLxw3rRRba2sQCUM4ISB+vlYw/Kk=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type:Cc:In-Reply-To; b=Jy4vImtwCAzVmtGhcaDQyasLUDVudvieENTGjePcs6fU3seidWrn6dVLD0KIpEnYBMqhPOKIxlMBejtdfNGjSA5OJnawQOXIVtEKkxC24LI/69140Mf2OfvXyIfYdZ9J9rplln1hxoWnDl77JRUZOeeq2HRQS+g/pU2/SlAYKQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glkb-bpf@m.gmane-mx.org>)
	id 1x9zld-0009G1-LS
	for bpf@vger.kernel.org; Fri, 25 Sep 2026 08:50:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: bpf@vger.kernel.org
From: Vineet Gupta <vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix build of callx tests with GCC
Date: Thu, 24 Sep 2026 23:50:39 -0700
Message-ID: <19cc4e99-2351-4d8c-8edd-918eaf857d5f@linux.dev>
References: <20260924182104.261823-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com
Content-Language: en-US
In-Reply-To: <20260924182104.261823-1-alexei.starovoitov@gmail.com>
Message-ID: <20260925065039.zZulRzHCO_w7Y-awZ6_htxXIlyVMtQ2ChCANwECUEOs@z>

On 9/24/26 11:21 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> GCC doesn't support indirect calls in BPF:
> 
>    progs/verifier_callx.c: In function 'apply_op':
>    progs/verifier_callx.c:977:1: error: indirect call in function, which are not supported by eBPF
>    progs/verifier_callx_rodata.c: In function 'use_shape':
>    progs/verifier_callx_rodata.c:746:1: error: indirect call in function, which are not supported by eBPF

GCC supports them under -mxbpf but unfortunately even that is broken.


> Build verifier_callx, verifier_callx_rodata and callx_rodata progs
> with clang only. Skip callx_rodata_lskel test when progs are built
> with GCC.

Can we do this slightly differently.
Following on same theme have been queued up in bpf-next

2026-08-24 48b69cc8825d selftests/bpf: Enable some of the blocked cpuv4 
instruction tests for bpf-gcc
2026-08-24 8928f5ffdb65 selftests/bpf: Report placeholder tests as SKIP, 
not OK
2026-08-24 b0eeb9e0f548 selftests/bpf: Name the remaining placeholder 
programs dummy_test

> 
> Fixes: e9b22d50796d ("selftests/bpf: Add tests for callx")
> Fixes: b018e998e645 ("selftests/bpf: Add tests for callx through pointers in read-only data")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>   .../bpf/prog_tests/callx_rodata_lskel.c       |  6 ++++
>   .../selftests/bpf/progs/callx_rodata.c        | 28 +++++++++++++++++--
>   .../selftests/bpf/progs/verifier_callx.c      |  3 +-
>   .../bpf/progs/verifier_callx_rodata.c         |  3 +-
>   4 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
> index 96f6179f0492..6a43b880d730 100644
> --- a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
> +++ b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
> @@ -35,6 +35,12 @@ void test_callx_rodata_lskel(void)
>   	if (!ASSERT_OK_PTR(skel, "open"))
>   		return;
>   
> +	/* gcc doesn't support indirect calls */
> +	if (skel->rodata->skip) {
> +		test__skip();
> +		goto out;
> +	}
> +

We now have common skipping machinery using __skip, see further below.

>   	skel->rodata->bias = 7;
>   
>   	if (!ASSERT_OK(callx_rodata_lskel__load(skel), "load"))
> diff --git a/tools/testing/selftests/bpf/progs/callx_rodata.c b/tools/testing/selftests/bpf/progs/callx_rodata.c
> index 07ae2d1b6b8e..e3f8335f80f8 100644
> --- a/tools/testing/selftests/bpf/progs/callx_rodata.c
> +++ b/tools/testing/selftests/bpf/progs/callx_rodata.c
> @@ -1,16 +1,21 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* callx through pointers to functions in .rodata, loaded by light skeleton */
>   
> +#include <stdbool.h>
>   #include <linux/bpf.h>
>   #include <bpf/bpf_helpers.h>
>   
> -typedef int (*op_fn)(int);
> -
>   /* set by user space before the programs are loaded, it's in .rodata too */
>   const volatile int bias = 1;
>   
>   int op_idx;
>   
> +#ifdef __clang__

It unfortunatete that this doesn't have a compiler feature test macro 
__BPF_FEATURE_* in clang or gcc. It seems we have existing 
CAN_USE_BPF_ST and CAN_USE_GOTOL, maybe we can define CAN_USE_CALLX in 
bpf_misc.h and use that as a gate, keeps one place for all such 
__clang/gcc workaround definitions instead of them scattered all over. I 
have a few pending patches which clean things up.

> +
> +const volatile bool skip = false;
> +
> +typedef int (*op_fn)(int);
> +
>   static __noinline int add_bias(int x)
>   {
>   	return x + bias;
> @@ -41,6 +46,25 @@ int both_ops(void *ctx)
>   	return ops[1](ops[0](4));
>   }
>   
> +#else
> +
> +/* gcc doesn't support indirect calls */
> +const volatile bool skip = true;
> +
> +SEC("socket")
> +int select_op(void *ctx)
> +{
> +	return 0;
> +}
> +
> +SEC("socket")
> +int both_ops(void *ctx)
> +{
> +	return 0;
> +}
> +
> +#endif
> +

This can be rewritten using exising skipping machinery as shown in 
bpf-next patch: 8928f5ffdb65 ("selftests/bpf: Report placeholder tests 
as SKIP, not OK")

#ifdef CAN_USE_CALLX

llvm_code

#else
__skip("gcc doesnt support callx")
int dummy_test(void *ctx)
{
     return 0;
}
#endif

This avoids the explicit skipping logic.

>   /* no callx here */
>   SEC("socket")
>   int read_bias(void *ctx)
> diff --git a/tools/testing/selftests/bpf/progs/verifier_callx.c b/tools/testing/selftests/bpf/progs/verifier_callx.c
> index ea3d3f97da31..bc31d0221f6a 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_callx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_callx.c
> @@ -6,7 +6,8 @@
>   #include "bpf_misc.h"
>   #include "../../../include/linux/filter.h"
>   
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> +/* gcc doesn't support indirect calls */
> +#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && defined(__clang__)
>   
>   #define CALLX_INSN(DST, SRC, OFF, IMM) \
>   	BPF_RAW_INSN(BPF_JMP | BPF_CALL | BPF_X, DST, SRC, OFF, IMM)
> diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
> index 65d34769c8bf..db3169a1ddf6 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
> @@ -6,7 +6,8 @@
>   #include "bpf_misc.h"
>   #include "../../../include/linux/filter.h"
>   
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> +/* gcc doesn't support indirect calls */
> +#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && defined(__clang__)

Instead of __clang scattered all over, CAN_USE_CALLX in bpf_misc.h so 
its one stop shop to clean things up in future.

BTW this is

Thx,
-Vineet

