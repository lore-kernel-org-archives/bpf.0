Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04A3F9E8
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778457756; cv=pass; b=slOExAjb91auYxuakNLqZscctFcuPiA+b3BTwvyLDU40dWMWz7xkYps6o2DU9oGTnsL7YkkDne01TPAxl6o94Azp3DvUSHEiTxhrlGNdb65B8arLHm3nTKTdoiubsdzLq7GcGdI9NwIqCoaCdW/ykhKAzZTaaCNh867kcJlFlvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778457756; c=relaxed/simple;
	bh=lCNRQr0NhFXKY/gNVPTEx/eS9wXBEjrxYSbYRfQAtuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCeA2pWbNglywtwCJSwKB0F8n9u93U7VwrwXNvC8aAjtrgs5Y1H8FzkynmTHahgajrYqfzvw0nR2V1RoeN59ibcq9nzpF0YaxfSDMZs2nhjh2KauOUHp9WwZagf/i3XmEmlYosIvRFTzh+IjhT3Dcx0ErMkPw6ZQ/XsnbZ1WCVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPMdA336; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPMdA336"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7c23248f3a3so5786947b3.1
        for <bpf@vger.kernel.org>; Sun, 10 May 2026 17:02:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778457754; cv=none;
        d=google.com; s=arc-20240605;
        b=BqoXgghVSSiHqLyfv17tLTJxfSzCbDjkVPy96N30w0uxzcTSDYxcIdUgwvNwGSIC85
         F+lrD8puw6GBuEf2PQEqL3VfrIxhsMkB7PUECgtNr5Gn2t4TwP3KzGa07PpjFYn7900r
         wCop6h6ckROTr5KqMtRz8P3M8FslxmgftBzG+1NKUD4kKJAXOy6SdRnSsWdo6lZtxAEi
         6+UmJDJRJog8yGagGJd2HpB+ZDf3Kfkpkm6OJz6LgOKYbVBrnFcn9lEsVMTIZWb1A4jV
         M0Fi4LnlgF6MRG9ZKlQaaqe8AuqGJbtWmaTd9FRE7lyOx4/LpGXP9fnl6oTH8JWo9zNR
         IVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nG8iesjaX2FxgWRTnqvql7kCVq7juvkfiba8tfPOt+w=;
        fh=07QAgl85271k/RRwKnJB5fsXLpIN6WeOiKUJqOrpT8M=;
        b=hAh79kK9ODtBjWOMf8ibuTlE5RnA5AydCiKCokB5/dU9V+Y02gkNG2BixPycnGjo6N
         U3qhBVAnBaPUonOmhprE6xSTvVJ+z7gDvHRX8zBvryNZwvi/xpE/jeHyuoIyY9VKr1Lh
         9xJZC3H//oqp2ruISn7i2Z1TFSYfRobNAlRJDS7SHpYZNmOkyc7y8r6ZzYGP6ukUSzpB
         pFi+2fCQoglVqr5pQJwLZGa2hKdnIpmyRX9cgX3MIL/JWzkxA51M+RiHoc/YLPWfo6qH
         Mm4ArGRufq8jg+uzxD2DJnhDkbYkATXc0iQuYM3p6Zev33B7qU9Mmc2SNfB51CUWfUsl
         CKcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778457754; x=1779062554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG8iesjaX2FxgWRTnqvql7kCVq7juvkfiba8tfPOt+w=;
        b=QPMdA336BqBI2cpSyafom+aPAQsNPCwdMCpCudEjCt4Ipoy/iujN7VyATRwAisSbz0
         ow962AA3AquroSb1LZvmF0bkyiJIFSbwoKPJjJVcRifHGY7n3f5k4JXg8UPpebUJw6vj
         +kWi7WSp6EbTEpkyciiiJ9pU3gQEjrI5zMckJrfkIfuplEhPo82+jV+yE/IBXKHAq1S4
         cI046HYx3bzG3+jVmslMwbnPjmhgtoZT6mH+5vs9v6aIOkFCrmHNEwLGDxQCvmliLrbs
         ZahS786bBzyyZUpd+lYmnMJP8Y7sz1Tkx9yuJJ6qGnToMKIyuuotEjhlSCkLGpY42fwb
         iaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778457754; x=1779062554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nG8iesjaX2FxgWRTnqvql7kCVq7juvkfiba8tfPOt+w=;
        b=haO+lX5XbnIdehCzUOo+TQkaf0+WK6rKlhTa8jzrdPy1RgOlIbRfG6W/bh0mOC9nmW
         aVL3wFElelkcpH7u0fA39awc9fqInITLPiRjI7z+q45QiZHJIx/oNUAEeiBAGEcA/cVs
         KzQe3Ujay1nusxB37UvLmMVIEzmHc6OQ9AC5kuM4F7phLeVp6CtWf9tWoHPr6sIBH7t7
         xgQBXALoX9S2BWn1YPMZR2c8eU/qWKgZCH7SKHek0hWYFnx1ZIRUnkRYmu2wTszVVgcl
         pXVVeByg9fMVsVE6cUvmAdcOg0NXQbdFrN9BCfucRySeIBumIwBtIgYUy7VIF5JrQREY
         Jb/w==
