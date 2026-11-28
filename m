Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795860243;
	b=lLlNABcAWYs9uHafAQVUpr76XfHyk8DkpYRsRqPRYWndwropvO5gWFDsBLLzgelfA7c9
	 wC2LTAQx9poNftu2gNPfDoaYF/knzfkuaYAK98/+oiFSCJ8hB3wSg47Ek+totlytKKthG
	 r5DJkE220OxLMvJxRyZV/WAZ3+ltYuBYodqxR1HpCPywm0MGkn8j7bE6wsCXMgtLn9iTg
	 uewxkFOoIJQsW3y78qZLRhHp/D1Hn+5FWT4EWFQs/TVNZ9Y+DewCqYXhECS3dDtqpOZvM
	 1fICvT5f3vGTM3SJLak9Q/KO8MuvBqp3CrhUZIyAw5jUTOT42FLE76nJiDEiv7SNcYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795860243;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=AckfiB/PsuekiwntPXxRDCpzpFz7XpY97JL9ReygHEE=;
	b=FUARNHu1SgU8YhTqD5Yw+0FMCGlTYkmivmy0MBqqL3kiQA3tgw9l/4EeOzEVLtcnV2O9
	 L6Sx6qp/HMttm52pVB46jeKYGZBYllRbJBZUPBSfsRps2jB99qKtiFGIXtghyYLHZv2sO
	 OkSaSDTCz/2ejXTKtixLu+8zdgTqRAD2hg1ZyA7TAX92KRWRt3IG0hvRol3ehNTI688lr
	 zVO8jQnuQdKiNZvG5j/G37hoDgIxqsyxgwz184oXz3z/6YVncYo5wwWyANyJPwaUDTF6h
	 DEAmNckc9GvEBa75zIzodPR9lwcndKFnYl1hulgdmlo3XUaon73rPSaAt02tNzARWRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qn3MHb7i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EDE606A689;
	Sat, 28 Nov 2026 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qn3MHb7i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF3D1F0092C;
	Sat, 28 Nov 2026 10:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795860242;
	bh=AckfiB/PsuekiwntPXxRDCpzpFz7XpY97JL9ReygHEE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qn3MHb7iEK0mbwVa0j45fPpeCVJjoZw3H4QInwCsSYNblW7zUepDSO6ls7+eYPphc
	 oYmGDLIMiboIAjTgDwBjA1wtFFXT1dowtDStv4xPyGcrlQQGR0DM0YH6CR4oCP5kQQ
	 95gismR17z5gO2mISumhHcXCQpEcvssO7Yb6CTHSeqMTiTNLdBo7LQStHpaYJFm7bj
	 FSjqqsTKsL2MR9DA4nBMSXgQ4FGCKU4A+JC4kZ3J33RsA1irnd4B12t7wKjeGfO2aQ
	 XpXPi0XDBqdDgMGiXy/Q5y9eQfv+64+Y+O3moNewidUiTaHGYAebD9dX0G4lLMsMKN
	 5dZZdlJvGx/zw==
Subject: Re: [PATCH net v9 5/6] selftests/bpf: add xdp_shrink_frags
From: netdev-bot+sashiko@kernel.org
To: sst@poczta.fm
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, bpf@vger.kernel.org,
 netdev@vger.kernel.org, jiayuan.chen@linux.dev, phx0fer@gmail.com,
 maciej.fijalkowski@intel.com, tianyi@cloudflare.com, tavip@google.com,
 toke@redhat.com, aleksander.lobakin@intel.com, lorenzo@kernel.org,
 lorenzo.bianconi@oss.qualcomm.com, ihor.solodrai@linux.dev,
 andrew+netdev@lunn.ch, willemb@google.com, horms@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, memxor@gmail.com,
 emil@etsalapatis.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
Date: Sat, 28 Nov 2026 10:04:00 +0000
Message-ID: <179586024048.3135.6988798909394815405@kernel.org>
In-Reply-To: <20261127100132.1977890-6-sst@poczta.fm>
References: <20261127100132.1977890-6-sst@poczta.fm>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] None of the three subtests in
  tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c can fail on…
- [Low] The commit message lists the three subtests and then says 'A
  kernel without the fix will report "Bad page state ... page_pool…
- [Low] The comment in xdp_shrink()
  (tools/testing/selftests/bpf/progs/xdp_shrink_frags.c) says the…
- [Low] Two comments say the veth path starts from a nonlinear skb.

--

selftests/bpf: add xdp_shrink_frags

This adds a selftest with an xdp.frags program that shrinks the tail by
3000 bytes, so that bpf_xdp_shrink_data() releases a page_pool frag on the
skb-backed XDP paths. Three subtests cover generic XDP on a tap device,
the veth skb path, and a veth XDP_TX bounce to the peer, and all three
skip on systems without 4K pages.

> test_veth_tx bounces the cow'd buff with XDP_TX so the peer runs a frags
> program on the resulting frame, covering the buff -> frame -> buff path.
>
> A kernel without the fix will report "Bad page state ... page_pool leak".

[Severity: Low]
Is this true for test_veth_tx?

On the baseline kernel, the XDP_TX branch of veth_xdp_rcv_skb() already
restores the rxq mem type before the buff is converted to a frame:

drivers/net/veth.c:veth_xdp_rcv_skb() {
    ...
	case XDP_TX:
		veth_xdp_get(xdp);
		consume_skb(skb);
		xdp->rxq->mem = rq->xdp_mem;
		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
    ...
}

rq->xdp_mem comes from the MEM_TYPE_PAGE_SHARED registration, and the
xdp_tx program on LOCAL does not shrink anything.

