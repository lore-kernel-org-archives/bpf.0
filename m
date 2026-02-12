Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8453A262A6
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770938770; cv=none; b=fte2ab9Q/rzsIpO7/1xUq1Dpujd7PIjIrHOoWfh8tLL82cMAe3P1YPr7WMNd0d64s0nfNRfgJnPC4Dcww4QcwXpBD1zvFJE1Gk8G/8G4y6CAg7uTyZ/k8MskClYiDXnWgo17A4lToZn2Ra6Cd+npBvvonPNfk5NSVmFyTlDA89w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770938770; c=relaxed/simple;
	bh=z8dHSwHwhdOTtyV1Osl7N2pAku1iDM9LNRdtorAttaU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bLYcfgcB+DCgmfJaqCKvnhc5BB1Qt5Is6sAqT9r4kGFQQveCvZOSWZJljBzK8RgZwSJsqVV6QOzwwWBsOWak5wLqKnycKP3E+wPuhUwJo8QgTTT85/SNWJSMUzOkudgi6CO2pIkWkRa3vKM8L+GJULHE13OymSY570CoBCn7/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehq/E01r; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehq/E01r"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-824adf81fa6so166078b3a.3
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 15:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770938769; x=1771543569; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z8dHSwHwhdOTtyV1Osl7N2pAku1iDM9LNRdtorAttaU=;
        b=ehq/E01r2+OxGim/vuHFXz/dcgSry5M8+lLYNBFjfzxPoPBI35tK2aihamnm+CdPMf
         CcTxP6mULPJap1adLZa4kF+9qJBfHsJq6xL6l5Qx7YVEQKZd/Qs3vHkcNHX1SbP4H9lH
         q/Je7Hf2vOBNbJnvbHp2ortsy8h/FMQtXyKYeMxXNa2QCNfOs+CnWMPdZicrcVt+YVba
         9RmU6yLrQBD6aBun6s2ApVu4S6upfr+nqYw2RuVBCWYRxy/pNR0/EEHKelr9oZO2yeGZ
         Cdms94iFO9A71AG80akilAIsSl+ZO9UFZ5L4QrXEAwqSQ0ACTRVSCBETXVqA+chLsvCS
         JRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770938769; x=1771543569;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8dHSwHwhdOTtyV1Osl7N2pAku1iDM9LNRdtorAttaU=;
        b=tJ0naGznSrbB140dMzZoys9NEpcIpAJTH2eNhmyjGVlyfXGV8ijaQR3PnbSflwKDJA
         kDU56ng+DK7gvlgqUQORI+ky5g3qPkX1dukX9dDTAdr19oHg9nzyWaMFgLfymP5WTApo
         NAlHwvyOyTTeMY893Hslj8S4nzxpU+0Vf+relphhgZ9SbcYumtf36RlvT5LEpTzz6hXh
         OSu1ZO2Fnj3qrUBoNlmKZBhU2mnXYkN6rxbH9VnmC0wCXgTEEVrqS8pONRUea0u9kEBS
         DPt47EpjNovgt+0dVKfhmmdf2FhTaLf3T48Tc3JZ9THBKJHC6WWI5QVWW+gQrA6Bl6Nt
         W1ng==
X-Forwarded-Encrypted: i=1; AJvYcCVSRqxjdrhdzgcV6yALnKAcTOOWT2PffJXbWYrubSeM8khLIQcrjUTpeM3I/JQQ8lndrao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhPCrfLWjMZuQC4gI6CQmG+3GhMWU3nOrHNH18snrO5S6C/3md
	af4UnchnbaaoAilv0w+kdoZ3KICVegeOF0PTcwenKaV57Fq3GJkowaVl
X-Gm-Gg: AZuq6aIP5lwow/kpBJk4yP240Crsjiwv/smFGXvIVbiSx0Ee9rM6dXCEzPlZMZZGhaX
	3tzDqERhjDguKrVJbpjp7F0LR2M8OQecypwd527Kt3b9fxShRHq5CGmcuqPvWnL7RSFfdylN+vj
	9PopTeujibH6AR+pTzJl3Zo8/t7uQb7spnWKi7eJcdPaSqqck5+GLD1KFZF20Q5O2jjNgxcU/vY
	Na4PKIAQ88Ys/yEMw3cuHhPRU8sdhYHlb62JVedtIbMXXrvfLofYs21EpA8x9+j9BKJVGsiR9hp
	yzTWoAbmwP3UH3fc5kex5JyBhGt1mDZD4O/k6G/sJ/nr7ylK1FiwIO90N48GUOpDWu0iBCUIT3Y
	C5TgUHqMd0Va0b2/j/d/A21mXkcbn9KLuJQM52IlETCxgXyO5rkP5jYVYLuR0ieA99LyMExCbjH
	/MeymyxcWxUnojOF5hDPRsl52o+klScguB6cX7CfCBjLSlrjQFP6s=
X-Received: by 2002:a05:6a00:855:b0:81f:8084:7ea0 with SMTP id d2e1a72fcca58-824c9458dd1mr83234b3a.7.1770938768866;
        Thu, 12 Feb 2026 15:26:08 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b94562sm327968b3a.54.2026.02.12.15.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 15:26:08 -0800 (PST)
Message-ID: <4150f31f020710932def63e2857ebab1e311b597.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 00/14] selftests/bpf: Fixes for userspace
 ASAN
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
 Alexis =?ISO-8859-1?Q?Lothor=E9?=	 <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com
Date: Thu, 12 Feb 2026 15:26:05 -0800
In-Reply-To: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-11 at 17:13 -0800, Ihor Solodrai wrote:
> This series includes various fixes aiming to enable test_progs run
> with userspace address sanitizer on BPF CI.
>=20
> The first patch fixes the selftests/bpf/test_progs build with:
>=20
> =C2=A0=C2=A0=C2=A0 SAN_CFLAGS=3D"-fsanitize=3Daddress -fno-omit-frame-poi=
nter"
>=20
> The subsequent patches fix bugs reported by the address sanitizer on
> attempt to run the tests.
>=20
> The series is a pre-requisite for enabling "test_progs with ASAN"
> workflow on BPF CI.

Also, do we want to have ASAN enabled by default?
If it would be enabled for CI, people will need to deal with local
configuration anyway. It might make sense to put the default flags in
to save everyone the trouble of figuring out which flags CI uses.
Wdyt?

[...]
