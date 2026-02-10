Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2FA3346B8
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 20:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770757130; cv=pass; b=Q3qBcQW6N6+fZPI2VNNeL/8K+kmg/PMfaI6ICxJeh9d+futBKE7pVwCcL4mCx4tlhCa3HmHEHPOjmqBdB3op5rI9yb5YifK2hE+0Xg3Gz35qb1VAm/8sl3N9tquD4zVtEUF8XwO7Oi9yg9OkySz5/L2mZPBL4vpqqDsklNlzQo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770757130; c=relaxed/simple;
	bh=FoRtX/JmSbM0ua6GaCDsRylpSpGiFH1Bg5aiisLM+vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjmtIc8nFKmoh0e77HUodycCaUZdeovU9M/qNXyPrkYqnPsSh5e89y+KyCBQP8ReGDKYjRdZOOmTEB0NJr5QSXDZ4JFQKpZTMjaLSATolISa6qn/jTkbu/M1CDDqGKpPu00Ds4tGwyFsSJGvCvNzZfsYK+0S4OO21wq1ewytJmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wn1ijQR/; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn1ijQR/"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-354a7b089bbso3644436a91.2
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 12:58:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770757128; cv=none;
        d=google.com; s=arc-20240605;
        b=IWv5v4zgne0X4PG8ljJwLder+QmHxabEC2A5ojiNJyBc3FQEo56Ll0m8lsrLHNXFlU
         nTqkh1yVyDiVvEejfFujJQQxqNt0BMcjuvQ9x9ntWSJ96YhbA/uqymcdTN+z0IdF0wYE
         3+aOg7FWwbAUtyFDqO+WONZ+L7WCNmWf/S3OpIfMj+0en4IDE/EQv+aO417V8jXDOreL
         bR4xzZUc/AlpnjfbxAL5bpMIloGkhBJdnhsWoyITkjb5J+HF3JokMf01R1gezvPji3uv
         ohQ+R4FzfHYJ5DOyMOs74QrUxUraAio3G1lj5s/AuPZUPwbz6T+IvO4zP6m4bieE/TAF
         a0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jGoUYqGYYmYoNSbkdbHDxGjPCbjsOh7ZY0OjSXO4lyQ=;
        fh=GpSyE2mZKw1eitMLbv4j1JPf26nQueHLFIj0cWsTV6s=;
        b=AkcYAgwj+2hh3o6WfWu+HJdNqhBnpq9VUB76yFS+9sSz6XDiGfi1/jUtOu+rGT7fGK
         QwgmOuv8iodLfAhny2KOU4PGaXdqXN54O+oqoB615aaC2530la35xGt7MQ7TNxZnUQOy
         d5kLEFtn6KWL5wroA8EmjkLx6mCrVOOlgRsD3wZkUF3J14nrAu7LAwBktVxR2WQB0nUt
         SxU1eVQn6K8zKCEfYbP0MUUIJSy1fm36wH2refc9vWvU/yk+VekkZwbgMo++IJieJM0U
         +8I1K1g72MVjGQIxEph/cI2sImh18k4oWtIpWYHPVhf1Wf9DGfAaw1Av2jdOy6nHPe1g
         JnAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770757128; x=1771361928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGoUYqGYYmYoNSbkdbHDxGjPCbjsOh7ZY0OjSXO4lyQ=;
        b=Wn1ijQR/XAMsyp3DSW4jKVCqFoZ608pzCmGYrYglO+hLppxciSuXuzTLNbC5IulfPA
         lX4ITcWTyadx66KmZvdgAE7tLozCcpJLBpe+1vFTLqdAaOcMmf/fXSM6/NYiTNrmoagQ
         7l9nI9NJL6vNo3QhD7gGrKrSkQE7VCSAerKHfzcWLXYI1/D79hVHJ/7TOs15EQASpd6a
         FFhPKBG74xQLVioh3IZ63irVBougjgStalbtL+dxY/F3k6JyVgs2vheEd27Z7l67IxPZ
         rrS6U9so9orVJfZXIw45NSQbmd6MhUVh/pXoWAFohFgbrPjrJ0QGgAmOhqMGJApd63nD
         exwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770757128; x=1771361928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jGoUYqGYYmYoNSbkdbHDxGjPCbjsOh7ZY0OjSXO4lyQ=;
        b=Incxqk050384hMFh8Wumv8ywwIhOJTcQsh/FypG1erbj87H2mbJxwiRDeQUXD6GKRK
         KZfq5jslIYYQqINMcoMD1d52HF8pLOaamR2XZBzHCk0mAqGOUSHTl+K/PiCzHQGjKvJp
         7qjtLtjB5jMOK94ebPvMkOxmDQGGanDhv3Im/SsXaXcuBsJn7sujmxjoHDP+20vbZmwF
         u/eB8WqRjT9MQO7pfjZx6955/7vil1WYu5e1BpS5fp7UxYQ841OFnx4RbnJO4uTI8kG8
         8TU3GuHJxjQfDlGfPXyLuQ++tdkul9NLvx3+j8snI9+hRweW+Xn30PDVnJVaMmJNQ0qQ
         669w==
