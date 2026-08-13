Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C913B3F0773
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643844; cv=pass; b=CYZRCIldJrX7Ftzd1quVbunVQzQdqADRUqjap0X/ToxE50gbh1Kdj2G8KLEOKZ4UbA4MKxCwuFASWE5IUlkN1aukmTTnKTWiXX+TgNl22TvuZLjZ75mdtitHZdAroEOHVJ4syzQnzvbUDjene6kIXJxhDBvcoAhd1mNlX2MZIJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643844; c=relaxed/simple;
	bh=pxjZogGhoQwedyJpdwQ8wZRuKcrI3e8ALoUqvv9xYKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npFvsjjkftQMJPvIhtKnqdY8IZ6lyhB7twnWQvnl/kV1w8HDch6QB9eml8HYXTjigd4hz/r0ziVAf3ow3os4q9USOwxMr1Q+5Omu7N2erfWilg54JTRuNbMVn6eQsWVqwZw/SvFHzjfKNquo+AnMpcWfu147yFD3QDT0C3+6McI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPbDHVpT; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPbDHVpT"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8486ac3f347so1246369b3a.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 10:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786643832; cv=none;
        d=google.com; s=arc-20260327;
        b=OLM8xjp6RRog4lychx6y4rpILZ4+pFqRvA6dzgeuuPVqlfQdN0gyuzHmEDOeoB8JgV
         /gWSaT/RN9PrYnmWWYcgvsoBZLMbK4fwTtGr6wciatZn77/cFdZhgWiIz4r9fpLFI3mz
         FVUwmuSpBLTw2ccmZg0Umf6kmRODE+762mkV7sGHN162QiS2Mf1bBfTJyt6goSt/jazm
         ho47oMTlVJIOuv/5WbTir2t4hvhXTHsorBXbQhLiSjIQSDVgeWSX3II+CS25Ldt/l7c6
         AG5+7HlJTS7hp1XowJmTkfnCWU7Ks2M4wSON3iSm7uFp+zZZEcnVwoZHzyzCnEyacoKe
         tb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oRrR0Bomgu4d4wxrr7e8CuFo7o1Kuq9WCM1ColLyvcI=;
        fh=IqI/Cp1xYGcfpyBgkhc6h3oFTMbeXOsSrhhlFByRLHg=;
        b=eJJBdP1zVjmXfz43B9ymopUrNsgLcrX7R4TI+WZ+3qJkiQ4JFer3yP6Fk71xvTof75
         8QzUV7TDBkKMTIqzHoWY6l0Z4J0lKjes0OMpmQ8KGOhXk9s4tqGOryAvLp8OOnsE9YwC
         gkFE3O+kBbDjm+/yBXZHOvFNuaGbvnfVJbWl9QqvZ1feOJJdlVpSaLn7lRk8cjttLaPj
         SCxN1hR184ydF9QiOtYJiISmm8gvPVkB0+GpdBRJo8pZOt+87AHyOP+LKyIr0jeMqQWI
         bqkfyZiDGwyZB+cFCFdnMT6z7y+WRPYpcqcBz+qSBc+JJc6KM3eeafzOkDjgoEEwOs2l
         TlOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786643832; x=1787248632; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oRrR0Bomgu4d4wxrr7e8CuFo7o1Kuq9WCM1ColLyvcI=;
        b=CPbDHVpTdEBQJQXdYOBYXuWWwMdTZuHlRdueUPQaAfXyu8IQfk3fGvKUF0cdVS00dq
         dpJwxrdqXr2iIBvzdrmavxPR6025UZxc3Mj1Jtg2lMRgFDDq0ggxVoEHgvApICMsg2D8
         nrO3Ey3pXETqi1qgmHiD5wQLeiTwdmuckK7hUWTS4l+Qg37Tpqmnk+YE5sfNpZ7edGO1
         gWq3eUu95aAWNoZv0pR5mJ2ATZrqcU2Sbta+7nYEgJncEFj875p2ldIDg4usN4jP6MSN
         a8Fustvi4iSv/ks9Y5CPh7Nl93/MRc+xX0p8zAi4Xf3++n2hgCotOM7dc4y9x/6FilTu
         Nxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786643832; x=1787248632;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oRrR0Bomgu4d4wxrr7e8CuFo7o1Kuq9WCM1ColLyvcI=;
        b=TVVuV1+C4eE2rh+d5UeTksTLf2YJQfqafPdnyMz79rteFd+nQpEFI//ecrHaD7KBG9
         4G6ActSGiJseMl7tjxIAW+deR3FiUw1KNZXtqGSoHzaKBXVT4gSs+8ue0n2aNz9xKwxz
         nTSHLJQJr32hhld0sMY2jrNytwG/c/IPItUS081I8uzGpi+0OMjPZXwOaJq6woF5eC0X
         mOzFwS4dR3AT6WLh4mFEa55yVL+2/sPV9KFNIm0718HnWh4YV/OL4fmalC/byWanZ6Zh
         bBttUXMyFTkPquWRyH7fO3JrpN1u3MfvoO85VhkLS7dk3k93zwHYw7F09Bdwa5AGbHgC
         H8vQ==
