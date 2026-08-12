Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D43357CFC
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557835; cv=pass; b=ND11aiZrvzBZ6JX0d6HM7uSwplVHVqnm8zrtNQfja0WIdk+Th7ahnkKtltwZ5lu5JZmGyYL9byBplbzEODmD6K3a3vxhcxStoUZb5LOw012DdQ7mnIEVQkcydV9yzau6E2P14veRDhOcdFaEdGAViDspq5ifIg+prXp43fFmyVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557835; c=relaxed/simple;
	bh=vMBqYA3Oao/qwl9109IYFIB6zYQ2CzD4vUL8EX97KuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FK5rP3x2yhwy1gj3LctTFHtWzVua2IFjB7xXveSpkmp6f8hkpbn2gRFS6QWRU/zBkm63M9noC1bWYf9C/du8F4p2ieFVnfwFJT9utIzmrktRxDeTtmqxWwUn3S14bAvmYjuTZyl0vx86GZScE0tJSV71LngXmTjPziqKRytoGu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTDpNRWh; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTDpNRWh"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66771ded50aso1895565d50.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 11:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786557831; cv=none;
        d=google.com; s=arc-20260327;
        b=Iq8ni0e7RFJN7JyWNgHPBERVAy6XxsoZ/hOAYja400nHuCXZZQPEiQeAcc1De4w+Uf
         7oxsqzne9z0O8DeeftFhzm9w828OfiQy/aYGDJmSe3/oIpiyrSDzY6AoSkHiIwpM4p+y
         DjLqDM9+tIhvh0+CQoTfbukzxlRGipGNb3ecXaWJn7rRJJvYG7mpQrxY15XMozNPUTcA
         Rv38Feh1LY4VhTid4qpBRk7paisTi+PyfxxjHIyqglDpvO5gckvpJSzqQ8gmXZ60WIyn
         Orwe/Q8kIXpWxynnSjBCYj1ZUKtZHOSN4UF/OqvcKZMM1N38shHgTEZbJ+mw8GuEvrsr
         dYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P7XVgnowewWWodMJST6arhy1oa6jdr7HK7v90K5tB4E=;
        fh=KFuCT+lsuCBthncmPgCKNp8gBFIheQk8cxGC6Wnibas=;
        b=I92mfiEdzOmTkn76d+wN/Zt1Pp5v1bTTjzfNlHjtxipqG/a3tnVCHcnWF5/9rtiowK
         r1EaIcaWVGWpUiF8fK5rSrg5TsgiwmJZ2885QZ4QGDW6mBPBwv0DL+ieMvz+fQVfL1p7
         FYato5EgOhS8wA4m4MBYckyIw/Ur3rV9H+R+FRBdvNhudFbtxZVsuVItn+5fSNB85N0j
         R9A+8DWPgikZ8dGzp9vTkuAdmQvdtZAONjrTalk/BeuUi91T4qDBmUF6juTa0PmDpFwa
         1vzOxlczuNJbjpeAnrgeaYuDwwDf5syzyrXPC1gMqpCC03Q9nOBJPWzX5UwhGK9G975R
         Hbhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786557831; x=1787162631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P7XVgnowewWWodMJST6arhy1oa6jdr7HK7v90K5tB4E=;
        b=KTDpNRWhvkvX1RTM1O0Gyo6bVKrKobf0NMyNwTdc9J6qdg1yreGY/ntlB7jQRO4rSl
         2Fyk9zEjQviOjCZBU9aTSPntX6YgIOSYV70JTgO+n3eXRHbIW+HYGjyCaf6C0zK4e96u
         BT5RKseEgFu/IuYw5nrgpTSC2t3f3ssPoEqBc6JAVjbf/SetIx5O9DRuRMOGV7laWCGT
         PbVVNej7gvnyyJQn7b8WU8T+QoRn70LXxZkTBtSb3b8ig1UB3HK3fD6AQw2UmkG1DpWP
         0kNbflv0IZYSFKnKtpOBPikTpV2s5j7bGrBUGWomW3/fIrH1ER/6vweIE5Db10oJEGvh
         UCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786557831; x=1787162631;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P7XVgnowewWWodMJST6arhy1oa6jdr7HK7v90K5tB4E=;
        b=bNS3Y/wR9BRAyA455nqj5ZD68050zqYJFS7aEz33TGd1pZLv65r1hINtXByHeSZNGC
         7qO8ldq4JsWFxkoWga9jXVnwbozX0luXAdtUoiSsC6q09fBl9gtuxVrv6Awm7PByw8WU
         rK7OKO1+WxCK+Az3Kmgdxz+BPHhAlhsy2+vfo0/Kpy+yezVpYfBaT+3TRwNPu5cZKasz
         3n4sPSHjEb/E9zS0vZA54v3Hwhr2ykSDnaicFzBybZV38tN4LFk/w/Mrxa2CfIKTD5Yn
         6DjJnqzBMkN4O99LQwzPmWXIazKqIiHF/Lg37LvlvNCKcdb5EIMK6oLsOri+hYEhW54p
         UiDg==
