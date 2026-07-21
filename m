Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971E239768C
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784673502; cv=none; b=CETRjuagsGIdZ0SyLhfcCq8e3k1cBlq4OhBG9UHZcEg1nESYhBRetGKZUWVzLjgdqM1YxnNT0ZixlQWGUGp72DMNi0P5c7wqPfZLRl6FQ3T7a6NMKWJueDTlXJRoL3GF4cTNtSSJK01cb3+ZkTVcwdQxWATCfHGvACpOZ81hEO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784673502; c=relaxed/simple;
	bh=JQ6jy/Liue8WW5wFfNIdvfNn2mNrYwM8ygCatIkUUQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LvC4QfVcIPukpzNil632naMcanDzPjanWBcopqqeB8pF/M7w3Z+GDMV/9VeBRHNsk6z35HGrYbD9WBOmLP8uOrCpwWDR/3WIbUk/z7Hb1q7Amy3QC1klaLjnxgr+iMoP8xOE5wOy6UteJOsaE2QJmwjFoLEyf6BmVrPfODpfitQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pl7odF18; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl7odF18"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso42810495e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 15:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784673492; x=1785278292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lLg62SoAvmrp+34mR0N76mbDra0q9WddbEhVc9/YGR8=;
        b=Pl7odF18vn1uogBY53vMccFDk34Kx1jSGqlg1rzIlSmDS1mALlfT74A3OkcX4y+Iyb
         1WawXRZ0Uk3EeFLaoUtP6HrF388PjM6wmzNvUUfQAII3cME/TIgBRZoeTMktWuO7VSWV
         fU9Nn/ApS34Bk7zjiZhED0+j1FIvhqOUY1wDGXjdoEfMahW7pmjv9Av0oct70CqeuEhl
         AcQWbtM73V2FUnitylLS3H8EA+RkVXy4B+gG3K8P4HwAVDG7bW1M6q2ZmruvSg90SSVZ
         eTTUJvoPUMo8qyyx/lLkXL967Zz/h/7EQT9h3oXGd3jUKu8sxKuEOT5/PqZSFcd37Igj
         M3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784673492; x=1785278292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lLg62SoAvmrp+34mR0N76mbDra0q9WddbEhVc9/YGR8=;
        b=SCwvDduImMCmhlTnaYsmG3yzltcmquHB1p9JmBufoC3bkMQLY2bzd1t8+FzjqM4rDI
         4JsEhB2kBgHfoUHxhGfhGie5ZYO7S33byEThJ1sXswJ+VlZ9vcivM6uhueVTN49L93nW
         Wug6w74ayQPYcpIvjhGyenfU6yS6vaNfOTYLdvL76RAeCU5wtclBxNs9Kb//Ubwomi/I
         0W4VBwYk6drHefY3VOD9HTt7MrPcgvlqeBfzZbEqQwIZxFouvHQCu/KmgFBJco+W+COx
         Xx3iSnL3J9f9nk1lmIpSn6Fk2z7ycBmqzhQ4kQsWOS6NulvtlHnzZLj03K2xcNtFRh+1
         5pAA==
X-Gm-Message-State: AOJu0YzBZiFgRhfJg+2OOTBuT9eoYwXGvf2/25SZa7DWkThB7AcA2mM6
	qkNK/Kn9Us6ai1qiKFeRrFg3CyVhfed/OY65SkmCB8y2h3dnONhVh/0Y
X-Gm-Gg: AfdE7ckf46BfmkWuSflhgCZZvjP2/dcr/AgsMVygk5WPIFD0HLSFuaZyyDjMn4jzjY+
	glf72nYkLr1nTnODNaF8ZaOjBLFtEEzpg6HZz7/TO2yU+pDq+xUR6h3Km6g3EtIyXoCOjlAWoT6
	Cpe33WNcDs4+OVlM9+KEKS2hyWI0s0IC6cvFtWzqmDSzY7i/nCsDsL+5ruN7YShB0x4PqhhuHJ7
	yObP+s2nlq7zi2xWxSRVhDS2Y76giYqZtW4AiUWFlRTcxErMvSR8R5ZeVXVleJ2UtDwxPIdj9BH
	BzOYG4yOaMXRTuaXOXpAKK5iZu7V0+aQUAJFOWhrnZ1/tDOp1DQMy5dnVV117iNzNFCt4avmmC8
	h2cXJLCt1/S5sKaUseL0PSBsZO5QjEJYTC138qK/9j4/KodoqmjzwXw9QTvJNuJI1lMoRVXPJbY
	fGlkynkfpiHpoN9MGqxUlZfKzFnoUeD26ZbUaXnBbamdVT1ISHYjZ/TW6HcYzaUNcJvQ==
X-Received: by 2002:a05:600c:3143:b0:492:7142:f46e with SMTP id 5b1f17b1804b1-4954a3d0cd7mr246829545e9.2.1784673491644;
        Tue, 21 Jul 2026 15:38:11 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653c9d99sm101290455e9.12.2026.07.21.15.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 15:38:10 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	emil@etsalapatis.com
Subject: [PATCH v7 0/2] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
Date: Tue, 21 Jul 2026 23:38:05 +0100
Message-ID: <20260721223807.75101-1-nnamdio@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Spurious wakeups in tcp_msg_wait_data() aren't being handled by
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

Changes in v7:
- In tcp_bpf_recvmsg check for data in the TCP_CLOSE, !timeo and
  signal_pending branches.
- Refactored changes to tcp_bpf_recvmsg to reduce duplication.
- Increase the number of iterations in the selftests.
- Documented selftests numeric constants.
- Link to v6: https://patch.msgid.link/20260720171535.67867-1-nnamdio@gmail.com

Changes in v6:
- Closing the file descriptor in the selftest worker thread.
- Ensuring the selftest loop breaks early for an error in the worker
  thread.
- Added comments to selftest regarding focus on EAGAIN error.
- Updated selftest commit message to imperative mood.
- Link to v5: https://patch.msgid.link/20260717155348.54975-1-nnamdio@gmail.com

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
  selftests/bpf: add sockmap recvfrom EAGAIN selftest

 net/ipv4/tcp_bpf.c                            |  72 ++++++++--
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 136 ++++++++++++++++++
 2 files changed, 199 insertions(+), 9 deletions(-)

-- 
2.52.0

