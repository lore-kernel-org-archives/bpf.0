Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0DD632
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770779173; cv=pass; b=PwBdv5OWUeETsq03//Hmk9lIwpsQdHi2bWno+xeQaZSgkMHoOGLv/+4qJpt/2AKLDHb4V2P05AakKA12q+5GCIWFlt6RyeqB8aJ/Gz04ADniGsGKSKbKoNT1lWp+xG/deIB86zu3H6Wh2jzS8iSeMtfTFngpnKWCMWlZzVZZ9Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770779173; c=relaxed/simple;
	bh=RexfdK/OGaVZREpinMebUu9qBWOUhOuQi+DTNLDnJ3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o81otso9TpTQbWHSQkl/ukqfVbqSoUUtnn2N8tukfazJdnakbAWu1XPEhZ6kqq270DZwyKrQXD9LzO2UxfBxK63sJgUGmJ1BzC7PvD3RfzDijQNhKaa8NgLI6NGusA2Mtcls0X2S5g60riL8D+ZK4rEfF0J9112SPHIMQU/26yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c88AG6Sx; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c88AG6Sx"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-435f177a8f7so4651435f8f.1
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 19:06:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770779170; cv=none;
        d=google.com; s=arc-20240605;
        b=aVSBgpjAuEtRzmB+YY29UUp2yNX1PJBUXqNxR0U1o9Nhzgw95d68ab00Cot2y8WLfU
         /YUdnI+v9EQznpIGFvxJOkp+xAw6f9p/QZtDu3PFpvVIKP/LjDtoYki3uPpxrRvwslcu
         I6uRGxBDgY7HLKDP2kHXW6ijGsHuUPkNICIbwKQY1cbcb7112W2Yzgq3E67k4tjorBk5
         8buneA3EP7FlPe3cmd1++Gvtxzl78q4XUWCmrZP7TlK2J7ADz12NSn13Vdio9usumih2
         5cl3K5VbRpVnq8ozSWKJAKHjUOtBXE7hiffZuqb0GLGPczVhZx8ymtKwqdyRoE88agD3
         4o8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BrR3zjDsrY2Lo+UKgwdw/6y6UrXQ/nQNsKJ6mn5lNxI=;
        fh=JLkf6s0VzBoLu5z5aI1wNPdAHKT8kYGlBS7MWN2tHu0=;
        b=UcD5g/+zgipaIvSXxnkHHZjcRoChlOpNgRyCj9Bnpj+b6jZ7H/BuXGDlc9IyI3KSqe
         HfclmLkLwJLMrI+s16d04iRYQqCGrupxk6lOF2eVLneV6S7Gg5q87+H0OtC4QuuqTuUI
         zQuaPW2UCobCF95CzZJnA5XTo2qPfzfwbH2i1GcPTam+ys129GzY1kvfvvh45w5pW9zm
         Cu9Ux8gF+BDRilK7ZLt1BevFCux4CKtb89zJm+xXdUXLY0SF4nAQ8PoODNeKzHUSDad3
         aE5Z3KLPEk1nPnH+3bkzirxSPBayvaxKRMY9rFHbVhTYqPqRUtl1MlHUG1OmZdSlk3P2
         D4iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770779170; x=1771383970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrR3zjDsrY2Lo+UKgwdw/6y6UrXQ/nQNsKJ6mn5lNxI=;
        b=c88AG6SxtWYcvIoQ/yYXsfXW4ZpmeoY0qdBV+eHrGqQKzX2AqY/6OKpChHz3v+9bUk
         LvMDxikJVY3aBDsNYU79809tIiZ7fUNyAELRj66iCuSRFuvcDYYsryw4LUmKY5O0Q59r
         gj9Dx2HRi8CRT6UbQT6e02Ocj6W3ewHjcZlTlCefMuO85loiSY3+64BIsOQFAUwuMzob
         p3lg4wXxX0ZE/HEld7d1I45dpmie6ERh1twyi9dCBdr2mWwxHdbC1W2cuWoP6E7885TK
         D4csX9Px4v+5HlGJhP6QcXLMjTo8RIMfziWLQFCQanMeGq0K0Z9avGQ2shOB4IXkVaSo
         WNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770779170; x=1771383970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BrR3zjDsrY2Lo+UKgwdw/6y6UrXQ/nQNsKJ6mn5lNxI=;
        b=UlcAk1SG/Pw0xNkrdSv9ga3uUwciGz5GHPUFjEHT1P8lA84TIFdBECMwXb6j58PKqV
         90z5cW0VTmsL58U4PkAoojbXMiDz23aBGIpk1VqCVRSu6R6VPYeDQGrTX6sZayKH4tfn
         LGq+iwGV3ILKXUCMK2W+BoAIOECbE+aospLoS5Yj9cYMKTSsN87sEU3uVo00Xqe/J1tq
         PNdXOB4eA01c3/BkCIq0tsaAm3Oe0lM+pokO68EnoJ4fjE6i1bw5hCppB3wn+33lgPy/
         GJyUcRjjMPWUvklJCmOkIXu0HVSqcOXQCssvPl9X/kpRMg3Q1TxGZWSoDH2omMW/Tmkk
         twXg==
