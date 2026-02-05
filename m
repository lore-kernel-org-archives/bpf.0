Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAA513D638
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770331527; cv=pass; b=VxqO6gBswq4TE69nJe6DV7/qYMB/x/VOZh/bS5+wExElwJg4bRGeT55iMnOJJzGQqQdUBNTmFtckm65WrAbxeIxurNod92IlklXV/CG63Z8Ncm1MbHcFROCkBesBAJxp4rQvAjPyudhtSeXdsprmpb401wtKZeBheHDwNVbW4fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770331527; c=relaxed/simple;
	bh=yOxljLs6cqtxsxON4cULkhGiN4JpDaED6E4B0ILFuH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/7kiFZMtiR6xg3KhAaZkpHsYzyDsC63bAaFnIKyhFKMpmzjGzSTzMJi03w96VzeBVSE6vyqvg8iBjvow9tBZhrTZb0qXp+jLTbU7cIFR4v0fFhSyMavL789vZvAy1YYoHnYtYRJjQL0nlL6nudFdxnUVNfOLkscN9iRf5DPx/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcJkUagt; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcJkUagt"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3549bba5302so853076a91.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 14:45:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770331527; cv=none;
        d=google.com; s=arc-20240605;
        b=aQ47901a1wUA9gA1TUAVtDPESiYcS7BEtlGcdRJDFr9oNOxW9RcbnRv35IKmFJ3Abu
         7UZWEtYd2MPbdVg50a4drDLBKCE9wk6yMmwlrNKWMhkUIno8VPKMaIxZex9vvc71/0Uw
         hrgdeIHZCBOU2Y6zK761yNkXg+VsvTdvB0hAUNh0EISmSijoETQKmA5x42MYH4KFZfib
         NEQf0Xiy7wI3HYiE+cB5zU29atCuD924ltJ+beHNAq5DULiIE0iPB0tDjPv6bc35YLzf
         Ltk9LNWnaUTXP4/77r4oWFUOFNZ6x3wZd0tyebmj15sDYab5ZVkxFG5tdQ0PID1PkpMI
         CO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BIYE1f3z3VJR2b710rNdmRj1J/VpDRr/cUVcptRb4JU=;
        fh=TJuAJWq6n3m23kuCJyH7DhZNUst0O47mgrX++u5Ve9c=;
        b=LE96QiEEjuBSjHOpyc3qAEKRoxR1EftZdiRzNGWzal6+qvspkmoZoTXlvC8TLvrKFv
         rN/6JUln7Dzs1tA5kyx8AD/PJ/rIqdNJ/4l26Dq8c4nCZVJpsNgCuMGU4GzvivX8V+rA
         orXLMfBqRGi9kBagANL+Y3Ow+J51n6ACE6ZE2ygf2JDURtqrtNU7af+2OIh6Oi5lRmue
         PyVe8E2gBEVfVa5qoYcEdYeG96VH0MsKRPefBwmFXXdM4L/5BJg+XxKGs88r8IWHj0f4
         wDsxN2IyHCqsffh8fJGn0lWZxgmEzrsZeRJ76YMIfBCEhLpBrpIXiuttVe4eLyhYigf9
         0kcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770331527; x=1770936327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIYE1f3z3VJR2b710rNdmRj1J/VpDRr/cUVcptRb4JU=;
        b=hcJkUagtyuMF/2vjAjaP+BlFjrTbHHKoGsUmolPI6cQiaXbhwfjmJy6BJOq5Mfnv7s
         fmsL/Nj3cJx6BtLx2VKaPdwYpyIcCQQaPR3BKBczAJRwAOwWixpakaMeo2faymAE5XB3
         MhzpNLYjuizVnXMKwo9sMXaRaE1Air0xks10AIi7G2Tg1lkeXTiJhvh8No3TwSiwfTz1
         ILpKm6bHWAp4T6iwtC3QOlwyEW9kFKQWD2atavyZWo3YHGIwCDSQRIbL7RNHE2MblZDP
         +D/pIIfjYKNdln/41yk6+NW/774h9a4WtCLtk+wjtjP8z9WZT1dMTWlnoZA+VPZX83gr
         nRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770331527; x=1770936327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BIYE1f3z3VJR2b710rNdmRj1J/VpDRr/cUVcptRb4JU=;
        b=WLzJ1okW/uktwAt4hC7/nlLH9fGGyy8aoxPGydkJlPodY/dUO7ftYxm4jJGgG0QAPo
         7zN49zTh8B0LT6XxTUdFPC3EiJM27I6W33a2IBjJb8CW/PYkc7PSG/1Ip8V+2hZVXz3+
         Lpwxh2oxq7+hYrL2cr84CtGWtrsXNtsw2MjwN9tErL47DdIpLxR4lt9cOBB0Use4YTii
         yqIP47xKmCkhi6EhKMmhDjYLDEDY/XAiH8N5Geceew+d98t91zDQf0RansBhLcMB6dfS
         2jO4yWHMqPPx1BDEG1S9l+w6mQalIzf8MAZt4JDAAG+2YoTMQr4FfyUWE6Xey0XXdsDw
         juYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPXxOiaEHw1dGXUrMQUuVWvSAB3IykqjaWFm2P6MoT67Er5nBlu7led2E505HS9dJIInU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeNXQKhQeK3NVWhcZenjMSvOxnwnSbEUjU9tXsUadftugjmd/F
	8Gp5edJZLqOO3k4zzeVg20akRgGkeO2vQ1nuhW+0uBfKJQ5fn/42QT4wxKGDJEINFmg+nnwitAp
	5NhV+2CiHyBcPVD306s2wtjsrRE3z9Zg=
