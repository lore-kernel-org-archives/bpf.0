Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6288F273D6D
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 05:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780290584; cv=none; b=U+gQy2/w6kKaLXc8MdQdp53G4vV9pHGlKf13lMGJP+VtSChzk7EGbGZ319M3+/PyyCnejA2CfefXYUeSdb/Vdx3EpyyTersDY2AqiaFV1fCz4kRAjgqJxWfz4biAD4U0JOB+kw0yn0ExndQVRM3vIZNOb+pQSzs3hngQh0yQyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780290584; c=relaxed/simple;
	bh=UOuN7C3I0nXg/sEYnoZM2Ygm5D5hdxYITzQw65kOciQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=nVB+y0SNEjp+9GG6L1BJjfieKkOM+L8lmWWzIUHM2p1kjbDwaWJXFhyMejr8LnyIfUvMPJEh4XVKQPXdEjOWNY6mMOckEZr+8A67acLnSTJgwQc4AUY8KvBWl2XcfSZclED77lg5LFf4mGqEbw7gIaETPm1YO8S+PKXn/Z6G5M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=t6B+tsdd; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="t6B+tsdd"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b7b7b7a80so1769330a91.1
        for <bpf@vger.kernel.org>; Sun, 31 May 2026 22:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780290583; x=1780895383; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7BJkAVMyuacNJHQpoPyEmWeh4Ciu3EPaEWst7jSM98=;
        b=t6B+tsdddHbPyajDGAr74t+8xYaVKcwDMWPSjHP6gH+ORhhqxFgPWnsieFucUZVJfo
         b7UzekxRQqLx3D7e5ElGIrmQ2sLfxa5FjjsvkDKn55sP9cOwgSm36sSr92pmddw1F1ZB
         QjOvmXxyL5jtBKfF5X+3hjaTUNy2IH0bmizcOxU1G7T/Kh9LVJkH61YT1EjNGpsZyoK8
         M/XYFb4L6aANJ+DRMoImD4UAP49H/hXLXDe32SBJ4axnBB0v6q/M+roSgipFMWiVNGIX
         Wjpe8+c8fh9vc5Z//hmu0iiLhmuIId+coiTmZlKd9E4SmWakmfHAYzM07wCG1XruBV3Z
         j7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780290583; x=1780895383;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7BJkAVMyuacNJHQpoPyEmWeh4Ciu3EPaEWst7jSM98=;
        b=G6grf8OzPhVzKr1VQYvLkS9LK7p332Ssa6zPsnc4cgvUTi6do5hdKdxh6KLTL81a/d
         XIiSLwsGRWEgAZxaJk4hFOw9YKi+y1xptg36/iIiBkTeG4Nuv34om0pxguFJkvOhvpsz
         wIjR8arkd8fmkkx6DPONj4ha1KKZTi16M1qrTqoViEL30jBz3P/BmL+W6e/bG0ApZS5A
         k5bFL054QBqD6qFbB+hKs91haJBpX76xzpwneSZo81b6Spdn6Zn+bh/43bl7GO2zUo2+
         Z8hwqR7j1frUNSEiC/kRbMT+rsJbQw1kkqEfXGbu1QT+8ZSfsV+vGgBc1EFfH1uSCnnR
         25xA==
X-Gm-Message-State: AOJu0YwEutAGfkYvVh7e6mFvWwylf84kq2hp7LjV/9IvPhGddXjgqUsV
	y6oBY7did8U130gCkIvueE1H+4sTsTapfk3zB1O5DvwdQ5RufsXnHQKusU4CbEnrvKk=
X-Gm-Gg: Acq92OFt20LrVOI43LOpklBBOdJXSC+LIUG7eEfX5InK1mKhHnP2jWegNnzQTtujyRY
	hf/QsdfoAMz09jHWt5o8Z3nQasYl/bYrU6SaqE0Nb7u1NsuCzI0cmYpmWmQrvXNdPr9b3rBeP6n
	Khgt1yEgFNzFDYUa8PlZVDnNoRYb25TMuhN6lNi8fYGk/P9vPD/LnfKbLWTZI4tA2Xievfjz75v
	Ge2hjklvwIaXQkA/Ekpuf2jXzmFtDHWAO+UohnBLtvSQnpm3ZcAoj3x7a562LLmlNBKU7cD7RUJ
	oK6XYLFBSnzs5bFobUahwgWGITs+JB7aysoDIw4MtPCYHznsmyOmYAAgBtRAznWLxzIOD09gNnE
	U4XtSW5kazWtBdzumqSI9oslnf46eDgcbH6AtRI8MYMDd+ik3Ud5Icfw/xE9wPpAJcR55Saov29
	NQ3y2cQ/5CYjJnhYlRtuTfXmPEKiFxyZnnTPY=
X-Received: by 2002:a17:90b:57f0:b0:35f:b9f1:fded with SMTP id 98e67ed59e1d1-36beb5adccdmr6927537a91.12.1780290582556;
        Sun, 31 May 2026 22:09:42 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbe18dda3sm4326840a91.9.2026.05.31.22.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 22:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 01:09:41 -0400
