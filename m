Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D75227E045
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847352; cv=pass; b=LA1vWOJ3o6Rj6WziEioH0bsRs7wS4HR0iIhJcbXAzmtw+20e8eJt+VRenpzL/5hi0dtHyAOs0UDHP9BZJkk6XzTA/hez6QxRhPvEqIW5OSR0KNZGkPdnJcNPq8pTV6NpEQx5lqxA17isvDAn85xMrItONuExyjGiaVxnZ+NzYX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847352; c=relaxed/simple;
	bh=5tJM/IOFmTBwEk6KRwggw12K8xJbGofyaznpROU0Gdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7Kitoav2IkkOVrmfG2PXe08BS+krb9ivHnwkPu9XOBSE+Y9NC74oHwix3qa99QiSSxLDWSaEocHaRJr9F8K53dP7iZYFkXL7BbzMyO7ZQ9H0l3ezbkfhLWaKd7s5pfB2cO6lgx5QRuStBMf2PeykSRwb2PPOv5Lq3seCzzJOJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iALz2aLc; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iALz2aLc"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4362507f0feso3789865f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:02:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770847350; cv=none;
        d=google.com; s=arc-20240605;
        b=eX8lePILR/fIOnXW4LMq7sPFwbsHe1Zyq3uijCQCc7gxD8Zbm8yhR055wLBX7NAgS0
         l3ooa24bDBjcMNmJYpIk65W6CFgtc6hPqVJ5PEiTvtgplR7s+TSnfyCwDo/xZAXoD6Xq
         gtCFdHgH0ITdn3nbonPQCFg12JLcecejXlpoPH66bauZbpR3htd038XQEcU6I2xQBx7U
         rLTVaSuNrgSMh4K3Mrdo+o6Hp2zODmXc5DQQFtAvdSmJgJkA8bgqLwTYXyfRBhrvkvOB
         NtsFd9Yv2JCd5b25izvQGpTiuXg5MeYk3szsJ7Ra+W5NcA783cxNb+myujKJq0dMVTiF
         nmkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T+yfShl3sVpZ+ZRUdesJYeDCGWqSYwJ/bLXn/Dcorsg=;
        fh=/vcNYrAJJb439dsZ7iBfi10x9/H/MJg6e/sjvEyepHc=;
        b=baDaMx6z1+iC5T+5VEyTnd6DvDx4HGvaBDOhix1QFkKHRg8RNpYt0ur+DP8jOcqUMX
         8tqjoojo69Sx9ChaKzKtnBXOjp/QhGDQ5785+8QRIilQxmENZyWD0owuB3s9d9E6F7si
         BtSvsJm9Hf08P927TkDBRrlHy9JGaQNbpQr6LOxhaCcZzZYPUYNwCcie6EZT5L9Sw3/i
         d9nEsR9tH+YBpaeIQn6cdaLKMSy8tsZ0s4arKgPSjESU11kjd9gIoabptWjc70ujTKAF
         xrpV1usAfr5MnHSvDjz0uuoDIJMHcC4x+AOwhLqGCW8DbK6dc+xoDne0pnqVJEdc2eIq
         wSYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770847350; x=1771452150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+yfShl3sVpZ+ZRUdesJYeDCGWqSYwJ/bLXn/Dcorsg=;
        b=iALz2aLcZl7PuIflChZet/e3bI8zbRMoEAWYKK1IIDI43sOfgqokcRR1q/xW3+VVUJ
         ex3uhbSId5TJKARUiF7mdGCHtqGaoVAcuKhg7M6aDu82cDD8IwfLmwmCn2IlQJiC3FQu
         KP89zbGdTeLtMCjfPT4gedu77I3k3nCaPMngK6EjbaDGdSDY0uLRqXarRkhao0PuwYGs
         VjScP3KISDMpnBnUtlAEFXfx2Ed5VMWVJwl3eEcC1wx1QRiLxgWCiCCCd6ZEm8J93nUA
         sTi5yVLxayNrD+vXLEmVYLBkTH0cnNGxC56fQlN4nhqo7F9NGOFh4s8KbNW3NNYWNlUL
         9rpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770847350; x=1771452150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T+yfShl3sVpZ+ZRUdesJYeDCGWqSYwJ/bLXn/Dcorsg=;
        b=pTLgdA7MBnYgjzaOb/oq9qaRhNofTbjoeHULXHuztxrTzEGKkSojl6/bAh7VwEwf5C
         KKxDAooHnnbshTTUstQPKac1cBYmrHNYjVx60uBmzp1/lgVCoSmE/jCatUG91mfZTcxA
         8r3MOOlgrCya01cH+FVmoaCHaG1zqPwAkbttDmZaF/v4ftmQ5lUVhIBa5fg37CJe7bOz
         JgWBt4RTmv2ds2PR/OJY/6Zy4iK2+0YEypHi1wCRucvZKFRiqnD/kz3pDW3UFGahDuDV
         FaewwF26xEUeWECzKEk2zfT2KufILSEUCRxVR55eaXrih/x4+NHEVzh7b+yXiLhhh8FA
         07/A==
X-Gm-Message-State: AOJu0Yz7RwG8YWNRCcVGMdd48x+4paytVyXtrieHwbISh3FqRwsorP4X
	2FjsQMXQ0saXTfNa0myX3SrcigelyQkpXXE2fc4yd1e+iaByqdCIUvAg7Oq32O2E5X4vpoPyoyB
	mBlZCZy2vTu6AfxB9CuGDleHYxMQ9Bw8=
