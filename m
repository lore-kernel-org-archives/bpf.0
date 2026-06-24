Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B0E33D6F7
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321884; cv=pass; b=Fuj324r0DE7Fs19bUNZJv79PCi2dU1hAGDXOye/Kx1t9i+Sd0SIDP21lUdhfeE8HygYm01HFaun2fPpMP/hRJt5O0kBpB9+eRSSCroZ+vzzqdSSYWtg138Gavl+xZHFm00QLIcVxeG0tKeprSX3KO9i+b8FmYRKFMA0CPoISBno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321884; c=relaxed/simple;
	bh=CgaZvZGY4e/EKVwuFfxFMZAVMcCg1E+jJOW3/B10q0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8bWnB4zSmPjN5kPqNgJ8RtUa1VWcRxfZiVUc6B6GvEQ02dUdEzzhkAvJyxh3gd4nDW3cVnUoyffoKEUNK07huhhozLb2Y3jxA5a31xkn2ffmv+1ZH6s6oALVFEAzSwM9+9CtWajYJXD6MqsoRZnTxWhqG2lYASwgIE6RDSSHcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrOk1KXN; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrOk1KXN"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66388bf3793so902728d50.2
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 10:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782321881; cv=none;
        d=google.com; s=arc-20240605;
        b=B0TMY3XPxdPSFN+dJyIQCkamigL7/AizdYR2IEw3l7Fn05nWtGBSmonLiExj6dEaSk
         3cS5W3Ja0EgvlMgDS4IH6QkvKCqJIZRA1BGW8lV2sNFu7aYFyhPQ+auuh3WMx4FBS9kf
         rZpy1TscKZTxXqtklqbLnt8NKCxbty1m81xnhvOJxa+E+BX8BOuG3FiVFTjV4Kfk7Nnr
         WjXklz4dKx+TKWjypALiqznX8+T/yQEADcfpwFkq0Zj0XnpUyaIjbWlGMeMauAK5+/lo
         j1k8mdXjqqkijVysD+NyandgHxfz8EySVFJzQAWlsFEUrmuVeQ90J9hXK6FA2DPhFqDm
         NIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E1wkuHZkbsib5kIV/a5Yk3B4Y1qMn1xPyrOQ/gPCTXM=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=cC+XsYgnkjIwvK97joHRErnXvBWE55XDvGJdz0urSgU+KYdARUi6eB8N+41OZzG/1R
         7t2lpfLMHrY6u0n/kdpd+GWuHAKBeeJ+7N/yFhaUcWnp/9eXJjWwcRttUy34vTWsLfX7
         mW1oVnSgsVvhn6OaTC1I4XPWiLWt+QUE/pe5VVnWHC59Nbu20GKVpgkkNhg5gPeEGVez
         p/uw0SCpDGkDUGZx1PFx4ET4mgZnwm/31ZPYrzZqpx9dIaIuZkhMF8dGHvmWfuU4R3f9
         Z5OpICDrV0ORDCaVwgHerOxkMUOZDLuTg6lzk6e/fPNoKmVhb0x8qVY8qZTxq3ebckR9
         DPfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782321881; x=1782926681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1wkuHZkbsib5kIV/a5Yk3B4Y1qMn1xPyrOQ/gPCTXM=;
        b=GrOk1KXNFjujVIRq0WGAuOFzhIC9LQX7D6ho3H39V2LHM3pgJtvkhO5uKeKsNKdA/H
         EyWAbNDiJQIhQMXGIEHbs06+POT0DKy2qlyGBe1ko+OysVUTxmAVCDsEYXODZoGK39RF
         nZ10rW2TBIdh6sfEKVZJtku9VrWBV/bMSU0KIFYGOdS/PyIMN+GuG7RJ24jKSwTMfM03
         ew2SEbKfFop4QwPsQw0qxS3ib46O45dYGsNxcYhtHB6n8pQmrdzQunFK9w83+vfZva8a
         K9y26WVsWEvC4ifaL6uMQaWR6RVSLBQa1AXe9tYtsZ/2Hwji/3nJ6FulYxQxRrIl3uCM
         4ObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782321881; x=1782926681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E1wkuHZkbsib5kIV/a5Yk3B4Y1qMn1xPyrOQ/gPCTXM=;
        b=rveLBmOph65A8Y1Het948/YGxTJFeX5iEryYC/u3F5WA75lrjrjQu8dUehpwlM5ZeN
         oZwu5b3XwElVuAHgTucnHk3tFIcNqV8gZc2pIyGAR3xtBh3BDXkrHreLIuGSuOeNH8Qt
         5jB01QGApYcxRyerXPepf74rg2KD0IUQJ0yDF2/7NAJoLshmzA5+lCLJtZB2x7BokTJj
         DVz8TqgMrQQd7b8kREQpa8P4cfP7biCIk02ZuHVZoOXHcAP+lCz/DB7u9e3f6Uo6n2XL
         pY60a2bgVlwlRe7cOqvVW+Xx143nBZPF/+qBVSqCOHMzP/aXGHjvJR49D5m4sokSDqv7
         4K6w==
