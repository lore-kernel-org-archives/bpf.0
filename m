Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BC2547051
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689612; cv=pass; b=AiXTQJ7z6phqaxy/OFR8SelP3LO1BFE/4li4W+UdNW+taM4agI7HRVS+6SGr/nWttUif/ycwmqveKCnK0+gRdeeIHj4SHgwWWrehhWl1E/859UUNL80JMgWHNivaf//K+YoImnvPu0Ncc/VpkelbF8h4+E1FTQjEqiM9YZQ7zbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689612; c=relaxed/simple;
	bh=TWMLUIawkSDpLveekItH6tmuk06VKSnQ5l2v4mbpMek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4rvh4QOWfxsZYWKJ7/hNStrm5H2V42tvZL6E9gTCGTzRPl2MTXcQoPbMJSb1Cc5YEKpgNumoOTfZoXtLaMFYz4oU48/SUlJN0haQ2EZxL2FSZd/3xtq3WxanS9IpI27JYz7F2EVChnnX33LFFecrxFVVquI3ssnyH5jqOI5pMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpbQkjOP; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpbQkjOP"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5121bcf1aso66158a12.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 17:00:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789689610; cv=none;
        d=google.com; s=arc-20260327;
        b=DNGlhDJ6N68YUsnfQ+NsrpT/++StmCvunXszBllR8xjB40SCbOHYUlAy28fSHXyiBn
         cE5RXIgFVhSNjeKN+zZkA4RHPmgQkMA97QiusQhPZEUBRNOnLjw2T23GoEYWAsx/Dxlf
         O9Ds5DGZjc6jlP1gz4sJbbJvRB+wxsIq0pv8Nl044NHre9CK3fy/oO0pw2+P1k8lnnPf
         kyDkpfU/B+tLSJi9KwR0y+CkD3fl/mD2hdVax9yh1otwiGKe8VwvfbeS9Gz4HT2hMhch
         OjXp532yPpYcVWVJ8Ynwz7k5XpRVJik7F5sg3UFdCR2NPo2HrfDgPT5kZeh2uya7QOkM
         B+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0leYozOKpK3i3ibHVEAy/A2s5NH8spzB/T5FebWWV6I=;
        fh=DuBL+vrfbB24jUMTHJBbQ0sS2UrD8td0TPX/9EFfXsA=;
        b=EtR/Id56LYBCtN7lqfm905BIjCva8QUXcHwUTSOmPzmzU6Ry8w9Z3n6dTpldAlvcmz
         dfNwqD2W6pIZQY8P3kzJYhcOhJxDUn49ZUO5OuGHzkqBa2ccUkfkwBajD6hTyEcNByuj
         /kK/xFe2iTpzGIopBlZJfoX3/hnuwncOTDmf9KLX7h4HuzEC/vEyEH75T7OR5BIA2X43
         /m7iWLUUbKlka1vAT+Fvlh2ACv1sIiNkazZQ+Hz8UKqkDqZm9f7zn53QNIGr3V53TqMk
         aLJsB1AvHWAurRTK7Ri068yi5skMLWedo4bRhiIyqnZZl2MgZcgT3v8bjbK2f1/mhzve
         v1YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789689610; x=1790294410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0leYozOKpK3i3ibHVEAy/A2s5NH8spzB/T5FebWWV6I=;
        b=fpbQkjOPaWIev5I5gTRaNkK470mRZf1r7BdyD/Ohms4oFEu2iby/07neVs2gw/Ca/p
         YiVj1jhJNHHREHh6q0h1KMtFJYjMAx7IYMnBgh+f2csv8UbMZnhM2tOBSVctXOr5HGSU
         t2LGU6eYfNluvVLUShsRG4SD9TeNIeRBhBmNJbXpBeBaiNdPv67WYac6cLLGy+q7kPWu
         pGWOIU86gUeYXpyr3rNjlwlRiNldfQq0TKJtC9/HGomV5LzsJI9X4Kk0ZYC8VsvdV9/U
         WLzpeEn/4XYsQSRwRzSED/TrkHzThV26iiGgx8ItGH/Bblpo9KERGm+nF/fcPUKWav7I
         7YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789689610; x=1790294410;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0leYozOKpK3i3ibHVEAy/A2s5NH8spzB/T5FebWWV6I=;
        b=e24XZPEBYeXLjOwTwxeiag/LTX5/MPU+ORh18/jKH3BRciuEapS300yduaCdZH8U5I
         3oQ6S9LyWOrKhx1/0AP6WBYKNzrlxWNcRd4B2Tpd1nNh9xJ1u23PPgticO+xJaZmiAjB
         JdRe+Pvys/Y7LyiYJH2uxDSO+CZTstTBpd6W4ljuUpTTbCJwmtObSt4A8PFSOEEKH/jK
         hhIVoO2xVo5ZUlxuxYm9SaBKFj48Nl0pkD/kTXGw6j1CaDdV5gwEv4FJvKrkfVFkqJG4
         ahladPn1Vm8cPsUvy9xfa14NCoQFm5c2RbYlgbY3jQBRHbpYdpq+N/zEOjFBe5GWJBHG
         aSvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZGDw6QVQ4cws9e67iwnr+zf66NB2A7MyqeNMgSAdLXlplSPp0w8e0OoGkc0vGSRbbru8=@vger.kernel.org
