Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99A435F197;
	Tue,  7 Jul 2026 02:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783391419; cv=none; b=SxqU8w+iSXCjDskGxHVBNFM3HPj9a+PmYvjjuhNzPztSbGaV0RPFRmDbJKgr4achmS8qtrVKpakToTLgwSlKqgNOIW9ZSmbxi6SpIqH6KcItDg3aIc1v4xk4jpsIH8jv6+L5SWY/0//BS5t4qYD7x6BP+lFJz8wf082MKD3AfMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783391419; c=relaxed/simple;
	bh=Knj3+Nkn4tycrPczd5i2ZsJyeYTbthvI/jr0YaPZGqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oETzhvkiOH4QSGIXlnsjiYLLSYfjpzUf2PpBIi7DKei65g3qSRT3vO9n6v8G0GkGgoZtu/GNFlaQdIKRO4dSjUpxFY7v03qR6oKGS5jz8FvtT2CWhw61gyAU81vALQ1KJtFZJal/99tNuHn+52pucoNDpLqibhQZjVE2vILAuG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3TSi2fud; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3TSi2fud"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7heSrC/IM7vJFta8mTohU08Ode+2cW0PEDQBN7m9SKM=;
	b=3TSi2fudV+vFK8dyTFS/nc6dVlhHwt9ig4G6UYLObCbHfzLR9e35Qs5UatZbXBmhTu4R83fdE
	vcb2ZbH06KEfISowNhH8/OyAiAv0e+T8C9v7v+M3pRqyKIGBQkyLNXuZr2WRrfgJ1JXPWEI4PSs
	Z9XkVIS/izPkEP2qGYrhhVI=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gvQ200pwNzmVZt;
	Tue,  7 Jul 2026 10:20:56 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 8358A4056C;
	Tue,  7 Jul 2026 10:30:09 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 7 Jul
 2026 10:30:08 +0800
Message-ID: <fa8a040f-64c4-484f-9538-fb0ec287639f@huawei.com>
Date: Tue, 7 Jul 2026 10:30:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/3] riscv, bpf: Add support for BPF_SDIV and
 BPF_SMOD in RV32 JIT
Content-Language: en-US
To: <bot+bpf-ci@kernel.org>
CC: <visitorckw@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
	<luke.r.nels@gmail.com>, <xi.wang@gmail.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
	<emil@etsalapatis.com>, <alex@ghiti.fr>, <jserv@ccns.ncku.edu.tw>,
	<eleanor15x@gmail.com>, <marscheng@google.com>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<martin.lau@kernel.org>, <clm@meta.com>, <ihor.solodrai@linux.dev>
References: <20260706172846.3876436-2-visitorckw@gmail.com>
 <2ed385399f170538acc571665dca8036ccaa85dd1b9dfe987d8c7d566f59e8e5@mail.kernel.org>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <2ed385399f170538acc571665dca8036ccaa85dd1b9dfe987d8c7d566f59e8e5@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/7/7 2:12, bot+bpf-ci@kernel.org wrote:
>> commit c5a973b7fc82eeb9b84aaf80fc2673a94ab795b2
>> Author: Kuan-Wei Chiu <visitorckw@gmail.com>
>>
>>      riscv, bpf: Add support for BPF_SDIV and BPF_SMOD in RV32 JIT
>>
>>      The current rv32 bpf jit compiler incorrectly treats BPF_SDIV and
>>      BPF_SMOD as unsigned operations. The BPF instruction set allows
>>      signed division and modulo by reusing the BPF_DIV and BPF_MOD opcodes
>>      with the instruction offset set to 1.
>>
>>      Update the emit_alu_r32() function to accept an 'is_sdiv' variable and
>>      emit the correct div and rem instructions when the offset is 1.
>>
>>      Before this patch:
>>      [   44.161771] test_bpf: #165 ALU_SDIV_X: -6 / 2 = -3 jited:1 ret 2147483645 != -3 (0x7ffffffd != 0xfffffffd)FAIL (1 times)
>>      [   44.167385] test_bpf: #166 ALU_SDIV_K: -6 / 2 = -3 jited:1 ret 2147483645 != -3 (0x7ffffffd != 0xfffffffd)FAIL (1 times)
>>      [   44.171053] test_bpf: #169 ALU_SMOD_X: -7 % 2 = -1 jited:1 ret 1 != -1 (0x1 != 0xffffffff)FAIL (1 times)
>>      [   44.172081] test_bpf: #170 ALU_SMOD_K: -7 % 2 = -1 jited:1 ret 1 != -1 (0x1 != 0xffffffff)FAIL (1 times)
>>
>>      After this patch:
>>      [   16.002192] test_bpf: #165 ALU_SDIV_X: -6 / 2 = -3 jited:1 95 PASS
>>      [   16.002983] test_bpf: #166 ALU_SDIV_K: -6 / 2 = -3 jited:1 1059 PASS
>>      [   16.017167] test_bpf: #169 ALU_SMOD_X: -7 % 2 = -1 jited:1 136 PASS
>>      [   16.023002] test_bpf: #170 ALU_SMOD_K: -7 % 2 = -1 jited:1 109 PASS
>>
>>      Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> This looks like a bug fix for the original RV32 BPF JIT implementation.
> Should this include:
> 
>    Fixes: 5f316b65e99f ("riscv, bpf: Add RV32G eBPF JIT")

not need to add fixes tag, as this not a bugfix

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28811594040
