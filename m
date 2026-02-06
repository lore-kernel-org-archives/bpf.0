Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35122DCF7B
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770397109; cv=pass; b=F8Nurm/sLXJXBLwKwKK36U0DbB6yNdm7mHE4Czn4MZ8XnngLejdGAII4PhEZVkFepHSOeKueWksqDSKMW/6wq528qzCBQHAUTnet/fjvJqT/ese8Igx9oLvSDZEf6/Lf9ZPVY5o8Kc+SOm6qE2Qa0fAgkzW19EtY4NUv6eknWKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770397109; c=relaxed/simple;
	bh=6IBq+XbEsFN4SvSjZqsxD5Hu9kTyhaVUfqnxmZg2dCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iral5xGFG/cxHzLztWnLfBtpeVRSyIsiTFZovNQb2PGaokL9WReuA8kO8f318qExZH1F5f4l8IAewcRAvCc9CrpolH8TOfgfYuyJODGjXpApLoDeMerdfsFwfIxFmHSRCetr09TGlopt+WReIvS0iGr1bkPuN8XRcr7JDcizFJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnsGqm39; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnsGqm39"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8231061d234so2448807b3a.1
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 08:58:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770397109; cv=none;
        d=google.com; s=arc-20240605;
        b=Mkn1ezcTbuBtxrGQ+xBPuoyoMqf7OnZv1qJOvaUKy8usTQGfsZrK+6qVCt7IAli0Mb
         L2GSIrmIuJ0WPVsAY0g9zKQP1TxOFNx/7vbqac1irBteiHE1ldmepGv1cQwJROXPC/+c
         KQdfNJevccW8je5yHI1zTrjZwi9e3ARmDI93juExdA/WrSCzqNaEgSrsHqwUW4e8Echr
         lFuyPcmwWfoHkaqV8RmwDjq8zkFQusPPcehvfiR2HQb4FJvl/wbmvaFk5wQ3pLx0EH7S
         dAtchHmrTzo+XfjFnjNaBnYZ2i3UWVfXdFCiBRGOIJjXVSWBTVmETEwcP4p1pLHCLfKp
         lsIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XLXsV7YNko4F5p8PCqHk8efpKDU+F1mnMJ2HETyCDMw=;
        fh=X6XiXQ/KynKAlnpa+O2r/enhLZ8UAgXTQGKOp2iIyqA=;
        b=UAzERx2ZtWhudCe5bjr7opmgMW75RYokV11sSr0Ln5mmmAbVONR7C+tStmQPCH+Bj6
         CSfQUF4jnYt37czWIm1HGoiBg2SQa/A1VQ+332o8712lZVHEAZVrADKdZZ23S6k6xqzA
         4EvLTZpOgjgHHTxOLUhXT3yyyThdhyTHk1Ea5Ytwtl0Qq14HdsihE/ZBtnAFFLSpibKq
         rYziaEtwKO/BTBLDAl/4T71fGgSthdgoFApQSYfYzF6nsnV/r6LAKfU9OT4yA/+6XfZ5
         1XCDbql7xAC0Hgx8cxGVpKz38W2UU3kFZPb8VqfjiEGQM4g7wD6eTBb9n17Ick9dkXlk
         M5pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770397109; x=1771001909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLXsV7YNko4F5p8PCqHk8efpKDU+F1mnMJ2HETyCDMw=;
        b=KnsGqm394y9Ec5UmYEfDL9ebWNGzvTU2cZS3NoZnx7zBh9F4O8PNar8bwKiYjxUDgJ
         VhSwsGqloAFm0uqWB3+rVOwA1zL1XaUzoWSpfl/SNMNRqu8oU/Bk5yW4C7eFxn6FzI8M
         Dc8IbWLT0nXHVygvrdktGAmLBcz6K9BvkFSvI4WXvL74IKGYMyyjs6NvigIA1+X9oYLL
         kOXK6xTJ2Nac1UaayEWeT9nRBibuJUiStJCNe/UFzTzuw2VhZzC8mDvObiYfNS5viVMI
         suSN5gZ61EUYq41duqUpEfBeoT48INOdC7AncsBzR3lL7VSdJii0h4BfdMCQzpKdVstG
         oMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770397109; x=1771001909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XLXsV7YNko4F5p8PCqHk8efpKDU+F1mnMJ2HETyCDMw=;
        b=FY4MFLP/yzRjsxyyEztHuY2k0fF8OuUsnze8j8Pf3VU79X7xybeNQNQNuFBIfHqdPn
         /mlyAu4B1Sd+MjFe5CBGiQnhioGyjMo5okRIuAFMaFeJRHW+6M7HxQlSfKXi1qSYx4Lb
         11kJz6xXTjP3O7m5NbIVI7v318TuerIbJYjK/FVa6rByRhSHtAY+4bxX0AT5AoABUqR8
         HpyBWoBKt2FF4uVY3N7WNnw69EKgPumIb2UxtJHy3aiMx4ZfHJIetgl288Ztp3FnHcSe
         ATul+nch4mOE/bE7D2fbcKtWPadBx+npaxbpBzTRf3+xlK05skuOsRiI1Gi+5NZBMs53
         TUQg==
