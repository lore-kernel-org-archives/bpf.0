Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA1E42A170
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876157; cv=pass; b=Sy4kiYp/O8LpTheuS2uv0HhMETOsPlVhHrlmTSeZ9GNvJFQuJowxgyCOehy+ytPVma5prlN2MF+svvmoH3ztU+ba0URs3Y+7lOWM+6llAWTKZvzX8J72kW1PypmzqWH4vd/CoL3QycUddaIhqBZ+qQmqa+UP/uaEuNo9hPPqetg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876157; c=relaxed/simple;
	bh=M8JSdwFyeJLLhtl/v2KQpFuVSgRMre7S8ava1XsB94s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Al6RafRoM6gdlaTZaNxH+UDIBi/Jx4PU6seBMnKdu9JtfnMbX6U0fmJmRzOV+Mfr2iMxw7lpci1Pp59b8calwNHb/9PsX7rL8e5QCt2895iKvBBsL7/AoEmUVrj6ErkyM+ljrz03M4zfW3aEEo3wvqzXaCqcrB/n+HRMcFciZCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iA8F0gBv; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA8F0gBv"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1f7666a90bso48638066b.3
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 13:42:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785876153; cv=none;
        d=google.com; s=arc-20260327;
        b=V0x9JAWvTsrqWY9fXGPMZ2J+dCAtoyVKmQIeu5f2EKm4MV1BfLEb0I4nqxjY4fVhOq
         MbgKfEoR18NmnEhYlb3vi70iRu4CK4yO3xxtE+1AxaABppz+6ciNluLKO/OokfCF7vsB
         7vyP4SBdKdbXaKNpprYbkeMbKuyWgp1TdXu0JEJIsA0VWfl0Iv5PR8RLRsEVTlzx0A8i
         M8qQm5zk3ihHADYechzqMzbSnUHFFhAaa55PM+9hcG7yeAcldtFl4ApaDmjjH9QnSqm1
         Wn/snEzgmrmsCnQC4CqtXTO5J3AXN+GqbQGu2ob+TMVMrVz7zmsos53skkhBnQ9MxyJv
         Uj4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QrkVrJzcta5RWUoKQyxrWJV7uC2Mp2UIFQinS79ZjUI=;
        fh=MfdxnbopznZxnCxWc4D4ptEL7Fpnl7hCH1/NSg1SbZw=;
        b=GUQFkhGHt5LDSOpqCaRBCGl7L9uLZ2U/3j0xKavqGlT7uQWKGrz6+fIbxJjXulhkOp
         D6yXhSg0zJ2Hn7PjXGtpGNvfaOzSXTL7vNPRlpjTiSLgjOth/AKAwqq73QV/9x53SUtJ
         oMvxqk6JDRG15vMEDHdV9VHY7AKIVz6OC3AZQKSDZpp9yajN85zg7D5oy9flo9pKr1rO
         QBLy20FrWj5SEBeo7N9WH6TsdzKAlF3Fwc5JPAaxLY4ypFtU7oN/kQ3Y5vUsaizbzXbb
         lVoMr/oR7ff4K2in8DsWw8f7rnWMn6kB8Pn9PGHeT+q3BUFJrsb63ynAVQv4A0fE+H6m
         DnJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785876153; x=1786480953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QrkVrJzcta5RWUoKQyxrWJV7uC2Mp2UIFQinS79ZjUI=;
        b=iA8F0gBvytw7uJrdcYUYXBXgsaZCd2i6+XpEssheubDt0H+MIfCNpZgsCcJKGvxEXY
         xhioVjuBMgMluhZl6agIZFP83qxsB7FUPpvMkSTJkAf1zvNqr1fKmp7+BRRi1pzpcjyH
         3KJf6RkdZ7wG27C35TpBxXbFLCgMseII/o6SfB5K+uU+I+KcVRKqxHaguq6fqhNJ5X4S
         g8HpYmUPgG/UdtUY14K3hBeiynIu8iJh7UbwxjxJ+SGEvQBez+OzzeiWo+nvHGlHs0D+
         24hBIsSBnOdPz/FiZegVLtPeHdWGSgqu0E4QNE/IHx91hHE21RKzKT9B3Tyn061PqFe9
         qt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876153; x=1786480953;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QrkVrJzcta5RWUoKQyxrWJV7uC2Mp2UIFQinS79ZjUI=;
        b=o3LtDzm8SgNP6mIJ8JZFzsuiBysIjIdTee1j+HxkJsCTAs/vpGl1sAJYk0qWiBMITW
         kz6BMN+8FtaWqKeXUXKpVj+11bm4KIMuaGgsj0x8YSXPpnP5ldRoYRHEsFj6rIZKhjbC
         QFRh+qczLj1w7Gmc4SX8WDb/wWGeN2qsyyjZK80WdjK6ocR23EWBXDMjtbAtlporhsVu
         fvxtvkcpWkGcI2Ob1/848zFcQdj8ivpUd/OS0HHNiMVzKPQjWmGG17at25ciWpwGXPJZ
         6JbRjHbfz+v9OrIhQU/41duEiPCUw2jaq1UG8UkwjWpwoZM1oX19lT2UoKxiKFeSTmGt
         s6gw==
