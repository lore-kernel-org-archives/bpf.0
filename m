Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C34470E92;
	Thu, 23 Jul 2026 03:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784777496; cv=none; b=j7xpejZQ/OgKuDmT+vOrnRWb0iPZRq7SJmXAhn4iwTOy/pZr7ce04Mf/MYJ4+qOyKoECuKAQyLdAkRyyHJChgVmbA9Y5f2p4dFE8K3gphL7EJQS0tDlReNh50i5zKcLqBdOV0yMvlpT58o4mTpFj8PiGWs/uH2hUoe40cONFXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784777496; c=relaxed/simple;
	bh=qmvWcj+5uBFibt0yErcgzAeyOgdcyNGGb3ZtXplZdTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZHuBhKi66mWGhWj8JvKBARPLpaI7rXsXlOa+V7+4a9yO/D07N/6tFWFKcZJlBAUzJUkSqp+NMP8SGTuGNWR3Ldz2IT+UacSrJAuhsbohP6oetK7C8eaftpFMLmfzXm3YP1SGY69f4TXecyak9m1t7kH/+PQJyzOzA1uQxIvrDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5UNlbpQb; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5UNlbpQb"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IT0yY9Bxei0oo4EbXvT7H7M8cLXUJVI6426bDPUCmNo=;
	b=5UNlbpQbn7cdavhtse20oO5491oP8PfnGxXCtjRfUEouLDQRy2/yc2MlHiWsRKINwyhp7dHU7
	HZLOku2z9m2TJU/axRLhMxdEyirdHL6dYgTgWL4jHzIEnXDiygMJ8NVXPSUIKoG9x/4OWHjN1Kr
	6yO2CFssDTZEKiElykaRpyc=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h5Gcy30Mvzcb4c;
	Thu, 23 Jul 2026 11:21:54 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BE2740579;
	Thu, 23 Jul 2026 11:31:24 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 23 Jul
 2026 11:31:24 +0800
Message-ID: <0c95b1bc-9fd3-48c6-a44e-cd42e38eede1@huawei.com>
Date: Thu, 23 Jul 2026 11:31:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Test jited inline of
 bpf_get_smp_processor_id() for RISC-V
Content-Language: en-US
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn@kernel.org>, Puranjay Mohan <puranjay@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260722070127.9679-1-yangtiezhu@loongson.cn>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260722070127.9679-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/7/22 15:01, Tiezhu Yang wrote:
> Add the JITed inline instruction of bpf_get_smp_processor_id() for RISC-V
> to pass the test case.
> 
> On RISC-V, the 'cpu' field of 'struct thread_info' resides at offset 0x20,
> BPF_REG_0 maps to the a5 register, and the thread pointer (tp) is used as
> the base address. Therefore, the JIT compiler emits "lw a5, 0x20(tp)" to
> optimize this helper call.
> 
> Tested on a RISC-V virtual machine.
> 
> Before:
>    $ sudo ./test_progs -t verifier_jit_inline
>    #610/1   verifier_jit_inline/inline_bpf_get_current_task:OK
>    #610/2   verifier_jit_inline/inline_bpf_get_smp_processor_id:SKIP
>    #610     verifier_jit_inline:OK (SKIP: 1/2)
>    Summary: 1/1 PASSED, 1 SKIPPED, 0 FAILED
> 
> After:
>    $ sudo ./test_progs -t verifier_jit_inline
>    #610/1   verifier_jit_inline/inline_bpf_get_current_task:OK
>    #610/2   verifier_jit_inline/inline_bpf_get_smp_processor_id:OK
>    #610     verifier_jit_inline:OK
>    Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   tools/testing/selftests/bpf/progs/verifier_jit_inline.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> index 02e562f56f9d..c696baa5364b 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> @@ -25,6 +25,8 @@ SEC("fentry/bpf_fentry_test2")
>   __success __retval(0)
>   __arch_loongarch
>   __jited("	ld.wu	$a5, $tp, 16")
> +__arch_riscv64
> +__jited("	lw	a5, 0x20(tp)")
>   int inline_bpf_get_smp_processor_id(void)
>   {
>   	bpf_get_smp_processor_id();

Hi Tiezhu,

There are many places in selftest can be add __arch_riscv64 tag, I think 
we can enable them witch one patch.
