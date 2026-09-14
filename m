Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3025B1474CC
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 00:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789344366; cv=pass; b=Y66oQGnBuBRKKbYArnufP9n6r7IxUOwKL8hsx4TgKQlxifyEwu/HumdnsMQBqJUCWzqd6/IgglRgFM2ZLXWc+Ukm2GCI927NSioZ3QKG7tcUvi5T0zb6aNSJXYB55FPGnKxyTuUUQMPfp2J7oc+Ij+rNhqOdI/7nh67KPvCYqE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789344366; c=relaxed/simple;
	bh=hgdGE5sYcbFJDYM69F4Ean8ruOChQnWbub/CqEJnfb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghe1eTbKlLZ0PpSpfj5wDaa1IGvnhxdllcKEkjiOhrYPXlYskWvVF0bMoBoBdtZJAPiIL6mTi+azY5Un7zXKKZPFbQyAHNnHEZvXhU/Tw9Usj7XX7xlx/KLcErDI5blEJJ9c3ml7MnvsNZCWxCf9IvvYSdK9iEZ9ZdwsIWsvzwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKkX11/a; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKkX11/a"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-80576d65d8eso1846026a34.1
        for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 17:06:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789344363; cv=none;
        d=google.com; s=arc-20260327;
        b=Enay+aTbJ7gYK+Qn5+CnJMjoZCONRBs8bSxZqzAVKQhsm83cYEsbBTCWjID3LHFF7f
         F85pwdTR8Edr2tSslA9V7Npo3EVR8nMPfTEMX+H1zk7yJz1Bk2d5Xn5JdKEoWMx5AiUB
         2E6n9bQauGKBOBDfoVEWnR0CIPjLB9e7Fwu9jW2K86KX+7iPs2RWFRkApXpkUptbhDUi
         wwcnfjL62r6v1pevoW5ehsr2pPuIfrfAcafDG8s56ZkcZlYzrb38FFxTIZgYKwCnJqnF
         1ruCqO4wz+Fw5elNG0Fp1jZ22cfP3vxE6g7/6gIzZgcX0TslHNcXeGKDsAJIWmqu9U7V
         5wtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OLS3kxGfJ9AhweQjgGXTWR/VA6fpoXFQK7nq/QkFZo4=;
        fh=b0nTke/dWNZNVxYYun7OzhjBPrEmqbca3P2CX/fBOFk=;
        b=UA9oK5kktaZeEJQGXNsNQNr7RBASdZwWC6WLAFOEpIzjF4Lsj/2HWumyV8rNPsCAon
         IaiMLFF/FeOuCRF2eucl5ZhTW4Q+6Grv+Yplz9RJ6y5UR1Pke7shahhBhlpg6DfDL1+b
         CHt+6C3ILw1IrkX3Rmx3k3W6FC+CffjG6b3Bs+5/tcpLDo/O9TPAlZDpVVKLaEPgM3qV
         bWarBJvch+qKNAf2R1XqDU4fIWqoQcg1mSylGVGVgE221ocEWP049HmcMGWguR5lQtAe
         d7TrBlU+F5yV31842rAw7kAlJxMdc7Lb79eXlfPhHxXzu0dHCuTe9D0qHSqvXAcTIhRq
         i+Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789344363; x=1789949163; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OLS3kxGfJ9AhweQjgGXTWR/VA6fpoXFQK7nq/QkFZo4=;
        b=VKkX11/aoa5VGNSUCf7dXqhLExXTvua/TtEaK5lEyPaNXFvPwUW0ev0HDlwYVagd44
         rJNQkBgxoHSXM0IAuVC1BvA20TB4fTnxNzlkHgVTIUxCT38V8i89O+D2ypcJGzAF0U7/
         uB8tcy2SbeD4hDV+l33/B77ONi3C06JkIayrf4wEWLGCmzFyFye1NeN4BjATTRQDRyYf
         sXBpMDi70F8wuWmrymHDuOd4Q0BhqXttQlI16Ui95roemt/X597v3t47y6i6sWi18t6O
         /Bt2ZdcqMm3Vtzm0DRQqhRBdX2ykw0n54Joe3Ho7IXpo9TkawrCDABJ5SoD4NXXPu5XI
         5tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789344363; x=1789949163;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OLS3kxGfJ9AhweQjgGXTWR/VA6fpoXFQK7nq/QkFZo4=;
        b=W81lKkrRqiSG8GnP+FYydCn5qNJCvCnoCsxQy9vldiIfHQEg270qF6ZcBRt898eNZN
         uDdlOw/uIzLQRKEU6uuu2eipnHYkfR5sDrNUKKVuBPfxA/3x3shX4HhD453lVls7GHaO
         fJVFEt36ZMw8opjNpXDQMSsrSzmqacydF63FPWwESB5t+WYNzx87PLj43BKxthO+fLQC
         vHq5TtxRsMmYEDS1E3+sbYqLnuGdykm2wEbd+32730wACQk4eUegPYpV1oNmAYhfj1zZ
         97dZUmmCZZt6UYSpFO9WxKeS4LZX4V8FkIf+yXBzNW6ne/kzhLR54lZTch3oS7lelyXf
         tMrQ==
