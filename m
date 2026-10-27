Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793138878;
	b=mXL6aFjHllA4SdKPRHjdc69Df5uM+MjjPkfEe5CnnWiUIBP7ylsc1znrxb7OGOYWUlXX
	 54iXn4ncvrDyZkpTzYFbthjJ4sP0hT3Bowdr9NZaTiqbNGFcg3SZRECXOx6wDtMNVk52m
	 oPzquNuVs9/c/8Rbvt3m9hqBLyW6X51U8ztrg+sHTkWp9tfmaymkQtRsfezsuPO8Ws9VW
	 F8QZJ9LRehd2WVhpvNrLUYbgsu43QJOE3jGgXUy43sKkHgKpG9vHQorUaCx0aUDvAl0N/
	 ZFI/zHtdwjcL9pZC+HWdM8fLv/rqc8VvDeDPWdHXWskPJFJh4Bs2h2N2ZYEgqscCXBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ca2YyfdF81F97G9Km6YN3E8m5/e8rC9hjJrfVgW4DSM=;
	b=bIPJE3p8qRAfkrKCP51VHHLdf8lttjZCGQ4q/URBZ5c8/rAvklaLSDTy/uPpGW7SS5lC
	 m/Ml/d//XzHHEXEbc98I6cr3OWPtc1upVS8cavNApsKgLuclpphUErvHMVzv4OLm1lfDo
	 nbFDZLkJNYLXaXx4WJwR5gJg47Q5H0UdMVaQoiW1SyE/1ilTFiU8hNA6h9gS3t1uJQoQQ
	 QucJNszyZju16t1i8IYT5CnfVJnotSOPlM/rfjb+v5IhSKUDaif6aqfjs1vw1Oy/XBogy
	 OQX1lkfXfs0XypZPEbgiOvtkNp1gR/zgm3tOXutjHNg+xmEz8fikVw6zXKSdHCDz95Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JndHwKJi;
	arc=fail smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C00606A31F
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 22:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2C00606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JndHwKJi
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c46bd7a7345so62470166b.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 15:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793138876; cv=none;
        d=google.com; s=arc-20260327;
        b=BWhAwa0Svgop1rXWMdvFRiYyyVRQt3WZ6kDbfxNIMrvjrhsFf9j/7bZeT4aSDnlK6W
         311G2jmu9HI7ahf7Ir3SP4GY8ybrfY5j/3YpXqIKOPWQRgMZwbx/YgtNcVJAKkdVHnMx
         u7TIvLGuVivg0aXOuPBG/IvrCSwvNHqj8n2YJzmE+zJlqIyr9yVWzDYZAU+3nJfbzOxn
         Qpa/oUg9uhGgDvvK5ahNIiNP0spDzDShuRHGDS5Odl+gp1gN59o3q684Znb1IOdMcugg
         0aPqjLdYOe1CN+JxWWVJY9eSCmDwKwtv0zo6+e0jfAMqlrBvY80L0d/k/nVia1hOb7hx
         wsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ca2YyfdF81F97G9Km6YN3E8m5/e8rC9hjJrfVgW4DSM=;
        fh=BPWyh8xhxBlVCppdtUUh5pK1n7CdKwhrUtuc2q8fz64=;
        b=nQvcfCA+xqxgHcPC+wyfThTYDBoKgLCEHDhMP9TLC/KB/2qd1HO0KY850wh9ZxNEoU
         e0H12vM+tJyPX5TdW6dSfFzi8AYIhZGwvRfkOsD4KLTxOcLTbTmg0afOmKR7SszPWYAX
         QmGd92bhX9EVrqzhJDxGCtMKb1RGWMSaI43yvZrEhq/ox+weXmigjDe3ymSlxSyvt/L9
         Q38jrTNCKStbuRPFFSl2teWHIDdbxra7MvlAvaXll5VUckAWAShhC/Gx9jv3sYqob054
         Cv7vygPhWVTzKie3h4wJXbRckvrDhA4zCw1AggvS8OOAM6emBMip0Zxb8c59vu4U3j1E
         LS1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793138876; x=1793743676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ca2YyfdF81F97G9Km6YN3E8m5/e8rC9hjJrfVgW4DSM=;
        b=JndHwKJiqoQdimfnFC/tOH0NOP9CxQKxSiHFIN7R0ytrfsF1otC25j8OT21ypOBaw0
         SeH274c5gs94bjO0YMSWpQNXnGDmaTecGn12SItZKlKn2t20O71XSnnuJyjslHTVxzrE
         aAuZ1VDMdN0s8JEith1PGtfJvP5bQ3t6fw0A06t14GU6kC17bHFf55OjmQW375eIxizr
         i2JTJ5g1ClaP/isCuqEeFHpCWCC9L8W2JDWntColXyJVJbpXJhsN0FnMsx/BvsZ43C79
         9prCEcfErHTtXqtmR20XD7L0Eg4tfpbIY/LNsw94YqE/9dDt2m4t1kDcuTu9qRDguQ/g
         fS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793138876; x=1793743676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ca2YyfdF81F97G9Km6YN3E8m5/e8rC9hjJrfVgW4DSM=;
        b=IvmNth0i4xSD+6HV1aJRiBFVWqs0BoNTbXDym7x+T77elgCHO20L/mwXGtI0GUmyOQ
         Bk1V0zwmGEaYmqrQKSI+qxl9oNWqnUr5PBe6cFW9fWqGfLfIzOUeIQLaP+v1QRDyegmL
         7cNA9Migi6II5fQ48JvxeMlWwoY6TA+pV1wMz2gQ6sMogHnxtYoqjKTYuCgFKO0u0Y57
         XIlINHuMJy5KiOPUVHRP4fs9Fl5V00FUk4htTfY2KWZRQBsZ4QQGYj7eOJdOHiO/GW0I
         Gj05ofA5idOoSCM5FrMrOSJgTWH1X03OipCWSAttmSUFBAFhez0UcMMG8M47nH2Ka6rt
         816g==
