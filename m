Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5FB37F732
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788594190; cv=none; b=hwotvITowDWSVjqfd9Fo4gsVHO87M41amqNtdj40PmAker8qg6MdAV+sis04JYWYK+HZLh+hE+PsGCPniBWt+FmANq/1D+9YI99ilYrqf1IhX0+u20tauX6DYdqUHbigpgXSIPHd222KYvOF0oDpZiprl7Ak1D6EWluaTak4dEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788594190; c=relaxed/simple;
	bh=GiF6rpZ8urYB6pW1Mm3W/LwDnfYSiGKuXUZ7eMAYxms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6Z7fezYbwS6orK92xgFPAOjgKECs508mvhuKvbxEeOQmuNRllR3DtdlTsOHMI3vwmaDZ9cNzike4jgxtmjjjgWeWF1i36eQub5CPgfR1CJcdA1Z7XvNYzm8O/ZPlgJNA14B5SQORVnrKekkPIkuyzIYE71HHyvUyBcjUbRSK7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hcQJw3CDdzKHMVf
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 15:42:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0DE1C4058C
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 15:43:05 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgB32Zbyx5tqmJ1RAw--.46762S3;
	Sat, 05 Sep 2026 15:43:05 +0800 (CST)
Message-ID: <f8d4eaee-5b88-4427-85ee-4e25b0f276de@huaweicloud.com>
Date: Sat, 5 Sep 2026 15:43:04 +0800
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
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260905070409.4141522-1-pulehui@huaweicloud.com>
 <20260905070409.4141522-2-pulehui@huaweicloud.com>
 <20260905071213.878301F00A3D@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260905071213.878301F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB32Zbyx5tqmJ1RAw--.46762S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW8Kry7tFWxKw4xJF1DKFg_yoW8Ww45p3
	yfWF1fCry8Xr9Iqr92yF48Z348uwsIqF13Xr47Kr9rAF1xWwn3tF4UKa13JrW5JFWSkayY
	9rWj934kJwn8ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7
	M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
	3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUzWrWUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/9/5 15:12, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The block and inline assembly comments in `bpf_timed_may_goto.S` continue to reference `a5` as the mapped register for `BPF_REG_0`, which contradicts the updated code utilizing `t6`. This patch changes `a5` to `t6` in the instructions, but missed updating the corresponding comments.
> --
> 
> commit 3f2026164fcac1b3db2387eec49e58f20293243f
> Author: Pu Lehui <pulehui@huawei.com>
> 
> riscv, bpf: Remap BPF_REG_0 and RV_REG_TCC
> 
> This commit remaps BPF_REG_0 to t6 and RV_REG_TCC to t5 to support BPF
> stack arguments and unify calling conventions. Freeing up a5 and a6
> allows bpf2bpf calls to pass extra arguments consistently with kfuncs.
> 
>> diff --git a/arch/riscv/net/bpf_timed_may_goto.S b/arch/riscv/net/bpf_timed_may_goto.S
>> index 02c637d874205..ac41bf6dcb3d0 100644
>> --- a/arch/riscv/net/bpf_timed_may_goto.S
>> +++ b/arch/riscv/net/bpf_timed_may_goto.S
>> @@ -21,7 +21,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
>>   	addi	s0, sp, 8*SZREG
>>   
>>   	/* Save BPF registers R0-R5 (a5, a0-a4) */
>> -	REG_S	a5, 5*SZREG(sp)
>> +	REG_S	t6, 5*SZREG(sp)
> 
> [Severity: Low]
> This isn't a bug, but should the inline comment above this instruction also
> be updated to reflect that R0 is now mapped to t6 rather than a5?
> 
> Additionally, in the block comment at the beginning of
> arch_bpf_timed_may_goto in arch/riscv/net/bpf_timed_may_goto.S, the text
> still documents a5 as R0. Could these documentation references be updated to
> match the code changes?
> 

all right

