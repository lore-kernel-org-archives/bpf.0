Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A4847CA99
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821298; cv=pass; b=KwrtWujLSRg9GKJ6TSo5rl3GKUBZ1vfTx3JDiXoopPoSpq9x6TLRThXzzP+/QvRKTSydoyj0IWyxU2ZE00Lm0fYgkGjPc80IxrN09CZQ/hl+Vd+epljYUpsk5qfaOCCRnUUOFJAuPFBUzZmH/om1vIMXHKKJOhP715aswBlfJB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821298; c=relaxed/simple;
	bh=pI+5JI9JeW3qaHsHCrOzwnAwIxbzLeEtKURHX1NItgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fE8ZDnoFg16N9xrXHz9HcSSUv5Wyu7DtzhYR6ZMYdutk55TxnOr+TyA2ol7YwHyFXmORWRgCs7fEhmszxJIhyxYd0LeKiVYy3XMiCJm8TPTiwfEq/gcmigHpGGSsZs1x1hI6nn91d+xiPyOeyiBEWWmBQwM0P/IWJVD/JpmSDDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+eYlhsq; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+eYlhsq"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69f4acf7047so200767a12.3
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 08:41:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784821293; cv=none;
        d=google.com; s=arc-20260327;
        b=OYMOSPqLo0oNslZE8Q7mWWcJrkB4mxgcT20MNJooADw3Wqtua45e4KYm3BT5LTWAXY
         1rCwhchzRoHw4TkPtJjQCp9BeCZjczR4WAVHQxzb3AAoRrvDxuLGtCNibkurwnQDnzXK
         8UQLqUjys9qRvtmph1kCvCk/sT5uvZd6IVWKxB8YW8kBTEOQtB7dTicMQP4Vkk+cXdbe
         xQ+3lUjM1rumDA4XWMXbU2DCpQ4n3NBeC8hCYYSoGyQW3ciX2gnyzYGr/m0drM1+MTGN
         XaCAof7U5HjMPctBpwVgWdz/JULnWFGZwx7bXBM4W5RcqmFGj5b4vo7ANIOPJFHRSFtx
         pCSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pI+5JI9JeW3qaHsHCrOzwnAwIxbzLeEtKURHX1NItgw=;
        fh=FE+py/Qym+u8RROLsMACj5kNhXCzPB+AwY5HC610DSs=;
        b=ns1pgH1XBLRXtt4JpHgI31IXWWFp4pLMcjCmEq9XMdEGwcRo1rM4UAe1bXlgPAHV/4
         qCdxLYo32TW/9BUHn3jQ8pTTHQXRK0dAN2LpOauSlRIX0M56dxOMeTXnCzcUJC9C0naE
         icuX/hNGwyJEynnAQ9ek4nB0F2qusxtiP3e1RQYYOLoVwjzitXFRHWoiJfcPu+u+YS37
         DXNc3Px9/3ObI+A056nmnBIf+kZ091WX01Pe+4tqohqIXTAHxFj2bEICgTR4ue50e+yz
         +1AovWgrifCtxjQSOKGG3kSGrQfGBiNcOSoKuDrH9xBYkok14g+t8oxLbBjkv7D+7D78
         ManQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784821293; x=1785426093; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pI+5JI9JeW3qaHsHCrOzwnAwIxbzLeEtKURHX1NItgw=;
        b=B+eYlhsqcRPCBu2CnkJiqDd9Ev79YYDcM5Q9d4bYMPM3AfSjsmGbTx7a0Ch+kPjJ4B
         CtHqrenwqX7TRGVT03w8/HmZwuk2f/Vx2QnZjJ5pcHxg1QvF7EQgHD50UXl8xxo86Chk
         BVRtyObOl+XVoV4eGnQRb9o+yAHqmNkU3OkOD+tAoCoCUASSeFpuh70JVpO5kBDDmYAy
         DIq3BgtDKEmiGZ0HxkYc9hkoz18gquHZrLSUjUIOAgqdbnJZx91aQtGs0O/byaIIvr/y
         PgCBa2+6623xm09PiUL3RKr+qKAUiDSWYuyMwZ8TkERMRfDu8eiFsWvpopG4hplovR2u
         tevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784821293; x=1785426093;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pI+5JI9JeW3qaHsHCrOzwnAwIxbzLeEtKURHX1NItgw=;
        b=i0j1arIdWiC3soGfP4IWBiyR4H76HCuac842tOHy6cV2j/akPcXsqUdu4w0ikLAg/R
         t/6DCTB71YYI09I3tsk2C9IcExBYxq2lEOaA/mbvD9m6voTFbKmi4xvbZpzIwgj8TR+o
         gFkP7ml1Twwni7TJ7ByUFInVXcx6x33pYWqSqNEVUG0WX7OdixYhslDezRCTLz7vX4M0
         qoDMnHsR7I5PCirDwky39x8k584Sa/SGQUrinb/pJiO4/FZfNaneV+jyHAsa11b5+0/p
         V3B7a7gsD6lFxj8rGiCL22/pRbsE5glnFmNpBM3nfOyZQ27yXWDtaVY4mvvrwLORoIyv
         KaUg==
