Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1151660250
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752749; cv=none; b=LvmHwzolZxhzF3g69ctoJqBXGs7tg95/zM66lMA6QzaHPasvJd/3k/IWqy6fXIVjLUe4Drxv/ZSl0D3zfvKFYIDptmG+gpoj24NTMCgG8rVBvMjeFygTlIdzmKC14Auz4hjJtBePN586l+AFEkG9OpDoXBMw6x83GYH9WGOPV9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752749; c=relaxed/simple;
	bh=VQEZhoWVge7jGgqzV6oherw8yCzTwobCnufm/KmE+LE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=G/DNN574eVfLHSXUO0e5IAlsRtXDh+smFl2pzxxeY7dekzhnh8oPc5iBnQsTqiyEEI1yo8kUPexqjM0DWkMu48ECHrSgQmXUtz3wEW3QIWC8e0zACTGHbG6T4XfHFcYCyjucpgwiRsYyrvOBTuTc3UAYXOuAHJWtlX+4ODtel8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RT6AhwAK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT6AhwAK"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dcce5e84bcso650735ad.1
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 11:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709752747; x=1710357547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygDNJdX+wIbMlpomf5qZ0mCLiQc5gFgcrV/3pEM30DM=;
        b=RT6AhwAKkeU7UmLAr5C/B2bNh+QXjNDNP4BuvKFVnt7oGjuJigSLs45STuIqsDqWQH
         A4l2LFlkyO3mcc115afkl/LX8xrzCaq7u5pJN9g+bQB7+trwo6Po1drxjFrN7sIBceiR
         Tx+SleSVJLmrc2uyJy/P0GiA4RtGarkVwqZIqpVMSjTgeEm5k81Gz/ewSrLJf3Sq1wnw
         HI7q2Rw32Sbpn6VilZtvqqv/GHSexpqpO59RsUtiu8+JvFzjgtPh8j2Y1vRM0Ft1bjHS
         eelD8BurMOaar1LdXk63rQUPa7iiDjmuLOZ/jn5eOa6ABKLhX5gatYKCsJPgRKL4RGSl
         T4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709752747; x=1710357547;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ygDNJdX+wIbMlpomf5qZ0mCLiQc5gFgcrV/3pEM30DM=;
        b=IvJyQRj2RUhb5Y5djZgqQ//mc70/l6EtjHPS+RR9epnGdH7LsZ07eK+XKbvxD44qY5
         Z3Jh1oobEkexsu95gIWfRdzZqCJacDyocci6VXdoA9InIxB4vZP3SA4f5i0ICF9ClRPN
         FXC00KRm4EEHoRfyfMzi0ozKyGcn3r+MgvvRmcnmaLhYtT7GfwZIWWSw8NlstSclv8py
         C4Za0z3qqiw4qjvNxMtjwB6IjFestKSpj/9sJEKl0YAE4J+NsrC6JyMy/WbYU8pjyCMA
         5dKWMbUOn4BXAJSX22BC85fqbno7qjWQ2mI9wK6pRRmY+ESnN9nSnxON9qytePA368KP
         Ty7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7ybUYmY08G0LwJ70xM0SMtYL0u1d4W2xPxXbjzQKGNpxdQ+Umt4AJcGOQjS48i7p03xZQAl7YHP6VRA+x+stdROtS
X-Gm-Message-State: AOJu0YyamFRMAygTisjK0B9u77UI/k6seIFHeEtkInclJpvqrZoMmZ9p
	G//jlEXUJbs7CyypavDI1xoayZPzpeHxeUNYiKpVw4kpbZ8Y4Zkq
X-Google-Smtp-Source: AGHT+IEeZuKYwN88bkIUwv7c9FuX/kvPSMVbzq32C++OBp5oTT0fPkiuiArImskCd+saCWndqaNGlQ==
X-Received: by 2002:a17:902:e544:b0:1dc:e26f:d8f8 with SMTP id n4-20020a170902e54400b001dce26fd8f8mr6935104plf.14.1709752747238;
        Wed, 06 Mar 2024 11:19:07 -0800 (PST)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902e84200b001db45855528sm12954181plg.198.2024.03.06.11.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:19:06 -0800 (PST)
Date: Wed, 06 Mar 2024 11:19:05 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, 
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 kernel-team@fb.com, 
 Martin KaFai Lau <martin.lau@kernel.org>
Message-ID: <65e8c1a95f4a8_34fc7208ec@john.notmuch>
In-Reply-To: <20240305202155.3890667-1-yonghong.song@linux.dev>
References: <20240305202155.3890667-1-yonghong.song@linux.dev>
Subject: RE: [RFC PATCH bpf-next 0/5] Add bpf_link support for sk_msg prog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yonghong Song wrote:
> One of our internal services started to use sk_msg program and currently
> it used existing prog attach/detach2 as demonstrated in selftests.
> But attach/detach of all other bpf programs are based on bpf_link.
> Consistent attach/detach APIs for all programs will make things easy to
> undersand and less error prone. So this patch added bpf_link
> support for BPF_PROG_TYPE_SK_MSG.
> 
> I marked the patch as RFC as not all functionality are covered
> by tests yet, e.g. update_prog(). Maybe somebody can suggest
> an existing test which I can look into.
> Or maybe some other tests need to be added as well.

Agree this was missing it will be nice to get this merged. The links
are much nicer to deal with.