X-Forwarded-Encrypted: i=1; AKwUvBy2WgLkk9KdvNHFHkeRDohLGHzaHIHIWAfPE/Ljnec2z4ofm/iVbb48z1anonkr7z7kXsM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMBMdNnwQ9zEg7FYNag107txQqXn4Td6+p/8fclMDnpUQpZKfO
	7cyImx2zBadnbN5Wj9TxtXq+ZZfK1LpuNYKZrERt/7hpD4K7ExaYADKaK6qLlulD8YarX4EPnR7
	0LDfSApuBkng6zPwyurSD7L9CKf3xJgcDmYH8weIz
X-Gm-Gg: AYBFou3GPrToTSnnzNezXNxEeaMJafMkfyDcikXzeIJJjjftL5LBhJkjHk/cmSE7+Df
	IzDfuxB8hZxQWY+wRlPThxp1YjQ5OsQ2WrxcSKH0YFjWjcF1oQUdDsSz+ZIdhS7z2EUs3FWaziN
	0iktlHCGM/89QXzY3440QAGy4FXjCQkTM7kcUHneaYQy5UBehPALnmwxOShs6RdpWcdJZGzPlCV
	eCT+Y+/sacKmPkJv6iMYxlTB0j5QBxnFvzKXlSf1516PPju6d2PeGjU/mHNiovnM9JifQXq+uT8
	3CrVEeQVHtaJ17KNKJrXEgJlwURDxbOWu9Sylv2MCS6Sk+JqvWDaERtb+DEjhsNylGQc3EB4icf
	KI5HnSsgrhIS4U4A5lwdzyccFFadJplBTXPHc5SfJV2LGMZCk+08bOP5RGMCsNkeJxve2XHVcSa
	RMqgQAE6wYTToj
X-Received: by 2002:a17:907:97d5:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c49bd9e20e9mr50496066b.0.1793138875790; Tue, 27 Oct 2026
 15:07:55 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com> <20261023001603.560210-12-wusamuel@google.com>
 <at8dNNb4vwovNZcZ@krava>
