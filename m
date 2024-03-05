Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24F517997
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665974; cv=none; b=KgVaU9OxnEH0ederhX7w2Ji8MrG45cvMjA2S7U+7234Dcc5GcfEXFns0yaOKVsmgGmcTmACM4pJX3LFRvIAG+Py+L0L7nYa2u+JTMdclDh81gNX8H48vEz6nAHIv/WncUfrBE/aLvc2Pnxubvjx/1yVlsSV/8y3EUzwhsHBVQlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665974; c=relaxed/simple;
	bh=jx6Rge/HL2/8Fkw+Fg5JjHkQfizW4JwlxG2CLvB1yBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bakkpjvde6O64vbGKj2Is85wr+IwgGMITqYr3a8QCKig+gznzKOmQP6gW0fbsZwQ9fm4pyrxXSs2Vzahnr3dNNjBK8J6VfxT9CM0k6bUC+nYbZdmZSci0D8nUGc2nSflf60j9hWnB0SfKN0yunm0udYbcrzdSoR36sPVarNL2As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDViyf1C; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDViyf1C"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e58d259601so61406b3a.3
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 11:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709665972; x=1710270772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Du+03rgZyIAaZxo8Mft1n9yPxFZja3KPt3aoH+gMxLo=;
        b=YDViyf1C9sz2OTYWG2n5qqW+ayqOkKaHd5hhIGoqOBqYuyTr7XCb6qR0TPmMc/ng8U
         M3/WSR6yYweFqChQ2lroW5//BtUHULt+OvjXHb1OVF55Mkc0YDJ8Uo8lhYTmgxw55ztM
         w4QoDe2ysOk6rEoSU5OC2KbLUrR6Y5TuaQcFjW4Nmq5+hrkyWjf2Wu7kyFYMNch9308w
         fN7MQjhb/7fZlCRs9gu5kzk8p29B3kRx3E8+IMWx6wpdhPjz9o/wNRb6ADdjvJ2q4w1y
         CmQjtn7+6JDggRy6wKvexmTKjoNDyQ3gHOwu+U8h9vV3xRjS1jYZyFePrMdKnThjvw3C
         pPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709665972; x=1710270772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Du+03rgZyIAaZxo8Mft1n9yPxFZja3KPt3aoH+gMxLo=;
        b=OxAjElbZCZ/oa8OTfrGPzrQbCFUiWwBGxdtKox86i4b0zUAjT5Z1PqxWtfpVcAavVm
         s4RbKr4I8OwXhryWsG2hCAE9n/IchwEBI2Vv82SwNe0PqBj5FCCb6Bi5Urd5POXl4YRD
         Lk/4ZpGvj97tNeFVIYHDfp18IW0P9dzRJc3+VuQItTZGcVqaEEiA0D18SWa8UhO4WYBX
         ZUN/cOTsmHR5/6POgADnad9jtDj0d7IS1tzG9cLS7SFKqaRTkb0FQCznKb+Moqk0TxCM
         1J8vPXZ6kXb0c05PTmRPL0I9dwpDj7/qwUrnLD4dj01vtpwSEARi9dcoQPaDJpSPDbGV
         cL8Q==
X-Gm-Message-State: AOJu0Yyi/3sgbckOjPHQ4NMceOFn6Q4K7V3fjRZh+EerWPhKL0d+eMQm
	L/T0JSwLUX1mYT0v6vKFH9qoXP8vKWyUoyX1GNJ75ZcBsRpUL7IjBvnR321upl68njOjICGt08+
	DVCvf+8yHLGl8ZH0vLscupugs/ck=
X-Google-Smtp-Source: AGHT+IFhXMsbiuV/Dwzywk6O0NkhsZmL5kCl9jhi0zhiu3l5EMkgRmU6Q/PVSvNABfOTuU5XlkGpWea+czOCz1WEg+g=
X-Received: by 2002:a05:6a00:1a8b:b0:6e3:fe0b:527 with SMTP id
 e11-20020a056a001a8b00b006e3fe0b0527mr15990465pfv.30.1709665971959; Tue, 05
 Mar 2024 11:12:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304225156.24765-1-eddyz87@gmail.com> <20240304225156.24765-2-eddyz87@gmail.com>
In-Reply-To: <20240304225156.24765-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Mar 2024 11:12:40 -0800
Message-ID: <CAEf4BzYrb9Dj6DpaZwb4ss7D8933ti_djXaAQ-LMV6z9SAE52g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/15] libbpf: allow version suffixes
 (___smth) for struct_ops types
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> E.g. allow the following struct_ops definitions:
>
>     struct bpf_testmod_ops___v1 { int (*test)(void); };
>     struct bpf_testmod_ops___v2 { int (*test)(void); };
>
>     SEC(".struct_ops.link")
>     struct bpf_testmod_ops___v1 a =3D { .test =3D ... }
>     SEC(".struct_ops.link")
>     struct bpf_testmod_ops___v2 b =3D { .test =3D ... }
>
> Where both bpf_testmod_ops__v1 and bpf_testmod_ops__v2 would be
> resolved as 'struct bpf_testmod_ops' from kernel BTF.
>
> Acked-by: David Vernet <void@manifault.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/libbpf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6c2979f1b471..e2a4c409980b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -948,7 +948,7 @@ static int find_btf_by_prefix_kind(const struct btf *=
btf, const char *prefix,
>                                    const char *name, __u32 kind);
>
>  static int
> -find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
> +find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw=
,
>                            struct module_btf **mod_btf,
>                            const struct btf_type **type, __u32 *type_id,
>                            const struct btf_type **vtype, __u32 *vtype_id=
,
> @@ -958,8 +958,12 @@ find_struct_ops_kern_types(struct bpf_object *obj, c=
onst char *tname,
>         const struct btf_member *kern_data_member;
>         struct btf *btf;
>         __s32 kern_vtype_id, kern_type_id;
> +       char tname[256];
>         __u32 i;
>
> +       snprintf(tname, sizeof(tname), "%.*s",
> +                (int)bpf_core_essential_name_len(tname_raw), tname_raw);
> +
>         kern_type_id =3D find_ksym_btf_id(obj, tname, BTF_KIND_STRUCT,
>                                         &btf, mod_btf);
>         if (kern_type_id < 0) {
> --
> 2.43.0
>
