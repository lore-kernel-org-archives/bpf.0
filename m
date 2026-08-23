Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1372C87F
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 00:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787445278; cv=pass; b=Y1meaOeHqMZPvVkZg/Fd0XeLhGcexYemYeYjc2R98k+EcssG4gpEOkIGRpTt+Cye4OcnU306RRcUB93Lm0F//mwXVGznok3tRNaSNQkdvFqdzj/RI+Gr6u0eubYCf7G8bFxMamYU0U/JFvhIPS0+B/gvgusZjXsSYxc/qB31Ojw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787445278; c=relaxed/simple;
	bh=0rr0awJxxCCNN4G2NNV4fK/y3qc1K9AQARKZ6VZeEtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4yVWxNR0smPAv8/cYmSzoO0Ph0jgwJ2y/JKAw+X8BkmEzMc2HMeVibIwQFy+sf6g6wNiiKgxv8r+O/5Wi6J4yrY232fySfn3f1Zgd6Nwsa29RzrE4Gp8nTDsifLsyI/mn4XQI9k5wnwFdm+fBBP1k14EOokPVCCRFJEbtNHN3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/zWL0no; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/zWL0no"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2074710751so410538666b.1
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 17:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787445275; cv=none;
        d=google.com; s=arc-20260327;
        b=bWzNWndrOfcUnZtV/Fd8iYtEBfDwxubLUT8ziocOuhBu438a+3oImaJtWsfmt4oKbo
         3YqjmXfXP6DhXz/UyuSUCmWu7+MAiqO0iOf6lz/GXJcyc/HISMoT7PYdnYXCUKbq9joX
         R3lpEYvh4LMODnqLLS7rC1Qu80ZvKlMwVqi+aO41dlBJGH+TtreBrI4g2n5U6iUhGV3f
         pvvxx3gj28j9xporf8WrtOLhLemQlTOkDoAINfxQ1LnoyxtNRr2IaUKHAmoECDMCHUKd
         6B9aLw9hPqCI+pDjJG2MaJrN6poZuQWH+w7tsmRf6/qA0vLILSeEHN1WQdSgKcpWDNW0
         R47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C01vzV5uWqhCLhAKgdPcDRsRZqcgs34QDY7g3I+MbSQ=;
        fh=FthGvuR3K9/4OOpgmQJp7FB64mSmSiZB6V3xeZ/77Q8=;
        b=bmDCFtYiloPaZ1Zd2uPGrYzC6ppp18NCWE2dIk7Vgk4pQUFpAaJZlAjMxfeHyIu2IN
         yvl/s1Sl6qHlJn0skrLtNePsb819uwN2bZnhaeJi4mcVXpsuNziP/i8Ah66x9xNBa+OR
         lrL5pjZlTpVKGTraA586nF/XF6/SQS40radVGD7C2IZr2fTIjYPj+/t/UnY63p4sTdGG
         pHtRZsxICoxVkRmXS4Y4iGDsoE/0NuFKaLFD1SZnjnmGH89/9T/uy3PwoZUL9BSLKGQM
         xL/DJR1sVuHIU1d6xSbpXDpnWmgdRNwBVa1Wg/xmuB6ivEsog0Y0pnUBMRQKDDIPsWGq
         o/fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787445275; x=1788050075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C01vzV5uWqhCLhAKgdPcDRsRZqcgs34QDY7g3I+MbSQ=;
        b=b/zWL0noFZmVQM7tfW3YAO40Nrqg6fgKiOQkfeAgBdPgjBwQ9tEaBGHqqCJumr/8LT
         ujUMQccXRoAGjNSvLyHj2h1lEONGqfIsE1GkZfQ1Bln0oH46GA1Nl4iskEku1LRWSqyi
         6cKwAVNLoYoOR256jnZQyg6raXKK3jdg8zhcEWckZ52EKXzBJkac/uG90+8hh504yWrn
         ijghj7ZzKMg5HIIdhOXKIucCxlRzgsM65apLc+u0FAa2hfKFOkKxsK4XTWGcGO9J+bht
         +JO++5FJdFzhLSghV30341BTfVfjCHNlNnZ4et9n8VxG4wupldF394YOx76oUr2XcYMb
         R9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787445275; x=1788050075;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C01vzV5uWqhCLhAKgdPcDRsRZqcgs34QDY7g3I+MbSQ=;
        b=JQUkVS+HmAAnYYz3hvxzz2LJh5li//7S2jMxF74Xbd8iMBaubvYoXN4gLVUefjcgPw
         7zqTvYPgtUxax4uQztjVKqxgCT0jRZKvTwwou+w660FSKYN4Z8aTNCasPmhPfxKT7nXQ
         FMDKiGD+6zWTqCKmBrMJ7EpiNpJ+d3JVh28AK5Q0uwPbOWhd//omYkkZ91xyJ1LHZJ5e
         9G1QAox9GNCuteTOE5M/V6cziY53PuiwbCu+FOwOEko7mOgVOYb8GNIiQ9pM9dDjaUqx
         znAUqNqBbRpHw+Eq2QIlgnaNYY/qD2kSVoMO3A6WC0FjnPkEAVMFOm5QpW0t+J28mbIP
         2v/Q==
