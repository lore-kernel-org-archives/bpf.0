Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793924718;
	b=lSBv3Nct6bXz6wcMulM/3mbNvAXcrJDGC6M+ButZEsbxRJ1lEP8YoNrBp20VCOdXpMip
	 yhottatK1PaWWYOoeY6DdwU2WgUnBwQz4csnOw18IChsYb9DX0lRj/ci85AlHawqCc5UO
	 yxai0EfdsfjjVy9S4Xeb8CFDNQ2rIy3bou02xpQq4rm2HVZ6a54j58Z4cqnHAihEMSmN1
	 /+eI9VCU7piBwgg4IKgO2R0aPh5aql0pYYlad4rfI50u4abNFQMvd0lmoYHT0zyyky8DW
	 JYaADdsTiOqxk8TELZN2si02cCZcqKlYusCNldml73FiGKTc9t2YpdQmbGGEvnK2ODQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0FSlYFmwRe1JgMOW94mlrGSq7fkWoXvAr5wBYx1j2gs=;
	b=dz3PRIlwCQDgyr9l3T1va61N0KrGszZIi12E1LCjn4N909C8wMtGcxNY1GWDgeVaNxD9
	 wmb2ILtsDEFyyX3e3OTQ1x67tW2mJGu5Gjgb2Wskoo8Ig3eBXDqR0M3fcVdW8giyRFWYi
	 igh3Zxo4gYza6pXSTBdv0LSigpLCbwSYnTwu/uR4AXlUDqhPcRZRwSAie2uF65MkSAy2y
	 LDdH8wmJEXh7rx0ZviVPVA+UnneQWgzw15n/ijkfTf/gXvt9TQQ8yGU7ymK2Wtnn6nVZB
	 B0SkDi5aEKfnaC3styMgrNuouK29ywDYS2ik9t9XopO7UTz2hJiZiojloHxvx6E6AAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=siAbizXl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EE1606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 00:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96EE1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=siAbizXl
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e985106c0cso644865ad.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 16:25:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793924717; cv=none;
        d=google.com; s=arc-20260327;
        b=Nn3Vo0vz8DNr1s6DOV4cV2nnPk7yjGWC/y+HiYLCbotsaij8zsjutw8ePTI+wzfhtN
         GPg1cdUPNsbnJARTiAoCLIyhCexFAH72lceqUnRxdc8JhU/xkC7WyF78Wgf3vZ42L3s1
         Ngrw0Xv50lmqkBx8CARAN4rEvB6Piq//13Lk7Lz7gUOg8pB2UF83aiMDoHydsjg7sQ+3
         5SVtp+RRZzpL6MQN1qEmKjZlonj3kn4gJIVe6qLe2+rzTC5qSH7db4aiXdSARiWnq4+A
         Q6/G60maKPAdtVxWZvZe8B7DeNz8xM7lW1nuDXIAQe8ZX+8NWOy7pIDVHsZwmftt+yxm
         rAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0FSlYFmwRe1JgMOW94mlrGSq7fkWoXvAr5wBYx1j2gs=;
        fh=2ursstC+1ICPWkl0MQmUyqAV8X6VjehwBjcwCTsYopI=;
        b=iQSYNfMXvX95SJ40rmmwsAALIQCzxV7Oe44PJgwEfZNJj/IiMJm+f+ws2/DYA1upzI
         PZNfle7ocxTTmCUOej+D8khCMk20v1TbRwmYDDWrlXTyZRa8RAn0dEJGbAozOzYppson
         n4UQnxlvVZuyP7qIx657Z8qjL7zaKE47Stztxd8IjeihUFHr+3LVq/6XsmI3XkRt9Ksr
         VyBU+k9vRfpURng9Vy7RxC2KnU9Yl0hPIOQf2kpmsKzCpS907+rydWqxKHid4RdaRDyO
         sQeY2U+ayRZWYEx3bNDZ5bKWOth9b/Mb/9yw0fS7HJXS44bfts+DYm/dFJdSAtlC/omH
         0MsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793924717; x=1794529517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0FSlYFmwRe1JgMOW94mlrGSq7fkWoXvAr5wBYx1j2gs=;
        b=siAbizXlJkigSMRtwUahIYjy3cLQUVbCyOEChFpdJvxL36zQ8W7WHtqmgf+l8pqVR5
         efNzP+t0l3HZZyw3fih+XuUuXMfu5Exvq0n0k6s4kkyKFCq5DwWVXf7heYCoTbXvwFVJ
         YXgFz8mJVo6ODhyyc4gYzBgyTAmgLVKeSuIp6gCHDnJflL99HgVK3UN3FN5HYi7XRr8y
         71RcA50GvvBATW7vjRQ7Qi3neDT7f8hJHlubGR9J5lRqxjfUDnhww1biHr05GAcRcnjT
         J10GFzHebA6pqxDbDfTUfnr5SIL6es1s1LnykgCL3nu+BorrQoLt+C4rhDawXr5n6hLz
         zKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793924717; x=1794529517;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0FSlYFmwRe1JgMOW94mlrGSq7fkWoXvAr5wBYx1j2gs=;
        b=BHAu8f5vPgF4XdOnl18+avbA0YZrg+CVZJGUBcs8kgMZ1T1LUG5fUw7igwreDcFuAn
         GsCClLF+hEct4aaHnxLS0qCKAPkzmc55tBkxetgLUKtz+ujR+g/MHli2ZPbfnoHmCVbf
         tgw5BL3WnTWxwgL0olADptmviGaCwqO2a1r0nLh+F4vWr8GG3qw2K1z5+EEBRcFUr6qs
         +Rmmqr6Rvv9Dby8aP3NKaI8wFScxJHAdCIXSvHNMaSyKI0XS6lwX+9D3pgI6h7tWDxvl
         DeZiBegH1uHe4nhpasxqwOssPXyuodonPZcnyR0MV0vpuIculugSDR1aG/UaY7N1e8bH
         Dt/g==
