Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.63
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516827;
	b=wyM/IkkS/Qabpchtui10/Xnmf7D++tTtMvetZHzdJ4Ug7hGiDaOxZx19q/JSMdbasioF
	 XW+WcM865E9GOr7eP8VM3h5jqDpz1YrPgKnDHbeLckgcDQslWPW68LYFnHyhksdrnRTxG
	 v5Wtw2TuPukk2k1XOVoXpCwZJo4+KKSPjL5p22n0HlOAjNZi/ZAWJ69UjY8X8+D/aTKqe
	 08dRz/VlYVT4ue4ih+XUk+KOvcRSyR2hLQlqeP8tunowZVdwK3zT7rPDRlErmmap2DqZo
	 VunPgoWYgMYtRlcYKQJsTpQ8oADK0I6q77kevWVE5WUorD+Jd8HKTe9Itm/dcR4C3Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516827;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:DKIM-Signature;
	bh=QM+r5B2AS8lrMdE+QswO5UC9oEDxXR/4o359p6UdgBU=;
	b=du3iCY31hpXcG7uSlrEqKU1s31jkaQq7x3qhSTUqzG4wnROvmYJjL+yTHIB2bpA//QXZ
	 OfTjbRNpNxkQssUkrW8mUWtFy2QGnTFSpdzIeKP8EdQ6hDy6oJxgwP5kw3hO2JZL2LgOz
	 nYeebUhk+/yzZuMN9dj4oex7PFCU7f+e87g7usX98MREwuaQBHR8jlhmpx7vwp+UFRxTB
	 6vGys2SxwfseVQJi1eZNElvSh1/ybVhFbAVQMUPbD3HfClsyuDhLSK/dduBmLbuA+eTny
	 MP/vBGs0fAxSMbPZtGKz2+TLyei+gEh2KoD9DMk3CCN2dAA+NYCFbhIO9UoNA9XfU8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=bD9wnS6f;
	arc=none smtp.remote-ip=217.74.67.63
Received: from smtpo63.interia.pl (smtpo63.interia.pl [217.74.67.63])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C44606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 10:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07C44606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=bD9wnS6f
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Tue, 24 Nov 2026 11:40:19 +0100 (CET)
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
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
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
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH v8 bpf 0/7] xdp: fix page_pool leaks
Date: Tue, 24 Nov 2026 11:40:09 +0100
Message-ID: <20261124104016.532341-1-sst@poczta.fm>
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
	t=1795516823; bh=QM+r5B2AS8lrMdE+QswO5UC9oEDxXR/4o359p6UdgBU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=bD9wnS6f/HtMz0WDiDfU8sBi3cQOI8AHfxGV+IuzU9n/z93J8raEjjC2b0rt9hOxG
	 tJVJJ2B2B1DjrM9LOAn81Z/URgFs4WYLqDZLBwk9XpKj+rAWlp3JhlBzb3J4ym5q3T
	 I8vlSe393NAS/YNV2KHZWqym+BmG2S1pK6zaivqc=

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

v7:
https://lore.kernel.org/bpf/20261119133032.2015656-1-sst@poczta.fm/
v7->v8:
- rebase onto bpf/master
- new patch 2: test_run wrote frag_size = PAGE_SIZE into the rxq info
  of lo's queue 0, where it stays after the test run. Generic XDP on lo
  then let bpf_xdp_adjust_tail() grow a frag up to the end of its page,
  but frags from skb_pp_cow_data() can be sub-page page_pool chunks, so
  the program could write into the next chunk. With ingress_ifindex the
  private copy from patch 1 took frag_size of the target queue instead,
  usually 0, and growing frags failed. Set frag_size = PAGE_SIZE on the
  private copy only (Sashiko)
- new patch 7: selftests for both cases of patch 2
- patch 1: say why there is no Fixes: tag and why it goes to stable
  together with patch 3 (Sashiko, checkpatch)
- patch 3 (was 2): describe that the wrong mem type can lead to a
  use-after-free, not only to a "page_pool leak" report; explain the
  6.4.x stable range; reword the kdoc: the mem type stays set on the
  rxq info, and a caller that may release the head through it, e.g. by
  converting to an xdp_frame, has to set the type that matches the
  head; describe the xdp_frame callers in the commit message (BPF CI)
- patch 3: drop the "# ..." notes after Octavian's and Maciej's
  Signed-off-by lines (Sashiko, checkpatch); Co-developed-by stays
- patch 4 (was 3): keep Fixes: 718a18a0c8a6, frames with frags reach
  veth_xdp_rcv_one() only since that commit (BPF CI, Tianyi)
