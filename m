Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE1729E116
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777898604; cv=none; b=jD07MVQ/P/qc9nR8zJzDgkmKDm24VCgmaB4kxYCBYmjZAwtkZpy4XSF1UpYJ7e+Ut8ZyrHCvM7wRqHHiEHYsQy7o3W14SLiP/aMBvytAnj3ri7KGVAynamV7nJINuheo3YiZIeG6tsBC8fWdRFKYNzkND4PjQemvsuU1bFhmwNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777898604; c=relaxed/simple;
	bh=jWGoglP6jmcwlrHvt1gQ9/+zWIwt0vegzHr25BbK6cc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ug5Ow1BmepDYYyCiWMU/zdrIGH1nf+0Vy8XQrFO9vLuB8Fg8Qe+DbLrmnBPaHbpMkgycnIbYwGhLgivr/Wx5fHR5fXaw8GRTTdPxfhtJje1fXqWbyThwDd9HSJCjwvLHWTM9dIhVJeGzVpgd2Z2TvvWH/fEdxYiwe1aIYVJwrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvLtTlsJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvLtTlsJ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48374014a77so46592965e9.3
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 05:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777898600; x=1778503400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ufm/8wyV7h2cWwxL5F4jbAArsiyVqXQndXIOjfMIX4=;
        b=XvLtTlsJ9uh3K33svRXL/rWcr2sD5q3Xga6b5UTIeCDK0LNib8hVKkfBTGtUmww0/M
         WoKK8s8TQdmUbdOxi8ywztkLLraGkG1nG+bUb5ZASV5SwteD8gFcQs8+2K6vDMXpOOok
         klki9QE/d2fWuF8JQcIHyyMjxdRdS4KTQB9gSrYmpvSc6o90dKvqDW584M/CjZxa+8xB
         LG2mgEB7bUGvJ3XUx2+cCKLgauyRDQyHHsq9HHlU+/63Klhep0rDOgo7cMrsuzP9ZAw9
         lHYItr+KtzOk/AQeaU6GxYZA4zLPGwN/BXSgogNGA51dQBxgN/F0YEykHtwtR7ygbykd
         hjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777898600; x=1778503400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+ufm/8wyV7h2cWwxL5F4jbAArsiyVqXQndXIOjfMIX4=;
        b=AF9v0uwmIyfW5lfiZNprlc2J2l89dAo+QcAfSjSkFvAL56gVna5v4bFg2ULi2zBEZd
         fdZyfeV/3gUQdLCmkJ5ZEDo+4FHNFYyJNscZuYLL4kju2avshGc11+OvYpkqbz8SA+bO
         P96xzX/egX3cwH2aOXix4IyAayQM1v+GbAJKIrkeDYU+qTj87dDdNVl1zEpTPTMhCdHY
         cNbgjwdmAE3w1aiA9mkYJTePZhIhX391qaT1MGiGx3KnBO1J4S0+NxUvabWsxtQXhUrT
         ySy8C+1NShj5oi3pJAdkC+M/6kvgNbkD0aurQBP3MrfZ5/5zKH7wRtD2KQKc1lQcWFw6
         +pJw==
X-Forwarded-Encrypted: i=1; AFNElJ9OuV5ROAI1i/41v5ntC9XEXSu0SvrLSl1rs7rVgh1BkTRLDsdiQrsCIxgM38j5FTNXjtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHsvmrgDsRZooe+nZxO+UDbugH6n58a7q51sMEBafCG+jo2EIt
	FgA/HN93VmDTnvF0VPHcPBjMw6d2GS83PdKHZF7VDlQHLYWxZktfno1d
