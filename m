Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AF72E737E;
	Thu, 11 Jun 2026 03:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781148513; cv=none; b=FIj0C2HEsiR4oRsN53OsmBom0Rr0nN9OZ8uJpB20Q4ywRptDlg+4nYTvT+ReJiHwk5OGEOseFoNn2u7OYEyWOSkIbv6gjYLxRRvOC9ovdYR2EsGlb733ESzJMs1UxfRsjgo9zmmqy6QjGeeNpMUB2j9kNHm4F9kK6C3vkm2QhJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781148513; c=relaxed/simple;
	bh=6te8vmnMabWj/6RUkNAjXUTv3IuZtNxwxf0v463UgpQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cM+ZYSzA1MHjmak9yihffYNacIMUPWrlkdY+kLBIaXdO9DSJT66wuQj193nRMRZj9tYbijvJDeAHV1AcFO+6+9n4wp7FdPNQ8bb2JLN8b2JAM/hm+C93gbwuiYX90+73nkfBvLLUOsZNOIG5EakpnWWBKORDNQbCBn4lg7b51qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxVehdKypqJO0SAA--.44509S3;
	Thu, 11 Jun 2026 11:28:29 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAx38JWKypqjIWiAA--.45678S3;
	Thu, 11 Jun 2026 11:28:23 +0800 (CST)
Subject: Re: [PATCH v2 2/3] LoongArch: BPF: Inline
 bpf_get_current_task{_btf}() helpers
To: bot+bpf-ci@kernel.org, chenhuacai@kernel.org, hengqi.chen@gmail.com
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
References: <20260611015327.12108-3-yangtiezhu@loongson.cn>
 <b88f6055e63f7f4084159c428dc427047d4074517c929f0ce4d6e7bb2b0d57f9@mail.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <0b4e5f5b-6e63-7f64-8968-27921271933c@loongson.cn>
Date: Thu, 11 Jun 2026 11:28:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b88f6055e63f7f4084159c428dc427047d4074517c929f0ce4d6e7bb2b0d57f9@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx38JWKypqjIWiAA--.45678S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGr1rWryruFWfuFWfGw43CFX_yoWrCw4UpF
	WUG3y2yr4DXF4I9347Jw4UZ3W5tayFq3y5G3WrGrWFka15Xrn7WF13Kas09FZ5Cr4v93Wa
	vr429F12kF1kGFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr9NsUUU
	UU=

On 2026/6/11 上午10:36, bot+bpf-ci@kernel.org wrote:
>> The pointer to task_struct is always available in the $tp register,
>> the calls to bpf_get_current_task() and bpf_get_current_task_btf()
>> can be inlined into a single move instruction.
>>
>> [ ... ]
>>
>> This is similar with commit 2bb138cb20a6 ("bpf, arm64: Inline
>> bpf_get_current_task/_btf() helpers").
>>
>> Additionally, a safety check for bpf_jit_enable is introduced in
>> bpf_jit_inlines_helper_call(). If CONFIG_BPF_JIT_ALWAYS_ON is not
>> set and JIT is disabled at runtime, the function returns false to
>> safely accommodate the fallback path to the BPF interpreter.
>>
>> Without this check, bpf_jit_inlines_helper_call() unconditionally
>> returns true. As a result, the verifier would skip fixing up the
>> call offset, leaving insn->imm as the raw helper ID rather than
>> the expected "insn->imm = fn->func - __bpf_call_base".
>>
>> When the fallback interpreter executes (__bpf_call_base + insn->imm)
>> with this raw ID, it jumps into an unaligned invalid address space,
>> triggering a fatal instruction alignment fault (ADEF) kernel panic.
>>
>> [ ... ]
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> The commit message describes a kernel panic on the interpreter fallback
> path, where bpf_jit_inlines_helper_call() returning true caused the
> verifier to skip rewriting insn->imm to (fn->func - __bpf_call_base),
> so the interpreter ran (__bpf_call_base + raw_helper_id) and jumped to
> an invalid address.
> 
> The bpf_jit_inlines_helper_call() contract, and the verifier logic that
> skips the call-offset fixup when it returns true, were introduced
> together with the unconditional return-true pattern that is now being
> guarded with the !bpf_jit_enable check.
> 
> Should this carry a Fixes: tag pointing at that commit, for example:
> 
>    Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
> 

This is a generic problem, as sashiko-bot@kernel.org said:
"Could this root cause be addressed in the BPF core instead of being
handled as an architecture-specific workaround?"

I will do the following changes:

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 448162584c9a..4f2493c549f1 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -2384,10 +2384,6 @@ bool bpf_jit_supports_subprog_tailcalls(void)

  bool bpf_jit_inlines_helper_call(s32 imm)
  {
-       /* Prevent interpreter panic when JIT is disabled at runtime */
-       if (!bpf_jit_enable)
-               return false;
-
         switch (imm) {
         case BPF_FUNC_get_current_task:
         case BPF_FUNC_get_current_task_btf:
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 6aa2a8b24030..8e08887e6534 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2598,6 +2598,30 @@ static struct bpf_prog 
*bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
         return prog;
  }

+/*
+ * Rewrite the helper call offset for inlined helpers when fallback to
+ * the interpreter happens due to JIT compilation failure or JIT disabled.
+ */
+static void bpf_fixup_fallback_inline_helpers(struct bpf_verifier_env 
*env, struct bpf_prog *fp)
+{
+       struct bpf_insn *insn = fp->insnsi;
+       const struct bpf_func_proto *fn;
+       int i;
+
+       if (!env || !env->ops->get_func_proto)
+               return;
+
+       for (i = 0; i < fp->len; i++, insn++) {
+               if (insn->code == (BPF_JMP | BPF_CALL) && insn->src_reg 
== 0) {
+                       if (bpf_jit_inlines_helper_call(insn->imm)) {
+                               fn = env->ops->get_func_proto(insn->imm, 
fp);
+                               if (fn && fn->func)
+                                       insn->imm = fn->func - 
__bpf_call_base;
+                       }
+               }
+       }
+}
+
  struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env 
*env, struct bpf_prog *fp,
                                            int *err)
  {
@@ -2629,6 +2653,15 @@ struct bpf_prog *__bpf_prog_select_runtime(struct 
bpf_verifier_env *env, struct

                 fp = bpf_prog_jit_compile(env, fp);
                 bpf_prog_jit_attempt_done(fp);
+
+               /*
+                * If JIT compilation failed or is disabled 
(!fp->jited), we are
+                * about to fall back to the interpreter path. Fix up 
the call
+                * offsets to prevent unaligned memory access panic.
+                */
+               if (!fp->jited)
+                       bpf_fixup_fallback_inline_helpers(env, fp);
+
                 if (!fp->jited && jit_needed) {
                         *err = -ENOTSUPP;
                         return fp;

Thanks,
Tiezhu

