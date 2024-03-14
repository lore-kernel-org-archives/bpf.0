Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8729B4683
	for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 01:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710381410; cv=none; b=s7Rx/Zu2SulYqYUSmU+pLSTeiWE3kAo0vyQo94qQCayK29A6tlUZBPL+IB13YrFKKWXO9HDQbtbzaFYgxF/BqMMuSSoCK2DNwsAfZS7uNGgpXxWBst+UJxtxs0bP/ts8ltpULJnsNkoeNTWBfjnyPjJSRCdcitWPoeroQD/lejA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710381410; c=relaxed/simple;
	bh=wMDJJO6UDRVvyJRRMecXVVKmsFMCjyK0MSqdZIf1IvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkEhmxZiwZXC5iz/Y7Oc2q3YScFLFId3XtdlleNTa/rdS064ozrhj05eZg3U2MaRkmTUYAzrL2kBTL8z6CFnR+o6ySjmC/xjP0PWuO/kseTS4i0+B+/Ze6V8YwGcMQMA0vpmtV5VqriF7UOndVSCx85GejUkoyEh6uTLvEyQuHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMOBUch2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMOBUch2"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-413f3b1e6d8so44845e9.0
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 18:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710381407; x=1710986207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK1v3ougoMsLqeARLs7UnUknHB0CwesXohQJ/8Mm0Rw=;
        b=OMOBUch2U4/XpSzxPArN150mPcbRoyVTJV1uLEvmX7x1oPpuO0nuC3icbndZl/yn+F
         HjUQry7qdw9qCG2E8kYj3eql9S0Dt7txF8dIZksZWEABpXFZeP+V4Zk/4lvDr+gWchxT
         OQCCtHj8cQvCvvLmGgMHCqzcJO1icP3HwERDWYVra7E8XejIdS5uTIWOfMdtiWfo6dat
         24YD66pae07EGICCtKrwaXoWhImdEINskKRHaw3crRyz4r1wb9JPEuQXzlFhmrxctm1J
         RBSo4/A3tE3T/7YCE2kQEVXNbc6FQ/KMkSlh9Ko1+OEtlv9pjVu5ArRoffDU0E9u9nqU
         RprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710381407; x=1710986207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FK1v3ougoMsLqeARLs7UnUknHB0CwesXohQJ/8Mm0Rw=;
        b=HyE3tdEX0ynkIPyxL347CxU3EU8olqn9bCY+FTP8Y790l9lKeK+pReB6DuxGtx0DBK
         ugzRrJtxghPzAHYIM0SQPuJFnoFjW/nvXEkSfvntV4hjbGaGpXkPjWl1BCDHJK176ArC
         a2RLyu7bDw2KC0TLbDt77lgI0n/FSaZKyRmd1G9T4B+SvkmjaWCWPUGK1SYSQr0OZj2e
         REMudM4nn3uBejsU/duCjsP8Eecr3FtoZrMbmou6l8CmXKsj+9USZYs0OmSJ2MnaJUIU
         x7CiuBlFIOIG4WtizMjqBYREzFUCZHmwZgKntwNTKRTNQkRaxsry/crSsZHcMRSVZrWr
         4hiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyv2MQP6SALO3Cx1WD4om8NC6CcEWJBdLeq0A9k+q0BbxKv96ulDP0NWlEIxSOLUdWV7O5+iLkWISkghKHBVcQq2V0
X-Gm-Message-State: AOJu0YzZrOXr7JgbRbEyplGtYQtConcRudtTPrIzFC+POLWRg0CO/nUM
	m2DR6YD9/IMBagiAQ8kBEBGSshsUnpz7YR5LVAFYaPMIGE9zE6szYPVyVuxb7jXed/AijEZlKsn
	JiLfkXQKsm/fuTndWzAwHFNfFyF8=
X-Google-Smtp-Source: AGHT+IEdkVus+IxnLEexywJHNvrQcH/LxvXAX9SUeEt/aZHetYP2k4qNxPcMvBdA7Fxfuh82wzEx8BSsolxBzlNhMwI=
X-Received: by 2002:adf:a395:0:b0:33e:1f2a:d88a with SMTP id
 l21-20020adfa395000000b0033e1f2ad88amr169500wrb.69.1710381406502; Wed, 13 Mar
 2024 18:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202162813.4184616-1-aspsk@isovalent.com> <20240202162813.4184616-4-aspsk@isovalent.com>
 <CAADnVQLnk=UyKBkRAC1tNkiaF7C4+FG7V-b2xrR3oa_E4+QX7Q@mail.gmail.com>
 <ZcIDqnXFjsWYyu1G@zh-lab-node-5> <CAADnVQLfidjTWa4+kyRH-qC29gbGvFsRJHu6smcaL0Yk0HqgmA@mail.gmail.com>
 <ZcS1ZruKKZ1euzlb@zh-lab-node-5> <CAADnVQKH1aitaADzCo__PfMJJA2SxAvYjTS8Z7A6Y01G2OWJgw@mail.gmail.com>
 <Zc9p4e1EccPkMnmY@zh-lab-node-5> <CAADnVQJ+_+ok_io1_W7e5z_dZhxSqhEFZQkumRgmY4AJRYwW7g@mail.gmail.com>
 <ZehJFP11vi5sv/eW@zh-lab-node-5>
