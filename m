Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE44605C1
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722321; cv=none; b=lJ46pnF2R7XejcVl+O5afOWE8bKzlRRwMwjfBXi3nmIv2iT3wbZd6+0DWxVnM9uM8mrGDxzou/Ac5ZYOnnzUPskbVlXeZzrrqQsu4jOFvrjm5NmQWFLAHhix1sMrW2HEJWsgUGIraMqHG+L10vgoPMTZhCP70KE6zSgjULYleYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722321; c=relaxed/simple;
	bh=MCUe1Ce5w3HhwVAbO++K3frDD18doSKOgiPf3/BS9OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVQ+BHPFtPk2LkJU0opd8lVsKZ1iCTZWiJw+Zjstc9HZNOxQASY6DpVimzgJv0KbLn5tsZJgdNTvpFy8y+Pj3Rhv1BLjoBwGYT0dj03WgatOlBJ/WHcEcjM/E1rIcFql0liBGNa4Kcuu+qdtugoQ1ZhcAhSnTmIyqJM89x3R7aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=hDlXh1dT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="hDlXh1dT"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512bde3d197so735505e87.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 02:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1709722317; x=1710327117; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mu51Rn1IsDd4e/jR6tga5wVb5ERyrouLKfCiu7r7yxc=;
        b=hDlXh1dTHElVTe/D89W8I1GiMfIC5IpC6Gd1fuPqX67bffzM64Pz0zocjhWTkg0CD7
         k8DiQyG+s8JmosOoZ6kno+1+RLq3E9+0mSpOQb3sBvq3Ud2Z/RoMsOluSwqNGHSZg8E1
         pbmsKT+5TBKgor0BAE4hOCuiwPlryhrhQJUsI4eRMt9PpOiZl6txJVzlezMxYGT+yw44
         NLfVXTD9PBNZsY6XP2n7gdaVv+QlgUx6+jSFEui9JDmQ/UnaW2af7IR4aCkcHg5rAWFS
         N26qHIJch6B/NIEgOVSJA46Vp7z1wKOJdUvXqFR5Q7kpy9J5+QIMbShkA0Jdj/MYNgVE
         viZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709722317; x=1710327117;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mu51Rn1IsDd4e/jR6tga5wVb5ERyrouLKfCiu7r7yxc=;
        b=IP+RSva0MjX+AZ8BkQbTx6ik3Ue4ps5KtSyc9p859eHLlo7WWAwOdHQ+5kgsJ9uxFz
         A20R+CBRlj3xYRKA/kCCSreCtjNGjUkW84yRoz+5G3JbbBQzLmthJdeY7WyqvyuYoFTw
         J9pAQpec5vC4QSeHRDU1DkcY73ILvnLyzjtO22Ab5PZ6rb/Gpm1/mYUIJPhf70Hp9p6C
         lSNoCbcln9AVNr1EOOW67v7NZi40zIqtG5Z6EO0gpozIpCF4T7YF4hIqitVin57dDZkV
         4fztZPNYQXzXbkuVJGVRlMU0mRPBa/T8VfFhufT04YWQRfcFLR1BnAyMijPTlbGbKNWu
         xPQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxRePWqs+6YPZNlAruQmcHchW7olU1Yy9sfnshudf/NsE4dgHds5weYonG3Y5gIn9C1EhJM3KkfdYoJXIecnAM/dAN
X-Gm-Message-State: AOJu0YzpD40YAGSXhOwbzSIb3KUy4wz8GSCdujDPC2D9uvh4SvuQ/UZn
	ZaF9aUPulbunHoqCg3lU3zdXa7ItPudJToUKdQ9/UgVxjKNWcs3qDd/qeOQI6SU=
X-Google-Smtp-Source: AGHT+IGeUU1gHM4FWb5HLpcyl135Rw61t5dvrWB6kspoBQUCd/hiP1OZhIUIKdAwL3USJHdsXg1Qtg==
X-Received: by 2002:ac2:57cd:0:b0:513:2b0d:f14f with SMTP id k13-20020ac257cd000000b005132b0df14fmr3003498lfo.20.1709722317363;
        Wed, 06 Mar 2024 02:51:57 -0800 (PST)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c458900b00412b3bf811bsm20535201wmo.8.2024.03.06.02.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:51:56 -0800 (PST)
