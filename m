Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925F46AF2C
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074036; cv=pass; b=m55/VogevSa85fftW0Kf660hi0CG6Njw7eBFHgBMn6oSs7usyKml+Qy2LFuIpGKJS9wnkfkrDRHLl6jmv9b6Kgxnx+sSUEuZa8YUGvQsJR8QrhBt+4uHfd5zNVKx6SYD2vkOf5cAjC5InyCCFH7FCcRgkQO0ukID7hJEheiSFsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074036; c=relaxed/simple;
	bh=pFDIaO3ijrgVBN0tzYnOqs0tlVPFCNUED/bjUZob+Jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+b4vki5/5loapfBcmxBQtGHMliRz06WScIuPI09Qm4lLgcK1Q2Tc6Chx3LuxIj0VNorqUdVQrY5r2CvlfSwfcL2Sdb2nUZqCrJd3z6CZHvMwWOngONTxGvOFoVHEQDQA5VleQMtnqk61ity8OX4+adLMmgrykNPmQmdoL8ZIOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfuTUc1A; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfuTUc1A"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39394e1e8f3so29911881fa.1
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 06:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778074032; cv=none;
        d=google.com; s=arc-20240605;
        b=YlicsEqj3bh+n1qqe1CDbwW6YJVRmVHJ8Eo8lzhPoMr8iahCheVCx2TF+Pu8biTJJ5
         B2+1+ey3Vmp28ZVxUu3iaxdzyjQSBlJMHMBjnAJ+gKlsbNWyhUgU56y31R5wlt+i6kbF
         C15QJs3P5ckFCpF1khMAqbRfq8g1ETZ7OOIrtZLJ5jr6s51TmdFGg6Xps3JpRCB/+ELZ
         Cw4ij82rzP/aI9/k4RgDEXNYiCZEfNQdefgnQX5zBDDt9aI9vHfLoISEdPIQMhAOtwix
         6TRtsncX9EHa1epaI7i1E24JaioiysalQxM4ItZpC4ohydaoRcdhBxVU98oGGvoth3oD
         GH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G8+O6WlrTVqaZn8/F7q6B9USYK4FirbixL2u42VdTFQ=;
        fh=TehjY1t5eGpLR12A70uh3MyGVP6T186N9ByKaUcxf4Q=;
        b=cD1/N1285kmTHmKLSxk8PKj4o4OCE1ujz+wpJS34oCA+fGd5fs09CTLmGmNyAu6mTQ
         faIJIJz5gdqf0UNyGVTmIR+TLRCyaJCgSR4T+0jQPhz5wznbzEd0m9mYOtimP16dXB1q
         KsZL8BWMJSbmevD5AxPnCFSVgotcYApywpQ6g5/p1u8+J4Eb9Q4h3gIcP4y5UOQ9p7ft
         2OFfEC1EpVMk+sGU5DNCwvIj50CUt8mW/QmctGU30eWMAh/1TYFs5IP7mj+kZxsiJ14e
         ycJyaP1yzABqrfNiJ4bykRLH5smZTK+7haSUZ77/uLxdODodFRnbmQihmfl0e6Sp9OBk
         YnqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778074032; x=1778678832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8+O6WlrTVqaZn8/F7q6B9USYK4FirbixL2u42VdTFQ=;
        b=NfuTUc1ACk2XNc/IiZ/qc5awCvnQM9aE13qJNiSU69tLLscj/Fj9agJqQZlSvRiPQs
         GZ1ff4iFVJ2PXVF4tgSK6b97ebR13p6SXqnvrAtER0MBfL1idEpu+06KcohP11nnMRzH
         55ED3xh2E9HknCtbghLPSaIpTN37XueWfTrulYiMCwfbJRDTBZHTUnEZXdw/i2c3YROU
         PuAwKi4fGQoEhnJo4lpnG++ARmQkFHicAWIOe8oADcISSEnr5cDhuzOcFqUEvrQZOmds
         Q3WU2lUMu7JEZxW3Vngeg207KGnmZEhYqFqQH0FGa3bMEctqvgordLSOZ4IbDPNnK7sd
         UAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778074032; x=1778678832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G8+O6WlrTVqaZn8/F7q6B9USYK4FirbixL2u42VdTFQ=;
        b=omDa77t1qKfKfjz1HQWva74mFb4A0KIzR/l6r+WZmSrVfaSJHsE7gJF0hX0C9pkuA0
         BiSRdzW9x00UKnayitRN+c6a9LYmH/VxlVHBB1UQtfgUpRpdvWuzVC2+d5AAyBTkloJG
         fJ5/hGtvLkrK8H5UYP2ejaXUv7euwiMG+OGppbQxgbCwWn/ilb6uD/GYpZzYudHafFX/
         mDcaCtmaybWZ+RPI2go7E447MX0Ywy3+jkYGXCSfyW/+uzKJg0wFeihT/d8njxH48Lvx
         fv6uL+Taosb0jDqn3rTSbshH6jg8Y5cA/aRd2B/LABTIrFYKDfodnRzJML04KMj581fh
         OvQw==
