Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCE0315D40
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 23:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774566306; cv=pass; b=dlQwlpDsbr4e5LwHSkCQ6vQIUKiSCJdRAZ82GBsGUR+8ZsZdcotYg2RIqpatbhe16w5FS/9TXCc5qJ4Ej69QQmivyqiY2aJZ7TZ5VG0e6+x/NcRgwXhKPm0ZEYj7Ys9ibqSkJviVHRDJe5s8kdbq57O68/3LQA/BIjJKw+ckJys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774566306; c=relaxed/simple;
	bh=kLvt8ALPWVdvZI4uxDrR8DdfOnNc7X8dwjsIDh2c50k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eN63rm6K8l3Djx7JpQA5iImuQSol9Xk2rd0XmPW8Eus2Am3Yj/WcD0f1DvMTPiWYRnaImV3vpdtuXa79AxNztL53mrTTRAiZUHvW6B8who+xXPHd7Xtx8A3RlLrpYmILRKeSQOdy62VhsSvequHsaJfZmHvTpwSNQ5pYJnZDtpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IaNJOzGu; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaNJOzGu"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38be66a9fc0so16126071fa.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 16:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774566304; cv=none;
        d=google.com; s=arc-20240605;
        b=IQTk043K9hEtp4rri3oRz6l3hgQ/hBuEA6WKca0OJs4BvclkJldnrAG6Mz9BonjHAC
         hfhbvVDm5JFwROoB6QS4knZgP2jmPTB+Ra4lt4an4VytAw+7pIgZplEeQ5jYJWPXA1h0
         neU07mn96KJdv11vsunUv18hnXvT+ZTliZUqBtUegtm+4IKdX7CabcCkOoGacNjqSlYb
         d1oXc6kOGVK/ODrXg/plXgsi9+8UiaF3jqnxHxDyB/ujgdV11jm0ydmNS9PwW/rtDHjl
         uvb2jttDUhEc7GGo3NqncZrw1rxj/B5AipxLPXDMt+Plz10OehOZNJtq4K5hn2YZ7ohh
         3bTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kLvt8ALPWVdvZI4uxDrR8DdfOnNc7X8dwjsIDh2c50k=;
        fh=MZ0PeQKhjZRN10YMjH19AstY25dWzkP67dnANw4Ko78=;
        b=WwhW1y5TGPS5NuqDUm2yPxUwgt2arSHZs2TVcnXqMxb4v9zLZ9JcVUtYzHuo2G0wIG
         7eAgidbao7Yt7m83Z3lNueQymxF5e0JOO6j/eL642ffxQglFcM1zlkb2oNwj0vllK/Ia
         ww0r3y1QEAqERkToNi6WcETfBwXxSnRPl1zdkE9eWpxP/3Wb1VcmGi+L0ONIC0SvthVP
         H0oJHlfxPpeAg6b5U4DwkaPuqC/vm84XI98M15g8fjlVVpAmZAY/Drgd4+2PxAMpIDhq
         NLFD2omfyJqConXn3cH7NNcwrBgf4v4UECdbMWKXPC24KBGPRuLCchjy7lUWqHUyrD4f
         Kl4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774566303; x=1775171103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLvt8ALPWVdvZI4uxDrR8DdfOnNc7X8dwjsIDh2c50k=;
        b=IaNJOzGuKk66x9bGRVdihzQItjJrDW+wwhMeJADFsqe2B2pR+j25805au+Mp9U+1on
         gTfvAD8GLhEInnUYIlsm2W3S8X4bWdkpJfeFzzjz9E1OfLi5vE1FdiA4FWptabNDaGym
         VEfCCdO016d7UmyQFlb7a09uYoCIfl9AsRmCBTBFu0lLxMZ/gm97t7DxfMDv9giinMKt
         30PSGfH8UmrszhwHBwrkWLMFHPW13czqDjjrWRRRKHFl473qVXXUFz5rrKRABk/7ZIoX
         x551SOAgWbDkUO9NpTgYNvE13b87HOZkmcg/gDjiee3S1BusCQ25G7krfyU44YdTrkZG
         cSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774566304; x=1775171104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kLvt8ALPWVdvZI4uxDrR8DdfOnNc7X8dwjsIDh2c50k=;
        b=iToqxYh8LIakX+09S+N1iKmPzLKtrxkAKHI/utSMviVK1PjI3PVFiw2tB/AI2zf1YN
         0+QYGi71kbV6Nti5e2uhCURDwdHJImlFJDYp1Rz9WRud5/HTuePrzE1MjffY3oO6EMTl
         lPk2EZg/qG4U7nkSb42VqSc46+JjP5+Wrl8Ui8EYX2Y3PM25mBZHeiqcBADGFHiuYKjT
         uSAo2s3K3ueqSVFg7knTkmjWxi1j1OdKIC3XW9jLpzrGiTuKX9lv8xY+KpdoLjga5wpR
         V4b5MBBLBVmPsqaxVjg5vRdIXXpVopM0xMV36UIG7SFoAkTl6zNi3wIDD2ws3UHYXCBj
         o+pA==
