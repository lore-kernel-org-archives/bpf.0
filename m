Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812FD22425B
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216802; cv=pass; b=rgnG3gDDRnkg5GLD8injIuPBpxThQ2rV24bcGo7KcWo+5arsPOiH8d6wV5Cb1qpbFdequ/xCiFg2LoaRxxu7w0XAKm11M0Zu4OWtJzb1Zx5FuhGkN3k0oEYty9AI4BOsGcfZ9MPG7NimC4zit9q9tmta+0LZIYtImLNNseZL96w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216802; c=relaxed/simple;
	bh=plfXtwctcX7RIwwVCPJRx5M23rgQL0XAh/FVtT+8StY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owtU4tsEqxrxILVfx2CsMFhku/KZ6tv4vxVIW89n47DbDk0IWXbEKSwOxkuudw8c3usyAbQdwzkk59rgp6JbGkNT1V+gsvC3ffGUFfSR/MI+/vFYM0e3PwK+Rph+K43z+87akyiCul5hweWIp7z+rt5rF6xn0Fi8LLbxgxj6JyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=giqX4hO4; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="giqX4hO4"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba180a022dso1565ad.1
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 11:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779216800; cv=none;
        d=google.com; s=arc-20240605;
        b=PrapA8M95QAlxi2d65khyF1d8XnyehzbouJDyBjAAtw46zPdZF2NbjGiGsDt6bHOSy
         VMPodEIF8dt82eU6GAT7lgqDV6o6nXMi5C8fxoEKhKMCr7AnAINT/SmInui5ub8KCQ8l
         qum8xeg7VIWVH9lOxuz8LF35fuPGmdqJ9jr499jDK6xfvp7XSxZnzb3IswHPJ6tB1HV4
         UVXWrck+F05GcgQldZJ2AFH3qgRNfJlHTQCNaSwKRJ8N9S9NvQC56O41Zcuf097vnYNL
         05R5IvrIQ87fpPbnP+ltjvWcDYzb1eGHgxkpOR1jZZd7rpzoRpdAukzGepUnpPjpbYOF
         8GAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lhvxmYHKe0KMovn7WvpTgA8pqdI/EU1EyA8chDBDlck=;
        fh=eAoWRMX8PO+xiYj1irm9NUiVOrQpZ2lEZcEh4HYTY9M=;
        b=WntY/j45elI/R53KeUdXWQTGjuVtlXSVrgWQ65YTam29hp+3KqBSW2ujkJgrwL14Hv
         gw5j0JeL4gfoiYa0dHBvsCFxLCCpHqK4LRws9L+ktYjA1J9IruQjoh4i4mv5WopZ6Hzn
         AUBFJwW46JBXDVsWZ2TlWUYEDoe6ay/ZM194azIvWwtlL5I9/3BVJdNQdpAlBCS1fVTM
         BF05cVlP5/M8Z+vyEx9ACFRoKOcZhxX3W2ZbbsmGyn1N1w1zAKp8HVixH8/gK4cGNajD
         Hbufx9tjQ8Ts0JRNcnTgmCqi0gEZPADACp3RHwmVrXbURFAHvhgHBhgQ9ergeE5+9pU3
         tLvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779216800; x=1779821600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhvxmYHKe0KMovn7WvpTgA8pqdI/EU1EyA8chDBDlck=;
        b=giqX4hO4QLmogg3y8ieX9agB+/XVvmosCfW3praEaaK9t72rZYLmPMncOshacLyUvy
         kHQn8EJCg9/FeEuWJlhydb0MGa130onHBszYs9FTKBu7k9w9OWA7l4NMrzAj59kQqB1r
         8xHZq9EREGeY+T7DFkLz0mHEpLEgs30uTs28Q2ZYNlrwdaoM0nSo30Ql/zJaFHR9cTaH
         VIatp5aQyXi8HzyUolqBkSYk2fu0KydSpsYcr1Ycxo7SgVitaJzQuqSa27+AnO1DVF3s
         w2uPM++lndv1jSA+/l0xkhbdQBkfod2S7Fu2vghUxAQJfWN6v7hYa3ix6y4FaMPiE6wn
         EXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216800; x=1779821600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhvxmYHKe0KMovn7WvpTgA8pqdI/EU1EyA8chDBDlck=;
        b=loAENTXHhetn1h0DAw4CqgVneHVozC0ioW89Yp22mIRyukvD1ytk1SGBBjJnG6QW7j
         /nL8enG+vJ3WtRYBQj6DcH3vTj2yX1uroJrRjrYPav3tFajf7uTjsa8KdObxsSZzYU9a
         tmInElBEyt/HL6bMB3nvcAIWN+UC8GDSZktEQrtEt14iqmV8BkHZAFB/8NVuwFdSfmiQ
         hZu9w/DiU1+g5ixu7CiP6bH/oGgKlFlEnJqu21e1u5yQBVxbX4BMuFkh9n9QVXyu9NGy
         p0qYAAHpmQAlvJzI7rrryt5awrUTszSm498nT8zLDGf5LKoy9+DyEnelITDgKGmuhMgo
         G4nw==
