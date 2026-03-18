Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C1125EFBE
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845547; cv=pass; b=Oo9Fsveel3CsI5SsDsTxIIPkqb8J/7imNaQMc/Ep25SC3G5Of0UzXBysfCoKK9Ek5mSLNb5KLlj2mLDvx2h1QEMtXQQQGEOprhM1m7rAlvwZ1K12jHuxx8JqDtFQV93uvqRqhaVAsyZ/USmqVdU4jX8mvS03x3F1d6YnE3UsFUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845547; c=relaxed/simple;
	bh=dtyJmL3ulsB2K04/QRakWuL0ygWl35EGvRyAQ+/kAD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgUjFL5mJm/CLfWFLP6f9HtHE/EHQZZho3EIc0Rbmwpi9USMPDy9dGJPSMn/m358HXrm/nAY54RbpS7kPyKZHjSqfU6XOgTC6khBt12EVmxDmW6OxGcUj5OA/jXqJWzTTpT6TD5HtUndN1kial3Q+ELDprDpUIYHy0oOlVV7oio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGMhJxpQ; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGMhJxpQ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so78127685e9.3
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 07:52:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773845544; cv=none;
        d=google.com; s=arc-20240605;
        b=gQFstycqggB1jDZuFcFri8N6GLjb+z5TNBxt8Y4Y8fCdjzwZj5kSnDD3A4PHAVAU/I
         WArLkh5zx80TJj93Mg9X1bTeJdheGkK+OH7M+NtOnDpIcFEL39/a96xHiceQcfItqtuq
         BbJGAOyz/nXhywBkwo1KJT4jX57HUsGtvphm1cK0nVcJ2of23O7Sa7yANOUzJdUJOxuk
         t8qNZraOylxtgZJpPbcT/wrdZsZiWUulMwKXka5Q+XwlukdmcJTFFRBcI1oErPUc69F0
         gzt4shM9OkjnpSU5BjOlu+GHSFD9uN/8KwV4RzxG0ADLphzHYs6pPJy3FpIBSgSUzLtQ
         9GXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HB+gA6ByzyLBH19NIOmS8rvUbE+H9OzxCLxj0msP9ro=;
        fh=n8DmVzClymUKKYFdULryoXNQlAjma0bI9q6Fi+O8Lro=;
        b=Fx//sHLzOEoP/B9ELXSRcGMRL3qiszxRw02XOnU9PmCus6ssCy0Vdw9rqUs4skX2zx
         PeZTJZhszlY9+lKvjf8yIJYRCoQL9dxsugBdZLGYMJoTGUG85RwBCR5cJOHOII0/Ym0l
         8NuuqdsCpME5AyiV6nDRGQ9LqKFMB5yxZ8mzheTyDwDTT9Z4QOVuCp7F1Onp0UUl28IL
         JDAawY87F+NtBhwHht6bTq7fjhAr90ndCZ0YiZmp9Pt00/I2kYSGjkPDaw31IEfwi2ts
         uXouadJKSrbSt9jFWBfUhIEEvfB8HCMKc/fhZwP6aNkHHF4q/AIfERehKdgDmX00g+LC
         N8lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773845544; x=1774450344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HB+gA6ByzyLBH19NIOmS8rvUbE+H9OzxCLxj0msP9ro=;
        b=gGMhJxpQgnlIwW44l95K4TzJwhfCKyjEJbBYLtnr67gy2sEM7JfKVi0+hT7tT/mHFj
         b2pdtelWYDkpybDImY+hnYn5SQD1MtN6F3ozU88p8bpSyvFs/nqHJbARP3zeuIvUzGo8
         7e6xGvoLKNWj+ZlBesbhLtZSR18Lr2FkT9GtdvjrfoK1aoFTkTezbWF51qQ0EsSwVy7W
         uULqFbLcLtbQ9UxpFoLEc5dZ1dR0/JCEolX4LUSO6j2DMsu64mzdJjq3saRq9Z8AleZW
         nN1aNW39hgqC8tVqU46+BEG0mCou5HdILi9PmElFwVYruTYNQn4i5aUDzgeb+fvxxqx9
         xToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773845544; x=1774450344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HB+gA6ByzyLBH19NIOmS8rvUbE+H9OzxCLxj0msP9ro=;
        b=EGgHQBbf4g8fgtBI1gABLefVmNYj9dPhBhROJzOzJYl4scXbfUPt8yDjRoSTLdtZyJ
         QJUUoZswPxAmxhhfzyfY77VqtYXaWbFzxESs7qf5G63pE8o3PnnaPZvAWeIJTwd29Uut
         fSrMASe66SEPNQt3FQ0FqqJzHlZ7zuN3QeuOHoAZZwKNMazvoPJWty23ERcqO6UI0OUd
         xTGrnbsOFkZIqbrnDN1QZyx3u3qwdTCa8rCsWvgE19Zvc6QNtDL+V1tlBD5Zi8OCrbrn
         DP1EgkU4y2eSMqjjTPE17vfBO2zGi6ToQ7dy8EEi1ZYdNTS+PPgltcADxNx0wFp6VLR+
         rwrw==
