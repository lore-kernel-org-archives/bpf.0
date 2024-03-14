Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C94762E3
	for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710446800; cv=none; b=i5eFzHpJoTVHbdWwzNNnvLuE2fpb9L0eZ+XQgeziAJWnoqLVEwVt35emKk3+AV19injEy+RwqLHSa5OVO4k5MZCUImFqPRG1Cr15UcijIGQ9O19dzc5Fsko0YqlguMAFp0hVsHiXJyQ+h/tUq6j/Fx818qjbYxglde0cxKphlZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710446800; c=relaxed/simple;
	bh=0iTW8SIWFx2Wqg9lRu/hOwh7ky2q3lIs/0ugMcjBGCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TceEUu+u2Ceg6nTYnDm5F+Et9OLptyM5zbPfxx2AMrMRq5ugV9VNz0AbpFndJc7wERaJhCm69Ms7rHsmDybVsiq6BWOME9LaRtSvtV7KpdmeS6Le2raddhyyKOFqvISwi+DALkd0BgsckU39T7vud9BJPATAu7aZi1eZTZ3SO4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz0L1Cj8; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz0L1Cj8"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29dd91f3aaeso705242a91.3
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 13:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710446798; x=1711051598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Sg3imqYK0CkSk0V1NFBdIX4BrA6ePwgwBt4sIz10Xs=;
        b=Jz0L1Cj80BO+z5rFAC8c13GOmQP+vLgLBK+cJZRPcvfgkrqUpxVuuPcZpyAzvuIU1x
         zgOziHki/+4aK4NH0dC/+w9Wfl11yB39WkVydodDeZcXBhD2/+85gg/qcvV3gIYqEhRx
         VWKv4ODvrfuQE3K06bTYr3buWxqqJdejg9A+Rcfk60uo2Vtal6bzAbc0BJJpvGpoNM+A
         Llw2+SkwZGPCTqWiRcxcberb+6nf+NXUHDABKwGXxgIi3OCkpLQj5ukpxlFQnSTGwgWu
         Y5wbnloEoLjg8Y9bVaZBMA66265A8ddsQWCE9gRYFpOz1CFR46ikva+fh5O3i+j4DZFb
         tPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710446798; x=1711051598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Sg3imqYK0CkSk0V1NFBdIX4BrA6ePwgwBt4sIz10Xs=;
        b=I5ZB+t9cn4n5Jh+o6DObi32UkvII6ZHcM+b64NOLllrGbSxUHGRryaTrvMUQ3PjkG9
         m/GXcnprXj15olNasSu4zfNjbG7jQOnR5sW0KoiQ4+9TcQ/p2HJT/oECvW0E+nkrwK3T
         v8FFZjdlPq+FJeqCJY2yIUNyMD3NoSQOUhHm1uqGxwef2GY36bGxtok+8/kyews+aMnT
         +J+iZNlus/2GG2Mf19RBzZYb0ujlIxTPNn5eUhWOVgdlov9YPyE6hNwXcfNJiNr4LJXj
         BpNSdJ/Ai0vtzuxP6I5Gg6oObi/vm3KG9nMRmuQ7aH6kDdkQw/e8qYPP3zV+HwqEyf7Q
         tHNg==
X-Forwarded-Encrypted: i=1; AJvYcCWY0ZH5HUvIIqp3HVwtXGiKPKGRph4zhFtgxODd1l5vzeBZbWvr6FZ6dail+55zdKMdL87rEASdeFKO1G2fmMcNL/tU
X-Gm-Message-State: AOJu0YwsbR0bTn0w5bsvaByezbm9J4WD/Hm/JUzqgSBbRmiAk+InVIVo
	T9TiJczyBAsHF/7ctr0NRy+Bk0yQWoZxAC0wu22HNo0OT/vqtqdSWmxAkTOUgKLoV2YpcwcRk27
	lgBSkZk75JBzVlZMktW/cxo3nyHo=
