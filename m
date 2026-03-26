Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F201427A
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557178; cv=pass; b=WTZrYkFYKtYmMY9emwBtW56xb/W75oNhfkAK/UlYKMwsO1rziZs1GoXkb0FXkaiek5ibqO0zt+fb4vyQHy5nMWPOddI78C4mqFOOyRvzvBAMNq4b/oWLOuZZJxTu78OmdtaDTn99ZGC8bVjt7KmEBcSiKIL0iHWx1E3OBIk8RH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557178; c=relaxed/simple;
	bh=vv3fINOTm4a1DJcw01C0iHFPBMj2LdgZIpAj1i6uj8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQb3ixs5JaHAtQmnyhwFMCkcnJ9nRhRyyliHV5j00Gy0ngH13wklSX2RoXByAb91bLwEG8DNe8EKEZtWDQTE7G0BPajnHmSWgC2+pJ8VmwFDTNnk6uMRW4f5PLlA/goXuVx4yB7dqo/HUyQwxRqYJiciflkvTwltEXg0YxAh73Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjiN0GtE; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjiN0GtE"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79a46ebe2beso14134377b3.2
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 13:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774557176; cv=none;
        d=google.com; s=arc-20240605;
        b=CwzXypzqzJ19sRurlY/oU6A7rl74g4wPk9aE/feCmxdH+/cYin50hJnu08QMn7Xa5L
         2nkl0Fj00ezCYDsxhkCLHDuKvKwypfcZFEGrH5dFWzffmR2TTEXlVdyS/yjI+kWcbMC7
         f1NyRddLr3MgEUIf0xf05wKYH8FaREmy2QVcKtiKuoSAmaq0PVbBvGanzEuZuntFdnEl
         LBK+G+ep4G9Ga4Q8Fl18JkKgxr5YG7fC6YGwtWJqtCVQMvdBDWLkSLoOD+nJyyFdwLfH
         vkbk8Ktah3uLOKd37g6al90E+Ax+wLAOyLsRx5ThKd9bRucHy4RDvGWZPGUMCB3KOgjp
         +9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=So3250I84ApogcJkFPpmfO31U8ThAo0mkcinoVGA0TI=;
        fh=PzF4mx18zzEJc6q5CF9iWR26tlykEsddYUFyx3rCgvY=;
        b=k8YKLYfDAnB3b0HaZRACmObeXhmtRra7jRrdkZNGDDSLMFdjz++nKml5URq8TyaS4F
         53YFe4q0peBFoCY1SFEG0nobnwRZFO/Don+K/4t+D6gPHkZMUS3vnSFbjbUzqw/qBbFK
         bs6M8EkXoRcxwiAx4dRTAnwooMOcfwN6TuXdKPX4KFFLNBO6HaW9lNTMBXLMXNHh9E9d
         THBMbUP20n+SN5Ve19r8tuggsCQ/YmHuHPKOF/MeaEbP/e3v6citFRXU5Sqkwnzwd76J
         /2ust5hEA5w7U2/xq/gpnjNYoONeWAHyMkD5MVmcEK7C4sGMzCCQQWsGgwn/zLNpH7gC
         TKbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774557176; x=1775161976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=So3250I84ApogcJkFPpmfO31U8ThAo0mkcinoVGA0TI=;
        b=CjiN0GtEDCU+KMhfWcJbV2aP9hOHCaYPGugc0isBxLw+PnUN63xpsgr+rfPMfPFb7I
         UWyUCU+ZQ6waO+oqY6wBREBczrAxottslbLxSpkxdsFqDjV0vcfow1r/MQr3hYjfDkn7
         0Mf4QFwdngYJOmyWVD8lhv6h3czaR6tnLZSb4LVuiq/9kOBH/tAb4bxdcuKBqS9AJjLD
         d22PDYycxZTtWis+yqODeJf2kvsKwRBXVnVOmbqXRjVNXLX8oRiCXWoiWcGQdlGtP18d
         vzwNe3cydmM+UbZqxxuS3mMp1ZHC8Dx0SHPXfoC4AkcVeAtFPTcA6QqrJPgW//0Y72y2
         o9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774557176; x=1775161976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=So3250I84ApogcJkFPpmfO31U8ThAo0mkcinoVGA0TI=;
        b=nTqIRA5Rh0McCK2r2kBVNVjHXqbQXIaDAn0vAzfIyci6X8FT1Y0XeMoB6v9aDgzXsF
         9yRHCe9hfHmTP0mvlK3vehTd+2TR8kn7N53WOXZOzFZHJ0UZyUWuPv6crxbi+xskAIBn
         fm9KRoW5dZYn6S8Mx29ps2DNVrVW1iE+h0ryam/V7IMxII/cAYEHctIi3cHj2atQv92O
         uTyP/beENzrAzK0wRSuWRl4zr6/bzzgbH3JlsZSvXC1+xHWcMOUU98DxJ6W+7F5vULag
         DMjgNRScYR8Isyl1rg7DVH5dQVTwb9KBatjZRITz+eMbKiQYnCxUkZsTf6IUiq2/TluN
         yUug==
