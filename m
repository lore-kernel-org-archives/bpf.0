Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58A9433A0
	for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407477; cv=none; b=YIa3vmocLejMuzRrYFbQyo1jlVGH45taBOaKPpBBau7zhCM5JPwuzm+z2sPdNm+vv59Q+H7TxLhTlgQqSCFcjzX0DNLwyv2EPa4BO/BQyOIMR5CbwJpiJgojHJUQ5r2NV4MKntlMf/S19KgbJjg9UpYHHb9F7e9TdKSB6YKZW2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407477; c=relaxed/simple;
	bh=tRuigTVhySto9HP06SDlUVpmAwg6czpe1ufC8XRlZVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2d7gwvPoqtO47jl19lTxZlYN2xarSb//KyIwyNxosroVOuW8VT5g5eabFi0vIsjiPKkSMH8yAA3SVoLebD/5HqNwi+9qd63li6WePjKtNfeQ/JDqu1urik3Jyxbme8sKVkOd38QXtV5GcV5ttcuK/Dqq0XdiIMf5Sp/5wC3O44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=ePjpxKrK; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="ePjpxKrK"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so92559166b.0
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 02:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1710407474; x=1711012274; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6uqOjoGuvM0n04+MU8F/uSrS7uGl645BO8r/kCRYiZk=;
        b=ePjpxKrKeSSn661myDTaziQlI5wa1SQJDTqnm7GSvPYB9m4gn5v0TA4+6WsQsQ03XX
         LXTq6BzT2wTkQwzGaXu7bRbEPyZqVKlPmRuBR8Kk7JOEb/XtWSYM5mqp2a+4alN7vZkO
         1DAvwq17keYanTZnQt1qidwMeAKb4Rw1IibZy0HiXsFZeuynrJzaRq1C0cEd2QijSx21
         0f15aw4Cf7E29ROWeHM7muz5s84l1uwal9V2fufEZR6LZHBqFIKxXkKAGD6viLj66gpe
         PihN9u5iTte3P6PAKuJuES7wfbKhH+h6RuMqzPNOOEF0ysFsrzE6XcM2EvvmuPAS2utA
         ktOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710407474; x=1711012274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6uqOjoGuvM0n04+MU8F/uSrS7uGl645BO8r/kCRYiZk=;
        b=T3k7MJXAwpFyt8axkNxUT/wpTRo4+Yc7jXZMqbrzC3tKdbVQG05G1KKCw7Riu0lJBp
         gSICRWX9pLDz+eSlySm3Z9ZDvSj4B86FZVxmI2tmGW1OsLxwUHbeGseNUvxIHzWeX9F8
         U2xEV3VR07XGmatrophfFr4uyv1qRgamPK5FjeGlMz5hTM8GdhxuvZ1SW5RH8o33VhrW
         9ELiAyz+hGi6N8QeIOYO5zjZKt68KiiE46Qy+VwDCXno2MoQnC1QC+ypGrSY0czrfP0I
         YcYTepV8YJPMRsL9e+4TugDq6iEV6S5YlwQcDeUDqz2HjqyB/pJA9tRYvD6QaSXbtG5t
         4jEw==
X-Forwarded-Encrypted: i=1; AJvYcCUR2IlfZZzJFmKy5U6O+MsWVxqUDR81wUaVe+h4CWP1dROMIXWsucwC+/PHqcpk5r2cTQFZz9TtxG0lJIWYf8KKF8A0
X-Gm-Message-State: AOJu0YzBq2Mev4hY9O01RWqGwWJQqqwd2OJP+CFzpnNw1r8Dfxq2SYQG
	8gjkkcxsyv6QYfAlrG8pDiGMS7Z9HzAJCIOTDV2EpASIxNFDuIeQUXcdukEFT5hoxRq/aPlEdGW
	U
X-Google-Smtp-Source: AGHT+IEXJ+jat5SE2PBBJfYanYu7cyUEZ6k6RTu48Eqf5ehKZxl0r8E3sJTSWnKi+LfmCyycPYZcsQ==
X-Received: by 2002:a17:906:c2cb:b0:a46:2ba9:da10 with SMTP id ch11-20020a170906c2cb00b00a462ba9da10mr596760ejb.25.1710407473999;
        Thu, 14 Mar 2024 02:11:13 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id v27-20020a1709063bdb00b00a4665f829a9sm503830ejf.90.2024.03.14.02.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 02:11:13 -0700 (PDT)
Date: Thu, 14 Mar 2024 09:03:31 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v1 bpf-next 3/9] bpf: expose how xlated insns map to
 jitted insns
