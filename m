Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9283BE645
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567749; cv=none; b=lwi14gfeLaCjzs53cJ9MK1YZLvaQnEOe5OrzdTj0z/PA+iP9crT4D+04tr7+udFb0Kq/ka1X2AY+zkI7O0oGjlcGYj/8nzn3YxaHB6kiJHtIwdbzNbaDl+GmllBTvKsjSZ+Li2soTVzQtfGRw/Ydo9qhaA9dydhh/mSdemmB6ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567749; c=relaxed/simple;
	bh=aotS4eEfRpVStcxAhOhiA18MzhLy96mjpdyq44LYXME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sJJaC45c7Tbnbf+QJ4WNl4MkauwhzopQvQig8RgGud9/9e4dqtI5gRaPktaRNyj9DAMAeklBGpGlupd6rS+aO9bty3LGAf3pylgDvU3K3IOiFnzhMBjWCWIyIVQBAFkG8dJ/Po7RnwPMz1DAzp7YnlMifMk8JdlieMtTOkyj7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZrtMeU1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZrtMeU1"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954d383e64so16964755e9.1
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 10:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784567740; x=1785172540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PMzyY0w2hvyVLQCy4KUYX/zX5WWoesLqRMdPQHdI44g=;
        b=RZrtMeU1tdM/U7oFsgmsO+PsqJucRmiGpz2Fon6khrS+969ciIezNGVpsHbRQA3NBm
         OPlhlxDoTSQkl157N4Tmprn1xJGA3sBEnk6LUAU8zUxgMSZjGlDAVEU2MYUA6TyelEQ0
         EYJCfk/7lfmktevT9GpDXzbnokJpGZgsylnyNJuieF/DXBlWKo2ZVkoTV+k/Sjk1o5Md
         z6zb/Fgqv9W1AUfWA6veeLg4tF3GVqaHMP0d2bqz7bb+Vr/0jrw6ULBgZjdqTHEPK5oi
         0tEtcQOze0p9+k0pRyYqhWT9gOkgNKrBsVTrwD/HRWPs6Whw7rReGQeNXsfy4M2uDiPY
         J0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784567740; x=1785172540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PMzyY0w2hvyVLQCy4KUYX/zX5WWoesLqRMdPQHdI44g=;
        b=KxtBeD4Svr3MUsm38P3aRdJMjtIa3etrqsFlMelKA9xifSD4/7XkbsDM/Ib2hT98Z0
         HQWNm4DW8FsDSN1xe3NLN0e+6NRqW+0ZFq/4ONMk2LX7hmqdQcHkvhR39lbhPA4pB956
         IUjlCSuDH0xPKxVwbSY6A8yZZtSMzQoBnpL2TOB0b8ynMgzgXRaZTcJ3VCZVM543mKTe
         A+ZOJrtd2gUhBxsiARRQa87WquQ34XMD8P/f3/pxx991mpXs953m2lR2R7ZX7F9BwgLm
         8TMp9ba4CFboTgUnhcalg8wpRJK2enOTGBnW9dzCGWRaSE/8MuO6Jq+L29Pt6UhblK1W
         aXRQ==
X-Gm-Message-State: AOJu0YxBDvDhUo0YHsqh9LwFsnTIIFyO0sCbtWJFDAHwQKkb1H5cenFM
	hEZkDbeFD/AE9E7oUe+YnA2lYMy2qVllbWvbhaHpbWpNVN4mfo0CPzmZ
X-Gm-Gg: AfdE7ckXJtZ0vJk0ot0KeEolo3kk2i+9YIW8TSpfHU74V6nHaM02NWNR5EbvQDbRqLp
	TAbDfZOGzO70qlgqPauEiVP9GBCxJOkjQRe3DKXkAWCLEXtmi1zquBAI6ju9sCcryc2hKy0LwJ0
	+4TGQL9777/mz/K5oGtCAHTC6YpRN088PoLxKcPjK5V9A8Q/EMrLmdgl1JI81sxl7t0CpONxDte
	99xbORZy8pReHPFYmCLCtIEeVkfpseYV+NaEgdMugrFkeGmUKppkHBqUT1P8JTKbcSZUCwp4GOI
	PrWPCu8MTzY/ZqgN+yiR+SMeiSRRo80lVI91/QmAxFyxstyZBkgV577QVsDs0Aap8qSfzMuwfLM
	HH/CeXcURRSwsSfkXVUf6Y0MvMBcklZP2sabdnAaEfOYK0A7MfjUn/TAH+IgWJF6nu8eBWaWlz+
	oV6O10HgtL+9tjoZi26bE+Jyx4Yg1LMef4b/ZLKsxrL3xX3cQEbsKrdn+fPFmvDjaYsQ==
X-Received: by 2002:a05:600c:4f13:b0:495:4fd5:570 with SMTP id 5b1f17b1804b1-4954fd506eemr130115115e9.4.1784567739453;
        Mon, 20 Jul 2026 10:15:39 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956547af7esm2304865e9.8.2026.07.20.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:15:38 -0700 (PDT)
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
Subject: [PATCH v6 0/2] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
Date: Mon, 20 Jul 2026 18:15:33 +0100
Message-ID: <20260720171535.67867-1-nnamdio@gmail.com>
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

 net/ipv4/tcp_bpf.c                            |  69 ++++++++--
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 124 ++++++++++++++++++
 2 files changed, 184 insertions(+), 9 deletions(-)

-- 
2.52.0

