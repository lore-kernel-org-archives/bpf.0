Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189C142E400
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153953; cv=none; b=GJJmBZhpAUYRRNoO6spyFZjw6mMUNBUtPhr1odoFXEP5+O9lFmwrkRwXW4h8DgqmWYtm+GRAxBZLkqjoxgfmPi1476qVwBedWm/QMVfUooh472k24FZ6Da+4Y/V3vBbX9M0LebTJvEieo9Xe2cylRYe9Eu2XTsIIe4pLhd9VSIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153953; c=relaxed/simple;
	bh=SDesEhc4PFq2cRed4ukRn2YTOPo57HmsSkA0bmNS26o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ANPma819aWqnfqR1ls7BZ1NWDLkmwhboRlZFixto7HIyqv2xDtzufqeeU00HpKwxKy1zWawKZveAtK0tw4LXxSRyeqeDekkFJlbmO90+rKZXoZaImC3EnR76IjJ2Im3ax2MtXWe+5s9rVcqBfOgx78X6gEigoRI0vjMhy0JHQFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU9oPtzr; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU9oPtzr"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso1040003a12.3
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 12:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789153940; x=1789758740; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TCslkik8e88DnDBuJgPGIPAPZ7Zn+JaXCZfsJXbWpPM=;
        b=UU9oPtzrHA6az2O5xWBeTCDNy1ZXrWqqeF/+xpFI8XXiWxfOBL5ztdT3NljrmQiL72
         Y03cCztD88BLRf7EF6jN3OHQV6UNQWEgKm0ZZ4cJnXnI4+7kxC6waCUkL8fLezQ/C8+l
         GTRq082ccsyE/H0Tj+6MymvPQ32W04RVzq0pLXSgokseiHNHWKY1rbRGXFG7GYoLdm6D
         xh67lVBbl3g1lPe3JsFS4uESYCkm0XH5OmXwb18WMs12dkwfY3tJkrv5M7eTZ0jzM7LE
         Zs3w13ZEoD+KXiWodzRnvAeX3NCSRCIdiElLbFlo/Y8S+deVALXcxXMXqf4E7HreXR4O
         u7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789153940; x=1789758740;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TCslkik8e88DnDBuJgPGIPAPZ7Zn+JaXCZfsJXbWpPM=;
        b=sjzer9mMVcCTmMxEOwwsi/W4Mff41rB/hjCVpTbtvfpxY47PuALkudd9/VwMdPt5Sh
         3AC1cE40SKGhaGgEc3LOqtvTaKlF/IW8g5kwPyPdtinYgUVXzLMJnXnWxMlrtoOIKnQa
         Or7UA0bbGT0AoLVLf1moMdMzo7nasYIcY6s8CqmIYB95RB57LkMuMowxB2PksiTqAsOJ
         PjN8XQlOen1GdWu2PfCVc+IFoD89uBrMJKKKg9PRqxn29Ysr3WdSQymPqqV6+2keO4nb
         OvNW1sC/9mwHL333zRvzNw5NRU7ZNzzofcamV1St2oa0eXs1+BUZXE3Mc7XkEJPpRZ60
         IrQA==
X-Forwarded-Encrypted: i=1; AKwUvBwDv5HQEE/IqAc65d+DN/phiwK0sseLX/X/Ouz1vPA004a6hcgQJhzdXsLV67q7cu5pl5M=@vger.kernel.org
X-Gm-Message-State: AFuF++mGGq71j6WxG5MHqHtV5VszpxM82suGSgz8YtK1RYhhJhWlbzir
	Li2ufLUbdHfd+wC8r+zeAS9LQfQ23/mUI1JiuE5Ckco5dsfymfjP33CB
X-Gm-Gg: AYBFou1wO0KcA2Z2KC8MhSIEYfqh7jYC1CzSYKOVnz2FpXP3BcRQJWAE7/czcaah6Yk
	s0f8gTNcY2+W3EY/xzPLp2NNJr253RDhZEj52J5jgAjI5OqkUYi6QmMMaSEc588G8DmosMzXr4U
	iqErihukiWLpjSIxe440sfRRu/eOwlCF/mXGB0ru9di4QqmzXCNRoge6JA1YHZs5waOoOGaYPrT
	4o+9dPGCd/KGtHu9AEgCHPxIjtgspGNCVxvHscH3++RSIxSZUkk1zdnh4G6ubh+k3+ZJ8oS2ME7
	/B2AnZJz9Ke+zdjYLa4Vv5iZTI3wCXe7hA5fu38AQotB1aVSD1ulm0XF2p5hk08PSTlz3m7V2Z8
	0MGWQcZimv7DTCHCTkU617+L8FhCCca0SmlJXs34JucH6vtt3vbinGjuTqXlCv2QZIwZ/E5VAZ3
	snyw6iNUYP1MAa3a34srz25dABdkKXycz7EtFgGQufBSD7oxgHTHpXzB5qzskLR+hq4cPGy6V3M
	tard1IeLf7eagMJbCI3i+J548C6jrgKlYkZVrtwiR8DF1zrWrCddUBWpH4=
