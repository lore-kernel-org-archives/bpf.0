Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE852346E7D
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 01:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116912; cv=none; b=WTe+wy1zr9W9USUrBPyYvcJBKmYP+YIjBbDiAVh6obxeDA+XeUnjKKfCoY8pDE1gOxmH+EG3eNDCMaJRi1d+k1Cvdd0R+D9GPhaf0Lwd9+8l87+DXrONL4p/4EzqsALMMhDwu3gkmNpDNz1LSIr5m3jnnKV2UM6nW2E9nIVGeI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116912; c=relaxed/simple;
	bh=aPEEwlRnw3JhKhQsFm8vklsz2pq4RcvfuAKiD7Z7YW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gs9E3VQj8Ksza71HMY69zzwNjgjFBZwVqK+0R1IS+0hpllOGXeT+WxtC3OXvte5yci8AkwHysfAE55EZZ8atx8KF0UIelN2jiYtTWzGilLAl3TmUcglFf9EbI72UZE0b5BfsyoEB4eeokoxlYe+Z4fchBvZyFcUH7uPJA/vNBIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h7hLS58cFzYQtHW
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 09:47:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 85E904058F
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 09:48:21 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgCnl9PhuGZq2lFWAA--.38623S2;
	Mon, 27 Jul 2026 09:48:18 +0800 (CST)
Message-ID: <ce469b75-97c3-4574-85a8-a188f2b24130@huaweicloud.com>
Date: Mon, 27 Jul 2026 09:48:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 6/9] bpf, arm64: Fix memory leak in
 bpf_jit_free
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260725154915.2488611-1-pulehui@huaweicloud.com>
 <20260725154915.2488611-7-pulehui@huaweicloud.com>
 <20260725160104.309A31F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260725160104.309A31F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCnl9PhuGZq2lFWAA--.38623S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurWUWw4rWF4DKr1rtw1kKrg_yoWrZw1kpF
	98X3Wak3yqgwn7tF4kXF18ZF1UXw48W3Wjkr1UurW09FnxWr92gFWSk3yUua90yr4UJw4Y
	qr4kWFy3Ca4kA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
	xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/7/26 0:01, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] `bpf_jit_free()` ignores the return value of `bpf_jit_binary_pack_finalize()`, leading to a Use-After-Free and Double Free if finalization fails.
> - [High] Pre-existing percpu memory leak of `priv_stack_ptr` on BPF JIT compilation failure.
> - [High] The identical memory leak of `ctx.offset` fixed by this patch in ARM64 remains unfixed in the LoongArch BPF JIT compiler.
> --
> 
> --- Patch [6]: [PATCH bpf-next v3 6/9] bpf, arm64: Fix memory leak in bpf_jit_free ---
> commit c1be108f68505531829d01d1fddc5f23ead947da
> Author: Pu Lehui <pulehui@huawei.com>
> 
> bpf, arm64: Fix memory leak in bpf_jit_free
> 
> When JIT compilation fails for a subprogram, the BPF core cleans up
> previously compiled subprograms by calling bpf_jit_free(). This commit adds
> a missing kvfree(jit_data->ctx.offset) to bpf_jit_free() in ARM64,
> preventing a memory leak of the JIT context offsets array.
> 
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index 4cdc7dfb05ba9..f4e4d4578e38a 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -3237,6 +3237,7 @@ void bpf_jit_free(struct bpf_prog *prog)
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but is there a pre-existing
> percpu memory leak of priv_stack_ptr when JIT compilation fails?
> 
> Looking at bpf_int_jit_compile() when build_body() fails, out_free_hdr frees
> ro_header but does not set it to NULL. In the out_off block:
> 
> arch/arm64/net/bpf_jit_comp.c:bpf_int_jit_compile() {
>      ...
>      if (!ro_header && priv_stack_ptr) {
>          free_percpu(priv_stack_ptr);
>          prog->aux->priv_stack_ptr = NULL;
>      }
>      ...
> }

patch 7 has been covered this.

> 
> Because ro_header is a dangling pointer, this check evaluates to false,
> skipping the free. Later, when the BPF core aborts and calls
> bpf_jit_free(prog), prog->jited is 0:
> 
> arch/arm64/net/bpf_jit_comp.c:bpf_jit_free() {
>      if (prog->jited) {
>          ...
>      }
>      ...
> }
> 
> This skips the cleanup block entirely, leaving priv_stack_ptr permanently
> leaked. Would it be appropriate to address this as well?
> 
>>   		 */
>>   		if (jit_data) {
>>   			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
> 
> [Severity: Critical]
> This is a pre-existing issue, but could ignoring the return value of
> bpf_jit_binary_pack_finalize() here lead to a use-after-free and double free?
> 
> If bpf_arch_text_copy() fails during finalization,
> bpf_jit_binary_pack_finalize() frees the ro_header internally and returns an
> error:

patch 9 has been covered this.

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
> Since bpf_jit_free() ignores this error, it proceeds to retrieve the freed
> header and unconditionally frees it again:
> 
> arch/arm64/net/bpf_jit_comp.c:bpf_jit_free() {
>      ...
>      prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();
>      hdr = bpf_jit_binary_pack_hdr(prog);
>      bpf_jit_binary_pack_free(hdr, NULL);
> }
> 
> Inside bpf_jit_binary_pack_free(), it reads ro_header->size (use-after-free)
> and calls bpf_prog_pack_free() on it again (double free). Can this cause
> memory corruption?
> 
>> +			kvfree(jit_data->ctx.offset);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the LoongArch BPF JIT
> compiler suffer from this exact same memory leak?

bugfix has been applied to loongarch tree.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20260726&id=47e20d4b3da97ef3881d1e55e43545c22424f3fc

> 
> Looking at the LoongArch implementation, it uses the same multi-pass logic
> for subprograms and preserves ctx.offset in jit_data. However, its
> bpf_jit_free() does not free ctx.offset:
> 
> arch/loongarch/net/bpf_jit.c:bpf_jit_free() {
>      ...
>      if (jit_data) {
>          bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
>          kfree(jit_data);
>      }
>      ...
> }
> 
> Should a similar kvfree() be added to arch/loongarch/net/bpf_jit.c?
> 
>>   			kfree(jit_data);
>>   		}
>>   		prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();
> 

