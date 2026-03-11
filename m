Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47FB23EAB2
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 04:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773203319; cv=pass; b=h8u9PQxU5YubhRzhZv08lncYH/edUt85FrO+9qCZU7eaPTNIi1b0tSOXO8tWKpDKyBBMr5+REmQmEt5M/fgCYGhnkWeY2MKnxgyfEjIYNx2uefiPvNuuY5RZ6SCkjo6jbpSE4/wpG2CgGck9Z6vN7QdfCmejGRj6wVckrU4sbTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773203319; c=relaxed/simple;
	bh=TtfcqyHBRIjtK6IeNrMjCnHPgWtOURI8gEbiWHKUhLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/F5DOktBzZhgGi5LsIuxHEsRaF3oSbLeZ6YT8Kh+ZiXLwzADz3Rx82F8DFMuC/zgQMCJTdL40wgc+2rZNp0mXT32TGOLjuppq5XP7XBku9Y+irecxiQQYx4yLXPBYbyXcCQDUTpDyodCXUhVpsKQs8Urz5zwNmMbj/HDT8sGGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Npt0ZXr3; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Npt0ZXr3"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ca09f2056so10148786d50.2
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 21:28:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773203317; cv=none;
        d=google.com; s=arc-20240605;
        b=kvBxOMJa8W+2dZJGjkuYUi8i7ivHAO9SpJiBSyFzk2x+XB6aGdIec2tOu0+Yv2MT4s
         CjvDuoZ9MxD8O3jrPYN+A0bFVNvSPYAFg2lu1MTrjFI0++Eulf6cCMkPsZnzhMSxeav2
         9rEA16nbWJT8RhY+ktiRxcPpgt5F7+aaZZiEWPvQToyq1Skz8wS74Gw6NL7DtZujVPRB
         Kr32ekjqJUG3TBnIkVCxWx2QU13KUTTuaEQCd60APEyiCHKTIfkgm+4yeQ/9zyxLxPRE
         sYEEV1jQaLJDI2d7zE5omrAjoICV8M99FBOr+PxokcguB261UGz6Jh0s0PBrHIVDZ5in
         +ssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5o3P6eHplYm7OFtUvHyPCeVIYrNp0w/amVRZXAgvY1A=;
        fh=6mzBUIqY/8sgjA9Q3etLroAMdIZQQbTP6IP/1ObD1Go=;
        b=iQnmbUjjGo0LqoYJCvN5Yl9hYW86rwwaAyt/gJY6oGcdeh2fmh+HceASadW655sxar
         +drLFgA4X6PST9c0WPbRFYUeBKsfoew9sAV8X1TENcMq3KnxSUQxBCfn5gW+/zzbZCdJ
         JAF4HNy6VzugYUbBuFDDh8EYA0mmFvKhf0H1obmYuEjSaLyC2n5fjCjz5SfrO+s5gY6M
         4eJLoZu28ZSD8csx5kXBOheapz8l0jzAyThemRYZ6JWWkW8yTqfc9B+TS2Pd/LB3HqWl
         DEyM1PabOs0nlLM+hGq0m8sgZD12M+A+Ijv7k0PgXR3ydUfbvKI9mvhdC9NcFGBM6fLX
         oNtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773203317; x=1773808117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5o3P6eHplYm7OFtUvHyPCeVIYrNp0w/amVRZXAgvY1A=;
        b=Npt0ZXr3oSzNbR+UY/CWFFGGa2fng9oTJ539XQ/9gW9qcIAD77HOuTN471QaD753Cj
         JSIUVkc1D6OgPbbz33IR2s+0bDxbJZ8ndPk61dIqM8fFJ7SgH7ZotNA/7W4nrTEAh/wx
         EpK5vZgSsvMkyW7lsIOlPvh7xdltxhSeFaoAE+I1AGHU3iOT+C/tr8e9/zHKf/6ujnrq
         GUQjMnxs6sCAn6cgTTzho8zT0+j5yqYY5udfEy5pbMq3TJmKSgya+x5qMmdsGtUqAdub
         jgCbgoXbOadYGFkFrdHtMrJOXrMOE8Dst/f6vDqHTurhwkzDRKhSFhYHqD0YPINDZQqo
         4grQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773203317; x=1773808117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5o3P6eHplYm7OFtUvHyPCeVIYrNp0w/amVRZXAgvY1A=;
        b=UgVi6ON2BjVT0+PTyMYrAEvdNxTATU6ZHpmhEe4DwGdoqwP9nJMTpJ3m6xpxEsNQFR
         lzrzEXnDtn+t0bgdcYxdyAle0ut6oLzj5vGniqiJ4y8NepEBzLlVboO1Jmq+fV2KnBaK
         Ys/PjeOzx/QyWQj4PYXmv8ScS77GqViRHXfsrI43yallgld5XqrZzXgyDM94qmsTBK3k
         wQ1jOiCuiuKiiAOj3SEDd8qvjEXNfdeaeTNdJ4KYzpJOqeQCGV2d/i9+oCCdZZEwfoYo
         h/+YDClYob0goKiMwLVu6c3l0OeGLn6wb9ZjIHf57VujApMzIeqtzSeM5W1BMowJLHhn
         EXpg==
