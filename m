Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B811446C859;
	Fri,  2 Oct 2026 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790980984; cv=none; b=Ke0N0VfBFYHhINWcXN8pbYFFbAJub1gRoHoyTE+/lldo6SQCl5pLT3qZ8iAynxpuIR9zjPck7cBDMBhDZszaltdMoEzdgyNfIgdW45xSw2S9W6+Br8/qLV1L+5d+9/9a8ue4lGlob+cYTAJ4eY4rm9Ycl3CKXGDp0zgEENhFZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790980984; c=relaxed/simple;
	bh=UUqj0Dc+VGnR8YAXXtMghNaddzXhpwNvqkgQSpTQ8nM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qTi/AboYm6JRpkVRwwYoQLey9Kir952ZwF5N+FMzC48CV1x+n385woLid8lzAFyOFhnstJkbtlsuBi4bBstnxuh3+kG5plAujZzT3bYHbm5u2xCFrFl/YOtM8mv2XEznH9k8JJUTL2UhbWotoCt5jpdlYSg5xU3GEkYCNUvfNMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nchOB8Rj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nchOB8Rj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDBE1F000FF;
	Fri,  2 Oct 2026 22:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790980982;
	bh=tN6iO9giFqv0Dd1EzkadSUzfCf7XzFMq2wbeSDxaDlY=;
	h=Date:From:To:Cc:Subject;
	b=nchOB8Rjk9DZyV5Z6Kyn8F1rUgmxyOJr6d3mfREsf+2r7tx8sc7ykOPrkjL/9ZBem
	 TDyQzmRo7Hgs/iIt01/WtMArRw5s+hBp/L6ccLCT2yRHMTOWbr3SOxim2oh8TmY/A6
	 xhpaY9jWn+1In2mpl2nsPcEnFgSmwaTPJx2gjLiGgvsH0j+VQDQ9GeDqUsXUmzpv9U
	 xpCB3J/qPcqhENB++Hd5hHDxNYbUaPkI451yBNfVO7Lfke942lf3nnL+po+0gYVwEC
	 n73ew1/L3yqW4PUKIcxv9wrcSeisBH2G/mvuw6j4BmGCD5q7OVjPNDqfY7Yo6Q6Zdv
	 p373hbblxn/lA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 257161AC57CE; Fri, 02 Oct 2026 23:42:58 +0100 (BST)
Date: Sat, 3 Oct 2026 00:42:58 +0200
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	KBuild Mailing List <linux-kbuild@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the kbuild tree
Message-ID: <asAzcgDsbNEFIfKV@sirena.co.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9myiH7RmOLX2eC/6"
Content-Disposition: inline


--9myiH7RmOLX2eC/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  init/Kconfig

