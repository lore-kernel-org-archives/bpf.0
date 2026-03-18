Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937C521FF4D
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 23:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773875256; cv=none; b=jXs5BF05IYcCyy+mSL6s+amaJ0nORnLO9UydmIRUl/Ix8Pf+DPKTDbvKQYKwKeY7XwKvZbjmJf9E4S12/8Z2hZHWllVdlMjswn5SLYal7iJ5H/HOTaL0VbD7qJzegxpMFbr7ouETdl3RuSZ/g6hMK1DCLvFHSfBnu0smK7IPiu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773875256; c=relaxed/simple;
	bh=xs8+wh7C9JOUP7iL9CNqdgAJGDNsvNBzIGV9AODoKzw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iy65v3M1X7HpMc9291PHHOLs41rc5ou/MWSPkvkpDVr/CcITdRgpdQs02mWErHVtpWYfBIn41tU1BAFAgfboD7xlTXJvLiOmlNf5GfeAAunV+bcj3tIMkunnzzl1DJv0V/NeLFgWmcB6vmAOLtai0iUwSCTSNxC6KP9/e6CUsLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zia8kgLm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zia8kgLm"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aecefc7503so477245ad.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 16:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773875255; x=1774480055; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xs8+wh7C9JOUP7iL9CNqdgAJGDNsvNBzIGV9AODoKzw=;
        b=Zia8kgLmmDJuXdVQR6mKAQQ7GsvEqxxhqmZdwGTP97WrEaWhUP3pS5LISEXI8DqEFZ
         NKfutN9ZaOWq5toWlqQbICKpNOLzCxhYyDzq1HWKFoFs7CxAHq4584btML4NyI20zQpB
         2X0TeF4lPHZb9als234Kv+5I0/tD3UxxV+QfHItp4l5ktmnsKYHIAmL5gixE0ER4uFvX
         TAaNdQoukKJH347y12CVA/0n0MN7oTGyBEslrLWbNRB4LPY/zucnTN8crAjePBXhr+/0
         ioNNnKyugQspZw5YiW1JBHiLeRcrEnLTSWETyTunDtCATfH7pb1kJr1m7Hll18TwIoI6
         cm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773875255; x=1774480055;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xs8+wh7C9JOUP7iL9CNqdgAJGDNsvNBzIGV9AODoKzw=;
        b=oBfTJdzjAivxvKn63QZWUKMYvaNkYgpBTZX+p1xbUdAEIzbTloOQ7E+N9zdR2fQ6Oi
         LxBqTFyP1OnrTNiaU1/hdhclejYDr33vlUiQAQrdHo8c50c/erBpQTPdNj1+dOA/HWbe
         TzxAYo2fAMpoFjbfhwEfQLdxwBJ870J18ehmrEmrAa4ct8hjIQobTzh2yp1PxAWftQy8
         nyITlpbUr+a3cCOQdVHnLkGWTWf7XlIuNS8U+N1Auh/SREse+uWrajvqThX8M22SC8ev
         WiNmx9Jr3b4DploTiXwFok3qvgNOzvwu6WU1G/7medpWo0+m8fhWtfxmkx7ejuLehXnQ
         ilmg==
X-Forwarded-Encrypted: i=1; AJvYcCVlZx38vbEC9CBgrE0j9hwQcUlLCH7O8ZHupsX+IUpK9HoZ2MKcvDrqOisGitNQa7SFcGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyOoX7LP5cvI3p+wYBIR+gbf1zqMaiqLdcl7rWfDW90kIkGAhA
	F+04atp003VV+gtTZmCd80PxNfuGPGnuIq7+OQUfyo4g2mLU7XuTelDYI84ZuQ==
X-Gm-Gg: ATEYQzxpQtbAl1qKG+OxDmUYrAcRZIOYFpysPZnHAhsWxG8P5jK+SmLZM0k0NcUL+rR
	ynHerp6PonLCDho1VNo8/ZkOi04tTwM8Cp2PvXJB9pbSzX/lghhmgyb3+nt56r3wwjuD0sc3ORh
	Cqxo42osZVrr+9J0Uorv5qtzTMtw/Sxr0GFXeyqOPw+ReL2eXcjL/1QlPR+lCywx7x1wKxdokJJ
	Aq+v9SLxAlW98VwW93brPukepP9vmBgwcEaWO9c7ufkDyjlo/e3DQadmE+5BY3iZjcz88DIL3b9
	XAck1QkYwnq235eOGxK8dMx+zQlPDLLE58Y/6p6etPlEGWC2j34pkiGhP34fE1Dr5TSNWfsd60t
	ifioUXquSXQhZ36eC5O19yNmvpkqWWE9kyM4n1Wdl/rqe6/vVWWyTuBn71bCyIqhtW1gC894pAw
	gMwcAJyH4I9MpULLb3JoYX7Jr1/H6X8Ec8StbOZfEybpPndtkjyOo=
X-Received: by 2002:a17:902:ef52:b0:2b0:5d17:6df with SMTP id d9443c01a7336-2b06e43d2e2mr44497825ad.51.1773875254867;
        Wed, 18 Mar 2026 16:07:34 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e5ef5a0sm47258885ad.44.2026.03.18.16.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 16:07:34 -0700 (PDT)
Message-ID: <b073da2be883cf8f22a9a4c5f2dfa112d75d68f9.camel@gmail.com>
Subject: Re: [PATCH] selftests/bpf: Enforce definition order for __msg
 macros in BPF tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: David Faust <david.faust@oracle.com>, Jose Marchesi
	 <jose.marchesi@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>
Date: Wed, 18 Mar 2026 16:07:32 -0700
In-Reply-To: <20260305130035.192080-1-cupertino.miranda@oracle.com>
References: <20260305130035.192080-1-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-05 at 13:00 +0000, Cupertino Miranda wrote:
> Ensure that __msg macros, and similars, used for BPF test validation are
> processed in the order they are defined in the source code.
>=20
> Neither GCC nor the C standard defines the order in which function
> attributes are consumed. While Clang tends to preserve definition order,
> GCC may process them out of sequence. This inconsistency causes BPF
> tests with multiple __msg entries to fail when compiled with GCC.
>=20
> This patch fixes the test runner to explicitly sort or process these
> attributes to guarantee predictable matching behavior across different
> compilers.
>=20
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: David Faust=C2=A0 <david.faust@oracle.com>
> Cc: Jose Marchesi=C2=A0 <jose.marchesi@oracle.com>
> Cc: Elena Zannoni=C2=A0 <elena.zannoni@oracle.com>
> ---

Looks like this patch fell through the cracks.

It looks a bit intrusive, given the amount of places index has to be
passed through. An alternative would be to modify parse_test_spec()
such that it collects decl tag ids into the array first and then sorts
the array. It will have to use strverscmp() for comparator, though.
This way all the changes would be localized to a single function
collecting the array.

Up to you if that is worth the hassle.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
