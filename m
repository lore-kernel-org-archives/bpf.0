Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA8934EEE1
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047784; cv=pass; b=KsMY6DkiXHZNz+ICZKaPMDxeSKxmvgDOHlfrkTl5bV6W7KW0CMgR8xFkBLT46/U0KkWMseY+BbFbnr97QO1XGVnz9zv1/AL2gB7rLHaYA3NnaNArcahva9cmsRHD+TGxQEEfiSpN7hh701YFIi02ic3Ezk9h4Nr+lwRPmKIS+J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047784; c=relaxed/simple;
	bh=3m4VXaMs4n4EPq3GLOSR3itDAfPEZGkQPOTO8GJSpCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1HZ9bOFcgVO86ORn2AUwRJ37gZSNe6crMuAknwwVKH/a7e+/9VgN44mQiFLNi0rK9VuDJVrDGQaX4pvaVYWvNrQS7v870YbxSZThW4DngAt1sSfDOG0HW1X1rSVbvcMGV+mS6WfF0IR2yQOwrUIkchSP1xh+z6RyRizwQtDzaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaOX3lfh; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaOX3lfh"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2503753efso82509285ad.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 09:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777047782; cv=none;
        d=google.com; s=arc-20240605;
        b=lSfwCIq5yT+BLN75jMcH4nTEiT0fNpoQKxjAk1JVXcEJobxHAnGSUZ2VD1ifBdE296
         bqmrUZu507lhaN6emF7p94vxlpZmnab02tAWeVjA7ZS1FRoGRqpb2ntPiEcReTtyn9YT
         pFhimVOIFTPcTnju8o5HobakwD987Qd2f/euCBGag/Ntpze9y4uJmSqbSKH2hg6ejT/x
         iERFcKlhrsv12sExuq8Vaxs9R5zjwB2naZPWJAQMsMnx1iEFKrpK/KbRcMe/lzxdot52
         XH3yn2BQLv98saOoTt5JJJJ92FRkjQ0QTIwu+GDJMC54aQ+ASUmfOPG2f2lEknsTzDaz
         4MYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uZSOT1Xpo8svsF0lfHeXNdp2/Y1pp+xVy0pY5P0ySGQ=;
        fh=zJ7odwitiZ4Go6vwe9A1wHagnO8NzvH3mQM+pdfOTPg=;
        b=cFMBeK5350qkQiJzsbfvYysOht4yzc24TyNygWZ2LVgRDazSC3ps2xBEvraawJYYms
         Xg7X3AzukAehZBL958EhkLz/dEAcZmK/Rmo9Pp2UvQlHxq8ykWQ8FRSz7lys6n2wr6CC
         AWQMGydhc1ESofN5vmP216eqwVxZvQuXMr6R8tS/kpQN3biDQzWSLKuW0nxQbigJNoJG
         0JUeFr5vTgh0Rac7AXu1px0/rwMLGhDf43qw8Ncpyoa/EI12gzyw5kOgJZNGV1FHGR0C
         9AvlmCDyjeEPj49kvvtTSn/qNpTAPjPXV6TqvhAtEVjo7+r0x97hyW9u4VJxFmCyjLfH
         1wcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777047782; x=1777652582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZSOT1Xpo8svsF0lfHeXNdp2/Y1pp+xVy0pY5P0ySGQ=;
        b=XaOX3lfhIPP1oCKWEcYqGQIlR4o33LR6uIcpT+k4JsMHw+fqDi7zAEpJEYW275teDS
         kc2ALhpBkWbeF7GVyEjyNuRaJskgpONreNAq1Fp20smkPNjqn5vuozbNwvanDYJPlSHx
         XUKNdEW3sj0uv4CxFVi6ZDu00/4aODwkPj/yYL/YvnPTlhiPRoePnqZ20bh5yUAq7uIH
         tMMfNvMxYMhxQEZcnCHtHPHtBhayjRpSuj08XTjYsapWi8RqgO5uOg16gDyYXCuvuTNd
         ZTvG9MO0afLoLf8qyyemi5/Wf9ZJYjNODXGPGSx2aFqfxoxuwPl0PymRYUC1aL6QSTt7
         jVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777047782; x=1777652582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uZSOT1Xpo8svsF0lfHeXNdp2/Y1pp+xVy0pY5P0ySGQ=;
        b=LcUUibPxmNOgt9W8RSHPuwKgDq0PRPsVUAoZ6pXHkTyGIsS46qjcleUqZVjVZefd4X
         ZwxtSbD6dobuMzm8KgpBksPRKlsph/C5zbhXNJjvUv3FKVTIlpvdcA1wlg7758Pt8ZiT
         M0BwdJ03WtfXVG5IynMRpDYTXeXKwdOkXFb3QrxaWezZp7JQGAUAI8iYy2PZ9e9lRf1Z
         FZOBFkFLc8Dc+1jN6+OyAuY3ISv/mBb9Z1WeZlBJ3a6E5ogqu7IxFUJl+TB+umyYRYLa
         yl3HelQuYz5Xb1aJMsydpYTbO9RjAOWqLD3QY4Ko35N4S+lphFmIMR277C3+u/rB016q
         sIcw==
X-Gm-Message-State: AOJu0Yyo8dDZ1gVFxbwJ2EIfVlIADrksDTzCDvTv6v4KfAyzXQCRSn1+
	lnrxcSo9hcXey7IqkwwtqcNbrp/XJow1N7Fq82Mtqj6L6BwlblpAqS23QOP3EZUptduykI8d7uX
	EIhhPxWTqB85gJqHaZVeW5ijGu3AKoEdb0g==
