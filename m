Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09393387368
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770739391; cv=none; b=caWqN1nNXR3rMBcTJbHI7d+aUuUBD1i+mjSN9SubpALVnW2r24NTAt07M+ex5hv4ZIDDX3E3+npuL4kvqHSiaA6U1E0uA5NQ297IecYKo83dHyZJxwddtRl1RaO/iH8zNpeuL9tVX8RoHHSDCBuh6y6IoZ/wRSLq1fcLSV/m00w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770739391; c=relaxed/simple;
	bh=vtBiLg74R0AE9nkJEKRZ94vEBP/led6ZWnBGdVmQpJM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DCTvI7jHQmMafxoeLukZ6IvS/cVKVP/wyCUbPZwFGAnY7e1Izm/QAGw0nrCqJNBqhJKdvQiUfHUPciqzGYWg0VkvlHcjXb3V2k3v5MfbuLUxvKtejMYfkYkQcO9rRgnca1bCKhvQrr5Z5JDvr9rCBDiEDOw+C49r0PLHmIHuSVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=RdY6fdFG; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="RdY6fdFG"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8966bd9da41so26542936d6.2
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 08:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770739388; x=1771344188; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFhrfCjWVSs9KEdL861h6NIGOyQrXHePbWPW/VETLng=;
        b=RdY6fdFGT0f/yNDwSkk+LDYeL0PleZ/4vAnPum606qMHlM/5UVev0FJr/DCZHVsDCY
         T8m8mV1smitF06mEigk93zI/9ZGLUbEWHllYGqbQgG5237T3Ze+M2m8EqjVybhtJNPIS
         7q+LgwB/SjFUMQacVgMEKUbUVv/6c8fYwjRKIS3tjl/Tu2qXMc5hVarHXQxwo29Fuqi8
         eQos7WhEthidf1CCFvl0wBIQgopthPdT7gH5ASWkk/iY7DXWXx5aUCMosyC0DflnFNBj
         KU5AH1gJrQM31PV3OZiNiVQVdXRwFIAkU/ZkSgb9Q5+uufA2R7k96L4bozZGB/APIB1l
         Vpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770739388; x=1771344188;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IFhrfCjWVSs9KEdL861h6NIGOyQrXHePbWPW/VETLng=;
        b=cDJt+Xg/6NtofIwHiH3QS+KGp2Aq+Ldg4PWkWbufFrJFlA+TqHMZFBKQSQLsBzyJE6
         XYZOGNDk+HN72ct1PlfQW9dqHfDbu8NF1XRfhPiDS4eS9ZzPZQ1oATM9DPP7lNPUpdyh
         bLjtL6o6pc298+LU+P9J8PLhWfCf9I1zXZ4/3234lXfYOuKNay+DH1FN/zZ+Mxe4nbUp
         GpQeBdby190t/TFcIJ5WoswC0suYtRAp98TUqrcrns7UoWWI0IPLUk2z9DVNcFIsn1s6
         G1fEJdOqNWdHLuyyZ7d3oD8x/Sh+U9vtgEoRmfiJSZAJc6KUOCKxNK3jQnAX5+ge7dkb
         Hegw==
X-Gm-Message-State: AOJu0YzwMs2LftxLQkBBZXuXarZFk+2xizxrDmVSP8OI2bWuTUy0rU38
	MAXowEUwJ4uPsxNOM0LDMOiWt2cdAmdDQfBa6UmMB6AGfxVaR5YqxGOGY8GuUjVuWts=
X-Gm-Gg: AZuq6aIpGezLB/z/VHxoVc+wjSEDtUC6fdqMZFkh20ZRkgLRd8WXo/EWC7a2jTkzVdo
	+aI6TEfDTkxc6MdB/ZMHJEhTz3CrD0RdrjZv7qcZAaYCOd9a4PPtyl/WtCjE8/r7VE+6o8t7bo8
	EoarnkPp0Vwzj/0ifg9Y/7bfE6wFg9HTpCkcWKsxAsBx0EcU1AXb/Zs8ikE/xAjmkULLpgy1BoO
	IWlFakGn9Rdd2Clsk3V7kyVIqTxVNLUmjdGLZQP84Liv94OaDl5/cLwrlmU3j8hY7PS8GOgWl0f
	LEHrQjmlb1axHUcSGonMzXrx4g2djr3E6aIg0llkah9ANrp1K6z2ngVipbIsShFdh1q9xyywe8k
	2TCVbvPI74wDPIdv/johg1h6eRQJ2YAqx4RvRTI6cqAQEUnEXsQ9WeOm1NheL6BEfpdmEYmV8bl
	9Go9xGheTlZs69FaBhi+fOPxYQ/rGDxdNE9w==
