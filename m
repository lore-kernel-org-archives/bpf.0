Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C9A416CF4;
	Thu, 13 Aug 2026 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628838; cv=none; b=u3StvmMB2masOHs2IpR6vw5pkXswclYk+VDPFk57Ksth1qlcW7v3Rv5+/0+D3zjfDRZn1i0NwwMX6SpgxOIosOs5V9y0sMVBVmx9B0U+8pPL0dW9jTk6iGtQg0pEDjfp99kH//XDZGEfQY4J3MIJ7TcJuZs8QCknm+fnQ7Ewi9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628838; c=relaxed/simple;
	bh=EhJJGbDik0S5OWZA7WNvSnZ6APV+DpLZb1wjIl210fw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=btiY3shusnPDYch8784rp6CUfR6R3JU2Zq6y/3XZ5v7QbjdBgf/XdYAtNMkWX/XMvo31O/b6+lQOWTcrQTZGChbtcVKhbRTQbKX+sYg+tpabG2pBGc0ClfmT090GiCXdzmLSgLZvVH3U8/QdTlAXegc/Eeyo3KfLSKmJVIA2FVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzlFt9FY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzlFt9FY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AD41F000E9;
	Thu, 13 Aug 2026 13:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786628837;
	bh=Ugf3uy7fwFDhSvZWaxNDkuorNdwUNerWxzz+OJEAJfg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JzlFt9FYm9zKVTxka2R39rEODNywk5zsn9AlhkwQmnbv4z53E66/HlnlSACZZRPzx
	 DU6Dh6JY8Y9+Lc/rSUHkSJm/I/8BIZtyL3+uVz1eJP2/V5tlevOgN3RHTJ1SeM3/f6
	 3fcO+JG036p6kZ7W2LykxFfaOSWJo4NR8Ya1Wbymb2r6hP4kvwNfS71GKCO2PAlpAF
	 FY06glVwkT1vFDciJD+b9tGzSdYE8xApcEvZKb9GR44DZbeHxSGn0YPpytYn41PVcp
	 R/H0Nc85JRbcI+9QPe0TtKrrYfZotQVo62Ag1fkmcXNvKyZ5QZwdNfnjJRTVESvuJr
	 8Vs8TjPb3FLQw==
Content-Type: multipart/mixed; boundary="===============7483017909899596015=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <899b5923662e13603a425d012318ae17c393e1066c0c2891c356397763ad58d0@mail.kernel.org>
In-Reply-To: <20260813-bpf-next-039-ia32-kfunc-return-v1-v1-2-37495ec632b5@mails.tsinghua.edu.cn>
References: <20260813-bpf-next-039-ia32-kfunc-return-v1-v1-2-37495ec632b5@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover IA32 narrow kfunc returns
From: bot+bpf-ci@kernel.org
To: chenyy23@mails.tsinghua.edu.cn,udknight@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,tglx@kernel.org,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,chenyy23@mails.tsinghua.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 13:47:15 +0000 (UTC)

