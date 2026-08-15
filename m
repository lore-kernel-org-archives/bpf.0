Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055FE319601
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786816222; cv=none; b=L6510asK7TRBE7Dy+1WGf54UtImNo3NlNF5d+tJ1f0lsxXIdbpYS/Hmez1oBzGZOGzYatFtL6l0ajmkrG+tvX5OU/RSruS/CWmjFLmk54P5leFLvng2+z3lwVZfRJvymIAB4axuCXsuRVOMKrTMRTYTs1TGC7zwRPNQSaY0DPCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786816222; c=relaxed/simple;
	bh=ok9PA+nGFxjh2uFeoKZgMKp0sTRjZtr7YxZcORHvFJc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gQC9HQJVB1y57GNnBwMKi6JBr5gu0MYXieMcE+612v6vhfiC6beM5+Q/xRaHwraiAnNehVeO02BkXF2Qx6cv6jOYUpGQgLAYQJRtjMSb/i2qYGUyU7hGycXnK6Ivv9pNYqg+XK4iFBvIj3i2ber+kZ9za1BgK65v9B/xqE/T2Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWXWIFul; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWXWIFul"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8518b3ff3e9so525450b3a.2
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 10:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786816220; x=1787421020; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lmSSdNqKXTDrx2uBY4sY/OXEcIWBPM2lgJ51UmvgJY0=;
        b=EWXWIFulsk8CuDuf1FMcDcNGTSw0dv0j9Hf9UK4IE+FtS9piwu/EI+LzbOljpH7ud7
         3Ej7LUOC7LxwYucTCCvbEk0J7koUoqGWOjxeyImRztlb5efDiSAEa2mVPN8MXN3lUpt6
         9I7/r1WHKFx2wsT/bA1ayfFXdq9lRUsrWh0pKo6ZTvKYj0zXancmzntjSmRWQ46gGNFX
         hGUb0qoGwkOap9LrEQw+8iYBeRnIf86DU5csDbMhpPzETiFHN3O0jSrUzmUz+mXdRtoA
         7KkXbhQDy32N4NxTOxnC4mTNNYCE8lVgh782tLy4e+61wGpVmt5Uif0nG/3d8UEDQB1z
         d5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786816220; x=1787421020;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lmSSdNqKXTDrx2uBY4sY/OXEcIWBPM2lgJ51UmvgJY0=;
        b=rciLtiMBeDSzqBRuGPU45HHgUEojRkrr+lRUbPoFbJVir6NC3LGK0L5bLE4rrLjbWw
         2wpufvNwjgPA8B0Dsx2mihjmi84bEz0nxy2jNc/Q7MvOsWeOuUTVUgDggQuTsI5GcD0w
         FZLnHu1TBZmLvTchAYYWZPysYgUFdxZ4OV9nd3Up8sCfZXXcviDRaldBoxlnjr++z7jJ
         /jqD+5kxZiratjtZvNLYeKu28+aPbzin6vQc0EarwkjwBUPsB/CT2XYKu82hqmspVP38
         u2Z1vSMo5bUm353iFj4PrtlonnqfhyegQJr1ioioJOLEjtgdwFa0t9CJxsh3LdJdIAaF
         HTiQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDONl3tXXUTB8nIBuxEEV3EgOM3q75VkMCEKZ8A05J3BWuqQBVqkINx/rey+qMF5zCzUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybdIzyxi7MqSjO5LXOQPyuj+qlYqy47m9nGUGQpYci412aoH5O
	hEClpj1shX9vthQUODNhC7QVR1Juo2CNaXb19LiydLh3nnMrT5Fy7og+
X-Gm-Gg: AR+sD11ZK3i+BguUNw5IfaBsq+0AB1pSqgl2m+whrhswNjrYe7UIh3245Y17MhC+HD8
	/4tIJuaRjJ7I6jxqJRweFycfMlIun2HWtK/clgAOHPw4Uc5S37XWpLPOW0ZEv4apk5aZcPjCJ4n
	KS2/Hqo/XnqdY3Tgesip1zgy1x6zKlFGxRVH6tVSussQkpQWmvJpAPDGSxSNPzfi4bnvpo+aPKm
	HTv1xIQvFZv06uRqXVAX9DX3vxJH2EMO6ogozPPHgiwrD/zONfMI5kHN3QJvyK5G3wzpWikJPFe
	1QRIdhX1+4oFcOGba63HezGy1vC7QtObODfIFIMaS2Ppp8kBvNtGK5z+Pby/iAJ85iR5s0+nbhW
	0ZxWX8HjDJ1Cuc9162+E3Z7AUtLIq4ECwLBvvjpb6UC7u9udG4d428KmbI3bqn1Tb6BMnebkhpk
	SBOGnkrdgny4K9QYAS7QJc70a7fdIoGE1qfl1tM3NkmEvN4N1tnBcyM+J1YbFzt1ueSfdECEqg/
	Iat2KPfoX3TXa9jU9O/y7jItAe3
