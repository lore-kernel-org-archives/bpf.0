Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDD7366553
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776000664; cv=pass; b=btxaomcMRNJ0zXB/ZVG7w3HDXKQIkTGGJBw5nk8qGdF4jze7uFDrppkTLfrraZE/3ykzWbhEISeGO65sBcOoVj8cYjKoRGTIISSlb70o5T5nrfOIAMrIWItApE+0bKRkpPYJ5L1EFbnGd5QdocgNQ2v4aWED22/tcrCKg1rbhRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776000664; c=relaxed/simple;
	bh=C6RY+r5Ylx4J7Ow2wiGd1LhoQuZdYHn356nitvzkRbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORtuxfaDDI5cHoA1ZAh+RP+eQhlIVjLkoCPu6EJesRHAUc/css+UboKFzTAhBlEXZ12AVFQlM84QiTG41BPmNOtsNJ4Br0x2Jq7Rp20V+G1RQUJN+hep8911UZLwej3O3xluEt9mrUU6R7if2PuGCIHJdfDxBO5i3lVQkwhX+GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cczCth2K; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cczCth2K"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-797ab169454so40715147b3.3
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 06:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776000661; cv=none;
        d=google.com; s=arc-20240605;
        b=liao/NEIxzMZ2Chv+na+Wy8TS9djzfWU3hJcYaBa8ggF8K0uy5lFAJvKKRUVLcGmfc
         hBOZjXVeohMWrRyJFeOvkNYJVAAL6SCpHtZ97CXfYWkobo8ZGPkHAXUeKlBiq7jvYc6u
         r8yPY/3oDi3TZqGm4LmRGxdZwgwWCXq5ItkyjJETNcDspAE4IACu4uPrV4w4LF8rOmCh
         71sf4UTqiSDI7V0bFzFm7fJJrs179ISy0VJcvBK22XgWI88qGkHKtfa/l4VmwSmGM1wc
         e2PU/9GJsfw7/FNA/9v5TQp4VWb9A2JDWtsbtGARxEqhEMqgVAak0JriOkmODVFZH32z
         S6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DXgBrho6CsK2+t2aCD8rZwM6Rey4DYcpPa87+rv2X+o=;
        fh=8KKBYFPatPJbteyq5iqM6ccJvM8qSJOeFeSoKUKQIuU=;
        b=j4QPjGTxDdkhSffwuCEoyFwoErH1RWDdG6Cbu3Uy3iN9mZbamPB6Fc0XMiXOVc3pMB
         DvMbUi2BqcsRgrIXnxvmN3tG8WvlyWwFsGvq0bmCcldVDKUCTzMG2X8gKpvHUX0xsjbD
         ZTjizZs7gXaYHyAWQ/OssZUp0TnucxeHfYoKowJdz4XCEPMHtBH0bvP/8AjQw4E8Dx49
         8ppeJWBLudyWmgtYc0NiOqEivCdumIiU/QM8Wo+MhPgcNAWo8QJJ9VINjbHGo49/xgdF
         AnA0BxgYgaagUeNHY81fjHsy2CMvmuD7fpL3rvTUr82LSZYA71MFTfVNtsyrUG+0tET1
         H8xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776000661; x=1776605461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXgBrho6CsK2+t2aCD8rZwM6Rey4DYcpPa87+rv2X+o=;
        b=cczCth2K2sLrPD/N/YtRFYIWH/K5oQpNo2MbO63jR7NHToIIVLtbjhFkN+DrOXvExl
         Tg4QrGPYfiJ/PPNLeI1zmXFG9nQS404LC+bh0X56h+tIGRtYylTrzausH9VjXutVzP09
         Bvu5y+iKG8/S+T8XjWZu5PPy0i4bmG9PVW2ZlD8JS5cLn6w8RSKjxefOsS1TXw+qmT63
         g2HFvm7ff7qGhNG7hVfE7Li9jaYFumJHU2EJ0gq2g8uhg9XRusNlHP0QiPY/YKy7s23t
         8zJwJNPlShAA8cEQFLSVgraqOcsypIf/qt4TwZWv3Q6J8BIGZ483BshRrN4EsaG0QLFj
         PiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776000661; x=1776605461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DXgBrho6CsK2+t2aCD8rZwM6Rey4DYcpPa87+rv2X+o=;
        b=M/Pv7oUoXnDrvAuYOuSTCGnh65uz5NfHCTBwuWkq/j/eYiw9+9Ql5xCC/2vUHo7C3C
         nm9lVP1fyTOVIVoiyPj1z3fcrg/uCozIAUC9xaTCJoq/iCC+bExQ6vwdMqk6nrsZV1Uf
         repp1D+t6JrYRGCVPkOslzfKUKhg1PPFxZ4hrPSkwd54cKrX9CIGsCEoWzKz6PEnISBg
         B/9QiD5oUTn2/BxWVEHZ98dj74hmSOGAPP8RIe7373MvdH+P7JOTI3Vu+DbBXJ4WGh/w
         7RVxHd15zUfYcuBJponBcazUbvYJ8ZmXzJ02J/+mQL2cR8xzge7LolYCxqjgp9d7IDSp
         p9hQ==
