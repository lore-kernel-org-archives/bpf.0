Received: from mta0.migadu.com (out-224.mta0.migadu.com [91.218.175.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A43438BE
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 06:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791785016; cv=none; b=GkYuOH/6Dmjf3ydHaBK6jxekJI3uAN4HJZoPBU3XvizOZcr+BCSAQG70vC8Kj99EloS9tpIMvSpTsrC+kfSFgbNEfWu59Z7iCBp0X3XUVNOH7FacLGFFRg5dW+GyCzsgAFzOcez5D/DoV3GGbULAPd6of1Z8MglJutEv4Bi9vQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791785016; c=relaxed/simple;
	bh=nv1UG4Byc1Uv+g1r2jpvGeQayl7ttSu4bEwBHaoVUxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzw6CKXC48UHuYoYLj0Sdk5GaFlX+xqXJtALOsaOXeHKC5xn0GB9fCyrObmaEHJjQwQatN5QVWeh8NqQXgZJgDIN7id2DEAK0xpSvPdTDHM81WB3NPl5zb4ZX3k/oz+jNBM1pUaB1BNebz7i/u8n9ZsZ2BiunVjiKKmqrxTsoqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ECZStmjs; arc=none smtp.client-ip=91.218.175.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ECZStmjs"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nv1UG4Byc1Uv+g1r2jpvGeQayl7ttSu4bEwBHaoVUxE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791785011; v=1; x=1792389811;
 b=ECZStmjsQiUNeco40xeDxnsr4hsQMyeioU3PMJ9mD4ZH1zBWO8Jos4/vlOrNHpcyPqZRydQm
 06OHk5Ux9L839yL6Kqs0h37wXuZSdbrwDef6HwfaYYYpybHk4cLzlHYNxGZrzNvDZot/vlJB7rK
 DhP3B6FVwdYD9W8NXimk/gj4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5e59796d94ceef6c;
	Mon, 12 Oct 2026 06:03:31 +0000
X-Mizu-Trace-ID: 5e59796d94ceef6c
X-Migadu-Flow: FLOW_OUT
Message-ID: <27e0b53a-49fb-4cfc-bc0c-1f1742cb8ba8@linux.dev>
Date: Sun, 11 Oct 2026 23:03:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/5] bpf: Keep the BPF calling convention for a
 trampoline on a BPF function
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20261009064206.1238047-1-yonghong.song@linux.dev>
 <20261009064216.1239645-1-yonghong.song@linux.dev>
 <DM18Y176CAXH.ODHX8RNC3W06@gmail.com>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DM18Y176CAXH.ODHX8RNC3W06@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/10/26 5:00 PM, Alexei Starovoitov wrote:
> On Thu, Oct 08, 2026 at 11:42 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Mark the model of a target program's function as bpf_tgt_prog, and have
>> bpf_jit_place_args() leave every slot of such a model where the BPF
>> convention put it. That is where both JITs pass it in a call from one
>> BPF function to another: slot N where the kernel convention passes its
>> Nth eightbyte, in a register or a stack slot. The x86-64 trampoline does
>> not use bpf_jit_place_args() yet; the next patch makes it, and this
>> keeps it right for a BPF target.
> can we drop the flag and for tgt_prog rewrite the model in
> bpf_check_attach_target() as one u64 arg per argument slot ?
> Every convention places N u64 args in slot order,
> so no arch has to know about BPF targets.

Good point. Will do this with u64 arg per argument slot.

>
> The flag fixes bpf_jit_place_args() only.
> calc_arg_aux() on arm64 picks reg vs stack per argument by looking
> at its first slot. In callee_stack() from patch 5 'h' is in slots 7 and 8.
> pos_of_slot[7] is x7, so the whole 'h' is counted in args_in_regs and
> save_args() emits 'str x8' for the second half. x8 is BPF R0.
> ctx[8] is garbage. For fexit it does 'ldr x8' and the first outgoing
> stack slot is never written, so callee_stack() runs with garbage
> in the upper half of 'h'. The test should fail on arm64.

Indeed, this is an issue. I should test with llvm23 for arm64 as well.

> CI uses clang 21 without stack args and won't catch it.
>
> s390 trampoline doesn't use bpf_jit_place_args().
> s390 ABI passes 16 byte arg by reference, so it does:
>    mvc bpf_arg_off(16,%r15),0(%arg)
> For callee_odd() that is a load from address 8.
> It also saves and restores nr_args == 3 registers,
> while callee_odd() takes 4.
>
> With the flat model arm64, s390 and the r9/stack split on x86
> are fixed without touching arch code.
>
>> @@ -21620,6 +21620,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>   		ret = btf_distill_func_proto(log, btf, t, tname, &tgt_info->fmodel);
>>   		if (ret < 0)
>>   			return ret;
>> +		tgt_info->fmodel.bpf_tgt_prog = !!tgt_prog;
> There is one more issue with BPF targets. Few lines above:
> 	if (tgt_prog && conservative)
> 		t = NULL;
> and the model is 5 u64.
> A static function with 6+ args where one of them is a plain pointer
> is 'unreliable', since btf_prepare_func_args() returns -EINVAL,
> but it still takes stack args.
> The trampoline saves and restores 5 registers. After fentry prog
> r9 on x86 and x5-x7 on arm64 have whatever __bpf_prog_exit() left there.
> With fexit the stack slots are not copied either.
> The function continues with garbage in the args that the verifier
> checked as pointers, I think.
> Reject such attach ?

I agree that rejection is the right way to go.

>
> Pls tell your agent to test on arm64 too.

Yes, will do.

>
> pw-bot: cr