X-Gm-Message-State: AOJu0Yxv7lKYh/jnbo+50QAxWO/QmcQoONtKzS6Wd0dC9zRJXkxxUDSS
	JGkcg8opNo5CroUw+1YQqJE1rFuaDAKp7+lMdMaoQ/2bV02bn60fM/bhNL7cNh33rRfViEmoVLe
	w/9aQap5+k1kXGYGVg3Kwn0GiAKDOmTU=
X-Gm-Gg: AeBDietnTNnBU2nf1JA5ycmEBTQ+2WUZKaxxQlN5SFlUDTKCadzyOREelpbnnT8LU4u
	l9es7UZBVTH9kSJJ+zx+qQx2tdU7Ks8xXGZchN7kO1SM/hQKnI3eg+1v/AYpcLWx2xGfrX9U7KK
	7WJ3/rSz4OK5ATYanYpx5oNJAnI21VZ9PfyUBV7r/TenWPN5eLLe71OCPqflX1xiEgFn87zLVrB
	dpNBcKubtuoDSoIah7YDJ0ZTAtQrL727c4gloxh7QHEkOdnmPIMV5sEOOFQ4+yXsiwbTBUuxlSu
	yN7BJ2U1E8gGgyLj
X-Received: by 2002:a2e:8952:0:b0:38e:98b0:3a7e with SMTP id
 38308e7fff4ca-393c4211654mr10682631fa.22.1778074032033; Wed, 06 May 2026
 06:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503165024.1526680-4-vernon2gm@gmail.com> <20260503174125.2C949C2BCB4@smtp.kernel.org>
In-Reply-To: <20260503174125.2C949C2BCB4@smtp.kernel.org>
From: Vernon Yang <vernon2gm@gmail.com>
Date: Wed, 6 May 2026 21:26:57 +0800
X-Gm-Features: AVHnY4Ljul8CUzS_G-va6ruKGX3ZCJiSzHij9r9KLJr3ECHCCjVxfY92mQxB2T4
Message-ID: <CACZaFFO9-xe-LewtzcUn9XHaJOUiMv60==M6TVOPVJHFafAefQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: introduce bpf_mthp_ops struct ops
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, inwardvessel@gmail.com, 
	Shakeel Butt <shakeel.butt@linux.dev>, ast@kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, baohua@kernel.org, Lance Yang <lance.yang@linux.dev>, 
	Dev Jain <dev.jain@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Forwarding sashiko review

On Mon, May 4, 2026 at 1:41=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 6 potential issu=
e(s) to consider:
> - [Critical] Use-After-Free vulnerability in `bpf_mthp_choose()` due to i=
mproper SRCU locking.
> - [High] NULL pointer dereference of `link` before validation in `bpf_mth=
p_ops_reg()` and `bpf_mthp_ops_unreg()`.
> - [High] Newly created cgroups silently bypass the hierarchical BPF mTHP =
policy.
> - [High] Silent registration failure leaves the cgroup hierarchy in an in=
consistent state.
> - [Medium] The BPF program can only restrict allowable THP orders, not ex=
pand or select new ones.
> - [Low] Compilation failure due to dereferencing an incomplete type and a=
 non-existent struct member.
