Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D89351C2F
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 02:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785118581; cv=none; b=Jsl0l5KD5W+ADN4tzcHrLSE/cVkc69xsfHkampUe57h4eWLibHGYbCew89+oJKyrPcT0YL8TFjFHX3ivx3kjRq0bc8qon/LHVMl/7V7JVCrLzLS8eQfHfUQ97P0MWISRCX2naR0w90wi4aOG6He/m7lJdeTyDibEjL28gBWzMjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785118581; c=relaxed/simple;
	bh=jn+Q7yCOhIaVwpeesR9ro/EvK9yIjbO8ItSL4uRWVAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOEAvXyI2zlDXESW+Uro1l/YP/ZTZxIqzMMNEBLk61YUpi5mNrE+ldo4UMNVLsMRbJJrwptIKLi46n6NkJ5HwnucDL8xrpbuwn65hh7xi33lxOiewNW9OWw7hicSs9XEr72g+STo6VgWU4I7UhgtRUir0q+b1sfppcz8F5FMVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h7hyf5fS1zYQtht
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 10:15:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id A351C4056B
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 10:16:15 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB34Iduv2ZqmyBZAA--.3224S2;
	Mon, 27 Jul 2026 10:16:15 +0800 (CST)
Message-ID: <d00c1124-92bf-42f5-a817-c5a4755ffa59@huaweicloud.com>
Date: Mon, 27 Jul 2026 10:16:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 7/9] bpf, arm64: Fix private stack leak when
 JIT failed
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260725154915.2488611-1-pulehui@huaweicloud.com>
 <20260725154915.2488611-8-pulehui@huaweicloud.com>
 <20260725155535.0398E1F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260725155535.0398E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgB34Iduv2ZqmyBZAA--.3224S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW5Gw4xGF1xZF1xuF45Wrg_yoW8Kry5pw
	n3uFnxCr4DWr4kKFWvq3WkJF17Xws7KFy5KFW5C3yj93ZI93s7tFyakayUCFW5ArW0qw4Y
	vryDKrZxC3WkX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/7/25 23:55, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Medium] Memory leak of the BPF private stack in the PowerPC JIT compiler upon JIT failure.
> --
> 
> --- Patch [7]: [PATCH bpf-next v3 7/9] bpf, arm64: Fix private stack leak when JIT failed ---
> commit 8de8b0f7fc232dba7540d3099301a4c55f3544c0
> Author: Pu Lehui <pulehui@huawei.com>
> 
> bpf, arm64: Fix private stack leak when JIT failed
> 
> This patch fixes a memory leak in the ARM64 BPF JIT compiler. When JIT
> compilation fails, the private stack percpu memory was being leaked because
> the cleanup check evaluated to false after a pointer was left dangling. The
> fix sets the pointer to NULL to ensure proper cleanup.
> 
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index f4e4d4578e38a..6e036acf80d8b 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -2311,6 +2311,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>>   		bpf_arch_text_copy(&ro_header->size, &header->size,
>>   				   sizeof(header->size));
>>   		bpf_jit_binary_pack_free(ro_header, header);
>> +		ro_header = NULL;
> 
> [Severity: Medium]
> This is a pre-existing issue, but while fixing this memory leak for arm64,
> it appears that the PowerPC JIT compiler has the exact same problem.
> 
> In arch/powerpc/net/bpf_jit_comp.c:bpf_int_jit_compile():
> 
> 		if (bpf_jit_build_body(fp, code_base, fcode_base, &cgctx, addrs, pass,
> 				       extra_pass)) {
> 			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
> 			bpf_jit_binary_pack_free(fhdr, hdr);
> 			goto out_err;
> 		}
> 
> When jumping to the error cleanup path, the JIT binary is freed but the image
> pointer remains non-NULL.
> 
> Then in the cleanup path:
> 
> out_addrs:
> 		if (!image && priv_stack_ptr) {
> 			fp->aux->priv_stack_ptr = NULL;
> 			free_percpu(priv_stack_ptr);
> 		}
> 
> Because the image pointer is still non-NULL, this check evaluates to false.
> Can this also cause the private stack percpu memory to be leaked in the
> PowerPC JIT? Should a similar fix be applied there?
> 
>>   	}
>>   	goto out_off;
>>   }
> 

will fix if have new version, or will send new patch

