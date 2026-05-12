Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527AC3C09E0
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617242; cv=none; b=vAjbZwdVKTHs7tjirY0yn++9V6TLpZ89dmOcUxTdTmeVuv48GgB+DPJhKN5Jksf2GCpo85AtEl/H6ge5SQ+BZyB/LV10qj747lnvh6+j4J0yhGa37T4O+4BwHUzbTpLx7QHiWEW8qpKMw/9zjGF0Mgv61bfDuuWWrVShAOu8WR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617242; c=relaxed/simple;
	bh=06Ut2b9dvZs1v+RSw5hLsGRQubpCyWhXGoGpYe0/huo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CmD9rTn5yz2hHf0Hwx74X515lmu342nM8R96Ug/V0Xd0rJpQ60fQUO/eX+OpzLK8wXEbueLv/h+2u5HQvTuaWtf6ny8OIhgNBIFggOmuYDlwCq+rIw/1Arr/KtsjCUgUDypTOvNdUm9m44LVU+Td7OpJGzQ2gZ+rKH4ACpM+0I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltbq6GPe; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltbq6GPe"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8383fb7143aso2877028b3a.3
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 13:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778617233; x=1779222033; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gQzjdm8eFv/sznJvgMXu/FTaTbhPBF2kbyubytRDFJs=;
        b=ltbq6GPe0a9lKdTDFbrdF2KmxQ2mNrIT15f9ngyoEgr4T/M9v+HGtZyGL6Q3KqiMMW
         Jjw23f4OBoXAi4G+U/DEutupX4uqwrnJPE9XPRPG6KJjAq1dBTmItXiJoAfMcJtyfciQ
         1dPMqkbDvPzyT0dfGFZh/jwhT2tM4b8TmydYLwpV+hP0w5+FVu83D1cpxr+gVaffjaNT
         aAjp2ave2wqww+aeGm1KjLio5c8L35O91teCISrJCUzYNCJKukF1EUttO8AEPoPytRk6
         kZHTn6a9qd2byJQUe02J/Z7lSDKKD0qoBK72WHIYtNPx1hlk8rvCaMzOIY4VlFNSFbIw
         SEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778617233; x=1779222033;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQzjdm8eFv/sznJvgMXu/FTaTbhPBF2kbyubytRDFJs=;
        b=pMLAvnKom9xl+t7AOFNhTCM5CfEdlAF4K+BF0210kiA1AjLe7ZSF3KSD66dOCNz2te
         tUpledUw7d5gNk4gTebCOO32kOcuotL5XzzEaVJVyvYCMbE3qixd9ILJ11/EqgbpVKt/
         thrs94bluE0EgvdwxchPXLve4hXL59HocyIkJT7aVJathcwykZgJXv9iYqt0/RVPouTu
         t9hT+NeIDWl25emWbi+paaBOdDV7nvq1MI0Meb69o2UhOLBD8NI5kwtK52usPoVZ1cpL
         i4Ops739xa3LxeKhVZpOByDdYE2Mk9HcF7UCuMSUMqH2ZNZutGEdS9DietUc8liWz9mq
         tjsA==
X-Forwarded-Encrypted: i=1; AFNElJ9YjulUiIXdpDBqgPobA7SVYW9dNaESNPKBrMA+IyViZdTu8d0LxZasO4glZxvGvyk9bb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl0HGuNsGadbLvmC9hccYJk+VIe9cP2xwQu6yicJwf7Kwbpt7w
	vHhJaxpCUxh158s04mhsbZ2IAUziDs54rdKj4kEArXqzFI8Z/Si2yxkU
X-Gm-Gg: Acq92OFHuBfkANXi56fleN/HdayBhVGtAu/0tzj66S0wz4mN8NZom0oLuCrtZULQoqi
	E/rdJogrLF7szni6hmIxl0fx21mB+ZxE01HeGUPKBTx40hZiq1OOfvcIBxtpV2WJQIa33BsnVgj
	3CiNRU6bCUmFo9F8rQ/zNXM9wUgTn4ahYZLvvk1wqTMRiVlth/gI2SZxYZOqJC2291AsEPVNZG9
	Iuqjewbe+SuAdiCsfR0OiYXAnIuYMCVGarkUVt9vXW9RErTdja561sZFZjnZPihoM2izGV+Ya1z
	kznAyGKRAX/SMEUw6FAdqLsqPjNr1+pyNryj29NEDq7QR8++VWAqNzCWSS+XSxmkH+9w3Oe+ZMK
	ruViSil8ysQjA9BwCfKMYtFVy6rK1sfSJyWUwSZ19Rzdp6maJUoa3dD6m1RQZOdHFjUs+s1kkvV
	CSf97rKtXt1vcA9K+m6UBjqW3KoS74qezBxbkeEcScT1KCNQfFAv6Q
X-Received: by 2002:a05:6a00:328c:b0:83e:cc27:9af7 with SMTP id d2e1a72fcca58-83f04279863mr159190b3a.31.1778617232647;
        Tue, 12 May 2026 13:20:32 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682abd39sm24975053b3a.52.2026.05.12.13.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:20:32 -0700 (PDT)
Message-ID: <cfdb2d4af893d70bcb15bcc22d6467f800b7291f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 08/12] bpf: Unify release handling for
 helpers and kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Tue, 12 May 2026 13:19:57 -0700
In-Reply-To: <20260506142709.2298255-9-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
	 <20260506142709.2298255-9-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:

LGTM, one question below.

