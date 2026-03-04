Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6068B18A92F
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772606236; cv=none; b=Gt8Fzj1D10qN5PBDczfdaI1zMFFAVHhyboorhfBkNyeELfzPLoA0RovH744Whb63BVQzr4VHuy+YhJmqhCTtEkessrlq+dTXI2DjbyPdszz+zK4FygI3Ul+6qu+oUFDaLPVE7bKjKApDsMNyyA7tOpuqaXpPjCj1F6Wrne/wRdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772606236; c=relaxed/simple;
	bh=C+GWh0X/x+E8K8Heufepk3oNTNdSdcGqi5B/uREcWyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B94y+TURcgga30wI0BeSVmdgA1iSBmvQFfk551x1uEOvnWzgA5qJ18wD+Y9Kj9jcl09HerxtvjXBDa5wQXB6srH+GcAT+XUu5UbMzQtWMpJ2ReudiRC251X4MOOsS2PPmAHKWjjQ1Fppm+aI+qVEVNNYwoJiF5imvFHMtOw6aLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dSdIUZn/; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dSdIUZn/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772606232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BezM0d3Efmj5Mb5nol+0YNAjnV5cCAH9C7KVaf9ncPM=;
	b=dSdIUZn/Je1e4TEMSMz6sz+HWz+Z67hLlAtKW/MRyVywEMHOVKjHo/LTFV+CR0iPzbus5U
	7SEeOmQamZI4V90SkQbQamxfBYQsMQCgKvpvG5qUExT1RlLbxEE4uCNGgwmpx0z7Mgvb9v
	mW3Cf0vE+qmUXg97JEPoKMATXtCr9IU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Michal Luczaj <mhal@rbox.co>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 0/7] bpf/sockmap: add splice support for tcp_bpf
Date: Wed,  4 Mar 2026 14:33:51 +0800
Message-ID: <20260304063643.14581-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Starting from Go 1.22.0, TCPConn implements the WriteTo interface [1],
which internally uses the splice(2) syscall to transfer data between
file descriptors [2].

However, for sockets with sockmap enabled, sk_prot is replaced with
tcp_bpf_prots which does not provide a splice_read callback. When data
is redirected to a socket's psock ingress queue via bpf_msg_redirect,
splice(2) cannot read from it because the splice path has no knowledge
of the psock queue. This causes TCPConn.WriteTo to return 0 bytes,
effectively breaking Go applications that rely on io.Copy between TCP
connections when sockmap/BPF is in use [3].

The simplest fix would be registering a splice callback that just calls
copy_splice_read(), but this results in redundant copies (socket -> kernel
buffer -> pipe -> destination), which defeats the purpose of splice.

Patch 1 adds splice_read to struct proto and sets it in TCP.
Patch 2 adds inet_splice_read and uses it in inet_stream_ops.
Patch 3 refactors tcp_bpf recvmsg with a read actor abstraction.
Patch 4 adds basic splice_read support for sockmap, but this still
involves 2 data copies.
Patch 5 optimizes the splice implementation by transferring page
ownership directly into the pipe, achieving true zero-copy. Benchmarks
show performance on par with the read(2) path.
Patch 6 adds splice selftests. Since splice can seamlessly replace read
operations, we redefine read to splice in the existing selftests so
that all existing test cases also cover the splice path.
Patch 7 adds splice to the sockmap benchmark, which also serves to
verify the effectiveness of our zero-copy implementation.

Benchmark results with rx-verdict-ingress mode (loopback, 8 CPUs):

  read(2):                  ~4292 MB/s
  splice(2) + zero-copy:    ~4270 MB/s
  splice(2) + always-copy:  ~2770 MB/s

Zero-copy splice achieves near-parity with read(2), while the
always-copy fallback is ~35% slower.

[1] https://github.com/golang/go/blob/master/src/net/tcpsock.go#L173
[2] https://github.com/golang/go/blob/fdf3bee/src/net/tcpsock_posix.go#L57
[3] https://github.com/jschwinger233/bpf_msg_redirect_bug_reproducer

Jiayuan Chen (7):
  net: add splice_read to struct proto and set it in tcp_prot/tcpv6_prot
  inet: add inet_splice_read() and use it in
    inet_stream_ops/inet6_stream_ops
  tcp_bpf: refactor recvmsg with read actor abstraction
  tcp_bpf: add splice_read support for sockmap
  tcp_bpf: optimize splice_read with zero-copy for non-slab pages
  selftests/bpf: add splice_read tests for sockmap
  selftests/bpf: add splice option to sockmap benchmark

 include/linux/skmsg.h                         |  12 +-
 include/net/inet_common.h                     |   3 +
 include/net/sock.h                            |   3 +
 net/core/skmsg.c                              |  34 ++-
 net/ipv4/af_inet.c                            |  15 +-
 net/ipv4/tcp_bpf.c                            | 227 +++++++++++++++---
 net/ipv4/tcp_ipv4.c                           |   1 +
 net/ipv6/af_inet6.c                           |   2 +-
 net/ipv6/tcp_ipv6.c                           |   1 +
 .../selftests/bpf/benchs/bench_sockmap.c      |  57 ++++-
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  28 ++-
 .../bpf/prog_tests/sockmap_helpers.h          |  62 +++++
 .../selftests/bpf/prog_tests/sockmap_strp.c   |  28 ++-
 13 files changed, 421 insertions(+), 52 deletions(-)

-- 
2.43.0

