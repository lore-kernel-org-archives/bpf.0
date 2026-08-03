Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5279D414DDD
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765562; cv=none; b=FqNiK9O6T9qxO8jj5tB4lox16b98OwZOqcNvGS6UJ4ThkxOrR6OQs922VhcsPaUlOwsyhgOPl7VewG+YnonznycUH5REreYHXOQYiuoqO/Y3gVyIVnHpD3TEEVp0Gp0dPCwsN4UJCN/0fYMIoZoyhvrQhotLQpBoi1EWwD/OxEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765562; c=relaxed/simple;
	bh=h1cPNjRA/0r6gNoruyluM5SfZi1K6x5n92plUA+GKx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7+E4DufYwFc/eeIc93A+jjZ2JJDE0F3KxpTtFFs+3+W5/FMAPBu5h0rEpv7hJ75B6y0kNKQzWe9Tw/vXOvJSzIxkq0jz1ICTzBv0rX/7s5L58LOGAI7GpT1ZA2UQQoS0oj0jPb3R3j7dzLI/IEXXwQhLh7OK98ov1TAcJvKXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Py69VPX3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py69VPX3"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so37776115ad.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 06:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785765560; x=1786370360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h1cPNjRA/0r6gNoruyluM5SfZi1K6x5n92plUA+GKx8=;
        b=Py69VPX31Vw+i+BdHdAX31VjutgUXIWSPj1zbNJRFFvRUxNuh51OqmzjDYPFeyb6sV
         Pg85rBnXCSDlMCp71BI4m+m5Pa1K/enCZyh5TIcbzq4KtW5IN/t+bvvRJg7p6Kes/FWi
         oe4wHrc2R/Nqy4jXhp7AubKt8il2FHQvNsxHnMke/ITASMtqLotc8G5WiQ/zDQSe74gb
         BEmkiVdlDhUZxh2nOkNsFbpWXfceabwBLrBV1UfHkhwkahPMVqNPTRW/3IlBpCtoJqTz
         7g00zB7aGas+0itOBg8N9ri7UzCPvTIEPUBurTCsP8Z3XMA4fpFgMhyQjweky0Gkh3aW
         SdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785765560; x=1786370360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h1cPNjRA/0r6gNoruyluM5SfZi1K6x5n92plUA+GKx8=;
        b=izVm3WC2ydXKE3X/VHzafK8RKvfIn9QAnE7NOumr1epaHgB/boEouOCOeoPtZMLTCU
         qVONm+ACD2MLugL0YDd24/y2FDsD76sZmPrF6ddrQl1A59d8DgAN2hDfG9MFhjLzozkV
         058DFuV7xw07MojM8RZVDdv4hiNUnmEKbK9IoFlMA4aj598+ihD5dliRdgQAVw2mRPf/
         s3KSxiglNUrZ6NFoam4b4WGKn7kl5Xxw6O7ziZYvRzaKqTCbSLxK08HqLqr14FAkbBy5
         GTifktYqVYkGAKQY/V+VvosVxJ79tRIApb0HMV84D06NdPWPZ2GbUeXDbNFZbVp43cE7
         dI3g==
X-Forwarded-Encrypted: i=1; AHgh+RqEVW3qSDB1OnR4xPT4CxDy00fGIfV5WBhql8bxNy7o7sAsxybHr/KvOJSoSz28qs+WPEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs0bAp18nEVTw79A0Kxr8j1XLlOuYJeI6p4h3r8DHAa0RGI2sK
	X49n9Gq4ony3SdzjpK57bofFH7sQqVLNiek4o/yuLEKdg2u+5DRlhDDr
X-Gm-Gg: AR+sD11X9Y875nWMuBan2I5AZBC3NEZaWs6Cv3h0CxUfbUe9c+xRs0u/BygBvG5dGOA
	1009ZkF8kbVVxbw0K3sA5T6dIOgP7GzluZfAcR4bFF+WmRaSO2SObnsrgVvnl37LWiOA2a43X9C
	bQyea97IO/eSoXRdZHQgFw9yu2xdc08NPx4H+ZdjX28oei9gSgrh8p3zvApliOE68qItZXw4Bu8
	k8M0w8peBFozVOx0ia4QCzbrEAgs9yXgOvEDYomgH3rh/ux5AlCmSLH+1ZsIuHUgM3LZBCBeWEX
	ABOJvKBFEAP3mqx92MhDe8dvqAd08wmDPf5BQfw9+Ux7q9T15hp//w9DqNbH64XBx1wLudx8Njw
	U2/R77qR6wupvMroPTPvcI1uFxLbwCjXDC7CNxn/Kfqpb3KYnAtTOg6BylSGVWd9KlrCFWDVyWg
	JaAcmfeuyEtDjR4kgJkrppg1QttvFy346Db7FNsGgun7Lkutm6XAnvMQ6uw68PG85JKYYo5tEyI
	IDB3Fg=
X-Received: by 2002:a17:902:e5cd:b0:2ca:d7a0:1312 with SMTP id d9443c01a7336-2d05229a2a8mr101594235ad.25.1785765560531;
        Mon, 03 Aug 2026 06:59:20 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain ([167.220.149.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04aea2514sm38586875ad.37.2026.08.03.06.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 06:59:20 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: maciej.fijalkowski@intel.com
Cc: AutonomousCodeSecurity@microsoft.com,
	blbllhy@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	magnus.karlsson@intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	tgopinath@linux.microsoft.com
Subject: Re: [PATCH net v2] xsk: fix NULL pointer dereference in __xsk_rcv()
Date: Mon,  3 Aug 2026 09:59:15 -0400
Message-ID: <20260803135915.1615-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <amnJiQHa9s5PtLek@boxer>
References: <amnJiQHa9s5PtLek@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the suggestions. I am back and will prepare and send v3 in the next few days.
