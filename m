Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6CD33DEF7
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 06:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788588788; cv=none; b=SugPFfBfu/GPMpCO4tajYfA29gmZmYaVQWgmfUXzpbtgLJcL2MazWUbYuJpKuXflzJLqLXuf36Z9PvsZvbsfHNHulIpwetxD95IYlPMRoYB5oUbvMIbc/U6FLOyv0L7K0UIkKzN6dgP13DaeDlryTAHbDT2zGjlKYY6UeiT94wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788588788; c=relaxed/simple;
	bh=/nUOsB0/0xAU7lnfKbndKpHkg4KadqDnVMpBax1l4BM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Guoi96KF3wsL+GgyZe3vLJfRE4bpDh1G965el19doTdQ4Iskc1pDvaNu+MYsFVbuxwQo0YL+xWAFh/lPrwzbjcjRzzzvOfdr6dyCNL0PDNNrIu9f6XNnrVDBUEKNMbSmQep2zzMoHQOxejZvDG+oDXqejXhJCyP48ilrziDbU/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPjVIii2; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPjVIii2"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-49cd3d0f150so7609315e9.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 23:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788588784; x=1789193584; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ML4tQwaga7x6hatyElf9ZkS7gcNBjlOJuWIIW8nuelk=;
        b=BPjVIii2zQW8/VnJUWIyiZpiy3/C7eXbjr8QwnlIHxjcS2LzKi1mAohFvTX+PlDtF7
         uzEgFA7WZ0ELXXcZkjszH+D3BiL8hTKUxO/7o8rtHD+eHtH3ciXFKZkRDC2B16lnzk2R
         h8MymeoeHURUYOK6zWvWpYCSskKSsEpUjH8NWTWdFGWC2QNBKSq4JwRMAN6+aR2N8KEx
         AvayUsllxmtgYzkYkhMYwWGpVJCz+dkqpb96ppI8QsUSjRBilbBtaY98kLYpG/gY3TyU
         rpRRFmRmU5cm9QAMaf6Y+JsrMDtx1LWd0cWHBPqNyZU5ip43mlSvAMJt6IyZuWgnXY8f
         rVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788588784; x=1789193584;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ML4tQwaga7x6hatyElf9ZkS7gcNBjlOJuWIIW8nuelk=;
        b=svUa9s2Y1t6R3bW3g4852XaLolgP0Y5NYOIUewn7y8DGOXyuAdMWRmk18etpADkHPd
         L2fHpGvACewXV9KnSoV/YZag2vW5JFm4e7yc3tK0WsBDuuJF9T5I1qn7SMpXKaQL7qw+
         r9aIn2khSuoOy7DcEFoUfNJFrmduKxV5SLf8JOM9PLkXkK3n/DIfjGG/ZwFJBpyT/PZ+
         1VV5Qo2eZFEF9Q0tVc/VIqZHuHqN61zEbX8mfd7PuDxVAY2ji3Mx14S9B/W95RBymKAp
         kEubLfVYM0zYGh3rP06hwxM5dmit7zh7/+6IO2ASwSK1psAd4V8y1yrJERgAG6AOgWMl
         kP7A==
X-Forwarded-Encrypted: i=1; AKwUvBz8d5pUglUtmM8kxxodBFTxl6fni7zJ45nELIr4eRO58YhOSyDx0QkGHkJjKAuwVG2iZsQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kDuD0MLHqZvxfZhR8Y5ilFTvU3uNWTn1RAHX7P1k+QGhIRfo9r
	h4sy+bMHyW11Me0rboZRAsed15cf8fA+WOigJtmeYyvc9mw2Xl3WpFSD
