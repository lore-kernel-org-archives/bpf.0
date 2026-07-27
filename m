Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290823F5BF1
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192580; cv=pass; b=el8+EIFxKx+4bCm5P5NxiUxNOr3R4NIwPO4ESLbYAE8x+7g8ZHQzykoJzyDqSxKI+3+I9UVoWZx5de0PbFFAQ0uT2BkZTDN1QFVAK+1p8jvVxPURDOOi1MznAEf6f/mkAyBQ1hqKCstIqZvNX+mct70WpmWoiRBrGttMgVq1Xu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192580; c=relaxed/simple;
	bh=kiI1VSpNFJhzNSWcdLnTgQoINEGVQGu9QbkmvRTLwx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYOsDFVgUk8RgN8HLJxZ+XpBEIv2MXonw19Q2Tmu4VimKsA7WQ241bEV7Pj/6rTDC79PLcu6PUelPlTIWFJY5XdRejgr6y0rapeJuUkDgrrWk2cYtYG4I2otsc6SoKwZxn/07GSLsu9qnsFDdNw4jA90t5PnW5sL3n7i3xlOYgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIRjCS7v; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIRjCS7v"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e04df8c46so3284529b3a.2
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 15:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785192578; cv=none;
        d=google.com; s=arc-20260327;
        b=IE5OfBPL9hrS7nELAndGEjoqSJvh6CYOWX+LnPtxUZdomplc/LSk8wv1Gz34vmITq2
         dL4vamW23tnt1nVKpu+VxWYYehwLJw0q0SOF6n9v7kR3xOOHwz8CKUcfNAALkH3OkCEO
         G/Z/BQaGJDUJmXXmZYmMGKc7iA2Br5BrcBnY/j2cyGftDo8+74naivnFCaKo6Oy+uezZ
         r5kSQrr56ZS0KAM6D2k6VjUyn47ObBon9nRvP4Ny60ZiJ8ke94jAJX8RSTRd2q0GIkPC
         4b941CVdoA2wz+dta8KgL5NyOYrSyfFNi3Nz8Ym5KmWlDMqTKecBAkR6QY/ZCn/9Lf8S
         KNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GQFoB4SFGLamNMZTUVcntUxCITVtLe4SxVKbrivWzS0=;
        fh=V0IZvD0rwlWQEwezYMJ/DOR0/FhAx2rKjysAwSMW+Vk=;
        b=BOJ38KiK4z2XmpEvz4y79ILz4b+klR7jjKY/4e2HtC+R8aRiqJcspBSHtrLBy4Zn9Z
         WFP2E/5Hs945Rx0+Sh5ztiFksr0NBSwlEHSNM4qG9p4SX1K/ilPmUnSoRavGxp0ENgNT
         rKcrd20TMjrKEbZNWhfnEnmrRHCeDeTbNf2JsDX4XiqlTnyVgYRAn1/XsCZEj3SInHCo
         oSQhBqQbokzyLfhwO5KMOCTHjlq9diiqiBkleN0BBwMFRHQu0cN+nxp7PckXa+CxdoIO
         Uk4e0T12HA2DgYn0YEgT5xS7wKDdUKS+EhdAPi278zqQb+TLmK3kCHWLrGTnQDoVDk60
         gjHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785192578; x=1785797378; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GQFoB4SFGLamNMZTUVcntUxCITVtLe4SxVKbrivWzS0=;
        b=iIRjCS7v8XY6GxAcghfn3sF4ARW/NEwqclcBr4Tmfubn42aw3iewLxda905UbRnxCN
         1tBYdZt4Ccn4P9a5HiOgT2tHiNXpA47U2Imsn20T8H8PMA3MH2200oVI0s+e+rrg2tFl
         BT714J/2/C8m2wvbh4s1ZUV3JUbHgbzxKtRkSQZEZiHLY1rNv2pEMmGZDUVe8H6tuwIY
         7n5cWLz08pzQ3lI5zGPQAEypjckJAMkuZQb9L7m8WEytdTQVz8xYrF267jEWxZ6Kb8at
         mJj24FYUtJl4LFaLboPLtASGxSzaxZRrm6lm/ZP2J7MWUoIG2WFJ5nBmpr2ml+5CI85a
         wiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785192578; x=1785797378;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GQFoB4SFGLamNMZTUVcntUxCITVtLe4SxVKbrivWzS0=;
        b=Md2lyYbI2iKyWLzpuWcCsJVWshG5uNyFOG+OgmTbLo3I5wuyanv90b56o8+VamMVEy
         6hT8wtyvwiP5W3tVJuG8eYVrsqconHH/vZpEWoDjBS0rv2NvtaDe9K/y43C0P5/2Csk8
         GDOcFB8hFB5OGSqnc3KHWH4mAU5mHUNZ/g/kR8o82yYMT+iiaMF+HMj7QT1Q7PuEKl4Z
         vVwxm5Xcy07GCw5z/PkLursyq1mtCDqv27QOxGsBySU6RvAVuNFm0Gqn5BdpclmdGr/E
         KbHWX5fUbVsQWCgmTL3mFhgB4cNImFLsrAmkrj+Cps1rTNPTozqQmcoaQF5fb79sGXu6
         jgWw==
