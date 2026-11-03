Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732252;
	b=rkTMbQ8LXaJgZ1QNOZ0CrT366m5HQtupYL2u5S38UTAupJMRt/ImXZDN+kic46LEaVWH
	 qrxfpTJhUd+Z8F86OAVvCCiEvwseyxyyYjVDd8dfgpr0vQ4pIwDnqkZy4vU7aMnhmjqV2
	 afd/+A2JuHnq1BFxnBO6Scm0MQ91nfu+GR48CCc8r9Z8zjY+5yJVSB+J64ks3oh5BNiZp
	 qXgsMkSr3U0KCNbtkanKnFAy1FVT4JJE+Fqf+bw3p5SXJ7NGHgDEVeUr3wyb9YLIEcF0z
	 KvR727wgneZ+k16S6f8NpxT9dBTGF47XXEjgIWBZsUCenckNWRXgp68Ki3rSNbZOKYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732252;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=uxUt2GKCrsv9nXTUYoHe18JWP28TYoHDRhXUA7khBmQ=;
	b=pEFhaOE7RFBnQHkRpsvVEcd44g1h1pGKUF1w1KBmUOMJs2WZUbxD0VHxWwDCXXwxQKoU
	 mIwMBy0JxkE2A5q+Q+tNrkBVRqAcZ2f6walpCQUCHIiaZI/ytdyM4pgIKVfzw8h9mirSj
	 YbebjAqm9Ylj6ez7DJp1GD8VshHoMy3Pvmzwfc81uD3HhcRAN90VRADraXuPjHNnvwZDl
	 GIJGXztrLItTTP+CqokQ9YG7ve8zy+AhIgLMDxZHAbSZFAvQJ4shRLNlK3WyoDcFWwMwL
	 EaDWI2MO3Nox+8zePLDMte44UjAjeh/KFQo6LkfUtTTYKzPA6qoT3+69/kN5mHWklzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="T/F5VN2J";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F1606D81E;
	Tue,  3 Nov 2026 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T/F5VN2J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA5D1F00A18;
	Tue,  3 Nov 2026 18:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793732251;
	bh=uxUt2GKCrsv9nXTUYoHe18JWP28TYoHDRhXUA7khBmQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=T/F5VN2Jj9/M83abzi4rapliyc2z3IwzG0mE8/LSYqRNeR7kHk/QKqplGDlE6WqWk
	 AilT0agYvJpokhhl7B9bhm1BxewRGB9ZNhjJe5CPf247PIyIQ19Qka8yfXk2jfh0Zz
	 KUsWs3T02xxn0rYlaAz3+JvzFg/ZAWpoHCEn/gj6aDvN3rmAVd9Agkn742BcugwsvS
	 WxkjkcUMm5qfFzzr56/82v0VxlJIBTLYAYTe71RL+gxSbNU+uVaicRFMWb2mPxU/Z+
	 k88y8zKM3kBmFr/aeH/XWti6XU8Wm+1+BK/6cnTGzHw15ZK6VBJrEx7/nH2X3w3IVq
	 ljdy7G0woY9pQ==
Content-Type: multipart/mixed; boundary="===============1979475058215293983=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <bbbf8bd524822c540e8f3d6b56113076f079f1510d4b8a930a2b4db26690af14@mail.kernel.org>
In-Reply-To: <20261103181816.254686-7-vineet.gupta@linux.dev>
References: <20261103181816.254686-7-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v4 6/8] selftests/bpf: drop the arena guards and tag the tests that need arena
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,shuah@kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,jose.marchesi@oracle.com,david.faust@oss.qualcomm.com,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  3 Nov 2026 18:57:30 +0000 (UTC)

--===============1979475058215293983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: drop the arena guards and tag the tests that need arena

TL;DR: Removing the addr_space_cast guards may break the selftest build with
clang 17/18, whose assembler lacks that mnemonic, so test_progs may fail to
build; keep a guard or emit raw bytes.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c

[ ... ]

> @@ -503,13 +482,10 @@ int arena_kfuncs_under_bpf_lock(void *ctx)
>  	bpf_arena_free_pages(&arena, page, 1);
>  
>  	bpf_spin_unlock(&arena_bpf_test_lock);
> -#endif
>  
>  	return 0;
>  }
>  
> -#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> -
>  /*
>   * Test that scalar += PTR_TO_ARENA correctly upgrades the
>   * destination register to a PTR_TO_ARENA.
[ ... ]
> -#endif /* defined(__BPF_FEATURE_ADDR_SPACE_CAST) */
> -

