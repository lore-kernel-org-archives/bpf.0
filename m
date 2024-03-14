Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6406ADF53
	for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436060; cv=none; b=BQdcAtY+4CVsTuEQtji1lzNAey3rMbfz200qs5DqwnQvFTnpmuZBJsiyZPjC6ecfuekk+KC/4xMT7EcSBvZSstwVLeDxZEtBWXAxaCZXEJDG6Bo2U6kcIGchJ/ZvdZs4P+9BY8y/xcyp4dptGWD11gBfVzr8YHWonuKORT5Wgog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436060; c=relaxed/simple;
	bh=u7aeIBhHyo50GveKPqlaMBlUI+CyXMH3SvSvikBbq2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3pQ/sXGVeuIhqq+OXDaWF0wgocLcvwnYvSeq+cbgjFsCENoAl2jUNOeqsFAH2byPwdW0kQyU4hE0/kEkgEx+Ntwx3xJ01GFZU2oz31QuGtXPtXsBd/JwWfoqaI0G9tziq0xKBP0OPdOssVFVBMnI1nN71XtGHfzoocmUxO7D0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laBhfYX1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laBhfYX1"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e5978fc1bso608331f8f.3
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 10:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710436057; x=1711040857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brGNn9fwUAszWnHKL29L34cIuzb1YTra4sIrEBl46/A=;
        b=laBhfYX1jf0qj/OZIgtqFwXY/hm7oHOZAFY1jX/DJBQ5X7wnifr/M37esR0MxXz2jC
         LNNcUtdZhB8GibMvQY7xqkLdGV8pfDnwXHcc7/jycrUX3QT5xvHkmqB5J3i7C6uR6mc1
         ilMY8PGp2CAQ7lh/3fKMikCmsYQGvdUb1vb7jUxN5zf8wJrRsz8muTTwmrYqU+s+9s3s
         h32EKF8IoFvB+B7cF9H7R7BHmEAdLYd9IbsDYjoSz7QBVLmg0aMtd//PKOeGnmLXn1cd
         7Ee/5WaDuurL88BFjR20GLn1G8/JGZoxuwK/8TRey6J4nRbZKzjexIjcSds8g4Lbtu22
         8pFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710436057; x=1711040857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brGNn9fwUAszWnHKL29L34cIuzb1YTra4sIrEBl46/A=;
        b=BsBnzosUuORQsp4f0736Y70B8a5Wt56frzbGkiBX4GLfnF/TE+MLEJOVLGYfy+H4Sx
         Cm85wWmeVfy7gFeciv0Be6Q+bd926fWjvHsQzRuMZ/17hCQifxhM+ZapEyn3TskikdvY
         9+YCwtm9NOliLKpFrz6CgU9l8Dt0IJ/IFyMGzRRb/zhOoZeiGy0kipZ+b0kyYJxcZpPs
         7LGxUY+fJlvSxyoeaYXR5w0qXt/RETYhGXHvvb8P457vD8GtnJsOZ8/dS4SY7GynZ77v
         N1OcwCFXzPhLaWGl0zD0lBemBJ6coUJJCfePk3sCfb0AKfnLxPb6fyzuj5be0QUNJMEF
         xk/A==
X-Forwarded-Encrypted: i=1; AJvYcCVBdmzcAklf0OizUzXg1V2NdzMsqceo2TlqABt3/gGYa4Rlo8ArMwZ6rNp8Ko48XTZoOryldSbtqBoZrxCINiBuy6lh
X-Gm-Message-State: AOJu0Yyz5AEvECj66ImsALBnCz8EecPRoqMUXjm3yZ4nezyF9cW6HhIP
	ujiohuRAw6UxkXWEwZJA/qrS9R13pop5qbywdN+n6GDVVBlvUqmFI2zbQxmT31jTHNI06ELgO9h
	SvnxY2YEpQnRoQ6O8OphcyXqOKbs=
