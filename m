Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC3B37186D
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433942; cv=pass; b=e5LLFbx4PHEhNKCIOcNVYhCPlOUKxzb/19QJLiufujhmSjASaFrWuQulDmRNrd5k5B150fLRcZOycORMM5sdbBKw2M5QqYpCW7iXi1PlL0HfN87cgSRWguCTxfFNqZP+MdOn0fMW4YFTJaVZSqF73yH3QuPugHUdKpqQSPdnzKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433942; c=relaxed/simple;
	bh=40KYgHnhjSiHLdwDpLF5x4iF2sn2Ws3bs7xDuEqjSMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkAav9aUuALiznE1FFqLRfFfM6e/UDlXUuAC6IE/qea9nLfUwsrG0IzRSZZ22TA36laBvrPaVIW5UjA+VFmABGpq1KzbRWWDR7nRE5wAiLIF3frQy+5eP6WLhWHCCI818uLK3k4wgKkusI4ylhPzMSaOt/WPX3BYg1jM8ZUSy8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpL8V104; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpL8V104"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-798374d0f44so55096397b3.0
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 13:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773433937; cv=none;
        d=google.com; s=arc-20240605;
        b=UiB1uP48TWaHj3Ms5qELHRUatRfVhW4BIfQiFSvd3qfJ/d96AFtlmoGegpqzseAkM4
         v7SrSmMdUfbS70EsYQMjctaDJciIpW1//GoK51TMW852OWnMo5LXRFEsvatt0uCnhfAO
         xBXKzyM680T0kGSzM3Uh1giEXOni0TAzRg180jZZs3e4Mt4DNkD52YvKcRyy6+EDR7WL
         fiE28AjETyskhbzwAMb01Ry9AZiePGrTG+05JRH5L6dTb0qKmd1UHthlpK7dKA24XwjA
         DIPnGhokek/0vN1ZjPe1089vhzA8ms6HLmSYqVrzJPnEW05/GCQF29dXIXoJtdXpq++w
         rmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xrvXrc2a0tLMlC/MG2taLuEzPA0KpCXPwW0g4OAbVgc=;
        fh=6ElxuiIjr8MUw7uRyrqk6E+jhEPFMT0pHHkRrcSi3dU=;
        b=ZcFHCDFujzLQDqUXuAQEfpu9QEqcA1Cxl4RzbjCHr9yY9WdD1F8LVQx3Mw06GmN0rT
         lb7s1VN2Ktdk28m3dTZTNtG5Nht2aeZVaqQkBu0exDa29r9qUxDT6ASqWAy3ZS2LWCBd
         3Tlfukhvc/LL7mzTX2Jjy1JZOErLoPBxkx4fKEQwvCLrZpDAulRn9PfrxT3/N2jcDn56
         qzsLBGrSknX09YGEMyLXL+XZQokQGhlHpN3qHBAc4bAmYA+NUiKzdEAX4wulq6PdGcmW
         QES+kPcTm6dMwy6vq9lKBMsnn/Nza3ygey6BzMUPHm1kWF8SSuT/dSkFmN5deUE6hKN3
         L9ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773433937; x=1774038737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrvXrc2a0tLMlC/MG2taLuEzPA0KpCXPwW0g4OAbVgc=;
        b=KpL8V104jRZ3Fba7JgU0Ae9IWnB7HlpWi/DqCMvYQcYtjSnb3wwJgpQY1iUJups3lh
         TfsKv/0bT/4WcOE3O/QmuJfUo7hNl53w/VYFsd/qrehuEsc8+8TIDuyHSnruK+4nS9Y/
         K3NL2W2k5He0cJesN+KRji5TSQikVMw5PVozjTM0yGS+dSd4boJRs9dS0uFymdCp6Nfb
         jOeeAxY5POihkCK4eaq1rMclRdGy3quuMxpWMKoStG2YKnxQTk4nY2vOxqUqe7kcmd9y
         V5+ZwYH/xtO6eSyqQOLnjpXCcgCjTUE/VngFZ2OfqPfCpRCBVdgmxDiPQEqzLFWUVgmE
         ajFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773433937; x=1774038737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xrvXrc2a0tLMlC/MG2taLuEzPA0KpCXPwW0g4OAbVgc=;
        b=Su3vN9xuiedRYbKvBebQO1lMF4d9JhmPmGRs3Mn2qtQqZYwOTktu4BT8X8sISkMRxH
         0Twgiv1Z7LXUjGCYVQEWLAJcuwBfQUntSInORpBzR3NVnVrTVl0PfMsCOKPGKpqH3BHL
         gjzkWFL4Bry65LOdVt5BtOIGoSkM4QpR0rX2Ux8aDhRdcuUmBRn5V1hZi1xoa8+D6ID8
         bEfIZFvA4R2BM4oEh3BE8365ThtL9ak21YRROCPwsMlgQT1RpydCtScD0iHi4mzu32EI
         lWHVz8PhITdbGQviNMO0/2c5CWsiO+4CWd8V5Fajz9U3UEDgP+xVAlivmBDnQ35U4HNm
         9wnA==
