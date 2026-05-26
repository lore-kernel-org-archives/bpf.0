Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749242189A
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818054; cv=pass; b=EqPIcTeBfIiFRn3DcTnhhiMG1ffQyGlhgvSvy4wL5Dz0xjZVmT3bZVpPylx9lANXZe3Pa4+50o7QdP/Tor3ufFejNRP1uGt8cBcDVdR7lY+N4ZblOtt1PM57MreXx0DGBG4y/Nm9F0Yr8cB+Ri59sJ3ZXL+O7Dziapav5mF1AMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818054; c=relaxed/simple;
	bh=mo51nLE6P1wJoADFxd9GxwL23mh9JvgaYmz4OryT76M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDxvzDqYAteghVjeP5vys+zfg2xOYOR1KoMH3aWGnGp6yBO6VOz9eBD/K6pXGVXOmyRD6a6cR4SHhLjUHJ1pjRqS1gHaV7/QYVI4sXtDQMZxxePz0GCFKKO4aTnwwNN7ctDh4kcTkO0QjqB8aW7jkNCwftfGMPqrWHkZ11xKi6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ib77nFs6; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ib77nFs6"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7cfd0d8eb09so74064647b3.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 10:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779818051; cv=none;
        d=google.com; s=arc-20240605;
        b=U08NClMvaJD8EGB8vBg/9j3MbLVZ9LPwQKoLMkzoAG4rxvmjuSkVyj5Jm4OivZC8/v
         mtLFx1y1yTGErLuYO866IRox9zX6XJ/ublytnnHrvBqOaiG/q0v0ZaDGsn9l6+cxZ5md
         nCAoxLHeiza+2QoJQ3g5BwX7opjOlFmS4mAEWy3tbUKLr/WyNvja5GFJ5H4+UwcbhrAe
         9RPYHaRPrYyvfMmUt3UpwRPigtd28ZePunSMo00NpkjAlYf/jc7EooRPuY0zVJgiXLT4
         5hC1QlkRgqgxs5kL369xgLBwRPgycVkVDwgIWJ5R8fK66nSgJdEK6Bm67FGlau9ReT9v
         gbtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aLSY4XkeDLqds8/zCxtUpFNC/XRt0rRFn6Ll8whM7pc=;
        fh=Toy6KGrAPK3N3ICJ0ecXrI/1oTKJjDXHP6DQCs1/fj8=;
        b=Kd8k03giAyqW+KSi8XA67ij4vTsQa79zZpM0/NOhiKSG962VDTUL7LYkdMrFU/1QAD
         iTgeI/0EPdBLZuggHpt3DBLa5jqXV0K9RAijFnb64ag5Owr/EP9JQuT9b82nCF+DYcGq
         V0xTYlE8HykB+JvnMYEqsU4sPIL42uPQfrRjUUUG5In9Z/avhS5IuWX1l/bF6MlwWWT1
         RmqofDIKZQw/vgMIvAFmyT4cEVTMmLkJc62bJqFg9gvotNh09HAByDJejT6d16WkS60I
         Sy4SCS6A+gsFi9MEkem5ANsgMmXAB/DR7mw219rpdLdWVQx+kiO6h/Wms1Q8E/pVX8VL
         XCZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779818051; x=1780422851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLSY4XkeDLqds8/zCxtUpFNC/XRt0rRFn6Ll8whM7pc=;
        b=ib77nFs6PJXs5sRgg/mrPnmRglSkC6wVC9/kWFyr/m/qv+M5KMIrAMsBA//gf57pR4
         3HR4Ndm8F9S0Hqc2TW5VeYARM31oWfJLvqzhkFzD2ZiagJIzfr+ZUGYJ0xjssQnqp4Hv
         IWv6M257FRN3IAH6NqoALlQjyMq+IpXBCcnFwZRv00XRQ/ZDW3M1/MyCaTtK+9R8wdTF
         aVeD3I+SedxxZ0Vco+c8bqG84ypX4ujerC7JLtAI931rqjwAVIuCWnkHOV8sDK8B5PXS
         cru3/fwT/J+hm1f7yH0+D1qf5OeLddv2WxjvPPdmA9j95svCBr3Lcih4civmDZf5Ux3d
         q02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818051; x=1780422851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aLSY4XkeDLqds8/zCxtUpFNC/XRt0rRFn6Ll8whM7pc=;
        b=N48EzRVKLqcbH3jyKCbK94aIh60waW91KfWEqUy0cB4Tlxs0aLcvOP2PRxu55H9yZf
         2PdObIvSsjJ0oVsDzhIezuvFaNMB7dYzf9wncDgzbqoxwXLGVbD8YmqVfiDUKwGV/ufk
         aB0S6ZruX8fJiJNkjCzJYha4U2HfrB7KobcGIUJKsdMh9pxa1smwGlEv2Q6zwnES0CT3
         SBL2tFqWGzwAfgqopUgz352YA4yFyF/t6FCxS4k9QYIz0oGPfBqTNECNoGjHrGcHSU/U
         s2SJGKeOIUjTCe4Xsih3Y7IqLZwc0lYnVeBXkGuxPidK2CINuZ5VjSiJRtBUOYbEcjjV
         NBQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YVqxy/fH1dk2EHRDPxrl8x1H5ezJdRSFH0UEPrND5ZgILBaPrbLSCDwU+4+zmxTrByIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcCF4wt4pUKTWG88b5Y+Fc/myKOmKGfG5h6b0kVM+aXYUSBuxy
	S6BI3pRBX3l8/KUVje7CC0Vu7kEWolrXqE5/tCfHrrsBhMVZqNdyIcFmDqd+K6xkVc02WkZaTsO
	Pen8d/l3AF64VIjaPIanql+LMCh6APY3meUT3