X-Forwarded-Encrypted: i=1; AJvYcCVDXjQVaoVbWM/j++oWRzLrGx4K3MlWscl0ZPqf6fT1AKyXAoOCHG3U7uWswl33jhUov24=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyeq18TH6xPRbqk8LOISe7DsF7OcTBhoBP9laPM5ljWl/YVIbN
	uwT4tazj6i/E/nCob0bUiW3H3RC02xKvjq6+sz7ELhCyI6djwODdqWYHvIyA2TiJrJpRzcQ+Com
	GB4Ugwa759r/zhcJUGjRyYqhMmZ/fSPM=
X-Gm-Gg: ATEYQzzdEDsAyYLmskKq82250pXP7+4JnmWan70BZwiFPyWNFX1FXJOkjASp2g4zZ8L
	+r4SR7TMxX+DBTzAhTt2VXro9W83R2TzMzwIYHJpvWFiKiaXj0QK+lpkBzqZ22qpiEV2WKTmA3E
	SfphoeAO37OVyxpEzmYBpTLIdwKLdyK/08PBJ4Rxpc+6NhQXTFnZaez0NEqsmyQlbcb8hoOmyyp
	EKF/MQtEgkSceBmidKQMXMuet2uqEed/8s+XT6nfBW/3822dKpoQ8f8Wqxu6FDUrgC2WtOexIDD
	FvruqMO0ZHpDfxPYaMTn8ViCTosUqj6ImV918H4mdQF2JtgXwdEbTkK18EWljvT/SWOh8DP6dzk
	sa3uro0ROjeeO7ygAZj4qtMPH4lbGzYl+1fbf
X-Received: by 2002:a5d:64c3:0:b0:43b:47bc:c147 with SMTP id
 ffacd0b85a97d-43b527cc553mr6436462f8f.45.1773845544085; Wed, 18 Mar 2026
 07:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318132927.1142388-3-alan.maguire@oracle.com> <9bb62dd69d27eaaf36db9036240de0354722c839121572557dd161a2511c6a43@mail.kernel.org>
In-Reply-To: <9bb62dd69d27eaaf36db9036240de0354722c839121572557dd161a2511c6a43@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Mar 2026 07:52:11 -0700
X-Gm-Features: AaiRm511EkeR7kwtmpLnyNHAISj-DqX9kUUsztIj5ywykAPSEKhNpeIJbJ-NsWc
Message-ID: <CAADnVQJEn3FXsSv6XJbCkhPuiJQzb8w35NteyGdsz3p=fu4Myw@mail.gmail.com>
Subject: Re: [PATCH v14 bpf-next 02/10] libbpf: Support layout section
 handling in BTF
To: bot+bpf-ci@kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 7:45=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 40becc9643688..37a3b317cb2f4 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
>
> [ ... ]
>
> > -static void btf_bswap_hdr(struct btf_header *h)
> > +static void btf_bswap_hdr(struct btf_header *h, __u32 hdr_len)
> >  {
> >       h->magic =3D bswap_16(h->magic);
> >       h->hdr_len =3D bswap_32(h->hdr_len);
> > @@ -224,66 +246,113 @@ static void btf_bswap_hdr(struct btf_header *h)
> >       h->type_len =3D bswap_32(h->type_len);
> >       h->str_off =3D bswap_32(h->str_off);
> >       h->str_len =3D bswap_32(h->str_len);
> > +     /* May be operating on raw data with hdr_len that does not includ=
e below fields */
> > +     if (hdr_len >=3D sizeof(struct btf_header)) {
> > +             h->layout_off =3D bswap_32(h->layout_off);
> > +             h->layout_len =3D bswap_32(h->layout_len);
> > +     }
> >  }
> >
> >  static int btf_parse_hdr(struct btf *btf)
> >  {
> > -     struct btf_header *hdr =3D btf->hdr;
> > -     __u32 meta_left;
> > +     struct btf_header *hdr =3D btf->raw_data;
> > +     __u32 hdr_len, meta_left;
> >
> > -     if (btf->raw_size < sizeof(struct btf_header)) {
> > +     if (btf->raw_size < offsetofend(struct btf_header, str_len)) {
> >               pr_debug("BTF header not found\n");
> >               return -EINVAL;
> >       }
> >
> > +     hdr_len =3D hdr->hdr_len;
> > +
> >       if (hdr->magic =3D=3D bswap_16(BTF_MAGIC)) {
> >               btf->swapped_endian =3D true;
> > -             if (bswap_32(hdr->hdr_len) !=3D sizeof(struct btf_header)=
) {
> > +             hdr_len =3D bswap_32(hdr->hdr_len);
> > +             if (hdr_len < offsetofend(struct btf_header, str_len)) {
> >                       pr_warn("Can't load BTF with non-native endiannes=
s due to unsupported header length %u\n",
> > -                             bswap_32(hdr->hdr_len));
> > +                             hdr_len);
> >                       return -ENOTSUP;
> >               }
> > -             btf_bswap_hdr(hdr);
> > +             btf_bswap_hdr(hdr, hdr_len);
>
> Could btf_bswap_hdr() access memory beyond the raw_data buffer here?

Alan,

before you respin please look through other bugs that gemini found:
https://sashiko.dev/#/patchset/20260318132927.1142388-1-alan.maguire%40orac=
le.com

pw-bot: cr
