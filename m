Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239443E092;
	Sat,  5 Sep 2026 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788595878; cv=none; b=iVC70T3FKXc+r85aROPkyddyQQ8nM3Eu21OimZqQ92eMl6V7KN2vENwSu4xI+VhFV3Noyq0xjkQWb+Tg/0CHIt7hU7ZIcuFd++Bsi7Y8WHMtCUE/yt4lUoGlq5vcLr1mMxztgFLDe3Aq6a814UJKL135U66YgOzF106WbjvTJxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788595878; c=relaxed/simple;
	bh=igbQ9mk+UgcxoDPeyfEkUMffxjjin4ebMAl6tyNnH6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnNYG/Yuw0dNZvIo8JMtVBNYQrr2etGkalPrmAWRCeARjfVJo1MEcyRPrI2tBM/qGidrHH4LkqWr70f7NfZIyzFHRUfs1xMrF/XfpQbTrYDibrST44fzofX3gvu215Oo/uJaCYJGg8MTzDeewKbnkE3X+JhkxOtrTmZvogm/Yxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hcQxW33c6zYQtvX;
	Sat,  5 Sep 2026 16:10:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6AB1E40594;
	Sat,  5 Sep 2026 16:11:09 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgB32peczptqrBRUAw--.52213S2;
	Sat, 05 Sep 2026 16:11:09 +0800 (CST)
Message-ID: <793cb69d-8f5f-4f30-a634-638fd01094f4@huaweicloud.com>
Date: Sat, 5 Sep 2026 16:11:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/3] riscv, bpf: Remap BPF_REG_0 and
 RV_REG_TCC
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 jiangfeng@kylinos.cn
Cc: bjorn@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 puranjay@kernel.org, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr,
 pulehui@huawei.com, martin.lau@kernel.org, mason@kernel.org
References: <20260905070409.4141522-2-pulehui@huaweicloud.com>
 <27b33e8d655c23498a546736e58ef01721ddc18462164e181864295a3b01ef42@mail.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <27b33e8d655c23498a546736e58ef01721ddc18462164e181864295a3b01ef42@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB32peczptqrBRUAw--.52213S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyrJw1rWw4kCry5Kw17KFg_yoW8XF45pr
	W0kF4fAr4vqw18Xw4xt3WrXr4rtw4vvw47CFy5Kr1rZFsIgryftF1rGF4Yvr98ZFn5Ca4U
	JFs0grn5Cw1kZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	j7l19UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/9/5 16:00, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index e7378be171a9..aac128b9f0a4 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
> 
> [ ... ]
> 
>> @@ -1075,7 +1075,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
>>
>>   	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
>>   	if (save_ret)
>> -		stack_size += 16; /* Save both A5 (BPF R0) and A0 */
>> +		stack_size += 16; /* Save both T6 (BPF R0) and A0 */
> 
> Should the comment read "Save both T6 (BPF R0) and A0"? The patch updates
> regmap[BPF_REG_0] from RV_REG_A5 to RV_REG_T6, and the stack slot at
> retval_off - 8 is written via regmap[BPF_REG_0] in the save_ret block
> (emit_sd(RV_REG_FP, -(retval_off - 8), regmap[BPF_REG_0], ctx)), so the
> comment still naming "A5" contradicts the new mapping. After this series
> a5 becomes an argument register (the 6th BPF argument maps to a5 in a
> later commit), which makes "A5" actively misleading here since a reader
> could mistake this slot for argument spill space rather than R0/return
> value storage.

good cache, will update

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33952202002

