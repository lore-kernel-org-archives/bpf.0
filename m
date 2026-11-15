Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794771337;
	b=axGwBjkxtuALJblYD9/cb+EyhQLQk2wdW9oxvCsEtWWhP4eooQEZnjDQ6axphy8aQMLe
	 0Rq1ONuerHc4Z2n5L2fixYyOKmLMPu3ACstHutPsxQZdLuXqcdIUduEKfQdWor58iYBFO
	 FPP911A8R7+UWJsPuXOb+izvFmKKIsySQ4MzN/wQ7sQeMIhwviDedCLtkqNqewZCmyYlT
	 OXusa2TO6oZJ/uNvC3SA/EfvVAkiuDy5Waget6Ajj87rg0Yz52egBXHyz4sfBBN4YGqZW
	 BPZM1Bpb6SY3BD7egz6uUXV7ghKTGVSVpZ4ZsWGdnqSH8QIEoJ7IOuAcgnFE42Jh/Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794771337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q+RkJ8dbLq2dXw8z3vZfj7Fvc0FFnDlwRUu3YwZ5OCw=;
	b=xnogwXvRQvpZnka0WhT4EDnvUVvwqUfQmKjK1GwkNQIyaFOPToNoY7JOkIHODAN318TA
	 jSoQOs/4tr0dksRHv1ludllC5OE87MKbq0RO3w0Yqptws3WTDBqMXWsgTiKYfW0TPtatZ
	 FOmAkDYf16jEc1SNEXQYRqbeOJEcwTaqzjdiZBBm6sfFfnaqEcm7+y2pQoAC5B3tS4e1B
	 94XgiS/3do6aiwjxoe77DBBV+7HGIOwqDQ7/U6CweF0hvjuIA7PPNDsNaPHtNK5bKmd4+
	 pLBll9iJQCSqT0Vz7KeEykfHJqQmX19bvUQeno4fscAnyxFBOQLKd+8QhthjzXkytpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=NcurtOBX;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8693A606A338
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 19:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8693A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=NcurtOBX
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c468bd799ecso404065766b.1
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 11:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794771335; x=1795376135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q+RkJ8dbLq2dXw8z3vZfj7Fvc0FFnDlwRUu3YwZ5OCw=;
        b=NcurtOBXdvjkgdGWXyF+08ppm8Qh0ji1b0IHXl7heKBKk42dlpytkfIlFJiWYj0OMq
         QHktELH/bjYGTL/seO4vNrakDzhWg/M9DL+eXFPIoBwE8VTp0eX78vY8ZHX2jGhAhFcV
         rT/UasnMU+eJL/z88AIIT+u351guTcDKW6iYUKCQygECEQBJ2UeX1rqM4a2l46ynDLlb
         Muupct4LPxfiMqHiMHIymYxDYJ7cVsV2F97hQh8fCE+KmLILoniBmA9WiIalZApDP1cY
         IcON9rXvk/2LnS52t7wgGlFqKRJ0xHG1t7dwJXlhU5b1/3kTsVNrNObwdyQTqCiDgaAe
         /dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794771335; x=1795376135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+RkJ8dbLq2dXw8z3vZfj7Fvc0FFnDlwRUu3YwZ5OCw=;
        b=sEBWDMEpCRpg+PDYqOhJww174d9+oRt7Df+U+fxEyZ/87YEby9u+F5i1mciRIhye1X
         M5qk2ue8nD36IBxlGzne2XrUqIhRuGtnGBguXSoKMiUbgBllDLSejDL11q5wLX1wcOcD
         TrlpwFrC4Mcy7TR4pXdKL9twrkIr1mwu6aTp3j9K6TyTHsMsyf2LeZnCM2YWysUD/feg
         uHGEC19aPdQkO5cM7yKm8OTcsa813VGeH3UJdQqftQtXV9TY/NtExC/Wvw5cfEFBOxge
         o5kn1oks/N1wH59maVzJf5k/XSG2u9UDHM01Q/iWwx/RjPSdWx5OgILnlg2jTktcZ6qm
         qAXg==
X-Forwarded-Encrypted: i=1; AL+hErHO0A+CvvMt/O3pR1ptinLiL9P8/8+9qkSH4LcarSkD5OJF7iPFZ72M21ItBFZoCLkNNyI=@vger.kernel.org
X-Gm-Message-State: APuU4Z91W+YchajfN/ImogyPe4bXkYGjcCknRndIYV2uNU+VUqr4IMVr
	kDgVKk0KcxO2kjUVmJ8xLKUVPXYMSPmil3QZ385EL68btgnsq1qfhErQG51EPJt33hU=
