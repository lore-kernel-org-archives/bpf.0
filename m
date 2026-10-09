Received: from mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49B23BB69D
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558793; cv=none; b=dlOB2tnoHLzE1wGGQxJozQFM6l1gxrESaF6aNF41MixCgnUVZhBNba4Jd/uCn39rmSlmQQQbhktWxJhnXBmY3SZRLJbBGTJ0WHZqMweZLHp39qZ4nGBy3uhDLUKwBBfUhK70mDfL55Ar8HDMs0FR7P0s7d79kAkg2ZH5c6GD1E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558793; c=relaxed/simple;
	bh=ES5C2zU9/owZ4m8OOip0v8LNQt+RScqdFXyLvYSW780=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJplRIx1mV4HBHWUDBO5pJi6kd+Gm8NOlfefMqUpHxr9GeqPHR0h/Qn4vnW9MbUMRHGlU8rZb23ld5ZYZDrljSASczOn19ORfcJLWG/hmgt3C+ZdZAKLIXFfVrRNmtKVuYZI5EIBXKAn/CipvnjyGpJHq74/OIHIDH/v2AqaLGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FtBeLo/g; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FtBeLo/g"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ES5C2zU9/owZ4m8OOip0v8LNQt+RScqdFXyLvYSW780=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791558789; v=1; x=1792163589;
 b=FtBeLo/gNfFJJoHy4sZzOwir1Xl2G9XmxI58V2U9lxX3NR4TPN7FijLIwNP4FEBEFl+TTvIC
 zxi8Id4pq4G1T1IJotFTuCVBkkK+99Wqv6Mk+qvUJ7gs/C8iSuPnO6uzMQL+iNJIF2QloAQ8AD8
 UZgE9I0dwcco05kuDiHi0d0Q=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a2210f97bc26ebe3;
	Fri, 09 Oct 2026 15:13:09 +0000
X-Mizu-Trace-ID: a2210f97bc26ebe3
X-Migadu-Flow: FLOW_OUT
Message-ID: <90e57268-b5c3-4113-b45b-25dcb6b132b5@linux.dev>
Date: Fri, 9 Oct 2026 17:13:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v10 05/24] bpf: Mark covered call sites and check
 a program can take a table
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261009041447.17092-1-yonghong.song@linux.dev>
 <20261009041513.24198-1-yonghong.song@linux.dev>
 <sashiko-outbox-164845@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-164845@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/9/26 6:34 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: exception landing pad target fails to shift under BPF_PATCH_MOVE_TARGET
> --
>
> commit 12354911ea762dbd3bb3462885368e582fd7efd5
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Mark covered call sites and check a program can take a table
>
> bpf_exc_prepare() records the landing pad of every call in a cleanup record's
> range. bpf_exc_check_prog() refuses offloaded programs, programs without
> JIT support, and programs with epilogues or exception callbacks.
>
>> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
>> index 2fef417dc090f..21bc1294227c1 100644
>> --- a/kernel/bpf/exception.c
>> +++ b/kernel/bpf/exception.c
>> @@ -141,6 +141,76 @@ int bpf_exc_check_info(struct bpf_verifier_env *env, const union bpf_attr *attr,
> [ ... ]
>> +static void mark_call_sites(struct bpf_verifier_env *env)
>> +{
>> +	u32 i, j;
>> +
>> +	for (i = 0; i < env->cleanup_info_cnt; i++) {
>> +		struct bpf_cleanup_info *rec = &env->cleanup_info[i];
>> +
>> +		for (j = rec->begin_off; j < rec->end_off; j++) {
>> +			struct bpf_insn *insn = &env->prog->insnsi[j];
>> +
>> +			if (!bpf_pseudo_call(insn) && !bpf_is_callx(insn) &&
>> +			    !bpf_is_unwind_kfunc(insn))
>> +				continue;
>> +			env->insn_aux_data[j].cleanup_pad = rec->landing_pad_off + 1;
> [Severity: High]
> If a landing pad is at the exact start of the program or subprogram
> (landing_pad_off == 0), how does this interact with BPF_PATCH_MOVE_TARGET
> when prepending instructions?
>
> Because kernel/bpf/exception.c:bpf_exc_check_info() permits landing_pad_off
> to be 0 or subprog_start, this structural layout is possible. When it
> happens, the shift logic in kernel/bpf/fixups.c:adjust_insn_aux_data() uses
> a strict greater-than condition:
>
>      if (env->cleanup_info_cnt)
>          for (i = 0; i < prog_len; i++)
>              if (data[i].cleanup_pad > off + 1)
>                  data[i].cleanup_pad += cnt - 1;
>
> If cleanup_pad == off + 1 (e.g., when off=0), it doesn't get shifted.
> But BPF_PATCH_MOVE_TARGET prepends instructions at off=0, such as
> when gen_prologue is called in kernel/bpf/fixups.c:bpf_convert_ctx_accesses().
>
> Will this leave the unwinder jumping into the newly prepended verifier
> instructions rather than the program's original first instruction,
> potentially causing issues like out-of-bounds reads or infinite loops if
> registers are clobbered?

The same as patch 4, BPF_PATCH_MOVE_TARGET is not needed.