X-Gm-Gg: AeBDietkJxnI9igZvYvnKSwNM6+pwVLGciZjT4FzltLrfPg3Gb1S8zGF84xB0LlcMM3
	czTcfPG00KRCSIvoQhLhHtH9ohlmvCe4G55gvijf5c4JnB2uIejpl1Q8GF4q1A3qyfEjZLCuM7s
	8FbfC+/FhPIg3yXLUUcpqQlPayBwBOFIX6q5sWEU5pwrNS7JUlae0toe3V9OdTw2f2wnGbgIK/W
	xzyq8n/OaRvQ74C+Fbbuo3n4FHPUdNfH4mueAJOseRk1cNG4/Tdvw8t7pPgHgHHJ88QuewApFJw
	AoylKNl4zhcEjwQgHg==
X-Received: by 2002:a17:903:3db3:b0:2b2:58a2:c8a with SMTP id
 d9443c01a7336-2b5f9d68827mr230869715ad.0.1777047782298; Fri, 24 Apr 2026
 09:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-2-ameryhung@gmail.com>
 <CAEf4BzZGg1EKwYFG6QKrkNbiE6RwWKew_Zz8mz9rjshKjWzcKA@mail.gmail.com> <CAMB2axMw7mOs8kTFZG8Z1wn8fX4D0Si3Ge4F58DXKkBBQwrjyw@mail.gmail.com>
In-Reply-To: <CAMB2axMw7mOs8kTFZG8Z1wn8fX4D0Si3Ge4F58DXKkBBQwrjyw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 24 Apr 2026 09:22:49 -0700
X-Gm-Features: AQROBzA4gxdMlVVwbP4QziFaumqbNPLGu0rKNfr3k9Zf5X-mR78Ckn8Sj18mJ3I
Message-ID: <CAEf4BzZ1LjRhh2DyQ8gPNKDh9fY+yOJrH0Ly9RoakBL2nOuxaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Unify dynptr handling in the verifier
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 10:34=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> On Thu, Apr 23, 2026 at 5:04=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Amery Hung <ameryhung@gmail.com=
> wrote:
> > >
> > > Simplify dynptr checking for helper and kfunc by unifying it. Remembe=
r
> > > the initialized dynptr (i.e.,g !(arg_type |=3D MEM_UNINIT)) pass to a
> > > dynptr kfunc during process_dynptr_func() so that we can easily
> > > retrieve the information for verification later. By saving it in
> > > meta->dynptr, there is no need to call dynptr helpers such as
> > > dynptr_id(), dynptr_ref_obj_id() and dynptr_type() in check_func_arg(=
).
> > >
> > > Remove and open code the helpers in process_dynptr_func() when
> > > saving id, ref_obj_id, and type. It is okay to drop spi < 0 check as
> > > is_dynptr_reg_valid_init() has made sure the dynptr is valid.
> > >
> > > Besides, since dynptr ref_obj_id information is now pass around in
> > > meta->bpf_dynptr_desc, drop the check in helper_multiple_ref_obj_use.
> > >
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  include/linux/bpf_verifier.h |  12 ++-
> > >  kernel/bpf/verifier.c        | 178 +++++++--------------------------=
--
> > >  2 files changed, 41 insertions(+), 149 deletions(-)
> > >
> >
> > [...]
> >
> > > @@ -7433,7 +7426,8 @@ static int process_kptr_func(struct bpf_verifie=
r_env *env, int regno,
> > >   * and checked dynamically during runtime.
> > >   */
> > >  static int process_dynptr_func(struct bpf_verifier_env *env, int reg=
no, int insn_idx,
> > > -                              enum bpf_arg_type arg_type, int clone_=
ref_obj_id)
> > > +                              enum bpf_arg_type arg_type, int clone_=
ref_obj_id,
> > > +                              struct bpf_dynptr_desc *dynptr)
> > >  {
> > >         struct bpf_reg_state *reg =3D reg_state(env, regno);
> > >         int err;
> > > @@ -7499,6 +7493,20 @@ static int process_dynptr_func(struct bpf_veri=
fier_env *env, int regno, int insn
> > >                 }
> > >
> > >                 err =3D mark_dynptr_read(env, reg);
> >
> > if mark_dynptr_read() fails, should we exit instead of proceeding to
> > fill out dynptr info?.. even if mark_dynptr_read() cannot fail because
> > of is_dynptr_reg_valid_init(), it still looks wrong and error-prone
>
> I think I will change mark_dynptr_read() to receive spi from the
> caller and make the function return void (It is technically nofail
> after liveness tracking code is removed). Then, move dynptr_get_spi()
> before it and don't error out. A comment seems to be enough.

yep, makes sense

>
> /* Cannot fail as we already make sure reg is valid dynptr */
> spi =3D dynptr_get_spi(env, reg);
>
> mark_dynptr_read(env, reg, spi);
>
> >
> > > +
> > > +               if (dynptr) {
> > > +                       struct bpf_func_state *state =3D bpf_func(env=
, reg);
> > > +                       int spi;
> > > +
> > > +                       if (reg->type !=3D CONST_PTR_TO_DYNPTR) {
> > > +                               spi =3D dynptr_get_spi(env, reg);
>
> ^ move this up
>
> > > +                               reg =3D &state->stack[spi].spilled_pt=
r;
> > > +                       }
> > > +
> > > +                       dynptr->id =3D reg->id;
> > > +                       dynptr->type =3D reg->dynptr.type;
> > > +                       dynptr->ref_obj_id =3D reg->ref_obj_id;
> > > +               }
> > >         }
> > >         return err;
> > >  }
> >
> > [...]
