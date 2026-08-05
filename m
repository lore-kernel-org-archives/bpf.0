Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2843D3CEB
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962178; cv=none; b=VFMmu25/SouGSw3Bl6uJNrLYbdiB1IWa+x//8Dh4emqJaX4Rk6T1nE0NqhUaK1jxewP+y2FhyhDZqqN+/YDt8564yVMm6REMuHWhNHgiNjqLCSKvxZfkQd0D2zRQO1yAQPLQ0AKIIU/cSfgAy52S3WQrQkpfG37eetVFz7mhKHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962178; c=relaxed/simple;
	bh=jQfY0SeixHuKD6B8uP1iAzMGi2goZGDAiPIc999xIkk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JWDAqVU8C9hmWsr5VX+M51RQOoKcEkwlZjcS2tpXOeFLgQVRwBrs+aBmskGnpJRqFicc5/K/igUYOzfLMl8brQ5PQK6e3y7jrJBAbKXQyvBaP6yVpcQOPvUxwQMCDvUcGAb7divoLxxuNDio1lXr6oXSeNxcS1Ng8n4bVQG7s78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfdXbTzR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfdXbTzR"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38f620399a0so1315976a91.2
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 13:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785962177; x=1786566977; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jQfY0SeixHuKD6B8uP1iAzMGi2goZGDAiPIc999xIkk=;
        b=DfdXbTzRGbWuIsgONiOUcnVEOq9mYIhINE+2aZC7cKPaB/PraoYADEOs2uJV3kNgXT
         Mf3+lIoxM0/WEARI7PshYarkP761E2zKWNkizysZNoExW7TgZJM/N5GOTQVXAZ8SCRJU
         JFAVpuHplG7p7jo/AvxtoHoEoCytXTbo2i11BvUSPaGWIYUDhE+YarGTpMJr9pHxc8Ks
         JqF3dzO4MkzzDejTk/fPAQ5LsSa3+iyG66smJYFLjsHD4ZtEp1QyIFfuaLfQm3YL1Pf4
         T6waRON1TjI9J3Aca4vdR5lcFX4fOzCy/10esE2bIHH1EonqNUGtnQPocedqHaJl1DU2
         oxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785962177; x=1786566977;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jQfY0SeixHuKD6B8uP1iAzMGi2goZGDAiPIc999xIkk=;
        b=q8BzCVK805ddXJs9O9NQYiNx5TGYZa5aq8GNjqcfssV/sWFVECNmmBYHeuRLIL9Z7C
         wenlxdZUNr7vXgmgAM7trh81FubmoNaNkeNjCBTu4JqL5Ti+sbQVZ3PQq0Ia+siYkR4U
         OKYS7iO30eCMPtKbhXFwEV+D1DMkLrjsIHdl1f6/SqVzG3OFDJmMX8YNOYoeX/ZXFEZW
         BBn8fn3T7D9bl1Jl766G0vzX40gcRKOI135m3YIuvZgfuV9iiOa1UHRriQh6pO9ueGD7
         Uo8urTOWTDOCW/gNjdaRqT1LMw1ppqU4x2fgCflKBdqSVAAV6PYs8tM+5PpFlbzTkCXx
         V9Tw==
X-Forwarded-Encrypted: i=1; AHgh+Rq7zr9SN5+ir4H/2wmAVDi/BcARH0P3V0NR29sOidHZOpneDSwl2VZ2blZ2upxlRwUkQM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbRZIGEi9SA6kdU0Mb+spp4s4LfixbW6uYBN3v9yEU/bRG0xj7
	qDpYvLqPRlIAFgBshOm6jZkiraqujH2/coxj9UdB+XgbYFIi/UV/jOHT
X-Gm-Gg: AR+sD13yUsszgwQW+Pfygoc1i3ha6dlJHhBbQot/P4d6PKnj+iazKaRCVHCUBYhnChX
	K1vD7VbEp6M4jc5pMZrHO3bEpKnOyiM8+4fAYNvxTtQtyoCjr5Pkom0XqaDcCOZKvCYkJP/HDT+
	eDLyWy4+FtbuOzykJW3fdlRpUhQhOcc4H39tmnhdheRRA64YZGYNtGxT7Zx3ZBoB1M2HF8Eot0k
	ntkJBtp7BfqKJOxm+EolGFZNGAJGpZFDFTREwVDRI9S7D+o2I+O1npLSr8ayS/ooQD+AodgU7dB
	us5/fDNihpuAIge4l6rWZe3ZAoil1tiaFiS7Uy/9cZ2sewke5g3BMBHIZxTYxpwe+mwU/Yxo5C3
	oJKDlvKBVFnlMfpRE5T+H3o5lCVN2Uza0sBD4dDOmp6VdRwJfGlSsufhD8Zv7YcAjUHSXw+20CZ
	7myl/m3xRCnGmztFP8ugVvbqT6IR1k4g0xUyIsFVhrsF1lY/wCDW1ScRCwm1IMJN84Eh6CV562h
	OGahudTc1gKBbna13VhGt6xtZSKXxBIhMXL4QoZD6LC
X-Received: by 2002:a17:90a:d2c3:b0:390:8361:a532 with SMTP id 98e67ed59e1d1-3908361a861mr1407710a91.7.1785962176684;
        Wed, 05 Aug 2026 13:36:16 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:969b:c0a:ff6f:454e? ([2620:10d:c090:500::5:b61b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca63ce12sm20726577c88.5.2026.08.05.13.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 13:36:16 -0700 (PDT)
Message-ID: <bfe416825f7a03f599835a41d6c5d261c7b4432d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Mark pending sub-register zero
 extension before pruning a state
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, memxor@gmail.com
Cc: puranjay@kernel.org, info@starlabs.sg, bpf@vger.kernel.org
Date: Wed, 05 Aug 2026 13:36:15 -0700
In-Reply-To: <785c9fa1-c238-47a5-b57f-23742cfaa728@iogearbox.net>
References: <20260805184444.292828-1-daniel@iogearbox.net>
	 <d8c2a4de77327f4c3cde8aed4d95aacc915ffa18.camel@gmail.com>
	 <785c9fa1-c238-47a5-b57f-23742cfaa728@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-05 at 21:54 +0200, Daniel Borkmann wrote:
> On 8/5/26 9:11 PM, Eduard Zingerman wrote:
> > On Wed, 2026-08-05 at 20:44 +0200, Daniel Borkmann wrote:
> [...]
> >=20
> > Hi Daniel,
> >=20
> > I have this series in progress:
> > https://lore.kernel.org/bpf/20260802-static-zext-v3-0-3456b2604574@gmai=
l.com/
> > Fixing that exact issue. It needs one more iteration.
> Dang, missed it, integrating into liveness looks better, lets go with
> that. If the selftests from here are of any use, please feel free to
> pick and integrate into your respin.

Ack, will do!
