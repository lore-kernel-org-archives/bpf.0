Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794431;
	b=Y9+Xf6v3Duz8MxTjiIonORghKWV/m3qd3D/V/I35L8yQLOQB1OY040XN5vFYKfbhhPuC
	 kyQKYECdbcXE5phYrbXsyvmMto7RYNBGz/WXUx5rtlsMahWym0jMTkd9fPpg/qzeCQaeq
	 8eivAHkxu2kpxjNNTUgu4J83x/bUSbkPoisMn4tzuErZXB4hAhJWcFzLcaRYvDF9+decG
	 RcQ82Edc0BZDNIPyDo8jhSN648EbfURjqbgoDaZd6l9qNTe3mdDV0XOFDxl9TFTwDQaD8
	 Afj5CPp8a9VeJUGYdh7/vjjhfSFDs682jVcJDxdz0c36IQRNs2CdWAc0sYKSqiT7qqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794431;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:DKIM-Signature;
	bh=HHnM5TEkoHOuFm3yyh6DB+8RQEyRe9oYyVhpQPrUB+g=;
	b=fvtVpWYnAlEJ8Qnhn4nEqdM/io+YdElz74cJtFoMCFKV9qUjGoFD6lbfi7hczs3AOquS
	 Hp3IHaWQY/qbGrTsyTa/DX4HRVrs65nRL5bTl+QiUit5fM6a9kU2Q8C9J2ZuD4PYBtgQK
	 WiBhO4hWyPDZSdI/NfPBTqVApU68j1uVmKfbvb/Yzq1wcuHvrAki04ijZmFuu1xQU6pTA
	 F/heqlQI7+761mI+WiRIUJK78Ru9fG5ZMoZCLYUt3ZQ3lPwGj6SyyLRLkg+Mnf/MRseyt
	 a1/EGv9TLXg1jbyf+7Kz3VpUpMDY1CvRVK78+n7asqp47QSwfipWU9biqbJEwc1Syiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=TQNB0B6f;
	arc=none smtp.remote-ip=217.74.67.75
Received: from smtpo75.interia.pl (smtpo75.interia.pl [217.74.67.75])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35D5606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 12:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C35D5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=TQNB0B6f
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Wed,  4 Nov 2026 13:13:34 +0100 (CET)
From: Slawomir Stepien <sst@poczta.fm>
To: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	aleksander.lobakin@intel.com,
	ilias.apalodimas@linaro.org,
	toke@redhat.com,
	lorenzo@kernel.org,
	ihor.solodrai@linux.dev,
	tavip@google.com,
	maciej.fijalkowski@intel.com,
	sst@poczta.fm
Subject: [PATCH v6 bpf 0/3] xdp: fix page_pool leaks
Date: Wed,  4 Nov 2026 13:13:13 +0100
Message-ID: <20261104121316.1155680-1-sst@poczta.fm>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1793794416; bh=HHnM5TEkoHOuFm3yyh6DB+8RQEyRe9oYyVhpQPrUB+g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=TQNB0B6fUFVq9ONkh9XwodYEzxH6DJLJB7MCuv0VlT5DkrmvzNJ2+i/9jTeQUph4E
	 1/nIaTk32QcsBZ3+wpUxZhfz5fYL8vF/bPmhZfJaC0rv7q3ftPpxQAYJnOnbO7P6Uz
	 pbAP/gSpkATEQgFOtDc6A1tuUUXSUzmWZKeEZe5M=

v1:
https://lore.kernel.org/bpf/20251003140243.2534865-1-maciej.fijalkowski@intel.com/
v1->v2:
- add skb to xdp_buff converter (Jakub)
- postpone restoration of veth's xdp_rxq_info mem model (AI)

v2:
https://lore.kernel.org/bpf/20251017143103.2620164-1-maciej.fijalkowski@intel.com/T/
v2->v3:
- make skb->xdp_buff conversion agnostic of current skb->data position
  (Toke)
- do not pull mac header in veth (Toke)
- use virt_to_head_page() when checking if xdp->data comes from
  page_pool (Olek)
- add ack from Toke

v3:
https://lore.kernel.org/bpf/20251022125209.2649287-1-maciej.fijalkowski@intel.com/
v3->v4:
- include skb->head when calculating packet length (Toke, lkp)

v4:
https://lore.kernel.org/bpf/20251027121318.2679226-1-maciej.fijalkowski@intel.com/
v4->v5:
- rely again on sk_buff::pp_recycle when setting mem type on rxq
  (Jesper, Jakub)
