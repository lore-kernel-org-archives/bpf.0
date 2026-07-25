Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7551CBE63
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784943571; cv=none; b=eiK8dIocIHFGwJKTxiExfxUtOOACaW/Fct899LA0NOe5zckxk6+tK1DNm9jS0LFqoEfB+X6+rkl9VQDtokQWfQ72SRftEj5VUp5LvUY+52hdY1jQwIS/x03SxB9tLmKQCgsdxsv249DGD5UY1weL/LFRMZgzrRKdUGnOzzSHi9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784943571; c=relaxed/simple;
	bh=D/oiJNuCYIAmvsAsnbKG9YJEUS/g7SfYUnOVzoyv3Sg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HtvvG03q45pMBl4WFwoL2H0cJ5rwpiUwVcL/rVSiCoUWhd2q4I2bRAr8pY5nqoTVNkKvXnq//Amc3/MK27RX1nVHcuFeavSr5gpLDPg0X8w6szUpjn+Qi5SaU1zcVDHg6iG20YZOCi7jdG1aZRO+3mr2EvAmMuyuDJiiGO0BshA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVQTz9q/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVQTz9q/"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cacf197759so14864005ad.2
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 18:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784943570; x=1785548370; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=D/oiJNuCYIAmvsAsnbKG9YJEUS/g7SfYUnOVzoyv3Sg=;
        b=DVQTz9q/q3ke0P/jn8mLTjQViHm1t7UUdv5ZK4vgZO+xufzFkhLOaDnpjPQPQhUR5w
         I7+wZLAeb9DCxRJZPfHbLj4+pPtnLSATH1my/2UXddnLJMBmHaStO4nGRI0AQ+pMEa97
         pHfJeMGzR2K3PwDdfDoh7uoK0yZiDlbw5b+zq/ltWTgPRHRSEFm3D0iStqsjd9ZWPS5J
         bSxCzZrtiOzmdwZJbAxy7ESnOXUbHVt2++8B2jL6chwm6757gI1xsJWIT235xhGkmBN1
         lnuLhXA10X5kGvy9Pp6c5g1xG1+/O/+YJjOPlaj1TIUTOAI5DaWVVAB4UmqThKfWJ0cu
         19Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784943570; x=1785548370;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D/oiJNuCYIAmvsAsnbKG9YJEUS/g7SfYUnOVzoyv3Sg=;
        b=FVAnV8T5JKj+51STX0+6Pi4oGj2GPPUTnmhIKe6GYe5ZFcwozyhwlivDRDbahVxFzX
         98duue7+cCTfzwtDr6MtBDjp3r+RhGowUMaOuL4yLGu5geh0FPlDQ9ANhxTG4NjcAxXE
         dz09wZ/6eQHva7ndNJHNjKazgk9W1EJiKTUbiw+Rj+YGlu0o+/sCIOn3ixGrV1Xqa7mN
         IIowBXtjGWDsZ237qtBFY9xMCJoiu3sAzcWCB80YYsiLjFzYa2MkScJ8+UCghADfKIb+
         10HFrOmZgZsrlkNihY0cpxhvuDC183xRlqrCKwToIo7tea/bVefhDILxQPZP8QzSEqBZ
         icrg==
X-Forwarded-Encrypted: i=1; AHgh+RrRuW7sRb0+cH/YWvAocI4vVNEJeXaZ8VnMSIDXyqv4CmAhyMqNX7ndgeV1ACdsemTwq20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPN7VRtJSNQmq8OCVhKvQC8YrrowsVdHd2KhRzU83L1kfVflfL
	cEe45NEnXv77rhZ4yCLFZKd7x9hpKzo2pU3u5lOmgQ+f2r+TK0p5JcZN
X-Gm-Gg: AR+sD13kKm4qQd6qvg836H4FZVMTvDMtOXD3KeZIJesX6+xmFzwYPlc65UvTBDmCMTD
	s6tNbFPxKmb6bpFW34oez3mnowEBAh3QeiB4O2UW99h4RADRP+fGaQH4Yyu5fQJWPoNJfCzaAQe
	GAM2Nf/FQ0DkNP2wlhMTB4WNxTQatG7QwLpv30OofoSNL7YdBrUmi8D5ZDPF4yZfd7a+iHJL2JI
	XMBUBVNmIuG/B3iRF0DyFkWV3WdgfRwa2Hdrba0HzezRGNeY5s1RGIjddsPwpeFdmLPZcUj/XiS
	3d/Mxrly6kbtlbUed04skfE885SmV1Vy0p4taXfhXHJoAdO/nOPGBnT++V9t4dqDKk/DNYdR+VD
	s6EjuhOxi12VrcHaYETf5qPNr11xuPpkDcr5gxAtIc+N2dFD0P0VUzGsst72nGtsGh+DTf2lj9z
	Ulm00VMaWA6avBLE4AAlZLsPq8ur26pA==
X-Received: by 2002:a17:902:dacb:b0:2cf:4544:104b with SMTP id d9443c01a7336-2cfde79689fmr7232495ad.5.1784943569585;
        Fri, 24 Jul 2026 18:39:29 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bbdc2sm2685385ad.42.2026.07.24.18.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 18:39:29 -0700 (PDT)
Message-ID: <f387ffb440878c6a9b9393debdd154a647780348.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 01/18] bpf: Drop process_timer_func wrappers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Fri, 24 Jul 2026 18:39:25 -0700
In-Reply-To: <20260724190813.1458271-2-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-2-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 12:07 -0700, Amery Hung wrote:
> Drop process_timer_{helper,kfunc}() since bpf_call_arg_meta is now
> shared by helper and kfunc. Call process_timer_func() directly.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...
