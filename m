Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866668;
	b=epx/nTnkU7WnR0vqs7x0uwFnRSKo4cAIAmfoQdGrVzHmZIh4cV5HsikUUcAbSUj2MDnY
	 I+jomGv5QPkDTmWGaDffqE5GrjNflZlu9IIQ5WNzqsD5JHwRC+VDRCJCjwZi9210xIRx3
	 W0wODnN1bzsbnhit7XzVBE9AWfXozkv9HZS9SzFkUGUHMvf/DJyDp2oXdXJVDSH72jgb9
	 /uane97KFGPDlcRnUP+gMiU0vc8PiJAPSyB+X9+KId9ism18TOfgZX1j6JLSPbi+PI5r5
	 OPaf3PGxaSTMI+ADCS9hzx5IpXKxwz5j9DN+P+QARCk85Jc5FbShR/zP70z12q8mBPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866668;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 DKIM-Signature;
	bh=4PBMioCVo1HxdzOkMsiafpKfAf735c8mJv4Cx+FgbRs=;
	b=vaEr5Bw2aRhEqutrHyLTv1N3F8WudqAl0+byfjBQ9edldINvgdfYpQotGi5aDaxwul7e
	 ZqHbdwrMh6k8Se84/9/WxRSPYm3MBVNlhhHIDtga+NWZPG1bNuxqlVx9xvON102LSW9S8
	 2iw4DRnfSPrO0x7y87NKNK/FR1sGXQJOPpDlGmxBKuzpcuMWWi/NJ6Nqw3SNK6tcXwo/+
	 GKTWGRtJAfShrY24Y/1zEmusN4iBhZND8HDmyYaFMm/VjBh3WbTnQsHdkyDyJEOZaG498
	 BdwfPB27b/wJpV7plA37IJrhLuaeZKH2oe7viXA6T83GcS0n0L0KncCZgHjVna7VzNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=VaCKJ2SU;
	arc=none smtp.remote-ip=217.74.67.75
