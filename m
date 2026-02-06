Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC135FF6B
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770397422; cv=pass; b=fPPwVm9w9LqNLG5aeO2k5DlxbchCvYDQrMvnQSYFZGESpkTdCDbbsr0oVHbvNqRTMSr4KDERT09D/kDu7jHYtBWNpckNSUxQTXf2per7WNWdPxRy1mjRzgjqniEOxPQ+HuroUUIFCBei4VmpmLe7iw2d+CodQi3uClPWqWUhjHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770397422; c=relaxed/simple;
	bh=0gK/iVx9C6u6GAIowrIBVLevr6ScygPxrWCcNezgBM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2Ka7P9aGjcmZ2DzYVQHTCf9ido4D0phkAVVZ1AGTXxgqiSRi2GEEC4up4AoVAMOU9kgo6FOm/abhsREHNbkNVrtQCUARVDl+3YM0BkkdnXrb55xfqC/Vxqa8IC+Tstd+bDE5d5VagslQERekiR5j3VyRqStZ2RwmMlOrDKb1VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNxd1FXa; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNxd1FXa"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81f4f4d4822so1336469b3a.3
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 09:03:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770397421; cv=none;
        d=google.com; s=arc-20240605;
        b=MzIsYgZJhLdzOwcAZMhd/tqCcfCvNDyM0yfKymk5fpiBnLNCrUPZRq0GZXRqfOQJOi
         qxVCwoivR67doic2J9L0xvpbTGmVbd4jmnemOpt5ABEQfrZhMr7QbappuA9xu1BZrIDm
         MRzqWnr8EL10IJrSKyK6VkFbns2y/bVzlAm+z1rZJZspO3G7VPqbu1AhZV/cy3htx3uZ
         s5XO1/2rhMT3FSWvu3pgtLD9Mnl5YgJK2rbbuDLGjbupMQEwmvtxELXrVcUy5tIWX0mq
         OUg7LmfyysT8FYR0eCZfXdgvr9wpI1O/rRAxBpdqZYmW0jZMZlgj9mPggBYoR1yvi01v
         2Tjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lzvjAbki/GfjEDACBGU634JpIQeRo+5itCY0HQJsI3A=;
        fh=+Rx81j6Cfa2hhtVW+eKCpaI3yjhQ1Dvd9c/d0T2fF1I=;
        b=S7fzw2keCt23E6d1p2+1x9IUupddJiPHHuJ2EDN4rtlbzbOBhWPi2h4ctWN+xsSGi7
         +sDFpjVYgOc6Fu0cEeLY5OMlexENdnYk02rVMAqbzZPiOaSgD3yLOVvRrZTQxsZx5UR3
         iQ6WBYbdwi1CP9xBb6E6uB3/XNZX4/Y0d2B36W/TRODRW4ebnC+6WzIaQnviH5LrnNpS
         zFiv+KY01U+lcFf151/+dYBB8abKYkABfBBAcpCtcVZocvZAQsumg+VJa8bPEIyWzV6j
         BnwZxEn+8ZbYGq6Xw6NG2lbrUENv9V5FTNz5G27l1pZ11uS2FuPM/oprDYnlvKnlx72Z
         fTbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770397421; x=1771002221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzvjAbki/GfjEDACBGU634JpIQeRo+5itCY0HQJsI3A=;
        b=iNxd1FXa0QJgXYPvmz/8t6s9SDEY4InSioWAoB5dwWTITPBb25zonhisSvQUCA3O9l
         xCFKM78/qMjsbl3dO28VvUJ4BR/Qvrbx1tSkqY3RnS2fuX+X9YERpRuxUryQLGhbC58f
         R+rf0cs7W8MTOzrPBkNuOjdVsmLKixz8b+KPqpbTbxi2jR5fNL9mEJzDbNxaNWUQ3r4M
         hToUJOIGBPj9GKknc4R3xTm0zYz+NS1EmJDq8XYzYn2Z8fKOuXX9j0Ft390PBuW0kiOf
         A10GMwWBZ+DhG1ANR7+yKqdLT5cXhtJ3T+7gDvDzJkPitU51+FfQiYs8PuaRhlctXDM/
         Y70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770397421; x=1771002221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lzvjAbki/GfjEDACBGU634JpIQeRo+5itCY0HQJsI3A=;
        b=nPy3ZWZF2bgSCEF3qdN/8d0CpB9KVQFbvkkGbtu+i+eoZNmZzuCsBFimno8evo7jD3
         rWbIhCYyzhPKHTDDLgV2PpSOnlwCsISXhHDfqN20pHZOcpcC1HzimxpKisb9g/KRu3rP
         CceZmnMexOhR6SDO/oTCdGxt12oEV8wCD4ro0AHLFtjgoeUWJEMPM5q8KRjUDmjlPLBH
         j+dLNZMJy5iWUsNLACiYeoFbqBPqzwUITCZWE7sXu+hqQWKvuv6k2VruGyWA6C/nbiLo
         A9TyDwc9J2O5tWiqxeGMgotZyVRIQeSbS2nU19PwUdxlluF6wAEeGqGuKWykL75n0cCh
         Rx+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBRnsmrn62+FxvffVkGGI2e8284YgGhqNuuarBVarxn/52J+2LcfpOjVKExLcqePICmWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy98HsWMSfliML9nyJntRF8B27xOK9oMre4hpOZBDHaZTQseaIq
	na5LNTvkm7HPOkxEqduUiU2pkF9lMtIVFSzneAolvgKom3AvCmZduRPhrRL5HvCHrNzSiBuBdnD
	B1SGhhja+48nFF/A21XyNuJ7wPixCD6s=