In-Reply-To: <ZehJFP11vi5sv/eW@zh-lab-node-5>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 Mar 2024 18:56:34 -0700
Message-ID: <CAADnVQJnh+j9etPYkst7hhnepvsoBuJY-ds-AF0fn3VqqJNXNg@mail.gmail.com>
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

On Wed, Mar 6, 2024 at 2:51=E2=80=AFAM Anton Protopopov <aspsk@isovalent.co=
m> wrote:
>
> On Tue, Feb 20, 2024 at 05:09:36PM -0800, Alexei Starovoitov wrote:
> > On Fri, Feb 16, 2024 at 6:04=E2=80=AFAM Anton Protopopov <aspsk@isovale=
nt.com> wrote:
> > >
> > > On Wed, Feb 14, 2024 at 10:48:26PM -0800, Alexei Starovoitov wrote:
> > > > On Thu, Feb 8, 2024 at 3:11=E2=80=AFAM Anton Protopopov <aspsk@isov=
alent.com> wrote:
> > > > >
> > > > > On Tue, Feb 06, 2024 at 06:26:12PM -0800, Alexei Starovoitov wrot=
e:
> > > > > > On Tue, Feb 6, 2024 at 2:08=E2=80=AFAM Anton Protopopov <aspsk@=
isovalent.com> wrote:
> > > > > > >
> > > > > > > On Mon, Feb 05, 2024 at 05:09:51PM -0800, Alexei Starovoitov =
wrote:
> > > > > > > > On Fri, Feb 2, 2024 at 8:34=E2=80=AFAM Anton Protopopov <as=
psk@isovalent.com> wrote:
> > > > > > > > >
> > > > > > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > > > > > index 4def3dde35f6..bdd6be718e82 100644
> > > > > > > > > --- a/include/linux/bpf.h
> > > > > > > > > +++ b/include/linux/bpf.h
> > > > > > > > > @@ -1524,6 +1524,13 @@ struct bpf_prog_aux {
> > > > > > > > >         };
> > > > > > > > >         /* an array of original indexes for all xlated in=
structions */
> > > > > > > > >         u32 *orig_idx;
> > > > > > > > > +       /* for every xlated instruction point to all gene=
rated jited
> > > > > > > > > +        * instructions, if allocated
> > > > > > > > > +        */
> > > > > > > > > +       struct {
> > > > > > > > > +               u32 off;        /* local offset in the ji=
tted code */
> > > > > > > > > +               u32 len;        /* the total len of gener=
ated jit code */
> > > > > > > > > +       } *xlated_to_jit;
> > > > > > > >
> > > > > > > > Simply put Nack to this approach.
> > > > > > > >
> > > > > > > > Patches 2 and 3 add an extreme amount of memory overhead.
> > > > > > > >
> > > > > > > > As we discussed during office hours we need a "pointer to i=
nsn" concept
> > > > > > > > aka "index on insn".
> > > > > > > > The verifier would need to track that such things exist and=
 adjust
> > > > > > > > indices of insns when patching affects those indices.
> > > > > > > >
> > > > > > > > For every static branch there will be one such "pointer to =
insn".
> > > > > > > > Different algorithms can be used to keep them correct.
> > > > > > > > The simplest 'lets iterate over all such pointers and updat=
e them'
> > > > > > > > during patch_insn() may even be ok to start.
> > > > > > > >
> > > > > > > > Such "pointer to insn" won't add any memory overhead.
> > > > > > > > When patch+jit is done all such "pointer to insn" are fixed=
 value.
