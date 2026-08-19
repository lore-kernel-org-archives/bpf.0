Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E36923ED60;
	Wed, 19 Aug 2026 04:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787113983; cv=none; b=IHIiNNaZkGLAOo2LS51KjhiYCU4+KFsgjZw3fOtzZUacdTuDozLj/9F4d3MvrsNw6yH2nfFzgBgv6F+GqBBcIRJpDuVnDyxBots9D6mtA8OvqYvyghad+8ikO/RCO064ngEWsnu9XZF+kBy7Lx1AiXDVC585w0/gUWdo+k1fYkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787113983; c=relaxed/simple;
	bh=GODhuljw+vwCKR2nwV1KNUDB1Kqfo6DSPt49GbIzhl4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GpRRPbBgHkckv23/BeT6APkZF9dZcKf04p7FDam4SQpbGJ3WgV9c3o/GuP8temoBFUlICQ6R5RVBOKYOy3KvcdsnKCJMCvFjiINcvmB87wFNBaX1KZ9HogtGiS8WnyxBPPLvGN70gi1X1b7tNA0uMuc0vlO5N6L+WLKFtFcfzb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8BxW_D4MYVqt5ICAA--.7781S3;
	Wed, 19 Aug 2026 12:32:56 +0800 (CST)
Received: from [10.130.40.83] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx3c72MYVqTy0KAA--.63623S2;
	Wed, 19 Aug 2026 12:32:55 +0800 (CST)
Subject: Re: [PATCH v1] LoongArch: Fix __smp_mb__{before,after}_atomic()
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Vincent Li <vincent.mc.li@gmail.com>, bpf@vger.kernel.org
References: <20260817035908.460-1-yangtiezhu@loongson.cn>
 <3103b3b4-5c0d-ed87-2e15-31a4d2289ec5@loongson.cn>
 <DKS3YCAMWONO.2NVVH8IPARH7Y@gmail.com>
 <48ade10d-dd1f-ac6f-e827-d76a81183486@loongson.cn>
 <DKS4KWIT8C5I.2THOLN7FKRRJT@gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <fe42c351-e6f9-8336-a5e0-895a4572fd3f@loongson.cn>
Date: Wed, 19 Aug 2026 12:32:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <DKS4KWIT8C5I.2THOLN7FKRRJT@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx3c72MYVqTy0KAA--.63623S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw1rCw4UtFyfZr48JFWxZrc_yoWrZr4fpF
	4xGF9rKFZ5XF48Zw1kJw4ru34fCw40k3y3WrWFgryYv3s0gry2qF1Ivr4a9FyDWw4ktryI
	vw4jgay2va4DJagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
	UUU==

On 2026/8/18 下午10:05, Kumar Kartikeya Dwivedi wrote:
> On Tue Aug 18, 2026 at 3:50 PM CEST, Tiezhu Yang wrote:
>> On 2026/8/18 下午9:35, Kumar Kartikeya Dwivedi wrote:
>>> On Tue Aug 18, 2026 at 3:28 PM CEST, Tiezhu Yang wrote:
>>>> On 2026/8/17 上午11:59, Tiezhu Yang wrote:
>>>>> When testing the BPF selftest "sudo ./test_progs -t timer_lockup", there
>>>>> is a kernel lockup and panic:

...

>>> There is a full barrier in both cases. I don't know what performance improvement
>>> will be achieved by changing this.
>>
>> We performed benchmarking using UnixBench on a physical LoongArch
>> machine, the UnixBench score is different (amadd.w + dbar < amadd_db.w).
>>
> 
> I mean, this function is already quite heavy. We have multiple fully ordered
> atomics (refcount bumps/drops, xchg(), etc.) spread across the operation. Do you
> observe any measurable speedup in the throughput of this function?  The second
> question is whether timer cancellation is really frequent. In practice, I don't
> think that is the case.  The actual hrtimer_cancel() in itself is heavy and
> waits synchronously for the callback to finish.
> 
> I'm not opposed to it or anything, I just don't think it's worth it in this
> case. If the latency of cancel is a problem there are other bigger opportunities
> to pursue than this.

Hi Kumar,

Thanks for your analysis. I totally agree that bpf_timer_cancel() is
heavy and cancellation is not a frequent fast path.

However, there is an interesting compiler and architecture background
here:

During our internal review, toolchain developers noted that executing
two separate instructions (amadd.w + dbar) causes a noticeable pipeline
bubble, and they are currently working on a compiler-level optimization
to automatically fuse them into a single ordered instruction amadd_db.w.

Since toolchain-level fusion into a single instruction is the clear
goal, explicitly using atomic_fetch_add() in the BPF helper achieves
this exact single-instruction benefit immediately, without waiting
for compiler updates.

More importantly, it hardens defensive programming, making the BPF
core logic immune to any architecture-level macro omissions.

To provide a concrete micro-architectural perspective, here is the
actual objdump comparison on a physical LoongArch machine between
the two approaches:

Approach 1 (Architecture fix: atomic_inc + smp_mb__after_atomic):
     2610:  amadd.w     $zero, $t2, $t3  /* Relaxed atomic increment */
     2614:  dbar        0x10             /* Explicit data memory barrier */

Approach 2 (Our BPF core change: atomic_fetch_add):
     2610:  amadd_db.w  $t3, $t1, $t4    /* Consolidated ordered atomic */

As the assembly shows, Approach 2 successfully eliminates a heavy
standalone hardware fence instruction (dbar 0x10).

What are your thoughts on this logic?

---
Appendix: Code Diff & Objdump for Reference

[1] Code Diff & Objdump for Approach 1:
diff --git a/arch/loongarch/include/asm/barrier.h 
b/arch/loongarch/include/asm/barrier.h
index 4b663f197706..adfe343dfa65 100644
--- a/arch/loongarch/include/asm/barrier.h
+++ b/arch/loongarch/include/asm/barrier.h
@@ -57,8 +57,8 @@
  #define __WEAK_LLSC_MB         "                       \n"
  #endif

-#define __smp_mb__before_atomic()      barrier()
-#define __smp_mb__after_atomic()       barrier()
+#define __smp_mb__before_atomic()      __smp_mb()
+#define __smp_mb__after_atomic()       __smp_mb()

$ objdump -d -S kernel/bpf/helpers.o
ATOMIC_OPS(add, i, add, +)
     2608:	0280040e 	li.w        	$t2, 1
     260c:	02c2e2ef 	addi.d      	$t3, $s0, 184
     2610:	386139e0 	amadd.w     	$zero, $t2, $t3
	smp_mb__after_atomic();
     2614:	38720010 	dbar        	0x10

[2] Code Diff & Objdump for Approach 2:
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c18f1e16edee..ee2b3a4dcc05 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1591,9 +1591,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern 
*, async)
          */
         if (!cur_t)
                 goto drop;
-       atomic_inc(&t->cancelling);
-       /* Need full barrier after relaxed atomic_inc */
-       smp_mb__after_atomic();
+       atomic_fetch_add(1, &t->cancelling);
         inc = true;
         if (atomic_read(&cur_t->cancelling)) {

$ objdump -d -S kernel/bpf/helpers.o
ATOMIC_OPS(add, i, add, +)
     2608:	0280040d 	li.w        	$t1, 1
     260c:	02c2e2f0 	addi.d      	$t4, $s0, 184
     2610:	386a360f 	amadd_db.w  	$t3, $t1, $t4

Thanks,
Tiezhu