X-Gm-Gg: AZuq6aKJyTOAF8Gq/Z9avyyWooPSv1YnWJSZaLyF9HYdFH8uC9p6hi2YP1GY7x4TeAB
	NnZ55SFYHIhixSyy9/+Y6gUIZdpG6igPNxP8xXCxeRobBshNjw1vNBcNCJxKwYgGD4nLLuWJzzY
	Zaz/xwjijisyyXaqIwYw5PNQ1Mxom8wcNBSboI7qlQriYd2oRAa4m0qn1M4k8Vy4xN0Crm+MF0q
	7dAW/9f9SFgU2pzqXraITww39E1S9Clez0Gh+4x2HJltkcvbTx88x0gMfQ7UrOTRyckB/rx3MRv
	d8kowcBLt0g=
X-Received: by 2002:a17:90b:528b:b0:34c:60dd:1bdd with SMTP id
 98e67ed59e1d1-354b3e267b4mr418716a91.22.1770331526739; Thu, 05 Feb 2026
 14:45:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203093819.2105105-1-jolsa@kernel.org> <20260203093819.2105105-9-jolsa@kernel.org>
 <CAEf4BzY7zZmEqFq577NiG2wh0aU0_og1_RjVSURjaqTOnTc-Bw@mail.gmail.com> <aYRbbL-QCnAZ6PGD@krava>
In-Reply-To: <aYRbbL-QCnAZ6PGD@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Feb 2026 14:45:14 -0800
X-Gm-Features: AZwV_QiMbxciqnNDNfiTeCrle5PemySR_UTMWl4o0CDlCuOKHMa7vmKOkTbkyFI
Message-ID: <CAEf4BzbzrPemyBe0xtEwuxG8d-JUC+Dd+B412VBLLAui=88LEw@mail.gmail.com>
Subject: Re: [RFC bpf-next 08/12] libbpf: Add btf__find_by_glob_kind function
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, Menglong Dong <menglong8.dong@gmail.com>, 
	Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 12:57=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Feb 04, 2026 at 11:04:09AM -0800, Andrii Nakryiko wrote:
