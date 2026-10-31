Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793410312;
	b=RmuxLbTeANAGs85rFePsxM+AFNywRm9cwlpKHU98d0Wc1DC9jZeFMzvwfk0BgMYwKmWt
	 xVu1on/fqo7DpwR+fWnMh1AdP7oEX4UFtqL1hRkjyB3+ivujcZZFUoFcDT/6mVhJhqgoE
	 UYuOWpPzp98GjjfCnUv3v9YlmxfJA9gCzi9XfGfOAyTOeet3BBq1edijobPd/Vg2hTJQ0
	 ySuJ9vNP2US2lic62lt/p9T09kaLsfnyBtKBhL/ssD6x9EkjWkHtz+lRJHwK2QsSqlBoi
	 s+Y5aZM3FeEVKGTVLwkTA0A84uyT0/gUIlCFEOz1mcCvZiBct+54cfENyeOgYoZXCBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793410312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nnMXVI7pxSqYqYmr+cJgAyqTawsiLp5YajS+zEQksOM=;
	b=RrysvyVFchnryuFUgVvpkEyhBhDIA4G41bfc49sjiYGyiPst6RySE4gKGU6+bJqwmiGu
	 GTfMXxuYT2on7w1N0SPTuUJzebiblwxPhOLQsQLSR9f38w7h9JtfhwOb4NKrJup77fSz+
	 4mipP0p6NAfAIiyQtvgTjabebwuMxxfjJ0No/Kcejo+yX7G0WbbD54xBDOmWNBt+g+BrJ
	 VEmIGWsJM7S3N91JU0VRNp1fugYReqqzd9scIvtm+l5t0dv7e0RZP0KCeC7G24s/1jEyJ
	 f1BFklM6eQBGsB0Vqp63yIx8RS3R25N9O73AAU7akvlRQeYt+cglBuWOUcLaZbmVR8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VpTC+yCU;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F63606A31F
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 01:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84F63606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VpTC+yCU
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a24f47293so718111eec.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 18:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793410312; x=1794015112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nnMXVI7pxSqYqYmr+cJgAyqTawsiLp5YajS+zEQksOM=;
        b=VpTC+yCU71DBdqXgz1LKbQNMOo+CoTVfbjagSAdjMqu/UezP7IeaVnTLbj+D8DT64a
         UgpIB/AoGz+QTWDXKQGu5eBN53Ah4U3OyB8xG/N4UtjGnTTAIK0698FSBrMBFrxeGUWW
         dcxhyrkWPDAlD055uHgNpHcaWdSU631DRHO8KUI/NjLmtA5C6YY62CoVuu41PEjbUR0w
         9yMpK2Rs0cVaYZTrJ6hOV4KrowM3q6fE44FlnK+e4WVWcaLDUFryb6sQP5InEHohby/Z
         TgZmnqsMovDi8VQmWkxF9tt+UpGJDOKDk8/JAOA8TqAZAgNpbI5lnV5R97otEtz8uMJy
         TddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793410312; x=1794015112;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nnMXVI7pxSqYqYmr+cJgAyqTawsiLp5YajS+zEQksOM=;
        b=Qg+LkHxwD6FWid85gmqNtPNMDNGAJmgW86+u8c7Od978HbdKS5pZwrm8pxw6D0cdo1
         t+2j9coIH04bALdnY+nFgZ1HG4N8VXhtcOopW/6xg4mCrnR8rYk06ifXiMgU3QQAI3uJ
         D+6ouE/nDVWyf5z7PF7rBsucC1OVZjgHrxy0VBNOAjW1m5ssXJBATw1F/ltlwAiFXrS+
         4CgQLxLJpOmrhnHao3S3uj2v176NovddsAFxjjp8BqABediGmn6y6Brb+xX8XlDMiPRL
         1KLIBWL717nkpP6dNLkg68sVe9ha+Uz9ihxCYN5tp3xnaS9m9rNliqdCryrGOORtDoeT
         mOBg==
