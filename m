Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5165E3F7892
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786965115; cv=pass; b=IpWRB9K81E4musToAKkL6iX7PnjE8kvUMOIdP/i5kRK/qjJfmHlUEZriyDFhm4PJd1E7jRgfdYdprCBGWGUbLPAwf/WqeYzsV3c6n94MpzRvHKDgqq2imUbBRB2KIL9rLBZ0PpppsC7Lh31kHHZ012CbZYLiGemmw+IEioVtF0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786965115; c=relaxed/simple;
	bh=kM7M9dhmSt1CNHwURST0ibANlBcU5MfqSMaB3wDSgdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDqItutK37yR/PmtvPEPk8qBlTAzWXqDye2glAH+jcNXLQ1ICyqajxhUx2TiJG/6dwZo8/5iA//2PZJI0lO05Zf4m4VE2Xpcd8q/ec1gsa4rS+J87F4GQRLT8jml5SgZMXJrpXPQVtrGZKYRh4lXegUNBO8XV4+v0s9pUnG/eck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgY7t70q; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgY7t70q"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so1914554a12.2
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 04:11:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786965113; cv=none;
        d=google.com; s=arc-20260327;
        b=QD3Ej4MPcr2MdI4XGaJS7n7ny6eMoItsKiRInvf1qwaFhSJ4PdRKUU8Qu4brCvmmJ6
         1aJEU3b0S9SrebPvtYOIoGBEB4eLpAQetjoHsyjtB1nfo9Cpt1w5M8G1t11hYQ/OsSkJ
         TqBGHALDfy6amZ/KLtALsO+zA2waCJOW9LPk/jlYMcUnkUCdEeIsNDVfqenA5vS5LhsU
         sU2PGzSrhcu8YVRAsPmyOWd/giB7VkRxJMv7FVMqhrjVL89b5FspELeEnHqrFDRTySFo
         juo8/3wk9AkjKzUSi0jdFSlXyrU2RVQo3dC7DT+9jx0rUMjO6AH1vg3UMfeEB4yWRxge
         Xkhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B/0Tohsp6Mp7x0D5GYfyZ0+VBe0eqTE/tewPUmmJv7g=;
        fh=YND17yVPqZwuQqswW1N8Cs/JLHTltHqTs+DQzPUXs6Q=;
        b=PwgyidrQHuUm8k4nP4yom3aham4soQQjju4pRPzH5d57KCQDnBfdUZFWFFV+S82DCi
         QliVddaPHNtO8csbBaShzgJ58Aiozc5oyeB7MeB6zc19iGHIp7hyokt08RBpmU07+9M/
         px3g5YSd+W3wi4n41bIi2qwJ0SXHKcXeX+CMrw9po8P65h2kLyVzYJhrmm4nTXt4GCM7
         27dC4ltySFyPfIM0+zXkBzpFtVN9lAy6lXvrZYnLST/os8SYKDje9H6lpp/yG8QPpFD1
         wFQL1WT+w9znfshUdcg4gkq/QK1CpPyWDz6mMhCKT0fc/lFX7eUPLxSYLZppDKeolJd8
         Yvsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786965112; x=1787569912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B/0Tohsp6Mp7x0D5GYfyZ0+VBe0eqTE/tewPUmmJv7g=;
        b=BgY7t70qhRo2fOAhAKQhhuTdBwlIZXKyJ03fFftZPke+64C/aR7PzITY/WuaGPtQ3v
         7a3aEpXpq/gaLj4hPoWydqZVv9VCNVpBcM72DNQ/6BuwZGIlawKs7evEIH+ycScHzSdM
         h2UQ+53ePOAXWGoL9eQkUqiX9EyFEnX3oYI4QiW8Od49rZtKAb572+K3SIXzkLwA6BhM
         ENj2FSXh6YSYzwbQCPbhG/37W7W4NzOMTo06FB5p7VLt7RO93XcXCDdD+ua/AgiwrVFL
         DwX6wC83IEerlRMY4xs3RNZfzRdknS4vI6VvTxN2CaAqmfwecSlx0t/ElnpPdMfINO+V
         Vsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786965113; x=1787569913;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B/0Tohsp6Mp7x0D5GYfyZ0+VBe0eqTE/tewPUmmJv7g=;
        b=BEYA7oWkkjhqSuA0AOgkGDVxP340fs55NRphRSHkHSclQMU4jg2GYMcESjZrJVLDO2
         Q+eH9XWXBiVOA/2HeW0Ph0ROtjsJT57T127AVFpO0LzeW+w6FrGgv5pxWCJZEXvxELjc
         BkqWQEy/SzLlB6M8B/IpXA3M7P+S3xhEAZyEcbhQ8hSxIQ57/UPEqLRwmc2zXSYTcO+D
         mISv6yIa2WxQj5aGn01v59VjTJmmnVzGl4IpEuGUCZCD/bcQMJJrcVXtnbywg1W1eF0p
         Vt3hZ1LBr/jROieN64k/lh66BOjn9FbUDHuXzSWYqaGCdH8BmmkDffKO+qBOHvTIYDh5
         6Stw==