X-Received: by 2002:a17:90b:582b:b0:398:c0ad:711c with SMTP id 98e67ed59e1d1-39d9c1d1f85mr9520451a91.15.1789153940349;
        Fri, 11 Sep 2026 12:12:20 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c301:f6bd:6d2f:aee9? ([2620:10d:c090:500::6:9299])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ed79absm9372181eec.17.2026.09.11.12.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 12:12:19 -0700 (PDT)
Message-ID: <5d95d6730b5e1d6f2e4492f8920bd2547ce0811c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Verify global subprogs in each
 sleepability context
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Fri, 11 Sep 2026 12:12:17 -0700
In-Reply-To: <20260905051224.2325381-2-memxor@gmail.com>
References: <20260905051224.2325381-1-memxor@gmail.com>
		 <20260905051224.2325381-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-05 at 07:12 +0200, Kumar Kartikeya Dwivedi wrote:
> Global subprograms are verified independently with a fresh verifier root.
> do_check_common() currently seeds that root's in_sleepable state from the
> program, even though a global subprogram can also run from callbacks whos=
e
> execution context differs from the program's main entry point.
>=20
> In particular, workqueue and task-work callbacks are sleepable even when
> the containing program is not. A global subprogram of that program is
> therefore verified as non-sleepable, making in_rcu_cs() true and allowing
> loads of RCU-protected kptrs to produce trusted MEM_RCU pointers. The sam=
e
> subprogram can then be called from a sleepable callback without a classic
> RCU reader. It can retain such a pointer while the object is freed and us=
e
> it after free.
>=20
> The verifier's execution-context predicates are complementary. A state is
> sleepable only when in_sleepable is set and no RCU, preemption, IRQ, or l=
ock
> region is active. Each condition which prevents sleeping also provides RC=
U
> protection, while in_rcu_cs() treats a non-sleepable state as implicitly
> protected.
>=20
> Use this relationship to represent a global subprogram caller with only t=
he
> result of in_sleepable_context(). A protected sleepable caller is normali=
zed
> to in_sleepable=3Dfalse at the independent verification root. This both
> prevents sleepable operations and makes in_rcu_cs() true without copying
> caller-owned lock state.
>=20
> Record whether each global subprogram is called with either in_sleepable
> value and verify it once for every observed value. Walk global subprogram=
s
> in caller-before-callee order so the values propagate through global call
> chains, and repeat until every discovered context has been verified to co=
ver
> asynchronous callback cycles.
>=20
> Since a global subprogram may now be verified twice, accumulate both pass=
es
> in subprog_info[].insns_total. This makes BPF_LOG_STATS and per-subprogra=
m
> veristat output account for both contexts instead of reporting only the l=
ast
> pass.
>=20
> This makes an unprotected callback verify the global subprogram as
> sleepable, turning its RCU-protected kptr load into an untrusted pointer.
> Protected callers and global subprograms which do not depend on implicit =
RCU
> protection remain valid.
>=20
> Fixes: 81f1d7a583fa ("bpf: wq: add bpf_wq_set_callback_impl")
> Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
> Reported-by: Nicholas Carlini <npc@anthropic.com>
> Suggested-by: Nicholas Carlini <npc@anthropic.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Hi Kartikeya,

Apologies for the delayed review. Overall the code lgtm, please see a
few questions and nits below.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5b51e7ee1a3f..f759a020c8a5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

...

> @@ -10804,7 +10804,12 @@ int bpf_get_helper_proto(struct bpf_verifier_env=
 *env, int func_id,
>  	return *ptr && (*ptr)->func ? 0 : -EINVAL;
>  }
> =20
> -/* Check if we're in a sleepable context. */
> +/*
> + * This predicate is the inverse of in_rcu_cs(): non-sleepable programs =
and
> + * every condition that prevents sleeping also provide RCU protection. G=
lobal
> + * subprog verification relies on this equivalence to represent the call=
er's
> + * execution context using only the in_sleepable bit.
> + */

Agree with Alexei, let's just write it down as !in_rcu_cs().
I think it's a second time we argue :)
For the purposes of this patch-set one can just drop the comment above.

