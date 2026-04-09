Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0255370D6D
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771733; cv=none; b=JJAB15R3dT8FqUkeQr0sCtDOuM3sa5LjeKDzYNYPVz15uNhy0sMfqRFDVdCc8FpD1Inp46GZVaF3gR29S7g7EOGfpR8c8WTwKztnFWs1HIbM/7suCu7o2MzbZ0AD+F5xfg9WH3SH5yL9X99iE/XsVBjWJcFa8imgQW9wqfqrrrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771733; c=relaxed/simple;
	bh=aNrtCUYe+N2iABhuyi1SzaMyCkHyu56uZ6ui65jmsJU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RF1kbMzR9HyI6/TzxQxg59/7T4Tmpj3qxWS6IGJ3qCRLO3/TZnGgFCPbb61j67Q8v4mVkxdA6oC0vICqhi+KQ1y+Aw0syO0Sq5MZL4wajjPBKFsOo7MQ8TqtqLhJEI/VLmE1CFpvPQQpNt+AGaZ9y6S1R9BvQ3mMMbbDe0uEX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=smYzA64e; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smYzA64e"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2d17b8fbedaso600649eec.1
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 14:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775771731; x=1776376531; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pun3LQ7OEOIQX+jb0YDDhC9wh8TdDlqMKhdaqxjuNkU=;
        b=smYzA64eil7RrVBz9IrsWbyGNMu3zlxULNAL4uNW+m6imIvuWITBl+2bzDNJNfW/oi
         VlyaWQNA98jG9qta92qBdfpKSgmYcZwUv2hKb/qSPRkWOllhheEoglSWP7HoWjQXMQUv
         bFR0zopBsuhokieVgDT0/1Z+tuScIdc3pMBeb1goUAflxtJnZVCGdO3ERB3rf8NtuF9T
         K9zzuumn0njuenqEdehaxCsbJ9yMG2zR5ksrHd3vflKg3aUpSaVXcGlNlJWH0Fmkf4V3
         qSo6Nuf+kshOv9QmrGjmVxkxmG6NmvAy7AuBw570Tup15JDHyBA5HCKOweHRd/3L1oQo
         o79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775771731; x=1776376531;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pun3LQ7OEOIQX+jb0YDDhC9wh8TdDlqMKhdaqxjuNkU=;
        b=M1MA1QmGlbQfeQY10ZJVE3qGuvxlU2iED+1WcxxClRpcSPnaetWdTeNFe/JCmk1UKX
         l7GgtBTR2m+fRuNMULk5Evh3javsUdt7FT6Ems7BRmLv8oFNIzccm+FJpGGWrPYNUHCD
         ktARMUYQs6Dc9eUJWGoO+a2Wm/6upke3nGVPiuufN8BLSshZaMY6UwmeHKOdc8NFKZ5s
         WLjjrBXr+I3TBMFDTKwngxhKgvRjTP8tejW2y63mXIafvzFdLi+OS9T7Xba6X4hlddPa
         8p782b03rwGUlPCS+A+z5k+IC6WDEJtqoz+Jp+gR4P4w5/KFeEvk1dQSD91ikAYa7KzM
         f9Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVXM8Grln5NWki8z0tijpocZfcH5cADZmf49x5He2uPTimuN27q0jm9sKN5Dh/keG7hc8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRxhO8fNharWdAzsT+1YOTKYt4zwgfZzoQ1BqcsqwtTLAhpDVT
	3a+b1ahNLj+xxYVh1Qjir9nt7TEE/vvH6ZjRRUFrFI8T/YGb60RVTkzq