X-Gm-Message-State: AOJu0YyDAAxatcEWG1eNN/rn4bboxBP8Du90OYJGGj3YZUuSjQw7Dl4T
	+LAbU1cPsieFBrkypcYmUq2zibMm5B1+lvzxmge0HiW79xQdGdxZoDjlCr0DlM8vSXhuuHRgN95
	dgJ2vxuk4zTPca2kaNvb8Pm2se0qqFcc=
X-Gm-Gg: AfdE7cleqaCw6JHlDm96gAxyDqFaWl04YuzsojpgBVh3ZukoSU6+FZ05ziz2CK9fCTa
	bni2cVaC1RTk3+Fo13SfMrFnWNmckSwJfg8f77tKLf3MIr5XgSogS2L1hOErnwo7dfbhHHKg3f8
	Kp434al1yhhYK8HQWYlRGS4wdN9FmyUIs0E0xbBDZuRduDNTvIcGfnpoN1s11LTGuiSBPQMpg5J
	7H0yN3lLRlcf5dSbfU0KB5cZWF9XEI6+P7P1a01lklYCILjpRVjMihTd9JNSfZ4xyPhTE1U
X-Received: by 2002:a05:690e:130d:b0:65c:2208:8c6a with SMTP id
 956f58d0204a3-6635a305368mr7227481d50.42.1782321881331; Wed, 24 Jun 2026
 10:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623175006.3136053-1-ameryhung@gmail.com> <20260623175006.3136053-10-ameryhung@gmail.com>
 <20260623225359.77EE31F00A3A@smtp.kernel.org>
In-Reply-To: <20260623225359.77EE31F00A3A@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 24 Jun 2026 10:24:30 -0700
X-Gm-Features: AVVi8CfocQt9hWr32v2QEQ80f9bKIfkVHJv2cXBIKPpLa-2WNtpQNV5_4ic1_XQ
Message-ID: <CAMB2axMA9GuQDitxDQiirPDD3pbw2z1U=pM2P+=8hm_WF8HJWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 09/15] bpf: Add infrastructure to support
 attaching struct_ops to cgroups
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 3:54=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
>
> New issues:
> - [High] The `bpf_cgroup_struct_ops_foreach` macro does not filter out du=
mmy sentinel elements, leading to type confusion and kernel panics.
> - [High] Strict `rcu_dereference()` in `bpf_cgroup_struct_ops_foreach` ca=
uses lockdep splats or panics for sleepable struct_ops.
> - [High] Array truncation during `purge_effective_progs` if the struct_op=
s type was registered without `cfi_stubs`.
>
> Pre-existing issues:
> - [High] `bpf_cgroup_array_copy_to_user()` incorrectly returns -ENOSPC wh=
en trailing dummy elements exist, breaking userspace queries.
> --
>
> commit a3bccbe6dc639128f470580a5e6281248194eb4e
> Author: Martin KaFai Lau <martin.lau@kernel.org>
>
> bpf: Add infrastructure to support attaching struct_ops to cgroups
>
> This patch adds necessary infrastructure to attach a struct_ops map to a
> cgroup. It reuses existing cgroup bpf structures and logic to handle the
> attachment, hierarchy, and ordering of struct_ops maps. It also implement=
s
> a separate struct bpf_link_ops for cgroup's struct_ops link.
>
> > diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> > index 4d0cc65976a14..8a75a6cd73096 100644
> > --- a/include/linux/bpf-cgroup.h
> > +++ b/include/linux/bpf-cgroup.h
> > @@ -110,6 +112,18 @@ struct bpf_prog_list {
> >       u32 flags;
> >  };
> >
> > +#define bpf_cgroup_struct_ops_foreach(var, item, cgrp, atype)         =
       \
> > +     for (item =3D rcu_dereference((cgrp)->bpf.effective[atype])->item=
s;\
> > +          ((var) =3D READ_ONCE(item->kdata));                         =
 \
> > +          item++)
>
> [Severity: High]
> Does this macro fail to filter out dummy sentinel elements?
>
> When update_effective_progs() fails under memory pressure, the kernel fal=
ls
> back to purge_effective_progs(), which overwrites the detached link's poi=
nter
> with a dummy sentinel value (struct_ops_cfi_stubs[atype]).
>
> Since the macro yields every non-NULL element to the caller subsystem,
> including these dummy sentinels, could this cause type confusion and kern=
el
> panics if the subsystem accesses data fields on the dummy struct?
>

Already replied in v1. Short version here again: cfi_stubs are used as
dummy struct_ops. They are safe to call and not filtered out for
performance reasons.

> [Severity: High]
> Will this strict rcu_dereference() cause lockdep splats or panics for
> sleepable struct_ops?
>
> The patch introduces free_after_mult_rcu_gp to support sleepable struct_o=
ps,
> meaning a subsystem executing a sleepable bpf program must hold
> rcu_read_lock_trace() instead of the standard rcu_read_lock(). However,
> rcu_dereference() rigidly enforces that rcu_read_lock() is held.
>
> If the subsystem holds rcu_read_lock_trace(), lockdep will splat, and if
> it erroneously holds rcu_read_lock(), the kernel will crash when the
> sleepable bpf program actually sleeps.
>
> Should this use rcu_dereference_check() or similar to accommodate sleepab=
le
> contexts?
>

