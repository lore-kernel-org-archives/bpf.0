Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429FF2EC56E
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685188; cv=none; b=O790JDUVsmUtED2I7amCbXRywWt6YTcPObvfhJ2tlVoxiNwtzdCFPHc7fGAxdQRox4Mq8i68lsj6tfdyfCVPqHHFTv/Ldn29hHBwU7DtuYv9j7AL7y4/QT9+jqlc0HbeZ7/fzUU0HcDDqfE7g4ZIwjVkp6fi3mGrUvJi1b7c8rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685188; c=relaxed/simple;
	bh=PzygfZTnYJkGb5ImMLBHFEs7Vk+UPgUBIurIwuiV1fY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f5iIz9iM/EMZly+bZvXQYtHWIc4U836/3KTQHAjeXzdkY3wV8blWLhKIF/Xk+C0R+Y9QSJnRspqogC+5wpyyj1hgHaztgvYZOJo4bboV57RPWsAQIhHTVZnxzD7bqxqwio3E4D43AXB8u/4p7URrsBUkYWxJgQFZtyJUTYdmS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oos2QmnC; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oos2QmnC"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115ebso885955ad.2
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 15:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789685187; x=1790289987; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ratc/abSd79zZBl4G2fhkyqyWM08vog00KFvTH6zT8M=;
        b=Oos2QmnCyjhcFK39dDkLiO7kywEGEJwqj6eRc+PE2ciGJXFYM3ts16vBEBo3LyheM+
         ZR8o9vvhoFzOY9XY41iZI1e6nZRmNP2zSn0HsYJirUL0qprParMdR89X6ynt3zLziGzL
         Is52WA09VoMDRgjLSQg7QVPeJSYnESqmsl1eo1qBYaaFfHYLEPuLGPGxpQ4UAJD6IXAo
         //Pky+yqKdsLEEUSpYYAnHBBZhpLCGlub91OfA6TNbKicOVOkqx1zJ499w8uZLI3sn75
         fvvH5ygrysmBik8Cx/H8t9Q+YqVuOUV5oSvEo303vpYz9r+2MhESsQBC4ORNq2BR60lT
         KYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685187; x=1790289987;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ratc/abSd79zZBl4G2fhkyqyWM08vog00KFvTH6zT8M=;
        b=oR/bWeV8KGw6M5PjrwceADmfuFLbFQq2zIwWAw0e3/87FbaBMkd8hfEusrvfB+hFUk
         XKunK1OnMrIw9WGk0CQBRM/M3/XDmZzQarWZO1FsNXlapfd2WRjVLtAr/WY13bkvdGYi
         OK8/UZB4HctHc6oafGTIaXnAHDuQd14EfOF3NQeIfrLBkdC6vIaUyz6Mv8/PS8M2uEll
         dWSnntYBKAlMfiJb46bYHYUhPgBUELkNE65I4Ls3HioGRw1DzvqnND7QB9MonC5m51gv
         L51VZzJnkKc90YkropNE9Kvk9GVpIKPNDH6YVyC+HKr7sl1SNIP2gR6tXSLI52MQ/6jG
         td9g==
X-Gm-Message-State: AFuF++l70LXELZ1Or9L4IAqG4Zn8DgqaqLk2KOEPZRSyKqDBigZHQX3R
	aDVtqPHriC0HWvLCNEC1rcSX3fHJz922SKs0zSn9BRSZ3P6CyBFUzOUO
X-Gm-Gg: AYBFou3Gx6d258eTRj3G5BSYRgA/grKFTLkKzKoomAnweXJ1/o7b5nZtVA9ayQyPAPi
	Upe96MoJeIfxNJQSjhqkxKWyu1HE/a1/wBmXOiQ3W+4VcuPgMdAUKwqz33Hqpw1hj/lhqayq/Ai
	ZmEQaPXn05gfezFhSnhfJGA3Kz6xBR+zGSFaoD96iGxfJUORphdcfJNUDCYBbWO01BrhcTbDM1d
	3oCfy5CJGh2M3u5tbb02pLaIjZig3D2QgJJbZdZc3UPEZ+/OXKGZTpu/MZQIqdQ6t2XDTpyubzA
	sRaNZdgDolKDFBWv878Ac5X8dKWS+T80qKGnqfkLjx5+YSwjQquuMfUoKBZgNztmHaV4B1K9Yao
	5xaksCCFYyFa43ju7HkyyYM4edWJe3pNYdsQTxNoAwv8Cv1xVUh4slJ6PkW/ikLHyFevrtWCVeu
	q74rjZq0oDHHlHtWVGvEamthhoTOpzErhZXWla482Z6abk/etf7E7QQfwVsOfxfTYDxRQVJMNXT
	zDh4ro6CMxNtpuZBuPQpCMtaNcO70w0sV0ljTAi3hmksC2j0IuaNFoLgQ==