X-Gm-Message-State: AOJu0YwDWOsWztEhIjtmDgGB+mmSCIg/r655e4IWwg6jd3c2u7nI9FWp
	kpJ+lFMXdwDNvZUioXYf3vLggmmLF4RjADZW75gwU8usLd6KxGNKBu4aTzU2IlqcSQ0hO9kpgHp
	BNWggUX/h2148l4qbW3hHaev16oRxXNA=
X-Gm-Gg: AR+sD1229/srJXJBku37YVRt7vUtaQ7VCG1SYRvKYAKrtHHv/8Erp46PonTnEa+STkr
	ZkYwQC6kWDe1HNKesR/oX73yWbGQYpo5FQRXdFmQE5tBxohcOwTg8JryDD2zKstpunBlCmHFJ2H
	55p0H80h9EBkVQ1zCA0BvM76A3jBW/n3degH21ThllpUjIMM8dWUx3Yj0H9RD2M2y7BeuRsB8pB
	bJOYWfm/1XhhQPYD7ba66Y/CyZ3G7Ch7Fq2lf64T+g6FeRh7IBS9ubjnente4qotDQPjJ0wwkur
	OUAfVAN740C+P5pj8ymsbvcWtwEUcX+gNiy9hCs0GU119UXAghxR9A8X4eSlU41lzXB08HnFzcP
	6kA==
X-Received: by 2002:a17:907:1c86:b0:c16:b05c:b9cf with SMTP id
 a640c23a62f3a-c2039cdc721mr72062866b.26.1785876152918; Tue, 04 Aug 2026
 13:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724042600.175440-3-nickolay.lysenko@gmail.com> <26de96afd813486d7e90ef7dea4c4d7e3e98b8400fb372cddac4a2f568502189@mail.kernel.org>
In-Reply-To: <26de96afd813486d7e90ef7dea4c4d7e3e98b8400fb372cddac4a2f568502189@mail.kernel.org>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Tue, 4 Aug 2026 13:42:20 -0700
X-Gm-Features: AUfX_mygwxtuPcNPlNQy2ON65S3msR5YWZwM9on8Y369Bzdz5TLgEFF18iuqHUY
Message-ID: <CAMtxOX3ZWX_rA57XMihyVFqpQLHoG7d5o5jxrFuUdvYhF_eK0w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v4 2/3] selftests/bpf: move shared build
 definitions into Makefile.buildvars
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, memxor@gmail.com, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Both findings were real - the first a genuine regression (confirmed in
the v4 CI logs: "llvm: [ OFF ]", __jited tests silently skipping).

Addressed in v5, which leaves srctree and PKG_CONFIG untouched at
their original positions; details in the v5 changelog:
https://lore.kernel.org/bpf/20260804170156.1709916-1-nickolay.lysenko@gmail=
.com/