> > On Tue, Feb 3, 2026 at 1:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wro=
te:
> > >
> > > Adding btf__find_by_glob_kind function that returns array of
> > > BTF ids that match given kind and allow/deny patterns.
> > >
> > > int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> > >                            const char *allow_pattern,
> > >                            const char *deny_pattern,
> > >                            __u32 **__ids);
> > >
> > > The __ids array is allocated and needs to be manually freed.
> > >
> > > The pattern check is done by glob_match function.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/lib/bpf/btf.c | 41 +++++++++++++++++++++++++++++++++++++++++
> > >  tools/lib/bpf/btf.h |  3 +++
> > >  2 files changed, 44 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > index 83fe79ffcb8f..64502b3ef38a 100644
> > > --- a/tools/lib/bpf/btf.c
> > > +++ b/tools/lib/bpf/btf.c
> > > @@ -1010,6 +1010,47 @@ __s32 btf__find_by_name_kind(const struct btf =
*btf, const char *type_name,
> > >         return btf_find_by_name_kind(btf, 1, type_name, kind);
> > >  }
> > >
> > > +int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> > > +                          const char *allow_pattern, const char *den=
y_pattern,
> > > +                          __u32 **__ids)
> > > +{
> > > +       __u32 i, nr_types =3D btf__type_cnt(btf);
> > > +       int cnt =3D 0, alloc =3D 0;
> > > +       __u32 *ids =3D NULL;
> > > +
> > > +       for (i =3D 1; i < nr_types; i++) {
> > > +               const struct btf_type *t =3D btf__type_by_id(btf, i);
> > > +               const char *name;
> > > +               __u32 *p;
> > > +
> > > +               if (btf_kind(t) !=3D kind)
> > > +                       continue;
> > > +               name =3D btf__name_by_offset(btf, t->name_off);
> > > +               if (!name)
> > > +                       continue;
> > > +
> > > +               if (deny_pattern && glob_match(name, deny_pattern))
> > > +                       continue;
> > > +               if (allow_pattern && !glob_match(name, allow_pattern)=
)
> > > +                       continue;
> > > +
> > > +               if (cnt =3D=3D alloc) {
> > > +                       alloc =3D max(16, alloc * 3 / 2);
> > > +                       p =3D libbpf_reallocarray(ids, alloc, sizeof(=
__u32));
> > > +                       if (!p) {
> > > +                               free(ids);
> > > +                               return -ENOMEM;
> > > +                       }
> > > +                       ids =3D p;
> > > +               }
> > > +               ids[cnt] =3D i;
> > > +               cnt++;
> > > +       }
> > > +
> > > +       *__ids =3D ids;
> > > +       return cnt;
> > > +}
> > > +
> > >  static bool btf_is_modifiable(const struct btf *btf)
> > >  {
> > >         return (void *)btf->hdr !=3D btf->raw_data;
> > > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > > index b30008c267c0..d7b47bb0ba99 100644
> > > --- a/tools/lib/bpf/btf.h
> > > +++ b/tools/lib/bpf/btf.h
> > > @@ -661,6 +661,9 @@ static inline struct btf_decl_tag *btf_decl_tag(c=
onst struct btf_type *t)
> > >         return (struct btf_decl_tag *)(t + 1);
> > >  }
> > >
> > > +int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> > > +                          const char *allow_pattern, const char *den=
y_pattern,
> > > +                          __u32 **__ids);
> >
> >
> > as AI pointed out, this should be an internal helper, no? Let's also
> > not use double underscore pattern here,
> > "collect_btf_ids_by_glob_kind()" perhaps?
>
> ok
>
> >
> > Also, you don't seem to be using deny_pattern, where you planning to?
>
> the tests are just rudimentary before we agree we want to do it this way
>
> but I'm not sure I have a usecase for deny_pattern.. I think we added it
> just to be complete, I recall we copied that function from somewhere,
> it's long time ago ;-)
>
> >
> > Also, are there functions that we'll have BTF for, but they won't be
> > attachable? What if I do SEC("fentry.multi/*")? Will it attach or fail
> > to attach some functions (and thus fail the overall attachment)?
>
> yes, for the benchmark tests I had to add is_allowed_func which mimics
> btf_distill_func_proto and denies attach for some functions
>
> also I had to filter out some core kernel functions like rcu*,trace*,..
> which seemed to cause trouble when you attach them

So the question I'm implying here is if libbpf should do what we do
for kprobes: use libbpf_available_kprobes_parse and intersect?

>
> jirka