Can this break the build with clang 17 and 18?  The removed guard also
kept the textual addr_space_cast mnemonic away from assemblers that do not
know it, since that mnemonic and __BPF_FEATURE_ADDR_SPACE_CAST both
arrived in LLVM 19.  Asm such as this is now always assembled:

    asm volatile (
        "%[arena_ptr] = 8192;"
        "%[arena_ptr] = addr_space_cast(%[arena_ptr], 0, 1);"
        ...

in scalar_add_arena_ptr(), arena_ptr_add_arena_ptr(),
mixed_arena_scalar_alu64_scalar_first(),
mixed_arena_scalar_alu64_arena_first(), scalar_xor_arena_ptr(),
arena_ptr_add_to_non_arena_ptr(), non_arena_ptr_add_to_arena_ptr() and
mixed_arena_stack_atomic().

verifier_arena.skel.h is included by prog_tests/verifier.c, so test_progs
and its no_alu32 and cpuv4 flavors would fail to build, not just these
subtests.  __skip_without_arena does not help since this fails at build
time.

Other places in the tree keep the guard for this reason, for example
arena_atomics.c and commit 9e35f216e5c5.  Would a guard like
"defined(__BPF_FEATURE_ADDR_SPACE_CAST) || !defined(__clang__)", or
emitting the cast as raw bytes (as bpf_addr_space_cast() in
bpf_experimental.h does), keep both bpf-gcc and older clang working?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_hmul_arena.c b/tools/testing/selftests/bpf/progs/verifier_hmul_arena.c
> --- a/tools/testing/selftests/bpf/progs/verifier_hmul_arena.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_hmul_arena.c
> @@ -5,8 +5,6 @@
>  #include "bpf_misc.h"
>  #include "../../../include/linux/filter.h"
>  
> -#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> -
>  #define BPF_UHMUL64_IMM(DST, IMM) \
>  	BPF_RAW_INSN(BPF_ALU64 | BPF_MUL | BPF_K, DST, 0, BPF_UHMUL, IMM)
>  
[ ... ]
> -#else
> -
> -SEC("socket")
> -__description("HMUL arena tests require compiler support for addr_space_cast")
> -__skip("compiler doesn't support addr_space_cast")
> -__success
> -int dummy_test(void)
> -{
> -	return 0;
> -}
> -
> -#endif
> -
>  char _license[] SEC("license") = "GPL";

Can this break the build with clang 17 and 18?  uhmul64_arena_ptr() and
shmul64_arena_ptr() contain:

    "r0 = addr_space_cast(r0, 0, 1);"
    "r1 = addr_space_cast(r1, 0, 1);"

The guard was about assembler support for that mnemonic (LLVM 19 and
later), not about compiler arena codegen.  With clang 17 or 18 the
integrated assembler rejects these lines, so verifier_hmul_arena.bpf.o
fails to build, and test_progs with it.  Previously those toolchains got
the dummy SKIP.

Commit ddd86412ac01 which added this file says "Retain
__BPF_FEATURE_ADDR_SPACE_CAST gating and a dummy skip program for
toolchains without addr_space_cast support."

Could the guard be kept in a form that both bpf-gcc and LLVM 19 or later
satisfy, for example "defined(__BPF_FEATURE_ADDR_SPACE_CAST) ||
!defined(__clang__)"?  Or could the cast be emitted as raw bytes with
.8byte/__imm_insn(), the way the HMUL instruction itself is emitted here?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> --- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> @@ -257,8 +257,6 @@ __naked void ldsx_ctx_8(void)
>  	: __clobber_all);
>  }
>  
> -#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
> -
>  struct {
>  	__uint(type, BPF_MAP_TYPE_ARENA);
>  	__uint(map_flags, BPF_F_MMAPABLE);

Can this break the build with clang 18?  The outer guard of this file
accepts any clang 18 or later:

    (__clang_major__ >= 18 || defined(__BPF_FEATURE_LDSX))

but clang 18 does not have the textual addr_space_cast mnemonic.  The
inner __BPF_FEATURE_ADDR_SPACE_CAST check was what kept the Arena LDSX
programs away from it.  Now arena_ldsx_disasm(), arena_ldsx_exception()
and arena_ldsx_s8/s16/s32() are assembled, and lines such as

    "r0 = addr_space_cast(r0, 0, 1);"

are rejected, so verifier_ldsx.bpf.o fails to build.  Would an inner
guard like "defined(__BPF_FEATURE_ADDR_SPACE_CAST) || !defined(__clang__)"
keep both working?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_zext.c b/tools/testing/selftests/bpf/progs/verifier_zext.c
> --- a/tools/testing/selftests/bpf/progs/verifier_zext.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_zext.c
> @@ -324,8 +324,6 @@ __naked void alu64_and_conditionals(void)
>  	: __clobber_all);
>  }
>  
> -#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
> -
>  SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
>  __arch_s390x
>  __xlated("7: w1 = w0")
[ ... ]
> -#endif
> -
>  /* Check if probe mem loads keep their zero extension. */

Can this break the build with clang that lacks the addr_space_cast
mnemonic?  arena_ptr() and zext_arena_cmpxchg32() now always contain:

    r1 = addr_space_cast(r0, 0, 1);
    r2 = addr_space_cast(r1, 1, 0);
    r1 = addr_space_cast(r1, 0, 1);

With clang 18 or older the assembler rejects these, so verifier_zext.bpf.o
fails to build.  That also takes the roughly twenty non-arena zext
subtests in the same object with it, and since prog_tests/verifier.c
includes verifier_zext.skel.h, test_progs fails to build.
__skip_without_arena cannot help because it is a runtime test_loader tag.

zext_arena_cmpxchg32() already emits its cmpxchg as .8byte through
__imm_insn(BPF_ATOMIC_OP(...)).  Could the two casts be encoded the same
way, for example with __imm_insn(BPF_RAW_INSN(BPF_ALU64 | BPF_MOV |
BPF_X, dst, src, BPF_ADDR_SPACE_CAST, (dst_as << 16) | src_as))?  The
alternative is to keep a compile-time guard for compilers that lack the
mnemonic.

The same pattern appears in the other files unguarded here:
jit_insns_arena.c and compute_live_registers.c.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41694978246
--===============1979475058215293983==--
