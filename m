Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6057081A
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 00:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775177607; cv=none; b=iO6TYDVsl5k1wkAwhFQUo4sJXcPrar5gFWErbKo0WKVr6sznF8Xph3k+BgAxevE4/j8Rpd223/czU+0RmcRyzKeH2R67dowJlfBiTJ0ALycqBAJksph4pyC2oGoRrX3LDTsKmtIc6yBtshJFpEMCwtmMrSWmWYEwZVhlRfWLjFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775177607; c=relaxed/simple;
	bh=0OWIeqnDu1mQYbWbLff8G9a/sGUJ0QRhkoMFFttqY5I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aq03b81ih24EZBrJKpT5SBUplMpZeFSHCcBSDcPJ6URR5udLrlpSIjsnNbNT65ikpQU7Z4RD14sk8XR2BwbOrqS8mJKsybO8dnUnpRCe0lCEqGJ3Bc68aQgq38JK+EGmv4Y2JRM4cVEArtokuVdYDM1W45LMj/XMQH4hd7AHTnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9irUHZ6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9irUHZ6"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad617d5b80so7814825ad.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 17:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775177605; x=1775782405; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0OWIeqnDu1mQYbWbLff8G9a/sGUJ0QRhkoMFFttqY5I=;
        b=F9irUHZ6jpDkn4d6/zoljHeRfcSQVem3pRNi7GJxguVPShiH2qpKrs8mt0aLa0nr6Q
         knGe9opt+K5FMmth+6qsCHNJLXUlljHx0T5gOZ6aiglkthwj1GMAQtzckp+ewpnAB0Gp
         rIE+S5hCAMKb4DnbgynY9stWQpXbxqA3AeV0CCvXdkVmy1F4E5yVR4EV7JmX13G7kc6F
         CyDZwiUaB+MAr7wyHpDuqjs1VDbpAdUSashq8okrVTWoTOCLGZKEXGSalCYbH/Y8tTEz
         aFE04/nxAmW9VkySoARV/wK76LeBlF9QxR/gRq7dH2jDoNloowyJi7CuoaJxbSFrGz1V
         gfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775177605; x=1775782405;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OWIeqnDu1mQYbWbLff8G9a/sGUJ0QRhkoMFFttqY5I=;
        b=BBpWBXsuvwjV/Qbjdo9K1HhZzK58h/6AcpcZFI+BiSyEV/bSdzscD+vuy6JthFohu/
         FaadAdIGYcNAEWS4Js5mi1Im06/keR3HWvImKNkK4iE8IpTptdyCpoGhduD0IGnuO933
         Qlfayqv2shyRBQjxP8N5zDS4CGuoFF5vxO2PhAKeS4oYPGN7JlG8mFRzmiaMG9gJy9lL
         I0rvgiOGlrXOluGo5yuxLVVMeDqsj4YVPSXLxrhv0ltDfYX0yK/TCoLMFI0xlYNl3hq/
         lLUWVQ1oHEHeijnSgaYlGfoZHAgagdI0kwykwMNwypKa72QOtfrc23PWC/d02NvJpvzw
         3fxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0wumWx7xI+PlDBdbZdXpURRy2G71NSrARlaIHlhpm56qhZXi5TvE6PySMGGt9S0CqUWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQmLgBw7iELbM2CZFlbMPQWU+lDKHi0QCNE+0SHWA99uwoBPoJ
	954lnRdHDXRvh7iTJueeS0J+bO85KS0FiWYZX/8Rt6CcBbkk6LbL0PPS
X-Gm-Gg: AeBDievuBIheR+N5BWN/rxrypdYRtX36EEeP05DcbRqNFiBiXM/13eOB2PeaHsz3u1Z
	+Cle/1/IHxEfk9KiFozlOatQ4MzAovx4v3h7TqwH7gI7lWofffFhYczeFb2ZuSYh0H6/TFM1Hqj
	I8zVefCdaL2xZzdUQ91zAKsav4XDkj7o4psqCF0UWljWUAEoC+3K3XUAlXkNzz+5CvutcofShdm
	K8GvfvsUrU0sdzZ1aocx/CeK4OGkz1C+wf3xZvlA4zSOLx+/8o1kwL1wkCZJdPpiuR29Qq+w/AZ
	kd9BbP3x7iOAeh6ZuvjNKjuM375dwkS4h2LnxdnZrMFuLYCXdXVySSC6Nfj9RmeYFszXUlAPSFy
	cnccHovKwhz7Goifivlj6RLSyotpcWqCySnRe1++1y9iM/l4nHUys+D3kFAn/NYmvEidMgm4QGP
	5CpXCFTgI8cG93mLy2FkJYblnpRbyL8r/8xI29eLUcH0uIqMC5NrTz
X-Received: by 2002:a17:902:c410:b0:2b2:4862:78e9 with SMTP id d9443c01a7336-2b281687c7fmr15226895ad.15.1775177605383;
        Thu, 02 Apr 2026 17:53:25 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af0dsm39824405ad.47.2026.04.02.17.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:53:25 -0700 (PDT)
Message-ID: <76c92bd4263566eb38ee41903a70ae1a0a1dce00.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Refactor reg_bounds_sanity_check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,  Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Thu, 02 Apr 2026 17:53:22 -0700
In-Reply-To: <198ec3e69343e2c46dc9cbe2b1bc9be9ae2df5bd.1775142354.git.paul.chaignon@gmail.com>
References: <cover.1775142354.git.paul.chaignon@gmail.com>
	 <198ec3e69343e2c46dc9cbe2b1bc9be9ae2df5bd.1775142354.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-02 at 17:08 +0200, Paul Chaignon wrote:
> From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
>=20
> This commit refactors reg_bounds_sanity_check to factor out the logic
> that performs the sanity check from the logic that does the reporting.
>=20
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.c=
om>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
