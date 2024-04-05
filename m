Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22235D734
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347111; cv=none; b=X1o49fpp6UVoPv1UkGRYjs7/xTOe94giJgB52b+/dtvbd+fYJPXhl565jHZErYk04I7I8Xj8fbrcqsO0Ulj3ZiVEb/86PYs1xjtq0j/8/s+/V+st7AB9AbV8tonrGP/moAkwX23MOoCinYppfd6UACmYNYzp2ii9StzKWdBMAZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347111; c=relaxed/simple;
	bh=V3bmhc2QhQu1qTd/7Veau1ga8c1OdHT79KY4iL4lWTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHwK+aM3fRCi0GsQgsFnMNlIarGEs6kvpUpGHd6yKM4V0bCDvcBiVYOSQPJeQVqRcK8pM52wFYY086ABkLQTwstNgEUlcJDFZu4gF45vkk/LaSbz4M4AAEVgwI3Y4Jp0brkZX/FnsrcQwxyCUmEcuJy4U2Vhb9YijfzMBQidFD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnibfRFe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnibfRFe"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e220e40998so18594395ad.1
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 12:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712347109; x=1712951909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1yD3iVOeVhMk2NmSFW5HWaZqPQJuShUZbYOeRmfKlU=;
        b=BnibfRFe/j9F2GCBfr1zpkIxlQwOr2H3wyOImkomJvteaFRaqsDqPGFLpDLDLHBv6t
         ZGS9qZho8xZ60GXGSQjCRBrmqmZxH9nHE3vaPdr26r4H3qNu33T1O0zBG21eJS9RBSxV
         vO/p3NNLrWIVO1SjVaP+Y5VsR/VDOBKRqr81SLbEHg83H6zUSOJY+oDZ46HAT8A2JjCa
         5ANXwpg/wPOGiRL27r1t9nMOUY70VwcPOGzEMI60SE7aQmNfNkzl1TY1xpfLaFaDEa/F
         m0aceHxCjmzkmC+ThVu7a4/j1Wl7KfVqZsZoS8z9KVWdBpqdGh8teUQXnFtAjVUr+FhN
         cTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712347109; x=1712951909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1yD3iVOeVhMk2NmSFW5HWaZqPQJuShUZbYOeRmfKlU=;
        b=KLup/cMRLQJk9+gLz8Rwz/8XmlOEeEiuibwIQ7SaHjD+HwP7MyhC82R3sO+7k7Mrvo
         GmyVK6Ng/0rBr0dXSfjnOTHmQtvUQN2/OJIQavfYZc7A+WADVe4c/4PdyMNocDWkXuA9
         T7qMkka9oAJcHBt2jDkh1anPRatOVLIBpyJvN94JwSt5iUs+XWYk0Uj9AT7NtnOTIC+x
         +OQPE4qchsp7QffMvk5loDANIu6jODkhuYfhe2l7jxl+wHzy/nYEeKBpH5xeFYH93v59
         QcLKN3OUgFCxHa7QvrS6oR0sevWuJO3pniZBo+vncZ9eeTtqBj5IphcjxXKv4vCpTK09
         +zJA==
X-Forwarded-Encrypted: i=1; AJvYcCVjaFBDEqqPHI2DzsEtg048q7wmRMqoMEPoB5izcxoJjXGJ0LlESxr6YmynI3zXaIZaHZcrO+OKwCKFecVT/+BRbaZo
X-Gm-Message-State: AOJu0Ywp2+LUhgMQwx230T4gq4zbw9QUaHDaQYkQlkHl4o1zYrVo7hB8
	UTVwwd8RNB/V1qK4s0WdNq/VNViaH8VizsNo6C1sImBYU88z47SRUHYNlqz9vNmCG/7+24G2Fle
	eSRWqzgfyoaRh46GJHHXgbgtvdIY=
X-Google-Smtp-Source: AGHT+IFbeqUD4evOuCDEXlcruU0qGT2Txl85TOCZYTlNT+s0Lph1uKS4KP5SV/mRFzfl7Fahv4mVo2h6CQojrGESudA=
X-Received: by 2002:a17:903:22c5:b0:1e2:9ddc:f620 with SMTP id
 y5-20020a17090322c500b001e29ddcf620mr2978100plg.23.1712347108831; Fri, 05 Apr
 2024 12:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322102455.98558-1-alan.maguire@oracle.com>
 <20240322102455.98558-11-alan.maguire@oracle.com> <CAEf4BzbQEYgiJ=Xc7qaf0Tm_geTd40Ld+623Gk0TaBjPtTsnKg@mail.gmail.com>
 <9be97b85-104b-4c33-a23a-ad68ba7f5838@oracle.com>
