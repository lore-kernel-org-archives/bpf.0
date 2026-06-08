Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BFF3D1CAF
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942668; cv=pass; b=QAxgRuLWv/sIZeZUi7ytqZNSlRYtNEfkvpMuffUyT6v6RqwKf3qRqTwLpehQC9N2RvSlrFhlFTcZhrfc2qgBkLinvSvVx6mbQySrTf+y0KPRRlww1Zc3vzAPx8gE+4HQd/3LmnQbco6Cg6EI8wecqBaDvrJ7KP1wiNFHuiYyYI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942668; c=relaxed/simple;
	bh=qEXPWKJAUq9h7gKR3mFd+TXuFcMvNL0MlYhGUvYhw74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NV23xKkzPCnUM/lHaIlNkLs4Cw7LEvguOXammlHRR9D5xj/vY99VIopYi9txVBKJqSb4LccnI0um73KcQUgim5XJZ9wi5hDlQt+PHsEMgVPKreXPfCtLQEvC3yz+8Z9lfkDZq+sNUO/5BbCtiFAIPB2ijRlAaMaZJs+rN5k3ipU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pcSDhrqL; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcSDhrqL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf0ddaf50fso31665935ad.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 11:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780942667; cv=none;
        d=google.com; s=arc-20240605;
        b=X9QKhZILgbxx4a6IwX9Hoo4SOmbz0kcCWB18VlDXVzA/cI2Nmw+l/+0DrYHdIM5JzS
         yGHqGnAMGXliDdH86JPwyw8V7hRZmm/657kxB5q4qdXH1TbkRhOb9W1TYJBGXL4jB78Z
         A+9MM+fs7I303l53xwkLcH+QqSpgKpH+vKvYHuIKr/wMNvgrmjZnpAEJeUVoVFToZ43F
         hpBVHDcK/Rha1mKEa1GK5DdzrLPnL/6dYyP8SvELapxohDYkyGgVyG3CZY2sN4lvLfbF
         zz5Gyrb8T3U8gQZxaq1B4Fk/j6tlTU/xADpAahmSgr2imv5TsZl6m5QV8XNpOvcTldmx
         gjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t5DnDar6JBnPe48ajQB1Hb9265gKUCW9aay647po/SI=;
        fh=78A92xKN0inphqxGkHcvwryHF4So1r2374/wLD6oGNw=;
        b=IToGueRkGKmeA5YT3+NfbDIIAJuN0DLv/6pVTC+GlzbJCm3j+EAXMs4Kro1ylrIjP5
         jPKhe3NDaGt/+NZR2QkcgUOV8WQXI4UJuiaEDnygsTqeh5XwQ8XZJaA0m6Mb2uV+06zN
         SEcTXp0JD7DLhqGHNrGliHPWsrCI+PRY9OKUjGaZUs2EO0L0eZz2jXsEIvkK5dZGMRRH
         JVmVmYspCRY4uCbJkDAbV+dmJDk84PEUuUaTuTIl7CtxeE/O+X0qvM17k/VcwLm7+NNh
         gvWoO5cVwFHtBDP2QGSw83pSiPccjewNzndRbi+qc+zmfBjVw7ZDvz8aU61I8XGcEkDS
         CZDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780942667; x=1781547467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5DnDar6JBnPe48ajQB1Hb9265gKUCW9aay647po/SI=;
        b=pcSDhrqLqZgA9oHaxYDBaH5WqiBwXPi5NJ7hSn9ETt3Eo3lmZ39nh4EyGS3XeWgueu
         BxlUSn7HvrLwOdQcML8aQfaJVcODOfB7X5GCDVCeQYG+K7bIrTSJAud1ht9BIrurtHLX
         XBCF0dz0vlzEF6MX6I/gf6X7YqxVZIu5v4Crkzjt9pKpJm6MV9xq3K5sDcnQVYcRQaWA
         7YNUqEK+S90fHiNtO40xi+pSs5bcIrcd0CQNSd1TxCPjG2DDv0UJ7btUqUeb2hRakZRA
         maKSifJtb1ElbQZ8+ZhUJP2acxqs9DtdvX2lwwkjn8A1O6j1HzDOYrFB1uuKUwrSvwBX
         aIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780942667; x=1781547467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t5DnDar6JBnPe48ajQB1Hb9265gKUCW9aay647po/SI=;
        b=qDu3bvrA35PGApZ2hd9r+IZFCol5bZYSvs22wCBi1wzJbXsD6bZmAE4vQnjyYMzo+a
         888xCwSAYw//vdgZjAkfn0RYheX1oy4EKs2FBRCU5IYTVrP03xEf0va7v85kd3fnd9Mm
         229Ui0WGxiArqY14WgsAdxIvWaMTyJ9HahXGzkTvKRoBigtKkR+Hfu1lIQAFRbWAXyUX
         cWwSKJcPKkqPQPOaspsoWgZzXiqAw001QE0MeyTZRGF7N3xxUfPQTgdTFlfVmbiwzC0s
         RF30HNo28jYn1RUIicpGngBjCcyhKg/b0O2VdZoHkHLH6jiwi1wk/26ICRePujNP9MU0
         nVrg==
