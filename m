Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4993D565B
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786003361; cv=none; b=dQaWdXzI6v4GQDloXjgLRyugem8M9IDWNUDe67yf0n+QeY8AFp7s90TGXkplkZJlIZbwvwiR5ZeHjmmFdJewisKcRNgqiCV4Ne/stqzTSOCItx1W0nVCvfkwgHMcg24nuvPDXhfFiOzRdBN5yKiQGqAliKorNifV+fm/PwCR84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786003361; c=relaxed/simple;
	bh=hGzxzF9/JmbeDawkqSCKlW1wp6VAzGG7Hw9X481Ku94=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HFTHGFyljtQeMEJx1jGs92ll6h12wCI9rBuoGmkyvd4nrpOTRkL7tIDqEfmKvoS9EZrag417yyFGCfwIBlLYsesZ0uq28045Cpl9ca0PwPOXf7sjnXbxloVVr8YDHRLT02aqNXUO9C1iu7ZQvUhxlWe1D0DidL7c7ZNnD3tCtEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSVBihvq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSVBihvq"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccf2360620so18799945ad.3
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 01:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786003359; x=1786608159; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TtujSMZaXhDDcsEPY9OVKDb7XUN6oPWUUEmgnvxbDRQ=;
        b=FSVBihvqIZpj6qexNbFUbPNsU+7DsPjboC6yRww9vqWar3Z9wc0eLhSJrqe1won125
         NxgjRhFDVzjWRq9b/PdfU9twu7/DkjB8mt9/xaYDgQB7/7yb5ntsr7dKQ6aKSQkK8PxN
         WrAm7A+XkF4SIdPlNPLK1JgtnpZsEghxlddfm7f/83UInEBgJOaiOszfHsUfcyd3DeSJ
         97Rt2eq5/WXzvrksejYj6i846U9Pql/fou8YjNvoPIpG50+Z/IvD0Iz23wUzFI8zzUCY
         942H7VlMSqyAQNvFa5DI6N0Z7Ql+CP9i9P+Z2Q/jMZPtIeylnuLx2tjgOrZiuVo28BV/
         c68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786003359; x=1786608159;
        h=mime-version:user-agent:content-type:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TtujSMZaXhDDcsEPY9OVKDb7XUN6oPWUUEmgnvxbDRQ=;
        b=ixSPRM6uBQh9QtOxtb8teiCW2m3Ctf81Z/UdwvtLZD8YZYZlR6YiqLftkOjJbdf5Cu
         m7v5M7UZUGVKkdgw1DFfGNQBBmn788eIRKtZgnTYB/NbHhr+exhQATiIiWc45s2CPCsW
         /5jBJj7V2jA+ERE8t//eX2oKnoX8ftf1wNcbbKiA7PZsIRmwE9D9lQ5OO81kRPL0Ma5n
         C1YvU3Ppv168xmKlGjJsMtrNtAEZbpeiVKzzb6FjTLKoqEnTnu3K9SWCZZYHB7BC9RT5
         3r3guLOhibx6qFzw0TWcq0epSevbKbU4WaIWJnEJcdDHghRxPBUYujM3XauciuzqZdYK
         HEgA==
X-Forwarded-Encrypted: i=1; AHgh+Rolg4E7weqjSkXld+GW/zxrqwmthT3o0+HS02jDgNXgwVMZANtc4SwS57xdDJ58jXyk20E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvsUezvT13nEDpvXivLineJHWz62fKjhCq21zOpdB+QtS+P9AN
	j+6UqSn7gOkQ092H4BM7KlK2icGcm6MzKOG/Swv294F6V3KIYKec8Tam
X-Gm-Gg: AR+sD10gyqJM+EhHunTHDOa0ta3rVYDC5AJlcaq7IQtyitvurxdd8sOHmQQBHcDLrLC
	/Wr7vO+MVT0RHf4zbVDvGSRLWVzs9mqLAUwwDPD/KzauLurwN0kuilEjX3ZuR3yLn9iJyzq2cLo
	9Gb2PWXOa4thUoiAcb+0H/VQeRrgXeF95p90C2+97tmlUU8imMFFxiIPYleDLM6+E6KRT6m5K12
	kjGOzK+0PSHX03hBWwJJYj7kszEIyJprPz4n6lJnXS11og8WC9B9B9HWpOyibC+od51aCs3Sfn8
	xbebyYT3z5RtgIsrzQf23SEMgyIUKyRP9+Jj02g9bJVYqSVm1OTlowSXwmIO5yIQ+f8K4HXwcmZ
	Abx1Y1RHbLMzFmIBA3KS4XZOs35GzbgITvxhOPzd+nfwP/9FoVF0Gp644zHugrZB9to2641RFAI
	yuP6EpnUy6zKyGtQ3dpdk6tmOSeVM1jLu0f7FPwX7qadjO9jo07khB37Nxp2l2WLyyK4kGX/SKK
	zv8pR0VsDH9vGm+pQ==
X-Received: by 2002:a17:903:41ca:b0:2c9:c083:cd50 with SMTP id d9443c01a7336-2d0ca981ba4mr123744345ad.17.1786003358902;
        Thu, 06 Aug 2026 01:02:38 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9ff4f33sm28249455ad.25.2026.08.06.01.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 01:02:38 -0700 (PDT)
Message-ID: <8da8aa48afa6ef52c22f976793af75b334b189a1.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v5 8/8] selftests/bpf: build each test
 runner instance in its own sub-make
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com
Date: Thu, 06 Aug 2026 01:02:35 -0700
In-Reply-To: <20260804170156.1709916-9-nickolay.lysenko@gmail.com>
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
	 <20260804170156.1709916-9-nickolay.lysenko@gmail.com>
Content-Type: multipart/mixed; boundary="=-6h88wX0oq1hJDr0Kofjg"
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-6h88wX0oq1hJDr0Kofjg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-08-04 at 10:01 -0700, Mykola Lysenko wrote:

...

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 58c567a22..af3709d51 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

...

