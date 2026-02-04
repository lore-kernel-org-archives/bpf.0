Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983072367B5
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770231862; cv=pass; b=kbUSXxJp/wxybHa8ZoRFu30FAF6QWOpAPrRySy5pCcGrzHHj7g1p78l87Yw4GGOJx37RDvb94kRF6UhidlVF0khKpdTh0ND7E9Y/qJPS/8BcV4pes3ARpLfOHRudrTbgHDjC/T3B4drGcGRAQAJB7KTR/rjLHl9ZsElNtHPhRiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770231862; c=relaxed/simple;
	bh=Dc0nYxw/rN5N5J7dVW80Z++yUTLJFp4B0UMOXuMTVHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsZPNziFDdqxbLsnjHT8nqHDsesm/CJEwPL+qojHZNBFPplJszjpo7o6QFMjCEwSw6M2X3QwT8FjCWwpIsQkPjOcCxbm+rWg1xnPWkgJJjyXhKbQzgFjA0cm/X82FuIVgvMftvQTUnSASGafiboBW6o2lVmtyvIztd+sChVctgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqF8g+8T; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqF8g+8T"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c551edc745eso15015a12.2
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 11:04:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770231862; cv=none;
        d=google.com; s=arc-20240605;
        b=HGagUgqyyqC+jtFn6lfUDdJbFB83dNSsfenKz0HwdDwP0rB9k0hXH6KoZSJ5D7PrMR
         6jwvSIwEARd86BctYlBHkH0ooutRG4mS8Ov19YaK7kVuvnzgHXsGnzWPN8LFpfUcefMW
         wmB53scutoqQd7zRzew3Hef6Koul/kc6Prm3zc+qpWYmB0etmnVkJokq6CFBUSbjH0Ow
         pQHJQ7hTvJV/N2QbeG6JA8TiAsmrcsvGSFJrgtK2AdYaIAGvfQGdAJYYkgcekWGksPSg
         znOlMGcCAgK1+rwpxUw8wBj2y0YOy94qZew1DK5noFCzjygmSQXcXuj38bKeUGCxofWh
         KVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2Fd4Wltq4DRRCvRywlrd5PjkgyLi05+SN7qlk8MFKlo=;
        fh=eVHL9PYn1E57Z50qCejYd+GDueSTc1ySr9iyeUhY3P0=;
        b=ctgb2m2qWij6Hqm7rYiKXDWH0igwMwE6K4WXBXpROV51ozAvyyKmLqBJ9McwetnwaV
         79nOn+XigRHi0VF4bytLFukH4jluvoau4HZNDRBFbc10Ab5/o7uBPRSjpvgHryr1omE6
         2hfcYOlKYTkNpeR6YpMcvasNVq4/teIj1UObzBcCC/QZFzb9zuX+RR038Gvg48cDf5OV
         RAefUzyIWehBVpbQ92q0QPc+wFS/eiUa+oPF0Yo+DqSCls3pzXentuH8HD85f4WO4z6o
         Vax/QXrV988WLPV6Ibk59F1AdRYYYpuRo3IqqHfRtjyPV/VNr+1VrYUcneckQaxeVQf/
         MgNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770231862; x=1770836662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Fd4Wltq4DRRCvRywlrd5PjkgyLi05+SN7qlk8MFKlo=;
        b=ZqF8g+8T/zUsvF7DFuqBB8YrzWweYrP+KtBhv3adMvxWxJM2tlBMrBtv9FMY4pjIlR
         3KpfoX0WWKyEN2eD8bidQ+jAxPcb8cYsc9n8r2m/Q8S19TDmv9PYCCPi1cvamCO8RzKv
         7UfkTrK+YpEZ1qTjcT4gTVbDQdVaO5m/d78aUm+N6d/EiRzWXBMqnlxAmf88SMcLBa6j
         aFIrcub9f3kXXY0YpWraJyFVce/vyeavOUOP2cvysap6lUYjHoquUAlHR6VBjqo7hZSp
         7CQJw8YEby4k6WwdFrMsalHiZTw0M46pHxU3Qpn3pOY9U94BKC7ZJ9VvTouP5irIBnJK
         21lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770231862; x=1770836662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Fd4Wltq4DRRCvRywlrd5PjkgyLi05+SN7qlk8MFKlo=;
        b=YSSxCnngiN3XGypFBupre/afD7w4PAe8TbBQrH1fmi+VcCpkUNDgWUrqtQBNgaK02H
         OcIJsR/Jx1OzqXbAo3Qby6Mxyv2MDBEmRyOK1Xbp4xzi/mYwywhnVUMjFTxF8SYX68Ft
         hfDYbFigI8bL8c6+5ZEZ2IjCHgkzDV6u67NnMOV0EUfoHtTMzAejuT6OjSyua+nQCXtK
         KTt8E/K8tFpc+CR02tKS91wFF4KX8vPmeS1uFRw1gqj2LaMmbgRkcyi+4l/Z4vjvwiAt
         uRVc5+YQhfMlIK9JkpFWykIV1MquRx1+Ttp+77h9gA8r4Kw3JVdFMQzpvcUFslpTzQJF
         q3VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqLYksvbTadRw6dmpVzfMgbnK7eWMmc6xaiPA9BVMW1OIh9uNGIYce6oP0TDEfm+wadmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRGFfkv60iKbfQz3Pa16vWR330Z3gB0IoSv4kRiCeNOXDix2Y2
	Mh/FPVRm2ax/V0MIJ2L/eRKRp3NWRdHIbeWrNJnlN1lXzjZuPm1H/OUnHdMjQQLTE5LErDlb62H
	1kVDX5RI0ZFU8y4z2m+NUczpKwtuvBeeThg==