X-Forwarded-Encrypted: i=1; AJvYcCV+sFOyP2hwyYbjM4EYXBwPCKkVr7RhorNowQnhp7WHEE4ddXm0V4CFBKPI1K76MtGXNQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YypHDJ8L+q3MgCxtY9hBNHcmVB84hiwFVu1RMfoJB2V6kEoHIlc
	ry9XlNyos5Y29ufIoagqP5EeY7T1gstHmsFRhYQQ2YAiwgV3XC8KZyDb+JfsLP8YfdGYsRQA8d1
	kXRa6nlScxKl5KjtFhUm8qVyTM7ZgOOQ=
X-Gm-Gg: AZuq6aJpy8dHeufhDCiukT8w/WZqmt7beCcMS72N+XM8jKPnBWessvMX8OeBV6FpGXM
	H1mtOhsYNOM7K8OU3V2zv28FQbA8hYjZds/41RMSeO8BFG/B7s2XtylIYRug4c4ESl05Z7gFrVd
	C4dQk/1FTzkwewqudoP5Rhfqa4BAIAgdVkGW4r7XwSFlr2/voue1hexmIn0hsrvm0MqjvWeR+o5
	QVDFpYokbANTy0+QFRxSh4LmHHnCXYZ8Lw8YDMG2Xi5J0Hs+R9gSxLIj4p3rGitH+Fro/NupDgZ
	Ed00Zo4kadWFMse8YS1BXw==
X-Received: by 2002:a05:6a20:43a3:b0:35d:5d40:6d7b with SMTP id
 adf61e73a8af0-393ad369c51mr2887295637.37.1770397109028; Fri, 06 Feb 2026
 08:58:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203093819.2105105-1-jolsa@kernel.org> <20260203093819.2105105-9-jolsa@kernel.org>
 <CAEf4BzY7zZmEqFq577NiG2wh0aU0_og1_RjVSURjaqTOnTc-Bw@mail.gmail.com>
 <aYRbbL-QCnAZ6PGD@krava> <CAEf4BzbzrPemyBe0xtEwuxG8d-JUC+Dd+B412VBLLAui=88LEw@mail.gmail.com>
 <aYWpotJVLSZdiZgG@krava>
In-Reply-To: <aYWpotJVLSZdiZgG@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Feb 2026 08:58:15 -0800
X-Gm-Features: AZwV_Qgu8joHCiUmGxaBJbBTrtx31pQZffg_bfACSxJhNn6lYqmj5nWwGsha45M
Message-ID: <CAEf4Bzag8E-hUyQ9CR671HTiDngiQFBRGqoicSpVigFhuQy8Kg@mail.gmail.com>
Subject: Re: [RFC bpf-next 08/12] libbpf: Add btf__find_by_glob_kind function
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, Menglong Dong <menglong8.dong@gmail.com>, 
	Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 12:43=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Feb 05, 2026 at 02:45:14PM -0800, Andrii Nakryiko wrote:
> > On Thu, Feb 5, 2026 at 12:57=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Wed, Feb 04, 2026 at 11:04:09AM -0800, Andrii Nakryiko wrote:
> > > > On Tue, Feb 3, 2026 at 1:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org>=
 wrote:
> > > > >
> > > > > Adding btf__find_by_glob_kind function that returns array of
> > > > > BTF ids that match given kind and allow/deny patterns.
> > > > >
> > > > > int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> > > > >                            const char *allow_pattern,
> > > > >                            const char *deny_pattern,
> > > > >                            __u32 **__ids);
> > > > >
> > > > > The __ids array is allocated and needs to be manually freed.
> > > > >
> > > > > The pattern check is done by glob_match function.
> > > > >
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >  tools/lib/bpf/btf.c | 41 +++++++++++++++++++++++++++++++++++++++=
++
> > > > >  tools/lib/bpf/btf.h |  3 +++
> > > > >  2 files changed, 44 insertions(+)
> > > > >
> > > > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > > > index 83fe79ffcb8f..64502b3ef38a 100644
> > > > > --- a/tools/lib/bpf/btf.c
> > > > > +++ b/tools/lib/bpf/btf.c
> > > > > @@ -1010,6 +1010,47 @@ __s32 btf__find_by_name_kind(const struct =
btf *btf, const char *type_name,
> > > > >         return btf_find_by_name_kind(btf, 1, type_name, kind);
> > > > >  }
> > > > >
> > > > > +int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> > > > > +                          const char *allow_pattern, const char =
*deny_pattern,
> > > > > +                          __u32 **__ids)
> > > > > +{
> > > > > +       __u32 i, nr_types =3D btf__type_cnt(btf);
> > > > > +       int cnt =3D 0, alloc =3D 0;
> > > > > +       __u32 *ids =3D NULL;
> > > > > +
> > > > > +       for (i =3D 1; i < nr_types; i++) {
> > > > > +               const struct btf_type *t =3D btf__type_by_id(btf,=
 i);
> > > > > +               const char *name;
> > > > > +               __u32 *p;
> > > > > +
> > > > > +               if (btf_kind(t) !=3D kind)
> > > > > +                       continue;
> > > > > +               name =3D btf__name_by_offset(btf, t->name_off);
> > > > > +               if (!name)
> > > > > +                       continue;
> > > > > +
> > > > > +               if (deny_pattern && glob_match(name, deny_pattern=
))
> > > > > +                       continue;
> > > > > +               if (allow_pattern && !glob_match(name, allow_patt=
ern))
> > > > > +                       continue;
> > > > > +
> > > > > +               if (cnt =3D=3D alloc) {
> > > > > +                       alloc =3D max(16, alloc * 3 / 2);
> > > > > +                       p =3D libbpf_reallocarray(ids, alloc, siz=
eof(__u32));
> > > > > +                       if (!p) {
> > > > > +                               free(ids);
> > > > > +                               return -ENOMEM;
> > > > > +                       }
> > > > > +                       ids =3D p;
> > > > > +               }
> > > > > +               ids[cnt] =3D i;
> > > > > +               cnt++;
> > > > > +       }
> > > > > +
> > > > > +       *__ids =3D ids;
> > > > > +       return cnt;
> > > > > +}
> > > > > +
> > > > >  static bool btf_is_modifiable(const struct btf *btf)
> > > > >  {
> > > > >         return (void *)btf->hdr !=3D btf->raw_data;
> > > > > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > > > > index b30008c267c0..d7b47bb0ba99 100644
> > > > > --- a/tools/lib/bpf/btf.h
> > > > > +++ b/tools/lib/bpf/btf.h
> > > > > @@ -661,6 +661,9 @@ static inline struct btf_decl_tag *btf_decl_t=
ag(const struct btf_type *t)
> > > > >         return (struct btf_decl_tag *)(t + 1);
> > > > >  }
> > > > >
> > > > > +int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> > > > > +                          const char *allow_pattern, const char =
*deny_pattern,
> > > > > +                          __u32 **__ids);
> > > >
> > > >
> > > > as AI pointed out, this should be an internal helper, no? Let's als=
o
> > > > not use double underscore pattern here,
> > > > "collect_btf_ids_by_glob_kind()" perhaps?
> > >
> > > ok
> > >
> > > >
> > > > Also, you don't seem to be using deny_pattern, where you planning t=
o?
> > >
> > > the tests are just rudimentary before we agree we want to do it this =
way
> > >
> > > but I'm not sure I have a usecase for deny_pattern.. I think we added=
 it
> > > just to be complete, I recall we copied that function from somewhere,
> > > it's long time ago ;-)
> > >
> > > >
> > > > Also, are there functions that we'll have BTF for, but they won't b=
e
> > > > attachable? What if I do SEC("fentry.multi/*")? Will it attach or f=
ail
> > > > to attach some functions (and thus fail the overall attachment)?
> > >
> > > yes, for the benchmark tests I had to add is_allowed_func which mimic=
s
> > > btf_distill_func_proto and denies attach for some functions
> > >
> > > also I had to filter out some core kernel functions like rcu*,trace*,=
..
> > > which seemed to cause trouble when you attach them
> >
> > So the question I'm implying here is if libbpf should do what we do
> > for kprobes: use libbpf_available_kprobes_parse and intersect?
>
> right, I think it's good idea.. and in addition (just for patterns) we wo=
uld
> filter out functions that:
>
>   - won't attach (is_allowed_func =3D=3D false)
>   - might cause problems (rcu*,trace*), maybe for that we could have
>     opts config bool

Well, who's going to maintain the "might cause problems" list in
libbpf? Let's not try to be too smart. If some functions are not safe
to be attached, we should mark them as such in the kernel, IMO.

>
> jirka