X-Forwarded-Encrypted: i=1; AFNElJ/SDlmpY/KBzINCPh0flWjINXy18EFzshIMBksvXrC4A5oH3Rei+EZaw2/4pqzaxeqFRDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6j0PEwAFfOPD9CB3zR502cQBo5Kz4yGzds3Xnthclyv+9Jpyy
	EWEXBjCYrnPFwVVOl8Pf08w1GKvA1VJ+EWJaRA6Xd8JjJpRJQoSk27IjvvHDoC3XYilz3RpTuxF
	aDeGyVsuR1NLBdNsPRQIe02lZbh2MsEVRtwbs7/2O
X-Gm-Gg: Acq92OETeM/0nEnXlfg0oQiq/gqFY8/CRg9Bo0U6RPTky1u0e6it9lZ1OPz1B3cCALN
	/OK6cRqaZ7ELhXo01GkKGlzdWXOiY6eMprYojSBvqDWV7Or2PIaYohnGeIf4Vp6Rhb/+HvO84C1
	KWHAbWaBFuBRthyevCQNcU2TBXj34Dvs6Fgmh5WtQ7GqhMpz2fhAqFwW4BU4WQ06qv8iwyhZQkH
	k0tXivdrI27IMVscJ9Sa4QPNJEma+aF7Hv0widYVi2amXbqkj5PkebWzdW2an9jb8OOW3D9q5Ar
	GBcsjA3uNiohwKuF1Cl5LKVoPgR6sk4c2Jb6Si3pZhYOBtjg
X-Received: by 2002:a17:903:3904:b0:2a8:ffed:4663 with SMTP id
 d9443c01a7336-2bdb03a2a4bmr7137625ad.12.1779216799339; Tue, 19 May 2026
 11:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518044740.2526802-1-irogers@google.com> <20260518154638.2798789-1-irogers@google.com>
 <agyrebq2hdayDIyg@google.com> <agyw0IoPccrjYq2q@x1>
In-Reply-To: <agyw0IoPccrjYq2q@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 May 2026 11:53:08 -0700
X-Gm-Features: AVHnY4Kn-EG5dZ43_XH-invlWIDQ8vKMTqwZaTbDUr0oLGMckblRt09X_blga_8
Message-ID: <CAP-5=fVX+_oYzuanMwoia6PqtoRrK_K0zO1A+qG8Xp+fueETjw@mail.gmail.com>
Subject: Re: [PATCH v7 00/14] perf build: Reduce build time by nearly half
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	alex@ghiti.fr, alexandre.chartre@oracle.com, andrii@kernel.org, 
	ankur.a.arora@oracle.com, aou@eecs.berkeley.edu, bpf@vger.kernel.org, 
	collin.funk1@gmail.com, costa.shul@redhat.com, daniel@iogearbox.net, 
	dapeng1.mi@linux.intel.com, dsterba@suse.com, eddyz87@gmail.com, 
	howardchu95@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:49=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, May 19, 2026 at 11:27:05AM -0700, Namhyung Kim wrote:
