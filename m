Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C49D395AD3
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245837; cv=pass; b=Abr8JDy9UHZkN2mOophxpgwuDqob7e3qLB+FI2EB+hAkcN6AL4hR2kn1pJVksRELI0UjXFai4yiQkfrGoo5Q/FSSM2iJ5Wcxypo/+u9766bnoKoLaAAuFPvbWkeLGEBVMOoBi/VcVSRoPOPzqMqv5/UOQmM0TRilXXbhhVQ8SKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245837; c=relaxed/simple;
	bh=BSYiNfjcqtbilpf9G77ON89zIBv60yDWhHNpR43RcG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJX8ZC/d6yi4Vhjpq3TE8A1W3gdKJ/y9xg1Q8wUSayvwzjaiqOv49MFr888+hd7BJAha7ukRbnkv5NFEMgwLdd/LF5yflkW9WgIplqrsv8YQ+o/4ggokyxeadmn5ORnRnU7kjt1hPoY92xra7lguOZbVfeUL0Pq+gS78Hg1msFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rwflqy9l; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwflqy9l"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c168baac83so1089405ad.2
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 13:17:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782245834; cv=none;
        d=google.com; s=arc-20240605;
        b=QAP67PhUranZiZ+Ev1wnE3Uja+v+62ydbmjsSn0DneCbWnDWsatC5hMKd1K5UZzx+L
         5Jpt6oCkjt58YkQRUUVQYKFSX/mCkX6aiFS7xXP6YIlU0cvAJvI8ecTQSu7/PJGpdsrd
         wITYv1WZsf7eE1Tsa6AmI8jPOEgsyIa0UO5fjwyUhXpQ+XNq2mVWFXKkWXcqBpi4Ngf0
         sAH6DdC8DO0tmgoBdsffxWsjD4n0WS75Dy/TFjCzpJtpfCSdUcuiRpgWUtIlXZWmRZcS
         hbVJ2rd8JTk6C7QctoVbOrluY3f6ozKXg9DHxVavzze7Ws9MMFTHk9Abc9dAYSsIg6SP
         98/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TDkRS+tM+X5MLSQAw7MXiKZlq+UbE5KS08f6slGFBtE=;
        fh=tqKeuO58RK2Cx/jtvuxN9FLmd5V3oWJE+Bte2phCuE4=;
        b=Ry2/o2lAOgcP5DyujtJd8wYciR9ZJyQYr2AVGGRHz5eN6vxAhvIICYDG7koqahDeXZ
         caqo5eCmmsn0w5wkx+vPFF0sqLnqnmWNjvWqZGK2DfwCu92zM/YMKqpyUMihzAgKOYde
         mV9/HXqME82I/IwTQ2SXgy9vWLBxC3qw2lty0ekmEs1aXl71SB7ghJ1uhnUtl3qVQASw
         yMxAB1wP+zz3CgCN8q4fr9/9I9bQd6ZvDdFaJ9D6LtzLICdydHj3ZXgVUinNVtBd+SNC
         dB/V5GH5uwaqq++UkFE3XgCv94vpQJH5R/8o8rZ4lBsOwE/KzMfLXH+oiIXYFUN6YbZ7
         PGDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782245834; x=1782850634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDkRS+tM+X5MLSQAw7MXiKZlq+UbE5KS08f6slGFBtE=;
        b=Rwflqy9l6lYwnnxOg9tXuY35ffQE6+rinuzNxdVF6gyi+dm6/E8ZE7SKHDkRQVxnR1
         DNq0KkOjZJiog4cnkOQfxrm27gS9tiQdZJZIiK5knmx5sJjdsh3zCTnKcQrihGkQWwk3
         gws8mV+zd2m4klHsDCY9V7+y9LtGEQWfqLlPgbrXzxk1E7JXTAJr2mujI8poBeeBjEDx
         nKq3qVyhccHZSCKsqiN969SBOffc7yPWSeVT9Z2LhIEtGNOT+YoEPIFQDUCajxFXYIFn
         72C2PaJ9APgAFgxxH+aMhaiAr4bD2dgoIjalq0rxJ2HFqkcjLmKCyAUkmRJsCsHJ5GQq
         ojZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782245834; x=1782850634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TDkRS+tM+X5MLSQAw7MXiKZlq+UbE5KS08f6slGFBtE=;
        b=qlbJrf8aBoL/46m0wPzT7KAmMRGDZWWqKWGQBI+Wej1IHPOLH4QOSZSGxEDxesg6MG
         xojfLnZko7sTnFMIjbSZj12k5ZO+RJEiaI54Bv1H7nVHmpQb1imcpxfVOSSHke90qAmO
         U62OCIbXwpAn+XB5+b/gVwMOjLSn36Wxif2g7rNJynh8T7i58S46EpaAs5aIiy9Oeqx3
         aadaRjOQLo6KEYX7etvNn9n1yedUkuxSocXPDNZN4bVmRPk97q2aK2OKcEMJkYOrCAWK
         e+GdrUP00Kkvn5vON6GuMxEWzSTDx9uEHpRhrSBOR7jeKnslzyFgohJZP53RI3ND/ZGw
         nicw==
X-Forwarded-Encrypted: i=1; AHgh+RqQ0bGYs8E4DPLi3NYlxNJEqdnsHKk/nJrRat1aLZy+MzODKvEuwEVE0c7wFAXdogb3BeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO4kr4UfYvToPvcPKCgVlPo3qO/98919v+8wqpxp1vKpwIVhgu
	intTxfPF6PnoHW6b9KYVZeG3ZQpkk51ZLV3x/J6CBZqY9ViG/woYOWzlM9omHdIS53cKW/+fsnZ
	skXFk2qOlEjUWyifJhuauWeDyTRb8a+g=
