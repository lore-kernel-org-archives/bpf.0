Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09A38425A
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530422; cv=pass; b=Tn2YW4nTdMp4hwMe3Wi3aUse7g0G9ZrrCoaxBxx0dAu1GyZcwJ8ccv/gMbJQMt2VljRYhZk2/vHI0F2rsWBQ0fpyNdgPbAHyu5pVH9Bh5HH75YqRr5H9RqrintZSzkdeS50PblTtHHVakkgExhT3ad+aKzDEBRKo8+aw/+OZhpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530422; c=relaxed/simple;
	bh=DCp3v9l+FMS7NINNd7W7HntSmsBGnknae4Q2CV0fksc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggTqWK3Or83qFiPumUz/ldYM4X9sA517u43OyjoM+vkhmboMVJ23hfSn6FUUtc4h/hf2BS6DeFe55a27DXD86IFxYP8SsE/SgvgdZ7WoGE115Bfx+o77t+BFdsJGr4n5kgEbZqq4SvyjBdarfcZ2Cndos9QlNdS8cWi2o2eIBaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ev1KpUro; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ev1KpUro"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-842319576d5so33989b3a.1
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 16:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780530420; cv=none;
        d=google.com; s=arc-20240605;
        b=JHV9blqO+tTqFRu7JSiLHG+pbiFmZaLGKBbi4Cn1rOWD13WfmWMiH6SYwV1oYUzsa8
         h5Ur720U0UY+EtwnKrWNHSJSYd8D8gga00CgQWWJwMfTnuo3DnAXKu7yBVlERnH4bLmW
         O+rl+8XvJeXsiE467469AiLMA892816qbrwkOi7DVJ/MHievjRxZiep13OcwCb9gonNt
         eOqglAGCGloSS130vsDiLmosEVA0eOobzWJnFzugHRjnZQMMNfIrQ0zj9dSsvtG9LxhJ
         HOfKSoPwc2bks6aDwIt4fZXL/PeUdFAI0xeneM3+bFJTqhwRve4TLOVHKr2oZr9SsQyp
         nD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PRQr144oVhotnRScCZDWsFCvp93dWQllt04uhG0kBxE=;
        fh=yKbtqUSzOE4mKNRSiOCx6/40+eHDz04LJECwO19mCQo=;
        b=cIJxhR7KrCCXHCYQ5g9Un8W3RzBjonnGshGndcGYiWvXT2/e3KClbjl7UlZC7SXHBe
         acwIqotcv0/C0QSHgXKVQwdo755ygxQlEdafDsiNqMDU1e6FopAlUtlgPTDTAIhnD6SI
         gO11N3ys6mbp43HmOfAsu88c7gMPtE+hwjYzKoCZNqENGcPuHABiPn4YUp+QhyG5Joaj
         EIJsh52RcKzuUYKxE+b4ihr0LgH1UqX6OV33DM6XfRP3qv8xGJab/MTa7KxnsSlWOURn
         Q5ZzaFsCcgzI9QUw4WAsoKnBicXoAGdZFNE94pV2YWhsryjqja36VWXCfmbIgmSnmg8q
         bIWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780530420; x=1781135220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRQr144oVhotnRScCZDWsFCvp93dWQllt04uhG0kBxE=;
        b=Ev1KpUrowU53YF+UACz+/2pJYtyWITUaz6K1qfk5YazJ8Er4DxEkFnUrKcHW2UTlWW
         GfMjcXfPTjV4EoyfyE7X35NRb5pY76ZrAGFc+ckqKeASJIAKG3IzHTGdG80BNyMHJkHn
         DOlrppCQW2ko7qFNLT89TyKYW0k5MSHSKVswJYlKNwhz8C8mEeCTiHdj8alGjoZcglry
         e0NMNWQef4heF38VrkJXS1WWj/0zWSehVHTf9gXGAnVtzNOdGK41A8C5qqNVaFZyCkFD
         sIV814ugFhypTTpS48nmM5LAO9a8dVFJJgamcZ/HzyonUsUUiDSE6qVBMBVBlxGCzS6/
         H0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780530420; x=1781135220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PRQr144oVhotnRScCZDWsFCvp93dWQllt04uhG0kBxE=;
        b=iAv1EUMLA1HO7PszfojKQ+ys2hvNXZelZWDRMm4t0N6S0plW4iTKRToa0q4fzYeSpt
         gtl0ISnZHAmXOpkYGaXXLhyZzwr8JJwVVYoCsVFZsOAT05Mlo/qBIEt8JdnHlP5XmaAW
         gSvakvdAWqujm+2EoT6/H1HsPHdJCBhv/SYCJ/5ix+1RjWurg5hChs3jo3w1jWnUoQkf
         4+XvSNmWUii8rWFXCeWXyvEzFIPscnrBTETaRhhpI4KNl81YcCsMdRsWM1heWkmv9HIH
         4h7tEwKiBuTlFvCVyWHkpgfVo+p9njetFchVXdYhSQ1A25hk5W2g5o9g2ku/wPkhGnl/
         +cFA==
