Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2413290B9
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 23:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785972875; cv=none; b=Sb9KArE/uRIrgz0kdNleMYPPIHNPO+Jg/iuSBbpjdBe9zSo/TmG60Ym/5IGx5CkHeZ6f4s8Svr0lziJ1bLhJ3ek0KSNpbDXR576c0hZHer5V4arOUoUynU61Fi8Uop049Qzec+TBaP40Q9rG67NZVrEmuLLqYH8rQ+5DfzP6L6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785972875; c=relaxed/simple;
	bh=zg/Fp3SPxz4DzWGL60edzGc8OVh33zlEF8lnFAL72ps=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G1jVF1WOAl+cHmoj09+MpwTvDkvcgsvYn42FBDceVvHPZVkYEwQXnEYWr3YFVaBict2m0x0G8oFDs+yrYJ/s0s9nwAXCqktWCarv6uklwSCYlCYtbQV2ZU/gezzR40sqUUxEalLN0bXZ0l8GzdPblHnDV0ffHGcfcFl/2OoQORw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrLGt3zC; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrLGt3zC"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso1047812a12.2
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 16:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785972873; x=1786577673; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qP5k8qaakhLWBbqj31MCAmlz6b82Li5+rLYZu4vQO8M=;
        b=YrLGt3zCho9kQQ68B7gVL2diV2qqDUDyczb6UyiZZnOzYikxiPa9DRMHgGi4ZQarFI
         bdJwlM2JSAXspQyg2bH9P/iPzkenSRiCjpPstf7+Zz9OhTLcuaOdiuVlwfEZK0BoWZkV
         vPmixrtBViXys9yu3w8E/qEQLCslj609YKJRDO9bWWkVsxtpE/LzKi5FEsHqx9zoqUJc
         swhjEMTdULlkK5IAzhwRzSECzlagy0glgOp3OWWPBJwluIFhCWMkgtY1KcVbx1amWxcL
         sOQfQQ/CE1c6R/5NibJfvRrAxovYRstaikBWpW1iy30EVldGot8VIQNCSPYzWRpxxc+0
         KLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785972873; x=1786577673;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qP5k8qaakhLWBbqj31MCAmlz6b82Li5+rLYZu4vQO8M=;
        b=MwOIVZOOqtFio5I2U6yE567PyU5xw2CQ867B+Jh2yfZ86krfzSXaTw5qOBU7d9ce/2
         BPW7OLgb2aMofSMvBG4IyDsU6+rNPq+LzTIMOzcRvQM+mXe8BmaHLHEZq5E7p3DsFUUc
         otS8Gx2m0dBlMQFK9O1s8LZEDsTU3csG/9WziF0bt815Eig2jYPUZqkqlCWiwKg0dNzo
         i9LI9VzEbw7HaWPLszRw1GkiabsxPmQIYn9Mw4CSsdtGuVdbifOL1p0FmLARKTkw6b1e
         1jJPXr93YVV6BAtLPjQpCdBrsizXPyNjACsx+iYd2fdTcL/ctPKd81f/hit+IRGNvTwf
         RrsA==
X-Forwarded-Encrypted: i=1; AHgh+RqirW2h+n1FnOwfXPNRoYToeBL7sL+ArNuLntVUQmRcgyxMho7NeB7YUwp2yiDEnLMxEdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyaIRYylMs1SBzUhaN87dc1uJvuSwW3YQwM8M/s+bLhgXxfytq
	5p69DXFTbQI6IwZ88AQnjQewLsFZrFiS9Ome8NfG1IW+5W7/Euo4poU+
X-Gm-Gg: AR+sD10yv/Mz0LxlZuHYC4eBYcPO3gOH3BaluQSBIv2SchJpqKndd3DXGQHblOmzN0o
	2x/7zM0sP7PgampMFXpR9WaZVsU3C4aZ9kxF/h9z7CLWpB++DBRUKvLCvPCSuKCddAyu7yQsaVw
	oLHE6zWlbqhWONuSrSEV/z1HZFdqrFPBrtGM/tKiEF1JKL+IN614cmloMesM/Q67zqVra0hfEqW
	ZDPBB8wOXp6Z8LsKC6weJUhrE2nb/7pvQIgLkbvGvsSR6+FddCBYnwkDI/UKqyWWPj8MkQs7awt
	7Vgjx1Nl0y9YjPeQM76gA/xZYwOGkEWdN18viMikbJQHk7qoGlaJTdCImlo4rJJIofxIXrqJcbF
	4G0sRduaYkDVHJgozFqTiSkpXgb/TEAUAWevSonDCA9FSnkZQyniWzMwuSq94bWwuKNi+GlYP5v
	U7Z2pBydlu2NwIc/LGQo5bDHriCFmYctavsoBS8b3xP2Q5EzSMMvlHJbT15J3y/1SXwPmV3SM66
	Lp27fLMtMA7hqe2slkmGfIBsXqToT/qjn/JylT6Mw5e
X-Received: by 2002:a05:6a21:6e43:b0:3c3:7762:5d5f with SMTP id adf61e73a8af0-3cb85e6afe9mr12595608637.19.1785972872863;
        Wed, 05 Aug 2026 16:34:32 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:969b:c0a:ff6f:454e? ([2620:10d:c090:500::5:b61b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586162e80sm22693200eec.0.2026.08.05.16.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 16:34:32 -0700 (PDT)
Message-ID: <9a2504bb38bd0760448fe483829c14e697a9b650.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v5 7/8] selftests/bpf: move shared build
 definitions into Makefile.buildvars
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com
Date: Wed, 05 Aug 2026 16:34:30 -0700
In-Reply-To: <20260804170156.1709916-8-nickolay.lysenko@gmail.com>
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
	 <20260804170156.1709916-8-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-04 at 10:01 -0700, Mykola Lysenko wrote:

...

Thank you for taking time to reshuffle the diff, such that the
Makefile.buildvars preserves the original relative order.
Much easier to review.

...

> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -3,60 +3,15 @@ include ../../../build/Build.include

...

> -GENHDR :=3D $(GENDIR)/autoconf.h
>  PKG_CONFIG ?=3D $(CROSS_COMPILE)pkg-config
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
It seems this can be removed as well, all uses are after
Makefile.buildvars is included. Or is it needed for one of the other
includes?

...

> @@ -220,21 +151,8 @@ ifeq ($(feature-llvm),1)

...

> -HOST_BPFOBJ :=3D $(HOST_BUILD_DIR)/libbpf/libbpf.a
> -RESOLVE_BTFIDS :=3D $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
> +include Makefile.buildvars

It appears that this include can be moved up, to the lib.mk include.
In this case the duplicate definitions for `srctree` and `PKG_CONFIG`
can be removed (and both can reside in Makefile.buildvars).
Wdyt?

...

> --- /dev/null
> +++ b/tools/testing/selftests/bpf/Makefile.buildvars

...

> +PKG_CONFIG ?=3D $(CROSS_COMPILE)pkg-config

...

> +ifeq ($(srctree),)
> +srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
> +srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
> +srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
> +srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
> +endif

In case if shuffling includes around does not work, can we export
`srctree` in the main makefile and not copy it here?

...