X-Forwarded-Encrypted: i=1; AKwUvByYEAVhpcT31yTaSNbarEIeVHlq7/rpHtvGVKul2MlDouBD6wXPwh7m4RF6Ak2tt59tJUs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FHqclllHfKueftAj/gtZM7zHyj+gyx9tiFQ2bojeXY4AO9dUe
	zoVW33N+u287TUvL/jHDvtwYis3aTuqUqaS6OJg8e2doOH4hymE5rtf4NiOU/Aaj5Podq6mNjYI
	q1iJoc78rVJfzTFf5chOOjXB+TBdSnPk=
X-Gm-Gg: AYBFou24Pwi1A7HRjJWq8+beQlZMA0ujh3MWQ2idZUfCmaEil8MPgxDyGuc3800UPqW
	qIJai4kcEOdfDIFsIdSvcCJf18dp+aCoSo0oLheUvCSdXmtWJuw3r5iz/lKsPnnIHLFkU19ZDzs
	ybnHbKcztjcQBsR1gUPj7ofeed4zzFPtV6UzRprJzAt7SB4xQuSi4OKXxE6lyddF+MQtfg7gK/I
	J+s0pwcrXCpGjXIuM+kMuBykYj5LnCFSKLDpFhfoyDmAVLYiUGo6IKy3WHtyeaPfMkTuQI7EwNT
	UjPOdc5r2dzN1R4UxeofoGGS3DYQfkzGVUwIIUewA/gflm9x4N+niyz0G5tX4ZukqbesiqEpIYc
	eB03vVlJF0Ul/REIl41WwlLoTAl0p5kQcJuDDUsiGM2NTSPpV4HPtvpFApNkNYvjONGZM9OiGP5
	OzYaHygDheHD9BQbx6dHzpmgLzuYyL3x0u9g==
X-Received: by 2002:a17:903:298c:b0:2e9:69b1:1b9b with SMTP id
 d9443c01a7336-2ed41284e55mr14039535ad.8.1793924716882; Thu, 05 Nov 2026
 16:25:16 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105175845.30357-1-ihor.solodrai@linux.dev> <20261105175845.30357-8-ihor.solodrai@linux.dev>
In-Reply-To: <20261105175845.30357-8-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Nov 2026 16:25:04 -0800
X-Gm-Features: AclHuK_-5OpfcXVjanePQelKCawJVyiEBYi9z4ZinpWuPzSZ_-DTWc2kuPR1fKc
Message-ID: <CAEf4BzbpVnoqKnGAVKYRffraPpPWjnNFF2oFAnXmBkqd2V6vmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 07/17] libbpf, bpftool, resolve_btfids: Dump
 kflagged BTF tags as is
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org, 
	Alan Maguire <alan.maguire@oracle.com>, Cupertino Miranda <cupertino.miranda@oracle.com>, 
	David Faust <david.faust@oss.qualcomm.com>, Ian Rogers <irogers@google.com>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Vineet Gupta <vineet.gupta@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 10:00=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> btf_dump wraps the strings of kflagged decl and type tags in an
