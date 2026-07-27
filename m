Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37329346FA1
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116961; cv=none; b=X68C1Oytgq2+ifvv6lr0p0+tl0qaSG2g74Nmf8JJw8BcHCDvQOduvVw0BEg4U1Gr56a66z5Gf/lmPDfW5XJcxoceqePI3JGnZ5AhAUtpoc0wCafpRnnAizpPKlrrBDeVNL3B+8wvWTx42Zg3T67oSFJSQ62TCex0gHptk3jcGDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116961; c=relaxed/simple;
	bh=386xT8si3MAf5gIsAeAzfgva4234ycPNg7EDcK6TFp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAK6nxZOZ0awkt59zTr/6+Xcg7ipXkcn/9kjk2uvB9ql5r15/VxObUsaF8zlRPeyjvedle7Vx7tPaVuseFhT+ObvHMi/K1LDUXN/pTUV6WXMvktFVp7TD9TMp7BxgP4Hesag1ReIqxynjQNk7u82tKkg7mQmBMegSaToMioP6jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h7hMD6kPvzKHMPb
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 09:48:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0956B4058F
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 09:49:16 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgAnFtIbuWZqg2ZWAA--.38780S2;
	Mon, 27 Jul 2026 09:49:15 +0800 (CST)
Message-ID: <183096a4-a348-44d8-9fec-8afea10e8345@huaweicloud.com>
Date: Mon, 27 Jul 2026 09:49:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 8/9] riscv, bpf: Adjust bpf_func to account
 for CFI offset in bpf_jit_free
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260725154915.2488611-1-pulehui@huaweicloud.com>
 <20260725154915.2488611-9-pulehui@huaweicloud.com>
 <20260725155706.54C5C1F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260725155706.54C5C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAnFtIbuWZqg2ZWAA--.38780S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW5Xr1UXw45ZF4xZF48tFb_yoW5JFy3pF
	n8Gryak3yqgrs7KFsFqw18KFy8Jw48W3WrGryj9ry0gFnxuryIgFna93y8WFZ8GryUJw18
	XF4DWFy3Ca4rJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6x
	kF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
	WIevJa73UjIFyTuYvjxUrNtxDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/7/25 23:57, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] bpf_jit_free() ignores the error return value of bpf_jit_binary_pack_finalize(), leading to a Use-After-Free and Double Free of the JIT ro_header.
> --
> 
> --- Patch [8]: [PATCH bpf-next v3 8/9] riscv, bpf: Adjust bpf_func to account for CFI offset in bpf_jit_free ---
> commit a0a806deebfc4afdceb1a23fa093826ade44c8cf
> Author: Pu Lehui <pulehui@huawei.com>
> 
> riscv, bpf: Adjust bpf_func to account for CFI offset in bpf_jit_free
> 
> When CFI is enabled, the actual BPF program entry point is shifted forward
> by a CFI preamble. This commit subtracts the CFI offset from prog->bpf_func
> in bpf_jit_free() to restore the original JITed allocation address before
> freeing it, preventing an invalid memory free.
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
> This is a pre-existing issue, but does ignoring the return value of
> bpf_jit_binary_pack_finalize() (called just prior to this diff snippet)
> lead to a use-after-free and double free?

patch 9 has been covered this.

> 
> If bpf_jit_binary_pack_finalize() fails, it frees ro_header internally:
> 
> kernel/bpf/core.c:bpf_jit_binary_pack_finalize() {
>      ...
>      if (IS_ERR(ptr)) {
>          bpf_prog_pack_free(ro_header, ro_header->size);
>          return PTR_ERR(ptr);
>      }
>      ...
> }
> 
> Back in bpf_jit_free(), we ignore this failure, extract the same freed
> header via bpf_jit_binary_pack_hdr(), and call bpf_jit_binary_pack_free()
> which dereferences ro_header->size and frees it again:
> 
> kernel/bpf/core.c:bpf_jit_binary_pack_free() {
>      u32 size = ro_header->size;
> 
>      bpf_prog_pack_free(ro_header, size);
>      ...
> }
> 
> Should bpf_jit_free() check if bpf_jit_binary_pack_finalize() returned
> an error before attempting to extract and free the header again?
> 
>>   		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
> 

