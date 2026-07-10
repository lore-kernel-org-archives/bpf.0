Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7446381AE0
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711032; cv=none; b=RuLJW1checIqIfySbRLjtWc298cQeIICBRL2lD/kmaT+LYRTLGKttHQ4tGrOjUgrnGYTDZDf9wdMpbN5sYUs3dHfbwmx8H8Pi9/C1uB+Ofmmrnf/uw9Im3zcLOgf/OZq3vlpTgGDK4k+T6ZJy7i5iPmCGYItq6SUrp/HtMuYVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711032; c=relaxed/simple;
	bh=fKtx+l1oHOZNTCM/j46NLi2wxexlleELoSfRE/hgiyI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=P6gHrizqRsBcmhbb4RbDvMSxqwl3jO3I4cg9sJbBZl5JNiu1SvXKu7SRMR2P8KEQSCG2PQ/+0vbuWMNZB5EyorA6HVhCoWS9KBRa/ykvtY9C/gjP5WzbyoNKdtqQEdMX1gwtkp+4VByT9k/qmRFEiP+gxh9gw5r8fA5pkKAjmxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrhAtvh+; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrhAtvh+"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-493b4af7976so8507955e9.1
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 12:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783711029; x=1784315829; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fKtx+l1oHOZNTCM/j46NLi2wxexlleELoSfRE/hgiyI=;
        b=JrhAtvh+63aGJxryPYPLBTf6uWHvsOhX/FphV1VtyS4QGLxWz1XH7D8n82nUbctcsZ
         tkWey5EPfgK7hP41RCOiCtpechr8qcj6L21GRBpN4rZvZh+JnsfuFzxtYaGBZlTC9Db8
         tKyOtVpimG9FIBN5Wzrt7fy1RAKq/OIm4Vq6drPpimxpliHLwkLpu8AGa6JHQDjnehmG
         thCyYQifJrHY7XzKDPPiPPosh4Rr0t6qehdXD7czN0mUSPww6ota3OuFezTEHYnyfmt3
         nmX1jA7l5DRIyt+9UBJHXLEMsqu5++FiTKQDI8YiQcaF1fqFZ0JXM3RxzKQRt9oN68td
         YCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783711029; x=1784315829;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fKtx+l1oHOZNTCM/j46NLi2wxexlleELoSfRE/hgiyI=;
        b=HrYmdqs7Hzg7XjHUKmwmFnfG70yZVvB1PQYf5fwjqrQBFoyoEtgtHxgjnY3BHIsbKH
         SMpCScuITQOznfNLnHNw0DjfP/Wcv26pxVRaJIDi+U6LpFMtPG9hNd3S2tMeoQXXh6Gf
         NKJ5U6eEz3ossiribqBOWEYDjHcNNTn9UV2FRxVZXGbj0Uv9GzAQ8KlMYBBz0rBPfSLq
         Fx+mzr1/xdlxl5DH28jNsy4hCWcaP04Rzn/8bIExVjjaZIAZ4eUQpaeLoWcFBB/D/wXd
         ZXGLeInjCdn80rJRQSJWRKgBrAvYOPPUQRW5OISz19ulpcOxwF2yOcs9UXeExpiG770N
         IEkg==
X-Forwarded-Encrypted: i=1; AHgh+Ro1gsnKV858Q1AuZSwnFHUkThxk/zaArv1Pw2rclSJWhlUe3PirVsVRe7/AdLa2zjKGjzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFJBkfMRY7FAioiegWv+Qng9sPrnB8yJrsX/PuZFJNXK/6NQcp
	6l4dEuQ5vb35ebTSFJOi5V8nArnwyjUuQNvRsRkssx7WqMA4XKRI4VIp
X-Gm-Gg: AfdE7cngmhv4eLIdwgxNlyxHp5SVLYMpUvSs1DDYRFSordJOv7zaBvqiQ0B2ZR4W0+H
	pMtJ+1IH0XVCTAhwwOzXU+OY29TOFpvE1k1lTlIGZiFWzWI2ri4sYkwHclrX4rgBytG6cFZKFT1
	k+Ckg5ORsYFtUiLUvfs4w7NVcLU2nhLdEQuqL/Bxa1UaFdzMg4/fRTgFF7iFXeA6XfBJBoBsG4w
	775MZcwcoOH/0juR2LHF6pnvfr0tl9R6EsNdV2ZwPmhTvWE9MkUKPBBroB4XhlaHJUDHnmAMo/0
	/LHLnxPA0stKXQgwqsPHTY4IUQYecWVaWn+jKHzCJ0AILRv61+diXLrl5CwdRC9epto20WyJGnR
	Ufq3W9y9KM4ul6MhFAZFCEqTL2ZlD6ZIb1ESYwDoQLB1KvKcEy98sytrGnIzQveYyV0P2ksdPyT
	xUX3WFQ6pPHGHpT5Flq3PzT8NY5ZTxAX4DYIozEyM6DfB3LOhJ7J1jTCTuL6+E7V3dApgZs57z8
	cYznfdjUW9+maJ2nfTAmlMic3OxysvyJamWj9juwXahbli5IeZ1veA=
X-Received: by 2002:a05:600c:3f06:b0:493:be13:98b with SMTP id 5b1f17b1804b1-493f8820923mr1197835e9.23.1783711029096;
        Fri, 10 Jul 2026 12:17:09 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f16cfsm160683635e9.12.2026.07.10.12.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 21:17:08 +0200
Message-Id: <DJV4SE3UC9L5.2MM3IGLHLQICW@gmail.com>
Cc: <tj@kernel.org>, <void@manifault.com>, <arighi@nvidia.com>,
 <changwoo@igalia.com>, <bpf@vger.kernel.org>, <sched-ext@lists.linux.dev>
Subject: Re: [PATCH bpf-next v3 0/2] bpf: require an owned cpumask for
 bpf_cpumask_populate()
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Nicholas Dudar" <main.kalliope@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0
References: <20260709182800.2037938-1-main.kalliope@gmail.com>
In-Reply-To: <20260709182800.2037938-1-main.kalliope@gmail.com>

On Thu Jul 9, 2026 at 8:27 PM CEST, Nicholas Dudar wrote:
> bpf_cpumask_populate() writes its destination with bitmap_copy() but
> types it as struct cpumask *, so the verifier accepts a borrowed,
> read-only cpumask (for example from scx_bpf_get_online_cpumask()) as a
> writable destination. Fix it and add a selftest for coverage.
>

+To Emil

Hi sched-ext folks, this fix looks good to me and on cursory look, apart fr=
om
potential signature change which may require some adjustment to casts, it s=
hould
not break existing intendended usage.

Could others confirm this? Thanks

> [...]
