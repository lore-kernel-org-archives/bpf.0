Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2AB3B530F
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785448232; cv=pass; b=CgZzJEYLV0iHcsqfQsXXPqau2Po2PXL3mebqimtLJifmjf1kECfYHPUzfYyYu7X3/Ds6P+CbT5+IHK228YHnwOKI5BJBhRST3+UPxJhFN8LehAWLLek4tuvU27X2TaMQ2CIKwj18Ej2C2pk3IZYVpXJ1sCTBkAOip561isEZevw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785448232; c=relaxed/simple;
	bh=hohf4egGI2FtTcoVSfXr/8H7yG8jREFXZ386prEXqNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTCeexqwzeWPmugIclreHg09WQYLuc0wCpvmG+PeKWIsdugfhZZXoC29IpAj253ZuyFmMvRe/wnBx32RRjX0pt1UvwW8j+2zLIfsRHjPsnzZmWcTyFiplqbJX0fFZtLhNPoR8DBMusJlAg+GBHVHHJpd3dqyfXmEaR5Oh/Pqyus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDZoUNNd; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDZoUNNd"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso402476b3a.2
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 14:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785448230; cv=none;
        d=google.com; s=arc-20260327;
        b=cVu4bkoQ9NTuyEKyBsmOO0Fh7CdiCG/+gjuLaKQCzk8qSCBylTidBN/erZ9Hdx+OEx
         6ZxzBlCIif2J3KFuKKG0R6p+19NHeYwpo08VAmn3vm8Tjdsch+XybpZKyAdlF8ofFbyd
         r+wGBGBNTV75TvglHEi26ySiz40RXRe8PyO4LsxoHdxHPLmiyDVzYfxPDAal8XRA9e7H
         aUAUb688P0rjyBJcDrn7EV+HxtkyUXZd7vfUmbhWynsLEjVvN1XSpOGIi3yn3QrO32nu
         rudqXQQwACjR5qfIhLk/NLXb8pnjo7cOD6nMZOkvIC9lMojmGCUpRPKXXMF1YmDVd+QS
         5H8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qr4nYzV06iZ6tNUQg08yVYJfq6vZPcikx9TBCQwP+fk=;
        fh=7eoyOfXUpehVHh0e6FcQCsD9SMN+Vtenv0RH2SBGXXs=;
        b=gQO88981+KJm6UIBzRjJNc6r16ZhHAJZ30e9yTXR6qoDjbwLw6wK7KFipoBaXElIk0
         uQEwrRxDgsKZkUv5LrfJMbJ+Jdb9qobknnVmBBcU3+nKxiBiLe617z62Xcr21kxiR0ea
         lA1+gegMEPhXJWTpZbQE4O154Le5dUM+QUJttZ+77KCYvYzbnIW6afm1GWJaAWy33jpt
         RxUCq4W04k5qxHKecWk8bSRqGNCNeF3KFlLZurzgggKVTzQlrd4MBnGN2FpRmxIbWKyR
         uStpHcnbBI0y88QmYtDi6gKapJu7UXp/UoXoisOcRh5c2XsxcfWZKl8xE/sEmS+DaJY3
         Y0wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785448230; x=1786053030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qr4nYzV06iZ6tNUQg08yVYJfq6vZPcikx9TBCQwP+fk=;
        b=GDZoUNNd+TzbEb62ebAOM2yLnNkyzU7iyqcWtyVD+6kZBjM+m6arClUeb6kqfrZM1I
         NOfCei4+g9tMQa6ZkSusgTh0zk4cK9XOfTmQldKyhN5iK8yuAUtS9u/Q60dzzUJsFzoZ
         9X6JVssiYpRpUuJCKZgeh7Nrx9T3gaOkChIq3lhTotJRtmFqjz8CWMqBi4K8vp07WVYb
         PyT0LGeIkRFRhcYixKacPkohu5yjXyJM5E5/axhSsJPgNSID6k8X0n4uKiFBkcdr7REW
         4t/PadjZ3PhUlUPNJXcu5d3axitbgs2SoLOpEVP4Aqo3KHb/e4Nop3lxsJ2amUx5Qm3K
         Z//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785448230; x=1786053030;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qr4nYzV06iZ6tNUQg08yVYJfq6vZPcikx9TBCQwP+fk=;
        b=r5lnwwVbKFPQj4kYlRKcLJm6dY7nS5vN/TWa7ZxFGmJUIPCr6GU3E5OLriTb1PRqrn
         Z9zlvByrPKLCzAypgYCXNIqhnn6S9kOi/4+ufVlc2rI+eeB+bgS07wUdbwLWE+a9n+90
         27zu2SP9ra/D2qANZrVPQPUdQKGLmn8O3BDaPK9uIW/P3LqT4sCedf4y53JValWAtDp+
         djKFJ4HT1Uk0LiySt4XLZilvIl74WXhEKExVpeAMOrcv5Ed7F2YWP4o6xhPTGLouo3HF
         UaAhHgvKQNzpKSMxKktT0N7OL2UDZm5x65gY/ZHu4K7RAkknDDMcKh8k/tOnnlznRk6X
         FckA==
