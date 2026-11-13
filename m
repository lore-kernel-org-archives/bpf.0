Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559513;
	b=437JLw677RClorNwQ4tuYHV85Yu2huTIp5z4RTEeki9RNjr7ElYUFdgH7f0ZuMT6TxG4
	 sNxpFN97d8UOckA7MXul/kMw8AxqJFihhZmJmwlSyj2briREo27uAB/N154t2Hekr/VjZ
	 xblr+cbVL+8wml1d0K3JSJ8acEBn5YdPTn6OOiO9CNbCkCsYC/6Ki1CqJVgBNqvgajsE/
	 N9t62c1r9H5bz6GQx1FllgYdw8v0coKahd3GG18/SleY5giCz+lykAfOcLYkH+myQqeyR
	 wglaNyRTfTjBnc9XWHlwYOFxkUqkDKV9B5pHt4T8REApKefdt7KutIvp9HwYzaezj0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559513;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:DKIM-Signature;
	bh=5B4YlwMMqdlMz8j2fd4NhB7kceWbrnYxW8cbEQS8dDI=;
	b=5b/4Lr71W18ODDLeK/YhrwQ9ezbV/IVI/XPYXAZTLGKFGamsrB+IwRWc5eXOStI9Tle+
	 ZvTUfxsZ2nQBv+5qSjgmZdcJPY9/BYEaCtkDiR+XkK7nDIEr9ISSAOH4RtYpNlgDU5EgM
	 VOmkK5BMk2DYAh7GURFYTwiJF7J9wJvHegpyrW+hebKF7UA4oORW/rH0lCw1TF1XHC7kU
	 SkeoCH8ONA4PNPb1co7+cu4G6v6rPr4jH3vRpUpoCbw5lYTx++Rc/lI+nf3SaQJPiotyQ
	 ZuEyVCFmCzjKI+A1iD7nEsRb3mrga39bEfQ64m3kQ4wQgwvdPPTTDcRlA3nkSwQzQ5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b="mPnXGe/j";
	arc=none smtp.remote-ip=217.74.67.75