X-Gm-Message-State: AFuF++kK2uFz+gie12mhpCYlWZN68xOSVMEsG3SnzY1SsXyGlfLXZc/j
	u9nPwU+YWdJ0/0rd80k8kGvUaGZ48LKnXngNdQXP4CGAt4upZ7YXYzCq+HR/8NTb7VCXoHSlt33
	3rJxdjpvvYJdButkFMt07f64NTIwfQXQ=
X-Gm-Gg: AYBFou2eP55yYuU5Nj6laFJ31PJ7LoBobdprcg8ObeC+VJBJuOMa+tukDCctz6TK8G1
	SSuA58eMe6Y/c0f0VZZOaHB+bAl+mC/Zbo3MRMXoRnh0gXwYO+dIpOYCMGyCpEVP3+zFNyggAy8
	47sffsDNanyf7N+rwCyt+Au2tRzKnSwmJ+26cXAQuvoNyod6Y8P83hqHumQisNH5NwZd9Ya7WKS
	PH3E5vlpH6xvyfYE6o9LddxJrk5KDa46b0067PANb0Tfhmeo4TjN97HknagoStqvteUvEudAMse
	hMNc1x5SXqagMuxAHQfO+08kXJftV1u5ABwx/i5YMsWoCby13qofVggmHqitXOZVz8kFX4f+sEe
	oQrEv+U3sTokw+cmzgPrQzFMWovd4rdOQFBM3NIKpF74KZNcBHV+J
X-Received: by 2002:a17:90b:5545:b0:39e:1ec8:adc8 with SMTP id
 98e67ed59e1d1-39e54d4a20amr1484801a91.14.1789689607059; Thu, 17 Sep 2026
 17:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917012037.1396254-1-ihor.solodrai@linux.dev> <20260917012037.1396254-3-ihor.solodrai@linux.dev>
