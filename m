Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30971392C36
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785448211; cv=pass; b=B4ofswJ5G7SLuBJ2QQlbn3MlTbx1qcnzgN3GrFXBc+oIaUMT3IoUiDp5nI0d7xAjfbLNja8+6QX+xqK8LXnrUEae7vG+XySavUD5dLEHmUHT1/eN40PA+1hYBHIoVEn4c+GhlHsC9Qn3iYne2YoizPbc2w3OvSsCukqjoPx/384=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785448211; c=relaxed/simple;
	bh=lhOrI1N7wsPIhHX/Ncz+GqJjJ8JEMYX//C6lZD5Necc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAr2KQ48AonMkvJwE373CZ61JfjtIFDBsm1P669crGuUBDZ6vxkuSxE3d8I5SMuL1diQAB6JOkXQbOTWK3NM2e5DbfxXXqcKImQefkFMWIkBhmlu1ZQYJzjiofnxRsv6Sf9dG3D/FQfdLEWxJ7T5+LV1nRXxffKlyvTXp0gCrIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpvDi7yi; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpvDi7yi"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8453427d3f4so437000b3a.3
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 14:50:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785448209; cv=none;
        d=google.com; s=arc-20260327;
        b=LAGSMQ2kupMOY+dOBtLeSZLo99Iy5swB7wmQbgKwrhysEQh06cFC/B64dU4uop+ulJ
         w+41KIZV746YYR+CtruVsG2Yg/NuUCWQ+kr/WEaSzcPUJpuk490M4Xqw+uUQ/bcle7xp
         e2cR+ahHKjwnU5Tcgyew3KHPXqY/lp6HaYSo+guKGoQGQ+S1BCvO15ULcllsm/kKPDb/
         /QUkMMnoWzoHoiYgLWkL02nfjR+KUDUaXvhUyVRXBPGlKciQEyMVCRUL3UR4Ok1gUwwf
         b29U/ithbkQkwkHQKN67ffp8TdZCv4jaVrdpXxuunNYRVV+KY3n4faMCzNgI/UShnTmG
         e8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2PJMwdgLmdvY40COdI1+KD93CM7q7y14zmADccaz8tw=;
        fh=7eoyOfXUpehVHh0e6FcQCsD9SMN+Vtenv0RH2SBGXXs=;
        b=i4At+jVVMpZmi0mVn+ijlmPDIE4fJYkh+++DYprz959tKfENlmgXXNPTaNiFgbnoAP
         wWPLtmBGY80q3vrsZUMchIsfAN3m7Ip3wt3PwmOAtj6FbVtrgTr55a5H+590jcqYX4w1
         jGnXgF7Sb3ogWNnGyGgTxfosSSO8QDP/KEhypUEbZj4SgEUeRpBDIZODKSHWGlnEPOsO
         TDBhjIB+0cDvzQTQQMPIrpJTq9guFlfQwMFshSsgeecfosa6SDW6qVTClFi6t72Lsql0
         94dSTdFwzKCKkd6IcDmjLPxEx9WzT79xSN5xQwHnCsIu8nRzR5VgSAr9IcmBm2QOT9VE
         xWng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785448209; x=1786053009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2PJMwdgLmdvY40COdI1+KD93CM7q7y14zmADccaz8tw=;
        b=IpvDi7yit83FZO150Xw+sSHLr7/drfLaZBOv5oZUgynbbRKRQk4Oqr+04hRoUJCD9v
         uKm5Y+2gmiR3d4IqrQoBd4WWfv2FZIn3ll9Dy1Dvbo5FHqj/l0w/bqTb8gbdLg1n2RA0
         EZN20bfYED5QkQmC0KS24MOewALZSSlUc3+iDUGCq68wgAncay2Rq2yAq2xPZifPKaXa
         vWy/QP1RMJ7OwjYHlf3fBBeFLVbQMfni1YIlxhBikZ+G7f6FiF9GCYL/ZfhI+0Vs8+0O
         NmSC5WZUg8aZb1W8Z5G9GKCmMNBYtitJoF2DYR/xKMgvbHQ9lQe6C1jKWs7cTR8wD8zg
         Uhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785448209; x=1786053009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2PJMwdgLmdvY40COdI1+KD93CM7q7y14zmADccaz8tw=;
        b=X+HOi3RLkWe0I/rVme3i4CPVzj9zHve2Iqznr81mTdmfTkvxdC6ktckiJGBz/YcqO8
         WrOvj1BGuPDho0TaLyjtpHWv3UcFFTRKYwSAxaOft1uAn620sKdrbaOire+zQfDLqiCW
         lcF98/Uqu43uWlWuWe6afufkMHfkPbEEsoQQRV00zUuVfO75CHBeb4ANzWxioiIea7YD
         3hxWbIeo5ghQR15PXx7wBoVilibFGAqA9kqGfgtP77/tsX6dP5Qrt6r9ehMy7TCOSAMS
         IohqlGDdNKHc74aCIqie2lAhU2w0jdm0fAZonyzFnF8IHCb1wxKrqxE9bn6syyer82zh
         huSg==