X-Gm-Message-State: AOJu0YxF8JyStrI1bEHsWtZZuMauEH4hI/nzc6K2QTVTY02AMV4ENsjF
	1bNSZ775nXQUIKyHlyFzA0d6jkHOkdXZ8v4lScmJXuF7UbzE6RW58TFJIvEWGQ1OLFE76TEBGXa
	AnSWg0nyfVLsvE+mfbNQIPrc1/nvKwgs=
X-Gm-Gg: AR+sD10ekirbWWKq7LXzkINSw7EUOlhxExVspiEt8zqcqxIMEChS0DpBApdBHnAPgL2
	+BUTkZx+9fvpdkoxamZ7mlhmMzq1TxXXKO0dAPV5yGYLpBWWIQbF4m16ZQxj7nfemzkUCLuLFsW
	7R35fjiNjkzWcnXhkECPxNIn3I6crR68Hnr3L6R1ev9UdMLtUTwybQsSfSH88gocml41k3kbRB6
	MlFhaJcuWyI+89U9vhz76VG4dBhscmhkkthAO2uPPZD878r3wyRS5hhx8YwXvFfASad/xGeEzRK
	00OBXBRnQBzvbcD7Nv8wOUJciRrs7WnddFDwX/r21vzmf9kPM5NxExhH1YMyau4lR04vtvuO3lv
	mT3xhOwTeAJqwt9qII9NLlHIWQUwlJWOZO6DYAw8RCQ==
X-Received: by 2002:a05:6a20:2450:b0:3cb:b6b0:1ada with SMTP id
 adf61e73a8af0-3cc57c406a3mr8656424637.13.1786643831419; Thu, 13 Aug 2026
 10:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813152324.97937-1-leon.hwang@linux.dev> <20260813152324.97937-7-leon.hwang@linux.dev>
In-Reply-To: <20260813152324.97937-7-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 13 Aug 2026 10:56:56 -0700
X-Gm-Features: AUfX_mxq5bBvm13KR6j4JCv_EZxTyHWyf2WYiBiHTsTVuDjtgVzk5Qn_fEDssmU
Message-ID: <CAEf4BzYRqZ--=5d2LBWA=mOL72CYe4y4iCGS3c5Dw8PEd9BOiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 06/10] bpftool: Generate skeleton for global
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

On Thu, Aug 13, 2026 at 8:24=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Enhance bpftool to generate skeletons that properly handle global percpu
> variables. The generated skeleton now includes a dedicated structure for
> percpu data, allowing users to initialize and access percpu variables mor=
e
> efficiently.
>
> For global percpu variables, the skeleton now includes a nested
> structure, e.g.:
>
> struct test_global_percpu_data {
>         struct bpf_object_skeleton *skeleton;
>         struct bpf_object *obj;
>         struct {
>                 struct bpf_map *percpu;
>         } maps;
>         // ...
>         struct test_global_percpu_data__percpu {
>                 int data;
>                 char run;
>                 struct {
>                         char set;
>                         int i;
>                         int nums[7];
>                 } struct_data;
>                 int nums[7];
>         } *percpu;
>
>         // ...
> };
>
>   * The "struct test_global_percpu_data__percpu *percpu" points to
>     initialized data, which is actually "maps.percpu->mmaped".
>   * Before loading the skeleton, updating the
>     "struct test_global_percpu_data__percpu *percpu" modifies the initial
>     value of the corresponding global percpu variables.
>   * After loading the skeleton, "maps.percpu->mmaped" has been marked as
>     read-only in libbpf. If users want to update the global percpu
>     variables, they have to update the "maps.percpu" map instead.
>   * For lightweight skeleton, "lskel->percpu" will be protected by
>     "mprotect(p, sz, PROT_READ)".
>   * For subskeleton, those variables of global percpu data will be
>     skipped.
>
> Acked-by: Quentin Monnet <qmo@kernel.org>
> Assisted-by: Codex:gpt-5.5-xhigh
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/bpf/bpftool/gen.c       | 53 +++++++++++++++++++++++++++--------
>  tools/lib/bpf/skel_internal.h | 24 ++++++++++++++--
>  2 files changed, 63 insertions(+), 14 deletions(-)

[...]

> @@ -263,13 +269,24 @@ static bool is_mmapable_map(const struct bpf_map *m=
ap, char *buf, size_t sz)
>                 return true;
>         }
>
> -       if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF=
_F_MMAPABLE))
> +       if (!bpf_map__is_internal(map))
>                 return false;
>
>         if (!get_map_ident(map, buf, sz))
>                 return false;
>
> -       return true;
> +       if (bpf_map__map_flags(map) & BPF_F_MMAPABLE)
> +               return true;
> +
> +       if (bpf_map__type(map) =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +               return bpf_map__btf_value_type_id(map) !=3D 0;

why do we need this btf_value_type_id() check? in what case it's
expected that there will be no BTF info set?

> +
> +       return false;
> +}
> +
> +static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t=
 sz)
> +{
> +       return is_skel_data(map, buf, sz) && bpf_map__type(map) !=3D BPF_=
MAP_TYPE_PERCPU_ARRAY;
>  }
>

[...]
