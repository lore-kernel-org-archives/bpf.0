Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B940DFCE
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776607457; cv=pass; b=A0Ii1QY9jW9M76NsKCRw5BEEYF1+bHIb17jd+kkaw8yBOEC/6Z1tTd/ZPykhv6qj2k0QPTilk2TKDX+9N+2hVPV4Xwgvrah/eXJNYfE0REaJE7TRHsb0322+pNLwf1nSYHw/MyI+osFs3sxWeCtQVXCGk3HbY8EuB7d+5lPcMWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776607457; c=relaxed/simple;
	bh=2RVo/RSCifhEzKkJZ9yxsZn/G5E0iUqkOdyqNiEFN24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiT10cv4ARldPhDybXIqk/RxCiWFDyYfcjIzh6gRLmJiTmVsrmCcJbn+HcCx1nWsMFlr0oV05XXFgfWUV/bFw2uzAMa+6EV9ZMrFxLPCpROH+MoELOMyf0NGX1gHfmhHEsnnNQFF2lx1AVO5rOnxM3deBoMS2SJXcxTU1zAscfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbZjSrBZ; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbZjSrBZ"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a40502e63bso2144800e87.0
        for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 07:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776607454; cv=none;
        d=google.com; s=arc-20240605;
        b=Nny5SfQNG+aW69Gaw6gyIBBuNHLxeN44nyYAOyBAJhn+t3ZEilSbiSa7WTZ+csKpaQ
         YcnvZFvlLGDboTaFoFthAXjaHNfmfgLTeK5umWSofGVNI/ZJF6GUc2k713GBLRkfolRf
         70hXF/3+a6qkU0oYyplKagN0jJuJDIWj21UoLlpEAUAXw9vAq50gjppBnwh8RWWwxUJ2
         3mL+n6JJRJtE6tDK1kpMRA+Y5OaU1eip45jjjYgTNCNagbL1zplhFmREv/Yj0uwMzZ/M
         uabU97HkCSg68cF+OKwP/LojsXuvjkxen0eyTi6Kob5pg3znij64klPI5bC3WgHNj8Jh
         T7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e12Eq09G32hg7N3z+criCjnBR6FQ2NhhxFDm3/Q78Ts=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=VO+gDYtH4TcUYOYOVdgAX5Bo6uSUiN5C7NzH2SWqWesSfJxL49YzaVTd3VWgQGsuhY
         pu0hb1+UN2/YQ7OYTOUgyqUtwEmB88KuBk+Rv/qTht7+EAM9KO4IeupSyICgGBi88w2v
         96ltmCHj0XjUSBWZMQrlVE2VfMgMZJbEsBfr0+5h/bA6gLiNeU5JiobFJlgzAth/G6ZY
         JlowP2XVk2+vWIbIOoQRyIBzvPORWwBHZhpAGpkANegGNNyAGLCI5CtNaz52J0jpGvPe
         mhfz4KWxDDyymo3sUjIhYQPzoBpGXZ9zIfDQB5s7VWPurP1ebwJ2SkVtsoM2yUWYFTaL
         TLcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776607454; x=1777212254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e12Eq09G32hg7N3z+criCjnBR6FQ2NhhxFDm3/Q78Ts=;
        b=WbZjSrBZdwb/qUoHqtKbqCHmOXZFJyqSGP1gxTVHWQfG1xzj2wTMyZeQ2FOXK5/IGi
         rZbELyFg8zjI8VaPMBH6nS6dMDMy2zBihaSqXNuJDHltAxsGNa+CKXcsr09YJHJGzLm3
         ok+y52rT7WEdmXfmhnUZcM6IURZDvsQ/gVzNG0tgg3w11bvdrf+qC5E6Wkx8Bw6+n7fl
         YPP9IgZ1J8N5ESopNXopW+4M1h452GOlg6+Jegi1BLBj31Y/LGlGawq2hbZUxfPOv3A6
         SZl0LNAf/mTKHg5gph4eJr6KCITGQjYkrNw/znE0C/EbtYeZ7KHtCVohil6G8vR1/NK1
         ZiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776607454; x=1777212254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e12Eq09G32hg7N3z+criCjnBR6FQ2NhhxFDm3/Q78Ts=;
        b=UhLY3UihyqCQuaeqXZod+0GqCIEsfKQjP6JeYVfGst4VWofK8pXPY/ssp9QM2LWGzL
         J9+pjV/386zOCmkWmQnK0spFOBpHAYjejWdjMnbfd9/nimCiv0Y6G/DdOabXl7IyJxni
         yKjAbUTFl8XOk44JX972fKyFZDaj3FZMjB8nob8AQUjGBpD4aavy7NO4zMkqSRkgxkKE
         Aa6w03S7MLf7vvHdR8rgw2i3US/gK3VrBFy61qavq2D/pO8P2QkkvYh/fV870K3N4gwL
         RmdphIbDhae3Yj9N9SXRB1aSepvqCZP5QFbX4thg94VgnvI5k9bNBM9lKB3IhJt8sUz0
         nSng==
