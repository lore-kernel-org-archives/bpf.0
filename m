Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C076E313520
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769804256; cv=pass; b=lxQBmLMQk0FDNIJWAS5emqSHXC2eQO6yNTPbAooebBj/oDVvv6X2j1i/V0GzpfavPZr3NK0DfWw4r0F8sQ9WHrEHGgc9UKnqFey8xICyslf1c2eHtgE8TvvZpf02Ctl+MCSfMCGf/0WjUhC8VFHCp6x8EloHAepBPWwPWqQ1y6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769804256; c=relaxed/simple;
	bh=dcn7oDy1+lw3lX1sFe2xWeSgJmlACo6AUQO8T8b1G1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dlyfo3MAanOvLCvtgPGIXJuSPDnWHbw3x/zGO9Mby6xdLKIknjE0xNjWTYaCrXje/7qM5rrZwOHZRpugS+SRl3pxWTn9zthZs9XRN+ZGDZsSumdEJC+QIjK/6Pu/2l/U6n9iroiVEhS/sWKjQdr02HAAFFu+Uy7qMjDMvtQHxOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFE4TYdu; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFE4TYdu"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee07570deso21314315e9.1
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 12:17:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769804253; cv=none;
        d=google.com; s=arc-20240605;
        b=HD26c+SlUCuqrxalFjCvjOraXT6O9wnHXf655UkeUivddqtVGaHj5ksmYdM/To4JKL
         4Y6Ew7JTu91i+oR11f+vTdD+v2uFx6zHnYS11bVd2A1LOIiqp0GFmZW9PiQ4JzMBPaVW
         bAzSC8AFloeXncOdPtOcPe6jrkg9zYjtOU4eaer3for3G89WD2yhES5O/xImnx5JPqB3
         ZNK5JU8KZJ+z1xTMUXwi7bQCtit+nET5Q3XcD3zZUMfNXoEJ2GYzb7/Jd/khKlB9i6QL
         avWRsEQTWkuACono1VsMrbIRYl2k/MZJ/TLoKj7B9GCLfAdXNrXw6sYHArgD3iaAqoiJ
         yehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kjr7bMIFo4y/rzwVSJirfBe5gxEvBTg8iQyuzOMiR0g=;
        fh=G7KIaXkZOukxMh5BaQjYSKohF/sYmfiVugxfsexzeBE=;
        b=iaJ+lFaAvZY6Blig/fLbUt/tvto322rc9q/cQ7AwjEu66J2sN4LtLDgrN+QmAE0t1t
         GAOy2KtDVwj1TP3H8xJi4HBU3W/ms/H6KEXEgilvPznccQmfoPWJtupLICfKoBw/OSvw
         6IsGWoXx5NewspHi7M2iW48aFQa25kOzJruxUU7PFZ3sDKZafRbwt5fVLWBtTu+zQ5gh
         Q6Ol8Ra9HWJJoX4FawxW5/eZYwvOMViDFAsCinnOvWK+Yo/VzN910Wsk2vGE9mEiW8SN
         k9Fd0qu5oFsnlRnYajcQHVeEvZvDZG3c4fYBpQRNWkHjXeiE0z2XMZL+2wADtK6tVXG6
         70Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769804253; x=1770409053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjr7bMIFo4y/rzwVSJirfBe5gxEvBTg8iQyuzOMiR0g=;
        b=dFE4TYdukKAO5wYrwVjiJBMEBYhjKKmjntFh+Fw3JsjYRpHjuv7ZcxuIsD4r8/SNyn
         6CYCw/5ooNGytTpVFkmOAY+Xuc7kUfSOd3DOQp2FDFLimvB7D1pYYLTkvbPpZmIdTYWP
         0SEypfxHJ/MqzrbzWwUm46G98vzESUzIfTgD8h+yEDGaHbG3g5/kuM1DQX4CKYdrcGbm
         rX7oHlvzr5YyDqmRJxNW0SeGuJ6TPATFyGt5lXpgx/4ZsDgFwjPk3f4lt5nio0SGXpag
         1Zv5wrJQSt8gNsqMvmGrftd+Vg6MCUxrm+SIBULFt/v+iR0a5GKaye51doO/iQPNutDL
         IvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769804253; x=1770409053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kjr7bMIFo4y/rzwVSJirfBe5gxEvBTg8iQyuzOMiR0g=;
        b=S40eFlPl0ICdWwdX2R8c90Ky9tGVX9cEfUAGV5ut3NFx0D3wNkASbX1dr4MKdR5YVj
         L/lsnzK8B9fIcIdUMHC5J64r8lIcoafffiwXPp4DOd7lKEKF2QdPrgcRL8ugVdgh4OHu
         RwQVCcZMC/jDJ0vW+kBHSMeK9KoACTGeGokwjJ/3NxRQBWH1Rk3PTOoT/Vj4EOt7JIjp
         sWzNSe/RuWq7iHaCTMhqek6io27opzb2axfSlP1SwILaim7Ud59mLUW42G2rxZCeaVRy
         yhoArLaQuo+AeFbSWkxi33iqZox8Xo59SugN/ePDRU2q65kv8Eb8dYKz6N0DP+5SPgV2
         4Ujg==
