Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737AE449980
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626050; cv=none; b=jM3NDh3qfkl0MhW8bFfu6AKQWiLRo+kMqthVTMZHgAiNPbi6wgx7E+GBpZTKEUBMndHFGfJUYYpcAGViC+poccDhqOU3+8pK9f6Cg0+pnc4wxRZhmG8pWheYnzM/m9pPlM/zH2uqXQpLPIzGphibq5ntHoOUd88iOFzuOQxuxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626050; c=relaxed/simple;
	bh=0YDvwgLQEnkkpcG5jtU7pRdyrltyLiFcCJWfTSdh4Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMTMC5lWOSZA/OlPQpTuza6LlR2a5nrlqFuOAFPknQ++Bj5F57hqOaf3j+4qDgLhT35nYL8nn4e+X66xfRfuLr/bqnnnkKLiPF8I82/6jw0lLJ7QQP/MEHdRNJnTEfk8rb+BVIH1ibZ/48IfMGhBr6HuC6Ckef5x0ycLItXQSqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pqh66trC; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pqh66trC"
Message-ID: <b344f190-ac57-4185-b5e6-e9c9db6c6249@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783626036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mS5cj0se9QcQQ34zS5YlgQmQWLzaB0xTLMO+WjoKy94=;
	b=Pqh66trCfq17jreg/W3iOLx6H8A12GucCAMF3MdBqH8lbvsEao5xuJ7thDkx/GwAQ1Y9lL
	p002UYsxFSbT628Oe22y06yIPVSBNjimQyOzRymd479hjb5dT5jw2oWML25+yo1aE22TOP
	Wl6Yce/s00VHz3KNDiSNQBUnVGplIzY=
Date: Thu, 9 Jul 2026 12:40:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 08/12] bpf: Enable 16-byte aggregate return types
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <20260708201020.2160131-1-yonghong.song@linux.dev>
 <20260708202836.0308F1F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260708202836.0308F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/8/26 1:28 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Leaking uninitialized kernel memory via kfunc R2 return register for structs of 9-15 bytes.
> --
>
> --- Patch [8]: [PATCH bpf-next 08/12] bpf: Enable 16-byte aggregate return types ---
> commit 5b4b6cb320ef1b1f82ac557b6f90945992d8a0c5
> Author: Yonghong Song <yonghong.song@linux.dev>
> Subject: bpf: Enable 16-byte aggregate return types
>
> This patch relaxes btf_distill_func_proto() and btf_validate_return_type()
> to allow kfuncs to return by-value structs or unions up to 16 bytes.
> This enables the <=16 byte aggregate return values end to end.
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index dff5c0d916412..bab82d1c8cb98 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -7572,7 +7572,12 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
>>   		return -EINVAL;
>>   	}
>>   	ret = __get_type_size(btf, func->type, &t);
>> -	if (ret < 0 || btf_type_is_struct(t)) {
>> +	/*
>> +	 * __get_type_size() already restricts a non-negative ret to void, a
>> +	 * pointer, an int, an enum or a struct/union, so only the size is checked
>> +	 * here.
>> +	 */
>> +	if (ret < 0 || ret > 16) {
> [Severity: High]
> Can this leak uninitialized kernel memory for structs between 9 and 15 bytes?
>
> The x86_64 ABI leaves the unused upper bytes of the %rdx register undefined
> when returning a struct that is not a multiple of 8 bytes.
>
> Looking at mark_kfunc_ret_reg_size() in kernel/bpf/verifier.c, if the struct
> size is greater than 8:
>
> 	if (size > 8) {
> 		mark_btf_func_reg_size(env, BPF_REG_0, 8);
> 		mark_reg_unknown(env, regs, BPF_REG_2);
> 		regs[BPF_REG_2].subreg_def = DEF_NOT_SUBREG;
> 	}
>
> The verifier explicitly marks BPF_REG_2 as fully initialized, bypassing subreg
> zero-extension.
>
> And in the x86 JIT do_jit() in arch/x86/net/bpf_jit_comp.c, it moves the full
> 64-bit register:
>
> 				fm = bpf_jit_find_kfunc_model(bpf_prog, insn);
> 				if (fm && fm->ret_size > 8)
> 					emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_3);
>
> Could a BPF program read the undefined bytes from R2, resulting in an
> information leak?

We should be fine here. See llvm patch https://reviews.llvm.org/D131598
which specifically tries to address this issue. The following is an example
for R2:

$ cat t.c
struct foo { long a; short b; };
struct foo bar(void);

int tar(void) {
   struct foo t = bar();
   return t.a + t.b;
}
$ clang --target=bpf -O2 -S t.c
$ cat t.s
         .file   "t.c"
         .text
         .globl  tar                             # -- Begin function tar
         .p2align        3
         .type   tar,@function
tar:                                    # @tar
# %bb.0:
         call bar
         w2 <<= 16
         w2 s>>= 16
         w2 += w0
         w0 = w2
         exit
.Lfunc_end0:
         .size   tar, .Lfunc_end0-tar
                                         # -- End function
         .addrsig

The caller will do proper narrowing immediately after call return.

>
>>   		bpf_log(log,
>>   			"The function %s return type %s is unsupported.\n",
>>   			tname, btf_type_str(t));