X-Received: by 2002:a05:6a00:2907:b0:847:8704:1c54 with SMTP id d2e1a72fcca58-84fde2cb212mr16124186b3a.22.1786816220329;
        Sat, 15 Aug 2026 10:50:20 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d223f8csm1474194b3a.35.2026.08.15.10.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 10:50:19 -0700 (PDT)
Message-ID: <091048db268a5abf69dec923248255723db440d7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 13/14] bpf: Report Program Structure CFG
 errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, memxor@gmail.com, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 emil@etsalapatis.com, 	kkd@meta.com, kernel-team@meta.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, 	clm@meta.com,
 ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 10:50:16 -0700
In-Reply-To: <cf2f420c2b21de440a7dc51b1565c0f06d4b539640ee5c03384e5d77bcfb5686@mail.kernel.org>
References: <20260815064612.378577-14-memxor@gmail.com>
	 <cf2f420c2b21de440a7dc51b1565c0f06d4b539640ee5c03384e5d77bcfb5686@mail.kernel.org>
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

...

> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>=20
> [ ... ]
>=20
> > @@ -3020,6 +3020,12 @@ static int check_subprogs(struct bpf_verifier_en=
v *env)
> > =C2=A0		off =3D i + bpf_jmp_offset(&insn[i]) + 1;
> > =C2=A0		if (off < subprog_start || off >=3D subprog_end) {
> > =C2=A0			verbose(env, "jump out of range from insn %d to %d\n", i, off)=
;
> > +			bpf_diag_program_structure(
> > +				env, i, "jump out of range",
> > +				"Keep branch targets within the same subprogram, or use an explici=
t subprogram call.",
> > +				"Instruction %d jumps to instruction %d, but subprogram %d only co=
ntains instructions %d through %d. "
> > +				"A branch target must stay inside the same subprogram.",
> > +				i, off, cur_subprog, subprog_start, subprog_end - 1);
> > =C2=A0			return -EINVAL;
> > =C2=A0		}
>=20
> Can these two bpf_diag_program_structure() calls in check_subprogs()
> produce the source context that the patch advertises?
>=20
> Looking at the verifier initialization in bpf_check():
>=20
> =C2=A0=C2=A0=C2=A0 ret =3D bpf_prepare_btf_info(env, attr, uattr);
> =C2=A0=C2=A0=C2=A0 ret =3D add_subprogs(env);
> =C2=A0=C2=A0=C2=A0 ret =3D check_subprogs(env);
> =C2=A0=C2=A0=C2=A0 ret =3D bpf_check_btf_info(env, attr, uattr);
>=20
> check_subprogs() runs before bpf_check_btf_info(). Inside
> bpf_check_btf_info(), check_btf_line() sets prog->aux->linfo and
> prog->aux->nr_linfo. Before that, both are zero.
>=20
> In bpf_diag_source():
>=20
> =C2=A0=C2=A0=C2=A0 linfo =3D bpf_find_linfo(env->prog, insn_idx);
> =C2=A0=C2=A0=C2=A0 if (btf && linfo)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_get_linfo_source(btf, linf=
o, &src);
> =C2=A0=C2=A0=C2=A0 if (!src.file || !*src.file || !src.line || !*src.line=
) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 diag_write(env, "=C2=A0 insn %=
u\n", insn_idx);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_restore;
> =C2=A0=C2=A0=C2=A0 }
>=20
> bpf_find_linfo() needs nr_linfo to be nonzero. Since check_subprogs()
> runs before check_btf_line(), nr_linfo is still zero, so bpf_find_linfo()
> returns NULL and bpf_diag_source() takes the degraded branch: bare
> "insn %u" plus an instruction dump, with no source file:line:col and no
> subprogram name.
>=20
> The other 8 new report sites in this patch (push_insn, create_jt,
> jt_from_subprog, visit_gotox_insn, bpf_check_cfg, sort_subprogs_topo)
> all run after bpf_check_btf_info(), so they do get source context.
>=20
> Should these two reports move to a later point where line info is
> available, or should the commit message acknowledge that source context
> isn't available yet for these early checks?

This would be nice to have but requires some ordering rework,
bpf_check_btf_info() requires subprog_info[] to be filled.

Other two flagged items are non-issues.