On Fri, Jul 31, 2026 at 3:27=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index 2ed953b84409..1843679fc0e2 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
>
> [ ... ]
>
> > @@ -213,21 +149,8 @@ ifeq ($(feature-llvm),1)
> >  endif
> >  endif
> >
> > -SCRATCH_DIR :=3D $(OUTPUT)/tools
> > -BUILD_DIR :=3D $(SCRATCH_DIR)/build
> > -INCLUDE_DIR :=3D $(SCRATCH_DIR)/include
> > -BPFOBJ :=3D $(BUILD_DIR)/libbpf/libbpf.a
> > -ifneq ($(CROSS_COMPILE),)
> > -HOST_BUILD_DIR               :=3D $(BUILD_DIR)/host
> > -HOST_SCRATCH_DIR     :=3D $(OUTPUT)/host-tools
> > -HOST_INCLUDE_DIR     :=3D $(HOST_SCRATCH_DIR)/include
> > -else
> > -HOST_BUILD_DIR               :=3D $(BUILD_DIR)
> > -HOST_SCRATCH_DIR     :=3D $(SCRATCH_DIR)
> > -HOST_INCLUDE_DIR     :=3D $(INCLUDE_DIR)
> > -endif
> > -HOST_BPFOBJ :=3D $(HOST_BUILD_DIR)/libbpf/libbpf.a
> > -RESOLVE_BTFIDS :=3D $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
> > +include Makefile.buildvars
> > +
> >  VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux)                        =
 \
> >                    $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)    \
> >                    ../../../../vmlinux                                \
>
> The srctree fallback block moved into Makefile.buildvars, but that file i=
s
> included after ../../../build/Makefile.feature has already been parsed. D=
oes
> this break the feature-llvm probe for standalone builds?
>
> In the pre-image, the ordering was:
>
>   include ../../../scripts/Makefile.include
>   <srctree fallback at old line 53-58>
>   include ../lib.mk
>   $(eval include ../../../build/Makefile.feature)  # old line 183/186
>
> After the patch:
>
>   include ../../../scripts/Makefile.include
>   include ../lib.mk
>   $(eval include ../../../build/Makefile.feature)  # new line 119/122
>   include Makefile.buildvars                        # srctree defined her=
e
>
> Makefile.feature line 2 does:
>
>   feature_dir :=3D $(srctree)/tools/build/feature
>
> This is an immediate assignment, so it captures srctree when
> Makefile.feature is parsed. In a standalone 'cd tools/testing/selftests/b=
pf
> && make' build, srctree is not in the environment and nothing in the earl=
ier
> include chain defines it - none of tools/build/Build.include,
> tools/scripts/Makefile.arch, tools/scripts/Makefile.include or
> tools/testing/selftests/lib.mk contain a srctree assignment.
>
> Consequently feature_dir becomes '/tools/build/feature' instead of
> '<tree>/tools/build/feature', and the probe at Makefile.feature:11 runs:
>
>   $(MAKE) ... -C /tools/build/feature ...
>
> The '-C /tools/build/feature' fails because the directory does not exist,
> stderr is discarded, and the probe silently yields feature-llvm=3D0.
>
> This flips the conditional at Makefile:127-150 off, so LLVM_CFLAGS never
> gains -DHAVE_LLVM_SUPPORT and LLVM_LDLIBS/LLVM_LDFLAGS stay empty.
> jit_disasm_helpers.c then compiles its '#else' stub whose get_jited_progr=
am_text()
> returns -EOPNOTSUPP, and test_loader.c:1442-1449 turns every __jited expe=
ctation
> into test__skip() with "tests are built w/o LLVM development libs". The s=
ix
> progs/ files that use __jited stop running, and test_progs loses
> -DHAVE_LLVM_SUPPORT and the LLVM libraries it previously linked.
>
> This contradicts the commit message's "Build artifacts are byte-identical
> before and after this change" claim for the standard build invocation
> documented in Documentation/bpf/bpf_devel_QA.rst:459.
>
> The srctree fallback belongs with BPF_GCC in the "needed before lib.mk"
> group that the commit message already identifies, for the same reason -
> it is consumed before Makefile.buildvars is included. The same applies to
> PKG_CONFIG, which is used in Makefile.feature at lines 178/183 but is now
> only defined in Makefile.buildvars.
>
> > diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/tes=
ting/selftests/bpf/Makefile.buildvars
> > new file mode 100644
> > index 000000000000..ef12018fa254
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/Makefile.buildvars
> > @@ -0,0 +1,165 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Shared toolchain, path and flag definitions for the BPF selftests
> > +# build, included by both Makefile and Makefile.runner. Definitions
> > +# follow the order they had in the Makefile before the split.
> > +
> > +CXX ?=3D $(CROSS_COMPILE)g++
> > +OBJCOPY ?=3D $(CROSS_COMPILE)objcopy
> > +
> > +CURDIR :=3D $(abspath .)
> > +
> > +TOOLSDIR :=3D $(abspath ../../..)
> > +LIBDIR :=3D $(TOOLSDIR)/lib
> > +BPFDIR :=3D $(LIBDIR)/bpf
> > +TOOLSINCDIR :=3D $(TOOLSDIR)/include
> > +TOOLSARCHINCDIR :=3D $(TOOLSDIR)/arch/$(SRCARCH)/include
> > +BPFTOOLDIR :=3D $(TOOLSDIR)/bpf/bpftool
> > +APIDIR :=3D $(TOOLSINCDIR)/uapi
> > +ifneq ($(O),)
> > +GENDIR :=3D $(O)/include/generated
> > +else
> > +GENDIR :=3D $(abspath ../../../../include/generated)
> > +endif
> > +GENHDR :=3D $(GENDIR)/autoconf.h
> > +PKG_CONFIG ?=3D $(CROSS_COMPILE)pkg-config
>
> Same ordering issue: PKG_CONFIG was defined before ../lib.mk in the
> pre-image, but now it is only defined here in Makefile.buildvars, which i=
s
> reached after Makefile.feature has already been parsed.
>
> Makefile.feature uses PKG_CONFIG at parse time:
>
>   ifneq ($(PKG_CONFIG),)
>     $(foreach package,$(FEATURE_PKG_CONFIG),$(call feature_pkg_config,$(p=
ackage)))
>
> with immediate assignments at lines 178-179:
>
>   FEATURE_CHECK_CFLAGS-$(1)  :=3D $(shell $(PKG_CONFIG) --cflags $(1) 2>/=
dev/null)
>   FEATURE_CHECK_LDFLAGS-$(1) :=3D $(shell $(PKG_CONFIG) --libs $(1) 2>/de=
v/null)
>
> Nothing parsed before Makefile.buildvars defines PKG_CONFIG, so the ifneq
> guard becomes false and the pkg-config-derived FEATURE_CHECK_*FLAGS block=
 is
