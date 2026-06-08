Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA203B895A
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944788; cv=none; b=Ivc0STR3Wbd9+gcU03INAjA3lB0d1/sCx4YAKRqN1wjkrcEzEwXJHhyGE9KLebJm/Wq+OEgE7gVAcLSvpG1h8WiiGID/A5tgs+yjO0RT3fFYoLBqaK90uvVuaEpklshH8dCtgvg3U9860upwOL9stP+mjBT2Qe/8CxuHKr2MBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944788; c=relaxed/simple;
	bh=W9PI1u9yJTruTbvdLjeBDRVDVUltbCBzKLoKv1zDOBQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IizSuSTroVtCUaVr9sENgxWQUkT5D+DN7Dos3VTyqTO1wQHRE3a+gPrda+B+bJwatnmpjiY9Yp6VX0Iv48nMpqosl9iPdDCvdshXMpq+X/HurQOfORHEkl3PpfjTerrAAlUKWERYmoDHXaJW4SWrq/UnQpRxsiXy0pKXsgC9bWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sVoKe/us; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVoKe/us"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so3473312f8f.0
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 11:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780944785; x=1781549585; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWCjmKIPfQK3YtgJDfNiX14r+khrP/F/aDQvVcFRnms=;
        b=sVoKe/usuAMSSKbwdFWL9KPY22pohznMnDbgFeqaFBiSxwO814kxFxeHRjYFlE92Gb
         qh0lGbbkjJHO3B3vm8NibXnYNkrTPACf7XdTXBY23ZNr/U4ZFZuIpAygRGrw2qZxXu0Y
         BnMysSiwjOCcSOtN+tbt5KxfZRtRxFQAmsbKRqqWLXtzDRfDQLaGToFejjwgrFk2pZDq
         0jtoQ8G5/KsEzCKtIXcWdYXCKboRFWk/u/a1J81REVFGx4h0Z1vFTJsWX2nT7TITMXvk
         a5WYkrpgppEQ0huXQzcDLa4Y/nS/USYN8QPwc74mOEBlE7aiq+fEk+7R5MjRnbqqDkTs
         9Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780944785; x=1781549585;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yWCjmKIPfQK3YtgJDfNiX14r+khrP/F/aDQvVcFRnms=;
        b=GUWxTd6PFfCXj/TrMF9W4pK1cgcQ5SdchwU6NBfS+6sHKL9vFiEyMjIQDi+euj/Ez4
         bWNYy43loNpJLZLzMv+9A43MUlpCLcflffK/xynJ+YuluNQVg6qhCNYr5hiOgbL2lVQy
         Z4o4+g/IOvn9fbyF3aeCxhCT42LW9omqNyVLvnnrXVeHLh+g0QNT+XoXMYg5n5+Lnpzg
         vVgIDzRi+AtnQvYaDM4iaqN8cHT2K76KgPNIj2qIcOD98Z3FCu5pyRJesWMRJJLgqPpT
         O/k5ouuOBzA/Af+VCJgqBVLfXblwThSUMHgvoTsrvIbURDA/cvCTA+Pe9Yqbi0OWOc5/
         0lBw==
X-Gm-Message-State: AOJu0Yx6tL5CBSdIymPyCWF1z8dHe5/U+B2WqHDC4epyMDFQhasvT5X8
	2PvTN5+lvZmCOINcn7pG6pKjS8LlvQ7DrCKyoS0k2Gz0eNwgzEw+Eyj+
X-Gm-Gg: Acq92OHaBtxrGexrwSAVH2+5Fv8oWk4nyyW4E/X7/NTnA7AxrfWBo64VskvNOA3A/Nf
	B1zhCs7ejzjbA4m1R0eGCvmGejl03QecDkHbXRSWH6xZ07c45YBOORRqPG6frG5x+mOV3xaweYN
	KkqqyoHtup9pzKzvxV+Q7U1QpR2LpjYAmvz77WtX7gzo7O0JWMVi23Xbg12gxqgEMGt3B1Km2Tv
	FaeltkgVUWj7pXAAP81RS8qcGM2iyvjTNNoYkhIThcbZfBHwJy63uDIHaZ9X++hcHZrGAorJhZW
	aR/ChO2eCAUZnBl94FLrTyf8Jq6bhrEDmWx0CKqy2i/IqYyoThLdBE514f0mi/Yxe5q39xZdjLy
	AyPhz+UFkY/SZI/4bNRUX0z1JYMQknPUXqnajaEXN7MBV7YpUh7HnGqrhiuoXE/nMh9gLmnzFYu
	djRHMQhc0cGXnR+VZJ11i3I80vT7RgriM0pqKQty0ZAuB1f+8ZPrh2GARKwqMsgKuKOF4KPWqin
	o87P4w5PQ+2MvPsHNyTvM8tjR1tic4C1OVaLe8GzGFahTdePdeSOzMamG0Y3PM/IeXO4q/7AZLJ
