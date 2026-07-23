Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEAA2C86D
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 01:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784768821; cv=none; b=VY+0pGdmnnO1ncvXlkX9Grk6OTjwjgiuxbQSK23sZZq7J+Lg2e/4HkZID0uDgMM9yccavklh7nXsQt0thIUHRK+YW5Kqg1Vm6cwmweCHkztmXZWIW7RwKJZMqqV0uFyI9BCFWmU8GPRqmogoiW5N+W+3N8AOMbytILTzfPNwRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784768821; c=relaxed/simple;
	bh=p1YYYIygdAYs+b4cSNuuJ7OBIvIPGLT2mwArPesGoJ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hUcuweY6WqrHFXDpEox0FEdC6tkzYF3gVLjmnWopb9bIKU1Lnn1aB+4J872KLAGvxF8Tbp6o7stnOsWcBGjQev9y138rZhBTTerJLg3Eh9dSgFqqAQZK82566B7KBjUpuxuvGjW4Oigx2UyFRacyrcoRvInipg/p5Lgzzm9azWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+Kel0aN; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+Kel0aN"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so71605a12.2
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 18:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784768820; x=1785373620; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=T4cIk/OcayfNnHvEvvbaO3C3xtBkKl4y8KCHRHkJKtI=;
        b=Z+Kel0aN+LevHm/VVUODMTIhEcODL/RJx822cCrUH7Y6hOeXkQ/dPfaypotMfitLEu
         YILNW1pdnLqMoXxChpDw0lastGoCh0+7BMNiZ693lkrQzZ9iQoJtbVHFSL6lUOALel9z
         mFSmB88yDYgotQiCZzD2aLUkoBg+ivR/+Jw+4589YEcZ4f+wXYfqNZTKevHixcPFiUwb
         Bs0mFhHSpkaGkXzI8EkwAglCvv9JO4+Y+15RD1jodiUk7z0t/GpSGHpoGAh/3wcOGOOI
         Lx5FV25eOIM48BZ1ysv6ZUm/QfA19ax/ebDtY1rJaD4D26/N1NZSPYsAokGHBHMKVQ8x
         nMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784768820; x=1785373620;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T4cIk/OcayfNnHvEvvbaO3C3xtBkKl4y8KCHRHkJKtI=;
        b=D4EFdK4KdHvhG9Jk6T9U5TFML7zWcmm7ERja+bZHLlVlsfhAS4tEBFGp8cx8wBproE
         esxl9/11jidHaLZ7DtGEy/RKGmvjh2ll+med4phhCoFhOLPoPT2QPt1sCfq1iyl8oFgA
         jGlwYP0S7d+aHv1BpsS5gkugeEGw+VJ8cap5crIJZL2UMIBIYzqrTEE1wtlSI/RhuB+c
         E7Ndp25sA1OPg6WCGUnDWYicRS3OVjbrirD1/W5/UfhCR+rmGG6sEskvxjEMzVifKNEP
         hqXg1AH+yxuiVjwmJgazEGLDdpe8+wKKeSRJZ3Pq/YvZNPypwHVM2UewJBJUqAa95s2s
         wA6w==
X-Forwarded-Encrypted: i=1; AHgh+Rr+KNwjAMQrQqyAyKYpFAEFBe5HwlobEuFTkA/9o1Mr4B9w/CVCaVMWcwIY32f1S3HTQto=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKVikxlWKBONO7xG5DbpZbikFfVql3v8rWJ8YrWVyfkdurbzb8
	xPrcAZlliRloKR5qDzYmkeet91SfYuhTUs0vP5sMcUxGugkxL5wFH6Op
X-Gm-Gg: AR+sD13wilCrSvBDa4Ow61gVaARHQDCRWGKre+stNfVnurxiZQ7LgIaXvtCBLzX8fYU
	n0pWNq+9GmAeY7/4JyfIyvFZ460EW0tmTa1UUksmC/Wgo2s4BK0nSKpb7YAPTGq1cHfaF+KLhw3
	BJWoneD3WFan2OeOwfJPiRdNzr2qecD29MVBcnr8O/aa/J7epABrNZMLzvEW/Sg0MPgBKEpSCMc
	fuZ0bOzN4ddnbmITW9U0okDsq8bEV4jHSy1lKpGobr4gUgedX2MTCtPhmZhS3HxsQ+7GVErbugY
	WMMQASydd9oS9vzQmAFSs1VV5f6ZWypsoUf238MBCzk1zFt/GgBUkO4F/OjpP5W9EfgTPUHjOXd
	Cyk+E6753K17bAGOPTLd5RmXQq+iy/U+Mbzk1AMaFUSLZAV0W2ty7JhPf5o83H6jRfHD/vfQgvY
	YKEZjoPZHm3cPfjnzs/m4UTcESUwkg8JXO13ag4h5DOkRo0SF7u2kJj/QhCg4=
