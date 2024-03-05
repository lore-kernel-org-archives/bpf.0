Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C324B59
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668539; cv=none; b=QiIusVkmQtv0vQWBScY11/3teLc18dOvAENi386IdjmDuhp4xeRxA9IA0BWacpjrLMVWakH3cMiL2NZZkv6nOETgOd1mFumt5hM63EIA+2ItgvhDKmdbhAFFw4hVHi94uyUp0Ld3z2Ya8kgVlThUM6fFWbdks4EZC6e11j5vGCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668539; c=relaxed/simple;
	bh=n7SIcpig6qpwpcoBYZ1vsgHqIIEQy5hvo+khHLV0t6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chDAZD5fTtuZmQWrjC7vTSS8rf9MCBxM6Dcv3IywJUwoU9zyhFiytsWai6pQPDNC/RuQKw+nJ7+DmNlXKd59BJMvxrlUHMXoRoG2XHXF54ZDQUGVmPJZsb94gxBkjPBCAe+hwHJYCsBVbNP5E9cgJDPlxeZrGT+fsbvJ5Pd4wyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KECIXYeO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KECIXYeO"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6da202aa138so4526458b3a.2
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 11:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709668538; x=1710273338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtGzNgmCvvGesCHHpgQDbeKZD8d7OaQs9o4mSpa8qwc=;
        b=KECIXYeOUgv0HIxRbEo7CaK3ZnwcFA/2MNl4pWNo4qG7LZufuItDe3jlQzFt4PrOEQ
         zCVed6t9sqoDpD4o2LGAIwdyuSqpwMRpIUGaP3cP8BJfAhaCtUiHPcqrSM6g2DUdQsxq
         mMGjscEeXOiUm2SqYwIH6Lmu43tNLu2KKn14/xSOqzipBRaAAy2XlzP51HEtz/M+8rHc
         pisGrpNCLdkKvFB5hVrKQCzcGfXk4GSuIxBiSxem9w/sPz8jSE8iqLmTLBk+WxMNBd4H
         NqL+Nq6e/KEsGejDsdRljY7zgIW4YvP30nxOcey5LjS6AXhCSWsHdlcDRNO9HH0fsNbI
         ORqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709668538; x=1710273338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtGzNgmCvvGesCHHpgQDbeKZD8d7OaQs9o4mSpa8qwc=;
        b=TD0EQcx6MpnX1vAuhqtV4w6ZD7aTZOnhcfXpaDSP8fSLwhzUcvZa4zmZo9eO6O0IG9
         fvTXYVsUGV+vfd0mey5QWYAKpJQF92XIlZtieNt55DHSZP07Y6gnTOibusbg2vLVL4dS
         Crn8U7FJFCyvpFruQvH1HFzxUqUIywdMLuusRQJy34bsym8g2agINgh03UOT50iFWiDC
         ygImBfIJIeOFoyFOGRwdM9+7B+X9GtfoOw3G1UrRafNSGDnh7fxh3ZQcv7PLaEdlBb3C
         fc0DWjuQUd4oFHMrLAbEEok0gOMHFdHO2oMnn7uDcXxtIWcJJjf2WDyTXr0ApUtveEET
         YpBA==
X-Gm-Message-State: AOJu0YzvzTketVVBC05G/BfyKTiy4F1OKFqlPg3uDX+O5TA9yPTyLl8l
	vhtQl5vm+LWhPXgKmcNu/Yd7Ym1TVFHjzNHrNeWaTORqV+ieHPvqL1Gwz7+R+gH0jLwzo0Nzk/c
	1X6YcMUGsjc3Dw1MOBzfRv9AyqUc=
X-Google-Smtp-Source: AGHT+IHXu6tXC20oKcgck8RaJhOHCYZLbpHeE+EEzH3Yr4yt4dftISUcSrWAAi9VhTYKsCITg+5RBtoeztOz6wSEbhI=
X-Received: by 2002:a05:6a00:2352:b0:6e5:adb9:b955 with SMTP id
 j18-20020a056a00235200b006e5adb9b955mr17097610pfj.23.1709668537342; Tue, 05
 Mar 2024 11:55:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304225156.24765-1-eddyz87@gmail.com> <20240304225156.24765-12-eddyz87@gmail.com>
