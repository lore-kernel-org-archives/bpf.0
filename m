Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C3639E9BD
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 20:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246439; cv=pass; b=bjY5OsVjHf788P2IX51RhKu2G7OkmsXBh3juAWoSeqQvbkYmUj7C707jdd+zMLUwEE8bRgSUpDcvWxGhSwb6DSv5oVo1K9UBKhlk1L/B680bLvVqNxghcPIHi3jW/y2mYfObc1tZSdPcFkMToQbyA/VSrXpLQftK2fEKo59GQCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246439; c=relaxed/simple;
	bh=0givHChfCtgJoG3Jw5N8bUWO/zkCW2u8xflNqGJxbDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAdZ/nOvenLuHbxAUkcnnkA6rc4JtxS6YvA6XaAB0d4CBt9T+w7K65CIpx/+wcDu8ewQXb/0vLg4b0L4ZxGLTaYGZF8kLz+IgkLB3k3yHb6PNl3mdGDHP/1u1JsnHKTWeKBIBONLin0+yakDlOgnTmIup1roQL965yQYptd9Qrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9c1OcuF; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9c1OcuF"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c6bc87f4d5so1121445ad.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 13:27:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782246438; cv=none;
        d=google.com; s=arc-20240605;
        b=Qxq+v35tz3DX09qPSTOkEEdtJ10T43NQhbBsLrhjiDiXT5Gcx20DDrN2bfAWbWlZ2N
         9J4HB3/U4QpScFUwPoTCyhf2sDrHG3C26xcNamdS6HrMBR2ITtcAwXmTRzrGSXVpFT8t
         OIowRlxyvJF3i+YYmmi+qvOFIzeQDoR53h9URciWB0JIHUDtEwgckcGtSZFBpBKl00gH
         eLezLXIdzT95LPZn8CpYDwDJwYymfUKX4PcxyTNGzUvolH1eXRTctdOvLXkCEQ/wSpbU
         mvhIZKH48TrQKNhX/3zdMm0/6eZVyJqSraKptJtJEzIaaHvoHxRagwKGt6v/AnMSO7hG
         m/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A2p3VMqob0x6dZXFsBHs+SV7dY60+U6kj2FwO5qGa2o=;
        fh=2T48NAExCdqyGJFWMVR7Vu4p3AzyPURhfoxoNNb1P4Q=;
        b=SNPFqtRe2KaN8qKEG3E8TecVm7aZvtC+FKAypZRlA8zTDzvn3IM19uhb2zSnW79ciP
         +tW5OHOSwdnr9vQ14vPrvTYyBpMvLV0Qtzu/+Znn1Xjb+72huxf1zep+SAmNR8epUEYB
         of6Golx7vft+U9wfyirsr0y3L/V4RrO0msSitE/XnLqdyqfLuZf0WB6Ip1F46i6uBq5h
         w81acO021yLkGVI4pSIM2hT1PEPNnFH17rqAiqwRvNuABxgASjHd33oTFx3ThTiBZ+7f
         6p73IZgtHAEKdPh/2WHkkJ5esjGmzwsRyPZNbN7Krw6JraMRZ176s3oZqFx/tl73WUCC
         FAgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782246438; x=1782851238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2p3VMqob0x6dZXFsBHs+SV7dY60+U6kj2FwO5qGa2o=;
        b=Z9c1OcuFHmBWV7Ua7iIv195QoBl60M5YfeP4Yx3FsIsMloirTWshGhrF7mUoYjQQ7F
         UubvpL6zUTp9Lq64ALr60qaFrBSqFblKK3l7icw9Z8609FpXp1LJb6HhDjYS0oMOUnvp
         Ezpk3fjyjIpCTOrGGGQUqxLEVkzC+idDV9PxUMNpRVE4jD9XIX1kjEHcWaZz2T3c32Yc
         DfuQE8hx9gCbbZoZNZvAZ6/yIQsNWfCYVWrCUI2+gcMHgG8KOW0mVwOMI+hpKudiE2z1
         9KpJkcMUpyR4SC64b+NEmHejaXNAQK00xBtW690qvssYszxKyiTz49ZcaSgr8MV2gXsa
         hDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782246438; x=1782851238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A2p3VMqob0x6dZXFsBHs+SV7dY60+U6kj2FwO5qGa2o=;
        b=N8vASML7Zs9D1bf4wlHyGB9rUWPKjahYwJrX06ciV4NtriO6bkU8LJNJ+ZnOsfjbqw
         9G4nalR0/AZ+Z4B2YCD7RoB1JJfui6G/Q+fGjozYa6q/OhrW0eJoVuYwDIzymF7q2KKE
         hr+X8VUa1/QjvH8Q2LXdlQzkigFuQRQegBFkVwru0EXV2cAPZCQBhewgg55Eb+xEtJ7+
         nKhRC9SSbo4PL88XxBzBwSeBne5HyIUuK5Ndu6RouLFKmHJU4DQE6bxOPvvFL/jvaJoS
         US4bE8wE1P769uF2nsQ34GHCv8tOEQDHtypi2lBgwObVhf3x7ZxD63UmC38j2SiwbmVp
         qEQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr8CBLFkHCHqXaUtVidFcHW5zXvG160+7JsYvqMEg9b4U/E+DwSLF55E8RWTRPy4fsOnpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8nDEs/CTgNH9tbmQ6ovcFwL99QEfz3RvzLYv/Ymn7MQVjPWbU
	gfqRj75j/0/fdXxbtiqNyIl3EOvDipUSTAUvlBvB54VE0g4rs9wRhdhw4o3VHmQDl2tZT+AtVhr
	6Xt/XEOXe8It+YJ06YdnwPOh+xlssCGs=