Already replied in v1. The macro is only intended for non-sleepable
struct_ops. A sleepable version can be added later when the new
struct_ops is added.

> > +
> > +static inline bool cgroup_bpf_is_struct_ops_atype(enum cgroup_bpf_atta=
ch_type atype)
> > +{
> > +     return atype =3D=3D CGROUP_TCP_SOCK_OPS;
> > +}
> > +void cgroup_bpf_struct_ops_register(int atype, u32 type_id, void *cfi_=
stubs, bool mult_trace);
> > +int cgroup_bpf_struct_ops_attach(struct bpf_map *map, const union bpf_=
attr *attr);
> > +
> >  void __init cgroup_bpf_lifetime_notifier_init(void);
>
> [ ... ]
>
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 64572f85edc83..d591f306ace52 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
>
> [ ... ]
>
> > @@ -9868,6 +9872,23 @@ btf_add_struct_ops(struct btf *btf, struct bpf_s=
truct_ops *st_ops,
> >       if (err)
> >               return err;
> >
> > +     if (cgroup_atype) {
> > +             if (!cgroup_bpf_is_struct_ops_atype(cgroup_atype) ||
> > +                 st_ops->reg || st_ops->unreg || st_ops->free_after_ta=
sks_rcu_gp) {
> > +                     bpf_struct_ops_desc_release(&tab->ops[btf->struct=
_ops_tab->cnt]);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             /* There is no need to unregister from cgroup when the
> > +              * btf_free(). No struct_ops map and its cgroup link
> > +              * can be created once its btf is gone.
> > +              */
> > +             cgroup_bpf_struct_ops_register(cgroup_atype,
> > +                                            tab->ops[btf->struct_ops_t=
ab->cnt].type_id,
> > +                                            st_ops->cfi_stubs,
> > +                                            st_ops->free_after_mult_rc=
u_gp);
>
> [Severity: High]
> Does this path accept st_ops->cfi_stubs without validating that it is non=
-NULL?
>
> If a struct_ops type is registered without providing cfi_stubs (e.g., if
> CONFIG_CFI_CLANG is disabled), struct_ops_cfi_stubs[atype] will be NULL.
>
> Later, if a link is detached and update_effective_progs() fails due to me=
mory
> pressure, the fallback bpf_cgroup_array_delete_safe_at() overwrites the
> detached program's slot with bpf_cgroup_array_dummy().
>
> Because cfi_stubs is NULL, it writes NULL into the middle of the array.
>
> Since NULL is used as the array terminator, won't this prematurely trunca=
te
> the array and silently bypass all attached bpf programs that follow the
> detached one?
>

Seems like a false positive. bpf_struct_ops_desc_init() already
rejects struct_ops registration with NULL cfi_stubs.

> > +     }
> > +
> >       btf->struct_ops_tab->cnt++;
> >
> >       return 0;
>
> [ ... ]
>
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index 081d81de18163..a808d2a31f11d 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
>
> [ ... ]
>
> > @@ -355,7 +407,12 @@ static int bpf_cgroup_array_copy_to_user(struct bp=
f_prog_array *array,
> >       for (item =3D array->items; item->prog && i < cnt; item++) {
> >               if (item->prog =3D=3D bpf_cgroup_array_dummy(atype))
> >                       continue;
> > -             id =3D item->prog->aux->id;
> > +
> > +             if (cgroup_bpf_is_struct_ops_atype(atype))
> > +                     id =3D bpf_struct_ops_kdata_map_id(item->kdata);
> > +             else
> > +                     id =3D item->prog->aux->id;
> > +
> >               if (copy_to_user(prog_ids + i, &id, sizeof(id)))
> >                       return -EFAULT;
> >               i++;
>
> [Severity: High]
> This is a pre-existing issue, but does bpf_cgroup_array_copy_to_user()
> incorrectly return -ENOSPC when trailing dummy elements exist?
>
> If a cgroup link is detached under memory pressure, it leaves a trailing =
dummy
> sentinel in the array.
>
> When userspace calls bpf_prog_query with an exact-sized buffer, the loop
> breaks via "i < cnt" exactly when i =3D=3D cnt, leaving "item" pointing t=
o the
> dummy element.
>
> Since item->prog is non-NULL (it is the dummy), the function evaluates
> "return item->prog ? -ENOSPC : 0;" and erroneously returns -ENOSPC.
>
> This breaks userspace queries, causing userspace tools to continually rec=
eive
> -ENOSPC and attempt to allocate larger buffers, eventually exhausting mem=
ory.

This issue is pre-existing and the severity should be low. This is an
unlikely path when the system is under pressure. Can be fixed later
with bpf_prog_array_copy_core() if really needed.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623175006.31=
36053-1-ameryhung@gmail.com?part=3D9
