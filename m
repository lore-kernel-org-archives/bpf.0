Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B09222D792
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746034; cv=pass; b=HWPSriuPmuezq42nBQAmGrdu87j1jAt8GIKpZ9S2Oh7SoYDnrjv85POT7Ij2nIs6dPPcEXmp22jHJTMW5lakuHbxwh4xPn56R9y73j+NIJRCR82T1tjMZ1L2vC/tsJ2+KpQeWpw5jzuSoWAFJ+2/0ESNvO0FW/Y81r5clRjsG1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746034; c=relaxed/simple;
	bh=6xM1ai1rrpeWuURVZz+0Y17lmw4N6mUw8g9CtDM7vew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmH+5GbUuSU01qOpj/JN5FhgqFO8kU/FSfHEylD9rnNNZA6xiTuaU4g3Zb961PL+INuYEKm7+OFG8JXApplYjgGrfqNpz02R/cAuMiUjXWOZhJVmGh/wvmAyg0y9PzrytkniV1bppwAdCI/CqalE/xjErW7B12BM3N9/QaGPvxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hE59ABoK; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hE59ABoK"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbedf6a6fe8so1076517a12.3
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 15:20:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786746033; cv=none;
        d=google.com; s=arc-20260327;
        b=sMXN580KHrlORg04EH0vePuiNsdx6bWFlE8a8AwA6cmiPI4WcumTFxOdJaGqxIsESD
         DWE7VBHSoMJTy+mNSLUzVwpIgygyiwjklC31vS+JNnZjfacrZJ1XCx5T3mseFGGxV2SL
         awoEf9SF5pKKrW+JBJ+FDUDaQlwuXLfEp0VIGB9W4xJjBl49sW4LyaOAu8H5o91i/3Cs
         ElHVBJITVeZ7D426iQcQnu3BbF2P6Ewe2XNmwAvvIQBdcK4Zm8MMEe2yPue1X1G3HQ1E
         4xG74udLAUo6Qap7XE1gQWkbjFAoHUFX4geEcE9XSBqVPu4LdVrLCYmOpUePnzIAP41n
         peMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5adhcsDYcahnxZi84WaSXe7GaNlj/GfGsk4553OgP1g=;
        fh=/VRpRzfotxltwQGihNl+rPZqo4nmkTmZ+jgvBo3HXi4=;
        b=oUKqI0O0TtCDb+5G3Z4esUeSzATgTMkcrzxvsvSkGKqVc68Hc7e1oUx10d8BFzUYyk
         XBKiDE3oTDQ/ViijqD6VwEDBO5U8+qX6HrgxXMpDsgwXbmrTZfwfPcuVSyXJIF/ksLwp
         ZC8l1fubgVXcLHf5HTRrVeI3oEff7N73MhqO7KT5dhLCpsQ7CHC953oNzajvRr3r+maK
         OiN9cgShj0fZAdouhcd3SgaglDIYfVKoiwcA9p+V+apSfX0UP0c7V8Vr6ZID61Mh7OV+
         ePLiXm0EkPxtdT/w6i560tArkwACydxxunZB4sZ9ElWYU2DKJReTaA9WuExs1PrkQxwr
         Rc4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786746033; x=1787350833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5adhcsDYcahnxZi84WaSXe7GaNlj/GfGsk4553OgP1g=;
        b=hE59ABoKTbEH4tAs7G6MnZaOlBURKbF8NHRSaYiG7iL92ibf36FxjMNo5eQiwaWeDE
         wCDIjIKOyo15NbXOHcCV9j+cF55k1oWpBTtbUF6na87EZy1xpxvJl7crpYvF64TGLTma
         xw2OaMPOnNLO/8nMoakShmKQc2SRzxFHLo3vx6Z2w9OO1MaseX9uLyPeC9A/Kh8ktpGG
         +vehcmjRGFxbNNX9HohLNf3jfjag9w1tv9++hsLW1KNiUmhoVE0jcQQT7NEkjTo9T/LD
         x1QZ8tpdB28dyJZ0ZS6IS0md/mAyeNG2DiYFrke/CgcUcbXObAX03fEypLq1oYw7EW8V
         yvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786746033; x=1787350833;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5adhcsDYcahnxZi84WaSXe7GaNlj/GfGsk4553OgP1g=;
        b=l5/55J6xicOVIm2P108dpstjBYeX/+VBZ4moipLXCSC0qY2vjC07BtH588ubD3ruES
         iKEWgKpx8ezl/DucO5SODfYIOaWrqGgPG/aAEqX/dXI/5Byw8/7mWqqqEhrtG9jEQRDw
         7+KRWlKKVEiAUEOSgZzt9HII/aoXfuZnwzCU80nVS44EwcXs3M5oPwQPx/I7B+TZ0yHt
         49WtqL2Ndc3suBkH2hdjeoNx0/QWhMFod3JWIvTbgQFkFjhdajoRQo4Y6ZUVzZVlfMHc
         wW9SWpibo051z6K0btiIYPooENeTOrGOynhUW3Pm9CZgurcPOzL4J5was+ABsqjcr+kR
         vZmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+X3GgMpQKqO4biMHsIiGf6YaTiJWnPebIH5hUGm6eXVV2RF2h2gCZwQkQYNjvI1Aq86E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr5vHh3yW3Lu4GrktmEVTJXRNdio6bgy3rE3pvCzIF89p6TEH0
	/3LAF9E5GxX7pAgcgOrsGIcW506LyyQOxtKYPeZ1WdoawDIxhQdJ+ckxDKThQ50XdjZ+0fWb1WZ
	E/SDwI8wztEGKt2NvLLtPZBx2OrJGXpA=
