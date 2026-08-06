Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F882D2486
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051046; cv=none; b=J5kq7XXDZEjtmV3DJEyfZzwTfDUDSgXA+hkBmEXy46SO5zeQen+yEXlO3GXIxjs3IsX24W4/qzzcay3HUy3kD+hEcZp84XZukpD4ZpOnc4Gps/2hvPnxWZwfgPewlE1P7JgFLvSuwvMEUlLSyNtEghlC4qwIWE4hn1RKXcka3mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051046; c=relaxed/simple;
	bh=i0xsFfuGkhJNhTq2EADzDgVshYOuIm2X/WcPJ0Xrx/k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iG1+tJnIlyEaESycXvB4PGcLHk/W5SuZr2tNjnTybsjQ8rAv3zZDG5fgGWwTWpGjMR6tjgOTcCu7judZYBATc36CEyqaPTMWhAxPLqpuFWwRdQYpI9+Nj/3ubw2ygZnMhyAJE5FC0yI65sp+MVXbIjmu+z/4Cp19oZAErHaGYck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWy6JEyX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWy6JEyX"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cab973140bso37489665ad.3
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786051045; x=1786655845; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vV1K/PxtFGbxxnxBOl9VvC5Z06I9t5mIXQGFPO9TbQ8=;
        b=BWy6JEyXbRBjpe5garlFErHQmiborXwEC5xuGYtTN2S4/ed4G/2GCby8pCUuoDCAa1
         kwx7yTMUQVsdIcGVaHK9/8U9g4QH/4A8MalfLoK0ih54AEVDl5Hb+axqmiYk4JSwUkMZ
         kyazbMF5visKX+fR8PPdK2Sb+flbi0udWKp4DYGwSdV007lL4XCwHu2L4t7j+rwIYI5h
         eLsuy/XPJIXyVoagdwgu/Fd/oeK/lH85M3iwKKh2Y7yUpSkFYgHYzm6W6A63xUPxb2VK
         UFFuEY77sulWvLMEP4UGOVyNEDXH9jn84r06aMNv5m1aWRwkhZ6ZhBYs3bN2cxnyGIFq
         wUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786051045; x=1786655845;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vV1K/PxtFGbxxnxBOl9VvC5Z06I9t5mIXQGFPO9TbQ8=;
        b=m87damFXJdX01W+M6XTdVzkA5emNoXcBipa/JYmZqa0efo3uF93xofKpkpqL/c2HcI
         47/6Z6lIDWHPZOKg5yGh28Jg1Wo/Q9Y7N6Gpc+i6KP4by4hAgQy2OPfNvO4suMW36iYc
         hlW0M88EGMboXYvD1/FX9h31GbI78xJknXmVKPz34A/RNVRVdZAd4sbl672mKo+AotQ/
         CP1JAYTmvbnXQ4FFNtmOybExnX67WQ78Bhz68H4EpNediTPf2B0J82uk775A5zA2NadA
         2M9vOb+x9wVFUAMwYOzW2xfQU6RX34seynVDt2SWZMgs6hmYT5M0b9yEdo2bRO0cE6I7
         5HjA==
X-Forwarded-Encrypted: i=1; AHgh+RpFM9qY1j2NYk8dbgnqvuCLMWgW7HYgJ5p4T6Kx6A0la6T4ELoOiauIqGl5YNX7bIspEzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbs5Xrz9DVT2VB3OlQVWwTHOkyiNdfQK1Zqi+AG10tsQxNY4bm
	u6tkpUH7l4cNLIED4WnNTx7e5uFjEevOCMXFO3i+q6mq6Veb4cuyKz0x
X-Gm-Gg: AR+sD10CJHy9WB8ARAYWZ2uFTdHS/7h8pkrrH4jLAuNiPCSwXDu//clVDMftNSGArKk
	+JRu/MAzFGRS1S5s1KkUhyB5/82JsEY963mr2Vzv0fXVTM3ckRkEGmo0kdFReSdSt0Hte63xOnt
	AdGBvZfsLtnCf5lwASJvTs0tMamAGXnIWH/vUbqME5n2DIw25T1/ljYtNX0NKg0i1mXvPhBvURd
	bAkoHgHeAIR2F+iEIvyLSqRMvE2NHEu/KPfXJ16/d+6F0PjRvoDumDleGucLCr6JH+ZVnANytf0
	y4/u7jzofBSKXtWM0xQztr2Ufk6Qxpuz0kbAnYJqk8diUtXE9vY0blyGCwLuotSE79Fz8qktmKK
	haE8WRQ5emhj+9o3kclKv5mMjIWzh/7VxVnzsqKiHhg8D68j/wMe2Rlj+v6DZRkcoabyWYjza1y
	wfyizPyYf082xvraSrikjAMyk/h9E/Zk46KiTaZb8ha6yWm+m0OHyWOSx/4LSpdSMzreUXFDNY9
	hhs6NYz2jRxAOGX
X-Received: by 2002:a17:902:da87:b0:2cc:a977:4260 with SMTP id d9443c01a7336-2d0ca9fe0d7mr180356565ad.21.1786051045162;
        Thu, 06 Aug 2026 14:17:25 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4e9cf6sm114655ad.76.2026.08.06.14.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:17:24 -0700 (PDT)
Message-ID: <7190f11283c2b3727b0e1242c9bcd7db6db4e7a6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 6/6] docs, resolve_btfids: Document kfunc
 BTF annotation emission
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Date: Thu, 06 Aug 2026 14:17:21 -0700
In-Reply-To: <f9b8c8b1-906e-458b-b779-faacb2dee66c@linux.dev>
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
	 <20260805230648.2354989-7-ihor.solodrai@linux.dev>
	 <b695bed46f03b4cc1a819bcd0d63272923ba5ca3.camel@gmail.com>
	 <f9b8c8b1-906e-458b-b779-faacb2dee66c@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-06 at 14:06 -0700, Ihor Solodrai wrote:

...

> > > @@ -14,6 +14,9 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)	+=
=3D --skip_encoding_btf_inconsis
> > > =C2=A0else
> > > =C2=A0
> > > =C2=A0# Switch to using --btf_features for v1.26 and later.
> > > +#
> > > +# kfunc BTF annotations (bpf_kfunc/bpf_fastcall decl tags and the ar=
ena
> > > +# address_space(1) type attribute) are emitted by resolve_btfids, no=
t pahole.
> >=20
> > What's the point of this comment?
>=20
> The point is to inform the reader "where did decl_tag_kfuncs go?".
> Question is whether the git log will be enough, or is a comment
> also appropriate?

I don't think we don't do this usually. E.g. it would be a first such
comment in this makefile. Also, the comment looks suspiciously like
something Claude inserts :)

> >=20
> > > =C2=A0pahole-flags-$(call test-ge, $(pahole-ver), 126)=C2=A0 =3D -j$(=
JOBS) --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,opti=
mized_func,consistent_func
> > > =C2=A0
> > > =C2=A0pahole-flags-$(call test-ge, $(pahole-ver), 131) +=3D --btf_fea=
tures=3Dlayout
> >=20
> > ...