- add ack from Toke on patch 2 and restore it on patch 1

v5:
https://lore.kernel.org/bpf/20251029221315.2694841-1-maciej.fijalkowski@intel.com/
v5->v6:
- rebase onto bpf/master
- patch 1: set MEM_TYPE_PAGE_POOL unconditionally in
  xdp_convert_skb_to_buff(); mem type only matters for frags consumed
  by the program, and those always come from skb_pp_cow_data() (Jakub)
- patch 1: add DEBUG_NET_WARN_ON_ONCE() for a non-linear skb without
  pp_recycle and document the expectation in kdoc (Jakub); the warning
  is limited to non-linear skbs since linear ones legitimately skip
  the CoW
- new patch 2: veth_xdp_rcv_one() ran the program on an xdp_frame with
  whatever mem type the previous packet left on rq->xdp_rxq; use the
  frame's mem type instead, as cpumap and devmap do. With patch 3 alone
  veth sends page_pool frames to its peer and the peer's program
  trimming frags crashed the kernel, so this comes first
- patch 3 (was 2): veth turns the buff into an xdp_frame on
  XDP_{TX,REDIRECT}, so the head is released through mem type too;
  keep the queue's original model unless the buffer was copied into
  rq->page_pool (Jakub)
- patch 3: take page_pool refs on compound heads via netmem helpers
- patch 3: do not restore the rxq mem model after XDP_{TX,REDIRECT}
  and on the error path; with patch 2 every path sets its own mem type
