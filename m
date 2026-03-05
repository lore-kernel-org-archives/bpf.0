Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC312D9ECD
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739508; cv=none; b=M1MPehNRlWU2s6uTS/uNCGFlQG5DGHB3IfE64RPrb9i7NcKOHMP6+32ZdhxF16rEjR2YIS3/rhBeHO+YdmIY6+DSgJtVFYvisAdVH20x5DuwCuOFq+vYVzaJRBGj9ZEKKjsz8hJ0EVhA/1sTrlP4p2MAXl7YV6Uw4M5oAeVdJ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739508; c=relaxed/simple;
	bh=Zs/QaGdrJ60/R6Ch0eIfScImUh2lOAvF8HVnzjXQD5I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tdb1TM82hyTuKcNumFOiCxH545hKh9hOA5KlM/re6Mcb1r0DL3nJIwjRKk8963RsXa/N/EczW08WweMDNQ+523JSbr20PN8w2cucEupSVg+otErGcVDr8XpeIh0tCQ0BxCL+WFdB4Y7/1saAD1jW1UfMW+NEReWOMsBPdedZ8S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=dJKPxQTO; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="dJKPxQTO"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-899a5db525cso77639496d6.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 11:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772739505; x=1773344305; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pod+0E0gkwYrYyhup05R55/ZkQgDLVH9s7dpvrDWznY=;
        b=dJKPxQTOyw6qJZl2zzDOMIreBigomKEMlQyGOMMeRiFoZ2+gJFPgtuBACvqiy1A64Z
         BAB25gTUHjf+9bEUTBelJHKhnomXnl2/EUyeW/g9YwVZsBw8APtxAvyJvTu54gyxSErw
         Q6kvT8cXlUMyZgxdhBZ5ExPavA8aXot5dYGokF3iNu3UXl3q1mUoMxt7xsloKUcR5zLO
         SghFbYnksDmPxRKNkhZMUuGZ5fdtGYNGFWNscwEmFMcGXUTa9LaRe7MbidpONhsLBOp6
         Kiu5kmjLYdfj6tMG8f4foBXCXtAS+yLEaJsjcWzfy4EGax5oFV1COJVMG8yRS+xOCR8W
         GOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772739505; x=1773344305;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pod+0E0gkwYrYyhup05R55/ZkQgDLVH9s7dpvrDWznY=;
        b=U7LxU9ZYIj1Ik9so4zlcnoIKxzYNV8D0jwYgvvlqTvoMV/g5mRTg5K1bI+Mlz+eF3T
         3ShN/IrrAtMviCqaMRP4ATS3XTOf6yiZedRorCzEaYp3ZoqFo1LqSSTUJRQVzFYjtRMA
         JBJ3N5QanDtWVEXpTQFkYc7PRUfLojVgPZ3RIs2KNG3P1XTFqSdZGbNuY5TLRgabKWKd
         FDMfig0foidHDef+KxGhyVGVttUmNHN8NBo1MpJXy3lkLZA8C8yJpX90gp1DvL3Hbzy/
         VUGU6jisDGyKbhsjbvF8NcKJ8RlM8qcYOnZyJDiaIAaUvS7cS43CAlFgvin5Yu79Ilyy
         52Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWQdH0VeKorZa7qtFv3RekdhdA/mQi55zhikr50URi12viMeOO8+3jLvXS4DnUWa/EhlJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpTfNQ+xItv+qnGXTp/f8YtfuulKp9SX8iDjKMwUG5r9RL0yBG
	7SaREzzcZdYI8GgGZkEPm0tOGdwYP3YzTShso5BwxxPp/r3+lTUu2o9/TUNBulLWcy0=
X-Gm-Gg: ATEYQzzcPs8sPetnUA8bQ0wUwZS/WL89z6Zn3bMnRP4Tnx+dnDkFWeVWN6CFXiIh7on
	XTnEeC+y2JiZMKKof5nI2wmE41RUV7kEAIGRLQ9LRFYltSY2775YT93/cDpzgY0o1y9xhg7RsGG
	y2ZuKKC0u9sEo06FfL3Mx3rveHC1L6vL4y41yPbkfPYqdn400LTZahzXghrk7qJsfTNgBS24DhM
	65PR4r/iMGXFrCXWgEmZealU0HOYUIXyeQvug6pSjgEyjJtAuuASmqUOgjdlwjFFNirHCXrS4uy
	7yulqWdu7dHaAUnjO18hpTK72xWXp71mLcWwvASjqA+zPXhUZ79Zga8g9G1ypmr1jPgLPAEAuLt
	Tf+5F6HDfFHUj2eQVZhNL3h6KgDhCSMJa9w0ImINIlcaatwd2ZvnYezRUjHhirJkIZTZDJMHL6j
	c8Dr0E9/TiRB81db/h5avWwUY=
