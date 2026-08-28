Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6EE3F1055
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787877026; cv=pass; b=ApY7SoIqjcgtKl4P4dih4nDeKNbIRlsHtC/fN5QzCLix1Y1aSPLyA7L7+hirfqyrlEaAA2rBascsx1rV4NiKSHZezUe1x3vcvT3Rl+dDY6+RMoD3efQBUx4Nah7UCC+qTdBEwoB7aziwdsS+f9f9gCJQrwycYXT45JvoyRFymOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787877026; c=relaxed/simple;
	bh=E5+XAiyX7pBlr2RwKkPtnwVrgYWfDy7M2WCj45Asnvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZ8hhwaKwp7avY/unIlYuBr4fTbXcCV2QaecprbS2oxJvCiVsLyA7nNXUqjNcgMTCydYkPPo8Ihb95yQa/tP7a+A6jW7g5WxVdPe/Cb9NaZr16VdfwK8JTrLzTr5vCvlPALzw7jFib6dxjqY+SBxDYwTXqWlTtqvqfk2RSJSpnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMgojzph; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMgojzph"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8525efa7274so453137b3a.2
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 17:30:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787877024; cv=none;
        d=google.com; s=arc-20260327;
        b=kGEZz7yNx+/Re9z9zNT26wEfvm/TAnprJrhsA7Wf8oUJg1s3/3U0sD0bYk6dZQGKqG
         3VnAVz5rzHQgOruTjKa6FvoPXTgLQwGkzCyYIZsga2A35DAC7SYMsiZUykvNiOKBPoUD
         TTB+Z5Sc6kR/oQda32G45tGUPYJvXaidd+0HXsk+W7V1ggeviWHosET3UgXL42Xua2rr
         M6UUiEq8ybbFC8JnkmEu9Rfw51zbnYaxrU38AGbXn2DcPu1k7Bu4LA44KE9LC9b3xd7y
         /6snqWZiRSqFENx4da0VgfFVkZZf2ZczAtQ6ekehcRpBc3y+kam/dwVllh2uf9KQZWQN
         OJWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xCFhGFwObZD+rpnTFTAWHr3psSvSoRO8scBW6mG+2DQ=;
        fh=IhN3luBD9UgyHzLP1M9ci3veL00rEY3LMquC5lVUaeY=;
        b=LtxYlFvO7wwDMVJJe9XCI68cPXAhAO4+4zNKPLfUYTM0IuXLoXzt7Fc8KDsie0/HsQ
         pxDA5qA/DCI4EO9VuZduo/wvIZ9j1jYPm9KVd1Bd1z3lhHFVPgWieAHeQ2r9LSmkYf/X
         EjIeND9UqOZJ8/QTxKxK7Z+r7M85cb733CTzs0TFgz/qe5zi6BlCdT+dSbbLqjuwvEGw
         pBaYNCmpt565/EbwI42gCpYCcrwNXZTnqxZXjydK4E6sNPjp/1YdNNzZFONKcMCoXxzT
         gW+g+55H7S/P5J+gGGSSKg97t59jHhuPKUvrubDUd27RmFwRMeYI6X2+MO1j5wf/WB2p
         cB/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787877024; x=1788481824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xCFhGFwObZD+rpnTFTAWHr3psSvSoRO8scBW6mG+2DQ=;
        b=NMgojzphNLxlb8BDhKFrl0PoL10rtYvuFbc7TlU33j/8Iu4E5b/sIh1mgEzVFstvLv
         6jCo+s2VoWOm3kVnwPuoYeAkgYrBorwyNH13Jy9q2NoxJO+iJubB0YBHwc5McZ87lKr9
         uSo8dXHvASxRkIm8mY7MygGXk2YKijI4lEn2Jf/c55MIjxaL4qEkgbfnLgIV3SgaTjG7
         cbDc6g2YZgYow524pyhJsJpclbJ0IwehhVtXdFKBKis3kQLVbUuKx0j09ImXzZu1Y8Oo
         zgP0X0cD5sBTx/Khqp+YW+ewpu3VJpKFInW+qp4ZL1HtWhogmbliEtjOz2fizVFQF8Th
         keww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787877024; x=1788481824;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xCFhGFwObZD+rpnTFTAWHr3psSvSoRO8scBW6mG+2DQ=;
        b=n06Hzus8t+fYSs2OX0qL6aKnlAR5rtyAYUtuMfyyyjoVLneRQUSbCNdijiBG9VXHos
         YgEKpJzaCw1dc/al5+iyDuOLs3igOK23mr6lX8ghJzfdGFR+J7EOLGyks+09BkseNv2w
         yNfxWPh+ACmcHW9+7yxmlqyPzTmaiZ1nO4JWq1+MHWP4XTdyDT+E/ik7phZ5W9n5v/35
         6FoU1OLdBETqeZbzhT5jqn4a4s1nHcpzWxnGRVoVafWpHKsyAamAdo9D1xnwh2EnX5gT
         BeI+i5Bzc+U8RVx44ppHh85EyNIF2Tm8arRxH3G2sduMFjGXSGg1yNjTKhmEYmsTJmP2
         sWnw==
