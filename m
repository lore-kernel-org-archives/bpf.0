Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39CD379EEF
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308933; cv=pass; b=AzDksvCRIkxw7P/QELL1TX2GcWPDX8eo/xGOijbpMofV6pRuI/mrRpB0bX5n4fA0x4MccEuxWIQ4Lpu904FtqAe5cK8zBhBg7mUurxSGv1w+xCiKFfCIoyNKmGf7sV/Y3+/dT0Qair6zlMtbGOvA0yxPX1dvFPk4rm3KY022rOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308933; c=relaxed/simple;
	bh=VRSArwJcRo79n9/mlWVHLIcO/a90TTkXWTwHqj889k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=li+U2Pr838aX+pkwYR+PH4PaxMmTLa8qyIApn1qAfYtHAlBWPRIhpnc+u7IYWhJRrQyz327LR/ZIkf4UHZM8rD5j38hqM3NK96uy5BpgWqoTRPqMpd4Sy9D8k2f26y8D1YIZNuQWgXdZ5lDuMCwyL22ouYh9W9ZsjNkLAs9x0bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DzuzpwTr; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DzuzpwTr"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4f5d3bff929so2090751b6e.1
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 10:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791308930; cv=none;
        d=google.com; s=arc-20260327;
        b=g+qncmzgAeu8h6XWFc9NjlHWILzdoB/681Cloo2/2J2D5S8vJ1Uo8UcbbRLSSN9PHo
         eBMywoqq/eLEuRyMcf3kyHcO5SBuMrdCfLRkAO0/Xv9/gcrid4986a/xaGfe9w3AIdTp
         R9tOjKfqHgyVojnRG7I/3SU/gzFrzTsYneF0MwcKo2HusAKS2LrImjYlvsQIkqQyi702
         kh2pa18/+JbDfztmpHzyRXh9KDfosoqSlF6rebOgzCHoLmfH3jfDvMhhPnyjGW/1e3Pc
         pFlDfH4U1x/eYatPj1Q2h0hwe2pW1Aj94WFmNYub4qe5djmeZ/ZGaeJG7WJsf6KSv1ld
         1VQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oKkGu4MISHQEsFFjUyIjKXrjUrAiNT5vrF+iXMX4HX0=;
        fh=m7vbt6bBxpVDsjyEabZKZ9ZMNCenqxFC6atX9tz/inc=;
        b=e3TBkEE+kQSRoyzEqOmZJ2SZCyg1d6arq/lbMskDmNdwsPTgqNRJJbVMEEKP4at368
         O05qe0ILLWhPnqxaU4ZlN5HVCkKt6QDrlSo9I4SA8SyxbKocRUMPqYYJX9zlmuvtQZNn
         l87jAtbExJUh4qneO0s2CBHcls2Fl/EUXpagcnoWJ7xMmO5aQMoSAaLtE0ol179/mG3s
         MB7agCvsYDgnm8h3/yQX66mtiR1GIA/4FqwpBCBG0rDuXJNpaaK4MapERCd1iPpS40QI
         EBG84y2DV1M2AwUcSdkiVWwMsCxY7xualIA0THVscNjHwlczf9PNk/gu8hacgl/QUjp1
         I6og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791308930; x=1791913730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oKkGu4MISHQEsFFjUyIjKXrjUrAiNT5vrF+iXMX4HX0=;
        b=DzuzpwTrkKtcDnXxD0hn6+9TImm7VEOD/gPZJMllMEnmoAuwr3+WcTob2Gj1ovdhZL
         eqQSSWC4WpNbmKOjz24kYhbFtsNbDp32zvh/xmzYySlovLdpd+rXQb+4d7z2f5DjXFKT
         bxEvC+MjpsQgZj3dmWAwy9WD/Q3Fp80YQ0A3vYXYVsY1aUJ94fiexwxEpOq8SFHX1h+h
         12ZxVGmwdAdfxYorAXNo4fHNKJfr0E2lmk3m82/4bkunhEYRaqHvEIzWftroYAsh0ecg
         qnXhnvrF4RZ9s4iQMmZDeo32fxyCASjScRVd1sYnpQ+Y8o5g6xmvsmwetNMKYr2qyW2G
         r+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791308930; x=1791913730;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oKkGu4MISHQEsFFjUyIjKXrjUrAiNT5vrF+iXMX4HX0=;
        b=UoWI6uOPj0v2WDBF3oNRw3DlD5TX7gjLFyCp9WuvRGbdBiX7vmV3iffHc7fzlTMdbM
         EusCTnN8xUwLAtOt9Vt+tGBx4QkZr1zIkqsFMJ1aj5HIRp5pYU3ENxMw61cVtvZiihqJ
         yLs4ewZ1/6ChY/LOtxMMsPBOJJL/zxxwTSeOS4svsdFv2lRwfZ91lTM4PVNPzHDomRw+
         npYTnpkwtcRCwhiu0a2q16a2w7vqamg+aOzbZS0sorshp43pf91ec32DOfEk6tjxkAgK
         y2bLSvPNvuADjf2XKVjZpnIWs4QZqOXr/IVWOQF3ncH+LZP+PzQDkmAsgb3Tl1sqmc9+
         tphg==
