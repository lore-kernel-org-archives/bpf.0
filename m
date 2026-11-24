Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795499110;
	b=SW/hWYBczWZeWDi6nuRTEPkgIkT0u9qlUu7BsplCyeOb7dyOOzJvc+QenGc2DHkgA9Gs
	 Pb3QjWfgOG5tc1O7qJ5YOxQl/XbJES+vIcvDRWnj98aXTzLsv9W00HoItr9fSOsxZ5O2B
	 iMONbSLB4OYWChREgMG4ecNmgMonVVZ4ViVwxVavKHRfR35Fqn7jLtWAwF/vPU3i8cot0
	 ZTDam4HUh/yHti24KJAKv5oGUobVYJWk9l9jmoc9PXMTUMkOjUSseK7iV4q8PsONatF3L
	 9zMIyZSKvHzVi6zGxGXw/ebNMfU3XDBEJ7DynYeOjJY2OPVOJ91U4Nqm+cGxyE01wlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795499110;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=b7hzx4hdT/aWGEHT3B9cp/wHj65qJWImONpb6FDPul4=;
	b=u/zsycF9hspY3XuYZ7XsjiBKw7Hy4GmU4CrkfaJwtuPcnHxISkeXKgDWEcraWmuO+cQR
	 RcUKA/U29xeHz0+48Y2w/X0W+P0p2cOBS1HReKMuMmBlcCsM+ztr+EHS3cRZZRyqSJkxl
	 6kVbraDEalsQa+Q726Vue3vozthm1r1aMyEbSEqCROrx1vciaRtOzIqqcWxjLdHAx3Dl+
	 x78NhElnZgH31djSKArnWUCiTU6GfSxlrR5RNqKELkP0GaHA6wLgbknFiqBEItsg0yV7q
	 wPuYOB/aln6KGVgSPEgCJPSGjQHxp3OnzfuDUsnK6XTRCDbMhwbW9Sg81o5t7ITTZbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vrcodb3p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A7C606A333;
	Tue, 24 Nov 2026 05:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vrcodb3p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBA81F000C0;
	Tue, 24 Nov 2026 05:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795499110;
	bh=b7hzx4hdT/aWGEHT3B9cp/wHj65qJWImONpb6FDPul4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Vrcodb3pExD7IvnRJ++M28lf/71cgaIy6O2yMrMX+tiJ+/bLMLI4faFbjLWyK86Ks
	 46creBgmZY87nJiZm6InSM58VnczzVQRyMZ6FR9fRN8e9yyxkPHRH+5pBUvlIf6pyJ
	 CdWf5m9tTKjNw3f52dmZ/LXNNqW5esRVeGZFwh5sm7eOG9L/Ds5caUNvGYUncpvPIN
	 tSAKk/EE48riNy34lxLJwcjgyNYj+BoJC8xztgprVFN7ilYuYbY20BvyXW4nobZcuz
	 1Cza7+lCS0pN7x4ldEVOBTIFr33kuZ2WGJF7OnLEiq4/X34p8gmiYAvZYQZE+Gez9z
	 ZdRYQNxKRNRHg==
Subject:
 Re: [PATCH net v12 2/2] selftests: net: add TAP socket filter attach tests
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, weirongguang@kylinos.cn
Date: Tue, 24 Nov 2026 05:45:09 +0000
Message-ID: <179549910931.3135.4958196655811648969@kernel.org>
In-Reply-To: <20261123054209.89946-3-clementwei90@163.com>
References: <20261123054209.89946-3-clementwei90@163.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The selftest misses the half of the bug where the queue is
  left unpublished.
- [Low] None of the new tests check whether the cBPF program actually
  runs on packets.

--

selftests: net: add TAP socket filter attach tests

This commit adds kselftests in tools/testing/selftests/net/tun.c for
TUNATTACHFILTER and TUNDETACHFILTER on a multi-queue TAP device. They cover
re-attaching a queue after the original filter buffer becomes unreadable,
bad lengths and bad programs with and without attached queues, a filter
set before any queue is attached, and IFF_NOFILTER handling. Every check
is made through TUNGETIFF and TUNGETFILTER.

> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index 34de2580e32ec..ac326193867b0 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c

[ ... ]

> @@ -548,6 +550,362 @@ TEST_F(tun, reattach_close_delete)
>  	EXPECT_EQ(tun_delete(self->ifname), 0);
>  }
>  
> +/* accept: return skb->len.  Three instructions on purpose, so that the
> + * length read back through TUNGETFILTER tells it apart from a rejected
> + * program that is shorter.
> + */
> +static const struct sock_filter filter_accept[] = {
> +	BPF_STMT(BPF_LD | BPF_W | BPF_LEN, 0),
> +	BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 0),
> +	BPF_STMT(BPF_RET | BPF_A, 0),
> +};

[Severity: Low]

Do any of the new tests check that the classic filter actually runs on
packets?

