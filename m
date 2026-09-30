Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7A3501F4B
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783430; cv=pass; b=lxo8k4Qfk5cFOx82A4AZE3+ywc+0FT/7oLlomWvxBMDEleyMe6li0H2IMYNUl5UPn0oQ5q+6z4Vnz00bRLkJcFHqZA686PdlZGD2rt8jZ0PGwUqeSTCFy0hDrL0ufj8AARshxXCDfs4tuKuKN6wUfFyh7JFsE5iIm/SFriwv1Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783430; c=relaxed/simple;
	bh=MGEEDlAviJWzJVDzCtT4Hh+IMtnckaCWBgZMBB0Y33U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0ItwRmzyUfrSHBW37/ruKXYDAsdliRA4PFkGXzU0DvxvoVh7HUegvaYhvkWiKqbB38MtKtGwe3Z/G/s+2aT8kMd+xOfKNXrREW9kXleGGpqg4e3yNkHJl3sQ/OlkIiwOf/cLLZRz3Tz1fybeKmhYQ3an0FPvHM29LPFtAg8LS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwhBi/NJ; arc=pass smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwhBi/NJ"
Received: by mail-pj2-f40.google.com with SMTP id d9443c01a7336-2e2a68e185cso22388445ad.0
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 08:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790783424; cv=none;
        d=google.com; s=arc-20260327;
        b=NeTF6gXydXzIL2QBzKE+0pfcSQaDCpuoNxFTsR2aaZVsOM/1P6olwN0WX7Kku3ZsiP
         RBUQ6Hj+IiV4YV1i/olFYqqY9Ie1TcpGiMPvyaik4r9QsdWpkEQ0nNpesgXU4bd2lJDx
         oyn5B3/o56TvQNo80svBUXeQ6QPRYPAuYLNROuH2hLiQGmPcaCsnYcD2xnbK9BLjbb54
         FmSmIhyGDZR17XFCK+avQnrLpfEwZf593hrwLfL5ce16yzVOhbeD6EF2sMvBAb4EIjts
         y3Buf6aJzIp34bOMJ6+3cNHDK8/LUfpSE177ofufvWCJlF48nijHCwz/fKwdv84YIyqB
         BSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ucGUlGsrjTLmfc/7H3rjC0J9lwNsLbGeuxbXDPKFbW0=;
        fh=Oe1vk+f+al8tefZHhxSif7dLRPP1/DLWo2CzbDJvjrA=;
        b=cnN3iRq1LDDHYEc+zPeniUFje2sHrgUnirGwze9eoNdOSW3ZL7BW2rZQsYwyYs7F1D
         Uv6unWI15cAxMOGyrxDFfIbAMWCgYyWYIbEvR1dlRx1F0wLA/B5wo6L6O0RpbqN5yB4L
         VmP/Ru8LjEF+v4Y+KEx6kC5WswCu0CUjGGk0ePiimdfHHv2I7oEo+FGGohfkB5ocjrbc
         nAMW8LCPpE8zb/NLFQ9uYWw+h2ZShQNKpSAknXdbNU71lylRO+vsV7I+zlAReHOlXG5+
         klnSf8D2fmGaBodW4Rvss9niqb7Mqictt86hwvBOAqqWefr6767E628fCPociReFgc3F
         +dLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790783424; x=1791388224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ucGUlGsrjTLmfc/7H3rjC0J9lwNsLbGeuxbXDPKFbW0=;
        b=UwhBi/NJno+rQhYq6ncbjbQMA7jN+SdKmwKkBlSriNV3kKx85taqVxpTR2sXXjcDFr
         buNI0s9xDqDQkCzZ74OPlErRkoynSRgkerIYX8vksaGfZJlYW21LYas2+BKvBj5T4d62
         pnKomDxh7iXlcgDvonL02ihcGOpyzZ7L7bIzvlhO/XsI/JP85sSGuxvt9jSHa1Nqxkp8
         y5DmUK40GMK+/QXJfL5pNTPoN5k7sa8kefa4maOH3kyipxa2QC5Jik1mKwM/HM/u9Tx0
         6ZKkTRxGjH+WB8gze/Y03vQQQoPHe1/U9xihDuVDrVaWZO/2VjkmCol2lgcvP4OuCw7Q
         RU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790783424; x=1791388224;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ucGUlGsrjTLmfc/7H3rjC0J9lwNsLbGeuxbXDPKFbW0=;
        b=lw1CGBbgRyUGisxVeLIZKtx1LNSqXBiYy2ifBtc9aGzuhK5QLl+LzluwYqmc/0cUkG
         2WGyH0Nc6yMWWVTiC4l5WJ4gn/+0TqB4mQe7/7ATvAglQmNSKZCdwR4zBaScxQ6QIt1l
         3tA7E8aMDPzifnBpRKnd9TeZBSJiRI3FxyoLbGxl4xzHcGhenulwUMTaTAa/kXeTUQQK
         ZUvKKLuD4DXotrZHJ8pM+vEOvmaeCoqAMlxk6eCR0Qi101/nR+BleS+rO7HfX6tBrkfS
         pd7SsV2L5csxhvDPgLRR05yfbBhfNukxEwNR5vnwpjNw92FfJGq7NAvWWHlDLndFTpZR
         hRYg==