> @@ -262,6 +249,35 @@ $(OUTPUT)/test_maps: $(TESTING_HELPERS)
>  $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELP=
ERS)
>  $(OUTPUT)/xsk.o: $(BPFOBJ)
>
> +# All helper objects a runner instance links, pre-built here so runner
> +# sub-makes sharing $(OUTPUT) never compile them concurrently.
> +HELPER_OBJS :=3D $(TESTING_HELPERS) $(CGROUP_HELPERS) $(UNPRIV_HELPERS)	=
\
> +	       $(TRACE_HELPERS) $(JSON_WRITER) $(CAP_HELPERS)		\
> +	       $(NETWORK_HELPERS) $(OUTPUT)/usdt_1.o $(OUTPUT)/usdt_2.o	\
> +	       $(OUTPUT)/xsk.o
> +
> +# $(BPFTOOL) is a prerequisite because its sub-make is what installs
> +# libbpf's internal headers (bpf/hashmap.h, bpf/libbpf_internal.h) into
> +# $(INCLUDE_DIR); without it, helpers including those headers race the
> +# install and can silently pick up the source-tree copies instead.
> +#
> +# Invariant: this list must be a superset of every prerequisite the
> +# runner's EXTRA_OBJS rule attaches to these same objects (EXTRA_HDRS,
> +# both tests.h flavors, $(BPFOBJ)). It guarantees the helpers built
> +# here are never older than a runner-side prerequisite, so the
> +# unflavored test_progs and test_maps sub-makes, which share $(OUTPUT),
> +# treat them as up to date instead of both recompiling the same object
> +# file concurrently.
> +$(HELPER_OBJS): flow_dissector_load.h ip_check_defrag_frags.h		\
> +		$(VERIFY_SIG_HDR) $(LIBARENA_SKEL) $(LIBARENA_ASAN_SKEL)\
> +		prog_tests/tests.h map_tests/tests.h $(BPFOBJ) $(BPFTOOL)
> +

Tbh, I don't understand what this comment is attempting to convey and
maintaining the invariant would be taxing going forward. LLM is also
trying to convince me that several dependencies are missing from the
list:

  test_progs.o btf_helpers.o sysctl_helpers.o netlink_helpers.o
  jit_disasm_helpers.o io_helpers.o test_loader.o disasm.o
  disasm_helpers.o bpftool_helpers.o find_bit.o

Which would form a race when compiling test_progs and test_maps that
both share the same $(OUTPUT) directory. This seem plausible.

How about a change as in the attached patch? (squashed with this patch).
It sidesteps a previously discussed constraint to keep refactoring to
the minimum, but HELPER_OBJS is just too ugly to pass.

> +$(OUTPUT)/flow_dissector_load: flow_dissector_load.h
> +
> +# Tool sub-builds: bpftool, libbpf (host and, when cross-compiling,
> +# target variants) and resolve_btfids. Deliberate asymmetry: the host
> +# libbpf builds without sanitizers and with the host toolchain.

Nit: is this comment necessary?

>  $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefi=
le)    \
>  		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
>  	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \

...

> @@ -672,81 +413,125 @@ $(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h $(=
BPFOBJ) $(LIBARENA_BPF_DEPS)

...

> +# Everything a runner instance references but does not know how to build=
.
> +RUNNER_PREREQS :=3D $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(BPFTOOL)		\
> +		  $(TRUNNER_BPFTOOL) $(RESOLVE_BTFIDS)			\
> +		  $(OUTPUT)/veristat					\
> +		  $(VERIFY_SIG_HDR) $(PRIVATE_KEY) $(VERIFICATION_CERT)	\
> +		  $(LIBARENA_SKEL) $(LIBARENA_ASAN_SKEL)		\
> +		  prog_tests/tests.h map_tests/tests.h			\
> +		  $(HELPER_OBJS)					\
> +		  $(OUTPUT)/urandom_read $(OUTPUT)/liburandom_read.so	\
> +		  $(OUTPUT)/xdp_synproxy $(OUTPUT)/sign-file		\
> +		  $(OUTPUT)/uprobe_multi $(TEST_KMOD_TARGETS)
> +
> +FORCE:

Nit: please drop a line here, saying that the main makefile does not
     know if $(OUTPUT)/test_progs is stale, hence FORCE to force
     delegation to Makefile.runner.

> +
> +# The default flavor's skeletons are also inputs of bench, test_maps,
> +# xskxceiver, xdp_* and test_cpp; "default-skels" builds just those
> +# without the test_progs test objects and binary.
> +.PHONY: default-skels
> +default-skels: $(RUNNER_PREREQS)
> +	+$(Q)$(RUNNER_MAKE) RUNNER=3Dtest_progs FLAVOR=3D TESTS_DIR=3Dprog_test=
s \
> +		BPF_CC=3D'$(CLANG)' BPF_CC_MSG=3DCLNG-BPF BPF_SYS_INCLUDES=3D'$(CLANG_=
SYS_INCLUDES)'	\
> +		BPF_CC_FLAGS=3D'-O2 $(BPF_TARGET_ENDIAN) -mcpu=3Dv3'		\
> +		BPF_DEFINES=3D-DENABLE_ATOMICS_TESTS skels
> +
> +$(OUTPUT)/test_progs: $(RUNNER_PREREQS) default-skels FORCE
> +	+$(Q)$(RUNNER_MAKE) RUNNER=3Dtest_progs FLAVOR=3D TESTS_DIR=3Dprog_test=
s \
> +		BPF_CC=3D'$(CLANG)' BPF_CC_MSG=3DCLNG-BPF BPF_SYS_INCLUDES=3D'$(CLANG_=
SYS_INCLUDES)'	\
> +		BPF_CC_FLAGS=3D'-O2 $(BPF_TARGET_ENDIAN) -mcpu=3Dv3'		\
> +		BPF_DEFINES=3D-DENABLE_ATOMICS_TESTS

Is there a way to reduce copy-paste between default-skels and
test_progs? Why does test_progs depend on default-skels?

