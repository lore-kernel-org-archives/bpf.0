Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E819405C21
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500707; cv=none; b=Lbfg+OTpYH0ZljJZLk/AMkVZWtnTB9PH0oHe5BiBDEX3z8rPkS1EoxjTMm2couUd/iITl00zDqq654ZPauiyS++eTIwJbZNcyn3ruFqnpJ2v/ZPcuFpDWSN6eVexvqcxpMEE5OiocuHD3p1VylobCSgxn9t9NHMwzCgaiJMFX9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500707; c=relaxed/simple;
	bh=2LS7c1Vpofa3/DJoUoi103g5/qVOJZs+JVuCnr7mhFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pCYvm9eUgEvT6qk+WXl4konNnoY2i2paBNWOnQeCAFenU9UNYgy3qVw8+RVYiVwK/PHQ0xYF39t+1be31+T4v5yBBHWErMpdSdEmN0SorYtH9WBcud3i6t8hZq6IKTY7MjEdc9juLnFFYPa1coDWR97RUr9ATpWDckTa2ikpwak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gwBf06tCczKHLvp
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 16:51:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AA86E4056B
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 16:51:41 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDHrCidD05q_m3rAQ--.50979S2;
	Wed, 08 Jul 2026 16:51:41 +0800 (CST)
Message-ID: <7218a234-df3b-40d9-aea3-1e1c69a2bc1f@huaweicloud.com>
Date: Wed, 8 Jul 2026 16:51:41 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 2/7] riscv, bpf: Fix memory leak in
 bpf_jit_free
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260708064436.2971933-1-pulehui@huaweicloud.com>
 <20260708064436.2971933-3-pulehui@huaweicloud.com>
 <20260708065406.66B4A1F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260708065406.66B4A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDHrCidD05q_m3rAQ--.50979S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurWUWw4rWFyDGw43AryDtrb_yoWrZw4xpF
	98uw1ak3yqgwn3KFs7KF18uFy7Jw48W3W2kFyUurWjg3Z8WryvgF1Sk3yrWa98Ar4UJw45
	XF4kGFy3Ca4kJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/8 14:54, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] bpf_jit_free() ignores the error return value of bpf_jit_binary_pack_finalize(), leading to a Use-After-Free, Double-Free, and potential JIT memory charge limit corruption.
> - [High] The identical memory leak fixed in RISC-V remains present in ARM64 and LoongArch BPF JIT implementations.
> - [High] Memory charge limit (modmem) is permanently leaked when bpf_jit_binary_pack_finalize() fails in bpf_int_jit_compile().
> --

These are all pre-existing issues unrelated to the mixing of tail calls 
and bpf2bpf; they will be analyzed and fixed in a new patch series, as 
addressing them here would make this patchset be more large.

> 
> --- Patch [2]: [PATCH bpf-next v6 2/7] riscv, bpf: Fix memory leak in bpf_jit_free ---
> commit 9c17e0351f5dcd9f2cb6815fc5c5e2c47b738ba2
> Author: Pu Lehui <pulehui@huawei.com>
> 
> riscv, bpf: Fix memory leak in bpf_jit_free
> 
> This commit fixes a memory leak in the RISC-V BPF JIT compiler. When a
> subprogram fails to compile, it cleans up earlier subprograms but previously
> failed to free the jit_data->ctx.offset array.
> 
>> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
>> --- a/arch/riscv/net/bpf_jit_core.c
>> +++ b/arch/riscv/net/bpf_jit_core.c
>> @@ -234,6 +234,7 @@ void bpf_jit_free(struct bpf_prog *prog)
>>   		 */
>>   		if (jit_data) {
>>   			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
> 
> [Severity: Critical]
> This is a pre-existing issue, but does ignoring the return value of
> bpf_jit_binary_pack_finalize() here cause a use-after-free and double-free?
> 
> If bpf_jit_binary_pack_finalize() fails (for example, due to a text copy
> failure), it frees the ro_header memory chunk and returns an error:
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
> Since bpf_jit_free() ignores this failure, it extracts the now-freed
> ro_header via bpf_jit_binary_pack_hdr() below, and unconditionally passes
> it to bpf_jit_binary_pack_free(). Inside that function, the freed ro_header
> is dereferenced to read its size, leading to a use-after-free, double-free,
> and uncharging the modmem with garbage data.
> 
> Can this be triggered by an unprivileged BPF program load?
> 
> [Severity: High]
> This is also a pre-existing issue, but does bpf_jit_binary_pack_finalize()
> fail to uncharge the modmem limit when it returns an error?
> 
> As shown above, bpf_jit_binary_pack_finalize() frees ro_header on failure
> but does not call bpf_jit_uncharge_modmem(). In other callers like
> bpf_int_jit_compile(), the error handler detects the failure, clears the
> header pointers, and skips calling bpf_jit_binary_pack_free() completely:
> 
> arch/riscv/net/bpf_jit_core.c:bpf_int_jit_compile() {
>      ...
>      if (WARN_ON(bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header))) {
>          /* ro_header has been freed */
>          jit_data->ro_header = NULL;
>          jit_data->header = NULL;
>          goto out_free_hdr;
>      }
>      ...
> }
> 
> Since out_free_hdr skips bpf_jit_binary_pack_free() when header is NULL,
> the modmem uncharge is permanently bypassed. Does this leak the
> bpf_jit_limit capacity?
> 
>> +			kfree(jit_data->ctx.offset);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but do arm64 and loongarch have
> the exact same memory leak that is being fixed here for riscv?
> 
> Looking at bpf_jit_free() in arch/arm64/net/bpf_jit_comp.c:
> 
> arch/arm64/net/bpf_jit_comp.c:bpf_jit_free() {
>      ...
>      if (jit_data) {
>          bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
>          kfree(jit_data);
>      }
>      ...
> }
> 
> And similarly in arch/loongarch/net/bpf_jit.c:
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
> Neither architecture frees the jit_data->ctx.offset array before freeing
> jit_data. Should a similar fix be applied to those architectures?
> 
>>   			kfree(jit_data);
>>   		}
>>   		hdr = bpf_jit_binary_pack_hdr(prog);
>>   		bpf_jit_binary_pack_free(hdr, NULL);
> 