So the frame that reaches PEER is PAGE_SHARED, and PEER's rxq is
PAGE_SHARED too. xdp_shrink on PEER then frees a plain page through
page_frag_free(), which is correct. An unfixed kernel would report nothing
for this subtest.

It looks like test_veth_tx only guards the reset that the veth skb-path fix
in this series adds to veth_xdp_get():

	/* the buff holds plain page references from here on */
	xdp->rxq->mem.type = MEM_TYPE_PAGE_SHARED;

If that reset went missing, the symptom would not be a "page_pool leak"
splat. A page whose pp was cleared would be sent down the page_pool return
path instead.

Every frame veth builds from the skb path is PAGE_SHARED. That means the
page_pool frame case handled by "veth: use the frame mem type when running
XDP on an xdp_frame" is not reached either, despite the "covering the
buff -> frame -> buff path" wording.

The series has four fixes, so "the fix" is also ambiguous. Could the commit
message say which fix each subtest covers and what failure it protects
against?

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c b/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
> new file mode 100644
> index 0000000000000..789dfdd51b579
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
> @@ -0,0 +1,288 @@

[ ... ]

> +static void test_tun(struct xdp_shrink_frags *skel)
> +{

[ ... ]

> +	n = writev(tap_fd, iov, ARRAY_SIZE(iov));
> +	ASSERT_EQ(n, sizeof(head) + sizeof(frag1) + sizeof(frag2), "writev");
> +
> +	wait_for_prog(skel);
> +	/* a buggy kernel only splats "page_pool leak", it does not fail here */
> +	ASSERT_GT(skel->bss->shrink_ran, 0, "xdp_prog_ran");

[Severity: Medium]
Can any of the three subtests fail on a kernel without the fixes?

This ASSERT_GT() is the only check here, and test_veth() and test_veth_tx()
use the same one. xdp_shrink() increments shrink_ran whenever
bpf_xdp_adjust_tail(ctx, -3000) returns 0:

	if (bpf_xdp_adjust_tail(ctx, -3000) == 0)
		__sync_fetch_and_add(&shrink_ran, 1);

That happens on fixed and buggy kernels alike. It also happens on any
linear buff longer than about 3014 bytes, where there is no frag at all.

The regression only shows up as "BUG: Bad page state ... page_pool leak"
from bad_page(). Nothing in the test reads /proc/sys/kernel/tainted or
scans kmsg, so unless the harness scans dmesg, test_progs reports PASS on
a regressed kernel.

The subtests would also keep passing, without testing anything, if a later
change to skb_pp_cow_data() or veth stopped leaving a frag after the cow.

bad_page() calls add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE) even when
its printk is rate-limited. Would it work to compare the TAINT_BAD_PAGE bit
(bit 5) of /proc/sys/kernel/tainted before and after each subtest?

Another option is for xdp_shrink() to count only when the buff had frags
before the shrink and lost one. It could compare bpf_xdp_get_buff_len()
against data_end - data to tell.

> +
> +	bpf_xdp_detach(ifindex, 0, NULL);

[ ... ]

> +/* A large ping builds a nonlinear skb that veth cow's into its page_pool. */
> +static void test_veth(struct xdp_shrink_frags *skel)

[Severity: Low]
Is the skb here actually nonlinear?

With MTU 8000 and a 5000-byte ping, __ip_append_data() puts the payload in
the linear area. paged is false because ping has no gso_size, zerocopy or
MSG_SPLICE_PAGES. Also fraglen + alloc_extra < SKB_MAX_ALLOC, so
alloclen = fraglen.

veth_convert_skb_to_xdp_buff() then cows the skb only because of the
headroom check, or because the skb is shared or its head is locked:

	if (skb_shared(skb) || skb_head_is_locked(skb) ||
	    skb_is_nonlinear(skb) ||
	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {

The skb only becomes nonlinear as a result of skb_pp_cow_data(). The file
header comment ("skb-backed XDP first cow's the nonlinear skb into
page_pool memory") has the same problem for the veth path.

If the sender ever left at least XDP_PACKET_HEADROOM of headroom, veth
would run the program on the linear skb without a cow. The 3000-byte
shrink would still succeed, and this subtest would pass without reaching
the page_pool frag path.

Could the comment describe the headroom dependency instead?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/xdp_shrink_frags.c b/tools/testing/selftests/bpf/progs/xdp_shrink_frags.c
> new file mode 100644
> index 0000000000000..5d8e26f1b3a63
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/xdp_shrink_frags.c
> @@ -0,0 +1,34 @@

[ ... ]

> +SEC("xdp.frags")
> +int xdp_shrink(struct xdp_md *ctx)
> +{
> +	/*
> +	 * Runs on both skb-backed XDP paths (generic XDP via tun, and veth):
> +	 * the nonlinear skb is cow'd into page_pool memory before we run, so
> +	 * shrinking the tail releases a whole frag that has to go back to that
> +	 * pool. The counter only tells us the program ran and the helper
> +	 * succeeded -- a linear buff returns 0 as well -- it does not prove a
> +	 * frag was released.
> +	 */

[Severity: Low]
This comment only describes the skb-backed case, but test_veth_tx() also
attaches xdp_shrink to VETH_PEER:

	if (veth_attach(ns1, VETH_PEER, bpf_program__fd(skel->progs.xdp_shrink)))

On PEER the program runs from veth_xdp_rcv_one() on the xdp_frame that
LOCAL bounced with XDP_TX, not on a cow'd skb.

By then veth_xdp_get() has switched those frags to plain page references
with MEM_TYPE_PAGE_SHARED. The released frag must go through
page_frag_free() rather than back to a pool. The comment above
test_veth_tx() itself says that freeing it "as page_pool memory" is the
bug.

Should this comment mention the frame case on PEER?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261127100132.1977890-1-sst%40poczta.fm