X-Gm-Message-State: AOJu0Yw0cRvJ9Jv9+wFGisG18Br3DUrXs+WhksMIwUBcph2mk5YxT9O4
	MXDg9RaNo1e9qoGPHO9zlNZfmNiL6CZCYrPP0veznib4ln/vFt7hccTNwPWXaKD5K4IYfAjEyB5
	TCHzb8/Z6LGBvp3IhfaISpviX2fztDvI=
X-Gm-Gg: ATEYQzy7DiT2UpMaKP0uWWjBjzjkTCIH94a4+UDeaXMjfyGtywOwyburUWBMEJ4y1Rd
	ik00+5PhbPGIGj00tFvJfdUY//tYT5YM6lqYfAAFY+tCFV2++8XLBH01EzAg9SQrGwel8SeNgtB
	JrZRpslvrNHnoLezoftpOEfsqdra7cS0VoVvopgdDmuERmUES2rIAKZgEDFEYXGNnUkqNgpkDib
	OSXj2gkLZXF0RkVU9ycpTZjXx6zSaRuAhsOR53sT6eIp/AwBpy7OhDJYzKYG8jeVLL8AgxfQ8I7
	WVSOmlxoks3vqRarVw==
X-Received: by 2002:a05:690c:4807:b0:796:db6:2386 with SMTP id
 00721157ae682-7994767b56dmr78688927b3.31.1773433936908; Fri, 13 Mar 2026
 13:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-7-ameryhung@gmail.com>
 <CAEf4BzZhAmLV92tw=tDs62WmUTnHbfVOu3KVE3_g-vtMt-bcoQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZhAmLV92tw=tDs62WmUTnHbfVOu3KVE3_g-vtMt-bcoQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 13 Mar 2026 13:32:04 -0700
X-Gm-Features: AaiRm51-cq0fcOUdY-MoWMmGBdxaEXlCaJ5KUoLBs-RCotGipFO7aonQv-Ut6gM
Message-ID: <CAMB2axOqyQtVbf1YAASNV8WWNrQBJRZ7kcBEXovBBLDRmmKpBQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 06/11] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 3:32=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > Refactor object relationship tracking in the verifier by removing
> > dynptr_id and using parent_id to track the parent object. Then, track
> > the referenced parent object for the dynptr when calling a dynptr
> > constructor. This fixes a use-after-free bug. For dynptr that has
> > referenced parent object (skb dynptr in BPF qdisc or file dynptr),
> > the dynptr or derived slices need to be invalidated when the parent
> > object is released.
> >
> > First, add parent_id to bpf_reg_state to be able to precisely track
> > objects' child-parent relationship. A child object will use parent_id
> > to track the parent object's id. This replaces dynptr slice specific
> > dynptr_id.
> >
> > Then, when calling dynptr constructors (i.e., process_dynptr_func() wit=
h
> > MEM_UNINIT argument), track the parent's id if parent is an referenced
> > object. This only applies to file dynptr and skb dynptr, so only pass
> > parent reg->id to kfunc constructors.
> >
> > For release_reference(), this mean when invalidating an object, it need=
s
> > to also invalidate all dependent objects by traversing the subtree. Thi=
s
> > is done using stack-based DFS to avoid recursive call chain of
> > release_reference() -> unmark_stack_slots_dynptr() ->
> > release_reference(). Note that, referenced objects cannot be released
> > when traversing the tree if it is not the object id initially passed to
> > release_reference() as they would actually require helper call to
> > release the acquired resources.
> >
> > While the new design changes how object relationships are being tracked
> > in the verifier, it does NOT change the verifier's behavior. Here is
> > the implication of the new design for dynptr, ptr casting and
> > owning/non-owning references.
> >
> > Dynptr:
> >
> > When initializing a dynptr, referenced dynptr will acquire an reference
> > for ref_obj_id. If the dynptr has a referenced parent, the parent_id
> > will be used to track the its id. When cloning dynptr, ref_obj_id and
> > parent_id of the clone are copied directly from the original dynptr.
> > This means, when releasing a dynptr, if it is a referenced dynptr,
> > release_reference(ref_obj_id) will release all clones and the original
> > and derived slices. For non-referenced dynptr, only the specific dynptr
> > being released and its children slices will be invalidated.
> >
> > Pointer casting:
> >
> > Referenced socket pointer and the casted pointers should share the same
> > lifetime, while having difference nullness. Therefore, they will have
> > different id but the same ref_obj_id.
> >
> > When converting owning references to non-owning:
> >
> > After converting a reference from owning to non-owning by clearing the
> > object's ref_reg_id. (e.g., object(id=3D1, ref_obj_id=3D1) -> object(id=
=3D1,
> > ref_obj_id=3D0)), the verifier only needs to release the reference stat=
e
> > instead of releasing registers that have the id, so call
> > release_reference_nomark() instead of release_reference().
> >
> > CC: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h |  14 +-
> >  kernel/bpf/log.c             |   4 +-
> >  kernel/bpf/verifier.c        | 274 ++++++++++++++++++-----------------
> >  3 files changed, 154 insertions(+), 138 deletions(-)
> >
>
> [...]
>
>
> > -       ref_obj_id =3D state->stack[spi].spilled_ptr.ref_obj_id;
> > -
> > -       /* If the dynptr has a ref_obj_id, then we need to invalidate
> > -        * two things:
> > -        *
> > -        * 1) Any dynptrs with a matching ref_obj_id (clones)
> > -        * 2) Any slices derived from this dynptr.
> > +       /*
> > +        * For referenced dynptr, the clones share the same ref_obj_id =
and will be
> > +        * invalidated too. For non-referenced dynptr, only the dynptr =
and slices
> > +        * derived from it will be invalidated.
> >          */
>
> this is confusing to me. Why the nature of dynptr should change
> anything about the scope of invalidation? This should be controlled
> from outside. E.g., if someone invalidates clone by overwriting it on
> the stack, we shouldn't just go an invalidate all other clones. We
> just invalidate that particular clone (regardless of whether it's a
> clone of file dynptr or just some mem dynptr).

