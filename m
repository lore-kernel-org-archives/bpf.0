Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28D393DE9
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788893281; cv=pass; b=GsbDTLGg/OFACSRUblMFETw0siWnqMf9dTTfabhP3MzY7lyGLGt3gbuGx8vxzi6A2HtUyMkGtr0HnOCB86kiWBIO7tO1/rCRFPUpqNl1zPrVVGWwppksqXiQxX+qpgRi+5mnVzj+gXpC0bqulPQ/YrYNMctLmwaUqwsgiyQubhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788893281; c=relaxed/simple;
	bh=KC/MF3mOfz/c6LOZdWzUY/uMGzjmJufJKZrFNJHsoig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plm6tw3APqTDtz5MRXSuSYKFgh5/vS461DSMtgq/flGbUxOgC7WSzixXhH3ebvp45usgy8e58IiQtZ2k0D+ELVbftfSMDLVhzfH2+CUqMJITpelWJ3N/PoSNfLTtsqxCdOrXQsV1etY5snHd989xEW5e7tuLBRIPhK2QTiOis1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=htIQcPr+; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="htIQcPr+"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-867a943b149so78972397b3.1
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 11:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788893274; cv=none;
        d=google.com; s=arc-20260327;
        b=LfMR2xFLHMe/CPU6JqtZNRgt43C40TPkXX/rqRWKjxSBcbORgij5LWW/5epOJbqG6y
         CsugoECvNW/XJu+Vby+Go9xnM4nfEWAftJgZ0+5hKYaiAL68E/ruc4AlHdLs5PUTzhIE
         A+RWGvxlFfHpePZLfcNQKK+ZQ9sgbF5Lo0aX9QwENXX2j49tp3G5Z6+FckDkVc2e8aTI
         dBAYB1DWj8JnQZKmxmGCTKx5ddg2RS4Vp9EekukARV/NJbisAwj6ZBZgTpiz8lZ47MSl
         1i1sJWBAqx3eskP6GNpKQYsxCi5QU259aNf1r7Cz8KbJ98WEscE61hB/SyBIydqMpTgg
         ou0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UhEHmzke+KQ7j1V3S/wUURk+tLbzSlS1aA+NPmeIjqg=;
        fh=5bG9Ph3wKY1cq0b9UgO3oml+l2PwNGRHDr56ATb400I=;
        b=stziRXJbKkdWfxPmhcbLB4+fkEnd+sZ9q+cLeQBMV2Pv0qiBY3v8DT1gMgCw7RaXcD
         1ZFBXsMQ52pMVpraKMDNUSZcy8A2nfddqIM6o50yyKG3GNLcX/Kez9PjR76wLvl3lce9
         h2vQ6nhxAAAEhL3g2NGdmoePXaOIutM6tIjoXVT9OzDSWeDzqTNqKBYg1C01EYvvEEm8
         wIWrWPOgOfIwpbXKeagI3kcz3/kcfr2FHM94F6CcOxdrD3qF0D4C2LfxrjZv4r8VI/bB
         06sQKYw5FHFdgM4Bh7EdcBT3yJAUatnZ/rAQE3ccIC4K1MXWRHa5y1UxkS/OETkEKnzI
         i6WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788893274; x=1789498074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UhEHmzke+KQ7j1V3S/wUURk+tLbzSlS1aA+NPmeIjqg=;
        b=htIQcPr+83ncnADA6UkdYutO02/EkRz/xZcVAaoYs3VYG3nkcqeHRE23iRAozLfz3R
         GC4ClAZYgN4cp9uZu1H2CRRDXJigH7QDrNlEsThDU2ZUyl8hUhUCP9zP7DXWCMexEoUw
         qWFME4A4UVp9hlYOTWFkFVUfsM0NixsOhwJ7J2Dk/71bTZwa5sYHmEzpE5Zs1k1SKzBA
         KTVfMZmrMhFCvZu/rb6pqyR/txr1TDl98zmSpuDSOXDYFWDookFoEwHwDElVIfz1Ojnu
         WXL4gak4eZE4YWKJazeSp7EpOB38FFTJAVPLtEbC0U8+xBcHDohBvtQvIS41VjVqFhqN
         4DeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788893274; x=1789498074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UhEHmzke+KQ7j1V3S/wUURk+tLbzSlS1aA+NPmeIjqg=;
        b=TZxemHB8+yzTBO6yGPScQMLvph0nZSiIF7aMtk3LX2VPiEU1GozM8gOeSQcKgqzoDh
         crMtLinvgBq7IMpBd8KVwjgiTNidFYfCwU8IyxFLbwJixlTK2goBrNgflcbOUsJc4fkQ
         SfTwMweopU2nRl+u7Wua3QP3y0Znb6BSqUTMPiWC4zc0ofw9ShkiL4o7ecexip0TTjaB
         mn9w15dEWAYCG5rTurQ/JL15DGq8LiwtzIfSg+SogflYhUpXdNDG82v/+oxOdePvRuw6
         8RJEOCX1In0Ek3N4m+H1x+yKfY4q9CONdQPDOPDyQF3VXcDHKiPDX5StbVhgtdq1QBjA
         UvLA==