X-Google-Smtp-Source: AGHT+IFQS6uKWaAnDvEvHYaZUOMO4ep6RLFPYkLew+Wb6Sx/HUk4Z0wDwzfl2GF5HPd8G2hQcgQ3XKXDUVKY6UlmaVw=
X-Received: by 2002:a17:90b:1e53:b0:29b:c728:4468 with SMTP id
 pi19-20020a17090b1e5300b0029bc7284468mr2597769pjb.33.1710446798087; Thu, 14
 Mar 2024 13:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202162813.4184616-4-aspsk@isovalent.com> <CAADnVQLnk=UyKBkRAC1tNkiaF7C4+FG7V-b2xrR3oa_E4+QX7Q@mail.gmail.com>
 <ZcIDqnXFjsWYyu1G@zh-lab-node-5> <CAADnVQLfidjTWa4+kyRH-qC29gbGvFsRJHu6smcaL0Yk0HqgmA@mail.gmail.com>
 <ZcS1ZruKKZ1euzlb@zh-lab-node-5> <CAADnVQKH1aitaADzCo__PfMJJA2SxAvYjTS8Z7A6Y01G2OWJgw@mail.gmail.com>
 <Zc9p4e1EccPkMnmY@zh-lab-node-5> <CAADnVQJ+_+ok_io1_W7e5z_dZhxSqhEFZQkumRgmY4AJRYwW7g@mail.gmail.com>
 <ZehJFP11vi5sv/eW@zh-lab-node-5> <CAADnVQJnh+j9etPYkst7hhnepvsoBuJY-ds-AF0fn3VqqJNXNg@mail.gmail.com>
 <ZfK9Y5c7RuOu0YiN@zh-lab-node-5> <CAADnVQLXok7niyyvpUaJxq4pNFFrBP5Vsk47NNxw1V4ipBdRrg@mail.gmail.com>
In-Reply-To: <CAADnVQLXok7niyyvpUaJxq4pNFFrBP5Vsk47NNxw1V4ipBdRrg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Mar 2024 13:06:25 -0700
Message-ID: <CAEf4BzbkkrFACwWQQQkESrdRKWUvJz=NyWdrtu4v6m2aOJKztw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/9] bpf: expose how xlated insns map to
 jitted insns
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Anton Protopopov <aspsk@isovalent.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 10:07=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 14, 2024 at 2:11=E2=80=AFAM Anton Protopopov <aspsk@isovalent=
.com> wrote:
> >
> > On Wed, Mar 13, 2024 at 06:56:34PM -0700, Alexei Starovoitov wrote:
> > > On Wed, Mar 6, 2024 at 2:51=E2=80=AFAM Anton Protopopov <aspsk@isoval=
ent.com> wrote:
> > > >
> > > > On Tue, Feb 20, 2024 at 05:09:36PM -0800, Alexei Starovoitov wrote:
> > > > > On Fri, Feb 16, 2024 at 6:04=E2=80=AFAM Anton Protopopov <aspsk@i=
sovalent.com> wrote:
> > > > > >
> > > > > > On Wed, Feb 14, 2024 at 10:48:26PM -0800, Alexei Starovoitov wr=
ote:
> > > > > > > On Thu, Feb 8, 2024 at 3:11=E2=80=AFAM Anton Protopopov <asps=
k@isovalent.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Feb 06, 2024 at 06:26:12PM -0800, Alexei Starovoito=
v wrote:
> > > > > > > > > On Tue, Feb 6, 2024 at 2:08=E2=80=AFAM Anton Protopopov <=
aspsk@isovalent.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Feb 05, 2024 at 05:09:51PM -0800, Alexei Starov=
oitov wrote:
> > > > > > > > > > > On Fri, Feb 2, 2024 at 8:34=E2=80=AFAM Anton Protopop=
ov <aspsk@isovalent.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/include/linux/bpf.h b/include/linux/bp=
f.h
> > > > > > > > > > > > index 4def3dde35f6..bdd6be718e82 100644
> > > > > > > > > > > > --- a/include/linux/bpf.h
> > > > > > > > > > > > +++ b/include/linux/bpf.h
> > > > > > > > > > > > @@ -1524,6 +1524,13 @@ struct bpf_prog_aux {
> > > > > > > > > > > >         };
> > > > > > > > > > > >         /* an array of original indexes for all xla=
ted instructions */
> > > > > > > > > > > >         u32 *orig_idx;
> > > > > > > > > > > > +       /* for every xlated instruction point to al=
l generated jited
> > > > > > > > > > > > +        * instructions, if allocated
> > > > > > > > > > > > +        */
> > > > > > > > > > > > +       struct {
> > > > > > > > > > > > +               u32 off;        /* local offset in =
the jitted code */
> > > > > > > > > > > > +               u32 len;        /* the total len of=
 generated jit code */
> > > > > > > > > > > > +       } *xlated_to_jit;
> > > > > > > > > > >
> > > > > > > > > > > Simply put Nack to this approach.
> > > > > > > > > > >
> > > > > > > > > > > Patches 2 and 3 add an extreme amount of memory overh=
ead.
> > > > > > > > > > >
> > > > > > > > > > > As we discussed during office hours we need a "pointe=
r to insn" concept
> > > > > > > > > > > aka "index on insn".
> > > > > > > > > > > The verifier would need to track that such things exi=
st and adjust
> > > > > > > > > > > indices of insns when patching affects those indices.
> > > > > > > > > > >
> > > > > > > > > > > For every static branch there will be one such "point=
er to insn".
> > > > > > > > > > > Different algorithms can be used to keep them correct=
.
> > > > > > > > > > > The simplest 'lets iterate over all such pointers and=
 update them'
