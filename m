Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568062D0C72
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770063838; cv=pass; b=ZeYMUXJveJVdQiINdMFiOHffkq/dYZFw8G0IFC4VqDNYlsSsVtg/g+tvr47EJ39wFpjIDVpklGg9SQ2vZpbsvrfUHbL5WvrMzzWwoGkOQxA+oPZkED6141TytEQxL/QreKTTPd1PUeuzVH8ZKozvDGnmDZ2AbTqHGQ82fJUC6h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770063838; c=relaxed/simple;
	bh=rygccUd18l19TzR5JCjH1aG9Ieh85FWBhgGrodwQfAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgTCpP5vPbVzRbICFMWExEbBv4PyOXiQVgy8fBxmZTQBkbf37IWP0Q0Gto0zxWrsM2krbuwGUICLo8GFJjl/qFc1yvcuCQJn3D7Oo2XoS+MxTM6UkGEGcxK66eJSsqfdMRGfmE7x9EGjekzVvx1UbNUsIkTmVOLe8vVryp4LfRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U5aTzo61; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5aTzo61"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-658f1fde4bfso202178a12.1
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 12:23:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770063836; cv=none;
        d=google.com; s=arc-20240605;
        b=TciFg6ZAD3CQr5k5m309g7C96HSuI89glbtbx16xBVKZdR/LFurMdzbI51z+Ob3IOT
         zCNqppEOT4sHTIQwAGTutOUbw73pW8sQI8zktiKKe36yQYMuuWzwEu/GR3hhvPnHbPG1
         lbufSGLRV2OyDUGvEIIV1GaGZXpvqBOOrhRCeGWFemEQtQNpvV8GCb/Kaws5ucUrJXyI
         toWlUGe17dOOK/iCPIeDn9MQ+6+Phwr3QviyK1thHjjnhznZXsVtBTH73OXephS6F5Wa
         k4rNPgJy5CvPKwKkRjyS0dwBC0ZliUE/rH+D/tPbFWu+Hz0MKpe2JqU1SIbOO5iB1Tge
         My1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=htIZPWHbD45Ax/xP9Qw9uEOw6k3b0vJzapO+gLliJ94=;
        fh=azJDFNdASRLRopI+wcIYL2gTGBLKAyhVwWRli5F3yK4=;
        b=TrAeBPv88+lEdBe1ph21yneBP/bDCOTEmTBOIYKbGsld8mp19nQRR4LOZ5xafdOOEW
         dRgANJSd7fVO9Q+MXiQrBuKfP+CNVa6DsoAAng8YaH0r/4HRRRF1Wsa09RcLy/zOPbmn
         tGm1aSdT1oCn82REJnQFkgxVd6JOYK/vaeGp6nYncAmkLL4ONVnfq2vdnF3oAWFbEqE+
         hW2t7dVnskvvU5TzHwdgxRqgk5YHftAeNJHOrJ9xp2CSyCMDrxPUg4e/tlaxZ3tG1NFv
         zprtJpZ6rtbjqzkxypdHZV/jColPcfZU5sSx0u8BShOPwzOZNAUusLc4+Ity1B1OFo6h
         K8Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770063836; x=1770668636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htIZPWHbD45Ax/xP9Qw9uEOw6k3b0vJzapO+gLliJ94=;
        b=U5aTzo61c9/GFsxEM2m/A/746Ub8QrtfHQpE1rRZ5Vf54hERmqP4ON5eB4HH08LM+7
         UI9XsRK69lkdz/LYxPZq52tIGUNny7M9dnq95j5P7Fmyp7Rw5Q6Ogr9TMk5I7pIpBLhI
         NHz2enOQi0U4FMoF9/xgSFOAPf1z5kw8vrMQVJPSD2LucXCUtI+UBn0hlm3CyVTknHMF
         K9t8VVvcZY+rQmf1yXA1kkzjBa+2daLFLDEU3vQih+VOcMi7/XGYzayGFKCtltNStaUX
         bD2joBB4sBs1iANJaqA0UI7jWhqVyTZIJgXXiNlK5ei6bmSxOAHvOI868ew8CdZljfGD
         GabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770063836; x=1770668636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=htIZPWHbD45Ax/xP9Qw9uEOw6k3b0vJzapO+gLliJ94=;
        b=YFn8BsU8bPocH96dBlIvJulmwt8cxyqZckzLCDiu0wIvXdDaNrmSsRu/GFkUUBdW37
         N/m09g8FB36hZ+n3k2Bj9jrw9YjBTJ1PQG43o5OulzxOS/WdSj3tHPjiWTlCQvJuTc9H
         yUabs+ECxOqj07b8C6nWX6MpvB1D8QJe8I3y8CVvD+bSlKPCRz+0NRjZTnpG8DsyWK46
         QPib+Nq0mVX5AjuWkrVhTDYb2ufSnxFd5+gtsrKUHqfvgERfUMO4Cz+jixQDRrYOok2r
         AoFUp0Z03UKGiJBhWreTDGm4dvjspofsMiCHVUb+6UuBRHkjvS9ierbB4cgw+HYvNbN4
         qP3g==
