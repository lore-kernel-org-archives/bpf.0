Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD135B125
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 20:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739572; cv=pass; b=TTlDEFO7sP2dnSo1bLK45734QXQgoZn1TjIXdPMwfVFkvAksJKk6yDOFec37L6SI7gRDPac7NSxyWDYrwF8wnzeHSJyBX8FVPpBq7c3v0hRov8OIJAstFijGjqvQH6sMpoCvxA/N6oRB+WhVw2zj7NP+D3xBHm6d1aGJ507BHmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739572; c=relaxed/simple;
	bh=5auGWzuy3H74mXm3K/cxbQ35Wk+k637VrdgTw99cmXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jt2/vAtwpJqTrDljg2UlSnv8rG+HHPy88ZRWH8+8NEGWmZdRtMQKTjzq4tGpyFtXPOgH2esIvd+2LRRqGvxy4nf1avOfsf4kjvjOKrUQDgMfADHGKfGPKoej9/OD3KfmG+uMx+At3XH7+PbGPGzn6b8fdLIdaArUab7b8XMcHnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AU6KhZSa; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AU6KhZSa"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso1020619b3a.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 13:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786739571; cv=none;
        d=google.com; s=arc-20260327;
        b=QuvkA/WI3ev2rWEL4oA0vbnUsRU/Gh44zcjcc8UUlYBPAHlhBRZ65o56xdvT1+Ajyr
         0v2bsaDJl5aMugZJ8oszNp5TuwaUPyTQxEnCazOH8Y4zOe2C6nBYESJ+YplkuIPcrXuP
         gB/quwTdz7tEODzXUjCZUqbGiKcIanCpB7ds7o7fZoW0Uq/rYjMmhh8O1GDItR/vol3q
         LR8l1x2LfVa7jqa2XqCdIJWbVBgoaW5tXMIq7MEU7g2d2/SSRQLxwi6xI6Fs4EBCLgtK
         wWstmvhlnp+yxmS9fsRgG10sjcM7ygu5fBAJbEeX/PiLA18/G5oMsgzKX8Qrp8FI6Tvs
         C7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mqvFprfHSRhKgldEIyrM1DXPu8/aXrHT7U/ON/4vjG4=;
        fh=Jhc8qUS82ewjnmR5J6GoQBwkTnL2S38bZDTss0mnObU=;
        b=lviqQBJ+1YuMBSnr224NKOivLrF9vdz7TGzP7kdnblKbb0a7ETxq48js2p5bZcfqTM
         E9b7svwLKmMZbHYWY8H21tPZUmcFxyhiwwy3jCA3Yd+xmB+QspzNsnovp4BF0hqvst4R
         NzS4KzFi/icYMi1cqGbhmo/OuqDuMbHWwGO86o9IVUfXJVS+Cto4UE27zzMfaiGWrTlA
         Kw+0q5TCeRcts9cBcE641JL9jVw4CFIRJit5UwcMWsLURQrPEkjbZjVn5TuKZaP9Ojsb
         c6bgWoY/y8W2nQw+vOi0N7V7xwA1fswMo4cJmUSTnQZG30NoxlB19sbFRY0ZtF2fWfi8
         HhEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786739571; x=1787344371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mqvFprfHSRhKgldEIyrM1DXPu8/aXrHT7U/ON/4vjG4=;
        b=AU6KhZSa+xEQ5mtj0yJQkqNkcqspmTovQ/qjNqQHsf3eXSAxmwT+qdaDZL3uDkL5u6
         IpLQRBUwf6GjQ/Kfof5CJy6Pz71+t2mE5Yva6hJO5TS8DnBbuGG6C/H/r5UBeXUGhCwa
         SOgbQhKGShNZohY3uVP6I29N3nhLf8fHVP0Jc/aZ15kYSDsCAltfGYMlo4mtE4FyUz1T
         Bcomkz8JAvkRsn8V3BkbzsBE8utVJ9bmQ9MDn8UxaNqpqCLX0dusorVdVZ5Q3EbFQish
         Qy7AIHvx62nwlkLEXHmBI12nCTCXB/KobgjNcGswWc4kdGXZMsCZAMn48jvptH7tl8T/
         kS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786739571; x=1787344371;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mqvFprfHSRhKgldEIyrM1DXPu8/aXrHT7U/ON/4vjG4=;
        b=oXwwpjyI0rH05u5or36Fre5E+0HucgBC1/zsPH9+MUzubHNPefoY7wUlIxTvHT8c3t
         goCkRbJu2Dj9qatF+xqGg2MZtUpInwOtletvOD6M5mbe5OszQoU3soLWmiWf4DXbhnxY
         AF9Qp1deBBUO8ywzxRrRqot3s61tf6MysFIbGbNt80Ipv4nlBT25+6jPTxeXXt+NCN/+
         /eHi/ErmKUYdeq4hOrwuK3usqAekWk6tneClNudtdhpP27ZAFs199+5bKb2SHLZqMCgi
         iopBJWtAYHZ3BtUOR8612jelovkVDXhN1Ial/kJTrytaMlcG8OoA63Rq+7sFsmlyapCA
         PbSw==
