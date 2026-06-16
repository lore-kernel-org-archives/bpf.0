Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827A247B425
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630204; cv=pass; b=frTRC6p76E+5p4Eh8n/ANMwyI0oAhNSVjW4inttFFiD65m6C3NsKsMEjziq+E/3v/ebDAXjGr8b8Hum8VsD5hVWw3aPLN9/NjZ6+CEOcRWV/jAsp4PAUGG+sPG7SR+vj7DtUmFDXizj/tLTr2wumjql4/E+0SpTLttve29//KQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630204; c=relaxed/simple;
	bh=Nh4pQEP/JXI3ej0cc0N9+1DaTtnfkzaHu46z64YzAqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uv13Isv00MeT++umkOs0Mit59hdUEIc6UzZq19H3c/erSI9WfzCk5IhqoyVTaAZAf7513FyHiFsmAUmNEeGVwbkyXfKnX/Xtc/zddNkYeS7dVgiIghP+DhlDtzssZwvJEDBcW2GqIahzoE0KG4sx3GcdumUBcy2+YXy7ufFosZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ogGjHaG3; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogGjHaG3"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7dd5a8dc8a2so28913467b3.0
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 10:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781630198; cv=none;
        d=google.com; s=arc-20240605;
        b=dad3nLAj7OucQspxfj9sMcfqXMjRuwC3fe/rlgJsHQYanOPCJE+KkrP0sksaWKacvg
         NBwmLbCdBBwPWXE8bJbwoTrZCQ3GJ2I+qxup3qxBtXul5ljve1xp97egKdHkJqnVVyVZ
         EkPy3yUTumDb7wDWpBEBBzEHHFduHtPGS3C2SdB9qDU2ECn8iPReqmyovPzp3O33+xqD
         VlAOlNl1nJez7elSKSzhf0XQl/KqQD9psemOVZ3wQbgbEz3yYQUnIegZZuPzHFFO3Y3s
         /AoOysE+g476l+fyM9HnrsKC4gsBHgPeBzJyPu45g5FDEfYWl0LnHWJSmA9GtEFYHltq
         /bNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m0Na40jsKjOOHid0+S5827JBwf9AggIFrx0Gx8lBHzA=;
        fh=dLj2/n3cRYQYmOwxDBVyzjFiVrbgsvM3T3YvJ3Z9NrE=;
        b=AnAiTyqactgSHWvT8AGbSA0PpY91l+Bw4LC6JprbVnunfPiPmoh3/1CiQUrUvvKqnt
         yHjCiUkBgoYUZZLl+MhSgLI7dB3go5JtsesO/c3vsLSK5LZqtSYFtyaJY13ZNid7NCNO
         TucJFHR+9TVfXynOYbslvxs4t7EFY/craH3cWqvyteSadoIRtOHFdGa4dZBeFPSLxdNz
         F8JlWt4jlkTs+jH02T+ShxtQQmj3ZJXfm8yVZuHH+XgwBFOPZWX56GON9tgdokJN3XOv
         6GQbr1Ldx1sQQjlxArZI4EARA+9mT0FNjgkzyouvOHT+zRl1bPGvVCbeB8owM2sENML0
         efhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781630198; x=1782234998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0Na40jsKjOOHid0+S5827JBwf9AggIFrx0Gx8lBHzA=;
        b=ogGjHaG3FFir+++MTSWO002gmUl64b68C/JGm7TDn4weBDzqwq2HhTKAVqUVg6n7BA
         fmOjrXkwaduxS2Nkxb22h3pD++L8PkchBwudECRDIFqgtJ5dIgeeCIprCq6RtjU7Vp1J
         Df1F0IhcD49OldeP8v9BtAaNnJaK0dkssJ5U6iErX2VCq+DYISjtTLWBqWbMCXNzQilc
         e38XQJxm/fqmkubdqZg5LfnE+uZa7Vz26NPGknYbEsWgyMnxFTO8AND7TT+3E0nk7D8m
         JM5x+hhEOBrqQsxIHx/BATfkM+VTwYJGwoFV+jPcDIVnD8PjKc4HVUe4N8GM2XtB9Di1
         i+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781630198; x=1782234998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m0Na40jsKjOOHid0+S5827JBwf9AggIFrx0Gx8lBHzA=;
        b=dpqlnMDr8djnbaVWQ3YtiNpNkLR2J84F/uTz1ZMd+gPfa6IwjXam6NJqRiKs69jgAq
         +sDpsfR13yTNU/C4+LNxFN4KQsxRg87UIHZZ53C+HzaNAyeEeCI8yRjxO75NQPHylVBw
         w7fq8rQvTtKBEPW/AGAePa/NnOpkmNMs7P/YFMrQcNTdWhHKOgHSN+RkFBeFtAct07yP
         m44pPicK/N2Dpj8SVPNAsTEGWPrzQJ/JxQYrXIlr7McWYgo8QEuLwba2rFbCuFVF7KAk
         1Y9PokVQQLWiNcE8zMMCm3fixNZVDGiipAWrGOeMJlOUsT5s+SNpVdMfr3ZDwwnkJloJ
         Vt2g==
