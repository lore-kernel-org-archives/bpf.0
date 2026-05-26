Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF8C3D813C
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793112; cv=none; b=pJd0SM0//irZfD/E1Bv6Tl8SQTF6/RpT6Hg2J/NLJH/YjsfvbpAksiB0O7LOEwofEAKa9n76HgWV2IoH++nhiA0duZ5BTSUEBQwcefN+xGXMTy2tN/4KOvliXi4/4SPY89UbrSqIGWZhwX8OCywoEbS/9y4PtqJPmr63uJMGOzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793112; c=relaxed/simple;
	bh=a97WdgvdJR2aCC+EG25ggPwSDJ17gXcQGcXDd0S8MFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nkMHZMx2o0LPY07+wtM+9nDl6iNBWDjK5nDjOTmVhcEg52uhHfDztqiIWLQNpBM9LRLwdfzhmpe1JzISNii5ErivyYLJRPIVATd/F75SJSMHo6AwE3ZLc0CvMtH4+6IZ0qHI55vtVFk5fidj/Ydw5KHAceuBUbxItd0pbDNFGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WAMXr10t; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WAMXr10t"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67b32c695efso19742695a12.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 03:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1779793109; x=1780397909; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=a97WdgvdJR2aCC+EG25ggPwSDJ17gXcQGcXDd0S8MFo=;
        b=WAMXr10tw6jizu/zk+SCS/wNFyzZ6w7epwjRZn3G5o+jlgIjroBhus24ZvagQ6jNPt
         ZZL6dPKbaFoF830ZtgrtBMZwChiO2ZYKHTFiPd8KaIGXaAURkSSDWPQFcEpovtondloA
         WPV6qpPW/AVYohhZqZS20yt5sD4hY6zEWkEMOas0jIuXO6pWU4fKDRdj1F2dHNiYDrof
         GzSGtn9Bqjd4sTGbVj1BbOyCCCjl2wLPdf0EVjPF5TwB+ovsT2coa3xg86g1V/BY8+XW
         pRI6bg4MSJvupMLSV2rcQslRsKHkCHWldpNJEcDDQCoE5n5GqJWRAiEz6K2NuZXVSQeJ
         cw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779793109; x=1780397909;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a97WdgvdJR2aCC+EG25ggPwSDJ17gXcQGcXDd0S8MFo=;
        b=Lq8BK6ZDTdnVi+4Y1fwbPOHKfMMpfcIC049XtPERuoQhOAZ0D+FyKc/AyN3mHzCjwk
         46HgznSmuJ1d1XQiIdMcjvK4131hEUvK7EpUE6xSYez2A8Y8cqjl6weod/Y9STXEewVa
         qryoLJwWe20L5acoTItQ+91b06e0BZ1s3l8LUn5iZ+gu4MhJijosz2rnUFop6Rhid5q+
         TMw4nkem8TPt/P5ZHNlqWAJ2G9Mck7PgpmROgISobYYoDBpbAH6O7ByK5V5jZK7PfolA
         YBZILAZdLcMXr+uF8hcrR5qdJAep4y66887Uf7BY3UaMala7K1HUqNAaDGJ/qlKg9qe6
         Q58A==
X-Forwarded-Encrypted: i=1; AFNElJ/DFdEBVZvigsC8PMRgm8gR9GbhX8r6P0CFsuLVHNSgy0LyOuJhoNPAfNJ+VUh6/hz4IyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBKPnBz/b3//mWEEQ3rPlII1gk2upQhfzKr8OwHxMPvwyoqs9O
	p4L2tuCMfbmkPhdEyok5xVoDHAdwqvh/VPH8feYBmKC1SBILNHngGhoV/4q1oqMZLvk=
X-Gm-Gg: Acq92OGJqC52+BiwfnkUN94aoDRDAN6AYn91al4IZH2uA/LgKrenbjYcdUg4abKCU5S
	FMIJaLCfNW9xPzNcOrNpcXgbXOv0WQI0deUy3/TdH2DTZ33fYSs7TyTZUPOoHORsFclQwcpVkBf
	TbbLUw4DczU3mmUVA85W5hIuvqWW14Rc6pkOyfm0lmqqXatu2ZEBpMD87KiFPTBmFM0e1PWc/Tf
	jCQUZMkd3LgAxcvB/1kYj7Ym548xJD2Oaxt/yLicI1kIvqm376zMWS9u/RpcNhNtSN0dci+K2gQ
	QPpAL+ukfnkqjNCkV/iLIiRJwe1D/puVSW4BkEglPww+5fqCNWROUNDFKj0AQEHuAKmrlQf5F4E
	1bPWhORUxncXfArfGPL2Vb/6BxS6IoY5cn+S8OLMOdYskNbKlkIFc+pnSySOHQGrtLAT0QMDAGa
	t1hbKX7WblpuRRCjHT++gjCesL6Q==
X-Received: by 2002:a17:907:9454:b0:bc1:9d5d:e020 with SMTP id a640c23a62f3a-bdbffc5ff17mr1141064166b.10.1779793109597;
        Tue, 26 May 2026 03:58:29 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc355d25bsm478129366b.27.2026.05.26.03.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:58:29 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: sashiko-bot@kernel.org
Cc: "Jiri Olsa" <jolsa@kernel.org>,  sashiko-reviews@lists.linux.dev,
  bpf@vger.kernel.org
Subject: Re: [PATCHv3 07/12] selftests/bpf: Emit nop,nop10 instructions
 combo for x86_64 arch
In-Reply-To: <20260521132121.EEB4E1F000E9@smtp.kernel.org>
	(sashiko-bot@kernel.org's message of "Thu, 21 May 2026 13:21:21
	+0000")
References: <20260521124411.31133-8-jolsa@kernel.org>
	<20260521132121.EEB4E1F000E9@smtp.kernel.org>
Date: Tue, 26 May 2026 12:58:28 +0200
Message-ID: <87bje277zf.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 21, 2026 at 01:21 PM GMT, sashiko-bot@kernel.org wrote:

[...]

> Would using two consecutive 5-byte nops instead of a single 10-byte
> nop safely provide the padding needed for a 5-byte patch?

Perhaps worth clarifying that nop5,nop5 wouldn't allow us to leave the
CALL in nop10 tail after the optimize/unoptimize cycle.
