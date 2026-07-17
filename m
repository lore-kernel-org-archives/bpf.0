Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D63175A83
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303635; cv=none; b=l7gXR4BqsSf/xao5eX4+Ce4jwuIV6CEJzeh38lvkYuNH9CB+PR+uRv87x/M6CIGJwIZM4s2zCvMsZFFvklZdv47fLRDQLt14haXuayXXntJ5ZdVECAyaG/KMI+veJlCA1GREE3cQ078OX4w3Bj3VhT/dmIAtURF5jakKLwjQ1aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303635; c=relaxed/simple;
	bh=YF9Knm40lON0FlUgiurO8Nd3SbRk4kttQ+DtP+b13jY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EI6PnRgq6aC7KLb6bKEPCTQBTB7mQtQyqZM+aoN7v6zrneTmrSCmaS3Y2VT4PX9A6BQI0fF1rgeyoBrcUW6GSI/Er7PLdJkOtenjFq8xrUMlcDlNwcFWJxtVyG1RmNLTTWGzpZ9PiYmdeV1NMXB09cXElzX1eOmyA0uIJSxLgfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixVOyCd+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixVOyCd+"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso4411600f8f.1
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784303632; x=1784908432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KgKTphT/EPBidWmUJpQky4fuu3ayeXNP41GXKcwaXpY=;
        b=ixVOyCd+G5zisdrc5ETx7nVumKoUjZCxACN6n/wSNEB1YtfxqWczAEduIV05Wjd/DK
         CM+FYVBml/Rep19+YnwjcZTtghC7xlCrFeI4tQe8h/NnYIPkV9CLyRP5JtslX7g0rv96
         rxTY94Z88ZujwGaGJVcJvX99ce1kxwbQDDjOZGB470J+Ev7ayjM4eqXukkbepavFEszc
         pHDhcMQgIDIHrDT9c7QyyL81iDXuMqp/ZokvlNRXxZ7qYCYodqt54cc8doh23bXcfccx
         XlGJKa5Za3WV4i9VZJIPlDYJi+IgbSZdnEEwGK0g4CEA8jvADJVnliwisUfBGvu6SBuz
         Wp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303632; x=1784908432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KgKTphT/EPBidWmUJpQky4fuu3ayeXNP41GXKcwaXpY=;
        b=NYkqYRLnUBf2FjBjeQPomzby0b6vP48cG9SaT6jsgRw57CjLxCjosS4qSOp+FW2tz7
         07HGx2tz9EqtsOKBc2jdxxxxVA3/F2r+k1aQeoKQgnAp78f4YA5bT68lvU+KIE5zQzav
         v4xg/+e+i9jUHBhs8g09Ycpo90N+IH7fThOIhrbmbF2kyIBbnbdoyt7d4Su+vXh0Ssfw
         WnyBsUpnMiWIj9Hvt7CfVuXXNPs6KqP5yUAC8TaWxOPj+ro4Cw9lgkJANDZOEdoCqEh1
         VIrapwFKLYt//KCGOCCTBruhWXTmCPZTXP7WxeENovUhzttJvG5mABsjG4rtLdkG5x+V
         UtFQ==
X-Gm-Message-State: AOJu0Yw3FOWmU/D0/6wh/hpu6K9BEjOzxHOhkXRItThLq+n5ZzbpAL68
	kSPjjNNBW9/IEqNWVl8n8ac5jfUigDoCJ2TRIEZcf//2aXvPEIa3v0Fn
X-Gm-Gg: AfdE7cn3yD5l9xMat7hDZjRaDzuVeBPo0kYXgEid6Vf6eCe6feil2bSLyl7a+DNOliJ
	eH/WO6zhgT8jLLtEaBKaN3ZjChUzbUITj2DjarJ7eNFjWuvBVvt3pJk+LlPkUWIkNGAKLvcBnW+
	3zCLbakpGDZaBPCvGA9Izy2xSn0i9asiUzUgmK2alttju7Nz+Sz97f9UKws354Qnckkn08OIHGi
	WxLMVB4jJZdD1CHBwhS2B+UMx92SDAQ/Kla3UD7kqDLetpj96zawXhEFmy2AyJXmW+B95j8CJaj
	Y+ERxzikWYqQoKr5W5geng0i9rJ4xFdT2HQ9+PORJS9DWjACdT64ljD6UoER9ikbYhhxAVou61+
	r9HV6MZdI7jIGz5oNJjL9vPDbJ6EgIM1Pe5aqIwEUBLuFTps7UeCpygEqnf+75yr+3ZDcdx78ik
	CkcXsvv95buc+MmJONMr9qILeE0HNJg/+XmctqumzTbMTFGUHIwM4xo/l1dhFFaR0TmA==
X-Received: by 2002:a05:6000:2213:b0:47f:59b4:3933 with SMTP id ffacd0b85a97d-47f62330c15mr4105029f8f.42.1784303631863;
        Fri, 17 Jul 2026 08:53:51 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63edcf8dsm5321369f8f.27.2026.07.17.08.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:53:51 -0700 (PDT)
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: nnamdio@gmail.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	kuniyu@google.com,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sashiko-reviews@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
Date: Fri, 17 Jul 2026 16:53:46 +0100
Message-ID: <20260717155348.54975-1-nnamdio@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Spurious wakeups in tcp_msg_wait_data() isn't being handled by
tcp_bpf_recvmsg() and tcp_bpf_recvmsg_parser(), leading to unexpected
EAGAIN errors returned by recvfrom()/recv().  Adding handling for the
wakeup and a selftest.

This issue was first discovered in an application that adds sockets to
a sockmap as a way to view the received data.  No redirects or any
other operations are performed.

Sashiko has noted a few other pre-existing issues in the same area
(https://patch.msgid.link/20260714205118.17DB11F000E9@smtp.kernel.org)
that can lead to EAGAIN in tcp_bpf_recvmsg() and
tcp_bpf_recvmsg_parser().  A local run of Sashiko also identified a
potential issue in tcp_bpf_recvmsg() handling zero-data FIN packets when
the MSG_PEEK flag is set.  To prevent this patchset from growing too
large, I intend to submit follow up patches to address these once this
one has been accepted.

Changes in v5:
- Move selftest from net into bpf/prog_tests/sockmap_basic.c
- Link to v4: https://patch.msgid.link/20260715213538.37229-1-nnamdio@gmail.com

Changes in v4:
- Fix potential data loss in tcp_bpf_recvmsg() when a FIN or RST has
  been received.
- Check the return code of pthread_create() in the selftest.
- Fix race caused by using EXPECT macros in a thread in selftest.
- Link to v3: https://patch.msgid.link/20260714203927.32289-1-nnamdio@gmail.com

Changes in v3:
- Added the sockmap_recvfrom selftest.
- Link to v2: https://patch.msgid.link/alFRK66z45eDNZA7@localhost.localdomain

Changes in v2:
- In tcp_bpf_recvmsg, handle signals and the socket closing in the loop.
- Fix spurious wakeups when SO_RCVTIMEO has been set on the socket.
- Link to v1: https://patch.msgid.link/ak_rR-Skd8Mvn4mH@localhost.localdomain

Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
---
Nnamdi Onyeyiri (2):
  bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
  selftest/bpf: added selftest sockmap_basic/sockmap recvfrom eagain

 net/ipv4/tcp_bpf.c                            |  69 +++++++++--
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 115 ++++++++++++++++++
 2 files changed, 175 insertions(+), 9 deletions(-)

-- 
2.52.0