This is the nuance that lies in dynptr.

When invalidating a referenced dynptr clone, all clones and the
original must be invalidated. There is no option to just invalidate
one. The reason is that bpf_dynptr_clone just copies bpf_dynptr_kern,
not calling the dynptr ctor to set up necessary stuff to make a dynptr
valid. (Also want to mention referenced dynptr cannot be destroy by
overwriting the stack slot)

This is not the case for unreferenced dynptr. The entire state of the
dynptr is saved in bpf_dynptr_kern. Therefore their clones can live
independently.

To summarize, referenced dynptr can only be released via helper and
all clones must be invalidated. Non-referenced dynptr do not need to
be released, but when invalidated by overwriting the stack slot, it
does not affect other clones.

>
> But if someone is calling bpf_dynptr_file_discard() on one of the
> clones, then yes, all the clones need to be invalidated. But that
> should be handled as more generic "this file lifetime is ending", no?
>
> Maybe I'm missing something, but it feels wrong to make decisions like
> this inside a low-level (and thus intentionally dumb)
> unmark_stack_slots_dynptr() helper.
>
> > -
> > -       /* Invalidate any slices associated with this dynptr */
> > -       WARN_ON_ONCE(release_reference(env, ref_obj_id));
> > -
> > -       /* Invalidate any dynptr clones */
> > -       for (i =3D 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
> > -               if (state->stack[i].spilled_ptr.ref_obj_id !=3D ref_obj=
_id)
> > -                       continue;
>
> [...]
>
> > +static u32 idstack_pop(struct bpf_idstack *idstack)
> > +{
> > +       return idstack->cnt > 0 ? idstack->ids[--idstack->cnt] : 0;
> > +}
> > +
> > +static int release_reg_check(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg,
> > +                            int id, int root_id, struct bpf_idstack *i=
dstack)
>
> tbh, I feel like release_reg_check is doing too much, it both enqueues
> children and checks unreleased references. And this <0, 0, and 1 as
> return values (where 1 is completely unobvious) is an indicator of
> that. I think id/parent_id/ref_obj_id check can be done inline in
> release_reg_check() just fine (yes, two place, no big deal, but if so,
> make it a small helper) and then you'll have more obvious logic break
> down into a) check if reg should be enqueue, b) if so, check ref leak,
> and c) enqueue new id

Make sense to break it down. I also found it hard to name this
function and maybe that already indicates that it is trying to do
much.

>
> >  {
> > +       struct bpf_reference_state *ref_state;
> > +
> > +       if (reg->id =3D=3D id || reg->parent_id =3D=3D id || reg->ref_o=
bj_id =3D=3D id) {
> > +               /* Cannot indirectly release a referenced id */
> > +               if (reg->ref_obj_id && id !=3D root_id) {
> > +                       ref_state =3D find_reference_state(env->cur_sta=
te, reg->ref_obj_id);
> > +                       verbose(env, "Unreleased reference id=3D%d allo=
c_insn=3D%d when releasing id=3D%d\n",
> > +                               ref_state->id, ref_state->insn_idx, roo=
t_id);
> > +                       return -EINVAL;
> > +               }
> > +
> > +               if (reg->id && reg->id !=3D id)
> > +                       idstack_push(idstack, reg->id);
>
> can't you push the same id multiple times into stack this way? your
> idstack is actually a set, no? so idmap serves you better (just map id
> to 1 for "to be checked")? And then you don't need to introduce a new
> idstack_scratch data structure

Ack.

>
> > +               return 1;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
>
> [...]
