Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAC5155757
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 02:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781490035; cv=none; b=O69SNLzxhBAKdreNSF3MWvk5Piree31tpmwbD6KMVP1gxKxJ7/cwJrLeH9R2b/9wR/TA2vNEm19KWEj15/lIB2OGKaYeS9eyu5w9AHF2vrn7ojPqFvIsPNlZfxFzNGqSdhgipkle81g8526y3W6v0jcmmw+pwOqRmxZEi96SdEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781490035; c=relaxed/simple;
	bh=X2sAx85wAAyGhm/EoqXJLnY16L/SUw5rsAhFLQf8iG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EiOP+EPxuCMPVPCMb8aV5AlxWlQTxkg66HFDJGwLPpsJ7lITtWG1CPgcW5Rm2c9J/BsUec0Vh0v7Kii+40F6Nl1SEeeviwImqQMbttNqSl2NVwJ3RkZojJ/gt5NZKPN0FxCdrBC4BBpw1XiVSaV6B2jcQ4Qa3ABRnlSEYuBMyIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dQ2bTrZJ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dQ2bTrZJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781490032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=No35Lw/b39ChO3VZp7VlHxwv6aJUeGevbRD6Ukvn+S8=;
	b=dQ2bTrZJhAB9Ib/Efydn/XjuFmzZ2JYTZsRms2PZG3DdNjo5qyd9++BC3SNfxsGhn7ro5P
	Kw7PBc3nGnAnREmZByh4rCUyjsRiY5ZZdHIWgja+IX9TGpodd5NWb/pPlzHQhNvKEwKjGE
	0t0gX2rgqsU2LML1qByS1Y0tZmegyT0=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev
Subject: [PATCH bpf-next v4 0/6] bpf, skmsg: some fixes for skmsg
Date: Mon, 15 Jun 2026 10:19:53 +0800
Message-ID: <20260615021959.140010-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


All fixes are from previous patches sent by Weiming Shi, Zhang Cen,
Kuniyuki and Sechang Lim, which have already been reviewed by me and John and Jakub.

https://lore.kernel.org/bpf/20260610081218.506709-2-rhkrqnwk98@gmail.com/
https://lore.kernel.org/bpf/20260520102715.3033936-1-rollkingzzc@gmail.com/
https://lore.kernel.org/bpf/20260424191602.1522411-3-bestswngs@gmail.com/
https://lore.kernel.org/bpf/20260423155807.1245644-2-bestswngs@gmail.com/
https://lore.kernel.org/bpf/20260221233234.3814768-4-kuniyu@google.com/

The automated reviewer (sashiko) may still flag a few other potential
issues on top of this series. After looking into them, they are either
already covered by the patches here, are the BPF program's own
responsibility (e.g. initializing the payload it pushes) and intentionally
left out, or only reachable under very narrow conditions that require a
specially crafted BPF program and an unusual sk_msg ring state, so they are
not practical to trigger and are left out of this series. I'm collecting
these fixes together because the same
problems have been re-sent many times in slightly different forms, and I
hope this series can be prioritized for merging so the duplicates can
finally settle. With so many AI-generated patches floating around for
these spots, leaving them unmerged just keeps wasting maintainer review
cycles on the same issues.


v3->v4: Carry Kuniyuki Iwashima's reviewed-by tag.
        Drop the __GFP_ZERO patch; initializing the pushed payload is the
        BPF program's responsibility, not the kernel's (per maintainer
        feedback).
        https://lore.kernel.org/bpf/20260612130919.299124-1-jiayuan.chen@linux.dev/
v2->v3: Target to bpf-next and carry Emil's reviewed-by tag.
        Reverse xmas tree style is used suggested by Cong.
        (not all code match reverse xmas tree due to variable dependency)
v1->v2: fix problem when fix the conflict.

Kuniyuki Iwashima (1):
  sockmap: Fix use-after-free in udp_bpf_recvmsg()

Sechang Lim (2):
  bpf, sockmap: fix integer overflow in bpf_msg_pop_data() bounds check
  selftests/bpf: add test for bpf_msg_pop_data() overflow

Weiming Shi (2):
  bpf, sockmap: reject overflowing copy + len in bpf_msg_push_data()
  bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()

Zhang Cen (1):
  bpf, sockmap: keep sk_msg copy state in sync

 net/core/filter.c                             | 97 +++++++++++++++++--
 net/ipv4/udp_bpf.c                            |  9 ++
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 48 +++++++++
 .../bpf/progs/test_sockmap_msg_pop_data.c     | 27 ++++++
 4 files changed, 173 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c

-- 
2.43.0

