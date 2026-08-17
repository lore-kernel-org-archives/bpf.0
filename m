Received: from mta1.migadu.com (out-207.mta1.migadu.com [95.215.58.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ED3425CEE
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983159; cv=none; b=o06Fh+oj8nm/g14DHafOaiLIQJLh5xD4xFgu6ZMMRy6H4oT5xO1KQsnfMWD57zKnB6NSCYKHOW3Xmn4NAbbm8gxoIGc9fYD56hswi7cGqYvupqdrTRX+tzQtXzVlWNEuLKKyKKR7tRx/qsIbg155vPRdSifBtHPWdOH/ajSVd7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983159; c=relaxed/simple;
	bh=WGx3h33cPqbSjk/SzW1+lLTO8vhVN29yB2U61HAXTkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijsHRzGlct72gzvFbeUkZLPaaFfXj82u4hacg37i+55ppVbBNzJ7fOyFIjfdkNvTlgjxSfnBf8jvtkWHusiST18auGgNX4x7HRTc4I0C+BoOxMiGkXUWMsMaFBwt7DMABhDw9FNQpgbeKPouUZpI3CGu4Nye4bUXxMaSJT7mNZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cTfGUGIK; arc=none smtp.client-ip=95.215.58.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cTfGUGIK"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WGx3h33cPqbSjk/SzW1+lLTO8vhVN29yB2U61HAXTkI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786983155; v=1; x=1787587955;
 b=cTfGUGIKQ9cygEfj5cupQgJwkru6Ox9/s6VMg24RJbukUxU/R9iBirGnxbPy5QO1jUCm0IUr
 ux533+nV/VjWomPTOIeJCOUQ3d/0lm7LZn/uDwk1rXwa2FeUlqADrzPP04/Z4DW8qz2mnE/dpUs
 1pCreqfeBOt8kTDFClN8mud8=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:5604)
	by smtp.migadu.com with ESMTPS id 42468abc18ef6ac4;
	Mon, 17 Aug 2026 16:12:25 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <edef89b1-08ad-48b0-ab03-5a80c3ce3940@linux.dev>
Date: Mon, 17 Aug 2026 09:12:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 07/10] bpf: Enable aggregate return types up
 to 16 bytes
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
 <20260817042217.2294438-1-yonghong.song@linux.dev>
 <20260817044241.BADD71F000E9@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260817044241.BADD71F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/16/26 9:42 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] Attaching a BPF trampoline to a function returning a 16-byte struct silently corrupts the return value because the trampoline fails to preserve the second return register.
>
> Pre-existing issues:
> - [Medium] Kfuncs returning structs with padding or sizes that are not a multiple of 8 may leak uninitialized kernel memory to BPF programs.
> --
>
> --- Patch [7]: [PATCH bpf-next v6 07/10] bpf: Enable aggregate return types up to 16 bytes ---
> commit 5c9b0fdbdfee0f07315dc190bc0c039af9bce8bd
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Enable aggregate return types up to 16 bytes
>      
> This commit relaxes the verifier and BTF distillation to accept by-value
> struct or union return types up to 16 bytes. These are returned in the
> R0:R2 register pair.
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -7591,7 +7591,7 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
>>   		return -EINVAL;
>>   	}
>>   	ret = __get_type_size(btf, func->type, &t);
>> -	if (ret < 0 || btf_type_is_struct(t)) {
>> +	if (ret < 0 || ret > 16) {
> [Severity: High]
> By relaxing this check to allow up to 16-byte returns, does this silently
> break fentry and freplace programs attached to such functions?
>
> While bpf_check_attach_target() rejects programs if they explicitly use the
> trampoline retval:
>
> bpf_check_attach_target() {
>      if (tgt_info->fmodel.ret_size > 8 &&
>          attach_uses_trampoline_retval(prog->expected_attach_type)) {
>          ...
>      }
> }
>
> It appears to still allow fentry and freplace programs to attach. When a
> BPF program attaches to a kernel function returning a 16-byte struct, the
> target function returns its value in RAX and RDX (on x86-64).
>
> The BPF trampoline epilogue calls __bpf_tramp_exit(), which clobbers
> caller-saved registers like RDX.
>
> If the trampoline only restores RAX from the stack before returning, won't
> RDX be left with garbage, corrupting the upper 8 bytes of the original
> function's return value?

For fentry, we should be okay as there are no return values.
For freplace, in patch "bpf: Add verifier support for 16-byte returns in R0:R2",
the return value cannot be more than 8 bytes.

So we should be okay here.

>
>>   		bpf_log(log,
>>   			"The function %s return type %s is unsupported.\n",
>>   			tname, btf_type_str(t));
>> [ ... ]
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> [ ... ]
>> @@ -14008,7 +14008,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   		 * otherwise a pointer field would be laundered into a scalar
>>   		 * and escape provenance and reference tracking.
>>   		 */
>> -		if (!__btf_type_is_scalar_struct(env, desc_btf, t, 0)) {
>> +		if (!btf_type_is_scalar_struct(env, desc_btf, t, 0)) {
> [Severity: Medium]
> This isn't a bug introduced by this patch, but since the scope of by-value
> returns is expanded from 8 bytes to 16 bytes, it might be worth verifying.
>
> In check_kfunc_call(), the verifier immediately calls mark_kfunc_ret_regs()
> after this check:
>
> check_kfunc_call() {
>      if (!btf_type_is_scalar_struct(env, desc_btf, t, 0)) {
>          ...
>          return -EINVAL;
>      }
>      mark_kfunc_ret_regs(env, regs, t->size);
> }
>
> If a kfunc returns a struct containing padding bytes, the C compiler might
> leave those padding bytes uninitialized. Since the verifier marks the entire
> return registers as fully initialized scalars, could this allow a BPF
> program to read uninitialized kernel memory via the padding bytes?

This should not be a problem. For kfunc, the return value (if size is less
than 8), the compiler will do proper narrowing.

>
>>   			verbose(env,
>>   				"kernel function %s returns %s %s that is not composed of scalars\n",
>>   				func_name, btf_type_str(t),

