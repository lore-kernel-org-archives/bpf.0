Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BE1347C5;
	Mon,  6 Jul 2026 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783315246; cv=none; b=jwLPYwGosJV7hqOjbciyYnt5jgsR1cphvzCudINHFFGTo0vsVcGl+rQ2nZHDPzY2cmUfdgtJpIpXEZJI8+cpSDBoU+DPsHj4mdGGYameQ75KShphgrdGZ0QQ/s0PMoxwjULB1dND5Glnny9ZkFeukofRrmXDIJjwos2wqsvq+8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783315246; c=relaxed/simple;
	bh=9gFSfGD/qpr9I1iPR7dcTOq9LHFITjBgBzGr/vWDvAA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lhlGulmQLEzxfJEo5uGG/4rfzcs5xvv3SgqB2AuLdkbOaU8+94lw0oaouV6yGG5mpURaJrWoUiyBRyQ7kExEpZDIBk5wVVIxjXfTpYknFyFEh+ILS18aWVOIM2O3sF6WZsx2ilV4V6APjEDbC9OFJ04pNiE1nRoBIBM9yuTySY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx1+orO0tqDUoAAA--.1429S3;
	Mon, 06 Jul 2026 13:20:43 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAx3cYoO0tqFdYBAA--.11423S3;
	Mon, 06 Jul 2026 13:20:42 +0800 (CST)
Subject: Re: [PATCH v2 2/4] LoongArch: BPF: Move arena register slot below TCC
 context
To: bot+bpf-ci@kernel.org, chenhuacai@kernel.org, hengqi.chen@gmail.com
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
References: <20260706033906.1988-3-yangtiezhu@loongson.cn>
 <20c6156293d46e6515a98030194624a58d25b9ca4771a7a48d99a466edd3b9de@mail.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <e36b6122-8d83-7b4a-dcff-161799c24dbf@loongson.cn>
Date: Mon, 6 Jul 2026 13:20:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20c6156293d46e6515a98030194624a58d25b9ca4771a7a48d99a466edd3b9de@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx3cYoO0tqFdYBAA--.11423S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CrW7XrW8Cw48Cw45Aw45CFX_yoW8XFWkpr
	48G3W2yr4DJr4vvFsruws2gFy5Ga93AFW5Xrn8CryrJF909rnaqayfGayFva4kur4rZr1j
	vr15KrWF9ayqyrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
	Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU7W
	SoDUUUU

On 2026/7/6 下午12:29, bot+bpf-ci@kernel.org wrote:
>> LoongArch: BPF: Move arena register slot below TCC context
>>
>> Currently, the stack layout places the optional arena register slot above
>> the tail call counter context. When arena_vm_start is dynamically enabled,
>> it shifts the relative offset of the tcc_ptr slot within the stack frame,
>> causing hardcoded tracking macros to mismatch and potentially leading to
>> memory misalignment or corruption.
>> To fix this, move the arena register save and restore sequences below the
>> tail call counter context slots in both build_prologue() and epilogue. It
>> needs to update __build_epilogue() to insert a proper offset decrement to
>> safely skip the unneeded tcc_ptr reading block while accurately aligning
>> with the relocated arena slot at the very bottom.
>> With this patch, the tcc_ptr slot is always positioned at a fixed distance
>> directly underneath the base callee-saved registers that is independent of
>> whether the arena features are on.
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> This looks like a fix for a memory misalignment or corruption bug affecting
> arena BPF programs.  Should it carry a Fixes: tag?
> 
> The buggy stack layout, where the arena register save/restore and the extra
> stack reservation sit above the tail call counter context, appears to have
> been introduced by:
> 
>    Fixes: ef54c517a937 ("LoongArch: BPF: Implement PROBE_MEM32 pseudo instructions")

OK, will add it in v3.

Thanks,
Tiezhu

