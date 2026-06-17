Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC912D2488
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 03:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781667823; cv=none; b=fhL24RHpBzCkSuPUtPxIDbtqToajMFXoXTGXbmSThNPiyacrwFdby3u6GLG39GJZL3KxTa5TBWlOLmMiuvFFscNhRll7lgWk7577PIRsOQXopHJlrqL0UYI634Pu/AW/JaidjvH1uz9i6BRUwvy36IYHV2BThzT031d9m1Ddj7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781667823; c=relaxed/simple;
	bh=TafRMDIpMbGp+E0deR9Uo/5qFaKDeUrP4kNpvAx+3g4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dgTAmIG/6CkbLvjTWl3s0BWPLoK/8aqqPFtKchob4v7zINEV5p3Gcm+zJeZsV9fkbrKja5COekBJgsA5a4YP7v3FrWvCzzi1EslKmH6UjAYvyp865X547jRnPx0Ryo/VYWMnKFnrHpdopZIvxq+Ad3QTqe+Jqr9vnLlKIgT+XEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cL6ILyW/; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cL6ILyW/; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cL6ILyW/";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cL6ILyW/"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9tGW59A/xDTVSUsa+VveumO8ZtEvO5di0CCgVmyKwBg=;
	b=cL6ILyW/IwlzBp1zHGKYugcxknlIBE8FhNHU6sB+FCmQZnS96jt4/fjtEpmzDOQvBji+d/S+p
	E0OAKDpZpe1k4gRNmdxVN9+Pu2GqLkV7RLPVMrMCBqpFIpTAAJ/dAeYUXoy+ncKwZfJeWnutcKo
	CfOLXhwUC5cz+GJf+oVQrjA=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gg8cy1HGszcZyX;
	Wed, 17 Jun 2026 11:35:14 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9tGW59A/xDTVSUsa+VveumO8ZtEvO5di0CCgVmyKwBg=;
	b=cL6ILyW/IwlzBp1zHGKYugcxknlIBE8FhNHU6sB+FCmQZnS96jt4/fjtEpmzDOQvBji+d/S+p
	E0OAKDpZpe1k4gRNmdxVN9+Pu2GqLkV7RLPVMrMCBqpFIpTAAJ/dAeYUXoy+ncKwZfJeWnutcKo
	CfOLXhwUC5cz+GJf+oVQrjA=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gg8cq4SV8z1T4Fg;
	Wed, 17 Jun 2026 11:35:07 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 301DA40537;
	Wed, 17 Jun 2026 11:43:38 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 17 Jun
 2026 11:43:37 +0800
Message-ID: <0191fe3f-b956-480d-aef2-a4d75f9e02de@huawei.com>
Date: Wed, 17 Jun 2026 11:43:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next 1/2] selftests/bpf: Add riscv support for
 get_preempt_count()
Content-Language: en-US
To: Tiezhu Yang <yangtiezhu@loongson.cn>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>
References: <20260420111516.19982-1-yangtiezhu@loongson.cn>
 <20260420111516.19982-2-yangtiezhu@loongson.cn>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260420111516.19982-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/4/20 19:15, Tiezhu Yang wrote:
> There is no riscv support for get_preempt_count() currently and its
> fallback path always returns 0, just add it so that bpf_in_interrupt(),
> bpf_in_nmi(), bpf_in_hardirq(), bpf_in_serving_softirq(), bpf_in_task()
> works for riscv as well. With this patch, "./test_progs -t exe_ctx"
> should pass on riscv.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   tools/testing/selftests/bpf/bpf_experimental.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index 2234bd6bc9d3..e5c039bc44cb 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -505,6 +505,8 @@ static inline int get_preempt_count(void)
>   	return bpf_get_current_task_btf()->thread_info.preempt_count;
>   #elif defined(bpf_target_s390)
>   	return bpf_get_lowcore()->preempt_count;
> +#elif defined(bpf_target_riscv)
> +	return bpf_get_current_task_btf()->thread_info.preempt_count;
>   #endif
>   	return 0;
>   }
> @@ -515,6 +517,7 @@ static inline int get_preempt_count(void)
>    *	* arm64
>    *	* powerpc64
>    *	* s390x
> + *	* riscv
>    */
>   static inline int bpf_in_interrupt(void)
>   {
> @@ -536,6 +539,7 @@ static inline int bpf_in_interrupt(void)
>    *	* arm64
>    *	* powerpc64
>    *	* s390x
> + *	* riscv
>    */
>   static inline int bpf_in_nmi(void)
>   {
> @@ -548,6 +552,7 @@ static inline int bpf_in_nmi(void)
>    *	* arm64
>    *	* powerpc64
>    *	* s390x
> + *	* riscv
>    */
>   static inline int bpf_in_hardirq(void)
>   {
> @@ -560,6 +565,7 @@ static inline int bpf_in_hardirq(void)
>    *	* arm64
>    *	* powerpc64
>    *	* s390x
> + *	* riscv
>    */
>   static inline int bpf_in_serving_softirq(void)
>   {
> @@ -580,6 +586,7 @@ static inline int bpf_in_serving_softirq(void)
>    *	* arm64
>    *	* powerpc64
>    *	* s390x
> + *	* riscv
>    */
>   static inline int bpf_in_task(void)
>   {

Hi Tiezhu,

Thanks for doing this, feel free to add:

Tested-by: Pu Lehui <pulehui@huawei.com>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
