Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.54.127.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842556;
	b=iJoMWOX1sf4jVxHcYqrJxtIdr9GrVh+y0tSciOJN+TH1uQITNo0w/KSc1pxSGfKlVZaE
	 FHYIoPFtaQseKP+/MymQ5yqO795s+u72c3cL9YIPp64nzFwabQz6e9aodAF4vLtPUeZBj
	 oZQt5hXO8sLCzytI47YNXfsP+afnk9A7Fnx/vv1+yI85qcAr26rw9SgA1QFPrYDOKYfen
	 yCIgFcRkWfMnv4pXCcALfVk3/GDA+4hhuj56gLSd7MxzQbJxdAfBpXqDCU+wfjOToJlt7
	 CJUmhtVDKRj5rxlW4A9qc4uhKeM0y1NL8K1ojpFJznRCnLvhZdCvpbrcucOnNhJ01zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842556;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-Envelope-From;
	bh=Byk3b1p7FIG1n4nWdBdX+H5EVJy03bY15RLhO4zDo54=;
	b=1h1Jh6985pfzJd0hmF39ClfCSrezBovQv+QAkoT7W0Ljw9Ewli5Qqe8N9Z/ryPmBtBaq
	 F95jJXdRWkNf8wbO3XZ0o1JNJVEsja00m9LR1+G0F9dndudSePCETM/viBCc2kHb4etOI
	 WotnMryFoy5cjmjfcCgQXCxm39pLEvRQk3ROnpb9xaGaBi2egs1CNQolpd95xXtmh4JSk
	 RdMvxe2G8yVgYRTjtrAiNE2P8K6BDZ9X5l+bhiVYMaiwYCKGxeRT7mA94oFI/U7jKg9AN
	 6vFK7nqpObhXLxSVIME1BofnKhtW9Z0+JV10CirZ2HV0RDz/y4h/jtkLgJThVzOf/nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=hwBFtluc;
	arc=none smtp.remote-ip=198.54.127.65
Received: from out-zbxj-a65.jellyfish.systems (out-zbxj-a65.jellyfish.systems [198.54.127.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB58606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 15:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FB58606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=hwBFtluc
Received: from fedora (ec2-52-197-241-54.ap-northeast-1.compute.amazonaws.com [52.197.241.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jSs6h3nqYz2x9D;
	Mon, 16 Nov 2026 15:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1794842541;
	bh=Byk3b1p7FIG1n4nWdBdX+H5EVJy03bY15RLhO4zDo54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwBFtlucljWVweEsNc1YqL/MQQQFf96vjPj06f9Uj0CefE/53Q8hl0nEKtIFCcw/n
	 4wm7maA29WLB/R9fRD7Bd+WVzw/QxGJon/+fQapyJh9W9MfFOXSw0bOE179SQ9zezV
	 ZoGCKfKezZk4W1Pde4pO9rM0966YZp2W0H1Jio0z8JFuLT3VveoTwUkid2pCpZREKq
	 9VRtR2AEYLgRHbuAJeNL5Eoj8elugf2DkGwQnN7Tuj5qR5y8jjGp21UzD3ysdr7dE8
	 JhIwUiskUH675+gxE10Wy1nwEu+XDB5tfZjyRpFOrzH2vBLslI7WlJnxwJwiyBswvg
	 jt3pyiDOgaIeQ==
From: Tianyi Chen <hi@tychen.cc>
To: sashiko-bot@kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v10 1/2] bpftool: Use batch lookups for map dumps
Date: Tue, 17 Nov 2026 00:22:13 +0900
Message-ID: <179484094141.491469.9991426657711805921.rhash-batch-review@tychen.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-208531@kernel.org>
References: <cover.1794380384.git.hi@tychen.cc> <074a359a044d121b4d85d5b15b7740bc9a9f1073.1794380384.git.hi@tychen.cc> <sashiko-outbox-208531@kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

> can dump_map_batch() silently truncate a BPF_MAP_TYPE_RHASH dump when
> an element is deleted concurrently?

Yes, this is the RHASH cursor-loss bug addressed by the separate fix:
https://lore.kernel.org/r/cover.1794379108.git.hi@tychen.cc

The fix returns -EAGAIN for a lost traversal key, allowing bpftool to
fall back. The v10 cover letter lists it as a prerequisite for the
batch series.

Thanks,
Tianyi
