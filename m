Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620E73539
	for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710448586; cv=none; b=fiCsksIUey5NNH1LAupBgYoRvJ4n5GUEAnRXVJQJKdz4JodQsVTa9th0RBKh3LK+KsYa34fVR1crFM7nXQuV6N+OZbxawblTwttJcZea68a+uSHjl9bnMaS/xRukoYfZ2KvwRBHwkAn0m9h0bsTLEb7cNeZoGF/eaWg6Iel2Cdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710448586; c=relaxed/simple;
	bh=SQmzlqqfIZdDnsJzbJILdD2Zalux16ytFMGddMRv30w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQBiXocjN4yhBJT/o1a6E0IZyU5aUh+cTJouTbA6S70SmnxEr+K6LpcJDeVZU4U61rF96QR1AoGHPawYV//GuxLl1XKlnI9Vk1RgUKDwrN64gPnji4pUS7Q/CUP6IXIbhmZLF7MCkxB31xw85bZX3NBwZTwy5p7rVu+gMWDj0Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIXvuhJk; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIXvuhJk"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so1080743a12.1
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710448583; x=1711053383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L83PgkjPwhdF9t3YVMUVm9BpVLEor+fvCDCMuLO2CeY=;
        b=gIXvuhJkyetNXPgYxfKvjTrztrH5urfPrk0yh7xfJ1tY5G00Df6C/5gKdfn/PTgjgv
         jcjCaR32hYCkEJkIxTxKefbCaNkBXX1ODj0ycwR+frkTGSEKqhcxOPKAbd83xvz/GYf9
         Cmxk0ROQA5CTNrmIF9TmfF50KMXiFCT4ZdFMgGRVBl3GPTxMzv5Jc5pDAN1M6ime7hI1
         djhTpBTE93+iekwRVeB03cSb5Ohq9mmXY0KdYTbMl+GtOsVRtg/efeZ6zqrwlrB+sQAl
         k6FwcnE0jAGym7+5FWK9SR4OWhJyILbonCgbnMJIi+r7eZ3ECT1eaVRbkuWWpcCvANKd
         MCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710448583; x=1711053383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L83PgkjPwhdF9t3YVMUVm9BpVLEor+fvCDCMuLO2CeY=;
        b=kojAp/t6VPx2+3rfhhK9ZMSfYjJmZIEN800UsoGPjyYlEEEs0y6JNGv5cU3IrfQJUk
         YneUy9VLV1ycbtQwwZ/jgWFuW6L29Mw60wndFLQ30epKap+CetgcgvulIo+y63YJFTXt
         4yApY2MeAp0xOEtop6TC7bT04DiziIsIBKjNQdIJUEmnEhITmt0lBAS9pgMGx08ZjKY1
         24wsVsHH5j0T9NNGU8BaXjYAcVfy4bo6zUrL7JHO5icxa/e2CFWoITLWgKuAQ1QFXTWZ
         GUH2ks+jA37etEJMXSs9biD5if/XdyI44Z+k9I5V0gWx0WIZcAsN5nafj3+eU2vLum6U
         hTww==
X-Forwarded-Encrypted: i=1; AJvYcCVteC3buMHXFicBP8yFZinCYoRb78lNe4J3jatMp0ws5CLyQjT7/pZShIAQicmVf5nwc5Iow1uqoffzI8FBTlaZ+Mix
X-Gm-Message-State: AOJu0Yz+OPTzuvFklkhX5b9D0loiGJa5002GgsJ5UmMcFtcqWBuEn88S
	9TS1LjKnYxhlISFsALWjmKLewsQQWJvswdOFsnIKJfbtjaGqn9lKFxPVsj0RmOEDh0Ez+46ychU
	+ac5ule7PQnSxcyDugHvA6SKCaUY=
X-Google-Smtp-Source: AGHT+IFo8jUKCdEmEadQfqhla2eweKJ032jtF+QKl+++fjWlw4yw3hBFUBSUzxQb2u+WzaXNED4CSzs251eEhNbV+fM=
X-Received: by 2002:a17:90a:f606:b0:29c:761e:3955 with SMTP id
 bw6-20020a17090af60600b0029c761e3955mr2543864pjb.17.1710448582975; Thu, 14
 Mar 2024 13:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312013726.1780720-1-thinker.li@gmail.com>
 <CAEf4BzZafCA3gQVgmL1-OnpcWPXNJZ8iXgdaH82gAvu5TEOVEw@mail.gmail.com>
 <c1781093-69fe-4760-9df5-8ae71a3ecd05@gmail.com> <CAEf4Bzb8ft68Ue-=2pQBGySbjpE2cgPvtDJaec3F-NyE_tTB5Q@mail.gmail.com>
 <b81c0d46-d817-4a7d-a1c4-c6de707fbe7b@gmail.com> <CAEf4BzaeBwnX7_tTy-aNQtAwwTy==nOgVyBGcaLE=4FB0BVgXw@mail.gmail.com>
