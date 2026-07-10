Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9DD43712F
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698343; cv=none; b=JbGyypQwT7slSXJafQT6Nj2nsqC4lhsdUe7C2joyyl/Epu+Hyxr1wDhM7nMAuM2UwmyPE8PpIxzX6iM7/b8+Dge8mIGTqOC+FxP3oOO1xJ9fhnjUCFN25sF1wrYhJO8vuucAnxPi446S9YDUGbnPXgBVdrhK9neaYe7sf+7y+pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698343; c=relaxed/simple;
	bh=BhwVYfpFR79oYTShacDUr2hlzhTnFWDFl2R+6GXiWSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nT5mPI8kxRKO6jq2u7b4kTlSWJRogcgslFtDZFkic0j+JwK9PpZmqfxrAAd+wQooj4RDJgwz8JcChEE67MO14DlPE2muC/hmkSaYcO8gJTCM8XYmmeaCECY73kYFfaTaLw2rC8A6Vn/zOavrX5iJVjoaZkQWvqi59Fm9EXIXHro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V590BP5E; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V590BP5E"
Message-ID: <6c9ed329-02a4-4de4-b6e9-3eacdfe11922@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783698339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MJAkNAixLcOAQy5WKBTS0fpHbyVG0CUx183CCa+0bk=;
	b=V590BP5E2QpV20oswvuV7SRxE4Wc+z3MzTBiP5kcsmGVn2BWCByMQg7mDp8QYFBbcyPY/l
	1J01HPfLwqHlox7zuW1PJBjST08EoQOdXwcVru7AU6Dp+tTATARSLThUWbOTgGtiTtS7xs
	KqkGmBe0EyNPZzkU27Tt91ZgyiqQAHg=
Date: Fri, 10 Jul 2026 08:45:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Reject >8 byte return values on
 return-reading trampoline paths
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260710144404.2579671-1-yonghong.song@linux.dev>
 <20260710145845.883411F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260710145845.883411F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/10/26 7:58 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] The x86 BPF trampoline generation under-allocates stack space for 16-byte scalar arguments (e.g., __int128), leading to an out-of-bounds stack write that overwrites the saved RBP and return address.
> --
>
> --- Patch [1]: [PATCH bpf 1/2] bpf: Reject >8 byte return values on return-reading trampoline paths ---
> commit 8947b8106804bc7e7328c045366441fc0d165459
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Reject >8 byte return values on return-reading trampoline paths
>
> This patch rejects BPF trampoline attachments for types like fexit, fmod_ret,
> and struct_ops if the target function has a return value larger than 8 bytes.
> Previously, the trampoline accepted 16-byte return values (e.g., __int128) but
> only saved and restored 8 bytes, which corrupted the return value seen by the
> caller.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6515d4d3c0032..26d281b77a6e7 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -19137,6 +19151,14 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>   		if (ret < 0)
>>   			return ret;
>>   
>> +		if (tgt_info->fmodel.ret_size > 8 &&
>> +		    attach_uses_trampoline_retval(prog->expected_attach_type)) {
> [Severity: High]
> This is a pre-existing issue, but while this patch addresses >8 byte return
> values, does the BPF trampoline also have a similar problem with >8 byte
> arguments?
>
> In kernel/bpf/btf.c:btf_distill_func_proto(), 16-byte arguments like __int128
> are accepted, but __get_type_fmodel_flags() does not set BTF_FMODEL_STRUCT_ARG
> for them because they are BTF_KIND_INT, not structs.
>
> In arch/x86/net/bpf_jit_comp.c:__arch_prepare_bpf_trampoline(), the stack
> size calculation relies on this flag:
>
> 		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
> 			nr_regs += (m->arg_size[i] + 7) / 8 - 1;
>
> Because the flag isn't set for __int128, it is incorrectly counted as
> 1 register, under-allocating the stack space by 8 bytes per 16-byte
> scalar argument.
>
> Later during code generation, save_args() computes
> arg_regs = (m->arg_size[i] + 7) / 8, which evaluates to 2. It performs
> two 8-byte stack stores, which will underflow the allocated boundary and
> overwrite the saved RBP and potentially the return address.
>
> Could this lead to out-of-bounds stack writes for fentry/fexit programs
> attached to functions with 16-byte scalar arguments?

Looks like this indeed an issue for x86.
Since the __int128 issue exists for both return value and argument,
I will send v2 to address both of them together.

>
>> +			bpf_log(log,
>> +				"Attach to function %s with a >8 byte return value is not supported for this attach type\n",
>> +				tname);
>> +			return -EOPNOTSUPP;
>> +		}

