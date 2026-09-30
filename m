Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769AC4F3EAA
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799737; cv=none; b=AsiKDyNgwCOZBREGolS8JFZWpavt/GdMc3AoS2I6fpQiU4wZbRmsE1nRIPFdiKKK+UACPJP6Kvp69HAMMeivE1yGEc3IOVrb+y6d189otJjtsIdfXT3r8PuuZsQBUQUVWdbEXGmZ31uP8z4zqZ8DdxOnC/yWJTHW7yL3eTswl6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799737; c=relaxed/simple;
	bh=ZpV5+lD5Lt1VL8THRGeE2opzGSQ+qCJ5rXJ3DULjk1c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kVbvd69+2SqCkhPcF+5bLSqbRry8lbL+eIEFMwYN5d4d98kKWIk3BgeKV7c3TvysqfRdwzeTkurDwRuTT41dgJWwcWi/aifivNboA9TIQv2OSlGi1c+aBxwZgUKZzDxp8puI00x3Wi+HeWpD4zeImOs0V/t7Sfe7y1QlHnCPphE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkpfFYKl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkpfFYKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07C51F000FF;
	Wed, 30 Sep 2026 20:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790799736;
	bh=JuUJN01ZEzRrUX/QYiryvNYpWl4if7BWhAaQgOHvMC4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HkpfFYKl15USOhPzRHMo+gz1oQAiwUHCCEmQTOp+L9CIixzhjKC1f02dHSFbCGAge
	 ZChLT7Pk1OsJuVYQpft8qaH1hVYxuCze7WoagJcyb+YRX7xg358X2vwgP9hkq+JS3L
	 1jnv3omkvrO/7chhHRDPom7Cn8QTNJjxnenyph4RfiY/EVc6wLQbswJs4/w2lZaPtv
	 RDA074DWR5qUygFgiOs87RUGgbx5CnNitEOUA5JyvuBXoajOUEfF2GxBkLLrxl7Fzb
	 4VcPHFu6QDxI5ZcGkwPsZdl8Bd46WZQegY8E4xvZeJ/PZi0ZmQ4k99slMGVQDa0auj
	 Dxq2/HZEtlUrQ==
Content-Type: multipart/mixed; boundary="===============7629148440464350644=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a5a8a9bbc4cef820e896c72a720c436b6a401b5d039fadf8dd4f99f48dcac87b@mail.kernel.org>
In-Reply-To: <20260930193127.2181684-15-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-15-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 14/14] selftests/bpf: Add test for global data of a program in Rust
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 30 Sep 2026 20:22:15 +0000 (UTC)

--===============7629148440464350644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add test for global data of a program in Rust

TL;DR:
- Selftests build may fail on rustc older than 1.85 (fixed --edition 2024),
  breaking all runners despite the skip promise
