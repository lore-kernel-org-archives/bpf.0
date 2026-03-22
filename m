Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64486364EB2;
	Sun, 22 Mar 2026 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774140587; cv=none; b=uOWPosZ0m+EQ+wlI+1eoc2jPEU075fzL174Q47edohZsdBziM4eHQug585SUSi6XHvWVlcP41Nyj0RpiliFl5KUwvyAEn/EHf56xFrbqRYFjAv5Au9Aq9NVqqTnNRGfP7OdGeLGpX7Q9ZZnXbuVadWnkd1dgZ9xMvBZpARgHIRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774140587; c=relaxed/simple;
	bh=3P+FHVNfbK+La3bD6MuS2D4z0TSvWKFHyTDdjVBd30Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuakDeVxGqzm8CPh9O5AgAVuaDkvMkcffHA5SvHlPHjtEX22+N4/1F7VrKrVyPEk4/QNiUCo8F7F5XhF1agaPef0XRSuW/gKAWlf3kfMz6jkpvJgl6Dyzi0c76MotKglF3sQ6Q4P+NO/vRm41YVnF47cfQ8URKX3XbbR5cMyxzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=JUJHUDtE; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="JUJHUDtE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ecx+NdtNHs/E9Y80PcAg4AM7G5D3SMKPl991bj4N5QQ=;
  b=JUJHUDtELWTUj4h3pCn9JQ6dp84wbwhQA0zM+YTcdKykr9XTs9vvYIOB
   5OK+XWGo7GSW45DyUHKNMDAjEeHwXycW0g1V3UvCeMdnS8dfOLStek2kV
   zOePlbCNAV2zqXpyuVVvH1RZydQ8JgN/Mk4flsqwgOOHnx2lv7bkfOlNW
   s=;
X-CSE-ConnectionGUID: wrH9vzEfRVSBv262jZ6SYQ==
X-CSE-MsgGUID: /Ex2Z2tYQYivu/BNe8Gcmw==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.23,134,1770591600"; 
   d="scan'208";a="141978277"
Received: from unknown (HELO [10.31.64.140]) ([193.52.24.41])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 01:49:35 +0100
Message-ID: <9f8cc4f1-a603-4cbf-9c99-1f5bca341ca5@inria.fr>
Date: Sun, 22 Mar 2026 01:49:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Add test for struct_ops __ref
 argument in any position
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Amery Hung <ameryhung@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 sun jian <sun.jian.kdev@gmail.com>, ameryhung@gmail.com, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, song@kernel.org,
 yonghong.song@linux.dev
References: <20260320130219.63711-1-keisuke.nishimura@inria.fr>
 <20260321214038.80479-1-varunrmallya@gmail.com>
Content-Language: en-US
From: Keisuke Nishimura <keisuke.nishimura@inria.fr>
In-Reply-To: <20260321214038.80479-1-varunrmallya@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Thank you for adding the test. If there is nothing further for me to 
address, I think we can proceed as-is without a v2? Let me know if 
anything still needs fixing.

Thanks,
Keisuke

On 2026/03/21 22:40, Varun R Mallya wrote:
> Add a selftest to verify that the verifier correctly identifies refcounted
> arguments in struct_ops programs, even when they are not the first
> argument. This ensures that the restriction on tail calls for programs
> with __ref arguments is properly enforced regardless of which argument
> they appear in.
> 
> This test verifies the fix for check_struct_ops_btf_id() proposed by
> Keisuke Nishimura [0], which corrected a bug where only the first
> argument was checked for the refcounted flag.
> The test includes:
> - An update to bpf_testmod to add 'test_refcounted_multi', an operator with
>    three arguments where the third is tagged with "__ref".
> - A BPF program 'test_refcounted_multi' that attempts a tail call.
> - A test runner that asserts the verifier rejects the program with
>    "program with __ref argument cannot tail call".
> 
> [0]: https://lore.kernel.org/bpf/20260320130219.63711-1-keisuke.nishimura@inria.fr/
> 
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---
>   .../prog_tests/test_struct_ops_multi_args.c   |  9 +++++
>   .../bpf/progs/struct_ops_multi_args.c         | 35 +++++++++++++++++++
>   .../selftests/bpf/test_kmods/bpf_testmod.c    |  7 ++++
>   .../selftests/bpf/test_kmods/bpf_testmod.h    |  3 ++
>   4 files changed, 54 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_multi_args.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
> new file mode 100644
> index 000000000000..0f321e889862
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "struct_ops_multi_args.skel.h"
> +
> +void test_struct_ops_multi_args(void)
> +{
> +	RUN_TESTS(struct_ops_multi_args);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c b/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c
> new file mode 100644
> index 000000000000..c62be15757f0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Varun R Mallya */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../test_kmods/bpf_testmod.h"
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> +	__uint(max_entries, 1);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u32));
> +} prog_array SEC(".maps");
> +
> +SEC("struct_ops/test_refcounted_multi")
> +__failure __msg("program with __ref argument cannot tail call")
> +int test_refcounted_multi(unsigned long long *ctx)
> +{
> +	/* ctx[2] is used because the refcounted variable is the third argument */
> +	struct task_struct *refcounted_task = (struct task_struct *)ctx[2];
> +
> +	bpf_task_release(refcounted_task);
> +	bpf_tail_call(ctx, &prog_array, 0);
> +
> +	return 0;
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops testmod_ref_acquire = {
> +	.test_refcounted_multi = (void *)test_refcounted_multi,
> +};
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 94edbd2afa67..297b02372fa6 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -1411,6 +1411,12 @@ static int bpf_testmod_ops__test_refcounted(int dummy,
>   	return 0;
>   }
>   
> +static int bpf_testmod_ops__test_refcounted_multi(int dummy, struct task_struct *task__nullable,
> +						  struct task_struct *task__ref)
> +{
> +	return 0;
> +}
> +
>   static struct task_struct *
>   bpf_testmod_ops__test_return_ref_kptr(int dummy, struct task_struct *task__ref,
>   				      struct cgroup *cgrp)
> @@ -1423,6 +1429,7 @@ static struct bpf_testmod_ops __bpf_testmod_ops = {
>   	.test_2 = bpf_testmod_test_2,
>   	.test_maybe_null = bpf_testmod_ops__test_maybe_null,
>   	.test_refcounted = bpf_testmod_ops__test_refcounted,
> +	.test_refcounted_multi = bpf_testmod_ops__test_refcounted_multi,
>   	.test_return_ref_kptr = bpf_testmod_ops__test_return_ref_kptr,
>   };
>   
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
> index f6e492f9d042..863fd10f1619 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
> @@ -39,6 +39,9 @@ struct bpf_testmod_ops {
>   	int (*unsupported_ops)(void);
>   	/* Used to test ref_acquired arguments. */
>   	int (*test_refcounted)(int dummy, struct task_struct *task);
> +	/* Used to test checking of __ref arguments when it not the first argument. */
> +	int (*test_refcounted_multi)(int dummy, struct task_struct *task,
> +				     struct task_struct *task2);
>   	/* Used to test returning referenced kptr. */
>   	struct task_struct *(*test_return_ref_kptr)(int dummy, struct task_struct *task,
>   						    struct cgroup *cgrp);

