Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9AE3FA5CA
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 23:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196596; cv=pass; b=oKo7iJB7lD5EJrAJuG0Eg/I9zyVdRGDjgeHpHaPHf3qIVFD/b/k7G2XiISiyKfVvaO0nR6+pgg8tEx9Hmhi0kB/QIzYIWuhLMMqcnxUuRr2NPTgmQaCTmAQuF6ZUUKfNgFxOAYh+QYGxyhcoTex3zyWf+ee77ZkkTl0fNhJoDCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196596; c=relaxed/simple;
	bh=3FSDJeFGNuR0A+HiMNEZiqsAd1vLvi1uy5CjUQBeq3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfh60LYf2K6jjHDmPj2R3cmge4nSSdyr3J1ZuoxJYUfwQ0C1f4JWCMR8w4DlXtx4HsK9vekc56T+xXAXlqYj/8Fjou6Z4hPzN/BiuxRZVu9sw0C8jqJe1RQ0bOk10MynjJjx8KzmknZzBCEoR5hFlbfKncYEZhOThIrdTtn5Sb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSGguAld; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSGguAld"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8423f236418so2493722b3a.1
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 16:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785196595; cv=none;
        d=google.com; s=arc-20260327;
        b=aPl51lI2znzNiKzpp20FTpA27rD1DLbdFEmBMu6T8C+WxKFthEG0Z0AIf8t3miu6cy
         LbpCFMuLY6uE5sLYtguYopCI4qDgf62RFGgfwaRtVDRR6I3WhYRmAHCgnDkp/EsUUZ8w
         UXHH5+kJ1/+F6G275xwLufSL+AlW9wEepXrqM8nbcQQffgPQluhDOX6l6wNRRtKzkGEL
         WSlt5PVeqBU2bDOlpeQX2gw9joJ6PUoVbScz0pd0EfHCPzqLXyl+GHr8arRVgNIsFOKU
         VlgApQeJxgIXuGu2ExA3loyvlD0NPJywqjkMCkIdp/2A4OnvqTY4CcYwqp/ZrIAhRMu7
         fW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3ucIRmpiE84BbcSAvsu4p6jdaHWrjbm5bupCPF3ABYA=;
        fh=7eoyOfXUpehVHh0e6FcQCsD9SMN+Vtenv0RH2SBGXXs=;
        b=KoxMwfvWZnwS8QpuJ+hHoHKuimxEKrXgTpUdUl0+yX9Jv3EvVu9CCm1e3zLAUv5zYI
         hRcg2Gc179+Eh9d/6xSXoG1gpJrTE0k6Quhj8tx2sjNiU5XDjMadja5UmNOpL6cJNK9G
         yyaKzk0CyE6lzKaP20HqEpJq3mfPBsROr7thtaoLqakasQ5zkCR7uBQ+FUdvB+MGszYD
         uCFF4V8xH8VjbHKuOXNe1uQvcexaoVdBDmImq9BD2v1ii0/SBhUNSG1PPTqjsxujUuSw
         XMuBGa1dTWsF53rtTU6AfpTOj1IXVYPFpZF1tpbsrmS4jJ4vgehfSj/RKeUuOeyXjsq0
         pT+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785196595; x=1785801395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3ucIRmpiE84BbcSAvsu4p6jdaHWrjbm5bupCPF3ABYA=;
        b=bSGguAldIWc4BADZLjjh8nypi0cqOoS9uNUOjGJ/0oZPw/D413aFKLDBmEZwubI7Z4
         gLRa9inxPfoZQXHz198UkZmk/To6ELbNTWzjY2N5/m3MZXOF382d/M+DTx2CaIRQWNh+
         umZTjw5We7Vvaexc99yaZeAuD1n5KvGSUF0otrBXpD9z8Y9w1a6D+Ngc8ZG0BxHIZgql
         d7fTOuBXpXLXhiUl2EM5JtaJnZVHGsRpBBe7Zl/aGgD0arRaM94RFIrDmSTBVxbu2t8l
         wempSBr57NnVWOXoWGIyFJFqXgFF0Lovhxb2IdLvT0Xa7/SrapozbU4Df4qbUNuWCB+O
         X7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785196595; x=1785801395;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ucIRmpiE84BbcSAvsu4p6jdaHWrjbm5bupCPF3ABYA=;
        b=OHvKj4DSGFgQf6IjKICmRrtX4tA6mHNFhtWOilaKcmrLoEJydUNwRrorYP1wxNGzoE
         6LN7v7PPlYe1hCXja6ar//1jvjJkvYwo0tNJNfW0PHWB2N7VYfQR3Z4fE6eB3fdZiaOh
         TPh2A7cK56KkFLafmRFSWPeEKQm8qKIZB+wCQC5S1u24mD/66NRAmoGvUScx0uTpCE3v
         nt5K3/TiPGuQxsa3Us3AoVZ+KQUczGHC+4J7x120NXSqQPATKKDog70xHb6ClIRH8gry
         EONGmjhYTuymI4JeH19yBxOP2ggZfQPTGb3mH2gX3v2rTQnGgu89hrD0EhOz7SGhuaXr
         ECoQ==
X-Gm-Message-State: AOJu0YxJYYpc/W1BYOv1tJGeGHr25xCkM+NRmZeydxMdehm+CUmksNxe
	bk1jaDydknZM3AXOUHh47DCUSeu8GZVFx07Tk8wm2nhyVM0iRzG5384qCjSV7knDOu8r67Yv0eZ
	fI/IXCp63jxZckgaUjvkMHrMj0bPcKO0=
