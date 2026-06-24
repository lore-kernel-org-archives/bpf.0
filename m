Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB04828C5CB
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338394; cv=none; b=DUexnrAFNzYyR34UchMwV5KE7N53mLnH3X5NAMIa4LOaa8/1tPoEZg75IkaXkp28bu9kbR36OPDPBCG6hECPolQmqI3epxUP6iGlNuak/qZFHPlFFJFNzHagjoAT99/Pw6eMre8NRkm91qcT5qbfb1dr689PlJxCFi8xddghs0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338394; c=relaxed/simple;
	bh=h+OydAedszTH445JQMgZ+upnFEvuyx0391pi32Sciiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrCYfVEUYDyQLxm/dhebzkZnBABi34VRvThpICjqXguL4WRNc6mFJzPFr81GFvLt//Ay/oCaO9MQoxO7Gg+YdwwGlHfwM5qDj2pntp4wasjhJeXPwEGJZ96Gqa2eoaj0x6wUJ4Y4ctEyXP7Y7A/jnF1EVso7cRnJ4pqQdlYmWUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTB9zJFc; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTB9zJFc"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-46019b190b6so1302749f8f.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338391; x=1782943191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uk4j+NCOVK1y3rM5ffoDmCbin5eAq9ei9VnnP9xZjK4=;
        b=jTB9zJFcCtPfHUo9WuDGukgRq0HU0joEIeNkO5lAytRp4zpmH4iCr3ZBiX6UCUKmm+
         wd0bhC9OzXrspxKW1xXRaFDkv7rcPHOVZ/ee7OKaPkMCPC+s4wsfx0diJSZxp6jnpnBF
         Xf1XI0qkAzpqgaKTwKEIEXsspLgyC6oXa7yfTPFqo8Q9u3xvWCiERFoMJ2pLXfIYUt4C
         kCKGmmjGcrHT5bvyN6x5s2KcJaBMO0kntN3uno14Qu2C6z3AcxtKWvSdA3jpLpwexITQ
         Djj8ccIIitk5JeV2Ul2PvjYAQDMHONfRoNvLpRaCjnXBHMEQ5snzj9L+fY/BvH0FtMWv
         lywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338391; x=1782943191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uk4j+NCOVK1y3rM5ffoDmCbin5eAq9ei9VnnP9xZjK4=;
        b=tGTpva8YZ26uy7KcKrIzxId0iYzfx+b4sLEJ4mamFRhqRnl55/tBKPCjCfzdHUK+VW
         7r6WzBCwJ20JEudGO2IfvetQrLSU8QEODsd55zNOtin4OslQ3Vm1w+/YevG42fcuzDib
         kxTrhfezAlbYH//pWAyZusO3e1c7U2GtCBuSJJDiEUvI1C3XcUSXdISq+ENpliHCn2qP
         4da1nkf38cX+7kE5Zi/mBGmRyEox25Wr+S6YaOmR87y1MI1hqm0gBkIrT1UF1vJRa8g2
         A+x4Iq6ONpXX7rpvKZGBTHBExXtKKV3+xVncBsNuBiTTr08vF/am3M8J3amjeH/WeELc
         us6A==
X-Gm-Message-State: AOJu0YzUVQlWAXKUXkxawIgPa4ERCNAtIrMPMh1/6117XeA+SjklJrTB
	L6tmSS/O7HGJ/KVQAv1ODiwph5+XQvUNJbQmcmzRwmiYJHUs8IHs9aeT
X-Gm-Gg: AfdE7ckIPwoJEC5dBsNSphzYuoYsRy1vbiKBjdSx9kmFhGFEBMgDu2/U+Oo8ObZ5uT9
	RbzzV2jBIO4IpioEMy65hMbmIve7YnDXz1m8RuFoKEZbah/CxiOUssNbVv4YE0KasSQzxGtJxem
	+LRlA+SnKYZ7YXV9Z98BAmbPN6fD2NkAsk74ms5Iwe7n6Nx6uPHi7Ywcvs81j3ii/gRcDi7DDPG
	l45E+xiFVTw5YrnGstrjdrtnwMfWZ0uwElm42M9sahkbx+jvOnzEKUFQhHSJMyBVDTz5WPW34E4
	HFdsizsgK1LONf6HIEoHRGAp7ZVu0B2gX2wy/A/LugHwFKjIwVMmDQ6U+tGvu8EM/TaqCdtkyR0
	W/qdUw8/3qrRxNrstrzKPnLPT7amBJ06wwSEZNwA6k1+uZfmJ/vo8gsUVsKS91YOHofqeZOlDJY
	GLV0F+f6pBpE4iWsIB45yW0BPa7czqf/g3STv8J+CmW265Ntrskt6C+leoDwLRuTWPEH5yJuoBT
	5nzQD+Qeyn0Hpw1yZx7EH0FMB8T4XjFGvYVMNzUq027wCLr/H4WTfwcZ1su3lG0zIVVOuWU8V1/
	fzm3D555667sWZsEF/ZII7DCoHdXTaHJtOzR+Qxb8fI=
X-Received: by 2002:a05:600c:5491:b0:490:bd1d:4732 with SMTP id 5b1f17b1804b1-4926087361fmr76202125e9.23.1782338391110;
        Wed, 24 Jun 2026 14:59:51 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0046ffccb749d01d87.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:46ff:ccb7:49d0:1d87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d9405sm11485640f8f.22.2026.06.24.14.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:59:50 -0700 (PDT)
Date: Wed, 24 Jun 2026 23:59:47 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Jordan Rife <jordan@jrife.io>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add tests for
 bpf_redirect_peer with BPF_F_EGRESS
Message-ID: <ajxTUx8eLYM2erU4@mail.gmail.com>
References: <20260618182035.43811-1-jordan@jrife.io>
 <20260618182035.43811-3-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618182035.43811-3-jordan@jrife.io>

On Thu, Jun 18, 2026 at 11:20:33AM -0700, Jordan Rife wrote:
> Extend redirect tests to cover bpf_redirect_peer(BPF_F_EGRESS). SRC
> redirects to DST using bpf_redirect_peer(BPF_F_EGRESS) then traffic is
> hairpinned into DST using bpf_redirect.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

