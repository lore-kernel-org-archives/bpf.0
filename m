Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D392242D7B
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 00:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787445489; cv=pass; b=PccF9cuK5R6v4CpiyGM/Qfmfu2y3aSK4zOrmxHwNx5SfSkkUbQSGE27n4z25K7lnwVVihsktZTDQIjZe+Fwy7E/n7oChJS5IFK9px/9u9yC7XgRbprGiEpdH2DKxRywLOa14N5siDQzDQGpwE+alRZdwaJRyQlYyx/2twv92HAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787445489; c=relaxed/simple;
	bh=CQQUk7WyMlimATvN2TubBpiV7t6/kdjxTiXJmzO+/I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VbcqDVds39p50lzhchtTXAoVB5XHMSCK9d8RJQ0tqcG842+rvqexbwbR6STgoGv2wTK/4qYDuLIL/nG0vgRaw30S1CvtaTd3L7otvFM0r96FTdseoEoTXXMXr1iJJesZ0f/kUzVVQwe5NBCjk1gxGzn7bmH4LIIyo1o5v+n9bmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NufCVPLW; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NufCVPLW"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c207cb16cf5so359355766b.1
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 17:38:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787445486; cv=none;
        d=google.com; s=arc-20260327;
        b=Ffrkx499VEBx2HYTcsOX8E5quSCBHLW4iQwYdeHzFuRTSk43dU9pO/ktSsT3071YxE
         3Rs02Nk2CA7HWaOhVnoL3BNYxPr3uSTswmsOx3U+/lLwxUX6WV9v0aTYsO/1LBB0XYZe
         5B9+9gyhy19zpWSdrDCcxmKKvrJAsoTHp2QG+R5sdumSjvFyVGunDC9qJAPkVqkDD/1x
         KICXM7aQsoMuzDha0vEn+OArAiwnw9CBwgfCXwb3GPRYUaRZG07HYcTwMrBImhgX5Ms6
         XaAm+SjnwCriD6D1L1yaulxyOoMkxaB7aO80a/xve0LS6W0+OjE4MqY8C726gWwdbBoc
         jIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qzqwutXDtz6cXpjQVmrAsIlzR2xXjGkclkw2fB1yovU=;
        fh=FthGvuR3K9/4OOpgmQJp7FB64mSmSiZB6V3xeZ/77Q8=;
        b=W7W0SNPv87tkzBrVBy76r5IPwzixvy0aGAG9zDcOcBH1qEsFXONKFqot4Y+LzUAjV0
         6mANpibLsv26F+dYs4MUdtrvMx9ie589B/9FjIYgo3PfrdAKFpCAzgCQjpe0dO+DIxH8
         5MQX4zOoE5GrdHdonVau/J7toN5192KKAt5psq0t7ForL2ksHwtZ5FsU0TC7oIJDTqJo
         plnXfVd0kGxbO1pz2b0r+OBgHyN7Pu1ucuQ9lkkOsYgnzsEgNUWBAUNOZTIrWA8Ul6+7
         VXMS2GGY/0zdPKAAXDPCDYZIBasC3ihdaFQVKAlNxWn2k5/f/MrBNocCNHjzc5Mecx8Z
         IMqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787445486; x=1788050286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qzqwutXDtz6cXpjQVmrAsIlzR2xXjGkclkw2fB1yovU=;
        b=NufCVPLWCemoUe1Kp1bw2Ap1+lBV6aNkICBFMKitBKVXARPCOlNqC2g6wU+Jut1g0R
         ZWRc0JciGD8qD+6y32HaP3X3aXwZpMPd7KgTaJYK963/QnlYh51JEutDgum69KQrCtoK
         f7QT/pCB9Si4JRMZ48bBY5zx14Yp/pu4q9KVndgUif+vYHpswxHbnTQkTcfZWwauHLmF
         joctW9koypoanr4b4y/54hs0fDdvgeosFUQfXl+xx8TGyPlIkezozF9XopyJEoePaYcv
         HbckVfowUScX1JJsBQqYbRT/dy4LeRg8i82AWL4j9SaXMCEOI2Xm2gbpMlmMJTcepDZe
         6Bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787445486; x=1788050286;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qzqwutXDtz6cXpjQVmrAsIlzR2xXjGkclkw2fB1yovU=;
        b=AcZaorgdEKpOGo9qusNOt11BQTJdO3ExJipG7PpjmcFidpOjsjCCqCoYLezqCxcZMB
         juV2drozMJuZPbzWjNOx+1HJZawJAjI8h4UXwkFXES16g7EUdlQyqLITZ0DuWcY3e1ut
         GD1mVvgdnGP4B6vDnI61Cyt1tfbfbSTNiJSwoEEgUxVRylTrJfSznkdRcVZzcv5Dri5u
         Enx5taBqLbF6Hw29F7lfL0I2slt5LzSZnV1UzKJDfx4eX/NI6FhM9DLbhsrwFtX1OptZ
         l+ii95kLZE23A7OHG4/qdhA175xI1R8hnsWSgU7S2GPtzs2Tl3aDlfODzZz3J2JsBTUc
         4s/w==