X-Gm-Gg: AfdE7cltJrOHCoS/hqtC3DGyanv9VNBeeIX+E/tZ9adBC/LPMBsnSy4CFGn9k10AWI0
	bPHZaTYZ2iLP1uGBQd8DE0QMwRAT7L6ZNQ0z1IZ6eIeeg6ODXPjMKrCu7GSPXfS0E9kU8NWl8Ce
	TKh/V/rmZEeppxG720RxRmhh4du/yyhQGdohihBxKi3J6JCJnyVLXbPKkTdCgFnZoxEWHDk3TOj
	RD2eHYLYfZi4oPn+sCRwlCYBMrBdxxjf0aqwswInsMXZVq7tWtfVx5qDaHyNxWd5nakLdKUhaAs
	wiyVGMDxdRGqgVsGF1NcVYLu0R7sNrraTViLhJOLwuKhNZ5hWk2SYCGHuyYnfi93PkhQ0w==
X-Received: by 2002:a17:903:41cf:b0:2bf:bd17:90d4 with SMTP id
 d9443c01a7336-2c7e151d8d2mr4280125ad.28.1782245833593; Tue, 23 Jun 2026
 13:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org> <20260618-bpf-ringbuf-fixes-v2-7-33fde039ddf3@kernel.org>
In-Reply-To: <20260618-bpf-ringbuf-fixes-v2-7-33fde039ddf3@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jun 2026 13:16:58 -0700
X-Gm-Features: AVVi8CdEpGZ38igQlR0_mWtEWrlfHpdcY4rIGcGw_cXgZ0_cBsNYkoAZNe89-1w
Message-ID: <CAEf4Bzay6HokFa2CTsoQt2SLQ-3WWC+EUe0b9KpT4Ju2TvBg4A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 7/8] libbpf: ringbuf: Use compiler atomics
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
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 5:27=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> Consumer-side ring buffer code uses architecture-specific smp_* helpers
> for shared memory accesses.
>
> Use compiler atomics instead. They provide equivalent acquire and
> release ordering through a portable userspace interface and allow the
> next commit to use compiler fences in the wakeup protocol without mixing
> atomic interfaces.
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> ---
>  tools/lib/bpf/ringbuf.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 1c5bce2b5e12..141f2cbe56eb 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -270,14 +270,14 @@ static int64_t ringbuf_process_ring(struct ring *r,=
 size_t n)
>         if (n =3D=3D 0)
>                 return 0;
>
> -       cons_pos =3D smp_load_acquire(r->consumer_pos);
> +       cons_pos =3D __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
>         do {
>                 got_new_data =3D false;
> -               prod_pos =3D smp_load_acquire(r->producer_pos);
> +               prod_pos =3D __atomic_load_n(r->producer_pos, __ATOMIC_AC=
QUIRE);
>                 /* Positions wrap; the consumer cannot logically pass the=
 producer. */
>                 while (cons_pos !=3D prod_pos) {
>                         len_ptr =3D r->data + (cons_pos & r->mask);
> -                       len =3D smp_load_acquire(len_ptr);
> +                       len =3D __atomic_load_n(len_ptr, __ATOMIC_ACQUIRE=
);
>
>                         /* sample not committed yet, bail out for now */
>                         if (len & BPF_RINGBUF_BUSY_BIT)
> @@ -291,14 +291,16 @@ static int64_t ringbuf_process_ring(struct ring *r,=
 size_t n)
>                                 err =3D r->sample_cb(r->ctx, sample, len)=
;
>                                 if (err < 0) {
>                                         /* update consumer pos and bail o=
ut */
> -                                       smp_store_release(r->consumer_pos=
,
> -                                                         cons_pos);
> +                                       __atomic_store_n(r->consumer_pos,
> +                                                        cons_pos,
> +                                                        __ATOMIC_RELEASE=
);

this almost fits 100 characters, I'd keep it as single line

>                                         return err;
>                                 }
>                                 cnt++;
>                         }
>
> -                       smp_store_release(r->consumer_pos, cons_pos);
> +                       __atomic_store_n(r->consumer_pos, cons_pos,
> +                                        __ATOMIC_RELEASE);

this definitely fits 100 characters, let's keep single line for readability

>
>                         if (cnt >=3D n)
>                                 goto done;
> @@ -413,8 +415,8 @@ struct ring *ring_buffer__ring(struct ring_buffer *rb=
, unsigned int idx)
>
>  unsigned long ring__consumer_pos(const struct ring *r)
>  {
> -       /* Synchronizes with smp_store_release() in ringbuf_process_ring(=
). */
> -       return smp_load_acquire(r->consumer_pos);
> +       /* Synchronizes with the release store in ringbuf_process_ring().=
 */
> +       return __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
>  }
>
>  unsigned long ring__producer_pos(const struct ring *r)
> @@ -422,7 +424,7 @@ unsigned long ring__producer_pos(const struct ring *r=
)
>         /* Synchronizes with smp_store_release() in __bpf_ringbuf_reserve=
() in
>          * the kernel.
>          */
> -       return smp_load_acquire(r->producer_pos);
> +       return __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
>  }
>
>  size_t ring__avail_data_size(const struct ring *r)
>
> --
> 2.55.0.rc0.159.gbe5d7338c2
>
