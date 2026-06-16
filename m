Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B13330FF20
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592820; cv=none; b=qVxHQ9wKRO7PUV55/P+3fVAOptINyj3YvTrB//OAX0zM8wmiT2t0TEqO7ZHP+4QDmDPd8k+y+bBdY+sZ6ar3TpXPALXcSg/vKHmIpsIqeymkeyQaw8tMT6P8cyi7hFUeCxSZSR1NuC8KfvTixsnO7c2moqZXUarcIJRPDqaqxbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592820; c=relaxed/simple;
	bh=FtzjIdGBmXPdBVqQqp0OKnPq2Aj8qUFPkZb0y+c03Rs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=a8aRN3WJVMYwcZCESgPQ7Jxf/Hr8UgOWBnYHioI49OiVqGZpGYAlEbNZT0ph1+eO7g3emJuRu94RXzdsY+QiAalitW8mJ9a+xysXeQqDnGjIb4X5QlyJg1Jjc3IfBa4FQXK5KlWmvxEobWTQDLUqRGnbA3JYcgpjjau5olGb30Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=AAPLxm/1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="AAPLxm/1"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36b903567fdso4766605a91.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 23:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781592817; x=1782197617; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAMbizAsvE1IYkvWb+JTaAfoViw+PfXliSYcH4bZRMM=;
        b=AAPLxm/1jeu3jgFZ3Z8cCssDwEvIoTrhiRVyHwlSCQ5cpnkmB/rqWyvnNrp3Nqj2hh
         oUtaVY+WsyB/ZRV0XWh5ksjByByplhN2uRUkeNFzJ4azGuWd4XZQknwhBtqZ8/+uNum1
         O/8SLRCH24aknB68goVlk30Z9DSoW4/l0UqZSzQSSD9vruIeqeqkvoiHN3v7I8FzVfjD
         vZ/BO5UX9HnRNvIxPU1mhBOD3qJ4kjtlT/MSzYHd+z7pa9u4mnJVyFckyrbzw/leUy/F
         gC/VMSL5jhm7yx5zS7zeJQm/zlkmX+jC2dknewWbhBXwMMU8t0FB8mD4NU4Tuyip3AZx
         jR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781592817; x=1782197617;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NAMbizAsvE1IYkvWb+JTaAfoViw+PfXliSYcH4bZRMM=;
        b=KNhoVmANUzMQIIthXEajZDRwIex03mMfwFxWw4XBpiLA7jBHCwwZUNH61i+NqZn8nH
         PKm2864bbUG8dDlTKnZ3+Am+lPGp0yeWAE52TkAltrHUZ29qwBff1t1kgzI3fPSnUwP4
         OSi69NyLsypyzbxodcPScBpzrO/Jfs61YY1QZOKjIguyGjXLlRRTytLK9lAuvfo8NEHq
         QAsA9Qhgm+C04/Y3le/t75/z8+C3BI06fWAbFnktZTaEU0y/pTPM5atLAMB9QCrh0DRZ
         ll68Me+uOgjS0JpdjHX/vfGZEpFLIkaycw9EHabMAWBH9ExAyIbrwjKzhTL+l2Xjl8Bd
         nlTA==
X-Forwarded-Encrypted: i=1; AFNElJ+3bEPjS+AdkCPsKa08N6Q/dHO9s9UlQq95175jTOntdRKdE1PHdMgDciQmS92UNLKusSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YytvGzTGl7gg5SqTO/mTQ01vQI2GVPIWwFmGihxLZbcS6yEV8nJ
	oVUvyKRaQu8dYpxJKRx6bqGw38IhYKnlsHhG6jIgUkleYBXqvI54PpIPWCV7l4O6rJ0=
X-Gm-Gg: Acq92OGLa0OmZW1GLrFj8RdiyEslKJd5nPdtfJkk5iat+99adJ+30ubr7OHJXKtiBrN
	ZBTs9D6lwjH6QLPf199ruty8QGEGU8Np6XOLtilKtGmANi7077efxE9MIl+t31DfDoG3locX56W
	/BcqPYDg7As0dci4SUnU4jXzJOnA06ocDvNVkhUdbaX4Dqo1G8O6BB7lT4q0BSqYpBtJW3cIhl0
	Uv4gjQRvfBHKIvV+q1BUE1Mnr49ZJO8hRq8h6YMb9P3vhAlyNGFgM+fx9hmA0Pdh/JNn1gl9ivi
	GASj2w1QWFN10LZzhFI/VM9lFb30pVqynGl4DheV3oVsBy6mkbHwx5q0YD5HAdFitC/UyVv0Cwf
	rSYd46edjhoSd4BY9/Ivh/C6QnOsy6xCNVYqNo5Env7MeVLB+nfRdxpl35mlWDK68VGmtge4fTU
	O7DbuMpF5Y05webPUXq6TJ9id+T0nIa7ygUwpmkXpZKJc7yK9Flu60pBzs
X-Received: by 2002:a17:90b:5388:b0:36b:9c4a:e05d with SMTP id 98e67ed59e1d1-37c52909376mr2464111a91.17.1781592817310;
        Mon, 15 Jun 2026 23:53:37 -0700 (PDT)
