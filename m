Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E839443
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 00:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104083; cv=none; b=PlhaeEEQhHRyUMSeavn9aMbzS0oAtICc8o/QShLNbH/FBofohA+w8XcP7eI5R2w1jPNIhvzP5ktMzIfp2fA+me8G3h1WKn84TdfctAJkCvWamfJGfRuJbXa178npdhmtVqVdeWnwy5/uw19TocYOVgyWzEC3F8JeaMxy7yahTQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104083; c=relaxed/simple;
	bh=q/3n1xERGFt9pBxbxus768OlQpVMYV691SqiPTwnCNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qF2/McQuv0fDcmNmtseCgSk2DAHLFov2XCFCDjPMBP09D/HM2y23DSyBtG7F8nLTVmWcPC1/ufR87EjUrVtNTRtPpR+nPawgT7WQjxT6qALK2TTpqn/UIWROzJ+S6LMVMlyU239dXCW3GKQREbH7PvvgB5AW6NjHfiW5vPuuIT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=CBZ2lG81; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="CBZ2lG81"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c7393c6832bso1688022a12.2
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 17:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773104080; x=1773708880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgT23yH044LlGG/ozIQ2ZblhH3i8dVPmq39iaq5VJ3s=;
        b=CBZ2lG81bVnNT7LA/ta8D0fvNT2TDXGpNjSvtvazaOwRtHN5nWBk8Oo+JbJ9zhIeaA
         aCz4q9UQz28WV/E9zJXXXcr3xK6wMEfoZ9DFDNIW/QDsDXgTNwVRUPIzK4elvUT3LydJ
         HIaqTRoIYfnj/xPYUtvkgwTHci7hu08LYUHZiyDl+gXz8lSEDzyldtJKM3mkwgoFygv4
         xy3/8I9+0+njhiqGv4btzbTbKWxSk3bhsGCy7VnoODoUDbKhiLhl2qJuMgXglE1QgoiA
         MjADmZrbYXFp/g4KkT1Rf9Ero1slR2P00AcuixHPNEfVXIKq5nve+rGR1Cfqvf4+R66A
         NSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773104080; x=1773708880;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgT23yH044LlGG/ozIQ2ZblhH3i8dVPmq39iaq5VJ3s=;
        b=NWxI81BhFXx/gv2jLVfI+9tShnn0C/L2Ih3fSAFqbuWr7zbUNO3OlLsLZot6cVMI4y
         WHU32QwI2LKinF46uNlPnWKKr5Ke8BuQ7IdoMRAbKCTAd3VXrQ/tvA8cqcVaMTg5ilUq
         lS7ZvYOG/rNgdEix378ZTA4uMpQK2PFph1wcPtw9DvAnc+669vnfjUlJdTnodwhxrzxV
         naczv64tp4xuWhCJ53cjiQOUAG+YzsK3R4209sCZipc5oXCEZObySIziy4QfCNAulVFG
         B80oIVt4nTrWCfCefFUrPnO2XsBZibvd3pGFak8hhDrsEFioQpx2SrRvEVcbPlFVzQGp
         sb3A==
X-Forwarded-Encrypted: i=1; AJvYcCUQYbwE1d21vH52agE1jgcMr8PN/Nkypfrxyko2G2jwv2GBg/hnvXuriS9TDDL7+loRxqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6zBtGMYenB4JaxBsRiCL8q73aZBe4cPRY+zagoGzxDTWxv4lX
	aMmH0YWksSFs9dZrm2VgxsfBi8F/gpraaAuvcF75NwHm1w9UC2xuapvD7ncIPmwH2+k=
X-Gm-Gg: ATEYQzxDhn51vmR/61fvYJekLMcJPa/kL1yiDRejrhL6IO9wlLVqoWnf5Rm3dtPQt5K
	PD7g2BEkQmDHh9sV7ZkHG837lP7LjX+3GYiuu/4lvA2cguW3lMNvdaEHjPRti20Hv2gnTPG8EDW
	Mlfy8ZCcm7fQmBAAteDncb7C8u22o5lmvmv1A0c0521jA2Spe0XyJ1liHkeE+EEap8E0O7MAuIt
	Q35l90HnXizqaEYf+Wx2eOIE5CrKDCqj90V99WnnkaCZH9vXo+6nSYkJrytwfbuq4JUyWF3Xyb9
	GEh+xXPqVXt3DiJz9PMojxDG4ciW2WuLlUCXIlp6ifqUX6InNfAzwTELLVMFQIm8SIhk3/ScnSc
	yRrZ58BTM47gtTo/eG+Zm8319YYyJfO+ks+yL2itk+OJoZvjxTgETM4QLMsS4KHYxvIAuMdCAnh
	/ZFsY=
X-Received: by 2002:a17:903:2c0d:b0:2ae:5bee:f0fd with SMTP id d9443c01a7336-2ae82530643mr146551245ad.51.1773104080629;
        Mon, 09 Mar 2026 17:54:40 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840c9967sm167614145ad.90.2026.03.09.17.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:54:40 -0700 (PDT)
Date: Mon, 9 Mar 2026 17:54:39 -0700
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/5] selftests: net: move common xdp.py
 functions into lib
Message-ID: <aa9rz54M/NXPvDbw@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
References: <20260306230600.1628196-1-carges@cloudflare.com>
 <20260306230600.1628196-5-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306230600.1628196-5-carges@cloudflare.com>

On Fri, Mar 06, 2026 at 05:00:19PM -0600, Chris J Arges wrote:
> This moves a few functions which can be useful to other python programs
> that manipulate XDP programs. This also refactors xdp.py to use the
> refactored functions.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  .../selftests/drivers/net/lib/py/__init__.py  |  2 +
>  tools/testing/selftests/drivers/net/xdp.py    | 95 +++++--------------
>  .../testing/selftests/net/lib/py/__init__.py  |  2 +
>  tools/testing/selftests/net/lib/py/bpf.py     | 68 +++++++++++++
>  4 files changed, 95 insertions(+), 72 deletions(-)
>  create mode 100644 tools/testing/selftests/net/lib/py/bpf.py

Looks unchanged from the v2?

Reviewed-by: Joe Damato <joe@dama.to>
