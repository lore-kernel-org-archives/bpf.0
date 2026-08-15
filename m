Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCAF2D8370
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786814975; cv=none; b=bx4Z/UGRqH4sGvTlzHkVv8oG6mRU3qBQPs+MqgYGtr4OL4duFPzb5dFhq2SeBYhd43rJ7WnOicF8hcXuuKSLdEDSk847GTiRQaNT9JnTknMzyjUmVzVOarGP5YgAEj1EbFEM00+AxsOjuMPqnYvttBEV2E101EtvFilXGVhtQcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786814975; c=relaxed/simple;
	bh=WnEoy2UvpZ4Kh5rYTCpETv8bn8c7aliYGO6EqInneTg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CceWU0GjmXuonzsud5wm2uaJ23SWg/e3L/ZwkUvgeLby7gIUBd3gKIg5xNv+bBH8e8ikJ8fZZoJQqlLnbg45igk0NUF0CoAJwX071bl/0RS4S1jE1r9JO7iNJlOYp/SGuef8fcGVwnZXUKaWC/h76h+HAbSAfsIpQyn92gnQFgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/xV3OTO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/xV3OTO"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2caea3f742bso35459105ad.0
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 10:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786814973; x=1787419773; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mOb9Wx7aWE/W9sY5AfLPQkAzoLdRUbNzaUnCc4Plo+4=;
        b=C/xV3OTO/uXxWytPfoxV//aBUx5rCQ8rV1gKx0BMgrcykIIRQwUAVnXdgCevhP8vq0
         ycTN8KgghzR+F3L9K+06H49u6urxPoqexrb5Ase/D3H58TkL8zI5FUPKpmJ/7+ys7nxC
         MsA1N6zJLmVeaR3x0X2nezKKM7wL6S9oN5LIdETW6gQN5iWwG+v1c/VUsg3t3ru2bN7H
         OK7nMVEVJvKbq+YlHYqrzuoPfvG6PnBrSMBIFO70ciFq+RwuWLiKclqCKMsi0kYOajoI
         cKNKy46dkVO00bHblcjXTKNBm2Y6ELTnSi1jnvT/XxlRTr659805hCjYaPJrPH87+aJ/
         blgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786814973; x=1787419773;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mOb9Wx7aWE/W9sY5AfLPQkAzoLdRUbNzaUnCc4Plo+4=;
        b=bbM73EMRAc/yddfzdUI61cw/+nGy4+6F3Wl2g0ojxK6EuMbUH8XGOhO6nefyCuRVHy
         cu4tzuq6L4z/xjta4HHlD93AdQoXWNUVZU2AQ8HHjosjq5QaN3tZR0XuKqO4/51nxekU
         nKBXuF39mviBWK48H1tWRF2FT5pvO9KUZ8o0ipsZds+GzpDPM5d1axGKDZ3UbT7hkUcI
         pVZ1yUjtyzI5hoAT+Vf9NTRzLtEHh3EJP1+5TQEhYtvyqZfJNUFixdVr/nvCaD5/Hr8p
         tMjQu6ldng5BUtxlDcZmc8B6CszK6BnXFb4I/GKmrNqXXAhughB7qa0E5iGP2QyvmCsr
         oMmg==
X-Forwarded-Encrypted: i=1; AHgh+RpVf394PcSuryvks48hXJ3h04/ca9LvMOeWpCJosm3clGOZEdWSFR6JqkL1QsIOT6LdiKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbNrmlFRKDcYcP4ZS9wcof8ji4JUEheF9FC3CL6ofTTsW41IzO
	yaJ3OKU+yzK6qGBHOkOvzDYZfc9wRZDVITINyFCNa2Z5+mdAzxfOIHeKT5jKOQLw
