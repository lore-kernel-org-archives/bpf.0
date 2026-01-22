Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4AD392B84
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769124874; cv=pass; b=EgPWL8b8lIJHpIl1usGVDXXMvd6BeW8/aEeCR9+GUAncboKODSb7EbFWkAKZEwFqI6BDqXZYanAB1DJHhWG9xR8Hn42mE7L/4ljjixqfyTO4RuosKov6YmoAp2YSgOHOo1mq+hxAO6jHPJEcWUUZzjYqu6gEmH4NTJ7m1zb/0KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769124874; c=relaxed/simple;
	bh=giPk6DDRTZcvYlbkEFdvR7fVqxpE1eGDCxj7fPxkPd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F16VJippf3Cu2AB4SM2hjpsmnmYQFhR/a6d1kJDYNyEvp8FdDFwMFzyhl0dXuV6kHZsU+MccBXMQM5DZ8iSkHovSTrn5HXeAi46xl9WcNUVj5KxXP6qJO1CwXuQwTfnamQ1sA9/bTHqKVEJNv6kq68UixKmxY2bddYlPNEe0bz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1U59/oJ; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1U59/oJ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so998315f8f.3
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 15:34:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769124860; cv=none;
        d=google.com; s=arc-20240605;
        b=Vk8uCXAgQihokEL47g2KcQVyaqGHStr1IVypiFvkbJYwdCaT1UjJ1IfeEtUNclplmj
         a8++3gM5RwxVDQp7ik6z9hpYxkZJGjLu0mn9lW1BO2WicVtc+9gxeWdqfbeXjM76FRd6
         LiuBqVESg0RobLOX/5UYHz1qmLWYrzGQFTuLt7koOg7qpTYC5hvrTodYph90E7uzI795
         H/WMr4jG4LEmwbOGA4m6DqM6C68tXIVkA8tqM8SmzTrw6Iy8O72pLkJUnhHkKdywmfhR
         Qgb0/9rUi1i7bHuobnZee+rZNP9e/6oK1xlSvQTiPlF6IZ4VFs4odtBuDkODkLiK7H4S
         hCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mBcSZwb+tedD/xdaoJD62QVy+kZ37WwODaVrsVpIdlU=;
        fh=1HVoQoyKoOeBZuT3DVhN1OPP2j01XTj4ecsxLHq6U84=;
        b=P4+ME8TcvnxohGclBEUEcl5H6bHcxg47VGkBKLxoWL3jfPuVJf4lSsvTuAlqWKYMx1
         r2LU/4w+CXCm6ZsAipycbZJRclIIRr1n4u3qZt6AjRrn98DkY0/M6vaxIU43SuYQAUf9
         +7PtkVVBKZjIBTyLTRJH9z3fZc7lATxHAJjaaLTqjgHgnhyKXfjkuAxBeW83BPdkvTW0
         pP5eBTl0HsVM6xEp634anG30vTotNkTz4OTK66mJ1zNw4LQyBRmTVL0uIDUk/nJWrb3w
         mmRMRg5ywNT5Qy4ylnGPYvTqgCDhjXQ1oYLUuuaszHw9IMiSV3R94J/L4K0JixT1FNUk
         3Yzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769124860; x=1769729660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBcSZwb+tedD/xdaoJD62QVy+kZ37WwODaVrsVpIdlU=;
        b=l1U59/oJHi+m2Z1S62AHYtABl2osu5Fr1UufXIjJRV2HKacnNwT88b/lotycFQZzC4
         DNpb4D89zn1PrTvUyJEJvSvruDcbsNvyz4a0/tjVAvOsdgYXsgoaw45WDRM/nx9YxovV
         gKp8KMcA2fPRaZdJy5T4HQhIsRImt6QxYofXSSvgciHZ9PnwTZaDbkv5xJv+ypLVwJxf
         kKn8ooxEwOa0qFUepIM8HNixx11j0K/TfKESKimglPGHEJUl+Yrk3tUiziBq/4PcltwF
         iBNWhm6TZDKl/NwNr+cz2gLzISXPLr61mw8LS+GJrFftQx1D3CSIQ714jAJ7tpZdgDs1
         z6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769124860; x=1769729660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mBcSZwb+tedD/xdaoJD62QVy+kZ37WwODaVrsVpIdlU=;
        b=DHBMGPj4iLSJ/E+JI31GUbbDZg9P/WwkhqHtszPAgQXgxobuKmoEOVJkyKRi833Bih
         fn4lLSOCdXQ33LLAZLYqirRTrqkpXsL61Sv7IhdXh5fd7ZLl5g4yTXJZcxnd1/k7K6xs
         wkwDwodvkuv8/r+I4KOuZRy6Im55jWUSW7iUsQLaBMa/dx7t7IMlbFEfxombaP1bfcy/
         P4H9OPGbFVKokQtaomh1ECGnKm+lrRJBevM0ATxBC1lM3lkHcCZgv2PtvYwksQYPnjyf
         TQkigaEURXEw4Tw/xt4eHyqs66mtb7TN7ua9L5KauAYN7S8JQo9A/XNuFfyzmau84jz+
         Axmg==
