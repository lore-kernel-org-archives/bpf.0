Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8E3C276F
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515516; cv=none; b=oBUEH/7A7u/Al/XGLEwmyeVaQE0VqXJphtTlmfLc6KWrfVDPkik3iIHzzJjB1PYae+mSeMH3AuxOILg/eG1TCMbgIy+sWMeAuHqmCbWh0X+5fBWG8ZeuwBGLb6/6Dx84nICxa13P9mS422WyNA8YF/peAV6Qv6D0S987/jefIQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515516; c=relaxed/simple;
	bh=4cyg4JNYYhfSLnZBdY7jGzhJYwGZ8LavjbeBJKCnm0Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iDK/q6oKpnodQHvR2K+AYep3eAq9dbQxY9YBjjQBKeQe1hLLMjIPLNt4oL5we6oNHTmtlx656WLEqRZreukwp7k+wtM0TbxYP4KTTXTIgHUdxuyC/L/FsdzcOPbzvp7jovJslgQMvm9yX4YG/1Zo44uXXx+hg1jkPh95m903iv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBixmeF/; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBixmeF/"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dcc9b506d9so3632905a34.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778515514; x=1779120314; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jebxWLF/JfLOb7mNlr8Jn51MLtCVkaFQGItG5KL18Ik=;
        b=OBixmeF/HdEKgOk2nUm5rPyaNORpOug6Mu/fv0OyPWnaidqaEgEnXxF259DShL23AT
         KFhCIobkPcWVHRDG7suCNwmO0dE8r/OQgKbs5HqFNPoMy+u1k1q68lgvc21LlcFpOEAJ
         mQ0vYvd5KFusMmZHo/bl9P1RDQrFddgzszTXQs6eT5Oa2XuQ8kR4xBXtDsxLDDkjl/Pp
         QxZg9yiMr4ifuSm1pTd9ZjDaCEJ2rstzZfD9C8Q8UjA4KA1TtlRPACbvxaZGx4H8Uzlw
         TspxtDrtt7QI82eRy/paQE68dsLyJ4EZ3uH8uuHXhBtUVpWgLdCq/sIyQSDUhSlcI96/
         cyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778515514; x=1779120314;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jebxWLF/JfLOb7mNlr8Jn51MLtCVkaFQGItG5KL18Ik=;
        b=VbvvhOZNZEs3fRNhTtVV+pc8toaHQjOT8r0DmVecwCkTWubYUlyobqFwhPp0JEz6HZ
         yjc8PCtW12/gmmIA7QiAHAejMWvJve7dcomo7ffk5+gEDbFgUYxYFkiXQyYVMOG/qO8H
         /+tIfSCd8C5l5YzJcANOBHNBAr87Z6vK/r/w8ZIGqyd7GDZq1fgkIbqQ5wIXfOsbg8MS
         GL5jloLgfQ/xillJYpn+Wnm8iT4nbTz1JYoaQBgKzAiPvpdnuyK5Bc+p176NtgLuDt44
         MmElcL4uP3uVgx/qx7p/0zcIeAp2ks4tyJxohyczgKfBZwDz6uQrwzLjvwIZ34TyngbT
         dm9A==
X-Forwarded-Encrypted: i=1; AFNElJ9Hk2o70+iCcSpyKw2OUyMo5ZVEPzapG75UfAAoSsuTEGWILaT2OcQoK5X6+9R8uGtU34M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK0tRFtvhJQgxklrLPczZx1zq1Pu+8HB2D12Rsve8KuG1R1NP6
	DBb8IYopX+Rd5IBew/IKXn4ajGZ9nfBwb7398ZQjhJ4JIcaONiqYKhcZ
X-Gm-Gg: Acq92OE8mWI7QkjNabTolSk2mZJ/YJIud1NxzrIbM2hpyaMtCggp/XmAdXmWCrJlf2u
	/TuK6eVFSy2++pKphpZiqgpa5VLbCJZND5YUlftPeqZ60Zh2fxfm3UDKKYxy5VJoSSgSyLqkfPZ
	x4KRA5UvyCENs0Xui5i3Tou9aXy4TrJTFGp1LfTrH2kCyuiLVTx6SmObJFMNnMClVmpcyn8uVQw
	Owpz174pC7EGNzVTLsNMU0vijO8fWsvu3FD0vH/XwCE11aMoe0lLX+1SHhlny2ApyzyKVhMOUsu
	QThZG/ULrfx7NjlH/7OeM+oOuP8jwd9lhLkI/t0rSYbkw2Ly8X2IEHMikibh3oNPVBArIxdqdWO
	gvw708wmNraHNUKfXPi4RZuWPw96sV+u3vyjQ5OAo8wqDACqWEP/nN9mQfqJYu24n8noma5kZkD
	YpK2VFmMJHRhcI3r5AmDxTvpqRCYeAjIMEHB8pVdzbDcsBVna2LkeQphyfD9z6DAQ7jaGj4lO7c
	rIkm0i5PVmto/Zdow==
X-Received: by 2002:a05:6830:3697:b0:7dc:d0e3:5bc1 with SMTP id 46e09a7af769-7e1df0f95f8mr15808859a34.13.1778515513668;
        Mon, 11 May 2026 09:05:13 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d90148sm7277608a34.20.2026.05.11.09.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 09:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 09:05:12 -0700