- patches 1, 5, 6, 7: put the opening /* of multi-line comments on its
  own line (Sashiko)
- patch 6 (was 5): wrap lines at 80 columns

Hi,

here we fix page_pool leaks which happen when fragment is released
within XDP program and memory type is set incorrectly. The reports come
from syzbot and AF_XDP test suite. With page checks enabled (e.g.
CONFIG_DEBUG_VM) the wrong release shows up as a "page_pool leak";
without them, a page that page_pool still uses can be freed, which can
lead to a use-after-free.

Most of the changes are about pulling out the common code for
init/prepare xdp_buff based on existing skb and supplying it with
correct xdp_rxq_info's mem_type that is assigned to xdp_buff. A bit more
stuff, page_pool related, had to be done on veth side.

Originally, this work was started by Octavian Purdila and continued by
Maciej up to v5. v6 picked up the v5 series, with Maciej's agreement, as
the minimal fix for bpf and stable, and addressed the v5 review. Maciej
stays the author of patches 3 and 5 and my changes are noted in their
commit messages; patches 1, 2, 4, 6 and 7 are new.

For veth, Jakub listed three options: stop turning skbs into xdp_frames
in veth, decide the head's mem type when the CoW was skipped, or CoW the
head on the Tx/Redirect path. The first one changes veth's XDP handling
beyond a fix, so patch 5 takes the second: veth knows whether it just
copied the buffer into rq->page_pool, and only then advertises
MEM_TYPE_PAGE_POOL. An skb that skipped the CoW is linear and keeps the
queue's original model, as before this series. This keeps the series a
minimal fix that is easy to reason about and to backport.

Patch 4 fixes the same problem for frames in veth_xdp_rcv_one() that
commit b3ca872947ef ("bpf: Use the frame mem type in devmap egress
XDP") fixed for devmap; cpumap already handled it.

Patch 1 prepares bpf_prog_test_run_xdp() for patch 3. Generic XDP runs
on the rxq info of the device queue, which is shared with test_run; with
patch 3 alone, any packet through generic XDP on lo makes later
multi-buffer test runs free their frags as page_pool pages. Restoring
the mem type after generic XDP would still race with test runs on other
CPUs, so test_run gets its own copy, like devmap and cpumap. Patch 1
has no Fixes: tag since nothing changes the shared mem type before
patch 3, but it has to be backported together with patch 3.

Patch 2 fixes the other field test_run wrote into the shared rxq info,
frag_size; it is an existing bug, so it has its own Fixes: tag. It is a
separate patch to keep patch 1 a pure prerequisite of patch 3.

Performance: compared to v7, only test_run, comments and selftests
changed; the veth and generic XDP code is the same. The numbers and
their explanation are in the v7 cover letter:
https://lore.kernel.org/bpf/20261119133032.2015656-1-sst@poczta.fm/

Testing of v8 (x86_64, QEMU via virtme-ng, KASAN + DEBUG_VM + DEBUG_NET,
bpf/master cbaaeff649b7):
- patch 7 without patch 2 (on v7): the lo subtest grows a frag of a
  generic XDP packet on lo after a test run (bpf_xdp_adjust_tail()
  returns -EINVAL for the too large offset instead of -EOPNOTSUPP), and
  the ingress_ifindex subtest cannot grow the test_run frags (XDP_DROP
  instead of XDP_TX, size 9000 instead of 9010); with the whole series
  both pass
- ./test_progs -t ns_xsk,xdp: all 34 tests passed, no splats, 208
  subtests (206 in v7)
- full ./test_progs run (with panic_on_warn=0): all xdp, xsk and veth
  tests pass and there are no page_pool or __xdp_return warnings;
  fs_kfuncs, kfree_skb, kprobe_multi_bench_attach,
  memcg_proactive_reclaim, test_ima, uprobe_syscall and
  verifier_live_stack fail the same way without the series, and
  rhash_timer is flaky on both kernels, as in v7;
  timer_stress_nmi_update hung in one of two runs; it triggers a
  lockdep report about the obj_hash lock taken in NMI (debugobjects),
  outside the code this series touches, with v7 as well

Testing of v7 (base 4b4eb7f44ee0), still valid for the unchanged code of
patches 3-5; see the v7 cover letter for the details:
- reproducer: an xdp.frags program that trims all frags with
  bpf_xdp_adjust_tail() on 8000-byte pings over a 9000 MTU veth pair;
  without the series both generic XDP and native veth XDP hit
  "BUG: Bad page state ... page_pool leak" followed by
  VM_BUG_ON_PAGE(page_ref_count(page) == 0) and a panic; with the
  series 20/20 packets are trimmed with no splat
- the standalone AF_XDP suite (test_xsk.sh): without the series dmesg
  shows 60 "page_pool leak" splats from generic XDP; with the series
  there are none
- frame path: one veth bounces 8000-byte pings with XDP_TX, its peer
  trims all frags of the resulting frames; with patches 3+5 only:
  "page_pool leak", VM_BUG_ON_PAGE() and a panic in veth_xdp_rcv_one();
  with the whole series 50/50 frames are trimmed and no splat
- the remaining veth paths and devmap egress after patch 5, each
  confirmed with kprobes; no splat, and none of the page_pool shutdown
  or inflight warnings 75s after teardown
- not tested: page_pool frames from hardware drivers redirected into
  veth, bpf_xdp_pull_data(), multi-queue load

This series was prepared with an AI coding assistant (Claude) from the
v5, v6 and v7 review threads; the assistant wrote the code changes, all
of patches 1, 2, 4, 6 and 7, the changelog updates, and ran the tests
listed above.

Maciej Fijalkowski (2):
  xdp: introduce xdp_convert_skb_to_buff()
  veth: update mem type in xdp_buff

Slawomir Stepien (5):
  bpf: test_run: Use a private rxq info for XDP test runs
  bpf: test_run: Keep frag_size on the private rxq info
  veth: use the frame mem type when running XDP on an xdp_frame
  selftests/bpf: Shrink test_run frags after generic XDP ran on lo
  selftests/bpf: Grow test_run and generic XDP frags after a test run

 drivers/net/veth.c                            |  57 ++++--
 include/net/xdp.h                             |  38 ++++
 net/bpf/test_run.c                            |  15 +-
 net/core/dev.c                                |  25 +--
 .../bpf/prog_tests/xdp_adjust_tail.c          | 191 ++++++++++++++++++
 .../test_xdp_adjust_frags_tail_grow_lo.c      |  25 +++
 6 files changed, 309 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_adjust_frags_tail_grow_lo.c


base-commit: cbaaeff649b7aa09170cb31db001e5468c2726c0
-- 
2.56.0

