Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999C72777E0
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105066; cv=pass; b=C68vJeRyKRoRqbLJAfA5bCqYYJ04c1njqqRqvNWJImtqHOikfEmo5DL0goRH/2cS4oLWMss3C0Yq6qXNmdTBxGrRlNty9bn6/5vAMdkZSSOLMwc5xBwlfMWw/l/6nO5IdmUAo27M8DD/9s2t7LcqlcKadjJ1lQ8dy0uM9HG5Gyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105066; c=relaxed/simple;
	bh=8Wl1J5hwxXhEd7SYm8cqNXkApLirWDp9Qz9p+UZQ35c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNiKI8cGmYaG49940fOkA3OMQcr8zkHXQjCA91uXw2wmqU+Ta4hmOpMja551HGLgXnLohRhWu2eDeYM1PyfNyTtxbFgvi96ZTg7y3JoIqVkNv+485hwUnN4BQWixDO3jJ0lXMng3EQ+1M/ZcOHoi8Q2XVcMU4bAn7UjOl/YMRbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ju1odibT; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ju1odibT"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-649523de977so1108852d50.0
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 10:04:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769105046; cv=none;
        d=google.com; s=arc-20240605;
        b=eyN2ys09O0a5k2lPKALfjqpW/14t4yYYg9q6Xq5novfBZiRAlwru19cqocMDFYxaf4
         6+28/xBR29ePAEfQR6a8gRfZtN78O2/mVCYrmP7aH9XlGbrlZuF/ZVfjDXaBv4sKu90s
         U7A9TLMMAyqxnttMMHa+W/lin8nh3UsLufCu5n5Dhk57W/J3hepLtSkQEsCkHelCU+yS
         zKbuQr0YeOg1OERy/50ZgD38GiEtuhqBujdY6FdE/r5zNreIvfESy8XTV7+bQQiyHvle
         IEhlHtbJPMEotUxBgTv6Lmsw33ZjP/WUZ0gbNbNee5WPCOC5LwV9iyGSZZYKYIm0ozH1
         i9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uOYgq90e7mqfTTyl0d9/bg2rDOythDs7zELkBCLpJTE=;
        fh=hboxMV+ig+t5uBsKdnrd6MzStRRVKSlXXVLeQMD9VD8=;
        b=FqoBp7YC7+CZ1gk32gMKeQdwRDVzhBEVVpdZaOXIlrAYSu8L1hdn6tzbJ0cZMsExmB
         ZVpStrEcbqbe+l/mLp0OqcQruBvk3u43mxkKDXAz9EoSGE3YJTwkKrByYDDRA97LO/hw
         WtN6SEtOyTAX6j6XdoPLAoV71LIHKAk/U667AVe9LDkCF7Sx/8GLdqgfZdsGJbizI8ur
         9mF/hxFd2z4L2/3vdktsZp5mCghPckwpV+bjqEguhBWWG+BUOYTK5uULu2r4oTJ8aCNg
         l9x9uGjG7hD0XFlyoCDhmfU6sux26K0NgVVj85WVDqHOeEzlLU1sDr+kc34lcFMjcOM2
         v5wA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769105046; x=1769709846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOYgq90e7mqfTTyl0d9/bg2rDOythDs7zELkBCLpJTE=;
        b=ju1odibTPMqtF/1FxKaDlxLqhlY9SdV1a9gU7IgVtOXV9nIMV3m0Ff9dxlcCp/EIeA
         DaiHi8npV0C8Z+GRwpE9R95oNqypOLE/SaLGCNMPi+f/qcha3qXELJZaqYn3ITlMj+x7
         5ibz5LMS8eDsqjIm8Fv22evfXAXvZ1WWRpN6HxW+QbFA/RD8Iq5YilyWWnuAjS54Sgbl
         BvEWAqt3QWpmUjCxO/EOaYtMO2srUoParqU+qV1pESEry4EaUBC9bYuckPukFm5tIIVT
         jBiWt86d44VRU8EziV6rsbt1HSTRJ9YPKF5jcNAEDRDPIiu1AJpnK13YjZ2gmeHNVeJ/
         CNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105046; x=1769709846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uOYgq90e7mqfTTyl0d9/bg2rDOythDs7zELkBCLpJTE=;
        b=ep4iVbNHE/QSTAxoPMdoMDGLcXfGwHQyKf99MjFjrMevGGF6cYPQRng/cVhzu5dJSX
         CW/8GtsNVzO9gqkrea8i8sQhgSg017x6u7qeT+/YrM2OemCvwPCxpSirGk6jcEWdDxpX
         HjTmLkJ3jekJbazV5AYp/vtOE9wytjuZcs5S622YhiigFSCMvv8bhwO4cJvJtofpt2fK
         sA9MxtJGLid7jtUXEzDVpd6/GVN1zpIpD4Het5gPKem+PAQOP3QavZwLGf9efOPOu+H9
         Xy26yr4rsSu5w/iaXS6vSZB1YTWteTx6jX3k7lzz/igdly5FuIXt2KiD8dd2sbnIJJSA
         ilcA==