Message-Id: <DIFZ4QX7T164.30KVT7BJ584K7@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <jose.marchesi@oracle.com>, <kernel-team@fb.com>, <martin.lau@kernel.org>,
 <eddyz87@gmail.com>, <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 05/24] bpf: Support stack arguments for bpf
 functions
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bot+bpf-ci@kernel.org>,
 <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260511053327.1883871-1-yonghong.song@linux.dev>
 <1bb0dfc54cc2dbe6a38c21af2717f1b575ba60ba66a763952f38ada03a65bf85@mail.kernel.org> <1718e913-d51d-4e81-9106-c39c88e9e160@linux.dev>
In-Reply-To: <1718e913-d51d-4e81-9106-c39c88e9e160@linux.dev>

On Mon May 11, 2026 at 8:46 AM PDT, Yonghong Song wrote:
>
>
> On 5/11/26 8:19 AM, bot+bpf-ci@kernel.org wrote:
>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
>>> index 321b9d69cf9c..f9020a4ea005 100644
>>> --- a/include/linux/bpf_verifier.h
>>> +++ b/include/linux/bpf_verifier.h
>>> @@ -402,6 +402,7 @@ struct bpf_func_state {
>>>   	bool in_callback_fn;
>>>   	bool in_async_callback_fn;
>>>   	bool in_exception_callback_fn;
>>> +	bool no_stack_arg_load;
>> [ ... ]
>>
>>> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
>>> index bd9c22945050..c249eb40c6d6 100644
>>> --- a/kernel/bpf/states.c
>>> +++ b/kernel/bpf/states.c
>>> @@ -833,6 +833,32 @@ static bool stacksafe(struct bpf_verifier_env *env=
, struct bpf_func_state *old,
>>>   	return true;
>>>   }
>>>
>>> +/*
>>> + * Compare stack arg slots between old and current states.
>>> + * Outgoing stack args are path-local state and must agree for pruning=
.
>>> + */
>>> +static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_fu=
nc_state *old,
>>> +			   struct bpf_func_state *cur, struct bpf_idmap *idmap,
>>> +			   enum exact_level exact)
>>> +{
>>> +	int i, nslots;
>>> +
>>> +	nslots =3D max(old->out_stack_arg_cnt, cur->out_stack_arg_cnt);
>>> +	for (i =3D 0; i < nslots; i++) {
>>> +		struct bpf_reg_state *old_arg, *cur_arg;
>>> +		struct bpf_reg_state not_init =3D { .type =3D NOT_INIT };
>>> +
>>> +		old_arg =3D i < old->out_stack_arg_cnt ?
>>> +			  &old->stack_arg_regs[i] : &not_init;
>>> +		cur_arg =3D i < cur->out_stack_arg_cnt ?
>>> +			  &cur->stack_arg_regs[i] : &not_init;
>>> +		if (!regsafe(env, old_arg, cur_arg, idmap, exact))
>>> +			return false;
>>> +	}
>>> +
>>> +	return true;
>>> +}
>>> +
>>>   static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifi=
er_state *cur,
>>>   		    struct bpf_idmap *idmap)
>>>   {
>>> @@ -924,6 +950,9 @@ static bool func_states_equal(struct bpf_verifier_e=
nv *env, struct bpf_func_stat
>>>   	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
>>>   		return false;
>>>
>>> +	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
>>> +		return false;
>>> +
>>>   	return true;
>>>   }
>> In v2 (May 7), bot+bpf-ci@kernel.org raised a concern that
>> no_stack_arg_load is not compared during state pruning in
>> func_states_equal():
>>
>>      "The same issue applies to state pruning: func_states_equal/
>>      stack_arg_safe does not compare no_stack_arg_load either, so a
>>      state with no_stack_arg_load=3Dtrue can be pruned to an old state
>>      with no_stack_arg_load=3Dfalse incorrectly. Should no_stack_arg_loa=
d
>>      be placed before stack (to be memcpy'd) or should copy_stack_state(=
)
>>      explicitly assign it?"
>>
>> The field placement was fixed (moving no_stack_arg_load before 'stack'
>> so it gets copied by memcpy), but func_states_equal() still does not
>> explicitly compare this field.
>>
>> Could this allow incorrect pruning? If a BPF program writes to stack
>> args and calls a function on one path (setting no_stack_arg_load=3Dtrue)=
,
>> then branches and tries to read from stack args on another path, the
>> verifier might incorrectly prune to the old state with
>> no_stack_arg_load=3Dfalse, missing the enforcement that stack arg reads
>> must happen before writes/calls.
>>
>> Looking at func_states_equal():
>>
>> kernel/bpf/states.c:func_states_equal() {
>>      if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
>>          return false;
>>
>>      if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
>>          return false;
>>
>>      return true;
>> }
>>
>> Should no_stack_arg_load be compared here, similar to how other boolean
>> flags in bpf_func_state are handled during state comparison?
>
> You are right. The following is an example:
>
>    /* subprog with incoming stack arg */
>    r1 =3D *(r11+8);         /* read incoming arg, no_stack_arg_load =3D f=
alse */
>                                                                          =
                                          =20
>    if cond goto path2;
>                                                                          =
                                          =20
>    path1:
>      call some_helper;    /* sets no_stack_arg_load =3D true */
>      goto join;
>                                                                          =
                                          =20
>    path2:
>      /* no call, no_stack_arg_load =3D false */
>      goto join;
>                                                                          =
                                          =20
>    join:
>      r2 =3D *(r11+8);       /* read incoming arg again */
>
> In the above case, at 'join' point, we have no_stack_arg_load =3D true an=
d false
> respectively. In this case, we cannot do pruning.
>
> Will fix.

Hold on. Didn't we agree that any call should scratch all arg slots?
In the above example call some_helper will scratch it and last read shouldn=
't be allowed.
