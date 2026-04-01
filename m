Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C91DF73C
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 04:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775016732; cv=pass; b=I0JaTpqeO+FaLmadOVWDiEconcnWZr/qLXdrD7V5cvu6i6A+Y9UvXLni0AabctT2mKSm0IvjJ8T5wg/iYRvDv6Vl+9a2Bj4l5PeFXfqOswsU1Q+1dAPQM35lJKXw5sIn2zJcH8OL21aHl/oiZEaDCdz43wButFp7oNOleD+JZrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775016732; c=relaxed/simple;
	bh=LGyQY+BpoA6o3ncj7YKfSjfi/rVqR8mIcnYZoEWph3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ziz9dvjNkXt1MDe+5c2Le8od8F1LZis412wSB953Mbenn1ho9UzX0DY+Su2n1HXcC9cWcosk7su8utGO+KpdNpqYK23mdxw1fomP1vGFBsQsRP6yAl7M/RtWxhkmBtTfy58JotkRucozGbZ1/pVTLjpU6NNbiBc60hZLZVSKX0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhEeg7/F; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhEeg7/F"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-794719afcd4so33105457b3.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 21:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775016730; cv=none;
        d=google.com; s=arc-20240605;
        b=lET3MrPwmE3uwf+0ExzjOCydJq99cfUSPa0WJPB1G2eyCvzAFoZZqUqwnvfWEcwQNY
         gzzlK4Wx8nAwDdg8s1kOCw8l/kndS521l+TBnE/+eTrU0ReHCOgrF1N1n7fSHnQqtb9h
         qMXlHbeIuoLKOc/eiM8R6u6YDpObPSy1wzwFERBMlri+vK81Ba8MF7hPvA7QxubIqO8p
         R2l+2ElpZXYOfuLQTvDGFnVYdpQRTAKTlESGNVb/uJAEyXUqAQwF+sqpYNzAZZ+q0OW8
         4fSW8DHY2KCFMmhxqM45Zt1tKAUlSDfcF+H8Slw+GaVYVM28aTvfAkZmLv++gIvXAhfl
         5EQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5NxOoaR5sx0uGHcMNhqLDI3liqwYtj4Q7nED+KAnPMk=;
        fh=jLrlXpAN1N+6I2c7BxDrN4VK5iGiuQSN/y4zidXjizY=;
        b=NP3Q6VFFWGaJkEu9bino+53Bkyger9ly662uD4SMNu0nMOhkbOJMJBaq3GmoLyDCNB
         Tzow20bDEjDzklAHarw1r+7WQYfbp75dbntjLVP+j6Nu5+vRBBlIy3rAxawI8T6ZsYI/
         sDfaCjza65C7YbdEVtGiDMUmPyDhjsj26Mn1u7u4rYw5VJA5BD9QOfe/z75T9kxee+od
         mKIezYUWgE0I4d1ve4PLWMYvwTO4sNCn7YLAW0/t3MJA4xb23Y8Rw+sEj2qpnZihWFy/
         jh66XAcAEszZRXTrng6LLkOpPo0kUxqQe65be8/+WeOTSPAVI3b8T77HO9Wvnh6iD30N
         JREQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775016730; x=1775621530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NxOoaR5sx0uGHcMNhqLDI3liqwYtj4Q7nED+KAnPMk=;
        b=rhEeg7/F1GAAQkxI3gdVpbVqc3721aUQbYilGdhxBbNW65WyJWzGiu38xWH6qaEwCR
         Rr787UbmLRf/p8M2Tu/lcDWsVKLBO6lwEFdLZ9DPDDl5l81J9WhvqvSectUkXripA5qV
         1A8/fs3a+bmXFnn0jxY8I/imjYXFuaQE/icxHz3Eo9gtFy3ViCvY9y8m1rTLp+Wl/+YT
         Ikf25+LgCUi+4/TBzBD7nbfVcpVhFPI4MiRY9uN85LFVncz9+k7GX5BKJ1W6T+0nSCIB
         mjqG8GKBoQUV0uEULoI7jbAFg5RY266N5Mf6a4C8BbDnVLVlG7KAfotobU0bFBvVk5sE
         rYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775016730; x=1775621530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5NxOoaR5sx0uGHcMNhqLDI3liqwYtj4Q7nED+KAnPMk=;
        b=jGIQer8BwLzsCrLfqggQeUln+aYVbcirnX5bgF8hxXv5FtkQlOM3misqYMbAfQBsx0
         /FQiRgZdgvKM/v6lvLUxVlm1r4nmu92/oO6w1jOkuylRNsGpu0LyU9FcMy8GmWscVH/p
         AQW5RwOJD7I0UAtDrnwSjEh1FDNmgLVgWutNfuGuCw7pAChYUUJptnEAOaOMAVCoWBKH
         +K46bB3OW2SEcWKoCB6VBW4a8FGDCxR0JyFtU3UVX/mQLsGKP6+4RBK/YFa+bEzE7cL1
         4fuhi+bYHGC3Wsi4eFBSI0sg4UXfJh7ALzAvOoSXSl9Yf4WzHZOiMhHI1M4LkXc4n/tJ
         kkTg==
