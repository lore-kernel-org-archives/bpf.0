Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DEF399023
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465658; cv=none; b=BR7XNm+YXzvL9G4jqr0NoBfm8796XABUiwbJQDOyiaZx1+agVYJnpaAomn2KsLM2X3cyk5MeRdG7Qrz8XWIQzG1Xvy7Edgc6fIK9+y5q7pTPac0qITHmBdOdso49LmuXm+BmeTfr/y+TbGTVjMIbk8x6pme9+4k6bplQ8GuYhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465658; c=relaxed/simple;
	bh=DkC1ReThD/WC953Vv3M9qm3hb1lN61rlvSH37UNsWZg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mhVhosOu4Q7WhKPE9co5Ho704531H6s7IkgVbF33kJlpA7Kv28FEtsvYIOF93RvGfrX+0zNlQGLkV7JRomASjj6WjP0vLEITxqeMYfS5PhfTHEQ1KWVCsS/J0twSCYpLaSmuLQLqr87YOfIwPBDkIxgaMm26yH8P6Zcx4X5RYAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOht4MRl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOht4MRl"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483487335c2so122756115e9.2
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 05:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777465656; x=1778070456; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DkC1ReThD/WC953Vv3M9qm3hb1lN61rlvSH37UNsWZg=;
        b=nOht4MRli/pSy3yOr37uF++bTQAUe2JxA0eyiwCKjQE7cjb9flsYtexPKZK7YNlnhH
         7zKnFk4YAJyZ28MRaK9w2HvMQX/ugK4olAzKI4tOokR0u7RWEPDpMGul+SIRuO333Ejl
         IJE7+55ac2sROn3zY+oGiiFksAX32bD9YLKY/jETPrQOajx4cZYrljUxlZHlY8jyeXUw
         85MnMhgQWYI30FyZAJFXybloFUgTSiqyBd22yL1jlsKLHmYenIq4rZ5iswSYti+k5W5C
         rsQxR+XRqgVitXTjlijgynKsSofsyhONv26l5Juj9/abr/q4ZOZOyjxDzDAVUXmrxBky
         P6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777465656; x=1778070456;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DkC1ReThD/WC953Vv3M9qm3hb1lN61rlvSH37UNsWZg=;
        b=tFklR9SChSoyh8rEbeiDbY2m4gZ4pP8H+xFssQ05jcIX2baZ/0Ef9Wh2+Oh+UA0avw
         G8ocq4bOuKN2nWvewI2rnXuCI/KMFZsblna4psPaQoPA8yUs2uhpZD9z4xQmI0MdqblX
         QfzwKrxCtEHkFeMjjq8e+qSX8XyfNv2+w+Ldl4OdbZO3J3Zo+s6mPcDVN9ssb2axfX2/
         tZczpQX9JstwjJ+pMH0tOKWs1RG+paK9PBsV1LWMklmhCmuSdiJU7PJhshNY8IUXsyOw
         3YlT1WxP5TvxqB/xcirsrgo2fvr3V5QC67Cs/abaLrcDQ3H+hcFeVDbrdjq0m7f/8XUg
         +iCA==
X-Forwarded-Encrypted: i=1; AFNElJ/d5MD/EJZiaaKkXbpBOJYcOraxJcyAijECbxUybD4U/OGD5FQLsY14cOdr17YfLZMX0ho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw22X8iIztxRI57I4vyz2O7eWcWIzpqMDJAL1XnzSosft2W/Cjc
	rNAkLKanFFucuz/M93jch0Z4aWcX96LE1GmS14VV2Oo1doAn3jUprdRo
X-Gm-Gg: AeBDiesXfhM0JVY//VbH3nhxyQ8q8rh6my0m1cilTT0NYlQ+d5tf0iEPLpB80nuC851
	+IKcHUAvHH9iJaoE0ExbeYY9tFnNDai8Tox1w/hVZHMyBDlJuLFJtgUENalvvukW3RoBFNkQRFT
	7my6REHpsLRff2EhpIggUzJiinnR1IM9dQFp/RneNF3oxurzzS9f7FOMSvddQM020+G+JDvFk5p
	/SJOGyml6wBRRTWlozmKlOfrueQ691cF24O7RMOgH7UigdZKvUAICz+viMMCpOPa8CIiljKQ6MU
	CV8MUX1kOo0klqCPHzXbtsujI+6BLBEgTv6KXeuD/agM3e4mLdf/8g4UWyVB50Bz+4LyCXk+Yvt
	uDi5Zgfy9H/q5hbuOkLcojtMdsIkD/79mHNWAwNBuU6fuHRMs9rgP5v5Hwr8ElUFz5u6zPKw5hj
	5VzL2/XX+kMKePXfVvSp2+7PkSWblYxFHzE/ZGDbVV9gA0m0qFN2/Ji9JHhjhvHwhk0MCRYcj3p
	UaFQRC/PMtkBOve+2w=
X-Received: by 2002:a05:600c:3d90:b0:488:b239:77ec with SMTP id 5b1f17b1804b1-48a77b1781cmr121924445e9.17.1777465655630;
        Wed, 29 Apr 2026 05:27:35 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:1126:4:da80:667b:e928:cc8c? ([2620:10d:c092:500::7:916f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c5c740fsm46504345e9.12.2026.04.29.05.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:27:35 -0700 (PDT)
Message-ID: <507085b1b3d66874bfbfca531852233bea15123c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 05/18] bpf: Reject stack arguments in non-JITed
 programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,  Martin KaFai Lau
 <martin.lau@kernel.org>, Puranjay Mohan <puranjay@kernel.org>
Date: Wed, 29 Apr 2026 05:27:34 -0700
In-Reply-To: <20260424171459.2036024-1-yonghong.song@linux.dev>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
	 <20260424171459.2036024-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-24 at 10:14 -0700, Yonghong Song wrote:
> The interpreter does not understand the bpf register r11
> (BPF_REG_PARAMS) used for stack arguments. So reject interpreter
> usage if stack arguments are used either in the main program or
> any subprogram.
>=20
> Acked-by: Puranjay Mohan <puranjay@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