X-Forwarded-Encrypted: i=1; AJvYcCXNKl+hCGzATud/rDunMhbSDfgTE52P499xcbbi+VPvQiOPgGFGrub8PfZy/p/U/SZB1iY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm9+2fAoVz5xeG1AnfrldZ0ffhNhB/RuturScmXDwPz0t6JPW3
	htMAoFGwA6gxGlOe6BH5d547zC/4N6TvNeDhFnEbkIQkXE7zG4hPerwyUqb9ruHCvikGKkuWjAP
	w+w+atevc2aW/VhiPn3tZ+WqzSiwy/yM=
X-Gm-Gg: AZuq6aKzacysy/dJ25IYDLRwjgBW8TRdVFJLg8aff4/fEolEAE5xe8BKGNHgUYrtjCR
	haVGty65FbQ7os/xFH8DseMfU+pWh2JsOcHwhCSAPmGk20DEh/L/ldXWi6pQ8+0oUvoyIUrwRZ/
	I+KS/dZToJTOiOP00a1Hbc5Uxap4bFENFN0XaNtuWd5Z5wfoYKlL/Z3V8CvByPjfXlBHxPSI9x5
	ckgA2W40gaH8NjiT+BZiwIFUfe/a0XuJVkBms+Yb8YcVnr0H79Pf7LkOCzkbWpKRoyHy8ap2vKp
	JoCk5v60dZRGzmSb3ShzZKQ=
X-Received: by 2002:a17:90b:3901:b0:354:a57c:65dd with SMTP id
 98e67ed59e1d1-354b3cae0d0mr12052678a91.24.1770757127919; Tue, 10 Feb 2026
 12:58:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210184532.255475-1-emil@etsalapatis.com> <848c629364521da9cb0fa24c52d6e034f3346c5cfd824faa12b0f139de16ce74@mail.kernel.org>
 <CAEf4BzbVOA6VW57QF14HDrF_T3qC1nF6NiENfqJ3696gFD4M5w@mail.gmail.com>
In-Reply-To: <CAEf4BzbVOA6VW57QF14HDrF_T3qC1nF6NiENfqJ3696gFD4M5w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Feb 2026 12:58:34 -0800
X-Gm-Features: AZwV_QjxZ-lUYAByE3VCSSXpg7SHot6NLzmZmKqMdCjDl94LhR6W_-zUSLta9YU
Message-ID: <CAEf4BzbEyYAM=LLLqhFyWV8kXZTi4R5i=FYCV-7vRMRAzTZ-2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] libbpf: Add gating for arena globals
 relocation feature
To: bot+bpf-ci@kernel.org
Cc: emil@etsalapatis.com, bpf@vger.kernel.org, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 11:34=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Feb 10, 2026 at 11:19=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> > > index b842b83e2480..9689e408ac58 100644
> > > --- a/tools/lib/bpf/features.c
> > > +++ b/tools/lib/bpf/features.c
> >
> > [ ... ]
> >
> > > @@ -581,6 +643,9 @@ static struct kern_feature_desc {
> > >       [FEAT_BTF_QMARK_DATASEC] =3D {
> > >               "BTF DATASEC names starting from '?'", probe_kern_btf_q=
mark_datasec,
> > >       },
> > > +     [FEAT_LDIMM64_FULL_RANGE_OFF] =3D {
> > > +             "Full range LDIMM64 support", probe_ldimm64_full_range_=
off,
> >                  ^
> >
> > Andrii requested in v3 review that the description should start with
> > lowercase since it appears mid-sentence in error messages like
> > "Detection of kernel %s support failed". Other feature descriptions
> > that don't start with acronyms use lowercase (e.g., "global variables",
> > "minimal BTF", "kernel-side __arg_ctx tag").
> >
> > Should this be "full range LDIMM64 support" instead?
>
> that's ok, I'll fix it up while applying, no need for v4
>

applied to bpf tree, thanks

> >
> > See: https://lore.kernel.org/bpf/CAEf4BzaLqWT1oj-EXibyAfE0ExmiaCCqhosRu=
jDi7Y0Nyho6dA@mail.gmail.com/
> >
> > > +     },
> > >  };
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/2187=
8398162
> >
> > AI-authorship-score: low
> > AI-authorship-explanation: The code follows standard libbpf feature pro=
be patterns, includes iterative review responses documented in changelog, a=
nd shows natural debugging artifacts from review cycles.
> > issues-found: 1
> > issue-severity-score: low
> > issue-severity-explanation: Minor style issue - feature description cap=
italization should be lowercase to match other feature descriptions.
