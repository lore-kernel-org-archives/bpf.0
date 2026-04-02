Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE5F2E54D3
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161898; cv=pass; b=SoOpNvFlOVoDTR6I7bplMgKXl0CUTQvIml1G+TsGY2iEAdvZ0AGl7kw4cFjWUU9p3D/BBPH5HcFs0vUu9Xapk+CIHtraFMWUENFIfWTJWcFgQhzBAuoovaNxjWiFKkJsAuzZtf0nCkFZdGnoY1bQ/VZAmNohoSZ31VZnxL6UwFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161898; c=relaxed/simple;
	bh=iRWW5i9syRNhtk99KdK2l6X5nFow1OsKtjnhHvQscv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brSNwDBZUnCOovQoJ9GFmp6n3HZViYnmEWBMdM+K6z/f2bAi260A4UBZSrS3bAF7xdaXx1vuRKc1cxHi/yy6wwRoi1HAcrF6+Ec0SR9eViql6ePPbMDQZwZgIGjMB/3ITFyyASO7YaueZehbfbwwbTDbBayEFceijyPw9DiZVFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDDvZZyP; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDDvZZyP"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c742d4df00cso1038039a12.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 13:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775161897; cv=none;
        d=google.com; s=arc-20240605;
        b=QfUCoO1NwhNG62cRpl54iNZEtCE0GRKtet95zfUVCkF+pkrbINGbyy8VAnQa+E24GZ
         0cqYlFHtiAbGPlQ5DzUPUdmReu3VcHnkIZMUgqYelQxiaiBVU8Mj3SHJ1mNcUcpaNOZ2
         YIpc2G2Qv7HLsZaqeOo215UuwVTrNR/KNXGFJGZHkKruaT7RJzPrmsKdrbvg527scnFN
         SHjtXh4p9vO4N7d8k+C1MSA/kiaeAyYHwe+DgZf1OE4vV939rd2ZP5UZGHEpj7N26F8Z
         DSFhN3q8zrs1utEelDSNSLY7YBcBdSjwPGtPGoWxumN7V4KPUF3kH3UEEAbSFi7XeXXb
         viWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JxjrkEVETjgQ/WFvUfh9XNex3oaJGt52TcAC/zTYsfo=;
        fh=Ywe8s23bwk/eEPH4D2/tCC08mZncmdqOrrvGfDUmuOg=;
        b=J9iQibQR9g2bJFexkXjfF/KYwUHMCCtXXcSNkY3xUMKm0vJb6f57FJTnXZ3L+nHJbj
         OUneCyl4cA02Q/fmJwK1d7oVQ6eiJPgdar0ubaeD3ZyofMntCqHtSpQs9sa6/Rz3Ppod
         IHmnEPhwA2WOLh8eNF2TpoOm2zHphRkJL3+6HZGmCilnDckS58s3oOnJlqr57DcRU+h8
         R+27Jvnhj5kC8Za10tmH4kqpkNkZUm5+4YMewiKyPRVpdFTcf/oqoY/IPxl6qKjnFZOH
         KME8I6rU6x5BR7kUBor+v31gufqlG8uUoLeeQyDJsJHFg2yZqd27kNepY8uGBZw43OvC
         ogGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775161897; x=1775766697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxjrkEVETjgQ/WFvUfh9XNex3oaJGt52TcAC/zTYsfo=;
        b=nDDvZZyPhsp09HMShsqzoB+LmGHsVVKXoq5kldAkk+ALzFDY2tNDh9UU+NQYvR8iGY
         hzjgBxtB+VWSCtfZkn9njvMoRoaSdS8t7NH6El9frQMLAQxlHrHczkSXF5NZ0c770oKx
         kQr741cg0wogEWNVRvwZbm+efhpjC2giuDKpCd1EWqVFs2ZlU5Q/EHcfbcfUjteg8N68
         Wn2kSspO5nR3ExeNvjPgRxVZN+E1KN8xLLtVGuF78qkmPcg7+FN5iUc0DSgp0D8t4FzL
         FUxgDEn9b0R/vjMRVMszVgOiycmXZzl3f6LW0k0q6PgnmNws1nT6AZVB7cTfafVUb5ex
         XUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775161897; x=1775766697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JxjrkEVETjgQ/WFvUfh9XNex3oaJGt52TcAC/zTYsfo=;
        b=TXNPIz2Wt1XITtr5d/MRYWUg2+YGIaIVJdEja1IJ6WLRy1Sg6fQDXySl7Q1+8bGUED
         +8ASVU80ZqGd7qTaP5XvsJ8H106q5lM6TLIeoqP98xPPrD3Pk0Qf/ogPiZDG1B/gHp7s
         Ccgk8Wmyjnxx2rMFyPrqF32sr6WSR6EsvixB1GM+aHWJGCqJw90bi89rXLGlzIccLkWB
         ZwbeON2t8uFUVanVm9QM6vXoSoU50Lum0+DMJyTak9oGEKubcgSotL2Knqj8ostloiDJ
         hlT2XcLFjizI1kmD1sz6y7Ci0dScsVb6v9mkX3jo87YaVyJmJkULhyDPd7U7zUtEqiB+
         iICA==
