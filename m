Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49BA350A3B
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887595; cv=none; b=LrPPmj171WBU1xbEH0PQ5Gg7miix9UT7RsJ3GgPkPibC2+Mg1eCWy4q3E7JoqIR0CZDQEIcZ3xgsOQF8o4Ok1apEvfgFCHLS20RWlobjBUgG4Y1ui0BBECWNSKHWL3MoVNWBmBnQ6ipAGniUMZWr9WBfvelVIw7iiHDRC1vPGlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887595; c=relaxed/simple;
	bh=y9ewuAaX7+LNO+0yIUwc2jUAjjYW+36dCa5yIenvtWA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DlD5KFd6QgT8rmgbxLN6zhFto6OZKBiEP0WmkRdFri+ZPnT8y4XBg8KX3wSy2TI2XABKOTBPYIM+Elo7aiNwbi38owpbgqHVgB50eNxQxZjsgmIzV4Bh80Uk9z0pGFRHPixq4Hbrnl4oRwh3hVg+c5miERqT3QO87I9IYMadU7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaEXDG8s; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaEXDG8s"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ba68df3687so1073794eec.1
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771887594; x=1772492394; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=duQdP+i7kPjYsfT9Kmpa5WVgHvBVP5FrMeOU8FXpE/0=;
        b=CaEXDG8sb3yvz3WIgeBxe/+Ox4a0Son0XBWtKWdNeY/5AcRxim6Fpc/rK/ZHWIXaSt
         pY5Jj9DQStqFgu4z4GA34GXmYNn9qAhi5Ay6Ki3GCYN9lq4RunskyrbA3UQ4lNTbmrSR
         quz+Sl30V+arUc6b5DgFrbZiu1Zf7wtVJvqBsKs8WLbmOMrAXx/NyMiXHby8uMELcRxS
         arPS99+RUg/wThs2YM1GSbkwUzrQeueUIA2emcqiHD4Mxwdo75m59AdkROorTrCgY8sj
         vOhPboD2WK2tMsW6DvBKoNySkQDjn4nmC+MUQ7icgwX6lnDKeiRIx/3302Tq0jw7GeWo
         0+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771887594; x=1772492394;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=duQdP+i7kPjYsfT9Kmpa5WVgHvBVP5FrMeOU8FXpE/0=;
        b=detwQQoKYsi6rm83xlQm4P12NbvpCu0eGgL9ulyPkJ3dxr7xebFYiZlT6wRE1TJ7GZ
         iXhRHizHwlaHdsW7wJT/kgafABSYTx9pHLU9CF2Zl5k3+8gwOpXLI0DnnyxZb7iMtzbU
         5/0gKQ29aLMuUZDM0mch2FyKDrd7ckOoCqQTURPcFR8M+6jn2RFx90JhJK7ClWgaTkxi
         017yKPSN941IXkp0vDcWxNupMfFeh8p+BxemejteLGNVyXc8LGWQakl3TMcP5zjABxEk
         mCmob5My1fjlWXliLzPe5Vf24GXtO1aQhq1qMHxeb81Sz/vORcBGLqL6Lm5Elqc8SOiq
         rf3A==
X-Forwarded-Encrypted: i=1; AJvYcCUOpHxzOU3miX74g5EHOXidPFexwDdDV7S936BYKh6hfXkr4TcNlmCvNNOhZy1BqZ6Yw5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5E3mRGBuCZJjKLGFDD4RfRsqb9s5sDE7XMoYR95ExwmR/3qqI
	ktBfDfA8XDoDs8DdOcfHKc8l/DTqaC0l4tBxNAcPrqQj99bOtp7+Tys1
