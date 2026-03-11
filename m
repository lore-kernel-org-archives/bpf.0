Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3231A31F99A
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246880; cv=pass; b=dMt6g99agwjmP7XjQujKFup8yLmYIa2SSpFP6Z/N6rgfhvQi4Azzg86R2PFAvkgUd+Wne7fUmxb42AJKY+0fH1gZx9ypjfu4ggKQT1hkVuDIlbuO68Wvpy6ECgPiCdtN18NRdt5excN6ifByoDQS51oK3XUCjjXqEz7ZfKz4STI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246880; c=relaxed/simple;
	bh=N7jO3orMqZR2oJ+QCZmCYBbnPuVa7c8V9rQdctlCuc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nduHdZDkE7stV4eyqPBNFzKteV7y463fM1jdxxcI/usPuA/oOmqoTYqVYn1p7jRUbeU5jGAQbIGthdIewU1CF1AvUlVElwTeuWTfE+oglIG0HfKJFTew8IbShRZqO1EXy9GUQ+3BolhTF/yCcy7qMSitwmgwJI58DU7n+ChrFI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R45Z+FyX; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R45Z+FyX"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79863ab8478so137607b3.3
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 09:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773246878; cv=none;
        d=google.com; s=arc-20240605;
        b=gFSM5h/mGbqg6XoH/V3CLUsVPrZeZzdo4VKHCuR7fx+Gd2T0gW4NNVPK1ZtCQia+Ls
         SFUxz3b+PW5Ts5D2Sj/fxA57+OYnuaNFt5aDapgR6fzw6NGgxoiu5Cfoc34qh2fuozH9
         CN/DuIdHtBTvQgdeqrcnZR86rcWvc24MCD+xAowUQhZISZkD7PF+LpoHpSSeftnblA8U
         XzbIkKtX+9ZgEmwp67lbHljW/PQ42+1X6dy/N4gvS09fsFOkiwO0Yc0rMZbK6pt0XmSw
         d4XL5RJQtQ4vR3eN2PKvWZqP7pWagZq74N7KOtBs9WYjZb4nwyWVHXeMh3wr6RXZ8mBQ
         lMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7u6RlutJheLDs8sUeXMwUnSzGxwPE/feaSihiWTJ5jA=;
        fh=reLytoccIbymnfxd0qOWViuC44C/L+sUMs8tM0wQ/L0=;
        b=B+G4ZG1PWyrqigCnSJ+z1QUgL06h8FKB6z9iItx3r2kfUKx3XX4dKZgwhIl4oF5Bt2
         JW5l31DIZbySe2WKibdUVTtNsoALRQ9S58psqBDF+oWSa3SfDFWLztyITQw6CsR9Y+Ek
         0Z8ODUjFh35F9/LAuCK3Uc28EAgDt3wfYcqTOBDd+Ldq5NADcYa4Pb6TGfd49Cp29YXj
         ykIubFNq9mPtg/8en5GkMtk5rPn5CnWfhx1nm3x2gi9V8tUAwPFm8Je/cFAupz35zKz7
         zMkTCzYAxpmz191ZHTY18e4b9ux6yPQwlnJ1bo4mM9CKfTcnaMOZqarRoBJaQ52yqkf7
         ztBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773246878; x=1773851678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7u6RlutJheLDs8sUeXMwUnSzGxwPE/feaSihiWTJ5jA=;
        b=R45Z+FyXNurHPVM0Jt7ruWUaCnHa+2kW4RVgmzMrd/2MyVzNo2n0dSqW4s7FZOkiP1
         Dd4VjfXWL20+SNV/pnjaUFLvRwGk9xAfNsRrTRgqAR3+pgNb7Nm1Ul2FALdXpPe/ue+v
         1vLhLMbkUgMZ8TWCfVsoyq1bS86LrpYIGmlLuD+Fm4P8JD1CPQyya5Q0IikAidCuIv29
         7zXNC14TvsQ+a/UyoOElX6pblYUbhv71A9q68rvDnXR99kzvOamrZd9oTDy4D7sivKNc
         F8eirQwaG7JQFCmWzzXoof2h7X6+Ka8U5SEC9aOXUwN2hT3uQH3ogo69IEfoqubPnxti
         BJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773246878; x=1773851678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7u6RlutJheLDs8sUeXMwUnSzGxwPE/feaSihiWTJ5jA=;
        b=c1JzyKQAtNse9XA7zKB+Dgg314kQvJEnkpbCEYPPo8YYmqhaeqrsxbin0DMDqA6ADh
         Kz8ucjB1UWqzdSZ+nupQ8GpPxngqUS0mFkvN0Q0Nrm4Num2T8NhR+57uCr5cCV0ryHdG
         WS6OhqC28eOgnKzHA5PgD1gecXW8WnXvYVBRtyA65LvP9v0tl3mG95eYs9KJ/qz2qvs+
         i9clpv1m16MYBZyx38F3sdrNqR2nnC0FIg1HdpLU8iAo+EP662MDynlwGx/yFA/3sQym
         +bYvGCY1A7wImaChfVriNkxOL2B2WZu+YdyrzZTkF7iKePU+m7kiX8E7CddDANWKkmwo
         hkMg==