X-Gm-Message-State: AFuF++mJPWSv0WqStEFuDL0Y9SwehAb9Sc3XopRf6dfZI5jpuE/KS3lS
	W9yuenOUKTgpE9fKUrZ+ZQ4TguO7omRuQgE9i/9yVAEg5gNLTaEY7yCwd23Xoe2JQdPn8mvIujx
	fIbplbyAyHiqLgtIrCQ0n9g4J2XvNTZWm80NKRhA=
X-Gm-Gg: AR+sD12d2hM1uIkB54KKo+6NXFOg2tAo2xVW4K6Zx+pGzbKu4TRL2pFxwnAPZfQnBOi
	zSitQ4U2ohGBOOMtsULBBrZkrKiWHystiaq7Xc82uSWqAcpr2YEC6aPlWe3xWUD0eUq496rABoD
	Ncm9+p9pZUhurgQvYPLl5MgjFF4RCHyVmzGGNAH0YaetVmEwOt/2qXMwLMsCAak414F9AkVk/NQ
	HM5taBy2IIbKlGZJJPM5Mra14Q531sszQRd6n5EeeXpfxX3KFzomDuo8MVAGiQvcGnUCYyllyGN
	2K+RUX+rXasIX7ZAizyhqFsR36Pd20qWc3QZ+6G9p1Q0soBumdQUOLfND6uTO46TbfJVtpYuWoU
	S
X-Received: by 2002:a17:907:7b93:b0:c20:5213:56f1 with SMTP id
 a640c23a62f3a-c246a60348emr1674469766b.13.1787445486069; Sat, 22 Aug 2026
 17:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
 <20260804170156.1709916-9-nickolay.lysenko@gmail.com> <8da8aa48afa6ef52c22f976793af75b334b189a1.camel@gmail.com>
 <c3f59776953b04e20e18da57e22b9cae2db5c9b6.camel@gmail.com>
In-Reply-To: <c3f59776953b04e20e18da57e22b9cae2db5c9b6.camel@gmail.com>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Sat, 22 Aug 2026 17:37:54 -0700
X-Gm-Features: AcwNN1UszvV9m-2bFoOTfr3SElHR6wZkjb5cYpc0G4rABqrR9AB8gbliTh98bvo
Message-ID: <CAMtxOX0PJUEv_05aQ_AQmseREAUMeESCK1NC1Sq0hcDsffo5cw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v5 8/8] selftests/bpf: build each test runner
 instance in its own sub-make
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 11:30=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2026-08-06 at 01:02 -0700, Eduard Zingerman wrote:
>
> ...
>
> > > +# The default flavor's skeletons are also inputs of bench, test_maps=
,
> > > +# xskxceiver, xdp_* and test_cpp; "default-skels" builds just those
> > > +# without the test_progs test objects and binary.
> > > +.PHONY: default-skels
> > > +default-skels: $(RUNNER_PREREQS)
> > > +   +$(Q)$(RUNNER_MAKE) RUNNER=3Dtest_progs FLAVOR=3D TESTS_DIR=3Dpro=
g_tests \
> > > +           BPF_CC=3D'$(CLANG)' BPF_CC_MSG=3DCLNG-BPF BPF_SYS_INCLUDE=
S=3D'$(CLANG_SYS_INCLUDES)'  \
> > > +           BPF_CC_FLAGS=3D'-O2 $(BPF_TARGET_ENDIAN) -mcpu=3Dv3'     =
           \
