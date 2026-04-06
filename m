Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6434E762
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 04:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775448857; cv=none; b=HEhL12LGCPWMKLf2Y5tiOxPylzq5SPkyBPJPrxDsw4FNobiG67a/fWo8fM1t/EwWSuz6JYsRNWsW2GDDUMvqhFsGr9DE5ntAut4RfZ25VxomYtRt5x15rOzK1FbuHEh2l3d566KlZUDLVSEtokQbwBmKo6M9pqPFCIgReL4W570=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775448857; c=relaxed/simple;
	bh=nvTfKlr4cGVzuCcVVBOPT2Xh3w3RT2vuBec9qUnt2bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Io5wM2fyd+6vkKp6FzN/zzSjSIqJUKNrfhuN98po0ayEqds60wwhdwWfWaAQdAuDm0dMVYzX6P2CqA502EQ4fkOgTo+JTKGed+Fba/4D8GyJCh1tgFl7k2kQbO3rCpZFbCT/FEMV0bS3PYiaPVfuVp7CvtC4DnsW8023I7Zb0Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iIMmINX/; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iIMmINX/"
Message-ID: <0903790e-a63c-4b62-b751-ce08ffcf8f57@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775448853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJUvX/m7Rx1ilqhgp64GT0erOcEl5yMFjfWl2fr7L68=;
	b=iIMmINX/HZvrM6l3NXUrslXuVTHyYgotFDB27Eo+Ai6pmf27sp0/C/NZp8akfx+nbNYDDS
	UlUEdXHwdmffRKW/3L05Im52OctFNTx6XPkmxVpfDvQzhn3bDHuAeVrpTLHE7g9IiBvOtu
	jH7segNlB51XZV6DBLWabPZCNO8XB84=
Date: Sun, 5 Apr 2026 21:14:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 08/11] bpf,x86: Implement JIT support for
 stack arguments
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20260405172505.1329392-1-yonghong.song@linux.dev>
 <20260405172626.1337674-1-yonghong.song@linux.dev>
 <CAADnVQLyoAS39gZvOzOT0qEAj4bzcZLVuupTAhyQSv6d5aQGWA@mail.gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLyoAS39gZvOzOT0qEAj4bzcZLVuupTAhyQSv6d5aQGWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/5/26 1:36 PM, Alexei Starovoitov wrote:
> On Sun, Apr 5, 2026 at 10:26 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Add x86_64 JIT support for BPF functions and kfuncs with more than
>> 5 arguments. The extra arguments are passed through a stack area
>> addressed by register r12 (BPF_REG_STACK_ARG_BASE) in BPF bytecode,
>> which the JIT translates to RBP-relative accesses in native code.
>>
>> The JIT follows the native x86_64 calling convention for stack
>> argument placement. Incoming stack args from the caller sit above
>> the callee's frame pointer at [rbp + 16], [rbp + 24], etc., exactly
>> where x86_64 expects them after CALL + PUSH RBP. Only the outgoing
>> stack arg area is allocated below the program stack in the prologue.
>>
>> The native x86_64 stack layout for a function with incoming and
>> outgoing stack args:
>>
>>    high address
>>    ┌─────────────────────────┐
>>    │ incoming stack arg N    │  [rbp + 16 + (N-1)*8]  (from caller)
>>    │ ...                     │
>>    │ incoming stack arg 1    │  [rbp + 16]
>>    ├─────────────────────────┤
>>    │ return address          │  [rbp + 8]
>>    │ saved rbp               │  [rbp]
>>    ├─────────────────────────┤
>>    │ BPF program stack       │  (stack_depth bytes)
>>    ├─────────────────────────┤
>>    │ outgoing stack arg 1    │  [rbp - prog_stack_depth - outgoing_depth]
>>    │ ...                     │   (written via r12-relative STX/ST)
>>    │ outgoing stack arg M    │  [rbp - prog_stack_depth - 8]
>>    ├─────────────────────────┤
>>    │ callee-saved regs ...   │  (pushed after sub rsp)
>>    └─────────────────────────┘  rsp
>>    low address
>>
>> BPF r12-relative offsets are translated to native RBP-relative
>> offsets with two formulas:
>>    - Incoming args (load: -off <= incoming_depth):
>>        native_off = 8 - bpf_off  →  [rbp + 16 + ...]
>>    - Outgoing args (store: -off > incoming_depth):
>>        native_off = -(bpf_prog_stack + stack_arg_depth + 8) - bpf_off
>>
>> Since callee-saved registers are pushed below the outgoing area,
>> outgoing args are not at [rsp] at call time. Therefore, for both BPF-to-BPF
>> calls and kfunc calls, outgoing args are explicitly pushed from the
>> outgoing area onto the stack before CALL and rsp is restored after return.
>>
>> For kfunc calls specifically, arg 6 is loaded into R9 and args 7+
>> are pushed onto the native stack, per the x86_64 calling convention.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   arch/x86/net/bpf_jit_comp.c | 135 ++++++++++++++++++++++++++++++++++--
>>   1 file changed, 129 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 32864dbc2c4e..206f342a0ca0 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -390,6 +390,28 @@ static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
>>          *pprog = prog;
>>   }
>>
>> +/* Push stack args from [rbp + outgoing_base + (k - 1) * 8] in reverse order. */
>> +static int push_stack_args(u8 **pprog, s32 outgoing_base, int from, int to)
>> +{
>> +       u8 *prog = *pprog;
>> +       int k, bytes = 0;
>> +       s32 off;
>> +
>> +       for (k = from; k >= to; k--) {
>> +               off = outgoing_base + (k - 1) * 8;
>> +               /* push qword [rbp + off] */
>> +               if (is_imm8(off)) {
>> +                       EMIT3(0xFF, 0x75, off);
>> +                       bytes += 3;
>> +               } else {
>> +                       EMIT2_off32(0xFF, 0xB5, off);
>> +                       bytes += 6;
>> +               }
>> +       }
> This is not any better than v1.
> It is still a copy.
> As I said earlier:
> https://lore.kernel.org/bpf/CAADnVQ+5Aqxpk1bTw47xZQ5E0HOtf0-HHjmDFHaay7CDJ-7aKQ@mail.gmail.com/
> It has to be zero overhead. Copy pasting:
>
> "
> bpf calling convention for 6+ args needs to match x86.
> With an exception of 6th arg.
> All bpf insn need to remain as-is when calling another bpf prog
> or kfunc. There should be no additional moves.
> JIT should only special case 6th arg and convert bpf's STX [r12-N], src_reg
> into 'mov r9, src_reg', since r9 is used to pass 6th argument on x86.
> The rest of STX needs to be jitted pretty much as-is
> with a twist that bpf's r12 becomes %rbp on x86.
> And similar things in the callee.
> Instead of LDX [r12+N] it will be a 'mov dst_reg, r9' where r9 is x86's r9.
> Other LDX from [r12+M] will remain as-is, but r12->%rbp.
> On arm64 more of the STX/LDX insns become native 'mov'-s
> because arm64 has more registers for arguments.
> "
>
> Remapping in earlier patches is unnecessary.
> These STX [r12-N], src_reg emitted by LLVM will be JITed as-is into
> store of src_reg into %rbp-M slot.
> Only shift by 8 bytes is necessary for N to become M.
> where STX of 6th argument becomes 'mov' from one register to x86's r9.

Okay, I will do the following jit stack layout:

   incoming stack arg N -> 1
   return adderss
   saved rbp
   BPF program stack
   tail call cnt <== if tail call reachable
   callee-saved regs
   r9 <== if priv_frame_ptr is not null
   outgoing stack arg M -> 1
   call ...
   undo stack of outgoing stack arg + r9

In this case, insn *(u64 *)(r12 - off) = val can directly write 'val'
into proper outgoing stack arg locations.

if the call is a kfunc, outgoing stack should remove the bottom one
for the 6th argument before the call.

>
> The feature has to be zero overhead to pass these args from bpf to native
> and from struct_ops hooks into bpf progs.
> All verifier considerations are secondary.
>
> pw-bot: cr

