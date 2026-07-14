Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04F63033E6;
	Tue, 14 Jul 2026 02:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996637; cv=none; b=bkInv8G+r5x7crJxKGOhKLnAC1v1wVtByW59RNULig69760DAbfKirFBp2lgRYDsYuD/sFFZBbr1FOj+n7nPtPWrGgIHWtzzMDFPmyH5IkgfrtmCwIMV3T+so3P0iucyd/GHC/JhC7LLyPZnbJovw5UmVul9B14r+juii44Qbdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996637; c=relaxed/simple;
	bh=ey3qwpkHp2SmqFv2KjnNf7pRXCLtxgGvtd2BT8WltDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OHk3w1ab3wPGb3zbOIQMNALKP3ENyapRYFG0mGEcI8HVP6bjj6VCbU3NhRosMIt2jUwAvC4zNNiH33rbu0zP0tC09luedwVI/YFky83eTs4Rw0UwfoIuq2YfinLF4Us9JHzSLR22vSky3xhUFtsCq5wdcezaE/oHDxbWgjBUxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=M8kQfk8U; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="M8kQfk8U"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xxaMPpKGBoyUhiBOOpGG/Nc0N/n7BrdLavegstx8CJw=;
	b=M8kQfk8UblWW5eFdQyQaVxRqv0UUgN+anqWkoZsoqu1e1dBCUp26UMQBu2GcodHEsLSCnqDhf
	kVyKVNTSpLh8SzqpXMwMm/GShJ4tYwj4f1Cju9j3/n9ZT/ATr6Vcnu9bpLEJJfawA1s8mN/iTiT
	9viDiQs08Xz8U0zxT+txH8A=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gzjrP3bsxz12LGB;
	Tue, 14 Jul 2026 10:27:33 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 0422C40537;
	Tue, 14 Jul 2026 10:37:12 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 14 Jul
 2026 10:37:11 +0800
Message-ID: <66bbcfac-7fe8-4823-bf30-dccd8adbe2f4@huawei.com>
Date: Tue, 14 Jul 2026 10:37:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/3] riscv, bpf: Add support for signed
 operations and 32-bit atomics
Content-Language: en-US
To: Kuan-Wei Chiu <visitorckw@gmail.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
	<memxor@gmail.com>, <luke.r.nels@gmail.com>, <xi.wang@gmail.com>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
CC: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<jolsa@kernel.org>, <emil@etsalapatis.com>, <alex@ghiti.fr>,
	<jserv@ccns.ncku.edu.tw>, <eleanor15x@gmail.com>, <marscheng@google.com>,
	<bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260714002451.4091139-1-visitorckw@gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260714002451.4091139-1-visitorckw@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/7/14 8:24, Kuan-Wei Chiu wrote:
> Add support for missing signed operations and 32-bit atomics in the
> RV32 BPF JIT compiler.
> 
> The current implementation lacks support for BPF_SDIV, BPF_SMOD, and
> BPF_MOVSX, ignoring the instruction offset field and treating them as
> unsigned or zero-extended. Introduce support for these operations by
> checking the offset field and emitting the corresponding instructions.
> 
> Additionally, we leverage the mandatory A extension to natively support
> 32-bit BPF atomics (and, or, xor, xchg) by mapping them directly to
> amo*.w instructions. BPF_CMPXCHG continues to fall back to the
> interpreter.
> 
> As a result, test_bpf.ko now runs with 0 failures, and the total number
> of successfully JIT'ed test cases increases from 843 to 902.
> ---
> Changes in v4:
> - Add a 'dst' param to emit_bpf_atomic().
> 
> Changes in v3:
> - Pass insn directly to emit_alu_r32().
> - Remove the Fixes: tag and update title.
> - Consolidate size, mode, and off into insn for emit_store_r64().
> 
> Changes in v2:
> - Add missing Fixes tags.
> - Fix memory ordering by emitting aq=1, rl=1
> 
> Kuan-Wei Chiu (3):
>    riscv, bpf: Add support for BPF_SDIV and BPF_SMOD in RV32 JIT
>    riscv, bpf: Add support for BPF_MOVSX in RV32 JIT
>    riscv, bpf: Add 32 bit atomic operations to RV32 JIT
> 
>   arch/riscv/net/bpf_jit_comp32.c | 111 +++++++++++++++++++++++++++-----
>   1 file changed, 95 insertions(+), 16 deletions(-)
> 

before:
test_bpf: Summary: 846 PASSED, 216 FAILED, [847/847 JIT'ed]

after:
test_bpf: Summary: 918 PASSED, 144 FAILED, [906/906 JIT'ed]


Tested-by: Pu Lehui <pulehui@huawei.com>
