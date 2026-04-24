Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECCE34C81E
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013218; cv=pass; b=lrh0EsPT8O1qw01QjRs2AZjUMXtZjg2bfwWuPl6/7S7oGHRu1CC7mpAKdGHnxPc8310r4PVowyqlgi/lF2aU/EKkrqWAuuE4Syiar4kLiJjeWY3YPqp6CZqED3c7Q5SPbaqkvEldOUVIGrXfU1OKCamABustWOhmSquWhQiK5Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013218; c=relaxed/simple;
	bh=qRFMoFp3syPnqQXJjTdkRUEYk2rQy+Gh/Burfci6Fi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVooug5ejhY95VQ5KS4EbA9D+z0OrsDY6S1RV0fSpyt9YBzbtpb71ZcyCy+b74RKWpaCG+pSpckb9TS1Z7JiWy4K3qcS336M03Aolo7m+A0E7j8oONk8nC71qMmmrDdL7F6lA9G5pchC4vrGEWjYL3fq/X9UpqzzWF5L+WZPrJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/HwCUdI; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/HwCUdI"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-799001d73bdso55308487b3.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 23:46:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777013216; cv=none;
        d=google.com; s=arc-20240605;
        b=JTX8LJalRLcELXA1mFaZ5N7RrbxIu1sMQ8hgLWgUASlvjHbwg+L5tMdSM04hQHmy1I
         uESIbJaIveqkdyC53+CvY8UcSmILFSQE8smWeMTJG14KHcLjKJ+H9DHi+9IcXV/AQCDp
         DYYHMOetFkQGzu4QnqrpkjfQh8711IsnJrOKqW4GHTJ3G5K0ta1PpjdxtGRDlc5y1XTb
         0Vq8l/P1HEiw8gzF37cpm2cynWBxUgpXqebzJu13x6kAdHQ6kxI2A9fBvK4aT+IxWxYI
         VUEYAzNIBwPQ8+Fce3vyPWCKSBqWxgsj7sqRi1fGk/d4Rt16IDzrlCCdbhUuvJG/783m
         x8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pG5N1aWYqHr3VjwttN7NR3A/LWyrjywLz4dOCiEC67E=;
        fh=41XuCkAesBlPtbfmUVD2iJF9WiWFw7xZWO9/I52l10g=;
        b=FXwx9EXPjWQWsnaShQkJwzQ4nWXwe21WTzY0Xgw/qL68Pi5nvfdvO9OmhFqP8u1PVs
         iHD+zfHKUey0y9tLWgwc3qrgov9nVcjjeLCN2R1Tsxdd7yNkzBy7cr8Ti+yv0H+xkybJ
         15ssUtpL1hej+sawpNDsOYD4DPxavJVoNEeEc1JSojJnYx3hkuDrb292ggg/lzF6Yjhi
         sb9ziiq/g2acwwMiwXwTVq5pqgJycoKWHeU/Z0XKX8049e/qmku2uB/9CM+2BjAgIP3b
         s6OYzVQhWif1tEeCq//S+toVXtpncMiHgkYorub1odehtLehQWWlA6bk5O4IUTbIraA3
         EwMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777013216; x=1777618016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG5N1aWYqHr3VjwttN7NR3A/LWyrjywLz4dOCiEC67E=;
        b=Q/HwCUdI0iA6p3Orf4EMjCiWNaHYONo5NJdJhKH3SjRwMiFlTSVy42iARC72A/EkJL
         y0wXfJTNdMpPRyVUhpMknqBxbGG2+tbqbLcTc/eBXv1wY7+5XasSblba4a4HOf6qe5D6
         vwczyc1szQjLIWTZk6aB+wTl8HxPuYspXzpvLvnfi9mmqagFkcttH8IDQYDloeSHRzvV
         GIQ4qo8MsYfGpLbt4oPjJaxMTg+/9vAg49k7Zlp0KgzihP8wTZXBLteGFN/roaOVLfqa
         hAo76Rd154Knhkb/II+Ccq5BxmIf+UGRwI01AKFRlFQJgolzSgTUvPo/25vctbb4k63g
         nTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777013216; x=1777618016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pG5N1aWYqHr3VjwttN7NR3A/LWyrjywLz4dOCiEC67E=;
        b=Fff4jWSI/HKJlN/LhC6S9mBnbq64AOhG9ILziA0vyVpbgd1Ow01K7w1onVhjfKlMHs
         ia3+ibWiPKHDDMXUl0PjNuHfQ4fuDmwLHl7hi9IKgyZEvpcl69Mi+ODPZwdHcZslgtAO
         3zZMetgMcHAb8UHF/WBtVGTQhb8uleSH2naAxxPV6+B+e1Sm6kkdcnlyO1rhw9wvknfn
         2c1R9qghmSFDuz+9qCdf+gH8U7Y++nf6Z8YQGDXHQDdss+iBZK3qrFwLfVVgcUIRGI8z
         mHsr10NlSy0veDCc46aVDMaFmjZ+byd7Whn1dl145TKtyoIy0CbUginNRnc7IV3ct/BW
         PHAw==