X-Gm-Gg: AYBFou3tTTZR5BIjdKVZEn31H3bdVwfO1O/7V5WWDqeYYqxP71UI11pMtaz0uYvgj9W
	SqPkcywoGnCscMC5+7V3k7+drdQtmamsoCmaFEubVCbiaV945nAFJSrYUSSCDW8jQSo5Tx5FsmR
	ir7mRTIFbXsQKQEHxt18TsYFFzvTSrJkItdrA3rz6lkxJBZgj6Nqdi2UnMu1HTkB2m466nxOy7O
	EgP/3JXY55X+oNnrFleLBM9JR1E6i0s6cXk9WkRVHSmchw26dnLwpbwLIAh84HVUfNB93jWuap8
	3Na0MrAp3gngmM+kHoQng3D4k52fIr7d2NXbtU5C/MjbYn3J/PbkmUeOZkrSQjaNz+pLK4mZLWr
	c9pd7BUFwzY7EggvRL89DB17lwyW17r9bot1f+K+SOLNvl5YKDFSv/tE5gkk8RMJq35+i/5tK6f
	0kgaRh2qm07VLOUdiYxRWC67tNNn6EZyWDeJRbnwrvEbPfpR3rPh/k6ZfZKrCOTi3MmAPSXbnM/
	y7tF4+ebupmCrUt21ad0dn0Od70qROgxe3bA+u11qqHjbQI9F0fwWhbS2ERTnUYoxUNSGvN+wKA
	RMDvE+fbchd+R468h4hi8U/+Ow/sLCBblLgvKw==
X-Received: by 2002:a05:600c:4693:b0:49d:39:90ba with SMTP id 5b1f17b1804b1-49d00399d19mr37052335e9.3.1788588784172;
        Fri, 04 Sep 2026 23:13:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d476esm228433385e9.1.2026.09.04.23.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 23:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Sep 2026 08:13:03 +0200
Message-Id: <DL75T3P90YMY.2I43E35KEI5HN@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Verify global subprogs in each
 sleepability context
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <npc@anthropic.com>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.21.0
References: <20260905051224.2325381-2-memxor@gmail.com>
 <652367e7a2ca75e71c0b7c2cadc8b760551008853bbe831dd596f65cb993e285@mail.kernel.org>
In-Reply-To: <652367e7a2ca75e71c0b7c2cadc8b760551008853bbe831dd596f65cb993e285@mail.kernel.org>

