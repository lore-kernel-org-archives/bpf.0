Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E36F3C2797
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076065; cv=pass; b=dlTONSJ+gR101QwLah5/dGiU/WnyOMIyOv+vOTA2qXIWpcRhc3tzvFXW1SEhYtyNojYclo3BsOEDrcL7bwGZgHrl7AfMQbj+otsWiq+zEITy7O8oZqPDpZOInhNd1RJpb1SoexvO9vnILTH8qatyH6gAWVh4DS2gPSP0WUYr0pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076065; c=relaxed/simple;
	bh=9Hl8AgvR48yvWlB7WWPD3Z0Gr1W7B+l/RJ1tuuzG//U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYunJ0tS8JQr5MA+EWe2JSuXsJO5Tt2ST3OQvDuiu3KIo0KSUbZQlN7nURHOGnyHDxasbMCFZk76fYGktQLZcViTc+ajBwPkpvoKuwuGOptA03TGeu9Wa4EqW6zTuPqpS8lY4ov8aMhX44S4GucV8btlGxi8ov/S21EoTOmgsCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB/xGRUL; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB/xGRUL"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso4917935e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 10:07:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773076061; cv=none;
        d=google.com; s=arc-20240605;
        b=b1utZdCjnTVJrAYINZ2s6WEy4du9MMqwFThZEi5tDfCMqZ33dLLYQyVVe0ziyAv4JM
         HfZ0FAJanMyIpYA8V2BegtEt+UgQq9c0W/zDnL8cAClZDWy7OzUfJM4Yx6w92xtwpCJf
         gGWoFWUo5LZ3rgvPHlNuwPYAUojfQ5WKAw/fdt3AL9g1yreOpO/kh4MW44J5glD0vYvn
         j30NHqKB7lPzeOtdDVge4CrJ3i7wyW+kEChNh3rJQYHxV2O+fpkO/ZECzIQxntduM8Hu
         ARozZsI/d3NpVz3ZpP8Tf9/6iuPWvjcV9de0w8RVdZiFc2y5uEFYQHMVewQpIgRB5fH6
         4wfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FqE2fJ/X7neg7OD1Eo/n5dE4xe0NWQfY1wYD9sdi9Ag=;
        fh=9JwvE0qQi/DS0ARnXMW0uFnBew1vFtBipvJwBur0nrU=;
        b=iJssX7QEOfr9UkFXMAvEJSwCxzRzC3JAQNmhTBQKMEseKollupkYKmVlmTEkKkDDXC
         MB8mPaIbH+06oTmABQS2ydxCi1ceoYdgPh8MOqVDPggLNkCs67gcWR4LAOpOH2Q23Ibd
         tOrxI8Z58dkwqyj4hhN9bYQ3S1prhK5hCFLPdBmk/ykgrbpYWXead9DvQ4GMzwGE2rSv
         ZD5Ek9Rsh6TIOh8iB6q2TmiO7/MBuk0EX9N9V+sBxCdNl+CwNBCWYKcRrS2I55Yv38pv
         iPrpiZBy+D+2ccS+qQOeeoh+uOQ/6FlHymOCtGyEDw7oD8jVbeVNbZRfePx74jN+cBQm
         emeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773076061; x=1773680861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqE2fJ/X7neg7OD1Eo/n5dE4xe0NWQfY1wYD9sdi9Ag=;
        b=TB/xGRULj791N9nDLY74A3O1dz8uL1gdGk9CrQz6EPFj9aifeettMipmyML5kMNEqG
         1lBW8IXly6dfea7JcZwzyb/hm5EXHbw7krQMIrREG3EAH5aGTVnGWk15NsxESyXjidhS
         Rv1fan4DA3HCQiXqgrIgigNBef2Ittd2OTK4fZw2vXf2c8MemEc2aByLfOnGxBfegUDK
         avPeQF5eij5NZBi0yQXlRdIaKLGROgDSvPaU0iPzBQSONr2e2rxbmoS/fMzwD3AM/KjQ
         ilOvJ6GIBtdWJ+JiqAkrKlc/guSwd7UIa9qRX8lu3dDc3JULYgOMkq2SH/KkgqVeahSD
         q9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773076061; x=1773680861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FqE2fJ/X7neg7OD1Eo/n5dE4xe0NWQfY1wYD9sdi9Ag=;
        b=svHgZ/4ogsYMUB8DDRulq09nMCvOd3rClO68YMAKBC4YkZ1cbJaRAebe6j2uYm8kFt
         ouovger1ZzbyP1gbb1k4VjufbQGkukCNMRIHYmvmnpIOeJw75+s3AR/iM1pIuQ+7syka
         hkJctJQqD/zK8CTBD0RiUfpWpPXgeqZANkCPR91UQzKR+K5HPNH3IyjumqqRfhxLpQJ0
         EaMQoRV7rCtBXBLAaFYJZIJPn4G2fNdkOa7qWDZN+pzakLrTF0Hn9VF6uBQX+j56Aw1W
         Pdv51DpqE0NjTcXJQCyugrMrDKFkdr6TcFIYdLg/L4TnQotumMsWbHN4iZvpSKgPEvtD
         H5Pg==