X-Forwarded-Encrypted: i=1; AJvYcCWa2BjnBjKsgm+ggXKiGOoQSg6IgG77jxRNY1AKf4cbAjsI97eg67pyZ85lmPzjcMZ+mHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj9HfO8hAZfy13wa8ECytJYj4v5+MKLWJkurycQ/qXt8uogm1l
	YaNDLRY8jYLdinBKUBEyCM2Y6nXnJcT3yuDckRzjblTP7TnOluDqm5oMwjq9LbJwSRD5m6ie+sC
	9q+1xt4XofwCwWeF11vFGlepS8KaExlRZcK1ubwuD
X-Gm-Gg: AZuq6aKMPNwaLQ3gqGAeUvGqCxb6msKmZM0+wNh4b/pAU/HkfYmNYfDRBmEttnT6Dqd
	Jqi8fpcKdtskRdmxC64AqgluuwvGbWfmNWP9UqR4rQUGBmlRy1iNlrVYwuv4RgzWC4ZJa3aul64
	zwSW1Pm94vgPRJRzN/QQXfnGpWxyZOVlS6NtlYykC9J2PNam3+lZacM/tqzq/8DsRg1lGKjyyBM
	8hggPFeZtSOkWB2NDFbN6Xy8D/7DPhpaDiJF84R3Ru67r8A9EZcGBDqh+di5jtzyOZZpro81jP0
	ppulxWUUhhTmMZHN2gqUpq4yMw==
X-Received: by 2002:a17:906:2092:b0:b88:5894:6ba1 with SMTP id
 a640c23a62f3a-b8e8384b261mr34088266b.28.1770063835546; Mon, 02 Feb 2026
 12:23:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124012133.2451708-1-wusamuel@google.com> <20260124012133.2451708-2-wusamuel@google.com>
 <CAJZ5v0jWCdEVgQxOAkek4qqVHMx3Xx4_W3ov9bvdJP=0acX=Yw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jWCdEVgQxOAkek4qqVHMx3Xx4_W3ov9bvdJP=0acX=Yw@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Mon, 2 Feb 2026 12:23:42 -0800
X-Gm-Features: AZwV_QgqKaDjKsxdqUkpb1jGTSFawd3uSAT91ZuKQiHw4J175hzMfkuvra288U8
Message-ID: <CAG2KctqqZ_12AWiJ89OhCfqDfNqxBH3UrzssycxrXbcbj-82VQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] PM: wakeup: Handle empty list in wakeup_sources_walk
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 8:15=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Sat, Jan 24, 2026 at 2:22=E2=80=AFAM Samuel Wu <wusamuel@google.com> w=
rote:
> >
> > In the case of an empty wakeup_sources list, wakeup_sources_walk_start(=
)
> > will return an invalid but non-NULL address. This also affects wrappers
> > of the aforementioned function, like for_each_wakeup_source().
> >
> > This patch updates wakeup_sources_walk_start() to return NULL in case o=
f
> > an empty list.
> >
> > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > ---
> >  drivers/base/power/wakeup.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index 1e1a0e7eeac5..e69033d16fba 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -275,9 +275,7 @@ EXPORT_SYMBOL_GPL(wakeup_sources_read_unlock);
> >   */
> >  struct wakeup_source *wakeup_sources_walk_start(void)
> >  {
> > -       struct list_head *ws_head =3D &wakeup_sources;
> > -
> > -       return list_entry_rcu(ws_head->next, struct wakeup_source, entr=
y);
> > +       return list_first_or_null_rcu(&wakeup_sources, struct wakeup_so=
urce, entry);
> >  }
> >  EXPORT_SYMBOL_GPL(wakeup_sources_walk_start);
> >
> > --
>
> This looks like a fix for the for_each_wakeup_source() users.
>
> I can apply it without the next two patches.

Yes please. Feel free to apply this patch independently, as it can
exist as a standalone fix independent of the subsequent two patches in
the series.

Thanks!
