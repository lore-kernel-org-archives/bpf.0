Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950F146A61A
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786476294; cv=none; b=uPfX0B5q5dWz6CLa/VidO2vfa/r+79U8AEdItAkjgWGryzQHw/g8nh5ON2h0e/4KD1eSnAbc3ig68Bg4dXvIy7IDzdIHCeKmKmhiqpbAEdpSubriblPlyPhiBGjpSr6cLRyipT8MFRvBCXOO27ZEJUsHVuCYOBK05tmYhw2q1PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786476294; c=relaxed/simple;
	bh=C00IyC7vTIjDZVkpSn5S0y3iZ1J/PYPn0FJUAp2SGhA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mr39lO8CAK9BIfHgJlYKg4dX8jOQC48BXqcacJ6jZT4VTuQaAzqSYrFKETWoiblBenDa0xiDBIEkOikYaEn5KBqJ9n8b12Ko+ELGNDEFmC3bwoZOiCAaH8DIhQu4fvzVDWqDddYCG5s6U/rjFtWVqzJH4VSnqWle1AQABA6QS9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oYm+Hn7X; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYm+Hn7X"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c998fd549a8so113468a12.2
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 12:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786476290; x=1787081090; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=px5wF7h95lt7reW18eclWt5PrhOlRHexv1P1r7EUzr0=;
        b=oYm+Hn7XLGTycMmJcN+O4spnKX9L3Yaru3HH8ctUvuVrjglmNzJD8mF1r3R58Jq5fN
         HkCzhtRVtn0rFA72X3epx/CMtWv1/gUnD9G18AywFiHA7PYBq9Y+pdm78BJ405WTFSIg
         YDaVWIXgch75a/XG0gpFetbW7JELdfhfpHD3RPl3oTooM++NkuS9PwOJfOpEkMo2cU7A
         gDufGiazL3XHZT/8QpBhoLkcmDZ4zP13/Jx9Vc2PVsSxEYY9V0rAVO/B7eWyJqFXvFnB
         MsLGpwTko2KGkoXi08IxezQlgD5T4wmXj3dcqYQVekNPFwIJWVi/h4b6l/eN38fzLPlt
         oZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786476290; x=1787081090;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=px5wF7h95lt7reW18eclWt5PrhOlRHexv1P1r7EUzr0=;
        b=YiI2u3wrGaep4kfA2ErkOFWYwFIlZNaFIn8rKiWRm6VbVra/ke1PsQF0h4m3cc+8bx
         XKM8nt3aC4AY1cmiT9ZEoS5+wpMxJ4Fqfel3o508kSvOqJfbb/c/NSIMgf0QG3skX2gM
         SO54JHGLUdemYbK3b6XArRM9vx4yAqMiojUAKK44xrEue2N5/EuKtRCeRo+IPgWACXoF
         507ZIUOeo4RNstxM8/UZZcnrIi6NHPwrMR/62ZFw2VBG06+L4+1zoRJV9XK+78Q1/jEn
         7Ffsb6Y1N6eIRt9T/gjT43eEg9WBv3zYBVUoGLbBCQ3mzcKL1TxfHJJBYYbnxRsqawA7
         kr7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpd1e0k/tn9gXUDq6VNPvDcbxFa56FYw48aezCrskbcjHjgs/g8jrAUjQYDoB+S9MJ5n28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQzXbx5yI5fkSOZ7ekLAbTPo5hFWWf1jJK2wg2UtWn/2JY2CCq
	Ja5K99BnDtBnNWXB8z5Fe0PzHEow57g2q7wVqOd5DFLisPQApY+UYELK
X-Gm-Gg: AR+sD10t2faqB6UsPgY32b62N1xJFB87oAMyRbP+dOCNF07ZPTe97yhvb+gHZCS65lo
	WgTO4UltGLqZnPQLXQ+OfcJwRthS3lnDr32T/RABVZVCDB34vIVKZ0ggacn4FDcGdZ7c084GEhr
	HDy4eegYVr/IixYmdsO21vFe53xaZ3u1f/Ohdt6TPEiIImWPvnYeKZmzTvVNoQdcHxDHI7ZwEZh
	w85PYpa8C+hAkPJtntldHk9/tahK/pOGVF7Osmeh0v2/WNnL+fMb4MQAH65J2bzRd/Pi0DmMpVe
	WUKTyV7PwP4CC8F224wJAlL58ReRa0sJTuEttg4W82MfDH3Ek4tY0ihbqXz5LVlFokMWXcjuy51
	nWp+XVecalU9p59DmsQnpWaDezNkCodP1VEq8ZhHDMcpjtx5KxNi0gjDAbT4/tcFr8nfrkaA7Hv
	3RC9icJfaQNS7r/gML8tZXjwwa3rdQ/WppC5Vy/1GaEpD7B2oT+3pU0qjIGT1YJ8mh+sbmzmO0a
	6NTnInFd7Cx4vRrJbJ+Ee+hc3l1TLOGj8G0nAkXbqXhnw==
X-Received: by 2002:a05:6a21:e0a6:b0:398:837a:7af0 with SMTP id adf61e73a8af0-3cc2baff1a5mr7928425637.30.1786476289392;
        Tue, 11 Aug 2026 12:24:49 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cd18:dfe8:e39c:4123? ([2620:10d:c090:500::4:f345])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf361d57asm2155916eec.6.2026.08.11.12.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:24:48 -0700 (PDT)