X-Received: by 2002:adf:e684:0:b0:45e:e95c:8106 with SMTP id ffacd0b85a97d-460302e894fmr20050818f8f.13.1780944784817;
        Mon, 08 Jun 2026 11:53:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcde3sm56482125f8f.1.2026.06.08.11.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 11:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 20:53:03 +0200
Message-Id: <DJ3W8IZ08WBT.VTRTP72FSWVO@gmail.com>
Cc: <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 1/5] bpf: Treat non-iterator tracing progs
 as tracing
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Justin Suess" <utilityemal77@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260608144841.1732406-1-memxor@gmail.com>
 <20260608144841.1732406-2-memxor@gmail.com> <aibxqG77bragcPos@zenbox>
In-Reply-To: <aibxqG77bragcPos@zenbox>

On Mon Jun 8, 2026 at 7:47 PM CEST, Justin Suess wrote:
> On Mon, Jun 08, 2026 at 04:48:34PM +0200, Kumar Kartikeya Dwivedi wrote:
>> The is_tracing_prog_type() predicate omitted BPF_PROG_TYPE_TRACING even
>> though fentry, fexit, fmod_ret, raw_tp BTF and similar programs have the
>> same execution-context concerns as the tracing program types already
>> covered by the helper.
>>
>> This matters for map compatibility checks that reject bpf_spin_lock,
>> bpf_list_head and bpf_rb_root in tracing contexts. BPF_PROG_TYPE_TRACING
>> programs can run from arbitrary instrumented contexts, including places
>> where taking these locks or manipulating graph roots is not safe.
>> BPF_TRACE_ITER is different: iterator programs run from task context, so
>> we continue to exclude them.
>>
>> This can reject existing fentry/fexit-style programs that use map values
>> with these fields. Such programs were accepted only because the
>> predicate missed this program type; their use depends on semantics the
>> verifier already rejects for equivalent tracing hooks.
>>
>> Move is_tracing_prog_type() checks from check_map_prog_compatibility()
>> to points where the fields are actually used to avoid preemptively
>> rejecting tracing programs that use maps with such fields but do not
>> touch these fields.
>>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
> Thanks for sending this, looks pretty good to me.
>>  kernel/bpf/verifier.c | 37 ++++++++++++++++++++++---------------
>>  1 file changed, 22 insertions(+), 15 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index ed7ba0e6a9ce..26bfb4465725 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -6967,6 +6967,11 @@ static int process_spin_lock(struct bpf_verifier_=
env *env, struct bpf_reg_state
>>  	u32 spin_lock_off;
>>  	int err;
>>
>> +	if (is_tracing_prog_type(env->prog)) {
>> +		verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
>> +		return -EINVAL;
>> +	}
>> +
>>  	if (!is_const) {
>>  		verbose(env,
>>  			"%s doesn't have constant offset. %s_lock has to be at the constant =
offset\n",
>> @@ -12222,6 +12227,10 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
>>  				return ret;
>>  			break;
>>  		case KF_ARG_PTR_TO_LIST_HEAD:
>> +			if (is_tracing_prog_type(env->prog)) {
>> +				verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\=
n");
>> +				return -EINVAL;
>> +			}
>>  			if (reg->type !=3D PTR_TO_MAP_VALUE &&
>>  			    reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
>>  				verbose(env, "%s expected pointer to map value or allocated object\=
n",
>> @@ -12238,6 +12247,10 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
>>  				return ret;
>>  			break;
>>  		case KF_ARG_PTR_TO_RB_ROOT:
>> +			if (is_tracing_prog_type(env->prog)) {
>> +				verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\=
n");
>> +				return -EINVAL;
>> +			}
>>  			if (reg->type !=3D PTR_TO_MAP_VALUE &&
>>  			    reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
>>  				verbose(env, "%s expected pointer to map value or allocated object\=
n",
>> @@ -17664,9 +17677,11 @@ static int check_pseudo_btf_id(struct bpf_verif=
ier_env *env,
>>  	return __add_used_btf(env, btf);
>>  }
>>
>> -static bool is_tracing_prog_type(enum bpf_prog_type type)
>> +static bool is_tracing_prog_type(const struct bpf_prog *prog)
>>  {
>> -	switch (type) {
>> +	switch (resolve_prog_type(prog)) {
>> +	case BPF_PROG_TYPE_TRACING:
>> +		return prog->expected_attach_type !=3D BPF_TRACE_ITER;
> Seems reasonable to exclude this attach type as they run always in task
> context as stated. This seems like the safest approach.
>
> In practice, *most* tracing type programs will be unreachable from
> NMI. But the edge cases are difficult to enumerate...
>
> fentry / fexit are nearly impossible to exclude, since there's no
> good way to answer "can this function be called from an nmi handler"
> at verification time. Such a list would be unmaintainable.
>
> Raw tracepoints are similar. Indeed, it would be *possible* to
> specifically exclude the tracepoints that cannot be called from NMI. But
> this would require maintaining a large list and would be brittle.
>
> fmodify_return attach types are whitelisted to LSM hooks and
> ALLOW_ERROR_INJECTION functions. A quick grep for ALLOW_ERROR_INJECTION
> doesn't bring anything that looks obviously NMI-relevant, but again, I
> think allowing it would be asking for trouble later.
>
> So I think this is a good balance...
>>  	case BPF_PROG_TYPE_KPROBE:
>>  	case BPF_PROG_TYPE_TRACEPOINT:
>>  	case BPF_PROG_TYPE_PERF_EVENT:
>> @@ -17697,24 +17712,16 @@ static int check_map_prog_compatibility(struct=
 bpf_verifier_env *env,
>>  		return -EACCES;
>>  	}
>>
>> -	if (btf_record_has_field(map->record, BPF_LIST_HEAD) ||
>> -	    btf_record_has_field(map->record, BPF_RB_ROOT)) {
>> -		if (is_tracing_prog_type(prog_type)) {
>> -			verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\n=
");
>> -			return -EINVAL;
>> -		}
>> -	}
>> -
>>  	if (btf_record_has_field(map->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOC=
K)) {
>>  		if (prog_type =3D=3D BPF_PROG_TYPE_SOCKET_FILTER) {
>>  			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
>>  			return -EINVAL;
>>  		}
>> -
>> -		if (is_tracing_prog_type(prog_type)) {
>> -			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
>> -			return -EINVAL;
>> -		}
>> +		/*
>> +		 * Rejecting tracing progs accessing maps with bpf_spin_lock in
>> +		 * them here would be too conservative; let's defer rejection
>> +		 * until seeing first use.
>> +		 */
>
> In practice, I think most programs using those spinlocks w/ fentry
> weren't broken.
>
> They were saved only by nature of the fact that the particular
> functions that attached to were uncallable / never were
> called from NMI. Which is the case for 99% of those programs.
>
> So this case is where fixing the other 1% of cases are going
> to have consequences for the remainder.
>
> This is a tough decision to have to make. There's options, but all of
> them come with downsides.
>
> 1. (this patch) break tracing programs using bpf_spin_lock.
> 2. Somehow prevent NMI reentrancy of tracing progs on the same cpu. proba=
bly
> by just ignoring the reentrant calls, much how we handle the recursive
> tracepoint prevention for bpf. (complicated, may have side effects)
> 3. Inject a fixup runtime check for in_nmi for every tracing program
> and tail callable program, exiting before executing anything
> (still breakage, just at runtime now)
>
> If breakage is acceptible here, the approach this patch takes is the
> most *correct* way to do it, and the way it should have been done from
> day one, but having users relying on the "broken" behavior makes it
> harder to fix now.
>
> This seems like a maintainer call.

Yeah, you outlined the tradeoffs perfectly. What I'm leaning toward is spli=
tting
this one out of the series, focus on the other two for now in v2, and send =
a new
set with this fix + opening up bpf_res_spin_lock() for use as a replacement=
. We
can then emit some guidance for the user to switch when their program break=
s to
a working replacement which hopefully allows a reasonable migration path wh=
ile
reducing this technical debt.