- patch 3: veth can now redirect MEM_TYPE_PAGE_POOL frames, which needs
  commit b3ca872947ef ("bpf: Use the frame mem type in devmap egress
  XDP") in devmap; list it as a stable prerequisite
- drop Reviewed-by/Tested-by tags as patches 1 and 3 changed

Hi,

here we fix page_pool leaks which happen when fragment is released
within XDP program and memory type is set incorrectly. The reports come
from syzbot and AF_XDP test suite.

Most of the changes are about pulling out the common code for
init/prepare xdp_buff based on existing skb and supplying it with
correct xdp_rxq_info's mem_type that is assigned to xdp_buff. A bit more
stuff, page_pool related, had to be done on veth side.

Originally, this work was started by Octavian Purdila and continued by
Maciej up to v5. Maciej then took the larger veth rework from the v5
review to net-next as an RFC [1]. This v6 picks up the v5 series, with
Maciej's agreement, as the minimal fix for bpf and stable, and addresses
the v5 review. Maciej stays the author of patches 1 and 3 and my changes
are noted in their commit messages; patch 2 is new.

For veth, Jakub listed three options: stop turning skbs into xdp_frames
in veth, decide the head's mem type when the CoW was skipped, or CoW the
head on the Tx/Redirect path. The first one changes veth's XDP handling
beyond a fix (it is what the RFC does), so patch 3 takes the second:
veth knows whether it just copied the buffer into rq->page_pool, and
only then advertises MEM_TYPE_PAGE_POOL. An skb that skipped the CoW is
linear and keeps the queue's original model, as before this series.
The two do not conflict: the RFC can go on top of this series and
replace the veth parts of patches 2 and 3.

[1] https://lore.kernel.org/all/20260509084858.773921-1-maciej.fijalkowski@intel.com/

Patch 2 fixes the same problem for frames in veth_xdp_rcv_one() that
commit b3ca872947ef ("bpf: Use the frame mem type in devmap egress
XDP") fixed for devmap; cpumap already handled it.

Testing (x86_64, QEMU via virtme-ng, KASAN + DEBUG_VM + DEBUG_NET; the
series ran on bpf/master fb7bd3a2aad7 and, rebased without changes, the
reproducers, kprobe path checks, devmap test and selftests below ran
again on 05441d697f7f with the same results; the runs without the series
on bpf/master c8a8a68d3ab4):
- reproducer: an xdp.frags program that trims all frags with
  bpf_xdp_adjust_tail() on 8000-byte pings over a 9000 MTU veth pair;
  without the series both generic XDP and native veth XDP hit
  "BUG: Bad page state ... page_pool leak" followed by
  VM_BUG_ON_PAGE(page_ref_count(page) == 0) and a panic; with the
  series 20/20 packets are trimmed with no splat
- native veth XDP_TX of multi-buffer packets, with and without
  trimming frags first (200 large + 200 small pings each), then veth
  teardown and a 75s wait for page_pool "stalled pool shutdown" or
  negative inflight warnings: none
- BPF selftests on bpf/master with tools/testing/selftests/bpf/config:
  ./test_progs -t ns_xsk,xdp: all 34 tests (205 subtests) passed, no
  splats, with and without the series
- the standalone AF_XDP suite (test_xsk.sh) also runs the tests that
  test_progs skips as flaky; XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF reports
  PASS either way, but without the series dmesg shows 60 "page_pool
  leak" splats from generic XDP (bpf_xdp_adjust_tail -> __xdp_return ->
  page_frag_free on pages allocated by skb_pp_cow_data()); with the
  series there are none
- frame path: one veth bounces 8000-byte pings with XDP_TX, its peer
  trims all frags of the resulting frames (IPv6 off, so no skb touches
  the peer's rxq first); with patches 1+3 only: "page_pool leak",
  VM_BUG_ON_PAGE() and a panic in veth_xdp_rcv_one(); with the whole
  series 50/50 frames are trimmed, kprobes show all __xdp_return() calls
  with MEM_TYPE_PAGE_POOL, no splat, also with IPv6 on so that skbs and
  frames interleave on the peer's queue; bpf/master alone passes as well
  since veth only sends MEM_TYPE_PAGE_SHARED frames there
- remaining veth paths, each confirmed with kprobes: skbs that skip the
  CoW (frames passed up by one veth and forwarded back into it: 1229 of
  1260 runs without skb_pp_cow_data(), heads from the page_pool),
  XDP_REDIRECT failing on the skb path (40 xdp_return_buff()) and on the
  frame path (40 xdp_return_frame()), XDP_PASS of 20 frames after their
  frags were trimmed; no splat, and none of the page_pool shutdown or
  inflight warnings 75s after teardown
- devmap egress after patch 3: veth redirects copied skbs through a
  devmap whose egress program trims all frags; with the series 20/20
  trimmed, all __xdp_return() calls with MEM_TYPE_PAGE_POOL, no splat,
  nothing 75s after teardown; with b3ca872947ef reverted on top of the
  series: "page_pool leak" from page_frag_free() under
  dev_map_bpf_prog_run(), VM_BUG_ON_PAGE() and a panic, hence the
  stable prerequisite in patch 3
- W=1 builds of the touched files with LLVM=1 and with DEBUG_NET=n: no
  warnings
- XDP_ADJUST_TAIL_GROW fails in DRV mode with and without the series,
  so it is unrelated
- not tested: page_pool frames from hardware drivers redirected into
  veth, bpf_xdp_pull_data(), multi-queue load, the full test_progs run

Performance (the same VM with 8 vCPUs, non-debug kernels with
PAGE_POOL_STATS, bpf/master fb7bd3a2aad7 with and without the series;
pktgen sends skbs into one end of a veth pair, the program on the other
end counts packets; median of 6 runs of 8s over two boots per kernel):
- 64-byte packets with native XDP_DROP, XDP_TX and XDP_REDIRECT (devmap
  to another veth), and generic XDP_DROP on 1 and 4 CPUs with 64 and
  8000-byte packets: within 2% of the base kernel, no regression
- native veth with 8000-byte packets (3 frags): XDP_TX +8.8%
  (0.507 -> 0.552 Mpps), XDP_REDIRECT +8.4% (0.613 -> 0.664 Mpps).
  Without the series veth_xdp_get() takes plain page references on
  the head and frags, so the pages copied into rq->page_pool are
  released from the pool instead of recycled (~1.2M/s
  rx_pp_recycle_released_ref plus slow allocations); with page_pool
  references they go back to the ring (~1.4M/s rx_pp_recycle_ring, no
  released_ref)
Absolute numbers in a VM differ between boots, so only the relative
change is meaningful.

This v6 was prepared with an AI coding assistant (Claude) from the v5
review thread; the assistant wrote the code changes, all of patch 2,
the changelog updates, and ran the tests listed above.



Maciej Fijalkowski (2):
  xdp: introduce xdp_convert_skb_to_buff()
  veth: update mem type in xdp_buff

Slawomir Stepien (1):
  veth: use the frame mem type when running XDP on an xdp_frame

 drivers/net/veth.c | 56 ++++++++++++++++++++++++++++++----------------
 include/net/xdp.h  | 36 +++++++++++++++++++++++++++++
 net/core/dev.c     | 25 ++++-----------------
 3 files changed, 77 insertions(+), 40 deletions(-)


base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.56.0

