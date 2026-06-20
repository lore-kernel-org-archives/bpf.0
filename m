Received: from outbound.qs.icloud.com (qs-2002g-snip4-11.eps.apple.com [57.103.87.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF822147F9
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.87.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781957637; cv=none; b=DkG9KmmIKsfVSvT53R8STzR8BbP1PJBNyKTTjCq/Dpdc5w2l0bAGA8ZydjsHcmCnF3RhUqoS45if8vkPnYNfwmPdmEkXyq1IfUyOnA1wrcwDCo0ZLHgDNOO0NHJK9rnR6e0J29hMeTtGViM/H1BR/sDYt03QeyYikbDZkYD9Jj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781957637; c=relaxed/simple;
	bh=aeRCG9IbJCYM/pLLbDklq0PuQs1TcxJY82pk0IPGOaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/8OlFcnEC9zUvAjXGvaMNaJhr276jVMQidJSQLwUnQhIqzyo2cvoOAv4J8WEPESk1qc2z2c07Dzfdd0+sj4Op3ijlqeX3oWqOdZEuLwrXdeY/Cy8+BDvIrsF+hHxLrs+uPgoH03hy+2Qq2ue80HqUv2N3Fe4BnHhWFdtCeIAwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=k1FV5e9f; arc=none smtp.client-ip=57.103.87.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="k1FV5e9f"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-2 (Postfix) with ESMTPS id D0AF9300017A;
	Sat, 20 Jun 2026 12:13:51 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQpOHV8CXhxBAFYLWxcOVk1KEVcJXwpABFEbWg9eK1sTVRdGCRkIXR0ZHldQXgheH0wcHQ5YBhICWkUKTV8OXh8EF0YZVQRHHl1WQh4ZAlEcVg1XQ1QEX1BJDEFQbFoARxdIHV0ZWW9QXRwOBFQHXQVdVlACWktfGV1FD18HWQRAD0oDXAVaAUIIVgdYBVkFXQhVQARTD1oRSwxbDl4JWzBQG18CQg8cE1YVDU1DEkIVBBFQAVgeVg==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1781957635; x=1784549635; bh=SaO0TQnbwTAbu9emSwCT5mBn4ilASYCmpin95gfilp4=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=k1FV5e9f6BDlf6nI50sDjBVADxNC6Pz3mFN6NeH4nx5UufLAaMRMBqMAMJsjfcrXkxU6zLlm6htC9uS78vMmQ0ytSgnxr2fRgXWyQWdjWAecjPbdI43UkdUWl9AbDhU5/Tk39qFUFHWUYQJv3ITVXGHt6mS63VtBuXxU2nAXjBS6apbRnwvcPkbKpuSrEUXqSK7pKJsNOarorjVlVTHHmDxTjPx8TicBFXIEK3ScQLB0q+S/SBS0icYbIi1GSTHf0GCdHGPKakDPRRjwbWlbv7vkBekq0PTLwINeYceN0bb3GhZo2oQXiJBNcmKnIUNHCQurCfh+CLCNffTq9otABg==
Received: from cibi (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-2 (Postfix) with ESMTPSA id 12F463000179;
	Sat, 20 Jun 2026 12:13:46 +0000 (UTC)
From: Siddharth C <siddharthcibi@icloud.com>
To: ast@kernel.org,
	kuba@kernel.org,
	hawk@kernel.org,
	andrii@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Siddharth C <siddharthcibi@icloud.com>
Subject: 
Date: Sat, 20 Jun 2026 12:13:12 +0000
Message-ID: <20260620121321.45227-1-siddharthcibi@icloud.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: op2Efvtf60g00WP6aSZVh7xoob9iGw7B
X-Proofpoint-GUID: op2Efvtf60g00WP6aSZVh7xoob9iGw7B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDEyMSBTYWx0ZWRfX7u+BgaOek0wq
 9vqprgTUg2wDJwOUdOSynKkyHLga9jkJSreJ4xI80CJ1FYFr6oFrGz7XChxYseN2PUX012z2KQJ
 P2OtMSm0Gp6fpFro+N0x5NT5fNXKQC7zLOhx3+IgId54CVH1zXt3i4A6n1si+RTtysUBFDVNqYq
 mHQKZ9tcJidbXB+7zgPO3GNObVd7nqVHkdm7jmJ/Qcb8GzldOU2inFStRIARwwsrBNy4Giv5zOD
 4au6WisL/vA/NOaEnKz9+QmaZSvHlCKWJ80iHX7Da44upapve8oWH/XgwCkrJ9dtmowBbRpcXRY
 MNO/utzQtTSAAG/sBkW
X-Apple-Category-Label: MjA0NzgyOTUxNDY6JGNhdGVnb3J5JF9QZXJzb25hbCw=

Subject: [PATCH 0/2] bpf: preserve rx_queue_index across XDP redirects

XDP programs executed after redirect through cpumap and devmap
currently lose ingress RX queue information because rx_queue_index
is not preserved across xdp_buff to xdp_frame conversion.

Preserve rx_queue_index in struct xdp_frame and restore it when
rebuilding xdp_rxq_info for redirected execution paths.

Add a selftest validating that ctx->rx_queue_index remains available
through redirected execution.

Testing:
* Built modified kernel objects
* Ran tools/testing/selftests/bpf/test_progs -t xdp_metadata -v
* Verified xdp_metadata passes
* Added explicit rx_queue_index assertion


Siddharth C (1):
  bpf: preserve rx_queue_index across XDP redirects

Siddharth_Cibi (1):
  selftests/bpf: validate rx_queue_index in xdp_metadata

 include/net/xdp.h                                     | 2 ++
 kernel/bpf/cpumap.c                                   | 2 +-
 kernel/bpf/devmap.c                                   | 5 ++++-
 net/core/xdp.c                                        | 1 +
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 3 ++-
 tools/testing/selftests/bpf/progs/xdp_metadata.c      | 2 +-
 tools/testing/selftests/bpf/xdp_metadata.h            | 1 +
 7 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.53.0

