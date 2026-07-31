Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F5E30DEB2
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785532359; cv=none; b=sTxygjyLvfPYuVvhiW6AyVKEPvF7vhSBKYcVVaseDUrbP6VnrJfK2VyfKbFFXMvQmY1LWgxisYXR3ulXRlVWzM9GsXa9DmFNSE4NO/Jyu4diEqjPQ3sKc1oiIrowA60ez/PRrnlDyhsYA6GL8cBxplAukdymf9qbPJSn8b6O1u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785532359; c=relaxed/simple;
	bh=EUwHIc+JG9I6HsDBJpYtA1OhGnWWoSb9fOlSwGlbsn8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gC6Eqbm9zi2NkQVczlkiRCQTgBcEzIwBJnOTFjenKNHq2wxvQFeRUdmGcTFvsUsGHMJt5BNK+3Ynv18MdN0lvmbi4IXMe7E019wrY8Wv8gSoYAlT/TwB9jJPq55gL4jKcdr+MIGDnxBRoYkPAeSjAL+ZV1l44n3ACDM/Dup8r2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJeru8YD; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJeru8YD"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8484f229529so1344410b3a.2
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 14:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785532358; x=1786137158; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aciLVwAiUKCH26kaGVrG54sFRgWeqkY7VDriTaiQmms=;
        b=XJeru8YDcSjfEAi15n1+zsD6cGqIup7F9/g8UQgeObPMnxEK1z6gFjnfyT+NDL5lQQ
         shjdHzO3giti4ayIrahVsWKdewOXsbvEmdbNOXGA2vPbhH1TUeHtbY4NTVbSJjqfQxnE
         uzwEwrzA140NqJG5AvCWh/WPCKeczoLWLgfxHavtoSkvn1Ij444gdxbPSdH0+K3d1+RU
         zQKj43CrGCwa/eVWW1vd0lY8aYJ2OZ5cdxJF6Xhuw2FYQYKENu/v4B+G1ovihDCpvmic
         s2dcVkP/s7pGHHkSQ745F3nfRTLh6HSdlBoYQzuPmG5jYCPw+c/mSFp6XQKIHUt/s99i
         bFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785532358; x=1786137158;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aciLVwAiUKCH26kaGVrG54sFRgWeqkY7VDriTaiQmms=;
        b=JB7GdDcgQr8wcCa0pBrelNHRh2MFs+fdudcZM1utwhtry68AiMbLUWaJ3AShGNRaie
         Tch00x1jei2CB4iLsXtDsjNbQjURriU5R+eSxSMD8VsbWoiGjQMtke39ZpyCK9uAW/+B
         VExhWEsEntWFFaDShxX0BfJOCdtUMLnLOvln90SBwA+aFYPVKEr0wo5Ms1hOS7bUfFuZ
         aJlJvS52YeX4CHDaV6tn2PV50ulBGsrlFLAzxwKER8Aga5b28a0xuDJbhRw3pTzFk+GF
         dzH4AJ7nmYH8oVsUmXm8syCjKPFzzEqLBd4lR1rlwCjWTI1GAXz07/8K0KhLmiaBWUtp
         eKOg==
X-Forwarded-Encrypted: i=1; AHgh+RoksUWw52eWL5WAv2wE/oRmQ519JJuumjKTVouM8nJu4Y/TmiuWMFTDqve5jQX/p2/zQ+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxceBEl1At23ndcLNtPi0R3Tk2TgviSpDtCnU9iaZK159I9X7Un
	iob4Mzgt5ONwkrFgUEpC5EyXVHiwEHLTIaV7DBbz2yE90+gvgm2HGPyD
X-Gm-Gg: AR+sD10yHX479XR9lRRAa2+iaXcrhRKCTT92OT6lZ6v9IOTrLavbSqDNmMAh97gm+LM
	UA+WSfQ5GmVaxfRRfYxE+5MUzgu5mwePgQcSGy3gNi0BcBlsNB6KwvbDWRkcpfJcx1AHWG6gXfb
	q2ydpTfhirTbF3sK/RSUM8qBJw3AO8PGWWveLQGNPHROL5Zpr9Nk7JlNItEiuZYk/mSqhp3hVBU
	uQ5vhxQ7LUkVjhXNACrK3iPBr2UorqqVXYhTcr2yclHW9DDZKoEDdvkatpTOduMg37XwNxKGGgE
	EpbukkF79YYbr/Bc3w74SFd/qODGIhTrky1Isk2oXkvqzrhNlwSR3aXeL+5+4ui6KTHzT7Qpx1x
	VqJCvPThAcaTfetf/kNAizSl6/tupJzcpIw/Xr0W5l067jTNhb7Ahkyw+HoFc6R1c4dUjtmEhs7
	O/NE9lSH0NBREPnQZmuxGKAasCx5Nwh1auwqUADxg0ojAl2CZqxPPi+QGEMHJ+C9l3zCiER5HRT
	E+bnaIhjM6YrA5z7hXdnmJyeWEs157z3/miO7GsaYVMD0xDu6/UYVCG
X-Received: by 2002:a05:6a21:e598:b0:3c0:9c1a:894d with SMTP id adf61e73a8af0-3c92a95303emr1139932637.69.1785532357579;
        Fri, 31 Jul 2026 14:12:37 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:f5a6:d314:fc37:ae46? ([2620:10d:c090:500::5:7346])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06f88fsm8744463eec.20.2026.07.31.14.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 14:12:37 -0700 (PDT)
Message-ID: <de102548a6b9fda9e5cc9b6277e536966098fc32.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: do not print a newline after
 disassembly in bpf_verbose_insn()
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, iii@linux.ibm.com,
 gimm78064@gmail.com, 	qmo@kernel.org, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
Date: Fri, 31 Jul 2026 14:12:34 -0700
In-Reply-To: <00c332237fb39899a63235c07cc1d51ab4df2bb5213a6ba93dd186250ccc54df@mail.kernel.org>
References: <20260731-static-zext-v1-1-98a4dc73e94b@gmail.com>
	 <00c332237fb39899a63235c07cc1d51ab4df2bb5213a6ba93dd186250ccc54df@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-31 at 20:24 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlat=
ed_dumper.c
> > index 5e7cb8b36fef2..7b33d847d800c 100644
> > --- a/tools/bpf/bpftool/xlated_dumper.c
> > +++ b/tools/bpf/bpftool/xlated_dumper.c
>=20
> [ ... ]
>=20
> > @@ -417,6 +412,7 @@ void dump_xlated_for_graph(struct dump_data *dd, vo=
id *buf_start, void *buf_end,
> >=20
> > =C2=A0		printf("%u: ", insn_off);
> > =C2=A0		print_bpf_insn(&cbs, cur, true);
> > +		printf("\\l\\\n");
> >=20
> > =C2=A0		if (opcodes) {
> > =C2=A0			printf("\\ \\ \\ \\ ");
>=20
> This isn't a bug, but now that no disasm.c format string carries a
> newline and dump_xlated_for_graph() emits "\\l\\\n" itself, is the
> '\n' arm of print_insn_for_graph() still reachable?

It is a dead code and it should be removed.

...