X-Received: by 2002:ad4:5ce3:0:b0:894:6d3c:224c with SMTP id 6a1803df08f44-8953c7b0b23mr235017186d6.13.1770739387229;
        Tue, 10 Feb 2026 08:03:07 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9a1575asm1151778685a.32.2026.02.10.08.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 08:03:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Feb 2026 11:03:04 -0500
Message-Id: <DGBEQ37JLW22.2IFYZDGMHZI2G@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <martin.lau@kernel.org>,
 <memxor@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3] libbpf: Add gating for arena globals
 relocation feature
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260210005508.3642641-1-emil@etsalapatis.com>
 <CAEf4BzaLqWT1oj-EXibyAfE0ExmiaCCqhosRujDi7Y0Nyho6dA@mail.gmail.com>
In-Reply-To: <CAEf4BzaLqWT1oj-EXibyAfE0ExmiaCCqhosRujDi7Y0Nyho6dA@mail.gmail.com>

On Tue Feb 10, 2026 at 1:54 AM EST, Andrii Nakryiko wrote:
> On Mon, Feb 9, 2026 at 4:55=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>>
>> Add feature gating for the arena globals relocation introduced in
>> commit c1f61171d44b. The commit depends on a previous commit in the
>> same patchset that is absent from older kernels (12a1fe6e12db,
>> "bpf/verifier: Do not limit maximum direct offset into arena map").
>> Without this commit, arena globals relocation with arenas >=3D 512MiB
>> fails to load and breaks libbpf's backwards compatibility.
>>
>> Introduce a libbpf feature to check whether the running kernel includes
>> patch 12a1fe6e12db, and only relocate arena globals if it does.
>>
>> CHANGELOG
>> ---------
>>
>> v2 -> v3 (https://lore.kernel.org/bpf/20260209234850.2750149-1-emil@etsa=
lapatis.com/)
>>
>> - Rename feature to better specify the verifier feature it probes for
>>   (Andrii)
>>
>> v1 -> v2 (https://lore.kernel.org/bpf/20260209210240.2051209-1-emil@etsa=
lapatis.com/)
>>
>> - Reworked test to use simpler array-based program (Andrii)
>>
>> Fixes: c1f61171d44b ("libbpf: Move arena globals to the end of the arena=
")
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  tools/lib/bpf/features.c        | 92 +++++++++++++++++++++++++++++++++
>>  tools/lib/bpf/libbpf.c          |  7 ++-
>>  tools/lib/bpf/libbpf_internal.h |  2 +
>>  3 files changed, 99 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
>> index b842b83e2480..034ea9b20617 100644
>> --- a/tools/lib/bpf/features.c
>> +++ b/tools/lib/bpf/features.c
>> @@ -506,6 +506,95 @@ static int probe_kern_arg_ctx_tag(int token_fd)
>>         return probe_fd(prog_fd);
>>  }
>>
>> +static int probe_ldimm64_full_range_off(int token_fd)
>> +{
>> +       const size_t bufsz =3D 1024;
>
> buf_sz, but really just
>
> char log_buf[1024]; and use sizeof(log_buf) below
>
>> +       int btf_fd, prog_fd, map;
>> +       char log_buf[bufsz];
>> +       int ret;
>> +       static const char strs[] =3D "\0f\0";
>> +       const __u32 types[] =3D {
>> +               /* [1] FUNC_PROTO `void(void)` */
>> +               BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 0),=
 0),
>> +               /* [2] FUNC 'f' -> FUNC_PROTO (main prog) */
>> +               BTF_TYPE_ENC(1 /* "f" */, BTF_INFO_ENC(BTF_KIND_FUNC, 0,=
 BTF_FUNC_GLOBAL), 1),
