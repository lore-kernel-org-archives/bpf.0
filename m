Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FBC3563C9
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710175; cv=pass; b=UtXjyi+r/KFxAVGFor/ciK5HFvkSz8poMJw2U65cKwJMOPwAlQyB/yOnocXfZU09JiXROg1vB8499BAJFJ1ue6pcyJgHOQ1nOQDwOQvP6pfHLDS5YylvS348+4HFDfeCt7buUGQUEtaCK2SfGD7tV10i8NA+U9j7TdYWYY9Dq2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710175; c=relaxed/simple;
	bh=WCflg43bXceuhdXcuspEJ/QhsFBrp4a/hOgWtlEBfek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQd7AkvD/HC5nUmtwrIYKGoK/OGBYiZa+IGLIFkRd2VYGGummnoJr1QVwvX+ycww1sfrvKeKRdMZdAcH6Sn5Woj7AYRNbsK4ZspNW8oJ60kWqJw1DDtOVx6wJ8EnwBSrDHaV9UHDXedq280/uqaCWYjy2n2QwOEV/e9q88VsIP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMH7Ifgh; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMH7Ifgh"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64965ee303dso1276042d50.0
        for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 10:09:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769710173; cv=none;
        d=google.com; s=arc-20240605;
        b=Z0DrPaPXUeGPNQjImVFNGfueEj4NgGGis1a91Wfd4JiyKcXHKJZEmOkaq7wxNEI9D8
         4XQcLVf6cRUXLEXtN4+hltm88tNn1OAYm0TlxN9mvMsZQtQo9P5QLQPvGTo9ram8+wN+
         Ib06k/3MI9LV/b7lLVF8msdhGBWyAOl8f5fXMhvaHI7sicQXC+9Sbb5Yr4qNTZfBNEjC
         Y8hmuGiKvY2XkWtFZr90GK2cKhRgWQcnlnz8uK88dnaIHO7Ym03HpWzccj07uBlsQLMW
         OJxdvIVNuoVTL48VaXT9I12L5IDOSFxDggu6+ls6q0V826cF0B0WL7Lk5h4KhkLgbnlW
         m32w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XB53foOMk6x3HwSeG6HDxO7PLPG3y7YUAlAI2KPZ36Y=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=GM6e6RDiBR2dy1ogy9mz8JFB3Bwma8lqsEEcU4pw5I6nVw/eJd+Fz4bZFRNc54sDN8
         HCFmv4q9FXstanUi2DnFw6tJ+zAsnvLolmqESamsRchnQHhWoDDrT0Qie+oFY9TolYL7
         a0dLqssc0JStG3ktTMShrMU26hwjtRJChzqTQKUKWFAXKUrdDSNCdTocl6OYiyJIold1
         rkSbljTTBqgBt0d2JaiP/XNfKf4CeRbwCvRcWbAWabKmNhBTjSzG0fyz6OT6vkTT5OUL
         SLnDUtmYACt/uEZSDM9X0DDVgtf8q5tlXTdsiLzVV0HRGbJPNRvc781XUYV2kX7FNmZv
         Epqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769710173; x=1770314973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XB53foOMk6x3HwSeG6HDxO7PLPG3y7YUAlAI2KPZ36Y=;
        b=PMH7IfghaemZIddZGQAa1GTWCtEDIuQBef1F9PGbNjy6PuliSfrjX2Jp/ZEuIeFHjw
         ++w8xLIUQCfRpSyUZrsQPMPPKIGvWRacoANOuuIs8PS4LqisRlyr7z2YVHVtu2ewa+vk
         edUcPYl1W3t5sZy9otU35Y6ixGh3ahH2T9h7wVrKW+ndnxiJqdJOBW7VvNHZNYvjrqx8
         GYKy8V0glW4pb0L95vdrxBC/iX8ClwpRN2dUQz3s8iNBADeTjDrWJoBGo0NWZgoeQcx7
         J4VcYm7n2+AZQdSjWDmR6VpFfIumz8i6ZvS1HOhmK297Kgv4uZIUY5AWohUnaTNK1ApI
         MYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769710173; x=1770314973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XB53foOMk6x3HwSeG6HDxO7PLPG3y7YUAlAI2KPZ36Y=;
        b=Lgc9CobTH6r7frO9nnJ2A6KZjchv92ri4aEfuWN4LV85xftoet4QFUXwX89dQpNuwY
         DyjSfsY5Oz4uILyic90QHdiN3h2vTr6fNAwTisN4JYzlNlFL1vJvWkbfvPisDafjlOBg
         HJmHhTlY9BaLSur241HcirYjLL6SyShHb2aJFMcFmdS/oGc/HGMzHdngCb3LakpLA9L8
         eKDu2UcM+IrWZ9Oesn8tQCHRigH5vRoPmKC/DQA41+rlrw3TX4x2Z7zZ32Rhvks0J8mp
         I1rGtBxMAJSbvtfthTmL5aps6yN2SyumPKvcQFjO57XigW5NT/HDo1y00nkpf8spwSDd
         k+YQ==
