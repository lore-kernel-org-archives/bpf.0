Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859FF220F38
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 23:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772234201; cv=pass; b=B3/8x8L8kRCHWQ7bivzRxVNQU1V9uogtsuCCZuJ2/FgwWiK9trFsPfrep048Y5tznJgsFA299TpSFuXpiEfoFcTkcW5vSiktWfrAyWT0EnYAeSuggF5dBimAebZolGcCXFqEhpmkDD2DSQSokTtOolNofak0T0UDdgGf6kY/hK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772234201; c=relaxed/simple;
	bh=5bEY5UXLzjWPh44w4Cx2basuFz8GnNVWmKBlQs+YDkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYR+8+9RplLX0AvuXf+v8/dQ7yuZ6wJg2XK7drkOZtrFOKMqEJZxZCTUu1c1TS3aOJ4jomOOBVZRyJYXYaqQNwNUzlLOBjoFdoz2gCofmDY8CGWRc1idEOcBUWkmBJvZVp4p77G8se+wmxF5Qx5/zPRqVa2K7oPuz7v8oyjN368=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hm1b7ubA; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hm1b7ubA"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43994aa265eso1501156f8f.3
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 15:16:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772234198; cv=none;
        d=google.com; s=arc-20240605;
        b=VzuBTdr9KC5RbkCXbW7EnQQz0Kl6B628zTvifTyDQkqkgNYK48bafuzj+VduPT0vFo
         FzzaQjP6lOzDLVxc2FD/1hf5gO95AXe133WguD2StOjioJwJl7HflUgvlEGGeNPgp1g/
         fsJCcL6OIIVCHHSLHYv6xSA167CEw8drttXDDwdHrNVmDgxcwlKlLxqNv/Opccg0LKtA
         eJ+42GMumBhUG8Cx0U6u64uaP12iPC3YmCfPt3y35liwyvY3C/Z++yfccMMltKOV0mbG
         6vIlRceUjHZ9YvG/Tn1H+vcx6l+SaMnjpQ+ExqHo7Sp5Bm02oMtEZvr0R5rTYXjahcWF
         3l3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3xNg2kQtCk3Ev8PHb+VBqW9Vt5j3KhL+uqlascRwyC0=;
        fh=hPJJtkN8Z7ZuQH9Ag3wzav2TvnVACmG/YcUQKiZk8vk=;
        b=CfKor6RyOunBQAM6/43rbD4SzPlm3l/EorV/BBR3goMFEXUye49y7U38yJvgGUfbGZ
         Dtl9CLZ5xtLitfCEagMmnjNugjIjW7PLIkowlCvOz1nQmowyJaFBYVxUdPCD+8cm4RVQ
         1nDmLPaUuni+AjVlBPm/9T4lj5ls/Wocs3fiBYsbj5a9qWtp22Y4FKX60+lK1i3Ft1lt
         hozV3MeMa7YteNOEPNlOJbyRwBiodLA9AN4962UBvOM0Qigu9/T9CG94jGxa5Mx+4fpE
         Adt8zdOBJDRuj9BgpgcSHS3fL9cvWLlSvvbWX0+uwn8SgtJlEo8YWvIbQc4xS2kbEOec
         qjZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772234198; x=1772838998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xNg2kQtCk3Ev8PHb+VBqW9Vt5j3KhL+uqlascRwyC0=;
        b=Hm1b7ubA/WI3ynYaEofIMSVmOR27iFc93OSXQ1yRjCC+ElwWEyjwIEWEek+83Si9e1
         HeUwxmdKL6yGR12YfiLxnuq3OmP0z8Jgk0C6iYY1ZXVTrVFE2qKVP6HrpFdQGDTXRs6C
         S/lURKKVVe75gVH50P+GxmA+mw9mU2DaKcVDz0zyJcvA2WBUXUXN1kAwvvBGtexABPqa
         qqW8t8yUL2QlkFmrxdnEpe343rM23hlCOJmlLb6LzLqnsZx9awtas7aXvNknWM6Jf4RF
         pjh/l6HcT9LAxaE1q4b3SpJMLWTFTCkXHQPHgVYn+n/1AVcvLMuoduTsmPwsqSEuUZ+K
         wk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772234198; x=1772838998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3xNg2kQtCk3Ev8PHb+VBqW9Vt5j3KhL+uqlascRwyC0=;
        b=oQP00ciRZwnggsfy1NrBE17kOQWpCEg4YNS5RihH3m6Z9VXA1F6Tt+PutUN/O5Z/IP
         YPObM47dYUqRkHx2VBWdPk1Lgd3KpLOEf4QRf1xonL4/vLZxVa/YAvKEgwQCWISKUvfN
         Teh3GEtkHHU4hPVK5I6RV5xAWvA6w9qanG7WSsBIyp80KB6eGRRHRAnWkETYa3gptcgI
         zMOB4xz5ck80nE4sNUcZMGgvYFJnim0W4gt2eSPyGo7ix03Q4Mfrg9ErkeijySPQFjve
         TVlQ+OWQIUK4M3ioh1kOs27fpuFEBiUxtyD5t7Pwyjw0LsdO94OvQvS7k5QKlckocA1M
         1rEA==