X-Gm-Gg: AR+sD10Ly2yfuvUvoc3X7n4Iq3fn8S6jr6w1RoFVpwsqnMQGVbUqOxVYp3TgGrgIpPr
	NqdUVib9XjghvJ8m8xSHbjCxv0KZYKUTwEoD1bduNVZMgFh+21yyFzeuS1SSM6EYKwdyGhsjzfJ
	KWahdYvPoXaTxRZSC0KE1A8/2MwlB6VBcoYelheu7Fl57Wea9eEvMsFaHUoCxEmaPDFRfgslkzB
	TDpNaIXtygROSP42M6iA20xWHtQzd38dQMponnlA3j/aD9GN6cGQm7iWEIZTZw31GZxIN+o6k/I
	iZ1SkUL5L/zNEGWMB4uJc6p8gYOsT4Ql7Zh9YVaYBvdJ6/zwWLBVPNlgzXunzP2md6nUfXe/Lfp
	hlDnJ2kYgmGUSDnShfzV4sHgdpJrsPq2989aVwXKxfcxCKRo4eLaRYD842Cx4To5Ylk5wNEbW9f
	UQvP6y5/p8n+65j75dZlJ72/55/M/bdaYPAYp4tgW44J2p1nVtg8XQdv/C9rgsIfQWZ7zaK+ulg
	GCZqGCqrxUpPgNXH4qtIxdKkxk=
X-Received: by 2002:a17:902:e543:b0:2c9:b396:1a55 with SMTP id d9443c01a7336-2d3b0c4876emr143762325ad.12.1786814973044;
        Sat, 15 Aug 2026 10:29:33 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aeb29c04sm20658685ad.49.2026.08.15.10.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 10:29:32 -0700 (PDT)
Message-ID: <eb1be5327d136b7e5bd6d68e76fef6de20c40790.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 08/14] bpf: Report Register Type Safety
 errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, memxor@gmail.com, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 emil@etsalapatis.com, 	kkd@meta.com, kernel-team@meta.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, 	clm@meta.com,
 ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 10:29:28 -0700
In-Reply-To: <85d734cb98ae3cf513fc1c123fb1666d6fe576f0afbe734b5058c37a850f53a6@mail.kernel.org>
References: <20260815064612.378577-9-memxor@gmail.com>
	 <85d734cb98ae3cf513fc1c123fb1666d6fe576f0afbe734b5058c37a850f53a6@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-15 at 07:34 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
>=20
> [ ... ]
>=20
> > +static int diag_stack_argno(u8 slot)
> > +{
> > +	return MAX_BPF_FUNC_REG_ARGS + slot + 1;
> > +}
> > +
> > +static void diag_format_stack_arg(char *buf, size_t size, u8 slot, con=
st char *arg_name)
> > +{
> > +	int argno =3D diag_stack_argno(slot);
> > +	const char *ordinal =3D diag_arg_ordinal(argno);
> > +
> > +	if (ordinal && arg_name)
> > +		scnprintf(buf, size, "outgoing stack argument %u (%s argument, %s)",=
 slot + 1,
> > +			=C2=A0 ordinal, arg_name);
>=20
> [ ... ]
>=20
> > +static const char *diag_mod_target_desc(struct bpf_verifier_env *env,
> > +					const struct bpf_diag_mod_target *target)
> > +{
> > +	switch (target->kind) {
> > +	case BPF_DIAG_MOD_TARGET_REG:
> > +		return bpf_diag_fmt(env, "R%u", target->regno);
> > +	case BPF_DIAG_MOD_TARGET_STACK_ARG:
> > +		return bpf_diag_fmt(env, "stack arg%d", diag_stack_argno(target->sta=
ck_arg));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> Does this numbering match the rest of the diagnostic output?
>=20
> diag_stack_argno() returns MAX_BPF_FUNC_REG_ARGS + slot + 1, which for
> slot 0 gives 6 (the absolute argument ordinal). But diag_format_stack_arg=
()
> uses slot + 1 to label the same slot, and the pre-existing verbose() mess=
age
> in check_outgoing_stack_args() also uses spi + 1.

This is legit, I think we need to use verifier.c:reg_arg_name() here.

...
