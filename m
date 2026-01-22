Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6438E10E
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769124909; cv=pass; b=gHp8vSz8R94E7bVP8f1P9NkHYAj3kVgq8LdSJrZyDQ8Vg+VrotffvEPsit2QMjiwQbY+AawxLEb04b0G8EFnJ9/2bZHymymMB3T/HgrfzGgJt6xybkGfq700shoU32TqET803HPCQVSvPBWwcYI8lrYu6JqqKU8Lg4+ldjibSw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769124909; c=relaxed/simple;
	bh=cWnAzy+hn6CvbcGX6kpk6V3WGORgce0onC3M/8tbt/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUgOR2y8MiPHtRi0IDZ/e1ST4oC1lEsu6p2ZpI9aMoA+fy38sdRCwaVs1ZNRQCE//seuV8eoJZt4qKbogdpCA4kl1tY5HzpSDJxKsXoQAwmOcI8S1tYFLa8qPxn41R4ePrabkirMJvGEypG8c4PTeeJys7JTnkTUaOCkV9ke/Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npOE/pzO; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npOE/pzO"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so11848715e9.0
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 15:34:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769124894; cv=none;
        d=google.com; s=arc-20240605;
        b=ldVcHtkwFaRwjN+YCaaez8xaBQsfgdRsI8o0jyzkqd5Bw4ovOfGIjpcfRNAq6UYn4k
         Jwd5uGeSno8ExUNMztzgTlJd31utxk7IJZh9d2m5DSrTb+nkvNW5YbIIp2ArO0o9t0/C
         bTDpXhL7bVVI9cJ1eM3l/sQq1rjqPEMNMKmpXTm2fh+GXCmqjvwMq4DhqX9bvsoLa6BE
         k0IMSfUZJw03urgpjonKwTzVEq8qiR5Cir55p2B6Ny18qcB+jkJN3hwxhzWVPNkqfeol
         9pdqpAE7p10KOym5NT1pEGoyAc1s1poXjeg1yhrig5ZgDmPYNawBBafDB9LvptSNmsdC
         Y4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gLALu0cKKEP4IChgEbHAxJs5ricV/J0uk0tzJouMdTg=;
        fh=Se6rbFxQQMfdArJNjpkYGL0T6QVJSKNvd/eZrBTOYkA=;
        b=See/Jb1K4mq13xMabU0TDLsW5RlB8RbnLed1MG5WMLqqykWQ25iyftFaqdyBM2+ddn
         j4uBvrK3+jW0KKyz6j3lL/ewiTIxGUhWaPV8gj5y9FRJ/Blod4n9uE8b4UTKRi5woMD3
         9DBqQL34jX5lwhOQnjRHxsCnJgR0o4M5YrXw8al7OkRCHbSwjoVvzyMb6/0kOATsPIW2
         ZjO6fGD8QPM+JuUiAVlqpmP+RqSpyINvHvWlAvkTPW70PWVp+muAQi17mFUUeuFOZvdE
         KYEEvSlMjpj9JljH+pzEG/foJLONKGnD7FsuEuCSlZttZsidFS039JsDppxUNREQMmzC
         uwJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769124894; x=1769729694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLALu0cKKEP4IChgEbHAxJs5ricV/J0uk0tzJouMdTg=;
        b=npOE/pzOFprjeZjBx74RcdVN6k4cp3dJMPeVZR5PdrgjFjEOH8kbf2V/1i24pr7SQH
         DOuZYj+SsVTibx47TEUxvJ0N6ibym+9Os3gphLRruP+AbHYd8Ry6AyLk2e76XzqEQffr
         MerXBMNZZAzJ+9oHEy3FiEZwQI/S2Rg/2tD9aS73JizV/efGYslzCpnsYEVEun7mQDHH
         F3A63X8ZPNijHiWRz0rMbOOzm6lo8h6NGTUXSEPaZ/34V7eFJgnTIW7KK3C/v0cSaOBa
         AWtiegJ6RXTFOyncjuJMhGlFbgwODXKLYP3T9KJoGLHKYSWjejF4i+8kjrUGhD95+bJQ
         21oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769124894; x=1769729694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gLALu0cKKEP4IChgEbHAxJs5ricV/J0uk0tzJouMdTg=;
        b=TcCTAtrNupBoO+b1SxxeI3AMXZxC7k7g65TBD3dPopweKRHbEKVzuOWGjiPcwEPf3x
         QfTlmTfJ1OG0FiSUdZWBEjXjWg92dnu0RPEk3fsR64FpnpzNyYRk5T2qZwme/tIbCRDk
         kNdy41weTHxlGafg7nBze2aWTMAzI/caStUFywHKigabzqbyh2+6Pw4ra0anAaXCd+48
         siQyAZec0E8YYocDpFj1fOHikXHSkOaO3IVES+gBr3XpMIxBZIJFrd7w5iei9kDHbZNL
         /j6nSCJuFy948aKgQKHMv+rwlGRSfMkkQPCmsP94a0g21YTtIEYRmgOtckL0dMq7x6Pu
         qVPA==
