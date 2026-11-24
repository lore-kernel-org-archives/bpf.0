Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533181;
	b=i82ZifSICvYDZXGIw23dC/Z/qFDsNp5lwb/7Y54c4xhDO6pPF4OF/0HffrnJ3hBs6mSJ
	 o9MQVKDj9h610LLONrcpduEICY1GbD9XkuHgnQZsjiE/uDJgwasSsWjowH1psu5l4HsmB
	 sLMhabGMxeC8TTsFPn1rwabIFS1bnhqwmc5mueOjoMdTBszocqond1R9/rkMYorpKTUQK
	 po2YHzihB7JofWoKpzo1yN+uuaE7gTrVbOHPGhB/m1jWlMSwepPXFt8oJOmLRYxn2QDPv
	 cbb7tWTadOvJqP5zZ0IPr/xA2lCI/SX5yb19SwBuyF6f4HW3VlbF6dm9/2q1g8YYJsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rwg2yD1zJeOjWk9k6blison6UKKrmu+SCF2d3nY+2Pc=;
	b=mFz9g3++fC0sZYJbHziaJdXo0hAFMeIJ4EyRNZUOQ/KJz5KXYSVRjf+5s+ENureRfi1J
	 InWEcFaor5Y0q+r45EBxsBQBUYoUOpoL7SR4RrGX3QeId25kTQJl1L7Vk43Wmh31kBx4M
	 jll8rJFcVqe4Vqi8DGzDOkuXd0C7L6uvVxpm6VUEBFMyr9B6ipGBfbz27KM69iEp9enDa
	 YuMWurpbKnDjH+/GeXE9wJ7+dMEOKYw1RM8VB3PJUqV4bM/vayzxu4a4uzgt8BR1Fx1af
	 +LgqvDC9gLk6DtZ6LopKqY1yVJHiYAzvaxBVdrP7Fd+wAJZzWZDjogjDPe/+7P938hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=aqSip14k;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EF4606A33C
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 15:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88EF4606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=aqSip14k
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so36284025e9.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 07:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795533179; x=1796137979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rwg2yD1zJeOjWk9k6blison6UKKrmu+SCF2d3nY+2Pc=;
        b=aqSip14kJuwOstw9v1SSzcUqfxbfcSSU1+YaNCeXU7kbwhBBGtPWSlwIMRuIbzfuaL
         ERWULgL2sqSxy9m2yB+GHEnsgz3v7oetNbCl6qWvpij49i+MgesFHx2us+4u8WbGCzbC
         8MdAf1/yl+uFdGCt0rDcvBAJNnYIvfPq9/QUn56gdyJ1Tv+TJzVS41ZJrW03dFgMhQpH
         qwRObwBamonPdZl0dllqDtMgJjVNKthhu+GfWx0ANFoD8+gvJBtNaCRR2hq9nPvwV2OC
         J3pcAgmbg+0PA27wvo6+P2r8s7NL5AD8NHYpc0Rp6ak9nmEFCWtPJnJppLAf3dTMnWd/
         rOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795533179; x=1796137979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rwg2yD1zJeOjWk9k6blison6UKKrmu+SCF2d3nY+2Pc=;
        b=C3BUHKiaHOt6CLw0dEN2FQ9jLxZSBS0ZyvhUAZWfTbqpx+RmSJYVVO+m57sPUoIT2X
         QY1IXnCsbvl0+2B3QWwcbezugX9lWxd/UVPqyonD/d9mg0BqTm772Olc2E8yIHR7SSH+
         mIWjmgl6FAzHLVrvRGPnFaNLiBciwVq12TbcsmwBFMe/TkPofdPM7MFLnJPcL/HJM1cI
         AfUoBLbEmoTfhnLG5aDp8fCiVJ2MLPTqfLWg39mArpr+XnZk09JdQ68VPIkQSjWvjWZJ
         kZ9u8wMIXeCd17ZFI+Wk3YxpwOzK4VfXQO3AtlHzEcE7vF/kjj96gZitRpye22vq9goW
         Cxow==
X-Gm-Message-State: APuU4Z/w/0PHAbSf8v7tR6yUAZgrLKuT7cvLiuYP+84YXf5R/376e15Y
	Es6Xksx41AJszyrN+YcuR7QlFc8opduZfmnfLqeEMF16bzUgDWrS71u+cukBoajY39i19UI7iHD
	EY0AfIk7CyQ==
