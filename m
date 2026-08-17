Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93715440A3C;
	Mon, 17 Aug 2026 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985535; cv=none; b=Rk9Dz8gzJaUIuox5Ca6NjRP5dvfYInu0NKjtcrqmOSHq9nrUgnZLJ7zBceXzbOc58bEoNUh8A4xFuIFEaDC/4HiRIJyL8RIjL+DJwCm/Sn3uXLmX/xOOkSk9M9zo6euc5lnAQFor11luNUwUYjOu/FyI9H0SmnMkVlfrFRRLgf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985535; c=relaxed/simple;
	bh=VoaoQ92q+saodbE8falTgUiJpsvtvTHX5ukkQpbeUlo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oUhpTx9eLSXREuriNIj+Kw8axCyDkLU16ugH3lNEbjcxSBHrtRosocUHmzqudJNNtx9yYrHPZN0AanLjP9FjolPAh67v6eiL2HMa/Qss8FKskyfdT9jwych1m7bz+i60mcMG+UY+NWALVxOe3/z+xVHaL00HppGAqNoEb/ZXsGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKdYEBZ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKdYEBZ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329421F000E9;
	Mon, 17 Aug 2026 16:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786985533;
	bh=8+UcCa/3P7jbV6kfhmVgCwmoF9vTHEa/FZXXfAd8rgE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GKdYEBZ6WYTn/tsSaUwX3PMm0xstzLVNpaJhnoE7P7XYOGU/ihDQGg1vHpNdb3sf4
	 o+yr2r41gSRD1OpGND5o1RIZ+OLt1Tnp4oSsAwSr9+PyXteBOulZVCtNReYRMkaHCZ
	 pDPjR+f2NjukSDNLlV0yDkW2PMvmAwFGvtu5BVr6I2LLfLVH5aLY9dRrFnH/d3yBPU
	 0bP0KItJCSzUSMJxljnwVgvKq8bRJupWYyRytwKy/j3da+j9YQQrPmfuI2CLSbPcjs
	 cMwzyTPyySUvOCKNDUZSw5vqwwj0/3I2xoukCFYJPgYX60jcniqS+7vZErIuxJb9sZ
	 c7jj90twn3bxQ==
Content-Type: multipart/mixed; boundary="===============0453003590258171134=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a3b7fa69a751733385d988051afe4955f318ccf622e7f0496016a7e47ff64983@mail.kernel.org>
In-Reply-To: <20260817155009.232670-3-zirajs7@gmail.com>
References: <20260817155009.232670-3-zirajs7@gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Cover strparser self-pass forward allocation
From: bot+bpf-ci@kernel.org
To: zirajs7@gmail.com,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev
Cc: davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,andrii@kernel.org,eddyz87@gmail.com,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,rhkrqnwk98@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 16:52:12 +0000 (UTC)

--===============0453003590258171134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
> index 1d7231728eaf..c7ad21d0bbf4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
> @@ -1,5 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <error.h>
> +#include <linux/inet_diag.h>
> +#include <linux/netlink.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/sock_diag.h>
>  #include <netinet/tcp.h>
>  #include <test_progs.h>
>  #include "sockmap_helpers.h"
> @@ -460,6 +464,171 @@ static void test_sockmap_strp_parser_reject(void)
>  	test_sockmap_strp__destroy(strp);
>  }
>
> +/* Read sk_forward_alloc through inet_diag meminfo. */
> +static int sockmap_strp_get_fwd_alloc(int sock, int *fwd_alloc)
> +{
> +	struct sockaddr_storage local = {}, peer = {};
> +	struct sockaddr_in *local_in, *peer_in;
> +	socklen_addr_len = sizeof(local);
> +	char buf[1024];
> +	struct {
> +		struct nlmsghdr nlh;
> +		struct inet_diag_req_v2 req;
> +	} req = {
> +		.nlh = {
> +			.nlmsg_len = sizeof(req),
> +			.nlmsg_type = SOCK_DIAG_BY_FAMILY,
> +			.nlmsg_flags = NLM_F_REQUEST,
> +			.nlmsg_seq = 1,
> +		},
> +		.req = {
> +			.sdiag_family = AF_INET,

sockmap_strp_get_fwd_alloc() takes an arbitrary socket fd but hardcodes
.sdiag_family = AF_INET and casts the sockaddr_storage results of
getsockname()/getpeername() to struct sockaddr_in * without checking
local.ss_family.

For an AF_INET6 socket it would build a request from IPv4-shaped fields of
an IPv6 address and then fail the exact lookup, returning -ENOENT and
causing a confusing test failure rather than a wrong-family diagnostic.

This matters because every other subtest in this file is parameterised over
AF_INET and AF_INET6 (test_sockmap_strp_pass(AF_INET6, ...) etc.), so this
helper is a candidate for reuse in the v6 direction.

Could the helper derive sdiag_family/idiag_src/idiag_dst from ss_family, or
reject a non-AF_INET socket explicitly?

> +			.sdiag_protocol = IPPROTO_TCP,
> +			.idiag_ext = 1 << (INET_DIAG_MEMINFO - 1),
> +			.idiag_states = ~0U,
> +			.id.idiag_cookie = {
> +				INET_DIAG_NOCOOKIE,
> +				INET_DIAG_NOCOOKIE,
> +			},
> +		},
> +	};
> +	int diag_fd, ret, err = -ENOENT;
> +
> +	if (getsockname(sock, (struct sockaddr *)&local, &addr_len))
> +		return -errno;
> +	addr_len = sizeof(peer);
> +	if (getpeername(sock, (struct sockaddr *)&peer, &addr_len))
> +		return -errno;
> +
> +	local_in = (struct sockaddr_in *)&local;
> +	peer_in = (struct sockaddr_in *)&peer;
> +	req.req.id.idiag_sport = local_in->sin_port;
> +	req.req.id.idiag_dport = peer_in->sin_port;
> +	req.req.id.idiag_src[0] = local_in->sin_addr.s_addr;
> +	req.req.id.idiag_dst[0] = peer_in->sin_addr.s_addr;
> +
> +	diag_fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC,
> +			 NETLINK_SOCK_DIAG);
> +	if (diag_fd < 0)
> +		return -errno;

