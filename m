Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0DC3D904E
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530355; cv=pass; b=Bn9xIeTa0wjq4U9aE9q7ltFwB9/agcDBTwt7tjlv2/oRFQyjPix/LUFX4V0DuUjsVCLFpt0s1yEJcLviMJzlDBdpjeFP3btknfMOGktrynsVWANGh5IOjP89+phv/5/D3tSenjD2HzZ7QjACGGwv0XrNi81Xt+8+oi9CZtOEU5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530355; c=relaxed/simple;
	bh=GsSyQi0Rmh/mLhiNbNqbWD9VQM1yl2uSBWhUyK8SnkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2o3XfKgX4pPga3Ul384GWole7RJcdMRog5/3x7Os6MssR08cE0Rxzrkwm/EG2cMEodzRgqK8/vGAGVLo69gMmwAADTzSwU+cu82yxMkDhqbbP6y0haAr4bA6k9bFZMDlCourG5MQDO40VqQ+jWTathL9r6HsZWpevJoI1P3eBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyJYab49; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyJYab49"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-842358aaf36so33124b3a.2
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 16:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780530353; cv=none;
        d=google.com; s=arc-20240605;
        b=PHgKss7FmgBC14ElvXzHqMEj19OyiY8Ra3TrSRN/3Gm78lvLT9baaSxV3KuudGMVI0
         N4Qn4EvtesCARXDxIn9qTFLqpaAQMlg42BkPLGUimmsD4B6ZBhUBXDhFbdoM9pZrtTFU
         RGd9RRKN8m2mY0/RGraDHeHdlyx2rEIF+YMsj/GoAFQ1ZT3iP0r7xrP0IwbiOcKfkGBt
         1gBaO07AfDZxru9VLZomcvyHJCCis4V2I2u7gzI1XdpaxaJN3LeAzCRwI8KAN+iAUPAn
         5Kt8wPO/DOoFH5zay5zwvBrPhHRTO1fb3nS8c3FwPsKkFmy9niCeS6R2jcdL0tVp4CjJ
         uxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CkgZL+58ql+bztqsx7oOmXRiL9ccnlrzQ1mrYu35Xvg=;
        fh=kThtw9MB1rTN8/cK7J7A3E0bur1UKFoXFkLCa737OYQ=;
        b=fhHn8M+HXTD8o5fPXdavx3FK6KGu2YUzZ2rtnzYbg+drd4vLgs4cLDpByt8kC8dpcN
         OKeqf+dx1juzn0kI0i0PJyzN9jaYSN5bNQTGO05ckdp+Ghv05V378xMbtCISCQPFCyKT
         CnFSu2l897+P0RE+ONlBcFVh3BmVBH6VriWC90rv2dMgUK7Y2/1vQKbDNCl/6+QFw+pY
         s1qh5a2WM1jDhHrlildyobLb4KVkEX5t/Nr5LpKSgMF5hh6n8LjDjHx/PPmUzyYvSVJr
         r/9rPCVRi/4ZCT+gKQ0KWmUEbc1so92Wwna6zLRogQBbTbXQ54F7dz7hWBz+sIR0uXZl
         lGzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780530353; x=1781135153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkgZL+58ql+bztqsx7oOmXRiL9ccnlrzQ1mrYu35Xvg=;
        b=CyJYab49d2KS7ZSpECWXOmMphUBLw5d9yLgmLE7HWU/dil4hLKIaV6w7XZjt/BcAlt
         ovZQCdKENij95X6SmEvql9TeFYlcPnhphf8/aro1tXHtl+lfqQ7mUyVqI5TTdRnXeain
         8OJbF8u4Sx+x7CG/buvdlURQIZlGCcmtYBv5BNmrtQyf34AExoxu1+vq2BnJvIAuydei
         0vQ7hq6RmKwfwJjLCIufhGtV1EvQuAL4comS/O7raPM5G4fvazQgGGy9Ug4lTXc33sXl
         +owHzpJ8bY9dguUjNX8wQXY45Cgd5C7fpmhjpBLg4ubIsYaXP9onptBzZzQedeLv4b1X
         ausA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780530353; x=1781135153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CkgZL+58ql+bztqsx7oOmXRiL9ccnlrzQ1mrYu35Xvg=;
        b=FeoCW+MdoddC/4nrGl/auyskgGHSd4CKFRJdHtKVyIBKlXX/87vq/0N5WmEhnba9b+
         asSwzxUr8drLSCqwssbfb05zlJnKAkvmIhgSLSpAJ+j6fDHYFWMbzViUTYDxY0ovIYar
         M8HHE/40QBOxelpD+2NEEAoxMAPLXRKqtAGrZWrXbDL22ZhFXIKCQJB90ZVjXywsm8D3
         6KsuswwhrdgDfYVwaWjKeEY49O9ALGw2UcplbwxI0HkBxq0OZcpxs8sHCUvhABWYgHSh
         32s7Ih73CKQwDAFf+FybCeQSTWzDlmuTCFVLEMHPwctZ8LO0cowhriBbq+WV4kqw+lyy
         /y5w==
