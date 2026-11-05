Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889242;
	b=iClRAPfNkKx1xAM0Q5z+r6dLeeR0c2KXT86gZAyZMpvjrWEENirzRKdg4bFRsVVh5/oB
	 IRvNMG8H9dGNd0P6ARPGwspKN1+ylR0fEayPuJ8Up4tNOvtxU+xU2MxszmWdS/6MV2kyo
	 f1gn6Oj5DjnNpG+Wrapz09/KdPNqkKfwvK76DPyC7d1VtJRYjeAEt68bTlZwr66MFggTZ
	 o/+AgqQl1PpN6B45byMdmA6Csq6wsJqtD4fnNMGQrH3yMVk7V24PnH/oNu+zzLrO3Ay89
	 VkwiVaVGU7JyxSBHLlwZdYTjofpQia0UP5nSQA2pmy2e2OVkkb5NGyr0MLQZCTfXE6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NdOrVzG3OCGSr60lMULw/RwF+DfcJzV9jGQLzrSIiVA=;
	b=wLCZcADhvHQkESqFUqTL4oV9sGXMwptZJR85upm2GcVxv00FtbdzO+7bnFRPR3p/i+24
	 ffM6os2tizn+pidMK675u9I8r/4q95qTstf5cKTnKc6WniRAf88e8/rJj5F18T6qTJto5
	 6fn5KmRSQXEsU7evkRv4sfA5OXkMfPRIjTWdhfkzzVHhMReEQF0y792ETq5tdOTT8OSa0
	 3DMqDOMDIROHm1HSnrgSy6v6tR0WELxeW5wKN0v1IZNmKYxEvdtN4et8JZpZcUhY4fm2l
	 i1mUOSUO43tLLxQq1o4atFNpuD1YHFsSHlGOdN3rwd4dig2MGPKz6kj4/AzxvXgl+Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=RcItvQZW;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D12606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 14:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96D12606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=RcItvQZW
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so2443299a12.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 06:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793889240; x=1794494040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NdOrVzG3OCGSr60lMULw/RwF+DfcJzV9jGQLzrSIiVA=;
        b=RcItvQZWLu6oodSC2bv8dHfWDL0GIt2qmvKNPvNvKMjaJXxgv9Eyc45gGdT2/H5qMq
         zJMGxlhwIroSZMhz6xRZojb0KdzZDU2epUyYSLcCd5+cR++B1GIvVW9p0ECeyzxaDkIK
         hgp1RiILJ/MVeoe5wK8flNWnrnDvqJCAxSrFXAkIJdAWXJF6iuGgXYpQl+xHbDP9Ph/h
         gukN0UgLTKmH8Axy2gPQvjp+G3thhc0hmclGfbgPV43mdB7r5td40U8/rH6stnGvfcqj
         FdXpbwBKja6bkyyZNo1WXNfPZWsTij547pcq81hOSlQR86GDs6/xrkgDKeK0J2rOJpsx
         FI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793889240; x=1794494040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdOrVzG3OCGSr60lMULw/RwF+DfcJzV9jGQLzrSIiVA=;
        b=l4InDoQAGy8PsCWzrkD1d0hWDf1vQg1yDDkUExdXa6BYmi3CRKeT14F/CuMFFofVcX
         Ma5BRifxvSMKn2/6n0PORfYmxvQo4+iOBzvHolKsRW7FmfwqDiEK1wlimQ+LMb5A1Oji
         5PgVdL8Ptp8hYR5z73qLAColfvAIhmS44a92rtWWnGrZZv6FiAx20ffE5hJC3jD/CQir
         zfPshSHuS9VHpsWU44+hVD/z4gILCNQp/Qamz+bWrH3hSq6pgJ01RaScIwugl2rj5Jtt
         G8iFSG/wkLqGQJcDOYK21Z4JNaw9DZRoYrf964gIE5YY1+NOuEawjJ6IhY1mxHCpODO7
         /6pQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5vUdeLuwa1rMjaWyMA4dbCETTn+cleupsJhYg9e3uWnT6Ixu6cvaKUxXgbadHaBMqjKo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gGB1gpquo1Xy5kkOaa4GB9tUvHJFApudNJmPMbxIQJ9ZzorwF
	YIeOJ0XDA+ijQIAkIQzoNBlfJByp1zeci1+XdpL1F6GUYB+QptXTs7f+YlCZXxyAkLY=