X-Gm-Gg: AeBDiesIhTf0pmmd6J6Gf8bCFFTw4g9dJPDyW5gCZooCXCwIgZR2twKy831wEDUd6Y0
	y984F3/9VBCyUYfuZOLxRpIViA1W8OPFOLucWLKOM1Sp3TUky0iNFuoGZmR2DymNZ0LhrcQCiSE
	qWegl9VE9QluV3HZkCo5DmTs4WgqOwuqPWBH8oWVejZGbLeFU6EzlJ71On/i86quQQMmiz1kdQI
	Pi7+w2zmUCUCeGgOEYtzITG0C6VyfP9I/FUu2XaC2X1YmPhRj9GLPZNEr6Ufdjtjm1HlK2pCxAo
	SEB/y1qyuE7YFwU7TZp5uKrY9eh8lpBxeeFCebSHS2XbRyDOh954AOJk0Cdf76iXG/4U2NMpQjy
	akYvlhvVSsUY3bZss0jyKBiWo5oQaNjFK9FGUdwfiuoUbtEvBOyc7AqOfsasIGlhhYU66f3Aqib
	ICR4LcM5RJe1HzecCAUAok/A1/zC2qorZ+3b+A1SoNo6mwFO2FFhuAxN4dOCOlcKaSykCPNgzIi
	eU=
X-Received: by 2002:a05:600c:a411:b0:48a:7b55:12a6 with SMTP id 5b1f17b1804b1-48a980fc3e7mr112517875e9.0.1777898600087;
        Mon, 04 May 2026 05:43:20 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fef2a67sm111207925e9.5.2026.05.04.05.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:43:19 -0700 (PDT)
Date: Mon, 4 May 2026 13:43:18 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Yury Norov" <ynorov@nvidia.com>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Ruan Jinjie" <ruanjinjie@huawei.com>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Linux-Arch
 <linux-arch@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
 bpf@vger.kernel.org, "Nathan Chancellor" <nathan@kernel.org>
Subject: Re: [PATCH 1/6] lib: include crc32.h conditionally on CONFIG_CRC32
Message-ID: <20260504134318.6eae8193@pumpkin>
In-Reply-To: <ec4ed7f5-b1c8-49e4-b83d-e29c5414b9de@app.fastmail.com>
References: <20260430211351.658193-1-ynorov@nvidia.com>
	<20260430211351.658193-2-ynorov@nvidia.com>
	<ec4ed7f5-b1c8-49e4-b83d-e29c5414b9de@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 May 2026 10:03:10 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Thu, Apr 30, 2026, at 23:13, Yury Norov wrote:
> > Currently, bitreverse API is either declared based on
> > CONFIG_HAVE_ARCH_BITREVERSE, wired to arch implementation, or if the
> > arch has no bitreverse, based on generic implementation.
> >
> > So, regardless of CONFIG_BITREVERSE=n, the corresponding API is always
> > declared. If that happens, the functions become declared but not
> > implemented, which is an error.  
> 
> I'm not following that description. Why is it an error to declare
> a funtion that is not implemented? Isn't that how optional interfaces
> tend to work in general?
> 
> > The only header requiring the crc32 and bitreverse prototypes is
> > include/linux/etherdevice.h. Thus, protect inclusion of corresponding
> > headers in the etherdevice with CONFIG_CRC32, together with the only
> > function depending on it.  
> ...
> >  #include <linux/if_ether.h>
> >  #include <linux/netdevice.h>
> >  #include <linux/random.h>
> > +#ifdef CONFIG_CRC32
> >  #include <linux/crc32.h>
> > +#endif
> >  #include <linux/unaligned.h>
> >  #include <asm/bitsperlong.h>  
> 
> Don't add #ifdef blocks around headers. If the header cannot
> be included without side-effects, change the linux/crc32.h
> file instead of its users.
> 
> It looks like the problem is the check for CONFIG_GENERIC_BITREVERSE
> in include/asm-generic/bitops/__bitrev.h, which ends up
> hinding the generic___bitrev32() helper without need.
> 
> Simply removing the #ifdef there should avoid the build failure.
> 
> > +#ifdef CONFIG_CRC32
> >  /**
> >   * eth_hw_addr_crc - Calculate CRC from netdev_hw_addr
> >   * @ha: pointer to hardware address
> > @@ -291,6 +294,7 @@ static inline u32 eth_hw_addr_crc(struct netdev_hw_addr *ha)
> >  {
> >  	return ether_crc(ETH_ALEN, ha->addr);
> >  }
> > +#endif  
> 
> I see there are only user users of this function, neither of
> them are performance critical. So the other options would
> be to either open-code this function in the two callers
> and remove it entirely, or move it into net/ethernet/eth.c.

Or change to a #define so that only the users need to have the
required headers included.

But open-coding in the callers saves anyone trying to read the code
having to look at another file to see what is going on.

-- David

> 
>       Arnd
> 

