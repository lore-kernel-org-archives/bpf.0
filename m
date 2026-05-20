Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85029348465
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 03:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247429; cv=none; b=Lp7qm8gA2vJjyuTaRaOJwr2ofqoCmcyiQkO1ipC90XGlrxptPr3oA8uDJdzXco/7DbWxoH4fOYedTXd07bBMGaG68a7cADFcBRFsFOY4lApQsKbzzXAzr1eGlp7XGwR+L3lslqfV3/9X0Imxne9VDl5N1W6UWGbLvml1H6jAEEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247429; c=relaxed/simple;
	bh=edpgFvB1eBWa0iwOxw+kh4PXSWfZY4/hi/ukSm0/DQQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Y4b4NQ981QXJGfwF63xKPZFQAU4nCloGChJKtfo+Zua9NeCHkKQYs45EKmULUn6ggwhHtNi80h0X9TDGEm2f7fMkq6HzfXbrKywHTEMFYsQi3BSk5tIsd6Kra85L53JOJcFFmAb7labn8eMCc4JP+dgD4ydTxgL2zOYNa7WAVFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzFXx2eQ; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzFXx2eQ"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso31684315e9.2
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 20:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779247427; x=1779852227; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edpgFvB1eBWa0iwOxw+kh4PXSWfZY4/hi/ukSm0/DQQ=;
        b=GzFXx2eQ9W5oUArmp7XsF6iMMlygpKbjh1rugDMVRPggB7ibcKEfqmJzvzSl+ZIQOM
         2aXynZnPJIWmt603Scqu1XzH+cHEMsgtd4kwGasCjCfn8IpE68rnObB55OADGI/YuYEP
         MozXp7R9YYz+LoPw9ZHWRVncdtsb441n+wksKYNouVilyOT3lT0sBPhAGsNPzJHwMAuX
         ns6aTfdLjRURIgaJPagAzn+ZWk1Uyl0c7fZyerN97/u9TGJDGVm7Vv2fbXiLuWHV1ssu
         RsjebfH8+QbXfoigLG58HySYxSw2kawdxIvQ3dpveHhrxjH6WC3/aMBopqi2XcBefcy5
         S+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779247427; x=1779852227;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=edpgFvB1eBWa0iwOxw+kh4PXSWfZY4/hi/ukSm0/DQQ=;
        b=ZSTHSCoa5XfU4x2RJiAdZJJyD0Ha9K3FNX63Dq/09aT2Xf+AC/45iHPQ4a8+0oE5KC
         waB+YDR3F3fHEi4IyHbTT8Wt4tHGPNZvW3oqgTVxSLN3rkllZArXvQ5CxByLR3hxnE4l
         pZUUSj266lF1FMS/jL0t6IM/+Iyiez4R28lSZJADeKzImI23Ffo0GS8qaGLqL7CfXiLs
         fFLqVT697J9hUS9PI8+metdSqdFbj8wsaUUnGLEiRbEDGgn/EN9aBVQMShxasACv2oR3
         bQmIKo6ljnDKrJmR+MLRF9v09in+YV9hy0fDGjBoUwi0kSpq0tSeWHCUAkYbcXq4z2Lj
         Yaig==
X-Forwarded-Encrypted: i=1; AFNElJ+5otxAROm/4zqBjp3RN8iAjsJpYA0cuU/9s2A3IA/MwfPo76eRAoe6AilcKSBW3VdoPn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO4mWslbQNUtv9SdDt09hWeOkV+rp4ylwOc0Bycp6nhGhb4ife
	HVBk35vbkvHOhuqx4HmcUQ3m+s95WfxiIs+ZiXpGLnqfk2D9P2V6yCpU
X-Gm-Gg: Acq92OF3p8Xh2WuleZjeu2P+Xiyb/c5XF7BmI0iZNLVrw7j1ewoKS9FIWBOTtuYSRGt
	6GZeYmT3F0FW4aObac+V8gRN9X5Y9WUXkR95btq0soeBue7l+MH7U8lDvz9d63s/5nMeRw1szqI
	Z4kCg1En6RKLK3YAQi8iB78FuFTVMRJnmnlOE3kWeixJSFqTbAZhuDwoZda4/mgJTuG02EGgeZt
	pi96OwzoOdJMsqhw1X7QpAEkicrcbeLRxy0qpkLnuP8Yv1sWt866s4yVKt7dNJI8FUSUWNPD9tP
	VOF0nZXs7XLhcRQYEt3W/VL6HpYyg+lUSKgyNHNHJ2m2OjQ9B+EE8Rmw8ye8YamFdNFCXUiFR72
	cfoBWbhKIC82+V6O3ePDRiT68pJgpPoVFut+gyu4nBLc5xAVPMaJWJOtNfn4PAuKbimlDsdDsjx
	wyhrL9p5jWWCSsSL7ViZEunikkrc3Y1FnAk4U39gbn4Xao+w7dXjGI3nb5PhmvLdG26Kt8LfdPp
	TMx9aERwykZv/Rq2T2aQi/FbyFfhZCIvDVwHFerc/+WmCmk9zryRXeNDWaXqiysCg==
X-Received: by 2002:a05:600c:1384:b0:490:2238:4021 with SMTP id 5b1f17b1804b1-4902238403fmr59342235e9.8.1779247426819;
        Tue, 19 May 2026 20:23:46 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490191b5244sm36266215e9.3.2026.05.19.20.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 20:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 05:23:46 +0200
Message-Id: <DIN6KNJ9BUXI.2A1LG8WW3842M@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "KP Singh" <kpsingh@kernel.org>, <bpf@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, "Xianrui Dong"
 <dongxianrui1@gmail.com>
Subject: Re: [PATCH v2] bpf: reject NULL data/sig in
 bpf_verify_pkcs7_signature
X-Mailer: aerc 0.21.0
References: <20260520024059.313468-1-kpsingh@kernel.org>
In-Reply-To: <20260520024059.313468-1-kpsingh@kernel.org>

On Wed May 20, 2026 at 4:40 AM CEST, KP Singh wrote:
> __bpf_dynptr_data() can return NULL (FILE dynptrs, any non-contiguous
> backing). bpf_verify_pkcs7_signature() forwards the pointer to
> verify_pkcs7_signature() unchecked, causing a NULL deref in
> asn1_ber_decoder() reachable from a sleepable BPF LSM at lsm.s/bpf.
>
> NULL-check both pointers and reject with -EINVAL. Mirrors the guards
> already in kernel/bpf/crypto.c.
>
> Fixes: 865b0566d8f1 ("bpf: Add bpf_verify_pkcs7_signature() kfunc")
> Reported-by: Xianrui Dong <dongxianrui1@gmail.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---

Added missing acks before pushing.

> [...]
