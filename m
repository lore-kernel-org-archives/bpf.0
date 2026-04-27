Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEACF36606C
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321448; cv=pass; b=sb2GE7TtWWYJY+vw7U38MIFs5CeouZEsr1wW5/WEda7KHEywDiY7vaTs7BL7YssnNRkTv3XLVBQHjaW68k1L11fLsMvDMbAAUBhiDqFye+M/kXB0GsD1lFSB9vX0UEazUKikOQ95Y+DbXA4MQWF+2ByDqbfLraDw/lPDPE2U51c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321448; c=relaxed/simple;
	bh=MIDQk6IaaivJ9A+oYRAlw1Zvj3fMOH5Mb+7qhf+hWso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmEUSXtE2kIWI8yGqip1BkjUQ6yKgbumWNCbYm9HJ3Y5CO3VNkcp1GmpnS+XcoPydjkET0ELrq7HzmVBtCY4iPugnoxHWX7JpBYAiEGRqtKgZ5a9QgnXMqgyySqM0EbUkQ4UEs7Nq9LYhTCCDd3zberW/THvQnmbrPdD/gs4MUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHIASxPY; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHIASxPY"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79a7109f568so127618367b3.1
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 13:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777321445; cv=none;
        d=google.com; s=arc-20240605;
        b=LB2kSxebEO2YgnkDAM7BWm2bbyhYgiqo7FKtPRJwhmYJfS3VneUJDHT7v0HlV/L3iw
         attD8y9LN1Qo/w647cZfCxF5mdJ+mKVPHMFb1iDUjVjhWfLOUYsPqZoyuVd3G9JZ3/f+
         j9yUHaN3zGH5N7D7ka1gcN0v9RPVgO4sU3H+Qhn4402rTPS+799f8olIogltmprnCw5S
         IVdWs7A6baUPiRgn2m+79YpNRpqdYsDPiGF+dFZmjwy5SyqXtRCQG+D/pz+kCJYxi5QM
         LDWLmvBPpLF5kijqErpqYeBWaxngsM84oiaM5rL48vOITnkgK4guXJUas1//CsHoLzRl
         yZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BCN7Y9kM9mKkjADQHIZKQPGfRhnTuCp0fYgbJCpzkI8=;
        fh=t+mmM/gg8HvVqu3DtowYM9O0sTzrV4vLBdaKbxjGBCk=;
        b=EQjraQELo1mvKJ7TzJ+qPke5yXXCfKnD0v/vVz8gnSJFJwN1VBcUXmk7l3T4LNGgkj
         U7mSm+TYScSeg3zDNEU048khyxEm8m/Cq6JsYZSCXIUsR0HcRBBtKcitDW3oUkoH76Bb
         nniviAPSn2fCivbZgMuVyef//7VUepmh6eOSFkgvvJi8dWYV3eVU1o2PMWu3dZ+qoFbt
         Dow0OqG6cwE3gf+1tZZKbyXf7UZeeQ8DOJsEYhRqL8F5RCKiT1yGkTPt9dinsNWueEP4
         IByg1dtMM4iHpV1YDfgu2RIWSP7aCJ4w9KCEocmY0o62E7ap6DgC33FjIo02/967Tc1M
         +T2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777321445; x=1777926245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCN7Y9kM9mKkjADQHIZKQPGfRhnTuCp0fYgbJCpzkI8=;
        b=DHIASxPYsK59ooP+zWGMw+F6Sb/dbrUIbOuH310Pjtm7W4QduG9/to5nce+Pzt0CTk
         4+d0Xz1/uxGFi0O/hKMO+1wH+nCI48DIseO81CGHTde+XLwXKuepYnBb6QyhrkZiT2Wm
         JQ1/EudwaLhiZx0eE8kFi26LlbRJry+CMi6O/pPgLSAK2AgYl/UJ9WvS6pl08YY1DOyU
         CvGA4i1kOxYhs1hJPWzLliy+dC8CNUV/l77Ufkt6WBjHIHnj3JBGAE1qcNLjaI4UldCt
         HCdO18kzYeNBWjNYlLjL7YNB4pa5M59g/PhWUnmbj3UMOpCi51Le+aRId96y5hs3jj38
         aiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777321445; x=1777926245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BCN7Y9kM9mKkjADQHIZKQPGfRhnTuCp0fYgbJCpzkI8=;
        b=hsUaJknu2rCCIC8LBq9IS41whHQQHnd/Ts2Vl42CbBMZ0VRrkMhnRTVhMwAfmLlEQz
         8tGrDfIohLXpd/ARS/VuqtAz2Z6VcFexP6T+tDeBYgykyuZmhfgjV8QBtzMyxoKoxBph
         3mRnxIq91PW8KyPwIsEkJwA5JgXK8Y3ZcjyDzYjgdRjeNn3IEojVmMaGzskM0s1Cs9vD
         lqsob1d8r6YGOWg9gLiH2Y4L6x/waO2imaIZ7j9il75lViMRUKIfKhJ7q+QI18SFZSle
         SadM71LafIj5pncSNFk/zBSLmrKzJMMeiwAd50iOyG2hvgeRXLXkrWOVZnUGgHtU6UE1
         0Zrg==
X-Forwarded-Encrypted: i=1; AFNElJ+kQpaIra/yrEXTMeI5EL9lCiHwrmhkZMkuWt8o1TZhZhM0yiUyMDBg/GtAetxvFKhZ9pY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzwqcx9DIaDiSeCe7Ix2XWpkc1uc20Fp7wigbSlawUZkdp9QI/
	QrMu8WJvtU/TaGvkbI/0cpyCXDiLdJhOk9kLQQcJKzw4P5bamkr+7U3uEBNbcVGtdr/0SwfhjXB
	vEz5QAOx9+7/TeYl7qN/26Ig41+s+nFA=
X-Gm-Gg: AeBDieslRaT6j8ibIiLUjJHtEa7ibIrljPTOJ9P9Ect50WG5ca7xKoXRBy4OcPKwCUu
	or2JAy+EzCVIs2nVvWLdRQJXjIT4vYvV85lxFZC+Nbx6Wi+S/0Oqz7ClNsTLn4aKrRsIrFVnagc
	zs3PgPRGvEP7NULhOj236GV5VhGpenWQiiCAwjDVFL7fLQMwkXzcvcjn+gqEQRtAATtvuNrkjZE
	boaVbo9B4v6zjMNz72z5iVoVxjzBJaFP3fGhL6yJ+QaG4czITK/VAu40BdyF7WQhOKz7TnvPcIU
	ijVUx5h0NnmzR14LkA==
X-Received: by 2002:a05:690c:e0b:b0:7b1:3579:2ef7 with SMTP id
 00721157ae682-7bcf5573815mr842387b3.28.1777321444779; Mon, 27 Apr 2026
 13:24:04 -0700 (PDT)
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
Date: Mon, 27 Apr 2026 13:23:53 -0700
X-Gm-Features: AVHnY4LJg5gx-H0HFRx-yTWyPQVFe5viQgXXN39uE_liNxV3HlNQ_-xyGCp3w6Y
Message-ID: <CAMB2axN0tXAXe3k6o_QCY0=VVjdvME7nTE9urYUmYr_7vTuobQ@mail.gmail.com>
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

I figured that I missed this question. The existing
mark_dynptr_stack_regs() above already assigned an id.