X-Gm-Gg: AZuq6aLIg9j44W78hJaYNxzBBIOY+18VF4VaKLN7n5NhteRAHXLycZJ4nnS7uYmrqOP
	E8dsN16VCQYWxK8BgbTU+KKUHx0VH/0hr7ewlk/O8O9KWLeLs8UEvGAZzPnr/Ssfp/nPso2U/rP
	ClpEZbGR3WOa/Fo1l7gUHNYjx53bpEQi/H/Sx4bK4HpdDQ/1Mh/pvupXFNGzi7vUSPgKhLEIfeW
	mXgX3+Wz+TyVxrskDHtI2SOgwBY9AUr4+sROV2EKhmfLmiydM0Ao8o4D9N9iL12txH67irQzG9b
	40HGfkFHS3I=
X-Received: by 2002:a17:90b:1a89:b0:341:8ad7:5f7a with SMTP id
 98e67ed59e1d1-354871951d6mr3910487a91.18.1770231861526; Wed, 04 Feb 2026
 11:04:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203093819.2105105-1-jolsa@kernel.org> <20260203093819.2105105-9-jolsa@kernel.org>
In-Reply-To: <20260203093819.2105105-9-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Feb 2026 11:04:09 -0800
X-Gm-Features: AZwV_QjTmRdFGEvb_WAqWPfjTYqkItrykLxxHEkIbtsV4rnebavgSBjlfpmxBwY
Message-ID: <CAEf4BzY7zZmEqFq577NiG2wh0aU0_og1_RjVSURjaqTOnTc-Bw@mail.gmail.com>
Subject: Re: [RFC bpf-next 08/12] libbpf: Add btf__find_by_glob_kind function
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, Menglong Dong <menglong8.dong@gmail.com>, 
	Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 1:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding btf__find_by_glob_kind function that returns array of
> BTF ids that match given kind and allow/deny patterns.
>
> int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
>                            const char *allow_pattern,
>                            const char *deny_pattern,
>                            __u32 **__ids);
>
> The __ids array is allocated and needs to be manually freed.
>
> The pattern check is done by glob_match function.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/btf.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/btf.h |  3 +++
>  2 files changed, 44 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 83fe79ffcb8f..64502b3ef38a 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1010,6 +1010,47 @@ __s32 btf__find_by_name_kind(const struct btf *btf=
, const char *type_name,
>         return btf_find_by_name_kind(btf, 1, type_name, kind);
>  }
>
> +int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> +                          const char *allow_pattern, const char *deny_pa=
ttern,
> +                          __u32 **__ids)
> +{
> +       __u32 i, nr_types =3D btf__type_cnt(btf);
> +       int cnt =3D 0, alloc =3D 0;
> +       __u32 *ids =3D NULL;
> +
> +       for (i =3D 1; i < nr_types; i++) {
> +               const struct btf_type *t =3D btf__type_by_id(btf, i);
> +               const char *name;
> +               __u32 *p;
> +
> +               if (btf_kind(t) !=3D kind)
> +                       continue;
> +               name =3D btf__name_by_offset(btf, t->name_off);
> +               if (!name)
> +                       continue;
> +
> +               if (deny_pattern && glob_match(name, deny_pattern))
> +                       continue;
> +               if (allow_pattern && !glob_match(name, allow_pattern))
> +                       continue;
> +
> +               if (cnt =3D=3D alloc) {
> +                       alloc =3D max(16, alloc * 3 / 2);
> +                       p =3D libbpf_reallocarray(ids, alloc, sizeof(__u3=
2));
> +                       if (!p) {
> +                               free(ids);
> +                               return -ENOMEM;
> +                       }
> +                       ids =3D p;
> +               }
> +               ids[cnt] =3D i;
> +               cnt++;
> +       }
> +
> +       *__ids =3D ids;
> +       return cnt;
> +}
> +
>  static bool btf_is_modifiable(const struct btf *btf)
>  {
>         return (void *)btf->hdr !=3D btf->raw_data;
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index b30008c267c0..d7b47bb0ba99 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -661,6 +661,9 @@ static inline struct btf_decl_tag *btf_decl_tag(const=
 struct btf_type *t)
>         return (struct btf_decl_tag *)(t + 1);
>  }
>
> +int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> +                          const char *allow_pattern, const char *deny_pa=
ttern,
> +                          __u32 **__ids);


as AI pointed out, this should be an internal helper, no? Let's also
not use double underscore pattern here,
"collect_btf_ids_by_glob_kind()" perhaps?

Also, you don't seem to be using deny_pattern, where you planning to?

Also, are there functions that we'll have BTF for, but they won't be
attachable? What if I do SEC("fentry.multi/*")? Will it attach or fail
to attach some functions (and thus fail the overall attachment)?

>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
> --
> 2.52.0
>