X-Forwarded-Encrypted: i=1; AJvYcCU/hqxhpFk8piYWMsxWgdc+zHtFwf6nTDWWqEP+Duuq3rIC7gMkJbKaVdmnTSXpQ1Q4xbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxujrTQSL+9IW6ejPfgaiPCWaeS/6UuepdpuV6CvhdnQ0HNvp5l
	+Jpi4Gfb01H/Cj6mL/EoAdqGTKr8eAG6toeZh/mkWkT4ri7F9sje45a35KM113wXMmRGBKNuBI6
	thgQtYcwxc88Wy8LAU+GP7wDbt5Nq9/c=
X-Gm-Gg: ATEYQzwT62KLRd6ib8l7ewzJ+wWvrmohRo3VWikTwDsk39uSAlCG/r/Jqgy4EJ3QF6A
	O9VxZvmBKaaq7vLz0fDdzburwGS/E0tsBHyTyQh+MXW4pRQ6zDhCoHXpj10GzKkOnBe9SKyDz5i
	MgWkX2TikwWUXM1/cHMtJ4ayW77z60lnzE40zzray2XYNIT+zxYKvgUBiqDnIdMcXV2/g4cdK1N
	YOm2qAirvq434ntn2I/JSHvC64vmdid/IbfbOUsWkE735z931/5bFBQJ5aq88UtCn4u5cOcQlEp
	gk8r7ydSNhIw+tNvrJceLE+jYTrdKUpMMgLV+xW8MayjabwYZreEYAV/iyWavM/tB9TSOmXIV2y
	lTNgpZjMLU6WrBsf2sKi7HA655A==
X-Received: by 2002:a05:6000:2012:b0:437:678a:5921 with SMTP id
 ffacd0b85a97d-4399ddd877emr7625802f8f.1.1772234197736; Fri, 27 Feb 2026
 15:16:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227100426.2585191-1-alan.maguire@oracle.com> <20260227100426.2585191-9-alan.maguire@oracle.com>
