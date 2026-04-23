Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB063D411A
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776927431; cv=pass; b=AhBAQW6F2xdBDGZKt/CPTHx8O+SaKGV5OpnpUEl2jIJTcX21VRz8KeUNLZc1K4ieX0ya8awjT4pFOYE0Y2O0ffooYFRoq8rMjnM6YkX09sR4Jcsnnh7aL7BeH0LUM+sRBX4IylyvybtOsLJKUPENOrUc7ptz8mVq/vBEjLZ3MeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776927431; c=relaxed/simple;
	bh=FaMQxyMbm/MvssklYFNdPl+DM+5+46erElji7HAPf4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gr/gH7kR2bV1B81RFu4rj9AaeS1TMJqiZo0UVj6f4gbi/jZ1T06CnguF0c/BJvGnCU/HJXGVPG7x6zkT/lBGANXloAVJ5MQ3i+f4L+speBSNo4F0i6O0dKLwnEkgu/Gdmd+Lp/24T5Q5K4Xv2hK/dUuQxefWqLH2uxv4MDR2Ots=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDnxWOoK; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDnxWOoK"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40946982a78so2291813fac.2
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 23:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776927428; cv=none;
        d=google.com; s=arc-20240605;
        b=FkGuhpjFtn4RtM2wA+LlI+z8Szow1hWgeoMThtSc5nH4Q1N8CMfXUH86JiG3nr+v1c
         FOz+lBB8T2Wu0PmC65DZINQ/n+9ntzE4VlXCCDuMBEJP/D9tyaT3iAkQijhHHabmrrAd
         JK7eEI1AgRcoLoky7wDtx5G7OxzLzkzxSEwgfi+MnhxWzWTvsAeN2F6OV3rlVRVzHTSE
         Q5dhIsEp3AOSKRKyA6wCyEaaqySaiJG5aOx51SQ6XwRLiFMEvXW8yqQPFaM9ceCYRQOu
         ZtOk8QkSpXtp1J3sHA1pckW4EojiZcm3r5NIZ729yahDBhABXFNPlrvLc2oV4w62tXFM
         6VZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QB81J+kn3zUKSpeQ5Shly/8f+kNoagaKHjIgpIqova8=;
        fh=pk+fWVgPEQfJ5D2XByfoaahrorMttUQmzjKRN+PHiRQ=;
        b=Lcnvf9fhXcDPZTbqTohD7cvLBNWYQUhDfRKsAEWLyhcuR+VqdEI3EjTYyAVlB2Z5I7
         zkxfG/4txmdxhQ60mbwBpojeZnyg5wDQLWItnBYMxF5KCxU4To2GYYzwc2Q2OEJ7EF8j
         icqaiXm90vOqz761N4LjyXRWWI76a+w631KOgZLjZowaOLcl23FfhKH4fJkhRz4k2fON
         C62jlBFzm1jcNsciGqzxCTjh8ymQEYPvatnzowm/pCUTUKiRZUmGl+zXwfp1FpTL3R5A
         5ZItXKj8toW/ksYXY8ESJllmo6JVKjOjIsGO44vFXKBVQ/bhzcB83lE1kprfPXH+mSWX
         lD3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776927428; x=1777532228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QB81J+kn3zUKSpeQ5Shly/8f+kNoagaKHjIgpIqova8=;
        b=aDnxWOoKVJAeiy+w1c9dhUM0ea2Ll9yoNW3Ap+jnC/MIoOsuLt3b2WFgqzbrWDO/E5
         jEAaP3bcSBvc1/hBbhw//9L9NbVQWxsjrJVrdFIYCCBl+vofnHezjMS7y4g67VYqgfWN
         FaFR2T46ZA/bYJiIeQqjEiS6055+H3bVD9GK8Ll3/bbOFClmVAPTi4MdqRdiGeChzmcj
         m6TzeQn2AzoV9uOXQxW5QL3rORPC2a1YxwNlma69uckaqi7f2/okhQuhdHHCtsROpGNy
         Qp0XnVg1KK+n3pTkFA1poNLu0kp8mF5DEL833cBCKX4kth1a81PG8+fveVeQoHTSEeEu
         /eqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776927428; x=1777532228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QB81J+kn3zUKSpeQ5Shly/8f+kNoagaKHjIgpIqova8=;
        b=ZjAtm9L8skOUjmkXozhqdYBz0aIdfj779eNqtq2mZPESQZS8TAAXxGGgFgcomIH4oD
         A9S8nc/R8JiwV0z8Obnq9mBPa93+FuuD2+zTqnVTu0IjtSZgdErPfDsFrDOUtUd/+kAM
         RHtz/n8bf2vP8lwxzxJOf/rEeZ95HvJnR89Fn11NIor0YzJ0M/nEvS8gIJ/GYbIXHYwc
         Hhind/HN5IT94uCWo0EWrf/Nli3a2jr3QjaSygZyb5+6yeRrBPUk/2Jbd9TFzya02UrZ
         HlWQ/3xzaW/u4hGJPZa6gWpvg31BsP18F0sc+tPRlwC94qYDipHfrzSeauiTwHCDLNBW
         yTAA==