X-Gm-Message-State: AFuF++mP79OV4CE8RN5mlzkM8GiKOYFql4h9FrpUbKFMUD+Yqe5BGqJY
	chAyOEORBoiJCgqTcqggrMyr93oY6b64UA4JmKZsgWpDWrV2QkUYnQqExzmu7r3WgEU+0RSuHQO
	qEdhFib4MbRa2wmnXzWtdKUqF4K2K7L8=
X-Gm-Gg: AYBFou219PzV064p9ptRPyR1KXtjcf9L0cF/xGo4chKAcZau29GF6Xm2JOQTLqm7kBa
	jeUkcNCP9Hmxh07mR0za5KRfnqVFwpA5yxNhn1eqqIlyi6lQvR4N/3wa/hDHnWtl/le6eamuyMK
	PF6qu3+pvRaTp1Bd2F/XJ/hd7e81gAQmvG8SjgLmZbxIsdvwoYQvvalxjns/0spUS/Drf9AI2Nk
	0zDDQRch45ScJRUv2BwLPvcOHpt4SzKGnSy+eopqLuzlvPzemoILNUcWcdG6mkwwHNA07xVskNh
	cXam76Yhr9933iEKSU4PjZALN+5OLsYUFYN2STDgS0rhvAwNEtuUeTQ=
X-Received: by 2002:a05:6820:4cc1:b0:6ac:b6c0:2c09 with SMTP id
 006d021491bc7-6c53f74c169mr59942eaf.1.1789344362855; Sun, 13 Sep 2026
 17:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911084254.3481508-1-xyx2021@mail.ustc.edu.cn> <20260911084254.3481508-2-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20260911084254.3481508-2-xyx2021@mail.ustc.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Sun, 13 Sep 2026 17:05:51 -0700
X-Gm-Features: AcwNN1WaQE8Obc9QPXlYgcMKdax2wlB5qSFPnqPbBOB1HXBeyKi69v0MQ3GqHhg
Message-ID: <CAMB2axMX07j49sZRmGFm2s==FMgKFzvKPWxc8hDvU=b3Lp=VOg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Invalidate iterator-owned BTF pointers on
 next and destroy
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan <puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 1:43=E2=80=AFAM Xu Yunxiang <xyx2021@mail.ustc.edu.=
cn> wrote:
>
> Open-coded iterator next kfuncs that return non-struct pointers associate
> the returned PTR_TO_MEM with the iterator's reference ID. Struct pointer
> returns take a separate PTR_TO_BTF_ID path which omits this relationship.
>
> This leaves such pointers verifier-valid after their lifetime ends. The
> task_vma iterator resets its VMA snapshot and drops the previous vm_file
> reference when next advances, then frees the snapshot on destroy. Other
> non-RCU struct iterators also release or replace their previous element o=
n
> advance.
>
> A trusted field derived from an iterator result can also back a
> resource-tracked object. In particular, bpf_dynptr_from_file() does not
> take its own file reference. Losing vm_file's iterator parent while
> constructing a FILE dynptr therefore lets the dynptr outlive the snapshot=
's
> file reference.
>
> Associate non-RCU PTR_TO_BTF_ID results with the iterator reference. Befo=
re
> modeling another next result, invalidate older BTF pointers carrying that
> parent. Do this before constructing R0 and for both the ACTIVE and DRAINE=
D
> iterator branches. The existing iterator reference release invalidates th=
e
> current result on destroy.
>
> Preserve the parent across BTF field loads when the result remains fully
> trusted and its lifetime is tied to the parent. Do not propagate it to
> MEM_RCU, MEM_PERCPU, MEM_USER, or untrusted results, whose lifetime or
> access domain follows separate rules.
>
> When bpf_dynptr_from_file() consumes a borrowed file carrying such a
> parent, use that parent as the FILE dynptr's lifetime anchor. Reject
> iterator next or destroy while a resource child remains live, requiring
> the program to discard the dynptr before its backing file can be released=
.

