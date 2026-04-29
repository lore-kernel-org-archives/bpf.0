Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE411A682C
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777422522; cv=none; b=cyBFthF4syNNpJMZ0Xgp4A4jPTrc1wzWST8lrabcts6zHQI27Rlv9QG+Bm9MdNx+Aq8/fOC8GURn1uKXZn9/vqernGBl02fuuEq3rFZKOkLCNFwIKo/M7XwZ0lLSMlLU7HDHuslQc6QlRcTMSRVUC5HpFQAmnyHSZTgYO133V58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777422522; c=relaxed/simple;
	bh=BlAgQn+1psPFAaMN8S9OF7HMPl+4zINnFbvRRh5WK+A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uB3Ulv0XY9BHkua3LECHSCMEZP2egYL2NY12NpGUZKF/LQI2rwqYlKG/hIoK/dtlW66cUf9S7h27sWHemp5eAHSclmFCdjLlmtNsNRgxqdhi6F89vqnioNJ6n7SU6ZP0xehUPCL1fVZFw0It5Of3ki+4uodICh+i12dotY1JzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGoSxhgX; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGoSxhgX"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c8ccc7755so12990747c88.0
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 17:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777422520; x=1778027320; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UZPrvQEae/RJSBUNybTxymw4prAcEq5DpZj7X0jmLeA=;
        b=SGoSxhgX87nqdXh1mKnViBUcmh2MKKhIdjyt/JC+5p0DiRrM8ti/L+/NO/aKnB1zhD
         Ix5qSZkpBDTFxXbDSirn+JWLpvxDpsljod3mfNTAdTg8/nrZbXRpLdesx3ifpmr53eJX
         2n4NHTP16IRyfEjb5hg8nwb+M8XjnVSW2nzAB6q1Fzdu4Yf1FjjnXeUrA/tJuLTcy1YO
         qmbEg7+UfdBnNySzYtlbFx43M47QzCMnq8QCW531phsZEi73SiFcrSGYvQlWe4kFp49O
         sRFu7ZRit/BHCBU6Aw222bCKyFcT1o1EUbO5sJgHXgnZJhUj2lsVbsKqSWDxQl1qK8WU
         Tv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777422520; x=1778027320;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZPrvQEae/RJSBUNybTxymw4prAcEq5DpZj7X0jmLeA=;
        b=ny6a4YQ1y0y4+bUiDWHfgXf/aH6JvNNs9IYmmu95RYRffEmiStx72o5UFmQxTaEyyp
         KFjZYdF6GZNN8QR/Tj+T8+p7ltBn7LOBQdGs4k0p58rWMTsAw5Gg7RKJvD7GriEHDS9R
         CCMGYMxVYZDVj+B+rawHdw7M3aKGB/Zz+r+UU1o7KpScV45ybKUzxmqbLi+JKFUg4Vhm
         yTItTAvAJp0s2vGD0Ttj4hO3J4klxwZipKIyDRN/PMQ3A+wad0G9vGcOlY+c3XYssCgE
         Pnrz2fJ/UAIHJANLe/j9YxpbB8+k3zayG/jPdgidefrZ9V2fC1DupItTPVW0D2QZxxHO
         e9uA==
X-Forwarded-Encrypted: i=1; AFNElJ/G0RKudA0NzTmV85a2s5e5OzuT54ln4MnImLm67kUr5qqKWyM0Rig9WRx727CXuasrad0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1EE/QF+B+UyA7OkYEbB5Wm+y82Eb3JtbOxkhZ+0ekGCuSbsDC
	9tHO/LQLEpi9+cYsNKKBkiC3qzD3vxlr4cGBTKrDUIh0b9DWGRbaoNTe