X-Gm-Message-State: AFuF++mtQ/gXcE1m20lX+MmPPmw6ikr4jIjRf6/untA8TkgwnHLTa3dy
	WbKv98YUL8TgjxGCi4r52tdRLXnoDxsIK7kFAyTu5M87ImvAd2B+tCdW5h1UlF2Ea6qgB4Lq9U9
	7hbxT/1LR3ZL3i3vNVdvYjieEy9EHkyp/dLGyTvCZtA==
X-Gm-Gg: AYBFou2iVR8VSQesd/dVnApiQ9UHxwykA7LTRJqhGHD+c5YyIRP9QaveqUcyLJw1J1t
	npnf5Isz3YECEjyWwBj44XzxmOCfkZL23LM4TYfoC+x8owNTs/Hu9AhFo+7T0G9xco2+DvCkS7h
	6R4MRguHR9l3V9StHnwxyE3n28vL9ufouIQg8Dm73Nx/SnAqjnEHN3jiPcrAiP0CohMTXHYMpmR
	Se7PWbGFNPu4EDVe1YooU4zsYapC07L2ThsJ/i2ZAh4r50vGY8EmTFcKQhcsBTLyeGRfjhLiwGO
	kCcPBkA9eAgyjmm4E+9ThevdSy7puqwIbaGBeka19xU4
X-Received: by 2002:a05:690c:e3ec:b0:873:5bd1:98b5 with SMTP id
 00721157ae682-8735bd19ff0mr101322187b3.39.1788893274555; Tue, 08 Sep 2026
 11:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830093514.4105972-1-memxor@gmail.com> <20260830093514.4105972-4-memxor@gmail.com>
In-Reply-To: <20260830093514.4105972-4-memxor@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Tue, 8 Sep 2026 14:47:41 -0400
X-Gm-Features: AcwNN1UkMhVOGf4HAzd8pl56tNOAvWYs-TYJaeEvTbGda8QhhOq35NCfQB3ZFFA
Message-ID: <CABFh=a406HZwo5tdaZGQ6vMaXJ6PjhD7FjcHSAdkYx3+v-MfAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/6] bpf: Separate stream readiness from
 capacity accounting
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 5:35=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Stream capacity is charged before allocation and before an element is
> published to the stream log. Using that reservation counter as the read a=
nd
> poll readiness condition can therefore report readable data while no
> element exists. A blocking reader can then repeatedly retry instead of
> sleeping, while a non-blocking reader can observe POLLIN followed by
> EAGAIN.
>
> Add a separate readable byte counter. Publish bytes with release ordering
> after adding elements to the lockless log, and use acquire loads before
> consuming them or reporting readiness. Limit each read to its readable
> snapshot and subtract only bytes actually copied; this keeps the aggregat=
e
> count correct even when concurrent publishers update it out of publicatio=
n
> order.
>
> Keep the existing capacity counter solely for enforcing the stream size
> limit.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

For the Sashiko issue: Do we have a specific policy for what to do with 0
byte writes? Imo we should completely ignore empty buffers and not even
stage them unless we have good reason to.