X-Gm-Message-State: AOJu0YzQsDL5Zik5lThMfmT2Qrhp998LGJaxs8TZRVUxg87Qvckersm2
	z9wSa0h8O/woqvoBflcRkMozttNYul1lcHU2ADDDxJ+oZkMSYHL/n9MkqUbhnVzgnMgqCeb5CNX
	5tgpaRKPUAU3SVqwVjX+zOVilI8qyd2M=
X-Gm-Gg: ATEYQzzGEU1X1+4cAYt9blfAvdm9bIfNHqXHRm0lNiTMZYuwS684GLofNVblv4k0HI6
	OuPrXv1dUkzNRfpi92Ek7Ag9hMswF9QS4BFAc0h3ymxzT5cocJ3clajKOGT/Cn/6Z4B2foarXZ6
	VzAUQBg52OjPY2mP9EZ5DZu7dPv89dG1FNJ3FL23nbRYMrK+BnB4T13NnXTLu+j8if694FUGfnq
	aL5g/e0AjXxgtN+tHbM4qOI31oIVVi5HDLUW4DC1jVrOkirAK45TqQECaxWne0cxGvD/3nD0/fp
	Js9BTPZbn9QVYrhYHp2RXoU=
X-Received: by 2002:a05:690c:360f:b0:79a:5b3a:8e25 with SMTP id
 00721157ae682-79acf6dbf2fmr99822067b3.58.1774557175836; Thu, 26 Mar 2026
 13:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326052437.590158-1-ameryhung@gmail.com> <20260326052437.590158-2-ameryhung@gmail.com>
 <87ikaiimyy.fsf@gmail.com>
In-Reply-To: <87ikaiimyy.fsf@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 26 Mar 2026 13:32:45 -0700
X-Gm-Features: AQROBzDIdLJS7UlJaGo5T1COIP5PNpDfFxFGUBLUucY0kkG04jVKanTT2XQFj8s
Message-ID: <CAMB2axNyYWApPr3gSpLe2k5kej04MGi1e8DWSWEfGa7xG2wKPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] selftests/bpf: Fix task_local_data data
 allocation size
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 9:18=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Amery Hung <ameryhung@gmail.com> writes:
>
> > Currently, when allocating memory for data, size of tld_data_u->start
> > is not taken into account. This may cause OOB access. Fixed it by addin=
g
> > the non-flexible array part of tld_datg_u.
> >
> > Besides, explicitly align tld_data_u->data to 8 bytes in case some
> > fields are added before data in the future. It could break the
> > assumption that every data field is 8 byte aligned and
> > sizeof(tld_data_u) will no longer be equal to
> > offsetof(struct tld_data_u, data), which we use interchangeably.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/task_local_data.h       | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b=
/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> > index 7819f318b2fb..a52d8b549425 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> > +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> > @@ -90,7 +90,7 @@ typedef struct {
> >
> >  struct tld_metadata {
> >       char name[TLD_NAME_LEN];
> > -     _Atomic __u16 size;
> > +     _Atomic __u16 size; /* size of tld_data_u->data */
> >  };
> >
> >  struct tld_meta_u {
> > @@ -101,7 +101,7 @@ struct tld_meta_u {
> >
> >  struct tld_data_u {
> >       __u64 start; /* offset of tld_data_u->data in a page */
> > -     char data[];
> > +     char data[] __attribute__((aligned(8)));
> >  };
> >
> >  struct tld_map_value {
> > @@ -158,6 +158,7 @@ static int __tld_init_data_p(int map_fd)
> >       struct tld_data_u *data;
> >       void *data_alloc =3D NULL;
> >       int err, tid_fd =3D -1;
> > +     size_t size;
> >
> >       tid_fd =3D syscall(SYS_pidfd_open, sys_gettid(), O_EXCL);
> >       if (tid_fd < 0) {
> > @@ -173,9 +174,10 @@ static int __tld_init_data_p(int map_fd)
> >        * tld_meta_p->size =3D TLD_DYN_DATA_SIZE +
> >        *          total size of TLDs defined via TLD_DEFINE_KEY()
> >        */
> > -     data_alloc =3D (use_aligned_alloc || tld_meta_p->size * 2 >=3D TL=
D_PAGE_SIZE) ?
> > -             aligned_alloc(TLD_PAGE_SIZE, tld_meta_p->size) :
> > -             malloc(tld_meta_p->size * 2);
> > +     size =3D tld_meta_p->size + sizeof(struct tld_data_u);
> > +     data_alloc =3D (use_aligned_alloc || size * 2 >=3D TLD_PAGE_SIZE)=
 ?
> > +             aligned_alloc(TLD_PAGE_SIZE, size) :
> > +             malloc(size * 2);
> It looks like there is no point having Patch 1 separately, most of it is
> overwritten in the Patch 2, I understand you want to have fix and
> simplification separately, but is it really worth it for this selftest.

The allocation path is already a bit puzzling, so I have this fix as a
separate patch to make patch 2 easier to follow.

That said, I can squash it if it is simpler and needs a respin.


> >       if (!data_alloc) {
> >               err =3D -ENOMEM;
> >               goto out;
> > --
> > 2.52.0