> > > > > > > > > > > during patch_insn() may even be ok to start.
> > > > > > > > > > >
> > > > > > > > > > > Such "pointer to insn" won't add any memory overhead.
> > > > > > > > > > > When patch+jit is done all such "pointer to insn" are=
 fixed value.
> > > > > > > > > >
> > > > > > > > > > Ok, thanks for looking, this makes sense.
> > > > > > > > >
> > > > > > > > > Before jumping into coding I think it would be good to di=
scuss
> > > > > > > > > the design first.
> > > > > > > > > I'm thinking such "address of insn" will be similar to
> > > > > > > > > existing "address of subprog",
> > > > > > > > > which is encoded in ld_imm64 as BPF_PSEUDO_FUNC.
> > > > > > > > > "address of insn" would be a bit more involved to track
> > > > > > > > > during JIT and likely trivial during insn patching,
> > > > > > > > > since we're already doing imm adjustment for pseudo_func.
> > > > > > > > > So that part of design is straightforward.
> > > > > > > > > Implementation in the kernel and libbpf can copy paste fr=
om pseudo_func too.
> > > > > > > >
> > > > > > > > To implement the "primitive version" of static branches, wh=
ere the
> > > > > > > > only API is `static_branch_update(xlated off, on/off)` the =
only
> > > > > > > > requirement is to build `xlated -> jitted` mapping (which i=
s done
> > > > > > > > in JIT, after the verification). This can be done in a simp=
lified
> > > > > > > > version of this patch, without xlated->orig mapping and wit=
h
> > > > > > > > xlated->jit mapping only done to gotol_or_nop instructions.
> > > > > > >
> > > > > > > yes. The array of insn->jit_addr sized with as many goto_or_n=
op-s
> > > > > > > the prog will work for user space to flip them, but...
> > > > > > >
> > > > > > > > The "address of insn" appears when we want to provide a mor=
e
> > > > > > > > higher-level API when some object (in user-space or in kern=
el) keeps
> > > > > > > > track of one or more gotol_or_nop instructions so that afte=
r the
> > > > > > > > program load this controlling object has a list of xlated o=
ffsets.
> > > > > > > > But this would be a follow-up to the initial static branche=
s patch.
> > > > > > >
> > > > > > > this won't work as a follow up,
> > > > > > > since such an array won't work for bpf prog that wants to fli=
p branches.
> > > > > > > There is nothing that associates static_branch name/id with
> > > > > > > particular goto_or_nop.
> > > > > > > There could be a kfunc that bpf prog calls, but it can only
> > > > > > > flip all of such insns in the prog.
> > > > > > > Unless we start encoding a special id inside goto_or_nop or o=
ther hacks.
> > > > > > >
> > > > > > > > > The question is whether such "address of insn" should be =
allowed
> > > > > > > > > in the data section. If so, we need to brainstorm how to
> > > > > > > > > do it cleanly.
> > > > > > > > > We had various hacks for similar things in the past. Like=
 prog_array.
> > > > > > > > > Let's not repeat such mistakes.
> > > > > > > >
> > > > > > > > So, data section is required for implementing jump tables? =
Like,
> > > > > > > > to add a new PTR_TO_LABEL or PTR_TO_INSN data type, and a
> > > > > > > > corresponding "ptr to insn" object for every occurence of &=
&label,
> > > > > > > > which will be adjusted during verification.
> > > > > > > > Looks to me like this one doesn't require any more API than=
 specifying
