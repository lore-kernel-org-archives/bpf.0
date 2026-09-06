Received: from mta0.migadu.com (out-92.mta0.migadu.com [91.218.175.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1303F358D32
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 20:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788725767; cv=none; b=LYJQ6uhkVRDYEM7SM1lxd5/eFFaZtGmQ9N5jXQAZ8g9Am56Eau4f8eXehQkDxr3AqP8zcQxn53QrzEpUEIPCLsPdcOyxkdVuG6s3RivNlphwD1ryM3N2CnwlKS/+RTpnfQGAiZyoMmGsx6g60uJalhLLZAhdR1rLB+WxsMTP93M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788725767; c=relaxed/simple;
	bh=bbcZUX/BO4lWe/6ZfVLEuowocDxn8mhx0FwM87kuvIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfFkGQrSobjuqjdurvdh+mPCtXR5l+GwOPr3yZQb0VuJdHfvEBb6Kf4/uM157ol/0Gyg+ZAumWghjox/bQggtivI+C4ctU5UiO0W66JUEnNClUC1q4te1Qss2rDcM2/FnriQcOIKYm6OYlRscqWjlYs+aPhhptotrs/0qIhtlyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n5P2ukew; arc=none smtp.client-ip=91.218.175.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n5P2ukew"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bbcZUX/BO4lWe/6ZfVLEuowocDxn8mhx0FwM87kuvIY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788725757; v=1; x=1789330557;
 b=n5P2ukewiQajvlGhYtYi088rwqwwNa5rolU5J4bpZdIHQKkEeYD1iJv9sYCv4VRViEYY0tlP
 cxWh2EsihYfyT1b8DLMyAE8uVKhIZVwVF1GNFs0OkKlO5vsC/x+qZFH5qtauJJ6dHBlbyurbGHv
 rQ0f7+KWMC25De6lC3eKS23c=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ff2a9d17ee2e92a1;
	Sun, 06 Sep 2026 20:15:57 +0000
X-Mizu-Trace-ID: ff2a9d17ee2e92a1
X-Migadu-Flow: FLOW_OUT
Message-ID: <f034ac4a-2829-4932-b3f8-b13cee4688a6@linux.dev>
Date: Sun, 6 Sep 2026 13:15:49 -0700
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
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051033.3979978-1-yonghong.song@linux.dev>
 <DL6XUEHAJN3Z.20UKZKTLHI2XZ@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DL6XUEHAJN3Z.20UKZKTLHI2XZ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/26 4:58 PM, Alexei Starovoitov wrote:
> On Thu Sep 3, 2026 at 10:10 PM PDT, Yonghong Song wrote:
>> The JIT hands each eightbyte the BPF calling convention passes an
>> argument in to the argument position of the same number, registers first,
>> so the two conventions agree unless the kernel one places an argument
>> somewhere else. Compute where SysV wants each eightbyte, and move the
>> ones that differ before the call.
>>
>> SysV disagrees over an argument that the registers left cannot hold: it
>> moves the whole of it to the stack and leaves the registers to the
>> arguments that follow, while the BPF convention splits it and keeps
>> filling slots in order. So for
>>
>>    u64 f(u64 a, u64 b, u64 c, u64 d, u64 e, struct pair s);
>>
>> the BPF convention puts s in the last argument register and the first
>> stack slot, while SysV puts it wholly on the stack. Add an argument after
>> s and it takes the register s vacated, which makes the moves a cycle, so
>> one value at a time waits in RAX, dead before a call.
>>
>> The outgoing argument area is sized for both conventions, as SysV can put
>> on the stack an argument the BPF slots kept in a register, and
>> bpf_jit_supports_kfunc_arg_slot() can now answer yes to any placement.
> What is SysV ? This change is about x86-64 ABI.

SysV refers to https://wiki.osdev.org/System_V_ABI#x86-64.

> How come BPF calling convention diverged from x86-64?

Let me explain the calling convention difference between BPF and x86_64.

For x86_64,
    rdi, rsi, rdx, rcx, r8, r9, <stack...>
So for
    foo(long a, __int128 b, __int128 c, __int128 d, __int128 e, long f)
the register/stack mapping:
    a:rdi, b:rsi/rdx, c:rcx/r8, d:stack, e:stack, f/r9

For bpf, the abi is simply sequential, e.g. for the above foo()
    a, b, c, d, e, f // no gap
For bpf, bar(long a, long b, __int128 c, __int128 d, __int128 e, long f, __int128 g)
    a, b, c, d, e, f, g // no gap

The upstream llvm:

SDValue BPFTargetLowering::LowerCall(TargetLowering::CallLoweringInfo &CLI,
                                      SmallVectorImpl<SDValue> &InVals) const {
...
   // Walk arg assignments
   for (size_t i = 0; i < OutVals.size(); ++i) {
     CCValAssign &VA = ArgLocs[i];
     SDValue &Arg = OutVals[i];

     // Promote the value if needed.
     switch (VA.getLocInfo()) {
     default:
       report_fatal_error("unhandled location info: " + Twine(VA.getLocInfo()));
     case CCValAssign::Full:
       break;
     case CCValAssign::SExt:
       Arg = DAG.getNode(ISD::SIGN_EXTEND, CLI.DL, VA.getLocVT(), Arg);
       break;
     case CCValAssign::ZExt:
       Arg = DAG.getNode(ISD::ZERO_EXTEND, CLI.DL, VA.getLocVT(), Arg);
       break;
     case CCValAssign::AExt:
       Arg = DAG.getNode(ISD::ANY_EXTEND, CLI.DL, VA.getLocVT(), Arg);
       break;
     }


     // Push arguments into RegsToPass vector
     if (VA.isRegLoc()) {
       RegsToPass.push_back(std::make_pair(VA.getLocReg(), Arg));
       continue;
     }

     if (VA.isMemLoc()) {
       int Off = -8 - VA.getLocMemOffset();
       if (Off < INT16_MIN) {
         fail(CLI.DL, DAG, "extra parameter stack depth exceeded limit");
         break;
       }

       // STORE_STACK_ARG requires i64 operands. With ALU32 mode, the CC
       // promotion may only extend to i32, so extend to i64 if needed.
       if (Arg.getValueType() != MVT::i64)
         Arg = DAG.getNode(ISD::ANY_EXTEND, CLI.DL, MVT::i64, Arg);

       SDValue OffVal = DAG.getConstant(Off, CLI.DL, MVT::i64);
       Chain = DAG.getNode(BPFISD::STORE_STACK_ARG, CLI.DL, MVT::Other, Chain,
                           OffVal, Arg);
       continue;
     }

     report_fatal_error("unhandled argument location");
   }

 From above, for a 16-byte struct e.g. __int128 or struct {long a; long b;};
they can have half in R5 and the other half in Stack. But this is not
allowed for x86_64.

arm64 has more constraints on top of x86_64. For any 16-byte (or > 8 byte)
argument, the argument must be 16-byte aligned (in registers or in stacks).
For the following example:
   foo(long a, __int128 b, __int128 c, __int128 d, __int128 e, long f, __int128 g)
the registers/stack:
   a: x0, b: x2/x3, c: x4/x5, d: x6/x7
   stack: e (offset 0), f (offset 16), g (offset 32).

> Maybe we should adjust bpf side instead.

We can keep llvm implementation but we can adjust bpf side in kernel.

For x86, if we have a reorder of an argument or a hole in the slots, reject.
For arm64, if there is a hole in the slots, reject.

This will simplify jit a lot.

WDYT?

> Looks like next patch is doing the same shift/move dance for arm64
> which is a sign that we got it wrong on bpf side.
> It needs to match x86/arm64.
>
> pw-bot: cr