X-Gm-Message-State: AOJu0Yzu+bA8mu0JLr+La+t8pGkJ7hjfDu4jfujY2m1xqsNr9MvV+Atm
	D9UTqGyLeljlL5TyZl8CXCoMl+DS37ky6uDyTJxPPfMphXcBAJefWUb55Xt7sJz/jtoytI8jtBx
	zOv73Ojc/A6fdEv9aASJ6hzyF2GFw/DY=
X-Gm-Gg: ATEYQzyP7qGGsrro0849gSa9W/8eTwgDaJIAcJjUhcUygI1Ge+/Sg7YyQCu8hc9I0Nu
	qJnF3vcJvfx4+ZL7QDp9VK9ecetkaOnq7tcAwQ7brJd6faDg2rVMFvtBBaB/Dh//oOzBHoVzxdd
	yO4g4W/HU10YQtj5d+T5oew337r2hCI3H4MQb3TtqZsVpzPxz8fRZC8aIgQpQQXORuDC7C4Xwjv
	dCZ+cYczdr1lBclEPBTw4weaPGY0/gi80usJ6NI3TCU7bZhkngprpiO17U2wrtE6+1tLIBwlqJn
	Z0yx+neNAvkFbSEVlhqgI9afPGVVTeinDR6wy5woyqAclac8QsVuWkLumAZMWQ==
X-Received: by 2002:a05:690c:ec5:b0:79a:b330:a8c5 with SMTP id
 00721157ae682-7a212338856mr23598467b3.38.1775016729801; Tue, 31 Mar 2026
 21:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331213555.1993883-1-ameryhung@gmail.com> <20260331213555.1993883-6-ameryhung@gmail.com>
