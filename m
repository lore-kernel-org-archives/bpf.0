Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C928B336887
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775097954; cv=pass; b=HPHTWQU6laJT5OGqe0PZFOTpKlFx3pST9jYXF7Z0hti+aFXkBrEQmPRjruwX3PvGCBE9UUmGvA307FbrvZbkJYA/Lhn855bcILYTBf8oYCdGEQOLW3vUL3e+TuL56aUPNXY2c9l1NLzlKKQpUPxPaiMlxP2DRqhR1caB+nYFJmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775097954; c=relaxed/simple;
	bh=jAV3ioP66vEkdufTxtj547qWgtXZ9FewVu2mtoZ3TEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Brc0DqzEOdXBgLL40YXGG/hMpo/50MDQT/iuixGP5lMve0OK1htXPetEj3T9Rv5VFcmOwscWAvHGLNaNQJuEy7BqPJcz8wQvMOoa1RLUWsQfZnXfJJD23bCgc3DKIfSCiyk76XqeFaw2wWMZzOcia6owQlwisQ4mEw4mb3x32zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Si2mbyTB; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si2mbyTB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fb439299so2827585e9.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 19:45:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775097951; cv=none;
        d=google.com; s=arc-20240605;
        b=HbWXRGTd2jFASpBFrbR0p65/z2XL7aluccKbYPXCGAkdxTr+PZM8ZudBxaDuRstMTg
         EllG4I/GP90YjSaBIQUfwDqjW4mGD4NR+w8J+hNOMDXcZstMFRIlHqwbzZp3oq6kc9q3
         HmvHcMyhsxixFRjh9Q/evzVo8pcoKfaZzqjDaChiUUqdvUzkHxUb4yOWBMxA+rnlMyg+
         qjWxm/Fbxnkea5bzbVMXjexgzJ/XlI447ee3uswLcA1mRThW+wEfkKt8aM30iU8g+TJB
         bbZF3lOpoTQMyxk9b5BMAHsbGU8RoHBsLrv7MYmb/HPuSleD/xbkpuieMVOOpb62MWcF
         HaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0vBlHDle6WPXcMh/oPV6nFSh8kH2WHEIiXmRlHqfRKo=;
        fh=UcZqnkcPYPCJuBeofOOObWQTYZ2DVO/Q2yzEycpMUlQ=;
        b=ATbEYHU9/RGGaZazrhNasleLFCN3UmV1/4sYLcdZXpoYaB8Vg77Rm9S4v1ROAFeLEo
         P1tG8iBnW+8U9illOsFpA7kIVuERjUXRdxc5FAoP86aNJkDpIUewpKXXKPKwGgpAF94t
         pQY5o9Y2KzvgdrDit2KmfgGGuziek3lqIXQ8vvfrNG0tsewMq3JW+QIe/a0EahHZzMEJ
         DHttkz/x4Mk2C1CQlusDKktfdQ4faEXIZCh1FMm8khgsfGgRTxtOlWsxcdui911wW/7P
         MSpu46uiAdgv3odkF7ixtObW/XcRTJ9SSfqlUurXN6IaWpyRN8bcFnAN7a6Ff7d7GpwT
         xmuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775097951; x=1775702751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vBlHDle6WPXcMh/oPV6nFSh8kH2WHEIiXmRlHqfRKo=;
        b=Si2mbyTBqvDzOZjQTuNMCQRDfo97xOjuOVPeOp/dbWURjKARFo2QC6gVcF6XvEk9oY
         gbki4RijvF+13zYVpQ8Frm/z9gQbmoyqQnBt8U5zvd9DUz4efrATBYeSiL62HV+Y2iPe
         JttWyDKdmI96f8QiwsmXlFGEeeOmdO8sgdtFssFWXjnVI9iMc2PasQuzsR4l6FpdYanS
         ljkl+VtuV4oiPhgyHyFlNMhj63m893eCPKutnbnb3VqctdajEWh/Ht1oNHlKol/ELSEj
         YulQu6mgm5rfdKPwiRvL7WwlHcNDTdg0LU9wGJitFkEgVkviHDSLDk//XBVkDcqrF/S3
         kDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775097951; x=1775702751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0vBlHDle6WPXcMh/oPV6nFSh8kH2WHEIiXmRlHqfRKo=;
        b=cMeVDaJNopPWp2hmoJpvNmOqMGINNnNnF9VgnERHIL9PlU0HI/brOHg6iy3TzxJvfB
         B+xLUSqAtun44UPBUp/obeO6QjXwesCwk3YOIlEbswfeqx6lGzWCix2KakJBMqJJb1kZ
         gKf2kVs4HUFyWovcAVLwphYaG3EizOMh19d1KHlcYQZQvNQh7XGsSfkZJ3f6Px82qnS9
         ZELQHpuZV+Kd6JVbXu2e2syFY71To5MkfgWcNl81cFr3DyPCSTVANOluOy9qgsUxPJ+p
         l0maIjq2NQpapzcb+84Qqgcj+TsQ+doVNbPMIxk5TXARb56RawRHBccv7TZw/Sf54UFs
         7Ljg==