> attribute specifier, so such a tag can only stand for an __attribute__.
>
> Print the strings as is instead. A tag can then carry any annotation,
> including an identifier whose definition is left to the consumer of the
> dump, such as a macro defined by a generated header.
>
> resolve_btfids, the only in-tree producer of kflagged tags in kernel
> BTF, tags arena pointers in kfunc prototypes with "address_space(1)".
> Make it encode the complete specifier, __attribute__((address_space(1))).
>
> Kernel BTF produced before this change carries the bare string, which
> does not compile when printed as is. pahole emitted it from
> commit 21cb33c7e065 ("kbuild, bpf: Enable --btf_features=3Dattributes"),
> and resolve_btfids from commit 27a78c2e7eee ("resolve_btfids: Process
> KF_ARENA_* flags in resolve_btfids").
>
> In the split BTF that bpftool dumps C through, attach a kflagged decl
> tag with the complete specifier to each such type tag, which btf_dump
> prints in its place. The input stays unmodified, and module BTF, whose
> base holds the vmlinux arena kfuncs, is handled the same way.
>
> A C dump of new kernel BTF by an older bpftool, built with libbpf 1.6
> or later, nests the attribute specifier in the arena kfunc prototypes,
> which does not compile.
>
> Update the BTF reference, kfunc documentation, libbpf API comments and
> existing tests to match.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  Documentation/bpf/btf.rst                     | 14 +--
>  Documentation/bpf/kfuncs.rst                  |  3 +-
>  tools/bpf/bpftool/btf.c                       | 43 +++++++++
>  tools/bpf/resolve_btfids/main.c               |  2 +-
>  tools/lib/bpf/btf.c                           |  6 +-
>  tools/lib/bpf/btf_dump.c                      |  4 +-
>  .../selftests/bpf/prog_tests/btf_dump.c       | 89 +++++++++++--------
>  .../selftests/bpf/prog_tests/resolve_btfids.c |  4 +-
>  8 files changed, 112 insertions(+), 53 deletions(-)
>
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index ea0d699749af..99833048de60 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -506,10 +506,11 @@ If ``info.kind_flag`` is 0, then this is a normal d=
ecl tag, and the
>  ``name_off`` encodes btf_decl_tag attribute string.
>
>  If ``info.kind_flag`` is 1, then the decl tag represents an arbitrary
> -__attribute__. In this case, ``name_off`` encodes a string
> -representing the attribute-list of the attribute specifier. For
> -example, for an ``__attribute__((aligned(4)))`` the string's contents
> -is ``aligned(4)``.
> +annotation. ``name_off`` encodes the complete annotation string, which
> +``btf_dump`` prints unchanged at the declaration. For example, an attrib=
ute
> +specifier is encoded as ``__attribute__((aligned(4)))``, including the
> +wrapper. A macro can be encoded as its identifier, leaving its definitio=
n
> +to the generated header or its user.
>
>  ``btf_dump`` also accepts decl tags that reference a ``type_tag``, as
>  described under ``BTF_KIND_TYPE_TAG``.
> @@ -542,8 +543,9 @@ normal type tag, and the ``name_off`` encodes btf_typ=
e_tag attribute
>  string.
>
>  If ``info.kind_flag`` is 1, then the type tag represents an arbitrary
> -__attribute__, and the ``name_off`` encodes a string representing the
> -attribute-list of the attribute specifier.
> +annotation. As with decl tags, ``name_off`` encodes the complete annotat=
ion
> +string, which ``btf_dump`` prints unchanged. An attribute specifier must
> +include its wrapper, for example ``__attribute__((address_space(1)))``.

same here, I wouldn't add a reference to btf_dump in this doc

>
>  ``btf_dump`` prints decl tags that reference a type tag, with
>  ``btf_decl_tag.component_idx`` of ``-1``, in place of that type tag. The=
y
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 901c37504217..87b3c4e4bea2 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -567,7 +567,8 @@ At kernel build time the ``resolve_btfids`` tool find=
s all kfuncs declared with
>  For each kfunc it emits a ``bpf_kfunc`` BTF decl tag, a ``bpf_fastcall``=
 decl
>  tag when the kfunc is flagged ``KF_FASTCALL``, and the ``address_space(1=
)`` type
>  attribute on the return value and/or arguments that use arena pointers (=
see
> -sections 2.3.8 and 2.8).
> +sections 2.3.8 and 2.8). The type tag stores the complete
> +``__attribute__((address_space(1)))`` specifier with ``kind_flag`` set.
>
>  2.7  Specifying no-cast aliases with ___init
>  --------------------------------------------
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index a438b5a03f5a..b4516361a3fe 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -1092,6 +1092,45 @@ static struct sort_datum *sort_btf_c(const struct =
btf *btf)
>         return datums;
>  }
>
> +/*
> + * Kernel BTF keeps its type tags as the kernel expects them. Decl tags =
in
> + * the dump split choose how btf_dump prints them.
> + */
> +static const struct {
> +       bool kflag;
> +       const char *name;
> +       const char *override;
> +} btf_c_type_tags[] =3D {
> +       /* the arena attribute in older kernel BTF */
> +       { true, "address_space(1)", "__attribute__((address_space(1)))" }=
,
> +};
> +
> +static int btf_c_annotate_type_tags(struct btf *btf)
> +{
> +       __u32 i, cnt =3D btf__type_cnt(btf);
> +       size_t j;
> +       int err;
> +
> +       for (i =3D 1; i < cnt; i++) {
> +               const struct btf_type *t =3D btf__type_by_id(btf, i);
> +               const char *name;
> +
> +               if (!btf_is_type_tag(t))
> +                       continue;
> +               name =3D btf__name_by_offset(btf, t->name_off);
> +               for (j =3D 0; j < ARRAY_SIZE(btf_c_type_tags); j++) {
> +                       if (btf_kflag(t) !=3D btf_c_type_tags[j].kflag ||
> +                           strcmp(name, btf_c_type_tags[j].name))
> +                               continue;
> +                       err =3D btf__add_decl_attr(btf, btf_c_type_tags[j=
].override, i, -1);
> +                       if (err < 0)
> +                               return err;

subjective, but I'd just hard-code two special cases instead of doing
the whole table search, it's not like this will keep expanding, we
just need to handle existing fixed set of "legacy" cases

(if you agree, send in a follow up, please)

> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int dump_btf_c(struct btf *btf,
>                       __u32 *root_type_ids, int root_type_cnt, bool sort_=
dump)
>  {
> @@ -1110,6 +1149,10 @@ static int dump_btf_c(struct btf *btf,
>         if (ptr_sz)
>                 btf__set_pointer_size(split, ptr_sz);
>
> +       err =3D btf_c_annotate_type_tags(split);
> +       if (err)
> +               goto done;
> +
>         d =3D btf_dump__new(split, btf_dump_printf, NULL, NULL);
>         if (!d) {
>                 err =3D -errno;
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index 5ad547356303..c16dd93fa6d4 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -204,7 +204,7 @@ struct btf_links {
>  #define KF_ARENA_ARG2  (1 << 15)
>  #define KF_IMPLICIT_ARGS (1 << 16)
>  #define KF_IMPL_SUFFIX "_impl"
> -#define TYPE_ATTR_ARENA "address_space(1)"
> +#define TYPE_ATTR_ARENA "__attribute__((address_space(1)))"
>  #define PARAM_SUFFIX_ARENA "__arena"
>  #define PARAM_SUFFIX_ARENA_NULLABLE "__arena__nullable"
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 5786232c1fea..0984a8ccb526 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -3078,7 +3078,8 @@ int btf__add_type_tag(struct btf *btf, const char *=
value, int ref_type_id)
>   * Append new BTF_KIND_TYPE_TAG type with:
>   *   - *value*, non-empty/non-NULL tag value;
>   *   - *ref_type_id* - referenced type ID, it might not exist yet;
> - * Set info->kflag to 1, indicating this tag is an __attribute__
> + * The kind flag is set; btf_dump prints *value* unchanged.
> + * Attribute specifiers must include the __attribute__((...)) wrapper.
>   * Returns:
>   *   - >0, type ID of newly added BTF type;
>   *   - <0, on error.
> @@ -3413,7 +3414,8 @@ int btf__add_decl_tag(struct btf *btf, const char *=
value, int ref_type_id,
>   *   - *ref_type_id* - referenced type ID, it might not exist yet;
>   *   - *component_idx* - -1 for tagging reference type, otherwise struct=
/union
>   *     member or function argument index;
> - * Set info->kflag to 1, indicating this tag is an __attribute__
> + * The kind flag is set; btf_dump prints *value* unchanged.
> + * Attribute specifiers must include the __attribute__((...)) wrapper.

nit: too specific, that decl_tag is an arbitrary text, user can figure
out what it needs there depending on its use case

>   * Returns:
>   *   - >0, type ID of newly added BTF type;
>   *   - <0, on error.

[...]
