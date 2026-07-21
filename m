Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C8446EC7E
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663020; cv=pass; b=UYsi/d+eBHjA9egBCPIJYZyvPOhXczA+s4zQSqUvIp2WVLBM2hHL8ZZC82GC2aMWf7QSlIxCrm0KVdGisnFpOiqUhDc0RC1/K0SwnFvrDOJVXeV9sG3noXWNPzM8pPWHroYmSwdTKV+fY+shw8yrNSY1U6pa01UaidE2tej8Yso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663020; c=relaxed/simple;
	bh=UWyB1slbr//2W4KTDkAmTzxAdMd8fmYMI4/ROQtFYbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpShZXilRr3N+LrNfRWVNczFBNbEQTWZvWdyQJG4QpUDYjVQtarZMKjQr78CFE/H7cK0UxPbFKRo5WtdmHV6hI0gxrZ7Z832yLjvLCNCRqhhlFP2wOspJk6nOdswDq8Id1mm8HMbtTAKodqUU1eS4QaUNrC9Ywz8WOSHtuLYTa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9L+CTgw; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9L+CTgw"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15f47e6297so861735966b.0
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 12:43:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784663017; cv=none;
        d=google.com; s=arc-20260327;
        b=RH4d3ymoZJ+snOq6tSUV4/zqUkQN5+Ko/byZRC1jhf4PMPw2jj8BnAo9hU5QDnSbxA
         5D2C+/GBNU/NKb0UVj8dlXVG7FIPURDLoPaEQs2kUoawwnam2WyxjMxjNEBnheGhrM+9
         saTZaNXSBa1Uz7cgO7vLSXqeIVTHvuQJ+QzK/ajNS936mv3HCGfAKmBOp4SCCLFSIDXU
         sBwIxLDjBZYXYm9ccd/r1vfJe1LRtziKPyIMF4Dr1AvVSVW+9Sm24/v5W3/L/Y4SCtXA
         w3xKD+fjMzbUCnaos1mfNozcC3VuY8otwRJmpdxoIW+5GZg/sSI7VKX539vqHzRVU5bB
         nzWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lkVJzKo6e4lzm7YdG6O+XIlFAoy5nL8becDKZSEK67I=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=k8Qxl2J2/PpD0/azIRdL4uk/d+Ffv1VezN0Gbac9WsCjOvxB2hc95adNLc6imWEVqP
         kxdFH/NLVQ/mxRjH4N9uN8Pcc4/JFY0crrMQu3oT4dCqajnR2noD/kN2itDVuSOkX2Ku
         7GucH7YG+GOWjhJiSaf5DcXlk5bwjwa8Fn2ici+ELqPF3eZU7p84iNWSulS1sfQW3wzn
         JZ5LD0T8ozk6K67gpfa8QY23zE5scA7kZGIFTsHoxX6ytOcffkoviNQ1VHaBwKL4t5zn
         CZDXgp96yUXrST122A0i8qwE7GHANUSLYhA1jk9/BM9Can86S8Uf+SmWqeHu2smydEqr
         c4Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784663017; x=1785267817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lkVJzKo6e4lzm7YdG6O+XIlFAoy5nL8becDKZSEK67I=;
        b=c9L+CTgwuXgMoXv0fQftRG6UwXoKLgE7YO7d/635hz8l+5qNRCa6ffmX5ktXtGOfKW
         XYppxx7WhOTtrZDto5EdEWp49TpZmF/nmvlYRvaBeMWKuZhthyFc0PjeHozbt8gGT+sD
         Kx8OK+Hj3WbJ1BkOTGdnSQjuY90DkLSeyFlhC6DuNzEnS5oNgzWTU0qMcoZUkRDJH0qd
         CThJoSzPr30JrARf+JbHYJllLTICC+/QcHD88UwSguWTF0uUnqIUUB7KRfwbxQqPYlGx
         uwidZCx3CbkZbxG/i44fJY4jCTDQepGmmNSqEbpOyYgpPKdpdZtfFz7l3SlLcBQQ5W6J
         ceZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784663017; x=1785267817;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lkVJzKo6e4lzm7YdG6O+XIlFAoy5nL8becDKZSEK67I=;
        b=PraaN3E0frkmlN89OsNnBkU0YM9XQGtWJbLHGeU4Tvz8Iik7FrxeBdtb0swSoqBQij
         4rx4YKqFwr7kRfopt9ZdBQktdgDoIK1zSNoT3YxskEcMkueCCL3h87XnfVeyFboSLVCg
         iXeovKGjyJ+W0aQHMlAmXVBebixXgmZ9ZOIZiczcFIRu8VhecePjE3ZKWe/WQWHzn1/X
         p58wg/5U3jAaVc1qtO8FD48MJQdHHJWmXxQLI9y68zYFbfJjV+t9DypHW7n92P2TVOk8
         kZcClgHkXBRF/MxBm0kAC3fUPMAxxTsSSSiUude/2985JQmSO1BKxlySAFjRXAV+3AKa
         2v0w==
