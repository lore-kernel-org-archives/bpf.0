Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775516;
	b=OoYJr5yUPGKKVGhnBQjBgYmTWbE1/ec3bXu5ZaT876OQJmSJRiZCegRKSRL0fRHRony/
	 mxcH8ju2WL2hoJbpMbgP27sWd5Ok4yaOmW50srgn6BJVsFvKSa289PEMSu2mReNLTDLan
	 YsTQhjank8XLRyXIxD0+uL+iz97HMxzBFjraxr7UqZEyuVVo+VhpFVBT7l5I8VednTl+Y
	 mdjnBDNMlhsVcdsiUASEFNIJZayFIILOWuvOK3+Vb3yR27SpuahJeJKLeXqAzaqRwgYXP
	 /VAw8kK5j6RFM8ixzjMj8W9M/MamhEglKEjKWkrf6Ql+WZEkBck7ZjlG1v/0l6QEcrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775516;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=hdQK57f7HyDlb+RjbKtfMWetjSY2KiFfxeS/E3Ij6Cw=;
	b=maj/Fjoa7VQozw+1j12ZfSjDGXhc87eadhbkpTXOj1MuqqRQ/D8uOR7xXaSx5RMT8+yR
	 XQDpNdozFWBUuLSbTD8RodcuUC/g8wcRJGDcWGo0eOFWpqRVhSjMnJ4sqHbfi6dtDHdXs
	 UxhpJGt6CWsWVxy6vO2/Fu+Y3DdNsZdKWwPlwTXkh4eqKOCcndzKoZY/46sQXvHIrcqLZ
	 PqN1w5h5iZGa6zTou1iVCJR19cX7NMQXIAhrkIqQmRs5oC7zBndU51jgnfgHF4swdZQoS
	 1Ka1D/Am0RrNDVWrXkk/oJc+EaCgb+m+v1tdhvfsuuhIj7oOMpLwjuCOHDGfw7uleqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85128606A31B;
	Wed,  4 Nov 2026 06:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85128606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxntKY1+pq6jccAA--.16033S3;
	Wed, 04 Nov 2026 14:58:32 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxlMyW1+pq2UQyAA--.10843S2;
	Wed, 04 Nov 2026 14:58:31 +0800 (CST)
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
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <6446c385-623c-d4cf-5a07-0c2276c6f50c@loongson.cn>
Date: Wed, 4 Nov 2026 14:58:30 +0800
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
In-Reply-To: <CAAhV-H52bqRD1SyrZsvMkNbCpGiM5DPSGPARiasZ8G3XsE5Tgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxlMyW1+pq2UQyAA--.10843S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAry5uFyxWryUWFy3KrW3Jwc_yoWrWFyUp3
	yxArnrGrWUWr1kJrZxt3yrWr4Dtr98K34a9a18A348Aan8Xa48Xr10kwn5WF1Dt39Yg3WF
	qFWrK3ZI9Fy8AabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU24So
	DUUUU

On 11/4/26 12:29 PM, Huacai Chen wrote:
> On Tue, Nov 3, 2026 at 10:24 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

...

>> So, the current patch has no problem IMO.
> OK, then I think we can use:
> 
> return __is_defined(system_has_cmpxchg128) && system_has_cmpxchg128();

If CONFIG_AS_HAS_SCQ_EXTENSION is not enabled, system_has_cmpxchg128()
is not defined at all. If we change the code to follow your suggestion,
something like this:

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
index d7ea515045ec..d124632b0fa9 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -2495,11 +2495,7 @@ bool bpf_jit_supports_arena(void)
          * atomic cmpxchg; this is provided by not only hardware SCQ 
extension
          * but also assembler support on LoongArch.
          */
-#ifdef system_has_cmpxchg128
-       return system_has_cmpxchg128();
-#else
-       return false;
-#endif
+       return __is_defined(system_has_cmpxchg128) && 
system_has_cmpxchg128();
  }

  bool bpf_jit_supports_fsession(void)
```

We will encounter a fatal build error:

   CC      arch/loongarch/net/bpf_jit.o
arch/loongarch/net/bpf_jit.c: In function ‘bpf_jit_supports_arena’:
arch/loongarch/net/bpf_jit.c:2498:55: error: implicit declaration of 
function ‘system_has_cmpxchg128’ [-Wimplicit-function-declaration]
  2498 |         return __is_defined(system_has_cmpxchg128) && 
system_has_cmpxchg128();
       | 
^~~~~~~~~~~~~~~~~~~~~
make[5]: *** [scripts/Makefile.build:290: arch/loongarch/net/bpf_jit.o] 
Error 1

Even if we change it to use IS_ENABLED(CONFIG_AS_HAS_SCQ_EXTENSION),
something like this:

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
index d7ea515045ec..1b87b1e4262e 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -2495,11 +2495,7 @@ bool bpf_jit_supports_arena(void)
          * atomic cmpxchg; this is provided by not only hardware SCQ 
extension
          * but also assembler support on LoongArch.
          */
-#ifdef system_has_cmpxchg128
-       return system_has_cmpxchg128();
-#else
-       return false;
-#endif
+       return IS_ENABLED(CONFIG_AS_HAS_SCQ_EXTENSION) && 
system_has_cmpxchg128();
  }

  bool bpf_jit_supports_fsession(void)
```

It still fails with the same error due to the macro visibility:

   CC      arch/loongarch/net/bpf_jit.o
arch/loongarch/net/bpf_jit.c: In function ‘bpf_jit_supports_arena’:
arch/loongarch/net/bpf_jit.c:2498:59: error: implicit declaration of 
function ‘system_has_cmpxchg128’ [-Wimplicit-function-declaration]
  2498 |         return IS_ENABLED(CONFIG_AS_HAS_SCQ_EXTENSION) && 
system_has_cmpxchg128();
       | 
^~~~~~~~~~~~~~~~~~~~~
make[5]: *** [scripts/Makefile.build:290: arch/loongarch/net/bpf_jit.o] 
Error 1

Therefore, using the explicit #ifdef block in the original patch is the
only way to ensure toolchain compatibility and compile-time robustness
here IMO.

Anyway, I will modify the patch subject, update the commit message
and code comment to make it more clear.

Thanks,
Tiezhu