- Failed rustc in the pipe may yield an empty object, so the Rust subtest
  fails confusingly at run time

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index afa589a27b15..a22be7efd1fa 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -422,6 +422,16 @@ $(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
>  	+$(MAKE) -C libarena libarena_asan.skel.h $(LIBARENA_MAKE_ARGS)
>  endif
>
> +# #![no_std] looks for compiler_builtins too. Nothing of it is used.
> +ifneq ($(RUST_CORE),)
> +$(RUST_CORE): $(RUST_CORE_SRC)
> +	$(call msg,RUSTC,,$@)
> +	$(Q)mkdir -p $(@D)
> +	+$(Q)$(RUSTC_BPF) -A warnings --edition 2024 --crate-name core --out-dir $(@D) $<
                                     ^^^^^^^^^^^^^^

Can this rule fail on a rustc older than 1.85?

The core crate is always built with a fixed --edition 2024, but the
detection in Makefile.buildvars only checks that rust-src exists and that
clang is version 23 or newer.  It never looks at the rustc version:

    ifneq ($(RUST_CORE_SRC),)
    ifeq ($(shell [ 0$(shell echo __clang_major__ | $(CLANG) ...) -ge 23 ] ...
    RUST_CORE := $(BUILD_DIR)/rust/libcore.rlib

A rustc older than 1.85 rejects --edition 2024, either as an unknown edition
or as unstable without -Z unstable-options, which RUSTC_BOOTSTRAP=1 does not
add.  For rustc 1.85 and 1.86 the core source that ships with rustc is still
edition 2021 code.

The kernel picks the edition to match the rustc version in rust/Makefile:

    core-edition := $(if $(call rustc-min-version,108700),2024,2021)

That came from f4daa80d6be7 ("rust: compile libcore with edition 2024 for
1.87+"), which says the edition must match what libcore expects.  So the
commit message statement "core is built from the source that comes with
rustc, like the kernel does it" is not quite accurate for the edition.

> +	+$(Q)echo '#![feature(compiler_builtins)] #![compiler_builtins] #![no_std]' | \
> +		$(RUSTC_BPF) -A warnings --crate-name compiler_builtins --out-dir $(@D) -
> +endif
> +

[ ... ]

> @@ -457,7 +467,7 @@ RUNNER_PREREQS := $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(BPFTOOL)		\
>  		  $(VERIFY_SIG_HDR) $(PRIVATE_KEY) $(VERIFICATION_CERT)	\
>  		  $(LIBARENA_SKEL) $(LIBARENA_ASAN_SKEL)		\
>  		  prog_tests/tests.h map_tests/tests.h			\
> -		  $(RUNNER_OBJS)
> +		  $(RUNNER_OBJS) $(RUST_CORE)
                                 ^^^^^^^^^^^^

If the libcore rule does fail, doesn't this stop the whole selftests/bpf
build and not just the Rust subtest?

$(RUST_CORE) is a prerequisite of RUNNER_PREREQS, so test_progs,
test_progs-no_alu32, test_progs-cpuv4, test_progs-bpf_gcc and test_maps all
depend on it.  The recipe has no $(call skip_on_fail,...), so the build
fails even with BPF_STRICT_BUILD=0.

One setup that hits this is a rustc older than 1.85 with rust-src installed
in the sysroot and clang 23 or newer, for example a pinned rustup toolchain
with "rustup component add rust-src", or distro rustc and rust-src packages
together with an apt.llvm.org or self-built clang.  On such a system
selftests/bpf built before this patch and does not build with it, while the
commit message says:

    The subtest is skipped when there is no rustc, no source of core
    (rustup component add rust-src) or when clang is older than 23.

Would it make sense to gate RUST_CORE on a probe that rustc accepts the
chosen edition, or to pick the core edition by rustc version the way
rust/Makefile does?  It may also be worth making a libcore build failure
produce a skip instead of stopping every runner.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
> index d9ddd1d86f89..df6bbf644a43 100644
> --- a/tools/testing/selftests/bpf/Makefile.skel
> +++ b/tools/testing/selftests/bpf/Makefile.skel

[ ... ]

> @@ -138,4 +138,18 @@ $(LINKED_SKELS_H): $(RDIR)/%.skel.h: $$(addprefix $(RDIR)/,$$($$*.skel.h-deps))
>  		   $(BPFTOOL) $(GEN_SKEL) | $(RDIR)
>  	$(Q)$(cmd_bpf_link_skel)
>
> +# Programs in Rust, see Makefile.buildvars. No skeletons: the objects may be absent.
> +ifneq ($(RUST_CORE),)
> +ifeq ($(BPF_CC),$(CLANG))
> +RUST_OBJS := $(patsubst progs/%.rs,$(RDIR)/%.bpf.o,$(wildcard progs/*.rs))
> +BPF_OBJS += $(RUST_OBJS)
> +
> +$(RUST_OBJS): $(RDIR)/%.bpf.o: progs/%.rs $(RUST_CORE) | $(RDIR)
> +	$(call msg,RUSTC,$(BINARY),$@)
> +	+$(Q)$(RUSTC_BPF) --edition 2021 -C debuginfo=2 --emit=llvm-bc -o -	\
> +		$(patsubst -mcpu=%,-C target-cpu=%,$(filter -mcpu=%,$(BPF_CC_FLAGS))) $< | \
> +		$(BPF_CC) $(BPF_CC_FLAGS) -x ir -c - -o $@
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If rustc fails here, does this recipe still succeed?

The object is built as "rustc ... -o - $< | clang ... -x ir -c - -o $@".
The selftests makefiles do not set SHELL or pipefail, so the recipe exit
status is clang's alone.  When rustc fails, for example on a compile error
in a progs/*.rs file or with a libcore.rlib built by an incompatible rustc,
it writes nothing to stdout.  clang then reads an empty stream, and with
"-x ir" empty input parses as a valid empty LLVM module, so clang writes an
empty BPF object and exits 0.

make then treats data_in_arena_rust.bpf.o as built, and .DELETE_ON_ERROR in
Makefile.runner never triggers.  The object is newer than its source, so it
is not rebuilt until the source or libcore changes.

Because the file exists, test_rust() does not skip, and the failure shows up
at run time as btf_fd, test_run and retval assertion failures, far from the
real cause.  bpf_program__fd(NULL) returns -EINVAL, so this does not crash
today.

This rule also ignores the BPF_STRICT_BUILD=0 convention that the other BPF
object rules follow through skip_on_fail.

Would writing the bitcode to a temporary file and running the two steps with
&& work better, so that a rustc failure either stops the build or goes
through skip_on_fail?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36768148430
--===============7629148440464350644==--