X-Gm-Message-State: AOJu0YwdhP0nFprr0wVXkQ+39iRzcRkmpeh6J0oWStQIyBRDbrnF2kkJ
	sIYGNuHP7JaaGg3OKFN7EuSVvbW+3jwKuEg+tesR2vhN99y5Rhs80t1hQW3zSTGJhgCFl7EDRG1
	dkEIaTp0QF0qpU705h+KLMuT5rImFW7E=
X-Gm-Gg: ATEYQzya8nKrpshzcQyZuvo8R7R6GDJseRsCeAgQYjtbp32Qv1yE9Bx5YgqRLLY+UxE
	Y/dxL1koEBYhpBYsh6Bpz1ct4ICkjjweSL7pjKeYZdN415hwrmV2kVta+mcSklMG5znEBYbtBxt
	Dc5ynrgJUuG/rK5X9tfsl1DX2wSJOYwg/vVI+pWULw1Y7hXPkyOO1xg1CiaIJ2cX3Vam5QQusYW
	Z8tIxALpHpOz2vJgs0UzUtIMp9HBls2CGLrkn1OTu5zN0vx1UhmtAnZT3nDTwNlV7J4jmETGEtX
	FmA/zZk=
X-Received: by 2002:a05:690c:d8d:b0:796:31ce:6026 with SMTP id
 00721157ae682-79917ec0f44mr30299877b3.16.1773246878137; Wed, 11 Mar 2026
 09:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-2-ameryhung@gmail.com>
 <87o6kutoc1.fsf@gmail.com>
