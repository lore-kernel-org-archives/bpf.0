Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE9E372B41
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862904; cv=none; b=EpAtD7F3GEO26TARVXE3QilhGTIm7STtDK/3W6kloHt53HNTjs8Q9Xx/pATX/Eu0aOLJeoPXI/mMtRdOw5apiZvMKaFusrbtFbj7AK7XDx+bIQ+dADqS9IziHodkaQw5GJW/1HXTcrcoQ+Dw566cCvT+gAkpp5/0KGszHRBiFvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862904; c=relaxed/simple;
	bh=/zzxxtBz/YcFxzyJw0I8LJiPVv+Tc7Dzp9NULhkpg88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8RP5CnqlfY7uM2sDTh+w/iU2tAaU++0zVLo1Nf2jEgWukQ5UiPkuwEYBE/tZu3KPojaCLxIncUDwR1Q3BhrdwoHccrzj5yNNhZKwONbjnaSYpyThDmXsRQzA8izKrRr6h7A3z16wHDvtO3hDqQvhc3zDqHMcXZTiBMP49wudMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h5tPv0YdGzYQtm6
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 11:14:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CB8FE40590
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 11:14:58 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgBHdlex2GJq7iBmCQ--.5168S2;
	Fri, 24 Jul 2026 11:14:58 +0800 (CST)
Message-ID: <50542597-a7b3-40db-a680-fcca0f8b98cd@huaweicloud.com>
Date: Fri, 24 Jul 2026 11:14:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/4] bpf: Fix double-free RO header in
 bpf_jit_free
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260722112754.1615201-1-pulehui@huaweicloud.com>
 <20260722112754.1615201-5-pulehui@huaweicloud.com>
 <20260722113354.503391F00A3A@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260722113354.503391F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHdlex2GJq7iBmCQ--.5168S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDZw4UGr48JFW5GFy3Arb_yoW5tryUpF
	1UCa4Yyw4qqw43K397tw18CF45Xw48J3WUuayrCrW7KFn09r92gFySk3y8WFW5Jr4UCw4F
	qFyqgr13Ca4kXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/22 19:33, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] When `bpf_jit_binary_pack_finalize` fails, `bpf_jit_binary_pack_free` reads an uninitialized/garbage `size` from `ro_header->size`, leading to a kernel panic in `vfree()` and module memory uncharge counter corruption.
> --
> 
> --- Patch [4]: [PATCH bpf-next 4/4] bpf: Fix double-free RO header in bpf_jit_free ---
> commit 4586888c771a3a31208f8ce31608697cc4147140
> Author: Pu Lehui <pulehui@huawei.com>
> 
> bpf: Fix double-free RO header in bpf_jit_free
> 
> This commit modifies bpf_jit_binary_pack_finalize() to drop the implicit free
> of ro_header on failure. Architectures are updated to explicitly call
> bpf_jit_binary_pack_free() in their error paths instead.
> 
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index de7515ea1beae..d017bb0397b88 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -3988,7 +3988,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>>   			 * Both cases are serious bugs and justify WARN_ON.
>>   			 */
>>   			if (WARN_ON(bpf_jit_binary_pack_finalize(header, rw_header))) {
>> -				/* header has been freed */
>> +				bpf_jit_binary_pack_free(header, NULL);
>>   				header = NULL;
>>   				goto out_image;
>>   			}
> 
> [ ... ]
> 
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 47fe047ad30b8..77195911a3b37 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -1237,10 +1237,9 @@ int bpf_jit_binary_pack_finalize(struct bpf_binary_header *ro_header,
>>   
>>   	kvfree(rw_header);
>>   
>> -	if (IS_ERR(ptr)) {
>> -		bpf_prog_pack_free(ro_header, ro_header->size);
>> +	if (IS_ERR(ptr))
>>   		return PTR_ERR(ptr);
>> -	}
>> +
>>   	return 0;
>>   }
> 
> [Severity: Critical]
> This is a pre-existing issue, but does reading ro_header->size cause a panic
> when bpf_arch_text_copy() fails?
> 
> If bpf_arch_text_copy() returns an error, the RO memory was not written, so
> ro_header->size contains uninitialized garbage or illegal instructions. Because

I think we should use bpf_arch_text_copy to initialize ro_header->size 
when ro_header is successfully allocated.

> kvfree(rw_header) is called unconditionally just before this check, the only
> header holding the correct allocation size is destroyed before the caller can
> properly free the resource.
> 
> When the architecture fallback explicitly calls bpf_jit_binary_pack_free()
> (or previously when this function called bpf_prog_pack_free directly), it
> reads the garbage size from ro_header->size:
> 
> kernel/bpf/core.c:bpf_jit_binary_pack_free() {
>      u32 size = ro_header->size;
>      bpf_prog_pack_free(ro_header, size);
>      ...
>      bpf_jit_uncharge_modmem(size);
> }
> 
> Since this garbage size typically exceeds BPF_PROG_PACK_SIZE, the allocator
> falls back to vfree(ro_header). As ro_header is a pointer to the interior of
> a vmalloc'd pack, vfree() will trigger a kernel panic. Additionally,
> bpf_jit_uncharge_modmem() drastically underflows the module memory tracking
> counter.
> 
> Could the size be preserved or passed differently to avoid reading from the
> uninitialized RO header during the error path?
> 

