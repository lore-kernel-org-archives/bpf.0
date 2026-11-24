Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795507318;
	b=xoAIruIbTBSZsIVJDqKj8JBRYCx9zxkgQFxR0IQ+N10W75IRK/93DUqnAreqxctiwUco
	 2nz7n8rpjwzGFiu1qvRI8NfCKCvbBmknTRe2VbcMLva38NKGWBLOG50ay1GJnmZiPWis1
	 rFeJzOrvpMQyT+lNnZLGORibSpqNLKhnQ/yvPTsVVeYMkQO7G0+02SojH710zxj2A3hyH
	 S09pJxZxUBQJQsOJWNDWXFiNr7jnIPj1CmyG7xsHkY3NqZJzw32LwwWwuXSZk8Ef7GRAQ
	 cvO3qEebhmFtk/QWsRK4OMqbMdUlD7TQEbS+C3OBIIdhMeFJUaTDWECBA0QMuY53dXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507318;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=1hk9uBpP77tVS+Fe7y11eb/ZPjQfE9lY4fYSE16WzKg=;
	b=zy/wd+4qichHzZufQUhuy4pXHRwJB93j+xybO8jKBHmf7NQLrzCGABzQfzXSStMe7gYu
	 ww3VOlY6h8wTTIf4kJqt7oBPh2XnN7baU8JlSvQQ8J8/ZCdGfC3UtGVNnNu2VXE5X0uMz
	 wGtT6aqQwwo+d3EwGXiRXfXNfiVi9lMTubrJ6geQ+Ems3I3UE0gPuydbziYfQQZ9WB2Th
	 rfd9sN1u1josjb2fj/2okkJCLSIRz3SvMuYI7laQIGopnaQPXHG+vr1SPIkRg5c7i3WBL
	 ImxLSp22wgrWavDSEnv0Q+TAHuoq4BKuzT3b+NUCf+nUmlPg/yYOGR4q9gkbbcRnovg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=UIyaA7gL;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347D606A31E;
	Tue, 24 Nov 2026 08:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F347D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=UIyaA7gL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=1hk9uBpP77tVS+Fe7y11eb/ZPjQfE9lY4fYSE16WzKg=;
	b=UIyaA7gLghQWUukv6OANfAH5rkL157Wpv1LgnTB1o7XpmCWivtPE7zBBTpe/fx
	nAPmK/3g93Ti77+ocYY1xC7sETAClYFgDPQk58/8wg5aWwk3+l3kOj+tksrm4wsf
	jGr9qnHDYp91SE0qohn4g10iRvF4i/QHvlMLydZKfVkPE=
Message-ID: <47389671-2a71-4a6b-8ed3-9c1fb4de0557@163.com>
Date: Tue, 24 Nov 2026 16:00:49 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v12 2/2] selftests: net: add TAP socket filter attach
 tests
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, weirongguang@kylinos.cn
References: <20261123054209.89946-3-clementwei90@163.com>
 <179549910931.3135.4958196655811648969@kernel.org>
Content-Language: en-US
From: Rongguang Wei <clementwei90@163.com>
In-Reply-To: <179549910931.3135.4958196655811648969@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBXQSkxRAVrMfi+Hw--.23973S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3ArW7ur47Wry5Kr4fJrWxCrg_yoW3GF1xpF
	WFga45tr1vqFWUXwn7ZrWUXFy3ZrsrGF45uw1kK345uFn8ury3uay3KFWj9an3Ar4vvws0
	kF4j939xCw4DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5sqAUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4RI5pGsFRDK7EAAA3d