--===============7483017909899596015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index 8113fea7ba86c..4638e0a45db6e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -127,6 +127,7 @@
>  #include "verifier_set_retval.skel.h"
>  #include "verifier_lsm.skel.h"
>  #include "verifier_jit_inline.skel.h"
> +#include "verifier_kfunc_return.skel.h"
>  #include "irq.skel.h"
>  #include "verifier_ctx_ptr_param.skel.h"
>  #include "verifier_zext.skel.h"
> @@ -289,6 +290,7 @@ void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
>  void test_irq(void)			      { RUN(irq); }
>  void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
>  void test_verifier_jit_inline(void)               { RUN(verifier_jit_inline); }
> +void test_verifier_kfunc_return(void)             { RUN(verifier_kfunc_return); }
>  void test_verifier_ctx_ptr_param(void)       { RUN(verifier_ctx_ptr_param); }
>  void test_verifier_zext(void)                 { RUN_TESTS(verifier_zext); }

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_return.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_return.c
> new file mode 100644
> index 0000000000000..52a94daf03922
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_return.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define BPF_NO_KFUNC_PROTOTYPES
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +extern int bpf_strcmp(const char *s1__ign, const char *s2__ign) __ksym;
> +extern bool bpf_dynptr_is_null(const struct bpf_dynptr *p) __ksym;
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} kfunc_return_map SEC(".maps");
> +
> +static const char string_a[] = "a";
> +static const char string_b[] = "b";
> +
> +void __kfunc_btf_root(void)
> +{
> +	struct bpf_dynptr ptr = {};
> +
> +	bpf_strcmp(string_a, string_b);
> +	bpf_dynptr_is_null(&ptr);
> +}
> +
> +SEC("syscall")
> +__flag(BPF_F_SLEEPABLE)
> +__success __retval(0)
> +__arch_x86_32
> +__naked void kfunc_bool_return_zero_extended(void)
> +{
> +	asm volatile ("					\
> +	r0 = 0;						\
> +	*(u32 *)(r10 - 4) = r0;				\
> +	r2 = r10;					\
> +	r2 += -4;					\
> +	r1 = %[kfunc_return_map] ll;			\
> +	call %[bpf_map_lookup_elem];			\
> +	if r0 == 0 goto 1f;				\
> +	r1 = r0;					\
> +	r2 = 8;						\
> +	r3 = 0;						\
> +	r4 = r10;					\
> +	r4 += -24;					\
> +	call %[bpf_dynptr_from_mem];			\
> +	if r0 != 0 goto 1f;				\
> +	r0 = 0x100000000 ll;				\
> +	r1 = r10;					\
> +	r1 += -24;					\
> +	call bpf_dynptr_is_null;				\
> +	r0 >>= 32;					\
> +	exit;						\
> +1:	r0 = 2;						\
> +	exit;						\

Can this test actually detect incorrect sign extension? The dynptr is
initialized by a successful bpf_dynptr_from_mem() on a non-NULL map value,
so bpf_dynptr_is_null() always returns false. Zero- and sign-extension of
0 are identical, so 'r0 >>= 32' followed by 'exit' yields 0 whether the
JIT emits movzx or movsx.

A JIT that wrongly sign-extended an unsigned/bool narrow return would
still pass this test. Reaching a true value would make the case
discriminating - for example, bpf_dynptr_is_rdonly() on a read-only
dynptr returns 1, or an unsigned kfunc that returns a value with bit 31
set.

The commit message states that 'each case ... checks the required zero or
sign extension', but that claim only holds for the int case below.

The new switch on fm->ret_size in emit_kfunc_call() has six size by
signedness arms plus a 'default: return -EINVAL', but this patch only
exercises two of them (bool/1-byte unsigned and 4-byte signed).

> +
> +SEC("syscall")
> +__flag(BPF_F_SLEEPABLE)
> +__success __retval(-1)
> +__arch_x86_32
> +__naked void kfunc_int_return_sign_extended(void)
> +{
> +	asm volatile ("					\
> +	r0 = 0;						\
> +	r1 = %[string_a] ll;				\
> +	r2 = %[string_b] ll;				\
> +	call bpf_strcmp;				\
> +	r0 >>= 32;					\
> +	exit;						\

Does this test codify an architecture-specific extension behavior that
conflicts with the documented ISA and other JITs? The test asserts that
after 'call bpf_strcmp' (which returns int -1 for "a" vs "b"),
'r0 >>= 32' yields 0xffffffff - meaning it expects sign-extension of a
narrow signed kfunc return into the upper 32 bits of R0.

The verifier deliberately does not model any extension after a kfunc call.
Looking at bpf_opt_subreg_zext_lo32_rnd_hi32() in kernel/bpf/fixups.c,
it skips kfunc calls entirely:

    if (!bpf_jit_needs_zext() && !is_cmpxchg_insn(&insn))
            continue;
    /* Zero-extension is done by the caller. */
    if (bpf_pseudo_kfunc_call(&insn))
            continue;

Everywhere else in the ISA a 32-bit definition read as 64 bits is
zero-extended, so the documented fallback contract for a narrow kfunc
return is zero-extension.

On x86-64 the identical program returns 0, because a callee returning int
leaves the upper half of RAX unspecified-but-in-practice-zero and the JIT
stores RAX as-is. No other JIT normalizes narrow kfunc returns either:
s390 extends kfunc arguments but emits a plain 'lgr %b0,%r2' for the
return; riscv64 and loongarch only extend returns in the trampoline and
struct_ops paths.

So the pair of commit 0231085a3eba6 plus this test locks IA32 into
sign-extending signed narrow kfunc returns while every other target
zero-extends, and encodes that divergence as a passing selftest. Either
the sign-extension convention should be stated as the cross-arch contract
(and the other JITs plus the fixups.c comment updated, with the test
tagged for all arches), or IA32 should zero-extend like the rest and this
case should expect __retval(0).

As written, a future patch that makes IA32 match x86-64 will be reported
as a selftest regression.

> +
> +char _license[] SEC("license") = "GPL";

A subsystem pattern flags this as potentially concerning: a whole new
prog file (84 lines) plus a new prog_tests/verifier.c entry point is
added for two cases about the upper 32 bits of R0 after a kfunc call.

Looking at tools/testing/selftests/bpf/progs/verifier_zext.c in the same
directory, it is already the home for 32-bit/64-bit register-half
semantics and contains exactly the same scaffolding this new file
re-creates: BPF_NO_KFUNC_PROTOTYPES, an extern __ksym declaration, the
__kfunc_btf_root() BTF-retention idiom, and __naked asm that calls a
kfunc by name.

Would adding the two subtests to verifier_zext.c avoid the duplicated
boilerplate, the extra skeleton, and the extra test entry point? The new
entry point also uses RUN() (which drops CAP_SYS_ADMIN) while the sibling
test_verifier_zext() uses RUN_TESTS() - another indication the two might
belong together.

> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 07807757b518d..8a9f4a31a1bb1 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -374,16 +374,19 @@ static const char **collect_decl_tags(struct btf *btf, int id, int cnt)
>  enum arch {
>  	ARCH_UNKNOWN	= 0x1,
>  	ARCH_X86_64	= 0x2,
> -	ARCH_ARM64	= 0x4,
> -	ARCH_RISCV64	= 0x8,
> -	ARCH_S390X	= 0x10,
> -	ARCH_LOONGARCH	= 0x20,
> +	ARCH_X86_32	= 0x4,
> +	ARCH_ARM64	= 0x8,
> +	ARCH_RISCV64	= 0x10,
> +	ARCH_S390X	= 0x20,
> +	ARCH_LOONGARCH	= 0x40,
>  };
>
>  static int get_current_arch(void)
>  {
>  #if defined(__x86_64__)
>  	return ARCH_X86_64;
> +#elif defined(__i386__)
> +	return ARCH_X86_32;
>  #elif defined(__aarch64__)
>  	return ARCH_ARM64;
>  #elif defined(__riscv) && __riscv_xlen == 64

Can ARCH_X86_32 mismatch the actual JIT when test_progs is cross-compiled?
ARCH_X86_32 is derived from the compile-time architecture of the
test_progs userspace binary, but the new __arch_x86_32 cases assert a
retval that depends on the kernel's JIT.

For every pre-existing __arch_* user this distinction does not matter,
because those tags only gate JIT-disassembly matching and a 64-bit
test_progs cannot run on a 32-bit kernel.

The reverse combination is legitimate and common though: a 32-bit (i386)
test_progs running on an x86-64 kernel. There get_current_arch() returns
ARCH_X86_32, run_subtest() does not skip, and both new subtests execute
against the x86-64 JIT, which does not sign-extend the bpf_strcmp()
return.

In that scenario kfunc_int_return_sign_extended fails with 'Unexpected
retval: 0 != -1'. If the intent is to detect when the kernel uses the
IA32 JIT, would the gate need a kernel-side probe (such as uname machine,
or a JIT-behaviour probe) rather than __i386__, or would the new cases
need a DENYLIST entry?

> @@ -577,6 +580,8 @@ static int parse_test_spec(struct test_loader *tester,
>  		} else if ((val = str_has_pfx(s, "test_arch="))) {
>  			if (strcmp(val, "X86_64") == 0) {
>  				arch = ARCH_X86_64;
> +			} else if (strcmp(val, "X86_32") == 0) {
> +				arch = ARCH_X86_32;
>  			} else if (strcmp(val, "ARM64") == 0) {
>  				arch = ARCH_ARM64;
>  			} else if (strcmp(val, "RISCV64") == 0) {


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31699378511
--===============7483017909899596015==--
