Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C62F17D6
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777070902; cv=none; b=Bj0bYf4tNRZYZZnUTbRRViTVzL9ac3cMV4yGzt0PMHmeCuTUN5VfNR7j48We/vX51PuRayerutytANtSDO4FpdU/48Sfie8G21CYy7NgKLzEsl4zMjqBX8jM3rX3UbZLFgMEpT2wgsAjY5PIkLO4dCedhY3vgGkmYLVIrUDbsFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777070902; c=relaxed/simple;
	bh=M/c6C4Zvps/uQEioy4pIoWH2KYqeHzzMEAVv6eOjphQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qgMzcJ27kkf8glnfCKybs5+B3CvdU7q20oGkOK9i+y6DYYvUAJEMg1vGICP1Mzgum8lruz7XN4AN9VjLjiI1m5Ov+4b8dmOYBVFBBKv+VB/DqXeNTWCQRtxzOVGgq0U0WoUR4Ef0fSdcIAaVXFvPFNQuWEsf81J48Ac+sBC+v3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVQztRfv; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVQztRfv"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c8f9846c8so8198250c88.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 15:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777070900; x=1777675700; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XoHn3xR/D6GkJaP6jV88s909txgrnyJW9G2/FzN3nwk=;
        b=GVQztRfvMSxojY0IFKn5Ax7lgl5X5P5+AK5nQTpJIEXBm5XrRyrurHl713BkHy6QqM
         aD9wbujchn8ociXqawdaYYJ3xbhysa2GQDhVIkCmZe28pBski1Qhs+9QLG2+ZPRpaTz8
         bJdz4NiRfpDLotkUlri1hpMX/R/oWk2sIVu2m4T61jtqkJ62IEMAaooNWDlXdP/Ok0/y
         J5LWgcnGupzCK3efpoy4xo1Mx0FWB1PMWWxJQOe4EGezaMw30pzvwvVcqwd9foQa6Iee
         h0vK81+jx3s5mFacsU94GLWXNVqMEEj0ptbf80Kq2150UaAqK7xb1rxZh9UJKyEIxZup
         6mKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777070900; x=1777675700;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoHn3xR/D6GkJaP6jV88s909txgrnyJW9G2/FzN3nwk=;
        b=aBx9CfI3HdVGGadFB2aqTwygVyFie7eiG0Mm+ZKtCriwQ0wuKcZq7muwBAK+lC+8uf
         hCgB9o7GIF32OSF3HjfIH9k6X7b2MeZo1rauRy7FOIzS0YlV4IzvSPXo9boclXp1ZKxh
         CveuXT/KRpDPJFdrsgLEzT+g3OFQaWnHp/D/jr+p6Ddxe+bMq9qCD58nHsHEmDjdSAG5
         y+9W9bUYmBEcmd3KtpWF7MwGpRrk44ZQTKOAlnvcKe0SDKhsRr1GBisgQO58eXSzC3TC
         2aHXUgk6ZU5eXqOjQFcmsRgrDJ+iKriK+2C5WJqwg3CnaTsspMI49QkoKMEVE2VPIKWA
         8bIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9vD/J3Mh2fb6PFkEJLkUOlne7iXJYnZkiOc20ZZoZ4982T8EdB92hciw6qtLcNTYL1iEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDEBaZQ3u4oizHdVcToM4nDNWXbxL80ZryULd4nJ6AJb8nP1d7
	coTSrFHrNsB0EYJuY6QJ6zomslUpuiEMlDUC2khqI/FyQdEsj26hZvGJ
X-Gm-Gg: AeBDiesJSNwIWsut5s0qjfLtN2mdCevJT8hOn6YCz76SN2XFlHMRXB7ZqhsFmzg+OoW
	Ab8rKidr5ehn8gViLcvNeKOpRJ0sEgDHdXlw4Z3735sHhyW6LbAht5hjOeFcVXJ3BsQhbDVZpbT
	lQyXJFv+0X9LrZIYIge/ijIYEfXToADXEYrAxFiZQeThKry+GEByRYTIdj8oznoq1be5Tu6WLIN
	Sg2+R7WYtfUGdzUTe7uCjBuN8WvTao/SJNLzU2FR3ocr6LD9+qGKG/7y8GUxQNdPYD/pLV5mqrE
	bXdbBkiUsaz/nHxI3UpmL4GLS9HktD9YVK6bo/sSI9hl/w8YlpvAsI+qIhNdgHLuu4DCR81LKsV
	t/K/0vJwmIUTqFqFz3vBHloVdeyflsmnlRAzQ29iaW5eDPzpTkt0uI7B/EOov/+gOwE1LMqszvD
	FYVi9QssqSPdzCtAfLG+dfLfKu4+KPHpGad2oaFpmcThe9CfliKc2HUSyphOT6gC94RK0s8hKZW
	eqN5NnhCTeFWewU5M2c