X-Gm-Gg: AYBFou24HaM2eUVY1syvrXxIR8A5HlHZUEoWhUpzSX3kne9gHmdOgiR3YsZH69/CoXi
	FhLw9HvMgn91KZXKYkIrmVVFliJfoQbuTwiqXg30xr83meZqfulfN6tn/U5SPJ5/QewUK60TNF5
	L/oaPcbrIgeLqV2/0n2Suf0G5EtXuBDJhVnU1ZEsPEscVxdjRodkn7llnzMu8PcML9D8vTOe7BG
	vSwfFbqcGj306NE1shVJRcmRSTqqtMz4Rm4Og5oVg5jPLn3kjRqBEdvIwzOnY6Ai2qFqYtOzfKZ
	2glw9eLzMzYfM/u0bzRGbxWaKcb9m7p8jdd88jMRqb4HsxLFUMDrWDO48O6ARxz0Az6yMxBAD6/
	sH0xdG58MEa/gGDMSvzpPoCobn3s+HNPjM67v6rM+6y71Ou2Uvg2tmISsMcLA17UKUmDpv6Q1Ad
	FsUBG1zpUqDR6OVWzUlSBY5l3fSdg6TGzrCu/kN38P9VA2nwhD2IyFV8QvhWR6Uwu5s9pOKtsA2
	ghHT3Aez+Jzs0SCzDeFWPVbMNI+X2FoIeIvi+J9uQzY8dtaHz3yX3ukddqiQV9vrruhebg6q9E5
	Faf+SKs0SUd69YvldWEEn1qObTSW89M/I9TEnSeFh69eyDnQYFdgzYRIbcbSKo7bDET2
X-Received: by 2002:a17:906:f59a:b0:c3f:7e8:235d with SMTP id a640c23a62f3a-c4ca792f92dmr1718115666b.5.1793889239960;
        Thu, 05 Nov 2026 06:33:59 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e466be0sm178671066b.54.2026.11.05.06.33.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 06:33:59 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	lorenzo@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	kernel-team@cloudflare.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	jiayuan.chen@linux.dev,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next 0/3] veth: link RX queues to their NAPI instances
Date: Thu,  5 Nov 2026 14:33:53 +0000
Message-ID: <20261105143356.17062-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
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

veth does not link its RX queues to their NAPI instances. queue-get
therefore reports no napi-id for them. napi-get lists the NAPI instances
of a veth, and their thread PIDs when NAPI is threaded. It does not show
which RX queue each instance polls. Userspace cannot tell which NAPI
thread to pin for a given queue, or which NAPI to change with napi-set.

There is also no way to busy poll an AF_XDP socket bound to a veth
queue. xsk_bind() takes the socket's NAPI ID from the RX queue, and a
veth RX queue has none.

Patch 1 is a cleanup to ease review of patch 2. veth_enable_xdp_range()
adds the NAPI instances only to pass their napi_id to
xdp_rxq_info_reg(), which no longer uses it. Patch 1 moves
netif_napi_add() into the loop that enables the NAPI instances. It also
removes the arguments and wrappers that came with adding the NAPI
instances in two places.

Patch 2 calls netif_queue_set_napi() in veth_napi_enable_range(), after
napi_enable(). In veth_napi_del_range(), it clears the link with NULL
before napi_disable().

Patch 3 adds RX queue NAPI link checks to veth.sh. The napi-id of every
RX queue must match a NAPI instance of the device. The queues must be
linked only while NAPI is enabled. The checks run with GRO on and with
XDP attached, and across RX channel changes and link down/up.

---
While working on patch 1, I noticed a pre-existing race in
veth_disable_xdp(). Jakub already pointed it out in [1] and suggested
fixing it as part of Jiayuan's series. This series only drops an
argument on that path. It does not depend on that fix. If the fix does
not end up there, I can send a separate patch for it.

[1] https://lore.kernel.org/all/20260917185814.0f944e78@kernel.org/

Tianyi Gao (3):
  veth: refactor NAPI enable paths
  veth: link RX queues to their NAPI instances
  selftests: net: veth: test RX queue NAPI links

 drivers/net/veth.c                  | 83 ++++++++---------------------
 tools/testing/selftests/net/veth.sh | 79 ++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 63 deletions(-)


base-commit: 0822d2fe38262e8b55c5ea55c970022bca8dd2a9
-- 
2.56.0