X-Forwarded-Encrypted: i=1; AFNElJ8nDRYTEiDcJbY0lkAH48OKCF/6Ne7ugbSr9G2zcwJaq17V5+52YYiRQj08Zmp7uUBkTL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDqivnMyuPp+1mXr1dH6U+V1QX55fnbImxhQZXLwrx5J5TeAi0
	sbpjdPKkyeVFH3M2G9ksBp39jaDLpydyt6E52xvwgGHNMGLGQlxF1rRcj3Z6YkZy2nVlXaWuR5c
	/v9D3kaIJD/X6x5z5VtFufaUt1EnoR3s=
X-Gm-Gg: Acq92OFBzvrYS1cLbFmZK9SUtWtmazVzrJRPhLrIr6PBIGjGUcdxbpBfuhLB+pWqyvX
	uLVjDENNdj4AEOhkNQ5zxVZGwJPShJ6JQQn7C9RIYZ7hBnYCoL2RWeuk1nOAp6/7OTUSNXWJZEx
	foTsghNUmUAaHXz0SPZGH8Qy49zvAmtRCnca9bwvp+Ne9kupMJ4F4+fBkL0XprKh8wULGQ8nzGn
	+PtrJFaFnixZ1WTcABvmnUM6j9Pq5CruOo8OlYxWOHeoFcEMWMG8Sx1Gj/IuEwscZwAtOfc94lx
	H0AWzpjLggxdxI87ZpWyDBh+MNKj3m/wHULK7syhLDGD4Rp3xbV2RwTi17G/fDDejWx91JconL0
	=
X-Received: by 2002:a05:6a00:a21e:b0:842:3801:47f with SMTP id
 d2e1a72fcca58-84284e1a23bmr4856513b3a.17.1780530419730; Wed, 03 Jun 2026
 16:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601221805.821394-1-ihor.solodrai@linux.dev> <20260601221805.821394-13-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-13-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jun 2026 16:46:45 -0700
X-Gm-Features: AVHnY4IQDbz3ReZJFNHbtHz-9E83Cjslix00uXOBreU20DsKEz2wz7UdcnKiRyY
Message-ID: <CAEf4BzapFqXxGj-rSuNZ-_0GWpUCGcyi+UKd3ei6xaa5AKDbaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 12/14] selftests/bpf: Verify arena type tags
 in resolve_btfids test
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
> Extend test_resolve_btfids() to assert that resolve_btfids emits the
> address_space(1) type attribute (a BTF_KIND_TYPE_TAG with kflag=3D1) on
> the return type and/or arguments of kfuncs marked with KF_ARENA_RET,
> KF_ARENA_ARG1 or KF_ARENA_ARG2.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/resolve_btfids.c | 59 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/btf_data.c  | 10 ++++
>  2 files changed, 69 insertions(+)
>