> +
> +$(OUTPUT)/test_progs-no_alu32: $(RUNNER_PREREQS) FORCE
> +	+$(Q)$(RUNNER_MAKE) RUNNER=3Dtest_progs FLAVOR=3Dno_alu32 TESTS_DIR=3Dp=
rog_tests \
> +		BPF_CC=3D'$(CLANG)' BPF_CC_MSG=3DCLNG-BPF BPF_SYS_INCLUDES=3D'$(CLANG_=
SYS_INCLUDES)'	\
> +		BPF_CC_FLAGS=3D'-O2 $(BPF_TARGET_ENDIAN) -mcpu=3Dv2'
> +
>  ifneq ($(CLANG_CPUV4),)
> -TRUNNER_BPF_BUILD_RULE :=3D CLANG_CPUV4_BPF_BUILD_RULE
> -TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_T=
ESTS
> -$(eval $(call DEFINE_TEST_RUNNER,test_progs,cpuv4))
> +$(OUTPUT)/test_progs-cpuv4: $(RUNNER_PREREQS) FORCE
> +	+$(Q)$(RUNNER_MAKE) RUNNER=3Dtest_progs FLAVOR=3Dcpuv4 TESTS_DIR=3Dprog=
_tests \
> +		BPF_CC=3D'$(CLANG)' BPF_CC_MSG=3DCLNG-BPF BPF_SYS_INCLUDES=3D'$(CLANG_=
SYS_INCLUDES)'	\
> +		BPF_CC_FLAGS=3D'-O2 $(BPF_TARGET_ENDIAN) -mcpu=3Dv4'		\
> +		BPF_DEFINES=3D-DENABLE_ATOMICS_TESTS
>  endif
>
> -# Define test_progs BPF-GCC-flavored test runner.
>  ifneq ($(BPF_GCC),)
> -TRUNNER_BPF_BUILD_RULE :=3D GCC_BPF_BUILD_RULE
> -TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(call get_sys_includes,gcc,)
> -$(eval $(call DEFINE_TEST_RUNNER,test_progs,bpf_gcc))
> +# Sys includes come from the *host* gcc, not $(BPF_GCC) - bpf-gcc's own
> +# search path lacks the host's asm-generic/ headers.
> +GCC_SYS_INCLUDES :=3D $(call get_sys_includes,gcc,)
> +
> +$(OUTPUT)/test_progs-bpf_gcc: $(RUNNER_PREREQS) FORCE
> +	+$(Q)$(RUNNER_MAKE) RUNNER=3Dtest_progs FLAVOR=3Dbpf_gcc TESTS_DIR=3Dpr=
og_tests \
> +		BPF_CC=3D'$(BPF_GCC)' BPF_CC_MSG=3DGCC-BPF				\
> +		BPF_SYS_INCLUDES=3D'$(GCC_SYS_INCLUDES)'				\
> +		BPF_CC_FLAGS=3D'-DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2'
>  endif

Did you test the bpf_gcc flavor?
I have a recipe to build the toolchain somewhere, if you need it.

