Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E070299943;
	Wed, 22 Jul 2026 02:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784688685; cv=none; b=HHB74DfUClMl8yDbV2fKo1KHAT/GL+f/0PM1pta584HBqgmn6qeZ67aoX0Czwu3xaa8TPSkb+hYFjCftFXpVeAqXIy+g5A0u7Odc84BWx1bp4iB1hWSc1QIqwDW6+X2SE4x3jA9R+ONEUuTBy+NTBazcXLCbJQtIdZ7XgZvOXEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784688685; c=relaxed/simple;
	bh=YIK25Q2g43R22APhyrYSPWuLaATLWDO8FiQDcDWRsr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ERhNRcr5fRH42nPHMTFEyMigGwfspY1khaz4VO9PG41q0w2vmMVEnpkVHAk0M0NO3+ZWXF7H9UAYhRpyip0JBX0AW2VAGsfMzr2ha9nQRa+77mrx0Mbd3GgHma5876V0H6DXiAQaWtLcTTZjNMcukrxaggR3IGEX/pczzcQmvF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=36IX7o0I; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="36IX7o0I"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qPWojk21eq0VDLmhqRWQmHQTKtv2iOwHul7FgxlQ/mg=;
	b=36IX7o0I6RjK4sEUg00opnq4qNmnNdoribyuy4RidHTzGIftjKCx/WPrUxsHX3KbYQ5g0xa8p
	1A1FGnJLKRTTm1BPXwLxkQGFZgJOACM9bSxE0D0qOCl8RyOpVwnq2AF7sqBohzjiplWjM7OUebr
	Tbwk2lrQfL9mdajNyXg/v+o=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4h4dn71WTVz1K96b;
	Wed, 22 Jul 2026 10:41:47 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 767C24057C;
	Wed, 22 Jul 2026 10:51:08 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 22 Jul
 2026 10:51:07 +0800
Message-ID: <14216058-3e55-4225-819f-9fce6ab7dffb@huawei.com>
Date: Wed, 22 Jul 2026 10:51:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Add get_preempt_count()
 support for RISC-V
Content-Language: en-US
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260722022906.8778-1-yangtiezhu@loongson.cn>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260722022906.8778-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100007.china.huawei.com (7.202.181.221)

Hi Tiezhu,

Thanks to respin it, we need this to cover more selftests.

On 2026/7/22 10:29, Tiezhu Yang wrote:
> Currently, there is no RISC-V support for get_preempt_count() and
> its fallback path always returns 0.
> 
> Add it so that bpf_in_interrupt(), bpf_in_nmi(), bpf_in_hardirq(),
> bpf_in_serving_softirq(), and bpf_in_task() work for RISC-V as well.
> 
> Given that RISC-V has supported CONFIG_THREAD_INFO_IN_TASK since its
> initial commit fbe934d69eb7 ("RISC-V: Build Infrastructure") in 2017,
> directly retrieve preempt_count from the thread_info embedded within
> task_struct via bpf_get_current_task_btf().
> 
> This aligns the implementation with arm64, powerpc, and loongarch.
> 
> Tested on a RISC-V virtual machine.
> 
> Before:
>    $ sudo ./test_progs -t exe_ctx
>    ...
>    #114     exe_ctx:FAIL
>    Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
> 
> After:
>    $ sudo ./test_progs -t exe_ctx
>    #114     exe_ctx:OK
>    Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Tested-by: Pu Lehui <pulehui@huawei.com>
> Reviewed-by: Pu Lehui <pulehui@huawei.com>
> ---
> RFC -> v1:
>    -- No code changes
>    -- Update the commit message
>    -- Add Tested-by and Reviewed-by
> https://lore.kernel.org/bpf/0191fe3f-b956-480d-aef2-a4d75f9e02de@huawei.com/
> 
>   tools/testing/selftests/bpf/bpf_experimental.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index 67ff7882299e..ff37ae5a113d 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -425,6 +425,8 @@ static inline int get_preempt_count(void)
>   	return bpf_get_lowcore()->preempt_count;
>   #elif defined(bpf_target_loongarch)
>   	return bpf_get_current_task_btf()->thread_info.preempt_count;
> +#elif defined(bpf_target_riscv)
> +	return bpf_get_current_task_btf()->thread_info.preempt_count;
>   #endif
>   	return 0;
>   }
> @@ -436,6 +438,7 @@ static inline int get_preempt_count(void)
>    *	* powerpc64
>    *	* s390x
>    *	* loongarch
> + *	* riscv
>    */
>   static inline int bpf_in_interrupt(void)
>   {
> @@ -458,6 +461,7 @@ static inline int bpf_in_interrupt(void)
>    *	* powerpc64
>    *	* s390x
>    *	* loongarch
> + *	* riscv
>    */
>   static inline int bpf_in_nmi(void)
>   {
> @@ -471,6 +475,7 @@ static inline int bpf_in_nmi(void)
>    *	* powerpc64
>    *	* s390x
>    *	* loongarch
> + *	* riscv
>    */
>   static inline int bpf_in_hardirq(void)
>   {
> @@ -484,6 +489,7 @@ static inline int bpf_in_hardirq(void)
>    *	* powerpc64
>    *	* s390x
>    *	* loongarch
> + *	* riscv
>    */
>   static inline int bpf_in_serving_softirq(void)
>   {
> @@ -505,6 +511,7 @@ static inline int bpf_in_serving_softirq(void)
>    *	* powerpc64
>    *	* s390x
>    *	* loongarch
> + *	* riscv
>    */
>   static inline int bpf_in_task(void)
>   {