X-Gm-Gg: AYBFou3mBVzw+rWY8J6wNDMRLOIhCGWbpz7gG7icKb7ZInQmmxdptLp9+fM2pDwbemG
	wCO5GoZVcY51GXzfHg7+a2JaG+yDxUaE7iWT20rff1kgBKOTo/QrtAc2nPNucSHzfX6HCj0+aKp
	ISf9Y01Ib1oERd1ZAkKLfP2rhkBd6yF5WNg89f4/ZHVoaZzNMsVgVQPGzytsqHErCuZ2QC9BQFL
	K4QukfC4fwbRkxjgfH+fNEevEpm2HHnLtElpmwSPgjSAP5rBH2V8e2CD7M1h0EwvF+gvq6F9kNR
	bgyo6rNF+F4CqjWzSOkTMgbg53NKtU4sAdwU3a/9WwGhvL17zUTSz7DpuCp2R4237sM1+XZNo/B
	0VV7DctD/gxYj7XV/Md1BZs6MvhX1MNTGVUV108xFYMgU4pZtb2gLG/ANgshcNGdT1GwHV5Ic7V
	HVqbwYE50Ald4aQTVQ6/mnoWazkCfQAd4HYRS8x3A8DDCagKhU7m9gj7BvxXvYq6YCtj1c4bFlY
	fKbyb24u8R4UZKMMdIdfoU+mBQHw67Gl6z6QXbO14p+VqiOUZ4zXR0KcA2N5p7burb3grsbxv+j
	8de3MZcsmRsSGh/T3ZlOoUWGZov3gMO7IMnoWhjRpKCnajM29XcXI6wU9A==
X-Received: by 2002:a17:907:6d02:b0:c4d:4d5b:4bd6 with SMTP id a640c23a62f3a-c509654df6emr656672966b.41.1794771334930;
        Sun, 15 Nov 2026 11:35:34 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b24b88sm340448766b.16.2026.11.15.11.35.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 11:35:34 -0800 (PST)
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
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	joe@dama.to,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v3 0/5] veth: link RX queues to their NAPI instances
Date: Sun, 15 Nov 2026 19:35:26 +0000
Message-ID: <20261115193531.57679-1-tianyi@cloudflare.com>
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

veth does not link its RX queues to their NAPI instances, so queue-get
reports no napi-id for them. napi-get lists each NAPI instance, and its
thread PID when NAPI is threaded, but not the RX queue it polls.
Userspace cannot tell which NAPI thread to pin for a given queue, or
which NAPI to change with napi-set.

There is also no way to busy poll an AF_XDP socket bound to a veth
queue. xsk_bind() takes the socket's NAPI ID from the RX queue, and a
veth RX queue has none.

Patch 1 is a cleanup to ease review of patch 2. veth_enable_xdp_range()
adds the NAPI instances only to pass their napi_id to
xdp_rxq_info_reg(), which no longer uses it. Patch 1 moves
netif_napi_add() into veth_napi_enable_range(), before the loop that
enables the NAPI instances. It also drops the napi_already_on and
delete_napi arguments and two wrappers.

Patch 2 calls netif_queue_set_napi() in veth_napi_enable_range(), after
napi_enable(). In veth_napi_del_range(), it clears the link with NULL
before napi_disable().

Patch 3 adds RX queue NAPI link checks to veth.sh. The napi-ids of the
RX queues must be the IDs of the NAPI instances of the device. The
queues must be linked only while NAPI is enabled. The checks run with
GRO on and with XDP attached, and across RX channel changes and link
down/up.

Patch 4 uses netif_napi_add_config(). veth deletes the NAPI instance of
an RX queue when it no longer needs it. With a persistent NAPI config,
the queue keeps its NAPI ID and settings when veth adds the instance
again.

Patch 5 adds checks to veth.sh that each RX queue keeps its NAPI ID.

---
Changes in v3:
- Patch 1: add all NAPI instances before enabling any, as before the
  series (Sashiko [1]).
- Patch 3: reword the commit message. No code change.
- New patch 4: use netif_napi_add_config() (Sashiko [2]).
- New patch 5: check that each RX queue keeps its NAPI ID.
- v2: https://lore.kernel.org/all/20261111015922.67745-1-tianyi@cloudflare.com/

[1] https://lore.kernel.org/all/179470883254.2199510.15270739408094114749@kernel.org/
[2] https://lore.kernel.org/all/179470883411.2199510.13825316417997386083@kernel.org/

Changes in v2:
- Rebase on net-next. Patch 3 no longer applied after commit
  c1f04ea0aa0f ("selftests: net: check veth carrier after changing
  channel counts"). The conflict is in context only. No code change.
- v1: https://lore.kernel.org/all/20261105143356.17062-1-tianyi@cloudflare.com/

Tianyi Gao (5):
  veth: refactor NAPI enable paths
  veth: link RX queues to their NAPI instances
  selftests: net: veth: test RX queue NAPI links
  veth: use persistent NAPI config
  selftests: net: veth: test that RX queues keep their NAPI IDs

 drivers/net/veth.c                  |  85 ++++++----------------
 tools/testing/selftests/net/veth.sh | 108 +++++++++++++++++++++++++++-
 2 files changed, 130 insertions(+), 63 deletions(-)


base-commit: 6964ff21c5d8b75649211a52dbfd92753e605649
-- 
2.56.0