X-Gm-Message-State: AOJu0Yy892UfQ+jWMUwPw1gIhJ9Ev58api2uiXtqhH+ekVrO0xxoAYFE
	z0YFRvVRh5WNxWn9KooCnf0cz6JYjNN7mbbAwNmIdx76iWC8aNsET0TvQebkOeV590HMdL9s5Oo
	ItMK8Bbv9dlndlGo3DPe94RnbXnpiNQ4=
X-Gm-Gg: ATEYQzzN/rjt3bK9vffDeXBX62UIXBWWsrEXsAu/N25uEB7qdybtk+YtvelZLMZ4WF7
	4mKJrdqb4RUbcqy26137ApXMjLyOPRXGrPHiXDLoXZlm49uqu//z0CFHDZkQ0jxKy1PEUVPsyn5
	OvPFiiiszMisK5uhZ7hNTlTK4JXmrmvK++fy7cuXDTWFIPiEexqgT5zK3lVd7ZE8rKYrhqaciGC
	HNhOvU321kKz0NK1DYV6QWxcEOHBcblNkjmoPmaYO+6FvzEo1KbLW4ZM2USmS4u10Q2oTvqNQa6
	0IPCp3E7nJFZcoGKVn5uB8CovX+1pMXl3ttxb11AG2yBh+rpdNUOjNCRKbUqvNjN+Wx+xgseg+z
	Re69bkR9pgqI+OaUJO4sqbTYM0jOthrAFm3Md
X-Received: by 2002:a05:6000:3113:b0:439:ba75:7dab with SMTP id
 ffacd0b85a97d-439da65450fmr21237678f8f.9.1773076061011; Mon, 09 Mar 2026
 10:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303131453.328674-1-hbathini@linux.ibm.com>
In-Reply-To: <20260303131453.328674-1-hbathini@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Mar 2026 10:07:30 -0700
X-Gm-Features: AaiRm51wrAKZg0huxnXoh83RAT7Tsq_qpgn4x24K3tzeY0JjOYfP8ZcwK34q5ms
Message-ID: <CAADnVQKuARvSirPjnTcSifLPunCiKC4Nenq0Mr61GpzbW5WxWg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: improve test coverage for kfunc call
To: Hari Bathini <hbathini@linux.ibm.com>, Eduard <eddyz87@gmail.com>, 
	Vineet Gupta <vineet.gupta@linux.dev>, "Jose E. Marchesi" <jemarch@gnu.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 5:15=E2=80=AFAM Hari Bathini <hbathini@linux.ibm.com=
> wrote:
>
>
> +SEC("tc")
> +int kfunc_call_test5(struct __sk_buff *skb)
> +{
> +       struct bpf_sock *sk =3D skb->sk;
> +       int ret;
> +       u32 val32;
> +       u16 val16;
> +       u8 val8;
> +
> +       if (!sk)
> +               return -1;
> +
> +       sk =3D bpf_sk_fullsock(sk);
> +       if (!sk)
> +               return -1;
> +
> +       ret =3D bpf_kfunc_call_test5(0xFF, 0xFFFF, 0xFFFFFFFF);

maybe add a comment with bpf asm to highlight what this is ?

Also 0xFFFFffffULL ?
8 "F"s in a row is harder on the eyes.
and ULL to make it explicit ?

> +       if (ret)
> +               return ret;
> +
> +       val32 =3D bpf_get_prandom_u32();
> +       val16 =3D val32 & 0xFFFF;
> +       val8 =3D val32 & 0xFF;
> +       ret =3D bpf_kfunc_call_test5(val8, val16, val32);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D bpf_kfunc_call_test5(val8 * 0xFF, val16 * 0xFFFF, val32 *=
 0xFFFFFFFF);

I'm struggling to decipher it. Pls add a comment with asm to explain.
I think the last multiplication is still done in 32-bit domain ?
or not? 0xFFFFFFFF is a 64-bit constant in C. I think...

Also we have 4 ISA versions. test_progs-no_alu32 and test_progs
compile it differently.
Maybe let's add another version of this test but fully in asm ?
Keep the C version too.

> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
>  SEC("tc")
>  int kfunc_call_test4(struct __sk_buff *skb)
>  {
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index e62c6b78657f..de4897ddcff1 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -766,6 +766,33 @@ __bpf_kfunc long noinline bpf_kfunc_call_test4(signe=
d char a, short b, int c, lo
>         return (long)a + (long)b + (long)c + d;
>  }
>
> +__bpf_kfunc int bpf_kfunc_call_test5(u8 a, u16 b, u32 c)
> +{
> +       /* Make val as volatile to avoid compiler optimizations on the be=
low checks */
> +       volatile long val =3D a;

Pls add a comment that this is zero extended in C.

> +
> +       /* Check zero-extension */
> +       if (val !=3D (unsigned long)a)
> +               return 1;
> +       /* Check no sign-extension */
> +       if (val < 0)
> +               return 2;
> +
> +       val =3D b;
> +       if (val !=3D (unsigned long)b)
> +               return 3;
> +       if (val < 0)
> +               return 4;
> +
> +       val =3D c;
> +       if (val !=3D (unsigned long)c)
> +               return 5;
> +       if (val < 0)
> +               return 6;
> +
> +       return 0;
> +}

Overall this looks very useful.
I would expand with another test where a,b,c are s8,s16,s32.

Please resend with [PATCH bpf-next] in the subject, so that CIs
can pick it up correctly.

pw-bot: cr
