Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795320858;
	b=4nlegT0KM/FNmmc9efr9sh3yzbYLSosZQjk3SnxpZ8JOx1scBYgOE5UlwnhDqFlHoA7D
	 qIeViXGp9EMCxcW+8qxjJpWMKTESbKvL1fMuFl+f52UEBHtXHpauw3LS5q4A2d1UMS/ni
	 CSiEp2t0NpK+3iVqJqGOeVmqQjo1ZQwSliOCjVEGLPnDHMeSEUtqpDeHkDjcsf46MR1GS
	 aC39ApMB96bay9KMBrCOmokFSGJDcRZAdOs0dpQhWz0DwWNF14OGNndfmm16AvETfmP17
	 3mXi03FeeQ1gIi3588T4Ob/Wyc/CCaaYF3TLJOjYYMofXleWjswsIRQtRSNao9VMgPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795320858;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ovhfiZCiK2Bm+u0ZTIh1E/1dbAZEVus4SnOMTgCTbrg=;
	b=4LBrkRZVRy0pTLL7a1ZJZGIJUv6/fEXylny396d8Vu4yaz1mLV/bKe7C/azxpByckpVw
	 6kR+RXXvWGta+s9VYeIFEv/CJYAUAmCIhGIEV/g80IVExdZtaQZ0UYS9cZyjjIDqy80JL
	 ZrjwFcnQ7kuu9GbmJLNG/uzHH/uxVvcDjj/B90GflzB8qJj7pERWKwMNTe5DQYOIf+Dyi
	 p9ayUy81QN/rYLhZC/jEEzcWp/IVgTBXTIeJgtlVXiciM+N/+Y6JKA8ff/kWnsslygCmh
	 zNrNLBy55MgZ7gPvOtYSavJ8hAJjCnWIUPSF4Oa1H3w9qeC1Vs1L/tC7I3fjvqZ8tfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="qmRc/TEC";
	arc=none smtp.remote-ip=91.218.175.168
Received: from mta0.migadu.com (out-168.mta0.migadu.com [91.218.175.168])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E471606A32A
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 04:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E471606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qmRc/TEC
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=H3duOZOezSAvkuuzvi1NeX54BSSVFIMmojI8WBcgCT8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795320855; v=1; x=1795925655;
 b=qmRc/TECqXbMJE0Yq15LydImnMtjR6cZ8pjNiHoiHlRnjtWns1iRhcKRFHS7P1TohoJWbMEi
 oJBpjGe+UgiogqHN9SvgwFB6N8dSPAs+IUSl4NYR+thjyHTBQV/AmbklxDdaZgKx0SmdoroZBgF
 pbo2Ic/6NwL83kDIgEXHWcXU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8150b656d19c1e71;
	Sun, 22 Nov 2026 04:14:15 +0000
X-Mizu-Trace-ID: 8150b656d19c1e71
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Junseo Lim <zirajs7@gmail.com>,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Leon Hwang <leon.hwang@linux.dev>,
	Yuqiang Sun <izaiahsun@gmail.com>,
	Peter Oskolkov <posk@google.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf: lwt: fix NULL deref in IPv6 reroute
Date: Sun, 22 Nov 2026 12:13:45 +0800
Message-ID: <20261122041401.189733-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
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

After an lwt prog pushed an IPv6 header, bpf_lwt_xmit_reroute() hands
skb->sk to ip6_dst_lookup_flow(). When the flow has no source address,
the lookup reads inet6_sk(sk)->srcprefs, and inet6_sk() is NULL for
example when:

 - skb->sk is a request_sock, e.g. for a SYN-ACK.
 - skb->sk is an IPv4 socket, the IPv6 header was pushed on an IPv4
   packet.

KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
RIP: 0010:ip6_route_output_flags+0x279/0x4c0
Call Trace:
 <TASK>
 ip6_dst_lookup_tail.constprop.0+0x26e/0x1050
 ip6_dst_lookup_flow+0x101/0x1e0
 bpf_lwt_xmit_reroute+0xc18/0x18b0
 bpf_xmit+0x28f/0x400
 lwtunnel_xmit+0x2a7/0x620
 ip_finish_output2+0xa67/0x1f80
 __ip_finish_output+0x510/0x7e0
 ip_finish_output+0x2f/0x320
 ip_output+0x171/0x3e0
 ip_push_pending_frames+0x200/0x260
 raw_sendmsg+0x114c/0x3680
 inet_sendmsg+0xdf/0x100
 __sys_sendto+0x3ef/0x500
 __x64_sys_sendto+0xe0/0x1b0
 x64_sys_call+0x1375/0x27e0
 do_syscall_64+0xe7/0x630
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>

Pass the full socket, and no socket if it is not an IPv6 one while the
flow has no source address.

Fixes: 3bd0b15281af ("bpf: add handling of BPF_LWT_REROUTE to lwt_bpf.c")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/lwt_bpf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 72c86ff2a847..33f710d92106 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -278,7 +278,11 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
 		fl6.daddr = iph6->daddr;
 		fl6.saddr = iph6->saddr;
 
-		dst = ip6_dst_lookup_flow(net, skb->sk, &fl6, NULL);
+		if (ipv6_addr_any(&fl6.saddr) &&
+		    sk && sk->sk_family != AF_INET6)
+			sk = NULL;
+
+		dst = ip6_dst_lookup_flow(net, sk, &fl6, NULL);
 		if (IS_ERR(dst)) {
 			err = PTR_ERR(dst);
 			goto err;
-- 
2.43.0

