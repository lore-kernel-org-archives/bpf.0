Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF371A681C
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784857184; cv=none; b=qGoGDDw3kWO0XuUZG5uBWufWeKxtiwHVDZ0S/f3dOS+5uTUOEEiYSRcj9k5X3rTeyajclbewMpjM9Dt1PoyfSetJOQGUv1r4PkBNhdWd7y9GD15tS5hwGq1Ph90vHBAC+mcxOKHeJtBbr5WZlFqaVJ76iF6Nk5yhaOaG/JwndD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784857184; c=relaxed/simple;
	bh=ZSu2HxhXu4BPUdzZi/39bsFPK9tNhoMqwzb8gq1shqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7C5LZ9R/GIcZvbI/xhnCPOjfbaW06QEavfTAaX2FejpkQCxIFRjXNvvt422F8S65iGIKsU05y7T5i0aSPq5HUHFVbTTnZXq4TcaI3vKE+MhMGPOFwir22WC880LAqZzwVm8esKOQ/4ga9QwJ/8T/1UtfeVV7mB2TFmwEZFmX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h5rHr2dvlzYQttK
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 09:39:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0A95540577
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 09:39:36 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgCXyFlWwmJqwP1dCQ--.5163S2;
	Fri, 24 Jul 2026 09:39:35 +0800 (CST)
Message-ID: <97c355e9-69ee-4e06-bfe7-95d7186a634b@huaweicloud.com>
Date: Fri, 24 Jul 2026 09:39:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/4] bpf, arm64: Fix memory leak in bpf_jit_free
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260722112754.1615201-1-pulehui@huaweicloud.com>
 <20260722112754.1615201-2-pulehui@huaweicloud.com>
 <20260722113808.94D6D1F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260722113808.94D6D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXyFlWwmJqwP1dCQ--.5163S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW5Gw4fZr4fKr15Gr4xtFb_yoW8CF4DpF
	yDu3W3C3yq9r1ktF1kX3W8uF4UWw4rGF1UKa4Uur4IgFn0gr93WF4Sk3yfCayYyr4UJ3yF
	qryYgryfCas5JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/7/22 19:38, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Memory leak of `jit_data->ctx.offset` in `bpf_jit_free()` for the LoongArch architecture.
> --
> 
> --- Patch [1]: [PATCH bpf-next 1/4] bpf, arm64: Fix memory leak in bpf_jit_free ---
> commit 34ee740bc2723be0c26671951b05fa73e1bfc918
> Author: Pu Lehui <pulehui@huawei.com>
> 
> bpf, arm64: Fix memory leak in bpf_jit_free
> 
> This commit fixes a memory leak in the ARM64 BPF JIT compiler. When
> bpf_jit_free() cleans up a subprogram after a later subprogram fails JIT
> compilation, it now correctly frees the jit_data->ctx.offset array.
> 
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index 4cdc7dfb05ba9..f4e4d4578e38a 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -3237,6 +3237,7 @@ void bpf_jit_free(struct bpf_prog *prog)
>>   		 */
>>   		if (jit_data) {
>>   			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
>> +			kvfree(jit_data->ctx.offset);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the same memory leak
> exist in the LoongArch BPF JIT compiler?

patch 2 have been covered this.

> 
> Looking at arch/loongarch/net/bpf_jit.c in bpf_jit_free():
> 
> 		if (jit_data) {
> 			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
> 			kfree(jit_data);
> 		}
> 
> It appears jit_data->ctx.offset is not freed there before kfree(jit_data)
> is called.
> 
> Could this lead to a similar resource leak if userspace loads a BPF program
> with multiple subprograms that passes verification but fails JIT compilation?
> 
>>   			kfree(jit_data);
>>   		}
>>   		prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();
> 

