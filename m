Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663AD2D600
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345080; cv=none; b=XQrxuAkWy0uzBqTOeBsz6SWRhy8XUuwwkBedgnOeTf/RpOzVASVLxvQJpp1Xu7rgPcioQrPm/Tnv4gLqzp8eUjKQYp+wOx7fKi1FzI0YmsDS9Yl8aZn7UJcd/buyCXuUvFHDL2936dTeUYq/mJKrYaec+vs0JfZrgXmogJVJo3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345080; c=relaxed/simple;
	bh=/0Mr2BOlkjxbVCWkh6OxYZVKoceJC+ZJ5eiE0X8V68s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUZX7sR7/v10yeHKX/2FsE/6Vxn1+OijADa9P59OOjZTNFr14mtpLZ7Tvqgn46jCh0G20eXOfLNOY2YVdloKtyczy4kNlSWG3u0QprHDP2PQ+uSP0FKbtWX3G822wqlZlo95qaOQJJz0x8/TYil3h3j/Oi1yfPdVKJ5VIbwvJvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m911qmvS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m911qmvS"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29c4fe68666so39291a91.0
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 08:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710345079; x=1710949879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZs1grIcRK2Cdh3wHMXwlKBEGRtebpzaPp5p0gueRsc=;
        b=m911qmvSuJUnKwkRF8JBn+hf6NJXzS7PdD5Uz8QNbx8ZLxs0A8xpY4LGmXeJSFw3mn
         j0+/lKh16fUtSeWEgNt8mQ1XVJDlGU8DEZrBZ7rYVMXmd1OulqtcmX318rMrCTP/Zc0/
         qEAYpYaSDn0lk5uNsYbqTw7wOGaQm2ZIFh9I6i6isbWHA3uoE8Q8jN/QFVd3fyGT3atl
         DFZFbzjsptSfMGJfKZD2VbYazUIlo2d73i9TNEFzhZKVhGsdUDJ41uvxe1HwQreuQwCa
         d1xL9OzwXLsE40+1fUU4ruVoIR/1fwoj0P9DT0QSMh72/c7Ca4eJaWFkslFhmLpHHyPK
         izJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710345079; x=1710949879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZs1grIcRK2Cdh3wHMXwlKBEGRtebpzaPp5p0gueRsc=;
        b=crwuMbGH7A+/ovnUyvdQoN0N0dhbP+whoi6/elzOyLanCwnQYfo64Eivt0/FQ7ovja
         42TSgfnfZTb7+oRSSSMSWlqRXa9Um0Yzsv+fZWiwfxoo8QOfxCKSezTunC6Hs5T8BhEq
         HAzn3zBao1FWzYmFbMA+j6GAS73l3+d50kOLq9jqW98Yni4VTBzpiqK7KT23QSiOf+ov
         qkX9dgfWyb/UKw4BOc8+FJ12vlvy1a9qgX1bDoHA4sjodTXKjXuv1Bv/v/ny9nHC5RWS
         M4yfMbK9ZUIMr/EaSDdlJzDbxGqT/cirV9ud+OGE69tApacbowG2Ep1huzhmct0JlafC
         rxuA==
X-Forwarded-Encrypted: i=1; AJvYcCW3BZVOfWlA6RdNQcRgTFrjf22aTIOGJVYNKOztBaeHmX9+uYWYGbYsXOuKklk0QofgLZxBk8OCpQLdAOe+HCqqn3ra
X-Gm-Message-State: AOJu0YznBhMl08QJbVk69v5Z80ihBLq9xucwgZ31aVclqgEvet1ZGWQj
	LL376nsSwdC8pHRc6IimUUbYgcwXsOIgwlfXT+IaZglTAo/fsPCk4o8pBuAEitUgdy1K8MSBMls
	9KjYARoNMF70Z6OABc5x1yheVQW8=
