Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADDA3AF676;
	Wed,  1 Jul 2026 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888562; cv=none; b=Q/H07l1XFIsYGc5ieP/pMggOobn9vxe8M8YrBjMnpgxcz3NN0aX5OhloKyygGNFmmiYCpkktG8DmNEPrLPVDe6UQUhcWNrXe91f/JGM/03oJOGAogTy9Aiu3QDOd6pARzihUt/f6d9Uno4bV+JdcNiokC4AT0pHtA9mQ64hnn1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888562; c=relaxed/simple;
	bh=1h5+A7fGGRbsOGbZcEKDqm4L+EdU05qwaM8k80pNZjU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uqdwG3V5snL/A3+iRvH0euAJmTj5gMpmjYh2o9UYXxtVtBz55pxKlq3Dxo5yjJ8w/dY1RMQe6NoVK7Oh9gSBKo6O1/gHJEEDgGNQnwcHigMCDBeHWXt+NDokyOoxXmQ7SajjN5y+q4mCKgrl657racm1IlvpbEP7xW09mLKcKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxOvFsuERqe18AAA--.2306S3;
	Wed, 01 Jul 2026 14:49:16 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxfcJnuERqjhm6AA--.23063S3;
	Wed, 01 Jul 2026 14:49:12 +0800 (CST)
Subject: Re: [RFC PATCH bpf 1/6] bpf: Disallow interpreter fallback for user
 BPF_ADDR_SPACE_CAST insn
To: Leon Hwang <leon.hwang@linux.dev>, KaFai Wan <kafai.wan@linux.dev>,
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
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
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <1c07a34f-b050-a281-6a7b-542a9bfa30b3@loongson.cn>
Date: Wed, 1 Jul 2026 14:49:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d55e10b1-d883-4fcf-8fb3-8210db935e4a@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxfcJnuERqjhm6AA--.23063S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFWfGrWrWFy5ArWkJw15Jrc_yoW8ZF1kpF
	ZIy3sFyr4DKw40q3srJw42y3W5Kw1jgas7GFZ5G34F9FZ0qrn3WF109FsayFZ8WryUKr1I
	vw4Sqryq9Fy7ArXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
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
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07joc_-UUU
	UU=

On 2026/7/1 下午2:21, Leon Hwang wrote:
> On 1/7/26 09:26, Tiezhu Yang wrote:
> [...]
>>
>> Hi all,
>>
>> Alexei said in another thread like this:
>>
>> ```
>>> [3] https://lore.kernel.org/bpf/20260615025316.24429-1-
>> yangtiezhu@loongson.cn/
>>
>> I don't think we need such fallback in patch [3].
>> ```
>> https://lore.kernel.org/bpf/DJMRIZ5PDWP4.12OOZ8H881H6O@gmail.com/
>>
>> Should I just drop my previous patch? To be honest, I'm not sure how to
>> solve the issue mentioned in it. Is that a real problem, and does it
>> need to be fixed? What is the next step?
>>
> 
> It is a real issue.
> 
> Instead of fixing up helper calls, it seems better to prevent
> interpreter fallback if the prog has any JIT-inlineable helper call.

Hi Alexei and Leon,

What about the following: (not tested yet, if it is good, I can test it)

----->8-----
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 649cce41e13f..806e1ec85ff4 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2608,6 +2608,19 @@ static struct bpf_prog 
*bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
         return prog;
  }

+static bool bpf_prog_has_inline_helpers(const struct bpf_prog *fp)
+{
+       struct bpf_insn *insn = fp->insnsi;
+       int i;
+
+       for (i = 0; i < fp->len; i++, insn++) {
+               if (bpf_helper_call(insn) && 
bpf_jit_inlines_helper_call(insn->imm))
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
@@ -2620,7 +2633,8 @@ struct bpf_prog *__bpf_prog_select_runtime(struct 
bpf_verifier_env *env, struct
                 goto finalize;

         if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
-           bpf_prog_has_kfunc_call(fp))
+           bpf_prog_has_kfunc_call(fp) ||
+           bpf_prog_has_inline_helpers(fp))
                 jit_needed = true;

         if (!bpf_prog_select_interpreter(fp))
----->8-----

If you are OK with the above changes, I will test it again and send
a new version later.

Thanks,
Tiezhu