X-Gm-Gg: AZuq6aLM61d9p4CSTibNOvpJrMU4kfuy3j85BSg2cN6p1Gebs/+dDZYoGNZvj6gGjgh
	I63HLqD9vNhUMhylpAmLnkMOn2alV+4syIWtcVXArzMj2EC9XrSIcvRnQuSCHrhE0IDgToJEe+S
	nWSNzNbjazdP8b+xemJnB9aa0LoQ5tAEwxo/EFOpryG2t7i5uIrBJefBCWj6Knpyiz8uk8gX5d3
	l6vCC0eXq+yjraKGSeKheZRI0sjtDYXZgDqrB5DCG5eurBH5+qzPmUt8xT5jUKjJzAf1+R5iaI6
	8OF7RNc7BRs=
X-Received: by 2002:a05:6a20:4324:b0:34f:241f:aa1e with SMTP id
 adf61e73a8af0-393ad00b442mr3459764637.31.1770397421372; Fri, 06 Feb 2026
 09:03:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203093819.2105105-1-jolsa@kernel.org> <CAADnVQ+EU_f4LVDQkqkB0Q+QYMBH5ynXU3+rGZA2XCGmYMcFqg@mail.gmail.com>
 <aYM9YUl6xf9I2x4c@krava> <CAADnVQJPbnVEDYAAy4mUP7NmsGkUmeV9B73V+Bc=LYb8r8Zrow@mail.gmail.com>
 <aYRa_CDL1RqIR_8S@krava> <CAADnVQLJJn=bSDvQrjNyyeNdLOZABKDjjR_3j6DG3pgbsJ+JXA@mail.gmail.com>
 <aYWjxMeXABGcYqEI@krava>
In-Reply-To: <aYWjxMeXABGcYqEI@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Feb 2026 09:03:29 -0800
X-Gm-Features: AZwV_QjOjkBoQkj5t0GC43pofpDNXlwuDaVx59-ZLVp5H6LCJshEE1XSJVX6d-A
Message-ID: <CAEf4BzbUX8xEp1x66ugtj1C6sxWPJ+_9EpyVmy3TVOMiKrFcWA@mail.gmail.com>
Subject: Re: [RFC bpf-next 00/12] bpf: tracing_multi link
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 12:18=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Feb 05, 2026 at 07:55:19AM -0800, Alexei Starovoitov wrote:
> > On Thu, Feb 5, 2026 at 12:55=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Wed, Feb 04, 2026 at 08:06:50AM -0800, Alexei Starovoitov wrote:
> > > > On Wed, Feb 4, 2026 at 4:36=E2=80=AFAM Jiri Olsa <olsajiri@gmail.co=
m> wrote:
> > > > >
> > > > > On Tue, Feb 03, 2026 at 03:17:05PM -0800, Alexei Starovoitov wrot=
e:
> > > > > > On Tue, Feb 3, 2026 at 1:38=E2=80=AFAM Jiri Olsa <jolsa@kernel.=
org> wrote:
> > > > > > >
> > > > > > > hi,
> > > > > > > as an option to Meglong's change [1] I'm sending proposal for=
 tracing_multi
> > > > > > > link that does not add static trampoline but attaches program=
 to all needed
