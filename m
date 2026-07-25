Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D652D780E
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784948432; cv=none; b=tPqzgsWiU5M3R32l5Wji65useeJFHTXd5AypWM/8LKiUNX1Mq9kr/goLUKoB40q3XE/vUdGiwGurLkzBZly7EGYl5VKlG0Y8KRgPyxyT/19vi50asal3+lpMZmSE/8TOpQZmlmSD5o7m58P1suSw71D624Ho+72wpeuOuP3XdbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784948432; c=relaxed/simple;
	bh=YqF8uXn973kV70BvwYjv8iv0rJOPusygYoAgrJ8qSW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/5e8XTtYwu8xYlW6Z9sFVTNQhI2Mh3UJAqnH/MrY0vQJ6canjwCbT1mFp+AuxOISbe99noOSfIaw6BseoAJa9tYU4claT8gtBMja5sPbroKfTFr7mgpsQPEo4lPfCubOOD2X+lVglH+SoKTEFFp7iov4imCBe+cKUKcNusv7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPjqOh94; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPjqOh94"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81ed2a00f12so10847597b3.2
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 20:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784948427; x=1785553227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e/c6yCrQuwkxtDBKJryWHPTZlmuJWG49aqIdtTn1MT0=;
        b=nPjqOh94kE5pFXoybmk1JhPScrx7zFrxFev+E9YeCW74B+9USuei3f8NgJtPG3EXmd
         MLhVHiXwxx1kyNDfKqhw/cGJApFy0vWY863XiRyTatwsw2c7QBPco847CCd+4H1VpFKA
         Ht+PDYR6vmKZnYQIHsV4ZseVnjLIU20Cldb8yXpIGavCbotZsFiE3YgiSAPIG4DkJT/t
         OQ1ojFUkBpIxtcGtnhZFhXzqBq/weFBAmtXSxxwNpy9MV85qb9J67cj+XqG2MqEVzfMn
         oFagF9n16Fdb5wSaZzLOD1jcWe8OTK9mn0ycEzR4QY2R1J6QXS3b/kTVEBBGyCvWqnrK
         J9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784948427; x=1785553227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e/c6yCrQuwkxtDBKJryWHPTZlmuJWG49aqIdtTn1MT0=;
        b=BC4gNbQ1hvyF1Rm83cfr3S9JE2o6Y6vCyigjK9Lb1HCjszHMtEoFsNto6/DnhBN6Ns
         mbP8sCD5Wo+vFlvkJwz+UVDwuhgewhF9pEAxdKbQRghTZ6ggbxhF3yyw6INEpmF6Miav
         oK7dFmwLHoCMvfe7UVhivzY6+J0ffZm3mLzdPawwI+/rRGIAztaYdxj+UTEzy2k6g8Sh
         tckg3ngcZG4WmubuIErA3ND0KwjOQBPnBCqXCym3vXUdneJPbCZwMwKYC1XtG+I1lJmJ
         L0vKbACt070Zx0IgwuWvOwEhe7gpRnMx4y4NO7/6BBHXQleumJdqzCvO/f5d3ylCcGgw
         CWcw==
X-Forwarded-Encrypted: i=1; AHgh+RoaPK9U8uYLZsp7KR9pxD25btE4zVOFD0oxcURGmle2H6UyZXrPUpwY/sbzjOmhMNwuvUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkeK72R55e/Q3W0AwKhD6nIW18r54e9SxYPNu75N32mIpKYNaD
	yMjfpZBwlzzTsigzZLtDINu0N0HmOfVFNlbYU5SYF730PiaxUfU5CdRB
X-Gm-Gg: AR+sD11pE+AimA9RpX1sF0oKFiZze/njehjTvnlNajQLr49l18xqECgxjEA9e8mwW7M
	f8NRreyaXNLCBUIiRqZT1QrAwh5AcRImpZqL0DkZQUJTobEXDEwFcuOmp5oMV+OOKv2dle6Q4gn
	49CEw6CI5ibVLGyIJrdvanMIgzIj2EjBrR668gWKceStAy96FBBFZJA22VUqEjLLwtHfZ4Hn9Wo
	CuItnMepYJENbdCqZIhk6vDShO0J60pKGpH34kum4Tw7vdpAYDL+WhIhDZsaL43DqsQiiyxo9hH
	mFRSDoqBPmQQht1qBc8oZYYDZyuhWoFZ/H51nDmNwRqDkCr3SHlrS4NRz8kkWMD+776/xK+ucJX
	jMepPuXf7UA7HeK55IQvA1zQEiSSNrWeFIlFQNORZwyFZnKNuuz3p48Z6Z0mruJB4usHPDBnLjP
	5+2N5urfg3I0AXGTIWwrlzdS/WWCQNKtzNYwUp3Fl5f0kx3C2QvYS+IYgUznMdWzFfrCiGwnQzQ
	V3VT4Lr62o9Jw==
X-Received: by 2002:a05:690c:64c2:b0:81e:9ba9:d36b with SMTP id 00721157ae682-81f69e9bd7amr3122207b3.63.1784948426585;
        Fri, 24 Jul 2026 20:00:26 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f658d32b6sm8270777b3.26.2026.07.24.20.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 20:00:26 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: sdf.kernel@gmail.com
Cc: AutonomousCodeSecurity@microsoft.com,
	blbllhy@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	tgopinath@linux.microsoft.com
Subject: Re: [PATCH net] xsk: fix NULL pointer dereference in __xsk_rcv()
Date: Fri, 24 Jul 2026 23:00:26 -0400
Message-ID: <20260725030026.191412-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <amPqFHJBnDEQGmOK@devvm7509.cco0.facebook.com>
References: <amPqFHJBnDEQGmOK@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> ... which means they are "lost"?

You are right. The UMEM frames already consumed from the Fill Ring must
be recycled into free_list when the packet cannot be completed. 

Since the current loop calls __xsk_rcv_zc_safe(), and therefore
xp_release(), after every allocation, they cannot simply be recycled
after a later failure. I will rework v2 as a two-stage transaction:
first allocate and stage all required buffers, recycling all staged
buffers if any allocation fails; then run the error-free
copy/submit/release loop only after the allocation stage succeeds.

Thanks.
