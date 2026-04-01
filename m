Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178C533CE88
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775078399; cv=none; b=EPx0nTl6HA4Xu98WWyoYY5LwzH2cqJz5tWW32ggmGfAg0dMr+atftBkIWSKliGdf8RozrkOkZzLxKzUF26FAqn4hfet1Vchg1lWitJFF62gRzLWUXgbSoVFNGbcOaZJ3bEPeOOFuqhHlHuToVSxXchovMR2NZYxDcXkzQdOng+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775078399; c=relaxed/simple;
	bh=PpAEFN40RhtgtGxfxNI2lVauCRlB2XaPeVhqUisQUJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTJVcRpTrtA4NmGYSWX71S0LD/o7jl4LIOz6tyGIX0MQprOQa/QwJ0LQTwkcq7SaWB1bif2D3JM9huRhvizQDBkGHA2j1aqKk/0OpmC0eajlzSUg2aDLw7QhbHJtkZZeHNjF9gsFsaQaErlST4SFVOU2Sij6Z7tAXIjk4KONvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGl+0P91; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGl+0P91"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so1324555e9.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 14:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775078396; x=1775683196; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D8D4qej7NW6rwpZ1OPzpQSnZh6GcRh2L2pi1OkwNFm4=;
        b=UGl+0P91xzuAYSMBTPybc3M1sXb4HYUobU1wrGqo0Yig4WPRzWXYNAwTtQj48MJ2lU
         eqmrDYmWcBxLhRffh9Gvg0lwYjP2e9oKnw11PtPfemSGgot1qWPGlGnohTk3KpaGSOfJ
         oCUFXesJj2CyN3k4PJ6Tj2cMeCIq7VoJw9REea/ZyQPfc6KM9HlgqaSejHwLMj43TGoV
         Qo2PcrkP4xzZQ50UKHB5XDLO1WTmVh+9DSKGSeN3uV5kNPlmf4jKwRZpEAXNj0vHH2GV
         ZAoj7c851s7iJntv0CkY78OA9PQiOvmgXUgQRrBu1FM0BLkBECqEuafrBASnT1mjDSwj
         pqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775078396; x=1775683196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8D4qej7NW6rwpZ1OPzpQSnZh6GcRh2L2pi1OkwNFm4=;
        b=P1s6PXQ28EZ9IQ6P1qUMe2p2K9pRT1KKWiQe3PcvAIIGpADGiMCD2hegx5rm/hQlHj
         TWQoxE0HRroev8EiJQ57LGOUK4Gjveo/LTZm6PgD4J9xem36kzIYAbRjGSSOnZikSamo
         2G6p1vyh+D7c+69KMp21LnczEWrXWw0dlk2pan14wA8zcrHVm9voyczE95OPKguW7UPP
         MxvNM/iHSo66fZRro31QfaIEIAEleJ2GJEQyarsQQ2Unyc3SolWVsKSWeVAYTYlNTajq
         46g1H9ysELAaIS+thLN6Aezt/bOOv8ksGTdoD7vNgHfIsATC9US+dkqQVGPKvcPUchOk
         0JGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC4UsBeLJUZeZHybrVPKm2I0jmcnDqxjSoSWd8/YP/zBgMfY+EVkKNFaTKIP0Ak4GS90A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxlwgRY7acEedwvtAyu7gMGz4J55QoiSS4Vu+S3uIwI0jo1dVU
	IvqouL6WNOyoUoePfzcbySngAkF+tQQ+KA7LjcQwijtypKIRUOVQUnjWlxGJ0KWc