X-Received: by 2002:a17:903:1b45:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2ddb1adedf1mr14767105ad.9.1789685186519;
        Thu, 17 Sep 2026 15:46:26 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c47a:decd:950f:5c9d? ([2620:10d:c090:500::7:463c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5ad25bbsm15771158eec.19.2026.09.17.15.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:46:26 -0700 (PDT)
Message-ID: <77af8904cb6a4b3c0329b4de192b5045144567b8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/4] libbpf: Render decl_tags in btf_dump
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: bpf@vger.kernel.org
Date: Thu, 17 Sep 2026 15:46:24 -0700
In-Reply-To: <20260917012037.1396254-3-ihor.solodrai@linux.dev>
References: <20260917012037.1396254-1-ihor.solodrai@linux.dev>
	 <20260917012037.1396254-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-16 at 18:20 -0700, Ihor Solodrai wrote:
> BTF_KIND_DECL_TAG is an attribute on a declaration: with kind_flag=3D0
> the tag name is the argument of a btf_decl_tag(), and with kind_flag=3D1
> it encodes a complete __attribute__.
>=20
> When doing btf_dump, render both forms at every declaration btf_dump
> emits - a record, a record member and a typedef:
>=20
> 	struct foo { ... } __attribute__((bar));
> 	struct foo { int a __attribute__((bar)); };
> 	typedef struct { ... } __attribute__((bar)) foo_t;
>=20
> A decl tag is a standalone type pointing at its target.  Build an
> index of decl tags in btf_dump_resize().  Keep it as a flat array
> sorted by (target ID, tag ID). This allows for a stable emission order
> in btf_dump_emit_decl_tags(). Tag IDs are unique, so the comparison is
> a total order and qsort not being stable does not matter.
>=20
> Only composite and typedef targets are indexed. Valid BTF allows for
> decl_tags on many types, however btf_dump only supports records,
> record members and typedefs and ignores datasec, var and func.
>=20
> btf_dump_emit_decl_tags() binary searches for where the target's
> entries would begin and walks tags while the target matches. A record
> shares its target with its members, so the component_idx is matched
> there.
>=20
> A record attribute goes after the closing brace, where
> __attribute__((packed)) already goes. A member attribute goes after
> the bit-field width: clang rejects one between the declarator and the
> ':'. A typedef takes it after the declarator, so a typedef of an
> anonymous record can carry two groups at once, one binding to the
> record and one to the typedef.
>=20
> Every decl tag in vmlinux BTF is a bpf_kfunc or bpf_fastcall tag on a
> FUNC, which has no declaration in the C output, so generated vmlinux.h
> does not change.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -962,6 +1011,47 @@ static void btf_dump_emit_struct_fwd(struct btf_dum=
p *d, __u32 id,
>  			btf_dump_type_name(d, id));
>  }
> =20
> +static void btf_dump_emit_decl_tag(struct btf_dump *d, const struct btf_=
type *t)
> +{
> +	const char *name =3D btf_name_of(d, t->name_off);
> +
> +	if (btf_kflag(t))
> +		btf_dump_printf(d, " __attribute__((%s))", name);
> +	else
> +		btf_dump_printf(d, " __attribute__((btf_decl_tag(\"%s\")))", name);
> +}
> +
> +/*
> + * btf_dump_resize() keeps d->decl_tags sorted by (target ID, tag ID), s=
o the
> + * tags of one type form a run that binary search finds the start of, in=
 a
> + * fixed order so that the same BTF always renders the same C.
> + *

--- 8< ---

> + * component_idx is not stored in d->decl_tags: a record and its members=
 share
> + * a target ID, so it is read from each tag.

Nit: useless detail, obvious from the code.

--- >8 ---

...

> @@ -1007,6 +1097,8 @@ static void btf_dump_emit_struct_def(struct btf_dum=
p *d,
>  			prev_bitfield =3D false;
>  		}
> =20
> +		/* after the bit-field width; an attribute cannot precede it */

Nit: /* after the bit-field width */ ?

> +		btf_dump_emit_decl_tags(d, id, i);
>  		btf_dump_printf(d, ";");
>  	}
> =20

...