In-Reply-To: <20260227100426.2585191-9-alan.maguire@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Feb 2026 15:16:26 -0800
X-Gm-Features: AaiRm53oYnNJ13pPYwBxjbvQcsIicGI5cpjaxTq7RmFZBNQScvLsj-YfhPsJ9GQ
Message-ID: <CAADnVQLTwLSWaN8arz5NmCwqJxd3DPhtKn2is5AgrQ0AwYFi7A@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 08/10] bpftool: add BTF dump "format meta" to
 dump header/metadata
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, dwarves <dwarves@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 2:05=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Provide a way to dump BTF metadata info via bpftool; this
> consists of BTF size, header fields and layout info
> (if available); for example
>
> $ bpftool btf dump file vmlinux format meta
> size 6516862
> magic 0xeb9f
> version 1
> flags 0x0
> hdr_len 32
> type_len 3929096
> type_off 0
> str_len 2587654
> str_off 3929176
> layout_len 80
> layout_off 3929096
> kind 0    UNKNOWN    info_sz 0    elem_sz 0    flags 0
> kind 1    INT        info_sz 4    elem_sz 0    flags 0
> kind 2    PTR        info_sz 0    elem_sz 0    flags 0
> kind 3    ARRAY      info_sz 12   elem_sz 0    flags 0
> kind 4    STRUCT     info_sz 0    elem_sz 12   flags 0
> kind 5    UNION      info_sz 0    elem_sz 12   flags 0
> kind 6    ENUM       info_sz 0    elem_sz 8    flags 0
> kind 7    FWD        info_sz 0    elem_sz 0    flags 0
> kind 8    TYPEDEF    info_sz 0    elem_sz 0    flags 0
> kind 9    VOLATILE   info_sz 0    elem_sz 0    flags 0
> kind 10   CONST      info_sz 0    elem_sz 0    flags 0
> kind 11   RESTRICT   info_sz 0    elem_sz 0    flags 0
> kind 12   FUNC       info_sz 0    elem_sz 0    flags 0
> kind 13   FUNC_PROTO info_sz 0    elem_sz 8    flags 0
> kind 14   VAR        info_sz 4    elem_sz 0    flags 0
> kind 15   DATASEC    info_sz 0    elem_sz 12   flags 0
> kind 16   FLOAT      info_sz 0    elem_sz 0    flags 0
> kind 17   DECL_TAG   info_sz 4    elem_sz 0    flags 0
> kind 18   TYPE_TAG   info_sz 0    elem_sz 0    flags 0
> kind 19   ENUM64     info_sz 0    elem_sz 12   flags 0
>
> JSON output is also supported:
>
> $ bpftool -p btf dump file /var/tmp/vmlinux.kind_layout format meta
> {
>     "size": 6516862,
>     "header": {
>         "magic": 60319,
>         "version": 1,
>         "flags": 0,
>         "hdr_len": 32,
>         "type_len": 3929096,
>         "type_off": 0,
>         "str_len": 2587654,
>         "str_off": 3929176,
>         "layout_len": 80,
>         "layout_off": 3929096
>     },
>     "layouts": [{
>             "kind": 0,
>             "name": "UNKNOWN",
>             "info_sz": 0,
>             "elem_sz": 0,
>             "flags": 0
>         },{
>             "kind": 1,
>             "name": "INT",
>             "info_sz": 4,
>             "elem_sz": 0,
>             "flags": 0
>         },{
>             "kind": 2,
>             "name": "PTR",
>             "info_sz": 0,
>             "elem_sz": 0,
>             "flags": 0
>         },{
> ...
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/bpf/bpftool/bash-completion/bpftool |  2 +-
>  tools/bpf/bpftool/btf.c                   | 91 ++++++++++++++++++++++-
>  2 files changed, 89 insertions(+), 4 deletions(-)
>
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftoo=
l/bash-completion/bpftool
> index a28f0cc522e4..d49d6a70cb74 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -950,7 +950,7 @@ _bpftool()
>                              return 0
>                              ;;
>                          format)
> -                            COMPREPLY=3D( $( compgen -W "c raw" -- "$cur=
" ) )
> +                            COMPREPLY=3D( $( compgen -W "c raw meta" -- =
"$cur" ) )
>                              ;;
>                          root_id)
>                              return 0;
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 946612029dee..08dc6a86bc85 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -835,6 +835,87 @@ static int dump_btf_c(const struct btf *btf,
>         return err;
>  }
>
> +static int dump_btf_meta(const struct btf *btf)
> +{
> +       __u32 layout_off =3D 0, layout_len =3D 0;
> +       __u32 data_sz, i, nr_kinds =3D 0;
> +       const struct btf_header *hdr;
> +       const struct btf_layout *l;
> +       const void *data;
> +
> +       data =3D btf__raw_data(btf, &data_sz);
> +       if (!data)
> +               return -ENOMEM;
> +       hdr =3D data;
> +       if (json_output) {
> +               jsonw_start_object(json_wtr);           /* metadata objec=
t */
> +               jsonw_uint_field(json_wtr, "size", data_sz);
> +               jsonw_name(json_wtr, "header");
> +               jsonw_start_object(json_wtr);           /* header object =
*/
> +               jsonw_uint_field(json_wtr, "magic", hdr->magic);
> +               jsonw_uint_field(json_wtr, "version", hdr->version);
> +               jsonw_uint_field(json_wtr, "flags", hdr->flags);
> +               jsonw_uint_field(json_wtr, "hdr_len", hdr->hdr_len);
> +               jsonw_uint_field(json_wtr, "type_len", hdr->type_len);
> +               jsonw_uint_field(json_wtr, "type_off", hdr->type_off);
> +               jsonw_uint_field(json_wtr, "str_len", hdr->str_len);
> +               jsonw_uint_field(json_wtr, "str_off", hdr->str_off);

I don't think this part is useful.
People can hex dump it if they really want to.

> +       } else {
> +               printf("size %-10u\n", data_sz);
> +               printf("magic 0x%-10x\nversion %-10d\nflags 0x%-10x\nhdr_=
len %-10u\n",
> +                      hdr->magic, hdr->version, hdr->flags, hdr->hdr_len=
);
> +               printf("type_len %-10u\ntype_off %-10u\n", hdr->type_len,=
 hdr->type_off);
> +               printf("str_len %-10u\nstr_off %-10u\n", hdr->str_len, hd=
r->str_off);
> +       }
> +
> +       if (data_sz >=3D hdr->hdr_len && hdr->hdr_len >=3D sizeof(struct =
btf_header)) {
> +               layout_off =3D hdr->layout_off;
> +               layout_len =3D hdr->layout_len;
> +               if (layout_len > 0 &&
> +                   (long long)layout_off + layout_len + hdr->hdr_len <=
=3D data_sz) {
> +                       l =3D (void *)hdr + hdr->hdr_len + layout_off;
> +                       nr_kinds =3D layout_len / sizeof(*l);
> +               }
> +       } else {
> +               if (!json_output)
> +                       return 0;
> +       }
> +
> +       /* unconditionally display (possibly empty) layout info for json =
only */
> +       if (json_output) {
> +               jsonw_uint_field(json_wtr, "layout_len", layout_len);
> +               jsonw_uint_field(json_wtr, "layout_off", layout_off);
> +               jsonw_end_object(json_wtr);             /* end header obj=
ect */
> +
> +               jsonw_name(json_wtr, "layouts");
> +               jsonw_start_array(json_wtr);
> +               for (i =3D 0; i < nr_kinds; i++) {
> +                       jsonw_start_object(json_wtr);
> +                       jsonw_uint_field(json_wtr, "kind", i);
> +                       if (i < NR_BTF_KINDS)
> +                               jsonw_string_field(json_wtr, "name", btf_=
kind_str[i]);
> +                       else
> +                               jsonw_null_field(json_wtr, "name");
> +                       jsonw_uint_field(json_wtr, "info_sz", l[i].info_s=
z);
> +                       jsonw_uint_field(json_wtr, "elem_sz", l[i].elem_s=
z);
> +                       jsonw_uint_field(json_wtr, "flags", l[i].flags);
> +                       jsonw_end_object(json_wtr);
> +               }

This part, I guess, is ok-ish.
I wouldn't do it either though. Feels like a debug feature.
