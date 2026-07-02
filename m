Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA63318B96
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782963101; cv=none; b=Q7PEUQX6PcDJWchX6QrVVUVd1bLclFtm5yBRUl8/dJV0dP32GnBVai/51GWytfA1qNMM7zBQlZDA/JaDO4WiqUfADikSfdLRFiffk2nA6vWV6EIlLO1HiX6/a7xFnekDlkLmOYYXkNWYq/jUsXam9U10oV5zN7wMDrpWd35ya58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782963101; c=relaxed/simple;
	bh=Cq8aVbupcdVVj0iwOLMAbsuiwqFEAE8N9FpHv/x/w0o=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cIu+rzEkp2kFkJK+KXRf4A/3nydmYb60CTuElWpdcBOUlm3hFzC+LIyJddhdXCE0EQKV9wTefYMJMb64Sw2j4DVPsLl3/1dQ1E5yZIwBA5PjFeC4NPY5xcuxKJYU0wrx7P9D+GKliSI7DuyWmZRwmntJZ+LnjvW6tIXWvBN5eak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxCfGS20Vq_cIAAA--.4498S3;
	Thu, 02 Jul 2026 11:31:30 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxSMGP20VqaYS7AA--.13542S3;
	Thu, 02 Jul 2026 11:31:28 +0800 (CST)
Subject: Re: [PATCH bpf-next v5] bpf: Reject programs with inlined helpers if
 JIT is unavailable
To: Leon Hwang <leon.hwang@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, KaFai Wan <kafai.wan@linux.dev>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev
References: <20260702022108.17693-1-yangtiezhu@loongson.cn>
 <3fe115fd-8df8-4bf0-805b-2d0c2c40fdf5@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <527b7e2e-e9cc-33b2-6a17-a888331a4d3e@loongson.cn>
Date: Thu, 2 Jul 2026 11:31:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3fe115fd-8df8-4bf0-805b-2d0c2c40fdf5@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxSMGP20VqaYS7AA--.13542S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFyrWr15GrWfXryxGr4fXrc_yoW5tryfpF
	1DCw1kuFWI9rWxWrWkAa18ury3trW5Gr17KF40grWjgr1DWFZ7Gw1fKF45A3s3ur4vvF10
	vrnFvr9xJr13X3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07joc_-UUU
	UU=

On 2026/7/2 上午11:17, Leon Hwang wrote:
> On 2/7/26 10:21, Tiezhu Yang wrote:
> [...]
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index ba09795e0bfd..463fae6a5c33 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1865,8 +1865,9 @@ struct bpf_prog_aux {
>>   
>>   struct bpf_prog {
>>   	u16			pages;		/* Number of allocated pages */
>> -	u16			jited:1,	/* Is our filter JIT'ed? */
>> +	u32			jited:1,	/* Is our filter JIT'ed? */
>>   				jit_requested:1,/* archs need to JIT the prog */
>> +				jit_required:1, /* program strictly requires JIT compiler */
> 
> Looks good to put jit_required together with jit_requested.
> 
> However, 'u16 -> u32' changes the layout of struct bpf_prog.
> 
> Before the change, pahole -C bpf_prog ./vmlinux
> 
> struct bpf_prog {
> 	u16                        pages;                /*     0     2 */
> 	u16                        jited:1;              /*     2: 0  2 */
> 	u16                        jit_requested:1;      /*     2: 1  2 */
> 	u16                        gpl_compatible:1;     /*     2: 2  2 */
> 	u16                        cb_access:1;          /*     2: 3  2 */
> 	u16                        dst_needed:1;         /*     2: 4  2 */
> 	u16                        blinding_requested:1; /*     2: 5  2 */
> 	u16                        blinded:1;            /*     2: 6  2 */
> 	u16                        is_func:1;            /*     2: 7  2 */
> 	u16                        kprobe_override:1;    /*     2: 8  2 */
> 	u16                        has_callchain_buf:1;  /*     2: 9  2 */
> 	u16                        enforce_expected_attach_type:1; /*     2:10
> 2 */
> 	u16                        call_get_stack:1;     /*     2:11  2 */
> 	u16                        call_get_func_ip:1;   /*     2:12  2 */
> 	u16                        call_session_cookie:1; /*     2:13  2 */
> 	u16                        tstamp_type_access:1; /*     2:14  2 */
> 	u16                        sleepable:1;          /*     2:15  2 */
> 	enum bpf_prog_type         type;                 /*     4     4 */
> 	enum bpf_attach_type       expected_attach_type; /*     8     4 */
> 	u32                        len;                  /*    12     4 */
> 	u32                        jited_len;            /*    16     4 */
> 	union {
> 		u8                 digest[32];           /*    20    32 */
> 		u8                 tag[8];               /*    20     8 */
> 	};                                               /*    20    32 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	struct bpf_prog_stats *    stats;                /*    56     8 */

Hi,

Thank you for the detailed pahole analysis! You are absolutely right.
Changing 'u16 -> u32' for the bitfield group row implicitly changed
the layout of subsequent fields like 'type', disrupting their natural
alignment and padding.

To address this and preserve the original bitfield packed layout perfectly,
I have rolled back the 'u16 -> u32' change. Instead, I moved 'jit_required'
out of the bitfield group and declared it as a standalone 'u8' field right
before 'stats'. This elegantly packs it into the existing 4-byte structural
hole (at offset 52).

The total size of struct bpf_prog stays exactly at 96 bytes, with zero
alignment regression.

Here is the incremental diff based on the previous v5 patch:

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 463fae6a5c33..f5c283af3cf7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1865,9 +1865,8 @@ struct bpf_prog_aux {

  struct bpf_prog {
         u16                     pages;          /* Number of allocated 
pages */
-       u32                     jited:1,        /* Is our filter JIT'ed? */
+       u16                     jited:1,        /* Is our filter JIT'ed? */
                                 jit_requested:1,/* archs need to JIT 
the prog */
-                               jit_required:1, /* program strictly 
requires JIT compiler */
                                 gpl_compatible:1, /* Is filter GPL 
compatible? */
                                 cb_access:1,    /* Is control block 
accessed? */
                                 dst_needed:1,   /* Do we need dst entry? */
@@ -1890,6 +1889,7 @@ struct bpf_prog {
                 u8 digest[SHA256_DIGEST_SIZE];
                 u8 tag[BPF_TAG_SIZE];
         };
+       u8                      jit_required;   /* program strictly 
requires JIT compiler */
         struct bpf_prog_stats __percpu *stats;
         u8 __percpu             *active;        /* u8[BPF_NR_CONTEXTS] 
for recursion protection */
         unsigned int            (*bpf_func)(const void *ctx,

I will collect this optimization and send out the formal V6 patchset 
shortly.

Thanks,
Tiezhu

