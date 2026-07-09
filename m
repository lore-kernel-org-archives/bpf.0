Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCDA38F226
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568230; cv=none; b=N7FPG4gya2CZBAD1ms2oArpEp6v/bs2cHz8yhPPp1AnDkqZk61iukNzDdcjdXRRI+FCO0sm0qZE/MBQ/NdY+cHpXS+jzNN3YCCgsFjH0f1qkT5Rt3GwoEW855Kb9z0tRZX7wq9LHoKsnqfJKafXBwme1BcZkUc17ceV4CLSmPDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568230; c=relaxed/simple;
	bh=lngESO5xPN08rbasMRTXTycsJ8gEcJ7PWqC94sL11ME=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BWLVIZb5n4EnfsG8i9gzpx4kOxhVJDgpccBPIXxJuPgb3ou9pcAjSrbaoymOI8oeRa0nyQOxf4GaRhscYLaB8qEWjW8AZC/S4kdY62ceRhEyC+lhEF5Iu5h4oDNm2obkHYDhrMRT0hJtM5q0Ieli76AV02WWf9rLjqLPmcujpug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx1+pVF09qorUBAA--.7209S3;
	Thu, 09 Jul 2026 11:36:53 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxDcdKF09qFWwGAA--.11651S2;
	Thu, 09 Jul 2026 11:36:43 +0800 (CST)
Subject: Re: [PATCH bpf-next v9 2/2] bpf: Reject programs with inlined helpers
 if JIT is not available
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, kafai.wan@linux.dev
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev, leon.hwang@linux.dev,
 puranjay@kernel.org, bjorn@kernel.org, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260708101806.18885-3-yangtiezhu@loongson.cn>
 <ec55680c84f90a8fdd97e0788926d322ea765e18df1604bf71fbd00b45b52f73@mail.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <02442c90-9467-ccb3-17a4-4c01f1bc3b38@loongson.cn>
Date: Thu, 9 Jul 2026 11:36:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ec55680c84f90a8fdd97e0788926d322ea765e18df1604bf71fbd00b45b52f73@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxDcdKF09qFWwGAA--.11651S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gr13CrWrGFW3CF1fCFW5XFc_yoWxCrykpF
	Z0qw48Kr4kX34I93y7Jw4UAr15tw4DAF15CFyrGr1rC3W5Xr18XFyxK3y29Fs0yr4UKw17
	Zr4jyw12k3WDXagCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUn0D73UUUU
	U==

On 2026/7/8 下午6:59, bot+bpf-ci@kernel.org wrote:
>> When an architecture (such as LoongArch, ARM64, and RISC-V) implements
>> bpf_jit_inlines_helper_call(), the verifier skips rewriting the helper
>> call offset (insn->imm) in bpf_do_misc_fixups(). This is because the
>> helper is expected to be inlined by the JIT compiler later. Therefore,
>> insn->imm remains as the raw helper enum ID.
>>
>> However, if JIT is disabled at runtime (net.core.bpf_jit_enable=0) or
>> if JIT compilation fails dynamically (e.g., due to OOM), the program
>> falls back to the BPF interpreter.
>>
>> When the interpreter executes (__bpf_call_base + insn->imm) with the
>> unpatched raw ID, it jumps into an invalid address space, triggering
>> an instruction alignment fault or a kernel panic.
>>
>> Although these helpers have valid C implementations in the kernel, the
>> omission of offset rewriting makes runtime interpreter fallback fatal.
>>
>> Fix this by setting 'prog->jit_required = 1' when helper call rewriting
>> is skipped for JIT inlining. This ensures that such programs are safely
>> rejected if JIT is not available, preventing the runtime kernel panic.
> 
> The commit message gives two reasons for the interpreter fallback:
> 
>> However, if JIT is disabled at runtime (net.core.bpf_jit_enable=0) or
>> if JIT compilation fails dynamically (e.g., due to OOM), the program
>> falls back to the BPF interpreter.
> 
> Is the "fails dynamically (e.g., due to OOM)" part accurate?
> 
> The JIT decision looks like it is settled before verification runs:
> bpf_prog_alloc_no_stats() sets fp->jit_requested ahead of the bpf_check()
> call in bpf_prog_load(), so the choice between JIT and interpreter appears
> to be made at load time rather than changing after a dynamic JIT failure.
> 
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 02246df2f6c3..d3be972714b2 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -1840,8 +1840,10 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>>   		}
>>
>>   		/* Skip inlining the helper call if the JIT does it. */
>> -		if (bpf_jit_inlines_helper_call(insn->imm))
>> +		if (bpf_jit_inlines_helper_call(insn->imm)) {
>> +			prog->jit_required = 1;
>>   			goto next_insn;
>> +		}
> 
> If the JIT decision is final at load time, would gating on
> bpf_jit_inlines_helper_call() together with the jit-enabled state be
> enough here, without depending on the dynamic-failure rationale?
> 
> This point was raised during review of an earlier version of the series
> and does not appear to have been answered before this version, and the
> disputed wording is still present in the commit message.

