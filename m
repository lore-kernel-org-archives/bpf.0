Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1033E34E
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786659562; cv=pass; b=LD7IK4pfpAoG3i/JbPmiJyUpwM0e/bLtIUzAUCMM225TCPGYh/FEWYPEMzyvLiLg7c9PdIl0JdPGoyf6nBBOa8BtpHYNu8TgyXUjL1VHdGlvDolA3/9o/uvb9RvoylyV9Smv6Q2xMAnHu3380dY2pKoXojILvdRz7ynrWJIcMcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786659562; c=relaxed/simple;
	bh=DCNuj4hZMU5dQ3ImyXLg7oXQDE+5Wb43CVNGbkQ+3Yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQwdD1GSCn06cNQApKOO+6JIqONr78bxIEhSBELawEWhet2vIT9eXmZgvafFgdkmknwTjguiIzGdV9eoMBK34xJbxxfrXTmL41QlCTq+Cjwb/QR10TyD9rQNyEp/U4CFxWIqBZiG2/8v34pGXrwv4gT76wCjtYNqMXIJdkPs2r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnToxncW; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnToxncW"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9e7391839cso329057a12.0
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 15:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786659560; cv=none;
        d=google.com; s=arc-20260327;
        b=SXJLwqpEZyUy3KUTGYVcOOEQl8NtSTgQrBgh9GvZHC6IcxdcbCVP/GPogGD/JGhFY0
         7VrvahWnqbXYRM/oxSbRlvjczmyp71mZUWS92MoelgjERcPFjFISf51nJJEhqWDj1VIP
         y43iJn5P6xy8rS+HR+7UFmmOP/tvkz27K0l6Ff5lrIlxrpo5C+Z3oz0Q34Gxa68DDgDf
         0qPNMbIVEVAiM90UkmwzbbNPT6RIxogb+ChpZzxlf16V8CkF9vuoWx+QJnFh83N+Luyc
         NSoW8ZY/8OtqwQySB+cfG0fBUarJ5nUarxfNrrUkj6+U4cIqwnXQxpo2hpT+jOqpLAv3
         asKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SjQ6DgrziXwEkM9z8Kl+icsTRDh7u3HCz5FJJYJC1y8=;
        fh=tD1M1+LIKDqOHgXF5hcN6UBYNyeC8XpWtz7upTYqC+w=;
        b=fKtXSADBjW2bBi/6QjdRB4Z92IoP1NkJpFRaK2k+NdmDQMtZy+Ork3l8yPTYa1Y6WU
         pjr7HQETgrQefgGXtgt5c7I0S72p+6JeZIyxPWMWR5acrcV6R6LAIa8obFYntZ9K+fUP
         /yuo6RMdVPNqt7tE3RQwIbudNptBSleeqQeH+kZKI8Et8MMvvFdf6vh+XJrxFtLoRgJ4
         Ly9Yhnw6LLvTZxvkV2SzhqYO6FedWZZOkPsX+dmfKZqBP9YlKX0TNRneRu0qABXgP/hP
         m0xgpktxxyLIdsCxJ9l9jpQ6Z1vEfRZarg1OKcH8dyGNuyOIxaC7F4HWPcZytZS+wx7B
         dvIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786659560; x=1787264360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SjQ6DgrziXwEkM9z8Kl+icsTRDh7u3HCz5FJJYJC1y8=;
        b=DnToxncWcJ/K6LvIXm9mwoz/uk/q8vuGEGbyESiqp86rlwCZYM5oInuwNq0cnK5gIA
         yycZZWDF+VKIWXiwmt/Llf7dcyM4yAGIlpX2ljYOnC3+DVVYe4NKU6ulovbOUU3oH7Sa
         IOEbqZXuL0EWDZOxTYJrXis068KqvvFHat5UrNXEsxkkMdXTfhlmlO6ivFvEEvxnMjGM
         RNd1/qgBlIE7Wpk3T7wQ0SZhrH7JSnDKWYgA8RMMMtAvk7pw0C/kfqgGBS1djGqyyYUE
         njqSfOq1JtEDNQf2T/q8XCNT4n4QdXI8PqXfMyTrX73K5mJTyv0hqfQI0hJkAm9mlnX0
         TOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786659560; x=1787264360;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SjQ6DgrziXwEkM9z8Kl+icsTRDh7u3HCz5FJJYJC1y8=;
        b=RWguIcoDz+jRPkooMi1Lf2QH+ucov8R71cJzqtB9q5d0ZxJ886VU687YVQxhqO49so
         lo7yg3lp2mVqxEp9Tx1JwZjOBNwkgX8Yl4nG5mYOHOTORvRQKuXkhR3JMaR1zkPJ2Mui
         nry8bM2czHR4Y9PEaOuFKQ+D3HMr8IcNHG8JODGZoqpCDZD3c9+GCEj9Z/cJVxVPDGBI
         6bABtgXmh1azB65PZx/UwzA/METSuk/LK7/CW/2+04V6CrPFy4K1HZL6ChiCley5HukR
         EZ3PoTxsH/uEaWFcnCjWxfbmY5XBPgxsdYxJcR0el5I9B6JzYZfyZdJwt/ZAqtyI50ms
         bgNQ==
X-Gm-Message-State: AOJu0Yy7F1pTejaVrY+FL3uD/ND2PodaqRatvX+fvCDWseWPC0kRAoUO
	027qVYgvA/zskitZGp+f3zXk6FqAwY5WNFG3siar9d3YsXiRVB9TR0GvMbD9xIXdpVkhz3VcBAu
	k43m/lIRXmr651rjhSUoshcOCnTx1e1I=