X-Forwarded-Encrypted: i=1; AFNElJ8icxFB81zEClj4KNz1IthI+vozMjucnMuoFWEyudLeCicTRAKqAQV/IZPXMUpJY69KjZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDOzql7euIXwawceznG+p6S1TdzN5WsWsDvGNNzDWywmi98D15
	sMmRyX4aE9rzH1efFtF82iNhyBtwtLfsMnjt0P1vCci6YG94gi+SnEHZjYWG3zNQtc74SOxH3s2
	XBYu8nM7L3Bwpj/PKG3WrhRe1Qy/HotY=
X-Gm-Gg: Acq92OHvmXpiT589TPWIz4COzemT9z2/ubWTz6OxkD2xk1N7OjJg3t9zAWVf50ANhgr
	JIBU03ZPO1L3/RwWCPKRrXCW3rl2s7MH1Of+rYZdc4eHCkC/AgV8G4HgnXexzmlveOqc3n6JDzM
	A70A3U9XiyFnlTlZBg0K7qs19VzThsy/rXx3cW68Pz6GNfxxo1tsmo6A/cx3/42z5xKZ5JfjrPj
	XhVnXZaHG3LCR1qO1m0Rq+TY6anprzDqWsTZcgq7LWhnElG4OWbvU7Wb/hiLM9n1Eam8AosJc5Y
	EOYlO50SH1kwLgNb7tOVX64y2+JffZmol3/jPnBQKQ8guXzrV8Cy
X-Received: by 2002:a05:690c:5c0f:b0:7b4:b591:e79a with SMTP id
 00721157ae682-7bdf5dc4fe8mr206135947b3.14.1778457753775; Sun, 10 May 2026
 17:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510230901.1772949-1-knecht.alexandre@gmail.com>
 <20260510233237.GA60510@quark> <20260510234452.GB60510@quark>
In-Reply-To: <20260510234452.GB60510@quark>
From: Alexandre Knecht <knecht.alexandre@gmail.com>
Date: Mon, 11 May 2026 02:02:22 +0200
X-Gm-Features: AVHnY4I30POVnMQFoSEd9M_3dMBo7zsyfwDX1xDUD32wHkKwf8MkuBfyUfKqVaU
Message-ID: <CAHAB8Wy1APeCcm7_OfrNYeZFcMXfZ5rUSeDX7-c7WO_rGg2Zig@mail.gmail.com>
Subject: Re: [PATCH] crypto: ctr - Convert from skcipher to lskcipher
To: Eric Biggers <ebiggers@kernel.org>
Cc: herbert@gondor.apana.org.au, "David S . Miller" <davem@davemloft.net>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 11 mai 2026 =C3=A0 01:44, Eric Biggers <ebiggers@kernel.org> a =C3=
=A9crit :
> Also note that lskcipher doesn't provide access to the accelerated AES
> mode implementations.  Indeed, almost nothing is supported by lskcipher.
> The fact that you found something to be missing isn't surprising.
>
> I think "lskcipher" is kind of a dead end, to be honest.  It's not clear
> why it got added.  The path forwards is to get the AES encryption modes
> added to lib/crypto/ and to just use that instead.
>
> - Eric

Hi Eric,

Thanks for the review =E2=80=94 you're asking the right questions.

I'm developing a VXLAN/EVPN-based CNI for Kubernetes (releasing in the
coming months), and the goal is to implement datapath encryption for
overlay traffic in a zero-trust datacenter model. The encryption
happens in BPF programs attached via TC on the VXLAN device (encrypt
inner frames on egress, decrypt on ingress).

The algorithm I actually need is AES-GCM (authenticated encryption of
VXLAN inner frames, with the outer headers as AAD). When I looked at
bpf_crypto, I found that:

1. Only lskcipher ("skcipher" type) was implemented
2. ecb(aes) was the only usable algorithm
3. AEAD support was designed for (authsize field exists in
 bpf_crypto_params, setauthsize in bpf_crypto_type) but never
 implemented
4. ctr(aes) wasn't available as lskcipher either

I looked at Herbert's history converting ECB and CBC to lskcipher and
assumed that was the path forward for CTR. But you're right, the
real goal is AEAD, not CTR. CTR alone doesn't give me integrity.

Your point about lib/crypto/ is interesting. If there's a path to
expose AES-GCM (or the building blocks) as direct library calls that
BPF programs in TC/XDP could use (avoiding the template/instance
machinery and getting hardware acceleration) that would be ideal for
this use case.

What would that look like? Is there existing lib/crypto/ work for
AES-GCM that could be wired up to BPF, or would that need to be
built?

Thanks,
Alexandre