Message-ID: <ZfK9Y5c7RuOu0YiN@zh-lab-node-5>
References: <20240202162813.4184616-4-aspsk@isovalent.com>
 <CAADnVQLnk=UyKBkRAC1tNkiaF7C4+FG7V-b2xrR3oa_E4+QX7Q@mail.gmail.com>
 <ZcIDqnXFjsWYyu1G@zh-lab-node-5>
 <CAADnVQLfidjTWa4+kyRH-qC29gbGvFsRJHu6smcaL0Yk0HqgmA@mail.gmail.com>
 <ZcS1ZruKKZ1euzlb@zh-lab-node-5>
 <CAADnVQKH1aitaADzCo__PfMJJA2SxAvYjTS8Z7A6Y01G2OWJgw@mail.gmail.com>
 <Zc9p4e1EccPkMnmY@zh-lab-node-5>
 <CAADnVQJ+_+ok_io1_W7e5z_dZhxSqhEFZQkumRgmY4AJRYwW7g@mail.gmail.com>
 <ZehJFP11vi5sv/eW@zh-lab-node-5>
 <CAADnVQJnh+j9etPYkst7hhnepvsoBuJY-ds-AF0fn3VqqJNXNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJnh+j9etPYkst7hhnepvsoBuJY-ds-AF0fn3VqqJNXNg@mail.gmail.com>