> > > +           BPF_DEFINES=3D-DENABLE_ATOMICS_TESTS skels
> > > +
> > > +$(OUTPUT)/test_progs: $(RUNNER_PREREQS) default-skels FORCE
> > > +   +$(Q)$(RUNNER_MAKE) RUNNER=3Dtest_progs FLAVOR=3D TESTS_DIR=3Dpro=
g_tests \
> > > +           BPF_CC=3D'$(CLANG)' BPF_CC_MSG=3DCLNG-BPF BPF_SYS_INCLUDE=
S=3D'$(CLANG_SYS_INCLUDES)'  \
> > > +           BPF_CC_FLAGS=3D'-O2 $(BPF_TARGET_ENDIAN) -mcpu=3Dv3'     =
           \
> > > +           BPF_DEFINES=3D-DENABLE_ATOMICS_TESTS
> >
> > Is there a way to reduce copy-paste between default-skels and
> > test_progs? Why does test_progs depend on default-skels?
>
> Overall, I don't like the default-skels dependency for `bench` and compan=
y.
> Previously these depended only on a subset of skel.h/bpf.o files.
> But idk if that could be avoided. One option is to extract Makefile.skel
> with the rules necessary to build bpf object files, and include it from
> Makefile.runner and from the main makefile. Making `bench` and others
> depend on the exact set of skels they want. But I'm not sure I like this
> option either.
>
> Please think a bit about this thing, maybe you can come up with
> something.

I prototyped your Makefile.skel option and I think it is the right
call - it comes out simpler than what it replaces, not more complex.

The observation that convinced me: it is the same move as your
RUNNER_OBJS change, applied to the BPF artifacts. The main Makefile
owns everything shared (now including the default flavor's BPF
objects and skeletons, via the included rule file instantiated with
the default parameters), and a runner instance owns only what is
private to it (the flavored artifacts, the test objects, the binary).
With the main Makefile able to build any individual skeleton:

- bench, xskxceiver, xdp_*, test_cpp and the install list go back to
  depending on exactly the files they consume - the stock per-target
  dependency lines, unchanged;
- default-skels disappears, and with it the delegation rules and the
  test_progs-depends-on-default-skels serialization trick you asked
  about this morning (so the DEFAULT_RUNNER_ARGS deduplication and
  the two pattern rules from your first mail dissolve rather than
  get adopted);
- every output path has exactly one owner again: the main Makefile
  writes $(OUTPUT)'s BPF artifacts, each flavored runner writes only
  its own directory. The unflavored sub-makes include the same rule
  file, and since the delegating rules list the full artifact set as
  prerequisites, a runner sub-make always finds them fresh - same
  file, same rules, so there is no two-lists invariant to maintain.

Cold "make bench" builds 19 BPF objects and 19 skeletons with this,
versus the full default-flavor pass (982 objects, 1,792 skeleton
headers) with default-skels - that was the regression you called out.

While folding it in, the file split settled one step further:
Makefile.skel is self-contained - the hand-maintained skeleton
metadata (the light-skeleton demand lists, LINKED_SKELS with its
-deps map, the skeleton blacklist, the BPF-object header list, the
per-source flag overrides) sits right next to the derivations and
rules that read it, and since both the main Makefile and
Makefile.runner include the file, both instantiations read the same
data with no second copy to keep in sync. Makefile.buildvars keeps
only definitions genuinely shared between files (toolchain, paths,
flags, the permissive-mode helpers, the runner link lists).

The cost is a fourth makefile and ~20 lines of parameter plumbing in
the top Makefile; Makefile.runner shrinks by the extracted section.
Functional checks on the prototype: no-op builds stay no-ops, a
full build settles, touching one bench prog rebuilds exactly its
skeleton, bench object and the binary, and touching a shared prog
rebuilds object, signed lskel, test objects and relinks test_progs.
The folded version passes the same full A/B as the rest of the
series: BPF objects, skeletons and artifact lists match the current
Makefile's output modulo the two changes already accounted for (the
moved header's recorded paths, the flavored duplicate .o removal).

This is folded into v6.

>
> ...
