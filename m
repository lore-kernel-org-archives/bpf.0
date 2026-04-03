Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE073CCA1A
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233035; cv=pass; b=JSDsUogf+FPCeh4DwpKglxphvJB5LEdenJFfaL/dj7KcGnXgd2ho8hahj+h+vlMBHUa3Mk9AvFHMg3ZrnqNBE6tg4Qzj2ct3m8sV08tAPlsXpoIJJdzo+NOAVvAcG53DCinpDQXPyTduCAXRDH0p5Nm9V4C4LCJDNx/k4hEpxLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233035; c=relaxed/simple;
	bh=bVAa0tVPrl+ZZraVrERiR3LqXKceJKqF7eRVzJwAxxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b60XweNq1eqCpnhunrmGCqTpCwJaZOikQJrxOGkQenbkV7JmoQpyqRFRDJ9GaGWTg2JZHD9rIZsITDCbX27GnJm/E3im6EUDcvtJzM+bJRtht4x0BNKPzEH66ZPqwzclpyzrgV0xslSSpdpGXSEG/bDGmo3YaqIPvPwFuVi0KbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koUJ21BW; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koUJ21BW"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cfa33a983so1297320f8f.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 09:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775233032; cv=none;
        d=google.com; s=arc-20240605;
        b=eKpfa87puzEjs4s0oe08koiO58zIs8cVO7t/WT3+wVF/jmYTy02sEKaV2lH8tlt8aZ
         YDjq7lNX/kkgm8MlOFqNT1FuXfb1HbZ6AXPo/02IvptPkYUsk0kD81QHsip2OI8RyavJ
         HzUw7ktY50R8BEAQqkvdzPql4lB/lECxALNnqm6R4cK08+rbLSi5gOeRDSMsvfNXs5y/
         0NZ/RDT0rI1UJZbATqSGjwP+ey2mXXWvw7iF1aG2IKnhUdPL0Gx50x2k91NLjaJ5sv7a
         ix1mfcZ9dQCfo7c4QRzHpA+vDZARJ0/94/kfS8AD3nZqWwJOStMyEPjunC6zBoGOG5g8
         1NjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZXczfDsnuZ1eKfjw7AeAQOseIwph1DmUQJxKWp4dMng=;
        fh=4u0wsseqOHzJhVzCPNiujUS9XmK5/RjMMpJjngy2IoU=;
        b=MwnMxp0Ue+7/mWnwtwmFLSNkWCIxFC2MFMWySq4kc6eqaB1sByvUqYQacJuarxCp0I
         T+AVq+XhHySNyz2PeMnic3dc+xRZT0nq3XTIuqgz2r5jSfcSHqILb8FrRnJI+0XcV14Q
         ZlFdL5vIuIt5lHP5Tso9CyMHjiOfmMVlnS4DXS8NFpytkZU3VInHj2yh+D47k78OvwAu
         FdyH5ZxfRFICOF9LserT23bKoYOiirTL5FeZeS9bHzfknMtJGb3n+VpH0wX+tcetmgUG
         yVn2EUo0UJAr4gS8Ie+T93Xs+B1Q6i6xjWs9AUYvaqBN6a5cL4saXu2gtgZsoUrsN0ZS
         KvOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775233032; x=1775837832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXczfDsnuZ1eKfjw7AeAQOseIwph1DmUQJxKWp4dMng=;
        b=koUJ21BWm07sjIIltcBRGbP4BTSGB3Mbexxge7J6z4xLPzdbJ1r3aT5l52C2AgxoQ4
         zzdPw8XG/JOgRFBkQtRiBQCnJfI4TPyWvMCkka/MhrxQBemzA6K34ZRGU7crqTAG3pm3
         +oQjERddS6TxeaN3uS7/xBQi713bCQccS7Bkb8B1mEUIAO7nJQfdgh0wQBYNMCqsGtj0
         Bt5lqjLxtG837UKZHmiSWa3De0/UvDJeZvZJ8ipjIM2TM+I13gfL32jAHE3pZNz1eCSZ
         DRo0VsJnUqkO0owPl9QdB0cXtpGOj3DILv+lcnhCVpItCNeWubOw3a0/FiiD9/hWPG8O
         hWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775233032; x=1775837832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZXczfDsnuZ1eKfjw7AeAQOseIwph1DmUQJxKWp4dMng=;
        b=dr58XjuA5PKfjfHnyDw71WErBTXHx4Bv2yHgXFdw8X2U/AcxJk/Ct83QyJp6caUuAK
         4T6iklmqg/EOirruBmwtC+aA/04QJuj3F4vs8AIUPv9oFwCn/eLJym2qzw6dhuIL4K6g
         mUK2YyNnGdhd+EJRafsLlUyL/Q9qTfnL79O6sqwzxJpEDo893TChY4GKhjJL0To72lUn
         nIL42I4KttxU9oD90fNNecOBHm4JTMbDy4kvi5gt7/5XsTIPN9FDW0IjyuaiP0L4NFSy
         bNQEz5EsEBvpO2cnj6jiYiY+PKiisLrq637EXMUyFyG+QgPs2tgNpU6mDjjIiyg+9aEA
         AKPg==