X-Forwarded-Encrypted: i=1; AJvYcCVyW56o7EK/V80REY/GhXeCFUhJwn7MHazEpmWheL3Ca73/nqP0uacGpM+L+zXz3deWPDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtmwE3BjFudRu8JMFZIPRoNjbKeD2UcjqZLmN3vhXPX5UDnrcO
	guzpseWhB9I0QtqT1KETxbliI1jbuR2GXOf++w5bdOhqQ4Hgsifz170u4LGwyUAqmaxWHfjiJwM
	HwJXusRVlAHDKLw4OlUguCT7hTW6R/a8Xupl9
X-Gm-Gg: AZuq6aKcuWmLR0HuIGfMuz7dBBs97GGiEJk6Tr7O4pSp4Oy9WNgIX5SYVvfk2rLmgM0
	OnCMOOTR3byKSWH4ScrQN+uJqYhZ5mPdc/aURn0d4C3YZRvpI1lvE8S2cy+whR4A59MrrToi+1F
	1j2P7E92TxLdUjB9qFDH/x0m2j+NsEy5xkxbHo+w3srpCKl/9ZkBZvvONUZqQA1D/dNnd/K0Tee
	4cGMBC84vHhlhtKJRUn3oz4l4RctQSFFsdgq8pL5MsVd23c3PP/jvRQ0iT1eq/1g/4FAKQ/U6j6
	U90l4qZzSNjeW0a3ONQQqpStKPLTZ3Xngx+pdYPZAUmcVIJmN52Mdbv/r92Dxyv1zOgVP3TrOg8
	9eEaOI4kLI4g/Cw==
X-Received: by 2002:a05:6000:1acc:b0:435:e451:2f93 with SMTP id
 ffacd0b85a97d-435f3ab4f75mr5973066f8f.60.1769804252984; Fri, 30 Jan 2026
 12:17:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130081208.1130204-1-jolsa@kernel.org> <20260130081208.1130204-2-jolsa@kernel.org>
 <CAP01T76RmkoJA+g=-Vr0mBvx29j8UjK_xg7VDwUR-FxtJbjnuA@mail.gmail.com>
In-Reply-To: <CAP01T76RmkoJA+g=-Vr0mBvx29j8UjK_xg7VDwUR-FxtJbjnuA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 30 Jan 2026 12:17:21 -0800
X-Gm-Features: AZwV_QiM-Q3Vh8Xa7yKijEZkB1UwCHRq1IX5wfjw6oG_oa9yJS5wZTPQsMFVJgE
Message-ID: <CAADnVQKRdbQCd-DKfQhfVPh=GxBThNfcVUnbkKTBY=b_u3rV7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow sleepable programs to use tail calls
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 9:35=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 30 Jan 2026 at 09:12, Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Allowing sleepable programs to use tail calls.
> >
> > Making sure we can't mix sleepable and non-sleepable bpf programs
> > in tail call map (BPF_MAP_TYPE_PROG_ARRAY) and allowing it to be
> > used in sleepable programs.
> >
> > Sleepable programs can be preempted and sleep which might bring
> > new source of race conditions, but both direct and indirect tail
> > calls should not be affected.
> >
> > Direct tail calls work by patching direct jump to callee into bpf
> > caller program, so no problem there. We atomically switch from nop
> > to jump instruction.
> >
> > Indirect tail call reads the callee from the map and then jumps to
> > it. The callee bpf program can't disappear (be released) from the
> > caller, because it is executed under rcu lock (rcu_read_lock_trace).
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/bpf.h   | 1 +
> >  kernel/bpf/core.c     | 4 +++-
> >  kernel/bpf/verifier.c | 1 +
> >  3 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 5524f9429e76..3b0ceb759075 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -287,6 +287,7 @@ struct bpf_map_owner {
> >         enum bpf_prog_type type;
> >         bool jited;
> >         bool xdp_has_frags;
> > +       bool sleepable;
> >         u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
> >         const struct btf_type *attach_func_proto;
> >         enum bpf_attach_type expected_attach_type;
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index e0b8a8a5aaa9..5ebece600aeb 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -2401,6 +2401,7 @@ static bool __bpf_prog_map_compatible(struct bpf_=
map *map,
> >                 map->owner->type  =3D prog_type;
> >                 map->owner->jited =3D fp->jited;
> >                 map->owner->xdp_has_frags =3D aux->xdp_has_frags;
> > +               map->owner->sleepable =3D fp->sleepable;
> >                 map->owner->expected_attach_type =3D fp->expected_attac=
h_type;
> >                 map->owner->attach_func_proto =3D aux->attach_func_prot=
o;
> >                 for_each_cgroup_storage_type(i) {
> > @@ -2412,7 +2413,8 @@ static bool __bpf_prog_map_compatible(struct bpf_=
map *map,
> >         } else {
> >                 ret =3D map->owner->type  =3D=3D prog_type &&
> >                       map->owner->jited =3D=3D fp->jited &&
> > -                     map->owner->xdp_has_frags =3D=3D aux->xdp_has_fra=
gs;
> > +                     map->owner->xdp_has_frags =3D=3D aux->xdp_has_fra=
gs &&
> > +                     map->owner->sleepable =3D=3D fp->sleepable;
>
> Sounds reasonable, but why not permit tail call of non-sleepable prog
> from sleepable prog?
> The problem is only if it's the other way around.

I think that needs deeper discussion.
sleepable only does rcu_task_trace while non-sleepable relies
on implicit rcu.
rcu_trace_implies_rcu_gp() is always true and this helper will
be removed soon,
but I would still consult Paul and think through the implications.

So I'm going to apply it as-is.
