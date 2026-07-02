Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EBC45039
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 06:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972650; cv=none; b=VuxEuAumdnBYoepmEE3XbyUPvh+q8aZwnttdW7skB5WLlOcYQnzPGlMNHywVEZMwjtzahP4seyCAYhvI6DX6QOfVtrkhrJnnRKuKIAgbch+efuwR7kCW2R8hi047HdrQaulSRwmaDcWB3WrSPw4rFBuPRcp51h/Hx2nGqvAyYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972650; c=relaxed/simple;
	bh=l2Y5w3mPIbBEeQ8kSbXus7o5RUfZJ0TgUAfPh09G4Wk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nELqUgUDNgA/Kk1Edd1d2vMWliVvoHW1udmt4yxUk1+1EJWiUlCQ+cbwwowLxCE4M05897++gAcFv/K/XTUVso1SJ6HnaDMeEEZWSszRxw7Wtgoe7F77PAwqFJLgee9VKM9skKZeg1LhcobnXMy1eIJXNb+2a0Tonv88WurxxhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxuPDiAEZqq8oAAA--.4657S3;
	Thu, 02 Jul 2026 14:10:42 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxysHXAEZqI6q7AA--.25892S3;
	Thu, 02 Jul 2026 14:10:33 +0800 (CST)
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
Message-ID: <8e441177-455d-4a0a-00dd-8f6c2adb954d@loongson.cn>
Date: Thu, 2 Jul 2026 14:10:31 +0800
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
X-CM-TRANSID:qMiowJDxysHXAEZqI6q7AA--.25892S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw47Jw4rCry5Kw1fGw1xZwc_yoW5uw1UpF
	Wvkw4qkrykXw1093y2ya1xur1ag3yDJryUKa4fGF1Fya12qrn3XrZxKa10qFZ5Gw4kW3WI
	v342yF95u3WUZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jwnYwUUU
	UU=

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

Hi Alexei,

Sorry for the AI text. I used it to translate my replies.

- v5 code: Placed jit_required under u16 group, but u32 broke layout.
- v6 code: Moved it to offset 52 hole to fix the alignment.

Here is the local test log for v6 when JIT is disabled:

fedora@linux:~$ cat test_panic.c
   #include <linux/bpf.h>
   #include <bpf/bpf_helpers.h>

   SEC("kprobe/sys_getpid")
   int test_panic(void *ctx)
   {
   	struct task_struct *task;

   	task = (struct task_struct *)bpf_get_current_task();
   	if (task)
   		bpf_printk("Task address: %p\n", task);

   	return 0;
   }

   char LICENSE[] SEC("license") = "GPL";
fedora@linux:~$ clang -target bpf -O2 -g -c test_panic.c -o test_panic.o
fedora@linux:~$ sudo sysctl -w net.core.bpf_jit_enable=0
net.core.bpf_jit_enable = 0
fedora@linux:~$ sudo bpftool prog load test_panic.o 
/sys/fs/bpf/test_panic autoattach
libbpf: prog 'test_panic': BPF program load failed: unknown error (-524)
libbpf: prog 'test_panic': -- BEGIN PROG LOAD LOG --
processed 10 insns (limit 1000000) max_states_per_insn 0 total_states 1 
peak_states 1 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'test_panic': failed to load: -524
libbpf: failed to load object 'test_panic.o'
Error: failed to load object file

It correctly rejects loading with -ENOTSUPP (-524) and prevents the panic.

Thanks,
Tiezhu