X-Gm-Gg: Acq92OGJbgKKX/kZHmdGhDnOwAI3FiI412IXzq04wUeotRdfMUbAQ8zMz9tbDdPVmeq
	Q/lDjVnz7GAV7aivQgOxC6deBMLWyf+fvVylT4sBvHY7gjpZlC+iBLInOjUOB/UHxkDa0eUFD+u
	mwSXkUvf/v6rgftvg1vCmj9vvlOZwlWSUIg7OOHCz+wrDLEasL3osD+Ius7Em5mfYEafjwDi/EL
	lOU3O16cUhfxcI7GFdUZ03Lmn8AHZjTy+lkRsVpsYyU57UNLd0XYykSlxEGvOD47doDPM7EcCLF
	OAJU8zhXHTMlWVDUhrIgI5iP2+4Jwu1EyA==
X-Received: by 2002:a05:690c:2608:b0:79f:b903:88c4 with SMTP id
 00721157ae682-7d33b348725mr203522267b3.46.1779818051399; Tue, 26 May 2026
 10:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519215841.2984970-10-martin.lau@linux.dev>
 <20260519225002.986EB1F00893@smtp.kernel.org> <2026519225454.By6y.martin.lau@linux.dev>
In-Reply-To: <2026519225454.By6y.martin.lau@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 26 May 2026 10:54:00 -0700
X-Gm-Features: AVHnY4KQI0xvn76Ojfwqn5BJzEfVnS3IaHKSZ2mEix5eW3t_R7baX6yhDJhmSvc
Message-ID: <CAMB2axPDDom8sD7u+2Fgo9dZO1ereX-unai8EW1SmsiDrnzzwQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 09/12] bpf: Add infrastructure to support
 attaching struct_ops to cgroups
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 4:58=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On Tue, May 19, 2026 at 10:50:02PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 4 potential is=
sue(s) to consider:
> > - [High] bpf_cgroup_struct_ops_foreach does not skip dummy items, leadi=
ng to unintended execution of cfi_stubs.
> > - [High] Using a loadable module's cfi_stubs as a dummy sentinel causes=
 a Use-After-Free when the module is unloaded and reloaded.
> > - [Medium] The macro bpf_cgroup_struct_ops_foreach uses rcu_dereference=
(), which is incompatible with sleepable struct_ops programs.
> > - [Medium] cgroup_bpf_struct_ops_register() lacks concurrency protectio=
n and global uniqueness enforcement.
> > --
> >
> > commit bad29e4e0d1357905491993ee45063766d0f7705
> > Author: Martin KaFai Lau <martin.lau@kernel.org>
> >
> > bpf: Add infrastructure to support attaching struct_ops to cgroups
> >
> > This patch adds necessary infrastructure to attach a struct_ops
> > map to a cgroup. The initial need was to support migrating
> > the legacy BPF_PROG_TYPE_SOCK_OPS to a struct_ops.
> >
> > > diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> > > index b2e79c2b41d51..8080f4a5c14b6 100644
> > > --- a/include/linux/bpf-cgroup.h
> > > +++ b/include/linux/bpf-cgroup.h
> >
> > [ ... ]
> >
> > > @@ -110,6 +112,18 @@ struct bpf_prog_list {
> > >     u32 flags;
> > >  };
> > >
> > > +#define bpf_cgroup_struct_ops_foreach(var, item, cgrp, atype)       =
       \
> > > +   for (item =3D rcu_dereference((cgrp)->bpf.effective[atype])->item=
s;\
> > > +        ((var) =3D READ_ONCE(item->kdata));                         =
 \
> > > +        item++)
> >
> > [Severity: High]
> > Does this macro need to skip dummy sentinel items?
> >
> > In cgroups with BPF_F_ALLOW_MULTI, compute_effective_progs() inserts du=
mmy
> > sentinel items at the boundaries between cgroup levels. For struct_ops,=
 this
> > dummy is the cfi_stubs pointer.
> >
> > This macro appears to iterate over all non-NULL items and fails to skip=
 the