X-Gm-Message-State: AOJu0Yzr/kN8dr0xiD3rCe9lKQ5RWhk4ISJVtFhRyQ9gJCraom1bJI0s
	mWPfcaPCWkwBoKPmz8YCsvvzrja95892cD9QMi69uFSBnMfpieaegOyYLeBHO/WQ00RW5is5jPE
	tO2yBOb9NsC3jtCp8CpSA9A+O5Fta+uU=
X-Gm-Gg: AR+sD13XpP9jEA667L1limrtpdT42ZrwHt2Vcmmcuf/NmDttY37ll6ZrY2FX2mj57cO
	afoGLINbAq/+vLGqkRQZoUM7G2gAt5l84MkQ3ioR8Nh82wAkpZwrc0d4XBjpWzBiPNDci0KfI5u
	WENiYWj/aXmm0fUjESHO8mE56u+uhu/UZm7qBpV3dwd4qx15JNk+xM7mKgi3XEtBi6Ihpbzfr+h
	uQVNdvNt7PZoy/foPdWDEsN6w7FvFTDHVm5eHJw2h3FS6b/C9CJIY0KPKPMb/uMjWFqyHRnmfec
	Lya+kkw4Gbne7apC/bEYVLKDAOThvjP8gKvo9dPzNPlU2315d9fwgmGgIjOHGpxpzH9dR6U749W
	MOfYBg9PC6rtV/+XZ84urMKZWjqqOLR3V2u863+sqBQ==
X-Received: by 2002:a05:6a00:a227:b0:848:55a6:fce with SMTP id
 d2e1a72fcca58-84ebc4221b6mr3785247b3a.62.1785448209334; Thu, 30 Jul 2026
 14:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729203633.213973-1-puranjay@kernel.org> <20260729203633.213973-2-puranjay@kernel.org>
In-Reply-To: <20260729203633.213973-2-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 14:49:54 -0700
X-Gm-Features: AUfX_mx8neQncAEpXE_n3-JDiGSk_md9UCkjplR-fcM2rC020NS8T8WtKnD5Gug
Message-ID: <CAEf4BzYvGPYa6CdoPwMFGq3L+cdQT7FJu6si8icP==fc_6797w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/6] bpf: Correct the overflow check comment
 in bpf_iter_num_next()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 1:36=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> bpf_iter_num_next() decides whether the iterator is exhausted with:
>
>         if ((s64)(s->cur + 1) >=3D s->end) {
>
> The comment above it claimed the (s64) cast was needed to be careful
> about overflow, "e.g., if s->cur =3D=3D s->end =3D=3D INT_MAX, we can't j=
ust do
> s->cur + 1 >=3D s->end". That reasoning is wrong: s->cur + 1 is evaluated
> in int and wraps *before* the cast, so casting the already-wrapped result
> to s64 changes nothing. For s->cur =3D=3D s->end =3D=3D INT_MAX the plain
> s->cur + 1 >=3D s->end and the (s64) version both evaluate to false, and
> more generally the two are identical for all inputs (sign-extending both
> operands of a signed compare never changes its result).
>
> The wraparound of s->cur + 1 is in fact intentional and load-bearing:
> bpf_iter_num_new() initializes s->cur to start - 1, which wraps to
> INT_MAX when start =3D=3D INT_MIN, and the wrapping s->cur + 1 recovers
> start on the first call. Using real 64-bit arithmetic ((s64)s->cur + 1)
> would instead break iterators starting at INT_MIN.
>
> Drop the redundant cast and rewrite the comment to describe what actually
> happens. No functional change; the kernel builds with -fno-strict-overflo=
w
> so the signed wraparound is well defined.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/bpf_iter.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index f5eaeb2493d4a..f190f2b250048 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -802,12 +802,14 @@ __bpf_kfunc int *bpf_iter_num_next(struct bpf_iter_=
num* it)
>  {
>         struct bpf_iter_num_kern *s =3D (void *)it;
>
> -       /* check failed initialization or if we are done (same behavior);
> -        * need to be careful about overflow, so convert to s64 for check=
s,
> -        * e.g., if s->cur =3D=3D s->end =3D=3D INT_MAX, we can't just do
> -        * s->cur + 1 >=3D s->end
> +       /* Detect the end of the range, or a failed/empty iterator: all o=
f these
> +        * leave s->cur + 1 >=3D s->end. bpf_iter_num_new() set s->cur to=
 start - 1
> +        * (which wraps to INT_MAX when start =3D=3D INT_MIN), so the s->=
cur + 1 below
> +        * is a deliberate 32-bit wraparound that recovers start. As s->c=
ur and
> +        * s->end are int, this is an ordinary signed 32-bit compare, exa=
ctly what
> +        * the inlined bpf_iter_num_next() emits.
>          */

this is really Claude-style verboseness. let's just say that num iter
maintains an invariant that either s->cur < s->end or s->cur =3D=3D s->end
=3D=3D 0, in both cases s->cur + 1 can't overflow int.


> -       if ((s64)(s->cur + 1) >=3D s->end) {
> +       if (s->cur + 1 >=3D s->end) {
>                 s->cur =3D s->end =3D 0;
>                 return NULL;
>         }
> --
> 2.53.0-Meta
>
