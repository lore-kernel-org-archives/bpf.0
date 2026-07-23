Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9245E21773D;
	Thu, 23 Jul 2026 01:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784771957; cv=none; b=gERvh9oWj6/eHk/CQxDJbR0tjWlpRH9bI0fLhK0ubUNAYDziZFonDSVVnH9ukpOJqZF8QFhSF1HKtK65TS9qyntTVMJBfFZ9DN+YFhcCdsRs5q+mF1Ugg3RpAsB0z8mJ0kahJ7iVV0xfS3uSco89dDnqCN2XcfNIrCMW95PVgzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784771957; c=relaxed/simple;
	bh=0zGdOayHKikByeaK7XlIU4XUa7/8PoPbSmQjWllHpbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HV6DgoLeO1T5YB49g6PCbQ57jpIVHtgMvOB1Y/NpXKPfG6ObBUdoVlMsf3qX96WlhFeQhPh3zFAcEs4HnEeFLkPKSr0b89PJh/AWZnmShKFW+XbFUgrlIgzmJdFA8edkiDDYINCZZ6V+s8xN90AmPq0UE5KEgok1R5CfVjeZN84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 17018a86863a11f1aa26b74ffac11d73-20260723
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:bd2c8e79-be37-4086-a867-be825a9344c7,IP:0,U
	RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:2
X-CID-META: VersionHash:e7bac3a,CLOUDID:20777172135575d246cb4784041c59a3,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|136|865|898,TC:nil,Conte
	nt:4|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 17018a86863a11f1aa26b74ffac11d73-20260723
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 494042459; Thu, 23 Jul 2026 09:59:07 +0800
Message-ID: <9dc7052f-4004-43c8-8e4b-e93134bff469@kylinos.cn>
Date: Thu, 23 Jul 2026 09:59:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/3] bpf, riscv: add support for timed
 may_goto
To: Pu Lehui <pulehui@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Luke Nelson <luke.r.nels@gmail.com>,
 Xi Wang <xi.wang@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Shuah Khan <shuah@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260722-riscv-bpf-timed-may-goto-v4-0-e117e6337bc7@kylinos.cn>
 <20260722-riscv-bpf-timed-may-goto-v4-1-e117e6337bc7@kylinos.cn>
 <53b49505-f593-44d1-a4ea-b3ad81f6cc0b@huawei.com>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <53b49505-f593-44d1-a4ea-b3ad81f6cc0b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/7/22 18:18, Pu Lehui wrote:
> 
> On 2026/7/22 12:21, Feng Jiang wrote:
>> Implement arch_bpf_timed_may_goto() for the RV64 JIT. The argument and
>> return value are carried in BPF_REG_AX, and BPF R0-R5 are preserved
>> across the call to the generic bpf_check_timed_may_goto().
>>
>> Enable bpf_jit_supports_timed_may_goto() so the verifier uses the timed
>> expansion path.
>>
>> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>

[ ...] 

>> diff --git a/arch/riscv/net/bpf_timed_may_goto.S b/arch/riscv/net/bpf_timed_may_goto.S
>> new file mode 100644
>> index 000000000000..f4bf2cd10586
>> --- /dev/null
>> +++ b/arch/riscv/net/bpf_timed_may_goto.S
>> @@ -0,0 +1,47 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2026 Feng Jiang <jiangfeng@kylinos.cn> */
>> +
>> +#include <linux/linkage.h>
>> +#include <asm/asm.h>
>> +
>> +/*
>> + * Trampoline for the BPF timed may_goto loop bound. Custom calling convention:
>> + *    - input:  stack offset in BPF_REG_AX (t0)
>> + *    - output: updated count in BPF_REG_AX (t0)
>> + *
>> + * Calls bpf_check_timed_may_goto(ptr) with the standard RISC-V ABI, where
>> + * ptr = BPF_REG_FP (s5) + BPF_REG_AX (t0). BPF R0-R5 (a5, a0-a4) are saved
>> + * across the call; BPF_REG_FP (s5) is callee-saved and needs no saving.
>> + */
>> +
>> +SYM_FUNC_START(arch_bpf_timed_may_goto)
>> +    addi    sp, sp, -64
>> +    sd    ra, 56(sp)
>> +    sd    s0, 48(sp)
>> +    addi    s0, sp, 64
>> +
>> +    /* Save BPF registers R0-R5 (a5, a0-a4) */
>> +    sd    a5, 40(sp)
>> +    sd    a0, 32(sp)
>> +    sd    a1, 24(sp)
>> +    sd    a2, 16(sp)
>> +    sd    a3, 8(sp)
>> +    sd    a4, 0(sp)
>> +
>> +    add    a0, t0, s5
>> +    call    bpf_check_timed_may_goto
>> +    mv    t0, a0
>> +
>> +    /* Restore BPF registers R0-R5 */
>> +    ld    a4, 0(sp)
>> +    ld    a3, 8(sp)
>> +    ld    a2, 16(sp)
>> +    ld    a1, 24(sp)
>> +    ld    a0, 32(sp)
>> +    ld    a5, 40(sp)
>> +
>> +    ld    s0, 48(sp)
>> +    ld    ra, 56(sp)
>> +    addi    sp, sp, 64
>> +    ret
>> +SYM_FUNC_END(arch_bpf_timed_may_goto)
> 
> I think we should use REG_S/REG_L/SZREG like in arch/riscv ([0]) – it keeps us in sync with upstream and will make it easier if we may later port timed_may_goto to RV32.
> 
> [0] arch/riscv/kernel/mcount.S

Agreed, will switch to REG_S/REG_L/SZREG in v5.

-- 
With Best Regards,
Feng Jiang