In-Reply-To: <20240304225156.24765-12-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Mar 2024 11:55:24 -0800
Message-ID: <CAEf4BzY6FokZYmNgGh=q5+icLxJ2p5Z9S6UxTC2AdJ4qz6==mA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 11/15] libbpf: struct_ops in
 SEC("?.struct_ops") and SEC("?.struct_ops.link")
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Allow using two new section names for struct_ops maps:
> - SEC("?.struct_ops")
> - SEC("?.struct_ops.link")
>
> To specify maps that have bpf_map->autocreate =3D=3D false after open.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>

Please check that patch subject is <80, and perhaps shorten it a bit?

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4ef3902e65db..c0212244bdf7 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -497,6 +497,8 @@ struct bpf_struct_ops {
>  #define KSYMS_SEC ".ksyms"
>  #define STRUCT_OPS_SEC ".struct_ops"
>  #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
> +#define OPT_STRUCT_OPS_SEC "?.struct_ops"
> +#define OPT_STRUCT_OPS_LINK_SEC "?.struct_ops.link"
>

I wouldn't do this, see below


>  enum libbpf_map_type {
>         LIBBPF_MAP_UNSPEC,
> @@ -1324,6 +1326,15 @@ static int init_struct_ops_maps(struct bpf_object =
*obj, const char *sec_name,
>                         return -ENOMEM;
>                 map->btf_value_type_id =3D type_id;
>
> +               /* Follow same convention as for programs autoload:
> +                * SEC("?.struct_ops") means map is not created by defaul=
t.
> +                */
> +               if (sec_name[0] =3D=3D '?') {
> +                       map->autocreate =3D false;
> +                       /* from now on forget there was ? in section name=
 */
> +                       sec_name++;
> +               }
> +
>                 map->def.type =3D BPF_MAP_TYPE_STRUCT_OPS;
>                 map->def.key_size =3D sizeof(int);
>                 map->def.value_size =3D type->size;
> @@ -3688,7 +3699,9 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
>                                 sec_desc->shdr =3D sh;
>                                 sec_desc->data =3D data;
>                         } else if (strcmp(name, STRUCT_OPS_SEC) =3D=3D 0 =
||
> -                                  strcmp(name, STRUCT_OPS_LINK_SEC) =3D=
=3D 0) {
> +                                  strcmp(name, STRUCT_OPS_LINK_SEC) =3D=
=3D 0 ||
> +                                  strcmp(name, OPT_STRUCT_OPS_SEC) =3D=
=3D 0 ||
> +                                  strcmp(name, OPT_STRUCT_OPS_LINK_SEC) =
=3D=3D 0) {

I'd do just

strcmp(name, "?" STRUCT_OPS_SEC) =3D=3D 0 ||
strcmp(name, "?" STRUCT_OPS_LINK_SEC) =3D=3D 0 ||


>                                 sec_desc->sec_type =3D SEC_ST_OPS;
>                                 sec_desc->shdr =3D sh;
>                                 sec_desc->data =3D data;
> @@ -3708,6 +3721,8 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
>                         if (!section_have_execinstr(obj, targ_sec_idx) &&
>                             strcmp(name, ".rel" STRUCT_OPS_SEC) &&
>                             strcmp(name, ".rel" STRUCT_OPS_LINK_SEC) &&
> +                           strcmp(name, ".rel" OPT_STRUCT_OPS_SEC) &&
> +                           strcmp(name, ".rel" OPT_STRUCT_OPS_LINK_SEC) =
&&

and similarly here, just use ".rel?" ?

>                             strcmp(name, ".rel" MAPS_ELF_SEC)) {
>                                 pr_info("elf: skipping relo section(%d) %=
s for section(%d) %s\n",
>                                         idx, name, targ_sec_idx,
> --
> 2.43.0
>
