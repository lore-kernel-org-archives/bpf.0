Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095062;
	b=RnKwll3yquFT5lIIFdzsAQybwBqiSdN3LXm2ybkW2AUgPyi7S90M9dyi74Pe0pFG8CJ/
	 i/6NsHHFhz7LzHVOgoVJ1ahNFHFY0Zvnr26YoPUp/ybupMMvYVZPpVaoqfR3ZdvI0AZJ3
	 NyxnLC4J8VAyN+v8Bs/+M4c6LclcFWQQdhfCs5VHoApjFjngOIoCmbdc6sQOC9OBdrW9U
	 uuoLtKwK5TuI0hAFbtEXeasNXCdSxotE1NNDBNfMq0BHZ5A1jPT7xFfctrSRJASrW1RyT
	 j8YODya2Q7s2EEpRwQsIa2jFMYAIUlLroJmfGN5tCS0VmNXf4lb+D4Z8TGQ7dN0/qZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095062;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:DKIM-Signature;
	bh=cOT01Eu5jIELCRSIZb2i7NtTdpX4y4H3A3WVilRs+LA=;
	b=h0b9mkPmvRXRuHP/siB3vI8ZohgIUlWe2Z/TgkCngabcCnduLkE3SXvVADTpLfXbk0hH
	 Bs1rXDpabrZgADC8raWVJ121TPw4+VOD5ILw+QVwsoVOnu77c+9qDu4cU/hVXOSKdTAn8
	 ceQg6qr0IeYghjsiFtiz4478KHuXGjIkgSUT4TpZ+rkMglwtFjjCxO1SCKUNLuOTLRLmh
	 cY+y1VhdOxekIsIlgdwShIvyLm9N+K6Fk656xDP/8WuYVwoc48e5BqqS3jSstRJCFTkx4
	 IQHRoRAi7iULLWZePRzEX/snF2cFedgs9x7aq9ja0OhbG46LaZFA6lZ3+5nTlRAyn0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b="s/F9hBTK";
	arc=none smtp.remote-ip=217.74.67.75
Received: from smtpo75.interia.pl (smtpo75.interia.pl [217.74.67.75])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA454606A326
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 13:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA454606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=s/F9hBTK
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Thu, 19 Nov 2026 14:30:50 +0100 (CET)
From: Slawomir Stepien <sst@poczta.fm>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tianyi Gao <tianyi@cloudflare.com>,
	Octavian Purdila <tavip@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH v7 bpf 0/5] xdp: fix page_pool leaks
Date: Thu, 19 Nov 2026 14:30:27 +0100
Message-ID: <20261119133032.2015656-1-sst@poczta.fm>
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
	t=1795095053; bh=cOT01Eu5jIELCRSIZb2i7NtTdpX4y4H3A3WVilRs+LA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=s/F9hBTKziauUr20KegK7ZRFIMQPPBJ/XlaXAyNdflYaGX0lQ3isViFhN8KaErgIL
	 xF2WM0OPeynNBN2Oq8WMHnMtFIQdZ8WG6QMnBd4/J82TA/34qgcct8f6qd69VpOMUq
	 xuK/P8eQMiSXFyc3dLZkMk32iH1HuZZzbNhDPTs4=

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

v6:
https://lore.kernel.org/bpf/20261104121316.1155680-1-sst@poczta.fm/
v6->v7:
- rebase onto bpf/master
- new patch 1: bpf_prog_test_run_xdp() borrowed the rxq info of lo's
  queue 0 (or of the ingress_ifindex queue) for its alloc_page() frags;
  once patch 2 makes generic XDP set MEM_TYPE_PAGE_POOL on that queue,
  a later test run freed the frags as page_pool pages (WARN in
  page_pool_unref_netmem(), reported by Sashiko and BPF CI); use a
  private copy of the rxq info with MEM_TYPE_PAGE_SHARED (BPF CI,
  Tianyi)
- new patch 5: selftest that runs generic XDP on lo before shrinking
  test_run frags, so the ordering behind patch 1 no longer depends on
  which tests ran before
