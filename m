Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1224534A4
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530363; cv=pass; b=GmP3HaMxofQY5vY0Wt7XGYiPvlZxLWrq8oMnUiYnltS2E49LFt3fLob/wpQfvQD879l9zJi8xweOXONzDH3LSCaJiZcbCGy09adHvKItqyte3wwoI70acBfkPOyxofyVCgY9VybC2conYJBieIkNvNz0e3VuqRwv1V4gaPCzpHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530363; c=relaxed/simple;
	bh=d01pYYztsqtr84UOeep+EAdKFvu5qQUMAqF0BPgwHCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POAXlMjVUGvBsSIEFlScWU4k0CiFHRVstgBZc6KhNTSPD7YrNYQoiJxHWzoxwPiB9BiqjRuRcP+YqC3a6THU5oxVE5MtF2oePnpEcHYYuyDJHj4JESU1ORG4j1Ccny7/JZZK41+Grywvc80SFWrGWBoGkBJK7+sIzTIBZOzfx5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivOzzdmx; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivOzzdmx"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-842358aaf36so33154b3a.2
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 16:46:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780530361; cv=none;
        d=google.com; s=arc-20240605;
        b=HKknAZKbrqNVrS8jDFe5GOY/9zddacu5gKefWsMPxRlFBX7Y6rVNYUxcZ2tNQhhHVW
         TOSXXbcET3PVVzy4ofYj29pDYwMDIMM4CxK1etjYQgu4WOUTla6GgSSqVfcDeWLVC1Uc
         PAjsnhV8J8B7AcA00LtehcTntDeVX0qJqDpf/+TXnOQVbFcZMlqp1J43SawzVf7XEUkj
         b9MCKeod+fBibP1NO+pFRvy4SZ8gzlraJlHpx0dCyQH9dy49Mpbb9QH03JhoubqKqaKe
         vgeAVdh+l5B9bu5p6abRSvYck9HbC/AZLiylm0fxY8pLl7q5t5HKQat12b7w1T0r1fV4
         e2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pG3L/vpuUNwUku1IpHlYEh732YQ2/gOWib0SuE0t7Yg=;
        fh=gw+mcCGswI1Wv386kc0Uin1DCuooidSG9J9X8/6RnHg=;
        b=fMeqWVULmG11EfczkLq1uGBlUF/16B72aITCk/3D9PKcZq7bBpr1Dpts9WhBPVXPUX
         ZFy0m7mdDDbEtXDR8yy7onCj/tzgIxGVpAusQzqPrhK8jWL6Yl3m85HlmHZUWTCU1yXf
         HIJvlG4OKxizTYWH4XjWS1/vqC4qVwWIb0W48cz7OKwzZyKto/8DbSX+Ga2B2mWGU7zY
         JlcAqq1w9I88cDIEcmun7Xu+c1H9ExY2e0oi8lzLRWWniAWLTObtwGLX8VdtlN8MOOlN
         eN5ifgygd4e9x3lAcgSqazHEi+ic4BiurlE9bpQZD60FOhSZulieRTe2TcuH34OYfWeP
         37uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780530361; x=1781135161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG3L/vpuUNwUku1IpHlYEh732YQ2/gOWib0SuE0t7Yg=;
        b=ivOzzdmxa+KWAhYzkiuTuxBJdOZGPzZ7iHdJ37yZktGxF7ZaVTnD+SCFgqPaUrl6q9
         f1cP63vPeRi9vWXUgARe8EwvsnLRy0zCfhmUybtipIC+6rIAvF1hejlk/XFqXRu23pfD
         vqonU9kEQSXgXiG8ym5eTMfdZyemOblxvBcni2pGgAJbAUIwMzkjLdjP1RTcqSJ9xZL+
         iQ6MMgY0zlKO0HdKlLt74+kHPC90qPlwPbZmtpUsIv6sn21IVvMiTfif2Z8iMKCwh1TS
         qVO06NVKkLsv+OK6KWtVbqPdbF6Laww4b7L3K1yl5nm29U2cRzp+Ivi9yQCpqlybMr/F
         FhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780530361; x=1781135161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pG3L/vpuUNwUku1IpHlYEh732YQ2/gOWib0SuE0t7Yg=;
        b=qvZpxZpj0lb98y97l6DpRDTkv6ReFs5b3M6Vwqo9KMMOF+w9/J0fItTe6M7b+22RvP
         odOty4Alz6DHMtaTdVMt67ZqKJCRRn3hi+HIMOn5WhpqQMQDC2Ep34h8KTSM6zdbkgsz
         K9wiUI/hQOVIX7Y6Tv0haRS/nBfDpKkt6W5Yk65+8CQ6XtPJvk2+X1VYpJkWeixjD8Do
         DH6pYfWX9ScimCVsQ2ixeJw//C6drs/nojywqCyRCg9Eduew5omz0M7qdKygEte+eL+u
         6BQB+mCCXb46F+i5i2/BgiTi8/ta0oMI1G4pNbyN4t2YP7IwUw20avKcW1nUxKAraYW4
         iE1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/H7bNkxA09TV36UBwjsuOKsg98DJsf+GcfwJ5C5LMqCga49nJRJj0G/Hio+dVfCSNuimU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+My671aatnHprXSMeu1bS6u398ep2IYJ+pShSWnHOfrevPocu
	Xv1+nY2IefUWm/zqqIKhDAV0yh4POxfrMouxRzDq/In7LyYidVcqANA1r3E3zBAKzMjxqFiflLP
	kn83g+d8JMx3rqLt3xNkw++tTflC4M8s=