X-Gm-Message-State: AOJu0YyzPMHXUorg4s8s2Y0hflw4f35ZKzc5+1KanAM9jFuow2PcC8Ig
	auNcR9AwQqZ2JTi9IaIzsS9XKMkybW949U8nethj4keSyd7Ds2L2j1hpAv4bZlFZahkMifEmZvY
	IxBoFyD67OHRoHryBlKHru4X4319HobjzZy3Wva0=
X-Gm-Gg: AR+sD100N9Sx1r0qEBUFnqoeNDaZ3b0BCbnrWPkXR1oyhc4LHAjoK9193b9ospgJPq6
	dyeJjHWRdx52m/V9u2jvzQhVmSK7GGxT4J1Eee/b4suZ/xL33z1D53LKnBkR39CVkzsxejoy3Dk
	s1RvkjGeVgoXJX3llb7uUQTA+K5ACdqnw0y4OgckrrcDX4d/lP2cdhoq19frqrMGhG2RJgdkxse
	7pFm0eySItOuxSRYaZWW+pywxtd/FSzDJgBrUb/UXi82KYwXXITuLLM04j4eFJ0ptrjeiyklpzZ
	dKiz6GlyrjErMYpq3w==
X-Received: by 2002:a17:907:1c2a:b0:bff:738c:7a64 with SMTP id
 a640c23a62f3a-c16b487dce6mr752859066b.49.1784663016824; Tue, 21 Jul 2026
 12:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721174909.8044-1-nickolay.lysenko@gmail.com>
 <20260721174909.8044-4-nickolay.lysenko@gmail.com> <20260721175857.DCF371F00A3A@smtp.kernel.org>
In-Reply-To: <20260721175857.DCF371F00A3A@smtp.kernel.org>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Tue, 21 Jul 2026 12:43:25 -0700
X-Gm-Features: AUfX_mxhuEeA4v_KINJ9pbWdnV-urNiDaBK_p0OmJd5Inr2XGNjBXpCpig2uaug
Message-ID: <CAMtxOX2Rw2PK6v+E07eE7n==CTJ_fn6iF+EyUOkyrJ=rUZPR5Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 3/3] selftests/bpf: build each test runner
 instance in its own sub-make
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 10:58=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Parallel build race on shared helper objects (`testing_helpers=
.o`, `cgroup_helpers.o`) due to overlapping rules between the parent Makefi=
le and `Makefile.runner` sub-makes.
> --
>
addressed in v2:
https://lore.kernel.org/bpf/20260721194111.334795-1-nickolay.lysenko@gmail.=
com/T/#u