X-Forwarded-Encrypted: i=1; AKwUvBzfgDE223LjLv3+YJ8VoYyinPJyUYDKv1qYRRVgg6aUqdTtcUCnq3GEvvdE8i27yAHc6MI=@vger.kernel.org
X-Gm-Message-State: AFq9FYILhobwAoKfr19rSrsNLsMrwBhe2j9Oiqp+g1EkG1ZsB+clikg8
	rRMQWQAZtfxKxM/dZ8PxH8rySr9gONZsl+qDWOVSwxhqBYQEvfyy6+gyXItDMPBOdpBkiCleNDC
	jEkgiN8UL56Xe8RsemVCQiMAEUgLAuoI=
X-Gm-Gg: AYBFou1vLJY0eZHA5jqcjjy2ROeDs+K8xUqiDWpmxnt2Ggi8xftsDmkPvrMsnIhM/w6
	Y4+QmHH29D1HY5Tx6hfsQE2i8OHynskJ+T3BPM2aMwIvEpU9sXx9qd8vdrcnihuUtc6iwyx0SwM
	yOxlLk8IyT4PngM7qr0bWpmemPWEjjaCAJ7Y8pLr38rdJU0sB2jA3yQhaEFmq8S/zXlO3sA0NxG
	VHpnyDGnMBRN8U8ejbiN6cBWjt9d3rw1CVGMtAutrrJwxzW+aC0bGxZ9s18iLsiBx/PctDmAD6b
	I2Xa/bwPAofplsD3xySVSMC47Pg0by36Vb4U6IOtvchBTQjp/UpDdjbNjswYnzkoBYg2jwZuYkT
	kW+g/T7H/eUL9TkrQmZPme8S8SsJlAhWcwtM=
X-Received: by 2002:a17:902:e945:b0:2da:f1b1:56c4 with SMTP id
 d9443c01a7336-2e2e4910065mr16379285ad.3.1790783424140; Wed, 30 Sep 2026
 08:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923232939.1886328-3-andrey.grodzovsky@crowdstrike.com>
 <68df9eab1022e5ac30007383b6f5a85dc6d7c9884edccc5f4c84cdeb9b32d427@mail.kernel.org>
 <CAOu3gNi-Vo=k6Xih9ywJ0wji=JZeNbFnNkV1fmRQU5Mk8WGd1A@mail.gmail.com>
In-Reply-To: <CAOu3gNi-Vo=k6Xih9ywJ0wji=JZeNbFnNkV1fmRQU5Mk8WGd1A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 30 Sep 2026 08:50:11 -0700
X-Gm-Features: AclHuK9IjrTJRp41bgRz2MOFqkd3cCcgG9kVSGbceZNn0ZXHItXtNDXFsjsKorM
Message-ID: <CAEf4Bzb9R13zs1Rcv2kOwDvgGFcXLgijwa-a323oZYytrtNUUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/8] libbpf: BPF programs manual loading and attaching
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, andrii@kernel.org, 
	ast@kernel.org, martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com, 
	linux-open-source@crowdstrike.com, daniel@iogearbox.net, 
	martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:41=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> On Wed, Sep 23, 2026 at 8:32=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index a3085847cb97f..939f0d6378e38 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> >
