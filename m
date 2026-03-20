Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C06F2D9EE8
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 05:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773984447; cv=none; b=b8gDvNO7Ti7cFeKAzglLXlf1p/EQxGhovxU4IoHpNQ5XfYHXSTb3jKWwhOYgKfR03+Ve3tpsYkVmEdM04r+5VIhEimL+/+t+IgbzcA95P3DQkwyQ9bf1mRFOyhfxYZ0O/woaJQagAbCkVqEdkUv8GOP37NxZxNIbgh736ET1/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773984447; c=relaxed/simple;
	bh=4iVp9GIRVW9ScHJBCOd3xBd4NWWeeXblCNYnYNrk+yo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZoN9ybVxs0nigRYRQz9afTN9tMKi7sIiiOW6pOfMopM7r5EjLj4ZhN3e4IdU827a+Exu+cMtf/sxxc84enjJk7S0qYhrLXw4dgQr7MCgS5xkr3uCFZ2usaK/JTvTI3NsULm195RgwHhSg0B2C9pASMaPYl3N4m8kxYte3wDgt4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zsm8tljV; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zsm8tljV"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6e2355739dso687423a12.2
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 22:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773984445; x=1774589245; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DJmIPBcZdlW7UJX0hL3AGBjH45wPuCoLtMpc6iY69ZM=;
        b=Zsm8tljVnniLXUcJHC3VdcAhCWHS3x+O5AiHcoACNx7ZmWVTlgwhrQ4AKZrTvEG6p6
         MWlYHl8qbjDi5UMG5ZiRE+aI65IDniOxSOSM2N9JUXO9gKpkvevkh3Z0FakEriK4MVZ2
         4X41UPdWSfqXh4CERDrC9Guz/RtNqCost+cMzvPQFo00+EXMxA94MqaDRplCQQ/G4TAe
         1FWauky+xf3K/mRPsVSQdSqT2qdGPD9iKkhXYqy15fXFkvqZV2tiIAekrLPrV5XMHKVc
         lM3/fmZcqdSvQZqlyc1mZQEuS89CgUTOarMH2ZKeCqE2s4iSSp+DNghz9TCZepK0omZy
         wlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773984445; x=1774589245;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJmIPBcZdlW7UJX0hL3AGBjH45wPuCoLtMpc6iY69ZM=;
        b=sjMOs51aTxgSKOakGSyw63C9Dq7suXhXTT0nlFKxCbpihQ0+0uxNUx4FElPk/7hxH+
         vH4OLcEFt4igVoRTT3H5MzzhLKeZNKzSSdXYKlv802WzeoB2+ksiL1SbRA7cPAgkbSEZ
         4bX53b8QsRdEq4U81/xyl64mRJxPCyg2bGQ/Zmu0RzThnzMLi/f4vUeWS8n6rAyvVHKr
         SQgmASg/WTydF90aYfLYFNIY+/X15hhaISaCYbXw45RZ3UqxeTrlacfH20U2U4v7CYSx
         Fqvnnfl38UA0YSNvvTcXc36XvQwLKMkmgdzXDj+b5TpVBJSyDq2tU7cBlcozrWkLzKeK
         xW3A==
X-Forwarded-Encrypted: i=1; AJvYcCWg9JW4nM1VV6SbaROtnEqT+Umxo9VnwlW6x8cBWPpNBWgF6YGNo3gwH27rqZaOv5Kh5Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoc6nFPzSQj3mBvwXXxpYFGe/WEV0T0aDVDrh4VWAI6Ds+bknG
	04G4Tk2YyxqxqyH6qVtPMeY/WtfIpB7d1QjCdPgoUxCcR3ocP+RPM3bY
X-Gm-Gg: ATEYQzwxMuZrtlHjVdXVeD1ESUWj/uw7igszuxr5A+Ak8qwrUST7+o+mEhZ99Ab1fKv
	IB8tqyWfMSYXF0tyc5LRa85KGRKF7+/+ac8R1xF1oAkWgGjTNg8mJyfPfylvzdQ1JWdsEEBmAhp
	XEL6YKn8aVhiX/4N49sI98lQnnGIz6cMBbgkdJjM2L6KDZ6BshZKq3RBeUDo926s/marOe22qOU
	w2fpY6RYwA1zoagVwSU4TjCXlpVN5iXAeEcheVC89+iIlkolkNn8ySvHCbbDy/NOhODDFKRjDWj
	BZtU5gpTSf7AIiSS/8+DAIcLuMaEgj8z7DWfEg/rQjUdU9VzLmynXLjujopqRA6ewyf3Rn90/lg
	TvQh88Gf4VNzsNCceB7V2iEHnoil+bKkw49x4vjj8pj43Q45E/s3MS3UPgv6CgbBt36aYXplxG/
	+49/xGZIUYjabMg0lnv72yXMusGXQA8hLMWLnVtY321ukpRgqumL8U
X-Received: by 2002:a17:902:f710:b0:2b0:6e60:9582 with SMTP id d9443c01a7336-2b0827107d7mr14773665ad.18.1773984445351;
        Thu, 19 Mar 2026 22:27:25 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836955dbsm11632385ad.72.2026.03.19.22.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 22:27:24 -0700 (PDT)
Message-ID: <5d7ad7f651c9a6525f477566ee36f0e746f650cd.camel@gmail.com>
Subject: Re: [PATCH] selftests/bpf: Enforce definition order for __msg
 macros in BPF tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: David Faust <david.faust@oracle.com>, Jose Marchesi
	 <jose.marchesi@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>, 
	cupertinomiranda@gmail.com
Date: Thu, 19 Mar 2026 22:27:21 -0700
In-Reply-To: <499f79da-eef7-4495-bcda-bca6c90c6f4c@oracle.com>
References: <20260305130035.192080-1-cupertino.miranda@oracle.com>
	 <b073da2be883cf8f22a9a4c5f2dfa112d75d68f9.camel@gmail.com>
	 <499f79da-eef7-4495-bcda-bca6c90c6f4c@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-19 at 13:45 +0000, Cupertino Miranda wrote:
> Hi Eduard,
>=20
> I might be mistaken, but as it is skip_dynamic_pfx is dropping the index=
=20
> from the string that is passed to push_msg.
> This is the case since it is matching the '=3D' in its passed macros;
>=20
>    #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg=3D"
>=20
> dropping the index and the other equal in the call to strchr(msg, '=3D').
>=20
> I know the patch is rather bigger then perhaps minimally necessary but I=
=20
> did not want to change the semantics of current implementation, except=
=20
> the array ordering.
>=20
> Did not really thought about string ordering it later, however, if I=20
> think about it, I would personally prefer to order the array at the=20
> push. Ordering later during a processing stage IMHO would obfuscate the=
=20
> fact that the array is ordered by its index.
>=20
> If we change skip_dynamic_pfx to also return the "<index>=3D" then we=20
> could parse the string and insert it ordered in push_msg, not really=20
> needing to wait for a later stage.
>=20
> Anyway, up to you. If you think it is worth it, I can do that.

Hi Cupertino,

Could you please check if [1] works as expected with gcc-bpf?
It is bigger than your patch, but I think it is a nice cleanup.
(I took a liberty of putting your 'Co-developed-by' tag in
 the patch #3, please let me know if that was inappropriate).

[1] https://github.com/kernel-patches/bpf/pull/11484/commits

Thanks,
Eduard
