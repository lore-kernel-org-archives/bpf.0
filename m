Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793601756;
	b=G28LigjzeQReuaJYd7eQF+yTIM9bW9YfrGtct6CpxMYs3IOGGKGbCChzW59OMsAS9iYV
	 UI9ebCaQ1AEwOaGOxJ+DavDPZEhq4mkqHE+tLA1+UZ4phMqFuJFYRYeMfQBBmDYq5od5y
	 IvrLO22OSoN219VPzYpDO2cTMZ77916pOQCJJhBVWP42VG+oufor4PFyYgK1cKlrowzwv
	 jBZVZ2vzq1VK4TZ9nVyPrPbrglXoagYWlAHuLPDL4yOX7TDvlQlChUMIvIDvLO2vBUEKE
	 Ht8zKmFS5Ma9dzqiJiBZjXQAj8TWHFIh6Gr4nQuCs/nJZydN8sf8GKqnriKA+j1UJcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=j0E5bokDcEb20wou0lBiRARe/SMgpET1z0a+ZadIFQ8=;
	b=XO/NoSiuthT6r2D3mgdvGWU6JJX4C9jrJ9UKBcYY4V9+AToaAWz6/hr+427VIEvK9ZIb
	 fhCiwBX/VxQOQ2ejsbzhzUWhABBdGi0BWvJ3sFv8NS/rZI8VaiyLILPJBezHMJG0JcE2E
	 xNg/ALZNUjQfNfmKRV8UztHLXjjZqdFpZfVtzs20aHuuYUhmB/mZ9xS8ae58/dMBaq5vY
	 mK9nWfuzXgIRB2D5axUNW3uJ5h71ZfUyV1NpNXnRlnOtn5Fz+jIIVN3Tfb0yjpi5pzuAW
	 6belwjDNffT2FDkRsjTAKIx9CjDD8TVXC9023A29si6YEKK0UadHR2wo3dquWP8Uo0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="BuDf6p/4";
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5417D606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 06:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5417D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BuDf6p/4
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso1608234a12.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 22:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793601755; x=1794206555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j0E5bokDcEb20wou0lBiRARe/SMgpET1z0a+ZadIFQ8=;
        b=BuDf6p/446BRAxqviX6ZnLJ/ODn4xcsuvokNERczemFiJTqfNBTntSqls9b7Xa2UYd
         FR53G+jI8yZjzhTazZxkhdSzQ8zP0fqdTfB/Hni883uIyv5q1dofzdOHyPYzNRn+bzwy
         rViFvenVf1kO8EwCj/p0BS4NA+ro44Ir4D09CQ+ARDk8Mm6iCzudXgxo72rxqJyQHhBu
         muLKBFS79ucVKaPQCiDCLNMQhgNjtisw7cCpbM1uhZgV0wCK1gHy6BnVIw9oWqFwuAYV
         cfFimvtL6+x48AkgiEMY8imzoXVl85PbzJN3PX8F2sQpCLed7J2YR5/6eyYSJU1R0oVj
         bTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793601755; x=1794206555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j0E5bokDcEb20wou0lBiRARe/SMgpET1z0a+ZadIFQ8=;
        b=u/puhymiTdVbWHl4Y2w23rynCKbvDDMtIURWDm8VRX+YgMEuyBuIB1mfpgtSaXa49p
         pDK0iTmQgA6hUpR6oTXu5kfBqvEzdYLYkcQvvYIIAm7K3/ebM3qMeqqA9MQ5NcPkMf/G
         kcmBgLpm8iRewjg0RCXXmtk7RFyAK7JBNDF8uKZD5G3WMRlzj0yI3N36wdKQ+MBJW/tE
         lvpIypxTxXtcGhdb4t8idK6/+mPjmySvNYDACXv7StlqMhpRrtWUhA8Rp+kBA7wfFbFC
         m/F5qMtVlMSgy8FJ5dR/c5Lru/veenfZ3Ylw5g/WGyCY/lSqlNTTCGa3Cz4LTNXDp4lw
         sLfg==