- patch 2: reword the description of the mem type and drop the stale
  BPF CI remark in the commit message; Cc stable, as patch 4 needs it
  (BPF CI)
- patch 3: add Reviewed-by from Tianyi
- patch 4: list the backport prerequisites in the commit message
  (BPF CI)
- new performance numbers; the ones in the v6 cover letter were wrong:
  the XDP_REDIRECT run was broken (the devmap entry pointed to a device
  in the wrong netns, so no packet reached the target) and the kernels
  still had debug options (KCOV, page_owner, INIT_ON_ALLOC) enabled

Hi,

here we fix page_pool leaks which happen when fragment is released
within XDP program and memory type is set incorrectly. The reports come
from syzbot and AF_XDP test suite.

Most of the changes are about pulling out the common code for
init/prepare xdp_buff based on existing skb and supplying it with
correct xdp_rxq_info's mem_type that is assigned to xdp_buff. A bit more
stuff, page_pool related, had to be done on veth side.

Originally, this work was started by Octavian Purdila and continued by
Maciej up to v5. v6 picked up the v5 series, with Maciej's agreement, as
the minimal fix for bpf and stable, and addressed the v5 review. Maciej
stays the author of patches 2 and 4 and my changes are noted in their
commit messages; patches 1, 3 and 5 are new.

For veth, Jakub listed three options: stop turning skbs into xdp_frames
in veth, decide the head's mem type when the CoW was skipped, or CoW the
head on the Tx/Redirect path. The first one changes veth's XDP handling
beyond a fix, so patch 4 takes the second: veth knows whether it just
copied the buffer into rq->page_pool, and only then advertises
MEM_TYPE_PAGE_POOL. An skb that skipped the CoW is linear and keeps the
queue's original model, as before this series. This keeps the series a
minimal fix that is easy to reason about and to backport.

