Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D21410D05
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468091; cv=pass; b=kfWDsVYx2LV5O5Pt2PEk/x+xiGBU1JB1UodBjX6NjvGNsedzFnF1HJqKT5hAELrrbCSfX8pNx6ZCDXFba30rZhK+ux9LWyeXw6g0kRj8ZZeum9ooqL/qBmJifxH9U+JqmsDZFERXk2jVjKeXLV0AZtqqD5Xwbm0uToeWwf+etrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468091; c=relaxed/simple;
	bh=Rgnmx+1nyZwmwDNPo/Rztzlpg4NbYKGPjQCd5t3n0ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H76RYh95dPcSk4A8PMTDJAiMjUOdPXm9Xa4BKCxSMNY9+4qxysWTVDZuBECfrOscXtvoLpH356C1W+RFPEwwWh9VAu4UuDWSX9NOI8tRxKGRyxCCZFpTKKIz9JKbOqAtRukcEdtXkFwrTKBnXkilP2M4x/8cBb8GjUKzuxNvfIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljQJYTTl; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljQJYTTl"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483487335c2so2953805e9.2
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 12:48:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774468087; cv=none;
        d=google.com; s=arc-20240605;
        b=aeJv565RiKPAl1p5ck/fkoXBzz3V8IHiAxLb2Rl95HHIkapbrfpbCJ8WX5+Tt6Sn6B
         jH97i2j4VYeoN1nackDSMzfgWDeAly9KbUvBNG7uxxgkVp7NfSXntpSZHKqS42c7RXNg
         Vdo6bEnrJa0ONkDacyN17pzRCgw+WwPc8hesc3pnWJ9U8zMVGyaks0QTKJoMKbe8zDvw
         /TsPR1uVgRkRO56YTrnXEQAGQHb0t8c23ciuxhbSFQAdyLn2ps46KviuJi+kwTmrantK
         4sL04yox9wIQnGoXjj+uh20uAiNqSc/0g1geUqsD7OQBtcjopSkBCEqSvug5/yVS646R
         BhyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NY3gGfyLd7Uhwim0KWjjQUSyX9gc+6plgh9QwAS+XRw=;
        fh=0DU+z+Q5bKuVnh4JGR/t9GghP+VHHsmwhCGEO9jJuSI=;
        b=KvgvvugIMt518rhFtS6oj7EI/keR3pN5Tw5+bW0c3tpLsnV3CXiYZSafkDdm7cXXbw
         1tgqstMA+g/TqhhwjsJUS4hpxJCzfP9ooP1maYJCWpUnE9skJwz4yBsvGEaVW7QLxYyY
         8V+4Z6SA9Z1RwJc47vS4kNOlyRAeYkRsAyLOQlosqpLKRYze3KlTqYifGdFfTye27mZy
         8IxgMhCq1q+BtHwLtBEOfzSSoyfoRV7RXIAqgIujMAnWobdAYMvvjT7LzFvw5Jl7LTMc
         1i2HdLQBykZDV22wefXH86tDAf/Gvu+2xHBMZOxIqKHA+/SxclWLecmdHGXUXcVhaUmd
         l+dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774468087; x=1775072887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NY3gGfyLd7Uhwim0KWjjQUSyX9gc+6plgh9QwAS+XRw=;
        b=ljQJYTTlAlOBLxzcwxFgiC/ibtzj4llGSqa7RH91tk4ouDKuAUIQbd5N+8QNhzsOG2
         PscxmD6uxqhCSti63ybQWlGvnOcXTQTY+bCDbDc+90I79NDTw3WdBfzqllLGytZXmeZm
         IpCWcLg+DbfP29V/ZlRTaUXNV7m1nxsa8AYgN5FeOMH6pVQRfVUKdVG07ALB2/kHPQ75
         RUIAjUDj0+2OiyTI6zKw5gUYccLjZzACz5kqDs+bKDiphsNk9u0UoCapJD+wbFxv589f
         NmodeEqURF2WcJQjRldu1OlDrR+wVjtD3OIg0cAILRsUFwjEKQNBZRE72i1iokNaTR+A
         p84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774468087; x=1775072887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NY3gGfyLd7Uhwim0KWjjQUSyX9gc+6plgh9QwAS+XRw=;
        b=dPxV8dtwLl+LaeIPuKpRQ803xgxsED3bj0FCYeDdPg3Rk29dhHzLvSaDhE1QXVyNHu
         n7pCX2zciFoEB0HKpheF7I2N/iYGKS+gcJ9GT3qeXE2RMJPbuqgLiVmo+l/0tJvVwYUk
         3dVLbCHihcLk53RSZBYMo31PI4jUwHNaxCXcjdlUhh4HIX8mfn702srMsGtiMqqJdGzd
         0UhdFWAuYWFNcEe9X9+sHJ3E0Xfr/IV2fQ2ulDVpN3LiNehZ/YhY0tbfhTpIEZHfN+cc
         bUQe0apbTGHW+ZtnKyfnjUK0Onp5gsU6Qycf4tPMXn5QiAXye3KpwkDFC3BMPzj7t1k+
         XkLw==
