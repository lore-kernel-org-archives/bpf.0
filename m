Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A0C34FF78
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784861846; cv=pass; b=PldvZ0F3iM52YHOmj9bm9KFS+3yKIrJMdJewRchM+ffX9jw3qD2R9lSPIcmXycNI1f8dG8lKVYyGZsTtPZ2679Zot1eTrUgs1oBAuIUYUtyGfSGSLi0nUsKOdXRwQnxDerz0vWZmTJLdoSpkkkGcP8eGzX2KrlUWUYM2GsF87oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784861846; c=relaxed/simple;
	bh=SI+hy8lcE4fSe8WJChOZm3H5rGUgjLLCQHytzXg0i+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMBNN0Enlc8jeYvRyiHhgnlOYyuKXeqcDMY8v+Jj+yYqhhazh1tuKkuVHYlaqZxmTPFn07TntrNbIrI4zpL/iTEUOP/TCT6o/coUeEyVYaJ9owLlrsdEhZejn1zWvXeZ6mVmraVC8VOUU1OdF1RX8gfHx4CrC+giI+8me3ukA9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAVsSkCD; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAVsSkCD"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1712a04ddaso202960766b.2
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 19:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784861841; cv=none;
        d=google.com; s=arc-20260327;
        b=g/Q0YnxpBLHKOdXw+d5TaIUI2OREYocyGoBD/Q+fqVH0LjSQbvTl14w3Bo/o+spvGw
         ZkAgPpinx3W4N2S35ffrq/b/Cwy0rOj0I5a760YXgL4SCFL55KvGRrPYDiDoP5sp56pP
         50UXUyt51M+GTX3J2s3GQNa75fb7PAkHDXUo9Mg8Bp7KGRZHsEh3i3A6/9l51VfaK0eR
         XWtDCS0+BIpTo0t/zDVUY2UIqNo3n5IocjkxDnDHTW00JANvPpbUMuDpCFiip4V3twlw
         cUlp2tJJmnDNr+OKnhH6EDgtA7ifeRufKZiYK8I5st+hvt36Q77APM/7rTfA8KxRbbOc
         I1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HayoOaOZQoP8erp/7VpQRc++DMVjYwyjCL0LDSZv+Zs=;
        fh=FthGvuR3K9/4OOpgmQJp7FB64mSmSiZB6V3xeZ/77Q8=;
        b=Be27v2aLgipm8svDouYAlXux8nYRqJOBoCE+ZTzCmQfCJEGcIaSNazj16ibKnLbh2Y
         LftemLCbjujKb3JIfev3AAbr0IA3fhfKBnMSP+uvK5Ss5mxvDytN+s7WZfBqxbMLryxB
         AT6EyxwLGkWTS5J8pKa6lNRdn8L5YzJNKz3gPh5su3kMd5t4TMnkP1thmCyYTJXP6qDI
         /pguoD7PJBH9PJ+AY2mmK4JSUEDv7Q2tZrbHDT5s9EmtNxi5wmcWLOxFULcByhseGM3x
         ui1AcgxswgXBNGKjapPDxRXqZTVLe6ON9Xr3i1CDc2PF3aIo1+90YFLJNRbjCw9HIjk6
         4oaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784861841; x=1785466641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HayoOaOZQoP8erp/7VpQRc++DMVjYwyjCL0LDSZv+Zs=;
        b=KAVsSkCDzcFBwHAzU/5/6KAD9KzP3SFzr0CQMbHb0lEnUZZSUA9KGw+c303GiKREAY
         +mMD2f3w0YNYNrvn34cKFqTzeKvoT5COBJwTKMrtzOeoQK1Y0qZbghNrAqquT+aQsDez
         dazeoI77PDy1CuggxBilt1ezNnnW27E7FqS7ag4WsuPONMF6qi+Q3/NYa8OdfdDFI22A
         nK6vcV9IgT9T2mP/LODZf76AxQaaW/KKhVEmfXouShlrjzQ0BaBmbW1wgVIF06PTNMO0
         CYzPGEGasdOrUsbmnrfIOIY5OIUX25Spw4+0p4wXTcOWKbnRK/k0Qka6CItECzlDQPdV
         PHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784861841; x=1785466641;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HayoOaOZQoP8erp/7VpQRc++DMVjYwyjCL0LDSZv+Zs=;
        b=RgV+egUW7gv8/WUxGPakgUfdYsZ1QoKWL0rQL47XrPEN0dalwZsVuke8XzIzWhTSqs
         rHvadGbbKOTiy0ZajWVGWe8KgpsO6hr3+razQBK4AxrNhFOQuLGIoEr0kmdlseM3Z2M4
         oFjI22itqPHhp/9r5m1gio7i1UHCn/pCApG9wlGMLpv/tD4VOuQUZWR3HYmHbwtCm9lg
         54G7kJhPur/Ak+HXWAnromg3/Dde/42AhJfdRS9VH5y17bz1XDhM7sVRY9ewHyyBA7MD
         It+5YVEuatA/GBgrXVbl7Dp6PO2t0Ij3RAsz1gadIeqQhmMbuhMz9CBsylegC4V/1iXD
         TFCA==
