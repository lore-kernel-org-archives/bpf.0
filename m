Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1713A7F59
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697365; cv=none; b=GAF//r3OUhV5aW9aS3x89w2mmW08Aw5cLZtPi7i9QaI0s7NfXaFGoTsLv4lAEbnBKy/aGyjotiVL2tYzvYY7BzbWVL9zWu/V4kre+Pnkx9uEBWywWcFI3EJCOkEHYLl8zplxB6+ccTyKzch5ZSKvqr4Gvuc7Um9kxaBDk5cdGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697365; c=relaxed/simple;
	bh=yqydc2BAvs/EEy/vMFDPydcYDh+gc6ICoo3g/wT4z8M=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=VO7JMUyGsdy7WNOzuKQJfYOidqUv3eHY1/SlJDR6NZMMZ9tGqX0z7zUHMvv1ShW23ZH35N1dsc8x3hLsoAdHr8XN9gwWsp269mrQL0IUT6cqWXV6GojXZKKWJ1BchtExJht/OpNW0KR2arFt4FP4Kwclk0cl7SPCIXR47Pfd6aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ef+MNUdg; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ef+MNUdg"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50fc496c8baso67227091cf.3
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778697363; x=1779302163; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQ2lrl+/gKDcPyuGztAL7xFoyeibd4FccB/Ub7cgd0c=;
        b=Ef+MNUdg2cj68iOeUx6W6u5nft19c9Bx8d31j7AN3WybWxNHZBb6dan2SqkNlVXciP
         Rbh3XdOv6EcXFPhbjOXlFJQg4RASegCNS6fiX35hq4YDmPc9DD1j0t8dcKFrbcPPlwNV
         kVy83zVUPu8M9skQHx3H0MKHLsULiQ88MjIerFZQile5SP/YeSExIhjHindyS+CNmTuP
         lhXjJo17EHoJ0/2lx7J90ZH2pHXasPeLJyzy2X3qK3FjSF3JJsfo8i2N9EHVbE9VIsDT
         Jx4cZGLBAcVUmRjrZ+iqVRWmq2sDmlZAvdXVDhKeP/5/u8qp2+OQOIOUYSjHuIQr8GCR
         qmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697363; x=1779302163;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQ2lrl+/gKDcPyuGztAL7xFoyeibd4FccB/Ub7cgd0c=;
        b=nbRD4mNy6h5PH3oD7orttQRlZQE55xVN8z3vkOTD8OxigDldjNt/9Ak/AurZkN9oh7
         118aCmqpFISH3cPzYV7YlLUTrjsB3KJOFFEazsoJWgIvLRKDEn5co4AfJvVgQhcZucr1
         /acr/6v1xKhI0jo/DiwW3zdKehnbSZ09wuxBqxWVkl1FT3A/bpzIBoQ4zL7NCE0wrf49
         4SzEOzFZusev1btzU5TL9rG/KU2uJ8mkqvYw/D2zgIpAMj3PdowOGnPWADUymo3YNjYm
         dliv9PRePrRSgjaCyEdOHyM/Jq+n0zmki276lltFeRf8zIuKk5dKWC7bVMekiT6tG00V
         lOLw==
X-Forwarded-Encrypted: i=1; AFNElJ+ngha0XUYmd/5AznOASvvkKIzXMIPHvHjlQuzsh3ZTEUV2IDB8G741cABToAhO1U8ENhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygfKfFEt83Ep/ugQWHQr3J+fa0LOnaOM7RriOXsZH1cImci05o
	shF3f1IYfDN0IvZMknSmoRwntNlimHBrzIcpUgXU24VQ8xOaZ0MbICZftjC9tmTkHQ==
X-Gm-Gg: Acq92OHlRNJ9NGgG9S/NBKQSGN/P3DYmxbGVm/BwSDsyTJPwLETSkYhKEkJqmcTxep/
	+VjhDRjTHsyGh/7ouS9D3Cqp4PQ9Nwt4NBuNG7lWs7vxPfKmMuGKdq+EEyMOdXDTXAcvOCxE9nb
	1Pa5TLUspsH8ZtzPp+mQsfiSvZ3toJuh+q8WCkUnzhh9TudJs0UF6tfrfSFN/+Gfl8KXEYkUCgS
	EyAY0wn2NhnxR+rIBTIAmRpJJR9/0kBMiqbVRKwx/qZXbGGLxyHinTDGWWTYo/6ittyYbnGjKAu
	Rw7f2u/MvljYpoFi7fdEMVHkHl0hEWTHJN03J8BUCNRtGRAN2pc5iLRBP034oFPFd0AdFhvtJYs
	BuwNoU8N3Oo/q/4vPuQzHHlzyIydLNICwwuIHLkX5/JQAIRjT9rxDZZStKn3M4vaTa2+/kBiwwf
	KTnYfWmki5qLIOJOQgkCxf+OGjivOZs3lDYLEdEmnYwhjQfD8woGgxOM4Ym8/q1pKwDyGB
X-Received: by 2002:a05:622a:5:b0:509:965f:888f with SMTP id d75a77b69052e-5162f2a4b4dmr62133441cf.0.1778697362725;
        Wed, 13 May 2026 11:36:02 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e82579fsm151609761cf.24.2026.05.13.11.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:01 -0700 (PDT)
Date: Wed, 13 May 2026 14:36:01 -0400
Message-ID: <fed9fdbba52e91a15597b3eeb79c9d2c@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260512_1604/pstg-lib:20260513_1343/pstg-pwork:20260512_1604
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>, "Jonathan Corbet" <corbet@lwn.net>, "" , "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, "Andrew Morton" <akpm@linux-foundation.org>, James.Bottomley@HansenPartnership.com, dhowells@redhat.com, "Fan Wu" <wufan@kernel.org>, "Ryan Foster" <foster.ryan.r@gmail.com>, "Randy Dunlap" <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH v7 1/10] crypto: pkcs7: add flag for validated trust on a  signed info block
References: <20260507191416.2984054-2-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260507191416.2984054-2-bboscaccy@linux.microsoft.com>

On May  7, 2026 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> Allow consumers of struct pkcs7_message to tell if any of the sinfo
> fields has passed a trust validation.  Note that this does not happen
> in parsing, pkcs7_validate_trust() must be explicitly called or called
> via validate_pkcs7_trust().  Since the way to get this trusted pkcs7
> object is via verify_pkcs7_message_sig, export that so modules can use
> it.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  certs/system_keyring.c                | 1 +
>  crypto/asymmetric_keys/pkcs7_parser.h | 1 +
>  crypto/asymmetric_keys/pkcs7_trust.c  | 1 +
>  3 files changed, 3 insertions(+)

Merged into lsm/dev, thanks.

--
paul-moore.com
