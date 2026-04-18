Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8125771
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776535040; cv=none; b=sQ85NSyLzaNSztL7gn3VYobAP/qqSoKke4+WKQzeGB7QzIJPlejvYBXz7GZNa8M9HjaXtOeHmI2T9vIah9NkdPs53ZwaSo+vGPastkjz5URD9KKo1YkxB0qeas5aEQal7xKkRZamBwndx9A03uLjvrspFMhjVxBffXJ6Nm9M9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776535040; c=relaxed/simple;
	bh=Uds63RVdl5GjWGsrGzptx1daVKluG2IWhTKx5autbUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxRKmxmj/Hd/emBhEexHsSLRa3wocAmcrbozQDFQXhMSzYKVhWE0IOQ4kpixD7FRone2Dpg8er+D6LqPrs83mjQpIUll88ZCVn0lZNhC+p8mHtkwJgFM6VvBNTIMZlOm2eMuqPOrQNSWiMFBtnBP3HZJ08pyIvRwgbx29cedrG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vlw6zr8u; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vlw6zr8u"
Message-ID: <bb1a896a-bc92-42a7-9019-017aa77b6b7e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776535036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txx1RIqsTARKANrY7lL7BWzWTiTnuK1LtCjTVR11U/A=;
	b=Vlw6zr8ut9oTdxFjPS0WcrPYq9a6j1DVzgXoRVj/KeKQ1u80o3KqTezbmNyLcYH0cEl9tV
	hkr/Gq9jHnaZUG9L6qNP2fW0+3z4WaVflihHEHyqiJieg9rg9rZOjtlXmubBC8N8Wf27Oq
	Z2Y7MMKIncwE8JnfZsiAVF4On59bATU=
Date: Sat, 18 Apr 2026 10:57:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 11/16] bpf: Support stack arguments for kfunc
 calls
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260417034754.2630932-1-yonghong.song@linux.dev>
 <e5a6e801c10994cc2e03b0cd57e76152eb234493a6b7395a9859feade4a6575b@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <e5a6e801c10994cc2e03b0cd57e76152eb234493a6b7395a9859feade4a6575b@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/16/26 9:43 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -20145,6 +20209,16 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   	if (!bpf_jit_supports_far_kfunc_call())
>>   		insn->imm = BPF_CALL_IMM(desc->addr);
>>
>> +	/*
>> +	 * After resolving the kfunc address, insn->off is no longer needed
>> +	 * for BTF fd index. Repurpose it to store the number of stack args
>> +	 * so the JIT can marshal them.
>> +	 */
>> +	if (desc->func_model.nr_args > MAX_BPF_FUNC_REG_ARGS)
>> +		insn->off = desc->func_model.nr_args - MAX_BPF_FUNC_REG_ARGS;
>> +	else
>> +		insn->off = 0;
>> +
> Is insn->off really "no longer needed for BTF fd index" after this
> point? Looking at bpf_jit_find_kfunc_model() in kernel/bpf/fixups.c,
> the function is called during JIT compilation from every BPF JIT backend
> that supports kfunc calls (x86_32, s390, riscv64, ppc64, loongarch).
>
> It performs a bsearch on the kfunc_tab keyed by (insn->imm, insn->off)
> using kfunc_desc_cmp_by_imm_off:
>
> kernel/bpf/fixups.c:kfunc_desc_cmp_by_imm_off() {
>      ...
>      if (a->imm != b->imm)
>          return a->imm < b->imm ? -1 : 1;
>      if (a->offset != b->offset)
>          return a->offset < b->offset ? -1 : 1;
>      return 0;
> }
>
> The desc->offset was populated from the original insn->off during
> bpf_add_kfunc_call(), where for module kfuncs it is a non-zero BTF fd
> index.
>
> The call order is:
>
> bpf_check()
>    -> bpf_do_misc_fixups()
>       -> bpf_fixup_kfunc_call()  (overwrites insn->off to 0 or stack_arg_count)
>    -> bpf_prog_select_runtime()
>       -> bpf_int_jit_compile()
>          -> arch JIT
>             -> bpf_jit_find_kfunc_model()  (reads insn->off for bsearch key)
>
> After this patch, for a kfunc with 5 or fewer args that lives in a
> module (non-zero btf_fd_idx), insn->off is zeroed, and the bsearch will
> fail to find the entry that was stored with offset=btf_fd_idx.
>
> For kfuncs with more than 5 args, the new value of insn->off (stack arg
> count) also will not match desc->offset (btf_fd_idx or 0), so module
> kfuncs with stack args are also broken, and vmlinux kfuncs with more
> than 5 args get a nonzero insn->off that no longer matches
> desc->offset=0.
>
> Can the stack arg count be communicated to the JIT without clobbering
> the btf_fd_idx that bsearch still keys on?

The above code is dead code. Will remove.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24546989054

