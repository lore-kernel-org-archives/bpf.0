Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405323C3F54
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657377; cv=none; b=RTwV6OaQMK7cQrELFpspXyS0XYg9bNrzgFqX3buaQUDbyZLl4qOCvlpq+t2HvQn8GgSOCgdWh58zDHJOSn0Jop5IfVSEvRS9tVWr5Y/saEuyAxpDyWn/1w+pA9N5UAqx6KUXexT2bGBU5oQc3dHKcD4osHkIh8THdZZIqKBhsBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657377; c=relaxed/simple;
	bh=huyJMFlfQJ3dOAsamBtnzGlfdRqKt9nhuuxDEDmUYRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdl5Zf0HXouwaEM+Pc8tV4SmSQttuouU+7T2Kq+8tFcm+CNSsYFCixXbzV9a80yMsSmQOfDzn+r3x+3RC7lXcczXP+7ZJQRhUDRu6/PlX+NiHnIc/uSFWg+71rDNBT19l8In0kVAnP5gfnPZd5XloL8tsgIrdIscCVVzeK/+ysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYRDP2o2; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYRDP2o2"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-836cbcd0a48so5692097b3.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 14:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786657375; x=1787262175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=huyJMFlfQJ3dOAsamBtnzGlfdRqKt9nhuuxDEDmUYRs=;
        b=PYRDP2o2CWjoB9buT3ASd6aSVMT8akCCHeSR/6oxwwaRcmcIApCKhk8WohvrnhZtsm
         RvfpFAwaCTD1apwh8y0G8Yd0aZi/zezyLLug7YTucKkNqEAq4YagSFTZEzpWy62CqBJ5
         eOCswou4YvRJlsKDMNmWKZrTN6R5LRPOdEm0/ZPvNsuk1MaC5TeNQHNoLcruGjVBRb7E
         8ltvbH49n0xNcpHVRru7W9C+4KD32jSlz+75DOfq4J1xkiMY12fuM/ROc9NFZWM+MzC7
         Eiadv8JLY8eQm9roU1uUuHZ+xm76J/u0lzDHUq2qUg496bciEy/BCQF3CbJYuJESo4ck
         x0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786657375; x=1787262175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=huyJMFlfQJ3dOAsamBtnzGlfdRqKt9nhuuxDEDmUYRs=;
        b=rKCJUE2h+5iKe/Xksp/lAFVZ1bA6Xi437dG8NgpU4waIS5h+gmNfpCnw7kI/gfMDV+
         djzPZoPh0W1i42emEbY9RPBZBG8IlMWZXoN2JkmRDHUS+DyH5kvsO5yI/0283Ta7027d
         +z++01YKScr2zWXT9CmEnRJ9g9Sqs1GC10+J5LErmvK64xV1MfNQo8+gEeioD0M4nCtw
         ivhSCQNSn1nxG/njIEREgAAhnjqC7mPu9ItXnn6+FC+cD5DBmvs7wKSrjtIi0yO0zXyA
         hhHCxF6kIrXxeb04jjR9pXUuutI9in/6lluEhIM2INlWHg2gOJfdCMuc65pcqUSVX/ko
         fCtg==
X-Forwarded-Encrypted: i=1; AHgh+RrBF7jaViJNXBlrAJl2WbUllJMw8Hgq/XLJIgd8SqLs2eBTe6KuSdhPodCn8x0oRQqNQxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybchLi/2PS1ZuwPWaj8vGCPV/NkmRYjHmukZsPS8vzL+HASh7h
	y+c3FqzNixxgKCkYZl1IDdZWkAJZQSR7hAmqpApXvK1n4eAW54j6FAXk
X-Gm-Gg: AR+sD13Lh8Ab6/38jKRIKaBrCmK7w17ZEy2w7G52ogp32OSYsv0eb5WI4ctevbKMoCP
	JMa3xRp0UtNnxDMuEA3ecFU3QE5G6s5uHKgpwpr/IfnPuVr96CDdHS4N6VnEf0w/me20RyUqhEH
	X735k53/qv/2z7Pybx81lo+VASQm3JwkXl3jw/pcsGniPp/pfU9SoQA3sGwZ5hORQo3+lkPnjzO
	bPaMIuLocpyF1k+GZFKfV4Wvy0UwrUnFs4q656BSg4wdxt7BQ+x7zsurfyzPfWw80OzZqdbbM2o
	ufARBcNsGjGacKMGdg4t5mP3aSwi2joOCytgI1m+ridfft4DxSAkyGc64J7MJyghECKD6kJFTK4
	Ij8ZHVewvKjrJROZNw5CxrWkzu0RLuPDecKJ5RCpXOTHRPlJTLIR2gATJ0CoHoatZswyaXJ2oGE
	FoVYFpHhScUnDiadUSgKVPgSuDTHXc7NyMI9PNQXF5D7rrfpPHgpiQF0tY4GQqq15pCTjaA+RC6
	rdShA==
X-Received: by 2002:a05:690c:e5d5:b0:814:7a54:3a93 with SMTP id 00721157ae682-83711836371mr5686327b3.23.1786657375206;
        Thu, 13 Aug 2026 14:42:55 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836bb3ed2b5sm5069637b3.6.2026.08.13.14.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 14:42:54 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: horms@kernel.org
Cc: AutonomousCodeSecurity@microsoft.com,
	blbllhy@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kerneljasonxing@gmail.com,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	tgopinath@linux.microsoft.com
Subject: Re: [PATCH net v3] xsk: fix NULL pointer dereference in __xsk_rcv()
Date: Thu, 13 Aug 2026 17:42:40 -0400
Message-ID: <20260813214240.96466-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260810132505.769431-1-horms@kernel.org>
References: <20260810132505.769431-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Simon,

Thanks for the comments.

Given the extra complexity of reusing the pool-global xskb_list here,
including the locking/concurrency issues and the hidden implementation
assumptions needed to reuse the existing frag helpers, I would prefer to
go back to the v2 local-list implementation, which is correct, logically
simpler, and easier to maintain.

@Jason, regarding your v2 memory leak concern:

> It will cause a memory leak because the current xsk_xdp that is not
> added to the local list will miss the chance to get freed? And the
> empty list_node cannot be easily freed by xp_free()...

IIUC, it would not leak. The !list_empty(&xskb->list_node) case can only
happen when fresh aligned-mode allocation returns the same xskb for a
duplicated user Fill Ring address. In that case, the xskb has already
been added to the local staging list by an earlier iteration, so the
error path will walk that list, do list_del_init(), and then
xsk_buff_free() can recycle it. For buffers returned from the free_list,
in either aligned or unaligned mode, xsk_buff_alloc() already did
list_del_init(). For fresh unaligned-mode allocations, xskb metadata
comes from free_heads, so duplicated user addresses should not return the
same in-list xskb.

I'll prepare v4 based on the v2 local-list approach shortly.

Thanks,
Cen