X-Gm-Message-State: AOJu0YwIhrxwifQ7gR3H64e/7+T4GNceVNscd3CwtAxotfAPjkwKkBG4
	qJzzmfjogdTUiXM4pz5YU/fvYZ1W9iGMDhi9+Vj6Rvhw5Y/PmVl3UuQmD/D85kQVTKw3Ofnpr99
	vwQBpmHpdHnsD7GR4AwXGifIst1GknL0=
X-Gm-Gg: ATEYQzw/Cuer6484oqE9W5l4gQG8YaXB5viMFg5nzdfZcoou4uYGEIh72eEJuJjKXr8
	89v63gY0AfqAP6Cms47dwr2Z61oi5bdoRpNnQxiV6pN7m1zX6GmcGGKGNk+lk7FozWTPt/OuijS
	f1Hl+tZc8Z6zRjQ/mVNc+tidPNuAYaviwVDrfk7mCJaNyG1QeR265AgOcwaEODsJmEeKuCtaley
	3Pp1nlhXcwuONZ7MDMOn5R+vWf4eSmKQ/XLXq6Vmq5v7ej6kAdoPG8ClL1ZbG8ELzBVxi8kQTXF
	vAxrMrkKZr3lAoI6kR0Ww641jP+L5yKAGAltbVagVAjScKNu0yzHO+sbHEIDGmwhY3MXNSVJHsW
	S2gwtmqqQvjsURqcmSJQpQtNzuQ==
X-Received: by 2002:a05:600c:1f11:b0:486:fd3a:fd22 with SMTP id
 5b1f17b1804b1-48883568b21mr87984785e9.4.1775097950988; Wed, 01 Apr 2026
 19:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
 <20260401021635.34636-5-alexei.starovoitov@gmail.com> <3c091ab744676990e90469a89a4f0110d724ce19.camel@gmail.com>
 <CAADnVQJtw5A4GbknXoA-BtobOVMiBc+pC8nUQZ+1zX5wbj3ipg@mail.gmail.com>
In-Reply-To: <CAADnVQJtw5A4GbknXoA-BtobOVMiBc+pC8nUQZ+1zX5wbj3ipg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Apr 2026 19:45:39 -0700
X-Gm-Features: AQROBzAS5onjHX4joIB3F_U4AwhGHEIAxc1wFoqQssoUn7SYnjiw3MqAlK53mMw
Message-ID: <CAADnVQJhXVri5XC8YScjUs1ShPiSokSCWt5F6LDJ-YDnivzb6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/6] bpf: Add compute_const_regs() and
 prune_dead_branches() passes
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 3:32=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Apr 1, 2026 at 2:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Tue, 2026-03-31 at 19:16 -0700, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Add two passes before the main verifier pass:
> > >
> > > compute_const_regs() is a forward dataflow analysis that tracks
> > > register values in R0-R9 across the program using fixed-point
> > > iteration in reverse postorder. Each register is tracked with
> > > a six-state lattice:
> > >
> > >   UNVISITED -> CONST(val) / MAP_PTR(map_index) /
> > >                MAP_VALUE(map_index, offset) / SUBPROG(num) -> UNKNOWN
> > >
> > > At merge points, if two paths produce the same state and value for
> > > a register, it stays; otherwise it becomes UNKNOWN.
> > >
> > > The analysis handles:
> > >  - MOV, ADD, SUB, AND with immediate or register operands
> > >  - LD_IMM64 for plain constants, map FDs, map values, and subprogs
> > >  - LDX from read-only maps: constant-folds the load by reading the
> > >    map value directly via bpf_map_direct_read()
> > >
> > > Results that fit in 32 bits are stored per-instruction in
> > > insn_aux_data and bitmasks.
> > >
> > > prune_dead_branches() uses the computed constants to evaluate
> > > conditional branches. When both operands of a conditional jump are
> > > known constants, the branch outcome is determined statically and the
> > > instruction is rewritten to an unconditional jump.
> > > The CFG postorder is then recomputed to reflect new control flow.
> > > This eliminates dead edges so that subsequent liveness analysis
> > > doesn't propagate through dead code.
> > >
> > > Also add runtime sanity check to validate that precomputed
> > > constants match the verifier's tracked state.
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> >
> > Besides issues found by bot this patch lgtm.
> >
> > [...]
> >
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
> > > index 4f492eaad5c2..0d797de30a3a 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> >
> > [...]
> >
> > > @@ -1086,6 +1102,13 @@ struct bpf_iarray *bpf_insn_successors(struct =
bpf_verifier_env *env, u32 idx);
> > >  void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
> > >  bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx);
> > >
> > > +int find_subprog(struct bpf_verifier_env *env, int off);
> > > +int compute_const_regs(struct bpf_verifier_env *env);
> > > +int prune_dead_branches(struct bpf_verifier_env *env);
> > > +int compute_postorder(struct bpf_verifier_env *env);
> > > +bool insn_is_cond_jump(u8 code);
> > > +bool is_may_goto_insn(struct bpf_insn *insn);
> > > +
> >
> > Q: What is the policy regarding naming exported functions?
> >    So far I always used "bpf_..." prefix assuming that this
> >    is a requirement, was I wrong?
>
> It's nice to have but not mandatory.
> imo the names are unique enough, so unlikely to clash.

This one I still think is ok, but the other patch does:

-__printf(2, 3) static void verbose(void *private_data, const char *fmt, ..=
.)
+__printf(2, 3) void verbose(void *private_data, const char *fmt, ...)

and this is definitely too much.