Date: Wed, 6 Mar 2024 10:44:36 +0000
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
Message-ID: <ZehJFP11vi5sv/eW@zh-lab-node-5>
References: <20240202162813.4184616-1-aspsk@isovalent.com>
 <20240202162813.4184616-4-aspsk@isovalent.com>
 <CAADnVQLnk=UyKBkRAC1tNkiaF7C4+FG7V-b2xrR3oa_E4+QX7Q@mail.gmail.com>
 <ZcIDqnXFjsWYyu1G@zh-lab-node-5>
 <CAADnVQLfidjTWa4+kyRH-qC29gbGvFsRJHu6smcaL0Yk0HqgmA@mail.gmail.com>
 <ZcS1ZruKKZ1euzlb@zh-lab-node-5>
 <CAADnVQKH1aitaADzCo__PfMJJA2SxAvYjTS8Z7A6Y01G2OWJgw@mail.gmail.com>
 <Zc9p4e1EccPkMnmY@zh-lab-node-5>
 <CAADnVQJ+_+ok_io1_W7e5z_dZhxSqhEFZQkumRgmY4AJRYwW7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ+_+ok_io1_W7e5z_dZhxSqhEFZQkumRgmY4AJRYwW7g@mail.gmail.com>

On Tue, Feb 20, 2024 at 05:09:36PM -0800, Alexei Starovoitov wrote:
> On Fri, Feb 16, 2024 at 6:04 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > On Wed, Feb 14, 2024 at 10:48:26PM -0800, Alexei Starovoitov wrote:
> > > On Thu, Feb 8, 2024 at 3:11 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > >
> > > > On Tue, Feb 06, 2024 at 06:26:12PM -0800, Alexei Starovoitov wrote:
> > > > > On Tue, Feb 6, 2024 at 2:08 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 05, 2024 at 05:09:51PM -0800, Alexei Starovoitov wrote:
> > > > > > > On Fri, Feb 2, 2024 at 8:34 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > > > > > >
> > > > > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > > > > index 4def3dde35f6..bdd6be718e82 100644
> > > > > > > > --- a/include/linux/bpf.h
> > > > > > > > +++ b/include/linux/bpf.h
> > > > > > > > @@ -1524,6 +1524,13 @@ struct bpf_prog_aux {
> > > > > > > >         };
> > > > > > > >         /* an array of original indexes for all xlated instructions */
> > > > > > > >         u32 *orig_idx;
> > > > > > > > +       /* for every xlated instruction point to all generated jited
> > > > > > > > +        * instructions, if allocated
> > > > > > > > +        */
> > > > > > > > +       struct {
> > > > > > > > +               u32 off;        /* local offset in the jitted code */
> > > > > > > > +               u32 len;        /* the total len of generated jit code */
> > > > > > > > +       } *xlated_to_jit;
> > > > > > >
> > > > > > > Simply put Nack to this approach.
> > > > > > >
> > > > > > > Patches 2 and 3 add an extreme amount of memory overhead.
> > > > > > >
> > > > > > > As we discussed during office hours we need a "pointer to insn" concept
> > > > > > > aka "index on insn".
> > > > > > > The verifier would need to track that such things exist and adjust
> > > > > > > indices of insns when patching affects those indices.
> > > > > > >
> > > > > > > For every static branch there will be one such "pointer to insn".
> > > > > > > Different algorithms can be used to keep them correct.
> > > > > > > The simplest 'lets iterate over all such pointers and update them'
> > > > > > > during patch_insn() may even be ok to start.
> > > > > > >
> > > > > > > Such "pointer to insn" won't add any memory overhead.
> > > > > > > When patch+jit is done all such "pointer to insn" are fixed value.
> > > > > >
> > > > > > Ok, thanks for looking, this makes sense.
> > > > >
> > > > > Before jumping into coding I think it would be good to discuss
> > > > > the design first.
> > > > > I'm thinking such "address of insn" will be similar to
> > > > > existing "address of subprog",
> > > > > which is encoded in ld_imm64 as BPF_PSEUDO_FUNC.
> > > > > "address of insn" would be a bit more involved to track
> > > > > during JIT and likely trivial during insn patching,
> > > > > since we're already doing imm adjustment for pseudo_func.
> > > > > So that part of design is straightforward.
> > > > > Implementation in the kernel and libbpf can copy paste from pseudo_func too.
> > > >
> > > > To implement the "primitive version" of static branches, where the
> > > > only API is `static_branch_update(xlated off, on/off)` the only
> > > > requirement is to build `xlated -> jitted` mapping (which is done
> > > > in JIT, after the verification). This can be done in a simplified
> > > > version of this patch, without xlated->orig mapping and with
> > > > xlated->jit mapping only done to gotol_or_nop instructions.
> > >
> > > yes. The array of insn->jit_addr sized with as many goto_or_nop-s
> > > the prog will work for user space to flip them, but...
> > >
> > > > The "address of insn" appears when we want to provide a more
> > > > higher-level API when some object (in user-space or in kernel) keeps
> > > > track of one or more gotol_or_nop instructions so that after the
> > > > program load this controlling object has a list of xlated offsets.
> > > > But this would be a follow-up to the initial static branches patch.
> > >
> > > this won't work as a follow up,
> > > since such an array won't work for bpf prog that wants to flip branches.
> > > There is nothing that associates static_branch name/id with
> > > particular goto_or_nop.
> > > There could be a kfunc that bpf prog calls, but it can only
> > > flip all of such insns in the prog.
> > > Unless we start encoding a special id inside goto_or_nop or other hacks.
> > >
> > > > > The question is whether such "address of insn" should be allowed
> > > > > in the data section. If so, we need to brainstorm how to
> > > > > do it cleanly.
> > > > > We had various hacks for similar things in the past. Like prog_array.
> > > > > Let's not repeat such mistakes.
> > > >
> > > > So, data section is required for implementing jump tables? Like,
> > > > to add a new PTR_TO_LABEL or PTR_TO_INSN data type, and a
> > > > corresponding "ptr to insn" object for every occurence of &&label,
> > > > which will be adjusted during verification.
> > > > Looks to me like this one doesn't require any more API than specifying
> > > > a list of &&label occurencies on program load.
> > > >
> > > > For "static keys" though (a feature on top of this patch series) we
> > > > need to have access to the corresponding set of adjusted pointers.
> > > >
> > > > Isn't this enough to add something like an array of
> > > >
> > > >   struct insn_ptr {
> > > >       u32 type; /* LABEL, STATIC_BRANCH,... */
> > > >       u32 insn_off; /* original offset on load */
> > > >       union {
> > > >           struct label {...};
> > > >           struct st_branch { u32 key_id, ..};
> > > >       };
> > > >   };
> > >
> > > which I don't like because it hard codes static_branch needs into
> > > insn->jit_addr association.
> > > "address of insn" should be an individual building block without
> > > bolted on parts.
> > >
> > > A data section with a set of such "address of insn"
> > > can be a description of one static_branch.
> > > There will be different ways to combine such building blocks.
> > > For example:
> > > static_branch(foo) can emit goto_or_nop into bpf code
> > > and add "address of insn" into a section '.insn_addrs.foo".
> > > This section is what libbpf and bpf prog will recognize as a set
> > > of "address of insn" that can be passed into static_branch_update kfunc
> > > or static_branch_update sys_bpf command.
> > > The question is whether we need a new map type (array derivative)
> > > to hold a set of "address of insn" or it can be a part of an existing
> > > global data array.
> > > A new map type is easier to reason about.
> > > Notice how such a new map type is not a map type of static branches.
> > > It's not a map type of goto_or_nop instructions either.
> > >
> > > At load time libbpf can populate this array with indices of insns
> > > that the verifier and JIT need to track. Once JITed the array is readonly
> > > for bpf prog and for user space.
> >
> > So this will be a map per .insn_addrs.X section (where X is key or
> > a pre-defined suffix for jump tables or indirect calls). And to tell
> > the verifier about these maps we will need to pass an array of
> >
> >     struct {
> >             u32 map_fd;
> >             u32 type; /* static key, jump table, etc. */
> >     }
> >
> > on program load. Is this correct?
>
>
> Probably not.
> Since we're going with a new map type (at least for the sake of this
> discussion) it shouldn't need a new way to tell the verifier about it.
> If .insn_addrs.jmp_table_A was a section generated for switch() statement
> by llvm it will be created as a map by libbpf,
> and there will be an ld_imm64 insn generated by llvm that points
> to that map.
> libbpf will populate ld_imm64 insn with map_fd, just like it does
> for global data.