X-Gm-Gg: AZFdTZf3q75hrDa+x3krbY0zRU9jCStpBGVYFOH2soaBdl6rnfZ2MzpCUJwxjZNPB+e
	ZqhWuyBmYzEIhcqdON+M8Ws8OYG2AUU+shHdTCQ3ZYZw1FyQZFaizxJ2IFkhqM1rYQPVG1MPX7T
	cpEgl3ffeJiL/ecx2wBEQ7qAlPfBdphBjbcKIsfEbNl/UjRmauiLdw+MwzCmi74eLIsr/5wlDoW
	F+dwg2zgpFVGAeaLKIkD0mumICNZavXI9V6STMgtYd3yyE0Zknjnt3MoHvh8RbT6POmKDTExqFQ
	hjOhzmkPqT0xJpReUM8EImzRMe97XKgQJBDlwhB3jzEtrJMBqYuEd4soeNvUE8FwlFKiA10AV+J
	3LkiKntH2Oto6sC2KqTqD1Holz0ugRj2fgwsvhtX/C0bpww11Q6EdOOXH28GQPkURJzwCtINNjB
	aFDuTtDHn4tFgiO//Us6CG8ge0jjly8z+AjK0/+AMWa879r6W0mY9wW0ZmqcXf8/2zcYK8C4Ujf
	b62B442bwJcC3YTJDPfuQ+bnKd6BN57DuwXcC+WL4Yt++3LkDo4/FcvTXsqU81iIeXMWZQ+qkey
	g+c7DLju+uXdPJp5GCJkg4z0jVnhWHllEhb5oRAgdwSdioxcddw=
X-Received: by 2002:a05:600c:a086:b0:4af:c210:5b3f with SMTP id 5b1f17b1804b1-4bb88817ef1mr320282735e9.24.1795533178500;
        Tue, 24 Nov 2026 07:12:58 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6bc8ce06sm27944396f8f.47.2026.11.24.07.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:12:58 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH RFC bpf-next 0/4] bpf: add bpf_sk_assign support on netkit egress
Date: Tue, 24 Nov 2026 17:12:40 +0200
Message-ID: <20261124151244.1423343-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
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

Hi,
This RFC narrows the earlier egress series [1] to netkit's transmit
path. NETKIT_PASS queues the assigned skb directly to the peer's
receive backlog. NETKIT_REDIRECT clears the assignment before forwarding.

General TC egress support would require changes across the networking
stack. Many transmit paths rely on skb->sk and skb->destructor for
send-side ownership and socket write-memory accounting, and would need
to handle an assigned socket reference in place of the transmit owner.

There is a new sk_assign_skb added to bpf_net_context that is used to
record the exact skb netkit is running BPF on, bpf_sk_assign uses that
identity to allow egress assignment for that skb. It is valid only when
the new kern_flags bit is set, that is used to avoid always initializing
it to NULL in bpf_net_ctx_set.
A nested tc egress program running on a clone still gets -EOPNOTSUPP.

This series builds on Daniel's work [2] to steer netkit traffic to a
transparent proxy in the receiving namespace. The receive backlog can
outlive the transmit path's RCU read-side section, so the skb takes its
own socket reference even for SOCK_RCU_FREE listeners.

The selftests exercise the new netkit sk assign for both IPv4/IPv6 and
TCP/UDP.

Feedback is most welcome, more importantly if the approach taken in
patch 03 is acceptable.

Changes since the original posting:
 - Use a new approach to limit the egress sk assign only to netkit
 - Reduce the number of selftests
 - Drop some unnecessary fixes of pre-existing problems

Pre-existing problems found during reviews that will be dealt with
separately:
   - Receive lookup could use a prefetched socket whose protocol, family
     or network namespace did not match the packet
   - GRO via gro_cells can merge an assigned skb after tunnel
     decapsulation and discard its socket reference without calling the
     destructor
   - When a reuseport program rejects an assigned UDP socket, receive can
     report an error pointer as rx_sk to the kfree_skb tracepoint
   - A generic XDP program, an rx_handler or a classic mirred action on
     the receiving device can forward the assigned skb to another network
     namespace. Generic XDP can also drop the assignment when it copies
     the skb, so the packet falls back to normal socket lookup
   - nsim_forward_skb() queues the skb for napi_gro_receive() without
     orphaning it. GRO can discard its socket reference when merging it

Thanks,
 Nik

[1] https://lore.kernel.org/bpf/20261119142231.2612515-1-razor@blackwall.org/
[2] https://github.com/cilium/linux/commits/pr/bpf-tproxy


Nikolay Aleksandrov (4):
  net: track references owned by prefetched socket assignments
  bpf: preserve owned socket assignments on ingress redirects
  bpf: support bpf_sk_assign in netkit tx path
  selftests/bpf: test netkit socket assignment to a transparent proxy

 drivers/net/netkit.c                          |  10 +
 include/linux/filter.h                        |   4 +
 include/net/inet6_hashtables.h                |  10 +-
 include/net/inet_hashtables.h                 |  10 +-
 include/net/netkit.h                          |  15 ++
 include/net/request_sock.h                    |  10 +-
 include/net/sock.h                            |   4 +-
 include/uapi/linux/bpf.h                      |   9 +-
 net/core/filter.c                             |  50 ++++-
 net/core/sock.c                               |   7 +
 net/netfilter/nf_queue.c                      |  16 +-
 tools/include/uapi/linux/bpf.h                |   9 +-
 .../bpf/prog_tests/sk_assign_netkit.c         | 189 ++++++++++++++++++
 .../selftests/bpf/progs/sk_assign_netkit.c    |  95 +++++++++
 14 files changed, 412 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_assign_netkit.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_assign_netkit.c

-- 
2.47.3