X-Received: by 2002:a05:6214:21ce:b0:89a:38b:dff0 with SMTP id 6a1803df08f44-89a2df296f9mr17459336d6.11.1772739505145;
        Thu, 05 Mar 2026 11:38:25 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a09ffa5e1sm70487956d6.21.2026.03.05.11.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 11:38:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 14:38:23 -0500
Message-Id: <DGV3PH3KCD9F.T400P92JF2T5@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <martin.lau@kernel.org>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Only enforce 8 frame call stack
 limit for all-static stacks
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260303043106.406099-1-emil@etsalapatis.com>
 <20260303043106.406099-2-emil@etsalapatis.com>
 <592a6eacf7c278137e49acb62f527e07a6c0b473.camel@gmail.com>
In-Reply-To: <592a6eacf7c278137e49acb62f527e07a6c0b473.camel@gmail.com>

On Tue Mar 3, 2026 at 8:01 PM EST, Eduard Zingerman wrote:
> On Mon, 2026-03-02 at 23:31 -0500, Emil Tsalapatis wrote:
>> The BPF verifier currently enforces a call stack depth of 8 frames,
>> regardless of the actual stack space consumption of those frames. The
>> limit is necessary for static call stacks, because the bookkeeping data
>> structures used by the verifier when stepping into static functions
>> during verification only support 8 stack frames. However, this
>> limitation only matters for static stack frames: Global subprogs are
>> verified by themselves and do not require limiting the call depth.
>>=20
>> Relax this limitation to only apply to static stack frames. Verification
>> now only fails when there is a sequence of 8 calls to non-global
>> subprogs. Calling into a global subprog resets the counter. This allows
>> deeper call stacks, provided all frames still fit in the stack.
>>=20
>> The change does not increase the maximum size of the call stack, only
>> the maximum number of frames we can place in it.
>>=20
>> Also change the progs/test_global_func3.c selftest to use static
>> functions, since with the new patch it would otherwise unexpectedly
>> pass verification.
>>=20
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  include/linux/bpf_verifier.h                  |  6 +++
>>  kernel/bpf/verifier.c                         | 43 ++++++++++++-------
>>  .../selftests/bpf/progs/test_global_func3.c   | 18 ++++----
>>  3 files changed, 42 insertions(+), 25 deletions(-)
>>=20
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index c1e30096ea7b..39a54e631bcd 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -650,6 +650,8 @@ enum priv_stack_mode {
>>  	PRIV_STACK_ADAPTIVE,
>>  };
>> =20
>> +struct bpf_subprog_info;
>> +
>>  struct bpf_subprog_info {
>>  	/* 'start' has to be the first field otherwise find_subprog() won't wo=
rk */
>>  	u32 start; /* insn idx of function entry point */
>> @@ -677,6 +679,10 @@ struct bpf_subprog_info {
>> =20
>>  	enum priv_stack_mode priv_stack_mode;
>>  	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
>> +
>
> Nit: please add a comment here saying the below are temporary values
>      used in check_max_stack_depth_subprog() (tbh, I'd move those to a
>      separate array in env but maybe that's an overkill).
>
>> +	int ret_insn;
>> +	int frame;
>> +	int cidx;
>
> Nit: please rename to `caller` and add a comment.
>
>>  };

Ack (and to all other nits).

>> =20
>>  struct bpf_verifier_env;
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 1153a828ce8d..d362ddd47d71 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -6652,9 +6652,11 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx,
>>  	struct bpf_insn *insn =3D env->prog->insnsi;
>>  	int depth =3D 0, frame =3D 0, i, subprog_end, subprog_depth;
>>  	bool tail_call_reachable =3D false;
>> -	int ret_insn[MAX_CALL_FRAMES];
>> -	int ret_prog[MAX_CALL_FRAMES];
>> -	int j;
>> +	int total;
>> +	int tmp;
>> +
>> +	/* no caller idx */
>> +	subprog[idx].cidx =3D -1;
>> =20
>>  	i =3D subprog[idx].start;
>>  	if (!priv_stack_supported)
>> @@ -6706,8 +6708,11 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx,
>>  	} else {
>>  		depth +=3D subprog_depth;
>>  		if (depth > MAX_BPF_STACK) {
>> +			for (total =3D 1; subprog[idx].cidx >=3D 0 ; total++)
>> +				idx =3D subprog[idx].cidx;
>> +
>>  			verbose(env, "combined stack size of %d calls is %d. Too large\n",
>> -				frame + 1, depth);
>> +				total, depth);
>>  			return -EACCES;
>>  		}
>>  	}
>> @@ -6723,8 +6728,8 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
>>  				continue;
>>  			if (subprog[idx].is_cb)
>>  				err =3D true;
>
> Below the old version of the loop does not include current frame, but
> the new version *does* include current frame. Looks like the above
> check can be removed.
>

Makes sense.