I understand how this works for indirect jumps (and for the
bpf_static_branch_update(&foo) kfunc) where we have a ld_imm64 with a
map, however, I am still not sure how this will work for static
branches where we just have a 8 byte JA insn + an index in the
corresponding ".insn_addrs.foo" section. How kernel will know that the
program is using a corresponding map which we create from
".insn_addrs.foo" without specifying this on program load?

(Sorry for replying late, catching up after [simultaneous] pto &
covid.)

> > > With that mechanism compilers can generate a proper switch() jmp table.
> > > llvm work can be a follow up, of course, but the whole design needs
> > > to be thought through to cover all use cases.
> > >
> > > To summarize, here's what I'm proposing:
> > > - PTR_TO_INSN verifier regtype that can be passed to static_branch_update kfunc
> >
> > If we have a set of pointers to jump instructions, generated from
> > static_branch(foo) for same foo, then this makes more sense to
> > provide a
> >
> >     static_branch_update(foo)
> 
> For bpf_static_branch_update(&foo) kfunc there will be another
> ld_imm64 insn that points to that map.
> No need for new interface here either.
> 
> > (where foo is substituted by libbpf with a map fd of .insn_addrs.foo
> > on load). The same for userspace:
> >
> >     bpf(STATIC_BRANCH_UPDATE, .attrs={.map_fd=foo})
> 
> but for libbpf it would be nice to have a helper that knows
> this .insn_addrs section details.
> 
> > > - new map type (array) that holds objects that are PTR_TO_INSN for the verifier
> > > libbpf populates this array with indices of insn it wants to track.
> > > bpf prog needs to "use" this array, so prog/map association is built.
> > > - verifier/JIT update each PTR_TO_INSN during transformations.
> > > - static_branch(foo) macro emits goto_or_nop insn and adds 8 bytes
> > > into ".insn_addrs.foo" section with an ELF relocation that
> > > libbpf will convert into index.
> > >
> > > When compilers implement jmptables for switch(key) they will generate
> > > ".insn_addrs.uniq_suffix" sections and emit
> > > rX = ld_imm64 that_section
> > > rX += switch_key
> > > rY = *(u64 *)rX
> > > jmpx rY
> >
> > What are the types for rX and rY? I thought that we will need to do
> > smth like
> >
> >   rX = .insn_addrs.uniq_suffix[switch_key] /* rX has type PTR_TO_INSN */
> >   ...
> >   jmpx rX
> 
> right. That ".insn_addrs.uniq_suffix[switch_key]" C syntax is exactly:
>   rX = ld_imm64 that_section
>   rX += switch_key
> in assembly.
> 
> >
> > this can be done if for switch cases (or any other goto *label alike) we generate
> >
> >   rX = map_lookup_elem(.insn_addrs.uniq_suffix, index)
> >   jmpx rX
> 
> No need for function calls.
>   rX = ld_imm64 that_section
>   rX += switch_key
> 
> should work.
> 
> It works for global variables already, like:
>   rX = ld_imm64 global_data_array_map
>   rX += 8 // address of 2nd u64 in global data