> > dummy sentinel, which could cause the subsystem to repeatedly yield the
> > cfi_stubs pointer as a valid attached struct_ops instance.
>
> The ops in the cfi_stubs is safe to be called. It intentionally skips
> checking for dummy in the fast path.
>
> >
> > [Severity: Medium]
> > Will this rcu_dereference() trigger Lockdep warnings for sleepable stru=
ct_ops
> > programs?
> >
> > The commit message mentions adding free_after_mult_rcu_gp to support a =
mix of
> > sleepable and non-sleepable struct_ops, but plain rcu_dereference() enf=
orces
> > rcu_read_lock_held().
> >
> > If a subsystem iterates the array while holding rcu_read_lock_trace()
> > (required for sleepable execution), this might trigger a 'suspicious
> > rcu_dereference_check() usage' warning. Conversely, if it holds
> > rcu_read_lock(), the struct_ops program cannot sleep without causing a =
panic.
>
> The proposed bpf_tcp_ops only has non-sleepable programs.
>
> The future sleepable callsite will need another version of foreach or
> rcu_dereference_check can be used here also. I think rcu_dereference_chec=
k
> is better.
>
> >
> > > +
> > > +static inline bool cgroup_bpf_is_struct_ops_atype(enum cgroup_bpf_at=
tach_type atype)
> > > +{
> >
> > [ ... ]
> >
> > > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > > index a033aa479ab6e..d496db48d2b86 100644
> > > --- a/kernel/bpf/cgroup.c
> > > +++ b/kernel/bpf/cgroup.c
> > > @@ -24,6 +24,29 @@
> > >  DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF=
_ATTACH_TYPE);
> > >  EXPORT_SYMBOL(cgroup_bpf_enabled_key);
> > >
> > > +static u32 struct_ops_type_id[MAX_CGROUP_BPF_ATTACH_TYPE];
> > > +static void *struct_ops_cfi_stubs[MAX_CGROUP_BPF_ATTACH_TYPE];
> > > +static bool struct_ops_mult_rcu[MAX_CGROUP_BPF_ATTACH_TYPE];
> > > +
> > > +void cgroup_bpf_struct_ops_register(int atype, u32 type_id, void *cf=
i_stubs, bool mult_rcu)
> > > +{
> > > +   struct_ops_type_id[atype] =3D type_id;
> > > +   struct_ops_cfi_stubs[atype] =3D cfi_stubs;
> > > +   struct_ops_mult_rcu[atype] =3D mult_rcu;
> > > +}
> >
> > [Severity: Medium]
> > Does this registration function need concurrency protection to prevent =
global
> > array corruption?
> >
> > If two modules are loaded concurrently and declare the same cgroup_atyp=
e, it
> > seems this could cause a data race or silently overwrite the registered=
 type_id
> > and cfi_stubs of a legitimate module.
>
> This will be a bug in the subsystems having the same cgroup_atype
>
> but (the next one)...
>
> >
> > > +
> > > +static enum cgroup_bpf_attach_type find_atype_by_struct_ops_id(u32 t=
ype_id)
> >
> > [ ... ]
> >
> > >  static void *bpf_cgroup_array_dummy(enum cgroup_bpf_attach_type atyp=
e)
> > >  {
> > > +   if (cgroup_bpf_is_struct_ops_atype(atype))
> > > +           return struct_ops_cfi_stubs[atype];
> > >     return bpf_prog_dummy();
> > >  }
> >
> > [Severity: High]
> > Can using a loadable module's cfi_stubs as a dummy sentinel cause a
> > use-after-free when the module is unloaded and reloaded?
> >
> > If all maps are detached, the module providing the struct_ops can be un=
loaded,
> > and its cfi_stubs memory freed. However, the cgroup's effective array m=
ight
> > still retain the dangling pointer to the freed cfi_stubs if BPF_F_ALLOW=
_MULTI
> > was set.
> >
> > If the module is reloaded, cgroup_bpf_struct_ops_register() updates
> > struct_ops_cfi_stubs[atype] with a new pointer. If a user then queries =
the
> > cgroup via BPF_PROG_QUERY, the loop checks
> > item->prog =3D=3D bpf_cgroup_array_dummy(atype) to skip the dummy. Sinc=
e the
> > array contains the old freed pointer, it won't match the new cfi_stubs
> > pointer, and the query loop might mistakenly treat the old dummy as a v=
alid
> > map, causing a use-after-free when calling bpf_struct_ops_kdata_map_id(=
).
>
> Agree. This will be an issue on BPF_PROG_QUERY when the module reload.
> I did think about the module reload case but I have only considered the
> rcu-reader in bpf_cgroup_struct_ops_foreach.
> BPF_PROG_QUERY does not use rcu_read_lock and depends on cgroup_lock.
> This will need to be addressed.
>

Also thinking of the potential problems of leaving dangling cfi_stubs,
but I don't see any other cases.

In this instance, it seems adding a cgroup_bpf_enabled() guard in
__cgroup_bpf_query should be enough. The dangling cfi_stubs will not
be cleared until update_effective_progs(), which happens during the
first struct_ops map attachment. cgroup_bpf_enabled() will be false
until a struct_ops map is attached.