X-Gm-Message-State: AOJu0Yx9fHpn2SnbFba5bO+2XE0dZ6fJqeX2VZDzrN0vU0wj3pHc5Zbg
	6QH4ITkzN2egttIAXhn2E/dt/YzV+NPyhUsRZaFPJ+4mXJNDFohy0A4s1ZRKUDxmedRPyOR6oFx
	xkpfKcpNH2vIs2hIN1zpWAqJMeOhb8tQ=
X-Gm-Gg: AZuq6aLd9rJiRlIM5+0oRvLH4v7ihl7bGONjjV4EW1Xemo46V1gQu/klQIWv8kcIiiv
	KDe38FsUhw68Ye/1IOYmGi9GVrJ/J5lXguyQGJzZYdHc8mfA1LZt+jsHy0EETHxuMqQwVFfQU3Q
	8J9jajHUaZoGVFbgx5Qi4bz4WEPguOOngy0MFvvcdkoJhg7d4OiVceembh8euUJchndqyuiamR4
	v7MIX1hkLURcma+cDrXMcRC1wP1AC1aQO7sj9ByEsLMqZFh4DGhBab+jsO7+zmTFP93m0RDQQeU
	Hj0lc2gBgKilZB5xvqwLGlchLmCFxXRByyFVZAEFiGsCvbWATZZksSjeXQpW6q4siRreKCWdyNV
	ljaKRz2OVPcChb+TUpHPCZBenMw==
X-Received: by 2002:a05:6000:18a7:b0:430:f494:6a9c with SMTP id
 ffacd0b85a97d-43782c24fb7mr1443257f8f.17.1770779170148; Tue, 10 Feb 2026
 19:06:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209155919.19015-1-leon.hwang@linux.dev> <20260209155919.19015-2-leon.hwang@linux.dev>
In-Reply-To: <20260209155919.19015-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Feb 2026 19:05:58 -0800
X-Gm-Features: AZwV_Qii0owf0x0JGNl4LGQA8Dt8ccp1AZ3F0XELxSon0biG0XuTcn6-sIAqP6w
Message-ID: <CAADnVQKvoLtURPXWg=CyycE=TcuZggcpMhP=Lcc0wGsj2_tZuw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/4] bpf: Introduce 64bit bitops kfuncs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 7:59=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> Introduce the following 64bit bitops kfuncs:
>
> * bpf_clz64(): Count leading zeros.
> * bpf_ctz64(): Count trailing zeros.
> * bpf_ffs64(): Find first set bit, 1-based index, returns 0 when input
>   is 0.
> * bpf_fls64(): Find last set bit, 1-based index.
> * bpf_bitrev64(): Reverse bits.
> * bpf_popcnt64(): Population count.
> * bpf_rol64(): Rotate left.
> * bpf_ror64(): Rotate right.
>
> Especially,
>
> * bpf_clz64(0) =3D 64
> * bpf_ctz64(0) =3D 64
> * bpf_ffs64(0) =3D 0
> * bpf_fls64(0) =3D 0
>
> These kfuncs are marked with a new KF_MUST_INLINE flag, which indicates
> the kfunc must be inlined by the JIT backend. A weak function
> bpf_jit_inlines_bitops() is introduced for JIT backends to advertise
> support for individual bitops.
>
> bpf_rol64() and bpf_ror64() kfuncs do not have KF_FASTCALL due to
> BPF_REG_4 ('cl' actually) will be used on x86_64. The other kfuncs have
> KF_FASTCALL to avoid clobbering unused registers.
>
> An internal BPF_ALU64 opcode BPF_BITOPS is introduced as the encoding
> for these operations, with the immediate field selecting the specific
> operation (BPF_CLZ64, BPF_CTZ64, etc.).
>
> The verifier rejects the kfunc in check_kfunc_call() if the JIT backend
> does not support it, and rewrites the call to a BPF_BITOPS instruction
> in fixup_kfunc_call().
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/btf.h    |  1 +
>  include/linux/filter.h | 20 +++++++++++++
>  kernel/bpf/core.c      |  6 ++++
>  kernel/bpf/helpers.c   | 50 ++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c  | 65 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 142 insertions(+)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 48108471c5b1..8ac1dc59ca85 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -79,6 +79,7 @@
>  #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its=
 first argument */
>  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its=
 second argument */
>  #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments suppl=
ied by the verifier */
> +#define KF_MUST_INLINE  (1 << 17) /* kfunc must be inlined by JIT backen=
d */

UX is not great.
Just keep kfuncs in C as fallback when JIT cannot inline them
and don't remove spill/fills that llvm leaves for fastcall.