X-Gm-Gg: AfdE7ck2jYTcPc+VEmF4/T+CgnQi1OQuLPlHdciO2KO1zKtcXT8vTicjlKS4afULw3K
	z6sIUtC3alSBhitIDjIivOoJaQTNTiKBnj6aYsJ6UWEIieJmzCRmDStY/t6fG+fpNeXdLLrt9fI
	pHGahr818CWSdQdK1S86j2ZrUnRu6FdBhJF4008vcpGqUNZZilWS3lRyP40oPUradGuxgkoQVmY
	g8LNRNmFhQ0FgiBcUDPii2n45hP94dSLSvzv+hhvwVRt3Uk/6KMbfgE510PgtjJ4FcNj5OqTsZx
	HV2U01lPMN5EXMDdnYxe5XwhBsnIHGsxd3cOfa/hHBnsd0z8I8BmI3YzRm8VhZKp32xoUA==
X-Received: by 2002:a17:902:d505:b0:2bf:23c3:34ba with SMTP id
 d9443c01a7336-2c742b3e10emr162283065ad.28.1782246437819; Tue, 23 Jun 2026
 13:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org> <20260618-bpf-ringbuf-fixes-v2-8-33fde039ddf3@kernel.org>
In-Reply-To: <20260618-bpf-ringbuf-fixes-v2-8-33fde039ddf3@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jun 2026 13:27:03 -0700
X-Gm-Features: AVVi8CeXtZ15zdMfAxyxFrRffuXWFGGoz7UAyF138iQEs558FIoN6NKA4iLQNGs
Message-ID: <CAEf4BzYKewRUpOboOmPcxdX25731tF0w63V0Ha=_f4D_F-ie3w@mail.gmail.com>
Subject: Re: [PATCH bpf v2 8/8] libbpf: ringbuf: Prevent missed wakeups
To: Tamir Duberstein <tamird@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>, Xu Kuohai <xukuohai@huawei.com>, 
	Andrea Righi <andrea.righi@canonical.com>, Bing-Jhong Billy Jheng <billy@starlabs.sg>, 
	David Vernet <void@manifault.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>, 
	Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 5:27=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> After consuming the last visible record, ringbuf_process_ring()
