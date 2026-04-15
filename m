Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978DF4A07
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 00:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776212437; cv=pass; b=PDUcZglAe3VuzsU78JCSIbegw+e8EnGNO1IJRAoYCWTGH9cCmkvVYGNjrpK635MKCWZEKXo5s7OhqpHFI2rOzeodYzVmNjpwk4SsR/74ttegitD3PxrJDCLA8vwBayrH4GN1EPuD3wCj6wMlm7OEjV+feNhkhgxbOWT600YZHj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776212437; c=relaxed/simple;
	bh=P52kXi1D7L2+vcCt4QX2ZTdttYWwIUlNxl4iiTA5Dz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pswN0AypIr6hF/B5X5ykXM8YuL9laAkHK5889S+ct+pfCSkoRO1zcqj7XvPbTpwf3SO8C9WNRfDMI5Ks7zHC0DB5lqYCIHQHAEk3cRgk7r/imjG/Otwd3awYwgkedooVqef5ipClGEHVeVXzBMS5iOQH9WiM2fY51N9bvy1McRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJSOt1Na; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJSOt1Na"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4888375f735so60817985e9.3
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 17:20:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776212435; cv=none;
        d=google.com; s=arc-20240605;
        b=MrAwCVA3hi8vBwXlk1XtcQ+6v+AAXp3nLmPIM/NhQA/uS4ZFzCWB5r0ashfEth90Xz
         N/RTqJ0mfS61zI6Jx0lE1XdLowcmXlTtCRWkMeMn/VOs9EV9K7w1Tsmfu5+NP2Fl2anP
         kgOPHvGBaQb/NOBzHBABxT+OFNSxWwm7ZuHY/GGAIvF0BmAiZg6KAh6TyuEA25tBNWhY
         RMw8uAluiciDwXpzEy1BC74w8PTPIdhaSPBE6bhk0qrsJolRujXMN0weyai1CkZn3mTO
         nDSB+pnO24xE78IofL4AOCrL4uIyOoGsMHHAXh745KX9aUT+YAmnRXx3rKc0He8vFm3G
         N56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V5P2LsRHz9TYbR56WIgtp6o6DPcYqGYcGSAOxY2w2UQ=;
        fh=GNdp8G+B6IPSlNosGfIOvww3xAEwscE6Mg8xr60922U=;
        b=jfoT3jod9NpA1u8m/q6w7oL2QE9lKA2k+4doSNaab3SeHZvJ7B+elcpGEn2HppfrGG
         Jf9SLH/O2yqnwgVWQvxwI4VxxXqc+JnR2n4iYCczOZeh9VD78khflnn5iTSyE/X35OW6
         0RGqb+TaZYRWpqr7U5JpGqo3xfdI5ypo/MVdADcE4XL0RtQ2ugeX07yrC94QsX3HAzex
         0mF2X594UIGATH2nddGSp80LvG/1tKWLfjhv6DlSc9icRZJps9vgXQt9J0dGmd2YvBQW
         ZbYCafSP+HjS+VLKZAQFLvI0J21GO+q9EJKWoIlk0eX3g1dDqzwBC7ZGf525x3CdzE00
         C/ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776212435; x=1776817235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5P2LsRHz9TYbR56WIgtp6o6DPcYqGYcGSAOxY2w2UQ=;
        b=QJSOt1NaFMcMzmZ99DLFoUPSgTJ48cCggUekxDdQvfg9ufl/paWY6vlG4nWi3zDejB
         esQdu2wRRrjJE/VuOtE0zhJU1XNc8usZceIYfFqGpcbes8xObe071+s3TaAfZnuhHaFw
         GeJUbcQ4QzHul1mrgeLxaEPT5sWtvbRucL+hLX5+ZzQxfIF3z5Xb8XD6AKlpq2edEdu5
         KsK2kLBjf+RhqL7ncNrmqLwWY1cNCnzbhmcD+O7xvVHQnHHysiIHwmFFAOME2jyg30U6
         rQAscrOUUwPl8H2ThKCHxJf2qPAu8WCmbQCFGKDM44DItrDVrCsVn+UAkoD6NlsStegp
         Y9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776212435; x=1776817235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V5P2LsRHz9TYbR56WIgtp6o6DPcYqGYcGSAOxY2w2UQ=;
        b=Agqg+GRwmpLuzbX9OiEIABY778knKOgZDEljUrAyXVEabdGuzUH+rNyLK/1qb3FhFx
         JwHwfJEtbqVu5HmAMBbT2hok6jXoCqGy6mAhEMZksohdLsTa83Gdy5Z+MU4mw/m3Bptf
         YbCo7qHBh+5e0UG0NM+SatAejvdetNE70+NBbODVvARqECCnhgXJ9pFBrsjb1a5wmOFq
         fhN49w43bUlPfKAjt0FUKzM1MPqAj/pQPrqLqIlrX6lh4G8lFPjLDMn4vyLDzLs1mYiL
         emh9W/g5KUzmSIQ/hDBLQupMtxwGi7ezH1RFSRYkos5zJwTwdhAf/pNiwMptxI0RUUTz
         pR9g==