I tested on a real hardware (Loongson-3A6000 physical machine).

Only with the first patch and without this second patch,
keep net.core.bpf_jit_enable=1, simulate a dynamic JIT
failure like this:

```
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 2738b4db1165..fa56a593ac1a 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -2208,7 +2208,7 @@ struct bpf_prog *bpf_int_jit_compile(struct 
bpf_verifier_env *env, struct bpf_pr
          * If BPF JIT was not enabled then we must fall back to
          * the interpreter.
          */
-       if (!prog->jit_requested)
+       if (prog->jit_requested)
                 return prog;

         jit_data = prog->aux->jit_data;
```

CONFIG_BPF_JIT_ALWAYS_ON is disabled, the kernel panics.

Here are the test logs:

```
fedora@linux:~$ cat test_panic.c
   #include <linux/bpf.h>
   #include <bpf/bpf_helpers.h>

   SEC("kprobe/sys_getpid")
   int test_panic(void *ctx)
   {
   	struct task_struct *task;

   	task = (struct task_struct *)bpf_get_current_task_btf();
   	if (task)
   		bpf_printk("Task address: %p\n", task);

   	return 0;
   }

   char LICENSE[] SEC("license") = "GPL";
fedora@linux:~$ clang -target bpf -O2 -g -c test_panic.c -o test_panic.o
fedora@linux:~$ sudo sysctl -w net.core.bpf_jit_enable=1
net.core.bpf_jit_enable = 1
fedora@linux:~$ sudo bpftool prog load test_panic.o 
/sys/fs/bpf/test_panic autoattach
fedora@linux:~$ sudo cat /sys/kernel/debug/tracing/trace_pipe
Segmentation fault

[  662.150034] Kernel ade access[#1]:
[  662.153416] CPU: 5 UID: 0 PID: 1224 Comm: (udev-worker) Not tainted 
7.2.0-rc1bpf+ #7 PREEMPT(full)
[  662.162408] Hardware name: Loongson 
Loongson-3A6000-7A2000-1w-V0.1-EVB/Loongson-3A6000-7A2000-1w-EVB-V1.21, 
BIOS Loongson-UDK2018-V4.0.05878.1-stable20241
[  662.176149] pc 9000000000f6a02e ra 9000000000f6ba70 tp 
9000000122539000 sp 900000015ef33ad0
[  662.184447] a0 900000015ef33d20 a1 0000000000000000 a2 
0000000000000000 a3 0000000000000000
[  662.192745] a4 0000000000000000 a5 00007ffffb7ebe4b a6 
00007ffffb7ebe4b a7 00000000000000ac
[  662.201044] t0 9000000000f6a02e t1 000000000000009e t2 
c1cd71039fc4e000 t3 00000000000000f4
[  662.209342] t4 900000016ebcdb00 t5 9000000122539000 t6 
0000000000000000 t7 0000000000ff0100
[  662.217640] t8 900000015ef33e60 u0 00000004749f0000 s9 
900000015ef33ec0 s0 ffff800032be0060
[  662.225938] s1 0000000000000051 s2 00000000000000f1 s3 
0000000000000040 s4 0000000000000000
[  662.234236] s5 900000015ef33b40 s6 9000000003520148 s7 
900000012218f9d0 s8 0000000000000000
[  662.242534]    ra: 9000000000f6ba70 ___bpf_prog_run+0x1370/0x36b0
[  662.248590]   ERA: 9000000000f6a02e __traceiter_xdp_exception+0x4e/0x90
[  662.255161]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
[  662.261307]  PRMD: 00000004 (PPLV0 +PIE -PWE)
[  662.265633]  EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
[  662.270392]  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
[  662.275150] ESTAT: 00080000 [ADEF] (IS= ECode=8 EsubCode=0)
[  662.280686]  BADV: 9000000000f6a02e
[  662.284146]  PRID: 0014d000 (Loongson-64bit, Loongson-3A6000)
```

The root cause can be easily seen in `__bpf_prog_select_runtime()`
after only applying patch 1:

1. Without patch 2, `fp->jit_required` remains `false` for programs
    using JIT-inlined helpers, so `jit_needed` initializes to `false`.
2. When the JIT compiler fails dynamically (returning `!fp->jited`),
    the program incorrectly falls back to the interpreter.

Thus the following conditions are not matched in
`__bpf_prog_select_runtime()`:

                 if (!fp->jited && jit_needed) {
                         *err = -ENOTSUPP;
                         return fp;
                 }

`!fp->jited` is true, but `jit_needed` is false.

3. As a result, the program incorrectly falls back to the interpreter
with unpatched instruction raw IDs, causing the fatal kernel panic.

IMO, there is no problem in the commit message.

Thanks,
Tiezhu