> > > > > > > > a list of &&label occurencies on program load.
> > > > > > > >
> > > > > > > > For "static keys" though (a feature on top of this patch se=
ries) we
> > > > > > > > need to have access to the corresponding set of adjusted po=
inters.
> > > > > > > >
> > > > > > > > Isn't this enough to add something like an array of
> > > > > > > >
> > > > > > > >   struct insn_ptr {
> > > > > > > >       u32 type; /* LABEL, STATIC_BRANCH,... */
> > > > > > > >       u32 insn_off; /* original offset on load */
> > > > > > > >       union {
> > > > > > > >           struct label {...};
> > > > > > > >           struct st_branch { u32 key_id, ..};
> > > > > > > >       };
> > > > > > > >   };
> > > > > > >
> > > > > > > which I don't like because it hard codes static_branch needs =
into
> > > > > > > insn->jit_addr association.
> > > > > > > "address of insn" should be an individual building block with=
out
> > > > > > > bolted on parts.
> > > > > > >
> > > > > > > A data section with a set of such "address of insn"
> > > > > > > can be a description of one static_branch.
> > > > > > > There will be different ways to combine such building blocks.
> > > > > > > For example:
> > > > > > > static_branch(foo) can emit goto_or_nop into bpf code
> > > > > > > and add "address of insn" into a section '.insn_addrs.foo".
> > > > > > > This section is what libbpf and bpf prog will recognize as a =
set
> > > > > > > of "address of insn" that can be passed into static_branch_up=
date kfunc
> > > > > > > or static_branch_update sys_bpf command.
> > > > > > > The question is whether we need a new map type (array derivat=
ive)
> > > > > > > to hold a set of "address of insn" or it can be a part of an =
existing
> > > > > > > global data array.
> > > > > > > A new map type is easier to reason about.
> > > > > > > Notice how such a new map type is not a map type of static br=
anches.
> > > > > > > It's not a map type of goto_or_nop instructions either.
> > > > > > >
> > > > > > > At load time libbpf can populate this array with indices of i=
nsns
> > > > > > > that the verifier and JIT need to track. Once JITed the array=
 is readonly
> > > > > > > for bpf prog and for user space.
> > > > > >
> > > > > > So this will be a map per .insn_addrs.X section (where X is key=
 or
> > > > > > a pre-defined suffix for jump tables or indirect calls). And to=
 tell
> > > > > > the verifier about these maps we will need to pass an array of
> > > > > >
> > > > > >     struct {
> > > > > >             u32 map_fd;
> > > > > >             u32 type; /* static key, jump table, etc. */
> > > > > >     }
> > > > > >
> > > > > > on program load. Is this correct?
> > > > >
> > > > >
> > > > > Probably not.
> > > > > Since we're going with a new map type (at least for the sake of t=
his
> > > > > discussion) it shouldn't need a new way to tell the verifier abou=
t it.
> > > > > If .insn_addrs.jmp_table_A was a section generated for switch() s=
tatement
> > > > > by llvm it will be created as a map by libbpf,
> > > > > and there will be an ld_imm64 insn generated by llvm that points
> > > > > to that map.
> > > > > libbpf will populate ld_imm64 insn with map_fd, just like it does
> > > > > for global data.
> > > >
> > > > I understand how this works for indirect jumps (and for the
> > > > bpf_static_branch_update(&foo) kfunc) where we have a ld_imm64 with=
 a
> > > > map, however, I am still not sure how this will work for static
> > > > branches where we just have a 8 byte JA insn + an index in the
> > > > corresponding ".insn_addrs.foo" section. How kernel will know that =
the
> > > > program is using a corresponding map which we create from
> > > > ".insn_addrs.foo" without specifying this on program load?
> > > >
> > > > (Sorry for replying late, catching up after [simultaneous] pto &
> > > > covid.)
> > >
> > > sorry. ctx switch takes time.
> > > libbpf can just bpf_prog_bind_map to associate this new map type
> > > of ptr_to_insn with a program.
> > > Or I misunderstood the question?
> >
> > All ptr_to_insn maps are required during the verification. So
> > bpf_prog_bind_map can't be used as it requires an existing program.
>
> I see.
>
> > What could work and what I am proposing is to pass a list of bound
> > maps in prog_load attributes. Then such maps can be used during the
> > verification. For normal maps
> >
> >   prog =3D prog_load(attr=3D{.bound_maps=3Dmaps})
> >
> > will be semantically the same as
> >
> >   prog =3D prog_load()
> >   bpf_prog_bind_map(prog, maps)
>
> Instead of a whole new api, let's make libbpf insert
> ld_imm64 r0, map
> as the first insn for this case for now.

This sounds like a big hack and unnecessary complication, tbh. I'd
like to avoid having to do this in libbpf.

But I think we almost have this already supported. In BPF_PROG_LOAD
UAPI we have fd_array property, right? I think right now we lazily
refcnt referenced maps. But I think it makes total sense to just
define that bpf_prog will keep references to all BPF objects passed in
through fd_array, WDYT? Verifier will just iterate all provided FDs,
determine kind of BPF object it is (and reject unknown ones), and then
just take refcnts on each of them once. On prog free we'll just do the
same in reverse and be done with it.

It also can be used as a batch and single-step (in the sense it will
be done as part of program load instead of a separate command)
alternative for bpf_prog_bind_map(), I suppose.

Thoughts?