X-Gm-Message-State: AFuF++m9cpjHhiNRKEsm+44S67TYLwpV0/SWd7a45Cu73No4AgW0Erup
	fF+BbdUQluAkytwYc74Ku5ht8F44rqfMbbNxtfoP/xNxyrx/feUW8DAQ7/Jbheck0KRhx1WewpF
	rtE18HI2ppSR4f7WHbFyxKP1xkPa8Iic=
X-Gm-Gg: AR+sD13dhsxrwGBxrUQlU/LA9dakE3DfBJcASDruSzqNo+xJCKn961sMIyTzQ32G0JL
	xP3xp74ylW5qUhEfY++g1S8BysqqtrqOLIZ9S8pCm6x18AuUxIAxSjwpdDUfxXLgWtt7d8kB9eN
	kopWHSt/1DtbbnTguw4UBIGMSVqkVdgLvj8tOvTLuGFABj+ZHfsHXmVZqa7OKm8K1Qv60SdSJ3I
	Z1j6efEfPiQ8aHWZvWTSoaUm92Lq6FSo/f0XFNwef68kDPJVLmugkSQEljTjIfX1J2BfIqo0NiM
	A1LJDG4febsfQ24UiJAveHpahP1AQULQWrwuArdek5Hpx3zuZa0vYOrj+pY+d9X0pOG1/rN+jZ3
	I
X-Received: by 2002:a17:907:d0c:b0:c20:d90b:2cb1 with SMTP id
 a640c23a62f3a-c249188eadbmr1011248366b.0.1787445274347; Sat, 22 Aug 2026
 17:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
 <20260804170156.1709916-9-nickolay.lysenko@gmail.com> <8da8aa48afa6ef52c22f976793af75b334b189a1.camel@gmail.com>
In-Reply-To: <8da8aa48afa6ef52c22f976793af75b334b189a1.camel@gmail.com>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Sat, 22 Aug 2026 17:34:23 -0700
X-Gm-Features: AcwNN1V8mCIiT2aSdqzysO4glhc6RqenijH_HgIh9IbeX9wcvKUhri-_iuhuP4o
Message-ID: <CAMtxOX3KFvfvbYOLB9WqbrxBhi=k8J5eXGs1wE0peg24CdAQiw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v5 8/8] selftests/bpf: build each test runner
 instance in its own sub-make
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the detailed review and sorry for the delayed reply! Had to
interrupt this adventure for a bit.