In-Reply-To: <20260917012037.1396254-3-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 17 Sep 2026 16:59:52 -0700
X-Gm-Features: AcwNN1UEPaA3-ysu_fqaZoQq4uonZOq3z8Hr0ZxFjz4lh1iY5AYsYAQwo-7s1f0
Message-ID: <CAEf4BzYXbPCAjbEg=E-VR-7owN3hGqE32OVTWRrWhPqDQVnC4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/4] libbpf: Render decl_tags in btf_dump
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 6:21=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> BTF_KIND_DECL_TAG is an attribute on a declaration: with kind_flag=3D0
> the tag name is the argument of a btf_decl_tag(), and with kind_flag=3D1
> it encodes a complete __attribute__.
>
> When doing btf_dump, render both forms at every declaration btf_dump
> emits - a record, a record member and a typedef:
>
>         struct foo { ... } __attribute__((bar));
>         struct foo { int a __attribute__((bar)); };
>         typedef struct { ... } __attribute__((bar)) foo_t;
>
> A decl tag is a standalone type pointing at its target.  Build an
> index of decl tags in btf_dump_resize().  Keep it as a flat array
> sorted by (target ID, tag ID). This allows for a stable emission order
> in btf_dump_emit_decl_tags(). Tag IDs are unique, so the comparison is
> a total order and qsort not being stable does not matter.
>
> Only composite and typedef targets are indexed. Valid BTF allows for
> decl_tags on many types, however btf_dump only supports records,
> record members and typedefs and ignores datasec, var and func.
>
> btf_dump_emit_decl_tags() binary searches for where the target's
> entries would begin and walks tags while the target matches. A record
> shares its target with its members, so the component_idx is matched
> there.
>
> A record attribute goes after the closing brace, where
> __attribute__((packed)) already goes. A member attribute goes after
> the bit-field width: clang rejects one between the declarator and the
> ':'. A typedef takes it after the declarator, so a typedef of an
> anonymous record can carry two groups at once, one binding to the
> record and one to the typedef.
>
> Every decl tag in vmlinux BTF is a bpf_kfunc or bpf_fastcall tag on a
> FUNC, which has no declaration in the C output, so generated vmlinux.h
> does not change.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/lib/bpf/btf_dump.c | 94 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>

series looks good, just small nits below

> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 635fa969e145..1e8236c8b9a5 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -77,6 +77,11 @@ struct btf_dump_data {
>         bool is_array_char;
>  };
>
> +struct decl_tag_desc {
> +       __u32 target_id;
> +       __u32 tag_id;
> +};
> +
>  struct btf_dump {
>         const struct btf *btf;
>         btf_dump_printf_fn_t printf_fn;
> @@ -93,6 +98,11 @@ struct btf_dump {
>         const char **cached_names;
>         size_t cached_names_cap;
>
> +       /* decl tags, sorted by (target ID, tag ID) */
> +       struct decl_tag_desc *decl_tags;
> +       size_t decl_tags_cnt;
> +       size_t decl_tags_cap;

nit: decl_tag_cnt, decl_tag_cap, "count" expects singular noun before
it: "table count" not "tables count"

> +
>         /* topo-sorted list of dependent type definitions */
>         __u32 *emit_queue;
>         int emit_queue_cap;
> @@ -192,9 +202,37 @@ struct btf_dump *btf_dump__new(const struct btf *btf=
,
>         return libbpf_err_ptr(err);
>  }
>
> +static int btf_dump_cmp_decl_tags(const void *a, const void *b)
> +{
> +       const struct decl_tag_desc *x =3D a, *y =3D b;
> +
> +       if (x->target_id !=3D y->target_id)
> +               return x->target_id < y->target_id ? -1 : 1;
> +       return x->tag_id < y->tag_id ? -1 : 1;
> +}
> +
> +static int btf_dump_push_decl_tag(struct btf_dump *d, __u32 id, const st=
ruct btf_type *t)
> +{
> +       const struct btf_type *target =3D btf__type_by_id(d->btf, t->type=
);
> +
> +       if (!target || (!btf_is_composite(target) && !btf_is_typedef(targ=
et)))

target shouldn't be null with correct t->type, don't add defensive checks

but also why this artificial limitation on the kind of thing that is
tagged? memory savings?


> +               return 0;
> +
> +       if (libbpf_ensure_mem((void **)&d->decl_tags, &d->decl_tags_cap,
> +                             sizeof(*d->decl_tags), d->decl_tags_cnt + 1=
))
> +               return -ENOMEM;
> +
> +       d->decl_tags[d->decl_tags_cnt++] =3D (struct decl_tag_desc) {
> +               .target_id =3D t->type,
> +               .tag_id =3D id,
> +       };
> +       return 0;
> +}
> +

[...]