X-Gm-Message-State: AOJu0YyjN4BhA3Z5xal2cAe1B1r2K8aTgkryRsj86kj00PGTI9wqR5XW
	QFXFM3HXVlXHVlFjcueQF40UkoslhvbG+G8bMWMLGtW370/OupCCSYe4M1oZaQ/GCpjs/gG0sT5
	TKOALwKLAax6XOhCSwLg5dfBIb9d0nQ+pVw==
X-Gm-Gg: AR+sD10l3RwCR+xkTQBu8saIQJRt8eQrjbVj8aCcP6KOCZBY9pSk9+aMvaIyhckR4vy
	M2/NHIjfRgDpIoYnXr1O0/Xy2TI5eBgQWeo0p915GQJwyGWxJY04QQg8hM0gEcq2OMXgz7Pj2yb
	K0w121ptXDR8QlNH+E+jmwX5HrfVCeDDwwFVZ/0e+XKx+1DrhZqOeIIznMnO3kg4hEk7pn8iibo
	aC8bpbKbjPNmo1rtqUmuC3uaPoGfSdiM8VFye40YbSZcSA8WG0vZZWuV69bLlzK+9NcfJYLVimq
	RZ26tjtZpY6p+KsE6IY5JbMZnTjDpNzCpxLzRYH53inLCf4EzJ8Juv+YC0Q5t9CFhKgRSHfMkjM
	Rl1Ojsd/9m93R11oZWjqWCX4wag==
X-Received: by 2002:a05:6a00:a21b:b0:848:417a:d1a6 with SMTP id
 d2e1a72fcca58-84fddfec0e9mr9121060b3a.15.1786739570651; Fri, 14 Aug 2026
 13:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814173206.93082-1-leon.hwang@linux.dev> <20260814173206.93082-4-leon.hwang@linux.dev>
In-Reply-To: <20260814173206.93082-4-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 14 Aug 2026 13:32:38 -0700
X-Gm-Features: AUfX_mxFBcL9JIQ3h-wVS6FoHUfCG6SKj77DXXw_Yp0V8tjDPaYTtOnuqLNlwD8
Message-ID: <CAEf4BzajJQobFoSUE9JxyieKupF5_j7q3jxWMHC8ZqAUcHY0yw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] bpftool: Update comments about skel data maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 10:32=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> Since is_skel_data() includes the non-memory-mapped percpu_array map, the
> "memory-mapped maps" in comments are incorrect for percpu data.
>
> Update "memory-mapped internal maps" to "skel data maps" for better
> explanation.

What is a "skel data map"? "memory-mapped internal map" is fine as is,
leave it be


>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/bpf/bpftool/gen.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index a50540ef6521..e5e82255af24 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -303,7 +303,7 @@ static int codegen_datasecs(struct bpf_object *obj, c=
onst char *obj_name)
>                 return -errno;
>
>         bpf_object__for_each_map(map, obj) {
> -               /* only generate definitions for memory-mapped internal m=
aps */
> +               /* only generate definitions for skel data maps */
>                 if (!is_skel_data(map, map_ident, sizeof(map_ident)))
>                         continue;
>
> @@ -510,7 +510,7 @@ static size_t bpf_map_mmap_sz(const struct bpf_map *m=
ap)
>         return map_sz;
>  }
>
> -/* Emit type size asserts for all top-level fields in memory-mapped inte=
rnal maps. */
> +/* Emit type size asserts for all top-level fields in skel data maps. */
>  static void codegen_asserts(struct bpf_object *obj, const char *obj_name=
)
>  {
>         struct btf *btf =3D bpf_object__btf(obj);
> --
> 2.55.0
>
