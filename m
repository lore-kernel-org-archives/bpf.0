Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E148639EF2C;
	Wed, 29 Apr 2026 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777501803; cv=none; b=UvH7pHGhba260WeWV3EJnkaUCZXNjUYnniJGMsL4ZvHUmKh2ix0DGC4uzGxTJhGvi0KQNPmIZkA/V1aWMKpmJj8FKYyjCPJXnGDIQrJjzwtoZCYP8Gi2L9/GZ04d4sh1B3xva7tCoiep0/VXLFInOsv9kDsTqqGB9FhzPglDpgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777501803; c=relaxed/simple;
	bh=3DcQIt3OyWfZwNDlD3KnBgTDz3Y2yFzJGzIKKpu3KJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SxqOwJP8Wox75AlMX9l2M6Rz8CnkVPFWuG1/RGh9FdMk6uKFADUYhb8TxcSQrNR+K8X5bATzzlZWX7e9Tky8XVcelNoIuwCDHs+UHSLk+LCx0+oDJE+H9c8nDu1mwbeGaoQ04LeooAQhUTuzhztprq2qWpNBYuCB4fiUKwYtvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezbBlo6b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezbBlo6b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F79C2BCB4;
	Wed, 29 Apr 2026 22:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777501802;
	bh=3DcQIt3OyWfZwNDlD3KnBgTDz3Y2yFzJGzIKKpu3KJE=;
	h=From:To:Cc:Subject:Date:From;
	b=ezbBlo6bgBKEEKdAHzTGXWDdwYzD5N6UUyoP1u93bdUv0+YudqOgkJnif7BF5L0O7
	 MtynkNmY5uSnSuBPrL1eZc/z1IdTM+lrYqFuvVMNB2k1D1YbwUfId0L8hFrKyJXJnx
	 NxjCnv5DIR0gatVqUsx0bvC378J9Ru/FNMiGKXcwis2LOkT6CnbkZIqI3oospHcehR
	 9QGEkp7yrg4XLz6bWrtwrea+RqEdYPr6Q7RsVSZAVNOHpwCjTaws94/loKvFN18Kbb
	 vsQ7Y66n1XXjopQIGQGuhK+rb/fcN3GR1vnczzgT8iGqifJvItagtSatmZOF+3lDVp
	 qXgTLddaMfG+A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/7] net: tls: fix a few random bugs
Date: Wed, 29 Apr 2026 15:29:37 -0700
Message-ID: <20260429222944.2139041-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a few random bugs, from external reports and my local scan
with various AI tools. Mostly corner cases in code which I don't
think TLS maintainers would consider "battle tested".

Jakub Kicinski (7):
  net: tls: fix silent data drop under pipe back-pressure
  selftests: tls: add test for data loss on small pipe
  net: tls: fix page pin leak on sendpage_ok() failure
  net: tls: fix off-by-one in sg_chain entry count for wrapped sk_msg
    ring
  selftests: bpf: cover wrapped sk_msg ring chaining in ktls TX path
  net: tls: fix use-after-free in tls_sw_sendmsg_locked after bpf
    verdict
  selftests: bpf: cover tls_sw_sendmsg UAF after bpf_exec_tx_verdict
    split

 net/tls/tls_device.c                          |   2 +
 net/tls/tls_sw.c                              |  17 ++-
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 139 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_ktls.c   |  10 ++
 tools/testing/selftests/net/tls.c             |  43 ++++++
 5 files changed, 207 insertions(+), 4 deletions(-)

-- 
2.54.0