X-Forwarded-Encrypted: i=1; AJvYcCWOvwCJIjccvDC4c4ZkJIGoXpasN6bbi4E+qcn/8xBKTEQR7Ea4xy3n/UC2MlMtTk94xgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5mj3aS2Q4aiynuJ1DvSzVXSrZbq0ioSrpM9DY5fabVYQaRYtA
	qyPTPfcYWaxlP6qEzhyoiHy/zbu0pZzEenHulB6N7ptYdkiKeNnCmmCuRmjqfswU8SqOj980KCT
	DT49mZBfTffh3ZXDd0Yhx4S3TZJ0rVRs=
X-Gm-Gg: ATEYQzz+/wc1KHeFmJ9PnTtURrGhm4KJGVNrQzrAbr/YX53t094VRxuFUNnwQUnN296
	nIL4KTv0jgnEgfXjdu/ZPB9kyhyQ1rMg9DxqduBk8QA8be5g57YdjFayi8w57Y0vzg1/WjyNt51
	OuZl3YS/0aT0p+sgpWrmQ2tTzaFnjR65V5gneSdWjof7v2H+BLLEoK/BIMdOQt7fQErcciYx+bF
	sV8xlPLmJEnYX1EzRPv+4UlimLWpkhq3Bnw/cR3BS1TqjPqW9t8baIOO8hoos5ieX0VO1j+k6za
	xM1TycCxNT/gB/GIsA==
X-Received: by 2002:a05:6a20:244e:b0:39c:5952:eab8 with SMTP id
 adf61e73a8af0-39f16f73f95mr3711041637.15.1775161896983; Thu, 02 Apr 2026
 13:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401164302.3844142-1-alan.maguire@oracle.com> <20260401164302.3844142-2-alan.maguire@oracle.com>
In-Reply-To: <20260401164302.3844142-2-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Apr 2026 13:31:24 -0700
X-Gm-Features: AQROBzAkIfE8ESaSAXVnWABamgo3jeYND6UTCAqJxPZ2sNztcX4q2G2ITqwLQC4
Message-ID: <CAEf4BzYJhkj6x73AtbJZGJ494gVaApsG3PiTJPpyCJ2dA-639Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Allow use of feature cache for
 non-token cases
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 9:43=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> Allow bpf object feat_cache assignment in BPF selftests
> to simulate missing features via inclusion of libbpf_internal.h
> and use of feat_cache_set() and bpf_object__sanitize_btf() to
> test BTF sanitization for cases where missing features are simulated.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/libbpf.c          | 12 ++++++++++--
>  tools/lib/bpf/libbpf_internal.h |  3 ++-
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 9ea41f40dc82..9e4acda1f58f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3145,7 +3145,7 @@ static bool btf_needs_sanitization(struct bpf_objec=
t *obj)
>                !has_layout;
>  }
>
> -static struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, stru=
ct btf *orig_btf)
> +struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf =
*orig_btf)
>  {
>         bool has_func_global =3D kernel_supports(obj, FEAT_BTF_GLOBAL_FUN=
C);
>         bool has_datasec =3D kernel_supports(obj, FEAT_BTF_DATASEC);
> @@ -5203,12 +5203,20 @@ bool kernel_supports(const struct bpf_object *obj=
, enum kern_feature_id feat_id)
>                  */
>                 return true;
>
> -       if (obj->token_fd)
> +       if (obj->feat_cache)
>                 return feat_supported(obj->feat_cache, feat_id);
>
>         return feat_supported(NULL, feat_id);
>  }
>
> +/* Used in testing to simulate missing features. */
> +void feat_cache_set(struct bpf_object *obj, struct kern_feature_cache *c=
ache)
> +{
> +       if (obj->feat_cache)
> +               zfree(&obj->feat_cache);
> +       obj->feat_cache =3D cache;
> +}
> +
>  static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
>  {
>         struct bpf_map_info map_info;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index cabdaef79098..540d62d45989 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -414,6 +414,7 @@ struct kern_feature_cache {
>
>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id);
>  bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id =
feat_id);
> +void feat_cache_set(struct bpf_object *obj, struct kern_feature_cache *c=
ache);

let's call it bpf_object_set_feat_cache() (no double underscore, as
it's not a public API, but it's still sort of a method of bpf_object,
so let's have it a bit more explicit)

>
>  int probe_kern_syscall_wrapper(int token_fd);
>  int probe_memcg_account(int token_fd);
> @@ -427,7 +428,7 @@ int libbpf__load_raw_btf(const char *raw_types, size_=
t types_len,
>  int libbpf__load_raw_btf_hdr(const struct btf_header *hdr,
>                              const char *raw_types, const char *str_sec,
>                              const char *layout_sec, int token_fd);
> -
> +struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf =
*orig_btf);
>  int btf_load_into_kernel(struct btf *btf,
>                          char *log_buf, size_t log_sz, __u32 log_level,
>                          int token_fd);
> --
> 2.39.3
>