X-Forwarded-Encrypted: i=1; AHgh+RqimTVcHV62FlAAMNHxN/X4ZpqRDgioNoZnxYZJvrRVXsuwvbIdrZUMJI736T5MVtlJIU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzxFd6ptp+1d4TWvWLS8MpnJXocb2D3I/iEJDKx/B7n3xCTg07
	2EC0eV4j5S5mfo4LqkkxQJV2Vq/TMLFtuOoQC2jLDv5qcNaq8avYQLfteIKPM8N9dftjj7S1ROt
	yWgUSFcv9qpyI9KrlSrfYRuh0LPzoXwA=
X-Gm-Gg: AR+sD11NBKwoqZ5xl5hrcc+rnhLgCEx+BAg8FXYXUCAJiSFUv977XsVW69t/EVFU5RI
	yNsaK+lz7rao7Y5SwpzaIxRJA01xD09oTGaIYBMALBa2FWdaAp3UvZALV7bQkfBkErpVgk9Vtng
	exP3jp23XwCtfFmkcp/KumBj39lCqqx71AdFb051hao/htWMECp6+qpmmNSaaiaYQZfQ4J+2x/d
	eEO5PyKNbKtYxLXr2qhvShpPq5AfpWYV4y3Znkml+6jXwMIWYimjrkh9WAcLngyk3UOIsbmK3Bm
	cUZeT8TAq0CllFE=
X-Received: by 2002:a05:6402:1ecd:b0:697:ee01:9a0e with SMTP id
 4fb4d7f45d1cf-69f6ab3881bmr979483a12.5.1784821292913; Thu, 23 Jul 2026
 08:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com> <DK3O81WR05WI.ZR3AJUCCX424@etsalapatis.com>
In-Reply-To: <DK3O81WR05WI.ZR3AJUCCX424@etsalapatis.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 23 Jul 2026 23:41:19 +0800
X-Gm-Features: AUfX_mwzqO4WBcNnVnNaBug6wKkdEpx8B7ntUhhI5hwB56M1TW0WBGtfi_e10H8
Message-ID: <CAAo+4rVPJMDiX776OHu22KCfL7WnLG30p9r28NZYYgQZya8-OQ@mail.gmail.com>
Subject: Re: [PATCH] bpf, sockmap: Fix cork use-after-free in tcp_bpf_sendmsg()
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, 
	"open list:BPF [L7 FRAMEWORK] (sockmap)" <bpf@vger.kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Emil,

Thanks for your effort in reviewing the patch! I have sent a new v2 patch
to address the Sashiko comments on that function. I will wait until later to
see if any more related issues are flagged by Sashiko.