X-Gm-Message-State: AOJu0Yz+y08S036+zryBDA23+sWeINppkCKyVqlVxulazNTF1aKOv7T2
	489zU7HAkdlMPGqxqAEEeToigxHyPrApjC7aJDjfPLMIi4yW42C+FHNO4er5nc/X/Lg7pxXfRje
	+WRpqT40XNdUSKzy7ZAp8VmOHUzMfuV8=
X-Gm-Gg: AR+sD11Xf4YNXoWK8ckHKQduFx1OnaChA0xWLvNFQMvrSRYdqCt3WZhqj5Mf3sPPGMp
	4QHiZkpUcq2PG5BwO3nPqUlUYCVArll7Hn2Q276K3L3Lzpw3OD8ERFsTEMnDZBNeXKlozyaEM1A
	Zjb35c7n0BtqSXVRXLMWLF6zxiF4QPmUP4SY3q5UuhT1cbBU1Ow75xrjUuwvAhfJfbqPhVP1la9
	rvpljhPl3eg52QQb1rULABS16Z5Y0kuohCXvHG6ZvZupI1p8WFZae/n6YWZNgOiXElo3FvQkE47
	5DWcJEgfG3N/QkWQ52s=
X-Received: by 2002:a17:907:944e:b0:c15:ce72:935e with SMTP id
 a640c23a62f3a-c1c506f7064mr241978566b.17.1784861840969; Thu, 23 Jul 2026
 19:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722040830.387979-1-nickolay.lysenko@gmail.com>
 <20260722040830.387979-4-nickolay.lysenko@gmail.com> <bf9a1270d51e40e96dfaddf52cc17c8229b674a0.camel@gmail.com>
In-Reply-To: <bf9a1270d51e40e96dfaddf52cc17c8229b674a0.camel@gmail.com>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Thu, 23 Jul 2026 19:57:09 -0700
X-Gm-Features: AUfX_myJuD9uMVtj_Hy1anxugoY1m2fTE8OnxhLnAkGyBmaer3DGnGuSYuTFm2E
Message-ID: <CAMtxOX00fMeUXLz9mnpODwshofDedj0CUtbir1q6cvR1PfPXYQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 3/3] selftests/bpf: build each test runner
 instance in its own sub-make
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 6:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-07-21 at 21:08 -0700, Mykola Lysenko wrote:
>
> ...
>
> > ---
> >  tools/testing/selftests/bpf/Makefile          | 738 ++++++------------
> >  .../testing/selftests/bpf/Makefile.buildvars  |   8 +
> >  tools/testing/selftests/bpf/Makefile.runner   | 320 ++++++++
> >  3 files changed, 588 insertions(+), 478 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/Makefile.runner
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index ce589f102..34056db11 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -1,9 +1,35 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > +#
> > +# BPF selftests build.
> > +#
> > +# The build is split in two layers:
> > +#
> > +#   Makefile (this file)
> > +#       Everything that exists once: knobs and toolchain setup, libbpf=
 /