Message-Id: <DIXGCACGWUVB.15OD5ER214U3S@etsalapatis.com>
To: <sashiko-reviews@lists.linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 3/5] bpf: Allow subprogs to return arena
 pointers
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260530002259.4505-4-emil@etsalapatis.com>
 <20260530045438.5CD9F1F00893@smtp.kernel.org>
In-Reply-To: <20260530045438.5CD9F1F00893@smtp.kernel.org>

On Sat May 30, 2026 at 12:54 AM EDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] Global subprograms returning arena pointers have their return va=
lue unconditionally marked as a scalar at the call site.
> - [Medium] The verifier bypasses BTF type enforcement for global subprogr=
am return values.
> - [Low] The error message logged when a global function has an invalid re=
turn type is outdated and confusing.
> --
>
> commit 0192bc82392a7d1bde4b6ab66bef8ece2f90c7cf
> Author: Emil Tsalapatis <emil@etsalapatis.com>
>
> bpf: Allow subprogs to return arena pointers
>
> This patch expands the verifier to permit returning an arena pointer to t=
he
> caller from a subprogram. The main subprog is still not allowed to return
> an arena pointer.
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index c6a930aca67ec..7a8101879f84d 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>
> [ ... ]
>
>> @@ -7963,17 +7993,15 @@ int btf_prepare_func_args(struct bpf_verifier_en=
v *env, int subprog)
> [ ... ]
>> -	if (!btf_type_is_void(t) && !btf_type_is_int(t) && !btf_is_any_enum(t)=
) {
>> -		if (!is_global)
>> -			return -EINVAL;
>> -		bpf_log(log,
>> -			"Global function %s() return value not void or scalar. "
>> -			"Only those are supported.\n",
>> -			tname);
>> +
>> +	err =3D btf_validate_return_type(env, btf, t, subprog);
>> +	if (err) {
>> +		if (is_global) {
>> +			bpf_log(log,
>> +				"Global function %s() return value not void or scalar. "
>> +				"Only those are supported.\n",
>> +				tname);
>> +		}
>>  		return -EINVAL;
>>  	}
>
> [Severity: Low]
> Since arena pointers are now supported, should this error message be
> updated to avoid confusing users? It still states that only void or
> scalars are supported.
>

Not necessary imo, the error is there for when things go wrong. Nobody's
going to read it and go "I should change my program to not return arena
pointers." If they're inspecting the verifier source, they have the
logic for allowing __arena tagged pointers in front of them.

>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index c8d980fdd7099..64d7954e93ea7 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -9375,7 +9375,7 @@ static int check_func_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
>>  		clear_caller_saved_regs(env, caller->regs);
>>  		invalidate_outgoing_stack_args(env, cur_func(env));
>> =20
>> -		/* All non-void global functions return a 64-bit SCALAR_VALUE. */
>> +		/* All non-void global functions return a 64-bit SCALAR_VALUE or PTR_=
TO_ARENA. */
>>  		if (!subprog_returns_void(env, subprog)) {
>>  			mark_reg_unknown(env, caller->regs, BPF_REG_0);
>>  			caller->regs[BPF_REG_0].subreg_def =3D DEF_NOT_SUBREG;
>>  		}
>
> [Severity: High]
> Does this unconditionally mark the caller's R0 register as a SCALAR_VALUE=
?
>
> When returning from a global subprogram, mark_reg_unknown() clears the
> register state. If the subprogram actually returned an arena pointer,
> it seems the caller will receive an untracked scalar instead. Any attempt
> by the caller to dereference it would then fail verification.
>
> Should we inspect the subprogram's BTF return type here to dynamically
> set caller->regs[BPF_REG_0].type =3D PTR_TO_ARENA when appropriate?

I will change the comment back because it's actually inaccurate.
(Somewhat confusingly) we're returning arena pointers but not
PTR_TO_ARENA - the pointer returned is a SCALAR_VALUE. THe bytecode will
turn this into a PTR_TO_ARENA with an address space cast just fine.

>
>> @@ -16645,6 +16645,10 @@ static int check_global_subprog_return_code(str=
uct bpf_verifier_env *env)
>>  	if (err)
>>  		return err;
>> =20
>> +	/* Pointers to arena are safe to pass between subprograms. */
>> +	if (is_arena_reg(env, BPF_REG_0))
>> +		return 0;
>> +
>>  	if (is_pointer_value(env, BPF_REG_0)) {
>>  		verbose(env, "R%d leaks addr as return value\n", BPF_REG_0);
>>  		return -EACCES;
>
> [Severity: Medium]
> Does this bypass BTF type enforcement for the return value?
>
> By just checking if R0 is an arena register and returning 0, a global
> subprogram declared in BTF as returning an int could successfully return
> a PTR_TO_ARENA. Conversely, a subprogram declared as returning an arena
> pointer could successfully return a SCALAR_VALUE, since the fallback scal=
ar
> check later in the function would allow it.
>
> Should we verify that the actual register type matches the subprogram's
> BTF return type signature?

Same thing, fixing the comment should make this clear that this is a
non-concern.