X-Gm-Message-State: AOJu0YxlvRm0NcQn1HSLAinR6w4AT5NTzVrsGTUjr8IFwp7RWZWQMfzx
	lH3g6Y73U+3/e1ZtMsRQ8Z28wlJR3R2PPrFNpW1BTaPYiJy5AOzXMkxg3owj+IUA4UiySU1/HA1
	3XjdV5Ks5S39hFGOPxrv9nnhlNQ9oUHI=
X-Gm-Gg: AeBDiesIAwVU2LpfIWJzn0WWsGfmEQTb8MP6SPRehGsrrNPnFbCPaipqr0tdVKdXDfl
	ilR5WcX7NmaHVUET712k40yMeKuDYKjGzdl43O1m3mr4OtGKMf+XGbYESWW8oYc1PvnT5hlEE/L
	hAU5T3RnP9WfhxKeoLRRcNS305Rg9MlF3cIb8135EeZiPsKN6IPDaQZ2iRErdcus257o/lYaLR4
	Lx9UXk7oS4CrFm3Gpp5UFXT87PDY73x02P7cDZTVM9QZslXSdxJIORUfxjnhovTRtaWuQR7FgON
	ADu4iatB7yhqJTzsLXd9IsFgmEcfEeN2txOZ4nqZr6/9R2KjMOD4L0OOH/XI0fhhnKlpko9h4qP
	c0XAUQBiTPIosG1lC1rNeibh7NFMpicS0utsw
X-Received: by 2002:a05:600c:8284:b0:488:d228:a133 with SMTP id
 5b1f17b1804b1-488d683d280mr254031295e9.14.1776212434826; Tue, 14 Apr 2026
 17:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414-subprog-token-fix-v1-0-5b1a38e01546@gmail.com> <20260414-subprog-token-fix-v1-1-5b1a38e01546@gmail.com>
In-Reply-To: <20260414-subprog-token-fix-v1-1-5b1a38e01546@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 17:20:23 -0700
X-Gm-Features: AQROBzDSUYTegsI0Dqi5Q9L8FPbi0kwD852_YjvkBUSk694MuqUjdPn7fsOpS-A
Message-ID: <CAADnVQJPf-jd8h67-OhuNNz5hQ6pYXV5nFGYWs+-ZGYZHUTR6Q@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: copy BPF token from main program to subprograms
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, ctao@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 5:17=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> bpf_jit_subprogs() copies various fields from the main program's aux to
> each subprogram's aux, but omits the BPF token. This causes
> bpf_prog_kallsyms_add() to fail for subprograms loaded via BPF token,
> as bpf_token_capable() falls back to capable() in init_user_ns when
> token is NULL.
>
> Copy prog->aux->token to func[i]->aux->token so that subprograms
> inherit the same capability delegation as the main program.
>
> Fixes: d79a35497547 ("bpf: Consistently use BPF token throughout BPF veri=
fier logic")
> Signed-off-by: Tao Chen <ctao@meta.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e3814152b52f..17d605cef749 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -22956,6 +22956,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
>                 func[i]->aux->exception_cb =3D env->subprog_info[i].is_ex=
ception_cb;
>                 func[i]->aux->changes_pkt_data =3D env->subprog_info[i].c=
hanges_pkt_data;
>                 func[i]->aux->might_sleep =3D env->subprog_info[i].might_=
sleep;
> +               func[i]->aux->token =3D env->prog->aux->token;

The code was moved in bpf-next.
Pls respin the patch when the whole thing gets propagated into bpf tree
or resubmit against bpf-next. I'll apply to bpf tree in few days.
