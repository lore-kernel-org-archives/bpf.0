Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8BF41168C
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 23:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170229; cv=pass; b=uufs85HYUny5dyeXul0ua646fjdp0m3P1A/MGcE7Z9PRyZNoSfwy1IdKVgODe7v/OGGaMm0j5uf8bIOGn9uQcH76yKQ/AQxfIl5ZkERMLjrPtWHuSBNqCNgHKkfMFkdM1D+jaTHedK9L/eAp7k4etnVJSNmRczcKBU9xYR7/3J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170229; c=relaxed/simple;
	bh=ABAAaXUX4Zo3idMdV9H8U0Fk9vtYWfM1D8JZBPYbj6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoBlopbIiM0Kn8Zs+1ZD2NNweiO0AXdns/G+Flw60KOKVNrEI/yHTTgMRFf9AHRdvh6e5mqecKbilBLpsGvRbTbG4ix81z9Enbxj8hzJZLHiPkt09f49Y0ibYXz9UbcUVMFyAzLaeKF3LZZNi5Z3EgHTej/VuDxEaOLlsxfev3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5U3/RuZ; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5U3/RuZ"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso52160a91.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 16:43:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789170225; cv=none;
        d=google.com; s=arc-20260327;
        b=YkH8vuLK1HlBlVDLdGRWyPg34JFHu/XR4R2fo0g0OTPW/w4BF9dWuqRNZMYQVx3eCw
         AtFAfhnjXr0ZGKA9TgkSVD+ufq3h6PfK0Phjll+74aBTfijuRuXRih/pPYgxd1UVWLMv
         ACAbB7bIcnTO+MWfMlSlbehXZ1bwCMpNa1jANY7RPorI2vNGP1meaMriIa+w45LVRYJD
         6jn5/1sBjwNhlbtvMpS0+MT6XeS0LWnZqTYH0Ut3ztLmJujnBQZRZtO42/ksOWeoP8X6
         Bzz88NNoSQYnMjProonyiCc1yAcYKC+ArgWmVOY1xQSTW89onML+AWfVb3kbzfvqholO
         aYsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dMrlyHn4FEhPUv10QbGyZNDHAlTVgFLMMjpZSRIG094=;
        fh=SQ6kYaruJFMu/K8oC5XdUZJW1gDc9szMP3R5keuZHzY=;
        b=lrdkD5FE00NzXtpCgDZ1FMUvv8QBPNmkdyV3tivLlQeIx6YE5muhK+nfXwgzX3GYsy
         7dd6y3+T9zw2Z56hZjmnduQ0OOrM2xWNzOyjyVAIqTWDfKw0/pQC2JjkRb+Mgtr9dZhk
         /Kl5hTL3M9IDSjg+7YE4CIMfcVAgs1MSHHs4sSIuAF0cRuF5J/yX/QLiIaMpp7iO8XhJ
         rAlegQhZHaloBS/Zr79vmmtHoXpbQ/mkbTy32xLXeW2kH8ElAZui0m6m1ModPpKMnbWK
         fI0Es+SgoGn5cHVE/YSrPjbT7IaQghv/Ec+OrSUHBq/KibXUrgDVmSMsCdrnqB56oLfv
         e4tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789170225; x=1789775025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dMrlyHn4FEhPUv10QbGyZNDHAlTVgFLMMjpZSRIG094=;
        b=Z5U3/RuZiv8bYX0h67bZea+SQizdqzZx79TqoDfcNTFEIdQQ0x9eP0rH1lms74MXfR
         6rmZX1IechpOYAZsB2xfN3StgUrdew8HlM62SOte1tgl+50zKnhEY0wD+JuQU9WW0L7A
         S9Wwntypkjvn+rykLBd73aw6ff3LdbhkiKBSpEniGHF4yICUii5kKZxIbJDS5W0TGAUN
         sxJfaGmCOewvhtLi27TjwwdcCQfYoxlkaeZf6sT7af9BCWWwDS7yuFq9laqRx+KzAwx0
         bBtLWoB2MzooNcYbRA3tZ564VPE4wxLDlzK4SkUSngyMCX5BZZ568vMuFRA9MAkltu2P
         ADfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789170225; x=1789775025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dMrlyHn4FEhPUv10QbGyZNDHAlTVgFLMMjpZSRIG094=;
        b=m5RqObAM4YJCtQBTe6UwOE8yY/ySXrhsCs0LnnQiZgV69IA2MveKZvIQ9tAkNs06QR
         nYwvCWBHXzPgGG2NeN+TyOcBJXbfmmL6JWgJ2ZIPkRE4NwQxgPZsL8L/WKZ5AwczzS34
         1zQP8epkXc1IsZlj/SdqkdPaCbDKEY/V50CHueFIGp9DJBKOUvh7zapikpIWoFOMNPnw
         tkhBT/+fRJnEK38hqg9qAtKIBbsX2+Z0crnddChlcbcZknOKDNghnH/ht0Vq+B4eQunp
         kPBPMSRl8yZozdpLRMW6C4QBI4C3AOkBTt7MozCKZ57zdHDiIhCgHMDBObZp2xop9fwI
         SVUQ==