X-Gm-Message-State: AOJu0Yzb2va9YwP+9RJGX9EZ9E79LeQo9A7f7L3N5ScEhqqlt7VzqRZw
	4HxVyhCRF4l92Z/AM7b16tT80Sryy2K3vmcnDypEmxLNHPQWv/JPdTQ4n8wyLd4u752hxnKxBJC
	mj4MecYGDDMg3MfQv+w25BqY+ES6l4xQ=
X-Gm-Gg: AR+sD10xx+2iHNaFUFw96Ys0vkeaqxzubBkyeOOEh3mRJ6VxThba1eumgtyiOwt2cdO
	fOJaVh37iWUE3cTPc31mkpA488RnBV0PXuM9BWzNKDi9V6rwcKBTJQxlmy7dNPEScBqmGUmIMFj
	2tKoQArsrycW1FrJi15opdnkWFoP2WYCMN2+YpJfujej8Fd1fVyagxcH3fHbtmEHL4kPPdtWOd7
	TOseyEcnx+bDTZDWQRnwda0MKDNkUZmSfrvb8DrsYhsVt/tqDrlpzwK0x5bHuhY4PDMT+I2sOl0
	439PzfhBkTpRYySrzkgdK7Nb9DOXEkQkRMp1GL5KasItZAs=
X-Received: by 2002:a05:6a20:3ca5:b0:3c3:c080:71ca with SMTP id
 adf61e73a8af0-3cc7148a154mr25217473637.0.1786965112393; Mon, 17 Aug 2026
 04:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807-static-zext-v4-0-b6c270013c77@gmail.com> <20260807-static-zext-v4-7-b6c270013c77@gmail.com>
In-Reply-To: <20260807-static-zext-v4-7-b6c270013c77@gmail.com>
From: Min-gyu Kim <gimm78064@gmail.com>
Date: Mon, 17 Aug 2026 20:11:40 +0900
X-Gm-Features: AcwNN1VhEPr2ejNC6h4J1n-GZHegcXbKimE_ZBqqp-egQ8Y5Snr7zWxMIe88b4Y
Message-ID: <CAGKGUvmh9puwO6BLME1sZq1QCdvMk-P1qsBcwB0PyDs+Dpa2Rw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 7/7] selftests/bpf: verify zext_dst
 annotations for various instructions
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, iii@linux.ibm.com, 
	info@starlabs.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Thank you for preparing the fix. I tested the v4 series against my
reproducer on s390x.

Tested revisions

I first built and booted the exact final commit of the v4 series applied by
the patchwork bot:

  8b365b3c68b474a1053ec0755dacdc751578afb0
  Linux 7.2.0-rc6-g8b365b3c68b4

I then fetched, built, and booted the current master directly from the
official bpf-next repository on 2026-08-17:

  repository: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.=
git
  commit:     8eb18920646415f6b4f100b34bd456c4fe002196
  Linux:      7.2.0-rc6-g8eb189206464

I verified that the v4 final commit is an ancestor of this master revision,
which contains 106 subsequent commits. Both tested source trees were clean.

Test conditions

Both kernels were tested in s390x QEMU guests with Debian trixie userspace.
The reproducer ran as uid 1000 with every capability set, including the
bounding set, cleared:

  CapInh: 0000000000000000
  CapPrm: 0000000000000000
  CapEff: 0000000000000000
  CapBnd: 0000000000000000
  CapAmb: 0000000000000000