>> +       };
>> +       LIBBPF_OPTS(bpf_map_create_opts, map_opts,
>> +               .token_fd =3D token_fd,
>> +               .map_flags =3D token_fd ? BPF_F_TOKEN_FD : 0,
>> +       );
>> +       LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
>> +               .token_fd =3D token_fd,
>> +               .prog_flags =3D BPF_F_SLEEPABLE | (token_fd ? BPF_F_TOKE=
N_FD : 0),
>
>  SLEEPABLE just for SYSCALL program? let's use TRACEPOINT and keep it sim=
ple
>
>> +               .log_buf =3D log_buf,
>> +               .log_size =3D bufsz,
>> +       );
>> +       struct bpf_insn insns[] =3D {
>> +               BPF_LD_MAP_VALUE(BPF_REG_1, 0, 1UL << 30),
>> +               BPF_EXIT_INSN(),
>> +       };
>> +       const struct bpf_func_info_min func_infos[] =3D {
>> +               { 0, 2 }, /* main prog -> FUNC 'f' */
>> +       };
>
> unnecesasry
>
>> +       int insn_cnt =3D ARRAY_SIZE(insns);
>> +
>> +       btf_fd =3D libbpf__load_raw_btf((char *)types, sizeof(types), st=
rs, sizeof(strs), token_fd);
>> +       if (btf_fd < 0)
>> +               return 0; /* BTF not supported at all */
>> +
>
> Do we need BTF at all? Have you tried this without it?
>
>> +       map =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr", sizeof(int), 1=
, 1, &map_opts);
>
> nit: map_fd for consistency with prog_fd
>> +       if (map < 0) {
>> +               ret =3D -errno;
>> +               pr_warn("Error in %s(): %s. Couldn't create simple array=
 map.\n",
>> +                       __func__, errstr(ret));
>> +               close(btf_fd);
>> +               return ret;
>> +       }
>> +       insns[0].imm =3D map;
>> +
>> +       prog_opts.prog_btf_fd =3D btf_fd;
>> +       prog_opts.func_info =3D &func_infos;
>> +       prog_opts.func_info_cnt =3D ARRAY_SIZE(func_infos);
>> +       prog_opts.func_info_rec_size =3D sizeof(func_infos[0]);
>
> unnecessary
>
>> +
>> +       prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_SYSCALL, "global_reloc",=
 "GPL", insns, insn_cnt, &prog_opts);