In-Reply-To: <87o6kutoc1.fsf@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 09:34:27 -0700
X-Gm-Features: AaiRm53cJgiEvgS-_NttJhCdTCZqNrtSmB3q_0uS0_PGxkN4Ci8FyP79OLZGVGQ
Message-ID: <CAMB2axNeo53OftBUuvh_FtYqujk8veUFCQ652YTtBiBWkcLxqg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 01/11] bpf: Set kfunc dynptr arg type flag
 based on prototype
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 7:47=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Amery Hung <ameryhung@gmail.com> writes:
>
> > The verifier should decide whether a dynptr argument is read-only
> > based on if the type is "const struct bpf_dynptr *", not the type of
> > the register passed to the kfunc. This currently does not cause issues
> > because existing kfuncs that mutate struct bpf_dynptr are constructors
> > (e.g., bpf_dynptr_from_xxx and bpf_dynptr_clone). These kfuncs have
> > additional check in process_dynptr_func() to make sure the stack slot
> > does not contain initialized dynptr. Nonetheless, this should still be
> > fixed to avoid future issues when there is a non-constructor dynptr
> > kfunc that can mutate dynptr. This is also a small step toward unifying
> > kfunc and helper handling in the verifier, where the first step is to
> > generate kfunc prototype similar to bpf_func_proto before the main
> > verification loop.
> >
> > We also need to correctly mark some kfunc arguments as "const struct
> > bpf_dynptr *" to align with other kfuncs that take non-mutable dynptr
> > argument and to not break their usage. Adding const qualifier does
> > not break backward compatibility.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  fs/verity/measure.c                            |  2 +-
> >  include/linux/bpf.h                            |  8 ++++----
> >  kernel/bpf/helpers.c                           | 10 +++++-----
> >  kernel/bpf/verifier.c                          | 18 +++++++++++++++++-
> >  kernel/trace/bpf_trace.c                       | 18 +++++++++---------
> >  tools/testing/selftests/bpf/bpf_kfuncs.h       |  6 +++---
> >  .../selftests/bpf/progs/dynptr_success.c       |  6 +++---
> >  .../bpf/progs/test_kfunc_dynptr_param.c        |  7 +------
> >  8 files changed, 43 insertions(+), 32 deletions(-)
> >
> > diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> > index 6a35623ebdf0..3840436e4510 100644
> > --- a/fs/verity/measure.c
> > +++ b/fs/verity/measure.c
> > @@ -118,7 +118,7 @@ __bpf_kfunc_start_defs();
> >   *
> >   * Return: 0 on success, a negative value on error.
> >   */
> > -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_=
dynptr *digest_p)
> > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const struc=
t bpf_dynptr *digest_p)
> >  {
> >       struct bpf_dynptr_kern *digest_ptr =3D (struct bpf_dynptr_kern *)=
digest_p;
> >       const struct inode *inode =3D file_inode(file);
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index b78b53198a2e..946a37b951f7 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -3621,8 +3621,8 @@ static inline int bpf_fd_reuseport_array_update_e=
lem(struct bpf_map *map,
> >  struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags);
> >  struct bpf_key *bpf_lookup_system_key(u64 id);
> >  void bpf_key_put(struct bpf_key *bkey);
> > -int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
> > -                            struct bpf_dynptr *sig_p,
> > +int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_p,
> > +                            const struct bpf_dynptr *sig_p,
> >                              struct bpf_key *trusted_keyring);
> >
> >  #else
> > @@ -3640,8 +3640,8 @@ static inline void bpf_key_put(struct bpf_key *bk=
ey)
> >  {
> >  }
> >
> > -static inline int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p=
,
> > -                                          struct bpf_dynptr *sig_p,
> > +static inline int bpf_verify_pkcs7_signature(const struct bpf_dynptr *=
data_p,
> > +                                          const struct bpf_dynptr *sig=
_p,
> >                                            struct bpf_key *trusted_keyr=
ing)
> >  {
> >       return -EOPNOTSUPP;
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 6eb6c82ed2ee..3d44896587ac 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3000,8 +3000,8 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf=
_dynptr *p,
> >   * Copies data from source dynptr to destination dynptr.
> >   * Returns 0 on success; negative error, otherwise.
> >   */
> > -__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u64 dst_of=
f,
> > -                             struct bpf_dynptr *src_ptr, u64 src_off, =
u64 size)
> > +__bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u64 =
dst_off,
> > +                             const struct bpf_dynptr *src_ptr, u64 src=
_off, u64 size)
> >  {
> >       struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_kern *)dst_ptr=
;
> >       struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_kern *)src_ptr=
;
> > @@ -3055,7 +3055,7 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr=
 *dst_ptr, u64 dst_off,
