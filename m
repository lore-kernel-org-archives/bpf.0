Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A473126C2
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 02:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775442210; cv=none; b=WdQGETAw7s/Fs5u7uWLtxuW0XDEfLEvFcDcQ79Q+ABqc652SAREK046euC10ckU5lM7OQPzB+qSOEWJUvgVdIfZkaGB05KsG8Nt1adlFyFEaWQORYdpH3D55SKmcjcOWeQgEbgLFplLr4hPLLdXtdzODhYtdAbQwc9k3il+wG60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775442210; c=relaxed/simple;
	bh=fzbMJhUAuMGp6GQ0px4BbWlOEM5YDr/DP0bRMWeEC64=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=COij24TkYYPKwSeKsCq3AfikjWB5vxKFLad+Irrde5hVf5FEVZ2GfhUatqnD8uS4ELb7F+oX4yNV/BDJ2j62AFX06O2pjfmxmGxVzU0hpEDi3oDTl3mjIEZxeSq65hzKCfF1P36cQx0wvMRS1q6GkUEziP3iPZrXpmnV+jtPKBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rDhBWpIo; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDhBWpIo"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6501d242e2fso3107297d50.3
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 19:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775442209; x=1776047009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om7CMU+KUBMnIrb1uq7hMyiNSH8jke3lfMQm56Bk+Qc=;
        b=rDhBWpIo5OIl/rG7cjeoOmvBGRIhAW19w4KnoJpcp2aUZ9SoWfHxL9g+CXfWvT8cKy
         tW5S0tfaiLGXyWcG71UAnA+iQ6YjMeb2HhM9UUM6AWUzgScoqfLjhXseoMNGPm/yIYjO
         O81O2DkPh8Z66B3MrNZNfOKkzIk3tzp4OBKnM0suaa80s/KUAxJ3mTPfcuT5+5Gyo9mz
         esdSY2GvLOFsyWt6TRW45fq69mSN3abEHRqtmpTG+kgYBb2mX/StcSimJ+M/cH/yo6P2
         Rr6bKHgi1be8Ip+an9k7ACPIjqjk3eGlsdFA2PfxVghvcX1v0AF8HerpSpUs0YdJWLJJ
         Meaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775442209; x=1776047009;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=om7CMU+KUBMnIrb1uq7hMyiNSH8jke3lfMQm56Bk+Qc=;
        b=UUoxdMSEeKd3d1pP2HkgpfNOukIkZYRP61pYxDj59Z26wGiSPOMV5ADnhOGD8NO1x/
         /pUghyule3LoRH2XEQ5E40Li6HDye08YW2QY+Nnmu93Ao6CcFvN2rUPfNxE4B2aVOKvS
         Hp3mRkfGGBxnbjDT9MuIDmiD1l4K4ZsEpvRzG+8lIoiCyU1X9CT8KAYT+oC1JNgCKqyp
         TBMRix0OEeK9dw/yE3oujb3kpGCaHZ0K93pivP40DucdBVLamRvRD1j9aJT9XC+YO7ie
         Iw2Ukk09nd5tW1vee5YWbeeTp0aoPjaME5THSaFXVSllg6iyhd8H1PNSvqHPvzHpnKu0
         HoEg==
X-Forwarded-Encrypted: i=1; AJvYcCUCJd4EL+VCbRRcxR5VcPrKRLqYND2+Y0cUYdErp0xBsET0AWRRXG7IGnvKJvFGsfNIgeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynEOaGe+lyr6KsyOozs3ZJKEy95JvUdTIjM33wgdmxwEXYWAg/
	S9IqqQChDL0Fc1WhI0BPgFWpDR2BDNMWTYBpsfBg7xdQBX/4zRjX3naC
X-Gm-Gg: AeBDietFhQobLdMYLki+zn2cdHBJ14Nx0jV+KS/KU/Qzankxw0d4NY7i/FkCWbcALIZ
	1KPXYkeZfB9wiUx4h+qW2FN9vY+n+noFqk/u+SIo2x+il4b+Z8S4kHOwntCqocKB0Dm1IR8rTh/
	F9nKZQ5h2nSmc8YcQb5mAAeFaXCN7b6lj1ZFNiCodxUjM9yuoisycsN/USXVMJsP8TcInsVzbzk
	NmNs6h1774/YWppGwFXh8fNg9I6JZjoGDeLuJI1AuZhpRWauJYZnoz4mx6Hkukwptvcq5JiHIl5
	cSdGcqcD4HVxVDqOkDsI3Ln0KrSh01bNGx+KD2xF8eooCX7AKDiLDp566/iUWp0ASBV11cKVy4y
	OzkxpvVyh8HktycgvnTCsalIiBLBFbNKaXmJ9gnRqDY6oPUq/I9TCGy08DaMZRj6gCH4rwQSmAU
	omxKZhNm+03BmTR2EsUjlCL1NrjJGo5UoCU7BNfM+2BZPCRSzBVHZryXeyUTEXhhXbyhl/DLzmB
	CS/
X-Received: by 2002:a05:690c:83:b0:79e:9cc1:edf7 with SMTP id 00721157ae682-7a4d35d7d6fmr104588547b3.13.1775442208679;
        Sun, 05 Apr 2026 19:23:28 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370ef3fa5sm47715847b3.42.2026.04.05.19.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 19:23:27 -0700 (PDT)
Date: Sun, 05 Apr 2026 22:23:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemb@google.com, 
 martin.lau@kernel.org
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>, 
 Yushan Zhou <katrinzhou@tencent.com>
Message-ID: <willemdebruijn.kernel.c2ef8ef43869@gmail.com>
In-Reply-To: <20260404150452.83904-3-kerneljasonxing@gmail.com>
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-3-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v2 2/4] tcp: advance the tsflags check to save
 cycles
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Check the tsflags first to see if the socket timestamping is enabled.
> If so, then try to fetch the last skb from either write queue or
> retransmission queue.

This message does not explain why this change is made.