Patch 3 fixes the same problem for frames in veth_xdp_rcv_one() that
commit b3ca872947ef ("bpf: Use the frame mem type in devmap egress
XDP") fixed for devmap; cpumap already handled it.

Patch 1 prepares bpf_prog_test_run_xdp() for patch 2. Generic XDP runs
on the rxq info of the device queue, which is shared with test_run; with
patch 2 alone, any packet through generic XDP on lo makes later
multi-buffer test runs free their frags as page_pool pages. Restoring
the mem type after generic XDP would still race with test runs on other
CPUs, so test_run gets its own copy, like devmap and cpumap. Patch 1
has no Fixes: tag since nothing changes the shared mem type before
patch 2, but it has to be backported together with patch 2.

Performance (QEMU/KVM, 8 vCPUs pinned 1:1 to host cores, the same
kernel config without debug options for both kernels; base is
bpf/master 4b4eb7f44ee0):

pktgen sends skbs into veth v0 and the XDP program runs on its peer
v1, on the skb path (native veth XDP, or xdpgeneric where noted).
XDP_TX sends the packets back to v0, devmap redirects them to a second
veth pair and cpumap to the network stack on another CPU. The tables
show packets/s that reach the destination (for XDP_DROP: packets the
program saw), the median of 8 runs of 8 s over 4 boots per kernel.
Changes of up to about 2 % are noise in this setup: a kernel rebuilt
with an unrelated one-line change moved single results by up to 3 %.

Why it is faster: on XDP_TX and XDP_REDIRECT, veth turns the skb into
an xdp_frame. On base, it takes plain page references for that
(veth_xdp_get()) and the frame is released as MEM_TYPE_PAGE_SHARED, so
v1's page_pool never gets its pages back: the pool hands every page of
an 8000 B packet to the page allocator and allocates a new one, 4.2-6.1
M pages/s in these runs. With the series the frame is released as
MEM_TYPE_PAGE_POOL, the pages go back into the pool's ring and are
reused, and the pool no longer releases any page. One page holds many
64 B packets, so at 64 B base released only 20-37 k pages/s and the
gain is small.

One sender, softirq NAPI:

                              64 B                      8000 B (3 frags)
  XDP_TX                      4.40 -> 4.39 Mpps (0%)    2.20 -> 2.37 (+7%)
  REDIRECT devmap -> veth     4.18 -> 4.22 (+1%)        2.14 -> 2.29 (+7%)
  REDIRECT cpumap             4.60 -> 4.61 (0%)         1.97 -> 2.12 (+8%)
  XDP_DROP (native veth)      5.74 -> 5.76 (0%)         2.77 -> 2.80 (+1%)
  XDP_DROP (xdpgeneric)       5.70 -> 5.75 (+1%)        2.97 -> 2.95 (-1%)

What it shows: the cost of one packet when nothing is batched. v1's
NAPI runs on pktgen's CPU and each poll sees a single packet.

Why: 8000 B XDP_TX and the redirects are 7-8 % faster from page
recycling; the per-packet work of one poll per packet and the copy of
8000 B into the page_pool still dominate. XDP_DROP does not change, as
dropped pages were recycled on base too, and 64 B does not change.

Four senders, softirq NAPI:

                              64 B                      8000 B (3 frags)
  XDP_TX                     12.07 -> 12.48 Mpps (+3%)  2.65 -> 3.71 (+40%)
  REDIRECT devmap -> veth    11.69 -> 12.17 (+4%)       2.65 -> 3.66 (+38%)
  REDIRECT cpumap             5.31 -> 5.36 (+1%)        2.56 -> 3.69 (+44%)
  XDP_DROP (native veth)     14.85 -> 14.62 (-2%)       4.31 -> 4.31 (0%)
  XDP_DROP (xdpgeneric)      22.32 -> 21.97 (-2%)      11.63 -> 11.42 (-2%)

What it shows: a busy veth. Four CPUs send at once, so v1 and the
destination process several packets per NAPI poll, as under real
load.

Why: at 8000 B the gain grows to 38-44 %: on base, the pages went
through the page allocator on four CPUs at once (5.4-5.8 M pages/s).
At 64 B, XDP_TX and devmap gain 3-4 % as the pages of the frames now
return to the pool's ring as well. cpumap is limited by the network
stack on the target CPU, about 5.3 Mpps on both kernels. The XDP_DROP
differences are within the noise: a profile of 64 B generic XDP_DROP
shows the extra cycles in pktgen and the senders' locks, not in code
that the series changes.

Two senders, threaded NAPI (v1 on its own CPU, the bottleneck):

                              64 B                      8000 B (3 frags)
  XDP_TX                     12.76 -> 12.06 Mpps (-5%)  2.75 -> 3.91 (+43%)
  REDIRECT devmap -> veth    12.95 -> 13.58 (+5%)       2.75 -> 3.87 (+41%)
  REDIRECT cpumap             5.33 -> 5.47 (+3%)        2.70 -> 3.85 (+42%)
  XDP_DROP (native veth)     11.39 -> 11.27 (-1%)       4.50 -> 4.46 (-1%)
  XDP_DROP (xdpgeneric)      11.41 -> 11.21 (-2%)       5.93 -> 5.88 (-1%)

What it shows: the cost on v1 itself. v1's NAPI thread has a CPU of
its own and runs at 100 %; v0 and the devmap target have NAPI threads
on their own CPUs too.

Why: at 8000 B, XDP_TX and both redirects are 41-43 % faster from page
recycling on the bottleneck CPU. At 64 B, devmap and cpumap gain 3-5 %.
XDP_TX at 64 B loses 5 %, but not from more work per packet: a profile
shows the same cycles per packet on v1's CPU (322 vs 320), and fewer
on the CPU of v0's NAPI thread, which frees the frames (152 -> 138
cycles: page_pool recycling instead of page_frag_free() and page
allocator frees). That thread then empties its ring sooner, sleeps
more often and has to be woken by an IPI more often (idle and wake-up
75 -> 118 cycles per packet). In a VM each wake-up also costs exits
that the guest does not see; this was not measured on bare metal.

With one sender and threaded NAPI, 64 B changes by -2 % to +3 %, and at
8000 B XDP_TX gains 42 %, devmap 37 % and cpumap 38 %.