X-Forwarded-Encrypted: i=1; AJvYcCXC2yOdU6GFsamp57yrLrQ599MaunVV6vaUOegvj4RLRvnCK2rLbE+cCn1mvet1Z9pmKL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVFltsaLucN/nusR+BMI4O0Z7YuBSPH5pu3MnyTFEtP9+naA8a
	FaNW//U8UP+nPnpK1mAqiaO5Le4b9fUoNNff2e+1cnjFOO60MEPSaA07au2fwtO+rOwLfroJCfP
	QHT48bDNmjGDm5nQmsAv/CtcYnGVFgWjB19oo6hEA
X-Gm-Gg: ATEYQzxSOETVnu3r3WNb3OtE/eDo3nsv21GdZcHvhYstQbyTANJwHKZjyYodSt4ImUL
	ta3ggOVpIuRg+Bi690GA3kkfSPeYJAJ92wYIkoMXR5WG49nRMw+rMx5aP1z/Trt6wvuGikQFR4v
	qmJe1ZaIzXz5/5mazg29nHSYlaj0BynaOnux3NPTre5niyB52lpd0/QyxNSWvlmNqoCOLKJrf30
	wMJ2JJUJthdMOShTtaqKdVsetcF3RvFZK2aZ4i1e0CoHZTO5341PoJAaaSrPpjw2X8W3R2TMmvz
	1mAljH5G/rzbpa2+yw5Br+qZ2CHDapFbYYJYScENuC9xXNVP
X-Received: by 2002:a05:651c:41cc:b0:383:31cb:e3ae with SMTP id
 38308e7fff4ca-38c730b9edcmr1215331fa.9.1774566303147; Thu, 26 Mar 2026
 16:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326114919.519456-1-maciej.fijalkowski@intel.com> <20260326114919.519456-12-maciej.fijalkowski@intel.com>
In-Reply-To: <20260326114919.519456-12-maciej.fijalkowski@intel.com>
From: Joshua Washington <joshwash@google.com>
Date: Thu, 26 Mar 2026 16:04:50 -0700
X-Gm-Features: AQROBzA8YYbhp_WNDVEgrQlqIcAqd1g3tgIQ2HlIhS8omAzHiv5MEEX3d9L4hKs
Message-ID: <CALuQH+U0NJYxFZOeZ=iwJAygQvC5LHg0xAKWTUdHWqXoFunNLw@mail.gmail.com>
Subject: Re: [PATCH v4 net 11/11] gve: remove home-grown xsk's frame size validation
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	larysa.zaremba@intel.com, aleksander.lobakin@intel.com, bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 5:02=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Since this check is now present in core in xp_assign_dev(), remove
> redundant statement from gve_xsk_pool_enable().
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Joshua Washington <joshwash@google.com>