X-Gm-Gg: ATEYQzwhdhswFwhto39V2JWRTRkrIBbQJ+AEiXmLAR7C4voAKWhYjhRKF5SmxAzFIjK
	qu2+d8guTMIE+Is53pAnOz7/lyJKQNDzwZQW/AXczwCzp5l+2ulCaeWbx85PWvxzJancjllZ8dl
	ohd9nefEtzU6THjxiuFa30iFZ77ey+glS4TUuVD2gIzji1PpLAWDNYXwbc7TMtAYFZuM1gamS3H
	TVkfZSa5xFMrEF28xsJKT9dWy06+tgmjKEVv2khz99nSyq4NkdKSyv5ZbXiZvp7IUeYL4VoZS46
	FDs9IZIAwmY+LmqLq6OuHDyprwlRORQzKuykNEIuvJTp91gUxXJXm1Djsa1O+0eo+LS8oFp1+x0
	CnX7unVwP7dk1Tc71FYWTWqDGB7j65AAu0KqYKwyyeQSne0VVJBYjwsBerCq/r4ScYxlK+/ZTSn
	ic7BqaeMycH6eJ0NUcFOdrbr6cYDXylT5pSvBC8h8LqGSr1XMGqiGtVkANeqEZLncec9ruWZbWK
	ly1NsQ/IzIqqF43cnhzcc7FBUdsQnM1rCoNa1NQLyYrndBliL3A0iI1Q+m64b6t8Se6/f5NyiQp
	qoHDlsIpd4HWLRPciYb/n3DDXxg30TE30+UEn/b9WrpceJ8+NRN7GQ==
X-Received: by 2002:a05:600c:45c5:b0:485:3193:6ddb with SMTP id 5b1f17b1804b1-4888356a036mr87051755e9.3.1775078396320;
        Wed, 01 Apr 2026 14:19:56 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0077853c1cf79fe628.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:7785:3c1c:f79f:e628])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c7510d3sm70762735e9.5.2026.04.01.14.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 14:19:55 -0700 (PDT)
Date: Wed, 1 Apr 2026 23:19:53 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, santosh.nagarakatte@rutgers.edu,
	shung-hsi.yu@suse.com, srinivas.narayana@rutgers.edu
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: Exit early if reg_bounds_sync gets
 invalid inputs
Message-ID: <ac2L-Rh_JcZ16qbv@mail.gmail.com>
References: <ac0NvOIc7AhifyNM@mail.gmail.com>
 <20260401193637.14694-1-harishankar.vishwanathan@gmail.com>
 <4343ab08efc55d52b95f1618dbd367952f8e6a1b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4343ab08efc55d52b95f1618dbd367952f8e6a1b.camel@gmail.com>

On Wed, Apr 01, 2026 at 01:21:02PM -0700, Eduard Zingerman wrote:
> On Wed, 2026-04-01 at 15:36 -0400, Harishankar Vishwanathan wrote:
> > On Wed, Apr 1, 2026 at 8:21 AM Paul Chaignon <paul.chaignon@gmail.com> wrote:

[...]

> What are remaining steps for this patch-set?
> Here are outstanding comments:
> 1. https://lore.kernel.org/bpf/33c006d7275cb443b5750f062cb78c38449a7537.camel@gmail.com/
>    resolved as noop
> 2. https://lore.kernel.org/bpf/ed85ac25cd315ac4273de335943f9f3a2c1f36e8.camel@gmail.com/
>    resolved, only if inputs are in bogus state, will be handled by a follow-up.
> 3. https://lore.kernel.org/bpf/7vwyzvy7cwy2n4c52fcurg4dnv4bqijtovmkeh3zgu6ey266vc@dtt3r5usvev5/
>    Some wording nits, do you intend to fix those?
> 4. https://lore.kernel.org/bpf/847173114a13630e1512ad05375c6b407720a916.camel@gmail.com/
>    Will be resolved as a follow-up.
> 5. https://lore.kernel.org/bpf/87ikamjv5q.fsf@gmail.com/
>    resolved as noop.
> 
> Is the above assessment correct?
> Beside (3) is there anything you'd like to change or should we go with v2?

I think there were also a couple nits on the selftests and at
https://lore.kernel.org/bpf/87qzpak4wc.fsf@gmail.com/. Let me send a v3
tomorrow morning with all the small things and the acks :)

