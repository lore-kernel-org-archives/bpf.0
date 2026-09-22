Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B9B568557
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094997; cv=pass; b=INuQHyujO0R/HC0tDZFDPz9+I3PXLb0+pTW+GiIf+vmNjymGqyYfKHF76NG0BbYACkb53xlNx9exyYvcqNdn/CjGvehNNVBH5i1/Z6UjTXiAqebCJ7pfHNnc1v9s3ITYu0ElpKM+anDstesGkY7AJrFXpSQJtm//WOhOnOrA03w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094997; c=relaxed/simple;
	bh=NeSJZI3oPqghVoi5QjfHHkj2vxIpir+t2ebsWjtQAAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sm5KiefZTNQC3x56TIFZ3Ji9AHYZtkUrgbIcsyZqU8sPFlf00Z2KFbGvg9KOsXavuIKCVR4RF0za//Xm1VXXXNWN145r8vD1hif8hI72Q2SAsM8059X2o7UzU9Ai8PKqH7XrpPvoVSg4D1zyMww5ep/1YdGudww/hQ8KjBf0YcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBHNN11u; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBHNN11u"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso99091a91.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 09:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790094989; cv=none;
        d=google.com; s=arc-20260327;
        b=YZf4IJ+udZIp9H6n+P8/6eamO5KcBjfpSR10EEVgTM3yS2Un42JgezsRTf6BMU3mgz
         40FmufH+LaAnlfr9Z1k3mq2QA9TXx94TaT7TJarzKglMikN36ASIjkNO0ZavPk7D1bXe
         wpCvZgjhbclT9LDhDJCkmRIHVqQ04Sma+I8/oDROxhP4Kn4iinAVpEbDRtFN7SJBcsP3
         GhaN9JCQgIGW5H+ek7XYk4lKUZS2UK1GV4DPo5slzCIZq7bhAy0v59y1tAs/fCSzEmRo
         V/IaHLt+vNIfOsWeQbF7RyYILrREJb6z3hKH00AVrOKntmKlz9hytLYz5u5deGuaZ40T
         PfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qECaZyvnXUWUfKoiPQWY74ksiGs88KXuCBZpaqYNDUk=;
        fh=of7HkGW75BjO+JJ/pfuZpVxZlnSJP9Z/VpxTygr225o=;
        b=EE3w+IaWOWrHk6rFNRS9AFmOpIpY3xDYPBifJcfXd0yWECbO49E10+Y4+Vywr+0JjA
         p1YEPUeO+9SGuFw0XAfzmcvpAyT06DsaWJw5wFqtgcLgvAlsCFQseZUr755cHXaHPxh6
         g+YlRuCGPztlHwC98PVbA1Qe9IzvfWyRnAkHBt5f1yWxrDj0BKshm/wNeaj9QkomN+aT
         2YSlh/XAuOBr5IoOmLTeFkeKVY6VVxFr1wQt1inQnXCvWngWYt55z/W6ymMOOmjlr5yq
         gaFw5V6W1JcAhqSPzbIM3LUTGnPh3vuK/GFSFXw++hsI2p39R64n6P9wqPg1AgzY6Zqw
         AaLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790094989; x=1790699789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qECaZyvnXUWUfKoiPQWY74ksiGs88KXuCBZpaqYNDUk=;
        b=FBHNN11uPObAR0hp6uDak2FjcsPXan9zl2WuMzTEUTC1Rb44uUwkIGX0Ymdpxh1kbL
         QERnmgULxAAUYxVMeC1B4dNaULCcudTKqsfyuu3RbCvjwm4w1oAT7DpFg5tNaGp1rHGX
         EbAFf/ldLpBdbMfd+kx4raGZjlkiFkLxVb2J4KZO+qgdPV21FXG1a6ddRGFivSe7WRVX
         Mpbfd+atUsEaIO/tv/eW5TJB6foLUEzPbubO+VSLT8CWXVeb5BCXypjm68GvoUKLiIyN
         z0v8DP91C+MOwsjtju0kw+OMZfvlWo7Bv0MFRwDiykQ18WdbWjI8zwAYUpGxATY246dJ
         HTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790094989; x=1790699789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qECaZyvnXUWUfKoiPQWY74ksiGs88KXuCBZpaqYNDUk=;
        b=XKWdiF8yO+CY9ff4Yo+T0OqmIcs16phQLavEBzMzX4qEiXlsnJtaa4NK7lKq486Xnn
         GQL6KsqDJIxHZpcn63RahRW6GdRGDsYsbMVPZ4bJ+zjgFhEIuGzcTYLuJQDU/TrNth7s
         kua8WYmJZpN3hcG4Sa3+QurZPwYPvYuIZbJ0EcuT8V5RmThqNcWjgnfk8Eaa6lhG7RyD
         p6/GfKQLyq5HmGKJ4jrg8co6sY7teB7GN4ek/rslcK4lenLU2jAci1Ah3cNm0ZPI3quV
         GZp8J+C3EQkU37qq3w8l9IbdddqJ2edpaRRDLRi05K3GUcvro7g9gyd1IsWDU/FcnHSE
         lCAw==
