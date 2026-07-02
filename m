Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F118C356764
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976832; cv=none; b=qBva+zY1xaKXtxlkMwf4wdYp8UA33y/xgQ7Nm6XP3a6Bb5dPq/C2k/Jrbchfy/Q+38zJ3mZ3B20PaHYbjns6eTHacnXtITkecZeFEb01qQDcfsM+XHEZe5q/4I/wuVthVRe+uasO7AhxrazHiM00fvwGuLeECUv3zw60KvD/V/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976832; c=relaxed/simple;
	bh=SEOsQgUF4DRi2+CHY7uhpWinmVqROYTwmseFKyd78aE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=frLx1o16Eqw6YwwbhHl+3vV4N9GNmAdwV2r9oRIxiRgyTPZstSUn7b9Xy5TjtT0z8tfHmvI/Txgsjx8waNacz6Y0+UmHKRu3KrfnjQsLDB3Kkdplphi9V1rSHrsI/U5RXbkYPo8xIfG0QG0VrEaGPO8HUIndkvqQ7vkUJNhpV50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxGfE5EUZqD88AAA--.4734S3;
	Thu, 02 Jul 2026 15:20:25 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxpsA2EUZqvbu7AA--.59525S3;
	Thu, 02 Jul 2026 15:20:23 +0800 (CST)
Subject: Re: [PATCH bpf-next v6] bpf: Reject programs with inlined helpers if
 JIT is unavailable
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, KaFai Wan <kafai.wan@linux.dev>,
 bpf <bpf@vger.kernel.org>, loongarch@lists.linux.dev,
 Leon Hwang <leon.hwang@linux.dev>, Puranjay Mohan <puranjay@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20260702053127.23599-1-yangtiezhu@loongson.cn>
 <CAADnVQJodzDppDUjSYXra-jCo3J32t7=h32bHm4tQei-+5P72w@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <a234d790-699d-4029-261a-9db131398e7b@loongson.cn>
Date: Thu, 2 Jul 2026 15:20:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJodzDppDUjSYXra-jCo3J32t7=h32bHm4tQei-+5P72w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxpsA2EUZqvbu7AA--.59525S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw47Jw4rCry5Kw1fGw1xZwc_yoWrWF1UpF
	yDCa1kCrWUX39F9as7Ja18ur4aq393GF17K3Z8Gw1Fk34qgwn3JF1agF1Y9F98Wr48u3WI
	vrnFgF17Zw15JFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8loGP
	UUUUU==

On 2026/7/2 下午1:45, Alexei Starovoitov wrote:
> On Wed, Jul 1, 2026 at 10:31 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> When an architecture implements bpf_jit_inlines_helper_call(), such as
>> LoongArch, ARM64, PowerPC, and RISC-V, the verifier skips rewriting the
>> helper call offset (insn->imm) during the bpf_do_misc_fixups() phase,
>> because the helper is expected to be inlined by the JIT compiler. As a
>> result, insn->imm remains as the raw helper enum ID.
>>
>> However, if JIT is disabled at runtime (net.core.bpf_jit_enable=0) or
>> if the JIT compilation later dynamically fails (e.g., due to OOM), the
>> core BPF subsystem falls back to the BPF interpreter.
>>
>> When the interpreter executes (__bpf_call_base + insn->imm) with the
>> unpatched raw helper ID, it jumps into an unaligned invalid address
>> space, triggering an instruction alignment fault or a memory access
>> panic.
>>
>> To avoid modifying the BPF interpreter's complexity for JIT-specific
>> paths, just introduce a 'jit_required' flag in struct bpf_prog. When
>> a program contains helper calls that skip rewriting for JIT inlining,
>> set this flag to 1. During runtime selection, if JIT compilation is
>> not available, explicitly reject loading with -ENOTSUPP instead of
>> falling back to the interpreter, safely preventing the kernel panic.
>>
>> Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>> v6:
>>    - Place 'jit_required' as a standalone u8 field right before 'stats'
>>      to reuse the existing 4-byte struct hole (offset 52) based on pahole
>>      analysis, avoiding the u16->u32 bitfield conversion in v5 which
>>      unintentionally changed the layout/alignment of subsequent fields.
> 
> v5 had AI written all over it. v6 is not any better.
> Please ask AI whether your v6 is any better than v5 ?
> Then analyze replies as a human.

The v6 code is a significant layout improvement over v5.

v5 broke natural 4-byte alignment, while v6 rolls back the bitfield
and utilizes a 4-byte hole at offset 52 for 'jit_required'.

Here is the partial pahole output for v6:

struct bpf_prog {
     ...
	u8                         jit_required;         /*    52     1 */
	/* XXX 3 bytes hole, try to pack */
     ...
	/* size: 96, cachelines: 2, members: 29 */
};

The layout preserves 16-bit packing, alignment, and 96-byte size.

Here is the full pahole output for v6:

fedora@linux:~/702jit.git$ pahole -C bpf_prog ./vmlinux
struct bpf_prog {
	u16                        pages;                /*     0     2 */
	u16                        jited:1;              /*     2: 0  2 */
	u16                        jit_requested:1;      /*     2: 1  2 */
	u16                        gpl_compatible:1;     /*     2: 2  2 */
	u16                        cb_access:1;          /*     2: 3  2 */
	u16                        dst_needed:1;         /*     2: 4  2 */
	u16                        blinding_requested:1; /*     2: 5  2 */
	u16                        blinded:1;            /*     2: 6  2 */
	u16                        is_func:1;            /*     2: 7  2 */
	u16                        kprobe_override:1;    /*     2: 8  2 */
	u16                        has_callchain_buf:1;  /*     2: 9  2 */
	u16                        enforce_expected_attach_type:1; /*     2:10 
2 */
	u16                        call_get_stack:1;     /*     2:11  2 */
	u16                        call_get_func_ip:1;   /*     2:12  2 */
	u16                        call_session_cookie:1; /*     2:13  2 */
	u16                        tstamp_type_access:1; /*     2:14  2 */
	u16                        sleepable:1;          /*     2:15  2 */
	enum bpf_prog_type         type;                 /*     4     4 */
	enum bpf_attach_type       expected_attach_type; /*     8     4 */
	u32                        len;                  /*    12     4 */
	u32                        jited_len;            /*    16     4 */
	union {
		u8                 digest[32];           /*    20    32 */
		u8                 tag[8];               /*    20     8 */
	};                                               /*    20    32 */
	u8                         jit_required;         /*    52     1 */

	/* XXX 3 bytes hole, try to pack */

	struct bpf_prog_stats *    stats;                /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	u8 *                       active;               /*    64     8 */
	unsigned int               (*bpf_func)(const void  *, const struct 
bpf_insn  *); /*    72     8 */
	struct bpf_prog_aux *      aux;                  /*    80     8 */
	struct sock_fprog_kern *   orig_prog;            /*    88     8 */
	union {
		struct {
			struct {
			} __empty_insns;                 /*    96     0 */
			struct sock_filter insns[0];     /*    96     0 */
		};                                       /*    96     0 */
		struct {
			struct {
			} __empty_insnsi;                /*    96     0 */
			struct bpf_insn insnsi[0];       /*    96     0 */
		};                                       /*    96     0 */
	};                                               /*    96     0 */

	/* size: 96, cachelines: 2, members: 29 */
	/* sum members: 91, holes: 1, sum holes: 3 */
	/* sum bitfield members: 16 bits (2 bytes) */
	/* last cacheline: 32 bytes */
};

Thanks,
Tiezhu