X-Forwarded-Encrypted: i=1; AFNElJ8pYjMyJE0G+vmoP6HHL9tqkz+j0r3dINOuD6D1NtZ4JXJdoiXrYoJctTIYiPv+ddt1OQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9tecY9NBB/qynWEIQQd+5drrbzT0aWVuyQ4aFu7BC+MXY63GZ
	d08M+eGWmFZYDVpHRomwx7TdXBgSv+URmRnPdScf6eVd+sKB2kSyiW28Bn5umMr0Y14o1MusXCy
	YLqjbfAKUXx5F8Nh6AUWNfrcgfGZ0wj4=
X-Gm-Gg: Acq92OGEBgibfgIJx9ILTunidIXPSORsWoGdXP+fNk7VejSkpTzS55yOhOxMGVbEGaX
	i7+EG0pmksS3ZVYiT5e/Z54DBYBwiJfA6rWLUjsxWpdPYOmaNTaR8mMBwC4Qyua+HVCYtx8qdk+
	kwUB6DYWL76kYyttkDO8NLgbV+vC2/j21NsYfSXlhwCpWwXWmoWFYl1AuCkFRt9Ryo8uNK9ANp0
	ELRy3hE59xVBgU87xeZXID+HwnGc18MU/NI+NUwcJ5uAUH2jGfhD8Tm0m1l1tCMckFs53sLqmbd
	m8ef5CZyVzLKUGrFIHDivr19RDdJqPtDKTvnV3w284A2HfjogZTUj7miqeyW4eSBz7HF3JYnRHI
	AjYKmsgoQlVxXN6s=
X-Received: by 2002:a17:903:1b44:b0:2c0:c262:b925 with SMTP id
 d9443c01a7336-2c1e7f9252fmr195715815ad.25.1780942667015; Mon, 08 Jun 2026
 11:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529031604.888137-1-chenyuan_fl@163.com> <20260604031033.806727-1-chenyuan_fl@163.com>
 <20260604031033.806727-2-chenyuan_fl@163.com> <e23baad8-1709-4210-81c8-22741b9dfb3e@gmail.com>
In-Reply-To: <e23baad8-1709-4210-81c8-22741b9dfb3e@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jun 2026 11:17:31 -0700
X-Gm-Features: AVVi8CcTUadNsMgxD4J0IajYU5XL2tzBD2ThgUFwBi0fy2o_akjL-kP-J_G8V_M
Message-ID: <CAEf4BzaY3LLmMbSm1ritXwTvqGYi+KSWSkqMYJd62D7opu4ZnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] libbpf: Skip bpf_object__probe_loading()
 when BPF token is in use
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: chenyuan_fl@163.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, chenyuan@kylinos.cn, daniel@iogearbox.net, 
	eddyz87@gmail.com, linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 4:16=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 6/4/26 4:10 AM, chenyuan_fl@163.com wrote:
> > From: Yuan Chen <chenyuan@kylinos.cn>
> >
> > bpf_object__probe_loading() tries to load trivial SOCKET_FILTER and
> > TRACEPOINT programs to verify the BPF environment works.  When a
> > BPF token is in use with restricted program type permissions, these
> > probe loads may fail because the token does not allow the specific
> > program types, even though BPF loading is perfectly functional.
> >
> > Fix by skipping the probe when a token FD is present: BPF token
> > creation itself proves the kernel has a working BPF subsystem.
> > Real BPF issues will be caught during actual program and map loading.
> >
> > Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> > ---
> >  tools/lib/bpf/libbpf.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index ab2071fdd3e8..7e21c5eb9533 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -5167,12 +5167,8 @@ bpf_object__probe_loading(struct bpf_object *obj=
)
> >               BPF_EXIT_INSN(),
> >       };
> >       int ret, insn_cnt =3D ARRAY_SIZE(insns);
> > -     LIBBPF_OPTS(bpf_prog_load_opts, opts,
> > -             .token_fd =3D obj->token_fd,
> > -             .prog_flags =3D obj->token_fd ? BPF_F_TOKEN_FD : 0,
> > -     );
> >
> > -     if (obj->gen_loader)
> > +     if (obj->gen_loader || obj->token_fd)
>
> This change makes sense, bpf_object__probe_loading() does very basic
> check that BPF works on a given kernel. In this case, when token is
> passed, this is ok to skip. An alternative, trying to make
> bpf_object__probe_loading() correctly token aware is worse.
>
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

This is the only patch in the series that makes sense to apply, but I
don't see this series in patchworks. Can you please resend just this
one to BPF mailing list? Thanks

>
> >               return 0;
> >
> >       ret =3D bump_rlimit_memlock();
> > @@ -5181,9 +5177,9 @@ bpf_object__probe_loading(struct bpf_object *obj)
> >                       errstr(ret));
> >
> >       /* make sure basic loading works */
> > -     ret =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", i=
nsns, insn_cnt, &opts);
> > +     ret =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", i=
nsns, insn_cnt, NULL);
> >       if (ret < 0)
> > -             ret =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GP=
L", insns, insn_cnt, &opts);
> > +             ret =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GP=
L", insns, insn_cnt, NULL);
> >       if (ret < 0) {
> >               ret =3D errno;
> >               pr_warn("Error in %s(): %s. Couldn't load trivial BPF pro=
gram. Make sure your kernel supports BPF (CONFIG_BPF_SYSCALL=3Dy) and/or th=
at RLIMIT_MEMLOCK is set to big enough value.\n",
>