X-Forwarded-Encrypted: i=1; AKwUvByZugaCUqGFSTAGpWyQg3nqqSSQt1Zw4E/nPikmBfIhNEXieTxkKs2PSxZPT90hjXphCiU=@vger.kernel.org
X-Gm-Message-State: AFuF++mOVls2KgOZN3I1g/Vc6UUI4R7D5UAFdxJ/gY47iV2FOqHN1+lE
	qiSSXcNIBeBbA7NX+UayUJoNOD76Sr7fz71AThvyyWuiynmjyyQeUG9yd30oKt91D5Ni4+gmScB
	ydWK/p2B6ls2kSItpYE+bqQGw5xAOIbs=
X-Gm-Gg: AYBFou3zA1gcVXvUKIoxV7GsNJR8/Kle8YNVfrFo1DbciWdCKES8/qGS5IRAUSAkngB
	lr5EiX96iFPOSW+5N+TX1QNyDegFevuqWHsTiOPCrKllRIBFUvIZHWLANqGLGFS4y4OKaIqmY/D
	NuUHytNxtwD/JqP+lQKxEz5irHSOTwuMV9Hvjj2/DbQ6BERfxfuwZ2fG3+I5dWSv/vbycu4/W0d
	k0VllquyZ+FqsrqDAvtlByOrl4sze7RAobxTPPIfAq7dtt0Npsc8iDs32e+ImhNednXA1mfoJRG
	UvOzxH5Nh3+9cNvnjzMRNd2LKn9sKe9nam/RBnWLZ2YBSmD4gmePyBeJCGuSXMqYELHc2p5cNmW
	UbGJ9sv8YgPijy0AicWEnUw4gyy82XRdTCoXMsg4iRD8N+SBlpX0IYA==
X-Received: by 2002:a17:90b:4983:b0:39e:4498:4863 with SMTP id
 98e67ed59e1d1-3a07e562326mr31241a91.10.1790094989333; Tue, 22 Sep 2026
 09:36:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
 <CAEf4Bzaf9AMBUWQeUj1Uor8F7A-tOPpVMa-CjRB0MNH4zRHEeQ@mail.gmail.com>
 <CAOu3gNhjPamqZgcxBj7Sgmr+B76qPC+O1hdWg7dY3uNuat+UMA@mail.gmail.com> <CAOu3gNhbz0m7=cPAAD-NWPix-TCL7B3iFFTHn1JzaaukAXP3oQ@mail.gmail.com>
In-Reply-To: <CAOu3gNhbz0m7=cPAAD-NWPix-TCL7B3iFFTHn1JzaaukAXP3oQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Sep 2026 09:36:13 -0700
X-Gm-Features: AcwNN1UUfvf7f-s154WrS6BWxUGu-Z1KQn0024w1ZxHUrU4yFEpvCff_Bh_sOtY
Message-ID: <CAEf4BzYiZ8ynXYCybu7axhBM9iv_KgkMWQcvL9nGGXRT2i05Zw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] libbpf: BPF program dynamic loading
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, andrii@kernel.org, 
	martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com, 
	linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 5:49=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> On Wed, Sep 16, 2026 at 8:45=E2=80=AFPM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > On Fri, Sep 11, 2026 at 7:47=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Aug 26, 2026 at 11:18=E2=80=AFAM Andrey Grodzovsky
