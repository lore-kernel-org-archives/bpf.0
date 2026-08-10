Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD40340403
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390507; cv=none; b=ad91k2jNO8iCQi2b2lLKWD/jM6dnDrBKRijZoJ8HiTIJIMX5idl3vSbONus2I7UMSyd43/98D6nK6uYx/3i0cDRBugRsYKDpwa3WDZudVqUOTO39Qnh7Q350uMX2bFaTJDJQb9qii0OdUycPr+GOJDYgMqnAdLwzRkbOp2VVuF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390507; c=relaxed/simple;
	bh=WwTpth8MrFVJI0sYO78MEBeGQnL3an5IX2+5ZrTWz9o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pupb3VFI1dg4RelIYl/obzfnus7RFcFXnf2DOTbvPN2yfrkvtDVPDCOdhlN2yRlcToebq13xOQTKge777rjQ1ENUBPJD0nUJP2UOnP8YaDQdH6Z1AcgvNmcCr3zFRp9xq07ZUQK3gq8PLJJeI1LJWe/l75j0grOG9SoeiNeTd84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZUMbA0s; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZUMbA0s"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38f620399a0so71243a91.2
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 12:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390506; x=1786995306; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WwTpth8MrFVJI0sYO78MEBeGQnL3an5IX2+5ZrTWz9o=;
        b=sZUMbA0s26EWbUEmsvpHQ85XEMvlR/Ulytn+PlhN/TjqpCvb0j+KM4GakKKBYqe3mD
         BqTHniynE0z9pmpVhU9jdOXL44a03aOg+rnbpE6Yb1CJF6DOtQXQh7U5dVpdjPx1S66F
         TXdcCrIEJtxJZsguYTfjymygC8EwkRMKKsFuNun9TRQO2NwUso/snb1ex3S59RYloONG
         bfT4MiSZZoZtJnVYgRFbRdPy5+IbWWOHj9wSNruVjWvEvaID02nwLjAchCg7Wj5OaJQ1
         oGKJLTzLdh7kQp1Io5tWyk0moHR68E/qkt3/ZARy+b5YSwQRuzlJ8OVNZMhGDXqANMbr
         fPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390506; x=1786995306;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WwTpth8MrFVJI0sYO78MEBeGQnL3an5IX2+5ZrTWz9o=;
        b=hJ4Sjvv98sYXyGvb2BucT5xxNHTB4/2aM8XvBqbpnKQHITKbqpPG6Bhd6tI2OBWHHJ
         ad9i9yjiAdAL+oJwjQ0buu+hlslJODLSuhDSpNju5rVmZ48bX2ChBduMCSB0B17RBEVH
         sNs1fMmRGaaA2p8zeycfA033YTT8GA8TIbwykzqXPqibQ6OZByst4GbheFxp4R0ngh99
         X8FpwWmLvUOh6FGWdrf4z26C1nuPRC8FSRrk0bx2x6a+OLI6qL3f4vmgfr7gWPU82R2P
         icD1Gp50j0utICvLxotav8ec0pVX+dgZupjQITKDK5y/jVw60X3nnJPu5Ta4gncUD+qg
         V/MA==
X-Forwarded-Encrypted: i=1; AHgh+Ro5/7Y7UlbSGeBZ34U1LB2yVkW3gGY2DfbThpK8JmP6Y2bgbH3FzaFinjyRvC3x9bDbHEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAxph209gYSh5bYzxxkTgsFv+L4in9COKkeqxKiRwSHFqosyFl
	rcjFJ46e+K6B5NapQw24KabtEvQIhlF7FzklY2I1KL3s8k2egrOQzJAsppgoeQ==
X-Gm-Gg: AR+sD13Tr8OU6NYCW9OcJjBhbeJBGzfcjJMpd7MkPhAO1wSwURtPusHpXcqOTms0Vvp
	0RAnTSrEFvFqF7nGVuIoIfvhS02fxUWunCa6KvxxhTN2bdGgfOwsb6j9kQbTrrVMh4anJIK8LOm
	sTvHWQB0c9eUMasxzmzQzGtZ8wvvNA5B8pgauJ5pVHLhVT3a7PTnLW5hI9w5mBquTFbkktToxc5
	nI8tMddbnKAEc7U5LLpMmDkYfAyTE0cj1SaL9GtJgs7pmo3DidDuJnoQJ1cQJNPznzPTszXQIz3
	fR6SmaggGxyVPnePNiu5cbrQbi8UIEBHrO9uUP3QZ9mgjBCx9j12SVceHHzYMtCtfwWQr/fjLtY
	FRC3I9SDTpDJaTOLjplFBDw7fjQbDLoUbugcfB2GyQDRRuelkqxM+9QGoU57UjQVkRD8XxKkElD
	rnlMywp0W3prnxl2d0qAPSQZEHd4vc/CyBN+2q17QEroNUaVocEHnXqV7hI58EgM4+yKetFtr4t
	1ZigHOPfBc15NwndjNk0MIR0/M=
X-Received: by 2002:a17:90b:1811:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-3903bb0ab77mr41170573a91.0.1786390505796;
        Mon, 10 Aug 2026 12:35:05 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d5226b40sm747333a91.13.2026.08.10.12.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:35:05 -0700 (PDT)
Message-ID: <d7f9046b1212e0b368bfde10b88549ac9ac8f63c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Compare iterator types during state
 pruning
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ning Ding <dingning04@gmail.com>, bpf@vger.kernel.org
Cc: memxor@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, 	linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
Date: Mon, 10 Aug 2026 12:35:02 -0700
In-Reply-To: <20260807004320.134069-2-dingning04@gmail.com>
References: <20260807004320.134069-1-dingning04@gmail.com>
	 <20260807004320.134069-2-dingning04@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-06 at 17:43 -0700, Ning Ding wrote:
> An iterator stack slot can be MEM_RCU or PTR_UNTRUSTED. These states
> must not be equal, or the verifier can prune an unsafe path.
>=20
> Compare the pointer type for STACK_ITER slots.
>=20
> Fixes: dfab99df147b ("bpf: teach the verifier to enforce css_iter and tas=
k_iter in RCU CS")
> Signed-off-by: Ning Ding <dingning04@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
