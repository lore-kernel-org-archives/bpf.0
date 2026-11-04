Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797579;
	b=UPpP5si7B9JH7E2MdhjmjPumgdKxS+ikARVKqCUiDyj+U+Hi0DOQ9lIUyR0qs2qud3RG
	 6usiYX1UE1ejpyjuoh2dItZlCESGLOjY7cP3stlwybIIrDqhVM7pPFsEf/AvL32sKteNJ
	 dX8PKbN2FnnLd14bjAlJHwVRmT8fiD6t7am+O4qmvN9amDw9QTNpG7vZdQg3WeBiW5vob
	 HTMNCzOEZZ4MVpeG+B9W6S7Vu5eNqB7lzBBWiaccc0OARiOt6VE/P0TyI7mQAcZ2kLbg9
	 7R/JvZfVC23VLNY9rROLN9cpwAv90qR6nRMNND40p/QTjpAJ1piPlGfgh5LFnkokL6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797579;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=t0N3y9MtqQSrXVauEHd0fFtWMbMzBCQaF+BK87D4JBk=;
	b=1kdbGePPQw4rbs203V9UoBsY109KTB76qgNKXJFOY4d02yl7LT1PODX3xidVDOVlk/C5
	 L9NqQ8Jva8I0LKoqyXoWqKm0rUxjVmkpyHqKmqUtMLYjVTha8A7GNKE89NLL7Q74j5skG
	 Dt5EBYkwK6SLbX145nbcIDtnvry0LWVkiKpS5m1CroIcLvfYTUHX50lVauxghXSiszWSk
	 F6/nbriErYVaEXG2tVWvTCt9v9ueYvdknZc4Po1d2FJ+2S9M5dPj2a+AtA56FSo2scGYW
	 DE2H2W8StttR52AXklOzEPkpfW3yjRPhzcOB8ccogQ/lBxgphFcFr4Y2jH+ya4gBrng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CCD606A329;
	Wed,  4 Nov 2026 13:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64CCD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8BxbdLHLetqIEwcAA--.18050S3;
	Wed, 04 Nov 2026 21:06:15 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCx9czFLetqql8yAA--.10756S2;
	Wed, 04 Nov 2026 21:06:14 +0800 (CST)
Subject: Re: [PATCH v1 1/2] LoongArch: BPF: Make arena support depend on SCQ
 extension
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261102072808.23080-1-yangtiezhu@loongson.cn>
 <20261102072808.23080-2-yangtiezhu@loongson.cn>
 <CAAhV-H52mbZJX2vkgG_h=XfwHoio=asLjFdhTJwUYqDp4V5JMg@mail.gmail.com>
 <8b00e5a7-4e60-19bd-7953-f76dc71e15ec@loongson.cn>
 <CAAhV-H52bqRD1SyrZsvMkNbCpGiM5DPSGPARiasZ8G3XsE5Tgw@mail.gmail.com>
 <6446c385-623c-d4cf-5a07-0c2276c6f50c@loongson.cn>
 <CAAhV-H4m-cokYz19HHAoDeLAjRGp4T=vwDOJaJEcHXZDW15rkQ@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <64b8f867-029d-3cdb-7896-1229a076e25c@loongson.cn>
Date: Wed, 4 Nov 2026 21:06:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4m-cokYz19HHAoDeLAjRGp4T=vwDOJaJEcHXZDW15rkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx9czFLetqql8yAA--.10756S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXF17Zw1rtry8Cw1xZr13GFX_yoWrJw1xpa
	yrCr4DKrWjgr4Fy397KFnxuw1UCrsIkrWUWayFkrWkZrn0qw17Gr1Fk3W5ZF4DtrWF93Wj
	9Fs0y3ZI93WkAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
	VUUUUUU==

On 11/4/26 5:54 PM, Huacai Chen wrote:
> On Wed, Nov 4, 2026 at 2:58 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

...

