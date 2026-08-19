Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE873812E1;
	Wed, 19 Aug 2026 03:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787108843; cv=none; b=tg+vYikQ+/aHvi1zmvPqY/oGYCVKWRhkAPcVfNtfIrdM2mVj1xny49X8lMgHvceWSWo8/ZghghiQWXq3NecOd6W8Er5n5jfrEHdoST4TUP0AG9lawrmfo9h53Ot9yrHVdJQIYpbkbvz00i9p30mIqaS2tn2LVRmCkDdCTZmkBq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787108843; c=relaxed/simple;
	bh=bNcs03/qax0NE2Dcoq2YxTBLI4cwGzk+jLyINd3l+mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4sXcuLE0ReppldaXcOcZ0c+8pQCCOPDGxW2Q4jRfQRJYsYoeVd19zimnRsGeaxfP4l9/a5hXQJEzzOqwDj/gjX3YEXikghKtVw5nDRqpnzCwnZwWYEtqI4ajcAstKN0Q8udSpAFHpqIMJB0zuC78iYtvt5FGGWVrf3maW3bBMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hPs0x28yQzKHML3;
	Wed, 19 Aug 2026 11:06:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B187B4058C;
	Wed, 19 Aug 2026 11:07:09 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgCHdtLcHYVqFr9bCw--.64187S2;
	Wed, 19 Aug 2026 11:07:09 +0800 (CST)
Message-ID: <449ec257-1ec2-4535-9bcc-70a6881c9349@huaweicloud.com>
Date: Wed, 19 Aug 2026 11:07:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v1 1/1] bpf: Enable JIT hardening by default
 when x86_64 CFI is enabled
Content-Language: en-US
To: Jennifer Miller <jmill@asu.edu>, Kees Cook <kees@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, linux-hardening@vger.kernel.org,
 xmei5@asu.edu, samitolvanen@google.com, peterz@infradead.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260710191932.120911-1-jmill@asu.edu>
 <20260710191932.120911-2-jmill@asu.edu> <202608091030.C69278022@keescook>
 <aoL_G-3chdLZGxSJ@spiro>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <aoL_G-3chdLZGxSJ@spiro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCHdtLcHYVqFr9bCw--.64187S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw17Gw1Utr4fAw1UXFyDtrb_yoW8uF4xpr
	1kKayFkF4DX340ka42vanrKr1Fva98Kr4UWr1rWw1Iq3Z0qr93JFnakr45WFn0qrWrZryI
	vF40qas8ua4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UAwIDUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/17/2026 9:24 PM, Jennifer Miller wrote:
> On Sun, Aug 09, 2026 at 10:30:35AM -0700, Kees Cook wrote:
>> On Fri, Jul 10, 2026 at 12:19:32PM -0700, Jennifer Miller wrote:
>>> Initializes bpf_jit_harden to 1 if x86_64 CFI is enabled. Prevents the
>>> misuse of BPF JIT code to craft CFI signatures or Endbr64 instructions
>>> by enabling constant blinding for JITted BPF code from unprivileged
>>> users.
>>>
>>> Signed-off-by: Jennifer Miller <jmill@asu.edu>
>>> ---
>>>   kernel/bpf/core.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>>> index 47fe047ad30b..ed22b90c6e4e 100644
>>> --- a/kernel/bpf/core.c
>>> +++ b/kernel/bpf/core.c
>>> @@ -548,7 +548,11 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
>>>   /* All BPF JIT sysctl knobs here. */
>>>   int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
>>>   int bpf_jit_kallsyms __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
>>> -int bpf_jit_harden   __read_mostly;
>>> +/* Enable hardening by default when x86_64 CFI is enabled to prevent CFI
>>> + * hashes and endbr64 instructions from being crafted.
>>> + */
>>> +int bpf_jit_harden   __read_mostly = IS_ENABLED(CONFIG_X86_64) &&
>>> +					IS_ENABLED(CONFIG_CFI);
>>
>> Why not just do this for all CONFIG_CFI?
>>
>> -Kees
>>
> 
> The intention was to not enable JIT hardening by default for other
> architectures when CONFIG_CFI is enabled when we don't know if it would
> be preventing any CFI from being bypassed. It may be possible that kCFI
> on other architectures is able to be bypassed in similar ways to x86_64,
> but we haven't looked into it.
> 
> ~Jennifer
>

Yeah, IIUC the described attacks rely heavily on x86-64's
variable-length instructions. On arm64, instructions are
strictly 4-byte aligned and jumping into the middle of an
instruction is not allowed, so the attacks seem not feasible,
at least in the current form.

>>>   long bpf_jit_limit   __read_mostly;
>>>   long bpf_jit_limit_max __read_mostly;
>>>   
>>> -- 
>>> 2.34.1
>>>
>>
>> -- 
>> Kees Cook
> 

