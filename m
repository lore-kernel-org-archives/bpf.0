Received: from mta1.migadu.com (out-39.mta1.migadu.com [95.215.58.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC8437F33E
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 19:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564152; cv=none; b=YxrPXeuIzqMNzHK9WlASxzQ3TXbS1mZuTR8si9xbLIAd4iwbNk67hNqYKis//OMAUAtoQR9fY4wQ7Dkx04NLiX5riCO7J5CT6jsHAfsCbYrJelDa3kna0SxfL6azIpWtBLITqSaPejw9FcjBNhhptYbA/LpyodHUlU8Sfg545O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564152; c=relaxed/simple;
	bh=XJKylqF8lApmKsKOPHpCQW96d2NsBo//4ayfnyEUckA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bt4GnMz70E+Ll5KZrMJb4sZa4I24M+xRUV0wIwexeTcRoHUmlS+1twtKgY9ZTgD81T2tZXKSNYgdN1mtOjmMbYG5Oth+HbmyHdyr5bqLi6JN+5WbQ7p8h1nrYynd0GZLt1CYen+qXwH+vO1jHeW9bQqQE4E/shlTuzRHDpfJLTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TAODnvYr; arc=none smtp.client-ip=95.215.58.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TAODnvYr"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XJKylqF8lApmKsKOPHpCQW96d2NsBo//4ayfnyEUckA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786564141; v=1; x=1787168941;
 b=TAODnvYrAoGLK5t6hh1e+mnKF1Xv6zeo9OqgE2PvasVSXPF1YKZ7Glrd61oAKEM0/TkQR0yT
 N7n/ekqC1iu9NOzZjozngeUTv1v2IBvIlYN9vAfIjiP79BesVGAp/IBsu14Rk66nbxV7CfibgXZ
 ICqGgX7SV4RiGHXgIjHdAzzg=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:cd95)
	by smtp.migadu.com with ESMTPS id 07bbe5dd543ce0a8;
	Wed, 12 Aug 2026 19:49:01 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <5cfa1167-7bd1-4933-a206-7b177822c33c@linux.dev>
Date: Wed, 12 Aug 2026 12:48:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 03/13] bpf: Wire up JIT support for 16-byte
 kfunc returns
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260811000927.2380571-1-yonghong.song@linux.dev>
 <b969b8d1045c704a50153c0947c5c47a35042e9755b592b4c38807daf64b23d3@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b969b8d1045c704a50153c0947c5c47a35042e9755b592b4c38807daf64b23d3@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/10/26 6:24 PM, bot+bpf-ci@kernel.org wrote:
>> LLVM 23 returns an __int128, or a struct/union larger than 8 bytes and no
>> larger than 16 bytes, in the BPF R0:R2 register pair. The previous patch
>> taught the verifier about that convention; wire up the JIT side so that the
>> second half of the return value actually lands in R2.
> This isn't a bug, but should this say the previous patch added the shared
> R0:R2 helpers, rather than that it taught the verifier the convention?
> Looking at 882cac43a2cef ("bpf: Add helpers to describe the R0:R2 return
> register pair"), its changelog states "No functional change,
> bpf_ret_reg_pair() has no callers yet" and "Later patches teach the JIT,
> precision backtracking, live register analysis and the verifier itself
> about that convention." The verifier actually learns the convention in
> d280e9c973c59 ("bpf: Add verifier support for 16-byte returns in R0:R2"),
> two patches later.

Okay, will update the commit message.

>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 8dddb5d7af21b..01c34114c8502 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -2647,6 +2647,22 @@ st:			insn_off = insn->off;
>>   				return -EINVAL;
>>   			if (priv_frame_ptr)
>>   				pop_r9(&prog);
>> +			if (src_reg == BPF_PSEUDO_KFUNC_CALL) {
>> +				const struct btf_func_model *fm;
>> +
>> +				/*
>> +				 * A kfunc returning a >8 byte aggregate hands the
>> +				 * second half back in RDX (the native ABI's second
>> +				 * return reg), but BPF expects it in R0:R2. BPF R0
>> +				 * is RAX (no move needed), while BPF R2 is RSI, so
>> +				 * copy RDX into RSI.
>> +				 */
> This isn't a bug, but since struct/union returns are still rejected by
> btf_distill_func_proto() at this point in the series (kernel/bpf/btf.c
> checks "if (ret < 0 || btf_type_is_struct(t))"), would "a kfunc
> returning more than 8 bytes" read more accurately here than ">8 byte
> aggregate"? Aggregates only become reachable later in b12c58bbc5e59
> ("bpf: Enable aggregate return types up to 16 bytes"), so the only
> return type that can reach fm->ret_size > 8 at this commit is __int128.

Will update commit message.

>
>> +				fm = bpf_jit_find_kfunc_model(bpf_prog, insn);
>> +				if (!fm)
>> +					return -EFAULT;
>> +				if (fm->ret_size > 8)
>> +					emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_3);
>> +			}
>>   			break;
>>   		}
> This isn't a bug, but emit_kfunc_arena_args() already does this same
> bpf_jit_find_kfunc_model() lookup earlier in do_jit() and bails out on
> NULL. Looking at emit_kfunc_arena_args() in arch/x86/net/bpf_jit_comp.c:
>
>      fm = bpf_jit_find_kfunc_model(prog, insn);
>      if (!fm)
>          return -EINVAL;
>
> Since bpf_jit_find_kfunc_model() is a pure bsearch over an immutable
> table, if the first lookup succeeded the second cannot fail. Could the
> two BPF_PSEUDO_KFUNC_CALL blocks share one lookup, so the second bsearch
> and the unreachable "if (!fm)" guard go away? The two sites also disagree
> on the errno for the identical condition (-EINVAL vs -EFAULT).

Good point. Let us just one 'fm = bpf_jit_find_kfunc_model(prog, insn)'.
Will change.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31446101762

