Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3B135E930;
	Thu, 23 Jul 2026 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801762; cv=none; b=ksjpsQIfv2xKIg/CzrubGH1NaMhzA7G5otcb6Ob43Jlqa5uFAsnGCGI23bWbT89zuDbPvzPLoyOYq/nSWXLpo9hRNEk7GRAkk7E2WpBNWv+lRkFc7N6rPiAuPJb0iNUBIQAOXcOt2xbbV0SXyQ4rj5ACZSPFwSEeJlI8CRCtUS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801762; c=relaxed/simple;
	bh=rX0sKVaTnuYQb0UKf/sTtpP4xyflWQILB5x2vqMkybc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hmreaOi42Uv0iooVgdigXjdSnXyjer2rdxV7tnI0Oxh+AUuWqYsdNvvnw7SnoTca63QbYSM9BuAZJByETDZAt7UqgJmBhGrQoN4AhX7sAo0AYr5M9cuhkgH/Lw9CcUckgZFqoNineNfmY1FE1Kp0Xv622nnII2u69R3gpWCKv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JoceHL4T; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JoceHL4T"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0Lx29bS/id5M40lC5Ms2Nz6QTU5j+T7B90l5cEGBQg8=;
	b=JoceHL4TrRdiJOabL+cHZgWH0jOwmNyNUYVBkVyDbum5Pm1Y1oY6ccctIR37YMtai3s0+Tq7s
	PhxjNBW9Ec/hEydxaaeCS5a6+w7wAXZ+lwLQnstos7PDQL1ceepeqJCS+5JpNCTarLwp/EwPEBi
	lyCIl2IvTl9Uqu7170BaMN8=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4h5Rbt2JNXz1cyvK;
	Thu, 23 Jul 2026 18:06:34 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 3154F40563;
	Thu, 23 Jul 2026 18:15:56 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 23 Jul
 2026 18:15:55 +0800
Message-ID: <15ceb481-ae3e-4c51-aeb7-513a3d213959@huawei.com>
Date: Thu, 23 Jul 2026 18:15:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: enable timed may_goto
 tests for riscv64
Content-Language: en-US
To: Feng Jiang <jiangfeng@kylinos.cn>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Luke Nelson
	<luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Puranjay Mohan
	<puranjay@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>, Ihor Solodrai
	<ihor.solodrai@linux.dev>
CC: <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260723-riscv-bpf-timed-may-goto-v5-0-86acb54e5642@kylinos.cn>
 <20260723-riscv-bpf-timed-may-goto-v5-3-86acb54e5642@kylinos.cn>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260723-riscv-bpf-timed-may-goto-v5-3-86acb54e5642@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/7/23 13:41, Feng Jiang wrote:
> Enable verifier_may_goto_1 (raw instruction tests), stream_cond_break
> (250ms timeout path), and the may_goto_interaction fastcall test on
> riscv64 now that the JIT supports timed may_goto.
> 
> Reviewed-by: Pu Lehui <pulehui@huawei.com>
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/progs/stream.c                | 1 +
>   tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c | 3 ++-
>   tools/testing/selftests/bpf/progs/verifier_may_goto_1.c   | 4 ++++
>   3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
> index 92ba1d72e0ec..8d8e53d37266 100644
> --- a/tools/testing/selftests/bpf/progs/stream.c
> +++ b/tools/testing/selftests/bpf/progs/stream.c
> @@ -64,6 +64,7 @@ SEC("syscall")
>   __arch_x86_64
>   __arch_arm64
>   __arch_s390x
> +__arch_riscv64
>   __success __retval(0)
>   __stderr("ERROR: Timeout detected for may_goto instruction")


This test fails because it relies on arch_bpf_stack_walk to fetch the 
prog. It's fine to leave it on though, since support is on the way.

https://lore.kernel.org/bpf/20260722140015.1982158-1-varunrmallya@gmail.com/


>   __stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> index 8d7ff38e4c06..83707faea049 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> @@ -660,6 +660,7 @@ __naked void may_goto_interaction_x86_64(void)
>   
>   SEC("raw_tp")
>   __arch_arm64
> +__arch_riscv64
>   __log_level(4) __msg("stack depth 24")
>   /* may_goto counter at -24 */
>   __xlated("0: *(u64 *)(r10 -24) =")
> @@ -679,7 +680,7 @@ __xlated("10: *(u64 *)(r10 -24) = r12")
>   __xlated("11: *(u64 *)(r10 -8) = r1")
>   __xlated("12: exit")
>   __success
> -__naked void may_goto_interaction_arm64(void)
> +__naked void may_goto_interaction(void)
>   {
>   	asm volatile (
>   	"r1 = 1;"
> diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
> index cb1ce4d13cfc..0e211f030d0d 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
> @@ -11,6 +11,7 @@ __description("may_goto 0")
>   __arch_x86_64
>   __arch_s390x
>   __arch_arm64
> +__arch_riscv64
>   __xlated("0: r0 = 1")
>   __xlated("1: exit")
>   __success
> @@ -31,6 +32,7 @@ __description("batch 2 of may_goto 0")
>   __arch_x86_64
>   __arch_s390x
>   __arch_arm64
> +__arch_riscv64
>   __xlated("0: r0 = 1")
>   __xlated("1: exit")
>   __success
> @@ -53,6 +55,7 @@ __description("may_goto batch with offsets 2/1/0")
>   __arch_x86_64
>   __arch_s390x
>   __arch_arm64
> +__arch_riscv64
>   __xlated("0: r0 = 1")
>   __xlated("1: exit")
>   __success
> @@ -79,6 +82,7 @@ __description("may_goto batch with offsets 2/0")
>   __arch_x86_64
>   __arch_s390x
>   __arch_arm64
> +__arch_riscv64
>   __xlated("0: *(u64 *)(r10 -16) = 65535")
>   __xlated("1: *(u64 *)(r10 -8) = 0")
>   __xlated("2: r12 = *(u64 *)(r10 -16)")
> 