X-Google-Smtp-Source: AGHT+IHnxrl6igTb1NneDQG+FIqymsTlRo8mENRgqfci2bzSCjVXwDJGSZup5r26gU8PiNN4u6fNn74cu8iI3FtjLNg=
X-Received: by 2002:a17:90b:35c3:b0:29b:b6bb:17ba with SMTP id
 nb3-20020a17090b35c300b0029bb6bb17bamr3366502pjb.46.1710345078637; Wed, 13
 Mar 2024 08:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312013726.1780720-1-thinker.li@gmail.com>
 <CAEf4BzZafCA3gQVgmL1-OnpcWPXNJZ8iXgdaH82gAvu5TEOVEw@mail.gmail.com>
 <c1781093-69fe-4760-9df5-8ae71a3ecd05@gmail.com> <CAEf4Bzb8ft68Ue-=2pQBGySbjpE2cgPvtDJaec3F-NyE_tTB5Q@mail.gmail.com>
 <b81c0d46-d817-4a7d-a1c4-c6de707fbe7b@gmail.com>
In-Reply-To: <b81c0d46-d817-4a7d-a1c4-c6de707fbe7b@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Mar 2024 08:51:06 -0700
Message-ID: <CAEf4BzaeBwnX7_tTy-aNQtAwwTy==nOgVyBGcaLE=4FB0BVgXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: cast pointers for shadow types explicitly.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, kuifeng@meta.com, yhs@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 5:37=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 3/12/24 17:27, Andrii Nakryiko wrote:
> > On Tue, Mar 12, 2024 at 5:08=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.c=
om> wrote:
> >>
> >>
> >>
> >> On 3/12/24 15:47, Andrii Nakryiko wrote:
> >>> On Mon, Mar 11, 2024 at 6:38=E2=80=AFPM Kui-Feng Lee <thinker.li@gmai=
l.com> wrote:
> >>>>
> >>>> According to a report, skeletons fail to assign shadow pointers when=
 being
> >>>> compiled with C++ programs. Unlike C doing implicit casting for void
> >>>> pointers, C++ requires an explicit casting.
> >>>>
> >>>> To support C++, we do explicit casting for each shadow pointer.
> >>>>
> >>>> Cc: yhs@meta.com
> >>>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> >>>> ---
> >>>>    tools/bpf/bpftool/gen.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> >>>> index 4fa4ade1ce74..dedafea0c127 100644
> >>>> --- a/tools/bpf/bpftool/gen.c
> >>>> +++ b/tools/bpf/bpftool/gen.c
> >>>> @@ -1131,7 +1131,7 @@ static void gen_st_ops_shadow_init(struct btf =
*btf, struct bpf_object *obj)
> >>>>                           continue;
> >>>>                   codegen("\
> >>>>                           \n\
> >>>> -                               obj->struct_ops.%1$s =3D bpf_map__in=
itial_value(obj->maps.%1$s, NULL);\n\
> >>>> +                               obj->struct_ops.%1$s =3D (typeof(obj=
->struct_ops.%1$s))bpf_map__initial_value(obj->maps.%1$s, NULL);\n\
> >>>
> >>> Given we have a named struct type for this and we use explicit type
> >>> names in other parts of generated skeleton code, let's maybe use
> >>> "struct %s__%s__%s" explicitly here (passing in obj_name, ident,
> >>> type_name)?
> >>
> >> I have considered about this solution. But, C++ works differently. It
> >> has nested namespaces. That means it should be referred as
> >> "XXX_skeleton::OOO_st_ops_map" in C++. Then, we need #if #else #endif
> >> directives to provide two separated casting.
> >>
> >
> > we cast to (struct <skeleton> *) by name of the skeleton, so it should
> > be fine, I don't see why we'd need to do something C++ specific here
>
> The skeleton looks like
>
> struct struct_ops_module {
>      ......
>      struct {
>          struct
> struct_ops_module__testmod_zeroed__bpf_testmod_ops___zeroed {
>              ....
>          } testmod_zeroed;
>      } struct_ops;
> };
>
> struct struct_ops_module__testmod_zeroed__bpf_testmod_ops___zeroed is
> inside of struct struct_ops_module. In C++, it should be referred as
> "struct_ops_module::struct_ops_module__testmod_zeroed__bpf_testmod_ops___=
zeroed".

ah, makes sense, thanks for elaborating

>
> The other option is moving definitions of these types to the top scope.

no, it's fine the way you did it in this patch, I'll land it once
bpf-next tree is open for new patches, thanks

>
> >
> >>>
> >>> No strong preferences, but feels like a consistent approach here woul=
d be nice.
> >>>
> >>>>                           \n\
> >>>>                           ", ident);
> >>>>           }
> >>>> --
> >>>> 2.34.1
> >>>>
