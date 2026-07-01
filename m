Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA2C3C1F36;
	Wed,  1 Jul 2026 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896856; cv=none; b=SOyukBPTd/ePZfEjkmTWSjh7cKcLl/x/HgVLtbe/VLbg/E72EYSHIpF+yyrD1I7GlRIHxjJ4aaHzMVlkiK8eFeaMTiKdjZK1liS9Hcd2C2HZ5JzfgtKbzb8z/hJHTICdAg3rxuP/NxkZoC/BDJ0vKFBzEH3SfuSfSsxIN1cwMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896856; c=relaxed/simple;
	bh=Tnv+D9HsSsnYr11/Z0+Uok1+c1b0VRtvufR+McFYnNY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WaFZidZfhF/oDGtbsQQicRrit/F6L3jpu6a0JTbgJJD4TIjmXym6IRYuu93PFXPSwa2WZRKUPDmZ+t3t85C1LMXShA+c8ksuWiOPlV2jDUipAg389SyEuk9oeYMstxXYej1e0tQnibRWNAOVUpmBRlXE60yWh+lS+sRLdCMKivI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx7+vR2ERq52gAAA--.1617S3;
	Wed, 01 Jul 2026 17:07:29 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBx68HL2ERq7Di6AA--.23033S3;
	Wed, 01 Jul 2026 17:07:25 +0800 (CST)
Subject: Re: [RFC PATCH bpf 1/6] bpf: Disallow interpreter fallback for user
 BPF_ADDR_SPACE_CAST insn
To: Leon Huang Fu <leon.huangfu@shopee.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, KaFai Wan <kafai.wan@linux.dev>,
 bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Anton Protopopov <a.s.protopopov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260626154330.33619-1-leon.hwang@linux.dev>
 <20260626154330.33619-2-leon.hwang@linux.dev>
 <e279c9a7ca6b16e52dc261560513b0eafdd70f87.camel@linux.dev>
 <a2aaa21d-4cf9-48a4-839f-dd152bda8185@linux.dev>
 <af9c0a7e-13de-c227-849f-4b35d1fb74ff@loongson.cn>
 <d55e10b1-d883-4fcf-8fb3-8210db935e4a@linux.dev>
 <1c07a34f-b050-a281-6a7b-542a9bfa30b3@loongson.cn>
 <bfb432db-bd29-419a-8147-78ff6fac07ad@linux.dev>
 <7438f087-7fb4-4991-a095-1d24d6d09895@loongson.cn>
 <20260701080524.194326-1-leon.huangfu@shopee.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d369317a-e695-7b56-2efd-f53ec76c6688@loongson.cn>
Date: Wed, 1 Jul 2026 17:07:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260701080524.194326-1-leon.huangfu@shopee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx68HL2ERq7Di6AA--.23033S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr1kZF45Cr1Duw1fZrWDtrc_yoWrGFy3pF
	WUJa4jyr4DWF4kZ3srtr4jyr13t3yFgr4xWa18GrWS9rs0qrn3WF409a1a9FWagrWjyF1I
	vr4jvrs2vFy7urXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcQzVUU
	UUU

On 2026/7/1 下午4:04, Leon Huang Fu wrote:
> On Wed, 1 Jul 2026 15:29:28 +0800, Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>> On 2026/7/1 ä¸‹åˆ3:02, Leon Hwang wrote:
>>> On 1/7/26 14:49, Tiezhu Yang wrote:
>>> [...]
>>>>>
>>>>> It is a real issue.
>>>>>
>>>>> Instead of fixing up helper calls, it seems better to prevent
>>>>> interpreter fallback if the prog has any JIT-inlineable helper call.
>>>>
>>>> Hi Alexei and Leon,
>>>>
>>>> What about the following: (not tested yet, if it is good, I can test it)
>>>>
>>>> [...]
>>>>
>>>> If you are OK with the above changes, I will test it again and send
>>>> a new version later.
>>>>
>>>
>>> If you don't mind, I think I can disallow the interpreter fallback by
>>> the below diff in the next revision of this series.
>>>
>>> The 'aux->jit_required' is introduced by following Alexei's suggestion.
>>
>> I am not sure if introducing a new aux->jit_required member is necessary,
>> as we already have a local jit_needed flag in the current logic.
> 
> A 'must_jit'-like member was suggested by Alexei [1].
> 
> Probably, the commits in [2] could help to understand 'aux->jit_required'.
> 
> [1] https://lore.kernel.org/bpf/DJMRIZ5PDWP4.12OOZ8H881H6O@gmail.com/
> [2] https://github.com/Asphaltt/bpf/commits/bpf/fix-interpreter-fallback/v2/
> 
>>
>> Additionally, the issue reported in my patch [1] is fundamentally tied
>> to bpf_jit_inlines_helper_call(). Maybe we can simply reuse jit_needed
>> by checking bpf_prog_has_inline_helpers() right before JITing, and then
>> reject fallback with -ENOTSUPP if JIT compilation fails.
> 
> Correct. Reusing jit_needed is preferred.

I agree.

To avoid bloating struct bpf_prog_aux and to keep the refactoring
minimal, I suggest that you submit a patch to introduce a centralized
bpf_prog_requires_jit() helper in kernel/bpf/core.c.

This will cleanly bundle bpf_prog_has_kfunc_call() and other JIT-only
instructions (like user cast, arena, etc.) together, like this:

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 649cce41e13f..4e96272f7377 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2608,6 +2608,24 @@ static struct bpf_prog 
*bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
         return prog;
  }

+static bool bpf_prog_requires_jit(const struct bpf_prog *fp)
+{
+       struct bpf_insn *insn = fp->insnsi;
+       int i;
+
+       if (bpf_prog_has_kfunc_call(fp))
+               return true;
+
+       for (i = 0; i < fp->len; i++, insn++) {
+               if (insn_is_cast_user(insn) ||
+                   insn_is_arena_load_store(insn) ||
+                   insn_is_indirect_jump(insn))
+                       return true;
+       }
+
+       return false;
+}
+
  struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env 
*env, struct bpf_prog *fp,
                                            int *err)
  {
@@ -2620,7 +2638,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct 
bpf_verifier_env *env, struct
                 goto finalize;

         if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
-           bpf_prog_has_kfunc_call(fp))
+           bpf_prog_requires_jit(fp))
                 jit_needed = true;

         if (!bpf_prog_select_interpreter(fp))


Once that infrastructure is in place, I can simply spin my next revision
by adding the bpf_jit_inlines_helper_call() check into this centralized
function, like so:

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 4e96272f7377..2ef82029de49 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2617,6 +2617,9 @@ static bool bpf_prog_requires_jit(const struct 
bpf_prog *fp)
                 return true;

         for (i = 0; i < fp->len; i++, insn++) {
+               if (bpf_helper_call(insn) && 
bpf_jit_inlines_helper_call(insn->imm))
+                       return true;
+
                 if (insn_is_cast_user(insn) ||
                     insn_is_arena_load_store(insn) ||
                     insn_is_indirect_jump(insn))

This keeps the core runtime selection logic completely clean.

Thanks,
Tiezhu