filter_accept is the only valid program the tests use. It returns
skb->len, so it can never show a drop or a trim. None of the new tests
write a frame to the TAP fds or read one back.

Every assertion reads either the IFF_NOFILTER bit from TUNGETIFF or the
fprog header from TUNGETFILTER. TUNGETIFF builds that bit from its own
expression in tun_chr_ioctl():

	if (tfile->nofilter || !rcu_access_pointer(tun->cbpf_prog))
		ifr.ifr_flags |= IFF_NOFILTER;

The companion commit "tun: run the socket filter from tun_net_xmit()" adds
the execution site as a separate check in tun_net_xmit():

	prog = rcu_dereference(tun->cbpf_prog);
	if (prog && !READ_ONCE(tfile->nofilter)) {
		len = bpf_prog_run_clear_cb(prog->prog, skb);
		if (!len || pskb_trim(skb, len)) {

Would these tests still pass if tun_net_xmit() never ran cbpf_prog, ran it
on IFF_NOFILTER queues, or ignored its verdict or trim length?

The test comments say a queue "still gets the filter", "must not get the
filter", or is covered by it. reattach_filter_without_user_buffer already
says its checks "cannot tell an installed filter from no filter". That
limit applies to the other new tests as well.

A test could send a frame through a rejecting or truncating program on a
TAP queue, then read it back or confirm it was dropped. That would cover
the datapath and the IFF_NOFILTER bypass.

There is also a smaller inaccuracy. The comment above
attach_filter_clears_nofilter_queue says:

  A later TUNATTACHFILTER covers every queue of the device, including one
  that was attached with IFF_NOFILTER.

tun_attach_filter() only clears nofilter for the active queues:

	for (i = 0; i < tun->numqueues; i++) {
		tfile = rtnl_dereference(tun->tfiles[i]);
		WRITE_ONCE(tfile->nofilter, false);
	}

A queue opened with IFF_NOFILTER and then detached keeps nofilter set.
TUNGETIFF keeps reporting IFF_NOFILTER for it until TUNSETQUEUE attaches
it again. Should the comment refer to the active queues only?

[ ... ]

> +	/* The queue gets that program again, from the device */
> +	EXPECT_EQ(tun_attach(self->fd, self->ifname), 0);
> +
> +	flags = tun_get_iff_flags(self->fd);
> +	EXPECT_GE(flags, 0);
> +	EXPECT_EQ(flags & IFF_NOFILTER, 0);
> +}
> +
> +/* A program configured while no queue is attached must cover the queues that
> + * are attached afterwards.
> + */
> +TEST_F(tun, attach_filter_without_queues_then_attach)
> +{
> +	short flags = 0;
> +
> +	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
> +	EXPECT_EQ(tun_detach(self->fd2, self->ifname), 0);
> +
> +	ASSERT_EQ(filter_attach(self->fd, filter_accept,
> +				ARRAY_SIZE(filter_accept)), 0);
> +
> +	EXPECT_EQ(tun_attach(self->fd, self->ifname), 0);
> +
> +	flags = tun_get_iff_flags(self->fd);
> +	EXPECT_GE(flags, 0);
> +	EXPECT_EQ(flags & IFF_NOFILTER, 0);
> +}

[Severity: Medium]

Should attach_filter_without_queues_then_attach also check
IFF_DETACH_QUEUE after the re-attach?

The companion commit "tun: run the socket filter from tun_net_xmit()"
describes two failure modes of the old check in tun_attach(). In the
first, a failed read of the user buffer attached the queue without a
filter. In the second, "a successful read returned early and left the
queue unpublished".

reattach_filter_without_user_buffer is the only test that checks
IFF_DETACH_QUEUE. Its buffer is PROT_NONE, so it only exercises the
failed read case.

In this test filter_accept is in readable .rodata. On the baseline
kernel, TUNSETQUEUE(IFF_ATTACH_QUEUE) therefore takes the early return in
tun_attach():

	/* Re-attach the filter to persist device */
	if (!skip_filter && (tun->filter_attached == true)) {
		lock_sock(tfile->socket.sk);
		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
		release_sock(tfile->socket.sk);
		if (!err)
			goto out;
	}

That path returns 0 before tun_enable_queue() and before tun->tfiles[] is
published. TUNGETIFF then reports IFF_DETACH_QUEUE set, because
tfile->detached is still set. It also reports IFF_NOFILTER clear, because
sk_filter is set.

Doesn't that let all three assertions here pass on the unfixed kernel
while the queue stays disabled?

The final re-attach in attach_filter_bad_keeps_program_without_queues has
the same gap. That test still fails on the baseline kernel, but only
because of its earlier bad length and bad program checks.

Adding this after the tun_attach() helper call in both tests would cover
the unpublished queue case:

	EXPECT_EQ(flags & IFF_DETACH_QUEUE, 0);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123054209.89946-1-clementwei90%40163.com