>> Therefore, using the explicit #ifdef block in the original patch is the
>> only way to ensure toolchain compatibility and compile-time robustness
>> here IMO.
> This is OK:
> 
> return cpu_has_scq && __is_defined(system_has_cmpxchg128);
> 
> It means two things:
> 1. CPU supports SC.Q;
> 2. Kernel defines system_has_cmpxchg128.
> 
> Very clear.

I tested your suggestion:
return cpu_has_scq && __is_defined(system_has_cmpxchg128);

There is no build error. However, this introduces a fatal functional
bug because __is_defined(system_has_cmpxchg128) is blindly evaluated
to 0 as a text string token. As a result, the expression is always
translated into "return cpu_has_scq && 0;", which disables BPF Arena
support permanently even on the Loongson-3A6000 system with hardware
SCQ extension and assembler sc.q support.

I did the following changes:

```
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 3ab039d0afb6..b61cca6a8947 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -2489,7 +2489,13 @@ bool bpf_jit_bypass_spec_v4(void)

  bool bpf_jit_supports_arena(void)
  {
-       return true;
+       /*
+        * The arena range tree uses kmalloc_nolock(), which requires 
128-bit
+        * atomic cmpxchg; this is provided by not only hardware SCQ 
extension
+        * but also assembler support on LoongArch.
+        */
+       pr_info("__is_defined(system_has_cmpxchg128)=%d\n", 
__is_defined(system_has_cmpxchg128));
+       return cpu_has_scq && __is_defined(system_has_cmpxchg128);
  }

  bool bpf_jit_supports_fsession(void)
```

Here is the test result on the Loongson-3A6000 system with hardware
SCQ extension and assembler sc.q support:

   $ sudo ./test_progs -a jit_insns/cast_to_user
   ...
   libbpf: map 'arena': failed to create: -EOPNOTSUPP
   run_subtest:FAIL:unexpected_load_failure unexpected error: -95 (errno 95)
   ...
   #197/2   jit_insns/cast_to_user:FAIL
   #197     jit_insns:FAIL
   Summary: 0/0 PASSED, 0 SKIPPED, 1/1 FAILED

   $ dmesg -t | grep system_has_cmpxchg128
   __is_defined(system_has_cmpxchg128)=0

This is not expected.

AFAICT, there are two viable ways to handle both assembler and runtime
constraints:

(1)Use system_has_cmpxchg128 at compile-time and run-time. This is
more aligned with semantic intent, as BPF relies on the generic
128-bit cmpxchg interface.

```
bool bpf_jit_supports_arena(void)
{
         /*
          * The arena range tree uses kmalloc_nolock(), which requires 
128-bit
          * atomic cmpxchg; this is provided by not only hardware SCQ 
extension
          * but also assembler support on LoongArch.
          */
#ifdef system_has_cmpxchg128
         return system_has_cmpxchg128();
#else
         return false;
#endif
}
```

(2) Use CONFIG_AS_HAS_SCQ_EXTENSION at compile-time and cpu_has_scq
at run-time. This is more aligned with kernel coding aesthetics by
avoiding #ifdef blocks.

```
bool bpf_jit_supports_arena(void)
{
         /*
          * The arena range tree uses kmalloc_nolock(), which requires 
128-bit
          * atomic cmpxchg; this is provided by not only hardware SCQ 
extension
          * but also assembler support on LoongArch.
          */
         return IS_ENABLED(CONFIG_AS_HAS_SCQ_EXTENSION) && cpu_has_scq;
}
```

Since cpu_has_scq and system_has_cmpxchg128() share the exact same
runtime expansion (cpu_opt(LOONGARCH_CPU_SCQ)), both approaches are
functionally equivalent and produce identical machine code.

Personally, I feel Approach 1 represents the pure semantic intent
better, whereas Approach 2 looks more aesthetically pleasing.

Which one do you prefer for the v2 patch?

Thanks,
Tiezhu