> > > > > > >
> > > > > > > Ok, thanks for looking, this makes sense.
> > > > > >
> > > > > > Before jumping into coding I think it would be good to discuss
> > > > > > the design first.
> > > > > > I'm thinking such "address of insn" will be similar to
> > > > > > existing "address of subprog",
> > > > > > which is encoded in ld_imm64 as BPF_PSEUDO_FUNC.
> > > > > > "address of insn" would be a bit more involved to track
> > > > > > during JIT and likely trivial during insn patching,
> > > > > > since we're already doing imm adjustment for pseudo_func.
> > > > > > So that part of design is straightforward.
> > > > > > Implementation in the kernel and libbpf can copy paste from pse=
udo_func too.
> > > > >
> > > > > To implement the "primitive version" of static branches, where th=
e
> > > > > only API is `static_branch_update(xlated off, on/off)` the only
> > > > > requirement is to build `xlated -> jitted` mapping (which is done
> > > > > in JIT, after the verification). This can be done in a simplified
> > > > > version of this patch, without xlated->orig mapping and with
> > > > > xlated->jit mapping only done to gotol_or_nop instructions.
> > > >
> > > > yes. The array of insn->jit_addr sized with as many goto_or_nop-s
> > > > the prog will work for user space to flip them, but...
> > > >
> > > > > The "address of insn" appears when we want to provide a more
> > > > > higher-level API when some object (in user-space or in kernel) ke=
eps
> > > > > track of one or more gotol_or_nop instructions so that after the
> > > > > program load this controlling object has a list of xlated offsets=
.
> > > > > But this would be a follow-up to the initial static branches patc=
h.
> > > >
> > > > this won't work as a follow up,
> > > > since such an array won't work for bpf prog that wants to flip bran=
ches.
> > > > There is nothing that associates static_branch name/id with
> > > > particular goto_or_nop.
> > > > There could be a kfunc that bpf prog calls, but it can only
> > > > flip all of such insns in the prog.
> > > > Unless we start encoding a special id inside goto_or_nop or other h=
acks.
> > > >
> > > > > > The question is whether such "address of insn" should be allowe=
d
> > > > > > in the data section. If so, we need to brainstorm how to
> > > > > > do it cleanly.
> > > > > > We had various hacks for similar things in the past. Like prog_=
array.
> > > > > > Let's not repeat such mistakes.
> > > > >
> > > > > So, data section is required for implementing jump tables? Like,
> > > > > to add a new PTR_TO_LABEL or PTR_TO_INSN data type, and a
> > > > > corresponding "ptr to insn" object for every occurence of &&label=
,
> > > > > which will be adjusted during verification.
> > > > > Looks to me like this one doesn't require any more API than speci=
fying
> > > > > a list of &&label occurencies on program load.
> > > > >
> > > > > For "static keys" though (a feature on top of this patch series) =
we
> > > > > need to have access to the corresponding set of adjusted pointers=
.
> > > > >
> > > > > Isn't this enough to add something like an array of
> > > > >
> > > > >   struct insn_ptr {
> > > > >       u32 type; /* LABEL, STATIC_BRANCH,... */
> > > > >       u32 insn_off; /* original offset on load */
> > > > >       union {
> > > > >           struct label {...};
> > > > >           struct st_branch { u32 key_id, ..};
> > > > >       };
> > > > >   };
> > > >
> > > > which I don't like because it hard codes static_branch needs into
> > > > insn->jit_addr association.
> > > > "address of insn" should be an individual building block without
> > > > bolted on parts.
> > > >
> > > > A data section with a set of such "address of insn"
> > > > can be a description of one static_branch.
> > > > There will be different ways to combine such building blocks.
> > > > For example:
> > > > static_branch(foo) can emit goto_or_nop into bpf code
> > > > and add "address of insn" into a section '.insn_addrs.foo".
> > > > This section is what libbpf and bpf prog will recognize as a set
> > > > of "address of insn" that can be passed into static_branch_update k=
func
> > > > or static_branch_update sys_bpf command.
> > > > The question is whether we need a new map type (array derivative)
> > > > to hold a set of "address of insn" or it can be a part of an existi=
ng
> > > > global data array.
> > > > A new map type is easier to reason about.
> > > > Notice how such a new map type is not a map type of static branches=
.
> > > > It's not a map type of goto_or_nop instructions either.
> > > >
> > > > At load time libbpf can populate this array with indices of insns
> > > > that the verifier and JIT need to track. Once JITed the array is re=
adonly
> > > > for bpf prog and for user space.
> > >
> > > So this will be a map per .insn_addrs.X section (where X is key or
> > > a pre-defined suffix for jump tables or indirect calls). And to tell
> > > the verifier about these maps we will need to pass an array of
> > >
> > >     struct {
> > >             u32 map_fd;
> > >             u32 type; /* static key, jump table, etc. */
> > >     }
> > >
> > > on program load. Is this correct?
> >
> >
> > Probably not.
> > Since we're going with a new map type (at least for the sake of this
> > discussion) it shouldn't need a new way to tell the verifier about it.
> > If .insn_addrs.jmp_table_A was a section generated for switch() stateme=
nt
> > by llvm it will be created as a map by libbpf,
> > and there will be an ld_imm64 insn generated by llvm that points
> > to that map.
> > libbpf will populate ld_imm64 insn with map_fd, just like it does
> > for global data.
>
> I understand how this works for indirect jumps (and for the
> bpf_static_branch_update(&foo) kfunc) where we have a ld_imm64 with a
> map, however, I am still not sure how this will work for static
> branches where we just have a 8 byte JA insn + an index in the
> corresponding ".insn_addrs.foo" section. How kernel will know that the
> program is using a corresponding map which we create from
> ".insn_addrs.foo" without specifying this on program load?
>
> (Sorry for replying late, catching up after [simultaneous] pto &
> covid.)

sorry. ctx switch takes time.
libbpf can just bpf_prog_bind_map to associate this new map type
of ptr_to_insn with a program.
Or I misunderstood the question?