X-Forwarded-Encrypted: i=1; AHgh+RoUBciEmGhM4WAC2IjfHhWPHN66u+QGts0eu8wyd44NyKJ7QDx2ueiK7wO6KLWD2za1VC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd9Lu/kpHtm7W3rVirPDxZ5K4Akm3Ae3aNOAgz6i0oW1rWEhjw
	y023y/Q7FYLLWkS8GoDDUaVYZ6lmGMjoi3gIUyMjUS0U9LD1eiTlri8NHE7PLXXvjolLavb3D4z
	Nuc/MuaTYx6/I6IK3kKEkV4Z8cxxZEcE=
X-Gm-Gg: AR+sD10ZmUfaYGcMSt731K7NPOTK8qr+6KAd418B9WxNiAdJE6li0xncZGLjzlM8EjP
	/A5jRZ3errlVxMBQ8/3DakQJRmEtv49fL/hVBE23XvNVmbDixY6U1ZE0jHw2J10yQFAre10tgj4
	egu9pI2lStTMfd0cP6hqZo2Bo4L2SYJCxdg5zs2+w3YNGHk1RJNXxkhiIQc4eIDZYap95gcFD/G
	dbH1fkzA5ykLNKAELYVgOBLRrRrdqR9cmN/wee2IzngEbHUPHdRmVFnbHSjz/BLDQNt8hBA4OR8
	urolqcOCMwFJvDqo59q3FyWX4g4JhFoPL2ovc8OL/xtv0PiZwZR0LhWNPA==
X-Received: by 2002:a05:6a00:4614:b0:848:56d4:3288 with SMTP id
 d2e1a72fcca58-84e92a4053fmr262b3a.4.1785192578458; Mon, 27 Jul 2026 15:49:38
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720033135.62223-1-icheng@nvidia.com>
In-Reply-To: <20260720033135.62223-1-icheng@nvidia.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jul 2026 15:49:23 -0700
X-Gm-Features: AUfX_mz1Tcgts6RuDi909QGVxPtfHU9wZppgPtPplyQdfrshl8nczJf_LcXxfvk
Message-ID: <CAEf4BzZUYD2-+nbKCS4tjzgz-+DtvOKF4meoVyXOjS7mhLuCtA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Run deferred program freeing on system_dfl_long_wq
To: Richard Cheng <icheng@nvidia.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com, 
	kobak@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 8:31=E2=80=AFPM Richard Cheng <icheng@nvidia.com> w=
rote:
>
> Destroying APT's seccomp BPF programs can spend over 20ms in arm64 JIT
> text invalidation. bpf_jit_free() calls kick_all_cpus_sync(), which is
> especially expensive on system with many CPUs.
>
> schedule_work() uses a per-CPU workqueue, causing:
>
> """
> [204351.169849] workqueue: bpf_prog_free_deferred hogged CPU for
> >20000us 5 times, consider switching to WQ_UNBOUND
> """
>
> This is triggered during a normal "sudo apt update -y"
>
> Queue the cleanup on system_dfl_long_wq, the unbound queue intended for
> long-running work, to avoid delaying concurrency-managed per-CPU
> workers.
>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>  kernel/bpf/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 6e19a030da6f..a2ca6bdfb6f5 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3115,7 +3115,7 @@ void bpf_prog_free(struct bpf_prog *fp)
>                 bpf_prog_put(aux->dst_prog);
>         bpf_token_put(aux->token);
>         INIT_WORK(&aux->work, bpf_prog_free_deferred);
> -       schedule_work(&aux->work);
> +       queue_work(system_dfl_long_wq, &aux->work);


schedule_work() is using system_percpu_wq, and it seems like the
closest equivalent for long-running work would be system_long_wq
(per-CPU queue), not system_dfl_long_wq (system-wide). I don't really
know why we use per-CPU queue here, but wouldn't it be logical to
stick to per-CPU queue to keep the behavior as close as possible to
the original logic?

>  }
>  EXPORT_SYMBOL_GPL(bpf_prog_free);
>
> --
> 2.43.0
>