X-Gm-Gg: Acq92OGFp+0mlVgpaw/ZriVzfc+66fCRobloMl5U/XUgk7BA4s7oV0EN0L3SLPQdzLt
	5w6jjC8u1R2cFjTNTGgupZFmPnX75PGFDX56GIrbZ7Z05LuaBtPSMKLDW+ndJzG1CoLUlMCnab6
	/qU3n2osRUKhqDLoV9XzF/VsPXaKE1aP9scM7NtXMmuXBuDTnYpTk/ymyYY3zyvcL2MNOeg2lFx
	0T8xzV/fxxTNnf70P2ZqLweYw8knT7v8YCv/S65pOtJXuBSbcnbKJ8G81vWIQxBlUwwKLz8oXNc
	hM5SFTlnw7bOVBK1NcfqjoEU7BMEAc4SjYsA8c3rdRs7vQq/cjLmouU7A8TIVKb/FZdxVB5+kR8
	=
X-Received: by 2002:a05:6a00:32cb:b0:82f:559d:ece3 with SMTP id
 d2e1a72fcca58-84284e83f69mr5353450b3a.15.1780530360964; Wed, 03 Jun 2026
 16:46:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601221805.821394-1-ihor.solodrai@linux.dev> <20260601221805.821394-6-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-6-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jun 2026 16:45:42 -0700
X-Gm-Features: AVHnY4JoceXTvB7eW-rSH2G2YnG2z-sIqzLAb-759Doc4bsSrdh08lc3JaZQhkg
Message-ID: <CAEf4BzYevwUOY34KOdjRd9cv5uXdxEwy13+6vHmNo_h4ryyT5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 05/14] resolve_btfids: Index BTF ID symbols by address
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 3:19=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> Keep an address-sorted index of parsed .BTF_ids symbols so code that
> the original BTF_ID symbol name can be recovered from an entry
> address.
>
> Use the index in find_kfunc_flags() to scan BTF_SET8_KFUNCS entries
> directly and match each entry back to the requested kfunc.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/bpf/resolve_btfids/main.c | 103 +++++++++++++++++++++++++-------
>  1 file changed, 80 insertions(+), 23 deletions(-)
>
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index f8a91fa7584f..43512af13148 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -119,6 +119,11 @@ struct btf_id {
>         Elf64_Addr       addr[ADDR_CNT];
>  };
>
> +struct addr_sym {
> +       Elf64_Addr       addr;
> +       const char      *name;
> +};
> +
>  struct object {
>         const char *path;
>         const char *btf_path;
> @@ -150,6 +155,10 @@ struct object {
>         int nr_structs;
>         int nr_unions;
>         int nr_typedefs;
> +
> +       struct addr_sym *addr_syms;
> +       int nr_addr_syms;
> +       int max_addr_syms;

nit: max seems misnamed, it's "capacity", so I'd choose
"addr_syms_cnt" and "addr_syms_cap" naming (I believe libbpf does that
relatively consistently)

>  };
>
>  #define KF_IMPLICIT_ARGS (1 << 16)

[...]

>         for (next =3D rb_first(&obj->sets); next; next =3D rb_next(next))=
 {
>                 set_id =3D rb_entry(next, struct btf_id, rb_node);
>                 if (set_id->kind !=3D BTF_ID_KIND_SET8 || set_id->addr_cn=
t !=3D 1)
>                         continue;
>
> -               set_lower_addr =3D set_id->addr[0];
> -               set_upper_addr =3D set_lower_addr + set_id->cnt * sizeof(=
u64);
> +               set_addr =3D set_id->addr[0];
> +               idx =3D (set_addr - obj->efile.idlist_addr) / sizeof(u32)=
 + 1;

where is this +1 coming from? we have some reserved zero entry in
.BTF_ids section? I'd understand if this was symbols table, where we
do have zero entry, but I'm not quite following here...



> +               set_flags =3D elf_data_ptr[idx];
> +               if (!(set_flags & BTF_SET8_KFUNCS))
> +                       continue;
>
> -               for (u32 i =3D 0; i < kfunc_id->addr_cnt; i++) {
> -                       addr =3D kfunc_id->addr[i];
> -                       /*
> -                        * Lower bound is exclusive to skip the 8-byte he=
ader of the set.
> -                        * Upper bound is inclusive to capture the last e=
ntry at offset 8*cnt.
> -                        */
> -                       if (set_lower_addr < addr && addr <=3D set_upper_=
addr) {
> -                               pr_debug("found kfunc %s in BTF_ID_FLAGS =
%s\n",
> -                                        kfunc_id->name, set_id->name);
> -                               idx =3D addr - obj->efile.idlist_addr;
> -                               idx =3D idx / sizeof(u32) + 1;
> -                               flags =3D elf_data_ptr[idx];
> -
> -                               return flags;
> -                       }
> +               for (u32 i =3D 0; i < set_id->cnt; i++) {
> +                       Elf64_Addr addr =3D set_addr + sizeof(u64) * (i +=
 1);
> +                       const char *name =3D find_name_by_addr(obj, addr)=
;
> +
> +                       if (!name || strcmp(name, kfunc_id->name) !=3D 0)
> +                               continue;
> +
> +                       pr_debug("found kfunc %s in BTF_ID_FLAGS %s\n",
> +                                kfunc_id->name, set_id->name);
> +
> +                       idx =3D (addr - obj->efile.idlist_addr) / sizeof(=
u32) + 1;
> +                       return elf_data_ptr[idx];
>                 }
>         }
>
> @@ -1575,6 +1631,7 @@ int main(int argc, const char **argv)
>         btf_id__free_all(&obj.typedefs);
>         btf_id__free_all(&obj.funcs);
>         btf_id__free_all(&obj.sets);
> +       free(obj.addr_syms);
>         if (obj.efile.elf) {
>                 elf_end(obj.efile.elf);
>                 close(obj.efile.fd);
> --
> 2.54.0
>