X-Gm-Gg: AeBDieuJ/M09NsjW5ZL3k9EcfJ2S6mgXituL1R1KiFEOUg4/9NxZu+uiCiNPUrz1WuV
	+zEslofzhbCJkHR7uuTH/r8Gvt+7a4+NhZlcxpKEstVEiYm4bE+5rjHtzIYbTg1o6hsdRH+DU7w
	DmH2lAsYxHb93/crqYf4C1U0pcO0uueR0EimVK3twkACCrcJC64SKJ4OEIhxkE2mLuCvZsp4keA
	JaYKOAH+sm0YJhXe2dwwI/q3ITSCtfMKWeK/tEdd7hfchIt+5JOoGGcJNkE7tUB+dj6bvLrp6cJ
	YSa98Nic8IeNtYjsm2HWVIkb3QCiZhsOd0eMQJOQWXy+o9okPD4MlUC5IABtuBhNiz9nYT3t+da
	5a5Fv3uRbedoYOmetqy/W11dhzlNcQLgrOpm9yf727ySGCg7jo6+EY8JS/aRkLLoZUtZTn7jBng
	gPuDayN1Q6lo3ZTJr8Src+RtHj4lXPTiYlN2RGQHMUK2zk5FlbEvcIeclEq8ta0dpXNMeQEF0M
X-Received: by 2002:a05:7022:61d:b0:12d:b218:e02e with SMTP id a92af1059eb24-12ddd950ae3mr2412582c88.11.1777422519370;
        Tue, 28 Apr 2026 17:28:39 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21d6::142b? ([2620:10d:c090:400::5:b46])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de3261596sm408468c88.11.2026.04.28.17.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 17:28:38 -0700 (PDT)
Message-ID: <abe6e8e7a0ac5d4c1fbbf35643577d53db81e891.camel@gmail.com>
Subject: Re: [PATCH bpf-next 01/18] bpf: Support stack arguments for bpf
 functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,  Martin KaFai Lau
 <martin.lau@kernel.org>
Date: Tue, 28 Apr 2026 17:28:33 -0700
In-Reply-To: <29308729-2a9c-4a4e-9b4f-a92bd185ee22@linux.dev>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
	 <20260424171438.2034741-1-yonghong.song@linux.dev>
	 <7a031b0dcbf54e34d6a6571256b1bb65b5617bcc.camel@gmail.com>
	 <29308729-2a9c-4a4e-9b4f-a92bd185ee22@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-04-28 at 17:47 +0100, Yonghong Song wrote:
>=20
> On 4/28/26 7:29 AM, Eduard Zingerman wrote:
> > On Fri, 2026-04-24 at 10:14 -0700, Yonghong Song wrote:
> >=20
> > [...]
> >=20
> > I didn't see this in the patch, hence the question: should or should
> > not this feature be privileged bpf only?
>=20
> It is priviledged only. See add_subprog_and_kfunc().
> both bpf-to-bpf call and kfunc requires bpf_capable.

I see, thank you.

> > [...]
> >=20
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
> > > index d5b4303315dd..2cc349d7fc17 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > [...]
> >=20
> > > @@ -508,6 +512,17 @@ struct bpf_verifier_state {
> > >   	     iter < frame->allocated_stack / BPF_REG_SIZE;		\
> > >   	     iter++, reg =3D bpf_get_spilled_reg(iter, frame, mask))
> > >  =20
> > > +#define bpf_get_spilled_stack_arg(slot, frame, mask)                =
   \
> > > +	((((slot) < frame->out_stack_arg_depth / BPF_REG_SIZE) &&          =
 \
> > > +	  (frame->stack_arg_regs[slot].type !=3D NOT_INIT))               \
> > > +	 ? &frame->stack_arg_regs[slot] : NULL)
> > can this be a static inline function?
>=20
> We could but we have
>=20
> #define bpf_get_spilled_reg(slot, frame, mask)                          \
>          (((slot < frame->allocated_stack / BPF_REG_SIZE) &&             =
\
>            ((1 << frame->stack[slot].slot_type[BPF_REG_SIZE - 1]) & (mask=
))) \
>           ? &frame->stack[slot].spilled_ptr : NULL)
>=20
> Should we do the same (as static inline function)?