> > +#       bpftool / resolve_btfids sub-builds, vmlinux.h, signing keys,
> > +#       generated tests.h headers, shared helper objects, standalone t=
est
> > +#       binaries (bench, veristat, test_verifier, xsk*, ...), kernel t=
est
> > +#       modules, docs, and the kselftest lib.mk run/install/clean
> > +#       contract.
> > +#
> > +#   Makefile.runner
> > +#       One test-runner instance (test_progs, test_progs-<flavor>,
> > +#       test_maps): BPF objects, skeleton headers, test objects and th=
e
> > +#       final runner binary. Invoked from here once per instance; each
> > +#       invocation is an independent single-flavor namespace, so the
> > +#       runner is plain make without $$-escaping or eval.
> > +#
> > +#   gen_bpf_skel.sh
> > +#       Links BPF objects via bpftool and generates (light) skeletons;
> > +#       one script instead of four near-identical make recipes.
> > +#
> > +# Shared definitions (paths, flags, permissive-mode helpers) live in
> > +# Makefile.buildvars, included by both layers.
>
> Nit: let's minimize these comments.

Trimmed to five lines.

>
> ...
>
> > @@ -102,7 +108,7 @@ endef
> >  include ../lib.mk
> >
> >  NON_CHECK_FEAT_TARGETS :=3D clean docs-clean emit_tests
> > -CHECK_FEAT :=3D $(filter-out $(NON_CHECK_FEAT_TARGETS),$(or $(MAKECMDG=
OALS), "none"))
> > +CHECK_FEAT :=3D $(filter-out $(NON_CHECK_FEAT_TARGETS),$(or $(MAKECMDG=
OALS),all))
>
> Nit: this change seems unnecessary.

Reverted.