On Sat Sep 5, 2026 at 8:05 AM CEST, bot+bpf-ci wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 3a7eb2185c35..66d04244c737 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1650,8 +1650,9 @@ static inline void bpf_trampoline_set_flags(struct=
 bpf_trampoline *tr, u32 flags
>>  struct bpf_func_info_aux {
>>  	u16 linkage;
>>  	bool unreliable;
>> -	bool called : 1;
>> -	bool verified : 1;
>> +	/* Indexed by in_sleepable. */
>> +	bool called[2];
>> +	bool verified[2];
>>  };
>
> [ ... ]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 5b51e7ee1a3f..f759a020c8a5 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -9957,6 +9957,7 @@ static int check_func_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
>>  	if (err =3D=3D -EFAULT)
>>  		return err;
>>  	if (bpf_subprog_is_global(env, subprog)) {
>> +		struct bpf_func_info_aux *sub_aux =3D subprog_aux(env, subprog);
>>  		const char *sub_name =3D bpf_subprog_name(env, subprog);
>>  		const char *operation;
>>  		bool returns_void;
>> @@ -9988,11 +9989,10 @@ static int check_func_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>>  		if (env->log.level & BPF_LOG_LEVEL)
>>  			verbose(env, "Func#%d ('%s') is global and assumed valid.\n",
>>  				subprog, sub_name);
>> +		sub_aux->called[in_sleepable_context(env)] =3D true;
>>  		returns_void =3D subprog_returns_void(env, subprog);
>>  		if (env->subprog_info[subprog].changes_pkt_data)
>>  			clear_all_pkt_pointers(env);
>> -		/* mark global subprog for verifying after main prog */
>> -		subprog_aux(env, subprog)->called =3D true;
>>  		if (returns_void)
>>  			bpf_diag_record_scrub(env, &caller->regs[BPF_REG_0], BPF_DIAG_MOD_CA=
LLER_SAVED);
>>  		else
>
> [ ... ]
>
>> @@ -19560,13 +19565,14 @@ static void free_states(struct bpf_verifier_en=
v *env)
>>  	}
>>  }
>>
>> -static int do_check_common(struct bpf_verifier_env *env, int subprog)
>> +static int do_check_common(struct bpf_verifier_env *env, int subprog, b=
ool in_sleepable)
>>  {
>>  	bool pop_log =3D !(env->log.level & BPF_LOG_LEVEL2);
>>  	struct bpf_subprog_info *sub =3D subprog_info(env, subprog);
>>  	struct bpf_prog_aux *aux =3D env->prog->aux;
>>  	struct bpf_verifier_state *state;
>>  	struct bpf_reg_state *regs;
>> +	u32 old_insns_total =3D sub->insns_total;
>>  	u32 insn_processed =3D env->insn_processed;
>>  	int ret, i;
>>
>> @@ -19579,7 +19585,7 @@ static int do_check_common(struct bpf_verifier_e=
nv *env, int subprog)
>>  	state->curframe =3D 0;
>>  	state->speculative =3D false;
>>  	state->branches =3D 1;
>> -	state->in_sleepable =3D env->prog->sleepable;
>> +	state->in_sleepable =3D in_sleepable;
>>  	state->frame[0] =3D kzalloc_obj(struct bpf_func_state, GFP_KERNEL_ACCO=
UNT);
>>  	if (!state->frame[0]) {
>>  		kfree(state);
>
> Can this change break check_css_task_iter_allowlist()?
>
> That function currently uses in_sleepable(env) to decide whether to allow
> bpf_iter_css_task_new(), per its comment:
>
>   "Any sleepable progs are also safe since bpf_check_attach_target() enfo=
rce
>    them can only be attached to some specific hook points."
>
> Before this patch, do_check_common() always set state->in_sleepable =3D
> env->prog->sleepable, so in_sleepable(env) matched the program-level
> sleepability even for global subprogs. After this patch, when a global
> subprog is called from inside bpf_rcu_read_lock() or a similar protected
> region in a sleepable program, in_sleepable_context(env) is false in
> check_func_call(), so the global subprog is verified with in_sleepable =
=3D=3D
> false.
>
> If that global subprog then calls bpf_iter_css_task_new(),
> check_css_task_iter_allowlist() sees in_sleepable(env) =3D=3D false and r=
ejects
> it with "css_task_iter is only allowed in bpf_lsm, bpf_iter and sleepable
> progs", even though:
>
> 1. The iterator itself never sleeps (it is marked only KF_ITER_NEW, not
>    KF_SLEEPABLE, so it only takes spin_lock_irq(&css_set_lock));
>
> 2. The allowlist check is meant to prove the attach point does not alread=
y
>    hold css_set_lock, which is a property of the program's attach type, n=
ot
>    of the current RCU/preempt nesting;
>
> 3. The identical call written directly in the main program under the same
>    bpf_rcu_read_lock() is still accepted, because there in_sleepable rema=
ins
>    true. Only the version factored into a global subprog is newly rejecte=
d.
>
> Should check_css_task_iter_allowlist() consult env->prog->sleepable direc=
tly
> instead of in_sleepable(env), so that normalizing a protected sleepable c=
aller
> to in_sleepable=3Dfalse at the global-subprog root does not affect allowl=
ist
> decisions?

No, it should not, the behavior in the patch is correct for this case.

>
>> @@ -19721,7 +19727,8 @@ static int do_check_common(struct bpf_verifier_e=
nv *env, int subprog)
>>  	 * Accumulate their total counts as total counts of the main or
>>  	 * global subprog hosting the async call.
>>  	 */
>> -	env->subprog_info[subprog].insns_total =3D env->insn_processed - insn_=
processed;
>> +	env->subprog_info[subprog].insns_total =3D old_insns_total +
>> +						(env->insn_processed - insn_processed);
>>  	return ret;
>>  }
>
> [ ... ]
>
>> @@ -19749,45 +19756,55 @@ static int do_check_subprogs(struct bpf_verifi=
er_env *env)
>>  {
>>  	struct bpf_prog_aux *aux =3D env->prog->aux;
>>  	struct bpf_func_info_aux *sub_aux;
>> -	int i, ret, new_cnt;
>> +	int context, i, j, ret, new_cnt;
>>
>>  	if (!aux->func_info)
>>  		return 0;
>>
>>  	/* exception callback is presumed to be always called */
>> -	if (env->exception_callback_subprog)
>> -		subprog_aux(env, env->exception_callback_subprog)->called =3D true;
>> +	if (env->exception_callback_subprog) {
>> +		sub_aux =3D subprog_aux(env, env->exception_callback_subprog);
>> +		sub_aux->called[env->prog->sleepable] =3D true;
>> +	}
>>
>>  again:
>>  	new_cnt =3D 0;
>> -	for (i =3D 1; i < env->subprog_cnt; i++) {
>> +	/*
>> +	 * Walk callers before callees so each global subprog normally sees al=
l
>> +	 * of its contexts before it is verified. Async callback cycles can ad=
d a
>> +	 * context to an earlier subprog, so repeat until every called context=
 is
>> +	 * verified.
>> +	 */
>> +	for (j =3D env->subprog_cnt - 1; j >=3D 0; j--) {
>> +		i =3D env->subprog_topo_order[j];
>> +		if (!i)
>> +			continue;
>>  		if (!bpf_subprog_is_global(env, i))
>>  			continue;
>>
>>  		sub_aux =3D subprog_aux(env, i);
>> -		if (!sub_aux->called || sub_aux->verified)
>> -			continue;
>> +		for (context =3D 0; context < ARRAY_SIZE(sub_aux->called); context++)=
 {
>> +			if (!sub_aux->called[context] || sub_aux->verified[context])
>> +				continue;
>>
>> -		env->insn_idx =3D env->subprog_info[i].start;
>> -		WARN_ON_ONCE(env->insn_idx =3D=3D 0);
>> -		ret =3D do_check_common(env, i);
>> -		if (ret) {
>> -			return ret;
>> -		} else if (env->log.level & BPF_LOG_LEVEL) {
>> -			verbose(env, "Func#%d ('%s') is safe for any args that match its pro=
totype\n",
>> -				i, bpf_subprog_name(env, i));
>> -		}
>> +			env->insn_idx =3D env->subprog_info[i].start;
>> +			WARN_ON_ONCE(env->insn_idx =3D=3D 0);
>> +			ret =3D do_check_common(env, i, context);
>> +			if (ret)
>> +				return ret;
>> +			if (env->log.level & BPF_LOG_LEVEL)
>> +				verbose(env, "Func#%d ('%s') is safe for any args "
>> +					"that match its prototype\n",
>> +					i, bpf_subprog_name(env, i));
>>
>> -		/* We verified new global subprog, it might have called some
>> -		 * more global subprogs that we haven't verified yet, so we
>> -		 * need to do another pass over subprogs to verify those.
>> -		 */
>> -		sub_aux->verified =3D true;
>> -		new_cnt++;
>> +			sub_aux->verified[context] =3D true;
>> +			new_cnt++;
>> +		}
>>  	}
>>
>> -	/* We can't loop forever as we verify at least one global subprog on
>> -	 * each pass.
>> +	/*
>> +	 * We can't loop forever as each pass verifies at least one new contex=
t,
>> +	 * and there are only two contexts per global subprog.
>>  	 */
>>  	if (new_cnt)
>>  		goto again;
>> @@ -19800,7 +19817,7 @@ static int do_check_main(struct bpf_verifier_env=
 *env)
>>  	int ret;
>>
>>  	env->insn_idx =3D 0;
>> -	ret =3D do_check_common(env, 0);
>> +	ret =3D do_check_common(env, 0, env->prog->sleepable);
>>  	if (!ret)
>>  		env->prog->aux->stack_depth =3D env->subprog_info[0].stack_depth;
>>  	return ret;
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/339471=
89666