[...]

> @@ -178,6 +191,22 @@ static bool btf_has_decl_tag(struct btf *btf, const =
char *tag_name, s32 target_i
>         return false;
>  }
>
> +/* True if @id is PTR -> TYPE_TAG(kflag=3D1, "address_space(1)") -> poin=
tee */
> +static bool is_arena_tagged_ptr(struct btf *btf, __u32 id)
> +{
> +       const struct btf_type *ptr, *tag;
> +       const char *name;
> +
> +       ptr =3D btf__type_by_id(btf, id);
> +       if (!ptr || !btf_is_ptr(ptr))
> +               return false;
> +       tag =3D btf__type_by_id(btf, ptr->type);
> +       if (!tag || !btf_is_type_tag(tag) || !btf_kflag(tag))

drop !ptr, !tag, etc, BTF is not malformed (and if it is, test_progs
crashing is not a big deal, IMO)

> +               return false;
> +       name =3D btf__name_by_offset(btf, tag->name_off);
> +       return name && strcmp(name, "address_space(1)") =3D=3D 0;
> +}
> +
>  void test_resolve_btfids(void)
>  {
>         __u32 *test_list, *test_lists[] =3D { test_list_local, test_list_=
global };
> @@ -253,6 +282,36 @@ void test_resolve_btfids(void)
>                                                      kfunc_symbols[i].id)=
,
>                                     kfunc_symbols[i].name);
>
> +       /* Check resolve_btfids wrapped exactly the arena-flagged return/=
args with
> +        * the address_space(1) type attribute, and left other pointers/r=
eturns
> +        * untouched.
> +        */
> +       for (i =3D 0; i < ARRAY_SIZE(kfunc_symbols); i++) {
> +               const struct btf_type *fn, *proto;
> +               const struct btf_param *params;
> +               const char *name =3D kfunc_symbols[i].name;
> +               u32 fl =3D kfunc_symbols[i].flags;
> +               __u32 nr;
> +
> +               fn =3D btf__type_by_id(btf, kfunc_symbols[i].id);
> +               if (!ASSERT_TRUE(fn && btf_is_func(fn), name))
> +                       continue;
> +               proto =3D btf__type_by_id(btf, fn->type);
> +               if (!ASSERT_TRUE(proto && btf_is_func_proto(proto), name)=
)
> +                       continue;
> +               params =3D btf_params(proto);
> +               nr =3D btf_vlen(proto);
> +
> +               ASSERT_EQ(is_arena_tagged_ptr(btf, proto->type),
> +                         !!(fl & KF_ARENA_RET), name);
> +               if (nr > 0)
> +                       ASSERT_EQ(is_arena_tagged_ptr(btf, params[0].type=
),
> +                                 !!(fl & KF_ARENA_ARG1), name);
> +               if (nr > 1)
> +                       ASSERT_EQ(is_arena_tagged_ptr(btf, params[1].type=
),
> +                                 !!(fl & KF_ARENA_ARG2), name);

I'd add {} around all multi-line if bodies

> +       }
> +
>  out:
>         btf__free(btf);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/btf_data.c b/tools/testing=
/selftests/bpf/progs/btf_data.c
> index 8587658012c3..ec34f7a6e038 100644
> --- a/tools/testing/selftests/bpf/progs/btf_data.c
> +++ b/tools/testing/selftests/bpf/progs/btf_data.c
> @@ -58,3 +58,13 @@ int kfunc_b(struct root_struct *root)
>  {
>         return 0;
>  }
> +
> +struct root_struct *kfunc_c(struct root_struct *a, struct root_struct *b=
)
> +{
> +       return a;
> +}
> +
> +int kfunc_d(struct root_struct *a, struct root_struct *b)
> +{
> +       return 0;
> +}
> --
> 2.54.0
>