X-Gm-Message-State: AFuF++mu05V8T1XU6NLXPBlv2GULpMG1xq+lEOFQ/i9cCEaJx5HdQvXq
	Bg5ALTAVnHjd5x7lPw2ziDacOeeMH+C9F7cjRsmYFPjcpE9zHKFlq4bY4LONYGU38t6TAP8s7PC
	OTA/vDzmSFM7+DRGjeZMc9tiiaAJy57w=
X-Gm-Gg: AR+sD10xFdOgo4pd9wOPRqCZPIMBgN77MHkvljOJVe9FdEP4yIoXM4TuJ5Kx3WOeLM8
	+e3DQfaHn669bctJGtbTPsL8yGlbsoG8qGG0bIrNDciNu2vH8MnsZfIJxXA8ZoSrEY41K0J8JQH
	hcabT4Q4ZxM71J1y/PYsZF5GLC26+9Vy8/r818f6AozWAfwvuV80r9MrxAp0a0nzlt8I4ugdIbx
	cIT2VfHGPtr0ekWz9KQ1w7YNvbo+ZMq9pvMokxefbGW1ryAdZ4AXvoFm5xdfQqBseUPJ8ZDpQOa
	th92HWK8egJi0YiaW5LA+WBE9tI2uYO252dL7ZvSTQMYpYyNWy3RcrZLx1Hka1Q+ahbjcZTLhDA
	2zfwOiNwmBT0vIbwIZFSJeZkpYg==
X-Received: by 2002:a05:6a00:2888:b0:847:9315:fb8b with SMTP id
 d2e1a72fcca58-856281ac5dbmr5461316b3a.6.1787877023992; Thu, 27 Aug 2026
 17:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827-bpftool_cyles_per_run-v1-1-77d7bfc3c065@meta.com>