X-Gm-Message-State: AFuF++nB9K5PYzgPvW665B0OXCaeYHhelRGoqCJKL3VXJszw8UNyWYvr
	gx9EObHCnwz6WDEoCYJnN7tkyX5XEAPNjwCvniQ+IW09Nc2ndsFWLM4baxoGrEsXmJOlFzx+QD9
	x8kRCWkCncraP/CUFQl1tAlqa6AzR8jg=
X-Gm-Gg: AYBFou2mRWQ113tw4T3RvA/cJpG2wmIMKsVpDJxjIvmSDVkSnfk8yF0PnP3ctlWTTCi
	lOOc6GY8dRF8XMi6yo2/6X45uIqfdyW6C2dTlG1/CWhgbM3T5Iv5J1d5WIqtFfZKM0A9SX/WBV3
	fRlNNeL7RbmaaqqZ+kmuPDZmcAVoECFBCvuLfT55wQZRdgWyBd5TQPRg2xAVRISiLb4OpWu/nnn
	JpB1vUllIT2Z7Wx/zpo2QWizQtB8UokioWxpi0uDHPAtyPIaFkUHk2U9TFJoT66m18QzdY9Up4j
	PJUVUuwvtlM7xTN+n5pGGDIdkNJywxQtV8jReehh8h7vpGEgCsZoGhOUVgoL7LaejGvAgdufLN2
	65iYyQ3CqQ4wqLE5eAeq3RWOeyPYSnrJIFcVIF4cM8KjjyWw=
X-Received: by 2002:a17:90b:28cd:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-39d9b983602mr11474444a91.0.1789170225044; Fri, 11 Sep 2026
 16:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Sep 2026 16:43:32 -0700
X-Gm-Features: AcwNN1XF93GUNMJ7y4zdnQm8Wb29a3aaZztAFCg7-WRAPE_lZWwsFjXuByHP57Q
Message-ID: <CAEf4Bzaf9AMBUWQeUj1Uor8F7A-tOPpVMa-CjRB0MNH4zRHEeQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] libbpf: BPF program dynamic loading
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, martin.kelly@crowdstrike.com, 
	slava.imameev@crowdstrike.com, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:18=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> This series was originally posted in January 2025 [1] as