X-Google-Smtp-Source: AGHT+IHM9ejUbMduzKD/TSqSeWSZbCRkVU+C2BVx6IILm2SUrH2xHpRF0pKyfq1UK1/7rtY4s8AuKCCSAIkmKe8IGAc=
X-Received: by 2002:adf:f3d2:0:b0:33e:8ba7:e53d with SMTP id
 g18-20020adff3d2000000b0033e8ba7e53dmr1910343wrp.7.1710436056300; Thu, 14 Mar
 2024 10:07:36 -0700 (PDT)
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
 <ZfK9Y5c7RuOu0YiN@zh-lab-node-5>
In-Reply-To: <ZfK9Y5c7RuOu0YiN@zh-lab-node-5>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Mar 2024 10:07:25 -0700
Message-ID: <CAADnVQLXok7niyyvpUaJxq4pNFFrBP5Vsk47NNxw1V4ipBdRrg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/9] bpf: expose how xlated insns map to
 jitted insns
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 2:11=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> On Wed, Mar 13, 2024 at 06:56:34PM -0700, Alexei Starovoitov wrote:
> > On Wed, Mar 6, 2024 at 2:51=E2=80=AFAM Anton Protopopov <aspsk@isovalen=
t.com> wrote:
> > >
> > > On Tue, Feb 20, 2024 at 05:09:36PM -0800, Alexei Starovoitov wrote:
> > > > On Fri, Feb 16, 2024 at 6:04=E2=80=AFAM Anton Protopopov <aspsk@iso=
valent.com> wrote:
> > > > >
> > > > > On Wed, Feb 14, 2024 at 10:48:26PM -0800, Alexei Starovoitov wrot=
e:
> > > > > > On Thu, Feb 8, 2024 at 3:11=E2=80=AFAM Anton Protopopov <aspsk@=
isovalent.com> wrote:
> > > > > > >
> > > > > > > On Tue, Feb 06, 2024 at 06:26:12PM -0800, Alexei Starovoitov =
wrote:
> > > > > > > > On Tue, Feb 6, 2024 at 2:08=E2=80=AFAM Anton Protopopov <as=
psk@isovalent.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Feb 05, 2024 at 05:09:51PM -0800, Alexei Starovoi=
tov wrote:
> > > > > > > > > > On Fri, Feb 2, 2024 at 8:34=E2=80=AFAM Anton Protopopov=
 <aspsk@isovalent.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.=
h
> > > > > > > > > > > index 4def3dde35f6..bdd6be718e82 100644
> > > > > > > > > > > --- a/include/linux/bpf.h
> > > > > > > > > > > +++ b/include/linux/bpf.h
> > > > > > > > > > > @@ -1524,6 +1524,13 @@ struct bpf_prog_aux {
> > > > > > > > > > >         };
> > > > > > > > > > >         /* an array of original indexes for all xlate=
d instructions */
> > > > > > > > > > >         u32 *orig_idx;
> > > > > > > > > > > +       /* for every xlated instruction point to all =
generated jited
> > > > > > > > > > > +        * instructions, if allocated
> > > > > > > > > > > +        */
> > > > > > > > > > > +       struct {
> > > > > > > > > > > +               u32 off;        /* local offset in th=
e jitted code */
> > > > > > > > > > > +               u32 len;        /* the total len of g=
enerated jit code */
> > > > > > > > > > > +       } *xlated_to_jit;
> > > > > > > > > >
> > > > > > > > > > Simply put Nack to this approach.
> > > > > > > > > >
> > > > > > > > > > Patches 2 and 3 add an extreme amount of memory overhea=
d.
> > > > > > > > > >
> > > > > > > > > > As we discussed during office hours we need a "pointer =
to insn" concept
> > > > > > > > > > aka "index on insn".
> > > > > > > > > > The verifier would need to track that such things exist=
 and adjust
> > > > > > > > > > indices of insns when patching affects those indices.
> > > > > > > > > >
> > > > > > > > > > For every static branch there will be one such "pointer=
 to insn".