In-Reply-To: <20260827-bpftool_cyles_per_run-v1-1-77d7bfc3c065@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 27 Aug 2026 17:30:11 -0700
X-Gm-Features: AcwNN1VJRRJUP3ZDoMp1AckvAr1TTjgkpsLFu57Sa4lxQ91tCQroLio_8X0HjCY
Message-ID: <CAEf4BzaKFk9yu10P9bXOE9i=hD8SO+_XfvPbnEBU7cd+eLDVCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Print average cycles per program run in profiler
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, qmo@kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 8:29=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Total cycle counts are difficult to compare across workloads with
> different run counts. Report cycles per run to expose the per-invocation
> cost directly.
>
> Example:
> sudo ./bpftool prog profile name mprog duration 15 cycles instructions
>
>             423256 run_cnt
>          947413975 cycles              #  2238.39 cycles per run
>          333965846 instructions        #     0.35 insns per cycle
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst |  6 ++++--
>  tools/bpf/bpftool/prog.c                         | 18 +++++++++++-------
>  2 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf=
/bpftool/Documentation/bpftool-prog.rst
> index 90fa2a48cc26..2280dc4492c0 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -217,7 +217,9 @@ bpftool prog run *PROG* data_in *FILE* [data_out *FIL=
E* [data_size_out *L*]] [ct
>  bpftool prog profile *PROG* [duration *DURATION*] *METRICs*
>      Profile *METRICs* for bpf program *PROG* for *DURATION* seconds or u=
ntil
>      user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not spe=
cified,
> -    the profiling will run up to **UINT_MAX** seconds.
> +    the profiling will run up to **UINT_MAX** seconds. When **cycles** i=
s
> +    selected, plain output also reports the average number of cycles per
> +    program run.
>
>  bpftool prog help
>      Print short help message.
> @@ -360,7 +362,7 @@ EXAMPLES
>  ::
>
>           51397 run_cnt
> -      40176203 cycles                                                 (8=
3.05%)
> +      40176203 cycles          # 781.68 cycles per run                (8=
3.05%)
>        42518139 instructions    #   1.06 insns per cycle               (8=
3.39%)
>             123 llc_misses      #   2.89 LLC misses per million insns  (8=
3.15%)
>
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index a9f730d407a9..8935508f955b 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -2069,9 +2069,9 @@ struct profile_metric {
>         bool selected;
>
>         /* calculate ratios like instructions per cycle */
> -       const int ratio_metric; /* 0 for N/A, 1 for index 0 (cycles) */
> +       const int ratio_metric; /* 0 for run_cnt, 1 for index 0 (cycles) =
*/
>         const char *ratio_desc;
> -       const float ratio_mul;
> +       const double ratio_mul;
>  } metrics[] =3D {
>         {
>                 .name =3D "cycles",
> @@ -2080,6 +2080,9 @@ struct profile_metric {
>                         .config =3D PERF_COUNT_HW_CPU_CYCLES,
>                         .exclude_user =3D 1,
>                 },
> +               .ratio_metric =3D 0,
> +               .ratio_desc =3D "cycles per run",
> +               .ratio_mul =3D 1.0,
>         },
>         {
>                 .name =3D "instructions",
> @@ -2256,17 +2259,18 @@ static void profile_print_readings_plain(void)
>         for (m =3D 0; m < ARRAY_SIZE(metrics); m++) {
>                 struct bpf_perf_event_value *val =3D &metrics[m].val;
>                 int r;
> +               __u64 ratio;
>
>                 if (!metrics[m].selected)
>                         continue;
>                 printf("%18llu %-20s", val->counter, metrics[m].name);
>
> -               r =3D metrics[m].ratio_metric - 1;
> -               if (r >=3D 0 && metrics[r].selected &&
> -                   metrics[r].val.counter > 0) {
> +               r =3D metrics[m].ratio_metric;
> +               /* r =3D=3D 0 is a special case for run_cnt */
> +               ratio =3D r ? metrics[r - 1].val.counter : profile_total_=
count;
> +               if (metrics[m].ratio_desc && ratio) {

this ratio_desc-based thing looks suspect. We used to check .selected,
why did you change this?

And tbh, this whole ratio_metric would be much better done with enum,
where you can have -1 as "NO_METRIC", -2 as "RUN_CNT", 0 - cycles, 1 -
instructions, and so on.

then in definition of metrics array you can use explicit

[METRIC_CYCLES] =3D { .name =3D "cycles", ... },
[METRIC_INSNS] =3D { .name =3D "instructions", ..., .ratio_metric =3D METRI=
C_CYCLES }


makes everything consistent, explicit, easier to follow, wdyt?

pw-bot: cr


>                         printf("# %8.2f %-30s",
> -                              val->counter * metrics[m].ratio_mul /
> -                              metrics[r].val.counter,
> +                              val->counter * metrics[m].ratio_mul / rati=
o,
>                                metrics[m].ratio_desc);
>                 } else {
>                         printf("%-41s", "");
>
> ---
> base-commit: 23ff631b3b8b1452dfe933ee21f96321a9c5e209
> change-id: 20260827-bpftool_cyles_per_run-93169fcb30b7
>
> Best regards,
> --
> Mykyta Yatsenko <yatsenko@meta.com>
>
