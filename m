Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56633B1B2
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711695547; cv=none; b=hHW4aay7EctKbGz1e3Z6oB80aMh7fgIOewNLeQ97ZtUsf91h8RiheA7NYzSKxK3UpEdtZBREJUzGpA64Jey08KrwxB4eHbe0C42mHsKGO7aWGOPu5oLun6X5Fnj2kDAWh7873oeSx+y9r8RN7WvMyqM96s+jvR1iMpf0lg13Dhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711695547; c=relaxed/simple;
	bh=h9iH+NxgICqla6Vj+dParRCdvqnXOQckpwZGUKlEjpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8fjNV+y0HyRbDQ1nFVawkKuCpV34xrCjvLeTCrqdOWFvgs3p3C7oorYLcVMvK3Y8dqrBKO8ouYuv6vB4QUkNaBlbrZvbxLroVlNT206a7Qyq9Mn0GMGfYMKI5zbPfQoDSSVJh0t0ESPd3GFD6ZPzsAQNMtbRZiH+v3CHJ/hesI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=dslQfvOW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="dslQfvOW"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3416df43cabso1183688f8f.3
        for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 23:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1711695544; x=1712300344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VOjvoiA8FXc2XWbJRypxPluT3CeOZ4Wnh9ISuCix+c=;
        b=dslQfvOW9z0iHjaqV2BwWUQKpKdeiHEACHFkIntalTk0XeH9UsGjWARwFJAfKb1t9C
         Z9KyY58NO22NkH7HYbpo/FHK5Cpmhg474rrm+cUpO77VniImarN5X5d+QND0NDgKtJx0
         R6mgqjqsB4oJhCOo29dIbyaImScKdJYuJ10cEMPaZdgMVmhmyHtNyWbpLBTWRAzZ5Hvy
         3rGYnNw9sAbX3ZPKioJF0YXao1Uq0+Cv3Fpj3rPRr1+uLtrP5qKfpvxcs31hPWGXgXzr
         77usv0ik+O43Gcvez18XLaLNCfLTM2Z7ATn115G1c9weVI+fm0GfFLxr/qgvpXTPgciW
         RTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711695544; x=1712300344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VOjvoiA8FXc2XWbJRypxPluT3CeOZ4Wnh9ISuCix+c=;
        b=Kpc5d7mkz/VVKzebu7XrPvYs2RMvJ6WzFxLxDs47ldEeS+fSoyk6XriQ+N2ONepBSf
         5OINFZ1Gq5NwqwzWKrUndeGIsXBLf00pOJvZVGzOHOX1Ct3f1IstaNB+TuUKmYrF489Y
         lc5od/3am6CZHVWcWeDzvfpWp1MgzMsVUH/JhLsaCY8CXUzWzdq8WDvmE/Xbl97mK34A
         tgsKshekXa1soeqqpJiUS/6Axn1WpeUu5VYf7GgCa/dhCBHnwmBo0BzzJu2zI+4c8xj3
         3V4t10FU0WkBMsU6vFvdX7sPFsq/STZadSa1pyWjwCfljZb58BEsSvEVgAymucPg8FPR
         QcIA==
X-Forwarded-Encrypted: i=1; AJvYcCVjGRhyGN4ZVAZsMp5mgmpYpwsGzoQ4ILdS1/imxJLM3uGBX6D9+93fVnrCLx4W0d491lIQ8zriOLJ0tWzFdwOpmuVI
X-Gm-Message-State: AOJu0Yx+hN/Vh6ZKh5S3xXs4FyxAGfholkaQ/lQ30rWj/Pa2UXqm6Zfh
	ySSI0ZVZGeZPAvCLZUePb7A3la4IGgEn8ht57oyUFRAjee6QnLokWtPZDWaZ0kQ=
X-Google-Smtp-Source: AGHT+IGfwx+D4Dm21Z2pHTYDXNf4jBW17+Wbo8y3sLJOJM3sL0jfuUcTq0Was6vXO/kXpVvVfUY2AA==
X-Received: by 2002:a05:6000:ec3:b0:33e:b9df:8445 with SMTP id ea3-20020a0560000ec300b0033eb9df8445mr766966wrb.38.1711695544044;
        Thu, 28 Mar 2024 23:59:04 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600000d200b0033e03a6b1ecsm3476555wrx.18.2024.03.28.23.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 23:59:03 -0700 (PDT)
Date: Fri, 29 Mar 2024 07:01:11 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/1] bpf: fix possible file descriptor leaks in
 verifier
Message-ID: <ZgZnNyeKSyEMxxYj@zh-lab-node-5>
References: <20240328095657.1995763-1-aspsk@isovalent.com>
 <cf8d5e75-dc75-4f86-be60-013f7ed7c688@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf8d5e75-dc75-4f86-be60-013f7ed7c688@linux.dev>

On Thu, Mar 28, 2024 at 08:23:03PM -0700, Yonghong Song wrote:
> 
> On 3/28/24 2:56 AM, Anton Protopopov wrote:
> > The resolve_pseudo_ldimm64() function might have leaked file
> > descriptors when BPF_MAP_TYPE_ARENA was used in a program (some
> > error paths missed a corresponding fdput).
> > 
> > Fix leaks and also extract code which adds maps to env->used_maps
> > into a separate function. This simplifies code of resolve_pseudo_ldimm64
> > and makes it possible to reuse this code later.  While at it, also add a
> > verifier verbose message when the maps usage limit is reached.
> 
> Could you break this single patch into a series? For example,
> for 'to reuse this code later', refactoring the code (without
> funcitonality change) can be a separate patch, could you explain
> what do you mean reusing the code later? Do you have some plans
> to reuse the code later?

Yes, to pre-process file descriptors in attrs.fd_array (or a similar array).
See this thread https://lore.kernel.org/bpf/ZgWcsKZR23JIg51e@lavr/

> The fix for missing fdput() should be its own patch with
> Fixes tag below.
> 
> You can have yet another patch to enhance verifier by adding
> verbose messages.

Thanks. I will just send two fixes for fdput and the verifier message.
I will send a patch which refactors code when it is needed.

> > 
> > Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >   kernel/bpf/verifier.c | 150 ++++++++++++++++++++++--------------------
> >   1 file changed, 79 insertions(+), 71 deletions(-)
> [...]