In-Reply-To: <CAEf4BzaeBwnX7_tTy-aNQtAwwTy==nOgVyBGcaLE=4FB0BVgXw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Mar 2024 13:36:10 -0700
Message-ID: <CAEf4BzZrtwoBX=GXPg=fpyyomW5oSUhpFxpmi5Pw-o70wRSLYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: cast pointers for shadow types explicitly.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, kuifeng@meta.com, yhs@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 8:51=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Mar 12, 2024 at 5:37=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com=
> wrote:
> >
> >
> >
> > On 3/12/24 17:27, Andrii Nakryiko wrote:
> > > On Tue, Mar 12, 2024 at 5:08=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail=
.com> wrote:
> > >>
> > >>
> > >>
> > >> On 3/12/24 15:47, Andrii Nakryiko wrote:
> > >>> On Mon, Mar 11, 2024 at 6:38=E2=80=AFPM Kui-Feng Lee <thinker.li@gm=
ail.com> wrote:
> > >>>>
> > >>>> According to a report, skeletons fail to assign shadow pointers wh=
en being
> > >>>> compiled with C++ programs. Unlike C doing implicit casting for vo=
id
> > >>>> pointers, C++ requires an explicit casting.
> > >>>>
> > >>>> To support C++, we do explicit casting for each shadow pointer.
> > >>>>
> > >>>> Cc: yhs@meta.com
> > >>>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> > >>>> ---
> > >>>>    tools/bpf/bpftool/gen.c | 2 +-
> > >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>>
> > >>>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > >>>> index 4fa4ade1ce74..dedafea0c127 100644
> > >>>> --- a/tools/bpf/bpftool/gen.c
> > >>>> +++ b/tools/bpf/bpftool/gen.c
> > >>>> @@ -1131,7 +1131,7 @@ static void gen_st_ops_shadow_init(struct bt=
f *btf, struct bpf_object *obj)
> > >>>>                           continue;
> > >>>>                   codegen("\
> > >>>>                           \n\
> > >>>> -                               obj->struct_ops.%1$s =3D bpf_map__=
initial_value(obj->maps.%1$s, NULL);\n\
> > >>>> +                               obj->struct_ops.%1$s =3D (typeof(o=
bj->struct_ops.%1$s))bpf_map__initial_value(obj->maps.%1$s, NULL);\n\
> > >>>
> > >>> Given we have a named struct type for this and we use explicit type
> > >>> names in other parts of generated skeleton code, let's maybe use
> > >>> "struct %s__%s__%s" explicitly here (passing in obj_name, ident,
> > >>> type_name)?
> > >>
> > >> I have considered about this solution. But, C++ works differently. I=
t
> > >> has nested namespaces. That means it should be referred as
> > >> "XXX_skeleton::OOO_st_ops_map" in C++. Then, we need #if #else #endi=
f
> > >> directives to provide two separated casting.
> > >>
> > >
> > > we cast to (struct <skeleton> *) by name of the skeleton, so it shoul=
d
> > > be fine, I don't see why we'd need to do something C++ specific here
> >
> > The skeleton looks like
> >
> > struct struct_ops_module {
> >      ......
> >      struct {
> >          struct
> > struct_ops_module__testmod_zeroed__bpf_testmod_ops___zeroed {
> >              ....
> >          } testmod_zeroed;
> >      } struct_ops;
> > };
> >
> > struct struct_ops_module__testmod_zeroed__bpf_testmod_ops___zeroed is
> > inside of struct struct_ops_module. In C++, it should be referred as
> > "struct_ops_module::struct_ops_module__testmod_zeroed__bpf_testmod_ops_=
__zeroed".
>
> ah, makes sense, thanks for elaborating
>
> >
> > The other option is moving definitions of these types to the top scope.
>
> no, it's fine the way you did it in this patch, I'll land it once
> bpf-next tree is open for new patches, thanks
>

so I made the following changes/additions as I was applying your patch:

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index dedafea0c127..3ce277544c24 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1131,7 +1131,8 @@ static void gen_st_ops_shadow_init(struct btf
*btf, struct bpf_object *obj)
                        continue;
                codegen("\
                        \n\
-                               obj->struct_ops.%1$s =3D
(typeof(obj->struct_ops.%1$s))bpf_map__initial_value(obj->maps.%1$s,
NULL);\n\
+                               obj->struct_ops.%1$s =3D
(typeof(obj->struct_ops.%1$s))\n\
+
bpf_map__initial_value(obj->maps.%1$s, NULL);\n\
                        \n\
                        ", ident);
        }
diff --git a/tools/testing/selftests/bpf/test_cpp.cpp
b/tools/testing/selftests/bpf/test_cpp.cpp
index f4936834f76f..dde0bb16e782 100644
--- a/tools/testing/selftests/bpf/test_cpp.cpp
+++ b/tools/testing/selftests/bpf/test_cpp.cpp
@@ -7,6 +7,7 @@
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include "test_core_extern.skel.h"
+#include "struct_ops_module.skel.h"

 template <typename T>
 class Skeleton {
@@ -98,6 +99,7 @@ int main(int argc, char *argv[])
 {
        struct btf_dump_opts opts =3D { };
        struct test_core_extern *skel;
+       struct struct_ops_module *skel2;
        struct btf *btf;
        int fd;

@@ -118,6 +120,9 @@ int main(int argc, char *argv[])
        skel =3D test_core_extern__open_and_load();
        test_core_extern__destroy(skel);

+       skel2 =3D struct_ops_module__open_and_load();
+       struct_ops_module__destroy(skel2);
+
        fd =3D bpf_enable_stats(BPF_STATS_RUN_TIME);
        if (fd < 0)
                std::cout << "FAILED to enable stats: " << fd << std::endl;


test_cpp is a good think to validate that skeletons are compiled with
C++ compiler just fine, so I referenced struct_ops-based skeleton
there.


> >
> > >
> > >>>
> > >>> No strong preferences, but feels like a consistent approach here wo=
uld be nice.
> > >>>
> > >>>>                           \n\
> > >>>>                           ", ident);
> > >>>>           }
> > >>>> --
> > >>>> 2.34.1
> > >>>>
