Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BFD3D5242
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732212; cv=none; b=QKDqkYbzZmu9xlqCuMZCptLVHyGrRo3vr18ubBYb2tCAd6vnSSNHuBiXPlMDLxtgOlPdjpMN/Usgi5TM5cCKC7PBMsiuEe0nu8en83lTCTF2G1+drK5V21HsI99txJiysxg2LpYMTtnC2W+zMCcp9Stt7V5jQvXcUwx9564jWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732212; c=relaxed/simple;
	bh=9jV3ji+Q/25x+fWra3Np9XUYJ5Du0z9BjGsZhAbjXXY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jwcp8HZTT1TGR6x5uxzXUDZ/9h/PD2qCBMAWRhv6RHcM6e82CjrczHtgWvFjo7z960aOjJC5BOvLuWScWjReP9qPUIh8+L8PECdpSFJlUeii2xM2eCHGh6ViFLCog2j0eq+uo4RCl4eTmff1qoSGP32Ul/nPBdFK4QJda6kItEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=RGN9pLFs; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="RGN9pLFs"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899ed41208fso95912316d6.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 09:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772732210; x=1773337010; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rXyq5dyBHeQFQaLWcbtNECj5dk/lorrVBQD6/NRV/Q=;
        b=RGN9pLFsQMyEz2ECT21JXxOJm133ai5MNYZZQI5DYK/tgdbOjL5gXyYuc2+UMtz/dx
         Bz2Tefz/NtYaGhRouJMYVSONiqrSXC4jL/bZtKy6xnG4fDOKjgYDArZl7NQg1wyBhgIB
         aLtFye+ETJSJm9DN1vOmF5ZfkaavPGg8zKi0CcJ8TdvqFIRKz4vNLbywm5idlzUHXWCn
         jZyxLVMX72PUxoljhLOoC7WhtJQH8xsB3fokRVm3h+6KcnetXfA7V/lJ9BDfTkt9ltw9
         oB9cuHr1l2mJBDxRSCkb1Byv/6ewRk1+Baj4oJIm893IJWpNAtCERnDQaidIPb3j+yrj
         SDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772732210; x=1773337010;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1rXyq5dyBHeQFQaLWcbtNECj5dk/lorrVBQD6/NRV/Q=;
        b=pxMbESwLcLqOYMHcMVdBMRRHatMPhkxQre/krQkvXojA+JG4wY1dHvgzxv/vdbsaVv
         3nTZp9es644oCEG7EkBV/Vd7SzI2/qZBP4/0xYd+nhxhtdDlR6WSsiQ1GgjlS9FW4lMp
         IvngdbbiRBR4a2LYFOn75aAuPNc6LDSiw6QA1EQSPlNH3vkDqWymm3DQq7aYX1L/On6d
         W8rT6yqPsXeVjy4f/Zt8X8+V//jtq+fu7G9reV6s92fRsEsWxZybm0u5QFBlpuwbnIkR
         /+szvTb8BPEL+XE6R778MMg0a/SCi8HgReSYb7CqGvjyPJ34MkbsIirRM9uoE6/2Zlvs
         YdBA==
X-Forwarded-Encrypted: i=1; AJvYcCUNKITmyUK6I2HhVfqZ3dXnoNpY6f+AIVD18TOfnio2/0BxK6ldjwdVDzRaSgKHi7zEMbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8H/il8sVyTUAdAKnOqsuCO0BycgS8Hn4dYQvyX5seVbe69ZrO
	cu1+Xe5lY7jgxesAWFbHpd2UQ+34II4y+xdw5HwB9L6lhu+FILa0nywIS1wSXrCtR58=
X-Gm-Gg: ATEYQzzVfggW97QBDPD984NufafKPQKE+TW0940rvQgAY7HleMrNnSsO/3Eb3Lpt8OP
	iogx0H0on3sxW0A8PVqI1fqyL3nfc85Wh3UvuAyQZc7M5rp7dojqF7T+EP8cZ6yI3OFRaLemxMI
	JBPLKpDZMeDEn6GbofE64bW+b2Thx7yJZH97cRfnKF/zCCw++3XYsq2ecwmtFbULqyhYaESV8cE
	2La4uOh1buWu0CCTMVuSbMgtTjFiNzM0owCj+y3LrhU5bfs5k2PpKaINkYQRpUE+ZwcwOJwnC3e
	m+hjnCnaquzm+3TO1VuM+Letn6fga9dUUHzHb4YGq/1XbQHRq4cG83Em/Jgbk4s/BUJuv+868Oj
	maCFIxHY6+1/raj1Kvkt9MsTfOPDZu8ELEt0ZbEIJypPh52vDxVaC5hxqZDITAfRCX8B639IlGj
	aRF1okWDJ0ebswmqjXEuBSteU=
X-Received: by 2002:a05:6214:400d:b0:899:f0b1:732a with SMTP id 6a1803df08f44-89a19d219dfmr93542096d6.31.1772732209660;
        Thu, 05 Mar 2026 09:36:49 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899ef69b089sm117292606d6.46.2026.03.05.09.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 09:36:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 12:36:48 -0500