X-Forwarded-Encrypted: i=1; AFNElJ9QbKX61Tfy9U/2VUei/6qIlzRvH9OdHdPEl+ZX4BNbhR42yNLieczhC9AnH7mun7Imy6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZSwgeEfbTc2fVGX1M0yz2ag1DI723Id6WX7UE9WJOeSn0VYXD
	Ivi/KSP9/OlxeYcj2yhqU29/qbrpFy55GrxaSC/ngyluprtCpiUI6jSCoyI5Dmcz3ErVEN9evou
	+wVmxQlh4ohO439F9veEvlhuB9cyYViY=
X-Gm-Gg: Acq92OE+Sa9yzj4+79CkkGqB8PuCncIaBLsUe8L1/g76mEWNvquiPyshbtyQ8ilgy6H
	aS3UhTCCiKpGJnGhS/xsGUVO3GkHRI4wDPwSYDjbYBlIs6khZXfYwA5vBgHzlfA1q2HIL2xVbVX
	QKe3MPFUXMpqaQFisHNS4ONRTxLU0gyKSeKpz5k9noJ9aCEWltjRx4aXIqXKVqUGVRKWLRdeFKd
	LtnZZlaH+timlfPtMIBnX/c6WFJGnD+lLR1sge9FFO/ggJEx9nYIXey+aJLfP84xdfh1R2ieMVJ
	7BuEp9vggzekHcSFhg==
X-Received: by 2002:a05:6a00:b56:b0:838:a46:ce96 with SMTP id
 d2e1a72fcca58-84284f5f5b7mr5135584b3a.27.1780530353094; Wed, 03 Jun 2026
 16:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601221805.821394-1-ihor.solodrai@linux.dev> <20260601221805.821394-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-4-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jun 2026 16:45:37 -0700
X-Gm-Features: AVHnY4IHUCMvhhzS4aH2hkfZA7z-wgFlsD2LjwAgYH16lMrWOW9SOCVNACcMLxs
Message-ID: <CAEf4Bzawb0qkNR3Cf5aQve5anGDvrfBX6g2B-B7RESdsvUVdvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 03/14] selftests/bpf: Fix resolve_btfids test
 reads of BTF ID sets in PIE builds
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 3:18=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
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

fascinating! but you also missed adding your SOB

Acked-by: Andrii Nakryiko <andrii@kernel.org>



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
>
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
>
> +#pragma GCC visibility pop

nit: empty line after pragma, no empty line before pragma so it "hugs"
relevant pieces of code instead?


but also, can't we just use BTF_ID_LIST_GLOBAL instead to avoid all this?


>  static int
>  __resolve_symbol(struct btf *btf, int type_id)
>  {
> --
> 2.54.0
>
