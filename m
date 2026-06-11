Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395AE40D56B
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781147108; cv=none; b=LGk+X/PLbRDd3sUqwjW8+nXak0dMIraDiYWE22irkKtDx1yA+OjbLxd6/pg4dV3IDauKdqzLriEMKaNleDTn3TK1xQ9qCQxGlOjBcNhy/HbvPVzinEJKhKMHFBgT/D7p6BfseyWM7E3uMi2I6MxEy85F8T3gmK3wfm3lNCppogw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781147108; c=relaxed/simple;
	bh=dpIOQqxdPS/vmNkvAmlx/sBmIHWDlHQH8nSWgaECwao=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SX76WPiqviRsfx025A5LkFQ1Pu1rmsSFdivn3hpJmMP/UVpBBGyzgEtewTBiWUsNTjp8QQb2VQgaakDM6Jm9TrRZSQt7JtO/peQpt4V/woHWMWNHjgsabQwxL+2VUVG1B/u9OUnCONNCU0ZjxcknbWGAxA6xG3GjDLGMPjtyJlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cxf+vdJSpqf+sSAA--.49801S3;
	Thu, 11 Jun 2026 11:05:02 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxC8LbJSpqJYKiAA--.45384S3;
	Thu, 11 Jun 2026 11:05:00 +0800 (CST)
Subject: Re: [PATCH v2 2/3] LoongArch: BPF: Inline
 bpf_get_current_task{_btf}() helpers
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev
References: <20260611015327.12108-3-yangtiezhu@loongson.cn>
 <20260611020748.1F0A11F00893@smtp.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f78c3761-1c43-18fa-4158-bbd686c2cd76@loongson.cn>
Date: Thu, 11 Jun 2026 11:04:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260611020748.1F0A11F00893@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxC8LbJSpqJYKiAA--.45384S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ar15KF4xJFyDKF18Kr4fXrc_yoW7Xry5pr
	Z8G3sFkr4vga92ga9rJ3WUZw15t3y8KF1UGF1rGrWFka1qqrn7WF13K3sYgFZ5GrsYv3Wa
	vrs2kr9FkF1kJFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
	CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
	wI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjxU2ID7UUUUU

On 2026/6/11 上午10:07, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The `!bpf_jit_enable` check is an incomplete, architecture-specific workaround for a core BPF verifier bug. It fails to handle JIT compilation failures and leaves ARM64, PowerPC, and RISC-V completely vulnerable to the exact same interpreter kernel panic.
> --
> 
> commit a76f924522a402d8fb15714c189dca631202c35b
> Author: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> LoongArch: BPF: Inline bpf_get_current_task{_btf}() helpers
> 
> This commit inlines bpf_get_current_task() and bpf_get_current_task_btf()
> helpers into a single move instruction for LoongArch. It also adds a check
> for bpf_jit_enable in bpf_jit_inlines_helper_call() to safely fallback to
> the BPF interpreter when JIT is disabled.
> 
>> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
>> index 24913dc7f4e83..cb379b236d7dd 100644
>> --- a/arch/loongarch/net/bpf_jit.c
>> +++ b/arch/loongarch/net/bpf_jit.c
> 
> [ ... ]
> 
>> @@ -2367,3 +2374,18 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>>   {
>>   	return true;
>>   }
>> +
>> +bool bpf_jit_inlines_helper_call(s32 imm)
>> +{
>> +	/* Prevent interpreter panic when JIT is disabled at runtime */
>> +	if (!bpf_jit_enable)
>> +		return false;
> 
> [Severity: High]
> This is a pre-existing issue, but does this !bpf_jit_enable check fully
> prevent the interpreter panic?
> 
> In the BPF verifier, do_misc_fixups() calls bpf_jit_inlines_helper_call(). If
> the architecture promises to inline the helper, it skips rewriting insn->imm
> from its raw enum ID to the required interpreter offset:
> 
> kernel/bpf/fixups.c:do_misc_fixups() {
>      ...
>      /* Skip inlining the helper call if the JIT does it. */
>      if (bpf_jit_inlines_helper_call(insn->imm))
>          goto next_insn;
>      ...
> }
> 
> If bpf_jit_enable is 1 but JIT compilation later dynamically fails (e.g., via
> bpf_jit_alloc_exec() returning NULL), bpf_prog_select_runtime() falls back to
> the interpreter:
> 
> kernel/bpf/core.c:bpf_prog_select_runtime() {
>      ...
>      fp = bpf_prog_jit_compile(env, fp);
>      bpf_prog_jit_attempt_done(fp);
>      if (!fp->jited && jit_needed) {
>          *err = -ENOTSUPP;
>      ...
> }
> 
> The interpreter then blindly executes (__bpf_call_base + insn->imm) using the
> unpatched enum ID, which triggers the same fatal Instruction Alignment Fault
> (ADEF) kernel panic.
> 
> Furthermore, ARM64, PowerPC, and RISC-V unconditionally return true from their
> implementations of bpf_jit_inlines_helper_call(). Are they left completely
> vulnerable to the exact same interpreter kernel panic when JIT is disabled or
> fails?
> 
> Could this root cause be addressed in the BPF core instead of being handled as
> an architecture-specific workaround?

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