X-Forwarded-Encrypted: i=1; AJvYcCX/HyuGWtX0hWFUYWPTESyxrsCd0k9z/02SbydI294rvdfmU9Ssa3b8+auO002hIdWK9eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyehjrp52tyUF0RJErR1LLi7J4MkYOWLVqW0X9+hZ/QebzwbqYT
	5u1LKrHMHqrCuP8FLt+4urRmtlj45iMeZcc6gJO5ygc6qC8CV1L8DE3S6VVdIFJV+1jwLlNVybW
	sVlNPGYNU00HU3AU5iZHHht8C2b1K+/c=
X-Gm-Gg: AZuq6aJwMoY7vZIPhW8D4KaGPj3hX5zpmGEVQSOKJUYRUhdVs2t8CXi99Tyng7Ff/kp
	/4YVDbh4yBnNFo2rfpG1xDe/kI73xNN14hUceB4CHUT/hI6iNwmlyooRpuWYo0kzd4k9uQ48+5G
	2o1Xp8n1sw8BSM56CdP4V/av9ttzA5XpWvV3FTftOct5sCu5WgVRdhW0a6nkbPUhUtWr2lhBMz5
	v1PKPK2UvrcrBeeQbjZ+znneIhgR/PRGjJIqPbAFWfFxT6EnJhTh0MVf6QFZW2b4aEEOKjZAV8i
	ELXddsVEAbaMjN4nP2w43iAYW0uyG1ZfM/pQB/cbtyBGIM/P5OnKVO59vD0JuinZ0075phh6kBa
	39RjjujKsmVv2Gw==
X-Received: by 2002:a05:6000:1887:b0:435:9770:9eb8 with SMTP id
 ffacd0b85a97d-435b15e47cbmr1910669f8f.25.1769124860201; Thu, 22 Jan 2026
 15:34:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122162616.3578898-1-yonghong.song@linux.dev>
 <CAMB2axPhNZXj86cby+4mgBFsVCzk4TnX=aC7PROkTd6Shh_sxA@mail.gmail.com> <3e2fbe5f-d28a-447c-9733-32091f461454@linux.dev>
