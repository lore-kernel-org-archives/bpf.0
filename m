Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA4C2D0607
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018886; cv=none; b=ULiLMag0IHkf2Sdz/Syn6UqFC2yu/QBiW3+JWLCNht9DK6hTBF13O8nrfmqjMY4+96r1lK1yAZBcsV9/YCmhktch0DJWU8a53udr6z0/QEJUnhik7y7jiuNRomLtNdRlfcWO0uEmerXu2tJOpOgtTDIZXMK0XBaH6u2sBTZzu1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018886; c=relaxed/simple;
	bh=81fgBQ2PoBDRpMrjDmaoSF9fxh4ImUjoFWIayUMvmSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbIpuknNG8EKWK8ikQOrrOf19wbj5e6ZVD6NaGFNBI9WRLuGZhSM02c1QsCOxLvKl6WulcHlB7bM9mheuk4YjbdKS5uNySmc0sTDBewybYKmXUw6Tr7Pspq4M8yKxjAcEiq7TBDusYIVDk401Hy6t83MJXIbucQiocCFfJZz8U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyNNB64P; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyNNB64P"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d74dbfe84cso1423083a34.1
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774018885; x=1774623685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+O+9zRpBumJjQs1Qrw2RwnISTo4eF51n2sz3tSLML3s=;
        b=GyNNB64PuGEBOqrvvoQG3v8Ini/H+i7p2Mtl1wv3kgLDxh0+KhJheSYhv8VQc5rEAG
         eBbYb15Zf2ekTiH9Xb6cR7Gg4RhpJhNf3OgaWtM5SRKYAODcT5toaAOM86RdD85dUDrJ
         1F83oTFTy2uCQFgtJNkE2Cnl+JA3gqC4Cp1YAeSdclMqpQE55XBMFNJotNuPOWKKNY+c
         5r4nndlK55DG9TfMf1K9h5INhdVa55o46eahwRCKu5DBi29c64tIt8pcs342s/pcNmoA
         eDWac1w7lk/Uj4y78M+iUwbm3O2yFcRvpVnrvLd7GKFNTtU+xnamryhB2PuNK7XaFWCZ
         5gFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018885; x=1774623685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+O+9zRpBumJjQs1Qrw2RwnISTo4eF51n2sz3tSLML3s=;
        b=kaxIm9P80USyFZAI77xHX2KqFgfAYDwzWpzEuTIfAIoMKUwMbL8BOdD0rp6AqDAZiz
         GA/MdvnufVA1sbnIy5qX7bPmfazWIlWUqqf6Qz9JgqCHF4yiWEFKw7jD0KZoD/EN9ah3
         Rmd1IJe0nb76B6q2X/hxrzXpHgc+zA/p8Zj3CQd/IXyx0w1UTZG2lMAhCN//XMepoZt7
         kTr14tNIwAjOZg7tO0HMkoYRHLpnbORooihNwgQR8j1lA87kfZnMEhqRLPM5l8LekRB5
         uzy6fGZAqOjK/8ve5QeT+duV37OXY01foVNYYQy8TgYrGEsJx8iDNB9IWN0TyCENUpKC
         HIiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWamNM8egxnIYh7fJRKwzJusDX2A1P/WGqjkmmcYrTRRpY+olGkPAhX+o3hdELnfyscZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPnpxJT1q47mf2GyRDBTWskU4MipdmiGuEJVzuOC9IjwMdUM2M
	avlYvutmAQDySikEXFiyHITBMzSp4LM3wVtImVu2XHq5VM+Q8JUS1emcIGEl
X-Gm-Gg: ATEYQzw44Z8g8sFnxQcvICCefG9Bs8cpdrMOZTcKQMFlgLA0aqDRXqBNSntxpSffVYY
	crT/8E/cpaRZ5QDJ/SmLsA3zk64Ei1ZTIs/67vxEKEaxNmmSazkzbQ+k0SOp+O97zrkaSkMP7sv
	UmflfNPhAlWaKosqW+hwUxx/9P7ZSa34u8pUIL/tiTKUQqxcVZNh0W8nRBk0YuYlLcezqs1Jgfb
	wIDD8xnqjHTlKDcnwFZA+9+gthNS+Mre432C9X6eJke+yoHSJwVZ5okpHwErGBLfnayUVx3F5qI
	KSca6SSLTQAB0eIWPi9+bZASYEJOQBcYPSWJWi0lnnMovTrfHd1pjdr/Vq+QR8X4GqlR6potKDH
	dr/FsgWJfA968c6eHX2+64/15+i5W6RsQeRQL+EbNaCsz7a5+GhjouXvkPW9M4vkWnHT4r9/kAm
	M+sVHlOg96GMw5z+vtXjMZ2v/XO13TBXilMqU7aCUpjkc5pVSm0fDQmnSU4ZlyEvy2ZNu5yZvP3
	9f7o4fY7wkVAuorMQ==
X-Received: by 2002:a05:6830:67d9:b0:7cf:da97:57d6 with SMTP id 46e09a7af769-7d7eae42d5amr2059854a34.6.1774018884112;
        Fri, 20 Mar 2026 08:01:24 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadfcf3fsm2296061a34.20.2026.03.20.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:01:23 -0700 (PDT)
Date: Fri, 20 Mar 2026 08:01:22 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	larysa.zaremba@intel.com, aleksander.lobakin@intel.com,
	bjorn@kernel.org
Subject: Re: [PATCH v2 net 1/8] xsk: tighten UMEM headroom validation to
 account for tailroom and min frame
Message-ID: <ab1hQjHMj-LJJz0I@mini-arch>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
 <20260319175538.479139-2-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319175538.479139-2-maciej.fijalkowski@intel.com>

On 03/19, Maciej Fijalkowski wrote:
> The current headroom validation in xdp_umem_reg() could leave us with
> insufficient space dedicated to even receive minimum-sized ethernet
> frame. Furthermore if multi-buffer would come to play then
> skb_shared_info stored at the end of XSK frame would be corrupted.
> 
> Multi-buffer setting is known later in the configuration process so
> besides accounting for ETH_ZLEN, let us also take care of tailroom space
> upfront.
> 
> Fixes: 99e3a236dd43 ("xsk: Add missing check on user supplied headroom size")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
