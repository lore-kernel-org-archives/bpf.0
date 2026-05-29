Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BED2E03EA
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067695; cv=none; b=JP2z5T+dzIeSnkBmZ4/CNF5VJbz8HN8E3kMqrLg0e1vRKnjoB+QiRk5jm4WDHSiiMFXrNc6fd+rQB4/Z0ikF9csaqSVHqW3itibRpro/bSBZp2pO6i9sn7kPp/n4Zig/UPNoksa2xM0S1OsAOTXVfMz11VQpzubjnJ4KvHE5SjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067695; c=relaxed/simple;
	bh=1Gxg4/H4M4EI8CJui4aTaBaLUod8+6zRAPKNyr1ay7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mMhhwe3sgE62w/mwgLJGiSjLayRzsUGVCrLWyN5EQWWa0C4zxYVCT9sH2yKTIuvw1/ypZnwm5i5CcrdZhJo5yA2ui/TiSPsE/k/4hF9wTTmQDaG1/hNNstZP8ugC8bPmX6OTxvbi7fbzLcZR6LZ60scvM0mijENq87xo28mLzqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IKs5bOuy; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IKs5bOuy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780067681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZKX3haN61Wnik8To+l56QjAR+mrY0s0xumH2LohYHes=;
	b=IKs5bOuyL9kBLbK9wnNTf6GSl/4BvYEaOtheeBpPzuXzfg3TMajccTJmRk7sU8bjEgr3uA
	BE/BIs7ttYSmHl7DEeJwPLY3bk6OyuvAXNWbJuzaAPpoz72xpk/oY9j87umXxzcVVLptXs
	JKc2Q8s1JRqZabeMyANFHH6hnsamuGM=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Ido Schimmel <idosch@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Peter Oskolkov <posk@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf v2 0/4] bpf: Update transport_header when encapsulating UDP tunnel in lwt
Date: Fri, 29 May 2026 23:13:47 +0800
Message-ID: <20260529151351.69911-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, bpf_lwt_push_ip_encap() does not update skb->transport_header.
When a driver, e.g. ice, reuses the stale skb->transport_header to
offload checksum computation to NIC hardware, VxLAN packets encapsulated
by bpf_lwt_push_encap() helper may be dropped due to incorrect checksum.

Update skb->transport_header in bpf_lwt_push_ip_encap() whenever the
encapsulated packet uses UDP, so checksum offload works correctly.

Fix these two issues reported by sashiko:

1. memcpy() hdr to a local buffer to avoid TOCTOU issue.
1. "iph->ihl < 5" was missing to avoid infinite-loop in MIPS driver.

Changes:
v1 -> v2:
* Address sashiko's reviews:
  * Fix TOCTOU issue in lwt to avoid changing hdr after checks.
  * Add check iph->ihl < 5 in lwt to avoid infinite-loop in MIPS driver.
  * Update comment style in selftests with BPF comment style.
* v1: https://lore.kernel.org/bpf/20260525142650.2569-1-leon.hwang@linux.dev/

Leon Hwang (4):
  bpf: Fix TOCTOU issue in lwt
  bpf: Add check iph->ihl < 5 in lwt
  bpf: Update transport_header when encapsulating UDP tunnel in lwt
  selftests/bpf: Add tests to verify the fix of encapsulating VxLAN in
    lwt

 net/core/lwt_bpf.c                            |  20 ++-
 .../selftests/bpf/prog_tests/lwt_ip_encap.c   | 158 ++++++++++++++++++
 .../selftests/bpf/progs/test_lwt_ip_encap.c   | 112 +++++++++++++
 .../bpf/progs/test_lwt_ip_encap_fix.c         |  36 ++++
 4 files changed, 323 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_ip_encap_fix.c

-- 
2.54.0