Received: from smtpo75.interia.pl (smtpo75.interia.pl [217.74.67.75])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9390606B365
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 08:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9390606B365
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=mPnXGe/j
Received: from nr200 (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Fri, 13 Nov 2026 09:44:59 +0100 (CET)
Date: Fri, 13 Nov 2026 09:44:57 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Tianyi Gao <tianyi@cloudflare.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"huangjie . albert" <huangjie.albert@bytedance.com>
Subject: Re: [PATCH RFC net-next v2 0/4] xdp: reuse generic skb XDP handling
 for veth
Message-ID: <avbOCfunJ252ZlJB@nr200>
References: <20261110101941.1059662-1-sst@poczta.fm>
 <avMSs9oopzc1SAnw@boxer>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avMSs9oopzc1SAnw@boxer>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1794559503; bh=5B4YlwMMqdlMz8j2fd4NhB7kceWbrnYxW8cbEQS8dDI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=mPnXGe/jT93c2XFqUqO8VnwCirp9DDzNl3GliRhTonov31fhcRD4WiO9gg7KdMenX
	 1vGYF9gIzNxApm3514+vEFa4hgkp9Fl+6taXQ6Y/j14WIPdeJ+zGkyuBaFQPrQ0Wrn
	 2Jy6bu1fZ1rqdt1XDuz43NrVJpJA3dWKJ5McGIrM=

On lis 10, 2026 13:48, Maciej Fijalkowski wrote:
> On Tue, Nov 10, 2026 at 11:19:37AM +0100, Slawomir Stepien wrote:
> > Hi,
> > 
> > this is v2 of Maciej's RFC [1], which makes veth run XDP on skb-backed
> > packets through the generic skb XDP path instead of converting them
> > into xdp_frames for XDP_TX and XDP_REDIRECT. The patches are Maciej's;
> > I addressed the review of v1 and measured the performance, which was
> > the main open question there. Changes I made are noted in [sst: ...]
> > lines in each commit message.
> > 
> > The motivation is unchanged: veth pins the skb data with plain page
> > references (veth_xdp_get()) to build an xdp_frame from an skb, and the
> > rxq memory type it reports does not match memory that was copied into
> > a page_pool, which makes the AF_XDP selftests splat when a program
> > shrinks a multi-buffer packet. With this series, pages copied into
> > veth's page_pool are recycled (0 rx_pp_recycle_released_ref, was
> > ~4.8M/s in the benchmark below).
> > 
> > Dependencies
> > ============
> > 
> > The series applies to net-next with these two net series applied
> > first (prerequisite-patch-id below):
> > 
> >  - Tianyi Gao, "net: fix mac_len of skbs copied by generic XDP" (1/2)
> >    [2]. Without it, cpumap redirect of skbs that veth copied drops
> >    every packet once veth uses the generic path.
> >  - Vladimir Oltean, "net: pass the XDP action to generic_xdp_tx() for
> >    tracing" and "net: validate xmit skbs in generic_xdp_tx()" [3].
> >    Patch 2/4 changes the same function.
> > 
> > Changes in v2
> > =============
> > 
> > 1/4: MEM_TYPE_PAGE_POOL_OR_SHARED renamed to MEM_TYPE_MIXED (Björn);
> >      comment on what the type means.
> > 2/4: Rebased on Vladimir's series. The redirect callers in devmap and
> >      filter still return success: generic_xdp_tx() frees and counts a
> >      failed skb itself, so propagating the error would free it twice
> >      (Björn asked why the error is not propagated).
> > 3/4: One skb_needs_xdp_cow() predicate for generic XDP and veth
> >      (shared, cloned, nonlinear or headroom too small) instead of a
> >      per-caller callback and INDIRECT_CALL_2 (Jakub). The
> >      skb_head_is_locked() check is gone, it would copy every locally
> >      generated skb. Copies go to the caller's page_pool with
> >      skb_pp_cow_data() also for programs without frags support (found
> >      by the xdp_metadata selftest).
> > 4/4: Commit message describes how XDP_TX/XDP_REDIRECT change for
> >      skb-backed packets (Björn's table). A failed skb XDP_TX is counted
> >      once, in the device's tx_dropped (Sashiko). veth sets
> >      skb->mac_len before running generic XDP, as
> >      __netif_receive_skb_core() does; without it cpumap redirect of
> >      veth skbs is dropped.
> 
> That looks sane.
> > 
> > Performance
> > ===========
> > 
> > QEMU/KVM, 8 vCPUs, minimal config without debug options. pktgen sends
> > skbs into veth v0, the XDP program runs on the peer v1 (skb path).
> > Packets/s delivered to the destination, median of 12 runs of 8 s over
> > 4 alternating boots per kernel, 95% bootstrap confidence intervals
> > within about +-2%. Base: v7.4-rc1+ (f66469d9905b) with the
> > dependencies above.
> > 
> >                               64 B                      8000 B (3 frags)
> >   XDP_TX                      4.49 -> 4.04 Mpps (-10%)  2.25 -> 1.87 (-17%)
> >   REDIRECT devmap -> veth     4.30 -> 3.95 (-8%)        2.18 -> 1.81 (-17%)
> >   REDIRECT cpumap             4.49 -> 4.47 (0%)         2.02 -> 2.27 (+12%)
> >   XDP_DROP (native veth)      5.65 -> 5.42 (-4%)        2.82 -> 2.71 (-4%)
> >   XDP_DROP (xdpgeneric)       5.63 -> 5.83 (+4%)        2.94 -> 3.00 (+2%)
> > 
> > (cpumap 8000 B base: base without Vladimir's series, which does not
> > touch that path; 3 of the 12 runs of the other base kernel stalled.)
> > 
> > cpumap avoids the skb -> xdp_frame -> skb round trip. XDP_TX and
> > devmap redirect to veth are slower for two reasons:
> > 
> >  - no bulking: one ndo_start_xmit() per skb instead of ndo_xdp_xmit()
> >    with up to 16 frames;
> >  - at 8000 B the receiving veth copies the packet a second time.
> >    Before, it got an xdp_frame; now it gets an skb with frags, and
> >    nonlinear skbs are always copied (kprobe on skb_pp_cow_data(): 1
> >    copy per packet before, 2 after).
> > 
> > Vladimir's validation itself costs about 3% at 64 B on these two
> > paths and nothing measurable elsewhere.
> > 
> > Questions
> > =========
> > 
> >  - Is the XDP_TX/devmap regression acceptable for the simpler and
> >    correct memory handling, or should it be fixed first? Options we
> >    see: skb-list bulking in the generic TX path (Jesper measured +30%
> >    with xmit_more), and not copying nonlinear skbs whose frags are
> >    already page_pool pages. Raising veth's needed_headroom (Jesper)
> >    only helps linear skbs from senders that honour it; pktgen skbs are
> >    shared and always copied, so the benchmark above cannot show it.
> >    We left all three for follow-ups.
> 
> Thanks for these tests, for some reason my local benchmarks were not
> showing such differences and also xmit_more was not giving me much of a
> bump.

Do you still have the method you used for your tests? Can we compare our approaches?

> The impact is noticeable I'd say. Could you see how xmit_more change would
> affect the benchmarks?

It will not (tested). The "problem" is that I was running tests that run on just one cpu with
softirq NAPI. That would cause one skb handling at a time, so there is nothing to batch - poll will
always see one skb. 

On threaded NAPI (with batching in place) the results are better, but I guess this is not an excuse
to allow regression in the other case.

I'm looking now into making sure that my tests are correct and checking how I could reduce these
regressions somehow.

> >  - MEM_TYPE_MIXED vs. separate memory types per source (Jesper).
> >  - The redirect semantics change in 4/4 (Björn).
> > 
> > Testing
> > =======
> > 
> > Each commit builds with W=1 without new warnings, checkpatch --strict is
> > clean. test_progs -t ns_xsk,xdp passes; test_xsk.sh shows the same DRV
> > XDP_ADJUST_TAIL_GROW failures (also with busy poll) as without the
> > series. Reproducers for shrinking frags in generic and veth XDP, XDP_TX
> > of multi-buffer packets, devmap egress programs and bpf_prog_test_run
> > after generic XDP on lo pass without kernel warnings.
> > 
> > The scripts, kernel configs and raw logs behind the numbers and tests
> > above are in [4], with instructions to rerun them.
> > 
> > AI disclosure: the review changes, the tests and the benchmark were
> > prepared with help from an AI coding assistant (Claude); I reviewed
> > and tested all changes.
> > 
> > [1] https://lore.kernel.org/all/20260509084858.773921-1-maciej.fijalkowski@intel.com/
> > [2] https://lore.kernel.org/all/20261103200036.65764-3-tianyi@cloudflare.com/
> > [3] https://lore.kernel.org/all/20261030114753.185281-1-vladimir.oltean@nxp.com/
> > [4] https://github.com/s-stepien/xdp-rfc
> > 
> > Thanks,
> > Slawomir
> > 
> > Maciej Fijalkowski (4):
> >   xdp: add mixed page_pool/page_shared memory type
> >   xdp: return status from generic_xdp_tx()
> >   xdp: split generic XDP skb handling
> >   veth: use generic skb XDP handling
> > 
> >  drivers/net/veth.c        | 191 +++++++++-----------------------------
> >  include/linux/netdevice.h |  33 ++++++-
> >  include/net/xdp.h         |   1 +
> >  net/core/dev.c            | 122 ++++++++++++++++++------
> >  net/core/filter.c         |   7 ++
> >  net/core/xdp.c            |  54 ++++++++++-
> >  6 files changed, 222 insertions(+), 186 deletions(-)
> > 
> > 
> > base-commit: fa5196392691051963726787944db872420dfa75
> > prerequisite-patch-id: 7db3107f14b28c509845871045e6af93b7e267bc
> > prerequisite-patch-id: 40350101232837c5a38ba1662825228d01734b39
> > prerequisite-patch-id: 0b57f8c2a409470b1ddf8df747d906d5d3dbd9f3
> > -- 
> > 2.56.0
> > 

-- 
Slawomir Stepien