Message-ID: <5da4529bb3a41a612f05b5d2dfc6b50f76ae03a8.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: fix for veristat file/prog
 filters processing
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, martin.lau@kernel.org,
 clm@meta.com, 	ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 12:24:46 -0700
In-Reply-To: <1b98af79fa5ac4a50f74eb67b30fecba06a9990d9483fdead77176412536fda0@mail.kernel.org>
References: <20260811-veristat-filter-fix-v1-1-b5b43c431550@gmail.com>
	 <1b98af79fa5ac4a50f74eb67b30fecba06a9990d9483fdead77176412536fda0@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-11 at 18:41 +0000, bot+bpf-ci@kernel.org wrote:
> > =C2=A0=C2=A0=C2=A0=C2=A0selftests/bpf: fix for veristat file/prog filte=
rs processing
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0At the moment veristat filtering behaves unexpe=
ctedly for the
> > =C2=A0=C2=A0=C2=A0=C2=A0following filter expression:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-f !file/prog
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0The expression rejects all programs with name '=
prog', and all programs
> > =C2=A0=C2=A0=C2=A0=C2=A0in a file with name 'file'. This commit fixes t=
he expression to
> > =C2=A0=C2=A0=C2=A0=C2=A0exclude only a program 'prog' from a file 'file=
'. Additionally,
> > =C2=A0=C2=A0=C2=A0=C2=A0the commit makes empty filters like '-f ""' or =
'-f "/"' and error.
> > =C2=A0=C2=A0=C2=A0=C2=A0Here is the filtering behaviour compared old ve=
rsus new:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0| filter   | file | prog | old verdict | new ve=
rdict |
> > =C2=A0=C2=A0=C2=A0=C2=A0|----------+------+------+-------------+-------=
------|
> > =C2=A0=C2=A0=C2=A0=C2=A0| !foo     | foo  | bar  | skipped     | skippe=
d     |
> > =C2=A0=C2=A0=C2=A0=C2=A0| !foo     | bar  | foo  | skipped     | skippe=
d     |
> > =C2=A0=C2=A0=C2=A0=C2=A0| !foo/bar | foo  | bar  | skipped     | skippe=
d     |
> > =C2=A0=C2=A0=C2=A0=C2=A0| !foo/bar | foo  | buz  | skipped     | proces=
sed   | (!)
> > =C2=A0=C2=A0=C2=A0=C2=A0| !foo/bar | bar  | bar  | skipped     | proces=
sed   | (!)
> > =C2=A0=C2=A0=C2=A0=C2=A0| !foo/    | foo  | bar  | skipped     | skippe=
d     |
> > =C2=A0=C2=A0=C2=A0=C2=A0| !foo/    | bar  | bar  | processed   | proces=
sed   |
> > =C2=A0=C2=A0=C2=A0=C2=A0| !/bar    | foo  | bar  | skipped     | skippe=
d     |
> > =C2=A0=C2=A0=C2=A0=C2=A0| !/bar    | foo  | foo  | processed   | proces=
sed   |
> > =C2=A0=C2=A0=C2=A0=C2=A0| !/       | foo  | bar  | processed   | error =
      | (!)
> > =C2=A0=C2=A0=C2=A0=C2=A0| !        | foo  | bar  | processed   | error =
      | (!)
> > =C2=A0=C2=A0=C2=A0=C2=A0|----------+------+------+-------------+-------=
------|
> > =C2=A0=C2=A0=C2=A0=C2=A0| foo      | foo  | bar  | processed   | proces=
sed   |
> > =C2=A0=C2=A0=C2=A0=C2=A0| foo      | bar  | foo  | processed   | proces=
sed   |
> > =C2=A0=C2=A0=C2=A0=C2=A0| foo/bar  | foo  | bar  | processed   | proces=
sed   |
> > =C2=A0=C2=A0=C2=A0=C2=A0| foo/bar  | foo  | buz  | skipped     | skippe=
d     |
> > =C2=A0=C2=A0=C2=A0=C2=A0| foo/bar  | bar  | bar  | skipped     | skippe=
d     |
> > =C2=A0=C2=A0=C2=A0=C2=A0| foo/     | foo  | bar  | processed   | proces=
sed   |
> > =C2=A0=C2=A0=C2=A0=C2=A0| foo/     | bar  | bar  | skipped     | skippe=
d     |
> > =C2=A0=C2=A0=C2=A0=C2=A0| /bar     | foo  | bar  | processed   | proces=
sed   |
> > =C2=A0=C2=A0=C2=A0=C2=A0| /bar     | foo  | foo  | skipped     | skippe=
d     |
> > =C2=A0=C2=A0=C2=A0=C2=A0| /        | foo  | bar  | processed   | error =
      | (!)
> > =C2=A0=C2=A0=C2=A0=C2=A0|          | foo  | bar  | skipped     | error =
      | (!)
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Eduard Zingerman <eddyz87@gmail.=
com>
>=20
> This looks like a bug fix for existing tooling. The changelog table marks
> four behavior rows with '(!)', showing the OR-matching bug being fixed an=
d
> empty filters now being rejected. Should this include a Fixes: tag?
>=20
> The broken semantics - deny filter matching on file OR prog independently=
,
> and empty filters being silently accepted - were introduced when the sepa=
rate
> should_process_file() and should_process_prog() helpers were merged into
> should_process_file_prog():
>=20
> =C2=A0=C2=A0Fixes: 10b1b3f3e56a ("selftests/bpf: consolidate and improve =
file/prog filtering in veristat")
>=20

Yeah, fixes tag should be added.