X-Forwarded-Encrypted: i=1; AFNElJ8RYYIKPNxXP3RETtNqumhOgw4QbGvW4Xp+UNpmFSI+QZ96CdB4+UtI0FphfoD12otossw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgbb70MSXumEKHi3XNLTAUoFncOPZ/OllxlFNBCdK5cjb+VqrO
	eS2amVlpUftFbDE/HeMrXDJWTH+mJjY/oXw/ikAkwmz4ciW+U92uSfbB9SpjZhsXyq2FPPWV0MC
	sp++qbYdmWzoa6izhHIPoTNWsKuUqpMA=
X-Gm-Gg: AeBDieuwDIwTab4H+30+uvhhC4ETY15hkIph5XQibU8WKZFU2l4SNlWNYvEgvUTmSVf
	FOaiG2NM4lVjlUcDTPTchLL0V9esWxr8a+Eqvazf59Ff1YIJ7D0E9AviempZZ72riOr4efKBKFC
	jzlU8oXLhluyfelNzCE1EUmmsidyjb7L3ACujumLivFcLeoCmjulGRG/W4JeRFZU8bI8xj5YQPf
	lfkI+rA+TaQYvIjmIms0Csh0cS3gxvV/pAk6qMle0X7bGWRBLUDXlOjkuH6Baduw0VbtXFJNyby
	6XiFPeVpNyi5GTm3ds7LfyXX7IyoD8gYlPd8Mu2r
X-Received: by 2002:a05:690c:8e1a:b0:7ae:dc4a:ff6e with SMTP id
 00721157ae682-7af702dbb9dmr92247417b3.24.1776000660995; Sun, 12 Apr 2026
 06:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <CAPhsuW7Y5KksWM49TrGH_Hohaq02XO8qs7G99Y6D8=0usLFSrQ@mail.gmail.com>
 <CALOAHbDG8=eUV53kF+xn=izs2rpydCk=a9RznU-EEOzmkB8mQg@mail.gmail.com>
 <CAPhsuW73qFybHgOnZ=oFC1PvdWkYWDk7gsAoiBXe4xWYagPrmA@mail.gmail.com>
 <CALOAHbC0hqk+yrUZay01EBRNOHgyj1MAavzNK-06XJKK9ARMqQ@mail.gmail.com>
 <CAPhsuW5MN6ikKmxgqby5RJ3_gvjJ4B77X74OvfbTQoFO8iUgzA@mail.gmail.com>
 <CALOAHbAmTAfamStF9sZtO6efWYJ1sbXJp3PbsVapZf7dba91ig@mail.gmail.com> <alpine.LSU.2.21.2604091205250.31526@pobox.suse.cz>
In-Reply-To: <alpine.LSU.2.21.2604091205250.31526@pobox.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 12 Apr 2026 21:30:25 +0800
X-Gm-Features: AQROBzAhZ7uy9uCOnehpJbZd9tdZu27AddmcCPfaAwa94iQun-8NAS1qnJVKEUo
Message-ID: <CALOAHbC3-_zW2CbHccy8kCzuBj0x4LeraeEt5DdUV=CdrxCnNw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] trace, livepatch: Allow kprobe return overriding
 for livepatched functions
To: Miroslav Benes <mbenes@suse.cz>
Cc: Song Liu <song@kernel.org>, jpoimboe@kernel.org, jikos@kernel.org, 
	pmladek@suse.com, joe.lawrence@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, kpsingh@kernel.org, 
	mattbobrowski@google.com, jolsa@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, yonghong.song@linux.dev, 
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 6:08=E2=80=AFPM Miroslav Benes <mbenes@suse.cz> wrot=
e:
>
> > Can we add something like ALLOW_LIVEPATCH_ERROR_INJECTION() to allow
> > error injection on functions defined inside a livepatch?
>
> No.
>
> I am sorry but you always seem to find band aids to your set up and how
> you deal with live patches internally. While I can see that something lik=
e
> a hybrid mode might be useful to people if done right (and we are not
> there yet), the combination of it with bpf overrides or anything like tha=
t
> is not something I would like to see in upstream.

The upstream kernel already allows for combining BPF and livepatch to
override functions. Song=E2=80=99s patch offers a great reference for
implementing this without changing the kernel:

  https://lore.kernel.org/bpf/20260408175217.1011024-1-song@kernel.org/

--=20
Regards
Yafang