> > On Mon, May 18, 2026 at 08:46:24AM -0700, Ian Rogers wrote:
> > > This patch series refactors Kbuild internals, BPF skeleton generation=
,
> > > Python AST pre-computation, and foundational tooling dependencies acr=
oss
> > > the perf tool build system. By eliminating umbrella target synchroniz=
ation
> > > barriers, decoupling static library prerequisites, parallelizing sing=
le-core
> > > script generators, and eradicating redundant feature checks, this ser=
ies
> > > unlocks absolute theoretical peak multi-core concurrency during Kbuil=
d startup.
> > >
> > > On a 28-core build workstation (make -j28 all from scratch), clean bu=
ild
> > > latency improves by over 44%:
> > >
> > >   Before:
> > >     real    0m29.006s
> > >     user    2m46.019s
> > >     sys     0m30.610s
> > >
> > >   After:
> > >     real    0m16.091s
> > >     user    2m40.135s
> > >     sys     0m25.740s
> > >
> > > Saving 12.9 full seconds time per clean build. Furthermore, nothing t=
o
> > > build incremental builds are improved by nearly 7x:
> > >
> > >   Before:
> > >     real    0m11.528s
> > >     user    0m9.633s
> > >     sys     0m6.965s
> > >
> > >   After:
> > >     real    0m1.717s
> > >     user    0m1.682s
> > >     sys     0m0.960s
> > >
> > > Summary of Patches:
> > >
> > > 1: Fast-Path Feature Detection
> > >   - Refactors test-clang-bpf-co-re.bin and test-bpftool-skeletons.bin=
 feature
> > >     checks to group shell pipelines within curly braces and redirect =
both stdout
> > >     and stderr to .make.output before touching $@ purely upon success
> > >     (> $(@:.bin=3D.make.output) 2>&1 && touch $@). Grouping the pipel=
ine ({ cmd1 | cmd2; })
> > >     ensures that compiler stderr is successfully captured in .make.ou=
tput rather
> > >     than escaping to the parent shell. This perfectly matches standar=
d Kbuild
> > >     feature check conventions and ensures the target files are touche=
d on disk
> > >     purely upon success, allowing Kbuild to cache positive detections=
 and avoid
> > >     continuous sub-make re-evaluations during incremental builds. Add=
s
> > >     test-bpftool-skeletons.bin to the clean FILES list and explicit s=
ource
> > >     prerequisite test-clang-bpf-co-re.c.
> >
> > I think patch 1 can be separated and needs Ack/Review from BPF folks.
> >
> > >
> > > 2-4: Flattening Umbrella Prepare Barriers
> > >   - builtin-trace embedded inclusions and pmu-events generation are c=
ompletely
> > >     decoupled from the sequential "prepare" umbrella target, eliminat=
ing Make
> > >     AST double-parsing overhead and unchoking parallel compilation ba=
rriers.
> > >
> > > 5-7: Decoupling & Pre-generating BPF Skeletons
> > >   - BPF skeleton rules are extracted out of Makefile.perf into bpf_sk=
el.mak.
> > >   - Decouples bpftool bootstrap from top-level static libbpf dependen=
cies,
> > >     attaching bpf-skel-prepare directly to the umbrella prepare targe=
t. This
> > >     allows Make to pre-compile bpftool and dump vmlinux.h in the back=
ground at
> > >     build startup, removing the 7-second serialization bottleneck bef=
ore BPF
> > >     object compilation.
> > >   - Ensures benchmark skeleton intermediate .bpf.o files are cleanly =
removed
> > >     during make clean, and adds bpf-skel-prepare to .PHONY.
> > >
> > > 8-9: Foundational Linkage Optimization
> > >   - Moves static libsymbol library prerequisites out of the prepare s=
tep.
> > >   - Eliminates redundant libbpf sub-make feature checks during static=
 builds.
