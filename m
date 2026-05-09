Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EFB337B81
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778368585; cv=pass; b=XIhl5bq9jGw66ygdK8RhlCvBA8+7pVh7dHAm0d8O0FFReaz3121VyPtvjUC1tZyyoXPdVfq2frzseJmwz8kX/Ra/0J0qjnZ4sfKPEJHLA7Xx0gGYMTWvx4sGIIhx9kDey341+PWyOlP72exPI2cPFRC5WFs9OzMLCTX2ZvPrFiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778368585; c=relaxed/simple;
	bh=z6GqNh35kOhKngHoBAMJY4T3MmTzLlBK6u0yYQ9qTJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkZr2U6kOMAPGjYAbYLkX/EjALSzUiuRZwMOClH9t7SZlDBwxG90yv/sghoKzwggZOSUvD0InFLNFqaPWqRDJWpCzDxjeEWEyTz2DZu65aUqJePSVgqAsgiDUlh40/MD4pzg3fj9hsoRLGYWvHzJXSiTjX1g4F8gW7DL2SHChsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7ZwP6XC; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7ZwP6XC"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso37590475e9.1
        for <bpf@vger.kernel.org>; Sat, 09 May 2026 16:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778368582; cv=none;
        d=google.com; s=arc-20240605;
        b=Alx86OoS37Y0dg4q9LUD7mvTjcNqyXqSmX1RgrHuOc2ltxS39bfDJCZnhOcUp72RG+
         3Nii8Dq/5JV8nSMk5f8A0FEi0DCM2N1CPLHTpKLIhq1Bvstc3jTGoG6tvBarRUY7U7pJ
         Bv6Tr6ODiJS+6BCRSOTPsTGCQ8BRsvRE5zSlIXCNds+XKXL1iodOWcYBTtawYjboJxhs
         ptHATeVAMnPfA96Y/q6zlXYKx8ADVlJQnivJALsg/E10TQZhVUTUxAoCRYxfiM+Ke7KB
         3j0De+CqJRL4nl7brM1fgbXJOeRJuf3hBTqmac70/Itt/MYz1fJvJC8TPGXwBNNvHMoG
         jOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=td6p/tC9q/Jox/JtPhnlUuVPVt7q3Q5KQO+ELC+HUjQ=;
        fh=FY2/EDnisq7oZWJxfdUwYDsDZL+evAoTiaeSNjAMRg8=;
        b=cpIoEkI7sul7jT9EiqisbrsaHfOzJdyqqZ43nAWZRJjGvIvAq9XIqz2t03/53XEzzj
         U/y8nJ8W5aOVPpZyO5cCC06uRKpKZsop5uJlPDAq3LjBhJxn+h15uRPpT8hX7weox9DY
         lhMeEs30QXu7xpBKh0or9PZ2Y3gW5s9xEhtKDkv5vRojNaEBoCzW6xFJlmkNBX+4iLbP
         ZqRXag55uXGUTVhbXLtVAUHwxd8Mtr1EhwNKB+pEGpKqnDh9d0MARlEMowxP03ADjQwY
         XTaxclDHFtZvdgqnwqU9un2vtfkD0cPrAQsxkUmvKBNF5a21GUsr+FvsOnhY5rzkvvvC
         GftQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778368582; x=1778973382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td6p/tC9q/Jox/JtPhnlUuVPVt7q3Q5KQO+ELC+HUjQ=;
        b=C7ZwP6XCIIB9BL/6u0Y+bjqiNNrr2cA7Xtmhe+90G02YzRv6nFPRG3DpWqIBAPr8SK
         fxAJqQhiWGA/Kf0sUEYEFPAmLnCN5Lf6L8ZAL5Mg8/NESE0pdf+a8gBgC7+sTIKZGxEq
         CKAAZYzjPmkbJuPqJfoxdZ5WYH1NLcWh2lElwDoc7iWu4ykgLOAdZmsxGmPncsLftFUM
         MWHoKJa9zQ+5T+VDbAv6AedFLOGRaxq0oLA5Vek9INt974EMGWBO0QTCFKPbbR5Nys7W
         e9vCX964MIXZrplvWyG19ojmIabbDORAOHeWmFoThvqC+AsOiXe88awyjRpi/XsMTR9q
         QzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778368582; x=1778973382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=td6p/tC9q/Jox/JtPhnlUuVPVt7q3Q5KQO+ELC+HUjQ=;
        b=iqKvsjWSCOAVwBscicGjyl/vB8nu28bk8qiO2Uf6grdBVks9pZ5AULhPUhUc/4AkUG
         pI4hrvQCRAnqkQfhUb87qBqU3Ca3H6jkg2LtZJXC2RokPDzzglGpq5dFQfQdMw1CJoIQ
         /VtXnovo5/30sfdOv8UZUL/BEj/NxuPWWV7NSaNkA2zpCTxkSdZGdbcrTwprAPhh7dcw
         0ejigxxZf3vbwtHBR2M4pxfbdz9uGe82J5C+WM2PgFtlU5/DxjWxbF25003WrntQu+yv
         QTorU3Gs6ZkK2iKo/xjt6DOq3Dd0k20qDX2w1fa64fSYcZx397GJpPheFhH+8I+VSPvb
         BOnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2P91NXZCKD5+IzArne6ZaKnctsU9yOIC8kCl5n61kKCKXEnh4NLGxyWMT8uhn5iRtP0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx9UpPtjjMLiz/Vj3pjJMz9I4lUzWb63l//yKeHuC7wXtTUu2b
	dyu+M4VNvSIQpwWfRSh5STIk4L2tYielHmMbNhqvJ8/evx/m88EaJa4cq3x5tnz279JrFPR07k9
	rl3oguL4agXa6JtDM35GZQjaghnNwups=