In-Reply-To: <9be97b85-104b-4c33-a23a-ad68ba7f5838@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Apr 2024 12:58:16 -0700
Message-ID: <CAEf4Bza41cU4R=PeqO6aaqcvzVmNcQNCN8Ee8bdyiOsPF-kfyA@mail.gmail.com>
Subject: Re: [RFC bpf-next 09/13] libbpf: split BTF reconciliation
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 3:06=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 29/03/2024 22:01, Andrii Nakryiko wrote:
> > On Fri, Mar 22, 2024 at 3:26=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> Map base reference BTF type ids referenced in split BTF and their
> >> references to the base BTF passed in, and if the mapping succeeds,
> >> reparent the split BTF to the base BTF.
> >>
> >> Reconciliation rules are
> >>
> >> - base types must match exactly
> >> - enum[64] types should match all value name/value pairs, but the
> >>   to-be-reconciled enum[64] can also define additional name/value pair=
s
> >> - named fwds match to the correspondingly-named struct/union/enum/enum=
64
> >
> > yeah, but what about their size if they are embedded? Using FWD was a
> > nice trick, but it's not flexible enough for recording (optionally)
> > size... Probably emitting an empty (but named) struct/union/enum would
> > be a bit better (and actually make split BTF using base ref more valid
> > even without pre-processing).
> >
> >> - anon struct/unions must have field names/offsets specified in base
> >>   reference BTF matched by those in base BTF we are matching with
> >>
> >> Reconciliation can not recurse, since it will be used in-kernel also a=
nd
> >> we do not want to blow up the kernel stack when carrying out type
> >> compatibility checks.  Hence we use a stack for reference type
> >> reconciliation rather then recursive function calls.
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  tools/lib/bpf/Build             |   2 +-
> >>  tools/lib/bpf/btf.c             |  58 ++++
> >>  tools/lib/bpf/btf.h             |   8 +
> >>  tools/lib/bpf/btf_reconcile.c   | 590 +++++++++++++++++++++++++++++++=
+
> >
> > how wrong would it be to call this process "relocate" rather than "reco=
ncile"?
> >
>
> seems fine to me.
>
> >>  tools/lib/bpf/libbpf.map        |   1 +
> >>  tools/lib/bpf/libbpf_internal.h |   2 +
> >>  6 files changed, 660 insertions(+), 1 deletion(-)
> >>  create mode 100644 tools/lib/bpf/btf_reconcile.c
> >>
> >
> > [...]
> >
> >> +/* Find next type after *id in base BTF that matches kind of type t p=
assed in
> >> + * and name (if it is specified).  Match fwd kinds to appropriate kin=
d also.
> >> + */
> >> +static int btf_reconcile_find_next(struct btf_reconcile *r, const str=
uct btf_type *t,
> >> +                                  __u32 *id, const struct btf_type **=
tp)
> >
> > I haven't grokked the whole patch logic just yet, doing a first pass,
> > so I might be asking stupid questions, sorry.
> >
> > But it looks like we have these linear searches here to find matching
> > types, is that right? Wouldn't it be better to build an index first to
> > speed up search?
> >
>
> It would, but the aim here was to keep things simple with an eye to
> sharing the code with the kernel. A lot of the libbpf hash stuff would
> be handy but then we'd have to have something on the kernel side. Given
> that the size of the base BTF is so small, the linear searches aren't
> much of a cost.

I didn't mean hashmap, I was thinking sort+binary search, but ok, we
can do that later as an optimization.

[...]