X-Gm-Message-State: AOJu0YxdyNBW7bBVbWoiP8+du9mquovf+RtjyZnLlGi/QVvsUdbbOfK5
	vmr1m/7KKxbHu4iD+8giyd7K8GeYymbv2mghTZRER8Moz65klPvQ94C8QsNXxawcK3M9BA4YD88
	TMp+1+FCzew0QR/lW2eFup9STzyQwy04=
X-Gm-Gg: AR+sD115UpekaAs1yS1Mi86Hl1FW23k/ZusEfLMLe5G3cIlIKiJYq3bd9Fs+wvV47kX
	EaB4ULs7ViLsFjdNJjC2FRGNFUwy9JO2JC5lop2UJ2vfKmqyGuyd5Au7QzSLV34Sj0/uG7oHlJY
	39Y8yKM0BWwOUI2eURV7iMiryxOUGq5SULIdODsauB3rtisyVo3N40XG6dAmDBv4H7ldl8V4KJV
	sfS29iBv4SrGirt6L1GLeXpRJk5qp+MNH44mlkBHwBuV0lefPCHh96XMX4l2lwOsdQ16FXRjWqR
	1wa/tGOXt/nfjMeXH7qA1caMz4T5JlPND1MzhgzWIyaF
X-Received: by 2002:a53:acd9:0:20b0:668:2553:a194 with SMTP id
 956f58d0204a3-66c517f0122mr73148d50.45.1786557830590; Wed, 12 Aug 2026
 11:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706171918.317102-1-ameryhung@gmail.com> <20260706171918.317102-10-ameryhung@gmail.com>
 <DJY2SPXTF9HL.10SSKCT9OMMBV@etsalapatis.com>