X-Gm-Message-State: APuU4Z+5/rcznRptECLZAHe43s2QIs7on6p30zhfpPb5IxWVpQRAGdpT
	+es6+hEglU02FjIn62oY0gdKP1PUdQd82iUqfXXiOEwYBuZcYBE8SOWc8ee0HA==
X-Gm-Gg: AYBFou2ickYIdf41zVawWwwCjIpoud4HuZGtKM4/aIHti7jJ7SfX1ZPzFCv6dCCa8QP
	Ingj1nfPK5sIXYEM4mT/ALacF9BZGYWsKb1dErmT8uDPkX7tTjQJbYqYdlLdqfZ2oQJcYxzTtug
	/SzNIiDmfV/tdk0fqYiMelhh5NOexzVpYKEFMPsHSb4lxXCfR+Ug0VIQBcLo1yvU6EfH7Lr1RWZ
	vmtV0dVMjaAaLhukYrm3A2YUXfIH7Rki2eqNilV8ERz0J8x7lrc8jw8NWXv1kbDNhhGMBXXPD7O
	ylHQwxVKxh+lJOmaZTmWs256Z03KCdt5E+zkgnx54X/wEa7gAPGfzE2o6zRyg+CJDNFAd5YxArl
	8Zu2AZiG7U/jbGiXfmCrChMOxVRj+jG+Amc2LdXL1WIkLCAvK2e5I7ZH19K3ds0qUDP3vIDQcHL
	Kunsz55K6NcuH9FNieEp9gd24Eo5FUAGlwevGK5BCkhe9mmzjxQfcMce6O4wo2wpUCgw+TXonAL
	dHnOGNHGHPpJjpRodfy2FEDWHJDCbDWkIOErMCplHlJIVXy8Y5B8Tj8t2xg5fnR6ltF3DY+8GXF
	u94puD9tw4iUzONWGD/wbWEMlMa82wYaqOOhJxRuiJTnzQezC7duP84LYK/exCQAAYVo3GuOI/6
	4kJKMqLRnOb+WumtGbO6AA3KsLa1bzW0c8Ons/Y/GzNQ2nmh0LNYw/atZ8IJjFIOUok5sHBFIOc
	YCTnxycsCf5QQjRASja/k=
X-Received: by 2002:a17:90b:5686:b0:3ac:9c37:9430 with SMTP id 98e67ed59e1d1-3ae89724b1dmr7755803a91.21.1793601755442;
        Sun, 01 Nov 2026 22:42:35 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f37e7esm7549215a91.1.2026.11.01.22.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:42:34 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 0/2] bpf: Follow-ups for the arena mmap() fixes
Date: Mon,  2 Nov 2026 06:42:29 +0000
Message-ID: <20261102064231.2153879-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Alexei Starovoitov <ast@kernel.org>

Two follow-ups for the arena patches of the series
"bpf: Fixes for the verifier, arena, skb and lwt helpers", merge
commit 714b7112017f. They answer review comments on that series.

Commit ca580b034380 ("bpf: Refuse to map an arena at address 0") tests for
address 0 in front of round_up(), and round_up() can wrap to 0. Patch 1
does not move a MAP_FIXED address at all. Patch 2 makes arena_mmap serial,
as the other arena tests are, and adds subtests for patch 1.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (2):
  bpf: Don't move a MAP_FIXED address in arena_get_unmapped_area()
  selftests/bpf: Run arena_mmap serially and test MAP_FIXED addresses

 kernel/bpf/arena.c                            | 13 +++++--
 .../selftests/bpf/prog_tests/arena_mmap.c     | 36 +++++++++++++------
 2 files changed, 37 insertions(+), 12 deletions(-)


base-commit: 714b7112017fc7f8b2afabccf562acdb12d2ea7d
-- 
2.55.0