> > > <andrey.grodzovsky@crowdstrike.com> wrote:
> > > >
> > > > This series was originally posted in January 2025 [1] as
> > > > a two-patch RFC introducing a per-program tri-state load type
> > > > (disabled/auto/dynamic) to let large BPF applications load a subset=
 of
> > > > their programs lazily, after the initial bpf_object load.
> > > >
> > > > We looked at the object-wide opt-in flag Andrii suggested as a
> > > > lighter-weight alternative to a per-program enum ("all programs may=
 load
> > > > later, opt in via bpf_object_open_opts"). Problem was that it colla=
pses two
> > > > states that need to stay distinguishable at the level of a single p=
rogram:[2]
> > > >
> > > >   - a program that is not currently loaded but is *expected* to loa=
d
> > > >     later, gated on runtime configuration; and
> > > >   - a program that is *permanently* not going to load on this kerne=
l
> > > >     (e.g. it targets a symbol or struct field that doesn't exist on=
 the
> > > >     running kernel, or it lost out to an alternative implementation=
 and
> > > >     will never be used on this object instance).
> > > >
> > > > A per-program enum keeps that distinction where it belongs: disable=
d
> > > > stays fully excluded from relocation/map-creation with isolated fai=
lure
> > > > handling, auto is unchanged, and the new dynamic state is the only =
one
> > > > that opts a given program into later loading -- without implicitly
> > > > promoting every other disabled program in the object along with it.
> > > >
> > > > This v2 keeps the same programs and tests we originally proposed, a=
nd
> > > > addresses two additional requests from Andrii [3]:
> > > >
> > > > 1. bpf_program__set_autoload() is converted from bool to the new
> > > >    enum bpf_prog_load_type, so it remains source- and ABI-compatibl=
e
> > > >    with the ~200 existing bool callers (false->0, true->1 already m=
atch
> > > >    the enum's DISABLED/AUTO numbering), while becoming a thin forwa=
rder
> > > >    to bpf_program__set_load_type(). It intentionally continues to r=
eject
> > > >    BPF_PROG_LOAD_TYPE_DYNAMIC, to preserve its original on/off mean=
ing --
> > > >    dynamic load is only reachable through set_load_type().
> > > >
> > > > 2. A declarative way to mark a program dynamic-load-eligible from i=
ts
> > > >    source, as an alternative to an imperative set_load_type() call,=
 using
> > > >    a new BTF decl_tag.
> > > >
> > > > Motivation:
> > > >
> > > > Security tools built on top of libbpf commonly ship as a single lar=
ge
> > > > BPF object containing many programs, only a subset of which are nee=
ded
> > > > on any given system -- the rest are gated on optional features or o=
n
> > > > kernel/runtime capabilities that vary across deployments. For this =
class
> > > > of application, per-program dynamic loading helps in two ways:
> > > >
> > > >   - it shortens the initial load, since only the programs actually
> > > >     needed for the running configuration are loaded and attached up
> > > >     front instead of the whole object; and
> > > >   - it lets a single failing program be unloaded and possibly
> > > >     reloaded (or a feature toggled at runtime) without tearing down
> > > >     and reloading the entire bpf_object.
> > > >
> > > > Both reduce the time window during which the tool is partially load=
ed or
> > > > inactive -- for a security tool specifically, that is also the time
> > > > window during which the system it protects is unprotected.
> > > >
> > > > We have been running this with our internal fork of libbpf in produ=
ction
> > > > for about a year. Depending on kernel and configuration support, ar=
ound
> > > > 250 of our programs are potentially loadable on any given system; w=
ith
> > > > dynamic loading, only around 90 of those are actually loaded by def=
ault,
> > > > growing to the full 250 only when every optional feature is enabled=
.
> > > > Cutting the default set of loaded programs from 250 down to 90 meas=
urably
> > > > reduces load time (we observed ~60% reduction in our own measuremen=
ts),
> > > > and since unload time scales with the number of loaded programs, it
> > > > correspondingly shortens unload time as well -- which matters, sinc=
e
> > > > slow unload can delay system shutdown. We believe this functionalit=
y
> > > > would benefit other libbpf consumers with similarly large, modular =
BPF
> > > > applications.
> > > >
> > >
> > > we should try to use this functionality in veristat, see if it can
> > > more cleanly replace clone-based solution we have currently.
> >
> > I will look into this, in my next patchset iteration, I moved (by your
> > suggestion)  the gating for manual loading from OBJ_LOADED ->
> > OBJ_PREPARED, this at least according to code review should allow
> > this. I will dig deeper into it.
> >
> > Andrey
>
> Following on this - I  swapped bpf_program__clone() for
> set_load_strategy(MANUAL) + load_manually()/unload_manually() in
> veristat's process_obj()/process_prog(). Builds clean, test_progs -t
> veristat passes.
>
> One isue spotted : load_manually() calls bpf_prog_bind_map() for
> RODATA maps on every load (via bpf_object_load_prog()), which clone()
> deliberately skips to avoid mutating object state and Mykyta even has
> explicit comment about wanting to avoid this. Since veristat loads
> each program individually, shared RODATA maps now get bound on every
> load. But they also get unbounded once we unload the program (drop its
> FD).
>

that's fine to do, binding map to a program that will be soon unloaded
is absolutely ok

> Andrey
>
> >
> > >
> > > >
> > > > [1] https://urldefense.com/v3/__https://lore.kernel.org/bpf/2025012=
2215206.59859-1-slava.imameev@crowdstrike.com/__;!!BmdzS3_lV9HdKG8!1zjO5-1C=
VIChpj-ePa0a0tLxU67BvclwUXzHIWVFj9j9rj9WraXxTZW7Bumk_isDyjBPDLExnfctIUG_V2A=
Tbp4Ecz6a8j3WfggToQ$
> > > > [2] https://urldefense.com/v3/__https://lore.kernel.org/bpf/CAOu3gN=
jg5vQ=3Dt0C5UmStNpK8zutFC7kcYTrKt9aiR8Gia*rdNw@mail.gmail.com/__;Kw!!BmdzS3=
_lV9HdKG8!1zjO5-1CVIChpj-ePa0a0tLxU67BvclwUXzHIWVFj9j9rj9WraXxTZW7Bumk_isDy=
jBPDLExnfctIUG_V2ATbp4Ecz6a8j29k6Njrg$
> > > > [3] https://urldefense.com/v3/__https://lore.kernel.org/bpf/CAEf4Bz=
ZKy5Wv_TxtEqsbzW*v-tO28kgY=3D9RhXrnbPhOZcVbOSA@mail.gmail.com/__;Kw!!BmdzS3=
_lV9HdKG8!1zjO5-1CVIChpj-ePa0a0tLxU67BvclwUXzHIWVFj9j9rj9WraXxTZW7Bumk_isDy=
jBPDLExnfctIUG_V2ATbp4Ecz6a8j2Xo62azw$
> > > >
> > > > Andrey Grodzovsky (2):
> > > >   libbpf: Convert bpf_program__set_autoload() to load-type enum
> > > >   libbpf: Support declarative dynamic load via BTF decl_tag
> > > >
> > > > Slava Imameev (3):
> > > >   libbpf: BPF program load type enum
> > > >   libbpf: BPF programs dynamic loading and attaching
> > > >   selftests/bpf: Cover BPF program dynamic loading
> > > >
> > > >  tools/lib/bpf/bpf_helpers.h                   |   5 +
> > > >  tools/lib/bpf/libbpf.c                        | 273 ++++++++++++++=
++--
> > > >  tools/lib/bpf/libbpf.h                        |  32 +-
> > > >  tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!Bm=
dzS3_lV9HdKG8!1zjO5-1CVIChpj-ePa0a0tLxU67BvclwUXzHIWVFj9j9rj9WraXxTZW7Bumk_=
isDyjBPDLExnfctIUG_V2ATbp4Ecz6a8j2Lf3q1jA$                       |   4 +
> > > >  .../selftests/bpf/prog_tests/dynamicload.c    | 222 ++++++++++++++
> > > >  .../selftests/bpf/prog_tests/load_type.c      | 167 +++++++++++
> > > >  .../selftests/bpf/progs/test_dynamicload.c    |  40 +++
> > > >  .../selftests/bpf/progs/test_load_type.c      |  31 ++
> > > >  8 files changed, 741 insertions(+), 33 deletions(-)
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/dynamicl=
oad.c
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/load_typ=
e.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/test_dynamicl=
oad.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/test_load_typ=
e.c
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > >
