Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4619333A03A
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319636; cv=pass; b=jEABOtV3fz0JL76WVY+53WPfBelYC5Q/p9FWnwv5EtsCxtRU5RLyJ5Xb/n1Euja9Rp+tvuxwTH6UxDx1bYzpv4rp4GOjg7oCs4jcpc9AWw3FIL6b5Os1UZK2EUUwVONQTLaJ+vjZxSR5Fhf4oeRGtEp3LTR3Ul6F2HKT8RTa2BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319636; c=relaxed/simple;
	bh=jb87HJfRSFh3ibClaIfUFqxc2lysBISQLAvxBTwcuj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bv9CwLbFJvoDLy2fN3ugMirhmBvHlT1a/qry7oSAcXcum4blgGiYdjoh1PHmzXiJVH55RHTyLbiSFqmD5aE/keGbqve5UNF93IJ8PxTEzHRDpIMjfoW9vqE8BMnZKmUDS6Vo/4pEB5m7txI37FHho74jHOLDBnKGGLQq2FkAXg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuKf5KIf; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuKf5KIf"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c7cfa17fedso10220365ad.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 09:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782319634; cv=none;
        d=google.com; s=arc-20240605;
        b=Fkf4TqWddvbSA5FPiYrkIB8F6xAsvwlg4293h5M71IfU00Bm4Mj7fI/qF9S/RAUaw7
         S7sLHm5brRM6qVs7uQgofp9W/kSS3iZw1vCcJr2c6ZkNeNKTclUkwPS0Mm6JVZJNOeFz
         L2/hvExFBqswhzAGlloxIS2iD452QNUn2ffsbA+tWMDocWXVB/iWz6SXnMFhAIqszr/e
         xC+F0tKR3vNKfMBPAwSuM0kBhrXAI5O63XsCq3C2CeqOtTY/0B+qYLb/2Xu80Nyi0/Ti
         YDVZ0gyMgYcyueXbGdBQgUbofKZeu/QAUG/FoHkIsGK83HFfdQpB8lEgqh0yEcWdQYpm
         lLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6SeAj53ToL+iIhvb8r7rZIq250sEiBfsaAyAkUxRk5E=;
        fh=IqI/Cp1xYGcfpyBgkhc6h3oFTMbeXOsSrhhlFByRLHg=;
        b=SVwTi0/fAIA7YuF+DHmIwkMfwiEqeMRh6weEbRa53xkIviKMNO+dSMo/ARkCThaaBj
         JpNZ7IMK1c5weNJqP2nuVLNsiqH42q1s0DWX2haPJ9EpxOg1nSj2q0Yqs1Y2SPFw2jqv
         erzOlEtwIobc1OrEWXYxzKKEW8TsFSn7RFKXb1Qgt+B+rD8U/79CBeiDTFRHM56ngS+k
         e5AhUnvGu8nXEP4e60UrNfLygrHKXZIRyZTpevZe5+Y+FzTMq84VMuaT6s9WOFl8z4cW
         QSwX1PbrnfzBlYGLhYrKA8iixR6zkN+rFUAS5jPbZAXpRhhLOFeO7Vdg18qgOXxb9Rxf
         VblA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782319634; x=1782924434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SeAj53ToL+iIhvb8r7rZIq250sEiBfsaAyAkUxRk5E=;
        b=fuKf5KIfZCUhaMM7Jw5GCxvmtruSQOOWbiti6peSj/5///0KiIRN7QklHhqHVb40sh
         1SzdJDClUzooH7JMDT+hw6gU9hN2KRSoptwWkox/Sm5HKHTQtP1IWC9AMupskvAg9P1R
         09aDnY+O3ITXZ4cUXzHOpI+q5fjvR73qHMgjHbtB4ao13LZPrEGzBYgJWd4DOcyLKq/F
         ZSpYMGZ0YtEw+SlgzXip+JBLyegXWzMNC8JnILO1VoiugSYtjHDmUwcuN49kR+/VZTZZ
         Oj+zQm1DTopeLqj/h1YvfdP/fSQ/bHZDzXXQP0dS2TjAHiOLdvY04II0KIZPKf4R/5Me
         Nv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782319634; x=1782924434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6SeAj53ToL+iIhvb8r7rZIq250sEiBfsaAyAkUxRk5E=;
        b=sAqznRzw9qjJ3Spg+SXEV6B5jwQPX0J3ES6s2GY8WEuNSLv+czlkNEusZJJJO/vR+Q
         KJ+DRdAQHWfmb+DOm244boK54A76KPIpWgf2tR5J8WYrBnlCM/b/cmdeLW7ROCqoLtVS
         nEnig4UfpwI+0OCEwPWH4oR6Vc1sYz+i7fR48suCQ0bjn/uqJcrW3lqE5L7gRhm9AEQ4
         Zp+aDR2xSkKeNDPBso+k2AAKz043masMykM+7OFioAlDjZv799XuHqP0YuSHq0D+tvsw
         3l2tSREOm1jtymUc0YYvytHOqJpOBboiQ+6Kg7GWuLLMlbSakYzmcFTZWtZnxxIeY56i
         WYww==
X-Gm-Message-State: AOJu0YykWTsiRVRLDnGp2p5GfViluZ3qIX6LW/JTUVr/nd1t7vIzkJTv
	AdeCGZbN/d9qEZLxVuCjJsp3obUrMN8teV+zGCATHzwUsHKjAM28FBJr2Yvjr/Upnhi/GjHyaGt
	zHI36zkkxViuMREop8CZqa8RGVBEqIPc=
X-Gm-Gg: AfdE7cmCiFbNHoO/fC9QsTmIYiR8BvDI6PTBkEGrNFi41/3LaofaeA9AKtFLyFijk3r
	kkQG+I6qFFmf3Tv4TSZU/jQ5miGEnzPpHq0PGvEG94v+VV2aPpSvca6FuS6UfrRQ40z7w8OklaF
	G74AtozusMUfLvo3Rqcm63GUV/dXdfRKvqmxiO5SbWMA+D/wmfmxZwk07De0LiXEomDxw1x4rGX
	TinkjSqb3+16fmtsMFbs9jXWnmkT0VWF5j9iqMCUhfcgBEtKCr6/RHRGPJ2/MgpJZWR0h4mdaHl
	IP0TuNYRTA5lLqpJlwSt8Er4jKnpi/TgbiIEtapduwjQKFA5mgjYQSx35p2pCwaCLrc=
X-Received: by 2002:a17:903:1aad:b0:2c1:ef9:4516 with SMTP id
 d9443c01a7336-2c7e15c5297mr43635345ad.35.1782319634356; Wed, 24 Jun 2026
 09:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622143557.22955-1-leon.hwang@linux.dev> <20260622143557.22955-8-leon.hwang@linux.dev>
 <CAEf4Bzay2Wssj1J4fEq3T7iTOBDswEZunm1OQNDJvPr2Cz2Usg@mail.gmail.com> <2330e6a8-c7eb-4296-8aa0-feaafd6b09cf@linux.dev>
In-Reply-To: <2330e6a8-c7eb-4296-8aa0-feaafd6b09cf@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Jun 2026 09:47:01 -0700
X-Gm-Features: AVVi8CfvajdsKBdz7BjLSNC0Pr7m6oD_1G7bxZMh3vJsMu1aR84CN80Svee0E40
Message-ID: <CAEf4BzaiYCAqSQgxeEv=8tmtNLYaghj8OBmRJdUDiUm2AKAwSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 07/11] bpftool: Generate skeleton for global
 percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:15=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 24/6/26 06:46, Andrii Nakryiko wrote:
> > On Mon, Jun 22, 2026 at 7:37=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> [...]
> >> @@ -263,13 +268,12 @@ static bool is_mmapable_map(const struct bpf_map=
 *map, char *buf, size_t sz)
> >>                 return true;
> >>         }
> >>
> >> -       if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & =
BPF_F_MMAPABLE))
> >> -               return false;
> >> -
> >> -       if (!get_map_ident(map, buf, sz))
> >> -               return false;
> >> +       if (bpf_map__is_internal(map) &&
> >> +           ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) || bpf_map_is_=
percpu_data(map)) &&
> >> +           get_map_ident(map, buf, sz))
> >> +               return true;
> >>
> >
> > just add `if (bpf_map_is_percpu_data(map) return true;`? maybe also
> > move get_map_ident check a bit earlier. I think that will be a bit
> > cleaner, this condition is quite hard to follow
> >
>
> Makes sense.
>
> With adding the helper bpf_map_is_skel_data(), will this change looks
> more readable?
>
>
> +static bool bpf_map_is_skel_data(const struct bpf_map *map)
> +{
> +       return bpf_map__is_internal(map) &&
> +               ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) ||
> +                bpf_map__type(map) =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY);

if (!bpf_map__is_internal(map))
    return false;

return (bpf_map__map_flags(map) & BPF_F_MMAPABLE) ||
bpf_map__type(map) =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY;

or just split that last return into two if (...) return true);

both work for me

> +}
> +
>  static bool is_mmapable_map(const struct bpf_map *map, char *buf,
> size_t sz)
>  {
>         size_t tmp_sz;
> @@ -263,7 +274,7 @@ static bool is_mmapable_map(const struct bpf_map
> *map, char *buf, size_t sz)
>                 return true;
>         }
>
> -       if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) &
> BPF_F_MMAPABLE))
> +       if (!bpf_map_is_skel_data(map))
>                 return false;
>
>         if (!get_map_ident(map, buf, sz))
>
>
> >> -       return true;
> >> +       return false;
> >>  }
> >>
> >>  static int codegen_datasecs(struct bpf_object *obj, const char *obj_n=
ame)
> >> @@ -343,6 +347,9 @@ static int codegen_subskel_datasecs(struct bpf_obj=
ect *obj, const char *obj_name
> >>                 if (!is_mmapable_map(map, map_ident, sizeof(map_ident)=
))
> >>                         continue;
> >>
> >> +               if (bpf_map_is_percpu_data(map))
> >> +                       continue;
> >> +
> >>                 sec =3D find_type_for_map(btf, map_ident);
> >>                 if (!sec)
> >>                         continue;
> >> @@ -669,7 +676,7 @@ static void codegen_destroy(struct bpf_object *obj=
, const char *obj_name)
> >>                 if (!get_map_ident(map, ident, sizeof(ident)))
> >>                         continue;
> >>                 if (bpf_map__is_internal(map) &&
> >> -                   (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
> >> +                   ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) || bpf=
_map_is_percpu_data(map)))
> >
> > also we can add a helper to check if it's an internal map with a
> > dedicated data section in the skeleton (too lazy to think of a good
> > name right now.. ;)
> >
>
> How about bpf_map_is_skel_data()?
>
> Then, this 'if' will be updated as 'if (bpf_map_is_skel_data(map))'.

yeah, I like the name

>
> Thanks,
> Leon
>
> >>                         printf("\tskel_free_map_data(skel->%1$s, skel-=
>maps.%1$s.initial_value, %2$zu);\n",
> >>                                ident, bpf_map_mmap_sz(map));
> >>                 codegen("\
> >
> > [...]
>