X-Gm-Message-State: AOJu0Ywzofciyi9PIq/dinawLaMJICLpotnoSWWZeMsG0VzKBd5OHKVe
	EXD5KQnWTgdHMw5S3cpnmqpqAiumU3TJ6iCRqMUgwLa/gXkun7NtPYCMd/Jnl6NIOG4X9+ipSCF
	x+YZ2g/jvEOGYMoDuyOAkoaKAiy0ASrE=
X-Gm-Gg: AZuq6aLSt2YjTwhd0381wqbUu1fMZAP5C1PzFGZKI7VS3eWXlrDbN2SRO3sMrN2PXI3
	UGuVPT0G2JFxMhOm8whNPhIS3ot4GIWNxX1KmJ5jDk1mHKuT9TSi56IfZ10ljlKEnBxLZk9OTlN
	5QhfdQHZXbvRVUTrGaaJc8kldtMs+V2iNnNVDZjqNWM7RGpdW9lGgaQ5C8DaCwx3qRB5HmOHh5v
	uYgkSmtjG09wrAebBZGkNBaNXi6VAsIh9MgE+jkSspisQHlK37aBoMTsDtTBUjmFt0pQuo=
X-Received: by 2002:a05:690e:1445:b0:649:3b6f:28e8 with SMTP id
 956f58d0204a3-649a83939b8mr256230d50.8.1769710172742; Thu, 29 Jan 2026
 10:09:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129-verif_special_fields-v1-0-d310b7f146c8@meta.com> <20260129-verif_special_fields-v1-1-d310b7f146c8@meta.com>