> skipped.
>
> > +ifeq ($(srctree),)
> > +srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
> > +srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
> > +srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
> > +srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
> > +endif
>
> [ ... ]
>
> > +ifneq ($(CROSS_COMPILE),)
> > +CLANG_TARGET_ARCH =3D --target=3D$(notdir $(CROSS_COMPILE:%-=3D%))
> > +endif
> > +
> > +# Immediate on purpose: expanding get_sys_includes forks several shell=
s.
> > +CLANG_SYS_INCLUDES :=3D $(call get_sys_includes,$(CLANG),$(CLANG_TARGE=
T_ARCH))
>
> The commit message states "Definitions keep the order they had in the
> Makefile; the only exception is called out in a comment (CFLAGS is prepen=
ded
> rather than appended, as this file is included after lib.mk)."
>
> However, CLANG_SYS_INCLUDES also changed from recursive assignment ('=3D'=
) to
> immediate assignment (':=3D'):
>
>   pre  (Makefile:463): CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(C=
LANG),$(CLANG_TARGET_ARCH))
>   post (buildvars:139): CLANG_SYS_INCLUDES :=3D $(call get_sys_includes,$=
(CLANG),$(CLANG_TARGET_ARCH))
>
> The inline comment explains the fork-count motivation, but this is a seco=
nd
> evaluation-time change beyond the CFLAGS exception documented in the
> changelog. It happens to be benign at this commit since CLANG and
> CLANG_TARGET_ARCH are already final, but any later target-specific or
> conditional override of CLANG would silently stop affecting CLANG_SYS_INC=
LUDES.
>
> Would it be worth mentioning this change in the commit message too?
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/305824=
11360
