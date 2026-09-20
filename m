Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4792F3C07;
	Sun, 20 Sep 2026 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938081; cv=none; b=qfPbM0NTU6XAYtArQNce6A/G+CqOZj4blWE6D9KELiHP7/VgEODc5xsiaIv/Q3CJBcYo7ZoroDG+5nDb7YpW+odoRip5/sVpvJmEofjwlMo4gzphw4hyxkvCb3ShjfL5spt4KPb7cRQwMNEO6VRP5LL1QDL4uEAWknnb4PY5eIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938081; c=relaxed/simple;
	bh=lu/NTm6cxk4GFQfaeHH1pmv71VcOXDDSpCWZhEKlgaw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hQqX5OwtDWE2Hee9q879DHjUv5gPR38Tua7QYUMbN6NH/OQlgvSp/bWH4B+9E38jD5a3T3QOe7bW1FQf6S8/Hun1jiEWARmyohajC5L0HuN57JFQ5Dpu9Ukjow80ETLrH4d7u6glmg7wVZmIDIvNP42HI4d3iDxEx65q3ywdtaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfisFl30; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfisFl30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AC51F000FF;
	Sun, 20 Sep 2026 21:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789938079;
	bh=3W1p1k7TMU+snbpcdtGYoLU8pWAIw+of9fM9R/xz/cE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HfisFl30bJEOw6xyGAlrcqnDZ2tptSpbPNUPCGU/s6L+ZrU/VGFmJwmDXpoSR7y+5
	 kk6WY6q0tp08bxKJ10W/OoddWMLsssV4fm6iW38wupwzi+CgJNNAdwrfvQFb3BZ+I2
	 PVpO26hb72FNVha7LmWBwJBBTvYVSGvKvOgMgsqhm+4ebV45agbNhC9ydNWAxTXGj8
	 y/NC+iI+N5N7/CUSXQtgTPD60eTFHyRQe32u2PPNxtHMKsraeD3OIcXQoO/3gEHTJx
	 qbJPnoN6N8Kl6Gb3PVslvL4XBw1Fb/wBv6+Pfx1FM2fC9DmxiuzXnXksb0QXx7bzCt
	 KdZQ6ERtXfxaA==
Content-Type: multipart/mixed; boundary="===============8009789460764158187=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <386c023dc4bca44689253b97a3f71c7758d9a320a014cb12e21562cba72a3443@mail.kernel.org>
In-Reply-To: <20260920195633.3033620-5-kuniyu@google.com>
References: <20260920195633.3033620-5-kuniyu@google.com>
Subject: Re: [PATCH bpf-next 4/7] tcp: Split out __tcp_set_rcvlowat().
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@google.com,ncardwell@google.com,willemb@google.com,ukyab@berkeley.edu,cleger@meta.com,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 20 Sep 2026 21:01:17 +0000 (UTC)

--===============8009789460764158187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> In the enqueue path, tcp_data_ready() is always called after
> the hooks in tcp_queue_rcv() and tcp_ofo_queue().

Does this "always" claim hold for every enqueue-side hook site?

Looking at the callers of tcp_queue_rcv() in net/ipv4/tcp_input.c:

  - tcp_data_queue() -> tcp_data_ready() at line 5709,
    but only if (!sock_flag(sk, SOCK_DEAD))
  - tcp_rcv_established() fast path -> tcp_data_ready() at line 6694
  - tcp_send_rcvq() (line 5565, TCP repair, tp->repair_queue == TCP_RECV_QUEUE)
    calls tcp_queue_rcv(sk, skb, &fragstolen) at line 5601 but never calls
    tcp_data_ready() or sk->sk_data_ready() at all

And there's a third enqueue hook site the message doesn't mention:
bpf_tcp_ops_enqueue_rcvq() in tcp_fastopen_add_skb()
(net/ipv4/tcp_fastopen.c:284), which also has no following tcp_data_ready().

So wakeup == false doesn't always mean "a wakeup happens later" on the repair
and TFO paths. There's no functional regression since neither tcp_send_rcvq()
nor tcp_fastopen_add_skb() signalled the reader before this series either, and
the later commit 0390d95e0979c explains the tcp_fastopen_add_skb() case.

Could the changelog be more precise about which paths it covers? Perhaps naming
tcp_data_queue()/tcp_rcv_established() specifically, and noting that
tcp_send_rcvq()/tcp_fastopen_add_skb() have no reader to wake?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35535082194
--===============8009789460764158187==--