X-Received: by 2002:a05:6a20:9c8c:b0:3bf:6c08:4ebb with SMTP id adf61e73a8af0-3c44b18ac6cmr959655637.48.1784768819542;
        Wed, 22 Jul 2026 18:06:59 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:d806:89cb:d651:6dc8? ([2620:10d:c090:500::1:d474])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc6781dsm14599050eec.9.2026.07.22.18.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 18:06:59 -0700 (PDT)
Message-ID: <bf9a1270d51e40e96dfaddf52cc17c8229b674a0.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 3/3] selftests/bpf: build each test
 runner instance in its own sub-make
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com
Date: Wed, 22 Jul 2026 18:06:57 -0700
In-Reply-To: <20260722040830.387979-4-nickolay.lysenko@gmail.com>
References: <20260722040830.387979-1-nickolay.lysenko@gmail.com>
	 <20260722040830.387979-4-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-21 at 21:08 -0700, Mykola Lysenko wrote:

...

> ---
>  tools/testing/selftests/bpf/Makefile          | 738 ++++++------------
>  .../testing/selftests/bpf/Makefile.buildvars  |   8 +
>  tools/testing/selftests/bpf/Makefile.runner   | 320 ++++++++
>  3 files changed, 588 insertions(+), 478 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/Makefile.runner
>=20
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index ce589f102..34056db11 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -1,9 +1,35 @@
>  # SPDX-License-Identifier: GPL-2.0
> +#
> +# BPF selftests build.
> +#
> +# The build is split in two layers:
> +#
> +#   Makefile (this file)
> +#       Everything that exists once: knobs and toolchain setup, libbpf /
> +#       bpftool / resolve_btfids sub-builds, vmlinux.h, signing keys,
> +#       generated tests.h headers, shared helper objects, standalone tes=
t
> +#       binaries (bench, veristat, test_verifier, xsk*, ...), kernel tes=
t
> +#       modules, docs, and the kselftest lib.mk run/install/clean
> +#       contract.
> +#
> +#   Makefile.runner
> +#       One test-runner instance (test_progs, test_progs-<flavor>,
> +#       test_maps): BPF objects, skeleton headers, test objects and the
> +#       final runner binary. Invoked from here once per instance; each
> +#       invocation is an independent single-flavor namespace, so the
> +#       runner is plain make without $$-escaping or eval.
> +#
> +#   gen_bpf_skel.sh
> +#       Links BPF objects via bpftool and generates (light) skeletons;
> +#       one script instead of four near-identical make recipes.
> +#
> +# Shared definitions (paths, flags, permissive-mode helpers) live in
> +# Makefile.buildvars, included by both layers.

Nit: let's minimize these comments.

...

> @@ -102,7 +108,7 @@ endef
>  include ../lib.mk
> =20
>  NON_CHECK_FEAT_TARGETS :=3D clean docs-clean emit_tests
> -CHECK_FEAT :=3D $(filter-out $(NON_CHECK_FEAT_TARGETS),$(or $(MAKECMDGOA=
LS), "none"))
> +CHECK_FEAT :=3D $(filter-out $(NON_CHECK_FEAT_TARGETS),$(or $(MAKECMDGOA=
LS),all))

Nit: this change seems unnecessary.

...

> @@ -223,26 +238,15 @@ $(TEST_KMOD_TARGETS): $(addprefix test_kmods/,$(TES=
T_KMODS))
>  	$(Q)$(if $(PERMISSIVE),if [ -f test_kmods/$(@F) ]; then )cp test_kmods/=
$(@F) $@$(if $(PERMISSIVE),; fi)
> =20
> =20
> -
>  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
>

--- 8< ---------------------------------------------------