X-Gm-Message-State: AOJu0Yx05P5/W+ivFLZtBKBdBTKQb1BYl+fTOi9CsTECDdvAXDbo+Hes
	z73whqNv6nRSnNLC3PVzFUrDvfzhd/Yv0qcpn306h4zIwQFjLYJgp/r6YVshLP37YWEFWQJAhbi
	7yAJWEldt45JFHrGMFdK7PsaJ2NDKpc0=
X-Gm-Gg: ATEYQzzo9xqRH21wvlmu4MEHE4wmZkq1PxeNliljSXnJ9YP6y8Rn7gz6UxN947xUirA
	YqujOrJDN4LooDrtotbNG1aEq6ZJFHURJI9wJQcdGVOLubr0QVFjF4RIseuI1kJMzZCAhz5DvUU
	PLskPzpGqaK4eFU5dgyKYpulOZ1tlmf5i51p1EJ1YxhUG/8NlaC75hVFXV1dbJKl2hwHDSYj8cF
	sI1HHZyWR4TVVY0ktOFhVzpZjxDvN4kBiVrLsjBityIvY7NehKJU+rCRLaFwR7pomBv9DZ1rdtM
	s7AhT9IQWme//tw1uXDVRsRuVFZK2EIZFkiAPVnBRqcpXOUR94LkASn2a/epgKAdCIyvt1iE6tt
	WsNjsq9fXX+LQwTYx0SW45pSGlw==
X-Received: by 2002:a05:600c:c166:b0:485:5812:bb9e with SMTP id
 5b1f17b1804b1-48715f0272amr75652355e9.0.1774468087238; Wed, 25 Mar 2026
 12:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325012242.45606-1-alexei.starovoitov@gmail.com>
 <DHBJEWWLVRCH.2ZH320TJNWI21@etsalapatis.com> <CAADnVQLQ2AbCjvvo5LcZAW34C-SF3x-NdDLnUAfsaqj3FzaMEw@mail.gmail.com>
In-Reply-To: <CAADnVQLQ2AbCjvvo5LcZAW34C-SF3x-NdDLnUAfsaqj3FzaMEw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 25 Mar 2026 12:47:56 -0700
X-Gm-Features: AQROBzBwFaCgVp6beexTw1As0buBSdTglRpACzXtFjuwGQf9LkWcTt4KXY6CSdI
Message-ID: <CAADnVQKGjNxtDQCWPWWbb6AdkeeSi+LNahxk66xPoOjqgbAsYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Make reg_bounds test more robust
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 8:23=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> > > +                     q++;
> >
> > I think the increment could alternatively be
> >
> > q =3D s;
> >
> > to avoid rescanning the whitespace.
>
> Good point. Sorry for being sloppy.

I fixed it up while applying.