X-Gm-Message-State: AOJu0YxVS55e+sJ47Es9pxCJdLYkjlDbHaCUNLGaqTuhGootZet7BzRj
	Y0lpZH7kjdkg32IY0JAsRkFlm5mV+63g3oHPMbn6FtAxNFcs9o7bMjCZugd0yXUC19Aw+2eniYl
	7eg4c04e3oCLi3ooZv1JZ2V6O/YqYxBpOFfYb
X-Gm-Gg: ATEYQzy8H9pLX8o0Awjse2btWLFhk/LhuP1S8vNhW79+9aaiJrwNNJLQGMhquX2fCPa
	EsfQN3f8AU7aEU94CVWX8LrsUrC50RbjzdyySoKyFg7b4RY6NQ+oymvS5+nhKWRUMlSmm+Y+XJ7
	LfYs10laqAl0H4eUvpLr5MD7B+6Oo+wxYiT44hRK/KDKNkX9ldQbobXm8lvD9LLxlGViEBWp2DM
	yGtfbaW37ufo/q5MVLJbewCvz8aQi2SULmZIh+/zd5vhAy85wZ2oBRObWIHyRgtEWTCUjrmXTJ5
	7FH4sXkvwoJ0jK5yvg==
X-Received: by 2002:a05:690c:6806:b0:798:1bd:6bc7 with SMTP id
 00721157ae682-79917faf764mr10084157b3.47.1773203317596; Tue, 10 Mar 2026
 21:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310133504.94871-1-danjwade95@gmail.com> <CAMB2axMNzeyNwiYUbTnAY2jpPXoahT36u1qt3u7cCpTryGqgPg@mail.gmail.com>
In-Reply-To: <CAMB2axMNzeyNwiYUbTnAY2jpPXoahT36u1qt3u7cCpTryGqgPg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 10 Mar 2026 21:28:26 -0700
X-Gm-Features: AaiRm50871Cx_LCkbkZpmOKcLfg_UaFwvAQttoovBu5TEMDQOltVutbOaY9KM0Y
Message-ID: <CAMB2axPdtvH6N3O9ms5pLa828hBhTipKnhrNJsXn07JSMi_3nA@mail.gmail.com>
Subject: Re: [PATCH bpf 0/2] bpf: Fix unsound scalar forking for BPF_OR
To: Daniel Wade <danjwade95@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 2:28=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Tue, Mar 10, 2026 at 7:43=E2=80=AFAM Daniel Wade <danjwade95@gmail.com=
> wrote:
> >
> > maybe_fork_scalars() unconditionally sets the pushed path dst register
> > to 0 for both BPF_AND and BPF_OR.  For AND this is correct (0 & K =3D=
=3D 0),
> > but for OR it is wrong (0 | K =3D=3D K, not 0).  This causes the verifi=
er to
> > track an incorrect value on the pushed path, leading to a verifier/runt=
ime
> > divergence that allows out-of-bounds map value access.
> >
> > Patch 1 fixes the bug by passing the opcode into maybe_fork_scalars() s=
o
> > it sets the pushed value to K for BPF_OR, and 0 for BPF_AND.
> >
> > Patch 2 adds three selftests to verifier_bounds.c exercising the fix.
> >
> > Daniel Wade (2):
> >   bpf: Fix unsound scalar forking in maybe_fork_scalars() for BPF_OR
> >   selftests/bpf: Add tests for maybe_fork_scalars() OR vs AND handling
> >
>
> The fix and selftest make sense to me. To observe it, I also
> vibe-coded a poc to lookup an array map element and OOB write to
> another element and confirm the issue.
>
> May be missing a fix tag though:
> commit bffacdb80b93 ("bpf: Recognize special arithmetic shift in the veri=
fier")

oops. It is in patch 1. Please ignore my comment...

>
> Reviewed-by: Amery Hung <ameryhung@gmail.com>
>
> >  kernel/bpf/verifier.c                         |  15 ++-
> >  .../selftests/bpf/progs/verifier_bounds.c     | 102 ++++++++++++++++++
> >  2 files changed, 112 insertions(+), 5 deletions(-)
> >
> > --
> > 2.43.0
> >
> >