Message-Id: <DGV14DQAZUSW.3PJEJA6VGR32L@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <martin.lau@kernel.org>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Only enforce 8 frame call stack
 limit for all-static stacks
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260303043106.406099-1-emil@etsalapatis.com>
 <20260303043106.406099-2-emil@etsalapatis.com> <87tsuvy1ug.fsf@gmail.com>
In-Reply-To: <87tsuvy1ug.fsf@gmail.com>

On Wed Mar 4, 2026 at 11:51 AM EST, Mykyta Yatsenko wrote:
> Emil Tsalapatis <emil@etsalapatis.com> writes:
>
>> The BPF verifier currently enforces a call stack depth of 8 frames,
>> regardless of the actual stack space consumption of those frames. The
>> limit is necessary for static call stacks, because the bookkeeping data
>> structures used by the verifier when stepping into static functions
>> during verification only support 8 stack frames. However, this
>> limitation only matters for static stack frames: Global subprogs are
>> verified by themselves and do not require limiting the call depth.
>>
>> Relax this limitation to only apply to static stack frames. Verification
>> now only fails when there is a sequence of 8 calls to non-global
>> subprogs. Calling into a global subprog resets the counter. This allows
>> deeper call stacks, provided all frames still fit in the stack.
>>
>> The change does not increase the maximum size of the call stack, only
>> the maximum number of frames we can place in it.
>>
>> Also change the progs/test_global_func3.c selftest to use static
>> functions, since with the new patch it would otherwise unexpectedly
>> pass verification.
>>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  include/linux/bpf_verifier.h                  |  6 +++
>>  kernel/bpf/verifier.c                         | 43 ++++++++++++-------
>>  .../selftests/bpf/progs/test_global_func3.c   | 18 ++++----
>>  3 files changed, 42 insertions(+), 25 deletions(-)
>>
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
>> +	int ret_insn;
>> +	int frame;
>> +	int cidx;
> nit: can you add comment that cidx means caller index, i saw it below
> and it clarifies this code a lot.
>>  };

Ack, I will add a comment on this.

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
> nit: I think the way this loop is implemented below is more readable:
> for (tmp =3D idx; tmp >=3D 0; tmp =3D subprog[tmp].cidx)
>     total++;
> it is confusing now, because for loop initializes and increments total,
> but tracks cidx for exit check.=20

Ack, I'll update it in the respin to be more like the others.

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
>> -			for (int c =3D 0; c < frame && !err; c++) {
>> -				if (subprog[ret_prog[c]].is_cb) {
>> +			for (tmp =3D idx; tmp >=3D 0 && !err; tmp =3D subprog[tmp].cidx) {
>> +				if (subprog[tmp].is_cb) {
>>  					err =3D true;
>>  					break;
>>  				}
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
>> -		for (j =3D 0; j < frame; j++) {
>> -			if (subprog[ret_prog[j]].is_exception_cb) {
>> +		for (tmp =3D idx; tmp >=3D 0; tmp =3D subprog[tmp].cidx) {
>> +			if (subprog[tmp].is_exception_cb) {
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
>> diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/too=
ls/testing/selftests/bpf/progs/test_global_func3.c
>> index 142b682d3c2f..974fd8c19561 100644
>> --- a/tools/testing/selftests/bpf/progs/test_global_func3.c
>> +++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
>> @@ -5,56 +5,56 @@
>>  #include <bpf/bpf_helpers.h>
>>  #include "bpf_misc.h"
>> =20
>> -__attribute__ ((noinline))
>> +static __attribute__ ((noinline))
>>  int f1(struct __sk_buff *skb)
>>  {
>>  	return skb->len;
>>  }
>> =20
>> -__attribute__ ((noinline))
>> +static __attribute__ ((noinline))
>>  int f2(int val, struct __sk_buff *skb)
>>  {
>>  	return f1(skb) + val;
>>  }
>> =20
>> -__attribute__ ((noinline))
>> +static __attribute__ ((noinline))
>>  int f3(int val, struct __sk_buff *skb, int var)
>>  {
>>  	return f2(var, skb) + val;
>>  }
>> =20
>> -__attribute__ ((noinline))
>> +static __attribute__ ((noinline))
>>  int f4(struct __sk_buff *skb)
>>  {
>>  	return f3(1, skb, 2);
>>  }
>> =20
>> -__attribute__ ((noinline))
>> +static __attribute__ ((noinline))
>>  int f5(struct __sk_buff *skb)
>>  {
>>  	return f4(skb);
>>  }
>> =20
>> -__attribute__ ((noinline))
>> +static __attribute__ ((noinline))
>>  int f6(struct __sk_buff *skb)
>>  {
>>  	return f5(skb);
>>  }
>> =20
>> -__attribute__ ((noinline))
>> +static __attribute__ ((noinline))
>>  int f7(struct __sk_buff *skb)
>>  {
>>  	return f6(skb);
>>  }
>> =20
>> -__attribute__ ((noinline))
>> +static __attribute__ ((noinline))
>>  int f8(struct __sk_buff *skb)
>>  {
>>  	return f7(skb);
>>  }
>> =20
>>  SEC("tc")
>> -__failure __msg("the call stack of 8 frames")
>> +__failure __msg("the call stack of 9 frames")
>>  int global_func3(struct __sk_buff *skb)
>>  {
>>  	return f8(skb);
>> --=20
>> 2.49.0