> @@ -8010,28 +8010,15 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
>  		return err;
> =20
>  skip_type_check:
> -	if (arg_type_is_release(arg_type)) {
> -		if (!arg_type_is_dynptr(arg_type) && !reg->ref_obj_id && !bpf_register=
_is_null(reg)) {
> -			verbose(env, "R%d must be referenced when passed to release function\=
n",
> -				regno);
> -			return -EINVAL;
> -		}
> -		if (meta->release_regno) {
> -			verifier_bug(env, "more than one release argument");
> -			return -EFAULT;
> -		}
> -		meta->release_regno =3D regno;
> +	if (arg_type_is_release(arg_type) && !arg_type_is_dynptr(arg_type) &&
> +	    !reg->ref_obj_id && !bpf_register_is_null(reg)) {
> +		verbose(env, "release helper %s expects referenced PTR_TO_BTF_ID passe=
d to %s\n",
> +			func_id_name(meta->func_id), reg_arg_name(env, argno));
> +		return -EINVAL;

Nit: a similar check is added in check_kfunc_args(),
     can these be wrapped in some utility function?

>  	}
> =20
> -	if (reg->ref_obj_id && base_type(arg_type) !=3D ARG_KPTR_XCHG_DEST) {
> -		if (meta->release_regno && meta->ref_obj.cnt) {
> -			verbose(env, "more than one arg with ref_obj_id %s %u %u",
> -				reg_arg_name(env, argno), reg->ref_obj_id,
> -				meta->ref_obj.ref_obj_id);
> -			return -EACCES;
> -		}
> +	if (reg->ref_obj_id)
>  		update_ref_obj(&meta->ref_obj, reg);
> -	}
> =20
>  	switch (base_type(arg_type)) {
>  	case ARG_CONST_MAP_PTR:

[...]

> @@ -9825,7 +9883,7 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
>  	memset(&meta, 0, sizeof(meta));
>  	meta.pkt_access =3D fn->pkt_access;
> =20
> -	err =3D check_func_proto(fn);
> +	err =3D check_func_proto(fn, &meta);
>  	if (err) {
>  		verifier_bug(env, "incorrect func proto %s#%d", func_id_name(func_id),=
 func_id);
>  		return err;
> @@ -9870,37 +9928,11 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>  	}
> =20
>  	if (meta.release_regno) {
> -		err =3D -EINVAL;
> -		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1])) =
{
> -			err =3D unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
> -		} else if (func_id =3D=3D BPF_FUNC_kptr_xchg && meta.ref_obj.ref_obj_i=
d) {
> -			u32 ref_obj_id =3D meta.ref_obj.ref_obj_id;
> -			bool in_rcu =3D in_rcu_cs(env);
> -			struct bpf_func_state *state;
> -			struct bpf_reg_state *reg;
> -
> -			err =3D release_reference_nomark(env->cur_state, ref_obj_id);
> -			if (!err) {
> -				bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
> -					if (reg->ref_obj_id =3D=3D ref_obj_id) {
> -						if (in_rcu && (reg->type & MEM_ALLOC) && (reg->type & MEM_PERCPU))=
 {
> -							reg->ref_obj_id =3D 0;
> -							reg->type &=3D ~MEM_ALLOC;
> -							reg->type |=3D MEM_RCU;
> -						} else {
> -							mark_reg_invalid(env, reg);

Note: release_reg() does not have this 'else' path, but it seem to be not a=
 problem,
      assuming that MEM_ALLOC | MEM_PERCPU registers are generated only fro=
m some
      other cmp_xchg call. Is that the case?

> -						}
> -					}
> -				}));
> -			}
> -		} else if (meta.ref_obj.ref_obj_id) {
> -			err =3D release_reference(env, meta.ref_obj.ref_obj_id);
> -		} else if (bpf_register_is_null(&regs[meta.release_regno])) {
> -			/* meta.ref_obj.ref_obj_id can only be 0 if register that is meant to=
 be
> -			 * released is NULL, which must be > R0.
> -			 */
> -			err =3D 0;
> -		}
> +		struct bpf_reg_state *reg =3D &regs[meta.release_regno];
> +		bool convert_rcu =3D (func_id =3D=3D BPF_FUNC_kptr_xchg) && in_rcu_cs(=
env) &&
> +				   (reg->type & MEM_ALLOC) && (reg->type & MEM_PERCPU);
> +
> +		err =3D release_reg(env, reg, convert_rcu, !!meta.dynptr.ref_obj_id);
>  		if (err)
>  			return err;
>  	}

[...]

> @@ -11609,18 +11640,16 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
>  			return -EACCES;
>  		}
> =20
> -		if (reg->ref_obj_id) {
> -			if (is_kfunc_release(meta) && meta->ref_obj.cnt) {
> -				verbose(env, "more than one arg with ref_obj_id %s %u %u",
> -					reg_arg_name(env, argno), reg->ref_obj_id,
> -					meta->ref_obj.ref_obj_id);
> -				return -EFAULT;
> -			}
> -			update_ref_obj(&meta->ref_obj, reg);
> -			if (is_kfunc_release(meta))
> -				meta->release_regno =3D regno;
> +		if (regno =3D=3D meta->release_regno && !is_kfunc_arg_dynptr(meta->btf=
, &args[i]) &&
> +		    !reg->ref_obj_id && !bpf_register_is_null(reg)) {
> +			verbose(env, "release kfunc %s expects referenced PTR_TO_BTF_ID passe=
d to %s\n",
> +				func_name, reg_arg_name(env, argno));
> +			return -EINVAL;
>  		}
> =20
> +		if (reg->ref_obj_id)
> +			update_ref_obj(&meta->ref_obj, reg);
> +
>  		ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
>  		ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
> =20

[...]