> > [ ... ]
> >

[...]

> >
> > So this sequence:
> >
> >     bpf_object__prepare()
> >     bpf_program__load(p)    // ok, insn_array->used =3D 0 -> 1
> >     bpf_program__unload(p)  // just zclose(prog->fd)
> >     bpf_program__load(p)    // -EBUSY, insn_array->used still 1
> >
> > fails verification with "Failed to properly initialize insn array". The
> > map and its 'used' state live on in obj->jumptable_maps until
> > bpf_object__close().
> >
> > Would libbpf need to recreate the jump-table maps (and re-patch insn->i=
mm)
> > before each manual load, or should this limitation be rejected or
> > documented?
>
> This is indeed an issue, but not specific to our manual loading progs.

yeah, I don't think you have to address this limitation. that second
load does really violate exclusivity, so...


> I was able to reproduce a pretty similar behavior using the exsiting
> bpf_program__clone() interface by writing a test for the recently
> added "Indirect call of bpf subprog" feature by Alexei [1] - I
> prepared and cloned a program which calls function by a func pointer
> from a table, first clone worked fine, while the second generated the
> failure + kernel log below.  Another test also verified that
> subsequent bpf_object__load()  after the first clone also failed with
> same error.
> I wasn't able to run the gotox scenario since my LLVM didn't support goto=
x.
>
> dynamicload_verify_callx_clone_twice:PASS:bpf_object__prepare 0 nsec
> dynamicload_verify_callx_clone_twice:PASS:callx_clone_first 0 nsec
> callx_clone_second: clone failed: -16
> -- BEGIN KERNEL LOG --
> map 'test_dyn.rodata' has addresses of functions of another program
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> -- END KERNEL LOG --
>
> So I am not sure we should look for and reject all those types of
> cases where the first loaded program captures a map exclusively, given
> that the first load will work normally.  Perhaps document it....
>
> Andrey
> [1] - https://lore.kernel.org/bpf/20260922011323.1298619-11-alexei.starov=
oitov@gmail.com/
>
> >
> > > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > > index e7255bd4247f7..faea42f758479 100644
> > > --- a/tools/lib/bpf/libbpf.h
> > > +++ b/tools/lib/bpf/libbpf.h
> > > @@ -392,7 +392,7 @@ LIBBPF_API const char *bpf_program__section_name(=
const struct bpf_program *prog)
> > >  LIBBPF_API bool bpf_program__autoload(const struct bpf_program *prog=
);
> > >  LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, b=
ool autoload);
> > >  LIBBPF_API bool bpf_program__autoattach(const struct bpf_program *pr=
og);
> > > -LIBBPF_API void bpf_program__set_autoattach(struct bpf_program *prog=
, bool autoattach);
> > > +LIBBPF_API int bpf_program__set_autoattach(struct bpf_program *prog,=
 bool autoattach);
> >
> > The return type of the public LIBBPF_API bpf_program__set_autoattach()
> > changes from void to int, but the symbol stays in its original
> > https://urldefense.com/v3/__http://libbpf.map__;!!BmdzS3_lV9HdKG8!zC1AT=
niphW52dqH2YnKa3C_GBu6XJsWup4Mbx4WwxlDc2udDHlre3KohEAG5kA8e6eh0iQUU_SXCP148=
DhevtSg6kBnoMe4M$  node. This is source compatible, but callers that ignore=
 the
