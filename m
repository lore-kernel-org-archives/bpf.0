Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E607125A0
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 00:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782173328; cv=none; b=QE8j9nJTvi5MLxzvJgtd796ceHEDMib9wGnbaAgOlI3qr9WI37s/n6Ym4MehmXZvtvGxdY2ISOIYls09L7I3hoVW1NjAwurB84OaC+D67eWoJNBCRFvRWAX/YPrR2cgfRcZvdX3Ljjzfch0Pzo1icCOyYUGN6itme7w/VT0SMHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782173328; c=relaxed/simple;
	bh=icuTFQPXGAsYRe0MUVQcIakHaKWLZBH+fggtc0IRHCw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kFxe1fwjjhDuYDtvGuOwVDRlyTErmgU32/4fmaR1/cxZ215zx6SPUfDQmkMqLBpu2glivHJgIiSpSTTWTiKkujOYtUWJHaFYdEaQ/gZC3B2uFi/rvCvZ/Ig4w7dsS9glAzUMVQWblXqithsEF4nt0KEawQNUKJ6DsRZRApI78dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/cLEmTM; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/cLEmTM"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-137335bc3caso8182349c88.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 17:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782173327; x=1782778127; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=icuTFQPXGAsYRe0MUVQcIakHaKWLZBH+fggtc0IRHCw=;
        b=C/cLEmTMsM1JTmbGA4eDqKl5Jge8eXjVq8l1UmqzN1eMzw93DGlJWiCOo68x60FIho
         CN6lxWFu/BZSL/0KhhG97Uh8r5QSPdY2f0k1sguTU2L+WRHVRIL6yUVJC0hJZu06rqEW
         AvuZti1c+Pyj+svxCuUol5Joe1zWrmlKJtLwGP25YFkMDnr4thMMq6rQ8SqriECDO7bO
         vSukCt0HokW8A+YYsGocol8P3zI7CwkvSYK318gTdYVS+BNkYPg4kBXnhix+gPH6t5jQ
         sEvLC5DuJIqZB8GTdYk6ccwiIYDJryvnvy/+V9U8pcHeWME7fnbXY73lcX5eqIxhOXJQ
         jHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782173327; x=1782778127;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icuTFQPXGAsYRe0MUVQcIakHaKWLZBH+fggtc0IRHCw=;
        b=HOXa4eyTHZeRXN47m1J9T34LoGVbiYktEWphlhjppmBpstnBzy2x5X9aVhwwyCWYyo
         5C/AwfKAs3J8iLpgB5cYj9qw9yBJtWvjE/fVuewwyLcOEo/POItnvDqgYzEYI4CJNPRD
         NqZATstNK1djxrlKkNsGf2lVH1SBp8mqoiy7rf9XFZSXmfPaEQ4uP0IlernZBF0PVjCn
         OYa2TAtHglPNc7iCbDIufdbrSOD3qHuYfxJ2WBWPSsqZ1a7J+V2M0A4/hsy2+FtxOiJ0
         3vx0ZXoTH+qWW9q9NH5kzqX1RvsWzkX4S1D2XyfK5wwaP7JBu6NkvZcMtyvB++L9s5eU
         MV2Q==
X-Forwarded-Encrypted: i=1; AFNElJ88nceq2reOISRekU/MBH5Uhs6Esw7O7ouxoCC4QCdGpCVqJG9pX0vM4egyj6FZgjiuk1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqtB1hKxyS1K+ZbrJYZ7KdIVWCVgL+dT0N7TVy0H/dLQrbJ+5u
	YP6Hp7C5k7VoDlDuRGyOfTVUbLLDEwhV3C1E2nRa/+XTicnDUV0XBSNY
X-Gm-Gg: AfdE7cmFFeXO1mTL8y4wLb9mvd1YtmAyrlLnb9jjyDRLpEhro99RkY+VaK/NTc4gw7R
	L0oqRwiYsPrZWQuUk1TRrmzsqCHTTxyUl/2aZmUS7ATrPsicZTpxZzev0RLWRdVETULQLb9A0hn
	O0wyby0MRrzbwqPuLFovLMBUGDf7Z5hvlJnFbQZvixb4BvluQEP+B7FDMO1/S6uoZ4CG8MUp6XF
	JRFettp/e+ymAeKsJvHRmtVR2LEBm/nu/yGmainWmODypoPgoZfMwvgjjH9PQtAo/T/N3Io6w9u
	i/cFkgW5yw4iEDsnGaq4jJvWLR/yTzTvzZTrYovm5JO+wm4WRntimAwDw5bI6EuKNg8ByufzGqQ
	qCcocgTMr2DXr5pMUpYQcl1SU7T6jFgT93ZMqoKvPqeDscy7pcxdY/CpxMxEVWFHAeSwlQmz/Ec
	n9hJ2XFs2zlBajPZDRSSL29j2+7ym03Mkb2vPIwBWgPeqELqiOXvaCVRYDH6ZB4PR2bcEpXmaoJ
	q6IAh94
X-Received: by 2002:a05:701b:4592:b0:139:c4e3:9496 with SMTP id a92af1059eb24-139c4e398bfmr436341c88.13.1782173326499;
        Mon, 22 Jun 2026 17:08:46 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c4f4:7a34:78e2:a600? ([2620:10d:c090:500::2:e8d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be5c5desm12569328eec.28.2026.06.22.17.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 17:08:45 -0700 (PDT)
Message-ID: <6c8cb4e03a3c626b0e37c7e4d95ea111e4116e4d.camel@gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add test for stale bounds on
 LSM retval context load
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tristan Madani <tristmd@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Xu Kuohai <xukuohai@huawei.com>, Jiri Olsa <jolsa@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, bpf@vger.kernel.org, 	stable@vger.kernel.org,
 tristan@talencesecurity.com
Date: Mon, 22 Jun 2026 17:08:44 -0700
In-Reply-To: <20260622230123.3695446-3-tristmd@gmail.com>
References: <20260622230123.3695446-1-tristmd@gmail.com>
	 <20260622230123.3695446-3-tristmd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-22 at 23:01 +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> Add a verifier test that catches the stale-bounds issue fixed in the
> previous patch. The test sets r6 =3D 0 to create known bounds, then loads
> the LSM hook return value into r6 from the context. Without the fix,
> the verifier intersects the retval range with the stale bounds and
> incorrectly narrows r6 to a single value, pruning the fall-through
> branch as dead code and missing the div-by-zero.
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
