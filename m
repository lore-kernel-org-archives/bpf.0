Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94AF42AFA0
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786656811; cv=pass; b=syWfr0/1c37Ab/cOdoaXB77J7MmXYizAWErr3N+fORcrsCZWThKlaeZWokmldG8/8KE6MNPYW2Ps6lhOB+h6yLgINGDqZGeloaNuOPysx0UTP9BE3Z1zLbZBaQzBZbN0l52ix7H/eUmNON7G7AkxGkOhAB+FTm8tNgswnA6spNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786656811; c=relaxed/simple;
	bh=w+5q2g6Ue/XTQ/eL/mCngu7a7G+eyoHj9y/oXsxacQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tykClcKbfo/pmSW6x4I1YAmI6/l3u0t35/Zhly4NtXyhmOv8qr5Mi5N7SlCHrQsnl0Z9avxBmTMK4GWY4pny/HBjuoyRORyR3yQ8i+9UwH763siKrqWXlOvhWe2YS9WcTLDcZT/CX+yuq11aY5nMrJWMNTKoiYOrOB1ANsVqllc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZxukqJ6; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZxukqJ6"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84a2dcede83so306308b3a.3
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 14:33:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786656809; cv=none;
        d=google.com; s=arc-20260327;
        b=dESEynhtd9iI6e1HXY/5/8TpBnwPsBoGjKb8EFk9wwc//thzG+aGcEYfpX9cTBfOZS
         l1ZGIgVJB51minJeMqnobo6uSsPBFuMK61GkHwbdIppR1TfwH5i+CorT7nI2i+nxn2ib
         cxSsQLPEyzB1OuceNkghGrMT9p9CG+2M5n/8Np5hHpNjtI/rhmO8g8/iN9O7x42b5J3l
         j1ZAk6i4RJ2TuYIGOuiA0ZfkGfzplWA7Sh1lDmapK0FXojLqtiHtwRT4XDL8biyasIX3
         z7pDfFiXS8P+tpWbhrX8SRcRlwKKtAW7AA9W/LQR/oYW/I4iendjpb3KMnRbR8/8kOpN
         s+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=thyqez2bNCrGLVqLYSLTcAnrKU3pB9eNIy2aMxPH7XI=;
        fh=fux1AmBW6yWcF3ppOeUAVGhjDUetJNpE5xxy9Z303M4=;
        b=qucz7u1HlZ+LaiZkIy6f6WQ+ZwRYgMWRu9SF941splv40hnAb2tzCvPNVeOcLZ4d6Q
         /Y9pC4M0yVSIcoCCBMFnwyPVC0zARDGEnaf3mZCmrzXRhDgwkFaGZ+himZD5T0y4hVVi
         sl5H1rQ7c5MmTjJB8/fJK14wNB/8hDBQXnq7QvSlQZBgqzPZm64g7AbROz4Wwzh1YwA5
         limVpS0ihjgCy9g3EMFZ/xXFnQ+5vKK/VRAH1huHBE/j8oAbNfsmxT3EXYaZ8wcW+iVD
         71c2t3DTaCD2BP+MkRenSmmuwaWuB+Hz3epoaiqa+7ntIXWrOT1xSREqb45QX05mdKjs
         qtqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786656809; x=1787261609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=thyqez2bNCrGLVqLYSLTcAnrKU3pB9eNIy2aMxPH7XI=;
        b=sZxukqJ6ipOgstOBmQ7C0Gld0e3RfPV6l65dnOu6F4XRfrZ70Tb7CfhkJ9tRc58NxV
         RkkbP8LIYu26M9UOa8p+2ZXw5CxdtG2L35+0hYdBH7JSLupEMd0ncXW9CrZ+2Bd3emwU
         aHq56HHzC5M9G93UyxuKXbD8TuZyHoxmYNq4ezfg+xEZfe2L2ZKXP7PoqJWoD1CikiwK
         HhTf2LvK/7PTBgMx4uvHfyWnYei9oUD8y8NA7Ldn5OroJdIgxfh7mkKd+RqYfFFDmEMY
         EvrZtqIWT7gxYb0WRfQa97nzcX4vSkmDjq6Vl56e04lMgulEVJMsVgHTSCHKNBGzlwHs
         pXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786656809; x=1787261609;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=thyqez2bNCrGLVqLYSLTcAnrKU3pB9eNIy2aMxPH7XI=;
        b=rWGXMbcloxmCb6fw7dntyFOb4h+3g+N9sIZLRTgHkC84xlcf3CufMODR8utyMHzPPv
         4QmQpIS55eLu3nKYUdQvFde+h7acEyzlzM2cFJFROb1J4ePxk5h8qnrAE1goqq41N9aW
         zXuW/hAWWJL9VnNfOB/ckFtSvQvprsI9h929v5vZFQIs9q7m2aQQwXAC7hyXzUbfTO5j
         dWM+DkEo9yDO3+JkTTEylKisdhOHCvt9VCXYo0wAAUmpErSx8hIKikodWNoGJrxsudcB
         JWGIuwH9/x6Yt3Uyv9ztxw8cOWyJh2oWWPjiQ1r69hFVru8o+JE6oOnxiKEA495kdmSD
         LYYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrikwi3x26WjYWReub/STFivA9W175XXGS0GzIg0LjFUlE1I0bRqmMa67hViOXtrwAYeno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJF8QAAuxRtivWvW27l/N0taf961Pn7t0smO/LQYZS1ZBYYuH/
	Y1TPTdidfwFeDmHzGxZ35jh6mnN7Ht9P3ZC15J1xvwmGf3WtQWIBqEEcVlxYoG67f7S8sDmjoqF
	MQ7z85lpvDZtUTfr7PlyMSIC4pM1s7RA=