In-Reply-To: <DJY2SPXTF9HL.10SSKCT9OMMBV@etsalapatis.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 12 Aug 2026 11:03:38 -0700
X-Gm-Features: AUfX_mwPheRiXTpmAlfGZw460NaxLoOP7uc_z26cGgqtCmoF8EfkfUj3WI8Vtlw
Message-ID: <CAMB2axPVwvHZDkfgCmkY9K0fuzYv9Vq7ZZF565Qtx+FPEnGJeQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 09/15] bpf: Add infrastructure to support
 attaching struct_ops to cgroups
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	kuniyu@google.com, kerneljasonxing@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 11:21=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> > From: Martin KaFai Lau <martin.lau@kernel.org>
> >
> > This patch adds necessary infrastructure to attach a struct_ops
> > map to a cgroup. The initial need was to support migrating
> > the legacy BPF_PROG_TYPE_SOCK_OPS to a struct_ops.
> > Recently, there are other struct_ops use cases that
> > need to attach struct_ops to a cgroup. For example,
> > the recent BPF OOM and memcg discussion in LSFMMBPF 2026.
> >
> > The motivation is to create a consistent expectation
> > for attaching struct_ops to cgroup instead of each subsystem
> > creating its own infrastructure. This logic includes
> > hierarchy expectation, ordering expectation,
> > attachment API, and rcu gp.
> >
> > There is already an existing implementation for attaching
> > multiple bpf progs to a cgroup. There are also tools
> > built around it for querying. Attaching a struct_ops map
> > (which is a group of bpf programs) could also adhere to
> > a similar API and potentially reuse most of the existing
> > implementation.
> >
> > A couple of ideas have been tried. One of them
> > is to use mprog.c. In terms of the amount of changes,
> > I eventually came to the same conclusion as in
> > commit 120933984460 ("bpf: Implement mprog API on top of existing cgrou=
p progs").
> > I then shifted the focus to reusing the current
> > {update,compute,activate,purge}_effective_progs() which has
> > the main logic that implements the mprog API.
> >
> > Since then, I tried to add a 'struct cgroup *cgroup' member
> > to the existing 'struct bpf_struct_ops_link' and link_create
> > will create a 'struct bpf_struct_ops_link' object to be stored
> > in the pl->link. This turns out to have more changes on
> > both cgroup.c and bpf_struct_ops.c than I like.
> >
> > This patch directly reuses the 'struct bpf_cgroup_link' which
> > cgroup.c already understands. Add 'struct bpf_map *map'
> > to 'struct bpf_cgroup_link'. In the future, as more subsystems
> > are extended by struct_ops, we may consider to make
> > 'struct bpf_map *map' as a primary citizen of a link
> > like 'struct bpf_prog *prog' and directly add
> > 'struct bpf_map *map' to the generic 'struct bpf_link'.
> >
> > The pl->link could be the traditional 'prog' link or the
> > new 'map' link. The places that need to handle them differently
> > have already been refactored into the new prog_list_*() added in
> > the earlier patch. In those new prog_list_*(), this patch will
> > check "pl->link && pl->link->map", learn that it is a 'map' link
> > and handle it correctly.
> >
> > The bpf_prog_array also needs to handle that its item can store
> > the traditional 'prog' or it can store a struct_ops map.
> > The places that need to handle them differently have also
> > been refactored into the new bpf_cgroup_array_*() added
> > in the earlier patch. The two differences are:
> >   - different sentinel (dummy_bpf_prog in prog vs cfi_stub in struct_op=
s)
> >   - the array for struct_ops may need to go through different
> >     rcu gp.
> > The bpf_cgroup_array_*() functions use the cgroup_bpf_attach_type (ie a=
type)
> > to distinguish the array is storing prog or storing struct_ops map.
> >
> > This patch also implements a separate struct bpf_link_ops
> > "cgroup_struct_ops_link_ops" to have a separate link_ops implementation
> > that only handles the cgroup's struct_ops link.
> >
> > Questions:
> > - Although this patch did not change it, it is not obvious to me how
> >   the replace_effective_progs() and purge_effective_progs() handle
> >   cases when there are existing BPF_F_PREORDER progs attached
> >   in the hlist.
> >
> > Misc notes:
> > - CGROUP_TCP_SOCK_OPS is added to the 'enum cgroup_bpf_attach_type'.
> >   The actual implementation of the tcp_bpf_ops (a struct_ops)
> >   will be added in the next patch.
> >
> > - free_after_mult_rcu_gp is added to 'struct bpf_struct_ops' such that
> >   the bpf_prog_array can have a mix of sleepable and
> >   non-sleepable prog in a struct_ops. This can tell
> >   how the bpf_prog_array should be freed.
> >
> > - For a struct_ops that supports cgroup attachment, it does not need to
> >   implement its own reg/unreg function. reg/unreg to a cgroup is
> >   done by the common infrastructure added in this patch.
> >
> > - The cgroup's struct_ops link only supports BPF_F_ALLOW_MULTI.
> >   This is enforced internally in cgroup_bpf_struct_ops_attach.
> >   This should be consistent with the current prog's link
> >   behavior in cgroup_bpf_link_attach.
> >
> >   In the future, we may allow each subsystem to choose differently.
> >
> > - A cgroup_atype member is added to 'struct bpf_struct_ops'.
> >   When a subsystem struct_ops needs to support cgroup attachment,
> >   it needs to add a value to 'enum cgroup_bpf_attach_type'
> >   and then assign it to the newly added cgroup_atype member
> >   in the bpf_struct_ops.
> >
> > - During LINK_CREATE in syscall, the patch uses the same
> >   BPF_STRUCT_OPS (in attr->link_create.attach_type).
> >   The bpf_struct_ops_link_create learns the map and
> >   from the map it learns the st_ops. If the st_ops->cgroup_atype
> >   is not 0, it will create a cgroup's link.
> >
> > - When a subsystem registers a struct_ops that supports cgroup
> >   attachment, the struct_ops infrastructure will also ask the
> >   cgroup infrastructure to remember a few things. This is done
> >   by calling cgroup_bpf_struct_ops_register().
> >
> > Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
>
> Hi Amery,
>
> > ---
> >  include/linux/bpf-cgroup-defs.h |   1 +
> >  include/linux/bpf-cgroup.h      |  28 +++
> >  include/linux/bpf.h             |  19 +-
> >  include/uapi/linux/bpf.h        |   4 +-
> >  kernel/bpf/bpf_struct_ops.c     |  29 +++
> >  kernel/bpf/btf.c                |  23 +-
> >  kernel/bpf/cgroup.c             | 375 ++++++++++++++++++++++++++++++--
> >  kernel/bpf/syscall.c            |   1 +
> >  tools/include/uapi/linux/bpf.h  |   4 +-
> >  9 files changed, 463 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup=
-defs.h
> > index c9e6b26abab6..0147b8bec973 100644
> > --- a/include/linux/bpf-cgroup-defs.h
> > +++ b/include/linux/bpf-cgroup-defs.h
> > @@ -47,6 +47,7 @@ enum cgroup_bpf_attach_type {
> >       CGROUP_INET6_GETSOCKNAME,
> >       CGROUP_UNIX_GETSOCKNAME,
> >       CGROUP_INET_SOCK_RELEASE,
> > +     CGROUP_TCP_SOCK_OPS,
> >       CGROUP_LSM_START,
> >       CGROUP_LSM_END =3D CGROUP_LSM_START + CGROUP_LSM_NUM - 1,
> >       MAX_CGROUP_BPF_ATTACH_TYPE
> > diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> > index 4d0cc65976a1..8a75a6cd7309 100644
> > --- a/include/linux/bpf-cgroup.h
> > +++ b/include/linux/bpf-cgroup.h
> > @@ -100,6 +100,8 @@ struct bpf_cgroup_storage {
> >  struct bpf_cgroup_link {
> >       struct bpf_link link;
> >       struct cgroup *cgroup;
> > +     struct bpf_map *map;
> > +     wait_queue_head_t wait_hup;
> >  };
> >
> >  struct bpf_prog_list {
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
> >
> >  int __cgroup_bpf_run_filter_skb(struct sock *sk,
> > @@ -479,6 +493,20 @@ static inline int bpf_percpu_cgroup_storage_update=
(struct bpf_map *map,
> >       return 0;
> >  }
> >
> > +static inline bool cgroup_bpf_is_struct_ops_atype(int atype)
> > +{
> > +     return false;
> > +}
> > +static inline void cgroup_bpf_struct_ops_register(int atype, u32 type_=
id, void *cfi_stubs,
> > +                                               bool mult_trace)
> > +{
> > +}
> > +static inline int cgroup_bpf_struct_ops_attach(struct bpf_map *map,
> > +                                            const union bpf_attr *attr=
)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +
> >  #define cgroup_bpf_enabled(atype) (0)
> >  #define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, atype, t_ctx)=
 ({ 0; })
> >  #define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, atype) ({ 0; })
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index e371a4733135..df95ae690da5 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2100,11 +2100,18 @@ struct btf_member;
> >   *      unloaded while in use.
> >   * @name: The name of the struct bpf_struct_ops object.
> >   * @func_models: Func models
> > + * @cgroup_atype: A value in enum cgroup_bpf_attach_type for cgroup at=
tachment.
> > + *             0 means the struct_ops type does not support cgroup att=
achment.
> > + *             If cgroup_atype is non-zero, the @reg and @unreg must b=
e NULL
> > + *             because the attachment/detachment will be handled by th=
e bpf core.
> >   * @free_after_tasks_rcu_gp: Set to true if it needs the bpf core to w=
ait for
> >   *                           a tasks_rcu gp before freeing the struct_=
ops map
> >   *                           and its progs. It is unnecessary if the @=
unreg
> >   *                           has waited for the correct rcu gp or the =
@unreg
> >   *                           has ensured all struct_ops prog has finis=
hed running.
> > + * @free_after_mult_rcu_gp: Same as @free_after_tasks_rcu_gp but waiti=
ng for
> > + *                          both tasks_trace_rcu and regular rcu grace=
 period.
> > + *                          It is usually needed if the struct_ops has=
 sleepable prog.
> >   */
> >  struct bpf_struct_ops {
> >       const struct bpf_verifier_ops *verifier_ops;
> > @@ -2123,7 +2130,9 @@ struct bpf_struct_ops {
> >       struct module *owner;
> >       const char *name;
> >       struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
> > +     int cgroup_atype;
> >       bool free_after_tasks_rcu_gp;
> > +     bool free_after_mult_rcu_gp;
> >  };
> >
> >  /* Every member of a struct_ops type has an instance even a member is =
not
> > @@ -2258,6 +2267,7 @@ void *bpf_struct_ops_map_cfi_stubs(struct bpf_map=
 *map);
> >  bool bpf_struct_ops_valid_to_reg(struct bpf_map *map);
> >  int bpf_struct_ops_link_update_check(struct bpf_map *new_map, struct b=
pf_map *old_map,
> >                                    struct bpf_map *expected_old_map);
> > +int bpf_struct_ops_map_cgroup_atype(struct bpf_map *map);
> >
> >  #ifdef CONFIG_NET
> >  /* Define it here to avoid the use of forward declaration */
> > @@ -2330,6 +2340,10 @@ static inline u32 bpf_struct_ops_kdata_map_id(vo=
id *kdata)
> >  {
> >       return 0;
> >  }
> > +static inline int bpf_struct_ops_map_cgroup_atype(struct bpf_map *map)
> > +{
> > +     return 0;
> > +}
> >  static inline void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
> >  {
> >       return NULL;
> > @@ -2519,7 +2533,10 @@ u64 bpf_event_output(struct bpf_map *map, u64 fl=
ags, void *meta, u64 meta_size,
> >   * since other cpus are walking the array of pointers in parallel.
> >   */
> >  struct bpf_prog_array_item {
> > -     struct bpf_prog *prog;
> > +     union {
> > +             struct bpf_prog *prog;
> > +             void *kdata;
> > +     };
> >       union {
> >               struct bpf_cgroup_storage *cgroup_storage[MAX_BPF_CGROUP_=
STORAGE_TYPE];
> >               u64 bpf_cookie;
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index c91b5a4bda03..c982801ec7db 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1756,7 +1756,7 @@ union bpf_attr {
> >                       __u32   prog_cnt;
> >                       __u32   count;
> >               };
> > -             __u32           :32;
> > +             __u32           type_id;
> >               /* output: per-program attach_flags.
> >                * not allowed to be set during effective query.
> >                */
> > @@ -6818,6 +6818,8 @@ struct bpf_link_info {
> >               } xdp;
> >               struct {
> >                       __u32 map_id;
> > +                     __u32 :32;
> > +                     __u64 cgroup_id;
> >               } struct_ops;
> >               struct {
> >                       __u32 pf;
> > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> > index 3d650a7e9f68..06d72cdca601 100644
> > --- a/kernel/bpf/bpf_struct_ops.c
> > +++ b/kernel/bpf/bpf_struct_ops.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/btf_ids.h>
> >  #include <linux/rcupdate_wait.h>
> >  #include <linux/poll.h>
> > +#include <linux/bpf-cgroup.h>
> >
> >  struct bpf_struct_ops_value {
> >       struct bpf_struct_ops_common_value common;
> > @@ -1076,6 +1077,11 @@ static struct bpf_map *bpf_struct_ops_map_alloc(=
union bpf_attr *attr)
> >               goto errout;
> >       }
> >
> > +     if (st_ops_desc->st_ops->cgroup_atype && !(attr->map_flags & BPF_=
F_LINK)) {
> > +             ret =3D -EOPNOTSUPP;
> > +             goto errout;
> > +     }
> > +
> >       vt =3D st_ops_desc->value_type;
> >       if (attr->value_size !=3D vt->size) {
> >               ret =3D -EINVAL;
> > @@ -1116,6 +1122,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(u=
nion bpf_attr *attr)
> >
> >       mutex_init(&st_map->lock);
> >       bpf_map_init_from_attr(map, attr);
> > +     map->free_after_mult_rcu_gp =3D st_ops_desc->st_ops->free_after_m=
ult_rcu_gp;
> >       map->free_after_rcu_gp =3D true;
> >
> >       return map;
> > @@ -1244,6 +1251,14 @@ void *bpf_struct_ops_map_kdata(struct bpf_map *m=
ap)
> >       return st_map->kvalue.data;
> >  }
> >
> > +int bpf_struct_ops_map_cgroup_atype(struct bpf_map *map)
> > +{
> > +     struct bpf_struct_ops_map *st_map;
> > +
> > +     st_map =3D container_of(map, struct bpf_struct_ops_map, map);
> > +     return st_map->st_ops_desc->st_ops->cgroup_atype;
> > +}
> > +
> >  void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
> >  {
> >       struct bpf_struct_ops_map *st_map;
> > @@ -1419,6 +1434,7 @@ int bpf_struct_ops_link_create(union bpf_attr *at=
tr)
> >       struct bpf_link_primer link_primer;
> >       struct bpf_struct_ops_map *st_map;
> >       struct bpf_map *map;
> > +     int cgroup_atype;
> >       int err;
> >
> >       map =3D bpf_map_get(attr->link_create.map_fd);
> > @@ -1432,6 +1448,19 @@ int bpf_struct_ops_link_create(union bpf_attr *a=
ttr)
> >               goto err_out;
> >       }
> >
> > +     cgroup_atype =3D st_map->st_ops_desc->st_ops->cgroup_atype;
> > +     if (cgroup_atype) {
> > +             err =3D cgroup_bpf_struct_ops_attach(map, attr);
> > +             bpf_map_put(map);
> > +             return err;
> > +     }
> > +
> > +     if (memchr_inv(&attr->link_create.cgroup, 0, sizeof(attr->link_cr=
eate.cgroup)) ||
> > +         attr->link_create.target_fd) {
> > +             err =3D -EINVAL;
> > +             goto err_out;
> > +     }
> > +
> >       link =3D kzalloc_obj(*link, GFP_USER);
> >       if (!link) {
> >               err =3D -ENOMEM;
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 64572f85edc8..d591f306ace5 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/btf.h>
> >  #include <linux/btf_ids.h>
> >  #include <linux/bpf.h>
> > +#include <linux/bpf-cgroup.h>
> >  #include <linux/bpf_lsm.h>
> >  #include <linux/skmsg.h>
> >  #include <linux/perf_event.h>
> > @@ -9836,6 +9837,7 @@ btf_add_struct_ops(struct btf *btf, struct bpf_st=
ruct_ops *st_ops,
> >                  struct bpf_verifier_log *log)
> >  {
> >       struct btf_struct_ops_tab *tab, *new_tab;
> > +     int cgroup_atype;
> >       int i, err;
> >
> >       tab =3D btf->struct_ops_tab;
> > @@ -9847,8 +9849,10 @@ btf_add_struct_ops(struct btf *btf, struct bpf_s=
truct_ops *st_ops,
> >               btf->struct_ops_tab =3D tab;
> >       }
> >
> > +     cgroup_atype =3D st_ops->cgroup_atype;
> >       for (i =3D 0; i < tab->cnt; i++)
> > -             if (tab->ops[i].st_ops =3D=3D st_ops)
> > +             if (tab->ops[i].st_ops =3D=3D st_ops ||
> > +                 (cgroup_atype && cgroup_atype =3D=3D tab->ops[i].st_o=
ps->cgroup_atype))
> >                       return -EEXIST;
> >
> >       if (tab->cnt =3D=3D tab->capacity) {
> > @@ -9868,6 +9872,23 @@ btf_add_struct_ops(struct btf *btf, struct bpf_s=
truct_ops *st_ops,
> >       if (err)
> >               return err;
> >
> > +     if (cgroup_atype) {
> > +             if (!cgroup_bpf_is_struct_ops_atype(cgroup_atype) ||
>
> Can we add a comment here as to why free_after_tasks_rcu_gp is always
> invalid here (which IIUC is because it's
> free_after_mult_rcu_gp)?

This is because the dispatching macro,
bpf_cgroup_struct_ops_foreach(), requires the caller to be in an RCU
read-side critical section. Unlike bpf-tcp-cc, where rcu_read_lock()
is taken inside the trampoline by __bpf_prog_enter() and the trailing
trampoline insns run outside it, here the critical section encloses
the whole trampoline call. Therefore a vanilla rcu gp is enough for
both the kdata and the trampoline image.

>
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
>
> Network-style comment, should be regular kernel-style.

Ack.

>
> In terms of the content: What happens if the struct_ops are in a module,
> then we load/unload/reload? IIUC even if the signatures are identical,
> the btf_id could be different so it's not like we can always reuse the
> previous cgroup registration.

The information in struct_ops_{type_id, cfi_stubs, mult_rcu} is never
reused across registration. Every load calls
cgroup_bpf_struct_ops_register() and overwrites all three, so a reload
always installs the new type_id and cfi_stubs.

Note that there was a bug in an earlier version where stale cfi_stubs
could be dereferenced during query. It is fixed by the
!cgroup_bpf_enabled(atype) check in __cgroup_bpf_query(), which
returns before walking the effective array when nothing is attached.

>
> > +             cgroup_bpf_struct_ops_register(cgroup_atype,
> > +                                            tab->ops[btf->struct_ops_t=
ab->cnt].type_id,
> > +                                            st_ops->cfi_stubs,
> > +                                            st_ops->free_after_mult_rc=
u_gp);
> > +     }
> > +
> >       btf->struct_ops_tab->cnt++;
> >
> >       return 0;
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index 081d81de1816..745e826c9f61 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -24,6 +24,29 @@
> >  DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_A=
TTACH_TYPE);
> >  EXPORT_SYMBOL(cgroup_bpf_enabled_key);
> >
> > +static u32 struct_ops_type_id[MAX_CGROUP_BPF_ATTACH_TYPE];
> > +static void *struct_ops_cfi_stubs[MAX_CGROUP_BPF_ATTACH_TYPE];
> > +static bool struct_ops_mult_rcu[MAX_CGROUP_BPF_ATTACH_TYPE];
>
>
> Can we make a struct out of those? Right now we're carrying them loose
> into the module even though every index corresponds to a single
> registered struct_oips.

Sure, will do in v4.

>
> > +
> > +void cgroup_bpf_struct_ops_register(int atype, u32 type_id, void *cfi_=
stubs, bool mult_rcu)
> > +{
> > +     struct_ops_type_id[atype] =3D type_id;
> > +     struct_ops_cfi_stubs[atype] =3D cfi_stubs;
> > +     struct_ops_mult_rcu[atype] =3D mult_rcu;
> > +}
> > +
> > +static enum cgroup_bpf_attach_type find_atype_by_struct_ops_id(u32 typ=
e_id)
> > +{
> > +     enum cgroup_bpf_attach_type atype;
> > +
> > +     for (atype =3D 0; atype < MAX_CGROUP_BPF_ATTACH_TYPE; atype++) {
> > +             if (cgroup_bpf_is_struct_ops_atype(atype) &&
> > +                 struct_ops_type_id[atype] =3D=3D type_id)
> > +                     return atype;
> > +     }
> > +     return CGROUP_BPF_ATTACH_TYPE_INVALID;
> > +}
> > +
> >  /*
> >   * cgroup bpf destruction makes heavy use of work items and there can =
be a lot
> >   * of concurrent destructions.  Use a separate workqueue so that cgrou=
p bpf
> > @@ -306,6 +329,19 @@ static void bpf_cgroup_storages_link(struct bpf_cg=
roup_storage *storages[],
> >               bpf_cgroup_storage_link(storages[stype], cgrp, attach_typ=
e);
> >  }
> >
> > +static void cgroup_struct_ops_link_detach_wake(struct bpf_cgroup_link =
*link, bool wake_poll)
> > +{
> > +     cgroup_put(link->cgroup);
> > +     link->cgroup =3D NULL;
> > +
> > +     bpf_map_put(link->map);
> > +     /* READ_ONCE in cgroup_struct_ops_link_poll */
> > +     WRITE_ONCE(link->map, NULL);
> > +
> > +     if (wake_poll)
> > +             wake_up_interruptible_poll(&link->wait_hup, EPOLLHUP);
> > +}
> > +
> >  /* Called when bpf_cgroup_link is auto-detached from dying cgroup.
> >   * It drops cgroup and bpf_prog refcounts, and marks bpf_link as defun=
ct. It
> >   * doesn't free link memory, which will eventually be done by bpf_link=
's
> > @@ -313,21 +349,37 @@ static void bpf_cgroup_storages_link(struct bpf_c=
group_storage *storages[],
> >   */
> >  static void bpf_cgroup_link_auto_detach(struct bpf_cgroup_link *link)
> >  {
> > -     if (link->link.prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
> > -             bpf_trampoline_unlink_cgroup_shim(link->link.prog);
> > -     cgroup_put(link->cgroup);
> > -     link->cgroup =3D NULL;
> > +     if (link->map) {
> > +             cgroup_struct_ops_link_detach_wake(link, true);
> > +     } else {
> > +             if (link->link.prog->expected_attach_type =3D=3D BPF_LSM_=
CGROUP)
> > +                     bpf_trampoline_unlink_cgroup_shim(link->link.prog=
);
> > +             cgroup_put(link->cgroup);
> > +             link->cgroup =3D NULL;
> > +     }
>
> Nit: If we write this as:
>         if (link->map) {
>                 cgroup_struct_ops_link_detach_wake(link, true);
>                 return
>         }
>
> it's slightly less churn.

Will do.

>
> > +}
> > +
> > +static void bpf_cgroup_array_free_rcu(struct rcu_head *rcu)
> > +{
> > +     kfree(container_of(rcu, struct bpf_prog_array, rcu));
> >  }
> >
> > -static void bpf_cgroup_array_free(struct bpf_prog_array *array)
> > +static void bpf_cgroup_array_free(struct bpf_prog_array *array,
> > +                               enum cgroup_bpf_attach_type atype)
> >  {
> >       if (!array || array =3D=3D &bpf_empty_prog_array)
> >               return;
> > -     kfree_rcu(array, rcu);
> > +     if (struct_ops_mult_rcu[atype])
> > +             /* RCU tasks trace grace period implies RCU grace period.=
 */
> > +             call_rcu_tasks_trace(&array->rcu, bpf_cgroup_array_free_r=
cu);
> > +     else
> > +             kfree_rcu(array, rcu);
> >  }
> >
> >  static void *bpf_cgroup_array_dummy(enum cgroup_bpf_attach_type atype)
> >  {
> > +     if (cgroup_bpf_is_struct_ops_atype(atype))
> > +             return struct_ops_cfi_stubs[atype];
> >       return bpf_prog_dummy();
> >  }
> >
> > @@ -355,7 +407,12 @@ static int bpf_cgroup_array_copy_to_user(struct bp=
f_prog_array *array,
> >       for (item =3D array->items; item->prog && i < cnt; item++) {
> >               if (item->prog =3D=3D bpf_cgroup_array_dummy(atype))
>
> Retroactive nit for bpf_cgroup_array_dummy: The name is pretty confusing,=
 something
> that explain that this is really a tombstone value would be nicer.
> Especially since we're repurposing the cfi_stubs for per-attach type
> tombstones.

The value is not just a tombstone. bpf_cgroup_array_dummy is the same
concept as bpf_prog_dummy. It actually runs instead of skipping. Let's
not change the _dummy name to keep things consistent.

>
> >                       continue;
> > -             id =3D item->prog->aux->id;
> > +
> > +             if (cgroup_bpf_is_struct_ops_atype(atype))
> > +                     id =3D bpf_struct_ops_id(item->kdata);
> > +             else
> > +                     id =3D item->prog->aux->id;
> > +
> >               if (copy_to_user(prog_ids + i, &id, sizeof(id)))
> >                       return -EFAULT;
> >               i++;
> > @@ -417,7 +474,7 @@ static void cgroup_bpf_release(struct work_struct *=
work)
> >               old_array =3D rcu_dereference_protected(
> >                               cgrp->bpf.effective[atype],
> >                               lockdep_is_held(&cgroup_mutex));
> > -             bpf_cgroup_array_free(old_array);
> > +             bpf_cgroup_array_free(old_array, atype);
> >       }
> >
> >       list_for_each_entry_safe(storage, stmp, storages, list_cg) {
> > @@ -461,17 +518,26 @@ static struct bpf_prog *prog_list_prog(struct bpf=
_prog_list *pl)
> >
> >  static void prog_list_init_item(struct bpf_prog_list *pl, struct bpf_p=
rog_array_item *item)
> >  {
> > -     item->prog =3D prog_list_prog(pl);
> > -     bpf_cgroup_storages_assign(item->cgroup_storage, pl->storage);
> > +     if (pl->link && pl->link->map) {
> > +             item->kdata =3D bpf_struct_ops_map_kdata(pl->link->map);
> > +     } else {
> > +             item->prog =3D prog_list_prog(pl);
> > +             bpf_cgroup_storages_assign(item->cgroup_storage, pl->stor=
age);
> > +     }
>
> Same nit as above, an if-return avoid reformatting existing code.

Ack.

>
> >  }
> >
> >  static void prog_list_replace_item(struct bpf_prog_list *pl, struct bp=
f_prog_array_item *item)
> >  {
> > -     WRITE_ONCE(item->prog, pl->link->link.prog);
> > +     if (pl->link && pl->link->map)
>
> Can we somehow encapsulate the pl->link && pl->link->map to give it a
> more descriptive name? It's mentioned in previous commit descriptions
> what it is for, but as it stands it takes some thought to realize it's
> checking if this is a struct_ops item or a regular prog.

Sure. Will add prog_list_is_struct_ops().

>
> > +             WRITE_ONCE(item->kdata, bpf_struct_ops_map_kdata(pl->link=
->map));
> > +     else
> > +             WRITE_ONCE(item->prog, pl->link->link.prog);
> >  }
> >
> >  static u32 prog_list_id(struct bpf_prog_list *pl)
> >  {
> > +     if (pl->link && pl->link->map)
>
> Ditto.
>
> > +             return pl->link->map->id;
> >       return prog_list_prog(pl)->aux->id;
> >  }

[...]

> >
> > +static int __cgroup_struct_ops_link_detach(struct bpf_link *link, bool=
 wake_poll)
> > +{
> > +     struct bpf_cgroup_link *cg_link =3D container_of(link, struct bpf=
_cgroup_link, link);
> > +     enum cgroup_bpf_attach_type atype;
> > +     struct bpf_prog_list *pl;
> > +     struct bpf_map *map;
> > +     struct cgroup *cgrp;
> > +
> > +     cgroup_lock();
> > +
> > +     cgrp =3D cg_link->cgroup;
> > +     if (!cgrp) {
> > +             cgroup_unlock();
> > +             return 0;
> > +     }
> > +
> > +     map =3D cg_link->map;
> > +     atype =3D bpf_struct_ops_map_cgroup_atype(map);
> > +
> > +     hlist_for_each_entry(pl, &cgrp->bpf.progs[atype], node) {
> > +             if (pl->link =3D=3D cg_link)
> > +                     break;
> > +     }
>
> What happens if the link isn't found here? Update deals this with
> -ENOENT. Even though it's only possible if there's a bug I think
> we should at least have a warning.

Yes, this is indeed unreachable. Will still add WARN_ON_ONCE(!pl) and
return -ENOENT defensively.

>
> > +
> > +     /* mark deleted so compute_effective_progs() skips it */
> > +     pl->link =3D NULL;
> > +     if (update_effective_progs(cgrp, atype)) {
> > +             pl->link =3D cg_link;
> > +             purge_effective_progs(cgrp, pl, atype);
> > +     }
> > +