X-Gm-Gg: AR+sD11zW+e7vd3pOdUmPkOnrd+wUbimNgrC5NwV8PBDxpTb6trj64LOUBhRcnxxSAD
	a6z8NyWSjkgU538f/+hQ5V64Bi80geKG/adEMo97ll6vPoqV2wlAIq9Lwzd1Xp6R6IUWsrjFadL
	9hP70GxZeBbcGbhRtSNv3jgFs4uI/PInDxHzWc4zj9Il86vA5N/YoTqQ2qtO8Si4JXZedPrIgY7
	bCIfLjByoTnowp9cd5wrmhaYXVeLPsrETSEHObRB14R2LAAT1/hOIQJNG2X0FHVTqIDwy6Vr2Ez
	0QNQBVHdG3v3thO7x10VQ0ZLZSwoXRmEA7KhGfwvCasJ0LB4NGKUeBHy1BEqoJWWyVcWN8dcUGj
	LH9PDJveSXSbjVKCxbMUWivLFmg==
X-Received: by 2002:a05:6a20:5483:b0:3bd:187e:2de with SMTP id
 adf61e73a8af0-3cc71f167c6mr10570426637.25.1786746032892; Fri, 14 Aug 2026
 15:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814124843.22041-1-i.tellez@btesa.com> <20260814124843.22041-4-i.tellez@btesa.com>
In-Reply-To: <20260814124843.22041-4-i.tellez@btesa.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 14 Aug 2026 15:20:17 -0700
X-Gm-Features: AUfX_myp4b7aWslulf4MYxiCJ6kMsL0Y7DfkXEQT9u7nmslzA4TkLl2wgG66tdI
Message-ID: <CAEf4BzZEuq+nA-NxEryPiXN1Qf-duNgnYwxMdpFUPprLTq98HQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 3/4] bpf: Read producer_pos before overwrite_pos in ringbuf_avail_data_sz()
To: =?UTF-8?Q?Israel_T=C3=A9llez_Garc=C3=ADa?= <i.tellez@btesa.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Bing-Jhong Billy Jheng <billy@starlabs.sg>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 5:49=E2=80=AFAM Israel T=C3=A9llez Garc=C3=ADa <i.t=
ellez@btesa.com> wrote:
>
> The producer documents the order the consumer has to use, in
> __bpf_ringbuf_reserve():
>
>          * smp_store_release(&rb->producer_pos, new_prod_pos) at
>          * the end of the function ensures that when consumer sees
>          * the updated rb->producer_pos, it always sees the updated
>          * rb->overwrite_pos, so when consumer reads overwrite_pos
>          * after smp_load_acquire(r->producer_pos), the overwrite_pos
>          * will always be valid.
>
> ringbuf_avail_data_sz() reads them the other way round, so the acquire
> load of producer_pos no longer orders the load of overwrite_pos. Nothing
> then prevents the pair from being observed as a stale overwrite_pos next
> to an already advanced producer_pos, which overstates the amount of
> available data by however far the producer moved in between.
>
> Swap the two loads so the documented contract holds, and say why in a
> comment.
>
> Signed-off-by: Israel T=C3=A9llez Garc=C3=ADa <i.tellez@btesa.com>
> ---
>  kernel/bpf/ringbuf.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 0fefa89039be..89a9c15a260f 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -319,8 +319,14 @@ static unsigned long ringbuf_avail_data_sz(struct bp=
f_ringbuf *rb)
>         cons_pos =3D smp_load_acquire(&rb->consumer_pos);
>
>         if (unlikely(rb->overwrite_mode)) {
> -               over_pos =3D smp_load_acquire(&rb->overwrite_pos);
> +               /*
> +                * Read producer_pos first: its release store in
> +                * __bpf_ringbuf_reserve() is what publishes the matching
> +                * overwrite_pos.
> +                */
>                 prod_pos =3D smp_load_acquire(&rb->producer_pos);
> +               /* Ordered after the acquire load above, per that contrac=
t. */
> +               over_pos =3D smp_load_acquire(&rb->overwrite_pos);
>                 return min(prod_pos - cons_pos, prod_pos - over_pos);

by reading over_pos after prod_pos, we can see over_pos logically
after prod_pos, which will lead to bogus result. With existing
ordering we at most will report stale amount of data, which is much
more benign. I'm dropping this change


>         } else {
>                 prod_pos =3D smp_load_acquire(&rb->producer_pos);
> --
> 2.39.5
>