I think so, yes.

> > > +/* Iterate over 'frame', setting 'reg' to either NULL or a spilled s=
tack arg. */
> > > +#define bpf_for_each_spilled_stack_arg(iter, frame, reg, mask)      =
   \
> > > +	for (iter =3D 0, reg =3D bpf_get_spilled_stack_arg(iter, frame, mas=
k); \
> > > +	     iter < frame->out_stack_arg_depth / BPF_REG_SIZE;             =
 \
> > > +	     iter++, reg =3D bpf_get_spilled_stack_arg(iter, frame, mask))
> > > +
> > >   #define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __ma=
sk, __expr)   \
> > >   	({                                                               \
> > >   		struct bpf_verifier_state *___vstate =3D __vst;            \
> > > @@ -525,6 +540,11 @@ struct bpf_verifier_state {
> > >   					continue;                        \
> > >   				(void)(__expr);                          \
> > >   			}                                                \
> > > +			bpf_for_each_spilled_stack_arg(___j, __state, __reg, __mask) { \
> > > +				if (!__reg)                              \
> > > +					continue;                        \
> > > +				(void)(__expr);                          \
> > > +			}						 \
> > >   		}                                                        \
> > >   	})
> > Tangential nit: I think this macro is getting a bit too complicated,
> > we might want to introduce some proper reg_state iterator at some
> > point, e.g.:
> >=20
> >    struct ret_iter it =3D new_reg_iter(state);
> >    while ((reg =3D next_reg(&it))) { ... }
>=20
> You mean have a static function with=C2=A0proper arguments and do the abo=
ve?
> I guess can do a followup later to simplify it.

Yes, a structure describing an iterator over all
registers/spills/stack-based arguments and to functions:
one for initialization and one for moving the iterator.

[...]