X-Forwarded-Encrypted: i=1; AKwUvBzC+Mu4FCnWEw5iVr7JrlSVLTaHiYFOCuncT4sx77YOE13a349fTk9ncOhj0pUn/Gco7X0=@vger.kernel.org
X-Gm-Message-State: AFuF++mKmXZ0kS9Tta/LVmWfR0D9wFRX+ZoqtjDhxckos2xRrIJX9/UX
	f+bXLqO2SjMLOtedO56FOggJCcjjQHlycJbs92sxa4evXBvic8Y7BXiKn/+IDg/6AH1H7uPrc1U
	a4rus5Y1FIWxBHcGE/QC0Npfo28zpTzxN4DkxN8rNxA==
X-Gm-Gg: AYBFou2UKFZOBwPMe47e8Y+IBAIYJ0grIZU1WWKmTRdG/VAErJq7KOu6CG4zVQPFyhy
	7rU6/F3XCGNn0cMGhPvwXJOXT/xNosDEMDh2+IFYEni+sNEgNsPLPAxF+mxtZr8Md/k9FgCArPM
	TcYZtIYZOxUCddIAX/UOmPw6/+TCFFQgfStOEJUIcd259j6k/NEw8SQjODMTD4v/I2vHQp/CLRj
	ktXjI5OeFYWwVgSOFXnt4la4aAEPiwGXmFWH/1dsFKOOT03uBMS7gZMShkZNGDBKTLVBkcAdAOX
	7PJVJ3p/SGKXOTkLuw0FRdFULOhyu8MhzR/J4FFUhygUSHgcpz0Oo9QTxb9iMT4VtmQJ0yrY6dM
	URuXnZdhGwA==
X-Received: by 2002:a05:6808:e305:10b0:4f6:a504:1897 with SMTP id
 5614622812f47-4f6a5042d3fmr7722009b6e.13.1791308930476; Tue, 06 Oct 2026
 10:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006173241.65945-1-tianyi@cloudflare.com> <179130839329.2231598.14859340679278349582@kernel.org>
In-Reply-To: <179130839329.2231598.14859340679278349582@kernel.org>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Tue, 6 Oct 2026 18:48:38 +0100
X-Gm-Features: AclHuK8tusQKzC0_fjG45JZf9NjrVrFoAQ9mJo_jQw5ddNkxc7dATehHk_JKOlk
Message-ID: <CAG4wq-eXM-mbZ=WOzL_M3u=yYm2YMoxshCJPjDqT2GB3FL0AbQ@mail.gmail.com>
Subject: Re: [PATCH net 0/2] veth: fix peer NETDEV_XDP_ACT_NDO_XMIT after GRO
 is toggled while down
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, toke@redhat.com, 
	lorenzo@kernel.org, horms@kernel.org, bpf@vger.kernel.org, shuah@kernel.org, 
	hawk@kernel.org, kernel-team@cloudflare.com, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I was testing XDP redirect from a physical NIC into a
veth whose peer is in another network namespace, and found that the
redirect worked or not depending on the order of enabling GRO on the
peer and bringing the peer up.

Cheers,
Tianyi

On Tue, Oct 6, 2026 at 6:39=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