> ---
>  include/linux/bpf.h |  3 ++-
>  kernel/bpf/stream.c | 35 +++++++++++++++++++++++++++--------
>  2 files changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 0af3c79f5d03..2ed1e82391b9 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1713,7 +1713,8 @@ enum {
>
>  struct bpf_stream {
>         refcount_t refcnt;
> -       atomic_t capacity;
> +       atomic_t capacity;      /* bytes reserved against the stream limi=
t */
> +       atomic_t readable;      /* published bytes available to readers *=
/
>         struct llist_head log;  /* list of in-flight stream elements in L=
IFO order */
>
>         struct mutex lock;  /* lock protecting backlog_{head,tail} */
> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index 99a89533eaef..b1e6767d8754 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -88,6 +88,21 @@ static void bpf_stream_notify(struct irq_work *work)
>         wake_up_interruptible_poll(&stream->waitq, EPOLLIN | EPOLLRDNORM)=
;
>  }
>
> +static int bpf_stream_readable_bytes(struct bpf_stream *stream)
> +{
> +       return atomic_read_acquire(&stream->readable);
> +}
> +
> +static void bpf_stream_publish(struct bpf_stream *stream, int len)
> +{
> +       if (!len)
> +               return;
> +
> +       /* Pairs with atomic_read_acquire() in bpf_stream_readable_bytes(=
). */
> +       (void)atomic_add_return_release(len, &stream->readable);
> +       irq_work_queue(&stream->notify_work);
> +}
> +
>  static int bpf_stream_push_str(struct bpf_stream *stream, const char *st=
r, int len)
>  {
>         int ret =3D bpf_stream_consume_capacity(stream, len);
> @@ -98,8 +113,8 @@ static int bpf_stream_push_str(struct bpf_stream *stre=
am, const char *str, int l
>         ret =3D __bpf_stream_push_str(&stream->log, str, len);
>         if (ret)
>                 bpf_stream_release_capacity(stream, len);
> -       else if (len)
> -               irq_work_queue(&stream->notify_work);
> +       else
> +               bpf_stream_publish(stream, len);
>
>         return ret;
>  }
> @@ -176,14 +191,16 @@ static bool bpf_stream_consume_elem(struct bpf_stre=
am_elem *elem, int *len)
>
>  static int bpf_stream_read(struct bpf_stream *stream, void __user *buf, =
int len)
>  {
> -       int rem_len =3D len, cons_len, ret =3D 0;
> +       int read_len, rem_len, cons_len, ret =3D 0;
>         struct bpf_stream_elem *elem =3D NULL;
>         struct llist_node *node;
>
>         mutex_lock(&stream->lock);
> +       read_len =3D min(len, bpf_stream_readable_bytes(stream));
> +       rem_len =3D read_len;
>
>         while (rem_len) {
> -               int pos =3D len - rem_len;
> +               int pos =3D read_len - rem_len;
>                 int chunk, n;
>                 bool cont;
>
> @@ -205,7 +222,7 @@ static int bpf_stream_read(struct bpf_stream *stream,=
 void __user *buf, int len)
>                         /* Keep any successfully copied bytes; -EFAULT on=
ly if none. */
>                         elem->consumed_len -=3D n;
>                         rem_len +=3D n;
> -                       ret =3D (len =3D=3D rem_len) ? -EFAULT : 0;
> +                       ret =3D (read_len =3D=3D rem_len) ? -EFAULT : 0;
>                         break;
>                 }
>
> @@ -216,8 +233,9 @@ static int bpf_stream_read(struct bpf_stream *stream,=
 void __user *buf, int len)
>                 bpf_stream_free_elem(elem);
>         }
>
> +       atomic_sub(read_len - rem_len, &stream->readable);
>         mutex_unlock(&stream->lock);
> -       return ret ? ret : len - rem_len;
> +       return ret ? ret : read_len - rem_len;
>  }
>
>  int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id strea=
m_id, void __user *buf, u32 len)
> @@ -234,7 +252,7 @@ int bpf_prog_stream_read(struct bpf_prog *prog, enum =
bpf_stream_id stream_id, vo
>
>  static bool bpf_stream_has_data(struct bpf_stream *stream)
>  {
> -       return atomic_read(&stream->capacity) > 0;
> +       return bpf_stream_readable_bytes(stream) > 0;
>  }
>
>  static void bpf_stream_put(struct bpf_stream *stream)
> @@ -412,6 +430,7 @@ int bpf_prog_stream_init(struct bpf_prog *prog, gfp_t=
 gfp_extra_flags)
>
>                 refcount_set(&stream->refcnt, 1);
>                 atomic_set(&stream->capacity, 0);
> +               atomic_set(&stream->readable, 0);
>                 init_llist_head(&stream->log);
>                 mutex_init(&stream->lock);
>                 init_waitqueue_head(&stream->waitq);
> @@ -496,7 +515,7 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *=
ss, struct bpf_prog *prog,
>                 list =3D tail;
>         }
>         llist_add_batch(head, tail, &stream->log);
> -       irq_work_queue(&stream->notify_work);
> +       bpf_stream_publish(stream, ss->len);
>         return 0;
>  }
>
> --
> 2.53.0
>