On Wed, Mar 13, 2024 at 06:56:34PM -0700, Alexei Starovoitov wrote:
> On Wed, Mar 6, 2024 at 2:51 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > On Tue, Feb 20, 2024 at 05:09:36PM -0800, Alexei Starovoitov wrote:
> > > On Fri, Feb 16, 2024 at 6:04 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > >
> > > > On Wed, Feb 14, 2024 at 10:48:26PM -0800, Alexei Starovoitov wrote:
> > > > > On Thu, Feb 8, 2024 at 3:11 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 06, 2024 at 06:26:12PM -0800, Alexei Starovoitov wrote:
> > > > > > > On Tue, Feb 6, 2024 at 2:08 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Feb 05, 2024 at 05:09:51PM -0800, Alexei Starovoitov wrote:
> > > > > > > > > On Fri, Feb 2, 2024 at 8:34 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > > > > > > > >
> > > > > > > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > > > > > > index 4def3dde35f6..bdd6be718e82 100644
> > > > > > > > > > --- a/include/linux/bpf.h
> > > > > > > > > > +++ b/include/linux/bpf.h
> > > > > > > > > > @@ -1524,6 +1524,13 @@ struct bpf_prog_aux {
> > > > > > > > > >         };
> > > > > > > > > >         /* an array of original indexes for all xlated instructions */
> > > > > > > > > >         u32 *orig_idx;
> > > > > > > > > > +       /* for every xlated instruction point to all generated jited
> > > > > > > > > > +        * instructions, if allocated
> > > > > > > > > > +        */
> > > > > > > > > > +       struct {
> > > > > > > > > > +               u32 off;        /* local offset in the jitted code */
> > > > > > > > > > +               u32 len;        /* the total len of generated jit code */
> > > > > > > > > > +       } *xlated_to_jit;
> > > > > > > > >
> > > > > > > > > Simply put Nack to this approach.
> > > > > > > > >
> > > > > > > > > Patches 2 and 3 add an extreme amount of memory overhead.
> > > > > > > > >
> > > > > > > > > As we discussed during office hours we need a "pointer to insn" concept
> > > > > > > > > aka "index on insn".
> > > > > > > > > The verifier would need to track that such things exist and adjust
> > > > > > > > > indices of insns when patching affects those indices.
> > > > > > > > >
> > > > > > > > > For every static branch there will be one such "pointer to insn".
> > > > > > > > > Different algorithms can be used to keep them correct.
> > > > > > > > > The simplest 'lets iterate over all such pointers and update them'
> > > > > > > > > during patch_insn() may even be ok to start.
> > > > > > > > >
> > > > > > > > > Such "pointer to insn" won't add any memory overhead.
> > > > > > > > > When patch+jit is done all such "pointer to insn" are fixed value.
> > > > > > > >
> > > > > > > > Ok, thanks for looking, this makes sense.
> > > > > > >
> > > > > > > Before jumping into coding I think it would be good to discuss
> > > > > > > the design first.
> > > > > > > I'm thinking such "address of insn" will be similar to
> > > > > > > existing "address of subprog",
> > > > > > > which is encoded in ld_imm64 as BPF_PSEUDO_FUNC.
> > > > > > > "address of insn" would be a bit more involved to track
> > > > > > > during JIT and likely trivial during insn patching,
> > > > > > > since we're already doing imm adjustment for pseudo_func.
> > > > > > > So that part of design is straightforward.
> > > > > > > Implementation in the kernel and libbpf can copy paste from pseudo_func too.
> > > > > >
> > > > > > To implement the "primitive version" of static branches, where the
> > > > > > only API is `static_branch_update(xlated off, on/off)` the only
> > > > > > requirement is to build `xlated -> jitted` mapping (which is done
> > > > > > in JIT, after the verification). This can be done in a simplified
> > > > > > version of this patch, without xlated->orig mapping and with
> > > > > > xlated->jit mapping only done to gotol_or_nop instructions.
> > > > >
> > > > > yes. The array of insn->jit_addr sized with as many goto_or_nop-s
> > > > > the prog will work for user space to flip them, but...
> > > > >
> > > > > > The "address of insn" appears when we want to provide a more
> > > > > > higher-level API when some object (in user-space or in kernel) keeps
> > > > > > track of one or more gotol_or_nop instructions so that after the
> > > > > > program load this controlling object has a list of xlated offsets.
> > > > > > But this would be a follow-up to the initial static branches patch.
> > > > >
> > > > > this won't work as a follow up,
> > > > > since such an array won't work for bpf prog that wants to flip branches.
> > > > > There is nothing that associates static_branch name/id with
> > > > > particular goto_or_nop.
> > > > > There could be a kfunc that bpf prog calls, but it can only
> > > > > flip all of such insns in the prog.
> > > > > Unless we start encoding a special id inside goto_or_nop or other hacks.
> > > > >
> > > > > > > The question is whether such "address of insn" should be allowed
> > > > > > > in the data section. If so, we need to brainstorm how to
> > > > > > > do it cleanly.
> > > > > > > We had various hacks for similar things in the past. Like prog_array.
> > > > > > > Let's not repeat such mistakes.
> > > > > >
> > > > > > So, data section is required for implementing jump tables? Like,
> > > > > > to add a new PTR_TO_LABEL or PTR_TO_INSN data type, and a
> > > > > > corresponding "ptr to insn" object for every occurence of &&label,
> > > > > > which will be adjusted during verification.
> > > > > > Looks to me like this one doesn't require any more API than specifying
> > > > > > a list of &&label occurencies on program load.
> > > > > >
> > > > > > For "static keys" though (a feature on top of this patch series) we
> > > > > > need to have access to the corresponding set of adjusted pointers.
> > > > > >
> > > > > > Isn't this enough to add something like an array of
> > > > > >
> > > > > >   struct insn_ptr {
> > > > > >       u32 type; /* LABEL, STATIC_BRANCH,... */
> > > > > >       u32 insn_off; /* original offset on load */
> > > > > >       union {
> > > > > >           struct label {...};
> > > > > >           struct st_branch { u32 key_id, ..};
> > > > > >       };
> > > > > >   };
> > > > >
> > > > > which I don't like because it hard codes static_branch needs into
> > > > > insn->jit_addr association.
> > > > > "address of insn" should be an individual building block without
> > > > > bolted on parts.
> > > > >
> > > > > A data section with a set of such "address of insn"
> > > > > can be a description of one static_branch.
> > > > > There will be different ways to combine such building blocks.
> > > > > For example:
> > > > > static_branch(foo) can emit goto_or_nop into bpf code
> > > > > and add "address of insn" into a section '.insn_addrs.foo".
> > > > > This section is what libbpf and bpf prog will recognize as a set
> > > > > of "address of insn" that can be passed into static_branch_update kfunc
> > > > > or static_branch_update sys_bpf command.
> > > > > The question is whether we need a new map type (array derivative)
> > > > > to hold a set of "address of insn" or it can be a part of an existing
> > > > > global data array.
> > > > > A new map type is easier to reason about.
> > > > > Notice how such a new map type is not a map type of static branches.
> > > > > It's not a map type of goto_or_nop instructions either.
> > > > >
> > > > > At load time libbpf can populate this array with indices of insns
> > > > > that the verifier and JIT need to track. Once JITed the array is readonly
> > > > > for bpf prog and for user space.
> > > >
> > > > So this will be a map per .insn_addrs.X section (where X is key or
> > > > a pre-defined suffix for jump tables or indirect calls). And to tell
> > > > the verifier about these maps we will need to pass an array of
> > > >
> > > >     struct {
> > > >             u32 map_fd;
> > > >             u32 type; /* static key, jump table, etc. */
> > > >     }
> > > >
> > > > on program load. Is this correct?
> > >
> > >
> > > Probably not.
> > > Since we're going with a new map type (at least for the sake of this
> > > discussion) it shouldn't need a new way to tell the verifier about it.
> > > If .insn_addrs.jmp_table_A was a section generated for switch() statement
> > > by llvm it will be created as a map by libbpf,
> > > and there will be an ld_imm64 insn generated by llvm that points
> > > to that map.
> > > libbpf will populate ld_imm64 insn with map_fd, just like it does
> > > for global data.
> >
> > I understand how this works for indirect jumps (and for the
> > bpf_static_branch_update(&foo) kfunc) where we have a ld_imm64 with a
> > map, however, I am still not sure how this will work for static
> > branches where we just have a 8 byte JA insn + an index in the
> > corresponding ".insn_addrs.foo" section. How kernel will know that the
> > program is using a corresponding map which we create from
> > ".insn_addrs.foo" without specifying this on program load?
> >
> > (Sorry for replying late, catching up after [simultaneous] pto &
> > covid.)
> 
> sorry. ctx switch takes time.
> libbpf can just bpf_prog_bind_map to associate this new map type
> of ptr_to_insn with a program.
> Or I misunderstood the question?

All ptr_to_insn maps are required during the verification. So
bpf_prog_bind_map can't be used as it requires an existing program.

What could work and what I am proposing is to pass a list of bound
maps in prog_load attributes. Then such maps can be used during the
verification. For normal maps

  prog = prog_load(attr={.bound_maps=maps})

will be semantically the same as

  prog = prog_load()
  bpf_prog_bind_map(prog, maps)