>
> ...
>
> > @@ -223,26 +238,15 @@ $(TEST_KMOD_TARGETS): $(addprefix test_kmods/,$(T=
EST_KMODS))
> >       $(Q)$(if $(PERMISSIVE),if [ -f test_kmods/$(@F) ]; then )cp test_=
kmods/$(@F) $@$(if $(PERMISSIVE),; fi)
> >
> >
> > -
> >  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
> >
>
> --- 8< ---------------------------------------------------
>
> > -TESTING_HELPERS      :=3D $(OUTPUT)/testing_helpers.o
> > -CGROUP_HELPERS       :=3D $(OUTPUT)/cgroup_helpers.o
> > -UNPRIV_HELPERS  :=3D $(OUTPUT)/unpriv_helpers.o
> > -TRACE_HELPERS        :=3D $(OUTPUT)/trace_helpers.o
> > -JSON_WRITER          :=3D $(OUTPUT)/json_writer.o
> > -CAP_HELPERS  :=3D $(OUTPUT)/cap_helpers.o
> > -NETWORK_HELPERS :=3D $(OUTPUT)/network_helpers.o
> > -
> > -$(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
> > -$(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(=
TRACE_HELPERS)
> > -$(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
> > -$(OUTPUT)/test_tag: $(TESTING_HELPERS)
> > -$(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
> > -$(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
> > -$(OUTPUT)/test_maps: $(TESTING_HELPERS)
> > -$(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HE=
LPERS)
> > -$(OUTPUT)/xsk.o: $(BPFOBJ)
>
> --------------------------------------------------- >8 ---
>
> These changes together with their '+' counterparts below seem
> unnecessary/out-of-scope.

Reverted.

>
> ...
>
> > @@ -336,288 +313,38 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD=
_DIR)/resolve_btfids   \
> >               HOSTPKG_CONFIG=3D'$(PKG_CONFIG)' \
> >               OUTPUT=3D$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=3D$(HOS=
T_BPFOBJ)
> >
> > -
> > -$(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS +=3D -fno-inline
> > -$(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS +=3D -fno-inline
>
> Are these -fno-inline flags dropped now?

They were already dead: those target-specific lines attach to
$(OUTPUT)/test_l4lb_noinline.o and $(OUTPUT)/test_xdp_noinline.o,
names nothing builds - the BPF objects have been %.bpf.o for years, so
the +=3D never reached any rule. Called out in the commit message now;
byte-identical artifacts confirm it.

>
> > -
> > -$(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
> > -$(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
> > -
> > -# Build BPF object using Clang
> > -# $1 - input .c file
> > -# $2 - output .o file
> > -# $3 - CFLAGS
> > -# $4 - binary name
> > -define CLANG_BPF_BUILD_RULE
> > -     $(call msg,CLNG-BPF,$4,$2)
> > -     $(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=3Dv3 -o $2 $=
(if $(PERMISSIVE),|| \
> > -             ($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)=
' 1>&2))
> > -endef
> > -# Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
> > -define CLANG_NOALU32_BPF_BUILD_RULE
> > -     $(call msg,CLNG-BPF,$4,$2)
> > -     $(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=3Dv2 -o $2 $=
(if $(PERMISSIVE),|| \
> > -             ($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)=
' 1>&2))
> > -endef
> > -# Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
> > -define CLANG_CPUV4_BPF_BUILD_RULE
> > -     $(call msg,CLNG-BPF,$4,$2)
> > -     $(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=3Dv4 -o $2 $=
(if $(PERMISSIVE),|| \
> > -             ($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)=
' 1>&2))
> > -endef
> > -# Build BPF object using GCC
> > -define GCC_BPF_BUILD_RULE
> > -     $(call msg,GCC-BPF,$4,$2)
> > -     $(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes =
-O2 -c $1 -o $2 $(if $(PERMISSIVE),|| \
> > -             ($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)=
' 1>&2))
> > -endef
>
> --- 8< ------------------------------------------------------------------=
-------
>
> > -SKEL_BLACKLIST :=3D btf__% test_pinning_invalid.c test_sk_assign.c
> > -
> > -LINKED_SKELS :=3D test_static_linked.skel.h linked_funcs.skel.h       =
         \
> > -             linked_vars.skel.h linked_maps.skel.h                   \
> > -             test_subskeleton.skel.h test_subskeleton_lib.skel.h     \
> > -             test_usdt.skel.h tracing_multi.skel.h                   \
> > -             tracing_multi_module.skel.h                             \
> > -             tracing_multi_intersect.skel.h                          \
> > -             tracing_multi_session.skel.h
> > -
> > -LSKELS :=3D fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.=
c        \
> > -     core_kern.c core_kern_overflow.c test_ringbuf.c                 \
> > -     test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
> > -     test_ringbuf_overwrite.c
> > -
> > -LSKELS_SIGNED :=3D fentry_test.c fexit_test.c atomics.c
> > -
> > -# Generate both light skeleton and libbpf skeleton for these
> > -LSKELS_EXTRA :=3D test_ksyms_module.c test_ksyms_weak.c kfunc_call_tes=
t.c \
> > -     kfunc_call_test_subprog.c
> > -SKEL_BLACKLIST +=3D $$(LSKELS) $$(LSKELS_SIGNED)
>
> -------------------------------------------------------------------------=
 >8 ---
>
> This group of changes appears together with accompanying "+" changes
> doing grep/sort/patsubst is an unrelated refactoring, let's drop it
> from this series.
>
> ...
>
> > +# --------------------------------------------------------------------=
-
> > +# Test runner instances, one sub-make each (see Makefile.runner).
> > +# --------------------------------------------------------------------=
-
> > +
> > +# The LLVM feature-probe results are exported to the runner sub-makes.
> > +# CC is passed explicitly instead: exporting it would also leak lib.mk=
's
> > +# CC into the libbpf/bpftool/resolve_btfids sub-builds, which compute
> > +# their own.
> > +export LLVM_CFLAGS LLVM_LDLIBS LLVM_LDFLAGS
> > +
> > +RUNNER_MAKE :=3D $(MAKE) -f Makefile.runner OUTPUT=3D$(OUTPUT) CC=3D'$=
(CC)'
> > +
> > +# Everything a runner instance references but does not know how to bui=
ld.
> > +RUNNER_PREREQS :=3D $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(BPFTOOL)     =
         \
> > +               $(TRUNNER_BPFTOOL) $(RESOLVE_BTFIDS)                  \
> > +               $(OUTPUT)/veristat                                    \
> > +               $(VERIFY_SIG_HDR) $(PRIVATE_KEY) $(VERIFICATION_CERT) \
> > +               $(LIBARENA_SKEL) $(LIBARENA_ASAN_SKEL)                \
> > +               prog_tests/tests.h                                    \
>                   ^^^^^^^^^^^^^^^^^^
> Shouldn't be needed map_tests.

Added map_tests/tests.h alongside it.

>
> > +               $(HELPER_OBJS)                                        \
> > +               $(OUTPUT)/urandom_read $(OUTPUT)/liburandom_read.so   \
> > +               $(OUTPUT)/xdp_synproxy $(OUTPUT)/sign-file            \
> > +               $(OUTPUT)/uprobe_multi $(TEST_KMOD_TARGETS)
>
> ...
>
> > diff --git a/tools/testing/selftests/bpf/Makefile.runner b/tools/testin=
g/selftests/bpf/Makefile.runner
> > new file mode 100644
> > index 000000000..7b0d9b1cf
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/Makefile.runner
>
> ...
>
> > +LINKED_SKELS :=3D test_static_linked.skel.h linked_funcs.skel.h       =
         \
> > +             linked_vars.skel.h linked_maps.skel.h                   \
> > +             test_subskeleton.skel.h test_subskeleton_lib.skel.h     \
> > +             test_usdt.skel.h tracing_multi.skel.h                   \
> > +             tracing_multi_module.skel.h                             \
> > +             tracing_multi_intersect.skel.h                          \
> > +             tracing_multi_session.skel.h
>
> Same nit about relative ordering of things as with the previous patch.

Makefile.runner now keeps the original relative order of these
definitions.

>
> ...
>
> > +ifeq ($(BPF_BUILD),gcc)
> > +BPF_CC_MSG :=3D GCC-BPF
> > +# Note: sys includes come from the *host* gcc, not $(BPF_GCC) - bpf-gc=
c's
> > +# own search path lacks the host's asm-generic/ headers. Computed once
> > +# here: bpf_cc below is deferred and expands per compiled object.
> > +GCC_SYS_INCLUDES :=3D $(call get_sys_includes,gcc,)
> > +bpf_cc =3D $(BPF_GCC) $(BPF_CFLAGS) $(GCC_SYS_INCLUDES)               =
         \
> > +      $(BPF_DEFINES) $($<-CFLAGS) $($<-$(FLAVOR)-CFLAGS)             \
> > +      -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $< -o $@
> > +else
> > +BPF_CC_MSG :=3D CLNG-BPF
> > +bpf_cc =3D $(CLANG) $(BPF_CFLAGS) $(CLANG_CFLAGS) $(BPF_DEFINES)      =
         \
> > +      $($<-CFLAGS) $($<-$(FLAVOR)-CFLAGS)                            \
> > +      -O2 $(BPF_TARGET_ENDIAN) -c $< -mcpu=3D$(BPF_MCPU) -o $@
> > +endif
>
> Is there a way to avoid this if-else block by tweaking parameters
> passed to Makefile.runner?

Yes

>
> > +
> > +$(BPF_OBJS): $(RDIR)/%.bpf.o: progs/%.c progs/*.h                    \
>                                  ^^^^^
> Previously this depended on runner specific TRUNNER_BPF_PROGS_DIR.
> Does it make test_maps dependent on all progs/* tests?
> Is the dependency on map_tests/* gone?

No on both counts. test_maps is invoked without BPF_CC, and the whole
BPF-objects section of Makefile.runner (including this rule) is inside
ifneq ($(BPF_CC),). So in the test_maps instance the progs/%.c rule is
never defined at all, and nothing there depends on progs/. The old
TRUNNER_BPF_PROGS_DIR role is played by the BPF_CC gate.
The map_tests/ dependencies are intact: the runner's test objects are built
from $(TESTS_DIR)/%.c with TESTS_DIR=3Dmap_tests, same set of prerequisites
as before.

>
> > +          $(INCLUDE_DIR)/vmlinux.h $(HEADERS_FOR_BPF_OBJS)           \
> > +          | $(RDIR) $(BPFOBJ)
> > +     $(call msg,$(BPF_CC_MSG),$(BINARY),$@)
> > +     $(Q)$(bpf_cc) $(call skip_on_fail,BPF)
>               ^^^^^^
> Would be nice to avoid this variable altogether and encode the rule
> directly.

Yes

>
> ...
>
> The whole thing is huge, I'll finish with the review tomorrow.

Thanks a lot for your review! It is a huge change indeed.
Thinking now, I should have split it into independent patches
instead of having it as a series of 3.
