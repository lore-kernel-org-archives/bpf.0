Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9360148986D
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 00:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785545890; cv=none; b=XSJMuyIJ9oVeBmill1I23sLx6wesm7H3d77iTwUcjSW+/u0d8kFB4sOBqh/WrmRZZH0NvpmWfnkKqh2eheIJxAZXkp9Ytd4R0pMjXROvM5dA4p/Q7JwwfTKeW3ejTvzDrWayGPvmlojMvy6n0FzQnvYqMHNvkNwFpQG7Trm+jSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785545890; c=relaxed/simple;
	bh=lsoE1qVcezkZc2HhRGXYicqTinW4yfGyZEOUzd7W7S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usg382nd+9AB05banqbd5IXZLejBsgikml1rqQ9IG8R7jQGqF7V3e6iHgg4Z3pbhLKhE+hZ5m0UyoRbCmEenEVKwsRzTNTgKBy/6dMa1H6NuVEeyQz9/Fqa7qkHrdmDMzNbaINxRtXR3PhAp7qmqXC6G5XGWLSm9Z+fd+uEatJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AyJ1bx9p; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AyJ1bx9p"
Message-ID: <634ef64f-b7c2-42f5-95fe-5855f6ef30a4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785545885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOfRGCeZmifO9qlU9391f/NKztrxpWO/v39bsqXXI3U=;
	b=AyJ1bx9p90XOk3lRX11LPrcJGJFdxAPfnoMVoACrwaFDqPqnjg2QVQ40O4gbvcpWoKFOPz
	Xbg3LHJamsBWwLNrpBwWwoh8fREMHa/jmMuL8CNPZHc5MeMtDklJVnlemlyBJm3Z36elGK
	pdyrXIKJsTYHU9lEcffZ61uIhbDEL/M=
Date: Fri, 31 Jul 2026 17:57:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/3] bpf, x86: Fix trampoline stack size for
 128-bit arguments
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, leon.hwang@linux.dev,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260729050204.2586457-1-yonghong.song@linux.dev>
 <a3aa43df79440fa636555ad987478e6b8409e38fbed641c6557b11e2ba8636d9@mail.kernel.org>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a3aa43df79440fa636555ad987478e6b8409e38fbed641c6557b11e2ba8636d9@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/28/26 11:20 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index b2feec81e231..01e7ce569c1e 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -3369,11 +3369,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>>   	WARN_ON_ONCE((flags & BPF_TRAMP_F_INDIRECT) &&
>>   		     (flags & ~(BPF_TRAMP_F_INDIRECT | BPF_TRAMP_F_RET_FENTRY_RET)));
>>
>> -	/* extra registers for struct arguments */
>> -	for (i = 0; i < m->nr_args; i++) {
>> -		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
>> -			nr_regs += (m->arg_size[i] + 7) / 8 - 1;
>> -	}
>> +	for (i = 0; i < m->nr_args; i++)
>> +		nr_regs += (m->arg_size[i] + 7) / 8 - 1;
>>
>>   	/* x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6
>>   	 * are passed through regs, the remains are through stack.
> Does the Fixes: tag target the commit that introduced the bug described in
> the commit message?
>
> The changelog says save_args() overwrites adjacent stack slots because the
> register save area is under-allocated. That mismatch requires the writer of
> the save area to count 2 slots for a 16-byte argument while the accounting
> loop counts 1.
>
> In commit a9c5ad31fbdc (v6.1-era), both sides were symmetric and save_args()
> did not exist yet. The save_regs() function in a9c5ad31fbdc used:
>
> arch/x86/net/bpf_jit_comp.c, save_regs():
>    if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
>            nr_regs = (m->arg_size[i] + 7) / 8;
>            arg_size = 8;
>    } else {
>            nr_regs = 1;
>            arg_size = m->arg_size[i];
>    }
>
> arch_prepare_bpf_trampoline():
>    if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
>            extra_nregs += (m->arg_size[i] + 7) / 8 - 1;
>
> Both used the same BTF_FMODEL_STRUCT_ARG condition, so a non-struct 16-byte
> __int128 was accounted for 1 slot and written to 1 slot. No adjacent slot
> was overwritten.

The problem happened actually in 6.1 release where BTF_FMODEL_STRUCT_ARG
is introduced. The below mentioned that there are changes in different
places for usage of BTF_FMODEL_STRUCT_ARG. But the root cause is still
in 6.1. What is why I used the fix tag which first introduced the issue.

So I still prefer to use the current fix tag.

>
> The asymmetry the changelog describes was introduced later, when save_regs()
> was replaced by save_args()/restore_regs() that compute the slot count
> unconditionally:
>
> arch/x86/net/bpf_jit_comp.c (current):
>    save_args():
>        arg_regs = (m->arg_size[i] + 7) / 8;
>    restore_regs():
>        arg_regs = (m->arg_size[i] + 7) / 8;
>    get_nr_used_regs():
>        arg_regs = (m->arg_size[i] + 7) / 8;
>
> versus the STRUCT_ARG-conditional accounting loop this patch deletes. The
> commit that made save_args() unconditional is the one that created the
> mismatch ('bpf, x86: allow function arguments up to 12 for TRACING', Menglong
> Dong, v6.6-era).
>
> The Fixes: tag points at a v6.1-era commit while the real culprit is
> v6.6-era. On a v6.1-v6.5 tree this patch changes nr_regs for an __int128
> from 1 to 2 while save_regs() still writes only 1 slot, which over-allocates
> the save area rather than fixing anything.
>
> ---
>
> Kumar Kartikeya Dwivedi raised a concern in v3 about a pahole BTF encoding
> issue with the function bpf_testmod_test_int128_arg(__int128 a, int b, long c)
> in tools/testing/selftests/bpf/test_kmods/bpf_testmod.c.
>
> On x86-64, parameter 'a' consumes rdi:rsi, and 'b' ends up in rdx (not the
> positionally-expected rsi). pahole maps the second parameter positionally to
> rsi, sees 'b' in rdx, and skips BTF encoding for the function.
>
> The comment in the code claiming that putting __int128 first prevents the
> pahole issue is incorrect. Kumar suggested using bpf_testmod_test_int128_arg
> (int b, long c, __int128 a) instead.
>
> Is the pahole patch set 'Encode true signatures in kernel BTF' that you
> mentioned in your response now merged? Without it, will this test fail in CI?

The 'Encode true signatures in kernel BTF' has merged into pahole and is
already used in CI. So we should be okay here.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30424886481

