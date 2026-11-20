Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187187;
	b=b3slw/DpyVh4z8U133xkyLPsJXzD26FNxG9Zw+gffYQbhhzJmprUZ8dGvsCxm/fvbNs3
	 4cuQE8j3hB1GS8nO49/z63RYefXP2SRi/5XMx6uUFtzo0bG/aKqCugjUgF9eeUjoPjZ5I
	 YWPEAK/xTbm0mZ89dY6JeP0jAJJ+KvG/lJ7fyJzBT2zx0yXymEk2G186L0ndG/3jXUyAu
	 C27y7CFIhpn5tHPOE1F4mE1g/8GZs3yPjhSZW05Kyz+PosddcWehWnG9t9f4MrgPtAuwr
	 7x6bGeNpwYI3ACl+kKqapnZkIHt5ePtZ7/YzMm/DLdSRvynG5zoIGv8GR6VQSFPpZAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9Q+A2Pm/lTzn6/74RcxfPC60rEW9xoC4OYcN2wFWBNQ=;
	b=o9YMiCG0H64NmQ7Jk7CF2pAJTBpQs3t/HPKXyzyBQrSthDO662/EPJo9FO4F49mXvC9C
	 M2iWPOSiq+dNTLXfH3cqiCfuE5maCX4Ep28J76FZeEqtv/Kdn7RRf5abUW278qeOAGg8T
	 nHSXlJeb/OzHARVSkZje73hkunm/Il0mZtvknidWQD80P8giH2xYjM3J+WIW3l4QeBUhN
	 xoR6g+M+3lo0e0X3OZGAs9OaE03rYITelGVFzL+v2A8qch0jr282HS27y9fWmF61QU9hS
	 HC1NH3fN/ba9nRtzTOLo9j/Ln7148oIYEYUH5tuIzCZMwKn7yoN2ns3wbzQ2CNXd7BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z7sxnoxR;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD536606A326
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 15:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD536606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z7sxnoxR
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b244fb7fffso1019624c88.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795187186; x=1795791986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Q+A2Pm/lTzn6/74RcxfPC60rEW9xoC4OYcN2wFWBNQ=;
        b=Z7sxnoxRdpdLlw+cEkND+OCe/Bd0Wms92uOSv/+RsFB/+Phud1KUC3aAO8qMx73kxi
         CkA7mb1hE19lBKtTEIX+s1YI8Of2WleXOj1JMTo/hZ82+4ApM6qAtW6o0J6dpbPbLbif
         xnBtOFsji6djS1KED6yKVUkkalD+XQZVXne0CYk0CvFBXky1oFPOQAG4QMgNpUpRZ5xk
         +9R+pAg/lwDH9LCfqpKXABMpL8hj9u4GyvQ08z5z0uVtL3BMwd5dfVWU7SxD1cnajJVn
         P2AVPTthpU8IG9vXNEE9er4zvnrhQq6koUa4/Skn4RZJm6Oq5RKm/ADZUyCx4MqoOMBh
         i5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795187186; x=1795791986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Q+A2Pm/lTzn6/74RcxfPC60rEW9xoC4OYcN2wFWBNQ=;
        b=E9HyLFtCb5KfSLH9aTM0DKtjqDq3QAM/StHyDmS+/28ba4X+zb0DxQkfDbEomA7BX7
         FnGcfJmucTbTlR0Eqp90dIvbNBX+JwLNIuX/g53HV7AocaQtWn/eKmrXZk5ZDnvJwHG8
         SYIMN2XoXwfwK09Iiv7ZUkk9mNNIQEfWZVRp1E6DhVqbVyot0SN/bYq62jcOY2UqUrib
         gVCls7lpepuJx7Fxl572saauZmEAA8bv8iBJjSVw54d8dKtvSpLpBAmmj6yp1xgI8xBB
         wRgj6pOOEEhB9WtIlEFnb3L4EjbybPm15SCBPil75ylOg15TIWWNZclHO6nglso2rUyc
         6WDw==
X-Forwarded-Encrypted: i=1; AL+hErFUROFUxwDPfteLRo2HbelOQPjXGVUIl0K9TW/XQQYYxWxMnatGDTfhk7xIp43LN6zqits=@vger.kernel.org
X-Gm-Message-State: APuU4Z8QCZgbdcCPttTt0nyNDAnwUKzNSSs698x0MkqBdhU+6x6vHjWH
	OAuUUsCqn3XFwvw379t5mPvIO6cVnnwep2Nd/K8QJI7iJWzfL5NHx0Ae
X-Gm-Gg: AYBFou3nqOx4nIATKUabYavf5qKXTQbRJkUQAo6LsSexJ8o1jLxxHYwj8LpI3moDGWA
	mbiL/WKm/QWB6mb9KWvo5Jn6Zu7o7mQyJXMViJQOpK3XFGlNAcqIhYCeUrYz4JJ7SK2XF70FRRA
	+bSNebN0a6vXXepPwpGkY/NtTKJdv7PZkrZn2cNkpoJnCJkefLTutgBAGa/2RNSN6qIKGTHFGQm
	6DaFPcbfwQUuJUoEWq8tp74XQ3F73kWCEtndrxewXlWa8v74sMk/StZNjDsAjo979pqWZMcygyn
	I5CX+PePXsPLWDmR1bZgXdWA88aHlZTGMVETQ8AzFxsadx4mw642g0DYo95k1dOnOe5+6GEshW+
	g+XADQNu2BPos55JhQdxygZdPvPUccuBgb1aU8Fgd9wuIfTVj0wCvCXuGAnPCyKwhDya5ynhxL3
	xUWw5NSzhHKvuK7xiKsOxrMKVGRsnfPcFrrBnP1Rb6+7zRyS4w4uF84oSgKLxH4S2GbQ8okH98X
	s/BUpo2fc02qU+S+yGeLDaOTH2sVLazUymul/o6zBYFDwlO12a3H53rgCBOU60lwNkjUKbh/s28
	Ku4limy6/gNXu9Zj/MbxBcXJwE+SRcXbab9m7J4jMVheFK6HP63ciYctzb/UPE0=
X-Received: by 2002:a05:7022:3f0d:b0:16c:3408:760b with SMTP id a92af1059eb24-1b5568dabf1mr3023904c88.32.1795187185858;
        Fri, 20 Nov 2026 07:06:25 -0800 (PST)
Received: from IN01-9QQVVV3.CAMNWK.COM ([171.76.82.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556840494sm7844902c88.12.2026.11.20.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:06:25 -0800 (PST)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Subject: [PATCH iwl-next 0/2] i40e, ice: one RCU grace period per XDP ring teardown
Date: Fri, 20 Nov 2026 15:05:25 +0000
Message-ID: <20261120150527.14649-1-shital.gandhi45@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Both i40e and ice wait for an RCU grace period once per XDP Tx ring
when tearing the rings down, so the time spent scales with the number
of queues (i40e) or CPUs (ice). The wait only has to cover in-progress
ndo_xdp_xmit and ndo_xsk_wakeup calls, and one grace period taken
before the loop does that for all rings.

Compile-tested with W=1 (allmodconfig, x86_64); not run on hardware.

Shitalkumar Gandhi (2):
  i40e: wait for one RCU grace period in i40e_down(), not one per queue
  ice: wait for one RCU grace period when destroying XDP rings

 drivers/net/ethernet/intel/i40e/i40e_main.c | 15 +++++++++------
 drivers/net/ethernet/intel/ice/ice_main.c   | 10 +++++++---
 2 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.53.0

