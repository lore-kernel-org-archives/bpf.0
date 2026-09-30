Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152C43502A8;
	Wed, 30 Sep 2026 06:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790750843; cv=none; b=KTnHkIcjIwV2BFq3IIQlUzfqG0v5eP6ZzAgfd106k/6L4Fbq2Z1GMq9Qf3JdlgShQ7ROyuR449wnuJIIxcCAss3aqnnBLegFtJVMeUrntJJkLAlEFKREJnex/4BrYftKybTz46Mj6Uhg+FaSPEiVK832MzJPzJYZdydckdzsIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790750843; c=relaxed/simple;
	bh=uZbKw8POGeFl20KyakO1qWE+Jvbro+kWIARjBbqCgxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FzNi3Z6nr5EVeZigBOtNfCOmK4Ez/vhijHBRPWDaF//NzqDlc+JrtCeQKUPkoccT8En7UpsOb7zCKAPMf++ByZ7v5OfnxomYEFaR0bJJq2Hw0ErjhPMXteHE6CYpA8JVRk9fJHK6aafklFp9R2DbejyZjPI11EBGevvVz+2wA5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FCiyFpLf; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FCiyFpLf"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hbGRKAiN+M+DetjoSs0ixVYVBfZRXUSaMrHD9zTQRGY=;
	b=FCiyFpLftKLenUMsnY89EHh+viyyMUrKQXs528WFnizT89rpnmODxyJ2kKnzO65B06fkKBG7m
	dDVvwZ5V/GTKou3Xnh+XKxp/+q8l7vQ25wu0oHxHWb6Q4M+N9Nt2eXvU5aRTQ+WZtZyX1cCXT0h
	lPWeaZ0pwv9Tzzh810fYPYM=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hvldt5NxRz1prLV;
	Wed, 30 Sep 2026 14:34:58 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D43640537;
	Wed, 30 Sep 2026 14:47:10 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 14:47:09 +0800
Message-ID: <e887cfb6-8f68-4a0d-949b-cdf5584b1834@huawei.com>
Date: Wed, 30 Sep 2026 14:47:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/2] riscv, bpf: Support indirect calls to bpf
 subprogs (callx)
Content-Language: en-US
To: Pu Lehui <pulehui@huaweicloud.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn@kernel.org>, <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
	<eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
	<emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Puranjay
 Mohan <puranjay@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>
References: <20260929085450.1852617-1-pulehui@huaweicloud.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260929085450.1852617-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100007.china.huawei.com (7.202.181.221)

This series fail to apply, I have resent a new one.


https://lore.kernel.org/all/20260930064928.1909085-1-pulehui@huaweicloud.com/T/#t

On 2026/9/29 16:54, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> This series implements support for indirect calls to bpf subprogs on
> riscv64 and enables the corresponding selftests.
> 
> Meanwhile, this series also resolves the test_verifier failures
> previously captured by riscv-bpf-daily due to missing callx support [0].
> 
> [0] https://github.com/pulehui/riscv-bpf-daily/issues/11
> 
> Pu Lehui (2):
>    riscv, bpf: Support indirect calls to bpf subprogs (callx)
>    selftests/bpf: Enable callx related testcases for RV64
> 
>   arch/riscv/net/bpf_jit_comp64.c                      | 12 ++++++++++++
>   .../selftests/bpf/prog_tests/callx_func_ptr_map.c    |  3 ++-
>   .../selftests/bpf/prog_tests/callx_rodata_lskel.c    |  3 ++-
>   tools/testing/selftests/bpf/progs/verifier_callx.c   |  3 ++-
>   .../selftests/bpf/progs/verifier_callx_rodata.c      |  3 ++-
>   5 files changed, 20 insertions(+), 4 deletions(-)
> 