Received: from smtpo75.interia.pl (smtpo75.interia.pl [217.74.67.75])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31E7606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 08:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B31E7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=VaCKJ2SU
Received: from nr200 (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Thu,  5 Nov 2026 09:17:39 +0100 (CET)
Date: Thu, 5 Nov 2026 09:17:37 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, netdev@vger.kernel.org, bpf@vger.kernel.org,
	magnus.karlsson@intel.com, aleksander.lobakin@intel.com,
	ilias.apalodimas@linaro.org, toke@redhat.com, lorenzo@kernel.org,
	ihor.solodrai@linux.dev, tavip@google.com
Subject: Re: [PATCH v6 bpf 0/3] xdp: fix page_pool leaks
Message-ID: <auw7ofYYYwOoGH2d@nr200>
References: <20261104121316.1155680-1-sst@poczta.fm>
 <ausorQSZn/tuxUWg@boxer>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ausorQSZn/tuxUWg@boxer>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1793866663; bh=4PBMioCVo1HxdzOkMsiafpKfAf735c8mJv4Cx+FgbRs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=VaCKJ2SUpvJLmQmBXvHIBVFMeAVEmkEIi4dy9YzBvGEakUoSsXU5rf2KZ3YA0I65G
	 ai+LY7iZAGmeS4LNtjsoUtH026QJf28XCyRhwam85fJFKRYDPWFA2wxW1GrZ6a7dI0
	 ewtfVMUPAioZGMUlMJYZTH3+bIgiMzsZwuv3qe0o=

On lis 04, 2026 13:44, Maciej Fijalkowski wrote:
> On Wed, Nov 04, 2026 at 01:13:13PM +0100, Slawomir Stepien wrote:
> > v1:
> > https://lore.kernel.org/bpf/20251003140243.2534865-1-maciej.fijalkowski@intel.com/
> > v1->v2:
> > - add skb to xdp_buff converter (Jakub)
> > - postpone restoration of veth's xdp_rxq_info mem model (AI)
> > 
> > v2:
> > https://lore.kernel.org/bpf/20251017143103.2620164-1-maciej.fijalkowski@intel.com/T/
> > v2->v3:
> > - make skb->xdp_buff conversion agnostic of current skb->data position
> >   (Toke)
> > - do not pull mac header in veth (Toke)
> > - use virt_to_head_page() when checking if xdp->data comes from
> >   page_pool (Olek)
> > - add ack from Toke
> > 
> > v3:
> > https://lore.kernel.org/bpf/20251022125209.2649287-1-maciej.fijalkowski@intel.com/
> > v3->v4:
> > - include skb->head when calculating packet length (Toke, lkp)
> > 
> > v4:
> > https://lore.kernel.org/bpf/20251027121318.2679226-1-maciej.fijalkowski@intel.com/
> > v4->v5:
> > - rely again on sk_buff::pp_recycle when setting mem type on rxq
> >   (Jesper, Jakub)
> > - add ack from Toke on patch 2 and restore it on patch 1
> > 
> > v5:
> > https://lore.kernel.org/bpf/20251029221315.2694841-1-maciej.fijalkowski@intel.com/
> > v5->v6:
> > - rebase onto bpf/master
> > - patch 1: set MEM_TYPE_PAGE_POOL unconditionally in
> >   xdp_convert_skb_to_buff(); mem type only matters for frags consumed
> >   by the program, and those always come from skb_pp_cow_data() (Jakub)
> > - patch 1: add DEBUG_NET_WARN_ON_ONCE() for a non-linear skb without
> >   pp_recycle and document the expectation in kdoc (Jakub); the warning
> >   is limited to non-linear skbs since linear ones legitimately skip
> >   the CoW
> > - new patch 2: veth_xdp_rcv_one() ran the program on an xdp_frame with
> >   whatever mem type the previous packet left on rq->xdp_rxq; use the
> >   frame's mem type instead, as cpumap and devmap do. With patch 3 alone
> >   veth sends page_pool frames to its peer and the peer's program
> >   trimming frags crashed the kernel, so this comes first
> > - patch 3 (was 2): veth turns the buff into an xdp_frame on
> >   XDP_{TX,REDIRECT}, so the head is released through mem type too;
> >   keep the queue's original model unless the buffer was copied into
> >   rq->page_pool (Jakub)
> > - patch 3: take page_pool refs on compound heads via netmem helpers
> > - patch 3: do not restore the rxq mem model after XDP_{TX,REDIRECT}
> >   and on the error path; with patch 2 every path sets its own mem type
> > - patch 3: veth can now redirect MEM_TYPE_PAGE_POOL frames, which needs
> >   commit b3ca872947ef ("bpf: Use the frame mem type in devmap egress
> >   XDP") in devmap; list it as a stable prerequisite
> > - drop Reviewed-by/Tested-by tags as patches 1 and 3 changed
> 
> I mentioned the changes [0] that were developed after v5 revision yet you
> decided to go with what you had - that might be okay but to be transparent
> it would be worth stating *why* you chose not to pursue further or explore
> approach where __do_xdp_generic() is called from veth.
> 
> Was it due to semantics change pointed out by Bjorn? Or is it too big a
> hammer for fixing page_pool leaks and should be implemented as a
> follow-up?

That. For me, at this point in time it is easier to reason about the fix first rather than refactor.

> Regardless, thank you for reviving this work, I am to blame for not
> dedicating further effort here.

No worries Maciej! You did a great job and I think it is worth pushing.

> [0]: https://lore.kernel.org/bpf/20260509084858.773921-5-maciej.fijalkowski@intel.com/
> 
> Thanks,
> MF
> 
> > 
> > Hi,
> > 
> > here we fix page_pool leaks which happen when fragment is released
> > within XDP program and memory type is set incorrectly. The reports come
> > from syzbot and AF_XDP test suite.
> > 
> > Most of the changes are about pulling out the common code for
> > init/prepare xdp_buff based on existing skb and supplying it with
> > correct xdp_rxq_info's mem_type that is assigned to xdp_buff. A bit more
> > stuff, page_pool related, had to be done on veth side.
> > 
> > Originally, this work was started by Octavian Purdila and continued by
> > Maciej up to v5. Maciej then took the larger veth rework from the v5
> > review to net-next as an RFC [1]. This v6 picks up the v5 series, with
> > Maciej's agreement, as the minimal fix for bpf and stable, and addresses
> > the v5 review. Maciej stays the author of patches 1 and 3 and my changes
> > are noted in their commit messages; patch 2 is new.
> > 
> > For veth, Jakub listed three options: stop turning skbs into xdp_frames
> > in veth, decide the head's mem type when the CoW was skipped, or CoW the
> > head on the Tx/Redirect path. The first one changes veth's XDP handling
> > beyond a fix (it is what the RFC does), so patch 3 takes the second:
> > veth knows whether it just copied the buffer into rq->page_pool, and
> > only then advertises MEM_TYPE_PAGE_POOL. An skb that skipped the CoW is
> > linear and keeps the queue's original model, as before this series.
> > The two do not conflict: the RFC can go on top of this series and
> > replace the veth parts of patches 2 and 3.
> > 
> > [1] https://lore.kernel.org/all/20260509084858.773921-1-maciej.fijalkowski@intel.com/
> > 
> > Patch 2 fixes the same problem for frames in veth_xdp_rcv_one() that
> > commit b3ca872947ef ("bpf: Use the frame mem type in devmap egress
> > XDP") fixed for devmap; cpumap already handled it.
> > 
> > Testing (x86_64, QEMU via virtme-ng, KASAN + DEBUG_VM + DEBUG_NET; the
> > series ran on bpf/master fb7bd3a2aad7 and, rebased without changes, the
> > reproducers, kprobe path checks, devmap test and selftests below ran
> > again on 05441d697f7f with the same results; the runs without the series
> > on bpf/master c8a8a68d3ab4):
> > - reproducer: an xdp.frags program that trims all frags with
> >   bpf_xdp_adjust_tail() on 8000-byte pings over a 9000 MTU veth pair;
> >   without the series both generic XDP and native veth XDP hit
> >   "BUG: Bad page state ... page_pool leak" followed by
> >   VM_BUG_ON_PAGE(page_ref_count(page) == 0) and a panic; with the
> >   series 20/20 packets are trimmed with no splat
> > - native veth XDP_TX of multi-buffer packets, with and without
> >   trimming frags first (200 large + 200 small pings each), then veth
> >   teardown and a 75s wait for page_pool "stalled pool shutdown" or
> >   negative inflight warnings: none
> > - BPF selftests on bpf/master with tools/testing/selftests/bpf/config:
> >   ./test_progs -t ns_xsk,xdp: all 34 tests (205 subtests) passed, no
> >   splats, with and without the series
> > - the standalone AF_XDP suite (test_xsk.sh) also runs the tests that
> >   test_progs skips as flaky; XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF reports
> >   PASS either way, but without the series dmesg shows 60 "page_pool
> >   leak" splats from generic XDP (bpf_xdp_adjust_tail -> __xdp_return ->
> >   page_frag_free on pages allocated by skb_pp_cow_data()); with the
> >   series there are none
> > - frame path: one veth bounces 8000-byte pings with XDP_TX, its peer
> >   trims all frags of the resulting frames (IPv6 off, so no skb touches
> >   the peer's rxq first); with patches 1+3 only: "page_pool leak",
> >   VM_BUG_ON_PAGE() and a panic in veth_xdp_rcv_one(); with the whole
> >   series 50/50 frames are trimmed, kprobes show all __xdp_return() calls
> >   with MEM_TYPE_PAGE_POOL, no splat, also with IPv6 on so that skbs and
> >   frames interleave on the peer's queue; bpf/master alone passes as well
> >   since veth only sends MEM_TYPE_PAGE_SHARED frames there
> > - remaining veth paths, each confirmed with kprobes: skbs that skip the
> >   CoW (frames passed up by one veth and forwarded back into it: 1229 of
> >   1260 runs without skb_pp_cow_data(), heads from the page_pool),
> >   XDP_REDIRECT failing on the skb path (40 xdp_return_buff()) and on the
> >   frame path (40 xdp_return_frame()), XDP_PASS of 20 frames after their
> >   frags were trimmed; no splat, and none of the page_pool shutdown or
> >   inflight warnings 75s after teardown
> > - devmap egress after patch 3: veth redirects copied skbs through a
> >   devmap whose egress program trims all frags; with the series 20/20
> >   trimmed, all __xdp_return() calls with MEM_TYPE_PAGE_POOL, no splat,
> >   nothing 75s after teardown; with b3ca872947ef reverted on top of the
> >   series: "page_pool leak" from page_frag_free() under
> >   dev_map_bpf_prog_run(), VM_BUG_ON_PAGE() and a panic, hence the
> >   stable prerequisite in patch 3
> > - W=1 builds of the touched files with LLVM=1 and with DEBUG_NET=n: no
> >   warnings
> > - XDP_ADJUST_TAIL_GROW fails in DRV mode with and without the series,
> >   so it is unrelated
> > - not tested: page_pool frames from hardware drivers redirected into
> >   veth, bpf_xdp_pull_data(), multi-queue load, the full test_progs run
> > 
> > Performance (the same VM with 8 vCPUs, non-debug kernels with
> > PAGE_POOL_STATS, bpf/master fb7bd3a2aad7 with and without the series;
> > pktgen sends skbs into one end of a veth pair, the program on the other
> > end counts packets; median of 6 runs of 8s over two boots per kernel):
> > - 64-byte packets with native XDP_DROP, XDP_TX and XDP_REDIRECT (devmap
> >   to another veth), and generic XDP_DROP on 1 and 4 CPUs with 64 and
> >   8000-byte packets: within 2% of the base kernel, no regression
> > - native veth with 8000-byte packets (3 frags): XDP_TX +8.8%
> >   (0.507 -> 0.552 Mpps), XDP_REDIRECT +8.4% (0.613 -> 0.664 Mpps).
> >   Without the series veth_xdp_get() takes plain page references on
> >   the head and frags, so the pages copied into rq->page_pool are
> >   released from the pool instead of recycled (~1.2M/s
> >   rx_pp_recycle_released_ref plus slow allocations); with page_pool
> >   references they go back to the ring (~1.4M/s rx_pp_recycle_ring, no
> >   released_ref)
> > Absolute numbers in a VM differ between boots, so only the relative
> > change is meaningful.
> > 
> > This v6 was prepared with an AI coding assistant (Claude) from the v5
> > review thread; the assistant wrote the code changes, all of patch 2,
> > the changelog updates, and ran the tests listed above.
> > 
> > 
> > 
> > Maciej Fijalkowski (2):
> >   xdp: introduce xdp_convert_skb_to_buff()
> >   veth: update mem type in xdp_buff
> > 
> > Slawomir Stepien (1):
> >   veth: use the frame mem type when running XDP on an xdp_frame
> > 
> >  drivers/net/veth.c | 56 ++++++++++++++++++++++++++++++----------------
> >  include/net/xdp.h  | 36 +++++++++++++++++++++++++++++
> >  net/core/dev.c     | 25 ++++-----------------
> >  3 files changed, 77 insertions(+), 40 deletions(-)
> > 
> > 
> > base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
> > -- 
> > 2.56.0
> > 

-- 
Slawomir Stepien