> > > > > > > trampolines.
> > > > > > >
> > > > > > > This approach keeps the same performance but has some drawbac=
ks:
> > > > > > >
> > > > > > >  - when attaching 20k functions we allocate and attach 20k tr=
ampolines
> > > > > > >  - during attachment we hold each trampoline mutex, so for ab=
ove
> > > > > > >    20k functions we will hold 20k mutexes during the attachme=
nt,
> > > > > > >    should be very prone to deadlock, but haven't hit it yet
> > > > > >
> > > > > > If you check that it's sorted and always take them in the same =
order
> > > > > > then there will be no deadlock.
> > > > > > Or just grab one global mutex first and then grab trampolines m=
utexes
> > > > > > next in any order. The global one will serialize this attach op=
eration.
> > > > > >
> > > > > > > It looks the trampoline allocations/generation might not be b=
ig a problem
> > > > > > > and I'll try to find a solution for holding that many mutexes=
. If there's
> > > > > > > no better solution I think having one read/write mutex for tr=
acing multi
> > > > > > > link attach/detach should work.
> > > > > >
> > > > > > If you mean to have one global mutex as I proposed above then I=
 don't see
> > > > > > a downside. It only serializes multiple libbpf calls.
> > > > >
> > > > > we also need to serialize it with standard single trampoline atta=
ch,
> > > > > because the direct ftrace update is now done under trampoline->mu=
tex:
> > > > >
> > > > >   bpf_trampoline_link_prog(tr)
> > > > >   {
> > > > >     mutex_lock(&tr->mutex);
> > > > >     ...
> > > > >     update_ftrace_direct_*
> > > > >     ...
> > > > >     mutex_unlock(&tr->mutex);
> > > > >   }
> > > > >
> > > > > for tracing_multi we would link the program first (with tr->mutex=
)
> > > > > and do the bulk ftrace update later (without tr->mutex)
> > > > >
> > > > >   {
> > > > >     for each involved trampoline:
> > > > >       bpf_trampoline_link_prog
> > > > >
> > > > >     --> and here we could race with some other thread doing singl=
e
> > > > >         trampoline attach
> > > > >
> > > > >     update_ftrace_direct_*
> > > > >   }
> > > > >
> > > > > note the current version locks all tr->mutex instances all the wa=
y
> > > > > through the update_ftrace_direct_* update
> > > > >
> > > > > I think we could use global rwsem and take read lock on single
> > > > > trampoline attach path and write lock on tracing_multi attach,
> > > > >
> > > > > I thought we could take direct_mutex early, but that would mean
> > > > > different order with trampoline mutex than we already have in
> > > > > single attach path
> > > >
> > > > I feel we're talking past each other.
> > > > I meant:
> > > >
> > > > For multi:
> > > > 1. take some global mutex
> > > > 2. take N tramp mutexes in any order
> > > >
> > > > For single:
> > > > 1. take that 1 specific tramp mutex.
> > >
> > > ah ok, I understand, it's to prevent the lockup but keep holding all
> > > the trampolines locks.. the rwsem I mentioned was for the 'fix', wher=
e
> > > we do not take all the trampolines locks
> >
> > I don't understand how rwsem would help.
> > All the operations on trampoline are protected by mutex.
> > Switching to rw makes sense only if we can designate certain
> > operations as "read" and others as "write" and number of "reads"
> > dominate. This won't be the case with multi-fentry.
> > And we still need to take all of them as "write" to update trampoline.
>
> this applies to scenario where we do not hold all the trampoline locks,
> in such case we could have race between single and multi attachment,
> while single/single attachment race stays safe
>
> as a fix the single attach would take read lock and multi attach would
> take write lock, so single/single race is allowed and single/multi is
> not ... showed in the patch below
>
> but it might be too much.. in a sense that there's already many locks
> involved in trampoline attach/detach, and simple global lock in multi
> or just sorting the ids would be enough
>

I'll just throw this idea here, but we don't have to do it right away.
What if instead of having a per-trampoline lock, we just have a common
relatively small pool of locks that all trampolines share based on
some hash (i.e., we deterministically map trampoline to one of the
locks). Then multi-attach can just go and grab all of them in
predefined order, while singular trampoline attaches will just get
their own one. We won't need to sort anything, we reduce the amount of
different locks. I don't think lock contention (due to lock sharing
for some trampolines) is a real issue to be worried about either.