X-Gm-Gg: ATEYQzwM5FeEf5CNb6nvqSfGEy/0xPaocWenX/DJNgaYJGyZQmbx3sdTGCR6pXI1TcC
	F8jL99qEFZ9gmfzuwuj9bFa6Erz/1q236JRs5SxsQPDAcE5T1cgY82xq5F07Bk1+41m7sxAU9yT
	bnMGYbGePBj1CzHHpMkop7qKeVxYapAt0DT9Os6y2BBo6bM06mKumZ9Sczvymb7eYWGkZmnHO1g
	17zTrm8HP1I2dQ33sfmP/mYMb03xHUKMyk9bmOFLZziPTYp5o6AmkjcQCaa4LQdCwaM1cj2I8Hu
	5pO8cqI5ZWL1CNQTGT21dpgQuXggKkXP4FxXxpkIuN4o68OblCBjDsbGk00K+F24Bi6+nV9O2l+
	8fi6cphbZQhTg3W1PweuvSnOpdilBrh6QlHYU6PeVIQGiZ7aOyX2A5nS5rt579aSuSo3/n8NktH
	E/OXdwqcy6dHFKhxtNMgnaL0cJp85Jd8XmRnbVaHH5IekivvI+l1I096HsBsQ9y8RuinsvgW9Ru
	+jGLUgA
X-Received: by 2002:a05:693c:310a:b0:2ba:8018:cc53 with SMTP id 5a478bee46e88-2bd7bda5986mr4203910eec.35.1771887593730;
        Mon, 23 Feb 2026 14:59:53 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:7bec:d612:85a2:37de? ([2620:10d:c090:500::1:3a66])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dbe8198sm5660640eec.22.2026.02.23.14.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:59:53 -0800 (PST)
Message-ID: <ac8015fad8ad465fa0c06ba2ce476d6d9fe8e0ab.camel@gmail.com>
Subject: Re: [PATCH bpf v4 03/20] selftests/bpf: Replace strncpy() with
 strscpy()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jiri Olsa <olsajiri@gmail.com>,  Mykyta Yatsenko
 <yatsenko@meta.com>, Alexis =?ISO-8859-1?Q?Lothor=E9?=
 <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Date: Mon, 23 Feb 2026 14:59:51 -0800
In-Reply-To: <b76aa450-e3fc-4002-ba3f-c73c11c1ec84@linux.dev>
References: <20260223190736.649171-1-ihor.solodrai@linux.dev>
	 <20260223190736.649171-4-ihor.solodrai@linux.dev>
	 <8249f1439fa9ee4a1227da3f0707a9d0cfbad825.camel@gmail.com>
	 <b76aa450-e3fc-4002-ba3f-c73c11c1ec84@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-23 at 14:32 -0800, Ihor Solodrai wrote:
> On 2/23/26 2:28 PM, Eduard Zingerman wrote:
> > On Mon, 2026-02-23 at 11:07 -0800, Ihor Solodrai wrote:
> >=20
> > [...]
> >=20
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/t=
esting/selftests/bpf/prog_tests/align.c
> > > index 24c509ce4e5b..841a166b8081 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/align.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/align.c
> > > @@ -633,7 +633,7 @@ static int do_test_single(struct bpf_align_test *=
test)
> > >  	} else {
> > >  		ret =3D 0;
> > >  		/* We make a local copy so that we can strtok() it */
> > > -		strncpy(bpf_vlog_copy, bpf_vlog, sizeof(bpf_vlog_copy));
> > > +		strscpy(bpf_vlog_copy, bpf_vlog);
> > >  		start =3D strstr(bpf_vlog_copy, main_pass_start);
> > >  		if (!start) {
> > >  			ret =3D 1;
> >=20
> > This hunk no longer applies.
>=20
>=20
> Hmm... Applies for me. What revision did you try?
>=20
> $ git log -1 --oneline=20
> 6de23f81a5e0 (HEAD, tag: v7.0-rc1, origin/bpf) Linux 7.0-rc1
>=20
> $ b4 shazam 20260223190736.649171-1-ihor.solodrai@linux.dev
> Grabbing thread from lore.kernel.org/all/20260223190736.649171-1-ihor.sol=
odrai@linux.dev/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 22 messages in the thread
> Looking for additional code-review trailers on lore.kernel.org
> Analyzing 103 code-review messages
> Checking attestation on all messages, may take a moment...
> ---

Uh-oh, it is for 'bpf' tree. I applied to 'bpf-next', sorry for the noise.

[...]