X-Gm-Message-State: AOJu0YxMgObdMZZY3CYJllv5ZJa9V0/ORU3omKnr9tz/fvlP+8Tfueu0
	uOnuVlsly0a3/gyr8j5vR3FWN8wDLeBcmhB5vL+sL7Dykz8N1R4zMxG6JnswdQmLpGXbfzxaWIs
	UdIJIRPR39WZ27obPXD4m5SDKZaf9Kek=
X-Gm-Gg: AR+sD12n8GMzcLSVvVis7xlwW/KyuQd06I/gmP8nuX5ulj+sYQKMIuMScXXstWz00zO
	ESoTK2gBEhp96ujPBz43rIdh8PvWvgUcZYd9VyB/jwUWpCEqf+gYfwHt+NGXagR66j+x6RNfeM1
	UoEGrhkS+hEGBV7kRi3BSqRT9qmLCkRIZgq7r5ReIB9Tnx8b7JnpxLpcq/phvTF1BzbDGURPb9J
	oxMDX7x4hVkfRrbVsej+HT2WVFhe1CdGEsZWIkx0yslNYg5GqnuBE57sGEBnMZ1mCf1XXavwDQi
	Jp+Cw2MJuw2BOTALQqCE5RB1YIoBvJg6QHkrtoyHermMjC3tNJf/+DjsFBVJSmgmMAmMxLwwE1O
	uSm01Iptu3DUvohooQOA8F3gLtBRSupVkL3Qqm7l6fw==
X-Received: by 2002:a05:6a00:39a8:b0:848:5d9b:6885 with SMTP id
 d2e1a72fcca58-84ebc494624mr3853705b3a.77.1785448230084; Thu, 30 Jul 2026
 14:50:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729203633.213973-1-puranjay@kernel.org> <20260729203633.213973-5-puranjay@kernel.org>
In-Reply-To: <20260729203633.213973-5-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 14:50:08 -0700
X-Gm-Features: AUfX_mwh63B5ZHu3IhBP5FloepQsAFJ5ABaPcXTi1eojCM6b1KoPr9MNU0nEOVA
Message-ID: <CAEf4BzYuQxx2Oa8hhqhmaP1FAFcamNW_QHRwxGv_GXKHpdvXgg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/6] bpf: Inline bpf_iter_num_destroy() as a no-op
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 1:37=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> bpf_iter_num_destroy() ends every bpf_for() loop. The kfunc only zeroed
> the 8-byte on-stack iterator state, but once destroy() returns that slot
> is no longer tracked as iterator state, so nothing reads it and the
> zeroing is dead work.
>
> Drop it on both sides: make the bpf_iter_num_destroy() kfunc a no-op, and
> inline the call in bpf_fixup_kfunc_call() to a single BPF_JA 0 (nop) so
> the per-loop call is removed without emitting any store. The nop is
> elided by the JITs.
>
> The emitted instruction is plain BPF and is handled by the interpreter,
> so interpreter fallback stays correct and no jit_required marking is
> needed.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/bpf_iter.c |  8 +++++---
>  kernel/bpf/verifier.c | 14 ++++++++++++++
>  2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index f190f2b250048..ff2055399f3c0 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -821,9 +821,11 @@ __bpf_kfunc int *bpf_iter_num_next(struct bpf_iter_n=
um* it)
>
>  __bpf_kfunc void bpf_iter_num_destroy(struct bpf_iter_num *it)
>  {
> -       struct bpf_iter_num_kern *s =3D (void *)it;
> -
> -       s->cur =3D s->end =3D 0;
> +       /*
> +        * Nothing to do: the stack slot backing the iterator is no longe=
r
> +        * tracked as iterator state once destroy() returns, so its conte=
nts do
> +        * not matter. The verifier inlines this call away entirely.
> +        */

verbose, drop the comment or have /* no-op */

>  }
>
>  __bpf_kfunc_end_defs();
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3a3d096f3966e..36f3e80d2f0b9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19838,6 +19838,18 @@ static int inline_bpf_iter_num_next(struct bpf_i=
nsn *insn_buf)
>         return i;
>  }
>
> +/*
> + * Inline bpf_iter_num_destroy(). The stack slot is no longer tracked as=
 iterator state after
> + * destroy(), so nothing has to be done to it; emit a nop just to drop t=
he call. Keep in sync
> + * with the kfunc in kernel/bpf/bpf_iter.c.
> + */
> +static int inline_bpf_iter_num_destroy(struct bpf_insn *insn_buf)
> +{
> +       insn_buf[0] =3D BPF_JMP_A(0);
> +
> +       return 1;
> +}

again, inline the inlining logic


also, bpf_patch_insn_single doesn't support deleting an instruction,
we have to have BPF_JMP_A?


> +
>  int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *=
insn,
>                      struct bpf_insn *insn_buf, int insn_idx, int *cnt)
>  {
> @@ -19971,6 +19983,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
>                 *cnt =3D inline_bpf_iter_num_new(insn_buf);
>         } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_iter_nu=
m_next]) {
>                 *cnt =3D inline_bpf_iter_num_next(insn_buf);
> +       } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_iter_nu=
m_destroy]) {
> +               *cnt =3D inline_bpf_iter_num_destroy(insn_buf);
>         }
>
>         if (env->insn_aux_data[insn_idx].arg_prog) {
> --
> 2.53.0-Meta
>