> >   * at @offset with the constant byte @val.
> >   * Returns 0 on success; negative error, otherwise.
> >   */
> > -__bpf_kfunc int bpf_dynptr_memset(struct bpf_dynptr *p, u64 offset, u6=
4 size, u8 val)
> > +__bpf_kfunc int bpf_dynptr_memset(const struct bpf_dynptr *p, u64 offs=
et, u64 size, u8 val)
> >  {
> >       struct bpf_dynptr_kern *ptr =3D (struct bpf_dynptr_kern *)p;
> >       u64 chunk_sz, write_off;
> > @@ -4069,8 +4069,8 @@ __bpf_kfunc void bpf_key_put(struct bpf_key *bkey=
)
> >   *
> >   * Return: 0 on success, a negative value on error.
> >   */
> > -__bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
> > -                            struct bpf_dynptr *sig_p,
> > +__bpf_kfunc int bpf_verify_pkcs7_signature(const struct bpf_dynptr *da=
ta_p,
> > +                            const struct bpf_dynptr *sig_p,
> >                              struct bpf_key *trusted_keyring)
> >  {
> >  #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 1153a828ce8d..0f77c4c5b510 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12276,6 +12276,22 @@ static bool is_kfunc_arg_dynptr(const struct b=
tf *btf, const struct btf_param *a
> >       return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_DYNPTR_ID);
> >  }
> >
> > +static bool is_kfunc_arg_const_ptr(const struct btf *btf, const struct=
 btf_param *arg)
> > +{
> > +     const struct btf_type *t, *resolved_t;
> > +
> > +     t =3D btf_type_skip_modifiers(btf, arg->type, NULL);
> > +     if (!t || !btf_type_is_ptr(t))
> > +             return false;
> > +
> > +     resolved_t =3D btf_type_skip_modifiers(btf, t->type, NULL);
> nit: t is ptr type, maybe we can do t =3D btf_type_by_id(btf, t->type)
> before the loop starts, as we know the result of the first iteration.

Will add it before calling btf_type_skip_modifiers.

> > +     for (; t !=3D resolved_t; t =3D btf_type_by_id(btf, t->type))
> > +             if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_CONST)
> nit: btf_kind() is a bit shorter than BTF_KIND_INFO()

Will replace it with btf_kind()

> > +                     return true;
> > +
> > +     return false;
> > +}
> The logic in this function looks correct to me. The refactoring makes
> sense as well (although I'm not 100% sure how this is relevant to this
> patch series)

Thanks for taking a look at the set!

Indeed independent. I will separate these two patches if the rest is
going to take more time.

> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> > +
> >  static bool is_kfunc_arg_list_head(const struct btf *btf, const struct=
 btf_param *arg)
