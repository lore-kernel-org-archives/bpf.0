Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9C341DEC9;
	Fri, 14 Aug 2026 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693815; cv=none; b=DD8NMKguh3GscTZHYqisySHwpYssTWMpzZeLexH4JIruuoTwHLBOWzdwY5wi1rqnnUhi8MhAEsNqIE6o3nyasP3Dyw/65icr5+hBLwf/rFaC1HglcaIhKW7fl1AA1P9IzF/K/QTECkuARNmF1BVDiw9rZNiDy9rIHLfSWXH/r/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693815; c=relaxed/simple;
	bh=+oMDrQPVFvGJr54fHJCZHuo8DGAxZIniII9GZ+RIeWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E22+J4qjjmTtCBvOGQ4Og+c3tRbp3cdQ7GFpC8HI8rb2e5qsFHI4K8Z1sTO7BqjjOgWTJfF4YR2Q3fhkNaivph49aYydh7e41QuBLGrkI0RjKEbrD+yRYo25yljx84yBxgum2Ce7EfIFhoG3q9gAKJHy4i9iJUsEhw4k4ox918s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c0ce679297b411f1aa26b74ffac11d73-20260814
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e1cb0c58-a236-4659-8646-9df8cee9de01,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:8c533ba8a267d53a3861e43604bf2119,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|136|865|898,TC:nil,Conte
	nt:0|15|50,EDM:-3|-100,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c0ce679297b411f1aa26b74ffac11d73-20260814
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 598644516; Fri, 14 Aug 2026 15:50:00 +0800
Message-ID: <ff8e2f00-0d44-408a-8724-36bfa78911d4@kylinos.cn>
Date: Fri, 14 Aug 2026 15:49:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf, riscv: Add BPF stack arguments
 support for RV64 JIT
To: Pu Lehui <pulehui@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Luke Nelson
 <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260814-bpf-riscv-stack-args-v3-0-2160de56fea3@kylinos.cn>
 <20260814-bpf-riscv-stack-args-v3-1-2160de56fea3@kylinos.cn>
 <25b9821d-113c-405f-93e9-585fb745a2d6@huawei.com>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <25b9821d-113c-405f-93e9-585fb745a2d6@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/8/14 14:49, Pu Lehui wrote:
> 
> On 2026/8/14 9:29, Feng Jiang wrote:
>> Add bpf_jit_supports_stack_args() for the RV64 JIT so BPF subprograms
>> and kfuncs can receive more than 5 arguments via the stack
>> (BPF_REG_PARAMS / r11).
>>
>> For BPF-to-BPF calls the caller writes outgoing arguments at the
>> bottom of its frame (SP-relative). The callee reads them with
>> FP-relative loads. Its FP is set to the caller SP in the prologue,
>> so the offsets match.
>>
>> The RISC-V ABI puts arguments 6-8 in A5-A7 and arguments 9+ at
>> SP+0. Before each kfunc call, load arguments 6-8 from the outgoing
>> area into A5-A7 and copy any remaining arguments down so argument 9
>> lands at SP+0.
>>
>> A5 (BPF_REG_0), A6 (TCC) and A7 are safe to clobber here: R0 is not
>> live before a call, TCC is backed up on the stack, and A7 is unused
>> by the JIT.
>>
>> Limit the existing kfunc sign-extension loop to MAX_BPF_FUNC_REG_ARGS
>> iterations; otherwise idx >= 5 resolves to S1-S5 (BPF_R6-FP) and
>> corrupts callee-saved registers.
>>
>> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
>> ---
>>   arch/riscv/net/bpf_jit.h        |  1 +
>>   arch/riscv/net/bpf_jit_comp64.c | 79 +++++++++++++++++++++++++++++++++++++++--
>>   arch/riscv/net/bpf_jit_core.c   |  4 +++
>>   3 files changed, 81 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>> index 419b9d795f2a..9eb4e149505d 100644
>> --- a/arch/riscv/net/bpf_jit.h
>> +++ b/arch/riscv/net/bpf_jit.h
>> @@ -82,6 +82,7 @@ struct rv_jit_context {
>>       unsigned long flags;
>>       int stack_size;
>>       int tcc_offset;
>> +    u16 stack_arg_size;
>>       u64 arena_vm_start;
>>       u64 user_vm_start;
>>   };
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index 6b9972b07c1b..58cb3e5ff6b4 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -1815,18 +1815,43 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>             if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
>>               const struct btf_func_model *fm;
>> -            int idx;
>> +            int idx, nargs;
>>                 fm = bpf_jit_find_kfunc_model(ctx->prog, insn);
>>               if (!fm)
>>                   return -EINVAL;
>>   -            for (idx = 0; idx < fm->nr_args; idx++) {
>> +            nargs = min_t(int, fm->nr_args, MAX_BPF_FUNC_REG_ARGS);
>> +            for (idx = 0; idx < nargs; idx++) {
>>                   u8 reg = bpf_to_rv_reg(BPF_REG_1 + idx, ctx);
>>                     if (fm->arg_size[idx] == sizeof(int))
>>                       emit_sextw(reg, reg, ctx);
>>               }
>> +
>> +            /* BPF stack args -> RISC-V ABI: args 6-8 in A5-A7, 9+ at SP+0 */
>> +            if (fm->nr_args > MAX_BPF_FUNC_REG_ARGS) {
>> +                int n_stack = fm->nr_args - MAX_BPF_FUNC_REG_ARGS;
>> +                int n_reg = min_t(int, n_stack,
>> +                          RV_MAX_REG_ARGS - MAX_BPF_FUNC_REG_ARGS);
>> +
>> +                for (idx = 0; idx < n_reg; idx++) {
>> +                    int sz = fm->arg_size[MAX_BPF_FUNC_REG_ARGS + idx];
>> +
>> +                    emit_ld(RV_REG_A5 + idx, idx * 8, RV_REG_SP, ctx);
>> +                    if (sz == sizeof(int))
>> +                        emit_sextw(RV_REG_A5 + idx, RV_REG_A5 + idx, ctx);
> 
> Hi Feng Jiang,
> 
> Thanks for doing this. I'll squeeze the time to review this patchset, but there is currently an issue with RV64 kfunc [0]. Let's hold off for a moment.:)
> 
> [0] https://lore.kernel.org/bpf/20260814064726.3607615-1-pulehui@huaweicloud.com
> 

Thanks for the heads-up. I'll wait for it to land and rebase on top.

-- 
With Best Regards,
Feng Jiang