> -TESTING_HELPERS	:=3D $(OUTPUT)/testing_helpers.o
> -CGROUP_HELPERS	:=3D $(OUTPUT)/cgroup_helpers.o
> -UNPRIV_HELPERS  :=3D $(OUTPUT)/unpriv_helpers.o
> -TRACE_HELPERS	:=3D $(OUTPUT)/trace_helpers.o
> -JSON_WRITER		:=3D $(OUTPUT)/json_writer.o
> -CAP_HELPERS	:=3D $(OUTPUT)/cap_helpers.o
> -NETWORK_HELPERS :=3D $(OUTPUT)/network_helpers.o
> -
> -$(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
> -$(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TR=
ACE_HELPERS)
> -$(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
> -$(OUTPUT)/test_tag: $(TESTING_HELPERS)
> -$(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
> -$(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
> -$(OUTPUT)/test_maps: $(TESTING_HELPERS)
> -$(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELP=
ERS)
> -$(OUTPUT)/xsk.o: $(BPFOBJ)

--------------------------------------------------- >8 ---

These changes together with their '+' counterparts below seem
unnecessary/out-of-scope.

...

> @@ -336,288 +313,38 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_D=
IR)/resolve_btfids	\
>  		HOSTPKG_CONFIG=3D'$(PKG_CONFIG)' \
>  		OUTPUT=3D$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=3D$(HOST_BPFOBJ)
> =20
> -
> -$(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS +=3D -fno-inline
> -$(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS +=3D -fno-inline

Are these -fno-inline flags dropped now?

> -
> -$(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
> -$(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
> -
> -# Build BPF object using Clang
> -# $1 - input .c file
> -# $2 - output .o file
> -# $3 - CFLAGS
> -# $4 - binary name
> -define CLANG_BPF_BUILD_RULE
> -	$(call msg,CLNG-BPF,$4,$2)
> -	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=3Dv3 -o $2 $(if $(=
PERMISSIVE),|| \
> -		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2))
> -endef
> -# Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
> -define CLANG_NOALU32_BPF_BUILD_RULE
> -	$(call msg,CLNG-BPF,$4,$2)
> -	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=3Dv2 -o $2 $(if $(=
PERMISSIVE),|| \
> -		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2))
> -endef
> -# Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
> -define CLANG_CPUV4_BPF_BUILD_RULE
> -	$(call msg,CLNG-BPF,$4,$2)
> -	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=3Dv4 -o $2 $(if $(=
PERMISSIVE),|| \
> -		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2))
> -endef
> -# Build BPF object using GCC
> -define GCC_BPF_BUILD_RULE
> -	$(call msg,GCC-BPF,$4,$2)
> -	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c=
 $1 -o $2 $(if $(PERMISSIVE),|| \
> -		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2))
> -endef

--- 8< --------------------------------------------------------------------=
-----

> -SKEL_BLACKLIST :=3D btf__% test_pinning_invalid.c test_sk_assign.c
> -
> -LINKED_SKELS :=3D test_static_linked.skel.h linked_funcs.skel.h		\
> -		linked_vars.skel.h linked_maps.skel.h 			\
> -		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
> -		test_usdt.skel.h tracing_multi.skel.h			\
> -		tracing_multi_module.skel.h				\
> -		tracing_multi_intersect.skel.h				\
> -		tracing_multi_session.skel.h
> -
> -LSKELS :=3D fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c =
	\
> -	core_kern.c core_kern_overflow.c test_ringbuf.c			\
> -	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
> -	test_ringbuf_overwrite.c
> -
> -LSKELS_SIGNED :=3D fentry_test.c fexit_test.c atomics.c
> -
> -# Generate both light skeleton and libbpf skeleton for these
> -LSKELS_EXTRA :=3D test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.=
c \
> -	kfunc_call_test_subprog.c
> -SKEL_BLACKLIST +=3D $$(LSKELS) $$(LSKELS_SIGNED)

------------------------------------------------------------------------- >=
8 ---

This group of changes appears together with accompanying "+" changes
doing grep/sort/patsubst is an unrelated refactoring, let's drop it
from this series.

...

> +# ---------------------------------------------------------------------
> +# Test runner instances, one sub-make each (see Makefile.runner).
> +# ---------------------------------------------------------------------
> +
> +# The LLVM feature-probe results are exported to the runner sub-makes.
> +# CC is passed explicitly instead: exporting it would also leak lib.mk's
> +# CC into the libbpf/bpftool/resolve_btfids sub-builds, which compute
> +# their own.
> +export LLVM_CFLAGS LLVM_LDLIBS LLVM_LDFLAGS
> +
> +RUNNER_MAKE :=3D $(MAKE) -f Makefile.runner OUTPUT=3D$(OUTPUT) CC=3D'$(C=
C)'
> +
> +# Everything a runner instance references but does not know how to build=
.
> +RUNNER_PREREQS :=3D $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(BPFTOOL)		\
> +		  $(TRUNNER_BPFTOOL) $(RESOLVE_BTFIDS)			\
> +		  $(OUTPUT)/veristat					\
> +		  $(VERIFY_SIG_HDR) $(PRIVATE_KEY) $(VERIFICATION_CERT)	\
> +		  $(LIBARENA_SKEL) $(LIBARENA_ASAN_SKEL)		\
> +		  prog_tests/tests.h					\
                  ^^^^^^^^^^^^^^^^^^
Shouldn't be needed map_tests.

> +		  $(HELPER_OBJS)					\
> +		  $(OUTPUT)/urandom_read $(OUTPUT)/liburandom_read.so	\
> +		  $(OUTPUT)/xdp_synproxy $(OUTPUT)/sign-file		\
> +		  $(OUTPUT)/uprobe_multi $(TEST_KMOD_TARGETS)

...

> diff --git a/tools/testing/selftests/bpf/Makefile.runner b/tools/testing/=
selftests/bpf/Makefile.runner
> new file mode 100644
> index 000000000..7b0d9b1cf
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/Makefile.runner

...

> +LINKED_SKELS :=3D test_static_linked.skel.h linked_funcs.skel.h		\
> +		linked_vars.skel.h linked_maps.skel.h			\
> +		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
> +		test_usdt.skel.h tracing_multi.skel.h			\
> +		tracing_multi_module.skel.h				\
> +		tracing_multi_intersect.skel.h				\
> +		tracing_multi_session.skel.h

Same nit about relative ordering of things as with the previous patch.

...

> +ifeq ($(BPF_BUILD),gcc)
> +BPF_CC_MSG :=3D GCC-BPF
> +# Note: sys includes come from the *host* gcc, not $(BPF_GCC) - bpf-gcc'=
s
> +# own search path lacks the host's asm-generic/ headers. Computed once
> +# here: bpf_cc below is deferred and expands per compiled object.
> +GCC_SYS_INCLUDES :=3D $(call get_sys_includes,gcc,)
> +bpf_cc =3D $(BPF_GCC) $(BPF_CFLAGS) $(GCC_SYS_INCLUDES)			\
> +	 $(BPF_DEFINES) $($<-CFLAGS) $($<-$(FLAVOR)-CFLAGS)		\
> +	 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $< -o $@
> +else
> +BPF_CC_MSG :=3D CLNG-BPF
> +bpf_cc =3D $(CLANG) $(BPF_CFLAGS) $(CLANG_CFLAGS) $(BPF_DEFINES)		\
> +	 $($<-CFLAGS) $($<-$(FLAVOR)-CFLAGS)				\
> +	 -O2 $(BPF_TARGET_ENDIAN) -c $< -mcpu=3D$(BPF_MCPU) -o $@
> +endif

Is there a way to avoid this if-else block by tweaking parameters
passed to Makefile.runner?

> +
> +$(BPF_OBJS): $(RDIR)/%.bpf.o: progs/%.c progs/*.h			\
                                 ^^^^^
Previously this depended on runner specific TRUNNER_BPF_PROGS_DIR.
Does it make test_maps dependent on all progs/* tests?
Is the dependency on map_tests/* gone?

> +	     $(INCLUDE_DIR)/vmlinux.h $(HEADERS_FOR_BPF_OBJS)		\
> +	     | $(RDIR) $(BPFOBJ)
> +	$(call msg,$(BPF_CC_MSG),$(BINARY),$@)
> +	$(Q)$(bpf_cc) $(call skip_on_fail,BPF)
              ^^^^^^
Would be nice to avoid this variable altogether and encode the rule
directly.

...

The whole thing is huge, I'll finish with the review tomorrow.
