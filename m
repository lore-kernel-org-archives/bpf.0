Received: from mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17B7368D4F
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 04:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841661; cv=none; b=WGy+BLe78cqKgFmgT5O68aTpFad5YtdhK9GTbIGTekv0s7EZLWt3GNzCIXX0FodB3CUHB41o2QfV5HPweWqypQ+hXwfLZ+fUREsvxINf6vUVtsM97wP/3aNJvmIb76LsGW8X4nYE6b4o6flgoYRfiHoG446MhRwUf4CzWL17oIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841661; c=relaxed/simple;
	bh=m6V2RF6ABpdBUXt/JwI0k+c2c46Fz5EHr4ua9/GihMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etHv/gNVjFsP6fxYXtZpf9p4033Yq+s6eq82IEoCsfFCyueHU5FOaG7/ArMdBsSSQWIK/5fJM6cqKxJ9en+E9lVFieh9LUnrRx8DMOXaB/Y44Wb57BYJXSC0TeTnSUS4eULiXrJiVxKFvYKqfbs/m/sGyeLcDPZsBpEB495UeOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qwRGGt42; arc=none smtp.client-ip=91.218.175.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qwRGGt42"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=m6V2RF6ABpdBUXt/JwI0k+c2c46Fz5EHr4ua9/GihMY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788841656; v=1; x=1789446456;
 b=qwRGGt42YKfY0uRqd5jQUC7BJt5HsownzDvmtNmq+KvPwlIthALtKc872LF+UWYn53HzqiAs
 FVWo85DMAr+p1dzKYGDaaXDHU2E6EctzyuLpsbLDD57PWalHpw8Drb3zKWXsefoiqn7Of/9c085
 N6mOTSM6aZu/zSdBUeqjWHjk=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e2deb18ee98ccc6d;
	Tue, 08 Sep 2026 04:27:36 +0000
X-Mizu-Trace-ID: e2deb18ee98ccc6d
X-Migadu-Flow: FLOW_OUT
Message-ID: <cd3251c3-b2f9-4254-8e33-42b80b4a9f49@linux.dev>
Date: Mon, 7 Sep 2026 21:27:34 -0700
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
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051033.3979978-1-yonghong.song@linux.dev>
 <20260904053658.335DE1F00A3F@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260904053658.335DE1F00A3F@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/3/26 10:36 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] emit_kfunc_args() and bpf_jit_kfunc_stack_slots() silently ignore kfunc_arg_layout() errors for kfuncs requiring more than 12 argument eightbytes, leading to miscompiled BPF programs with incorrect argument placements.
> --
>
> commit f5201014b232baff8f1ba36c0b74d2c3e1e5ccf9
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf, x86: Place kfunc arguments per the SysV calling convention
>
> This commit updates the BPF JIT on x86 to conform to the SysV calling
> convention when placing kfunc arguments. It adjusts argument placements
> before a kfunc call to account for differing rules between BPF and SysV
> regarding stack and register usage. The outgoing argument area is sized
> to support both conventions.
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
>> +static int emit_kfunc_args(const struct btf_func_model *fm, u8 **pprog,
>> +			   s32 stack_base)
>> +{
>> +	u8 *prog = *pprog, *start = prog;
>> +	bool done[MAX_BPF_FUNC_ARGS] = {};
>> +	u8 pos[MAX_BPF_FUNC_ARGS];
>> +	int i, j, n, todo = 0, parked = -1;
>> +
>> +	n = kfunc_arg_layout(fm, pos, ARRAY_SIZE(pos));
>> +	if (n < 0)
>> +		return 0;
> [Severity: Medium]
> Will this silently ignore errors if a kfunc requires more than 12 argument
> eightbytes?
>
> While the verifier limits the argument count to 12 (MAX_BPF_FUNC_ARGS),
> arguments can take up to 2 slots, so the total slots could reach 24.
> If a BPF program calls a registered kfunc that requires more than 12
> eightbyte slots (such as 7 struct arguments of 16 bytes each),
> kfunc_arg_layout() will return -EINVAL because max is hardcoded to 12 here.
>
> Since emit_kfunc_args() returns 0 instead of propagating the error code,
> could this cause the BPF program to compile successfully but execute with
> missing argument shuffle instructions? It seems the kfunc might read garbage
> from the 6th slot onwards, potentially causing panics or data corruption.
>
> This same pattern of silently ignoring layout errors appears in
> bpf_jit_kfunc_stack_slots():
>
> kernel/bpf/core.c:bpf_jit_kfunc_stack_slots() {
> 	...
> 		n = layout(fm, pos, ARRAY_SIZE(pos));
> 		if (n < 0)
> 			continue;
> 	...
> }
>
> Does this also leave stack calculations undersized?
>
> Though the stack corruption is mathematically averted because BPF's calling
> convention stack requirements always equal or exceed SysV's (making
> outgoing_rsp naturally sufficient), the silent argument corruption remains.
> As there are currently no mainline kfuncs that take more than 12 slots,
> this appears to be a latent regression.

This patch will be removed. I will simplify the jit.


