Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E824385
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710289660; cv=none; b=iNvXcc5x4KfUFxOvWrMzIl06vgg/Bpufj/j0t0yrMs0wPezKGZQNG9YF6skbmFf0R4Fn4J1GUPXlyESff/P97pIPXbFU3sRhNGf8NFI00s0lQTXkGfgtiIOS6gWW1jhA/4IViKRzkSWSFdDbDwS7CWaQHAwwlhwWTCqiFoYk/lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710289660; c=relaxed/simple;
	bh=rV6sSr3hpp1M6DD1mIvwnNpMKylsElFr4SzqGj0UrOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpAM9kGZ6elPvkclmxqTxAjJSKqycY9gzkiz06KnakvjgcYVb/jihAVa837/zCy2rGjFnXJQMRQsRQtvE4VtzRlVJEvd982e7mo6VgnrZRyUlsbZKZNBW5i3RrkRSOqo+ouNVPr4DH/aTvJaGFt1AgUfC2TuzEEpMPk8LE4MQXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ge432yui; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge432yui"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29aa91e173dso4341724a91.0
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 17:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710289659; x=1710894459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6khEUPsucsN9UN37vMK7rghn7SPHxcdE2drQgkwzy0=;
        b=ge432yuiQ25Sa/LVQO4+kDj3HrN5awp2zwEv6tGQbIFfbTrHIStT4A7x3maR+9EZsa
         TBdGbgc6iLNfwxpY1UqEbBdx25ROLx/RpjM++PKKgrYsHq0USjkJecBfkK+YUONCI1+p
         SjxZK/nV6cg9/tQI54J5bli1iO7Lna1Tn6dOXc1tTytpBm+VEpwrZH/ipANIbmPjJczg
         2xraEXtnAMZdNgAX5UgBsj/RWEB+0dfBisk3hJT8ya/pZrvATOGRf1VY6NfECRad49td
         hwi/zurJOehGM/XJkfBh2mNqwiRarZPovkuqHBn+2frQBKlPd5YYa2z5MMzDhlNSmBOL
         yqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710289659; x=1710894459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6khEUPsucsN9UN37vMK7rghn7SPHxcdE2drQgkwzy0=;
        b=Nqm4wGE5x+l3X0/x7jsa/7SJgjKyvaTbe36mVcEcXJW/Ke3niV1dnExwNCl8lv2gd2
         EhH5/qQ5RZNYE4U2UEynPsjBlR4AFm+OqdVojlme5EPNeB8nL+Eve2UAYeSFNBkfAf1I
         SJ0+BM/4qBzjaG01z91mX1qo2xgGFppqv2sypxoivdBTouwkGeHhCxWRJBWaW2DTIBzg
         KClpDUCs8H94VzuoCqmG2r8b2bzGRxVwL+1CLBkblI/JqLdMNTsfU5n+s/Fz3S6QU6/H
         XWDwInWzcBfDHUknrdt8N13yvI1EHXdSYuh1AfAUGXBWIp2b7ouJEJibg9b/RecyDJyD
         V0kw==
X-Forwarded-Encrypted: i=1; AJvYcCWYhhioqeMl2vXwkPGNbRtbejPoo1lQAoPaa5uokxZlXmxcH4ca+XybK62SEgJO9V0q1alNwxSTWdLtIdNj/lLvzOXt
X-Gm-Message-State: AOJu0YzmcgD3IqeAaYRRdTggxnn2B+3j8yoYS4pOoDfDh5Gy2Jaa+RmM
	mi5vzD3xe8sIJGMT/VHzd+Tx0ynhqeTcXBjIeskRra9BjXUuBK6fqUFnbwV1yY0WGyiaP/apBaX
	DjavIwsUUGU1nlYmhRUerq7QzRLI=
X-Google-Smtp-Source: AGHT+IGu1WnUwLiMfTcpywjuO+1pCTp3g8YQouyEidVOQ1PHPILsgyFgfVxIgQh9QsG9/l1Ug6ynvYWqLoBybT++e30=
X-Received: by 2002:a17:90a:8b02:b0:299:4cc5:aa25 with SMTP id
 y2-20020a17090a8b0200b002994cc5aa25mr3095269pjn.25.1710289658573; Tue, 12 Mar
 2024 17:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312013726.1780720-1-thinker.li@gmail.com>
 <CAEf4BzZafCA3gQVgmL1-OnpcWPXNJZ8iXgdaH82gAvu5TEOVEw@mail.gmail.com> <c1781093-69fe-4760-9df5-8ae71a3ecd05@gmail.com>
In-Reply-To: <c1781093-69fe-4760-9df5-8ae71a3ecd05@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Mar 2024 17:27:25 -0700
Message-ID: <CAEf4Bzb8ft68Ue-=2pQBGySbjpE2cgPvtDJaec3F-NyE_tTB5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: cast pointers for shadow types explicitly.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, kuifeng@meta.com, yhs@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 5:08=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 3/12/24 15:47, Andrii Nakryiko wrote:
> > On Mon, Mar 11, 2024 at 6:38=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.=
com> wrote:
> >>
> >> According to a report, skeletons fail to assign shadow pointers when b=
eing
> >> compiled with C++ programs. Unlike C doing implicit casting for void
> >> pointers, C++ requires an explicit casting.
> >>
> >> To support C++, we do explicit casting for each shadow pointer.
> >>
> >> Cc: yhs@meta.com
> >> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> >> ---
> >>   tools/bpf/bpftool/gen.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> >> index 4fa4ade1ce74..dedafea0c127 100644
> >> --- a/tools/bpf/bpftool/gen.c
> >> +++ b/tools/bpf/bpftool/gen.c
> >> @@ -1131,7 +1131,7 @@ static void gen_st_ops_shadow_init(struct btf *b=
tf, struct bpf_object *obj)
> >>                          continue;
> >>                  codegen("\
> >>                          \n\
> >> -                               obj->struct_ops.%1$s =3D bpf_map__init=
ial_value(obj->maps.%1$s, NULL);\n\
> >> +                               obj->struct_ops.%1$s =3D (typeof(obj->=
struct_ops.%1$s))bpf_map__initial_value(obj->maps.%1$s, NULL);\n\
> >
> > Given we have a named struct type for this and we use explicit type
> > names in other parts of generated skeleton code, let's maybe use
> > "struct %s__%s__%s" explicitly here (passing in obj_name, ident,
> > type_name)?
>
> I have considered about this solution. But, C++ works differently. It
> has nested namespaces. That means it should be referred as
> "XXX_skeleton::OOO_st_ops_map" in C++. Then, we need #if #else #endif
> directives to provide two separated casting.
>

we cast to (struct <skeleton> *) by name of the skeleton, so it should
be fine, I don't see why we'd need to do something C++ specific here

> >
> > No strong preferences, but feels like a consistent approach here would =
be nice.
> >
> >>                          \n\
> >>                          ", ident);
> >>          }
> >> --
> >> 2.34.1
> >>