X-Gm-Gg: AR+sD12AxBKcxSD4gxSvlxl/6tpjjg89mnER/rbXcAdP46UJsMiNJUlEl6NWMVVD/Cv
	hyiRZ9hdKibZhVh5xskdNN6q6T/LlHiH87/qE5KtG5RZqXzvONWGcJxOL/j1mYg6J6Z9/RbsWlR
	07F5xGhQpfdmFaAX3bibYm+s9TY2nVKfnTQIDQu+RzWMNFXCKNWYtAmxwxIUJecUSH+Kpaxjn/Q
	uNGaJiN9/VB/h0HXL/X83sGlryIOWj+0Sv5zubCTZa+KiFiTE/er5fGadycoCG7iQg5WA9BhtW/
	WUYax9JtjGAa9dpy1IUUBMEg17sWbzoyajgThBYtovwLe8n55Xyv18Vd4QX/FlqqwZuVm9YEvW6
	z/1gYpVo0hFntMbB6FEKTFY9wsmiyLQFKERmvergNAQ==
X-Received: by 2002:a05:6a20:b598:b0:3bf:b1d3:393e with SMTP id
 adf61e73a8af0-3cc719c7b62mr1390951637.2.1786659560132; Thu, 13 Aug 2026
 15:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810135934.2887684-1-chenyuan_fl@163.com> <20260810135934.2887684-3-chenyuan_fl@163.com>
In-Reply-To: <20260810135934.2887684-3-chenyuan_fl@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 13 Aug 2026 15:19:05 -0700
X-Gm-Features: AUfX_mzcr9_pANAQ3PayhLnK7CPFvKV5oFQoyyVDej7_RMrcmcIfSgjXXxtK-t4
Message-ID: <CAEf4BzbGe74OuUKiDz7oBrWzQCD54JVhYuCTQEWNHOHmnBEtbQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add regression test for
 queue/stack map size limit
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Yuan Chen <chenyuan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 7:00=E2=80=AFAM <chenyuan_fl@163.com> wrote:
>
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> Verify that queue/stack maps whose element storage would overflow the
> u32 head/tail index multiplication are rejected at creation time, and
> that max_entries =3D=3D U32_MAX (which would wrap the u32 capacity counte=
r
> to 0) is rejected as well.
>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  .../bpf/prog_tests/queue_stack_map.c          | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/t=
ools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> index 41441325e179..043cbe92e2ba 100644
> --- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> @@ -2,6 +2,8 @@
>  #include <test_progs.h>
>  #include <network_helpers.h>
>
> +#define U32_MAX ((u32)UINT_MAX)
> +
>  enum {
>         QUEUE,
>         STACK,
> @@ -101,8 +103,55 @@ static void test_queue_stack_map_by_type(int type)
>         bpf_object__close(obj);
>  }
>
> +static void test_queue_stack_map_alloc_check(void)
> +{
> +       LIBBPF_OPTS(bpf_map_create_opts, opts);
> +       const __u32 big_value =3D 1 << 20; /* 1MB */
> +       int fd, saved_errno;
> +
> +       /*
> +        * Regression test for the u32 index overflow in queue/stack maps=
:
> +        * a map whose element storage (max_entries * value_size) exceeds
> +        * U32_MAX bytes must be rejected at creation time, otherwise the
> +        * u32 head/tail index multiplication wraps and push/peek/pop
> +        * address the wrong element. 8192 * 1MB =3D 8GB > U32_MAX.
> +        */
> +       fd =3D bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, big_value, 819=
2, &opts);
> +       saved_errno =3D errno;
> +       ASSERT_LT(fd, 0, "queue_oversize_fd");
> +       ASSERT_EQ(saved_errno, E2BIG, "queue_oversize_errno");
> +       if (fd >=3D 0)
> +               close(fd);
> +
> +       /*
> +        * max_entries =3D=3D U32_MAX would make the u32 capacity counter
> +        * qs->size (max_entries + 1) wrap to 0, permanently breaking the
> +        * map, so it must be rejected as well.
> +        */
> +       fd =3D bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 1, U32_MAX, &o=
pts);
> +       saved_errno =3D errno;
> +       ASSERT_LT(fd, 0, "queue_u32max_fd");
> +       ASSERT_EQ(saved_errno, E2BIG, "queue_u32max_errno");

Just ASSERT_EQ(fd, -E2BIG)? libbpf returns an error value directly.

> +       if (fd >=3D 0)
> +               close(fd);
> +
> +       fd =3D bpf_map_create(BPF_MAP_TYPE_STACK, NULL, 0, big_value, 819=
2, &opts);
> +       saved_errno =3D errno;
> +       ASSERT_LT(fd, 0, "stack_oversize_fd");
> +       ASSERT_EQ(saved_errno, E2BIG, "stack_oversize_errno");
> +       if (fd >=3D 0)
> +               close(fd);
> +
> +       /* A normal-sized map must still be created successfully. */
> +       fd =3D bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 64, 100, &opts=
);
> +       ASSERT_GE(fd, 0, "queue_normal_fd");
> +       if (fd >=3D 0)
> +               close(fd);
> +}
> +
>  void test_queue_stack_map(void)
>  {
>         test_queue_stack_map_by_type(QUEUE);
>         test_queue_stack_map_by_type(STACK);
> +       test_queue_stack_map_alloc_check();
>  }
> --
> 2.54.0
>
