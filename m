Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873A843147
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 00:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310718; cv=pass; b=DgbRMjVDpkJR4BV3jyhY9svPMyaNgdCY4DxcGcJwo7qiQATWU3kdvKQ4tkFmxvzX1NwhG60m5Sq7qyUp1PkpGpvOTGEu/caanUev3J4TSFKkhX1wVkukO20oFepeRR15IxsMZNv5abiotAECg0SNmk/CG/3C6yrpQpF/J3jsmv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310718; c=relaxed/simple;
	bh=rUDohFNQIPqA9OPjLaOOhr4HcP9sBdwHQXBNGNPYdas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gvc5XmN4CwNaVNFmQGWCfSZbW9+nQ+ZQGEcsl+Ld2uiS3glidIILz21dfM/jwucYa0w2h2llzVIT0Jyj67WSO60J5z07q/iDL88jcXIiP+n2P9KyNZinMgn7FJpJa2DVjqLpJ4LrOUoBNOzupfyL5MJSi5FDolOAuuJxHRKDxz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7sS2c71; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7sS2c71"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso3175458f8f.1
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 17:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774310715; cv=none;
        d=google.com; s=arc-20240605;
        b=ICpR4jIpDYohAbyH+UXrtkY5BQut87VIFmWKpyQ2KeYG2qeRc1eNCB54UCCaQoIF9V
         QgiAl2PuKJPVPEn483gSuzuhGbbV9w8h3kPx+N5TRSFtmYGmgQ/VRGB0FmMtRt7mZ+o9
         5U/jDHwDfcX1np1xZ1GNsjh4esJWBXXkXGRcWAkYMq3ZSoSBRKX0NP7qB+g+ICxGa9xx
         rPlPR4MRZrN4FyTLVzGzYAyv7TfW16zYJV9qgRu3D+Og8Z/FUTXcpDi9Euh41DP+vrm4
         rbdqtWZx6k+RYIcL67OkDz+BGsdG+iL+SsdtnyBgol67bWZ8+EuEXRe53FFeq//B/s7Y
         zv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=T1hM+icX398TA7NVfAVxPdZcaEOwJQfPypAPvlCuJ20=;
        fh=nBHPQzXQzNeywpV1+qGu3fmnl32p/ehv/zPIhbWrdUQ=;
        b=RO/crwyzlWTRX2IGw+gzDmcnhT6NLCKudQdpGexymFA5qfk54CTaRenKB3jZPEV9x6
         xePCURy7IYAYoW8F4uSwMjgda8Yvzn36Mg+kyfusMBfsZrv3jgLxMNEDWH3eZYgIGgCW
         +oC+/zkveCfqoJeMyO8+guwFDxsTupCrBEDv+dLVIj6N4CeTGv2tigkkxmnCzpPKjxdS
         nLkjLl1UkBT9yJxupe9Mhk72RJSfFXeUzVMykkqiF0Y3eg3dMJh0grZ3/G04jX4Q4LPu
         LPDKTmPtteZKKIo8ZNs+Its/geLH4oKoPIAaRQV9teN42R6A7CXsRTmwBNxI2DJmQ/qe
         3Tsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774310715; x=1774915515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T1hM+icX398TA7NVfAVxPdZcaEOwJQfPypAPvlCuJ20=;
        b=V7sS2c71DjM0CqJVUrxeUimaisR0w9wO9ZkXTf20TQbe9lPi8yHqQ/dk2SnNMc/fTq
         ZQEbdDC8MfojMa7NJL7VlidMHlbhXrgG5qk/RDVTamByU4HOQd2+eofV8jjjNZNZabDc
         rEXycFV8Vxe8DOD/oBkN3I5ygSgV8iKbnTlqUvC49l+9hgaiFgNTMTyF5IeBEC5DXIfh
         Uw75DR8/hbxB10R2ObuF1pX4B7MBLjOdfquXlr/d5RS7wgfiXo1eUXYLmFRv8Q+qJs85
         HU+7khtenweNK8ifG6xm6L50ONeelGuyaI2veYGhkzdHUv9vKZH/GUj/J4Xz1y64rQFP
         W4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310715; x=1774915515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1hM+icX398TA7NVfAVxPdZcaEOwJQfPypAPvlCuJ20=;
        b=fm1bx1oqt7QvuP8KjSM3jtY2wCgwfkHjvibzXQTbs17ZNdCEyNjvl2dgcvOX+ld77c
         BRhJtBrzW6IX9gy/pdkpSZgedEXSIFNBI3CegXaK4YGiCkMPp0vyZ8VAxS6GWUL3sW/j
         b3ceRpNqr2w4CtV/Z81EPFApZnx1InZTN0sOS/H4xPBHzZpuqcpalyEI7K4P030xY7FX
         Mh6Syg/AcTGzM/aVrdXf84w9ybE/GlZGJPM4mkrkGv/XXvb79hDS5k64jcGgLUkLkpVS
         QuM25L19OXUv4wplX5rsXqVQUYLMA7l4Jb7nSw9dswCnRxTKvtkoM8e/R3dYziR99171
         wEWQ==
X-Gm-Message-State: AOJu0YwyMS/OmvdaxGBqpbkvbyh02S92UvC85S+4ejbTMazXdF0ocDc3
	Qn+AZqILPFBc5/K0JEBSqWjOW7tgb2WhKv8Sqer100mmmBrSQFTPzdfDv2Ur3L27HDBxkUg+HMZ
	0fU/xM6F1iDEgP/wMUeLS+6iJbIkfnpJnOXa5/Bc=
X-Gm-Gg: ATEYQzze4wpPzxGmn9CAcWzCFZBlWnDJdeEXDff62Nr1Z6mgUvRFzSaRacrBsPpNdx/
	396w2V97v2Ke6KgICvkrRxEVm4m/wv85piaMc1Uio2ToaUnvmtC03R/Id47+gx6E6IyDAkWwy1Q
	GDSIQehBUx1Y0cP8eEarNstsG+IpkpceHbsxF25lr5eXtncAuH426z5hwhkAByP52pU6YsiYRPY
	h7jN6/yp6zAvzkD0Fm07ibai774a5an6YuCwqOBrFVJl0e2DTPOmMsnSotq4nckhcHpH3z+DuLt
	NAuAF0Ko94nLvZi9R7Wj8/KmEl0pDon04pEFqcG0zL5KctYxwMh91TgD7cTHiOeLeffw5g==
X-Received: by 2002:a05:6000:25c6:b0:437:6d8c:c08a with SMTP id
 ffacd0b85a97d-43b64281275mr20459796f8f.45.1774310714683; Mon, 23 Mar 2026
 17:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323231133.859941-1-ameryhung@gmail.com>
In-Reply-To: <20260323231133.859941-1-ameryhung@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 24 Mar 2026 01:04:38 +0100
X-Gm-Features: AQROBzDw4iqXP_GX6DlCkZybmivDKGls9nqSp0oanWJSGth6zs79r8uZkIqeMp0
Message-ID: <CAP01T77Q4Qt8evMNCU756LJt_BDJb1LpYop_o0cXPBsXGARzhw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/1] selftests/bpf: Fix compiler warnings in task_local_data.h
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2026 at 00:11, Amery Hung <ameryhung@gmail.com> wrote:
>
> Fix compiler warnings about unused parameter, narrowing non-constant
> into a smaller type and comparison between integers of different size.

Nit: might be worth noting it's supposed to fix compilation in C++.

>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]