X-Forwarded-Encrypted: i=1; AKwUvBxBXUgzt9VGAMS+zibpxm+XPS7q2OQ1WZYuxRHZASeXXKBHOPbpKQ5+ZOwTF2Ww0GyKcm0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+Y8kFH//H6Qqh0Y1MRpi0qKMvwjORYdqP+jbR1J09Guruqq6n
	dZpeHkPzaM+hXD+IfDEJ/H85/aUQ+0/Gr6JkIrkep2Sr7y+i76Ke3wwD
X-Gm-Gg: AYBFou3pBHbfeZ7Arv2+7tzrpxb0sSX685IIE4kWJDHqpQLgDW4woEThfrpzame/1O1
	Mkfh+jj4fcHq3q8XBVdF5BCj3HQgUJdnbKdBdXjgQ7xO3ylPhUlFyNMMBVjemLvbabojn0boCk6
	MQYMV2XUc/FkZFUiFMF1cBlBZmzT9eieM/NnL6NovfZ6NS/SzRecYnbXKfDN8Ozd7rWOKAnjNQa
	MT1grTZCPbaPe/uhTwMuu2LtTvxFv5CnOj05nYBmKG6ldtDuWqMcRQX81e1Bf7XS/vx2YxOLZl8
	sky8Z6DtMxfZTbE9s9CPMkqpghyUYsMv0Q2mRF5ozDbt3NR00aHVjOgD1GbPoj6HTcPI1yrgGg7
	CXweqhqwqZLpZyGCRhg6tH45cfrwWpxouUqiX/GTTJAdlqsgBT1z6zRAYeglnW2TWjWW1QL6hWE
	D9v7pvbB/pNRCK6/J+f4jVyMnISt5NdnRuEeTBZz+Red6o2HyYFWeL1ahIwLvtcX9xAvfuN+3y5
	T0fwqMb3T7QiTLWcegN+zkJ9xvvhaYkvolM9/u6DqD4jzKNzqTtyCL/euXQvU8POWWPk/3J+j2+
	QIzwSDCpvFrXzsitT9wZlXULO1uuKQIXSkqARxVUQaXk6Y5yaXKf
X-Received: by 2002:a05:7301:1927:b0:369:f419:e7bb with SMTP id 5a478bee46e88-36a4260caacmr5280670eec.39.1793410311487;
        Fri, 30 Oct 2026 18:31:51 -0700 (PDT)
Received: from 192.168.1.3 ([2409:8a1e:2331:2850:d40c:1fcf:6319:8524])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4294419dsm11009649eec.18.2026.10.30.18.31.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 18:31:51 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] selftests/bpf: cover AF_XDP multi-buffer TX software checksum
Date: Sat, 31 Oct 2026 09:31:43 +0800
Message-Id: <20261031013143.42509-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <auT51NbSPvKJwgiD@devvm16445.scu0.facebook.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-3-testwrzwrz@gmail.com> <auT51NbSPvKJwgiD@devvm16445.scu0.facebook.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Any reason you're not reading the real value from
> /proc/sys/net/core/max_skb_frags ?

The test wants to exercise the maximum supported number of frames, but also
needs to run on every build. CONFIG_MAX_SKB_FRAGS ranges from 17 to 45, so
using the minimum (17, i.e. 18 frames) gives the largest bound that works
everywhere. af_xdp.rst documents the same limit:

  "For copy mode, the maximum supported number of frames in a packet is
   equal to CONFIG_MAX_SKB_FRAGS + 1."

xsk checks MAX_SKB_FRAGS directly (net/xdp/xsk.c), not
net.core.max_skb_frags. I also set net.core.max_skb_frags=4 and ran
xdp_metadata; it still passes, which confirms xsk does not consume that
sysctl. Reading it in this test would not tell us the xsk limit, and would
only reduce coverage if it is lowered.

CONFIG_MAX_SKB_FRAGS is compile-time and has no userspace interface, so 18
frames is the portable upper bound. That is why I used 17.

Thanks,
Rongzheng