In-Reply-To: <20260331213555.1993883-6-ameryhung@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 1 Apr 2026 12:11:58 +0800
X-Gm-Features: AQROBzDsCSPf6Z0xHyKyfyjoHb4z2umQCZEfVhsAke6H5D1j0vhdW0pClslG0pM
Message-ID: <CABFUUZFh8OqR=gvLHBiOPLEFqDrFaqtD+R=0rt0fBOhkK=v6UQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: Improve task local data
 documentation and fix potential memory leak
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, yatsenko@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 5:42=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> If TLD_FREE_DATA_ON_THREAD_EXIT is not enabled in a translation unit
> that calls __tld_create_key() first, another translation unit that
> enables it will not get the auto cleanup feature as pthread key is only
> created once when allocation metadata. Fix it by always try to create
> the pthread key when __tld_create_key() is called.
>
> Also improve the documentation:
> - Discourage user from using different options in different translation
>   units
> - Specify calling tld_free() before thread exit as undefined behavior
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  .../bpf/prog_tests/task_local_data.h          | 25 +++++++++++++------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/t=
ools/testing/selftests/bpf/prog_tests/task_local_data.h
> index 91f3486439bf..1e5c67c78ffb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> @@ -22,14 +22,17 @@
>  /*
>   * OPTIONS
>   *
> - *   Define the option before including the header
> + *   Define the option before including the header. Using different opti=
ons in
> + *   different translation units is strongly discouraged.
>   *
>   *   TLD_FREE_DATA_ON_THREAD_EXIT - Frees memory on thread exit automati=
cally
>   *
>   *   Thread-specific memory for storing TLD is allocated lazily on the f=
irst call to
>   *   tld_get_data(). The thread that calls it must also call tld_free() =
on thread exit
>   *   to prevent memory leak. Pthread will be included if the option is d=
efined. A pthread
> - *   key will be registered with a destructor that calls tld_free().
> + *   key will be registered with a destructor that calls tld_free(). Ena=
bled only when
> + *   the option is defined and TLD_DEFINE_KEY/tld_create_key() is called=
 in the same
> + *   translation unit.
>   *
>   *
>   *   TLD_DYN_DATA_SIZE - The maximum size of memory allocated for TLDs c=
reated dynamically
> @@ -47,7 +50,7 @@
>   *   TLD_NAME_LEN - The maximum length of the name of a TLD (default: 62=
)
>   *
>   *   Setting TLD_NAME_LEN will affect the maximum number of TLDs a proce=
ss can store,
> - *   TLD_MAX_DATA_CNT.
> + *   TLD_MAX_DATA_CNT. Must be consistent with task_local_data.bpf.h.
>   *
>   *
>   *   TLD_DONT_ROUND_UP_DATA_SIZE - Don't round up memory size allocated =
for data if
> @@ -110,6 +113,7 @@ struct tld_meta_u * _Atomic tld_meta_p __attribute__(=
(weak));
>  __thread struct tld_data_u *tld_data_p __attribute__((weak));
>
>  #ifdef TLD_FREE_DATA_ON_THREAD_EXIT
> +bool _Atomic tld_pthread_key_init __attribute__((weak));
>  pthread_key_t tld_pthread_key __attribute__((weak));
>
>  static void tld_free(void);
> @@ -140,9 +144,6 @@ static int __tld_init_meta_p(void)
>                 goto out;
>         }
>
> -#ifdef TLD_FREE_DATA_ON_THREAD_EXIT
> -       pthread_key_create(&tld_pthread_key, __tld_thread_exit_handler);
> -#endif
>  out:
>         return err;
>  }
> @@ -203,6 +204,7 @@ static int __tld_init_data_p(int map_fd)
>  static tld_key_t __tld_create_key(const char *name, size_t size, bool dy=
n_data)
>  {
>         int err, i, sz, off =3D 0;
> +       bool uninit =3D false;
>         __u16 cnt;
>
>         if (!tld_meta_p) {
> @@ -211,6 +213,14 @@ static tld_key_t __tld_create_key(const char *name, =
size_t size, bool dyn_data)
>                         return (tld_key_t){(__s16)err};
>         }
>
> +#ifdef TLD_FREE_DATA_ON_THREAD_EXIT
> +       if (atomic_compare_exchange_strong(&tld_pthread_key_init, &uninit=
, true)) {
> +               err =3D pthread_key_create(&tld_pthread_key, __tld_thread=
_exit_handler);
> +               if (err)
tld_pthread_key_init would still be true, so later callers would not
retry key creation.

sun jian
> +                       return (tld_key_t){(__s16)err};
> +       }
> +#endif
> +
>         for (i =3D 0; i < (int)TLD_MAX_DATA_CNT; i++) {
>  retry:
>                 cnt =3D atomic_load(&tld_meta_p->cnt);
> @@ -353,7 +363,8 @@ static void *tld_get_data(int map_fd, tld_key_t key)
>   *
>   * Users must call tld_free() on thread exit to prevent memory leak. Alt=
ernatively,
>   * define TLD_FREE_DATA_ON_THREAD_EXIT and a thread exit handler will be=
 registered
> - * to free the memory automatically.
> + * to free the memory automatically. Calling tld_free() before thread ex=
it is
> + * undefined behavior, which may lead to null-pointer dereference.
>   */
>  __attribute__((unused))
>  static void tld_free(void)
> --
> 2.52.0
>
>
