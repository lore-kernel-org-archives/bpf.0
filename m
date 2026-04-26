Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934E22AD00
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230327; cv=none; b=L5e1Jxpii9TyGdWz/WWeBCmuCy1/cyI+pFV/B2bp2IpvCHRpsSnXLLamidIDHrYrzEiLS08MMgr/2ieIA7N72To/Q5SEvkHCKaDvH1pu+duEkqhoEu+1r5Ss6yksVjhIZaPkz6vdrNFPqBezPwXKA3xVu45zakiKMTb6Fd5X3/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230327; c=relaxed/simple;
	bh=CUk65o+NTnV2ThIbnYIcCGM3inf9Aoaszk79Z1TaqGY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KCVhxBZU5puNHpAmalffUQVL4BhX6HOGCPZKBpM6ujM9/yEpi5QuNl7OCefx+3w0nHgdKrMD+NrCc84/ZhwVU7rZUMCOPb+6X8zogXgrC2NirAoYsI5E7N7nu6qGWtcGqpD6O4Fhaen5n3SptbSSK4zrpg5MwqEFijeil8qmKn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Sf0mgzjl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Sf0mgzjl"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b2589c26e3so89084535ad.1
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 12:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1777230326; x=1777835126; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUk65o+NTnV2ThIbnYIcCGM3inf9Aoaszk79Z1TaqGY=;
        b=Sf0mgzjlNM2iXeUpzlPKR2CKKZIoS08FT/ZOg3rGFNdJ6IsdUO9knW1qCNSTvulDXU
         CpiFWqEWhCd9cjX/nztf68Bemjng6Dln5XMkcZj3p+WC4PQMcqFo24UPN8rpE+TDQczV
         Y1yIeKSIbU0LxMvMDPs12900+BGu1TYQVlovC+1zZpLy6ioCe8t559lP7TVNZVOODb4H
         hcGzrB+fgIqzrOww2Fj8CcKx8GEU7QpAPxWElv46w8fef58PFqB1hHFS6IG1oeQ4pyoy
         rLp/ox8368nYCn6Ux7bGbU+7AoWT8KaWYpKp7TZ/euDcLJN7xeq+l1mH7yPktq8NRI/i
         amDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230326; x=1777835126;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CUk65o+NTnV2ThIbnYIcCGM3inf9Aoaszk79Z1TaqGY=;
        b=E+TgS2L6BxWXdozjsTg6bru+IF/Znwn0qD7qL2IEYZxCr03x9CTFLKFPBKzW23Fz3V
         hmE+NKbDywJil1SfQ0gASoNqfc20oxqJFP1AsHPgMwukg6ted2ewt7nLPpj/qFIa/pgc
         TGjFAIEnM5DSPoOTXGLJqxJGnjwbZxBu5EikdQh8dHgbgu9ad6GFVHRAk0dLig+4EEFw
         MY8T3r/pASte5EXAhGx8FjeaBQ60kE6+q1oumGZGBhXdxMKXr/mM4ifd8NbCuOk9s63D
         z6fnA5YclSE7N4ytiFMUoATbSInjt3vmTCVNo0xgJbNvyAv7f8ytGgllKmfKF7kEVyDR
         CVhg==
X-Forwarded-Encrypted: i=1; AFNElJ/EIlh/Us/t4DjfWkiNp+Bj/3rMT6HvexIJBx5eoa3TOdyUX00/VFlA7nmvA56k4FOx9Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtOTPsWEpxshqyTX7XgUovtA/39WJFheVOlmtTAMk7c/rcllft
	xdCm7aRpK5/6i4aP3olO3EQSq5TzIKrVgO3sDVaoR5qpBJZSzJvwp+5/dGl9IixgJcM=
X-Gm-Gg: AeBDievwq1c46Us8v3HFW9kOX4oimS1FIYjyBr6Ak6eRWi6Rnm0+NHqeZUs4QNF0bxI
	IpI/4i3okwHV9ThGVK7ICRzLhcdyrR2LRa0KJk2U0drDbFuJY4M6Yg5uPqX5klMJcpiKuqv4+sv
	l8w5R3K2nEmawk8xtsNIwrTh+8p2ebBy88LR52ydCdKBBCA9W3tE/oeo7TmQpDllZOWzGBqWyV+
	rtUmSQsbrNen/2TbUavZm8pzKHB1FDyO5s8feiaxBAq/8lvbT+nYOq/qITz80xn/CuPxn7TP/CX
	HPB4ymK2AUJbMmT0yjwKRSBp2+8qhl+3Qxkog7mVXmdoB72ymrCXS6KM3CZw54gEOBYbwPbP3gb
	N6IIma1z9cLPlwBMKPhiBX3NolwnswUPFr59NjgYLnIViffIknLz6jS8yaMkRMkrhAKJEyoS+nL
	1slNxvS6yCQmemRuKWRpLqDatVNdZP
X-Received: by 2002:a17:902:cf0e:b0:2b0:5cb3:e4bc with SMTP id d9443c01a7336-2b5f9f0099cmr441471515ad.16.1777230325982;
        Sun, 26 Apr 2026 12:05:25 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::2af6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff734sm275246115ad.10.2026.04.26.12.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2026 12:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 26 Apr 2026 15:05:24 -0400
Message-Id: <DI3BKK3IZGQG.1VSX0LT0DODQ5@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <song@kernel.org>,
 <mattbobfrowski@google.com>
Subject: Re: [PATCH bpf-next v9 0/8] Introduce arena library and runtime
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260426190251.4456-1-emil@etsalapatis.com>
In-Reply-To: <20260426190251.4456-1-emil@etsalapatis.com>

I typo'ed Matt's email in the CC list, resent after fixing - please disrega=
rd this one.