> jirka
>
>
> ---
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index b76bb545077b..edbc8f133dda 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -30,6 +30,8 @@ static struct hlist_head trampoline_ip_table[TRAMPOLINE=
_TABLE_SIZE];
>  /* serializes access to trampoline tables */
>  static DEFINE_MUTEX(trampoline_mutex);
>
> +static DECLARE_RWSEM(multi_sem);
> +
>  struct bpf_trampoline_ops {
>         int (*register_fentry)(struct bpf_trampoline *tr, void *new_addr,=
 void *data);
>         int (*unregister_fentry)(struct bpf_trampoline *tr, u32 orig_flag=
s, void *old_addr, void *data);
> @@ -367,11 +369,7 @@ static struct bpf_trampoline *bpf_trampoline_lookup(=
u64 key, unsigned long ip)
>         head =3D &trampoline_ip_table[hash_64(tr->ip, TRAMPOLINE_HASH_BIT=
S)];
>         hlist_add_head(&tr->hlist_ip, head);
>         refcount_set(&tr->refcnt, 1);
> -#ifdef CONFIG_LOCKDEP
> -       mutex_init_with_key(&tr->mutex, &__lockdep_no_track__);
> -#else
>         mutex_init(&tr->mutex);
> -#endif
>         for (i =3D 0; i < BPF_TRAMP_MAX; i++)
>                 INIT_HLIST_HEAD(&tr->progs_hlist[i]);
>  out:
> @@ -871,6 +869,8 @@ int bpf_trampoline_link_prog(struct bpf_tramp_node *n=
ode,
>  {
>         int err;
>
> +       guard(rwsem_read)(&multi_sem);
> +
>         mutex_lock(&tr->mutex);
>         err =3D __bpf_trampoline_link_prog(node, tr, tgt_prog, &trampolin=
e_ops, NULL);
>         mutex_unlock(&tr->mutex);
> @@ -916,6 +916,8 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_node =
*node,
>  {
>         int err;
>
> +       guard(rwsem_read)(&multi_sem);
> +
>         mutex_lock(&tr->mutex);
>         err =3D __bpf_trampoline_unlink_prog(node, tr, tgt_prog, &trampol=
ine_ops, NULL);
>         mutex_unlock(&tr->mutex);
> @@ -1463,6 +1465,8 @@ int bpf_trampoline_multi_attach(struct bpf_prog *pr=
og, u32 *ids,
>         struct bpf_trampoline *tr;
>         u64 key;
>
> +       guard(rwsem_write)(&multi_sem);
> +
>         data.reg =3D alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
>         if (!data.reg)
>                 return -ENOMEM;
> @@ -1494,12 +1498,10 @@ int bpf_trampoline_multi_attach(struct bpf_prog *=
prog, u32 *ids,
>                 tr =3D mnode->trampoline;
>
>                 mutex_lock(&tr->mutex);
> -
>                 err =3D __bpf_trampoline_link_prog(&mnode->node, tr, NULL=
, &trampoline_multi_ops, &data);
> -               if (err) {
> -                       mutex_unlock(&tr->mutex);
> +               mutex_unlock(&tr->mutex);
> +               if (err)
>                         goto rollback_unlink;
> -               }
>         }
>
>         if (ftrace_hash_count(data.reg)) {
> @@ -1516,11 +1518,6 @@ int bpf_trampoline_multi_attach(struct bpf_prog *p=
rog, u32 *ids,
>                 }
>         }
>
> -       for (i =3D 0; i < cnt; i++) {
> -               tr =3D link->nodes[i].trampoline;
> -               mutex_unlock(&tr->mutex);
> -       }
> -
>         free_fentry_multi_data(&data);
>         return 0;
>
> @@ -1528,6 +1525,7 @@ int bpf_trampoline_multi_attach(struct bpf_prog *pr=
og, u32 *ids,
>         for (j =3D 0; j < i; j++) {
>                 mnode =3D &link->nodes[j];
>                 tr =3D mnode->trampoline;
> +               mutex_lock(&tr->mutex);
>                 WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, t=
r, NULL,
>                              &trampoline_multi_ops, &data));
>                 mutex_unlock(&tr->mutex);
> @@ -1550,6 +1548,8 @@ int bpf_trampoline_multi_detach(struct bpf_prog *pr=
og, struct bpf_tracing_multi_
>         int i, cnt =3D link->nodes_cnt;
>         struct bpf_trampoline *tr;
>
> +       guard(rwsem_write)(&multi_sem);
> +
>         data.unreg =3D alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
>         if (!data.unreg)
>                 return -ENOMEM;
> @@ -1567,6 +1567,7 @@ int bpf_trampoline_multi_detach(struct bpf_prog *pr=
og, struct bpf_tracing_multi_
>                 mutex_lock(&tr->mutex);
>                 WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, t=
r, NULL,
>                                                           &trampoline_mul=
ti_ops, &data));
> +               mutex_unlock(&tr->mutex);
>         }
>
>         if (ftrace_hash_count(data.unreg))
> @@ -1576,7 +1577,6 @@ int bpf_trampoline_multi_detach(struct bpf_prog *pr=
og, struct bpf_tracing_multi_
>
>         for (i =3D 0; i < cnt; i++) {
>                 tr =3D link->nodes[i].trampoline;
> -               mutex_unlock(&tr->mutex);
>                 bpf_trampoline_put(tr);
>         }
>