> --- Patch [3]: [RFC PATCH bpf-next 3/3] selftests/bpf: build each test ru=
nner instance in its own sub-make ---
> commit e06c43ef78e32188e09532ae20788ac48fd20702
> Author: Mykola Lysenko <nickolay.lysenko@gmail.com>
> selftests/bpf: build each test runner instance in its own sub-make
>
> This patch refactors the BPF selftests build system by moving the
> double-expansion DEFINE_TEST_RUNNER logic into independent sub-makes via =
a
> new Makefile.runner. Shared configurations and prebuilt toolchain element=
s
> are kept in the top-level Makefile.
>
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index f5c0f81f61db7..a3ab525f7dfab 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
>
> [ ... ]
>
> > +HELPER_OBJS :=3D $(addprefix $(OUTPUT)/,testing_helpers.o cgroup_helpe=
rs.o \
> > +            trace_helpers.o network_helpers.o json_writer.o          \
> > +            cap_helpers.o unpriv_helpers.o usdt_1.o usdt_2.o xsk.o)
> > +
> > +# $(BPFTOOL) is a prerequisite because its sub-make is what installs
> > +# libbpf's internal headers (bpf/hashmap.h, bpf/libbpf_internal.h) int=
o
> > +# $(INCLUDE_DIR); without it, helpers including those headers race the
> > +# install and can silently pick up the source-tree copies instead.
> > +$(HELPER_OBJS): flow_dissector_load.h ip_check_defrag_frags.h         =
       \
> > +             $(VERIFY_SIG_HDR) prog_tests/tests.h $(BPFOBJ) $(BPFTOOL)
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/bpf/Makefile.runner b/tools/testin=
g/selftests/bpf/Makefile.runner
> > new file mode 100644
> > index 0000000000000..4c58cc51f2514
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/Makefile.runner
>
> [ ... ]
>
> > +ifeq ($(RUNNER),test_progs)
> > +EXTRA_SOURCES :=3D test_progs.c cgroup_helpers.c trace_helpers.c      =
         \
> > +              network_helpers.c testing_helpers.c btf_helpers.c      \
> > +              cap_helpers.c unpriv_helpers.c sysctl_helpers.c        \
> > +              netlink_helpers.c jit_disasm_helpers.c io_helpers.c    \
> > +              test_loader.c xsk.c disasm.c disasm_helpers.c          \
> > +              json_writer.c bpftool_helpers.c usdt_1.c usdt_2.c
>
> [ ... ]
>
> > +EXTRA_OBJS :=3D $(patsubst %.c,$(RDIR)/%.o,$(filter %.c,$(EXTRA_SOURCE=
S)))
> > +LIB_OBJS   :=3D $(patsubst %.c,$(RDIR)/%.o,$(LIB_SOURCES))
>
> [ ... ]
>
> > +$(EXTRA_OBJS): $(RDIR)/%.o: %.c $(EXTRA_HDRS) $(TESTS_HDR) $(BPFOBJ) |=
 $(RDIR)
>
> [Severity: Medium]
> Could this cause a parallel build race on the shared helper objects?
>
> The top-level Makefile builds shared helpers like testing_helpers.o and
> cgroup_helpers.o with a limited set of dependencies (shown above). Howeve=
r,
> this EXTRA_OBJS rule inside the sub-makes encompasses those same helpers =
and
> declares broader dependencies, such as $(LIBARENA_SKEL) for test_progs an=
d
> map_tests/tests.h for test_maps.
>
> Because these broader dependencies are built in parallel by the top-level
> make, they can end up with newer timestamps than the pre-built helpers. I=
f
> that happens, both the test_progs and test_maps sub-makes might evaluate
> the helpers as out-of-date and concurrently recompile them.
>
> Can this lead to intermittent "file truncated" or "file format not recogn=
ized"
> link errors when building with -j?
>
> > +     $(call msg,EXT-OBJ,$(BINARY),$@)
> > +     $(Q)$(CC) $(CFLAGS) -c $< -o $@
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721174909.80=
44-1-nickolay.lysenko@gmail.com?part=3D3