On Thu, Aug 6, 2026 at 1:02=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2026-08-04 at 10:01 -0700, Mykola Lysenko wrote:
>
> ...
>
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index 58c567a22..af3709d51 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
>
> ...
>
> > @@ -262,6 +249,35 @@ $(OUTPUT)/test_maps: $(TESTING_HELPERS)
> >  $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HE=
LPERS)
> >  $(OUTPUT)/xsk.o: $(BPFOBJ)
> >
> > +# All helper objects a runner instance links, pre-built here so runner
> > +# sub-makes sharing $(OUTPUT) never compile them concurrently.
> > +HELPER_OBJS :=3D $(TESTING_HELPERS) $(CGROUP_HELPERS) $(UNPRIV_HELPERS=
)        \
> > +            $(TRACE_HELPERS) $(JSON_WRITER) $(CAP_HELPERS)           \
> > +            $(NETWORK_HELPERS) $(OUTPUT)/usdt_1.o $(OUTPUT)/usdt_2.o \
> > +            $(OUTPUT)/xsk.o
> > +
> > +# $(BPFTOOL) is a prerequisite because its sub-make is what installs
> > +# libbpf's internal headers (bpf/hashmap.h, bpf/libbpf_internal.h) int=
o
> > +# $(INCLUDE_DIR); without it, helpers including those headers race the
> > +# install and can silently pick up the source-tree copies instead.
> > +#
> > +# Invariant: this list must be a superset of every prerequisite the
> > +# runner's EXTRA_OBJS rule attaches to these same objects (EXTRA_HDRS,
> > +# both tests.h flavors, $(BPFOBJ)). It guarantees the helpers built
> > +# here are never older than a runner-side prerequisite, so the
> > +# unflavored test_progs and test_maps sub-makes, which share $(OUTPUT)=
,
> > +# treat them as up to date instead of both recompiling the same object
> > +# file concurrently.
> > +$(HELPER_OBJS): flow_dissector_load.h ip_check_defrag_frags.h         =
       \
> > +             $(VERIFY_SIG_HDR) $(LIBARENA_SKEL) $(LIBARENA_ASAN_SKEL)\
> > +             prog_tests/tests.h map_tests/tests.h $(BPFOBJ) $(BPFTOOL)
> > +
>
> Tbh, I don't understand what this comment is attempting to convey and
> maintaining the invariant would be taxing going forward. LLM is also
> trying to convince me that several dependencies are missing from the
> list:
>
>   test_progs.o btf_helpers.o sysctl_helpers.o netlink_helpers.o
>   jit_disasm_helpers.o io_helpers.o test_loader.o disasm.o
>   disasm_helpers.o bpftool_helpers.o find_bit.o
>
> Which would form a race when compiling test_progs and test_maps that
> both share the same $(OUTPUT) directory. This seem plausible.

For the record, that race does not exist: the test_maps sub-make
compiles only test_maps.o and testing_helpers.o (and testing_helpers.o
is in HELPER_OBJS, pre-built), while each of the eleven objects above
has exactly one builder - the unflavored test_progs sub-make.
find_bit.c never becomes $(OUTPUT)/find_bit.o outside it either:
xskxceiver compiles it directly from source on the link line.
HELPER_OBJS was exactly the multi-writer set - objects the top
Makefile's own binaries (test_verifier etc.) share with the runners.

That said, I agree the arrangement was too subtle to live: it took
the paragraph you quoted to explain, and the invariant is the kind of
thing that silently rots.

>
> How about a change as in the attached patch? (squashed with this patch).
> It sidesteps a previously discussed constraint to keep refactoring to
> the minimum, but HELPER_OBJS is just too ugly to pass.

Applied your patch to v6, thank you - it is clearly better: one
builder for every user space object by construction, no invariant,
and the flavored instances stop compiling identical copies of the
shared objects.

>
> > +$(OUTPUT)/flow_dissector_load: flow_dissector_load.h
> > +
> > +# Tool sub-builds: bpftool, libbpf (host and, when cross-compiling,
> > +# target variants) and resolve_btfids. Deliberate asymmetry: the host
> > +# libbpf builds without sanitizers and with the host toolchain.
>
> Nit: is this comment necessary?

Dropped in v6.

>
> >  $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Make=
file)    \
> >                   $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
> >       $(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)                  =
      \
