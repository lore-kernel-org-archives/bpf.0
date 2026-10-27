Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793125299;
	b=kFClyEIEbrLYqnn1fg4HF4vR9NR1rdG5h3kbeuM0aMFVxU52UVNjA2WWMkbAFnERGGpQ
	 2O0vGL6zZBug7XMkoNi93lGIwwhKS1AMTY9HiSl26Spxz+XE8fhDywkVS10A0K+Iltbpm
	 KAcBc6wTQJRdYr1ruGfSmdNwP087PLzypF8JUoDG2vXZe6wCpoa2DcsW0Cdfi4o6uykxw
	 N3Y4D5BF8H+5Skyn/YfY2eQucrN5WhLxSEUAX1bUwpzSy+j412wry8h2Ljg2Fu1ZEcpuo
	 iUQByelsHAlVYvxGB1QsD9+4mwHOKkb7qG/QEOzmMCaBF6jPxITMHuqLhCOgPUDhNqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=F+uvwasvpckL07TS96Fl5RRK5HZS8g47J5IGwgm44OM=;
	b=1H8FulGWyVkHLLKzeY17HbbToVhVOc1AShEIQL/yL1NkywlxjIt57MahbNtKf8KnPk1g
	 b3faBg9kX0WhfnuVuIGPeCGCpKZNrqlY7xnvZbkkeKSBRVagYl9gOAdeOX5B7wGB7iE1k
	 atu3gaEZR5KjonTGAafQNMmXjzVfMhiroFepHvYwdz3LHW32sUgAPe5WeW7hGR4i2jme7
	 ojjOX9HMuUhTLwWx+SmRWDADvTiHP2NbdFmym6wpA9ykW1D9g5eQkYPijy/KJudQso7lm
	 WzLKYwK9x5OIqvq3/p5huO2ogE9iIR2D5zgHIHwhyX4nz10BUJ64EaK/zcq3ePyjzZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ml6zZgh0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348A606A31F
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8348A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ml6zZgh0
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso148803a91.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 11:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793125298; cv=none;
        d=google.com; s=arc-20260327;
        b=e1MaL8Vnhye8XUXWUZO6mmgvEVnTYt0OPcQJvcsY3k8V55JB54Q54mXbRIsRmAer65
         N07JTjtBBVUQVWO84NF8zRW8eoX4Rq5jqbkmYrybxXF7cvqbLte9rMWqdPxY9BW/pYCr
         q7+CVRI+4Vk6wOViS6feRYPAdHxgvjXjG4S+Nss9a3lW2QNEmCdoA64vqKGW2Yt3/CHT
         gfUEWI38hv1PcGmnjxkr1ResGkwjC7npqY0Bi9Z4r4oCO720dWiLnGlyw8ANuM/xnZPU
         Y2oD7XwLrSt5KZ7S0CjhcyDlPqxgmQMwhPMd9tNGbHwt+FdvVVXFuEuBJIZbTITjOLKs
         9AaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F+uvwasvpckL07TS96Fl5RRK5HZS8g47J5IGwgm44OM=;
        fh=B2K1JQvOSgpSGLZ64tiBzFRfL+sA/Y1H6EOFsNSeoVw=;
        b=Ewu3gc0htYmdy1zlvQ4OR7eCiPt+wp6yFAVWdkNUvlR4yMK+28+ldtq+e6BsuG4kje
         R7jWAFxD5sfkJkab+VWGapBB4HZzAMvpJ/Exwg8TZzaIZUNkV0vcQtF6Rx9Rr4kiibWx
         uFhYG92khvTW6kL0ixWWPp692KQj+Ldk2eqr54dgrME34XU3Hsq2eI4x5rL6P84UujmA
         m3fZjrqMGC3cVKY0HQb3Dp5tz4tyn00R/jGd0e8QlvujI4H/dEPXcLP1FhHyjcWXn6fX
         62Sqc44x+0WsL4gec0/n/waWZckMTEOgEZz/sdvC359n35N1nd3cmRnkfLJt2FWTd7KQ
         eXdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793125298; x=1793730098; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F+uvwasvpckL07TS96Fl5RRK5HZS8g47J5IGwgm44OM=;
        b=Ml6zZgh0IM9OrAj9Pxh8S1iAHsOci1hL+5CSQj+xdSA4BGKq74fLCZjJODxXbibzcd
         p/fm0TRzdrZycRxWJP6he0I0wK6bujqxw8yhQHYptRyuI6RpPuDlmp6KYnS/lkPbFzAK
         yAo2coRxKnDs1Ghlt9HnTyUw01E3JyF2aLjcHC3N0LJfc0u/atEMT6ghM7FaOoRyYmPl
         BS27+aS6DwtvcOiX5t5EccF/RlKUko0NOe/+VIy3Wwy63ZpQjNCL9jEvBCuKWeZkbw0r
         R6CpMJpt35OtJfJcQIz/IkYc513UITnHJV6F3rNWO0pu56Av++8RbDHEJHXNQEgik7pX
         +ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793125298; x=1793730098;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F+uvwasvpckL07TS96Fl5RRK5HZS8g47J5IGwgm44OM=;
        b=Ouye3Ekkedn5XjiwFlXM829mTW0WpnN+GiyS6EiFJVKBmy+L5I7RqXn+RMoLgE47/a
         eJJ66pHaZIk5y5U/mZzhFttY2/9j0qcAqUE61LJlR5efMBrbTK+LMp72WRxwC2IU8AlK
         tfzIUGbqyMX5ESN6va5OoTdj8PAEsSQbcXW/SzqfoE7ONp3vEOM5iYEgThxsHOVvgQLb
         u+KAW+7obnXVTJ0dfPAhvyceod9wuIrtioeoEnqiFgCxtSaeBFqyG5p9079yETE/1LTY
         60DJIwm0alnmI03EflqJJ+orC4gA9VgSblnXiHDgHmJ/MbpQcFz+iJuUvzhsVeryDofE
         Izjg==