X-Received: by 2002:a05:7022:6627:b0:128:dcbd:e27c with SMTP id a92af1059eb24-12c73f95191mr17500938c88.20.1777070900415;
        Fri, 24 Apr 2026 15:48:20 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:92a1:14f3:18de:3c64? ([2620:10d:c090:500::1:b6b2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12da8b8fbc4sm29105885c88.4.2026.04.24.15.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 15:48:20 -0700 (PDT)
Message-ID: <02dbf08511c72ea0c1a5caa33ed400f4a3e3c3c9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/9] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Fri, 24 Apr 2026 15:48:17 -0700
In-Reply-To: <20260421221016.2967924-5-ameryhung@gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
	 <20260421221016.2967924-5-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-04-21 at 15:10 -0700, Amery Hung wrote:

Tbh, I find current state of affairs with id/ref_obj_id/parent_id hard
to follow. The release_reference() is an improvement, but the means by
which the fields are propagated to bpf_reg_state objects are convoluted.
I wonder if having a separate "object table" in bpf_verifier_state and
having bpf_reg_state->id refer to objects within this table would make
things more straight forward.

A few nits below.

[...]

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h

[...]

> @@ -1323,6 +1335,7 @@ struct bpf_dynptr_desc {
>  	enum bpf_dynptr_type type;
>  	u32 id;
>  	u32 ref_obj_id;
> +	u32 parent_id;
>  };

Nit: would be nice to have a comment describing when the above fields
     are populated.

> =20
>  struct bpf_kfunc_call_arg_meta {
> @@ -1334,6 +1347,7 @@ struct bpf_kfunc_call_arg_meta {
>  	const char *func_name;
>  	/* Out parameters */
>  	u32 ref_obj_id;
> +	u32 id;

Nit: would be nice to have a comment here too.

[...]

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 8478d2c6ed5b..72bd3bcda5fb 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -494,7 +494,8 @@ static bool regs_exact(const struct bpf_reg_state *ro=
ld,
>  {
>  	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) =3D=3D 0 =
&&
>  	       check_ids(rold->id, rcur->id, idmap) &&
> -	       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
> +	       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap) &&
> +	       check_ids(rold->parent_id, rcur->parent_id, idmap);

Nit: these check_ids() become repetitive, maybe add a utility function
     checking id/ref_obj_id/parent_id?

>  }
> =20
>  enum exact_level {
> @@ -619,7 +620,8 @@ static bool regsafe(struct bpf_verifier_env *env, str=
uct bpf_reg_state *rold,
>  		       range_within(rold, rcur) &&
>  		       tnum_in(rold->var_off, rcur->var_off) &&
>  		       check_ids(rold->id, rcur->id, idmap) &&
> -		       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
> +		       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap) &&
> +		       check_ids(rold->parent_id, rcur->parent_id, idmap);
>  	case PTR_TO_PACKET_META:
>  	case PTR_TO_PACKET:
>  		/* We must have at least as much range as the old ptr
> @@ -799,7 +801,8 @@ static bool stacksafe(struct bpf_verifier_env *env, s=
truct bpf_func_state *old,
>  			cur_reg =3D &cur->stack[spi].spilled_ptr;
>  			if (old_reg->dynptr.type !=3D cur_reg->dynptr.type ||
>  			    old_reg->dynptr.first_slot !=3D cur_reg->dynptr.first_slot ||
> -			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
> +			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap) ||
> +			    !check_ids(old_reg->parent_id, cur_reg->parent_id, idmap))

Not something changed by the current patch, but still a question:
this path ignores old_reg->id, is it a bug?

>  				return false;
>  			break;
>  		case STACK_ITER:
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0313b7d5f6c9..908a3af0e7c4 100644

[...]

> @@ -241,6 +241,7 @@ struct bpf_call_arg_meta {
>  	int mem_size;
>  	u64 msize_max_value;
>  	int ref_obj_id;
> +	u32 id;

Nit: please add a comment here as well.

[...]

> @@ -635,11 +636,12 @@ static int destroy_if_dynptr_stack_slot(struct bpf_=
verifier_env *env,
>  				        struct bpf_func_state *state, int spi);
> =20
>  static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg,
> -				   enum bpf_arg_type arg_type, int insn_idx, int clone_ref_obj_id)
> +				   enum bpf_arg_type arg_type, int insn_idx, int parent_id,
> +				   struct bpf_dynptr_desc *dynptr)

Having both parent_id and dynptr->parent_id as parameters of this
function is very confusing, but I don't have a suggestion on how to
better deal with it.

[...]

> @@ -8489,6 +8444,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
>  			return -EACCES;
>  		}
>  		meta->ref_obj_id =3D reg->ref_obj_id;
> +		meta->id =3D reg->id;

Could you please leave a comment here explaining when e.g.
meta->ref_obj_id and meta->id would have same or different ids here?
Maybe a few lines of BPF C code.

>  	}
> =20
>  	switch (base_type(arg_type)) {
> @@ -9111,26 +9067,75 @@ static int release_reference_nomark(struct bpf_ve=
rifier_state *state, int ref_ob

[...]

> +/* Release id and objects referencing the id iteratively in a DFS manner=
 */
> +static int release_reference(struct bpf_verifier_env *env, int id)
> +{
> +	u32 mask =3D (1 << STACK_SPILL) | (1 << STACK_DYNPTR);
>  	struct bpf_verifier_state *vstate =3D env->cur_state;
> +	struct bpf_idmap *idstack =3D &env->idmap_scratch;
> +	struct bpf_stack_state *stack;
>  	struct bpf_func_state *state;
>  	struct bpf_reg_state *reg;
> -	int err;
> +	int root_id =3D id, err;
> =20
> -	err =3D release_reference_nomark(vstate, ref_obj_id);
> -	if (err)
> -		return err;
> +	idstack->cnt =3D 0;
> +	idstack_push(idstack, id);
> =20
> -	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> -		if (reg->ref_obj_id =3D=3D ref_obj_id)
> -			mark_reg_invalid(env, reg);
> -	}));
> +	if (find_reference_state(vstate, id))
> +		WARN_ON_ONCE(release_reference_nomark(vstate, id));
> +
> +	while ((id =3D idstack_pop(idstack))) {
> +		bpf_for_each_reg_in_vstate_mask(vstate, state, reg, stack, mask, ({
> +			if (reg->id !=3D id && reg->parent_id !=3D id && reg->ref_obj_id !=3D=
 id)
> +				continue;
> +
> +			if (reg->ref_obj_id && id !=3D root_id) {
> +				struct bpf_reference_state *ref_state;
> +
> +				ref_state =3D find_reference_state(env->cur_state, reg->ref_obj_id);
> +				verbose(env, "Unreleased reference id=3D%d alloc_insn=3D%d when rele=
asing id=3D%d\n",
> +					ref_state->id, ref_state->insn_idx, root_id);
> +				return -EINVAL;
> +			}
> +
> +			if (reg->id !=3D id) {
> +				err =3D idstack_push(idstack, reg->id);
> +				if (err)
> +					return err;
> +			}
> +
> +			if (!stack || stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_SPILL)
> +				mark_reg_invalid(env, reg);
> +			else if (stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_DYNPTR)
> +				invalidate_dynptr(env, state, stack);

invalidate_dynptr() rewrites to stack slots, can it be the case that
this body of bpf_for_each_reg_in_vstate_mask() is computed for first
and second dynptr stack slots, hence triggering invalidate_dynptr() to
rewrite three slots instead of two?

> +		}));
> +	}
> =20
>  	return 0;
>  }

[...]

> @@ -12009,6 +12009,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>  				return -EFAULT;
>  			}
>  			meta->ref_obj_id =3D reg->ref_obj_id;
> +			meta->id =3D reg->id;

And here a comment describing when this happens would be helpful.

[...]

> @@ -12171,15 +12171,10 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
>  				}
> =20
>  				dynptr_arg_type |=3D (unsigned int)get_dynptr_type_flag(parent_type)=
;
> -				clone_ref_obj_id =3D meta->dynptr.ref_obj_id;
> -				if (dynptr_type_refcounted(parent_type) && !clone_ref_obj_id) {
> -					verifier_bug(env, "missing ref obj id for parent of clone");
> -					return -EFAULT;
> -				}
>  			}
> =20
> -			ret =3D process_dynptr_func(env, regno, insn_idx, dynptr_arg_type, cl=
one_ref_obj_id,
> -						  &meta->dynptr);
> +			ret =3D process_dynptr_func(env, regno, insn_idx, dynptr_arg_type,
> +						  meta->ref_obj_id ? meta->id : 0, &meta->dynptr);

And an example here as well.

>  			if (ret < 0)
>  				return ret;
>  			break;

[...]