In-Reply-To: <3e2fbe5f-d28a-447c-9733-32091f461454@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Jan 2026 15:34:09 -0800
X-Gm-Features: AZwV_Qjv9CzzLidu33YpXOAZeR7GH-ungNjt_BIGaneTQofXJqinRofjib_hmLk
Message-ID: <CAADnVQLDM8F_8r0AHPW5vxT=jJZi9qjGSe0nip84bLVaOdt=uQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Fix task_local_data
 failure with 64K page
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 2:58=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 1/22/26 1:49 PM, Amery Hung wrote:
> > On Thu, Jan 22, 2026 at 8:54=E2=80=AFAM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> On arm64 systems with 64K pages, the selftest task_local_data has the =
following
> >> failures:
> >>    ...
> >>    test_task_local_data_basic:PASS:tld_create_key 0 nsec
> >>    test_task_local_data_basic:FAIL:tld_create_key unexpected tld_creat=
e_key: actual 0 !=3D expected -28
> >>    ...
> >>    test_task_local_data_basic_thread:PASS:run task_main 0 nsec
> >>    test_task_local_data_basic_thread:FAIL:task_main retval unexpected =
error: 2 (errno 0)
> >>    test_task_local_data_basic_thread:FAIL:tld_get_data value0 unexpect=
ed tld_get_data value0: actual 0 !=3D expected 6268
> >>    ...
> >>    #447/1   task_local_data/task_local_data_basic:FAIL
> >>    ...
> >>    #447/2   task_local_data/task_local_data_race:FAIL
> >>    #447     task_local_data:FAIL
> >>
> >> When TLD_DYN_DATA_SIZE is 64K page size, for
> >>    struct tld_meta_u {
> >>         _Atomic __u8 cnt;
> >>         __u16 size;
> >>          struct tld_metadata metadata[];
> >>    };
> >> fields 'cnt' and 'size' would overflow. For example,
> >> for 4K page, 'cnt' will be 4096/64 =3D 64. But for 64K page,
> >> 'cnt' will be 65536/64 =3D 1024 and 'cnt' is not enough for 1024.
> >> For field 'size', it is okay for value 4K, but it is not enough
> >> for 64K as maximum 'size' value is '64K - 1'.
> >>
> >> To accommodate 64K page, '_Atomic __u8 cnt' becomes '_Atomic __u16 cnt=
'
> >> and '__u16 size' becomes '__u32 size'. A few other places are adjusted
> >> accordingly.
> >>
> >> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> >> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> >> Cc: Amery Hung <ameryhung@gmail.com>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   tools/testing/selftests/bpf/prog_tests/task_local_data.h    | 6 +++-=
--
> >>   .../testing/selftests/bpf/prog_tests/test_task_local_data.c | 2 +-
> >>   tools/testing/selftests/bpf/progs/task_local_data.bpf.h     | 4 ++--
> >>   3 files changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h =
b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> >> index 2de38776a2d4..4c38f9a7bc90 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> >> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> >> @@ -94,8 +94,8 @@ struct tld_metadata {
> >>   };
> >>
> >>   struct tld_meta_u {
> >> -       _Atomic __u8 cnt;
> >> -       __u16 size;
> >> +       _Atomic __u16 cnt;
> >> +       __u32 size;
> > Agree cnt should be __u16.
> >
> > size can remain to be __u16 as maximum data size is page_size - 8
> > byte. The 8 byte is tld_data_u->start recording thread-specific offset
> > of data in a page.
>
> In test_task_local_data.c, I made the change like below
>     #define TLD_DYN_DATA_SIZE getpagesize()
> so TLD_DYN_DATA_SIZE will be 64K for 64K page.
>
> In function __tld_init_meta_p(), we have
>    meta->size =3D TLD_DYN_DATA_SIZE;
>
> So size needs to be 32 bit in order to hold the value 0x10000.
>
> Are you saying
>      #define TLD_DYN_DATA_SIZE getpagesize()
> is not correct?
> The previous one is
>      #define TLD_DYN_DATA_SIZE 4096
> for 4K page system. For 64K, I naturally tried
> to replace the above 4096 with getpagesize().
> Did I miss anything?

iirc TLD_DYN_DATA_SIZE is a max size. Technically it can be anything,
but bigger than 4k is hard to imagine. Even 1k is hard to come up
with a real use case.

imo _u16 size is fine.