>> -			for (int c =3D 0; c < frame && !err; c++) {
>> -				if (subprog[ret_prog[c]].is_cb) {
>> +			for (tmp =3D idx; tmp >=3D 0 && !err; tmp =3D subprog[tmp].cidx) {
>> +				if (subprog[tmp].is_cb) {
>>  					err =3D true;
>>  					break;
>>  				}
>
> This code checks that bpf_throw() cannot be called from callbacks.
> The `is_cb` is set in push_callback_call() both for sync and async
> callbacks, it is also set for exception callback separately.
> Meaning that check_return_code() can be simplified further.
>

Do you mean we can simplify the check for choosing between
check_return_code and check_global_subprog_return_code to just check
is_cb instead of checking both is_async_cb and is_exception_cb?

>> @@ -6740,8 +6745,9 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
>>  		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
>>  			continue;
>>  		/* remember insn and function to return to */
>> -		ret_insn[frame] =3D i + 1;
>> -		ret_prog[frame] =3D idx;
>> +
>> +		subprog[idx].frame =3D frame;
>> +		subprog[idx].ret_insn =3D i + 1;
>
> Nit: move this down to `subprog[sidx].cidx =3D idx;`, so that the whole
>      "frame" setup is done in one place?
>
>> =20
>>  		/* find the callee */
>>  		next_insn =3D i + insn[i].imm + 1;
>> @@ -6762,6 +6768,9 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
>>  			}
>>  		}
>>  		i =3D next_insn;
>> +
>> +		/* caller idx */
>> +		subprog[sidx].cidx =3D idx;
>>  		idx =3D sidx;
>>  		if (!priv_stack_supported)
>>  			subprog[idx].priv_stack_mode =3D NO_PRIV_STACK;
>> @@ -6769,7 +6778,7 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
>>  		if (subprog[idx].has_tail_call)
>>  			tail_call_reachable =3D true;
>> =20
>> -		frame++;
>> +		frame =3D subprog_is_global(env, idx) ? 0 : frame + 1;
>>  		if (frame >=3D MAX_CALL_FRAMES) {
>>  			verbose(env, "the call stack of %d frames is too deep !\n",
>>  				frame);
>> @@ -6783,12 +6792,12 @@ static int check_max_stack_depth_subprog(struct =
bpf_verifier_env *env, int idx,
>>  	 * tail call counter throughout bpf2bpf calls combined with tailcalls
>>  	 */
>>  	if (tail_call_reachable)
>
> Unrelated to current patch, but looks like an issue.
> `tail_call_reachable` is not reset anywhere in
> check_max_stack_depth_subprog(). Once it flips to true all calls
> visited afterwards trigger spine to be marked.
>

You're right, this is never unset. I can send a followup patchset for
this along with the followups for the check_return_code patch. I believe
we can change this to eagerly set the subprog's tail_call_reachable flag
directly instead of using a stack variable.=20

>> -		for (j =3D 0; j < frame; j++) {
>> -			if (subprog[ret_prog[j]].is_exception_cb) {
>> +		for (tmp =3D idx; tmp >=3D 0; tmp =3D subprog[tmp].cidx) {
>> +			if (subprog[tmp].is_exception_cb) {
>
> As with previous such loop, the new code seem to include current frame.
> Does this change anything?
>

I think it is ok, though since as you pointed out tail_call_reachable doesn=
't=20
currently seem to work correctly I can only assume: We set tail_call_reacha=
ble=20
if any of the subprogs called by the current one make a tail call. If
that's the case, the current frame should also count as tail_call_reachable=
.

It all depends on where tail_call_reachable is supposed to be set and unset=
. I=20
think it's supposed to flow from callee to caller, and if that's the
case we should hoist up the whole loop to where we initially set the
stack variable.

>>  				verbose(env, "cannot tail call within exception cb\n");
>>  				return -EINVAL;
>>  			}
>> -			subprog[ret_prog[j]].tail_call_reachable =3D true;
>> +			subprog[tmp].tail_call_reachable =3D true;
>>  		}
>>  	if (subprog[0].tail_call_reachable)
>>  		env->prog->aux->tail_call_reachable =3D true;
>> @@ -6796,13 +6805,15 @@ static int check_max_stack_depth_subprog(struct =
bpf_verifier_env *env, int idx,
>>  	/* end of for() loop means the last insn of the 'subprog'
>>  	 * was reached. Doesn't matter whether it was JA or EXIT
>>  	 */
>> -	if (frame =3D=3D 0)
>> +	if (frame =3D=3D 0 && subprog[idx].cidx < 0)
>>  		return 0;
>>  	if (subprog[idx].priv_stack_mode !=3D PRIV_STACK_ADAPTIVE)
>>  		depth -=3D round_up_stack_depth(env, subprog[idx].stack_depth);
>> -	frame--;
>> -	i =3D ret_insn[frame];
>> -	idx =3D ret_prog[frame];
>> +
>> +	idx =3D subprog[idx].cidx;
>> +	frame =3D subprog[idx].frame;
>> +	i =3D subprog[idx].ret_insn;
>> +
>>  	goto continue_func;
>>  }
>> =20
>
> [...]