X-Forwarded-Encrypted: i=1; AFNElJ9goIfCqXeNZDFhE9H1ghmQQcAJrt1GRsZWb75GutDcM8o69UFd5VZiqLLNKEtOeMa/jkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwfs3+0Cz1hOOqDB3+uXCYJQPbuJkA/qFKrsmo7JyvfpQ4itlB
	Q6Z9yvOELSXpd/cFoBp321DR2RuOeLQowHEgW6jCgKOW63ziWZpwjY8jYioa+mGvFpMAuOfaS4C
	FzFOGayRiHo6Tu6imCyKHpihKaMqY8Xo=
X-Gm-Gg: AeBDieuY8rP2GmInWIK6xMAKrhtz7jRXDXDg6VEUW9pT/LvP2QNR3abPXuuqmryNTAc
	SPb2tK4fDWchFk+58CRhNMzbXh78a1Cj74ZUwSYHucK7WknOEs6z85dvKOc06z8sjQ6E/crAKrt
	MLAe7X72y3rkB+S7qxggOKTUuD7rNlNerJa3erlwKBtvUGwbB6Fs7Pe8NzuWDHcYgpwhn+CPmQ8
	qWMpJ5F0zi/YB7eapp8xZo/O6G8mc7pS/qCFmN/H2UDxayGnMdvP36FYcszC0uAk3nsnMudxcF1
	p8PrCAsOc1y1/7Trn3Z125UIkb32mQ==
X-Received: by 2002:a05:6871:c005:b0:42c:7f89:2916 with SMTP id
 586e51a60fabf-42c7f892ceamr7133923fac.20.1776927428557; Wed, 22 Apr 2026
 23:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422183757.15069-1-suchitkarunakaran@gmail.com> <CAADnVQ+=iEmyf-=T=V0oW2aK+dgx4S0CbAAPi4pSg=DnaHNFoA@mail.gmail.com>
In-Reply-To: <CAADnVQ+=iEmyf-=T=V0oW2aK+dgx4S0CbAAPi4pSg=DnaHNFoA@mail.gmail.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Thu, 23 Apr 2026 12:26:57 +0530
X-Gm-Features: AQROBzCmP_tTpa9MPR2n3mcSyZk76MbSm-jGeLSvbrvMhcfw5ZdsgAHyHU-UZm4
Message-ID: <CAO9wTFi8wrhP07YikinU283Z_JVyttNrzwwgdVWz=gUvuWjzGw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: replace bpf_probe_read_kernel with direct access
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Apr 2026 at 02:51, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Apr 22, 2026 at 11:38=E2=80=AFAM Suchit Karunakaran
> <suchitkarunakaran@gmail.com> wrote:
> >
> > Use direct field access instead of bpf_probe_read_kernel() for
> > nlk->groups[0] and inode->i_ino, and clean up related code.
> >
> > Removes obsolete FIXME comments and unused variable.
> >
> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > ---
> >  .../testing/selftests/bpf/progs/bpf_iter_netlink.c  | 13 ++-----------
> >  1 file changed, 2 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c b/too=
ls/testing/selftests/bpf/progs/bpf_iter_netlink.c
> > index 00b2ceae81fb..5930bf8899d2 100644
> > --- a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
> > +++ b/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
> > @@ -17,7 +17,6 @@ int dump_netlink(struct bpf_iter__netlink *ctx)
> >         struct seq_file *seq =3D ctx->meta->seq;
> >         struct netlink_sock *nlk =3D ctx->sk;
> >         unsigned long group, ino;
> > -       struct inode *inode;
> >         struct socket *sk;
> >         struct sock *s;
> >
> > @@ -35,10 +34,7 @@ int dump_netlink(struct bpf_iter__netlink *ctx)
> >         if (!nlk->groups)  {
> >                 group =3D 0;
> >         } else {
> > -               /* FIXME: temporary use bpf_probe_read_kernel here, nee=
ds
> > -                * verifier support to do direct access.
> > -                */
> > -               bpf_probe_read_kernel(&group, sizeof(group), &nlk->grou=
ps[0]);
>
> Please stop sending patches to remove TODO and FIXME.
>
> pw-bot: cr

Sorry about that. I'll test it more rigorously next time and ensure
the patch is sensible.