X-Gm-Message-State: AOJu0YwU9ILLdBGS1eoHdk/cXGtAM9oFoDmhd6SusGlSt+vgPvFhYIUh
	8kYn/CQ3oxm3MTWwD5bn1WiX7uljI/+txSTtOmKu15DVQ2nr3hvaDcHUffmV5j0xtE4vAd76Zv0
	R2me/SCftju22UWOEI7jXDxMQwwmvlHg=
X-Gm-Gg: AZuq6aIzkujxcJ+5LaqFzkHm+II7z0Dp4RfvSgZqT3naLQFdcW76fGZnpc66MskMXUm
	KG3agWdoxMOG8SQjye5/7wFMH12h0AkSyk41rRIxlb0BDGPawPGi0k7cuozD09A/IHx0856FviH
	fKgjY5ciFuTA/qnjlBae+yAqkhf9BWKDjxGKT8CfMPBNeA1XcmKVQRKyor/8Pw4i+BPX1zFCc+f
	B7y0g9lY2iesjIhF26kNKEQrNXucnBVhhZKLffkUFLUiXVj8OyXuPszwuCkM1uwnGVnfDsxr6cX
	BMKHZWyZwF9WCQcdhJWCZpGs8//QnXTtahC1cH57OCFmFLWcut2l7f/xzKpmLLgXdHIZ4s8Zzef
	TbDRiSxxVVNk3cQ==
X-Received: by 2002:a05:600c:8714:b0:47e:e78a:c831 with SMTP id
 5b1f17b1804b1-4804c9cbeb8mr19032575e9.36.1769124893809; Thu, 22 Jan 2026
 15:34:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122214340.1457621-1-yonghong.song@linux.dev>
In-Reply-To: <20260122214340.1457621-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Jan 2026 15:34:42 -0800
X-Gm-Features: AZwV_QgbRacyjWaVdfm-sUjm6LYEkw9p0f1vKQ9C2yG2qatJUm5lC6SkO3o-JtU
Message-ID: <CAADnVQK9u8z2_fRe+tND+tMLEfZVidNguWEro-4AUo-aNu4iYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] selftests/bpf: Fix task_local_data
 failure with 64K page
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Amery Hung <ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 1:43=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> On arm64 systems with 64K pages, the selftest task_local_data has the fol=
lowing
> failures:
>   ...
>   test_task_local_data_basic:PASS:tld_create_key 0 nsec
>   test_task_local_data_basic:FAIL:tld_create_key unexpected tld_create_ke=
y: actual 0 !=3D expected -28
>   ...
>   test_task_local_data_basic_thread:PASS:run task_main 0 nsec
>   test_task_local_data_basic_thread:FAIL:task_main retval unexpected erro=
r: 2 (errno 0)
>   test_task_local_data_basic_thread:FAIL:tld_get_data value0 unexpected t=
ld_get_data value0: actual 0 !=3D expected 6268
>   ...
>   #447/1   task_local_data/task_local_data_basic:FAIL
>   ...
>   #447/2   task_local_data/task_local_data_race:FAIL
>   #447     task_local_data:FAIL
>
> When TLD_DYN_DATA_SIZE is 64K page size, for
>   struct tld_meta_u {
>        _Atomic __u8 cnt;
>        __u16 size;
>         struct tld_metadata metadata[];
>   };
> fields 'cnt' and 'size' would overflow. For example,
> for 4K page, 'cnt' will be 4096/64 =3D 64. But for 64K page,
> 'cnt' will be 65536/64 =3D 1024 and 'cnt' is not enough for 1024.
> For field 'size', it is okay for value 4K, but it is not enough
> for 64K as maximum 'size' value is '64K - 1'.
>
> To accommodate 64K page, '_Atomic __u8 cnt' becomes '_Atomic __u16 cnt'
> and '__u16 size' becomes '__u32 size'. A few other places are adjusted
> accordingly.
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> Cc: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/prog_tests/task_local_data.h    | 6 +++---
>  .../testing/selftests/bpf/prog_tests/test_task_local_data.c | 2 +-
>  tools/testing/selftests/bpf/progs/task_local_data.bpf.h     | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/t=
ools/testing/selftests/bpf/prog_tests/task_local_data.h
> index 2de38776a2d4..4c38f9a7bc90 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> @@ -94,8 +94,8 @@ struct tld_metadata {
>  };
>
>  struct tld_meta_u {
> -       _Atomic __u8 cnt;
> -       __u16 size;
> +       _Atomic __u16 cnt;
> +       __u32 size;

pending discussion in the other thread...
this can be _u16.