> >> +
> >> +/* Ensure each enum value in type t has equivalent in base BTF and th=
at values (if any) match. */
> >> +static int btf_reconcile_enum(struct btf_reconcile *r, const char *na=
me,
> >> +                             const struct btf_type *t, const struct b=
tf_type *bt)
> >> +{
> >
> > should we care about compatibility between ENUM and ENUM64, they can
> > both represent the same values of the same size?
> >
>
> so do you mean if one representation uses an enum, another an enum64?
> Yep that might well be the case, I'll add that too.

yep, they are two different kinds, but they overlap in what they can
represent, so we try to support them interchangeably, if possible

[...]

> >> +                               if (err) {
> >> +                                       pr_warn("could not find base B=
TF type for base reference type[%u]\n",
> >> +                                               id);
> >> +                                       return err;
> >> +                               }
> >> +                       } else {
> >> +                               if (btf_reconcile_push(r, id) < 0 ||
> >> +                                   btf_reconcile_push(r, t->type) < 0=
)
> >> +                                       return -ENOSPC;
> >
> > I'm missing something, please help me understand. I don't get why we
> > need a recursive algorithm at all.
> >
> > In my mind, we have this small "base ref" set of types referenced from
> > module's BTF (split BTF part), right? So all we should need is to map
> > every type from base ref set to vmlinux BTF.
> >
> > What I don't yet fully get is why CONST/VOLATILE or PTR need to
> > postpone reconciliation via a queue. By the time we get to types in
> > split BTF all base ref types should be mapped, so all you need is to
> > remap t->type to resolved vmlinux BTF, no?
> >
>
> It's possible to have multiple layers of reference in the distilled base
> BTF though; for example here's a case from a module's distilled base BTF:
>
> [41] PTR '(anon)' type_id=3D42
> [42] CONST '(anon)' type_id=3D0
>
> To resolve type id 41 we need to resolve type id 42, and since type id 0
> already has a mapping, at that point we can look for CONSTs that refer
> to type id 0 and then once we've established that mapping we can find
> PTRs that have a t->type that refers to the const. So as described below
> we keep pushing type ids onto the stack until we find one with a t->type
> mapping to base BTF; once we hit that we can start looking in base BTF
> for types that have the mapped t->type value.
>

see below

> > I suspect the answer might have something to do with those anonymous
> > structs/unions which you copy verbatim into base ref BTF?
> >
>
> They do add a few more types, but we can get base BTF references that
> don't come from that source too. The above case PTR CONST void for
> example wasn't referred to via any other distilled base types.

I think it's too problematic to allow unnamed types in base reference
BTF. If we keep the rule that only named
structs/unions/typedefs/int/float kinds can be in base reference, then
everything becomes much simpler and faster, without breaking any of
kfunc/PTR_TO_BTF_ID usage.

The biggest problem is probably TYPEDEF pointing to anonymous
struct/union/func proto, so we might want to still record the shape of
expected underlying type, maybe, but we still go off of just a name in
the first place. Maybe initially we should just say that any ambiguity
would be rejected and keep only TYPEDEF with name?

Let me know if this is unrealistic, though.

>
> > But on the latter topic, I wonder if we at all need this? Why not keep
> > all those anon struct/union/enum in module's part of BTF? If they are
> > unnamed, I doubt they will ever be referenced from kfuncs or anything
> > like that, so their BTF ID isn't that important.
> >
>
> Changing the module BTF would make things a bit more complicated.

you mean appending those anonymous types from base BTF to module BTF?
It shouldn't be too hard, we just do it recursively and keep track of
ID remapping (so we don't add the same type twice). Or is there
something more?


> Currently we just update type id references and string offsets. The anon
> structs we end up with tend to be very small; from the same distilled
> base BTF used above here are the instances of struct/union:
>
> [35] STRUCT '(anon)' size=3D4 vlen=3D1
>         'counter' type_id=3D6 bits_offset=3D0
> [62] STRUCT '(anon)' size=3D8 vlen=3D1
>         'raw_lock' type_id=3D48 bits_offset=3D0
> [113] UNION '(anon)' size=3D8 vlen=3D2
>         'kernel' type_id=3D13 bits_offset=3D0
>         'user' type_id=3D13 bits_offset=3D0
> [114] STRUCT '(anon)' size=3D16 vlen=3D2
>         '(anon)' type_id=3D113 bits_offset=3D0
>         'is_kernel' type_id=3D11 bits_offset=3D64 bitfield_size=3D1
> [119] STRUCT '(anon)' size=3D8 vlen=3D1
>         'net' type_id=3D85 bits_offset=3D0
>
> These only added one type that wasn't referenced elsewhere - typedef
> arch_rwlock_t.
>
> > If base BTF is all named types, it would simplify the reconciliation
> > process significantly, I think.
> >
> > But again, I only skimmed the overall algorithm, sorry for my
> > laziness, but I figured it would be good to discuss the above first
> > anyways.
> >
>
> I'll try and walk through an example of how the algorithm proceeds; that
> might help make the approach concrete and we can see if it can be
> simplified.
>
> Consider split BTF that uses the base BTF type "int *", i.e. a PTR to an
> "int". It could do so in an anonymous struct/union, but also as an array
> member type or a FUNC_PROTO or VAR. For such a reference type, we first
> encounter the outer PTR. If its t->type has a mapping to base BTF "int"
> (it will), we look through the base BTF for reference types that match
> the kind (here a PTR) _and_ have the required t->type (int). Once we
> find the reference type in base BTF, we can add the mapping for PTR to
> int from distilled->base BTF id. So the reference type with one layer of
> reference is pretty straightforward.
>
> In the case where we don't have a mapping for a t->type - let's say PTR
> to PTR to int (int **) - we push the type id for PTR to PTR to int onto
> the stack along with the type id for t->type (PTR to int) after. So we
> will first pop PTR to int and go through the above-described type
> resolution. Next we will pop the PTR to PTR to int and because we've
> resolved PTR to int now, it's t->type will have a mapping and we can go
> through the search process to find a PTR that refers to a PTR to int
> in base BTF, and we then add that mapping too.

sure, pretty standard dfs with memoization, makes sense

what makes me a bit uncomfortable is that if you have PTR -> STRUCT,
once you found match for STRUCT, you'll go do a linear search for any
PTR  to that STRUCT. Which starts to sound like BTF deduplication
(though admittedly matching STRUCT by name removes half of BTF dedup
complexity) and the way you are doing it right now with linear search
over vmlinux BTF is going to be slow (which is why I was proposing an
index).

Ok, anyways, it's probably going to work. If we can simplify further
with keeping just named types, it would be great. If not, so be it, I
suppose.

>
> For an array we push the member and index types, a func proto the return
> type and parameter types, etc.
>
> So once multiple layers of reference are part of the picture I _think_
> we need something like this approach.
>
> Alan
>
> >> +                       }
> >> +                       break;
> >
> > [...]
