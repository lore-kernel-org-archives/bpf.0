Received: from mta1.migadu.com (out-101.mta1.migadu.com [95.215.58.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C582386C1E
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564567; cv=none; b=FFVY55KtX6+gRJ668usKq9qVT/XRVQdl8/e4GdQEr7HkzoHZUuqFW75KkR1W3/D4n/JLZySQgFIIhtrhiCpLdk2Ftoq5YaqQAvx1j68wHKXxo8W3TSnZPKC6Rz+dfVcjRMhoTj9UO20E8BFj5GpUNAzH3TY+k3BgWL2K/6cw5vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564567; c=relaxed/simple;
	bh=/BQNJ1YknXzJNIfKwQBmx5fcmpDiASIgniCAhTJG1tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5fHAFRbhFX6ymgVfvfUGX2Gy0s9Mp75dAjbsu1pUJKTdJc2ZCNYqJWQYNsoEtTEJlMZBoRaMGSMI16nJXWbH0g9KRac6mRNfs/vjd7UNsZ1D80V5ues+NUvUX7zQWDBMm3081kHiFXQK/G0lxTHcbo4rUFzO2F/BHosihKYNHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DCjEgm9B; arc=none smtp.client-ip=95.215.58.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DCjEgm9B"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/BQNJ1YknXzJNIfKwQBmx5fcmpDiASIgniCAhTJG1tE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786564563; v=1; x=1787169363;
 b=DCjEgm9BvMFCGepNwqR1iqILU/VahDUf2cavay41fohoGQS/TVuyyBJTTM6iWwNGPRBgdKm2
 q3xdPVH75HTlWQoNVVK6lbOMTVbv+ld7a2XzCQ2D/wc/2qkKjEuPN4+WD1Wqz8Tsa8IxILUPVqO
 MOr+TqEb+q9sFeg82L2PDtBk=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:cd95)
	by smtp.migadu.com with ESMTPS id bdb4cfd8db90265f;
	Wed, 12 Aug 2026 19:56:03 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <127e70b6-b844-4824-81fa-112ae5635abf@linux.dev>
Date: Wed, 12 Aug 2026 12:55:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 05/13] bpf: Account R2 of register-pair
 returns in live register analysis
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260811000937.2381528-1-yonghong.song@linux.dev>
 <73f764590b71831acdfe184bdc7d06c9d0da1403745ac24c4dea486385fce48a@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <73f764590b71831acdfe184bdc7d06c9d0da1403745ac24c4dea486385fce48a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/10/26 6:09 PM, bot+bpf-ci@kernel.org wrote:
>> A BPF_EXIT of a subprogram returning a value larger than 8 bytes (a
>> struct/union or an __int128) reads R2 as well as R0, since the second half
>> of the return value is passed back in R2. compute_insn_live_regs() only
>> marked R0 used at exit, so a callee's R2 could be considered dead and
>> cleaned from checkpointed states, which would allow unsound state pruning.
>>
>> Mark R2 as read at the BPF_EXIT of a subprogram that does return a register
>> pair. bpf_compute_live_registers() walks the instructions in order and
>> env->subprog_info[] is sorted by subprogram start, so the containing
>> subprogram is tracked with a running index and its return convention is
>> queried once per subprogram through bpf_ret_reg_pair().
> This isn't a bug, but the description talks about tracking the containing
> subprogram with a running index while walking instructions in order. The
> code that landed uses a plain nested loop iterating over subprog_info[]
> directly:
>
> 	for (subprog = 0; subprog < env->subprog_cnt; subprog++) {
> 		start = env->subprog_info[subprog].start;
> 		end = env->subprog_info[subprog + 1].start;
> 		ret_reg_pair = bpf_ret_reg_pair(env, subprog);
>
> 		for (i = start; i < end; ++i)
> 			compute_insn_live_regs(env, &insns[i], &state[i], ret_reg_pair);
> 	}
>
> This nested form gets its [start, end) ranges straight from subprog_info[]
> (the same idiom mark_fastcall_patterns() uses), so neither "walks the
> instructions in order" nor the sortedness reasoning is what makes the loop
> correct. Would it be worth adjusting that paragraph to describe the nested
> loop form that landed?

Okay, will update the commit message.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31446101762