X-Gm-Message-State: AOJu0Yx+JGhnw+hkOw/PDeX6zHDv+vULBoNYmLVljwAczitI3LV9aU4t
	kuSzRLYptYdmmagCHd1tDrsUs3pF/E/O+w5dQc4sm3oD5GyU4qrsZoZ3crE1iztFNodeZo05f2c
	yyZrVlVirkE6zLAebacHhTPx3npTxUk3xdIFxtwrNdg==
X-Gm-Gg: AeBDieus277ct22vRzNF3v7Uw3rJb2byyzsT/TcsRQETDMW4hZ6PBicAYfBd7ftyiJV
	pbb+WUkm5Dsd5yJglgVwtTuzSmuAUz1gH9utfmTRe4waZCsv+pGvBpazCkr+UobXv+z5/lDkNRW
	ugAuSUYBh/BnMDL+YuuIITzxNmhNCaJvLKOt9+7+c7OyRy9/XrllMFNI88eTT0je4OJcmM+Kr3n
	3mnQVwZLsfsBxJEjZpZ8xJ0EzA7tj6Fdd78qOShHx/XZvPG4uS3qMMBpYeex3shJ7/SWmN89lnt
	5pfdFY4sBAH1OXEVlA==
X-Received: by 2002:a05:6512:6c7:b0:5a2:c766:13bb with SMTP id
 2adb3069b0e04-5a4172cc01dmr3026692e87.18.1776607453929; Sun, 19 Apr 2026
 07:04:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418045644.28612-3-kerneljasonxing@gmail.com> <20260419045823.417A4C2BCB8@smtp.kernel.org>
In-Reply-To: <20260419045823.417A4C2BCB8@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 19 Apr 2026 22:03:36 +0800
X-Gm-Features: AQROBzBk6dZxLwBITTzv6ntf1Ghy5u3GgL7dt6A_-e7BFhx940vQ0MvI_eYTV7o
Message-ID: <CAL+tcoD-Vx=93myozGvuCz8J9DTz0Byb9wX_mSvtFD3q-zDxUw@mail.gmail.com>
Subject: Re: [PATCH net 2/4] xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 12:58=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 2 potential issue(s):
> - [High] The patch leaves a guaranteed NULL pointer dereference in the ca=
ller's error handling path when `-EOVERFLOW` is returned for the first frag=
ment.
> - [High] Calling `kfree_skb(skb)` directly triggers the packet destructor=
 and incorrectly submits the dropped packet to the userspace Completion Que=
ue (CQ).
> --
>
> commit e5bfaac263557abd44f47ec6e9c85e50c7aa1efc
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
>     xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
>
> This commit explicitly frees the skb when the MAX_SKB_FRAGS limit is hit
> on the first descriptor to avoid a memory leak.
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 5b273bcd0dbce..3d6c6caa7ff82 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -858,8 +858,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(stru=
ct xdp_sock *xs,
> >       addr =3D buffer - pool->addrs;
> >
> >       for (copied =3D 0, i =3D skb_shinfo(skb)->nr_frags; copied < len;=
 i++) {
> > -             if (unlikely(i >=3D MAX_SKB_FRAGS))
> > +             if (unlikely(i >=3D MAX_SKB_FRAGS)) {
> > +                     if (!xs->skb)
> > +                             kfree_skb(skb);
>
> If we free the newly allocated skb here and return -EOVERFLOW, the caller
> xsk_build_skb() catches the error and jumps to free_err, where it calls:
>
>     if (err =3D=3D -EOVERFLOW) {
>         /* Drop the packet */
>         xsk_inc_num_desc(xs->skb);
>
> Since xs->skb is still NULL, will this cause xsk_inc_num_desc() to
> dereference a NULL pointer?
>
> Note that this regression appears to be fixed in a later commit 1c728000f=
884c
> ("xsk: handle NULL dereference of the skb without frags issue").

As you noticed, it was already fixed by patch 3.

>
> Additionally, does calling kfree_skb(skb) here trigger the packet destruc=
tor
> and incorrectly submit the dropped packet to the userspace completion que=
ue?
>
> Prior to entering the fragmentation loop, xsk_skb_init_misc() sets the
> destructor to xsk_destruct_skb(). When kfree_skb(skb) is called, it invok=
es
> this destructor, which sequentially calls xsk_cq_submit_addr_locked().
>
> This writes the descriptor address to the completion queue and advances t=
he
> user-visible q->ring->producer pointer, falsely notifying userspace of a
> successful transmission.
>
> The caller xsk_build_skb() then executes its own error handling, calling
> xsk_cq_cancel_locked(), which only decrements the kernel's internal
> q->cached_prod counter.
>
> Could this desynchronize the internal queue tracking variables from the
> shared memory ring pointers?
>
> Should the destructor be changed back to sock_wfree before freeing it,
> similar to how xsk_consume_skb() handles it?

Right, it's the same (pre-existing) bug as pointed out in patch 1.

Thanks,
Jason

>
> >                       return ERR_PTR(-EOVERFLOW);
> > +             }
> > [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418045644.28=
612-1-kerneljasonxing@gmail.com?part=3D2