X-Gm-Gg: Acq92OENqHzmdDPTF34CDxFk26CeD1ZGm5NwXdFajqfH8YSaQ8YWeR8bh/8CBfvo8ky
	DSJ+Su2BY+QZ+6yhcGxjhJGOve8WrUHwhIR4KtQMYmucGKSjjN1oZ+kv9Bru1N9MH5+cVd5uHRz
	3+2wiBNLWKpbAV/mbtAARg0yHbTgsYADT3hVv8F3KKgwvnWvcXkkBhsBWQVswLXoi85V4yEL49p
	U+Zis4SYT3IFbXxp4djPiNVcBtSiLIyVEBhFRWbfzuqWWvEKD5oVKGKwDFwEDm/XPHjKxDJNCUZ
	EWpwwZgqbI64B5IVasDaIPhtPC2I2Jvqkus9giX0eUwgFGLYFPuEBe3uRPgZMpZCUrHdIkgOH6Y
	zA7TNe82qExlBZj39brs/pHJSc2arn481ZV20
X-Received: by 2002:a05:600c:3b17:b0:489:e696:836f with SMTP id
 5b1f17b1804b1-48e51e15718mr262730405e9.10.1778368581751; Sat, 09 May 2026
 16:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e4d7b53d4963ef520541a782f5fc8108a168877c.1778176504.git.paul.chaignon@gmail.com>
 <CAADnVQ+kM=Zg_pcY30QHFPu_16L8wa+DbgQqnidqo-QZphihFQ@mail.gmail.com> <3e3a145bfb6c17535c5c921c60f405d56d32bf7d.camel@gmail.com>
In-Reply-To: <3e3a145bfb6c17535c5c921c60f405d56d32bf7d.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 9 May 2026 16:16:10 -0700
X-Gm-Features: AVHnY4LNOuxxylmawwF8f_VMrnOGtFCnsdgSmTPBrG9tk3fm2Z6Sh6k-dCX_9Es
Message-ID: <CAADnVQLpbXdoqo11c1a4mS5XYPG+5WXrd+MP9EFoDGj1_B0uaQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Don't run arg-tracking analysis twice on main subprog
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 4:50=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2026-05-08 at 16:24 -0700, Alexei Starovoitov wrote:
> > On Thu, May 7, 2026 at 11:22=E2=80=AFAM Paul Chaignon <paul.chaignon@gm=
ail.com> wrote:
> > >
> > > Because subprog 0, the main subprog, is considered a global function,
> > > we end up running the arg-tracking dataflow analysis twice on it. Tha=
t
> > > results in slightly longer verification but mostly in more verbose
> > > verifier logs. This patch fixes it by keeping only the iteration over
> > > global subprogs.
> > >
> > > When running over all of Cilium's programs with BPF_LOG_LEVEL2, this
> > > reduces verbosity by ~20% on average.
> > >
> > > Fixes: bf0c571f7feb6 ("bpf: introduce forward arg-tracking dataflow a=
nalysis")
> > > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > > ---
> > >  kernel/bpf/liveness.c | 11 ++---------
> > >  1 file changed, 2 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > > index 332e6e003f27..505250998f36 100644
> > > --- a/kernel/bpf/liveness.c
> > > +++ b/kernel/bpf/liveness.c
> > > @@ -1914,15 +1914,6 @@ int bpf_compute_subprog_arg_access(struct bpf_=
verifier_env *env)
> > >                 return -ENOMEM;
> > >         }
> > >
> > > -       instance =3D call_instance(env, NULL, 0, 0);
> > > -       if (IS_ERR(instance)) {
> > > -               err =3D PTR_ERR(instance);
> > > -               goto out;
> > > -       }
> > > -       err =3D analyze_subprog(env, NULL, info, instance, callsites)=
;
> > > -       if (err)
> > > -               goto out;
> > > -
> > >         /*
> > >          * Subprogs and callbacks that don't receive FP-derived argum=
ents
> > >          * cannot access ancestor stack frames, so they were skipped =
during
> > > @@ -1934,6 +1925,8 @@ int bpf_compute_subprog_arg_access(struct bpf_v=
erifier_env *env)
> > >          * each subprog is analyzed before its callees, allowing the
> > >          * recursive walk inside analyze_subprog() to naturally
> > >          * reach nested callees that also lack FP-derived args.
> > > +        *
> > > +        * Note the main subprog is also analyzed as part of this loo=
p.
> > >          */
> >
> > Thanks for the report.
> > I guess the fix is correct.
> > This part of the comment needs to be adjusted:
> > "they were skipped during
> >          * the recursive walk above."
> >
> > I wonder whether something like this is cleaner?
> > -               if (info[sub].at_in && !bpf_subprog_is_global(env, sub)=
)
> > +               if (info[sub].at_in && (!bpf_subprog_is_global(env,
> > sub) || sub =3D=3D 0))
> >
> > This part of the comment:
> > "Async callbacks (timer, workqueue) are
> > * also not reachable from the main program's call graph."
> >
> > is also not quite correct.
> > In here:
> >                 } else if (bpf_calls_callback(env, idx)) {
> >                         callee =3D find_callback_subprog(env, insn, idx=
,
> > &caller_reg, &cb_callee_reg);
> >
> > they could have been reached, but find_callback_subprog()
> > will ignore timers because FP-derived args won't be passed
> > into them.
> >
> > Eduard,
> > wdyt?
>
> This is a nice catch. Idk if 'sub =3D=3D 0' part is necessary, tbh.
> Paul, please add my acked-by when you respin with fixed comments.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Reworded myself and applied.