> --
>
> commit e5c9c74b11f76b4de7ba4ef8ff94c10bae978e16
> Author: Vernon Yang <yanglincheng@kylinos.cn>
>
> mm: introduce bpf_mthp_ops struct ops
>
> Introducing bpf_mthp_ops enables eBPF programs to register the
> mthp_choose callback function via cgroup-ebpf.
>
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 2949e5acff35..80ec622213df 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> [ ... ]
> > @@ -291,6 +292,11 @@ unsigned long thp_vma_allowable_orders(struct vm_a=
rea_struct *vma,
> >                                      enum tva_type type,
> >                                      unsigned long orders)
> >  {
> > +     /* The eBPF-specified orders overrides which order is selected. *=
/
> > +     orders &=3D bpf_mthp_choose(vma->vm_mm, orders);
>
> Does this inadvertently prevent the BPF program from enabling or selectin=
g new
> orders? Since the return value is applied using a bitwise AND, it appears
> restricted to only disabling existing orders rather than customizing them=
 as
> described in the commit message.

Yes, It is restricted to only disabling existing orders.

> > +     if (!orders)
> > +             return 0;
> > +
> >       /*
> >        * Optimization to check if required orders are enabled early. On=
ly
> >        * forced collapse ignores sysfs configs.
> > diff --git a/mm/bpf_huge_memory.c b/mm/bpf_huge_memory.c
> > new file mode 100644
> > index 000000000000..e34e0a35edac
> > --- /dev/null
> > +++ b/mm/bpf_huge_memory.c
> [ ... ]
> > +unsigned long bpf_mthp_choose(struct mm_struct *mm, unsigned long orde=
rs)
> > +{
> > +     struct cgroup *cgrp;
> > +     struct mem_cgroup *memcg;
> > +     struct bpf_mthp_ops *ops;
> > +     int idx;
> > +
> > +     memcg =3D get_mem_cgroup_from_mm(mm);
> > +     if (!memcg)
> > +             return orders;
> > +
> > +     cgrp =3D memcg->css.cgroup;
> > +     ops =3D READ_ONCE(cgrp->mthp_ops);
> > +     if (unlikely(ops)) {
> > +             idx =3D srcu_read_lock(&mthp_bpf_srcu);
> > +             if (ops->mthp_choose)
> > +                     orders =3D ops->mthp_choose(cgrp, orders);
> > +             srcu_read_unlock(&mthp_bpf_srcu, idx);
> > +     }
>
> Could reading cgrp->mthp_ops outside the SRCU critical section lead to a
> use-after-free regression?
>
> If a thread is preempted immediately after ops is read:
>
>     ops =3D READ_ONCE(cgrp->mthp_ops);
>     <preempted>
>
> Another thread could execute bpf_mthp_ops_unreg(), set the pointer to NUL=
L,
> and complete synchronize_srcu(). The original thread would then resume,
> acquire the lock, and dereference the freed ops pointer.

(Report is identical to bot+bpf-ci) Good catch, I will fix that in the
next version. Thanks!

> > +
> > +     mem_cgroup_put(memcg);
> > +
> > +     return orders;
> > +}
> [ ... ]
> > +static int bpf_mthp_ops_reg(void *kdata, struct bpf_link *link)
> > +{
> > +     struct bpf_struct_ops_link *st_link =3D (struct bpf_struct_ops_li=
nk *)link;
> > +     struct bpf_mthp_ops *ops =3D kdata;
> > +     struct cgroup *cgrp =3D st_link->cgroup;
>
> Can this cause a regression if link is passed as NULL? st_link is cast fr=
om
> link, and st_link->cgroup implicitly dereferences it before the validatio=
n
> check below.

(Report is identical to bot+bpf-ci) I will fix that in the next version. Th=
anks!

> Additionally, struct bpf_struct_ops_link is defined privately in
> kernel/bpf/bpf_struct_ops.c and does not contain a cgroup field. Will thi=
s
> cause a compilation failure due to dereferencing an incomplete type and a
> non-existent struct member?

(Report is identical to bot+bpf-ci)

This series is based on linux v7.1-rc1 (26fd6bff2c05) + "mm: BPF OOM"[3]
first four patches.

All of the above definitions are in  "mm: BPF OOM" PATCH#2.

https://lore.kernel.org/linux-mm/20260127024421.494929-3-roman.gushchin@lin=
ux.dev/

> > +     struct cgroup_subsys_state *pos;
> > +
> > +     /* The link is not yet fully initialized, but cgroup should be se=
t */
> > +     if (!link)
> > +             return -EOPNOTSUPP;
> > +
> > +     cgroup_lock();
> > +     css_for_each_descendant_pre(pos, &cgrp->self) {
> > +             struct cgroup *child =3D pos->cgroup;
> > +
> > +             if (READ_ONCE(child->mthp_ops)) {
> > +                     /* TODO
> > +                      * Do not destroy the cgroup hierarchy property.
> > +                      * If an eBPF program already exists in the sub-c=
group,
> > +                      * trigger an error and clear the already set
> > +                      * bpf_mthp_ops data.
> > +                      */
> > +                     continue;
>
> Is it intentional to return 0 at the end of this function when we skip ov=
er
> descendants that already have mthp_ops configured? This appears to leave =
the
> hierarchy in an inconsistent state while userspace assumes the registrati=
on
> was fully successful.

Yes, that is exactly what I will do next.

> Furthermore, is there a missing hook in the cgroup creation path? Since t=
his
> loop only applies to existing descendants, any newly created cgroups will
> have their mthp_ops field initialized to NULL, allowing tasks moved there=
 to
> silently bypass the BPF program attached to their ancestors.

Good catch, I will set WRITE_ONCE(child->mthp_ops, parent->mthp_ops)
during cgroup_create(). Thanks!

> > +             }
> > +             WRITE_ONCE(child->mthp_ops, ops);
> > +     }
> > +     cgroup_unlock();
> > +
> > +     return 0;
> > +}
> > +
> > +static void bpf_mthp_ops_unreg(void *kdata, struct bpf_link *link)
> > +{
> > +     struct bpf_struct_ops_link *st_link =3D (struct bpf_struct_ops_li=
nk *)link;
> > +     struct bpf_mthp_ops *ops =3D kdata;
> > +     struct cgroup *cgrp =3D st_link->cgroup;
>
> Does this code similarly dereference link before it can be validated?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503165024.15=
26680-1-vernon2gm@gmail.com?part=3D3