> > > > > > > > > > Different algorithms can be used to keep them correct.
> > > > > > > > > > The simplest 'lets iterate over all such pointers and u=
pdate them'
> > > > > > > > > > during patch_insn() may even be ok to start.
> > > > > > > > > >
> > > > > > > > > > Such "pointer to insn" won't add any memory overhead.
> > > > > > > > > > When patch+jit is done all such "pointer to insn" are f=
ixed value.
> > > > > > > > >
> > > > > > > > > Ok, thanks for looking, this makes sense.
> > > > > > > >
> > > > > > > > Before jumping into coding I think it would be good to disc=
uss
> > > > > > > > the design first.
> > > > > > > > I'm thinking such "address of insn" will be similar to
> > > > > > > > existing "address of subprog",
> > > > > > > > which is encoded in ld_imm64 as BPF_PSEUDO_FUNC.
> > > > > > > > "address of insn" would be a bit more involved to track
> > > > > > > > during JIT and likely trivial during insn patching,
> > > > > > > > since we're already doing imm adjustment for pseudo_func.
> > > > > > > > So that part of design is straightforward.
> > > > > > > > Implementation in the kernel and libbpf can copy paste from=
 pseudo_func too.
> > > > > > >
> > > > > > > To implement the "primitive version" of static branches, wher=
e the
> > > > > > > only API is `static_branch_update(xlated off, on/off)` the on=
ly
> > > > > > > requirement is to build `xlated -> jitted` mapping (which is =
done
> > > > > > > in JIT, after the verification). This can be done in a simpli=
fied
> > > > > > > version of this patch, without xlated->orig mapping and with
> > > > > > > xlated->jit mapping only done to gotol_or_nop instructions.
> > > > > >
> > > > > > yes. The array of insn->jit_addr sized with as many goto_or_nop=
-s
> > > > > > the prog will work for user space to flip them, but...
> > > > > >
> > > > > > > The "address of insn" appears when we want to provide a more
> > > > > > > higher-level API when some object (in user-space or in kernel=
) keeps
> > > > > > > track of one or more gotol_or_nop instructions so that after =
the
> > > > > > > program load this controlling object has a list of xlated off=
sets.
> > > > > > > But this would be a follow-up to the initial static branches =
patch.
> > > > > >
> > > > > > this won't work as a follow up,
> > > > > > since such an array won't work for bpf prog that wants to flip =
branches.
> > > > > > There is nothing that associates static_branch name/id with
> > > > > > particular goto_or_nop.
> > > > > > There could be a kfunc that bpf prog calls, but it can only
> > > > > > flip all of such insns in the prog.
> > > > > > Unless we start encoding a special id inside goto_or_nop or oth=
er hacks.
> > > > > >
> > > > > > > > The question is whether such "address of insn" should be al=
lowed
> > > > > > > > in the data section. If so, we need to brainstorm how to
> > > > > > > > do it cleanly.
> > > > > > > > We had various hacks for similar things in the past. Like p=
rog_array.
> > > > > > > > Let's not repeat such mistakes.
> > > > > > >
> > > > > > > So, data section is required for implementing jump tables? Li=
ke,
> > > > > > > to add a new PTR_TO_LABEL or PTR_TO_INSN data type, and a
> > > > > > > corresponding "ptr to insn" object for every occurence of &&l=
abel,
> > > > > > > which will be adjusted during verification.
> > > > > > > Looks to me like this one doesn't require any more API than s=
pecifying
> > > > > > > a list of &&label occurencies on program load.
> > > > > > >
> > > > > > > For "static keys" though (a feature on top of this patch seri=
es) we
> > > > > > > need to have access to the corresponding set of adjusted poin=
ters.
> > > > > > >
> > > > > > > Isn't this enough to add something like an array of
> > > > > > >
> > > > > > >   struct insn_ptr {
> > > > > > >       u32 type; /* LABEL, STATIC_BRANCH,... */
> > > > > > >       u32 insn_off; /* original offset on load */
> > > > > > >       union {
> > > > > > >           struct label {...};
> > > > > > >           struct st_branch { u32 key_id, ..};
> > > > > > >       };
> > > > > > >   };
> > > > > >
> > > > > > which I don't like because it hard codes static_branch needs in=
to
> > > > > > insn->jit_addr association.
> > > > > > "address of insn" should be an individual building block withou=
t
> > > > > > bolted on parts.
> > > > > >
> > > > > > A data section with a set of such "address of insn"
> > > > > > can be a description of one static_branch.
> > > > > > There will be different ways to combine such building blocks.
> > > > > > For example:
> > > > > > static_branch(foo) can emit goto_or_nop into bpf code
> > > > > > and add "address of insn" into a section '.insn_addrs.foo".
> > > > > > This section is what libbpf and bpf prog will recognize as a se=
t
> > > > > > of "address of insn" that can be passed into static_branch_upda=
te kfunc
> > > > > > or static_branch_update sys_bpf command.
> > > > > > The question is whether we need a new map type (array derivativ=
e)
> > > > > > to hold a set of "address of insn" or it can be a part of an ex=
isting
> > > > > > global data array.
> > > > > > A new map type is easier to reason about.
> > > > > > Notice how such a new map type is not a map type of static bran=
ches.
> > > > > > It's not a map type of goto_or_nop instructions either.
> > > > > >
> > > > > > At load time libbpf can populate this array with indices of ins=
ns
> > > > > > that the verifier and JIT need to track. Once JITed the array i=
s readonly
> > > > > > for bpf prog and for user space.
> > > > >
> > > > > So this will be a map per .insn_addrs.X section (where X is key o=
r
> > > > > a pre-defined suffix for jump tables or indirect calls). And to t=
ell
> > > > > the verifier about these maps we will need to pass an array of
> > > > >
> > > > >     struct {
> > > > >             u32 map_fd;
> > > > >             u32 type; /* static key, jump table, etc. */
> > > > >     }
> > > > >
> > > > > on program load. Is this correct?
> > > >
> > > >
> > > > Probably not.
> > > > Since we're going with a new map type (at least for the sake of thi=
s
> > > > discussion) it shouldn't need a new way to tell the verifier about =
it.
> > > > If .insn_addrs.jmp_table_A was a section generated for switch() sta=
tement
> > > > by llvm it will be created as a map by libbpf,
> > > > and there will be an ld_imm64 insn generated by llvm that points
> > > > to that map.
> > > > libbpf will populate ld_imm64 insn with map_fd, just like it does
> > > > for global data.
> > >
> > > I understand how this works for indirect jumps (and for the
> > > bpf_static_branch_update(&foo) kfunc) where we have a ld_imm64 with a
> > > map, however, I am still not sure how this will work for static
> > > branches where we just have a 8 byte JA insn + an index in the
> > > corresponding ".insn_addrs.foo" section. How kernel will know that th=
e
> > > program is using a corresponding map which we create from
> > > ".insn_addrs.foo" without specifying this on program load?
> > >
> > > (Sorry for replying late, catching up after [simultaneous] pto &
> > > covid.)
> >
> > sorry. ctx switch takes time.
> > libbpf can just bpf_prog_bind_map to associate this new map type
> > of ptr_to_insn with a program.
> > Or I misunderstood the question?
>
> All ptr_to_insn maps are required during the verification. So
> bpf_prog_bind_map can't be used as it requires an existing program.

I see.

> What could work and what I am proposing is to pass a list of bound
> maps in prog_load attributes. Then such maps can be used during the
> verification. For normal maps
>
>   prog =3D prog_load(attr=3D{.bound_maps=3Dmaps})
>
> will be semantically the same as
>
>   prog =3D prog_load()
>   bpf_prog_bind_map(prog, maps)

Instead of a whole new api, let's make libbpf insert
ld_imm64 r0, map
as the first insn for this case for now.
