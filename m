Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D263C553F
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322581; cv=none; b=WosjvQ53hQe1UgLX/35AnbbFssMdLFyZ1vJzrlXa7Xre4ZZBOEnb59Y7cwOzLKaOLW2F5abvZYy+n5FFN0SfE+ym4+v94sQa1JlKeecYyhYRg9GmyibErAIim9Gd5Sr0AYQgfsKjvMx6LfKeT7YvbhEXm2fiWFJe8BJFQ080m9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322581; c=relaxed/simple;
	bh=793G8Fg70Xi/DClVrYVEIisgQu2USDkKfhP0N/gMUP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKQ+hiFxeR9ujcbP3VVLg6l/KKF+eZwHcTMvgTMmUDgM0UI9NUN5iJTWxRPCryBMQUs9xuXgkY3sFUDZsCW68SyqZT37VSpjBIBEH/76rk/K9pKe7s/IzuAvJqVmcRq8kulKrEKGGxg2lXXjYdW277CObcJdDdA9eXhFC+U75hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gtwmj15l9zYQtJ0
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 15:22:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5F1ED4058C
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 15:22:46 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDH+FnGV0tq4bnzAA--.46886S2;
	Mon, 06 Jul 2026 15:22:46 +0800 (CST)
Message-ID: <b4b2a9ed-d9bd-4dfa-817d-37a7865107ce@huaweicloud.com>
Date: Mon, 6 Jul 2026 15:22:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 4/6] riscv, bpf: Add RV_TAILCALL_OFFSET macro
 to format tailcall offset
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260629140048.733346-1-pulehui@huaweicloud.com>
 <20260629140048.733346-5-pulehui@huaweicloud.com>
 <20260629141034.D5F6F1F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260629141034.D5F6F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDH+FnGV0tq4bnzAA--.46886S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDZw1fXw4rKFy3Cr4UJwb_yoW5ArWrpF
	s3Jwn3CFyqqr1rKryDCF4qqa1avrZ5WF9rWr15CryaywnF9FykG3Z0k3yqqa45ur4UKa10
	qFyq93s3uas8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1QVy3UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/6/29 22:10, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] The tail call offset macro `RV_TAILCALL_OFFSET` incorrectly double-counts the KCFI preamble when `CONFIG_CFI` is enabled, causing tail-called programs to skip their stack pointer adjustment and corrupt the caller's stack frame.
> --
> 
> commit 655037e3f7e62935bb76d41ae8cffb13d2a38d50
> Author: Pu Lehui <pulehui@huawei.com>
> 
> riscv, bpf: Add RV_TAILCALL_OFFSET macro to format tailcall offset
> 
> Add RV_TAILCALL_OFFSET macro to format tailcall offset, and correct the
> relevant comments.
> 
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index 69512d93ca4a7..c239696cca646 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -21,6 +21,8 @@
>>   #define RV_KCFI_NINSNS (IS_ENABLED(CONFIG_CFI) ? 1 : 0)
>>   /* imm that allows emit_imm to emit max count insns */
>>   #define RV_MAX_COUNT_IMM 0x7FFF7FF7FF7FF7FF
>> +/* kcfi, fentry and TCC init insns will be skipped on tailcall */
>> +#define RV_TAILCALL_OFFSET ((RV_KCFI_NINSNS + RV_FENTRY_NINSNS + 1) * 4)
> 
> [Severity: Critical]
> This is a pre-existing issue, but does RV_TAILCALL_OFFSET incorrectly
> double-count the KCFI preamble when CONFIG_CFI is enabled?
> 
> Since prog->bpf_func already skips the 4-byte KCFI hash (because it points
> to ctx->ro_insns + cfi_get_offset()), it looks like including RV_KCFI_NINSNS
> here overshoots the correct jump target by 4 bytes.
> 
> Does this skip the necessary stack pointer adjustment instruction, causing
> tail-called programs to execute prologue register saves using the unadjusted
> stack pointer of the caller and potentially corrupting the kernel stack?

oops, my bad, kcfi insn will be skipped during prog->bpf_func setup, so 
DO NOT need to skip this again when tailcall.

Will revert that bad patch, thanks sashiko.

> 
> [ ... ]
> 
>> @@ -272,9 +274,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
>>   	if (!is_tail_call)
>>   		emit_addiw(RV_REG_A0, RV_REG_A5, 0, ctx);
>>   	emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
>> -		  /* kcfi, fentry and TCC init insns will be skipped on tailcall */
>> -		  is_tail_call ? (RV_KCFI_NINSNS + RV_FENTRY_NINSNS + 1) * 4 : 0,
>> -		  ctx);
>> +		  is_tail_call ? RV_TAILCALL_OFFSET : 0, ctx);
>>   }
> 
> [ ... ]
> 
>> @@ -394,7 +394,7 @@ static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
>>   	off = ninsns_rvoff(tc_ninsn - (ctx->ninsns - start_insn));
>>   	emit_branch(BPF_JEQ, RV_REG_T2, RV_REG_ZERO, off, ctx);
>>   
>> -	/* goto *(prog->bpf_func + 4); */
>> +	/* goto *(prog->bpf_func + RV_TAILCALL_OFFSET); */
>>   	off = offsetof(struct bpf_prog, bpf_func);
>>   	if (is_12b_check(off, insn))
>>   		return -1;
> 