Received: from localhost (d206-116-244-52.bchsia.telus.net. [206.116.244.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c52092ee3sm1838204a91.0.2026.06.15.23.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 23:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 02:53:36 -0400
Message-Id: <DJA9Y0YAOZG3.1TEPN0383EAL2@etsalapatis.com>
Cc: "Alan Maguire" <alan.maguire@oracle.com>, "Jiri Olsa"
 <jolsa@kernel.org>, <bpf@vger.kernel.org>, <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 03/14] selftests/bpf: Fix resolve_btfids
 test reads of BTF ID sets in PIE builds
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
 <20260601221805.821394-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-4-ihor.solodrai@linux.dev>

On Mon Jun 1, 2026 at 6:17 PM EDT, Ihor Solodrai wrote:
> TL;DR
>
> On aarch64 with gcc toolchain, when test_progs is linked as a PIE,
> reads of BTF ID array by C name return garbage because the GNU
> assembler on aarch64 unconditionally folds .local symbol references
> into section+addend form, and GOT slots cannot carry an addend per the
> AArch64 ELF spec.
>
> Fix by marking the test's BTF ID objects with hidden visibility, which
> makes gcc emit a direct access that bypasses the GOT entirely.
>
> Details below.
>
> The subsequent patches adding kfunc checks to resolve_btfids test may
> cause test failures on aarch64 / gcc-15:
>
>   test_resolve_btfids:FAIL:kfunc_set_flags  actual 13 !=3D expected 1
>   test_resolve_btfids:FAIL:kfunc_set_cnt    actual 0  !=3D expected 4
>
> The test defines its BTF ID sets with the same macros as the kernel
> and reads them back directly by C name (in the same way as the kernel
> code does).
>
> test_kfunc_set is a .local symbol emitted into .BTF_ids by inline asm
> and declared to the compiler as a plain default-visibility
> extern, that is:
>     extern struct btf_id_set8 test_kfunc_set;
>
> Depending on the build environment, test_progs may be linked as a
> position-independent executable (for example, gcc defaults to -fpie
> [1]). In a PIE, taking the address of a default-visibility extern is
> routed through the GOT (Global Offset Table) [2].
>
> The GNU assembler's adjust_reloc_syms() pass (gas/write.c [3])
> replaces references to local symbols with the corresponding section
> symbol, folding the symbol's offset into the relocation addend.  On
> aarch64 this conversion is unconditional: tc_fix_adjustable() is
> defined to 1 for all fixups (gas/config/tc-aarch64.h [4]), so even
> GOT-generating relocations are subject to it.  The resulting object
> file therefore contains:
>
>   R_AARCH64_ADR_GOT_PAGE      .BTF_ids + 0x54
>   R_AARCH64_LD64_GOT_LO12_NC  .BTF_ids + 0x54
>
> However, the AArch64 ELF specification mandates that GOT-generating
> relocations must have a zero addend [5].  The +0x54 is therefore not
> honored: the linker creates a GOT slot pointing at the .BTF_ids base,
> and every access through that slot reads offset 0 instead of 0x54.
>
> This is purely a read-side problem, specific to the PIE test binary on
> aarch64 with gcc toolchain. resolve_btfids patches the set header
> correctly and the .BTF_ids bytes in test_progs are correct. vmlinux is
> unaffected because it is built with -fno-PIE [6] and reaches .BTF_ids
> with direct, addend-preserving relocations rather than the GOT. clang
> is unaffected because LLVM's assembler retains the original symbol for
> GOT relocations instead of converting to section+addend [7].
>
> To mitigate this issue, mark the test's BTF ID objects hidden with a
> visibility pragma so that gcc treats them as non-interposable and
> emits a direct access instead of a GOT load. This keeps the natural
> by-name access, works in both PIE and non-PIE builds, and needs no
> change to the BTF_ID macros or resolve_btfids.

(This is missing your SOB)

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>
> [1] https://gcc.gnu.org/onlinedocs/gnat_ugn/Position-Independent-Executab=
le-PIE-Enabled-by-Default-on-Linux.html
> [2] https://gcc.gnu.org/wiki/Visibility
> [3] https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=3Dgas/wri=
te.c#l922
> [4] https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=3Dgas/con=
fig/tc-aarch64.h#l279
> [5] https://github.com/ARM-software/abi-aa/blob/main/aaelf64/aaelf64.rst#=
5733relocation-operations
> [6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Makefile?h=3Dv7.1-rc6#n593
> [7] https://github.com/llvm/llvm-project/blob/4b3bc46d1d794b8ed78b75ccd35=
a6cc30235bf31/llvm/lib/MC/ELFObjectWriter.cpp#L1213-L1224
>
> ---
> ---
>  .../selftests/bpf/prog_tests/resolve_btfids.c  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/to=
ols/testing/selftests/bpf/prog_tests/resolve_btfids.c
> index d742ecb2ca8e..d0e51979d455 100644
> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> @@ -32,6 +32,23 @@ asm (
>  ".balign 4, 0;                            \n"
>  ".popsection;                             \n");
> =20
> +/*
> + * The BTF ID arrays below are .local symbols placed in .BTF_ids by
> + * inline asm, and are read here directly by C name. To the compiler
> + * they are plain, default-visibility extern objects.
> + *
> + * When test_progs is linked as a position-independent executable (PIE),
> + * taking the address of such an extern is routed through the GOT. The
> + * GNU assembler on aarch64 unconditionally converts references to
> + * .local symbols into section + addend form (".BTF_ids + <offset>"),
> + * but a GOT slot cannot carry an addend (the AArch64 ELF spec mandates
> + * zero), so the linker resolves it to the .BTF_ids base.
> + *
> + * Mark these symbols hidden so the compiler treats them as
> + * non-interposable and emits a direct, addend-preserving PC-relative
> + * access instead of a GOT load, in both PIE and non-PIE builds.
> + */
> +#pragma GCC visibility push(hidden)
>  BTF_ID_LIST(test_list_local)
>  BTF_ID_UNUSED
>  BTF_ID(typedef, S)
> @@ -60,6 +77,7 @@ BTF_ID(union,   U)
>  BTF_ID(func,    func)
>  BTF_SET_END(test_set)
> =20
> +#pragma GCC visibility pop
>  static int
>  __resolve_symbol(struct btf *btf, int type_id)
>  {