>  static inline bool in_sleepable_context(struct bpf_verifier_env *env)
>  {
>  	return !env->cur_state->active_rcu_locks &&
> @@ -19560,13 +19565,14 @@ static void free_states(struct bpf_verifier_env=
 *env)
>  	}
>  }
> =20
> -static int do_check_common(struct bpf_verifier_env *env, int subprog)
> +static int do_check_common(struct bpf_verifier_env *env, int subprog, bo=
ol in_sleepable)
>  {
>  	bool pop_log =3D !(env->log.level & BPF_LOG_LEVEL2);
>  	struct bpf_subprog_info *sub =3D subprog_info(env, subprog);
>  	struct bpf_prog_aux *aux =3D env->prog->aux;
>  	struct bpf_verifier_state *state;
>  	struct bpf_reg_state *regs;
> +	u32 old_insns_total =3D sub->insns_total;
>  	u32 insn_processed =3D env->insn_processed;
>  	int ret, i;
> =20
> @@ -19579,7 +19585,7 @@ static int do_check_common(struct bpf_verifier_en=
v *env, int subprog)
>  	state->curframe =3D 0;
>  	state->speculative =3D false;
>  	state->branches =3D 1;
> -	state->in_sleepable =3D env->prog->sleepable;
> +	state->in_sleepable =3D in_sleepable;
>  	state->frame[0] =3D kzalloc_obj(struct bpf_func_state, GFP_KERNEL_ACCOU=
NT);
>  	if (!state->frame[0]) {
>  		kfree(state);
> @@ -19721,7 +19727,8 @@ static int do_check_common(struct bpf_verifier_en=
v *env, int subprog)
>  	 * Accumulate their total counts as total counts of the main or
>  	 * global subprog hosting the async call.
>  	 */
> -	env->subprog_info[subprog].insns_total =3D env->insn_processed - insn_p=
rocessed;
> +	env->subprog_info[subprog].insns_total =3D old_insns_total +
> +						(env->insn_processed - insn_processed);

Wouldn't +=3D work w/o old_insns_total temporary?

>  	return ret;
>  }
> =20
> @@ -19749,45 +19756,55 @@ static int do_check_subprogs(struct bpf_verifie=
r_env *env)
>  {
>  	struct bpf_prog_aux *aux =3D env->prog->aux;
>  	struct bpf_func_info_aux *sub_aux;
> -	int i, ret, new_cnt;
> +	int context, i, j, ret, new_cnt;
> =20
>  	if (!aux->func_info)
>  		return 0;
> =20
>  	/* exception callback is presumed to be always called */
> -	if (env->exception_callback_subprog)
> -		subprog_aux(env, env->exception_callback_subprog)->called =3D true;
> +	if (env->exception_callback_subprog) {
> +		sub_aux =3D subprog_aux(env, env->exception_callback_subprog);
> +		sub_aux->called[env->prog->sleepable] =3D true;

Do we allow to call throw from the callbacks?
If we do, do we handle the `called[sleepable|not-sleepable]`
management for exception callbacks?

> +	}
> =20
>  again:
>  	new_cnt =3D 0;
> -	for (i =3D 1; i < env->subprog_cnt; i++) {
> +	/*
> +	 * Walk callers before callees so each global subprog normally sees all
> +	 * of its contexts before it is verified. Async callback cycles can add=
 a
> +	 * context to an earlier subprog, so repeat until every called context =
is
> +	 * verified.
> +	 */
> +	for (j =3D env->subprog_cnt - 1; j >=3D 0; j--) {
> +		i =3D env->subprog_topo_order[j];
> +		if (!i)
> +			continue;

Nit: is it really necessary to explicitly change the traversal order here?
     the algorithm already explores the function only when 'called' flag is=
 set.

>  		if (!bpf_subprog_is_global(env, i))
>  			continue;
> =20
>  		sub_aux =3D subprog_aux(env, i);
> -		if (!sub_aux->called || sub_aux->verified)
> -			continue;
> +		for (context =3D 0; context < ARRAY_SIZE(sub_aux->called); context++) =
{
> +			if (!sub_aux->called[context] || sub_aux->verified[context])
> +				continue;
> =20
> -		env->insn_idx =3D env->subprog_info[i].start;
> -		WARN_ON_ONCE(env->insn_idx =3D=3D 0);
> -		ret =3D do_check_common(env, i);
> -		if (ret) {
> -			return ret;
> -		} else if (env->log.level & BPF_LOG_LEVEL) {
> -			verbose(env, "Func#%d ('%s') is safe for any args that match its prot=
otype\n",
> -				i, bpf_subprog_name(env, i));
> -		}
> +			env->insn_idx =3D env->subprog_info[i].start;
> +			WARN_ON_ONCE(env->insn_idx =3D=3D 0);
> +			ret =3D do_check_common(env, i, context);
> +			if (ret)
> +				return ret;
> +			if (env->log.level & BPF_LOG_LEVEL)
> +				verbose(env, "Func#%d ('%s') is safe for any args "
> +					"that match its prototype\n",
> +					i, bpf_subprog_name(env, i));
> =20
> -		/* We verified new global subprog, it might have called some
> -		 * more global subprogs that we haven't verified yet, so we
> -		 * need to do another pass over subprogs to verify those.
> -		 */
> -		sub_aux->verified =3D true;
> -		new_cnt++;
> +			sub_aux->verified[context] =3D true;
> +			new_cnt++;
> +		}
>  	}
> =20
> -	/* We can't loop forever as we verify at least one global subprog on
> -	 * each pass.
> +	/*
> +	 * We can't loop forever as each pass verifies at least one new context=
,
> +	 * and there are only two contexts per global subprog.
>  	 */
>  	if (new_cnt)
>  		goto again;

...
