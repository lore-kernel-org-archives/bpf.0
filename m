Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D53101A0
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 01:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772589147; cv=none; b=LG8mvr4r8baK3J7210Ayx9/LMvBITF1kuPA0OEEUceUn2LJGPkMel7STu3EmhcjySuha0EYwOhWb83t4vkptUTf4Myhu2FY2wGtfbQ4PMYn0QqoxJgWu2+zJt5uLiFGHbZUS8dFUnvj95WHAuwDKUSajEfcZ5q+moMY0ffG1ypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772589147; c=relaxed/simple;
	bh=rPTY48Iubdpu3NXqy8HT4V9ZO1OkhsoHpesXWdjQcyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GCV82pEqruWaJDrLkQieL9hd4XUC3e8X1suv03U77hEDNL3gIVqiNV+2SFlJBl6KyC7GkLmttUypkOZ/urCAzJ99mOVFRpO9nXiwFzd1KT+hUvLDEXrXpiwHaxi/hT1L2DAok7/m4iH99Gv/0Sp5td0CWs5Ob8YCodrD6e27HXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtsiLxOK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtsiLxOK"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae50a33ff8so22902575ad.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 17:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772589146; x=1773193946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIvIgLHoIA/uDprnWtl8reZar/8ysIY1y6EtxkybfUM=;
        b=PtsiLxOKAnZ9tEhClG8ESRh2vTYOUoFW39PAyzPvM5/CjswgMRNrsvDrdLVJj6wx6L
         29HeK2xhCarltxdHnHT9pOVsJxTjtybYhAIWQsLRWeHtDbJj9LrUmp++fcaB5vkoc1B4
         jv39AlhFk/I/pPh4HQjXDSaXzPbwat5sffDD9SreITKtI3O9jigvtCv8/ELdRyqCm7VO
         Tx9w1KVp1oWgaVt5nwQjww9GMlDgvttVYE6csaeT91UQzVLDDz15J9uK7X77AqNOVPTq
         u0BTqnSCi4A2220uY1wQXnnDbaFd6Qk35g8utMutbyc7OnQfSk2WJF3117rKGfsKY/w8
         wo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772589146; x=1773193946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aIvIgLHoIA/uDprnWtl8reZar/8ysIY1y6EtxkybfUM=;
        b=GsrLukN0Gx6w9pnTRuv+b+rz6BBjHuKx2vUVOPcrUp/xnU3aeFoFt1s3rbP1Xq1nDD
         8Il0YA3++ur6sFRQLVXvvhs6X0uV0NiovfKvK8AEtG1aKie0c4Ut1Q9q9SCZR+90oukp
         1sz72YFd9R6gRnzcmS5oc3G+Y4wVklVDHLM0km/kdbP69tPaWswQ3oznJJKhPt+adVNh
         2N1/jhq/mc8+k+trpMh0+FDAsZsjH5Bv4CU4LE7TUWvXtECUZJ05FGZw5k9lHTKfOeG+
         mAbi5PySLz8EFg+jhIdnmJcZMa4t2STs1h1ZwDPVQuHiMJszdCqt0jcUpHOCE8AwjmL5
         tUmg==
X-Gm-Message-State: AOJu0YxKMtnY6S0A1WrdaxPbyrXIHVVRB0xKxVr20Q8IM9e0QuzA0Xak
	JnAQY+gZZhc0nPkRmsfzcw9o+x8wojZ3GFtxzDa5Kj8qP/HuRQFcNXvH
X-Gm-Gg: ATEYQzxghRGwkFQehPiNkU2cM93on3rKUxMs7omO2ZKHqg5oOh1txLb0wlQKmRoZrBp
	wr9sUv30PJTyE5/4017LX57oQ6hc3d/o5wFtaMLZEfPSp7tffSiwnGtqvf7/aZlmSedvaI+kEAx
	khymEpAkQagajPJsUH4XNZdajq0ivFEd2MLcXt9kr8G0ZVH33dqqxgLX5sv/KipZQ5SdkxV3R4T
	fpcCcNyXeH9egiMpwZjGpheO9hKzZN/0Tl51PzNeO/FW6w+NYWZgH1sgwnYWlyCvGfTDxe/alvS
	mrwvKTdvbTv5WKQ/8um3S4o7r8a2VLzQ4vKz6nb1514PBHjBfDZyyaiMCdZPBQP7qUuUrIh7LyM
	tYAgrZ4qynm27nVv8yu+HZmslNf9hipM6mGuDT9ROqJEtuyXOQrAfzNd2ez4IRCAxTQUfanZbe1
	hCwlsIHDjRVtKJUiS9CnbO+6+EirgH86Y1H58NF/7Nwp5ojenxzB15WXQASrt73UM6xRAxpxl/4
	TXI7BTLV1B3
X-Received: by 2002:a17:902:fc8d:b0:2ae:5426:da46 with SMTP id d9443c01a7336-2ae6aa8e99fmr5074385ad.29.1772589145620;
        Tue, 03 Mar 2026 17:52:25 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c20d3sm251074665ad.25.2026.03.03.17.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 17:52:25 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: jakub@cloudflare.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kmta1236@gmail.com,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2] tcp: shrink per-packet memset in __tcp_transmit_skb()
Date: Wed,  4 Mar 2026 10:52:15 +0900
Message-Id: <20260304015215.755299-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87bjh5drmk.fsf@cloudflare.com>
References: <87bjh5drmk.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Loosely related, noticed while reviewing - tcp_out_options.hash_size
> looks unused:
>
>  * MD5 - always 16
>  * AO - uses tcp_ao_maclen()

Great catch. I will follow up.

> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

Thank you for the review, Jakub.