X-Forwarded-Encrypted: i=1; AFNElJ/gmzl23968Obl9R8KXDpsUgjMj9wpuaXIU2LRpCns+j2gsAhXFFaF5UxXXOi8Lnwd8pOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoL0P1ScNsVDew2VZpcHpeCW25s5wsuU0yUNdB2Q0nb5+zmUSV
	/qk/WGvXaB3oa4LkCEcI2Vp/tlw2UliF5uwVDbkV/utcSCRjw3qsYwqRw0+SUzQhWEGd82AtGkQ
	cv+iIGTviUGXQ+NjerIiyl6fc05Dex6U=
X-Gm-Gg: AeBDieuID2j8VjtN8QQPD5QofupdJthzFPOQ4pGUaeY6gVUyNS2R5nyFvPbRYwBMDBb
	ug8UbYeTsPA2kWRfkfvzGFM8jghtLdEIcuTOcV6wBE+wRakXJRQ98XuZ9RHCwqHZPC9OwMHqXrb
	kHKQx4TyLksGcLvABwGT+lk7RCT+PvihFgx9to0lVpa5jG8QhypGiD6/tlRp1gaDUQDFDfKcR+L
	n7k8aEhJUHNxKs3+FcB8XPXLz+tYttIXP+Gvh1n8SssiPr9jPeubjP3tpqnB9BXS2oMFDW06ZnF
	ZF7T5hAiIyYWoxrYkQ==
X-Received: by 2002:a05:690c:398:b0:7ba:fe31:65df with SMTP id
 00721157ae682-7bafe316bf1mr169650047b3.31.1777013215788; Thu, 23 Apr 2026
 23:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-5-ameryhung@gmail.com>
 <4de82d94-a975-4703-b45e-8932dfc28248@gmail.com> <CAMB2axO5TJwmYyvRheoZGH4ktRa0d8ig-UGK5E269iVoDH-zPw@mail.gmail.com>
 <CAEf4BzYuaA0xDm9WXv0vnorOgzmzsD-Rf6R3w5kus5Uo37SBFg@mail.gmail.com>
In-Reply-To: <CAEf4BzYuaA0xDm9WXv0vnorOgzmzsD-Rf6R3w5kus5Uo37SBFg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Apr 2026 23:46:44 -0700
X-Gm-Features: AQROBzDlrTDH-m1Sd2o5aNvKzf0YODxFxjr3CBtFdZ4EBt4YziJvzugAvl_pAr4
Message-ID: <CAMB2axNJjJPU_nwQ=b5=9CSAL4GEMDNgaZp6Qdek6BmbZ35PGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/9] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 5:04=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 23, 2026 at 11:44=E2=80=AFAM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >
> > On Thu, Apr 23, 2026 at 11:19=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> > >
> > >
> > >
> > > On 4/21/26 11:10 PM, Amery Hung wrote:
> > > > Refactor object relationship tracking in the verifier and fix a dyn=
ptr
> > > > use-after-free bug where file/skb dynptrs are not invalidated when =
the
> > > > parent referenced object is freed.
> > > >
> > > > Add parent_id to bpf_reg_state to precisely track child-parent
> > > > relationships. A child object's parent_id points to the parent obje=
ct's
> > > > id. This replaces the PTR_TO_MEM-specific dynptr_id and does not
> > > > increase the size of bpf_reg_state on 64-bit machines as there is
> > > > existing padding.
> > > >
> > > > When calling dynptr constructors (i.e., process_dynptr_func() with
> > > > MEM_UNINIT argument), track the parent's id if the parent is a
> > > > referenced object. This only applies to file dynptr and skb dynptr,
> > > > so only pass parent reg->id to kfunc constructors.
> > > >
> > > > For release_reference(), invalidating an object now also invalidate=
s
> > > > all descendants by traversing the object tree. This is done using
> > > > stack-based DFS to avoid recursive call chains of release_reference=
() ->
> > > > unmark_stack_slots_dynptr() -> release_reference(). Referenced obje=
cts
> > > > encountered during tree traversal cannot be indirectly released. Th=
ey
> > > > require an explicit helper/kfunc call to release the acquired resou=
rces.
> > > >
> > > > While the new design changes how object relationships are tracked i=
n
> > > > the verifier, it does not change the verifier's behavior. Here is t=
he
> > > > implication for dynptr, pointer casting, and owning/non-owning
> > > > references:
> > > >
> > > > Dynptr:
> > > >
> > > > When initializing a dynptr, referenced dynptrs acquire a reference =
for
> > > > ref_obj_id. If the dynptr has a referenced parent, parent_id tracks=
 the
