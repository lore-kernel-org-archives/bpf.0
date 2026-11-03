Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672656;
	b=p9dC38U+TVoKzm0YyB4ktu7C+wtVMGOEIM/T9dAcMDcM9NBmNTDztaHism8e+H950Qpx
	 Ae0N0kaCG+RPF8LQx6O/kkQ2CeLiWTTwQnsX1Z+ppIlUV9t24D9Dq63TQdXKN/Waq9Vs+
	 RZo5Rw6yhQ287qFheF8vM2DibwQs0NAIhvc7KgjrSAtbDniH0u8AyHysJjdkT2fUHjJ4i
	 fCkOI2V+OWDoO6109o4fBkBOLeWc/3P59eWOQhQgNfHUy8rIULnO0y3uvwEUIJiqEgFRe
	 KWuzqIk2AkPg52E6nNxxQNjO1Cru3HwkdkMgD7XPgnq3oVaVnKKob67tI6w+PrtsOWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672656;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=UTAawBq1TFFImCpcVMvX7PdBtwNak+VTPEQ+ylgpEcw=;
	b=PTHj7lTC5ua4YNwhR7gUeXdQt4RoHQ24fsgINHZVbldY9FnDA/Qp5l16NVh1t1nKPQJ6
	 6TMAgvMmTz+Jb/oorxSzQoDmW6NnKkTQbOHD7255s5Fp7KzQwW+BJDtA0uHiTgmpiQta3
	 hnRhakJGXrPhgwXdlDU5U29UnQTYrMdS4MTSfbL9EMrMamMFd6rYGTVBJfFIV3MUtC7lf
	 bFDyoYZXRVGBkoPYc/v/r9/MatlJhL6yokixgdEYOPaNpbqqXF2ANpG6LkjRRSiQa/7pe
	 Q3byPprOrjESmNAgYWqWG24w22S77Rf2mjUpcC2ZVA3N9Z7cGrxrN9RYpM2fb/4f83g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD48606A324;
	Tue,  3 Nov 2026 02:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AD48606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxC9LLRelqRc8bAA--.14963S3;
	Tue, 03 Nov 2026 10:24:11 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx3c7KRelqWAsyAA--.37821S2;
	Tue, 03 Nov 2026 10:24:11 +0800 (CST)
Subject: Re: [PATCH v1 1/2] LoongArch: BPF: Make arena support depend on SCQ
 extension
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261102072808.23080-1-yangtiezhu@loongson.cn>
 <20261102072808.23080-2-yangtiezhu@loongson.cn>
 <CAAhV-H52mbZJX2vkgG_h=XfwHoio=asLjFdhTJwUYqDp4V5JMg@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <8b00e5a7-4e60-19bd-7953-f76dc71e15ec@loongson.cn>
Date: Tue, 3 Nov 2026 10:24:10 +0800
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
In-Reply-To: <CAAhV-H52mbZJX2vkgG_h=XfwHoio=asLjFdhTJwUYqDp4V5JMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx3c7KRelqWAsyAA--.37821S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF1fCFyDGFyUKr18Kr1kCrX_yoW5AFykpF
	W7ArnrCrWYgrn5JrZrK3yrWF4DJrn8K342ga10krykJF98Xa4UXr18C3ZxXFn8Jrs5Ww40
	gFyYka4a9asxJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnUUUU
	UUUU=

On 2026/11/2 下午10:20, Huacai Chen wrote:
> Hi, Tiezhu,
> 
> On Mon, Nov 2, 2026 at 3:28 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> When testing bpf selftest "jit_insns/cast_to_user", there are different
>> behaviors on different Loongson machines.

...

>> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
>> index 3ab039d0afb6..01c12da168ee 100644
>> --- a/arch/loongarch/net/bpf_jit.c
>> +++ b/arch/loongarch/net/bpf_jit.c
>> @@ -2489,7 +2489,15 @@ bool bpf_jit_bypass_spec_v4(void)
>>
>>   bool bpf_jit_supports_arena(void)
>>   {
>> -       return true;
>> +       /*
>> +        * The arena range tree uses kmalloc_nolock(), which requires 128-bit
>> +        * atomic cmpxchg support, provided by SCQ extension on LoongArch.
>> +        */
>> +#ifdef system_has_cmpxchg128
>> +       return system_has_cmpxchg128();
>> +#else
>> +       return false;
>> +#endif
> You can "return cpu_has_scq" directly.

This was my initial thought too; it is simpler, but unfortunately
not enough here.

The 128-bit atomic cmpxchg arch_cmpxchg128() not only depends on
the hardware SCQ extension, but also requires assembler support,
which was addressed in commit c8b8f3c50f48 ("LoongArch: Only use
SC.Q when supported by the assembler").

Therefore, using #ifdef system_has_cmpxchg128 as in the current
patch is necessary to handle toolchain compatibility properly.

Here is a simple diff to verify this scenario. On a 3A6000 machine
with hardware SCQ extension, if we hack bpf_jit_supports_arena() to
return cpu_has_scq directly, but force AS_HAS_SCQ_EXTENSION to 'n'
to simulate an environment without assembler support, the original
test error "libbpf: map 'arena': failed to create: -ENOMEM" still
shows up because the underlying slab allocator lacks the flag
__CMPXCHG_DOUBLE.

```
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index b5ed4881d3c0..6f572d24d2c3 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -336,7 +336,7 @@ config AS_HAS_LVZ_EXTENSION
         def_bool $(as-instr,hvcl 0)

  config AS_HAS_SCQ_EXTENSION
-       def_bool $(as-instr,sc.q \$t0$(comma)\$t1$(comma)\$t2)
+       def_bool n

  config CC_HAS_ANNOTATE_TABLEJUMP
         def_bool $(cc-option,-mannotate-tablejump)
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 8cc78efe722d..1e8049937851 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -2490,15 +2490,7 @@ bool bpf_jit_bypass_spec_v4(void)

  bool bpf_jit_supports_arena(void)
  {
-       /*
-        * The arena range tree uses kmalloc_nolock(), which requires 
128-bit
-        * atomic cmpxchg support, provided by SCQ extension on LoongArch.
-        */
-#ifdef system_has_cmpxchg128
-       return system_has_cmpxchg128();
-#else
-       return false;
-#endif
+       return cpu_has_scq;
  }

  bool bpf_jit_supports_fsession(void)
```

So, the current patch has no problem IMO.

Thanks,
Tiezhu

