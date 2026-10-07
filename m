Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5723F44EC
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384615; cv=none; b=HuGr4C8wUBtHRWe+BndVcgG908CK1ifqev+b5XtvItoGhRt7iOltNvA8Jhxu7SNKXTkJrCNRI9xHBYVhWGkVhSxO3fHLefxA1ZrdBFBiSZrw9eQLc5XuONxsrKbP5e7H9SrVx9wK80WOcgyXc1GGF7FD2YzBhrWUSlCJIch4XhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384615; c=relaxed/simple;
	bh=DtLW2TlvpGvM6hV7rxhC4fpV2L2eYZv026J/B1/JswE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bRJTLOfaIFqAbliTdKR2+5z8TDkD0IgsWIBgwJTOQVF2SwVZhhVXm1ZOhOxm53TVLuh68tMC0WBg0AUgxriDrFq3GihTkI/4PBajgHhniDsW5W43QSa2Gu/Ukd6rdx1S1nuwfSk8B2etcc3czzxkcBU7z/LIpC1zWPWPWoXLm6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdz264Cp; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdz264Cp"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b056d58f2aso14340497b3.2
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791384608; x=1791989408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R5S9y3rm49FcBbD2GVDr+s54p4RcgRdmhC0n7fWz+ME=;
        b=fdz264Cp2G8Z/ltyHdIO0aIQSkeYspGBR3kVFF/2Ks4+3YFIWsJUI3x2KlmWnf6WP0
         U8wXEbRCDfzMAsfeEvwFQ5xWZItwAvgSdXUKQ0wYqIfdGxsOsNrgdw+zz/0UlYDrUK+b
         Stm1zUFuHsKeYuXlHG2GrHdGtJGorQ3XR+2eWcSTquM0th9QDNdubXg9omqhP+02gsgV
         9hdcopXhkdgqWXuU0Xhu/S5vSqbRTMDR98GodN/YHgaLNZxdFfPS6ps5caVe+3b/gMQz
         5Nbr0ObPecxrNhF38cpixnYcnyaoD7U5GbHbnLcGlcOjNUS+ySmWHzamLhT480F8aWu/
         /hYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791384608; x=1791989408;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R5S9y3rm49FcBbD2GVDr+s54p4RcgRdmhC0n7fWz+ME=;
        b=sqpDKotIGyH9Q5DcpA+QAfPl+Nikb5z67iFUn2OndVqcZFkW96wAIJtGEFyylQnVMB
         /uLPQLreFWGY0DWPKEuZQ+7OhzTu910tmTzM1x/iNUQswsacKKJZKNYj8yb/mQR4F47b
         P2xOkxa+DreFIqA4fnM5mH3i9u4UF837avQc8Cr4xV55UobMZoAjBOqB5VUg0QswmNOf
         70bQM/xAqez1oa+ytKaJM7sfN+fqMlDStUHBudtoZ+DpiJh/iG1GDIk/8VoAtn5/jj0Z
         3xquxihxPw5RKbkQ/UyC1KGVJBZrRZh7xRZPvB4XXktMhsoQcc4OFqt0F8RfTwx0z93S
         wT9A==
X-Forwarded-Encrypted: i=1; AKwUvByl5IFMLeRTL+REwln30S6khCqANt/Ls+H/qTFZ7XoZIm/Lphb4oBN1hRDSN5qGkGJuWZ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzvP1krr8p///WsQJRWvWrbftqCu2uzisCzdspV3A5Ro2py7b6
	M06D8TQdEU+UmyyNsqW/kaLF74XDit2eoWQNCDe+XXMj86f60O641q+A
X-Gm-Gg: AYBFou1AykvHEnyL1HHA8TX8o4yKsg/CQvfdB17/TJ9/eVcwMBQvUtxviuTiHM4sLzE
	qXtBiyDESd/W4s1A3Vpnw6tK6muf4VDvGz0kCOao/570w/fUJUzjKcrGnTN/mo0oqogbMAFFJt9
	nggqSezGLoQ3b0eqzvpKHJ7uHQZiT1GuXQQnBdcaHF65KrMLty6MvdqeNNyo9U7sdRxmTGIggfD
	w4bzh8styA3izhavtv1jr+sUlz39OFL2Nac2DbgCq4Ikn+Kdnlkj0fEBbuDkaJPlLcBe/OuyyEL
	CDiLjzK/wBDJpZKCfOAO0HnYk71Y2BQvDRoDdgbZckYNVa64uUJBKiGdSk8z4xc+y7JPxSO9m2L
	xrc2Il6prKxn5D7PdM79rB+7gInRVd1HqOMJO025Y/PAbeseuwl3sbSCvdU0xx9+1ugDuoBjAUF
	L6JIdcjW6ALczpvs03YtunrBKcS2E9efnpboOhys3amQmq0xQO6tF9+f4ofHfNh4ok7xRziWJFz
	TGKMquenS67oN6KeF2Arl4lxwV/w3moa/9osfBFloq5OBM7sdGEUrWQm3+BIzCxKRaHqBo/D1az
	zf9wNxEF+MWWX81E5iuYAkM1MUpJ947YA5kO2A==
X-Received: by 2002:a05:690c:3481:b0:8ae:c3f4:3da8 with SMTP id 00721157ae682-8b05b172ff5mr16418657b3.85.1791384608412;
        Wed, 07 Oct 2026 07:50:08 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b05abb8b72sm9302657b3.34.2026.10.07.07.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 07:50:07 -0700 (PDT)
Date: Wed, 07 Oct 2026 10:50:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
Message-ID: <willemdebruijn.kernel.235bf1cecf85f@gmail.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-1-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
 <20261006-b4-skbuff-bug-on-v1-1-1b4434c5357c@toxicpanda.com>
Subject: Re: [PATCH net-next 1/9] net: skbuff: don't leave stale bytes in
 skb_copy_and_csum_bits()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Josef Bacik wrote:
> When skb_copy_and_csum_bits() reaches unreadable frags it returns 0
> after copying only the linear part, and the rest of the caller's buffer
> is left as it was.  The callers copy into a buffer that is about to go
> out on the wire: an ICMP error quoting the offending packet, or a
> driver's TX bounce buffer in skb_copy_and_csum_dev().  Neither buffer
> is zeroed beforehand, so whatever was in memory there gets sent.
> 
> Zero the part of the buffer we didn't fill.  The checksum is already
> wrong in this case, so the packet still gets dropped by the receiver,
> it just doesn't carry anything it shouldn't.  Only zero for a positive
> @len, a negative one from a broken caller must not turn into a huge
> memset().
> 
> Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

This should be a stand-alone fix sent to net (and stable)?
