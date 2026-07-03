Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED81F1D9A5F
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783095272; cv=none; b=bYdlpCuCCmxqjAJ2llpnE2GXeck9x26M4pVC7etPOglSP5PKhmD5rqcggzVFMVgx7qiZCjkm3RJcsmPrwJPpWV8yPS8iDfvwDZ8PU/sO02Jrp+hFnP9hm/psDFYWJVscRnRWLEhv0OOz3817khflXY4cAha3Lceh62j/oIo4CQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783095272; c=relaxed/simple;
	bh=7w/X1cc13jwOkMFd7WkIJ0IZogAONd76gWlycTImxpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PRWH82ijIe1Qs8PF+3aTDLfYssl9Ok2D45rpR06vs6uTAOcUY8xPUrKSeFHzgzv5csPhBEtvyOCQIjVmHv3Hn3IdavtWo2abZ+NsZvmFGAw0biFByrXfUEsbKt1Y6OX5beL8QoVqhidd+z9MXmBZ79PB3ZMM7kK+0lWNhtGk8Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [36.44.120.111])
	by gateway (Coremail) with SMTP id _____8DxOPLi30dqiGUBAA--.7395S3;
	Sat, 04 Jul 2026 00:14:26 +0800 (CST)
Received: from [192.168.0.111] (unknown [36.44.120.111])
	by front1 (Coremail) with SMTP id qMiowJBxacHe30dqDju+AA--.19487S3;
	Sat, 04 Jul 2026 00:14:25 +0800 (CST)
Message-ID: <2d1babdf-a4d9-9902-77b0-3f5640871323@loongson.cn>
Date: Sat, 4 Jul 2026 00:14:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Introduce jit_required flag and
 refactor kfunc path
Content-Language: en-US
To: KaFai Wan <kafai.wan@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev,
 Leon Hwang <leon.hwang@linux.dev>, Puranjay Mohan <puranjay@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20260702143656.28845-1-yangtiezhu@loongson.cn>
 <20260702143656.28845-2-yangtiezhu@loongson.cn>
 <ba5679e744e0209ca10788c2c385c6727eddb8a5.camel@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <ba5679e744e0209ca10788c2c385c6727eddb8a5.camel@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxacHe30dqDju+AA--.19487S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr4xtw43Ww17KrWUuF1UXFc_yoWrurykpF
	ykGasrCF109r409F9rJF48ZrW5t3W0kr17Kry8Kry09r1qgw1vga48G3sxZa9Yqr4vkr10
	vF9FvrWUt34UZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Jr0_Gr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8HKZJUUUUU==

On 7/3/26 21:55, KaFai Wan wrote:
> On Thu, 2026-07-02 at 22:36 +0800, Tiezhu Yang wrote:
>> Introduce a 'jit_required' bitfield flag at the end of the
>> flags group in struct bpf_prog. This bit tracks whether a
>> program strictly requires the JIT compiler.
>>
>> Set this flag to 1 when a kfunc call is added at the end of
>> bpf_add_kfunc_call().
>>
>> In __bpf_prog_select_runtime(), check with fp->jit_required
>> rather than bpf_prog_has_kfunc_call() to unify the logic.
>>
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Suggested-by: KaFai Wan <kafai.wan@linux.dev>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   include/linux/bpf.h   | 3 ++-
>>   kernel/bpf/core.c     | 3 +--
>>   kernel/bpf/verifier.c | 2 ++
>>   3 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index ba09795e0bfd..4e2b059d71f3 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1880,7 +1880,8 @@ struct bpf_prog {
>>   				call_get_func_ip:1, /* Do we call get_func_ip() */
>>   				call_session_cookie:1, /* Do we call bpf_session_cookie() */
>>   				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
>> -				sleepable:1;	/* BPF program is sleepable */
>> +				sleepable:1,	/* BPF program is sleepable */
>> +				jit_required:1;	/* program strictly requires JIT compiler
>> */
> 
> In v6 you're using 'u8 jit_required', I thought it would be 'u8 jit_required:1', so we use one byte
> and left 3 byte hole for future use.
> 
> This version left 2 bytes hole, same as v5, but it can easily be misleading because of the u16 type,
> since we used 17 bits. I prefer v5, it has better readability.

OK, I will use the previous layout in v8, like this:

```
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ba09795e0bfd..463fae6a5c33 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1865,8 +1865,9 @@ struct bpf_prog_aux {

  struct bpf_prog {
  	u16			pages;		/* Number of allocated pages */
-	u16			jited:1,	/* Is our filter JIT'ed? */
+	u32			jited:1,	/* Is our filter JIT'ed? */
  				jit_requested:1,/* archs need to JIT the prog */
+				jit_required:1, /* program strictly requires JIT compiler */
  				gpl_compatible:1, /* Is filter GPL compatible? */
  				cb_access:1,	/* Is control block accessed? */
  				dst_needed:1,	/* Do we need dst entry? */
```

> 
>>   	enum bpf_prog_type	type;		/* Type of BPF program */
>>   	enum bpf_attach_type	expected_attach_type; /* For some prog types */
>>   	u32			len;		/* Number of filter blocks */
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 649cce41e13f..5fcd19ccb41a 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2619,8 +2619,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env,
>> struct
>>   	if (fp->bpf_func)
>>   		goto finalize;
>>   
>> -	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
>> -	    bpf_prog_has_kfunc_call(fp))
>> +	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) || fp->jit_required)
>>   		jit_needed = true;
>>   
>>   	if (!bpf_prog_select_interpreter(fp))
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 25aea4271cd0..f496b45b9da4 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -2765,6 +2765,8 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16
>> offset)
>>   	desc->func_model = func_model;
>>   	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
>>   	     kfunc_desc_cmp_by_id_off, NULL);
>> +
>> +	env->prog->jit_required = 1;
> 
> That's ok, and I think Sashiko is right about this patch.
> 
>>   	return 0;
>>   }

As discussed in another thread, I will update bpf_prog_has_kfunc_call()
in v8, like this:

```
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 25aea4271cd0..c34cc524651a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2770,7 +2770,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env
*env, u32 func_id, u16 offset)

   bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
   {
-       return !!prog->aux->kfunc_tab;
+       return prog->aux->kfunc_tab && prog->aux->kfunc_tab->nr_descs;
   }

   static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
```

IIUC, there are two places to modify so far:
(1) struct bpf_prog
(2) bpf_prog_has_kfunc_call()

If you have any more comments, please let me know.

Thanks,
Tiezhu