>
>  /*
>   * Tag marking a kernel function as a kfunc. This is meant to minimize t=
he
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 4e1cb4f91f49..ff6c0cf68dd3 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -514,6 +514,25 @@ static inline bool insn_is_cast_user(const struct bp=
f_insn *insn)
>                 .off   =3D 0,                                     \
>                 .imm   =3D 0 })
>
> +/* bitops */
> +#define BPF_BITOPS     0xe0    /* opcode for alu64 */
> +#define BPF_CLZ64      0x00    /* imm for clz64 */
> +#define BPF_CTZ64      0x01    /* imm for ctz64 */
> +#define BPF_FFS64      0x02    /* imm for ffs64 */
> +#define BPF_FLS64      0x03    /* imm for fls64 */
> +#define BPF_BITREV64   0x04    /* imm for bitrev64 */
> +#define BPF_POPCNT64   0x05    /* imm for popcnt64 */
> +#define BPF_ROL64      0x06    /* imm for rol64 */
> +#define BPF_ROR64      0x07    /* imm for ror64 */
> +
> +#define BPF_BITOPS_INSN(IMM)                                   \
> +       ((struct bpf_insn) {                                    \
> +               .code  =3D BPF_ALU64 | BPF_BITOPS,                \
> +               .dst_reg =3D 0,                                   \
> +               .src_reg =3D 0,                                   \
> +               .off   =3D 0,                                     \
> +               .imm   =3D IMM })
> +

why introduce pseudo instructions and this encoding?
Just let JIT identify kfunc calls by address.
bpf_jit_get_func_addr()
if (addr =3D=3D bpf_clz64) ...

>  /* Internal classic blocks for direct assignment */
>
>  #define __BPF_STMT(CODE, K)                                    \
> @@ -1157,6 +1176,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
g *prog);
>  void bpf_jit_compile(struct bpf_prog *prog);
>  bool bpf_jit_needs_zext(void);
>  bool bpf_jit_inlines_helper_call(s32 imm);
> +bool bpf_jit_inlines_bitops(s32 imm);
>  bool bpf_jit_supports_subprog_tailcalls(void);
>  bool bpf_jit_supports_percpu_insn(void);
>  bool bpf_jit_supports_kfunc_call(void);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index dc906dfdff94..cee90181d169 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3113,6 +3113,12 @@ bool __weak bpf_jit_inlines_helper_call(s32 imm)
>         return false;
>  }
>
> +/* Return TRUE if the JIT backend inlines the bitops insn. */
> +bool __weak bpf_jit_inlines_bitops(s32 imm)
> +{
> +       return false;
> +}
> +
>  /* Return TRUE if the JIT backend supports mixing bpf2bpf and tailcalls.=
 */
>  bool __weak bpf_jit_supports_subprog_tailcalls(void)
>  {
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 7ac32798eb04..0a598c800f67 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -29,6 +29,8 @@
>  #include <linux/task_work.h>
>  #include <linux/irq_work.h>
>  #include <linux/buildid.h>
> +#include <linux/bitops.h>
> +#include <linux/bitrev.h>
>
>  #include "../../lib/kstrtox.h"
>
> @@ -4501,6 +4503,46 @@ __bpf_kfunc int bpf_timer_cancel_async(struct bpf_=
timer *timer)
>         }
>  }
>
> +__bpf_kfunc u64 bpf_clz64(u64 x)
> +{
> +       return x ? 64 - fls64(x) : 64;
> +}
> +
> +__bpf_kfunc u64 bpf_ctz64(u64 x)
> +{
> +       return x ? __ffs64(x) : 64;
> +}
> +
> +__bpf_kfunc u64 bpf_ffs64(u64 x)
> +{
> +       return x ? __ffs64(x) + 1 : 0;
> +}
> +
> +__bpf_kfunc u64 bpf_fls64(u64 x)
> +{
> +       return fls64(x);
> +}
> +
> +__bpf_kfunc u64 bpf_popcnt64(u64 x)
> +{
> +       return hweight64(x);
> +}
> +
> +__bpf_kfunc u64 bpf_bitrev64(u64 x)
> +{
> +       return ((u64)bitrev32(x & 0xFFFFFFFF) << 32) | bitrev32(x >> 32);
> +}
> +
> +__bpf_kfunc u64 bpf_rol64(u64 x, u64 s)
> +{
> +       return rol64(x, s);
> +}
> +
> +__bpf_kfunc u64 bpf_ror64(u64 x, u64 s)
> +{
> +       return ror64(x, s);
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
> @@ -4578,6 +4620,14 @@ BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
>  #endif
>  #endif
> +BTF_ID_FLAGS(func, bpf_clz64, KF_FASTCALL | KF_MUST_INLINE)
> +BTF_ID_FLAGS(func, bpf_ctz64, KF_FASTCALL | KF_MUST_INLINE)
> +BTF_ID_FLAGS(func, bpf_ffs64, KF_FASTCALL | KF_MUST_INLINE)
> +BTF_ID_FLAGS(func, bpf_fls64, KF_FASTCALL | KF_MUST_INLINE)
> +BTF_ID_FLAGS(func, bpf_popcnt64, KF_FASTCALL | KF_MUST_INLINE)
> +BTF_ID_FLAGS(func, bpf_bitrev64, KF_FASTCALL | KF_MUST_INLINE)
> +BTF_ID_FLAGS(func, bpf_rol64, KF_MUST_INLINE)
> +BTF_ID_FLAGS(func, bpf_ror64, KF_MUST_INLINE)

Mark all of them as fastcall and do push/pop in JIT when necessary.

pw-bot: cr