> > > @@ -1378,9 +1382,21 @@ int bpf_fixup_call_args(struct bpf_verifier_en=
v *env)
> > >   	struct bpf_prog *prog =3D env->prog;
> > >   	struct bpf_insn *insn =3D prog->insnsi;
> > >   	bool has_kfunc_call =3D bpf_prog_has_kfunc_call(prog);
> > > -	int i, depth;
> > > +	int depth;
> > >   #endif
> > > -	int err =3D 0;
> > > +	int i, err =3D 0;
> > > +
> > > +	for (i =3D 0; i < env->subprog_cnt; i++) {
> > > +		struct bpf_subprog_info *subprog =3D &env->subprog_info[i];
> > > +		u16 outgoing =3D subprog->stack_arg_depth - subprog->incoming_stac=
k_arg_depth;
> > > +
> > > +		if (subprog->max_out_stack_arg_depth > outgoing) {
> > > +			verbose(env,
> > > +				"func#%d writes stack arg slot at depth %u, but calls only requi=
re %u bytes\n",
> > > +				i, subprog->max_out_stack_arg_depth, outgoing);
> > > +			return -EINVAL;
> > Is this an internal error condition?
> > If it is, maybe use verifier_bug()?
>=20
> It is not. For example,
>=20
> SEC("tc")
> __description("stack_arg: write unused stack arg slot")
> __failure
> __msg("func#0 writes stack arg slot at depth 40, but calls only require 1=
6 bytes")
> __naked void stack_arg_write_unused_slot(void)
> {
>          asm volatile (
>                  "r1 =3D 1;"
>                  "r2 =3D 2;"
>                  "r3 =3D 3;"
>                  "r4 =3D 4;"
>                  "r5 =3D 5;"
>                  /* Write to offset -40, unused for the callee */
>                  "*(u64 *)(r11 - 40) =3D 99;"
>                  "*(u64 *)(r11 - 16) =3D 20;"
>                  "*(u64 *)(r11 - 8) =3D 10;"
>                  "call subprog_7args;"
>                  "r0 =3D 0;"
>                  "exit;"
>                  ::: __clobber_all
>          );
> }

But this is a very partial check, the max_out_stack_arg_depth is
computed per-subprogram, not per-call. As far as I understand the
design, it can't be computed per-call at all. Meaning that if there
are, say, two calls:
- foo(1,2,3,4,5,6,7)   // where foo expects only 6 parameters
- bar(1,2,3,4,5,6,7,8) // where bar expects only 7 parameters

In this case:
- Verifier won't know which of the two calls is bogus, so won't be
  able to point user to the instruction where error occurs.
- This is not a safety condition, meaning that kernel state is not
  broken if more arguments are pushed onto stack (and if it *is* a
  safety condition, then we need to figure out something two check
  both calls above).
 =20
Thus, I'd suggest not to check this property at all.

[...]

> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -1361,6 +1361,18 @@ static int copy_stack_state(struct bpf_func_st=
ate *dst, const struct bpf_func_st
> > >   		return -ENOMEM;
> > >  =20
> > >   	dst->allocated_stack =3D src->allocated_stack;
> > > +
> > > +	/* copy stack args state */
> > > +	n =3D src->out_stack_arg_depth / BPF_REG_SIZE;
> > > +	if (n) {
> > > +		dst->stack_arg_regs =3D copy_array(dst->stack_arg_regs, src->stack=
_arg_regs, n,
> > > +						 sizeof(struct bpf_reg_state),
> > > +						 GFP_KERNEL_ACCOUNT);
> > > +		if (!dst->stack_arg_regs)
> > > +			return -ENOMEM;
> > > +	}
> > > +
> > > +	dst->out_stack_arg_depth =3D src->out_stack_arg_depth;
> > Given that this is capped by 12, does it make sense to maintain the cou=
nter?
> > It might be simpler to always allocate an array of 12 elements.
>=20
> The number of stack arguments is most 7. So yes, we can do it.

Note from a short discussion with Alexei today:
he does not think this is a big deal and also thinks that saving some
space by allocating this array only when necessary would be a plus.
I, on the other hand, still think that growing this dynamically is an
over-complication.

[...]

> > > @@ -4417,6 +4446,109 @@ static int check_stack_write(struct bpf_verif=
ier_env *env,
> > >   	return err;
> > >   }
> > >  =20
> > > +/*
> > > + * Write a value to the outgoing stack arg area.
> > > + * off is a negative offset from r11 (e.g. -8 for arg6, -16 for arg7=
).
> > > + */
> > > +static int check_stack_arg_write(struct bpf_verifier_env *env, struc=
t bpf_func_state *state,

[...]

> > > +	/* Track the max outgoing stack arg access depth. */
> > > +	if (-off > subprog->max_out_stack_arg_depth)
> > > +		subprog->max_out_stack_arg_depth =3D -off;
> > > +
> > > +	cur =3D env->cur_state->frame[env->cur_state->curframe];
> > > +	if (value_regno >=3D 0) {
> > > +		state->stack_arg_regs[spi] =3D cur->regs[value_regno];
> > Nit: there is copy_register_state(), we should either use it here or
> > drop it and replace with direct assignments everywhere.
>=20
> Will use copy_register_state() to be consistant with our examples.

It is a second time the issue is raised on the mailing list,
so it might be worth it to have a small preparatory patch removing
this function. It had a non-empty body once but now it is truly
useless. Wdyt?

[...]

> > > +/*
> > > + * Read a value from the incoming stack arg area.
> > > + * off is a positive offset from r11 (e.g. +8 for arg6, +16 for arg7=
).
> > > + */
> > > +static int check_stack_arg_read(struct bpf_verifier_env *env, struct=
 bpf_func_state *state,
> > > +				int off, int dst_regno)
> > > +{
> > > +	struct bpf_subprog_info *subprog =3D &env->subprog_info[state->subp=
rogno];
> > > +	struct bpf_verifier_state *vstate =3D env->cur_state;
> > > +	int spi =3D off / BPF_REG_SIZE - 1;
> > > +	struct bpf_func_state *caller, *cur;
> > > +	struct bpf_reg_state *arg;
> > > +
> > > +	if (state->no_stack_arg_load) {
> > > +		verbose(env, "r11 load must be before any r11 store or call insn\n=
");
> > > +		return -EINVAL;
> > > +	}
> > I think the error message should be inverted, store should precede the =
load.
> > But tbh, I'd drop it altogether, the check right below should be suffic=
ient.
>=20
> This is necessary. See
>=20
> SEC("tc")
> __description("stack_arg: r11 load after r11 store")
> __failure
> __msg("r11 load must be before any r11 store or call insn")
> __naked void stack_arg_load_after_store(void)
> {
>          asm volatile (
>                  "r1 =3D 1;"
>                  "r2 =3D 2;"
>                  "r3 =3D 3;"
>                  "r4 =3D 4;"
>                  "r5 =3D 5;"
>                  "*(u64 *)(r11 - 8) =3D 6;"
>                  "r0 =3D *(u64 *)(r11 + 8);"
>                  "call subprog_6args;"
>                  "exit;"
>                  ::: __clobber_all
>          );
> }
>         =20
> SEC("tc")
> __description("stack_arg: r11 load after a call")
> __failure
> __msg("r11 load must be before any r11 store or call insn")
> __naked void stack_arg_load_after_call(void)
> {
>          asm volatile (
>                  "call %[bpf_get_prandom_u32];"
>                  "r0 =3D *(u64 *)(r11 + 8);"
>                  "exit;"
>                  :: __imm(bpf_get_prandom_u32)
>                  : __clobber_all
>          );
> }
>=20
> >=20
> > > +
> > > +	if (off > subprog->incoming_stack_arg_depth) {
> > > +		verbose(env, "invalid read from stack arg off %d depth %d\n",
> > > +			off, subprog->incoming_stack_arg_depth);
> > > +		return -EACCES;
> > > +	}
>=20
> This is for this kind of failure:
>=20
> SEC("tc")
> __description("stack_arg: read from uninitialized stack arg slot")
> __failure
> __msg("invalid read from stack arg off 8 depth 0")
> __naked void stack_arg_read_uninitialized(void)
> {
>          asm volatile (
>                  "r0 =3D *(u64 *)(r11 + 8);"
>                  "r0 =3D 0;"
>                  "exit;"
>                  ::: __clobber_all
>          );
> }

Consider your first example:

    > __naked void stack_arg_load_after_store(void)
    > {
    >          asm volatile (
    >                  "r1 =3D 1;"
    >                  "r2 =3D 2;"
    >                  "r3 =3D 3;"
    >                  "r4 =3D 4;"
    >                  "r5 =3D 5;"
    >                  "*(u64 *)(r11 - 8) =3D 6;"
    >                  "r0 =3D *(u64 *)(r11 + 8);"
                                     ^^^^^^^^^
wouldn't the second check 'if (off > subprog->incoming_stack_arg_depth)...'
be triggered here?

    >                  "call subprog_6args;"
    >                  "exit;"
    >                  ::: __clobber_all
    >          );
    > }

> > > +	caller =3D vstate->frame[vstate->curframe - 1];
> > > +	arg =3D &caller->stack_arg_regs[spi];
> > > +	cur =3D vstate->frame[vstate->curframe];
> > > +
> > > +	if (is_spillable_regtype(arg->type))
> > > +		copy_register_state(&cur->regs[dst_regno], arg);
> > > +	else
> > > +		mark_reg_unknown(env, cur->regs, dst_regno);
> > For stack writes we report error in such situations,
> > should the same be done here?
>=20
> We should be fine here.

This is not a bug, sure, but it would be nice to have consistent
behavior for similar situations.

[...]