This indeed is a gap in ref_obj tracking: it records a source that
owns a reference, but misses a borrowed object carrying a
verifier-tracked lifetime, such as a trusted pointer obtained by
walking an iterator result. I suggest handling this generically for
dynptr constructors. Except for bpf_dynptr_clone(), all current
constructors take their backing object in R1, so record R1=E2=80=99s lifeti=
me
ID when it either owns a reference or carries a parent_id.

>
> This issue was found during BPF verifier testing with an in-house runtime
> semantic checker.
>
> Fixes: 4cbee026db54 ("bpf: return VMA snapshot from task_vma iterator")
> Suggested-by: Amery Hung <ameryhung@gmail.com>
> Link: https://lore.kernel.org/bpf/CAMB2axMV4rZ_Mb91OdzGH6T4Yym7nB+wz+EtxP=
_wUEniwA+EzA@mail.gmail.com
> Assisted-by: LLM
> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
> ---
>  include/linux/bpf_verifier.h |   6 +-
>  kernel/bpf/verifier.c        | 110 ++++++++++++++++++++++++++++-------
>  2 files changed, 92 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 36b65797877d0..ae30df629d5b3 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1518,9 +1518,9 @@ struct bpf_dynptr_desc {
>
>  /*
>   * The last seen rereferenced object; Updated by update_ref_obj() when a=
 register refers to a
> - * referenced object. Used when the helper or kfunc is casting a referen=
ced object, returning
> - * allocated memory derived from referenced object or creating a dynptr =
with a referenced
> - * object as parent.
> + * referenced object or another verifier-tracked lifetime anchor. Used w=
hen the helper or kfunc
> + * is casting a referenced object, returning allocated memory derived fr=
om a referenced object
> + * or creating a dynptr whose backing object has a tracked lifetime.
>   */
>  struct ref_obj_desc {
>         u32 id;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 72a3f5998dd27..eb013954182f2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -238,13 +238,18 @@ static void bpf_map_key_store(struct bpf_insn_aux_d=
ata *aux, u64 state)
>                              (poisoned ? BPF_MAP_KEY_POISON : 0ULL);
>  }
>
> -static void update_ref_obj(struct ref_obj_desc *ref_obj, struct bpf_reg_=
state *reg)
> +static void update_ref_obj_id(struct ref_obj_desc *ref_obj, u32 id, u32 =
parent_id)
>  {
> -       ref_obj->id =3D reg->id;
> -       ref_obj->parent_id =3D reg->parent_id;
> +       ref_obj->id =3D id;
> +       ref_obj->parent_id =3D parent_id;
>         ref_obj->cnt++;
>  }

Please keep update_ref_obj() unchanged rather than adding a second form. I
think the missing abstraction is the lifetime ID of a register:

static u32 reg_lifetime_id(struct bpf_verifier_env *env,
                           const struct bpf_reg_state *reg)
{
        reg_is_referenced(env, reg) ? reg->id : reg->parent_id;
}

The first case is an owned reference; the second is a borrowed pointer tied=
 to
another object's lifetime. This should not change reg_is_referenced(), sinc=
e a
borrowed pointer must not become releasable itself.

>
> +static void update_ref_obj(struct ref_obj_desc *ref_obj, struct bpf_reg_=
state *reg)
> +{
> +       update_ref_obj_id(ref_obj, reg->id, reg->parent_id);
> +}
> +
>  static int validate_ref_obj(struct bpf_verifier_env *env, struct ref_obj=
_desc *ref_obj)
>  {
>         if (ref_obj->cnt > 1) {
> @@ -977,7 +982,7 @@ static int unmark_stack_slots_iter(struct bpf_verifie=
r_env *env,
>                                    struct bpf_reg_state *reg, int nr_slot=
s)
>  {
>         struct bpf_func_state *state =3D bpf_func(env, reg);
> -       int spi, i, j;
> +       int spi, i, j, err;
>
>         spi =3D iter_get_spi(env, reg, nr_slots);
>         if (spi < 0)
> @@ -987,8 +992,11 @@ static int unmark_stack_slots_iter(struct bpf_verifi=
er_env *env,
>                 struct bpf_stack_state *slot =3D &state->stack[spi - i];
>                 struct bpf_reg_state *st =3D &slot->spilled_ptr;
>
> -               if (i =3D=3D 0)
> -                       WARN_ON_ONCE(release_reference(env, st->id));
> +               if (i =3D=3D 0) {
> +                       err =3D release_reference(env, st->id);
> +                       if (err)
> +                               return err;
> +               }
>
>                 bpf_mark_reg_not_init(env, st);
>
> @@ -6140,9 +6148,16 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
>         }
>
>         if (atype =3D=3D BPF_READ && value_regno >=3D 0) {
> -               ret =3D mark_btf_ld_reg(env, regs, value_regno, ret, reg-=
>btf, btf_id, flag);
> +               enum bpf_reg_type reg_type =3D ret;
> +               u32 parent_id =3D reg->parent_id;
> +
> +               ret =3D mark_btf_ld_reg(env, regs, value_regno, reg_type,
> +                                     reg->btf, btf_id, flag);
>                 if (ret < 0)
>                         return ret;
> +               if ((regs[value_regno].type & PTR_TRUSTED) &&
> +                   !(regs[value_regno].type & (MEM_RCU | MEM_PERCPU | ME=
M_USER)))
> +                       regs[value_regno].parent_id =3D parent_id;

parent_id should be the source's lifetime ID, computed before mark_btf_ld_r=
eg().

>         }
>
>         return 0;
> @@ -9456,6 +9471,24 @@ static int idstack_pop(struct bpf_idmap *idmap)
>         return idmap->map[--idmap->cnt].old;
>  }
>
> +static int check_reference_children(struct bpf_verifier_env *env, int pa=
rent_id)

Perhaps call this check_reference_children_leak(), since it specifically
detects leaked child references. There may also be an opportunity to share =
the
scan/reporting logic with check_reference_leak().

> +{
> +       struct bpf_verifier_state *vstate =3D env->cur_state;
> +       int i;
> +
> +       for (i =3D 0; i < vstate->acquired_refs; i++) {
> +               if (vstate->refs[i].type !=3D REF_TYPE_PTR)
> +                       continue;
> +               if (vstate->refs[i].parent_id !=3D parent_id)
> +                       continue;
> +               verbose(env, "Leaking reference id=3D%d alloc_insn=3D%d. =
Release it first.\n",
> +                       vstate->refs[i].id, vstate->refs[i].insn_idx);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  /* Release id and objects derived from it iteratively in a DFS manner */
>  static int release_reference(struct bpf_verifier_env *env, int id)
>  {
> @@ -9465,31 +9498,25 @@ static int release_reference(struct bpf_verifier_=
env *env, int id)
>         struct bpf_stack_state *stack;
>         struct bpf_func_state *state;
>         struct bpf_reg_state *reg;
> -       int i, err;
> +       int err;
>
>         idstack->cnt =3D 0;
>         err =3D idstack_push(idstack, id);
>         if (err)
>                 return err;
>
> -       if (find_reference_state(vstate, id)) {
> -               err =3D release_reference_nomark(env, id);
> -               WARN_ON_ONCE(err);
> -       }
> -
>         while ((id =3D idstack_pop(idstack))) {
>                 /*
>                  * Child references are inaccessible after parent is rele=
ased,
>                  * any child references that exist at this point are a le=
ak.
>                  */
> -               for (i =3D 0; i < vstate->acquired_refs; i++) {
> -                       if (vstate->refs[i].type !=3D REF_TYPE_PTR)
> -                               continue;
> -                       if (vstate->refs[i].parent_id !=3D id)
> -                               continue;
> -                       verbose(env, "Leaking reference id=3D%d alloc_ins=
n=3D%d. Release it first.\n",
> -                               vstate->refs[i].id, vstate->refs[i].insn_=
idx);
> -                       return -EINVAL;
> +               err =3D check_reference_children(env, id);
> +               if (err)
> +                       return err;
> +
> +               if (find_reference_state(vstate, id)) {
> +                       err =3D release_reference_nomark(env, id);
> +                       WARN_ON_ONCE(err);

This changes release_reference() to release every referenced ID reached by =
the
DFS. Only the initial ID corresponds to an actual release helper/kfunc call=
.
A referenced descendant must remain tracked and make verification fail unle=
ss
the program explicitly releases it; otherwise the verifier can accept a
program that leaks the runtime reference. Please keep
release_reference_nomark() limited to the initial ID.

>                 }
>
>                 bpf_for_each_reg_in_vstate_mask(vstate, state, reg, stack=
, mask, ({
> @@ -9541,6 +9568,33 @@ static void invalidate_non_owning_refs(struct bpf_=
verifier_env *env)
>         }));
>  }
>
> +static int invalidate_iter_owned_btf_ptrs(struct bpf_verifier_env *env, =
u32 parent_id)
> +{
> +       struct bpf_func_state *unused;
> +       struct bpf_reg_state *reg;
> +       int err;
> +
> +       if (WARN_ON_ONCE(!parent_id))
> +               return -EFAULT;
> +
> +       err =3D check_reference_children(env, parent_id);
> +       if (err)
> +               return err;
> +
> +       /*
> +        * Struct iterators can release the previous element on each next=
 call.
> +        * PTR_TO_MEM iterator results use storage that remains valid unt=
il destroy.
> +        */
> +       bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
> +               if (base_type(reg->type) !=3D PTR_TO_BTF_ID || reg->paren=
t_id !=3D parent_id)
> +                       continue;
> +               bpf_diag_record_scrub(env, reg, BPF_DIAG_MOD_REF_RELEASE)=
;
> +               mark_reg_invalid(env, reg);
> +       }));
> +
> +       return 0;
> +}
> +
>  static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env)
>  {
>         struct bpf_stack_state *stack;
> @@ -13100,6 +13154,10 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_call_arg_me
>                                 ret =3D process_kf_arg_ptr_to_btf_id(env,=
 reg, ref_t, ref_tname, ref_id, meta, i, argno);
>                                 if (ret < 0)
>                                         return ret;
> +                               if (meta->btf =3D=3D btf_vmlinux &&
> +                                   meta->func_id =3D=3D special_kfunc_li=
st[KF_bpf_dynptr_from_file] &&
> +                                   i =3D=3D 0 && !reg_is_referenced(env,=
 reg) && reg->parent_id)
> +                                       update_ref_obj_id(&meta->ref_obj,=
 reg->parent_id, 0);

This feels hacky. Handle this in the generic dynptr-constructor path
instead to be less hacky? All current constructors take their
backing/source object in R1. Use R1's lifetime ID for the new dynptr
relationship.

>                                 break;
>                         }
>
> @@ -13995,6 +14053,13 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                 }
>         }
>
> +       if (bpf_is_iter_next_kfunc(&meta) &&
> +           !(get_iter_from_state(env->cur_state, &meta)->type & MEM_RCU)=
) {
> +               err =3D invalidate_iter_owned_btf_ptrs(env, meta.ref_obj.=
id);
> +               if (err)
> +                       return err;
> +       }
> +

This should be done in process_iter_arg().

>         bpf_diag_record_caller_saved(env, regs);
>         bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRIT=
E);
>         for (i =3D 0; i < CALLER_SAVED_REGS; i++) {
> @@ -14105,6 +14170,9 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>                         regs[BPF_REG_0].btf =3D desc_btf;
>                         regs[BPF_REG_0].type =3D type;
>                         regs[BPF_REG_0].btf_id =3D ptr_type_id;
> +
> +                       if (bpf_is_iter_next_kfunc(&meta) && !(type & MEM=
_RCU))
> +                               regs[BPF_REG_0].parent_id =3D meta.ref_ob=
j.id;
>                 }
>
>                 if (is_kfunc_ret_null(&meta)) {
> --
> 2.43.0
>