X-Gm-Gg: AR+sD13tvfKGfPSGPV8f6W1SyNc97WHYJyQ5JngUpgh9vdAbWXIeRG9+ZexiDo/+qaN
	ED1CZWb8HDccwp93eUbKsnOYcvcqWclqXCeOpwvuNFe5Cqv1xKnlLaMNUc9+ff6sAXzfQhH3ztz
	Jyg0COPoqUUJ15i6aX0IFdXbiFEkWVRdfHec20HGzlJWUvG9bRBL5vf4+aBbtccqE/41kI3b+U1
	bXYTI9XG7uVCVKBSh/lhKcze7Ode5rznx9UywMekWX4gCDnRuU++3Ez3gzz3snO6MkZsSIzJz4w
	vNZKvqW5zwhbMmaMQUntq0syMErmTjZXl6OL/AxyvHUlKPJ7N5MPL2xzRA==
X-Received: by 2002:a05:6a00:12ca:b0:847:7fd5:aaaa with SMTP id
 d2e1a72fcca58-84e93137621mr49432b3a.17.1785196594576; Mon, 27 Jul 2026
 16:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722132424.450230-1-puranjay@kernel.org> <20260722132424.450230-3-puranjay@kernel.org>
In-Reply-To: <20260722132424.450230-3-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jul 2026 16:56:14 -0700
X-Gm-Features: AUfX_mxfzkVa_APXso24bglQ-tmBUl2HzSq1K6W_tADWMexbK7bErQQ6jJWVO_A
Message-ID: <CAEf4BzY_8E8Zb_+DkBMwx8Ti8Cm-8H+AzODtYPZ9YA28b5BD3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Inline bpf_iter_num_next() kfunc
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 6:24=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> bpf_iter_num_next() is called on every iteration of a bpf_for() loop and
> is the hot path of the numeric open-coded iterator. It only advances the
> on-stack iterator state and returns a pointer to it, so open-coding it in
> the verifier removes a function call from each loop iteration.
>
> Inline it in bpf_fixup_kfunc_call() by replacing the call with an
> equivalent instruction sequence. R1 holds the pointer to the on-stack
> bpf_iter_num; the returned pointer to s->cur is R1 itself since s->cur is
> the first member.
>
> s->cur and s->end are int, so the kfunc's (s64)(s->cur + 1) >=3D s->end
> test is equivalent to a signed 32-bit comparison of (s->cur + 1) against
> s->end: s->cur + 1 is computed as a 32-bit int in the kfunc as well, and
> sign-extending both sides of a comparison of two int values does not
> change its result. The inlined code therefore uses a 32-bit compare and
> needs no sign extension.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/verifier.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ff76a1ed04556..6fb8fdd5d5b21 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19807,6 +19807,34 @@ static int inline_bpf_iter_num_new(struct bpf_in=
sn *insn_buf)
>         return i;
>  }
>
> +/*
> + * Inline bpf_iter_num_next(). R1 holds the pointer to the iterator. Kee=
p in sync with the
> + * kfunc in kernel/bpf/bpf_iter.c.
> + */
> +static int inline_bpf_iter_num_next(struct bpf_insn *insn_buf)
> +{
> +       int i =3D 0;
> +
> +       /*
> +        * s->cur and s->end are int, so the (s64)(s->cur + 1) >=3D s->en=
d check is equivalent to a
> +        * signed 32-bit comparison of (s->cur + 1) against s->end and ne=
eds no sign extension.
> +        */

really?.. have you checked the original code and that large comment there?


        /* check failed initialization or if we are done (same behavior);
         * need to be careful about overflow, so convert to s64 for checks,
         * e.g., if s->cur =3D=3D s->end =3D=3D INT_MAX, we can't just do
         * s->cur + 1 >=3D s->end
         */


But I don't try my own judgement, so I did this:

$ cat test.c
#include <stdio.h>
#include <limits.h>
int main() {
        int s =3D INT_MAX;
        int e =3D INT_MAX;
        s +=3D 1;
        printf("%d %d %u\n", s, e, (_Bool)(s > e));
        return 0;
}
$ cc test.c
$ ./a.out
-2147483648 2147483647 0


That zero means "false", doesn't it?..

And if we don't have tests for these corner case (blame me, doh),
let's please add them.

pw-bot: cr


> +       insn_buf[i++] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0);
> +       insn_buf[i++] =3D BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1);
> +       insn_buf[i++] =3D BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 4);
> +       /* if ((s32)(s->cur + 1) >=3D (s32)s->end) goto done; */
> +       insn_buf[i++] =3D BPF_JMP32_REG(BPF_JSGE, BPF_REG_0, BPF_REG_2, 3=
);
> +       /* s->cur++; return &s->cur; */
> +       insn_buf[i++] =3D BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0);
> +       insn_buf[i++] =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
> +       insn_buf[i++] =3D BPF_JMP_A(2);
> +       /* done: s->cur =3D s->end =3D 0; return NULL; */
> +       insn_buf[i++] =3D BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
> +       insn_buf[i++] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
> +
> +       return i;
> +}
> +
>  int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *=
insn,
>                      struct bpf_insn *insn_buf, int insn_idx, int *cnt)
>  {
> @@ -19938,6 +19966,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
>                 *cnt =3D 6;
>         } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_iter_nu=
m_new]) {
>                 *cnt =3D inline_bpf_iter_num_new(insn_buf);
> +       } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_iter_nu=
m_next]) {
> +               *cnt =3D inline_bpf_iter_num_next(insn_buf);
>         }
>
>         if (env->insn_aux_data[insn_idx].arg_prog) {
> --
> 2.53.0-Meta
>