> > >
> > > 10-11: jevents.py Concurrency & Deduplication
> > >   - Splits the massive 2.8 MB big_c_string literal out of pmu-events.=
c into a
> > >     dedicated pmu-events-string.c compilation unit. This slices C com=
pilation
> > >     latency in half by compiling string and struct tables simultaneou=
sly across
> > >     separate CPU cores while preserving zero dynamic ELF relocations.=
 Adds
> > >     pmu-events-string.c to .gitignore, declares extern const char big=
_c_string[];
> > >     locally inside output_string_file and output_file when split to p=
revent linkage
> > >     conflicts with empty-pmu-events.c, defers file closures to ensure=
 identical
> > >     timestamps, and uses canonical Make 4.0 @: dependency chaining.
> > >   - Pre-populates jevents.py JSON ASTs and metric formulas in paralle=
l across
> > >     all available CPU cores using ProcessPoolExecutor (accelerating P=
ython
> > >     execution by 11x, from 3.3s down to ~290ms). Moves _init_worker t=
o top-level
> > >     scope to ensure clean pickling under spawn multiprocessing start =
methods.
> > >
> > > 12: Out-of-Tree Incremental Rebuild Fix
> > >   - Prefixes SCRIPTS (perf-archive, perf-iostat) with $(OUTPUT) to pr=
event
> > >     Make from continuously re-executing script installation rules on =
already
> > >     built out-of-tree builds.
> > >
> > > 13-14: AST Parsing Optimization & Shell Fork Eradication
> > >   - Converts ZENS, ARMS, and INTELS in pmu-events/Build from recursiv=
e assignment
> > >     (=3D) to simply expanded assignment (:=3D) and replaces model_nam=
e/vendor_name
> > >     with pure GNU Make string functions. This guarantees Make execute=
s directory
> > >     probing shell forks exactly once during AST parsing and evaluates=
 path macros
> > >     purely in memory, completely eradicating over 7,800 redundant sub=
-processes
> > >     during out-of-tree build evaluation.
> > >   - Converts llvm-config shell queries in Makefile.config from recurs=
ive assignment
> > >     (=3D) to simply expanded assignment (:=3D). This eliminates ~185 =
redundant sub-processes
> > >     that were previously executed across object compilation dependenc=
y checks.
> > >
> > > Changes since v6:
> > >   - Rebase/resend as last series failed to apply by Sashiko.
> > >
> > > Ian Rogers (14):
> > >   tools build: Fix feature checks to touch target files on success
> > >   perf trace beauty: Make beauty generated C code standalone .o files
> > >   perf build: Decouple pmu-events from prepare umbrella target
> > >   perf build: Remove empty archheaders target
> > >   perf build: Move BPF skeleton generation out of Makefile.perf
> > >   perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
> > >   perf build: Pre-generate BPF skeleton tooling during umbrella prepa=
re
> > >     phase
> > >   perf build: Move libsymbol dependency out of prepare step
> > >   perf build: Remove redundant libbpf feature check for static builds
> > >   perf pmu-events: Split big_c_string storage into standalone
> > >     compilation unit
> > >   perf pmu-events: Parallelize JSON and metric pre-computation in
> > >     jevents.py
> > >   perf build: Prefix SCRIPTS with output directory to fix continuous
> > >     rebuilds
> > >   perf pmu-events: Convert recursive shell assignments and macros to
> > >     Make built-ins
> > >   perf build: Convert llvm-config shell queries to simply expanded
> > >     variables
> >
> > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>
> So this is for 2-14? I haven't checked if 1 can be left out of an
> initial merge by me.

I believe you are correct. Patch 1 is completely independent because
it is the only change in tools/build; everything else is in
tools/perf.

Thanks,
Ian

> - Arnaldo
