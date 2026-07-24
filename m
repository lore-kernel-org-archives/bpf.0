Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CFF30566A
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 01:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784857257; cv=none; b=NVrx5R1bdjCoaqRmX1G71wphw+5JmD55hWkWqudm5qG0j9patWvEmXUjquIBzMeybTIc1B7HFkzY88yIN6rZnjghhUosTDXa4qIiRQ8o8Fry6QA8xE44K55PPEBOCC7JKOT5UYoM3F95CKPLm7xc3LbPKOKToLQxArXzGbR85WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784857257; c=relaxed/simple;
	bh=sR7SlHhGAvn2qNpSSJg51t+g91muCwDUDu1pKmcwbrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMj7kB8nwTicFa5OarXhXIYBhQG8J0y+JDprOyG04DvSBYM0zvX3dogfHqRsrs2YHiMsgARv9btaUXNZD88ZstrnGe1U4mO9xy6xkDV8MpLy/OxWA0sAB0EhEmNBS6B+zJ2Nye2SfbvXSu+3a74D9DtflX9Od1kgCKVvrZZe06w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h5rK1697WzKHMSj
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 09:40:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0DF904076D
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 09:40:52 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgBXiVqjwmJqkxleCQ--.28046S2;
	Fri, 24 Jul 2026 09:40:52 +0800 (CST)
Message-ID: <7b6811a6-c4b4-4eab-b121-bffe2af350cd@huaweicloud.com>
Date: Fri, 24 Jul 2026 09:40:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/4] riscv, bpf: Adjust bpf_func to account for
 CFI offset in bpf_jit_free
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260722112754.1615201-1-pulehui@huaweicloud.com>
 <20260722112754.1615201-4-pulehui@huaweicloud.com>
 <20260722113814.40F971F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260722113814.40F971F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXiVqjwmJqkxleCQ--.28046S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDZw48uFWDtw1Dtry7Wrg_yoW5Kw15pF
	n8Jryak3yqgw1xKF4qqr18KF1xJw4xW3W7Gry8urZ2g3ZxWr92gF9ak3y8WrZ8JrWUAw10
	qFZ5WF17Ca4kX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1QVy3UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/22 19:38, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Error path in `bpf_jit_free()` ignores the return value of `bpf_jit_binary_pack_finalize()`, leading to a use-after-free and double-free of the `ro_header`.
> - [High] The BPF JIT module memory charge is permanently leaked when `bpf_jit_binary_pack_finalize()` fails.
> --
> 
> --- Patch [3]: [PATCH bpf-next 3/4] riscv, bpf: Adjust bpf_func to account for CFI offset in bpf_jit_free ---
> commit 2c7946882741f9c426f80073ff738910e58599f5
> Author: Pu Lehui <pulehui@huawei.com>
> 
> riscv, bpf: Adjust bpf_func to account for CFI offset in bpf_jit_free
> 
> Adjusts the BPF program entry point in bpf_jit_free() by subtracting the CFI
> offset. This correctly restores the original JITed allocation address before
> freeing it.
> 
>> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
>> index cbfcd287ea166..059db1adeaf8d 100644
>> --- a/arch/riscv/net/bpf_jit_core.c
>> +++ b/arch/riscv/net/bpf_jit_core.c
>> @@ -237,6 +237,7 @@ void bpf_jit_free(struct bpf_prog *prog)
>>   			kvfree(jit_data->ctx.offset);
>>   			kfree(jit_data);
>>   		}
>> +		prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();
>>   		hdr = bpf_jit_binary_pack_hdr(prog);
>>   		bpf_jit_binary_pack_free(hdr, NULL);
> 
> [Severity: High]
> This is a pre-existing issue, but does bpf_jit_free() ignore the return value
> of bpf_jit_binary_pack_finalize() and risk a use-after-free and double-free?
> 
> When bpf_jit_binary_pack_finalize() fails, it frees the ro_header internally:
> 
> kernel/bpf/core.c:bpf_jit_binary_pack_finalize() {
>      ...
> 	if (IS_ERR(ptr)) {
> 		bpf_prog_pack_free(ro_header, ro_header->size);
> 		return PTR_ERR(ptr);
> 	}
>      ...
> }
> 
> But here in bpf_jit_free(), the error is ignored, and bpf_jit_binary_pack_free()
> is called with the same header:
> 
> arch/riscv/net/bpf_jit_core.c:bpf_jit_free() {
>      ...
> 		hdr = bpf_jit_binary_pack_hdr(prog);
> 		bpf_jit_binary_pack_free(hdr, NULL);
>      ...
> }
> 
> kernel/bpf/core.c:bpf_jit_binary_pack_free() {
>      ...
> 	u32 size = ro_header->size;
> 
> 	bpf_prog_pack_free(ro_header, size);
>      ...
> }
> 
> If finalization fails, could this lead to a use-after-free read of
> ro_header->size, followed by a double-free of the ro_header?
> 
> [Severity: High]
> This is also a pre-existing issue, but does the error path of
> bpf_jit_binary_pack_finalize() permanently leak the BPF JIT module memory
> charge?
> 
> When bpf_jit_binary_pack_finalize() fails and frees ro_header, it does not
> uncharge the memory:
> 
> kernel/bpf/core.c:bpf_jit_binary_pack_finalize() {
>      ...
> 	if (IS_ERR(ptr)) {
> 		bpf_prog_pack_free(ro_header, ro_header->size);
> 		return PTR_ERR(ptr);
> 	}
>      ...
> }
> 
> In other places like bpf_int_jit_compile(), a finalization failure results in
> the pointers being set to NULL and bypassing bpf_jit_binary_pack_free(), which
> would normally uncharge the memory:
> 
> arch/riscv/net/bpf_jit_core.c:bpf_int_jit_compile() {
>      ...
> 		if (WARN_ON(bpf_jit_binary_pack_finalize(...))) {
> 			/* ro_header has been freed */
> 			jit_data->ro_header = NULL;
> 			jit_data->header = NULL;
> 			goto out_free_hdr;
> 		}
>      ...
> }
> 
> Could repeated failures exhaust the JIT memory limit, resulting in a local DoS
> by preventing further BPF program loading?
> 
>>   		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
>>   	}
> 

patch 4 have been covered this two issues.