X-Gm-Gg: AR+sD12LDbRIgRTv4rTrJrhRQWDrU3O/dLrXuJBX/ohPxaAK8hYDbx+da/+MqHquP3Q
	eXDbyWDNE2EcFVpHqrjpzSX/LzG+RmV88KqyoDzVedilZV6ZDhYRh2mAqAJotRAHIqU3xrE7psj
	5RTNUQFvRul8xMku5LRK7jxiZMScr34yIJans7nPd+hJoeZSSP08Dl5REo9ehbKjt95BzySSwEx
	pTHhYPG+sNJ6VDmvHh+c523iuR/InaOc/pWelJ4Qz3xjPYjYncOOjP16WLryJAU0DUtgNaykA90
	4yp3MEAUkkH8Wu/i681NIM+2qTKSamnCG0/0F8yorWPyVlFaQihv7O9t2RHD+zX980aV2qb9ib+
	yglmXNQZRDl40DVFpQl+08pqYJAjZUPa+Ism9MyPXoFkkJZRy9+WLBw==
X-Received: by 2002:a05:6a21:3511:b0:3c3:b57b:6285 with SMTP id
 adf61e73a8af0-3cc71a2c74emr991433637.13.1786656808918; Thu, 13 Aug 2026
 14:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806130214.66028-1-i.tellez@btesa.com>
In-Reply-To: <20260806130214.66028-1-i.tellez@btesa.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 13 Aug 2026 14:33:14 -0700
X-Gm-Features: AUfX_mz0OadMGfWZZPCIsVcZiMBgRON0WlwFQ48aWof4h8vcUMOfzy_P9bF-D8k
Message-ID: <CAEf4BzaPMurhZTo-bxTvXoiSU9Q4JXGFWNefO5nnT4Kxu3ju5g@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix pending_pos walk on 32-bit ring position wrap
To: =?UTF-8?Q?Israel_T=C3=A9llez_Garc=C3=ADa?= <i.tellez@btesa.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 6:02=E2=80=AFAM Israel T=C3=A9llez Garc=C3=ADa <i.te=
llez@btesa.com> wrote:
>
> The reservation path caches the position of the oldest not-yet-committed
> record in rb->pending_pos and advances it past already committed records
> on every reservation:
>
>         while (pend_pos < prod_pos) {
>
> consumer_pos, producer_pos and pending_pos are unsigned long, i.e.
> 32-bit on 32-bit architectures, and Documentation/bpf/ringbuf.rst states
> that these counters may wrap around there. Every other comparison in the
> file is written as a difference, so modular arithmetic keeps them
> correct across the wrap. This one is an ordering comparison, and it is
> not wrap-safe.
>
> Once producer_pos wraps past 2^32, prod_pos is small while pend_pos
> still holds its pre-wrap value, so the loop condition is false and
> pending_pos is never advanced again. Reservations keep succeeding for a
> while, because bpf_ringbuf_has_space() uses differences, but
> new_prod_pos - pend_pos grows as the producer advances, and once it
> exceeds rb->mask every subsequent __bpf_ringbuf_reserve() call fails:
> the kernel believes a pending record spans the whole buffer. The ring
> never recovers, bpf_ringbuf_output() drops every event from then on, and
> nothing is logged.
>
> Observed on four armv7 devices (i.MX7 Dual, 6.6.52) running a
> tracepoint-based collector with a 512 KiB ring and 160-byte records.
> Every one of them stopped delivering after exactly 26846821 records and
> 4295491360 bytes had passed through the ring, at event rates between 441
> and 862 records/s, that is after 8 h to 17 h of uptime: the trigger is
> the byte count, not time or load. That figure is 2^32 plus 524064 bytes,
> and the excess is one ring's worth of grace period, as expected while
> new_prod_pos - pend_pos is still below rb->mask. The last reservation
> that fits is the largest record boundary X with X + 160 <=3D 524287, and
> since 2^32 mod 160 =3D 96 the boundaries after the wrap sit at
> X =3D 64 (mod 160), giving X =3D 524064. Userspace kept consuming normall=
y
> until the producer stopped, then read zero records for good. With this
> patch applied, one of the four devices took 10 GiB through the same ring
> with no stall, while the three unpatched ones kept wedging at the same
> byte count.
>
> 64-bit hosts are unaffected in practice: their counters would need
> 16 EiB to wrap.
>
> Compare the two positions as a signed difference, which is wrap-safe
> here: the real distance between pend_pos and prod_pos is bounded by the
> ring size, far below the point where the sign would become ambiguous.
>
> Fixes: cfa1a2329a69 ("bpf: Fix overrunning reservations in ringbuf")
> Signed-off-by: Israel T=C3=A9llez Garc=C3=ADa <i.tellez@btesa.com>
> ---
>  kernel/bpf/ringbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 35ae64ade36b..2c08a98370d5 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -482,7 +482,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf=
 *rb, u64 size)
>         prod_pos =3D rb->producer_pos;
>         new_prod_pos =3D prod_pos + len;
>
> -       while (pend_pos < prod_pos) {
> +       while ((long)(prod_pos - pend_pos) > 0) {

prod_pos should logically always be greater or equal to pend_pos, so
there is no need for casting here, please drop (long) part. See
sashiko's reply also, maybe you can try addressing other similar
issues that would bite you on 32-bit architectures.

pw-bot: cr

>                 hdr =3D (void *)rb->data + (pend_pos & rb->mask);
>                 hdr_len =3D READ_ONCE(hdr->len);
>                 if (hdr_len & BPF_RINGBUF_BUSY_BIT)
> --
> 2.43.0
>
