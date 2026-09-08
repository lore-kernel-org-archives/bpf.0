Received: from mta0.migadu.com (out-103.mta0.migadu.com [91.218.175.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA66238159
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 05:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788844229; cv=none; b=jLCgycInFsqAPqPlGREkRNJBW/Xv0koNRlxmsHjA/hXjktVkKRVFLIpgNfxNdCxpNzaKEOgyG39gDhkA7Qf/mhN8e9OHa0avgJNgZSTlsmncZz6MJDEKnZUyIyI7KkxNEH3hcECRRl1tOwTKu7vNPSf8Alqii240lzBcFkkSXFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788844229; c=relaxed/simple;
	bh=1uZgF8OleuCHE8Qna4Z/71SLCcHmeq2HN4ivG1mgMrM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=F5mBEEw1ytikdRcbq34ih1lKo26mBBwkHqJGmR0HRIgpV6VqeOzbl38kG05RvyGvFBe4BrPGSsJ28vrvpHd/ftGUJfwtP2oGh/THqz7rGv6XuC71Fk8+2Q36hC7eDJtlUl6MPaeUZRWFg5FaLMIjOXfLtQoJRAt6k5sNx743u98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fh8i3rCu; arc=none smtp.client-ip=91.218.175.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fh8i3rCu"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1uZgF8OleuCHE8Qna4Z/71SLCcHmeq2HN4ivG1mgMrM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788844224; v=1; x=1789449024;
 b=Fh8i3rCusDeuvUBeq9S9k2BWA+gpTDvMcWjnys9AX5Pp2nnXKxYdLirDb71fCx1bTUhAKsSZ
 J2DgFto9aZfGy+PD7qgnmbxav7i1ekoIZha4Y0aKBzaU2MUQ8IVZv/gupZJ3VzYmdgo1OKlreQ2
 Gip/2JF2errEjIcBZW+oAECg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d359f18d6ddb3dfa;
	Tue, 08 Sep 2026 05:10:07 +0000
X-Mizu-Trace-ID: d359f18d6ddb3dfa
X-Migadu-Flow: FLOW_OUT
Message-ID: <541c4568-122f-4005-a093-4dfdada439ab@linux.dev>
Date: Mon, 7 Sep 2026 22:10:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 07/12] bpf, x86: Place kfunc arguments per the
 SysV calling convention
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Kernel Team <kernel-team@fb.com>
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051033.3979978-1-yonghong.song@linux.dev>
 <DL6XUEHAJN3Z.20UKZKTLHI2XZ@gmail.com>
 <f034ac4a-2829-4932-b3f8-b13cee4688a6@linux.dev>
 <CAADnVQ+bKmypdfAPXdk9jDN3QedX9EO9YXHFudLu71AR02Z3CQ@mail.gmail.com>
 <7be30b65-0a22-47b6-8635-e0054c6cba24@linux.dev>
In-Reply-To: <7be30b65-0a22-47b6-8635-e0054c6cba24@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/7/26 10:02 PM, Yonghong Song wrote:
>
>
> On 9/7/26 9:33 PM, Alexei Starovoitov wrote:
>> On Sun, Sep 6, 2026 at 1:15 PM Yonghong Song 
>> <yonghong.song@linux.dev> wrote:
>>>
>>>
>>> On 9/4/26 4:58 PM, Alexei Starovoitov wrote:
>>>> On Thu Sep 3, 2026 at 10:10 PM PDT, Yonghong Song wrote:
>>>>> The JIT hands each eightbyte the BPF calling convention passes an
>>>>> argument in to the argument position of the same number, registers 
>>>>> first,
>>>>> so the two conventions agree unless the kernel one places an argument
>>>>> somewhere else. Compute where SysV wants each eightbyte, and move the
>>>>> ones that differ before the call.
>>>>>
>>>>> SysV disagrees over an argument that the registers left cannot 
>>>>> hold: it
>>>>> moves the whole of it to the stack and leaves the registers to the
>>>>> arguments that follow, while the BPF convention splits it and keeps
>>>>> filling slots in order. So for
>>>>>
>>>>>     u64 f(u64 a, u64 b, u64 c, u64 d, u64 e, struct pair s);
>>>>>
>>>>> the BPF convention puts s in the last argument register and the first
>>>>> stack slot, while SysV puts it wholly on the stack. Add an 
>>>>> argument after
>>>>> s and it takes the register s vacated, which makes the moves a 
>>>>> cycle, so
>>>>> one value at a time waits in RAX, dead before a call.
>>>>>
>>>>> The outgoing argument area is sized for both conventions, as SysV 
>>>>> can put
>>>>> on the stack an argument the BPF slots kept in a register, and
>>>>> bpf_jit_supports_kfunc_arg_slot() can now answer yes to any 
>>>>> placement.
>>>> What is SysV ? This change is about x86-64 ABI.
>>> SysV refers to https://wiki.osdev.org/System_V_ABI#x86-64.
>>>
>>>> How come BPF calling convention diverged from x86-64?
>>> Let me explain the calling convention difference between BPF and 
>>> x86_64.
>>>
>>> For x86_64,
>>>      rdi, rsi, rdx, rcx, r8, r9, <stack...>
>>> So for
>>>      foo(long a, __int128 b, __int128 c, __int128 d, __int128 e, 
>>> long f)
>>> the register/stack mapping:
>>>      a:rdi, b:rsi/rdx, c:rcx/r8, d:stack, e:stack, f/r9
>>>
>>> For bpf, the abi is simply sequential, e.g. for the above foo()
>>>      a, b, c, d, e, f // no gap
>>> For bpf, bar(long a, long b, __int128 c, __int128 d, __int128 e, 
>>> long f, __int128 g)
>>>      a, b, c, d, e, f, g // no gap
>>>
>>> The upstream llvm:
>>>
>>> SDValue 
>>> BPFTargetLowering::LowerCall(TargetLowering::CallLoweringInfo &CLI,
>>> SmallVectorImpl<SDValue> &InVals) const {
>>> ...
>>>     // Walk arg assignments
>>>     for (size_t i = 0; i < OutVals.size(); ++i) {
>>>       CCValAssign &VA = ArgLocs[i];
>>>       SDValue &Arg = OutVals[i];
>>>
>>>       // Promote the value if needed.
>>>       switch (VA.getLocInfo()) {
>>>       default:
>>>         report_fatal_error("unhandled location info: " + 
>>> Twine(VA.getLocInfo()));
>>>       case CCValAssign::Full:
>>>         break;
>>>       case CCValAssign::SExt:
>>>         Arg = DAG.getNode(ISD::SIGN_EXTEND, CLI.DL, VA.getLocVT(), 
>>> Arg);
>>>         break;
>>>       case CCValAssign::ZExt:
>>>         Arg = DAG.getNode(ISD::ZERO_EXTEND, CLI.DL, VA.getLocVT(), 
>>> Arg);
>>>         break;
>>>       case CCValAssign::AExt:
>>>         Arg = DAG.getNode(ISD::ANY_EXTEND, CLI.DL, VA.getLocVT(), Arg);
>>>         break;
>>>       }
>>>
>>>
>>>       // Push arguments into RegsToPass vector
>>>       if (VA.isRegLoc()) {
>>>         RegsToPass.push_back(std::make_pair(VA.getLocReg(), Arg));
>>>         continue;
>>>       }
>>>
>>>       if (VA.isMemLoc()) {
>>>         int Off = -8 - VA.getLocMemOffset();
>>>         if (Off < INT16_MIN) {
>>>           fail(CLI.DL, DAG, "extra parameter stack depth exceeded 
>>> limit");
>>>           break;
>>>         }
>>>
>>>         // STORE_STACK_ARG requires i64 operands. With ALU32 mode, 
>>> the CC
>>>         // promotion may only extend to i32, so extend to i64 if 
>>> needed.
>>>         if (Arg.getValueType() != MVT::i64)
>>>           Arg = DAG.getNode(ISD::ANY_EXTEND, CLI.DL, MVT::i64, Arg);
>>>
>>>         SDValue OffVal = DAG.getConstant(Off, CLI.DL, MVT::i64);
>>>         Chain = DAG.getNode(BPFISD::STORE_STACK_ARG, CLI.DL, 
>>> MVT::Other, Chain,
>>>                             OffVal, Arg);
>>>         continue;
>>>       }
>>>
>>>       report_fatal_error("unhandled argument location");
>>>     }
>>>
>>>   From above, for a 16-byte struct e.g. __int128 or struct {long a; 
>>> long b;};
>>> they can have half in R5 and the other half in Stack. But this is not
>>> allowed for x86_64.
>>>
>>> arm64 has more constraints on top of x86_64. For any 16-byte (or > 8 
>>> byte)
>>> argument, the argument must be 16-byte aligned (in registers or in 
>>> stacks).
>>> For the following example:
>>>     foo(long a, __int128 b, __int128 c, __int128 d, __int128 e, long 
>>> f, __int128 g)
>>> the registers/stack:
>>>     a: x0, b: x2/x3, c: x4/x5, d: x6/x7
>>>     stack: e (offset 0), f (offset 16), g (offset 32).
>>>
>>>> Maybe we should adjust bpf side instead.
>>> We can keep llvm implementation but we can adjust bpf side in kernel.
>>>
>>> For x86, if we have a reorder of an argument or a hole in the slots, 
>>> reject.
>>> For arm64, if there is a hole in the slots, reject.
>>>
>>> This will simplify jit a lot.
>> Why cannot we adjust bpf calling convention to match arm64/x86 the best?
>> Since arm64 is stricter, I'd pick that style.
>> There are no kfuncs that use int128 or 16+ byte args,

This patch intends to support kfuncs for int128 or <= 16 bytes argument.

>> so it's a matter of bpf subprogs calling bpf subprogs.

For bpf to bpf call, if I understand correctly, there is no calling convention issue.


>> Seems cleaner to adjust what llvm emits instead of forcing all jits 
>> to adapt.
>
> The following is what I was suggested:
>
> llvm: no change,
>
> x86_64 jit:
>
> +bool bpf_jit_supports_kfunc_arg_slot(u32 slots_used, u32 nslots, u32 
> align)
> +{
> +       if (slots_used >= 6)
> +               return IS_ALIGNED((slots_used - 6) * sizeof(u64), align);
> +
> +       return slots_used + nslots <= 6;
> +}
>
> arm64 jit:
>
> +bool bpf_jit_supports_kfunc_arg_slot(u32 slots_used, u32 nslots, u32 
> align)
> +{
> +       if (slots_used >= 8)
> +               return IS_ALIGNED((slots_used - 8) * sizeof(u64), align);
> +
> +       if (!IS_ALIGNED(slots_used * sizeof(u64), align))
> +               return false;
> +
> +       return slots_used + nslots <= 8;
> +}
>
> The above x86_64 and arm64 will reject for certain cases as in the above.
>
> The alternative solution is to change llvm's. Let us say we want to have
> arm64 calling convention. We may have
>
>    slot 0: int
>    slot 1: empty
>    slot 2: first64 in int128
>    slot 3: second64 in int128
>    slot 4: int
>    slot 5: empty
>    slot 6: first64 in int128
>    slot 7: second64 int int128
>    slot 8: int
>
> in llvm and it matches to arm64
> but it has some issues in kernel as some slot is empty. (slot 1, slot 5).
> and it needs calling convention change for x86_64.
>
> So in llvm, we should have strict arm64 calling convention without holes.
> That means the above slot 0->8 example will be rejected in llvm.
> Is this what you suggested?
>
>