between commit:

  f85147b291e35 ("kbuild: move the toolchain checks into scripts/Kconfig.to=
olchain")

=66rom the kbuild tree and commit:

  eb13a1ff271b0 ("random: vDSO: avoid call to memset() when zeroing reserve=
d parameter")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined init/Kconfig
index 5229015e0e3dd,ad592fdf29af4..0000000000000
--- a/init/Kconfig
+++ b/init/Kconfig
@@@ -1,6 -1,206 +1,6 @@@
  # SPDX-License-Identifier: GPL-2.0-only
 -config CC_VERSION_TEXT
 -	string
 -	default "$(CC_VERSION_TEXT)"
 -	help
 -	  This is used in unclear ways:
 =20
 -	  - Re-run Kconfig when the compiler is updated
 -	    The 'default' property references the environment variable,
 -	    CC_VERSION_TEXT so it is recorded in include/config/auto.conf.cmd.
 -	    When the compiler is updated, Kconfig will be invoked.
 -
 -	  - Ensure full rebuild when the compiler is updated
 -	    include/linux/compiler-version.h contains this option in the comment
 -	    line so fixdep adds include/config/CC_VERSION_TEXT into the
 -	    auto-generated dependency. When the compiler is updated, syncconfig
 -	    will touch it and then every file will be rebuilt.
 -
 -config CC_IS_GCC
 -	def_bool $(success,test "$(cc-name)" =3D GCC)
 -
 -config GCC_VERSION
 -	int
 -	default $(cc-version) if CC_IS_GCC
 -	default 0
 -
 -config CC_IS_CLANG
 -	def_bool $(success,test "$(cc-name)" =3D Clang)
 -
 -config CLANG_VERSION
 -	int
 -	default $(cc-version) if CC_IS_CLANG
 -	default 0
 -
 -config AS_IS_GNU
 -	def_bool $(success,test "$(as-name)" =3D GNU)
 -
 -config AS_IS_LLVM
 -	def_bool $(success,test "$(as-name)" =3D LLVM)
 -
 -config AS_VERSION
 -	int
 -	# Use clang version if this is the integrated assembler
 -	default CLANG_VERSION if AS_IS_LLVM
 -	default $(as-version)
 -
 -config LD_IS_BFD
 -	def_bool $(success,test "$(ld-name)" =3D BFD)
 -
 -config LD_VERSION
 -	int
 -	default $(ld-version) if LD_IS_BFD
 -	default 0
 -
 -config LD_IS_LLD
 -	def_bool $(success,test "$(ld-name)" =3D LLD)
 -
 -config LLD_VERSION
 -	int
 -	default $(ld-version) if LD_IS_LLD
 -	default 0
 -
 -config RUSTC_VERSION
 -	int
 -	default $(rustc-version)
 -	help
 -	  It does not depend on `RUST` since that one may need to use the version
 -	  in a `depends on`.
 -
 -config RUST_IS_AVAILABLE
 -	def_bool $(success,$(srctree)/scripts/rust_is_available.sh)
 -	help
 -	  This shows whether a suitable Rust toolchain is available (found).
 -
 -	  Please see Documentation/rust/quick-start.rst for instructions on how
 -	  to satisfy the build requirements of Rust support.
 -
 -	  In particular, the Makefile target 'rustavailable' is useful to check
 -	  why the Rust toolchain is not being detected.
 -
 -config RUSTC_LLVM_VERSION
 -	int
 -	default $(rustc-llvm-version)
 -
 -config RUSTC_LLVM_MAJOR_VERSION
 -	int
 -	default $(shell,expr $(rustc-llvm-version) / 10000)
 -
 -config RUSTC_CLANG_LLVM_COMPATIBLE
 -	bool
 -	default y if CC_IS_CLANG && RUSTC_LLVM_MAJOR_VERSION =3D $(shell,expr $(=
cc-version) / 10000)
 -	help
 -	  This indicates whether Rust and Clang use LLVM of the same major
 -	  version.
 -
 -	  Operations involving handling LLVM IR or bitcode (e.g. cross-language
 -	  LTO) require the same LLVM major version to work properly. For best
 -	  compatibility it is recommended that the exact same LLVM is used.
 -
 -config ARCH_HAS_CC_CAN_LINK
 -	bool
 -
 -config CC_CAN_LINK
 -	bool
 -	default ARCH_CC_CAN_LINK if ARCH_HAS_CC_CAN_LINK
 -	default $(cc_can_link_user,$(m64-flag)) if 64BIT
 -	default $(cc_can_link_user,$(m32-flag))
 -
 -# Fixed in GCC 14, 13.3, 12.4 and 11.5
 -# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D113921
 -config GCC_ASM_GOTO_OUTPUT_BROKEN
 -	bool
 -	depends on CC_IS_GCC
 -	default y if GCC_VERSION < 110500
 -	default y if GCC_VERSION >=3D 120000 && GCC_VERSION < 120400
 -	default y if GCC_VERSION >=3D 130000 && GCC_VERSION < 130300
 -
 -config CC_HAS_ASM_GOTO_OUTPUT
 -	def_bool y
 -	depends on !GCC_ASM_GOTO_OUTPUT_BROKEN
 -	depends on $(success,echo 'int foo(int x) { asm goto ("": "=3Dr"(x) ::: =
bar); return x; bar: return 0; }' | $(CC) -x c - -c -o /dev/null)
 -
 -config CC_HAS_ASM_GOTO_TIED_OUTPUT
 -	depends on CC_HAS_ASM_GOTO_OUTPUT
 -	# Detect buggy gcc and clang, fixed in gcc-11 clang-14.
 -	def_bool $(success,echo 'int foo(int *x) { asm goto (".long (%l[bar]) - =
=2E": "+m"(*x) ::: bar); return *x; bar: return 0; }' | $CC -x c - -c -o /d=
ev/null)
 -
 -config TOOLS_SUPPORT_RELR
 -	def_bool $(success,env "CC=3D$(CC)" "LD=3D$(LD)" "NM=3D$(NM)" "OBJCOPY=
=3D$(OBJCOPY)" $(srctree)/scripts/tools-support-relr.sh)
 -
 -config CC_HAS_ASM_INLINE
 -	def_bool $(success,echo 'void foo(void) { asm inline (""); }' | $(CC) -x=
 c - -c -o /dev/null)
 -
 -config CC_HAS_ASSUME
 -	bool
 -	# clang needs to be at least 19.1.0 since the meaning of the assume
 -	# attribute changed:
 -	# https://github.com/llvm/llvm-project/commit/c44fa3e8a9a44c2e9a575768a3=
c185354b9f6c17
 -	default y if CC_IS_CLANG && CLANG_VERSION >=3D 190100
 -	# supported since gcc 13.1.0
 -	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D106654
 -	default y if CC_IS_GCC && GCC_VERSION >=3D 130100
 -
 -config CC_HAS_NO_PROFILE_FN_ATTR
 -	def_bool $(success,echo '__attribute__((no_profile_instrument_function))=
 int x();' | $(CC) -x c - -c -o /dev/null -Werror)
 -
 -config CC_HAS_COUNTED_BY
 -	bool
 -	# clang needs to be at least 20.1.0 to avoid potential crashes
 -	# when building structures that contain __counted_by
 -	# https://github.com/ClangBuiltLinux/linux/issues/2114
 -	# https://github.com/llvm/llvm-project/commit/160fb1121cdf703c3ef5e61fb2=
6c5659eb581489
 -	default y if CC_IS_CLANG && CLANG_VERSION >=3D 200100
 -	# supported since gcc 15.1.0
 -	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D108896
 -	default y if CC_IS_GCC && GCC_VERSION >=3D 150100
 -
 -config CC_HAS_COUNTED_BY_PTR
 -	bool
 -	# supported since clang 22
 -	default y if CC_IS_CLANG && CLANG_VERSION >=3D 220100
 -	# supported since gcc 16.0.0
 -	default y if CC_IS_GCC && GCC_VERSION >=3D 160000
 -
 -config CC_HAS_BROKEN_COUNTED_BY_REF
 -	bool
 -	# https://github.com/llvm/llvm-project/issues/182575
 -	default y if CC_IS_CLANG && CLANG_VERSION < 220100
 -
 -config CC_HAS_ALLOC_TOKEN
 -	def_bool $(cc-option,-falloc-token-max=3D123)
 -
 -config CC_HAS_MULTIDIMENSIONAL_NONSTRING
 -	def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring__)) =
=3D { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
 -
 -config CC_OPT_INLINE_MEMSET
 -	string
 -	default "-finline-stringops=3Dmemset" if $(cc-option,-finline-stringops=
=3Dmemset)
 -	default "-mllvm -max-store-memset=3D4294967294" if $(cc-option,-mllvm -m=
ax-store-memset=3D4294967294)
 -
 -config LD_CAN_USE_KEEP_IN_OVERLAY
 -	# ld.lld prior to 21.0.0 did not support KEEP within an overlay descript=
ion
 -	# https://github.com/llvm/llvm-project/pull/130661
 -	def_bool LD_IS_BFD || LLD_VERSION >=3D 210000
 -
 -config RUSTC_HAS_SPAN_FILE
 -	def_bool RUSTC_VERSION >=3D 108800
 -
 -config RUSTC_HAS_UNNECESSARY_TRANSMUTES
 -	def_bool RUSTC_VERSION >=3D 108800
 -
 -config RUSTC_HAS_FILE_WITH_NUL
 -	def_bool RUSTC_VERSION >=3D 108900
 -
 -config RUSTC_HAS_FILE_AS_C_STR
 -	def_bool RUSTC_VERSION >=3D 109100
 -
 -config RUSTC_HAS_SUSPICIOUS_RUNTIME_SYMBOL_DEFINITIONS
 -	def_bool RUSTC_VERSION >=3D 109800
 -
 -config PAHOLE_VERSION
 -	int
 -	default "$(PAHOLE_VERSION)"
 +source "scripts/Kconfig.toolchain"
 =20
  config CONSTRUCTORS
  	bool
@@@ -36,10 -236,9 +36,10 @@@ config BROKEN_ON_SM
  	default y
 =20
  config INIT_ENV_ARG_LIMIT
 -	int
 +	int "Maximum number of kernel command line arguments"
  	default 32 if !UML
  	default 128 if UML
 +	range 32 4096
  	help
  	  Maximum of each of the number of arguments and environment
  	  variables passed to init from the kernel command line.
@@@ -1263,17 -1462,6 +1263,17 @@@ config USER_N
 =20
  	  If unsure, say N.
 =20
 +config USER_NS_MAP_KUNIT_TEST
 +	tristate "KUint test for user namespace map insertion" if !KUNIT_ALL_TES=
TS
 +	depends on USER_NS && KUNIT
 +	default KUNIT_ALL_TESTS
 +	help
 +	  This builds the KUnit test for user namespace uid/gid map insertion.
 +	  It validates map insertion, limits, dynamic allocation of the
 +	  extended extents array, and mapping sorting functions.
 +
 +	  If unsure, say N.
 +
  config PID_NS
  	bool "PID Namespaces"
  	default y
@@@ -1431,22 -1619,6 +1431,22 @@@ config CMDLINE_FROM_BOOTCONFI
 =20
  	  If unsure, say N.
 =20
 +config COMMAND_LINE_SIZE
 +	int "Maximum size of kernel command line"
 +	default 4096 if S390 || LOONGARCH || MIPS || UML
 +	default 2048 if X86 || ARM64 || PPC || SPARC64 || RISCV
 +	default 1024 if ARM || PARISC
 +	default 256 if ALPHA || ARC || M68K || MICROBLAZE || SPARC32 || XTENSA
 +	default 512
 +	range 896 1048576 if S390
 +	range 256 2048 if ARM || M68K || NIOS2 || PPC
 +	range 256 3840 if SUPERH
 +	range 256 256 if ALPHA
 +	range 256 4096
 +	help
 +	  This allows you to specify the maximum length of the kernel command
 +	  line.
 +
  config CMDLINE_LOG_WRAP_IDEAL_LEN
  	int "Length to try to wrap the cmdline when logged at boot"
  	default 1021

--9myiH7RmOLX2eC/6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCasAzcQAKCRAv73Ows9A4
iWCeAQC8/b92zBLM6cWNWguno++G/FnzQyyypKW1BhXKuazktgD/SCkFS2AtB5QT
LVlimqu7lOX2ILzSyV994IHJwkOoNgE=
=Rv/C
-----END PGP SIGNATURE-----

--9myiH7RmOLX2eC/6--