X-Forwarded-Encrypted: i=1; AKwUvByhKrspapaIb0n3hff7s/bWNokAtQkv79J8yLMSvSJB3Xudog3IoyaqSHFQoPa2lXGVMnE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdPOhfWus6w6Vvw84rXETJusZLF6uIOdop8TC8X1T3ZnVbQwtY
	VLESL57uoZmzOfP8wbuwtObeBgyNL1Njq7pAfDab2d710hU4TDyHkpGIsQ8CsQEFBEe9fZlB/lv
	uPT35+KeS/rI2P48mjx2IlNkxUWASNEY=
X-Gm-Gg: AYBFou0gRMC/cqhatcPeTM8+vpp/2GJVGpN2HWcLbmJgJb5wGZ7UcTFvMRAnst2vG5A
	aZUUB2/L6FD2U+IF2hHGVtv5SGxykmV2VjpdYRaIXvzb3TTvtu3UPqzpZ1hmc9j0nA91OegdmDp
	v1HVDKUxfuvhPmuI5POxRO9h7EhrdgxLK0/GKBU9qTLXOwKSAQ6z7z7G3AB8djMLfQ0N9ihfOO3
	UdXqsJkDVVRMGKT1/qpL9oyCu/K3/wCGeDFZg5/2CRNWL5yTz77IkFKpUR/1C/N3ArkCjSSoLa8
	5oZCrTRjoYobue5U5KbYtjVJJMI17meGF0Pxc+P74YmKA9IHgeiX2ea5GvZYeEtmjVrlesI18ii
	U2AB7pQMSOIvxsEhQneSAk9uotTHj40WteeOgx8qre1nTnucFp6dqVVhNCNNRA8EEhH/Z0m6v3K
	xIXsYMjUwCbhx5W1FelPqcTKZrSHo7WciRPzddy2sq7T3PmR0flOUtPgM=
X-Received: by 2002:a17:90b:2686:b0:3ad:6090:a17b with SMTP id
 98e67ed59e1d1-3adeae6d892mr7812495a91.17.1793125297361; Tue, 27 Oct 2026
 11:21:37 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023222652.3927736-1-ihor.solodrai@linux.dev>
 <20261023222652.3927736-4-ihor.solodrai@linux.dev> <CAEf4BzYuEetnwDnm38J_MEG4-ZcQHfZwg=L1FcFtgXvAn7NSAA@mail.gmail.com>
 <882895bf-db14-485a-bd6f-0241b1eba1ba@linux.dev>
In-Reply-To: <882895bf-db14-485a-bd6f-0241b1eba1ba@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Oct 2026 11:21:23 -0700
X-Gm-Features: AclHuK88OrQ3b4YZnstv4M67AzAB701uiSayzXJelOWiEU7XVxcO0Ngdw6GaoKM
Message-ID: <CAEf4BzYwORw44UFwt6Kiy+Y3hj3m0=wYzPiH7e7wDsAW58xxBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/8] bpftool: Apply __bpf_relocatable per
 record on BTF dump
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org, 
	Alan Maguire <alan.maguire@oracle.com>, Cupertino Miranda <cupertino.miranda@oracle.com>, 
	David Faust <david.faust@oracle.com>, Ian Rogers <irogers@google.com>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Vineet Gupta <vineet.gupta@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:15=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> On 10/27/26 11:03 AM, Andrii Nakryiko wrote:
> > On Fri, Oct 23, 2026 at 3:27=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >> bpftool wraps the C dump in a clang attribute pragma that applies
> >> preserve_access_index to every struct and union, so field accesses
> >> through vmlinux.h types get CO-RE relocations. GCC-BPF supports the
> >> attribute but not the pragma, so it gets no CO-RE from the header.
> >>
> >> Jose proposed replacing the Clang pragmas with per-record attributes
> >> in May 2024 [1]. The declaration attribute support in btf_dump [2] now
> >> provides the per-type control discussed in that thread.
> >>
> >> Apply the attribute to each struct and union definition instead, as
> >> kflagged decl tags rendered by btf_dump. Add the tags to a split BTF
> >> over the input, so the input stays read-only. The tags use the
> >> __bpf_relocatable macro, which by default expands to
> >> preserve_access_index if compiler supports it.
> >>
> >> Clang output is unchanged.
> >>
> >> GCC-BPF programs now can get CO-RE relocations from vmlinux.h, however
> >> the selftests GCC-BPF build defines BPF_NO_PRESERVE_ACCESS_INDEX and
> >> is unaffected yet.
> >>
> >> [1]: https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@=
oracle.com/
> >> [2]: https://lore.kernel.org/bpf/20260929234608.48503-1-ihor.solodrai@=
linux.dev/
> >>
> >> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >> ---
> >>  tools/bpf/bpftool/btf.c                       | 62 +++++++++++++++---=
-
> >>  .../bpf/bpftool_btf_dump_sorted.expected      | 16 ++---
> >>  .../bpf/bpftool_btf_dump_unsorted.expected    | 16 ++---
> >>  3 files changed, 65 insertions(+), 29 deletions(-)
> >>
> >
> > [...]
> >
> >>         printf("#ifndef __VMLINUX_H__\n");
> >>         printf("#define __VMLINUX_H__\n");
> >>         printf("\n");
> >> -       printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
> >> -       printf("#pragma clang attribute push (__attribute__((preserve_=
access_index)), apply_to =3D record)\n");
> >> +       printf("#ifndef __bpf_relocatable\n");
> >> +       printf("#if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_at=
tribute(preserve_access_index)\n");
> >> +       printf("#define __bpf_relocatable preserve_access_index\n");
> >
> > why not define __bpf_relocatable as
> > __attribute__((preserve_access_index))? then type definitions will be
> > a bit cleaner and we can basically drop BPF_NO_PRESERVE_ACCESS_INDEX
> > eventually, and instead you'll be able to just `#define
> > __bpf_relocatable` to disable relocations (or if some GCC version
> > requires some quirk, you'll define it wholesale)
>
> The problem is in how libbpf dumps the attributes.
>
> __attribute__((__vmlinuxh_local_foo)) allows to have a single BTF tag
> emission logic in bpftool: always emit the attributes. And they remain
> opt-out in the generated vmlinux.h because __attribute__(()) is legal.
>
> In order to enable
>
>   #define __bpf_relocatable __attribute__((preserve_access_index))
>
> We need to move the opt-out to bpftool level, that is: optionally not
> emit the BTF tags. And that then brings up a question of adding a
> runtime flag, passing it through makefiles etc.
>
> This can also potentially break existing progs that depend on
> BPF_NO_PRESERVE_ACCESS_INDEX.
>
> So going with __attribute__(()) looked like the best
> backward-compatible option to me.
>
> I'm open to other ideas though.

So we always emit __bpf_relocatable next to a type, but then at the
top of the header we can define __bpf_relocatable as empty if we want
to disable relocations (either because compiler doesn't support this
or user defined BPF_NO_PRESERVE_ACCESS_INDEX, or user manually defined
__bpf_relocatable).

I must be missing something, why doesn't this work?

>
> >
> >> +       printf("#else\n");
> >> +       printf("#define __bpf_relocatable\n");
> >> +       printf("#endif\n");
> >>         printf("#endif\n\n");
> >>         printf("#ifndef __ksym\n");
> >>         printf("#define __ksym __attribute__((section(\".ksyms\")))\n"=
);
> >
> > [...]
> >
> >> -#ifndef BPF_NO_PRESERVE_ACCESS_INDEX
> >> -#pragma clang attribute push (__attribute__((preserve_access_index)),=
 apply_to =3D record)
> >> +#ifndef __bpf_relocatable
> >> +#if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_attribute(preserv=
e_access_index)
> >> +#define __bpf_relocatable preserve_access_index
> >> +#else
> >> +#define __bpf_relocatable
> >> +#endif
> >>  #endif
> >>
> >>  #ifndef __ksym
> >> @@ -30,19 +34,15 @@ struct holey {
> >>         long: 32;
> >>         long: 32;
> >>         int tail;
> >> -};
> >> +} __attribute__((__bpf_relocatable));
> >
> > e.g., I was expecting to see just __bpf_relocatable here, without
> > __attribute__(()) wrapper
> >
> > are there any downsides to that? that seems how attributes are
> > typically hidden in kernel, for instance
> >
> > pw-bot: cr
> >
> >
> > [...]
>