The relevant runtime and build conditions were:

  kernel.unprivileged_bpf_disabled =3D 0
  net.core.bpf_jit_enable =3D 1
  CONFIG_BPF_JIT_ALWAYS_ON=3Dy

The BPF program was accepted, attached as a socket filter, and JIT-executed
in every run. The result was therefore not caused by verifier rejection or
interpreter fallback.

Results

The results were identical on the v4 final commit and the later bpf-next
master revision.

I ran my reproducer ten times on each kernel. All runs stopped before a
kernel address could be disclosed or an out-of-bounds read/write primitive
could be established. None reached the task, credential, or
privilege-escalation stages.

I also ran a focused regression test using the same verifier/JIT mismatch
trigger to distinguish the attempted out-of-bounds accesses from valid map
value accesses. On each kernel, all 20 runs confirmed that both the read an=
d
write remained within the map value.

Finally, I ran the merged zext_lost_across_checkpoint regression program
with BPF_F_TEST_STATE_FREQ and BPF_F_TEST_RND_HI32. On each kernel,
BPF_PROG_TEST_RUN completed all 20 repetitions with:

  PASS: zext_lost_across_checkpoint retval=3D0 repeat=3D20

The kernel taint value remained zero after testing. I found no BTF error,
BUG, WARNING, Oops, user process fault, kernel panic, timeout, or signal
termination.

These results confirm that the merged v4 series prevents the s390x
verifier/JIT zero-extension mismatch exercised by my reproducer. The same
behavior is preserved in the tested current bpf-next master revision.

For the v4 series, my test result is:

  Tested-by: Min-gyu Kim <gimm78064@gmail.com>

Thank you for your time.

Thanks,
Min-gyu Kim