>
> -# Define test_maps test runner.
> -TRUNNER_TESTS_DIR :=3D map_tests
> -TRUNNER_BPF_PROGS_DIR :=3D progs
> -TRUNNER_EXTRA_SOURCES :=3D test_maps.c
> -TRUNNER_LIB_SOURCES :=3D
> -TRUNNER_EXTRA_FILES :=3D
> -TRUNNER_BPF_BUILD_RULE :=3D $$(error no BPF objects should be built)
> -TRUNNER_BPF_CFLAGS :=3D
> -$(eval $(call DEFINE_TEST_RUNNER,test_maps))
> -
> -# Define test_verifier test runner.
> -# It is much simpler than test_maps/test_progs and sufficiently differen=
t from
> -# them (e.g., test.h is using completely pattern), that it's worth just
> -# explicitly defining all the rules explicitly.
> +# test_maps compiles map_tests/*.c against the default flavor's skeleton=
s
> +$(OUTPUT)/test_maps: $(RUNNER_PREREQS) map_tests/tests.h default-skels F=
ORCE
> +	+$(Q)$(RUNNER_MAKE) RUNNER=3Dtest_maps FLAVOR=3D TESTS_DIR=3Dmap_tests
> +
> +# Default-flavor BPF objects and skeletons consumed by targets in this
> +# Makefile (and by lib.mk's install rule) are produced by the runner
> +# sub-make above; the empty recipe plus the order-only prerequisite
> +# makes them available here without duplicating the runner's rules.
> +DEFAULT_BPF_OBJS :=3D $(patsubst progs/%.c,$(OUTPUT)/%.bpf.o,$(wildcard =
progs/*.c))
> +TEST_GEN_FILES +=3D $(DEFAULT_BPF_OBJS)

--- 8< --------------------------------------------------------------------=
------

> +BENCH_SKELS :=3D $(addprefix $(OUTPUT)/,					\
> +	       test_overhead.skel.h trigger_bench.skel.h		\
> +	       ringbuf_bench.skel.h perfbuf_bench.skel.h		\
> +	       bloom_filter_bench.skel.h bpf_loop_bench.skel.h		\
> +	       strncmp_bench.skel.h bpf_hashmap_full_update_bench.skel.h\
> +	       local_storage_bench.skel.h				\
> +	       local_storage_rcu_tasks_trace_bench.skel.h		\
> +	       bench_local_storage_create.skel.h			\
> +	       bpf_hashmap_lookup.skel.h htab_mem_bench.skel.h		\
> +	       crypto_bench.skel.h bench_sockmap_prog.skel.h		\
> +	       lpm_trie_bench.skel.h lpm_trie_map.skel.h		\
> +	       bpf_nop_bench.skel.h xdp_lb_bench.skel.h)
> +TOP_SKELS :=3D $(addprefix $(OUTPUT)/,xsk_xdp_progs.skel.h		\
> +	     xdp_hw_metadata.skel.h xdp_features.skel.h			\
> +	     test_core_extern.skel.h) $(BENCH_SKELS)
> +
> +# Empty-recipe delegation: "default-skels" (re)builds the file via the
> +# runner sub-make, after which make re-stats the target, so dependents
> +# see fresh timestamps within the same invocation. Dependents still
> +# rebuild on mtime only - the phony prerequisite does not cascade.
> +$(DEFAULT_BPF_OBJS) $(TOP_SKELS): default-skels ;

-------------------------------------------------------------------------- =
>8 ---

Note, the above two lists can be replaced with the following two rules:

  $(OUTPUT)/%.skel.h: default-skels ;
  $(DEFAULT_BPF_OBJS): default-skels ;

> +
> +# Standalone test binaries
> +
> +# test_verifier is much simpler than test_maps/test_progs and
> +# sufficiently different from them (e.g., its tests.h uses a completely
> +# different pattern), that it's worth just defining its rules explicitly=
.
>  verifier/tests.h: verifier/*.c
>  	$(Q)( cd verifier/; \
>  		  echo '/* Generated header, do not edit */'; \

...

--=-6h88wX0oq1hJDr0Kofjg
Content-Disposition: attachment; filename="common-objects.diff"
Content-Type: text/x-patch; name="common-objects.diff"; charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAyNWFkZGM4YmUwZDU1NDg2NTJhOWE5MzUwNGExMjQ1MTU3ZmFhODQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFZHVhcmQgWmluZ2VybWFuIDxlZGR5ejg3QGdtYWlsLmNvbT4K
RGF0ZTogV2VkLCA1IEF1ZyAyMDI2IDIzOjM1OjE0IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gc2Vs
ZnRlc3RzL2JwZjogYnVpbGQgdGhlIHJ1bm5lciB1c2Vyc3BhY2Ugb2JqZWN0cyBpbiB0aGUgbWFp
bgogTWFrZWZpbGUKClNxdWFzaCBpbnRvICJzZWxmdGVzdHMvYnBmOiBidWlsZCBlYWNoIHRlc3Qg
cnVubmVyIGluc3RhbmNlIGluIGl0cyBvd24Kc3ViLW1ha2UiLgoKSW5zdGVhZCBvZiBtYWludGFp
bmluZyBhbiBpbnZhcmlhbnQgbGlzdCBvZiBzb3VyY2UgZmlsZXMgdG8gcHJlLWJ1aWxkCmluIHRo
ZSBtYWluIG1ha2VmaWxlIGFuZCBoYXZpbmcgdGhlIHJ1bGVzIHRvIGJ1aWxkIHNhbWUgb2JqZWN0
cyBpbiB0aGUKTWFrZWZpbGUucnVubmVyLCBidWlsZCB0aGVzZSBvYmplY3RzIGV4cGxpY2l0bHkg
aW4gdGhlIG1haW4gbWFrZWZpbGUKYW5kIGRyb3AgdGhlIHJ1bGVzIGZyb20gTWFrZWZpbGUucnVu
bmVyLiBMZXQgZWFjaCBydW5uZXIgaW5zdGFuY2UgbGluawp0aGVtIGFzIHBsYWluIHByZXJlcXVp
c2l0ZXMuIFRoZSBsaXN0cyBsaXZlIGluIE1ha2VmaWxlLmJ1aWxkdmFycy4KCkdvbmUgZnJvbSBN
YWtlZmlsZS5ydW5uZXI6IHRoZSBpbnZhcmlhbnQgbm90ZSwgRVhUUkFfU09VUkNFUywKTElCX1NP
VVJDRVMsIEVYVFJBX09CSlMsIExJQl9PQkpTIGFuZCBib3RoIGNvbXBpbGUgcnVsZXMuCkVYVFJB
X0hEUlMgc2hyaW5rcyB0byB0aGUgZ2VuZXJhdGVkIGhlYWRlcnMgYW5kIGlzIHJlbmFtZWQKYWNj
b3JkaW5nbHkuIFRoZSBmbGF2b3JlZCBpbnN0YW5jZXMgbm8gbG9uZ2VyIGJ1aWxkIHRoZWlyIG93
biBjb3BpZXMKb2Ygc2hhcmVkIHByZXJlcXVlc3RpZXMuCgpXaXRoIG5vIHJ1bGUgbGVmdCBmb3Ig
dGhvc2Ugb2JqZWN0cywgYSBtaXNzaW5nIG9uZSB3b3VsZCBtYXRjaCBtYWtlJ3MKYnVpbHQtaW4g
JS5vIHJ1bGUgYW5kIGJlIHJlYnVpbHQgd2l0aCBkZWZhdWx0IGZsYWdzLCBzbyBkaXNhYmxlIHRo
ZQpidWlsdC1pbiBydWxlcyAoVGhlIGBNQUtFRkxBR1MgKz0gLXJgIHRoaW5neSkuCi0tLQogdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL01ha2VmaWxlICAgICAgICAgIHwgMzkgKysrKysrLS0t
LS0tLQogLi4uL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9NYWtlZmlsZS5idWlsZHZhcnMgIHwgMTcg
KysrKysrCiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvTWFrZWZpbGUucnVubmVyICAgfCA1
NSArKysrKy0tLS0tLS0tLS0tLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyks
IDY1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Jw
Zi9NYWtlZmlsZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9NYWtlZmlsZQppbmRleCBh
ZjM3MDlkNTFmNjcuLmRjMTRhODllZDU1YiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvYnBmL01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9NYWtl
ZmlsZQpAQCAtMjQ1LDMyICsyNDUsMjUgQEAgJChPVVRQVVQpL3Rlc3Rfc29ja19maWVsZHM6ICQo
Q0dST1VQX0hFTFBFUlMpICQoVEVTVElOR19IRUxQRVJTKQogJChPVVRQVVQpL3Rlc3RfdGFnOiAk
KFRFU1RJTkdfSEVMUEVSUykKICQoT1VUUFVUKS90ZXN0X2xpcmNfbW9kZTJfdXNlcjogJChURVNU
SU5HX0hFTFBFUlMpCiAkKE9VVFBVVCkvZmxvd19kaXNzZWN0b3JfbG9hZDogJChURVNUSU5HX0hF
TFBFUlMpCi0kKE9VVFBVVCkvdGVzdF9tYXBzOiAkKFRFU1RJTkdfSEVMUEVSUykKICQoT1VUUFVU
KS90ZXN0X3ZlcmlmaWVyOiAkKFRFU1RJTkdfSEVMUEVSUykgJChDQVBfSEVMUEVSUykgJChVTlBS
SVZfSEVMUEVSUykKLSQoT1VUUFVUKS94c2subzogJChCUEZPQkopCi0KLSMgQWxsIGhlbHBlciBv
YmplY3RzIGEgcnVubmVyIGluc3RhbmNlIGxpbmtzLCBwcmUtYnVpbHQgaGVyZSBzbyBydW5uZXIK
LSMgc3ViLW1ha2VzIHNoYXJpbmcgJChPVVRQVVQpIG5ldmVyIGNvbXBpbGUgdGhlbSBjb25jdXJy
ZW50bHkuCi1IRUxQRVJfT0JKUyA6PSAkKFRFU1RJTkdfSEVMUEVSUykgJChDR1JPVVBfSEVMUEVS
UykgJChVTlBSSVZfSEVMUEVSUykJXAotCSAgICAgICAkKFRSQUNFX0hFTFBFUlMpICQoSlNPTl9X
UklURVIpICQoQ0FQX0hFTFBFUlMpCQlcCi0JICAgICAgICQoTkVUV09SS19IRUxQRVJTKSAkKE9V
VFBVVCkvdXNkdF8xLm8gJChPVVRQVVQpL3VzZHRfMi5vCVwKLQkgICAgICAgJChPVVRQVVQpL3hz
ay5vCiAKKyMgVGhlIHVzZXJzcGFjZSBvYmplY3RzIHRoZSBydW5uZXIgaW5zdGFuY2VzIGxpbmsg
KFJVTk5FUl9PQkpTLCBzZWUKKyMgTWFrZWZpbGUuYnVpbGR2YXJzKSBhcmUgYnVpbHQgaGVyZSwg
b25jZSwgc28gdGhhdCBubyBydW5uZXIgc3ViLW1ha2UKKyMgZXZlciB3cml0ZXMgYSBmaWxlIHRo
aXMgTWFrZWZpbGUgYWxzbyBidWlsZHMuCisjCiAjICQoQlBGVE9PTCkgaXMgYSBwcmVyZXF1aXNp
dGUgYmVjYXVzZSBpdHMgc3ViLW1ha2UgaXMgd2hhdCBpbnN0YWxscwogIyBsaWJicGYncyBpbnRl
cm5hbCBoZWFkZXJzIChicGYvaGFzaG1hcC5oLCBicGYvbGliYnBmX2ludGVybmFsLmgpIGludG8K
LSMgJChJTkNMVURFX0RJUik7IHdpdGhvdXQgaXQsIGhlbHBlcnMgaW5jbHVkaW5nIHRob3NlIGhl
YWRlcnMgcmFjZSB0aGUKLSMgaW5zdGFsbCBhbmQgY2FuIHNpbGVudGx5IHBpY2sgdXAgdGhlIHNv
dXJjZS10cmVlIGNvcGllcyBpbnN0ZWFkLgotIwotIyBJbnZhcmlhbnQ6IHRoaXMgbGlzdCBtdXN0
IGJlIGEgc3VwZXJzZXQgb2YgZXZlcnkgcHJlcmVxdWlzaXRlIHRoZQotIyBydW5uZXIncyBFWFRS
QV9PQkpTIHJ1bGUgYXR0YWNoZXMgdG8gdGhlc2Ugc2FtZSBvYmplY3RzIChFWFRSQV9IRFJTLAot
IyBib3RoIHRlc3RzLmggZmxhdm9ycywgJChCUEZPQkopKS4gSXQgZ3VhcmFudGVlcyB0aGUgaGVs
cGVycyBidWlsdAotIyBoZXJlIGFyZSBuZXZlciBvbGRlciB0aGFuIGEgcnVubmVyLXNpZGUgcHJl
cmVxdWlzaXRlLCBzbyB0aGUKLSMgdW5mbGF2b3JlZCB0ZXN0X3Byb2dzIGFuZCB0ZXN0X21hcHMg
c3ViLW1ha2VzLCB3aGljaCBzaGFyZSAkKE9VVFBVVCksCi0jIHRyZWF0IHRoZW0gYXMgdXAgdG8g
ZGF0ZSBpbnN0ZWFkIG9mIGJvdGggcmVjb21waWxpbmcgdGhlIHNhbWUgb2JqZWN0Ci0jIGZpbGUg
Y29uY3VycmVudGx5LgotJChIRUxQRVJfT0JKUyk6IGZsb3dfZGlzc2VjdG9yX2xvYWQuaCBpcF9j
aGVja19kZWZyYWdfZnJhZ3MuaAkJXAotCQkkKFZFUklGWV9TSUdfSERSKSAkKExJQkFSRU5BX1NL
RUwpICQoTElCQVJFTkFfQVNBTl9TS0VMKVwKLQkJcHJvZ190ZXN0cy90ZXN0cy5oIG1hcF90ZXN0
cy90ZXN0cy5oICQoQlBGT0JKKSAkKEJQRlRPT0wpCisjICQoSU5DTFVERV9ESVIpOyB3aXRob3V0
IGl0LCB0cmFjZV9oZWxwZXJzLmMgcmFjZXMgdGhlIGluc3RhbGwgYW5kIGNhbgorIyBzaWxlbnRs
eSBwaWNrIHVwIHRoZSBzb3VyY2UtdHJlZSBjb3BpZXMgaW5zdGVhZC4KKyQoUlVOTkVSX09CSlMp
OiAkKFZFUklGWV9TSUdfSERSKSBwcm9nX3Rlc3RzL3Rlc3RzLmggbWFwX3Rlc3RzL3Rlc3RzLmgJ
XAorCQkkKEJQRk9CSikgJChCUEZUT09MKQorCisjIFNvbWUgdXRpbGl0eSBmdW5jdGlvbnMgdXNl
IExMVk0gbGlicmFyaWVzCiskKE9VVFBVVCkvaml0X2Rpc2FzbV9oZWxwZXJzLm86IENGTEFHUyAr
PSAkKExMVk1fQ0ZMQUdTKQorCiskKE9VVFBVVCkvZmluZF9iaXQubzogJChUT09MU0RJUikvbGli
L2ZpbmRfYml0LmMKKwkkKGNhbGwgbXNnLENDLCwkQCkKKwkkKFEpJChDQykgJChDRkxBR1MpIC1j
ICQ8IC1vICRACiAKICQoT1VUUFVUKS9mbG93X2Rpc3NlY3Rvcl9sb2FkOiBmbG93X2Rpc3NlY3Rv
cl9sb2FkLmgKIApAQCAtNDQ2LDcgKzQzOSw3IEBAIFJVTk5FUl9QUkVSRVFTIDo9ICQoSU5DTFVE
RV9ESVIpL3ZtbGludXguaCAkKEJQRk9CSikgJChCUEZUT09MKQkJXAogCQkgICQoVkVSSUZZX1NJ
R19IRFIpICQoUFJJVkFURV9LRVkpICQoVkVSSUZJQ0FUSU9OX0NFUlQpCVwKIAkJICAkKExJQkFS
RU5BX1NLRUwpICQoTElCQVJFTkFfQVNBTl9TS0VMKQkJXAogCQkgIHByb2dfdGVzdHMvdGVzdHMu
aCBtYXBfdGVzdHMvdGVzdHMuaAkJCVwKLQkJICAkKEhFTFBFUl9PQkpTKQkJCQkJXAorCQkgICQo
UlVOTkVSX09CSlMpCQkJCQlcCiAJCSAgJChPVVRQVVQpL3VyYW5kb21fcmVhZCAkKE9VVFBVVCkv
bGlidXJhbmRvbV9yZWFkLnNvCVwKIAkJICAkKE9VVFBVVCkveGRwX3N5bnByb3h5ICQoT1VUUFVU
KS9zaWduLWZpbGUJCVwKIAkJICAkKE9VVFBVVCkvdXByb2JlX211bHRpICQoVEVTVF9LTU9EX1RB
UkdFVFMpCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvTWFrZWZpbGUu
YnVpbGR2YXJzIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL01ha2VmaWxlLmJ1aWxkdmFy
cwppbmRleCAwNDRlMGQ3M2IwOWIuLmJiOTVjZmY2NTMyNCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvYnBmL01ha2VmaWxlLmJ1aWxkdmFycworKysgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9icGYvTWFrZWZpbGUuYnVpbGR2YXJzCkBAIC0xNjksMyArMTY5LDIwIEBAIGlm
bmVxICgkKENMQU5HX0hBU19BUkVOQV9BU0FOKSwpCiBMSUJBUkVOQV9BU0FOX1NLRUwgOj0gbGli
YXJlbmEvbGliYXJlbmFfYXNhbi5za2VsLmgKIENGTEFHUyArPSAtREhBU19CUEZfQVJFTkFfQVNB
TgogZW5kaWYKKworUlVOTkVSX09CSlMtdGVzdF9wcm9ncyA6PSAkKGFkZHByZWZpeCAkKE9VVFBV
VCkvLAkJCVwKKwl0ZXN0X3Byb2dzLm8gY2dyb3VwX2hlbHBlcnMubyB0cmFjZV9oZWxwZXJzLm8J
CQlcCisJbmV0d29ya19oZWxwZXJzLm8gdGVzdGluZ19oZWxwZXJzLm8gYnRmX2hlbHBlcnMubwkJ
XAorCWNhcF9oZWxwZXJzLm8gdW5wcml2X2hlbHBlcnMubyBzeXNjdGxfaGVscGVycy5vCQkJXAor
CW5ldGxpbmtfaGVscGVycy5vIGppdF9kaXNhc21faGVscGVycy5vIGlvX2hlbHBlcnMubwkJXAor
CXRlc3RfbG9hZGVyLm8geHNrLm8gZGlzYXNtLm8gZGlzYXNtX2hlbHBlcnMubwkJCVwKKwlqc29u
X3dyaXRlci5vIGJwZnRvb2xfaGVscGVycy5vIHVzZHRfMS5vIHVzZHRfMi5vKQorUlVOTkVSX09C
SlMtdGVzdF9tYXBzIDo9ICQoYWRkcHJlZml4ICQoT1VUUFVUKS8sCQkJXAorCXRlc3RfbWFwcy5v
IHRlc3RpbmdfaGVscGVycy5vKQorCisjIGZpbmRfYml0LmMgaXMgdGhlIG9ubHkgcnVubmVyIHNv
dXJjZSBvdXRzaWRlIHRoaXMgZGlyZWN0b3J5LAorIyBzbyBpdCBuZWVkcyBhIHJ1bGUgb2YgaXRz
IG93bgorUlVOTkVSX0xJQl9PQkpTLXRlc3RfcHJvZ3MgOj0gJChPVVRQVVQpL2ZpbmRfYml0Lm8K
KworUlVOTkVSX09CSlMgOj0gJChzb3J0ICQoUlVOTkVSX09CSlMtdGVzdF9wcm9ncykgJChSVU5O
RVJfT0JKUy10ZXN0X21hcHMpXAorCQkgICAgICAkKFJVTk5FUl9MSUJfT0JKUy10ZXN0X3Byb2dz
KSkKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9NYWtlZmlsZS5ydW5u
ZXIgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvTWFrZWZpbGUucnVubmVyCmluZGV4IDkx
ZThhMmRmNDY4Zi4uZWQ2MjYyZGMxM2UzIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9icGYvTWFrZWZpbGUucnVubmVyCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Jw
Zi9NYWtlZmlsZS5ydW5uZXIKQEAgLTcsOSArNyw5IEBACiAjIHNvIGV2ZXJ5dGhpbmcgaGVyZSBp
cyB3cml0dGVuIGluIHBsYWluIG1ha2UgLSBubyAkJC1lc2NhcGluZywgbm8gZXZhbCwKICMgbm8g
cGVyLWZsYXZvciBndWFyZHMuIFRoaXMgZmlsZSBpcyBhbHdheXMgaW52b2tlZCBieSB0aGUgbWFp
biBNYWtlZmlsZSwKICMgbmV2ZXIgZGlyZWN0bHk6IGFsbCBzaGFyZWQgcHJlcmVxdWlzaXRlcyAo
bGliYnBmLCBicGZ0b29sLCB2bWxpbnV4LmgsCi0jIHZlcmlzdGF0LCBoZWxwZXIgb2JqZWN0cywg
c2lnbmluZyBrZXksIGdlbmVyYXRlZCB0ZXN0cy5oLCBleHRyYQotIyBiaW5hcmllcykgYXJlIGJ1
aWx0IGJ5IHRoZSBtYWluIE1ha2VmaWxlICpiZWZvcmUqIHRoaXMgb25lIHJ1bnMgYW5kIGFyZQot
IyByZWZlcmVuY2VkIGJlbG93IGFzIHBsYWluIGZpbGVzLgorIyB2ZXJpc3RhdCwgaGVscGVyIG9i
amVjdHMsIHNpZ25pbmcga2V5LCBnZW5lcmF0ZWQKKyMgdGVzdHMuaCwgZXh0cmEgYmluYXJpZXMp
IGFyZSBidWlsdCBieSB0aGUgbWFpbiBNYWtlZmlsZSAqYmVmb3JlKiB0aGlzCisjIG9uZSBydW5z
IGFuZCBhcmUgcmVmZXJlbmNlZCBiZWxvdyBhcyBwbGFpbiBmaWxlcy4KICMKICMgUGFyYW1ldGVy
cyAoYWxsIHBhc3NlZCBvbiB0aGUgc3ViLW1ha2UgY29tbWFuZCBsaW5lKToKICMgICBPVVRQVVQg
ICAgICBhYnNvbHV0ZSBwYXRoIG9mIHRoZSBzZWxmdGVzdHMgb3V0cHV0IGRpcmVjdG9yeQpAQCAt
NjMsNiArNjMsMTEgQEAgYWxsOiAkKE9VVFBVVCkvJChCSU5BUlkpCiAjIERlbGV0ZSBwYXJ0aWFs
bHkgdXBkYXRlZCAoY29ycnVwdGVkKSBmaWxlcyBvbiBlcnJvcgogLkRFTEVURV9PTl9FUlJPUjoK
IAorIyBObyBidWlsdC1pbiBydWxlczogZXZlcnkgZmlsZSBidWlsdCBoZXJlIGhhcyBhbiBleHBs
aWNpdCBydWxlLCBhbmQgdGhlCisjIG9iamVjdHMgdGhhdCBjb21lIGZyb20gdGhlIG1haW4gTWFr
ZWZpbGUgaGF2ZSB0byBiZSBhbiBlcnJvciB3aGVuCisjIG1pc3NpbmcgcmF0aGVyIHRoYW4gYSBz
aWxlbnQgcmVidWlsZCBieSB0aGUgYnVpbHQtaW4gJS5vIHJlY2lwZXMuCitNQUtFRkxBR1MgKz0g
LXIKKwogIyBQZXJtaXNzaXZlIHNraXAtb24tZmFpbHVyZSBvZiBpbmRpdmlkdWFsIHRlc3RzIGFw
cGxpZXMgdG8gdGVzdF9wcm9ncyBhbmQKICMgaXRzIGZsYXZvcnMgb25seTsgdGVzdF9tYXBzIHVz
ZXMgc3Ryb25nIGNyb3NzLW9iamVjdCByZWZlcmVuY2VzIGFuZCBrZWVwcwogIyBzdHJpY3Qgc2Vt
YW50aWNzIGV2ZW4gd2hlbiBCUEZfU1RSSUNUX0JVSUxEPTAuCkBAIC03NywxNSArODIsNyBAQCAk
KFJESVIpOgogIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIAogaWZlcSAoJChSVU5ORVIpLHRlc3RfcHJvZ3MpCi1F
WFRSQV9TT1VSQ0VTIDo9IHRlc3RfcHJvZ3MuYyBjZ3JvdXBfaGVscGVycy5jIHRyYWNlX2hlbHBl
cnMuYwkJXAotCQkgbmV0d29ya19oZWxwZXJzLmMgdGVzdGluZ19oZWxwZXJzLmMgYnRmX2hlbHBl
cnMuYwlcCi0JCSBjYXBfaGVscGVycy5jIHVucHJpdl9oZWxwZXJzLmMgc3lzY3RsX2hlbHBlcnMu
YwlcCi0JCSBuZXRsaW5rX2hlbHBlcnMuYyBqaXRfZGlzYXNtX2hlbHBlcnMuYyBpb19oZWxwZXJz
LmMJXAotCQkgdGVzdF9sb2FkZXIuYyB4c2suYyBkaXNhc20uYyBkaXNhc21faGVscGVycy5jCQlc
Ci0JCSBqc29uX3dyaXRlci5jIGJwZnRvb2xfaGVscGVycy5jIHVzZHRfMS5jIHVzZHRfMi5jCi1M
SUJfU09VUkNFUyA6PSBmaW5kX2JpdC5jCi1FWFRSQV9IRFJTIDo9IGZsb3dfZGlzc2VjdG9yX2xv
YWQuaCBpcF9jaGVja19kZWZyYWdfZnJhZ3MuaAkJXAotCSAgICAgICQoVkVSSUZZX1NJR19IRFIp
ICQoTElCQVJFTkFfU0tFTCkgJChMSUJBUkVOQV9BU0FOX1NLRUwpCitHRU5FUkFURURfSERSUyA6
PSAkKExJQkFSRU5BX1NLRUwpICQoTElCQVJFTkFfQVNBTl9TS0VMKQogRVhUUkFfRklMRVMgOj0g
JChPVVRQVVQpL3VyYW5kb21fcmVhZCAkKE9VVFBVVCkvbGlidXJhbmRvbV9yZWFkLnNvCVwKIAkg
ICAgICAgJChPVVRQVVQpL3hkcF9zeW5wcm94eSAkKE9VVFBVVCkvc2lnbi1maWxlCQlcCiAJICAg
ICAgICQoT1VUUFVUKS91cHJvYmVfbXVsdGkJCQkJCVwKQEAgLTk1LDI1ICs5Miw5IEBAIEVYVFJB
X0ZJTEVTIDo9ICQoT1VUUFVUKS91cmFuZG9tX3JlYWQgJChPVVRQVVQpL2xpYnVyYW5kb21fcmVh
ZC5zbwlcCiAJICAgICAgICQod2lsZGNhcmQgcHJvZ3MvKi5icGYubykKIGVuZGlmCiAKLWlmZXEg
KCQoUlVOTkVSKSx0ZXN0X21hcHMpCi1FWFRSQV9TT1VSQ0VTIDo9IHRlc3RfbWFwcy5jIHRlc3Rp
bmdfaGVscGVycy5jCi1lbmRpZgotCi0jIE5vdGUgb24gdGhlIHVuZmxhdm9yZWQgcnVubmVycywg
d2hpY2ggc2hhcmUgJChPVVRQVVQpIHdpdGggdGhlIG1haW4KLSMgTWFrZWZpbGU6IGhlbHBlciBv
YmplY3RzIHRoZSBtYWluIE1ha2VmaWxlIGFsc28gdXNlcyAoYW5kIGxpc3RzIGluIHRoZQotIyBy
dW5uZXIgcHJlcmVxdWlzaXRlcykgYXJlIGFscmVhZHkgYnVpbHQgYW5kIGZyZXNoIHdoZW4gYSBy
dW5uZXIgc3RhcnRzLAotIyBzbyB0aGUgcnVsZXMgYmVsb3cgZmluZCB0aGVtIHVwIHRvIGRhdGUg
YW5kIG5ldmVyIHdyaXRlIHRoZW0uIFRoaXMKLSMgaG9sZHMgYmVjYXVzZSB0aGUgbWFpbiBNYWtl
ZmlsZSdzIGhlbHBlci1vYmplY3QgcnVsZSBkZXBlbmRzIG9uIGEKLSMgc3VwZXJzZXQgb2YgdGhl
IHByZXJlcXVpc2l0ZXMgdGhlIEVYVFJBX09CSlMgcnVsZSB1c2VzIGhlcmUgLSBrZWVwCi0jIHRo
ZSB0d28gbGlzdHMgaW4gc3luYyAoc2VlIHRoZSBpbnZhcmlhbnQgY29tbWVudCB0aGVyZSkuCi0K
LVRFU1RTX0hEUiA6PSAkKFRFU1RTX0RJUikvdGVzdHMuaAotCiBURVNUX1NSQ1MgIDo9ICQobm90
ZGlyICQod2lsZGNhcmQgJChURVNUU19ESVIpLyouYykpCiBURVNUX09CSlMgIDo9ICQocGF0c3Vi
c3QgJS5jLCQoUkRJUikvJS50ZXN0Lm8sJChURVNUX1NSQ1MpKQogVEVTVF9ERVBTICA6PSAkKFRF
U1RfT0JKUzoubz0uZCkKLUVYVFJBX09CSlMgOj0gJChwYXRzdWJzdCAlLmMsJChSRElSKS8lLm8s
JChmaWx0ZXIgJS5jLCQoRVhUUkFfU09VUkNFUykpKQotTElCX09CSlMgICA6PSAkKHBhdHN1YnN0
ICUuYywkKFJESVIpLyUubywkKExJQl9TT1VSQ0VTKSkKIAogIyAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KICMgQlBG
IG9iamVjdHMgYW5kIHNrZWxldG9ucwpAQCAtMjcwLDIyICsyNTEsMTEgQEAgJChURVNUX09CSlMp
OiAkKFJESVIpLyUudGVzdC5vOiAkKFRFU1RTX0RJUikvJS5jIHwgJChSRElSKS8lLnRlc3QuZAog
CQkkKFJFU09MVkVfQlRGSURTKSAtLXBhdGNoX2J0ZmlkcyAkQC5CVEZfaWRzICRAOwkJXAogCQlm
aSkKIAotJChURVNUX0RFUFMpOiAkKFJESVIpLyUudGVzdC5kOiAkKFRFU1RTX0RJUikvJS5jICQo
RVhUUkFfSERSUykgJChCUEZPQkopIFwKKyQoVEVTVF9ERVBTKTogJChSRElSKS8lLnRlc3QuZDog
JChURVNUU19ESVIpLyUuYyAkKEdFTkVSQVRFRF9IRFJTKSAkKEJQRk9CSikgXAogCSAgICAgIHwg
JChSRElSKSAkKEFMTF9TS0VMUykKIAogaW5jbHVkZSAkKHdpbGRjYXJkICQoVEVTVF9ERVBTKSkK
IAotIyBTb21lIHV0aWxpdHkgZnVuY3Rpb25zIHVzZSBMTFZNIGxpYnJhcmllcwotJChSRElSKS9q
aXRfZGlzYXNtX2hlbHBlcnMubzogQ0ZMQUdTICs9ICQoTExWTV9DRkxBR1MpCi0KLSQoRVhUUkFf
T0JKUyk6ICQoUkRJUikvJS5vOiAlLmMgJChFWFRSQV9IRFJTKSAkKFRFU1RTX0hEUikgJChCUEZP
QkopIHwgJChSRElSKQotCSQoY2FsbCBtc2csRVhULU9CSiwkKEJJTkFSWSksJEApCi0JJChRKSQo
Q0MpICQoQ0ZMQUdTKSAtYyAkPCAtbyAkQAotCi0kKExJQl9PQkpTKTogJChSRElSKS8lLm86ICQo
VE9PTFNESVIpL2xpYi8lLmMgfCAkKFJESVIpCi0JJChjYWxsIG1zZyxMSUItT0JKLCQoQklOQVJZ
KSwkQCkKLQkkKFEpJChDQykgJChDRkxBR1MpIC1jICQ8IC1vICRACi0KICMgTm9uLWZsYXZvcmVk
IGluLXNyY3RyZWUgYnVpbGRzIHJlY2VpdmUgc3BlY2lhbCB0cmVhdG1lbnQsIGluIHBhcnRpY3Vs
YXIKICMgd2UgZG8gbm90IG5lZWQgdG8gY29weSBleHRyYSByZXNvdXJjZXMgKHNlZSBlLmcuIHRl
c3RfYnRmX2R1bXBfY2FzZSgpKS4KIC5QSE9OWTogZXh0cmFzCkBAIC0zMDMsMTAgKzI3MywxMSBA
QCBlbmRpZgogIyByZWxpbmtzIHRoZSBydW5uZXIgLSB3aGlsZSB0aGUgZnVsbCBzZXQgc3RheXMg
b3JkZXItb25seSB0byBkcml2ZSB0aGUKICMgYnVpbGQgYXR0ZW1wdHMsIGFuZCB0aGUgd2lsZGNh
cmQgaW4gdGhlIHJlY2lwZSBwaWNrcyB1cCB0aGUgc3Vydml2b3JzCiAjIGF0IGxpbmsgdGltZS4K
LSMgUHJlcmVxdWlzaXRlIG9yZGVyIGlzIGFsc28gbGluayBvcmRlciAodGVzdCBvYmplY3RzLCBl
eHRyYSBvYmplY3RzLAorIyBQcmVyZXF1aXNpdGUgb3JkZXIgaXMgYWxzbyBsaW5rIG9yZGVyICh0
ZXN0IG9iamVjdHMsIHJ1bm5lciBvYmplY3RzLAogIyBsaWJicGYsIGxpYiBvYmplY3RzKS4KICQo
T1VUUFVUKS8kKEJJTkFSWSk6ICQoaWYgJChQRVJNSVNTSVZFX1RFU1RTKSwkKHdpbGRjYXJkICQo
VEVTVF9PQkpTKSksJChURVNUX09CSlMpKSBcCi0JCSAgICAgJChFWFRSQV9PQkpTKSAkKEJQRk9C
SikgJChMSUJfT0JKUykJCVwKKwkJICAgICAkKFJVTk5FUl9PQkpTLSQoUlVOTkVSKSkgJChCUEZP
QkopCQkJXAorCQkgICAgICQoUlVOTkVSX0xJQl9PQkpTLSQoUlVOTkVSKSkJCQlcCiAJCSAgICAg
JChUUlVOTkVSX0JQRlRPT0wpICQoT1VUUFVUKS92ZXJpc3RhdAkJXAogCQkgICAgIHwgZXh0cmFz
ICQoQlBGX09CSlMpCQkJCVwKIAkJICAgICAkKGlmICQoUEVSTUlTU0lWRV9URVNUUyksJChURVNU
X09CSlMpKQotLSAKMi41My4wLU1ldGEKCg==


--=-6h88wX0oq1hJDr0Kofjg--