> a two-patch RFC introducing a per-program tri-state load type
> (disabled/auto/dynamic) to let large BPF applications load a subset of
> their programs lazily, after the initial bpf_object load.
>
> We looked at the object-wide opt-in flag Andrii suggested as a
> lighter-weight alternative to a per-program enum ("all programs may load
> later, opt in via bpf_object_open_opts"). Problem was that it collapses t=
wo
> states that need to stay distinguishable at the level of a single program=
:[2]
>
>   - a program that is not currently loaded but is *expected* to load
>     later, gated on runtime configuration; and
>   - a program that is *permanently* not going to load on this kernel
>     (e.g. it targets a symbol or struct field that doesn't exist on the
>     running kernel, or it lost out to an alternative implementation and
>     will never be used on this object instance).
>
> A per-program enum keeps that distinction where it belongs: disabled
> stays fully excluded from relocation/map-creation with isolated failure
> handling, auto is unchanged, and the new dynamic state is the only one
> that opts a given program into later loading -- without implicitly
> promoting every other disabled program in the object along with it.
>
> This v2 keeps the same programs and tests we originally proposed, and
> addresses two additional requests from Andrii [3]:
>
> 1. bpf_program__set_autoload() is converted from bool to the new
>    enum bpf_prog_load_type, so it remains source- and ABI-compatible
>    with the ~200 existing bool callers (false->0, true->1 already match
>    the enum's DISABLED/AUTO numbering), while becoming a thin forwarder
>    to bpf_program__set_load_type(). It intentionally continues to reject
>    BPF_PROG_LOAD_TYPE_DYNAMIC, to preserve its original on/off meaning --
>    dynamic load is only reachable through set_load_type().
>
> 2. A declarative way to mark a program dynamic-load-eligible from its
>    source, as an alternative to an imperative set_load_type() call, using
>    a new BTF decl_tag.
>
> Motivation:
>
> Security tools built on top of libbpf commonly ship as a single large
> BPF object containing many programs, only a subset of which are needed
> on any given system -- the rest are gated on optional features or on
> kernel/runtime capabilities that vary across deployments. For this class
> of application, per-program dynamic loading helps in two ways:
>
>   - it shortens the initial load, since only the programs actually
>     needed for the running configuration are loaded and attached up
>     front instead of the whole object; and
>   - it lets a single failing program be unloaded and possibly
>     reloaded (or a feature toggled at runtime) without tearing down
>     and reloading the entire bpf_object.
>
> Both reduce the time window during which the tool is partially loaded or
> inactive -- for a security tool specifically, that is also the time
> window during which the system it protects is unprotected.
>
> We have been running this with our internal fork of libbpf in production
> for about a year. Depending on kernel and configuration support, around
> 250 of our programs are potentially loadable on any given system; with
> dynamic loading, only around 90 of those are actually loaded by default,
> growing to the full 250 only when every optional feature is enabled.
> Cutting the default set of loaded programs from 250 down to 90 measurably
> reduces load time (we observed ~60% reduction in our own measurements),
> and since unload time scales with the number of loaded programs, it
> correspondingly shortens unload time as well -- which matters, since
> slow unload can delay system shutdown. We believe this functionality
> would benefit other libbpf consumers with similarly large, modular BPF
> applications.
>

we should try to use this functionality in veristat, see if it can
more cleanly replace clone-based solution we have currently.

>
> [1] https://lore.kernel.org/bpf/20250122215206.59859-1-slava.imameev@crow=
dstrike.com/
> [2] https://lore.kernel.org/bpf/CAOu3gNjg5vQ=3Dt0C5UmStNpK8zutFC7kcYTrKt9=
aiR8Gia+rdNw@mail.gmail.com/
> [3] https://lore.kernel.org/bpf/CAEf4BzZKy5Wv_TxtEqsbzW+v-tO28kgY=3D9RhXr=
nbPhOZcVbOSA@mail.gmail.com/
>
> Andrey Grodzovsky (2):
>   libbpf: Convert bpf_program__set_autoload() to load-type enum
>   libbpf: Support declarative dynamic load via BTF decl_tag
>
> Slava Imameev (3):
>   libbpf: BPF program load type enum
>   libbpf: BPF programs dynamic loading and attaching
>   selftests/bpf: Cover BPF program dynamic loading
>
>  tools/lib/bpf/bpf_helpers.h                   |   5 +
>  tools/lib/bpf/libbpf.c                        | 273 ++++++++++++++++--
>  tools/lib/bpf/libbpf.h                        |  32 +-
>  tools/lib/bpf/libbpf.map                      |   4 +
>  .../selftests/bpf/prog_tests/dynamicload.c    | 222 ++++++++++++++
>  .../selftests/bpf/prog_tests/load_type.c      | 167 +++++++++++
>  .../selftests/bpf/progs/test_dynamicload.c    |  40 +++
>  .../selftests/bpf/progs/test_load_type.c      |  31 ++
>  8 files changed, 741 insertions(+), 33 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/dynamicload.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/load_type.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_dynamicload.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_load_type.c
>
> --
> 2.34.1
>
