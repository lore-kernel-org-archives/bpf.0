Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9FC42E435;
	Thu, 27 Aug 2026 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858392; cv=none; b=dhjbmGgpdYBvOy6/cdr244kJYuE9PUiOzJoMNIP6nFz1EbVXaDjR/SC1EeXnGuHOgAaM6kWGnxDr90M4qwUWBFFuC2N8V8NYiOJxr7NPEmh3VnSEd+IAlNT+viT5huIIrYpjgypMdUyo6aCFdyBEFUB7069PdqKkEhsfcE9cL5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858392; c=relaxed/simple;
	bh=rLGsBlyHFqJgMnY6x6sqSDrwb7eyBlIKFHSnVpGOYCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CB/+3HB49ts/SWJ79x7UiwZyJyTPIsSy6GthKGbzaeH/PYs9IIiJ0oCn3p7WktQ4XnegKgoAH5F5yJ19bFyRDdMAbyw4QyL3QLZ+7na/7PCn6JIc2pZc2xf2er3onG99SCgKIK6LOEljenVx/XKCPz7/4wi1zpJbEOvuWhvDSWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9d3wjCc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9d3wjCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDEC1F000E9;
	Thu, 27 Aug 2026 19:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787858391;
	bh=BjNabrfEquVWKaCHfvPeXL5yetMhzyRSgkqbwCF3qgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b9d3wjCcrdTDi1HtOgCyHrdSi1C6/Oir0Ipzalc+EWR1oH5I9gYjulKd7M6Fx4swC
	 P+aleYchvmfrK94b/yqZmPNAgqUqr0RoHIjgEQEQb+LqEQVeOdjNoc66mtDJt+5AN9
	 UC0H3ntHGFl5YuXIhEcM9fm5qSjyehtXhwurKOYsIJS0kXoNIO67Fi34rNvS3VzzJB
	 weCf2nTQPZ5qeUHKBqF33aJ2wMpqEfIrLykRGnm02eASByEk+X1G5hsMgYIBJPbtaS
	 nLGPhpVRgiotED3vkFZKgSVktopmKpbPSzyPFLx+LCenbuoZUCNw2WENhl7gdt7GSk
	 bcLqJF6YzWZig==
From: Jakub Kicinski <kuba@kernel.org>
To: jiayuan.chen@linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	horms@kernel.org,
	martin.lau@linux.dev,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	kuniyu@google.com,
	liuhangbin@gmail.com,
	krikku@gmail.com,
	mkarsten@uwaterloo.ca,
	toke@redhat.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: add xdp_shrink_frags
Date: Thu, 27 Aug 2026 12:19:46 -0700
Message-ID: <20260827191946.4007873-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824030705.266049-2-jiayuan.chen@linux.dev>
References: <20260824030705.266049-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
selftests/bpf: add xdp_shrink_frags

Adds a new test_progs test with two subtests (tun and veth) that attach an
xdp.frags program shrinking the tail by 3000 bytes so a whole frag is
released.  The intent is to reproduce a page_pool frag being freed with the
wrong memory type on skb-backed XDP paths.

Two questions below about what the test actually observes.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c b/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
> new file mode 100644
> index 0000000000000..f3d8a84a6dc9c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
> @@ -0,0 +1,163 @@

[ ... ]

> +/*
> + * Similar to flow_dissector.c: writev() an IFF_NAPI_FRAGS tap to build a
> + * nonlinear skb (sized for 4K pages, like xdp_adjust_tail.c) that tun runs
> + * through do_xdp_generic().
> + */
> +static void test_tun(struct xdp_shrink_frags *skel)
> +{
> +	__u8 head[74], frag1[2048], frag2[2048];

[Severity: Medium]
Is the 74 + 2048 + 2048 byte frame guaranteed to still be nonlinear when the
program runs on kernels with PAGE_SIZE larger than 4096?

skb_pp_cow_data() in net/core/skbuff.c bounds the linear head by the page
size:

	max_head_size = SKB_WITH_OVERHEAD(PAGE_SIZE - headroom);
	...
	size = min_t(u32, skb->len, max_head_size);
	...
	for (i = 0; i < MAX_SKB_FRAGS && off < skb->len; i++) {

With PAGE_SIZE 16384 or 65536 the whole 4170-byte frame fits in the head, so
the frag loop body never runs and the xdp_buff has no frags.

tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c handles this by
branching on getpagesize():

	int page_size = getpagesize();
	...
		if (page_size == 65536)
			test_xdp_adjust_frags_tail_grow_64k();

Would a getpagesize() branch or skip be appropriate here too, given that
config.aarch64 is shipped in the bpf selftests?

[ ... ]

> +	n = writev(tap_fd, iov, ARRAY_SIZE(iov));
> +	ASSERT_EQ(n, sizeof(head) + sizeof(frag1) + sizeof(frag2), "writev");
> +
> +	usleep(100 * 1000);
> +	ASSERT_GT(skel->bss->shrink_ran, 0, "xdp_prog_ran");

[Severity: Medium]
Can this subtest distinguish a buggy kernel from a fixed one?

The failure mode the commit message names ("Bad page state ... page_pool
leak") is produced by bad_page() in mm/page_alloc.c, with the reason string
set in page_bad_reason():

	if (unlikely(page_pool_page_is_pp(page)))
		bad_reason = "page_pool leak";

bad_page() is a static void that only emits pr_alert()/dump_page()/
dump_stack() and then:

	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);

No error is propagated back to bpf_xdp_adjust_tail(), writev() or ping, and
the test does not read /proc/sys/kernel/tainted, scan kmsg, or look at
page_pool inflight statistics.

So the assertions here (bpf_xdp_attach, the writev length, and shrink_ran)
all succeed identically on a kernel with and without the fix.  Would it make
sense to add an observable oracle (taint bit, kmsg scan, or page_pool
stats), or alternatively to state in the commit message that this is a splat
generator requiring manual dmesg inspection?

[ ... ]

> +static void test_veth(struct xdp_shrink_frags *skel)
> +{

[ ... ]

> +	SYS_NOFAIL("ip netns exec " VETH_NETNS
> +		   " ping -q -s 5000 -c 3 -W 1 " VETH_LOCAL_IP);
> +
> +	ASSERT_GT(skel->bss->shrink_ran, 0, "xdp_prog_ran");

[Severity: Medium]
The same two concerns apply here.  The ping runs under SYS_NOFAIL and the
only assertion is shrink_ran > 0, so nothing observes whether the released
frag went back to its page_pool.

Additionally, the frag layout of a ~5 KB ping through an 8000-MTU veth is
decided by the sender's SG/GRO behaviour rather than by the test.  If the
skb ends up with a single frag larger than 3000 bytes, the shrink happens in
place and no page is released at all.

On large-PAGE_SIZE kernels veth_convert_skb_to_xdp_buff() takes the other
branch after the COW leaves no frags:

	if (skb_shinfo(skb)->nr_frags) {
		...
		xdp_buff_set_frag_pp(xdp);
	} else {
		xdp_buff_clear_frags_flag(xdp);
	}

which bypasses the frag-release code entirely.

> diff --git a/tools/testing/selftests/bpf/progs/xdp_shrink_frags.c b/tools/testing/selftests/bpf/progs/xdp_shrink_frags.c
> new file mode 100644
> index 0000000000000..62e3791ac81d9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/xdp_shrink_frags.c
> @@ -0,0 +1,23 @@

[ ... ]

> +	/*
> +	 * The program is loaded with BPF_F_XDP_HAS_FRAGS (xdp.frags), so a
> +	 * nonlinear skb entering generic XDP is cow'd into page_pool memory
> +	 * before we run. Shrinking the tail far enough releases at least one
> +	 * whole frag, which must be returned to its page_pool. Count only a
> +	 * successful shrink so a too-small frame (e.g. ARP) does not satisfy
> +	 * the test.
> +	 */
> +	if (bpf_xdp_adjust_tail(ctx, -3000) == 0)
> +		__sync_fetch_and_add(&shrink_ran, 1);

[Severity: Medium]
Does a return value of 0 here really imply a frag was released?

bpf_xdp_adjust_tail() in net/core/filter.c only enters the frag path when
the buffer is nonlinear:

	if (unlikely(xdp_buff_has_frags(xdp))) { /* non-linear xdp buff */
		if (offset < 0)
			return bpf_xdp_frags_shrink_tail(xdp, -offset);
	...
	xdp->data_end = data_end;

	return 0;

A purely linear buffer takes the bottom path and also returns 0, so
shrink_ran gets incremented without bpf_xdp_shrink_data() ever running.
That seems to contradict the comment's claim that only a genuine
frag-releasing shrink is counted.

Would asserting somewhere that the buffer actually had frags (for example
comparing ctx->data_end - ctx->data against the total frame length) make the
counter mean what the comment says?