X-Gm-Message-State: AOJu0YzTeE8nb7kjRPO6IZ8gZT6kBJI4PEKg5Z6sDQepQKqh2Jm6hwGj
	lZpD18uYiR+y+MW1tdekNtO5tQrtx3IwkWi7WKV4XNwVE+tTx5Y4tTqJ7GJcLlYOZhVf2oGjBcO
	u6U2RB5FPYVGAwjzXcnxfBJeRIHCzA0s=
X-Gm-Gg: AZuq6aLLurK5xjrCOyE/AER1jaj7cQR2Ntwevs0O8Kva7vAzuLR9K5dNHNtsgtbXro/
	IRMfZplW02+9r/TE0waiCzkMyHQfmyOXlfJbkZNaJcBN3k+YN5ivo9MlMzsyWVOzoSxi5NlKX1h
	YrNHl/LCfFPY8KqkDmW4kLs6Y7qKKBUzQ2HJ3Hto0wFdxjKKaEMpX8nHzTmfgk1EumLVfGF5l/D
	v8F9qJehqgv3aiq73P5MBRXROW1R4dJRmVNz9rrrrpT+zlhFcOssRKDRC1JxhTGqR4wcD5x/U6r
	LITeyCk77NSmlMgiy/uTxg==
X-Received: by 2002:a05:690e:d4c:b0:644:4e03:89fd with SMTP id
 956f58d0204a3-6495be78b3cmr270868d50.16.1769105045878; Thu, 22 Jan 2026
 10:04:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122115911.3668985-1-memxor@gmail.com>
In-Reply-To: <20260122115911.3668985-1-memxor@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 22 Jan 2026 10:03:54 -0800
X-Gm-Features: AZwV_QhX_ej7ftNzei2fbnfuIJpHZVruLORJ3na_Cj9tLouDoEuTr1_FZQhLdp8
Message-ID: <CAMB2axNB=v+rM1548vU_anUGj-p_hmA5_jSxGzmeUzKS-4W0XA@mail.gmail.com>
Subject: Re: [PATCH bpf] rqspinlock: Fix TAS fallback lock entry creation
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 3:59=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> The TAS fallback can be invoked directly when queued spin locks are
> disabled, and through the slow path when paravirt is enabled for queued
> spin locks. In the latter case, the res_spin_lock macro will attempt the
> fast path and already hold the entry when entering the slow path. This
> will lead to creation of extraneous entries that are not released, which
> may cause false positives for deadlock detection.
>
> Fix this by always preceding invocation of the TAS fallback in every
> case with the grabbing of the held lock entry, and add a comment to make
> note of this.
>
> Fixes: c9102a68c070 ("rqspinlock: Add a test-and-set fallback")
> Reported-by: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/asm-generic/rqspinlock.h | 2 +-
>  kernel/bpf/rqspinlock.c          | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspi=
nlock.h
> index 0f2dcbbfee2f..5c5cf2f7fc39 100644
> --- a/include/asm-generic/rqspinlock.h
> +++ b/include/asm-generic/rqspinlock.h
> @@ -191,7 +191,7 @@ static __always_inline int res_spin_lock(rqspinlock_t=
 *lock)
>
>  #else
>
> -#define res_spin_lock(lock) resilient_tas_spin_lock(lock)
> +#define res_spin_lock(lock) ({ grab_held_lock_entry(lock); resilient_tas=
_spin_lock(lock); })
>
>  #endif /* CONFIG_QUEUED_SPINLOCKS */
>
> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> index f7d0c8d4644e..2fdfa828e3d3 100644
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c
> @@ -265,10 +265,11 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t=
 *lock)
>
>         RES_INIT_TIMEOUT(ts);
>         /*
> -        * The fast path is not invoked for the TAS fallback, so we must =
grab
> -        * the deadlock detection entry here.
> +        * We are either called directly from res_spin_lock after grabbin=
g the
> +        * deadlock detection entry when queued spinlocks are disabled, o=
r from
> +        * resilient_queued_spin_lock_slowpath after grabbing the deadloc=
k
> +        * detection entry. No need to obtain it here.
>          */
> -       grab_held_lock_entry(lock);
>
>         /*
>          * Since the waiting loop's time is dependent on the amount of
> --
> 2.47.3
>

Make sense to me. Thanks for fixing the false positive.

Tested-by: Amery Hung <ameryhung@gmail.com>