In-Reply-To: <20260129-verif_special_fields-v1-1-d310b7f146c8@meta.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 29 Jan 2026 10:09:21 -0800
X-Gm-Features: AZwV_QgXN4TOhxobPCZRWEC2-6dpJYKFwTfrZlkeuHRuKagZ10RsGKaSCvIUHbU
Message-ID: <CAMB2axOYwGFzB3eO8=pmAhF6qPJrZpgLEO-qWMUdTZcM4L+08g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce struct bpf_map_desc in verifier
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 9:38=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Introduce struct bpf_map_desc to hold bpf_map pointer and map uid. Use
> this struct in both bpf_call_arg_meta and bpf_kfunc_call_arg_meta
> instead of having different representations:
>  - bpf_call_arg_meta had separate map_ptr and map_uid fields
>  - bpf_kfunc_call_arg_meta had an anonymous inline struct
>
> This unifies the map fields layout across both metadata structures,
> making the code more consistent and preparing for further refactoring of
> map field pointer validation.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/verifier.c | 79 ++++++++++++++++++++++++++-------------------=
------
>  1 file changed, 40 insertions(+), 39 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c2f2650db9fdf71737eecd56febbe3cbf8fe42b4..2c5fb7be73923b9f8395a6fae=
53209f002c48fd1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -272,8 +272,13 @@ static bool bpf_pseudo_kfunc_call(const struct bpf_i=
nsn *insn)
>                insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL;
>  }
>
> +struct bpf_map_desc {
> +       struct bpf_map *ptr;
> +       int uid;
> +};
> +
>  struct bpf_call_arg_meta {
> -       struct bpf_map *map_ptr;
> +       struct bpf_map_desc map;
>         bool raw_mode;
>         bool pkt_access;
>         u8 release_regno;
> @@ -283,7 +288,6 @@ struct bpf_call_arg_meta {
>         u64 msize_max_value;
>         int ref_obj_id;
>         int dynptr_id;
> -       int map_uid;
>         int func_id;
>         struct btf *btf;
>         u32 btf_id;
> @@ -351,10 +355,7 @@ struct bpf_kfunc_call_arg_meta {
>                 u8 spi;
>                 u8 frameno;
>         } iter;
> -       struct {
> -               struct bpf_map *ptr;
> -               int uid;
> -       } map;
> +       struct bpf_map_desc map;
>         u64 mem_size;
>  };
>
> @@ -8666,7 +8667,7 @@ static int process_timer_func(struct bpf_verifier_e=
nv *env, int regno,
>         if (err)
>                 return err;
>
> -       if (meta->map_ptr) {
> +       if (meta->map.ptr) {
>                 verifier_bug(env, "Two map pointers in a timer helper");
>                 return -EFAULT;
>         }
> @@ -8674,8 +8675,8 @@ static int process_timer_func(struct bpf_verifier_e=
nv *env, int regno,
>                 verbose(env, "bpf_timer cannot be used for PREEMPT_RT.\n"=
);
>                 return -EOPNOTSUPP;
>         }
> -       meta->map_uid =3D reg->map_uid;
> -       meta->map_ptr =3D map;
> +       meta->map.uid =3D reg->map_uid;
> +       meta->map.ptr =3D map;
>         return 0;
>  }
>
> @@ -8739,7 +8740,7 @@ static int process_kptr_func(struct bpf_verifier_en=
v *env, int regno,
>                         return -EINVAL;
>                 }
>                 rec =3D map_ptr->record;
> -               meta->map_ptr =3D map_ptr;
> +               meta->map.ptr =3D map_ptr;
>         }
>
>         if (!tnum_is_const(reg->var_off)) {
> @@ -9246,13 +9247,13 @@ static int resolve_map_arg_type(struct bpf_verifi=
er_env *env,
>                                  const struct bpf_call_arg_meta *meta,
>                                  enum bpf_arg_type *arg_type)
>  {
> -       if (!meta->map_ptr) {
> +       if (!meta->map.ptr) {
>                 /* kernel subsystem misconfigured verifier */
>                 verifier_bug(env, "invalid map_ptr to access map->type");
>                 return -EFAULT;
>         }
>
> -       switch (meta->map_ptr->map_type) {
> +       switch (meta->map.ptr->map_type) {
>         case BPF_MAP_TYPE_SOCKMAP:
>         case BPF_MAP_TYPE_SOCKHASH:
>                 if (*arg_type =3D=3D ARG_PTR_TO_MAP_VALUE) {
> @@ -9906,7 +9907,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
>         switch (base_type(arg_type)) {
>         case ARG_CONST_MAP_PTR:
>                 /* bpf_map_xxx(map_ptr) call: remember that map_ptr */
> -               if (meta->map_ptr) {
> +               if (meta->map.ptr) {
>                         /* Use map_uid (which is unique id of inner map) =
to reject:
>                          * inner_map1 =3D bpf_map_lookup_elem(outer_map, =
key1)
>                          * inner_map2 =3D bpf_map_lookup_elem(outer_map, =
key2)
> @@ -9919,23 +9920,23 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
>                          *
>                          * Comparing map_ptr is enough to distinguish nor=
mal and outer maps.
>                          */
> -                       if (meta->map_ptr !=3D reg->map_ptr ||
> -                           meta->map_uid !=3D reg->map_uid) {
> +                       if (meta->map.ptr !=3D reg->map_ptr ||
> +                           meta->map.uid !=3D reg->map_uid) {
>                                 verbose(env,
>                                         "timer pointer in R1 map_uid=3D%d=
 doesn't match map pointer in R2 map_uid=3D%d\n",
> -                                       meta->map_uid, reg->map_uid);
> +                                       meta->map.uid, reg->map_uid);
>                                 return -EINVAL;
>                         }
>                 }
> -               meta->map_ptr =3D reg->map_ptr;
> -               meta->map_uid =3D reg->map_uid;
> +               meta->map.ptr =3D reg->map_ptr;
> +               meta->map.uid =3D reg->map_uid;

I was also working on this part when unifying bpf_call_arg_meta and
bpf_kfunc_call_arg_meta. The check and setting bpf_map_desc is almost
the same for kfunc and helper. Maybe extract this part out as a
function?

>                 break;
>         case ARG_PTR_TO_MAP_KEY:
>                 /* bpf_map_xxx(..., map_ptr, ..., key) call:
>                  * check that [key, key + map->key_size) are within
>                  * stack limits and initialized
>                  */
> -               if (!meta->map_ptr) {
> +               if (!meta->map.ptr) {
>                         /* in function declaration map_ptr must come befo=
re
>                          * map_key, so that it's verified and known befor=
e
>                          * we have to check map_key here. Otherwise it me=
ans
> @@ -9944,11 +9945,11 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
>                         verifier_bug(env, "invalid map_ptr to access map-=
>key");
>                         return -EFAULT;
>                 }
> -               key_size =3D meta->map_ptr->key_size;
> +               key_size =3D meta->map.ptr->key_size;
>                 err =3D check_helper_mem_access(env, regno, key_size, BPF=
_READ, false, NULL);
>                 if (err)
>                         return err;
> -               if (can_elide_value_nullness(meta->map_ptr->map_type)) {
> +               if (can_elide_value_nullness(meta->map.ptr->map_type)) {
>                         err =3D get_constant_map_key(env, reg, key_size, =
&meta->const_map_key);
>                         if (err < 0) {
>                                 meta->const_map_key =3D -1;
> @@ -9966,13 +9967,13 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
>                 /* bpf_map_xxx(..., map_ptr, ..., value) call:
>                  * check [value, value + map->value_size) validity
>                  */
> -               if (!meta->map_ptr) {
> +               if (!meta->map.ptr) {
>                         /* kernel subsystem misconfigured verifier */
>                         verifier_bug(env, "invalid map_ptr to access map-=
>value");
>                         return -EFAULT;
>                 }
>                 meta->raw_mode =3D arg_type & MEM_UNINIT;
> -               err =3D check_helper_mem_access(env, regno, meta->map_ptr=
->value_size,
> +               err =3D check_helper_mem_access(env, regno, meta->map.ptr=
->value_size,
>                                               arg_type & MEM_WRITE ? BPF_=
WRITE : BPF_READ,
>                                               false, meta);
>                 break;
> @@ -11310,7 +11311,7 @@ record_func_map(struct bpf_verifier_env *env, str=
uct bpf_call_arg_meta *meta,
>                 int func_id, int insn_idx)
>  {
>         struct bpf_insn_aux_data *aux =3D &env->insn_aux_data[insn_idx];
> -       struct bpf_map *map =3D meta->map_ptr;
> +       struct bpf_map *map =3D meta->map.ptr;
>
>         if (func_id !=3D BPF_FUNC_tail_call &&
>             func_id !=3D BPF_FUNC_map_lookup_elem &&
> @@ -11343,11 +11344,11 @@ record_func_map(struct bpf_verifier_env *env, s=
truct bpf_call_arg_meta *meta,
>         }
>
>         if (!aux->map_ptr_state.map_ptr)
> -               bpf_map_ptr_store(aux, meta->map_ptr,
> -                                 !meta->map_ptr->bypass_spec_v1, false);
> -       else if (aux->map_ptr_state.map_ptr !=3D meta->map_ptr)
> -               bpf_map_ptr_store(aux, meta->map_ptr,
> -                                 !meta->map_ptr->bypass_spec_v1, true);
> +               bpf_map_ptr_store(aux, meta->map.ptr,
> +                                 !meta->map.ptr->bypass_spec_v1, false);
> +       else if (aux->map_ptr_state.map_ptr !=3D meta->map.ptr)
> +               bpf_map_ptr_store(aux, meta->map.ptr,
> +                                 !meta->map.ptr->bypass_spec_v1, true);
>         return 0;
>  }
>
> @@ -11357,7 +11358,7 @@ record_func_key(struct bpf_verifier_env *env, str=
uct bpf_call_arg_meta *meta,
>  {
>         struct bpf_insn_aux_data *aux =3D &env->insn_aux_data[insn_idx];
>         struct bpf_reg_state *reg;
> -       struct bpf_map *map =3D meta->map_ptr;
> +       struct bpf_map *map =3D meta->map.ptr;
>         u64 val, max;
>         int err;
>
> @@ -11913,22 +11914,22 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
>                  * can check 'value_size' boundary of memory access
>                  * to map element returned from bpf_map_lookup_elem()
>                  */
> -               if (meta.map_ptr =3D=3D NULL) {
> +               if (meta.map.ptr =3D=3D NULL) {
>                         verifier_bug(env, "unexpected null map_ptr");
>                         return -EFAULT;
>                 }
>
>                 if (func_id =3D=3D BPF_FUNC_map_lookup_elem &&
> -                   can_elide_value_nullness(meta.map_ptr->map_type) &&
> +                   can_elide_value_nullness(meta.map.ptr->map_type) &&
>                     meta.const_map_key >=3D 0 &&
> -                   meta.const_map_key < meta.map_ptr->max_entries)
> +                   meta.const_map_key < meta.map.ptr->max_entries)
>                         ret_flag &=3D ~PTR_MAYBE_NULL;
>
> -               regs[BPF_REG_0].map_ptr =3D meta.map_ptr;
> -               regs[BPF_REG_0].map_uid =3D meta.map_uid;
> +               regs[BPF_REG_0].map_ptr =3D meta.map.ptr;
> +               regs[BPF_REG_0].map_uid =3D meta.map.uid;
>                 regs[BPF_REG_0].type =3D PTR_TO_MAP_VALUE | ret_flag;
>                 if (!type_may_be_null(ret_flag) &&
> -                   btf_record_has_field(meta.map_ptr->record, BPF_SPIN_L=
OCK | BPF_RES_SPIN_LOCK)) {
> +                   btf_record_has_field(meta.map.ptr->record, BPF_SPIN_L=
OCK | BPF_RES_SPIN_LOCK)) {
>                         regs[BPF_REG_0].id =3D ++env->id_gen;
>                 }
>                 break;
> @@ -12031,7 +12032,7 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>         if (type_may_be_null(regs[BPF_REG_0].type))
>                 regs[BPF_REG_0].id =3D ++env->id_gen;
>
> -       if (helper_multiple_ref_obj_use(func_id, meta.map_ptr)) {
> +       if (helper_multiple_ref_obj_use(func_id, meta.map.ptr)) {
>                 verifier_bug(env, "func %s#%d sets ref_obj_id more than o=
nce",
>                              func_id_name(func_id), func_id);
>                 return -EFAULT;
> @@ -12043,7 +12044,7 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>         if (is_ptr_cast_function(func_id) || is_dynptr_ref_function(func_=
id)) {
>                 /* For release_reference() */
>                 regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj_id;
> -       } else if (is_acquire_function(func_id, meta.map_ptr)) {
> +       } else if (is_acquire_function(func_id, meta.map.ptr)) {
>                 int id =3D acquire_reference(env, insn_idx);
>
>                 if (id < 0)
> @@ -12058,7 +12059,7 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>         if (err)
>                 return err;
>
> -       err =3D check_map_func_compatibility(env, meta.map_ptr, func_id);
> +       err =3D check_map_func_compatibility(env, meta.map.ptr, func_id);
>         if (err)
>                 return err;
>
>
> --
> 2.52.0
>