>
> ...
>
> > @@ -672,81 +413,125 @@ $(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h =
$(BPFOBJ) $(LIBARENA_BPF_DEPS)
>
> ...
>
> > +# Everything a runner instance references but does not know how to bui=
ld.
> > +RUNNER_PREREQS :=3D $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(BPFTOOL)     =
         \
> > +               $(TRUNNER_BPFTOOL) $(RESOLVE_BTFIDS)                  \
> > +               $(OUTPUT)/veristat                                    \
> > +               $(VERIFY_SIG_HDR) $(PRIVATE_KEY) $(VERIFICATION_CERT) \
> > +               $(LIBARENA_SKEL) $(LIBARENA_ASAN_SKEL)                \
> > +               prog_tests/tests.h map_tests/tests.h                  \
> > +               $(HELPER_OBJS)                                        \
> > +               $(OUTPUT)/urandom_read $(OUTPUT)/liburandom_read.so   \
> > +               $(OUTPUT)/xdp_synproxy $(OUTPUT)/sign-file            \
> > +               $(OUTPUT)/uprobe_multi $(TEST_KMOD_TARGETS)
> > +
> > +FORCE:
>
> Nit: please drop a line here, saying that the main makefile does not
>      know if $(OUTPUT)/test_progs is stale, hence FORCE to force
>      delegation to Makefile.runner.

Done in v6, essentially in your words.

>
> > +
> > +# The default flavor's skeletons are also inputs of bench, test_maps,
> > +# xskxceiver, xdp_* and test_cpp; "default-skels" builds just those
> > +# without the test_progs test objects and binary.
> > +.PHONY: default-skels
> > +default-skels: $(RUNNER_PREREQS)
> > +     +$(Q)$(RUNNER_MAKE) RUNNER=3Dtest_progs FLAVOR=3D TESTS_DIR=3Dpro=
g_tests \
> > +             BPF_CC=3D'$(CLANG)' BPF_CC_MSG=3DCLNG-BPF BPF_SYS_INCLUDE=
S=3D'$(CLANG_SYS_INCLUDES)'  \
> > +             BPF_CC_FLAGS=3D'-O2 $(BPF_TARGET_ENDIAN) -mcpu=3Dv3'     =
           \
> > +             BPF_DEFINES=3D-DENABLE_ATOMICS_TESTS skels
> > +
> > +$(OUTPUT)/test_progs: $(RUNNER_PREREQS) default-skels FORCE
> > +     +$(Q)$(RUNNER_MAKE) RUNNER=3Dtest_progs FLAVOR=3D TESTS_DIR=3Dpro=
g_tests \
> > +             BPF_CC=3D'$(CLANG)' BPF_CC_MSG=3DCLNG-BPF BPF_SYS_INCLUDE=
S=3D'$(CLANG_SYS_INCLUDES)'  \
> > +             BPF_CC_FLAGS=3D'-O2 $(BPF_TARGET_ENDIAN) -mcpu=3Dv3'     =
           \
> > +             BPF_DEFINES=3D-DENABLE_ATOMICS_TESTS
>
> Is there a way to reduce copy-paste between default-skels and
> test_progs? Why does test_progs depend on default-skels?

The dependency existed for serialization: under -j, bench and friends
reached the default flavor's skeletons through the default-skels
sub-make while the test_progs recipe launched its own sub-make that
also builds them - two make instances writing the same files
concurrently; the dependency made default-skels complete first.

Both the duplication and the serialization trick are gone in v6
though: following your second mail, the skeleton rules moved into
Makefile.skel and the main Makefile builds the default flavor's
artifacts itself - default-skels no longer exists. Details in the
reply there.

>
> > +
> > +$(OUTPUT)/test_progs-no_alu32: $(RUNNER_PREREQS) FORCE
> > +     +$(Q)$(RUNNER_MAKE) RUNNER=3Dtest_progs FLAVOR=3Dno_alu32 TESTS_D=
IR=3Dprog_tests \
> > +             BPF_CC=3D'$(CLANG)' BPF_CC_MSG=3DCLNG-BPF BPF_SYS_INCLUDE=
S=3D'$(CLANG_SYS_INCLUDES)'  \
> > +             BPF_CC_FLAGS=3D'-O2 $(BPF_TARGET_ENDIAN) -mcpu=3Dv2'
> > +
> >  ifneq ($(CLANG_CPUV4),)
> > -TRUNNER_BPF_BUILD_RULE :=3D CLANG_CPUV4_BPF_BUILD_RULE
> > -TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS=
_TESTS
> > -$(eval $(call DEFINE_TEST_RUNNER,test_progs,cpuv4))
> > +$(OUTPUT)/test_progs-cpuv4: $(RUNNER_PREREQS) FORCE
> > +     +$(Q)$(RUNNER_MAKE) RUNNER=3Dtest_progs FLAVOR=3Dcpuv4 TESTS_DIR=
=3Dprog_tests \
> > +             BPF_CC=3D'$(CLANG)' BPF_CC_MSG=3DCLNG-BPF BPF_SYS_INCLUDE=
S=3D'$(CLANG_SYS_INCLUDES)'  \
> > +             BPF_CC_FLAGS=3D'-O2 $(BPF_TARGET_ENDIAN) -mcpu=3Dv4'     =
           \
> > +             BPF_DEFINES=3D-DENABLE_ATOMICS_TESTS
> >  endif
> >
> > -# Define test_progs BPF-GCC-flavored test runner.
> >  ifneq ($(BPF_GCC),)
> > -TRUNNER_BPF_BUILD_RULE :=3D GCC_BPF_BUILD_RULE
> > -TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(call get_sys_includes,gcc,)
> > -$(eval $(call DEFINE_TEST_RUNNER,test_progs,bpf_gcc))
> > +# Sys includes come from the *host* gcc, not $(BPF_GCC) - bpf-gcc's ow=
n
> > +# search path lacks the host's asm-generic/ headers.
> > +GCC_SYS_INCLUDES :=3D $(call get_sys_includes,gcc,)
> > +
> > +$(OUTPUT)/test_progs-bpf_gcc: $(RUNNER_PREREQS) FORCE
> > +     +$(Q)$(RUNNER_MAKE) RUNNER=3Dtest_progs FLAVOR=3Dbpf_gcc TESTS_DI=
R=3Dprog_tests \
> > +             BPF_CC=3D'$(BPF_GCC)' BPF_CC_MSG=3DGCC-BPF               =
           \
> > +             BPF_SYS_INCLUDES=3D'$(GCC_SYS_INCLUDES)'                 =
         \
> > +             BPF_CC_FLAGS=3D'-DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attri=
butes -O2'
> >  endif
>
> Did you test the bpf_gcc flavor?
> I have a recipe to build the toolchain somewhere, if you need it.

Two data points. The BPF CI GCC-BPF job builds the flavor and is
green on this series. Locally I ran it with the bpf-gcc Ubuntu
packages (gcc 14 snapshot, 2024): the machinery works - 671 of 982
programs compile, the ones that old gcc cannot handle skip cleanly
under BPF_STRICT_BUILD=3D0, skeletons generate or skip with the
objects - until resolve_btfids aborts on btf_data.bpf.o carrying no
.BTF section, which that gcc does not emit; the BTFIDS recipe step is
not covered by the permissive suffix in the current Makefile either,
so the behavior matches stock. I would take your toolchain recipe -
with a current gcc-bpf I expect the flavor to complete, and I'd like
it in my pre-send checklist.

>
> >
> > -# Define test_maps test runner.
> > -TRUNNER_TESTS_DIR :=3D map_tests
> > -TRUNNER_BPF_PROGS_DIR :=3D progs
> > -TRUNNER_EXTRA_SOURCES :=3D test_maps.c
> > -TRUNNER_LIB_SOURCES :=3D
> > -TRUNNER_EXTRA_FILES :=3D
> > -TRUNNER_BPF_BUILD_RULE :=3D $$(error no BPF objects should be built)
> > -TRUNNER_BPF_CFLAGS :=3D
> > -$(eval $(call DEFINE_TEST_RUNNER,test_maps))
> > -
> > -# Define test_verifier test runner.
> > -# It is much simpler than test_maps/test_progs and sufficiently differ=
ent from
> > -# them (e.g., test.h is using completely pattern), that it's worth jus=
t
> > -# explicitly defining all the rules explicitly.
> > +# test_maps compiles map_tests/*.c against the default flavor's skelet=
ons
> > +$(OUTPUT)/test_maps: $(RUNNER_PREREQS) map_tests/tests.h default-skels=
 FORCE
> > +     +$(Q)$(RUNNER_MAKE) RUNNER=3Dtest_maps FLAVOR=3D TESTS_DIR=3Dmap_=
tests
> > +
> > +# Default-flavor BPF objects and skeletons consumed by targets in this
> > +# Makefile (and by lib.mk's install rule) are produced by the runner
> > +# sub-make above; the empty recipe plus the order-only prerequisite
> > +# makes them available here without duplicating the runner's rules.
> > +DEFAULT_BPF_OBJS :=3D $(patsubst progs/%.c,$(OUTPUT)/%.bpf.o,$(wildcar=
d progs/*.c))
> > +TEST_GEN_FILES +=3D $(DEFAULT_BPF_OBJS)
>
> --- 8< ------------------------------------------------------------------=
--------
>
> > +BENCH_SKELS :=3D $(addprefix $(OUTPUT)/,                              =
         \
> > +            test_overhead.skel.h trigger_bench.skel.h                \
> > +            ringbuf_bench.skel.h perfbuf_bench.skel.h                \
> > +            bloom_filter_bench.skel.h bpf_loop_bench.skel.h          \
> > +            strncmp_bench.skel.h bpf_hashmap_full_update_bench.skel.h\
> > +            local_storage_bench.skel.h                               \
> > +            local_storage_rcu_tasks_trace_bench.skel.h               \
> > +            bench_local_storage_create.skel.h                        \
> > +            bpf_hashmap_lookup.skel.h htab_mem_bench.skel.h          \
> > +            crypto_bench.skel.h bench_sockmap_prog.skel.h            \
> > +            lpm_trie_bench.skel.h lpm_trie_map.skel.h                \
> > +            bpf_nop_bench.skel.h xdp_lb_bench.skel.h)
> > +TOP_SKELS :=3D $(addprefix $(OUTPUT)/,xsk_xdp_progs.skel.h            =
 \
> > +          xdp_hw_metadata.skel.h xdp_features.skel.h                 \
> > +          test_core_extern.skel.h) $(BENCH_SKELS)
> > +
> > +# Empty-recipe delegation: "default-skels" (re)builds the file via the
> > +# runner sub-make, after which make re-stats the target, so dependents
> > +# see fresh timestamps within the same invocation. Dependents still
> > +# rebuild on mtime only - the phony prerequisite does not cascade.
> > +$(DEFAULT_BPF_OBJS) $(TOP_SKELS): default-skels ;
>
> -------------------------------------------------------------------------=
- >8 ---
>
> Note, the above two lists can be replaced with the following two rules:
>
>   $(OUTPUT)/%.skel.h: default-skels ;
>   $(DEFAULT_BPF_OBJS): default-skels ;

I verified this works (a no-op build stays a no-op, cascades and
re-stat behave, nothing becomes an intermediate file for make to
delete), but it ended up moot: with Makefile.skel from your second
mail the delegation rules are gone entirely - the main Makefile owns
the default flavor's skeleton rules and the hand lists disappear with
them. Details in the reply there.

>
> > +
> > +# Standalone test binaries
> > +
> > +# test_verifier is much simpler than test_maps/test_progs and
> > +# sufficiently different from them (e.g., its tests.h uses a completel=
y
> > +# different pattern), that it's worth just defining its rules explicit=
ly.
> >  verifier/tests.h: verifier/*.c
> >       $(Q)( cd verifier/; \
> >                 echo '/* Generated header, do not edit */'; \
>
> ...