> > result cannot tell that the call was rejected for MANUAL programs, and =
the
> > ABI of an already exported symbol changes without a new version node.
> >
> > Note: This is fixed later in the series by fca8106ae09c7 ("libbpf:
> > Version bpf_program__set_autoattach() ABI change").
> >
> > > diff --git a/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.=
map__;!!BmdzS3_lV9HdKG8!zC1ATniphW52dqH2YnKa3C_GBu6XJsWup4Mbx4WwxlDc2udDHlr=
e3KohEAG5kA8e6eh0iQUU_SXCP148DhevtSg6kBnoMe4M$  b/tools/lib/bpf/https://url=
defense.com/v3/__http://libbpf.map__;!!BmdzS3_lV9HdKG8!zC1ATniphW52dqH2YnKa=
3C_GBu6XJsWup4Mbx4WwxlDc2udDHlre3KohEAG5kA8e6eh0iQUU_SXCP148DhevtSg6kBnoMe4=
M$
> > > index 03c3d2bd15bf4..8def5474885a8 100644
> > > --- a/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!=
!BmdzS3_lV9HdKG8!zC1ATniphW52dqH2YnKa3C_GBu6XJsWup4Mbx4WwxlDc2udDHlre3KohEA=
G5kA8e6eh0iQUU_SXCP148DhevtSg6kBnoMe4M$
> > > +++ b/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!=
!BmdzS3_lV9HdKG8!zC1ATniphW52dqH2YnKa3C_GBu6XJsWup4Mbx4WwxlDc2udDHlre3KohEA=
G5kA8e6eh0iQUU_SXCP148DhevtSg6kBnoMe4M$
> > > @@ -463,6 +463,7 @@ LIBBPF_1.8.0 {
> > >               bpf_program__attach_tracing_multi;
> > >               bpf_program__clear_flags;
> > >               bpf_program__clone;
> > > +             bpf_program__load;
> > >               bpf_program__load_strategy;
> > >               bpf_program__set_load_strategy;
> > >               btf__find_by_name_kind_own;
> >
> > The commit message refers to bpf_program__load_manually() and
> > bpf_program__unload_manually():
> >
> > >     A manual-strategy program is loaded via bpf_program__load_manuall=
y()
> > >     and unloaded via bpf_program__unload_manually(), gated on
> > >     bpf_object__prepare() having already run (BTF loaded, maps create=
d,
> > >     relocations applied) rather than requiring a full bpf_object__loa=
d().
> >
> > Neither function exists. The patch actually adds bpf_program__load()
> > (exported in LIBBPF_1.8.0) and changes the existing bpf_program__unload=
()
> > so that it only closes the fd for MANUAL programs. The message also lea=
ves
> > out the user-visible change to bpf_program__set_autoattach(): it now
> > returns int and rejects MANUAL programs.
> >
> > In the v1 review thread, Andrii Nakryiko expressed concern about adding
> > complexity to bpf_object internals:
> >
> > > I don't want to complicate bpf_object internals with this third
> > > autoload state, as this creates tons of non-obvious gotchas that have
> > > to constantly be checked whenever any new feature is added to
> > > bpf_object (or even during refactorings).
> >
> > From: https://urldefense.com/v3/__https://lore.kernel.org/bpf/CAEf4BzYW=
e0KCzA4-qwAGp5n_ydJ0_zyLSO=3DCrr_vewFHzZ0t6Q@mail.gmail.com/__;!!BmdzS3_lV9=
HdKG8!zC1ATniphW52dqH2YnKa3C_GBu6XJsWup4Mbx4WwxlDc2udDHlre3KohEAG5kA8e6eh0i=
QUU_SXCP148DhevtSg6kHoTp1qY$
> >
> > While the patch has been revised to use bpf_object__prepare() as Andrii
> > suggested, does the implementation still add significant complexity: ne=
w
> > state tracking (has_manual_progs), modified cleanup logic with force
> > parameter, complex state machine logic for load strategies, and deferre=
d
> > BTF/fd_array cleanup?
> >
> > Also, for subsequent submissions, Andrii requested the [PATCH bpf-next]
> > subject prefix in the v1 review.
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://urldefense.com/v3/__https://github.com/kernel-patches/vmte=
st/blob/master/ci/claude/README.md__;!!BmdzS3_lV9HdKG8!zC1ATniphW52dqH2YnKa=
3C_GBu6XJsWup4Mbx4WwxlDc2udDHlre3KohEAG5kA8e6eh0iQUU_SXCP148DhevtSg6kIlMmsx=
Y$
> >
> > CI run summary: https://urldefense.com/v3/__https://github.com/kernel-p=
atches/bpf/actions/runs/35934836796__;!!BmdzS3_lV9HdKG8!zC1ATniphW52dqH2YnK=
a3C_GBu6XJsWup4Mbx4WwxlDc2udDHlre3KohEAG5kA8e6eh0iQUU_SXCP148DhevtSg6kMF5-R=
GT$