>> +
>
> let's use TRACEPOINT as one of the most basic program types
>
> also "global_reloc" as a name doesn't match, really
>
>> +       ret =3D -errno;
>> +       close(map);
>> +       close(btf_fd);
>> +
>> +       if (prog_fd >=3D 0) {
>> +               pr_warn("Error in %s(): Program loading unexpectedly suc=
ceeded.\n",
>> +                       __func__);
>> +               close(prog_fd);
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* Be conservative and NULL terminate the buffer to ensure strst=
r terminates. */
>> +       log_buf[bufsz - 1] =3D '\0';
>
> let's not be conservative, trust the verifier :)
>
>> +
>> +       /*
>> +        * Feature is allowed if we're not failing with the error messag=
e "direct value
>> +        * offset of %u is not allowed that was removed in 12a1fe6e12db
>
> missing quote after "is not allowed", also try to keep commit hash +
> subject on single line if possible (see my diff below, it looks pretty
> straightforward to achieve that)
>
>> +        * ("bpf/verifier: Do not limit maximum direct offset into arena=
 map").
>> +        * Instead, we should be failing with the message "invalid acces=
s to map value
>> +        * pointer". Ensure we match with one of the two and we're not f=
ailing with a
>> +        * different, unexpected message.
>> +        */
>> +       if (strstr(log_buf, "direct value offset of"))
>> +               return 0;
>> +
>> +       if (strstr(log_buf, "invalid access to map value pointer") =3D=
=3D NULL) {
>
> !strstr()
>
>> +               pr_warn("Error in %s(): Program unexpectedly failed with=
 message: %s.\n",
>> +                       __func__, log_buf);
>> +               return ret;
>> +       }
>> +
>> +       /* Feature is on. */
>> +
>
> unnecessary comment
>
>> +       return 1;
>> +}
>> +
>>  typedef int (*feature_probe_fn)(int /* token_fd */);
>>
>>  static struct kern_feature_cache feature_cache;
>> @@ -581,6 +670,9 @@ static struct kern_feature_desc {
>>         [FEAT_BTF_QMARK_DATASEC] =3D {
>>                 "BTF DATASEC names starting from '?'", probe_kern_btf_qm=
ark_datasec,
>>         },
>> +       [FEAT_LDIMM64_FULL_RANGE_OFF] =3D {
>> +               "Full range LDIMM64 support", probe_ldimm64_full_range_o=
ff,
>
> this description is used in the middle of sentence, it should start
> with lowercase (see other descriptions where the first word is not
> some abbreviation like BTF).
>
>> +       },
>>  };
>>
>>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature=
_id feat_id)
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 0c8bf0b5cce4..93e59ed8d9a1 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -3009,8 +3009,11 @@ static int init_arena_map_data(struct bpf_object =
*obj, struct bpf_map *map,
>>         memcpy(obj->arena_data, data, data_sz);
>>         obj->arena_data_sz =3D data_sz;
>>
>> -       /* place globals at the end of the arena */
>> -       obj->arena_data_off =3D mmap_sz - data_alloc_sz;
>> +       /* place globals at the end of the arena (if supported) */
>> +       if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF))
>> +               obj->arena_data_off =3D mmap_sz - data_alloc_sz;
>> +       else
>> +               obj->arena_data_off =3D 0;
>>
>>         /* make bpf_map__init_value() work for ARENA maps */
>>         map->mmaped =3D obj->arena_data;
>> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inte=
rnal.h
>> index fc59b21b51b5..974147e8a8aa 100644
>> --- a/tools/lib/bpf/libbpf_internal.h
>> +++ b/tools/lib/bpf/libbpf_internal.h
>> @@ -392,6 +392,8 @@ enum kern_feature_id {
>>         FEAT_ARG_CTX_TAG,
>>         /* Kernel supports '?' at the front of datasec names */
>>         FEAT_BTF_QMARK_DATASEC,
>> +       /* Kernel supports LDIMM64 imm offsets past 512 MiB. */
>> +       FEAT_LDIMM64_FULL_RANGE_OFF,
>>         __FEAT_CNT,
>>  };
>>
>
> So overall this patch gets the job done, but I think we should tighten
> it up. I was curious why you have so much ceremony, so applied your
> patch locally and tried to strip everything I thought unnecessary
> (plus reformatted that big comment to be a bit more greppable). Here's
> what I got and it seems to do the job...
>
> pw-bot: cr
>

So to recap:

a) Remove BTF as it's not necessary
b) func_infos is also not needed
c) Use sizeof(log_buf) to avoid having a separate variable
d) Use a TRACEPOINT program to avoid the SLEEPABLE flag

Will update with those.

For two of the changes I have questions:

>
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index 034ea9b20617..6e27aa618e70 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -508,90 +508,64 @@ static int probe_kern_arg_ctx_tag(int token_fd)
>
>  static int probe_ldimm64_full_range_off(int token_fd)
>  {
> -       const size_t bufsz =3D 1024;
> -       int btf_fd, prog_fd, map;
> -       char log_buf[bufsz];
> +       int prog_fd, map_fd;

Should we rename here? Every test program in this file uses map for map.
No strong opinions one way or the other.

> +       char log_buf[1024];
>         int ret;
> -       static const char strs[] =3D "\0f\0";
> -       const __u32 types[] =3D {
> -               /* [1] FUNC_PROTO `void(void)` */
> -               BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 0), =
0),
> -               /* [2] FUNC 'f' -> FUNC_PROTO (main prog) */
> -               BTF_TYPE_ENC(1 /* "f" */, BTF_INFO_ENC(BTF_KIND_FUNC,
> 0, BTF_FUNC_GLOBAL), 1),
> -       };
>         LIBBPF_OPTS(bpf_map_create_opts, map_opts,
>                 .token_fd =3D token_fd,
>                 .map_flags =3D token_fd ? BPF_F_TOKEN_FD : 0,
>         );
>         LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
>                 .token_fd =3D token_fd,
> -               .prog_flags =3D BPF_F_SLEEPABLE | (token_fd ? BPF_F_TOKEN=
_FD : 0),
> +               .prog_flags =3D token_fd ? BPF_F_TOKEN_FD : 0,
>                 .log_buf =3D log_buf,
> -               .log_size =3D bufsz,
> +               .log_size =3D sizeof(log_buf),
>         );
>         struct bpf_insn insns[] =3D {
>                 BPF_LD_MAP_VALUE(BPF_REG_1, 0, 1UL << 30),
>                 BPF_EXIT_INSN(),
>         };
> -       const struct bpf_func_info_min func_infos[] =3D {
> -               { 0, 2 }, /* main prog -> FUNC 'f' */
> -       };
>         int insn_cnt =3D ARRAY_SIZE(insns);
>
> -       btf_fd =3D libbpf__load_raw_btf((char *)types, sizeof(types),
> strs, sizeof(strs), token_fd);
> -       if (btf_fd < 0)
> -               return 0; /* BTF not supported at all */
> -
> -       map =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr", sizeof(int),
> 1, 1, &map_opts);
> -       if (map < 0) {
> +       map_fd =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr",
> sizeof(int), 1, 1, &map_opts);
> +       if (map_fd < 0) {
>                 ret =3D -errno;
>                 pr_warn("Error in %s(): %s. Couldn't create simple
> array map.\n",
>                         __func__, errstr(ret));
> -               close(btf_fd);
>                 return ret;
>         }
> -       insns[0].imm =3D map;
> -
> -       prog_opts.prog_btf_fd =3D btf_fd;
> -       prog_opts.func_info =3D &func_infos;
> -       prog_opts.func_info_cnt =3D ARRAY_SIZE(func_infos);
> -       prog_opts.func_info_rec_size =3D sizeof(func_infos[0]);
> -
> -       prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_SYSCALL, "global_reloc",
> "GPL", insns, insn_cnt, &prog_opts);
> +       insns[0].imm =3D map_fd;
>
> +       prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, "ldimm64_off"=
, "GPL",
> +                               insns, insn_cnt, &prog_opts);
>         ret =3D -errno;
> -       close(map);
> -       close(btf_fd);
> +       close(map_fd);
>
>         if (prog_fd >=3D 0) {
> -               pr_warn("Error in %s(): Program loading unexpectedly
> succeeded.\n",
> -                       __func__);
> +               pr_warn("Error in %s(): Program loading unexpectedly
> succeeded.\n", __func__);
>                 close(prog_fd);
>                 return -EINVAL;
>         }
>
> -       /* Be conservative and NULL terminate the buffer to ensure
> strstr terminates. */
> -       log_buf[bufsz - 1] =3D '\0';
>

Should we remove this? If there is no guarantee the buffer has a NUL
character somewhere, the strstr can fly off past the end of the array.

>         /*
> -        * Feature is allowed if we're not failing with the error
> message "direct value
> -        * offset of %u is not allowed that was removed in 12a1fe6e12db
> -        * ("bpf/verifier: Do not limit maximum direct offset into arena =
map").
> -        * Instead, we should be failing with the message "invalid
> access to map value
> -        * pointer". Ensure we match with one of the two and we're not
> failing with a
> +        * Feature is allowed if we're not failing with the error message
> +        * "direct value offset of %u is not allowed" that was removed in
> +        * 12a1fe6e12db ("bpf/verifier: Do not limit maximum direct
> offset into arena map").
> +        * Instead, we should be failing with the message "invalid
> access to map value pointer".
> +        * Ensure we match with one of the two and we're not failing with=
 a
>          * different, unexpected message.
>          */
>         if (strstr(log_buf, "direct value offset of"))
>                 return 0;
>
> -       if (strstr(log_buf, "invalid access to map value pointer") =3D=3D=
 NULL) {
> +       if (!strstr(log_buf, "invalid access to map value pointer")) {
>                 pr_warn("Error in %s(): Program unexpectedly failed
> with message: %s.\n",
>                         __func__, log_buf);
>                 return ret;
>         }
>
> -       /* Feature is on. */
> -
>         return 1;
>  }
>
>> --
>> 2.49.0
>>

