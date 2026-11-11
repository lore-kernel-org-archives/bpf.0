Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362369;
	b=HF51/A01s74Gb3qbAyXnmVveIA+P3PpuBoS3X4YhibWRcS/CndB6FPt1MU/DtCxGSLZD
	 L5F0onC00TIX6Hr2eaTdGlsygG9QuY2Ri6XwWV64PTyIl2qu8TpN4mTeMy8izoxy7+4RZ
	 IaayZTkaChmmco3SOmn7xX83SwcPLA5vzFMdIGzEUnjIL5jHrN6m7iTHdN133Bf3BCPwK
	 20ku32yYlGG9R0chc2H5KzHotUSu95EiL4/mRQuy3xWJzrq3SZtsYzeRquNmfcHBxWom1
	 ptZ6EqPS9U9HsgptPZAHdLtOj9dExv2o/+Jcn3C3olVFCMPNINLwQIqG8uKWxpBEkvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2ke5kyJBmq0AFCcx3Fu7oLeZm6H/B0W+HhAkyx1DQsI=;
	b=KY7Nkhz93Ra58RL6uMhPgKYZYyEyOKARHar7pLha2rt/SVm2zbQIA/jTki8OJNaVMkCq
	 6eOzSQ7iv4pSuUcqj9SBU4gxHNuIBsJbgUJ8x8YdqqHF/Jy/R5NfmJVBWWT8r71LYdLZN
	 7VBPgUUHwYHrGifbzMxcyIVg+CvdJAfBuEeOoo0Yn1NEiRa+gp7rqklTPA1O+gaIknRH0
	 0TxpY1Iz9Re6vGyEIRKcOalqNG4M7oF5kD/7nI5pAPRPYS9V+COeTBchJjzwcSDY8F3tM
	 CCpMmfBZGiWyMsxUAr/8QWhsk54nu54MFmCGkRvV8Ks5iXZ4pWonm8y23T9ylGA89nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=S5gUk4di;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E493B606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 01:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E493B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=S5gUk4di
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b56c428212so3612438a12.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 17:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794362367; x=1794967167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ke5kyJBmq0AFCcx3Fu7oLeZm6H/B0W+HhAkyx1DQsI=;
        b=S5gUk4dimJhKaLynL3tjG1twjvBv2NBjeIh62CUJ0NqRTEyi+tsShsPrvV1cWhQd4y
         wgEM5GdyDHpe4DQ3ei6bfZRquKgULlS5MrKWXxNBbD1rPYLIz3DgkDg7hhNwHU0MIs1F
         MWcaD4YdkKLNipDvkPqD9ebyZOWngy1bQTZlttfDsjCB/3oz2bOMvGHrP73S+G9gfCsr
         SJhFCiLdBmgu1RoSbdao+CzdhvrIjIGIb6BMbKTxS7LCFFycAvFSLqTx2rmFSVSlHtU+
         +Pe6DcEHmClnNzPZWVFWkKTjs2PGPK9CGc7loRSucdDS//goGzoobiL5ipSYmBT2MEA8
         CsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362367; x=1794967167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ke5kyJBmq0AFCcx3Fu7oLeZm6H/B0W+HhAkyx1DQsI=;
        b=GngdIb6JybLcM5vNK6zYxH4H3Lmk+zwC2cd6bNRDC/G+f+tGxT/ReSzAYhRQMaBU6g
         MlXyQbB5MhooMxNtUccmUgcwif1JFCqnHPpr9rRVfU/wRchf7oCpB2CGqiqB/mRGs47A
         waB80p4N3FWW75qMUN6a4cCNI1/DBLRvxCAG2jyjOtCjNSjklY8HtpLMDJuuBARvrk1P
         t9Z/5Abgel9xWgrw04kIIXaA4HVqmVsrnvgrTYDqE0P3UY9j/pepGtHexw6av4KWvmiJ
         sQ72EAHx0rGQgV79FUXV+6HljfeaeqxGuyk/FDImnKZxCOFtMEzpuLOXRMvZXxDgUPdL
         cYsw==
X-Forwarded-Encrypted: i=1; AL+hErHzdHDeA6f4rUSONvfOsM3c5/zEOadWGEeZtJ9JAU82TiTUY8+gczU3PyZIem71Q3pG6wg=@vger.kernel.org
X-Gm-Message-State: APuU4Z83FUL0Ur5dvjzxtO/ViKpFOFRcxSiQa0MVKeyeydGlyACbhklK
	99yv0DKNpML+fZtOxCNI2MC8jn4UUv7h+A9DC3YJcymqxtNpfFDMAy4xQBQrc0BIADE=
X-Gm-Gg: AYBFou3GwyfSk2WskBJAdraY9v58XnZ8YqosPusIdjuRJZlT8saQwhfdV9VaxHZQ0Zl
	kUkLaaufOzz3kiLQxdHSmCz75TndTeXw0sqktchW669tCDk5n7+6K5xKkgbzOk+aPfnbCjcj0Yt
	2r6fUnZzHw32NrpTHhBBoSYi61/aI59C57MdxmuT60uyVuzxvT95El2PrErPPebRuYJahgxR/US
	X0vM3ZuH0HZFldF2LC4G8yBhF6CC5s5mp6TNxGUR9SUT1/EMbmm9Q74O9p0tIHwYyoQXe3rTmZT
	OTKFC/TR63KXgAKTC7mXRIjIIDgftlnDj2gHJ8wESgMy8sa3YZPKKRcfyzE/Mp5C1bl2qGMz0mN
	UEQGqkVFEuyfOVhUlCGG3Mn+utKIqjz+muRRo0J0fQi5wDczSQC3I2EtHotbHEeupNMLWs8bA3T
	oSjZCelOl89VimI+CwORrChp8fv8dmLt758LUMloazyFjvFa/BwKGKtbqUW+eWMJt1iDrcdy1zZ
	l3uO47hpS2JsBXK2tnTilb2LVR4LQtWUu9ahvavTNqaIM8P/wZFHb/yyphmvbXxrswjvLt1sQtv
	AGn7LUyM/rcCDiQzhT4CuLHA4NwomXwX4e5lfwxgoQ0+lPjYU3KVHHnPTQ==
X-Received: by 2002:a05:6402:4005:b0:6b7:8444:a456 with SMTP id 4fb4d7f45d1cf-6b78444a614mr130398a12.0.1794362367268;
        Tue, 10 Nov 2026 17:59:27 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.58])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7834cdc23sm147498a12.12.2026.11.10.17.59.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 17:59:25 -0800 (PST)
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
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v2 0/3] veth: link RX queues to their NAPI instances
Date: Wed, 11 Nov 2026 01:59:19 +0000
Message-ID: <20261111015922.67745-1-tianyi@cloudflare.com>
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
Changes in v2:
- Rebase on net-next. Patch 3 no longer applied after commit
  c1f04ea0aa0f ("selftests: net: check veth carrier after changing
  channel counts"). The conflict is in context only. No code change.
- v1: https://lore.kernel.org/all/20261105143356.17062-1-tianyi@cloudflare.com/

Tianyi Gao (3):
  veth: refactor NAPI enable paths
  veth: link RX queues to their NAPI instances
  selftests: net: veth: test RX queue NAPI links

 drivers/net/veth.c                  | 83 ++++++++---------------------
 tools/testing/selftests/net/veth.sh | 79 ++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 63 deletions(-)


base-commit: 79ee9e6768721f337952e9b3edd14cedbbc03030
-- 
2.56.0

