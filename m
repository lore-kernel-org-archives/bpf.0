Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD0A1A6810
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862972; cv=none; b=Gv0vQ5pOfXF36ehSYNBZ6su/URHZFdnsv4bUV3SWxNYxVTD02tngAW53vcMlvCxvW/vEVI5/S/q00zD5886TTY7rWowgIlbC4/i/Ce7SoBdDuef1DLDCAVQG7fwjEi777RH/DTM+3TW849B+e0ly5hVpVKIqV+J5tufZZ+iwRj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862972; c=relaxed/simple;
	bh=1RnLhP3iUsnE5myKEdKyfGGZ48B3gZvFFvxx33OEAR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fc+3n0Q+oG0O5w4kJx7iGTulAWFAwfh3Qdaug1uPl+iq1mkkpiR9WgEUjIqzN5oNVQ1qV1RB0P74mHyeAzp3sO7ReaGrk6YcbQH/GrLh4xMvxBxzCNsUzamKfAeiPKoxjv/SVc6G1dPyJuwNLvxjp0H6Q368UpnGdfo/klvA5xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h5tRC5RhrzYQts6
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 11:15:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 87C4440561
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 11:16:07 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgAX_Sj32GJqPj9hCQ--.22423S2;
	Fri, 24 Jul 2026 11:16:07 +0800 (CST)
Message-ID: <100c4981-cc61-44d4-928b-e6f5c29f9570@huaweicloud.com>
Date: Fri, 24 Jul 2026 11:16:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/4] LoongArch: BPF: Fix memory leak in
 bpf_jit_free
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260722112754.1615201-1-pulehui@huaweicloud.com>
 <20260722112754.1615201-3-pulehui@huaweicloud.com>
 <20260722113556.63A971F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260722113556.63A971F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAX_Sj32GJqPj9hCQ--.22423S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw43ur48CF1kCry5Aw1DWrg_yoW5WrykpF
	98Zr13CrWqg392gFsrJw48WF4UJw43W3WjgF1Y9r4xuF15WrykWFyak3yrWa90yry8Jw40
	qFWjgr9xJa4kAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/22 19:35, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The patch series correctly fixes a memory leak of `prog->aux->jit_data` on JIT subprogram failure in `arm64` and `loongarch`, but misses the identical architectural flaw in `s390`, `parisc`, and `sparc64`.
> --
> 
> --- Patch [2]: [PATCH bpf-next 2/4] LoongArch: BPF: Fix memory leak in bpf_jit_free ---
> commit cacb56acd5af4ef394049dd1560a358cf9a04bae
> Author: Pu Lehui <pulehui@huawei.com>
> 
> LoongArch: BPF: Fix memory leak in bpf_jit_free
> 
> This commit fixes a memory leak in the LoongArch BPF JIT compiler. When
> bpf_int_jit_compile() returns early for subprograms, it leaves ctx->offset
> allocated, which bpf_jit_free() previously failed to clean up on abort.
> 
>> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
>> index 2738b4db11653..3d3ed1677d018 100644
>> --- a/arch/loongarch/net/bpf_jit.c
>> +++ b/arch/loongarch/net/bpf_jit.c
>> @@ -2361,6 +2361,7 @@ void bpf_jit_free(struct bpf_prog *prog)
>>   		 */
>>   		if (jit_data) {
>>   			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
>> +			kvfree(jit_data->ctx.offset);
>>   			kfree(jit_data);
>>   		}
> 
> [Severity: High]
> This is a pre-existing issue, but while this patch correctly fixes the memory
> leak of the JIT context arrays for LoongArch, do we have the exact same leak
> occurring in s390, parisc, and sparc64?
ok, will take a look for the ctx.offset.

> 
> Looking at s390, parisc, and sparc64, they also return early for subprograms
> and leave memory attached to prog->aux->jit_data. For example, in s390:
> 
> arch/s390/net/bpf_jit_comp.c:bpf_int_jit_compile() {
>      ...
>      } else {
>          jit_data->header = header;
>          jit_data->ctx = jit;
>          jit_data->pass = pass;
>      }
>      ...
>      if (!fp->is_func || extra_pass) {
>          ...
>          kvfree(jit.addrs);
>          kfree(jit_data);
>          fp->aux->jit_data = NULL;
>      }
> }
> 
> However, these architectures do not have a custom bpf_jit_free() implementation
> and rely on the weak generic bpf_jit_free() function instead:
> 
> kernel/bpf/core.c:bpf_jit_free() {
>      if (fp->jited) {
>          struct bpf_binary_header *hdr = bpf_jit_binary_hdr(fp);
> 
>          bpf_jit_binary_free(hdr);
>          WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
>      }
> 
>      bpf_prog_unlock_free(fp);
> }
> 
> The generic bpf_jit_free() does not check or free prog->aux->jit_data. If JIT
> compilation fails for a later subprogram, the BPF core aborts and calls
> bpf_jit_free() on all previously JITed subprograms.
> 
> Does this mean s390, parisc, and sparc64 will still leak their jit_data and
> offset arrays on this failure path?
> 
>>   		hdr = bpf_jit_binary_pack_hdr(prog);
> 