on 2026/11/24 13:45, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The selftest misses the half of the bug where the queue is
>   left unpublished.
> - [Low] None of the new tests check whether the cBPF program actually
>   runs on packets.
> 
> --
> 
> selftests: net: add TAP socket filter attach tests
> 
> This commit adds kselftests in tools/testing/selftests/net/tun.c for
> TUNATTACHFILTER and TUNDETACHFILTER on a multi-queue TAP device. They cover
> re-attaching a queue after the original filter buffer becomes unreadable,
> bad lengths and bad programs with and without attached queues, a filter
> set before any queue is attached, and IFF_NOFILTER handling. Every check
> is made through TUNGETIFF and TUNGETFILTER.
> 
>> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
>> index 34de2580e32ec..ac326193867b0 100644
>> --- a/tools/testing/selftests/net/tun.c
>> +++ b/tools/testing/selftests/net/tun.c
> 
> [ ... ]
> 
>> @@ -548,6 +550,362 @@ TEST_F(tun, reattach_close_delete)
>>  	EXPECT_EQ(tun_delete(self->ifname), 0);
>>  }
>>  
>> +/* accept: return skb->len.  Three instructions on purpose, so that the
>> + * length read back through TUNGETFILTER tells it apart from a rejected
>> + * program that is shorter.
>> + */
>> +static const struct sock_filter filter_accept[] = {
>> +	BPF_STMT(BPF_LD | BPF_W | BPF_LEN, 0),
>> +	BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 0),
>> +	BPF_STMT(BPF_RET | BPF_A, 0),
>> +};
> 
> [Severity: Low]
> 
> Do any of the new tests check that the classic filter actually runs on
> packets?
> 
> filter_accept is the only valid program the tests use. It returns
> skb->len, so it can never show a drop or a trim. None of the new tests
> write a frame to the TAP fds or read one back.
> 
> Every assertion reads either the IFF_NOFILTER bit from TUNGETIFF or the
> fprog header from TUNGETFILTER. TUNGETIFF builds that bit from its own
> expression in tun_chr_ioctl():
> 
> 	if (tfile->nofilter || !rcu_access_pointer(tun->cbpf_prog))
> 		ifr.ifr_flags |= IFF_NOFILTER;
> 
> The companion commit "tun: run the socket filter from tun_net_xmit()" adds
> the execution site as a separate check in tun_net_xmit():
> 
> 	prog = rcu_dereference(tun->cbpf_prog);
> 	if (prog && !READ_ONCE(tfile->nofilter)) {
> 		len = bpf_prog_run_clear_cb(prog->prog, skb);
> 		if (!len || pskb_trim(skb, len)) {
> 
> Would these tests still pass if tun_net_xmit() never ran cbpf_prog, ran it
> on IFF_NOFILTER queues, or ignored its verdict or trim length?
> 
> The test comments say a queue "still gets the filter", "must not get the
> filter", or is covered by it. reattach_filter_without_user_buffer already
> says its checks "cannot tell an installed filter from no filter". That
> limit applies to the other new tests as well.
> 
> A test could send a frame through a rejecting or truncating program on a
> TAP queue, then read it back or confirm it was dropped. That would cover
> the datapath and the IFF_NOFILTER bypass.
> 
> There is also a smaller inaccuracy. The comment above
> attach_filter_clears_nofilter_queue says:
> 
>   A later TUNATTACHFILTER covers every queue of the device, including one
>   that was attached with IFF_NOFILTER.
> 
> tun_attach_filter() only clears nofilter for the active queues:
> 
> 	for (i = 0; i < tun->numqueues; i++) {
> 		tfile = rtnl_dereference(tun->tfiles[i]);
> 		WRITE_ONCE(tfile->nofilter, false);
> 	}
> 
> A queue opened with IFF_NOFILTER and then detached keeps nofilter set.
> TUNGETIFF keeps reporting IFF_NOFILTER for it until TUNSETQUEUE attaches
> it again. Should the comment refer to the active queues only?
> 
> [ ... ]
> 
>> +	/* The queue gets that program again, from the device */
>> +	EXPECT_EQ(tun_attach(self->fd, self->ifname), 0);
>> +
>> +	flags = tun_get_iff_flags(self->fd);
>> +	EXPECT_GE(flags, 0);
>> +	EXPECT_EQ(flags & IFF_NOFILTER, 0);
>> +}
>> +
>> +/* A program configured while no queue is attached must cover the queues that
>> + * are attached afterwards.
>> + */
>> +TEST_F(tun, attach_filter_without_queues_then_attach)
>> +{
>> +	short flags = 0;
>> +
>> +	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
>> +	EXPECT_EQ(tun_detach(self->fd2, self->ifname), 0);
>> +
>> +	ASSERT_EQ(filter_attach(self->fd, filter_accept,
>> +				ARRAY_SIZE(filter_accept)), 0);
>> +
>> +	EXPECT_EQ(tun_attach(self->fd, self->ifname), 0);
>> +
>> +	flags = tun_get_iff_flags(self->fd);
>> +	EXPECT_GE(flags, 0);
>> +	EXPECT_EQ(flags & IFF_NOFILTER, 0);
>> +}
> 
> [Severity: Medium]
> 
> Should attach_filter_without_queues_then_attach also check
> IFF_DETACH_QUEUE after the re-attach?
> 
> The companion commit "tun: run the socket filter from tun_net_xmit()"
> describes two failure modes of the old check in tun_attach(). In the
> first, a failed read of the user buffer attached the queue without a
> filter. In the second, "a successful read returned early and left the
> queue unpublished".
> 
> reattach_filter_without_user_buffer is the only test that checks
> IFF_DETACH_QUEUE. Its buffer is PROT_NONE, so it only exercises the
> failed read case.
> 
> In this test filter_accept is in readable .rodata. On the baseline
> kernel, TUNSETQUEUE(IFF_ATTACH_QUEUE) therefore takes the early return in
> tun_attach():
> 
> 	/* Re-attach the filter to persist device */
> 	if (!skip_filter && (tun->filter_attached == true)) {
> 		lock_sock(tfile->socket.sk);
> 		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
> 		release_sock(tfile->socket.sk);
> 		if (!err)
> 			goto out;
> 	}
> 
> That path returns 0 before tun_enable_queue() and before tun->tfiles[] is
> published. TUNGETIFF then reports IFF_DETACH_QUEUE set, because
> tfile->detached is still set. It also reports IFF_NOFILTER clear, because
> sk_filter is set.
> 
> Doesn't that let all three assertions here pass on the unfixed kernel
> while the queue stays disabled?
> 
> The final re-attach in attach_filter_bad_keeps_program_without_queues has
> the same gap. That test still fails on the baseline kernel, but only
> because of its earlier bad length and bad program checks.
> 
> Adding this after the tun_attach() helper call in both tests would cover
> the unpublished queue case:
> 
> 	EXPECT_EQ(flags & IFF_DETACH_QUEUE, 0);
> 
The assertion is missing, yes, but I would leave the test as it is.

The early return that returns success without publishing the queue is the
code patch 1 deletes. With it gone, tun_attach() has a single success path:
returning 0 means the queue was added to tun->tfiles[] and tfile->detached
was cleared, so on the patched kernel this test cannot pass with a queue
that stayed disabled. reattach_filter_without_user_buffer() also asserts
that the queue is not left with IFF_DETACH_QUEUE after a re-attach.

Adding the check here would only guard against reintroducing the code the
series removes, so I did not include it. I'll pick it up if the series
needs another revision anyway.