X-Gm-Gg: AeBDievL9+XOLp3JcEveJ5CCA/TBuOJ+A9s5cx7+YRhz8NfSpKBQSeNzOsNu5JvPapn
	WuaUYfUgCHCFihWufoEOOcva6jYJ4HvG0Sb6kVFWgYPRJbuzDtCPnNIX2vYuZ4LmccC8/mcl1Jk
	4bRoPsNGAgaEDpfJ9XUV3xJeWg+dSon7qIvW1lI3hHhRAbZVslVuhQ22IFol+Ck6EOX+JCrkFFI
	deYuEDW/3LOdrZ3HY8Zs2Iywm2qlMuoo0BuVLRTfP1VDZvbtuU+DPHBte+LwTjZF4NtK3dALZgX
	7UKL7B1StXFUry0jPGaQlGmLZk6ZA7cZkQwzC1d+u+zE4Voc5kOlVoRYD0FWveE1EkyV1Mq+9H1
	okXAJvPFwafwk/hIkW0QCseJXomZJvnarqb0q59XsZCGl8WeFIWReduhl/JewTBGz2f8VJuugIa
	LvLLHG3jJS/uuKek+uvx9Ss0oAE2vbtt9P8yo4sPoa109C5zOzVx32QVPmmMXBiNsT8JJc/nRnh
	KsV99c=
X-Received: by 2002:a05:7301:6884:b0:2c6:67b6:3acc with SMTP id 5a478bee46e88-2d4101c7714mr2350396eec.15.1775771730540;
        Thu, 09 Apr 2026 14:55:30 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:7da6:9d9:d70c:7407? ([2620:10d:c090:500::2:f3a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c6b10sm1534859eec.5.2026.04.09.14.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 14:55:30 -0700 (PDT)
Message-ID: <184d880c061c9271e44294a93f7adfa6b39a89e9.camel@gmail.com>
Subject: Re: [PATCH bpf-next 02/14] bpf: save subprogram name in
 bpf_subprog_info
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Date: Thu, 09 Apr 2026 14:55:28 -0700
In-Reply-To: <8579b8a893ff0e0759ceed3be1f0fb12655ade241da3dc0111362c67cfd5b482@mail.kernel.org>
References: <20260408-patch-set-v1-2-1a666e860d42@gmail.com>
	 <8579b8a893ff0e0759ceed3be1f0fb12655ade241da3dc0111362c67cfd5b482@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-09 at 02:14 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0bac5c537fad..e6c048c55899 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>=20
> [ ... ]
>=20
> > @@ -3710,9 +3713,16 @@ static int add_subprog_and_kfunc(struct bpf_veri=
fier_env *env)
> > =C2=A0	 */
> > =C2=A0	subprog[env->subprog_cnt].start =3D insn_cnt;
> >=20
> > +	if (func_info) {
> > +		for (i =3D 0; i < env->subprog_cnt; i++) {
> > +			t =3D btf_type_by_id(btf, func_info[i].type_id);
> > +			subprog[i].name =3D btf_name_by_offset(btf, t->name_off);
> > +		}
> > +	}
>=20
> Could this loop read past the end of the func_info array?
>=20
> The loop iterates env->subprog_cnt times, but func_info was allocated
> with prog->aux->func_info_cnt entries in check_btf_func_early(). The
> validation that these two counts match only happens later in
> check_btf_func():
>=20
> =C2=A0=C2=A0bpf_check()
> =C2=A0=C2=A0=C2=A0=C2=A0check_btf_info_early()  -> sets func_info with fu=
nc_info_cnt entries
> =C2=A0=C2=A0=C2=A0=C2=A0add_subprog_and_kfunc() -> loops subprog_cnt time=
s over func_info[]
> =C2=A0=C2=A0=C2=A0=C2=A0check_btf_func()        -> validates func_info_cn=
t =3D=3D subprog_cnt
>=20
> If a program has more subprograms than func_info entries, func_info[i]
> reads past the kvcalloc'd buffer. A garbage type_id would then go into
> btf_type_by_id(), which can return NULL, and the subsequent
> t->name_off would be a NULL pointer dereference.
>=20
> A bounds check against prog->aux->func_info_cnt, or moving the name
> population after check_btf_func(), would close the window.

valid point, moved ->name population to check_btf_func().

>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/241682=
98083