> > > > parent's id. When cloning, ref_obj_id and parent_id are copied from=
 the
> > > > original. Releasing a referenced dynptr via release_reference(ref_o=
bj_id)
> > > > invalidates all clones and derived slices. For non-referenced dynpt=
rs,
> > > > only the specific dynptr and its children are invalidated.
> > > >
> > > > Pointer casting:
> > > >
> > > > Referenced socket pointers and their casted counterparts share the =
same
> > > > lifetime but have different nullness =E2=80=94 they have different =
id but the
> > > > same ref_obj_id.
> > > >
> > > > Owning to non-owning reference conversion:
> > > >
> > > > After converting owning to non-owning by clearing ref_obj_id (e.g.,
> > > > object(id=3D1, ref_obj_id=3D1) -> object(id=3D1, ref_obj_id=3D0)), =
the
> > > > verifier only needs to release the reference state, so it calls
> > > > release_reference_nomark() instead of release_reference().
> > > >
> > > > Note that the error message "reference has not been acquired before=
" in
> > > > the helper and kfunc release paths is removed. This message was alr=
eady
> > > > unreachable. The verifier only calls release_reference() after
> > > > confirming meta.ref_obj_id is valid, so the condition could never
> > > > trigger in practice (no selftest exercises it either). With the
> > > > refactor, release_reference() can now be called with non-acquired i=
ds
> > > > and have different error conditions. Report directly in
> > > > release_reference() instead.
> > > >
> > > > Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
> > > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > > ---
> > > >   include/linux/bpf_verifier.h |  22 ++-
> > > >   kernel/bpf/log.c             |   4 +-
> > > >   kernel/bpf/states.c          |   9 +-
> > > >   kernel/bpf/verifier.c        | 264 +++++++++++++++++-------------=
-----
> > > >   4 files changed, 152 insertions(+), 147 deletions(-)
> > > >
>
> [...]
>
> > > > @@ -673,82 +675,56 @@ static int mark_stack_slots_dynptr(struct bpf=
_verifier_env *env, struct bpf_reg_
> > > >       mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
> > > >                              &state->stack[spi - 1].spilled_ptr, ty=
pe);
> > > >
> > > > -     if (dynptr_type_refcounted(type)) {
> > > > -             /* The id is used to track proper releasing */
> > > > -             int id;
> > > > -
> > > > -             if (clone_ref_obj_id)
> > > > -                     id =3D clone_ref_obj_id;
> > > > -             else
> > > > -                     id =3D acquire_reference(env, insn_idx);
> > > > -
> > > > -             if (id < 0)
> > > > -                     return id;
> > > > -
> > > > -             state->stack[spi].spilled_ptr.ref_obj_id =3D id;
> > > > -             state->stack[spi - 1].spilled_ptr.ref_obj_id =3D id;
>
> is id assigned somewhere else now? where?
>
> > > > +     if (dynptr->type =3D=3D BPF_DYNPTR_TYPE_INVALID) { /* dynptr =
constructors */
> > > > +             if (dynptr_type_referenced(type)) {
> > > > +                     ref_obj_id =3D acquire_reference(env, insn_id=
x);
> > > > +                     if (ref_obj_id < 0)
> > > > +                             return ref_obj_id;
> > > > +             }
> > > > +     } else { /* bpf_dynptr_clone() */
> > > > +             ref_obj_id =3D dynptr->ref_obj_id;
> > > > +             parent_id =3D dynptr->parent_id;
> > > >       }
> > > >
> > > > +     state->stack[spi].spilled_ptr.ref_obj_id =3D ref_obj_id;
> > > > +     state->stack[spi - 1].spilled_ptr.ref_obj_id =3D ref_obj_id;
> > > > +     state->stack[spi].spilled_ptr.parent_id =3D parent_id;
> > > > +     state->stack[spi - 1].spilled_ptr.parent_id =3D parent_id;
> > > > +
> > > >       return 0;
> > > >   }
> > > >
>
> [...]
>
> > > > -/* The pointer with the specified id has released its reference to=
 kernel
> > > > - * resources. Identify all copies of the same pointer and clear th=
e reference.
> > > > - *
> > > > - * This is the release function corresponding to acquire_reference=
(). Idempotent.
> > > > - */
> > > > -static int release_reference(struct bpf_verifier_env *env, int ref=
_obj_id)
> > > > +static int idstack_push(struct bpf_idmap *idmap, u32 id)
> > > > +{
> > > > +     int i;
> > > > +
> > > > +     if (!id)
> > > > +             return 0;
> > > > +
> > > > +     for (i =3D 0; i < idmap->cnt; i++)
> > > > +             if (idmap->map[i].old =3D=3D id)
> > > > +                     return 0;
> > > > +
> > > > +     if (WARN_ON_ONCE(idmap->cnt >=3D BPF_ID_MAP_SIZE))
> > > > +             return -EFAULT;
> > >
> > > It feels like this check belongs above, maybe the first thing to do.
> >
> > Shouldn't it allow the verification to continue when pushing an id
> > that already exists in the stack?
>
> yep
>
> >
> > >
> > > > +
> > > > +     idmap->map[idmap->cnt++].old =3D id;
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int idstack_pop(struct bpf_idmap *idmap)
> > > >   {
> > > > +     if (!idmap->cnt)
> > > > +             return 0;
> > > > +
> > > > +     return idmap->map[--idmap->cnt].old;
> > > > +}
> > > > +
> > > > +/* Release id and objects referencing the id iteratively in a DFS =
manner */
> > > > +static int release_reference(struct bpf_verifier_env *env, int id)
> > > > +{
> > > > +     u32 mask =3D (1 << STACK_SPILL) | (1 << STACK_DYNPTR);
> > > >       struct bpf_verifier_state *vstate =3D env->cur_state;
> > > > +     struct bpf_idmap *idstack =3D &env->idmap_scratch;
> > > > +     struct bpf_stack_state *stack;
> > > >       struct bpf_func_state *state;
> > > >       struct bpf_reg_state *reg;
> > > > -     int err;
> > > > +     int root_id =3D id, err;
> > > >
> > > > -     err =3D release_reference_nomark(vstate, ref_obj_id);
> > > > -     if (err)
> > > > -             return err;
> > > > +     idstack->cnt =3D 0;
> > > > +     idstack_push(idstack, id);
> > > >
> > > > -     bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> > > > -             if (reg->ref_obj_id =3D=3D ref_obj_id)
> > > > -                     mark_reg_invalid(env, reg);
> > > > -     }));
> > > > +     if (find_reference_state(vstate, id))
> > > > +             WARN_ON_ONCE(release_reference_nomark(vstate, id));
> > > > +
> > > > +     while ((id =3D idstack_pop(idstack))) {
> > > > +             bpf_for_each_reg_in_vstate_mask(vstate, state, reg, s=
tack, mask, ({
> > > > +                     if (reg->id !=3D id && reg->parent_id !=3D id=
 && reg->ref_obj_id !=3D id)
> > > > +                             continue;
> > > > +
> > > > +                     if (reg->ref_obj_id && id !=3D root_id) {
> > >
> > > Does this line check that the only ref_obj_id we should see is either
> > > 0 or root_id? can we rewrite it as
> > > if (reg->ref_obj_id && reg->ref_obj_id !=3D root_id)
> > >
> > > this is simpler, because id can also be reg->id/reg->parent_id, which=
 is
> > > hard to reason what that means.
> > >
> >
> > Looking at it again, I think my release_reference() is wrong. It first
> > calls release_reference_nomark() if the id is a ref_obj_id. This will
> > invalidate all registers with the same ref_obj_id without traversing
> > their children.
> >
>
> hm, will it? from what I see, release_reference_nomark() doesn't do
> anything with registers/stack slots, just removes the reference from
> state->refs

You are right... I was conflating it with something else.

I think Mykyta's suggestion seems to be more straightforward so I will
change it in the next version.


>
>
> > I should remember the root_ref_obj_id instead of calling
> > release_reference_nomark(). Then, the check you mentioned should be:
> >  if (reg->ref_obj_id && reg->ref_obj_id !=3D root_ref_obj_id)
> >
> > I will write a selftest to confirm the issue and include it in the
> > next respin if this turns out to be a bug.