A subsystem pattern flags this as potentially concerning: the new subtest
adds an undeclared kernel-config dependency on the INET socket-monitoring
interface and turns its absence into a test failure rather than a skip.

socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG) fails with EPROTONOSUPPORT
when sock_diag is unavailable, and when inet_diag/tcp_diag is not built in
(or is a module that cannot be auto-loaded) inet_diag_lock_handler() /
__sock_diag_cmd() reply with NLMSG_ERROR, which this helper maps to
-EINVAL. Either way, the ASSERT_OK(err, "sockmap_strp_get_fwd_alloc") at
test_sockmap_strp_self_pass_fwd_alloc() reports a failure that has nothing
to do with the sockmap/strparser behaviour under test.

CONFIG_INET_DIAG and CONFIG_INET_TCP_DIAG do not appear in
tools/testing/selftests/bpf/config or any of the per-arch config fragments.
They only default to y from net/ipv4/Kconfig, and are tristate, so a base
config with =m and no installed modules, or =n, breaks the subtest.

Should the config symbols be added to tools/testing/selftests/bpf/config,
or should the code detect the missing capability and call test__skip() with
a reason?

[ ... ]

> +/* Test strparser SK_PASS delivery to the same socket. */
> +static void test_sockmap_strp_self_pass_fwd_alloc(void)
> +{
> +	struct test_sockmap_strp *strp = NULL;
> +	char snd[4 * 1024];
> +	int c = -1, p = -1;
> +	int fwd_alloc;
> +	int sndbuf = sizeof(snd);
> +	int zero = 0;
> +	char rcv;
> +	int sent, recvd;
> +	int map;
> +	int err;
> +
> +	memset(snd, 0xa5, sizeof(snd));
> +
> +	strp = test_sockmap_strp__open_and_load();
> +	if (!ASSERT_OK_PTR(strp, "test_sockmap_strp__open_and_load"))
> +		return;
> +
> +	map = bpf_map__fd(strp->maps.sock_map);
> +	err = xbpf_prog_attach(bpf_program__fd(strp->progs.prog_skb_parser_one),
> +			       map, BPF_SK_SKB_STREAM_PARSER, 0);
> +	if (err)
> +		goto out_destroy;
> +
> +	err = xbpf_prog_attach(bpf_program__fd(strp->progs.prog_skb_verdict_pass),
> +			       map, BPF_SK_SKB_STREAM_VERDICT, 0);
> +	if (err)
> +		goto out_destroy;
> +
> +	err = create_pair(AF_INET, SOCK_STREAM, &c, &p);
> +	if (!ASSERT_OK(err, "create_pair"))
> +		goto out_destroy;
> +
> +	err = xsetsockopt(c, SOL_SOCKET, SO_SNDBUF, &sndbuf, sizeof(sndbuf));
> +	if (err)
> +		goto out_destroy;
> +
> +	err = xsetsockopt(p, SOL_SOCKET, SO_RCVBUF, &sndbuf, sizeof(sndbuf));
> +	if (err)
> +		goto out_destroy;
> +
> +	err = xbpf_map_update_elem(map, &zero, &p, BPF_NOEXIST);
> +	if (err)
> +		goto out_destroy;
> +
> +	sent = send(c, snd, sizeof(snd), MSG_DONTWAIT);
> +	if (!ASSERT_EQ(sent, sizeof(snd), "send"))
> +		goto out_destroy;
> +
> +	recvd = recv_timeout(p, &rcv, sizeof(rcv), MSG_DONTWAIT,
> +			     IO_TIMEOUT_SEC);
> +	if (!ASSERT_EQ(recvd, sizeof(rcv), "recv_timeout") ||
> +	    !ASSERT_EQ(rcv, snd[0], "data mismatch"))
> +		goto out_destroy;

Does anything here confirm that the one-byte parser actually split the 4 KB
write into many strparser messages?

Reading a single byte and comparing it to snd[0] succeeds identically
whether the stream parser/verdict programs took effect or not (a plain TCP
socket returns the same byte). The only other assertion is sk_forward_alloc
>= 0, which is trivially true when no self-pass clone was ever charged.

If the setup silently stops exercising the path -- for example, a future
change rejects a parse verdict of 1, the parser attach becomes a no-op for
some reason, or the messages end up on the psock backlog and are dropped --
the subtest degrades into a tautological pass and stops guarding the fix.

> +
> +	err = sockmap_strp_get_fwd_alloc(p, &fwd_alloc);
> +	if (!ASSERT_OK(err, "sockmap_strp_get_fwd_alloc") ||
> +	    !ASSERT_GE(fwd_alloc, 0, "sk_forward_alloc"))
> +		goto out_destroy;

Can the asserted condition (sk_forward_alloc >= 0 while self-pass strparser
clones are queued) fail on a fixed kernel?

With the fix, sk_psock_skb_ingress_self_assign() does:

    if (settle_fwd_alloc) {
            sock_owned_by_me(sk);
            if (!sk_rmem_schedule(sk, skb, 0))
                    return -EAGAIN;
    }
    skb_set_owner_r(skb, sk);

sk_rmem_schedule(sk, skb, 0) reserves only ceil(deficit / PAGE_SIZE) pages,
leaving sk_forward_alloc in [0, PAGE_SIZE). skb_set_owner_r() then calls
sk_mem_charge(sk, skb->truesize) for the full clone truesize.
net/strparser/strparser.c gives every one of the ~4096 one-byte messages a
skb_clone() of the original 4 KB skb, so truesize is ~4.8 KB per clone.

Therefore, after every single clone charge, sk_forward_alloc is negative
(roughly -(truesize - PAGE_SIZE) .. -truesize) on the fixed kernel too.

The assertion only passes because the one recv() of 1 byte fully consumes
the first message, and kfree_sk_msg() -> consume_skb() -> sock_rfree()
uncharges exactly one truesize, cancelling the last charge and leaving
sk_forward_alloc in [0, PAGE_SIZE).

Any clone charged between that recv() and the inet_diag read makes the
sampled value negative and the subtest fails even though the kernel is
correct. Two realistic ways that happens:

1. Deferred strparser work. tcp_bpf_recvmsg_parser() calls tcp_data_ready()
while holding lock_sock() when sk_receive_queue is non-empty
(net/ipv4/tcp_bpf.c) -- exactly the behaviour the comment at the top of
this file already documents for sockmap_strp_consume_pre_data().
strp_data_ready() then queue_work()s the parse, which runs after recv()
returns and charges more clones.

2. psock backlog. If any one ingress attempt returns -EAGAIN
(sk_rmem_schedule() failing under memcg or global tcp_mem pressure -- the
test intentionally piles ~20 MB of clone truesize onto one socket), the skb
is queued on psock->ingress_skb and from then on every message is charged
asynchronously by sk_psock_backlog(), potentially after the recv().

Could the test sample something that is monotone with respect to the bug
instead: drain all 4 KB (so every clone is uncharged), or re-read/poll
until the value settles, or assert on a value that the fixed kernel
guarantees at all times?

> +out_destroy:
> +	test_sockmap_strp__destroy(strp);
> +	if (c >= 0)
> +		close(c);
> +	if (p >= 0)
> +		close(p);
> +}
> +
>  void test_sockmap_strp(void)
>  {
>  	if (test__start_subtest("sockmap strp tcp pass"))
> @@ -482,4 +651,6 @@ void test_sockmap_strp(void)
>  		test_sockmap_strp_dispatch_pkt(AF_INET, SOCK_STREAM);
>  	if (test__start_subtest("sockmap strp parser reject pkt mod"))
>  		test_sockmap_strp_parser_reject();
> +	if (test__start_subtest("sockmap strp self pass fwd alloc"))
> +		test_sockmap_strp_self_pass_fwd_alloc();
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32045036810
--===============0453003590258171134==--