In-Reply-To: <at8dNNb4vwovNZcZ@krava>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 27 Oct 2026 15:07:44 -0700
X-Gm-Features: AclHuK_4ySi3E2heiJLIOqDTOIX20dmWcYWcaizjPHfB4zOsCZlZ7RMy9jhhzuA
Message-ID: <CAG2KctpMEuK5OJSedSFshNMSwOqe1g87m2ZOKBhn=Z5iCA45Aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/6] libbpf: Resolve typeless ksyms via
 KALLSYMS_QUERY ioctl
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 2:28=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Oct 22, 2026 at 05:16:05PM -0700, Samuel Wu wrote:
>
> SNIP
>
> > +static int bpf_object__query_ksyms(struct bpf_object *obj)
> > +{
> > +     struct kallsyms_query q;
> > +     struct extern_desc *ext;
> > +     int err =3D 0;
> > +     int fd;
> > +     int i;
> > +
> > +     fd =3D open("/proc/kallsyms", O_RDONLY | O_CLOEXEC);
> > +     if (fd < 0)
> > +             return -errno;
> > +
> > +     for (i =3D 0; i < obj->nr_extern; i++) {
> > +             ext =3D &obj->externs[i];
> > +             if (ext->type !=3D EXT_KSYM || ext->ksym.type_id)
> > +                     continue;
> > +
> > +             q =3D (struct kallsyms_query){
> > +                     .size =3D sizeof(q),
> > +                     .query_flags =3D KALLSYMS_QUERY_BY_SYMBOL,
> > +                     .sym_name_addr =3D ptr_to_u64(ext->name),
> > +             };
> > +
> > +                     err =3D -errno;
> > +                     if (err =3D=3D -ENOENT) {
> > +                             err =3D 0;
> > +                             continue;
> > +                     }
> > +                     if (err =3D=3D -EADDRNOTAVAIL)
> > +                             pr_warn("extern (ksym) '%s': resolution i=
s ambiguous\n",
> > +                                     ext->name);
> > +                     break;
> > +             }
> > +             ext->is_set =3D true;
> > +             ext->ksym.addr =3D q.sym_addr;
> > +             pr_debug("extern (ksym) '%s': resolved in kernel to 0x%ll=
x\n",
> > +                      ext->name, ext->ksym.addr);
> > +     }
> > +     close(fd);
> > +     return err;
> > +}
> > +
> > +static int bpf_object__resolve_typeless_ksyms(struct bpf_object *obj)
> >  {
> > +     int err;
> > +
> > +     err =3D bpf_object__query_ksyms(obj);
>
> hi,
> we could also add similar support for libbpf_available_kallsyms_parse and
> probably in some other places like bpf_get_ksyms.. which makes me think i=
t
> could be useful to have KALLSYMS_QUERY support for multiple symbols
>
> thanks,
> jirka
>

Thanks for lookiing over this Jiri!

Using KALLSYMS_QUERY for libbpf_available_kallsyms_parse() would
theoretically by O(m*log(n)) instead of O(n*log(m)), where m is the
number of tracefs symbols, and n is lines in kallsyms, with n >> m.
But AFAICT, libbpf_available_kallsyms_parse() would only be called in
pre-6.5 kernels, for kernels without commit 83f74441 (ftrace: Show all
functions with addresses in available_filter_functions_addrs); so this
ioctl could never be called.

And regarding bpf_get_ksyms(), it loads all traceable functions and
needs the full syms table, so a /proc/kallsyms should fits better.

I did profile a slightly different form of querying multiple symbols
at once [1], but didn't see much benefit. struct kallsyms_query is
extensible via size and query_flags, so we can update in the future as
needed.

[1]: https://lore.kernel.org/all/CAG2KctozPSev+EXSpHitM3JWfjufQaEjsPJHS_1HJ=
1wSm7sJ1w@mail.gmail.com/

[...]