X-Gm-Gg: AZuq6aIcA8hvPcox6mPut5QzoRiZDdbmsExn7uVMjRflEtry3xM4neRKYfBPUmQzD8H
	Yr9Vnrhb11c05pdyjrP3qP7EH5H32pD/92JRQItAbajozTLC6s4KbwGsduEuoXz7E2pZCan8w2/
	MZetlXJejyE33wzCrH6U7/VfLm7QmEkSauyHIMYiJBO3FIyC571T+GfIGSeb2MEeREXOstuHJR4
	88cv/AyL5tZNxRjOo06vHAj1TurokoZxcrgWitO2Xc24XnnbP4rai3oP/4DOGwKvGeEft+cmvp0
	+BQ9JTT4uCEonz7f8Onqs9WDRKMjFRp3sRJVUzXDUwseLfMO+g13pORCaDEcj/rdr9pmzJyZl1M
	cn1ViDjPQtlRB+cNpAMcdD9zHlA==
X-Received: by 2002:a05:6000:2884:b0:429:c14f:5f7d with SMTP id
 ffacd0b85a97d-4378ac8f35dmr1447269f8f.29.1770847349571; Wed, 11 Feb 2026
 14:02:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211181248.3040142-1-memxor@gmail.com> <20260211181248.3040142-2-memxor@gmail.com>
In-Reply-To: <20260211181248.3040142-2-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 14:02:18 -0800
X-Gm-Features: AZwV_QiLtXnzNgr0f-ufObU7DGCZpoCcnpmlX0xmchdVM27Ei1P6asmlx3cAkjY
Message-ID: <CAADnVQLBwsi4uPJukTWPmKF7gG56Qz7kWXcqQkSpkqMTjFk0aw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 1/6] bpf: Support repeat, duration fields
 for syscall prog runs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 10:12=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Currently, BPF syscall programs do not support specifying the repeat
> field to repeat the test inside the kernel multiple times. Use the
> test_timer infra for other prog run tests and make it with RCU tasks
> trace to allow usage for syscall programs. Also make the duration field
> available for use.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  net/bpf/test_run.c | 92 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 74 insertions(+), 18 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 178c4738e63b..4e06e516d9f2 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -33,23 +33,27 @@ struct bpf_test_timer {
>         u64 time_start, time_spent;
>  };
>
> -static void bpf_test_timer_enter(struct bpf_test_timer *t)
> -       __acquires(rcu)
> +static void __bpf_test_timer_enter(struct bpf_test_timer *t, bool trace)
>  {
> -       rcu_read_lock_dont_migrate();
> +       if (trace)
> +               rcu_read_lock_trace();
> +       else
> +               rcu_read_lock_dont_migrate();
>         t->time_start =3D ktime_get_ns();
>  }
>
> -static void bpf_test_timer_leave(struct bpf_test_timer *t)
> -       __releases(rcu)
> +static void __bpf_test_timer_leave(struct bpf_test_timer *t, bool trace)
>  {
>         t->time_start =3D 0;
> -       rcu_read_unlock_migrate();
> +       if (trace)
> +               rcu_read_unlock_trace();
> +       else
> +               rcu_read_unlock_migrate();
>  }
>
> -static bool bpf_test_timer_continue(struct bpf_test_timer *t, int iterat=
ions,
> -                                   u32 repeat, int *err, u32 *duration)
> -       __must_hold(rcu)
> +static bool __bpf_test_timer_continue(struct bpf_test_timer *t,
> +                                     int iterations, u32 repeat,
> +                                     int *err, u32 *duration, bool trace=
)
>  {
>         t->i +=3D iterations;
>         if (t->i >=3D repeat) {
> @@ -70,9 +74,9 @@ static bool bpf_test_timer_continue(struct bpf_test_tim=
er *t, int iterations,
>         if (need_resched()) {
>                 /* During iteration: we need to reschedule between runs. =
*/
>                 t->time_spent +=3D ktime_get_ns() - t->time_start;
> -               bpf_test_timer_leave(t);
> +               __bpf_test_timer_leave(t, trace);
>                 cond_resched();
> -               bpf_test_timer_enter(t);
> +               __bpf_test_timer_enter(t, trace);
>         }
>
>         /* Do another round. */
> @@ -83,6 +87,45 @@ static bool bpf_test_timer_continue(struct bpf_test_ti=
mer *t, int iterations,
>         return false;
>  }
>
> +static void bpf_test_timer_enter(struct bpf_test_timer *t)
> +       __acquires(rcu)
> +{
> +       __bpf_test_timer_enter(t, false);
> +}
> +
> +static void bpf_test_timer_leave(struct bpf_test_timer *t)
> +       __releases(rcu)
> +{
> +       __bpf_test_timer_leave(t, false);
> +}
> +
> +static bool bpf_test_timer_continue(struct bpf_test_timer *t, int iterat=
ions,
> +                                   u32 repeat, int *err, u32 *duration)
> +       __must_hold(rcu)
> +{
> +       return __bpf_test_timer_continue(t, iterations, repeat, err, dura=
tion, false);
> +}
> +
> +static void bpf_test_timer_enter_trace(struct bpf_test_timer *t)
> +       __acquires(rcu_trace)
> +{
> +       __bpf_test_timer_enter(t, true);
> +}

rcu_task_trace doesn't exist any more. We should move away
from that name as well.
Especially here '_trace' is misleading. What you meant is task_trace
and that it's sleepable.
So let's use either "_sleepable" suffix and replace 'bool trace'
to 'bool sleepable'?
or use "_srcu" if you want to describe the logic inside rcu_read_lock_trace=
().
At least "s" in srcu also means sleepable.