X-Gm-Message-State: AOJu0Yw6wl5GT9Qgg0bRtYiFk8t2zkZyOMCTh/6mloOeOD4oxOXX0C6t
	EVOq9vTHgcG+mg8aRj+57nSGG0xRG8bdYErhsCNvaru691QWPlhab6cm+046Lm4bfY9PvbG7Umz
	hYyVNO/oH3UnFRM0FkWpOcwKDueBnJDY=
X-Gm-Gg: AfdE7cloQ4d5KwzHzdUprUI3WabmFesGYsKJzpIKwDf85Bh4lm9gw50eKbyIqF/8+6N
	fQ5mFZyMeaB5u0WOdPVtmRZRRYRjgn5VrYkV+mL9fjtNYPhfg8uVud6oyxjF/47CVxPPaDTp+pM
	Kv2FWQrs9EObguztS0vbSzQtWu9OdNV7z6BxZcAu7W/HDu7guONruigESPfkUXEeqrLcKkV4P2e
	+hhH2a993UK3JwDRka2OfMgefGolAzI8IZ/h/uglJyOqnYg/Ggvt/k3h3KgJ0y3Zs6Uq+APDi81
	0CdQoZefesFLc2PwZO3k+36xO2zsGXTc8cEdEsQnBJH8B40Yezg=
X-Received: by 2002:a05:690c:c11:b0:7f8:7e60:aca with SMTP id
 00721157ae682-7fd00b41bfcmr45333267b3.47.1781630198070; Tue, 16 Jun 2026
 10:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616093103.471444-1-sun.jian.kdev@gmail.com>
 <20260616093103.471444-2-sun.jian.kdev@gmail.com> <ajFQvedGURQuKqbX@mail.gmail.com>
In-Reply-To: <ajFQvedGURQuKqbX@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 17 Jun 2026 01:16:25 +0800
X-Gm-Features: AVVi8CfQ9aqklUqfMKfjhMBGm3tuyh-ykNo01OgpkMaLz69xQ_iTRgzZV4nsZPM
Message-ID: <CABFUUZHV2be01_BVO1ZAVf9_z1UOzsYZ7hH1FKrwmJUxPnrR_A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix partial copy of non-linear test_run output
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, toke@redhat.com, 
	lorenzo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 9:33=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> On Tue, Jun 16, 2026 at 05:31:02PM +0800, Sun Jian wrote:
> > For non-linear test_run output, bpf_test_finish() derives the linear
> > data copy length from copy_size - frag_size. This only matches the
> > linear data length when copy_size is the full packet size.
> >
> > When userspace provides a short data_out buffer, copy_size is clamped t=
o
> > that buffer size. If copy_size is smaller than frag_size, the computed
> > length becomes negative and bpf_test_finish() returns -ENOSPC before
> > copying the packet prefix or updating data_size_out.
> >
> > Compute the linear data length from the packet layout instead, and clam=
p
> > the linear copy length to copy_size. This preserves the expected
> > partial-copy semantics: return -ENOSPC, copy the packet prefix that fit=
s
> > in data_out, and report the full packet length through data_size_out.
> >
> > Fixes: 7855e0db150ad ("bpf: test_run: add xdp_shared_info pointer in bp=
f_test_finish signature")
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> >  net/bpf/test_run.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 2bc04feadfab..976e8fa31bc9 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -453,19 +453,16 @@ static int bpf_test_finish(const union bpf_attr *=
kattr,
> >       }
> >
> >       if (data_out) {
> > -             int len =3D sinfo ? copy_size - frag_size : copy_size;
> > -
> > -             if (len < 0) {
> > -                     err =3D -ENOSPC;
> > -                     goto out;
> > -             }
> > +             u32 head_len =3D size - frag_size;
> > +             u32 len =3D min(copy_size, head_len);
> >
> >               if (copy_to_user(data_out, data, len))
> >                       goto out;
> >
> >               if (sinfo) {
> > -                     int i, offset =3D len;
> > +                     u32 offset =3D len;
> >                       u32 data_len;
> > +                     int i;
>
> That doesn't look needed.
>
> >
> >                       for (i =3D 0; i < sinfo->nr_frags; i++) {
> >                               skb_frag_t *frag =3D &sinfo->frags[i];
> > --
> > 2.43.0
> >

Hi Paul,

Thanks for taking another look.

Agreed, I'll keep the fix patch minimal and leave offset as-is.

For the selftest patch, I'll try to reuse pkt_v4 and the existing TC
program where possible, and keep only the minimal XDP frags program for the
XDP case.

Thanks,
Sun Jian
