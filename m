Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1782B3E274A
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841135; cv=none; b=fwPFA2LGfWphEjVKQwK55ajf6cDLW1afRvzmeqqrheLvddGqetc0ysrpKKxLiRdZ3smId60gQ4SDTx9DB2TgPogQWTkFrapiT9vnja9W6fDfXYOqa2FKTqFHt5tJtfmG9eOJvPmko+NyVkoaPTOUz0HzSlRU3X5j3WkcPMHVU6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841135; c=relaxed/simple;
	bh=7Y50K8gzWNHN2+9cjC7SKN95egvIxGaPQkmfRVHtBiI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PsbPUvJ0ne33gGON4HTwlY2qx8Qey8P0+ZxRbtwx1ZHCsyOPQvwLaC0e592j8sHVlLYrqAy2Gll5J/Jfmdj/N3Mpza4GlS9UD9ERkdJ60XyTlGD5tQcT1cnQXFZPJ+iKojITSGH8MZf1lB3qLa/ok8m3jKGTKchnpNpkZbiSqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaS/wwgx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaS/wwgx"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b24fede2acso13642585ad.3
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 10:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775841131; x=1776445931; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hGMSCtid5NZkJo9E6D62MXqXr+LpqW+55Gy3qfwLuSE=;
        b=GaS/wwgxBNHFG4Fib0ZHOsySW5ij4bsQzv75DdZcUiKqLYeSJ58xkZJSzQGqrkL+64
         bttummoK7AOL4oSC/abcT/xsyptCxaNlqpJd59nmWdBa263gcx4PaAUvmXE2HngS4yTq
         RPgwEeb16x6dHbt68VmEAa547jeD9OjjD0YdwLsaAFbLEgGG/V+0AAml/bniIyIDkI1L
         ZK1ZX1+ngQQCqAR2v+SimIAnv5NqsxsNu8IfhqCVyMwHMz4Qczh5y6bguOE419EozAbk
         HgxpzHGkcZIJny7qjoLnKmUP4bIH0uI0j+PiQUUMxJkKPJhzLx7hnDm61WGpYoDgskHY
         cuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775841131; x=1776445931;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGMSCtid5NZkJo9E6D62MXqXr+LpqW+55Gy3qfwLuSE=;
        b=VdqSwcufdoa8idMXZC1KbFDWjvTsPn1OPHz8Vs88I2c+Dq8Wdnhl9CDAXBVj/BlUou
         COaR/Sb/+mX4MpCnTBfH5iA7SG8Fkysz5cE4XMMe22DxSYMTP9kFK+BYDapPeSb/M18a
         kVG2cmLTotfMS5RrM3up4WqvLZ4LsCWYasU6n3qzeGtNE7ySWXt+TeN5iYPnKvol4GQa
         ZmO/g5UGui5a+QU28KMkLCYz2fwNmIeMZYJNxaa14L4xcU1+QYFaQXvzQdLB7vesPrxR
         tsZqsncn7WLFiwhhpkq9krkg23l22ZPmwDcZlnxGgSzs4QzJiDOcnLTseQ5tQDzZviWt
         aH4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZdI8dmTnM5Vgd0Out0fFuU6iegoKt+DAHw4SpGkXHPXtNlcLDE2HGh9ZKL3ZxstlOaFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX8meb+ajYqxUa0JdA08/LqGpO7qgSivdJn70/d3ryw98xCynJ
	SnXMrDRo/WhHD0obxDdjb/sX6dYAgKVlXrCXD7qNiF/vErWC+EhTlcWu
X-Gm-Gg: AeBDieusxhN4sFVZXdx41dTqhQJuK2q2hW2UTOLqzdj+xjomDBrM3y6iBhc8aN9ddbw
	MkNC3/D4IAmIxWaRQLgqVILYGDGHoWXNmwlElSACm9gL9pPcIqFda3uRK8pzb+4Wbpr4RdA6O5g
	7IYyvT1VYUe5j+2azDltnZ67B1Naixzt+HfR4nORDBh7BE/4dg8MvFilIuVhLFlDnp3LSpq2b9Z
	xEZqiIBJt1KUWQnDyOwLq7S+Qc46cNWqopP5MLTq3UhAM0/PhlmpeHp/XdOQgYUgB+Vfmh72IEb
	RZzK7xG3OA4B8tBOhuS1TEk4yWxBoo8+F71gZrV71qNWInCAe8m4CTX0IRfkXIi8gROoWQ5yDZB
	aa5fud+2vE7AiBz6vpDWPaaD5DRZe2n4cELoQohiSDZSwBk9srm3PQg350fWfPMnJgwjsZB9755
	sS7lLbpVfk9vRZRuwaONd5iJFpjVOkyvw2f9Heo70PGcfPl3JKyuwXAouvH/sa5xI=
X-Received: by 2002:a17:903:fa7:b0:2b0:6e6a:8504 with SMTP id d9443c01a7336-2b2d5a3033amr40244585ad.27.1775841130725;
        Fri, 10 Apr 2026 10:12:10 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f0ada5sm37471625ad.42.2026.04.10.10.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:12:10 -0700 (PDT)
Message-ID: <1d7dff25bec3966fe74b56d47ea4a5ac694a805b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 09/13] bpf: change logging scheme for live
 stack analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Date: Fri, 10 Apr 2026 10:12:07 -0700
In-Reply-To: <14bdd17ba48246c7ed1add4332eb7df21ca1ba844b12d5f69317c9d1273d18fd@mail.kernel.org>
References: <20260410-patch-set-v3-9-1f5826dc0ef2@gmail.com>
	 <14bdd17ba48246c7ed1add4332eb7df21ca1ba844b12d5f69317c9d1273d18fd@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-10 at 09:57 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > index 1d9c89a269e3..3c421ad8684c 100644
> > --- a/kernel/bpf/liveness.c
> > +++ b/kernel/bpf/liveness.c
>=20
> [ ... ]
>=20
> > +static char *fmt_subprog(struct bpf_verifier_env *env, int subprog)
> > +{
> > +	const char *name =3D env->subprog_info[subprog].name;
> > +
> > +	snprintf(env->tmp_str_buf, sizeof(env->tmp_str_buf),
> > +		 "subprog#%d%s%s", subprog, name ? " " : "", name ?: NULL);
> > +	return env->tmp_str_buf;
> > +}
>=20
> Should `name ?: NULL` be `name ?: ""`?  When subprog_info[].name is
> NULL (programs loaded without BTF func info), this passes NULL to the
> third %s.  The kernel's vsnprintf prints "(null)", so the output
> becomes "subprog#0(null)" instead of "subprog#0".
>=20
> The conditional `name ? " " : ""` on the second %s shows the intent
> to suppress the name entirely when absent, but the NULL on the third
> %s defeats that.

Uh-oh.
Silly meatbag is going to be obsolete soon.

>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/242365=
38770