> >  {
> >       return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_LIST_HEAD_ID);
> > @@ -13509,7 +13525,7 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
> >                       enum bpf_arg_type dynptr_arg_type =3D ARG_PTR_TO_=
DYNPTR;
> >                       int clone_ref_obj_id =3D 0;
> >
> > -                     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
> > +                     if (is_kfunc_arg_const_ptr(btf, &args[i]))
> >                               dynptr_arg_type |=3D MEM_RDONLY;
> >
> >                       if (is_kfunc_arg_uninit(btf, &args[i]))
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 9bc0dfd235af..127c317376be 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3391,7 +3391,7 @@ typedef int (*copy_fn_t)(void *dst, const void *s=
rc, u32 size, struct task_struc
> >   * direct calls into all the specific callback implementations
> >   * (copy_user_data_sleepable, copy_user_data_nofault, and so on)
> >   */
> > -static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *dp=
tr, u64 doff, u64 size,
> > +static __always_inline int __bpf_dynptr_copy_str(const struct bpf_dynp=
tr *dptr, u64 doff, u64 size,
> >                                                const void *unsafe_src,
> >                                                copy_fn_t str_copy_fn,
> >                                                struct task_struct *tsk)
> > @@ -3533,49 +3533,49 @@ __bpf_kfunc int bpf_send_signal_task(struct tas=
k_struct *task, int sig, enum pid
> >       return bpf_send_signal_common(sig, type, task, value);
> >  }
> >
> > -__bpf_kfunc int bpf_probe_read_user_dynptr(struct bpf_dynptr *dptr, u6=
4 off,
> > +__bpf_kfunc int bpf_probe_read_user_dynptr(const struct bpf_dynptr *dp=
tr, u64 off,
> >                                          u64 size, const void __user *u=
nsafe_ptr__ign)
> >  {
> >       return __bpf_dynptr_copy(dptr, off, size, (const void __force *)u=
nsafe_ptr__ign,
> >                                copy_user_data_nofault, NULL);
> >  }
> >
> > -__bpf_kfunc int bpf_probe_read_kernel_dynptr(struct bpf_dynptr *dptr, =
u64 off,
> > +__bpf_kfunc int bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *=
dptr, u64 off,
> >                                            u64 size, const void *unsafe=
_ptr__ign)
> >  {
> >       return __bpf_dynptr_copy(dptr, off, size, unsafe_ptr__ign,
> >                                copy_kernel_data_nofault, NULL);
> >  }
> >
> > -__bpf_kfunc int bpf_probe_read_user_str_dynptr(struct bpf_dynptr *dptr=
, u64 off,
> > +__bpf_kfunc int bpf_probe_read_user_str_dynptr(const struct bpf_dynptr=
 *dptr, u64 off,
> >                                              u64 size, const void __use=
r *unsafe_ptr__ign)
> >  {
> >       return __bpf_dynptr_copy_str(dptr, off, size, (const void __force=
 *)unsafe_ptr__ign,
> >                                    copy_user_str_nofault, NULL);
> >  }
> >
> > -__bpf_kfunc int bpf_probe_read_kernel_str_dynptr(struct bpf_dynptr *dp=
tr, u64 off,
> > +__bpf_kfunc int bpf_probe_read_kernel_str_dynptr(const struct bpf_dynp=
tr *dptr, u64 off,
> >                                                u64 size, const void *un=
safe_ptr__ign)
> >  {
> >       return __bpf_dynptr_copy_str(dptr, off, size, unsafe_ptr__ign,
> >                                    copy_kernel_str_nofault, NULL);
> >  }
> >
> > -__bpf_kfunc int bpf_copy_from_user_dynptr(struct bpf_dynptr *dptr, u64=
 off,
> > +__bpf_kfunc int bpf_copy_from_user_dynptr(const struct bpf_dynptr *dpt=
r, u64 off,
> >                                         u64 size, const void __user *un=
safe_ptr__ign)
> >  {
> >       return __bpf_dynptr_copy(dptr, off, size, (const void __force *)u=
nsafe_ptr__ign,
> >                                copy_user_data_sleepable, NULL);
> >  }
> >
> > -__bpf_kfunc int bpf_copy_from_user_str_dynptr(struct bpf_dynptr *dptr,=
 u64 off,
> > +__bpf_kfunc int bpf_copy_from_user_str_dynptr(const struct bpf_dynptr =
*dptr, u64 off,
> >                                             u64 size, const void __user=
 *unsafe_ptr__ign)
> >  {
> >       return __bpf_dynptr_copy_str(dptr, off, size, (const void __force=
 *)unsafe_ptr__ign,
> >                                    copy_user_str_sleepable, NULL);
> >  }
> >
> > -__bpf_kfunc int bpf_copy_from_user_task_dynptr(struct bpf_dynptr *dptr=
, u64 off,
> > +__bpf_kfunc int bpf_copy_from_user_task_dynptr(const struct bpf_dynptr=
 *dptr, u64 off,
> >                                              u64 size, const void __use=
r *unsafe_ptr__ign,
> >                                              struct task_struct *tsk)
> >  {
> > @@ -3583,7 +3583,7 @@ __bpf_kfunc int bpf_copy_from_user_task_dynptr(st=
ruct bpf_dynptr *dptr, u64 off,
> >                                copy_user_data_sleepable, tsk);
> >  }
> >
> > -__bpf_kfunc int bpf_copy_from_user_task_str_dynptr(struct bpf_dynptr *=
dptr, u64 off,
> > +__bpf_kfunc int bpf_copy_from_user_task_str_dynptr(const struct bpf_dy=
nptr *dptr, u64 off,
> >                                                  u64 size, const void _=
_user *unsafe_ptr__ign,
> >                                                  struct task_struct *ts=
k)
> >  {
> > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/s=
elftests/bpf/bpf_kfuncs.h
> > index 7dad01439391..ffb9bc1cace0 100644
> > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > @@ -70,13 +70,13 @@ extern void *bpf_rdonly_cast(const void *obj, __u32=
 btf_id) __ksym __weak;
> >
> >  extern int bpf_get_file_xattr(struct file *file, const char *name,
> >                             struct bpf_dynptr *value_ptr) __ksym;
> > -extern int bpf_get_fsverity_digest(struct file *file, struct bpf_dynpt=
r *digest_ptr) __ksym;
> > +extern int bpf_get_fsverity_digest(struct file *file, const struct bpf=
_dynptr *digest_ptr) __ksym;
> >
> >  extern struct bpf_key *bpf_lookup_user_key(__s32 serial, __u64 flags) =
__ksym;
> >  extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
> >  extern void bpf_key_put(struct bpf_key *key) __ksym;
> > -extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> > -                                   struct bpf_dynptr *sig_ptr,
> > +extern int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_pt=
r,
> > +                                   const struct bpf_dynptr *sig_ptr,
> >                                     struct bpf_key *trusted_keyring) __=
ksym;
> >
> >  struct dentry;
> > diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools=
/testing/selftests/bpf/progs/dynptr_success.c
> > index e0d672d93adf..e0745b6e467e 100644
> > --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> > +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> > @@ -914,7 +914,7 @@ void *user_ptr;
> >  char expected_str[384];
> >  __u32 test_len[7] =3D {0/* placeholder */, 0, 1, 2, 255, 256, 257};
> >
> > -typedef int (*bpf_read_dynptr_fn_t)(struct bpf_dynptr *dptr, u64 off,
> > +typedef int (*bpf_read_dynptr_fn_t)(const struct bpf_dynptr *dptr, u64=
 off,
> >                                   u64 size, const void *unsafe_ptr);
> >
> >  /* Returns the offset just before the end of the maximum sized xdp fra=
gment.
> > @@ -1106,7 +1106,7 @@ int test_copy_from_user_str_dynptr(void *ctx)
> >       return 0;
> >  }
> >
> > -static int bpf_copy_data_from_user_task(struct bpf_dynptr *dptr, u64 o=
ff,
> > +static int bpf_copy_data_from_user_task(const struct bpf_dynptr *dptr,=
 u64 off,
> >                                       u64 size, const void *unsafe_ptr)
> >  {
> >       struct task_struct *task =3D bpf_get_current_task_btf();
> > @@ -1114,7 +1114,7 @@ static int bpf_copy_data_from_user_task(struct bp=
f_dynptr *dptr, u64 off,
> >       return bpf_copy_from_user_task_dynptr(dptr, off, size, unsafe_ptr=
, task);
> >  }
> >
> > -static int bpf_copy_data_from_user_task_str(struct bpf_dynptr *dptr, u=
64 off,
> > +static int bpf_copy_data_from_user_task_str(const struct bpf_dynptr *d=
ptr, u64 off,
> >                                           u64 size, const void *unsafe_=
ptr)
> >  {
> >       struct task_struct *task =3D bpf_get_current_task_btf();
> > diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.=
c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > index d249113ed657..c3631fd41977 100644
> > --- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > @@ -11,12 +11,7 @@
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_tracing.h>
> >  #include "bpf_misc.h"
> > -
> > -extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
> > -extern void bpf_key_put(struct bpf_key *key) __ksym;
> > -extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> > -                                   struct bpf_dynptr *sig_ptr,
> > -                                   struct bpf_key *trusted_keyring) __=
ksym;
> > +#include "bpf_kfuncs.h"
> >
> >  struct {
> >       __uint(type, BPF_MAP_TYPE_RINGBUF);
> > --
> > 2.47.3