Testing (x86_64, QEMU via virtme-ng, KASAN + DEBUG_VM + DEBUG_NET; the
whole series on bpf/master 4b4eb7f44ee0, and before on 05441d697f7f,
where the reproducers, kprobe path checks, devmap test and selftests
below gave the same results; patches 2-4 also on fb7bd3a2aad7; the runs
without the series on bpf/master c8a8a68d3ab4 and 05441d697f7f):
- test_run after generic XDP: send one packet through generic XDP on lo,
  then run xdp_adjust_tail; with patches 2-4 only:
  "WARNING: include/net/page_pool/helpers.h:305 at __xdp_return" from
  bpf_xdp_adjust_tail() under bpf_prog_test_run_xdp(), as in BPF CI;
  the new xdp_adjust_frags_tail_shrink_after_generic subtest hits the
  same warning; with the whole series no splat
- full ./test_progs run (with panic_on_warn=0): all xdp, xsk and veth
  tests pass and there are no page_pool or __xdp_return warnings;
  fs_kfuncs, kfree_skb, kprobe_multi_bench_attach,
  memcg_proactive_reclaim, test_ima, uprobe_syscall and
  verifier_live_stack fail the same way on 4b4eb7f44ee0 without the
  series, and rhash_timer is flaky on both kernels (it failed in 10 of
  20 runs without the series and in 14 of 20 with it)
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
  ./test_progs -t ns_xsk,xdp: all 34 tests passed, no splats, with the
  series (206 subtests, with the new one from patch 5) and without it
  (205)
- the standalone AF_XDP suite (test_xsk.sh) also runs the tests that
  test_progs skips as flaky; XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF reports
  PASS either way, but without the series dmesg shows 60 "page_pool
  leak" splats from generic XDP (bpf_xdp_adjust_tail -> __xdp_return ->
  page_frag_free on pages allocated by skb_pp_cow_data()); with the
  series there are none
- frame path: one veth bounces 8000-byte pings with XDP_TX, its peer
  trims all frags of the resulting frames (IPv6 off, so no skb touches
  the peer's rxq first); with patches 2+4 only: "page_pool leak",
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
- devmap egress after patch 4: veth redirects copied skbs through a
  devmap whose egress program trims all frags; with the series 20/20
  trimmed, all __xdp_return() calls with MEM_TYPE_PAGE_POOL, no splat,
  nothing 75s after teardown; with b3ca872947ef reverted on top of the
  series: "page_pool leak" from page_frag_free() under
  dev_map_bpf_prog_run(), VM_BUG_ON_PAGE() and a panic, hence the
  stable prerequisite in patch 4
- W=1 builds of the touched files with LLVM=1 and with DEBUG_NET=n: no
  warnings
- XDP_ADJUST_TAIL_GROW fails in DRV mode with and without the series,
  so it is unrelated
- not tested: page_pool frames from hardware drivers redirected into
  veth, bpf_xdp_pull_data(), multi-queue load

This series was prepared with an AI coding assistant (Claude) from the
v5 and v6 review threads; the assistant wrote the code changes, all of
patches 1, 3 and 5, the changelog updates, and ran the tests listed
above.


Maciej Fijalkowski (2):
  xdp: introduce xdp_convert_skb_to_buff()
  veth: update mem type in xdp_buff

Slawomir Stepien (3):
  bpf: test_run: Use a private rxq info for XDP test runs
  veth: use the frame mem type when running XDP on an xdp_frame
  selftests/bpf: Shrink test_run frags after generic XDP ran on lo

 drivers/net/veth.c                            | 56 ++++++++++++-------
 include/net/xdp.h                             | 36 ++++++++++++
 net/bpf/test_run.c                            |  9 +++
 net/core/dev.c                                | 25 ++-------
 .../bpf/prog_tests/xdp_adjust_tail.c          | 51 +++++++++++++++++
 5 files changed, 137 insertions(+), 40 deletions(-)


base-commit: 4b4eb7f44ee05754339d07e9df649809f45d14c5
-- 
2.56.0