2026=EB=85=84 8=EC=9B=94 8=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 6:00, Ed=
uard Zingerman <eddyz87@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Includes the following test cases:
> - a test showing that zero extension flags do not propagate through
>   state pruning in the unpatched kernel.
> - a 32-bit subregister consumed by MOV32 and ALU32 operations
>   (never zext'ed);
> - a 64-bit MOV (never zext'ed);
> - a narrow (32-bit) BPF_LDX load whose result is read as 64-bit;
> - 32-bit atomic fetch_add and cmpxchg whose result is read as 64-bit;
> - a CFG case where a 32-bit definition's upper half is used only on one
>   of two branches;
> - no zext for dead registers;
> - LD_ABS defines only lower 32 bits, hence needs zext when the result
>   is used as 64-bits;
> - helper, kfunc and subprogram parameters are considered to use full
>   64 bits;
> - a 32-bit subregister consumed by JMP32 (X/K) operations;
> - a 32-bit subregister consumed by JMP (X/K) operations;
> - a 64-bit register consumed by both JMP and JMP32 operations
>   (never zext'ed);
> - ALU64 and address space cast operations on arena pointers;
> - memory loads using BPF_PROBE_MEM instructions.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/verifier.c |   2 +
>  tools/testing/selftests/bpf/progs/verifier_zext.c | 392 ++++++++++++++++=
++++++
>  2 files changed, 394 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index b79bafca68f7..0baa74618fa0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -126,6 +126,7 @@
>  #include "verifier_jit_inline.skel.h"
>  #include "irq.skel.h"
>  #include "verifier_ctx_ptr_param.skel.h"
> +#include "verifier_zext.skel.h"
>
>  #define MAX_ENTRIES 11
>
> @@ -281,6 +282,7 @@ void test_irq(void)                       { RUN(irq);=
 }
>  void test_verifier_mtu(void)                 { RUN(verifier_mtu); }
>  void test_verifier_jit_inline(void)               { RUN(verifier_jit_inl=
ine); }
>  void test_verifier_ctx_ptr_param(void)       { RUN(verifier_ctx_ptr_para=
m); }
> +void test_verifier_zext(void)                 { RUN_TESTS(verifier_zext)=
; }
>
>  static int init_test_val_map(struct bpf_object *obj, char *map_name)
>  {
> diff --git a/tools/testing/selftests/bpf/progs/verifier_zext.c b/tools/te=
sting/selftests/bpf/progs/verifier_zext.c
> new file mode 100644
> index 000000000000..8f2362da91d6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_zext.c
> @@ -0,0 +1,392 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "../../../include/linux/filter.h"
> +#include <bpf_arena_common.h>
> +#include <bpf/bpf_core_read.h>
> +#include "bpf_misc.h"
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARENA);
> +       __uint(map_flags, BPF_F_MMAPABLE | BPF_F_NO_USER_CONV);
> +       __uint(max_entries, 1);
> +} arena SEC(".maps");
> +
> +extern long bpf_kfunc_call_test4(signed char a, short b, int c, long d) =
__ksym;
> +
> +/* to retain debug info for BTF generation */
> +void __kfunc_btf_root(void)
> +{
> +       bpf_kfunc_call_test4(0, 0, 0, 0);
> +       bpf_arena_alloc_pages(0, 0, 0, 0, 0);
> +       bpf_rdonly_cast(0, 0);
> +}
> +
> +SEC("socket")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__flag(BPF_F_TEST_RND_HI32)
> +__success __retval(0)
> +__naked void zext_lost_across_checkpoint(void)
> +{
> +       asm volatile ("                                                  =
               \
> +       call %[bpf_ktime_get_ns];                                        =
               \
> +       r8 =3D r0;                                                       =
                 \
> +       r6 =3D 0xdeadbeefcafebabe ll;     /* inject some value for r6's u=
pper half */     \
> +       if r8 !=3D 0 goto 1f;             /* fall-through cached first, b=
ranch pruned */  \
> +       r6 =3D 32;                        /* full 64-bit def */          =
                 \
> +       goto 2f;                                                         =
               \
> +1:     w6 =3D 32;                        /* 32-bit def, zext mark lost *=
/                \
> +2:     r0 =3D r6;                        /* buggy verifier believed uppe=
r 32 bits are 0 */ \
> +                                       /* and thus did not zero extended=
 w6 =3D 32. */   \
> +       r0 >>=3D 32;                                                     =
                 \
> +       exit;                                                            =
               \
> +"      :
> +       : __imm(bpf_ktime_get_ns)
> +       : __clobber_all);
> +}
> +
> +/* 32-bit ALU result read as 64-bit -> zext */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("w1 =3D w0{{ +}}; zext")
> +__naked void zext_alu32_hi_used(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       w1 =3D w0;                                        \
> +       r0 =3D r1;                                        \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +/* 32-bit ALU result read only as 32-bit -> no zext */
> +SEC("socket")
> +__success __log_level(2)
> +__not_msg("; zext")
> +__naked void no_zext_alu32_hi_unused(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       w1 =3D w0;                /* MOV */               \
> +       w2 =3D w1;                                        \
> +       w2 +=3D w1;               /* ALU32, BPF_X */      \
> +       w2 +=3D 1;                /* ALU32, BPF_K */      \
> +       w2 =3D w2;                /* keep w2 alive for previous instructi=
on */ \
> +       r0 =3D 0;                                         \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +/* 64-bit definition is never zero extended */
> +SEC("socket")
> +__success __log_level(2)
> +__not_msg("r1 =3D r0{{.*}}; zext")
> +__naked void no_zext_mov64(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       r1 =3D r0;                                        \
> +       r0 =3D r1;                                        \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +/* Narrow load result read as 64-bit -> zext */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("r1 =3D *(u32 *)(r10 -8){{ +}}; zext")
> +__naked void zext_narrow_load_hi_used(void)
> +{
> +       asm volatile ("                                 \
> +       r0 =3D 0;                                         \
> +       *(u64 *)(r10 - 8) =3D r0;                         \
> +       r1 =3D *(u32 *)(r10 - 8);                         \
> +       r0 =3D r1;                                        \
> +       exit;                                           \
> +"      ::: __clobber_all);
> +}
> +
> +/* 32-bit atomic fetch result read as 64-bit -> zext */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("r1 =3D atomic_fetch_add((u32 *)(r10 -8), r1){{ +}}; zext")
> +__naked void zext_atomic_fetch32_hi_used(void)
> +{
> +       asm volatile ("                                 \
> +       r1 =3D 0;                                         \
> +       *(u64 *)(r10 - 8) =3D r1;                         \
> +       w1 =3D 1;                                         \
> +       .8byte %[fetch_add32];                          \
> +       r0 =3D r1;                                        \
> +       exit;                                           \
> +"      :
> +       : __imm_insn(fetch_add32,
> +                    BPF_ATOMIC_OP(BPF_W, BPF_ADD | BPF_FETCH, BPF_REG_10=
, BPF_REG_1, -8))
> +       : __clobber_all);
> +}
> +
> +/* 32-bit atomic cmpxchg result (r0) read as 64-bit -> zext */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("r0 =3D atomic_cmpxchg((u32 *)(r10 -8), r0, r1){{ +}}; zext")
> +__naked void zext_cmpxchg32_hi_used(void)
> +{
> +       asm volatile ("                                 \
> +       r1 =3D 0;                                         \
> +       *(u64 *)(r10 - 8) =3D r1;                         \
> +       w0 =3D 0;                                         \
> +       w1 =3D 1;                                         \
> +       .8byte %[cmpxchg32];                            \
> +       r2 =3D r0;                                        \
> +       r0 =3D r2;                                        \
> +       exit;                                           \
> +"      :
> +       : __imm_insn(cmpxchg32,
> +                    BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_10, BPF_RE=
G_1, -8))
> +       : __clobber_all);
> +}
> +
> +/* 32-bit def before a branch, upper half used on one branch -> zext */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("w6 =3D 32{{ +}}; zext")
> +__naked void zext_cfg_hi_used_one_branch(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       w6 =3D 32;                                        \
> +       if r0 =3D=3D 0 goto 1f;                             \
> +       r0 =3D r6;                                        \
> +       exit;                                           \
> +1:     r0 =3D 0;                                         \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +/* r1's upper half is dead, so 'w1 =3D 1' must NOT be marked for zero ex=
tension. */
> +SEC("socket")
> +__success __log_level(2)
> +__not_msg("w1 =3D 1{{.*}}; zext")
> +__naked void no_zext_other_reg_hi_used(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       r6 =3D r0;                                        \
> +       r6 <<=3D 32;                                      \
> +       w1 =3D 1;                                         \
> +       r0 =3D r6;                                        \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +/* LD_ABS defines r0; when r0 is read as 64-bit it must be zero extended=
 */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("r0 =3D *(u8 *)skb[0]{{.*}}; zext")
> +__naked void zext_ld_abs_hi_used(void)
> +{
> +       asm volatile ("                                 \
> +       r6 =3D r1;                                        \
> +       r0 =3D *(u8 *)skb[0];                             \
> +       r7 =3D r0;                                        \
> +       r0 =3D r7;                                        \
> +       exit;                                           \
> +"      ::: __clobber_all);
> +}
> +
> +/* Helper parameters are read as 64-bit (call_use_mask() fallback) */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("w2 =3D 1{{ +}}; zext")
> +__naked void helper_param_read_as_64bit(void)
> +{
> +       asm volatile ("                                 \
> +       r1 =3D r10;                                       \
> +       r1 +=3D -8;                                       \
> +       w2 =3D 1;                                         \
> +       call %[bpf_trace_printk];                       \
> +       r0 =3D 0;                                         \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_trace_printk)
> +       : __clobber_all);
> +}
> +
> +static __used __naked int subprog_reads_arg_as_64bit(void)
> +{
> +       asm volatile ("                                 \
> +       r0 =3D r1;                                        \
> +       exit;                                           \
> +"      ::: __clobber_all);
> +}
> +
> +/* subprogram parameters are conservatively read as 64-bit */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("w1 =3D w0{{ +}}; zext")
> +__naked void subprog_param_read_as_64bit(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       w1 =3D w0;                                        \
> +       call subprog_reads_arg_as_64bit;                \
> +       r0 =3D 0;                                         \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +/* kfunc parameters are zero extended */
> +SEC("tc")
> +__success __log_level(2)
> +__msg("w1 =3D 1{{ +}}; zext")
> +__msg("w2 =3D 1{{ +}}; zext")
> +__msg("w3 =3D 1{{ +}}; zext")
> +__msg("w4 =3D 1{{ +}}; zext")
> +__naked void kfunc_param_read_per_btf(void)
> +{
> +       asm volatile ("                                 \
> +       w1 =3D 1;                                         \
> +       w2 =3D 1;                                         \
> +       w3 =3D 1;                                         \
> +       w4 =3D 1;                                         \
> +       call bpf_kfunc_call_test4;                      \
> +       r0 =3D 0;                                         \
> +       exit;                                           \
> +"      ::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__success __log_level(2)
> +__not_msg("; zext")
> +__naked void alu32_and_32bit_conditional(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       w1 =3D w0;                                        \
> +       if w1 > 42 goto 1f;             /* BPF_K */     \
> +       w2 =3D 28;                                        \
> +       if w2 > w1 goto 1f;             /* BPF_X */     \
> +       r0 =3D 0;                                         \
> +1:     exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +SEC("socket")
> +__success __log_level(2)
> +__msg("w1 =3D w0{{ +}}; zext")
> +__naked void alu32_and_64bit_conditional(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       w1 =3D w0;                                        \
> +       if r1 > 42 goto 1f;             /* BPF_K */     \
> +       r2 =3D 28;                                        \
> +       if r2 > r1 goto 1f;             /* BPF_X */     \
> +       r0 =3D 0;                                         \
> +1:     exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +SEC("socket")
> +__success __log_level(2)
> +__not_msg("; zext")
> +__naked void alu64_and_conditionals(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       r1 =3D r0;                                        \
> +       if w1 > 42 goto 1f;             /* BPF_K */     \
> +       if r1 > 42 goto 1f;             /* BPF_K */     \
> +       r2 =3D 28;                                        \
> +       if w2 > w1 goto 1f;             /* BPF_X */     \
> +       if r2 > r1 goto 1f;             /* BPF_X */     \
> +       r0 =3D 0;                                         \
> +1:     exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +__arch_s390x
> +__xlated("7: w1 =3D w0")
> +__xlated("8: w1 =3D w1")
> +__xlated("9: w1 +=3D 8")
> +__xlated("10: w1 =3D w1")
> +__xlated("11: w2 =3D w1")
> +__xlated("12: w2 =3D w2")
> +__xlated("13: *(u64 *)(r1 +0) =3D r2")
> +__naked void arena_ptr(void)
> +{
> +       asm volatile ("                                 \
> +       r1 =3D %[arena] ll;                               \
> +       r2 =3D 0;                                         \
> +       r3 =3D 1;                                         \
> +       r4 =3D 0;                                         \
> +       r5 =3D 0;                                         \
> +       call %[bpf_arena_alloc_pages];                  \
> +       r1 =3D addr_space_cast(r0, 0, 1);         /* needs zext */ \
> +       r1 +=3D 8;                                /* needs zext */ \
> +       r2 =3D addr_space_cast(r1, 1, 0);         /* needs zext because o=
f BPF_F_NO_USER_CONV */ \
> +       *(u64 *)(r1 +0) =3D r2;                           \
> +       r0 =3D 0;                                         \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_arena_alloc_pages),
> +         __imm_addr(arena)
> +       : __clobber_all);
> +}
> +
> +#endif
> +
> +/* Check if probe mem loads keep their zero extension. */
> +SEC("socket")
> +__success __log_level(2)
> +__arch_s390x
> +__xlated("3: r1 =3D *(u64 *)(r0 +0)")
> +__xlated("4: r2 =3D *(u32 *)(r0 +0)")
> +__xlated("5: w2 =3D w2")
> +__xlated("6: r3 =3D *(u16 *)(r0 +0)")
> +__xlated("7: w3 =3D w3")
> +__xlated("8: r4 =3D *(u8 *)(r0 +0)")
> +__xlated("9: w4 =3D w4")
> +__naked void probe_mem(void)
> +{
> +       asm volatile ("                                 \
> +       r1 =3D 0;                                         \
> +       r2 =3D 0;                                         \
> +       call %[bpf_rdonly_cast];                        \
> +       r1 =3D *(u64 *)(r0 + 0);  /* BPF_PROBE_MEM */     \
> +       r2 =3D *(u32 *)(r0 + 0);  /* BPF_PROBE_MEM */     \
> +       r3 =3D *(u16 *)(r0 + 0);  /* BPF_PROBE_MEM */     \
> +       r4 =3D *(u8 *)(r0 + 0);   /* BPF_PROBE_MEM */     \
> +       r0 =3D r1;                /* make the registers used */ \
> +       r0 +=3D r2;                                       \
> +       r0 +=3D r3;                                       \
> +       r0 +=3D r4;                                       \
> +1:     exit;                                           \
> +"      :
> +       : __imm(bpf_rdonly_cast)
> +       : __clobber_all);
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
>
> --
> 2.55.0