> publishes the consumer position and checks the producer position. These
> operations lack a full StoreLoad barrier. A producer can therefore
> commit a new record but read the old consumer position while the
> consumer reads the old producer position. The producer sends no
> notification and the consumer waits despite a queued record.
>
> Insert a full barrier between publishing a consumer position and the
> next producer position load. When a record bound or callback ends the
> current invocation first, execute the barrier before returning so the
> load in a later invocation completes the same handshake.
>
> Add an edge-triggered epoll test that drains one record per call while a
> concurrent producer fills the ring. Without the barrier, a missed
> notification leaves the producer dropping records from a full ring while
> the consumer times out. Document that bounded consumers and callbacks
> that terminate consumption must drain before waiting again.
>
> Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
> Reported-by: Andrew Werner <awerner32@gmail.com>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/bpf/20260614015716.945AF1F000E9@smtp.kern=
el.org/
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> ---
>  tools/lib/bpf/libbpf.h                           | 23 +++++++
>  tools/lib/bpf/ringbuf.c                          | 24 +++++--
>  tools/testing/selftests/bpf/prog_tests/ringbuf.c | 83 ++++++++++++++++++=
++++++
>  3 files changed, 123 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index ae46b17feaa6..3a649ed87034 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1440,6 +1440,11 @@ struct ring;
>  struct user_ring_buffer;
>
>  /* Callback-based consumption is unsupported for BPF_F_RB_OVERWRITE maps=
. */
> +/*
> + * A negative return stops consumption; non-negative values continue. St=
opping
> + * can leave records queued without a new readiness notification. Before
> + * waiting for readiness again, consume until no records remain.
> + */
>  typedef int (*ring_buffer_sample_fn)(void *ctx, void *data, size_t size)=
;
>
>  struct ring_buffer_opts {
> @@ -1456,6 +1461,20 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer=
 *rb, int map_fd,
>                                 ring_buffer_sample_fn sample_cb, void *ct=
x);
>  LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)=
;
>  LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
> +
> +/**
> + * @brief **ring_buffer__consume_n()** consumes up to a requested number=
 of
> + * records from a ring buffer manager without event polling.
> + *
> + * @param rb A ring buffer manager object.
> + * @param n Maximum number of records to consume.
> + * @return The number of records consumed, or a negative error code on f=
ailure.
> + *
> + * Reaching the requested bound does not establish that every ring is em=
pty.
> + * Records can remain queued without a new readiness notification. Befor=
e
> + * calling ring_buffer__poll() or waiting on ring_buffer__epoll_fd(), ca=
ll
> + * ring_buffer__consume() until it returns 0.
> + */
>  LIBBPF_API int ring_buffer__consume_n(struct ring_buffer *rb, size_t n);
>  LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
>
> @@ -1538,6 +1557,10 @@ LIBBPF_API int ring__consume(struct ring *r);
>   * @param r A ringbuffer object.
>   * @param n Maximum number of records to consume.
>   * @return The number of records consumed, or a negative error code on f=
ailure.
> + *
> + * Reaching the requested bound does not establish that the ring is empt=
y.
> + * Records can remain queued without a new readiness notification. Befor=
e
> + * waiting on ring__map_fd(), call ring__consume() until it returns 0.
>   */
>  LIBBPF_API int ring__consume_n(struct ring *r, size_t n);
>
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 141f2cbe56eb..0598f6c2f7da 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -271,7 +271,7 @@ static int64_t ringbuf_process_ring(struct ring *r, s=
ize_t n)
>                 return 0;
>
>         cons_pos =3D __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
> -       do {
> +       for (;;) {
>                 got_new_data =3D false;
>                 prod_pos =3D __atomic_load_n(r->producer_pos, __ATOMIC_AC=
QUIRE);
>                 /* Positions wrap; the consumer cannot logically pass the=
 producer. */
> @@ -279,9 +279,9 @@ static int64_t ringbuf_process_ring(struct ring *r, s=
ize_t n)
>                         len_ptr =3D r->data + (cons_pos & r->mask);
>                         len =3D __atomic_load_n(len_ptr, __ATOMIC_ACQUIRE=
);
>
> -                       /* sample not committed yet, bail out for now */
> +                       /* Retry a busy record once after publishing prio=
r records. */
>                         if (len & BPF_RINGBUF_BUSY_BIT)
> -                               goto done;
> +                               break;

so we do this one time retry just so that we can reuse the same memory
barrier, is that right? and similarly all those error-returning
conditions with cnt =3D err. Wouldn't it be cleaner and easier to
mentally follow to have `goto done` which would just duplicate memory
barrier and exit with whatever value err is?

>
>                         got_new_data =3D true;
>                         cons_pos +=3D roundup_len(len);

[...]