X-Forwarded-Encrypted: i=1; AJvYcCUFxM9tbCLw2c4hz54ljph58Bq9IlQitAFo2r3vqseKLF1qVphS5wSmDS/6cOAXyBK6kPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNKiH0M9Gco/V3IDLZiOos+P+7/BNvT9Ttc/G2HGosI02FzVid
	1mYZ33+2MYi5CyCk/4K+Vpu3greR6VPB9odCRCTUGPh45MVGADFOgHeR5ZKzkgCCK7MWATVlBge
	IOdb8fjYjOP868SZxXG/i78clOUm3iaM=
X-Gm-Gg: AeBDievHWmLbKGVvZWL8MudLbk9AOggKEuO+pIkc1qSvpFScY0/zc1Xp7/Lfyxsz/mw
	k+aWHGyc9kGnyZzGCuI5bNRETM6yApznAFXPIlz7/tR4pWW0fTvtc3x2+NYDCQXuRFAsyLjA6Sx
	SvNPLYtw8vujKnJwwYxewfjxgKCMCNlsU5UXpC0rmi44klDMdc7MBp029PuZpR9q3s5UISgEbvJ
	zzjqYn2FfAhUXSoJoG2P743u86GoOBRFRI5vh5k6Wn0RPEHuSoBU14QFZHYLQuqa7BGP1r90WBs
	xdj0gkhuwrdENLPvXMQLfy2O1lDLJ/WP3pTSXabEusZxC6aIWhS1u29R3mUrbjtMMRO7p2OPITo
	UuzXRcGI+YQuIqeeY5i13T8FvXA==
X-Received: by 2002:a5d:64e4:0:b0:43b:8fa4:194d with SMTP id
 ffacd0b85a97d-43d292855famr5589689f8f.6.1775233031605; Fri, 03 Apr 2026
 09:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401001130.it.781-kees@kernel.org> <CAADnVQJ+uSCvtpv4A33YeRi=_LCnZRaxB_ejVgdxPDO5u3+oeg@mail.gmail.com>
 <202604030852.D0F31E6@keescook>
In-Reply-To: <202604030852.D0F31E6@keescook>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 Apr 2026 09:16:57 -0700
X-Gm-Features: AQROBzAh2gaJNAjBABQUsT-kUzYHd2Il0HjJ3W_45dy4MAn0PLbD3Ecbks_CBHE
Message-ID: <CAADnVQLso-qgaa6CxT8pmh3rwSOA5c=G=97DNJHKXSQeBLgcCg@mail.gmail.com>
Subject: Re: [PATCH v4] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
To: Kees Cook <kees@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Sun Jian <sun.jian.kdev@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	bpf <bpf@vger.kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 8:54=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> > > -       strncpy(attr.map_name, map_name, sizeof(attr.map_name));
> > > +       /* attr.map_name must be NUL-terminated, like bpf_obj_name_cp=
y() */
> > > +       map_name_len =3D strnlen(map_name, sizeof(attr.map_name));
> > > +       if (map_name_len =3D=3D sizeof(attr.map_name))
> > > +               return -EINVAL;
> > > +       memcpy(attr.map_name, map_name, map_name_len);
> >
> > this is plain ugly and inefficient.
> > Just #ifdef kernel and use strscpy in that branch.
>
> I think you're asking for:
>
> #ifdef __KERNEL__
>         if (strscpy(attr.map_name, map_name) < 0)
>                 return -EINVAL;
> #else
>         strncpy(attr.map_name, map_name, sizeof(attr.map_name));
> #endif
>
> Is that right?

yes.
