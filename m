Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795320875;
	b=gD7lfLBba7ih0g1j5NC7ufRrzCNS+P4mFxx3QN9kF+maXzFsUgK/xFbn0/ztmDWr/wQq
	 V8fMRZpXCUbcuqFSMFA9JrpaK7L+yMC8PpZTxEHyHkUqf3Ht2YeH641+T9sV+gxavIjQL
	 k8dWdmXRhY3mdpXPUSqlqJxIBZpxn9pbsIZdZ9XKIUnTzCKlW+2KMHRCqsAspKx2cviAq
	 5DaTYgckCc2001E7cyQAFAjKePe/OfttT9zU1DkAe8PNfX5voYIJycF+ms3yWbSSwPhCb
	 Rv6WynDA9KQKCUU++nKGzTLhfkVffqeUWhz+/u9/fp86/alqpp5xKC+ptnrFcJ4ZOzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795320875;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lb38nMxOfAlLbtezAc3dRCaDpF4QbPhXFYzRnbMlPHM=;
	b=BvUZgoj6ErEYCoYBnGi88BgNETYHXZxJTtSPSjU6wikQqOcbETYyoV7B7kF3Pqbkm46q
	 RKehF7CJfIm65AevLTp/VqdQKBVpawM+/ZtaVbb5keU3QnS8edGjUCVkUL7uo63ErDR0O
	 dN8y4VdSE3V+9btaDWdPqkpWJEQEvD7i8ewph2TeV1UXJy5wz5vEnpQP6y5QOh2Hc3P+W
	 4DMqBX5xLBnZwPEwsW6LQQ1bhTPzTu+kXa3xXQpJZhm8O21TMV4F0zK8O7rXaOdGjvg8D
	 aL7WMF57CbPABea8jyKX3E8iX2eeaQ3FdMUPG+cfJYwkX+zo835/G3n2GUPTkvvld+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SQznjq0P;
	arc=none smtp.remote-ip=95.215.58.185
Received: from mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9D0606A320
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 04:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B9D0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SQznjq0P
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JwIXtkgmQnvWYqCsXOrCGYCDMk1uEahCPH3Tnd+gNFQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795320872; v=1; x=1795925672;
 b=SQznjq0PzjWacY5RI7IZkMLtQnykYNY8Tvxkbs3v6aYyOkRT1jWsxRVQ9cyGg4KgacMJPzkT
 DcCXJ0tUqRPByE3VDe86g6IJDnYIAfbYRYQEbXTE9FiR7wq5yHZNdQ7gRxaVoRhsn0PebYt746L
 j/VRHVpxmDZSqaR6/g4mBTPo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1dac3f365d5e8237;
	Sun, 22 Nov 2026 04:14:32 +0000
X-Mizu-Trace-ID: 1dac3f365d5e8237
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Junseo Lim <zirajs7@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Yuqiang Sun <izaiahsun@gmail.com>,
	Peter Oskolkov <posk@google.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: test lwt_xmit reroute of an IPv4-in-IPv6 encap
Date: Sun, 22 Nov 2026 12:13:46 +0800
Message-ID: <20261122041401.189733-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122041401.189733-1-jiayuan.chen@linux.dev>
References: <20261122041401.189733-1-jiayuan.chen@linux.dev>
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

Add a test where an lwt_xmit prog pushes an IPv6 header with a ::
source on an IPv4 packet and reroutes. On an unfixed kernel this
dereferences inet6_sk() of the IPv4 socket and crashes; here reaching
the end is the pass.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/lwt_reroute.c    | 20 ++++++++++++++--
 .../selftests/bpf/progs/test_lwt_reroute.c    | 24 +++++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c b/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
index 6c50c0f63f43..01387c0f1b19 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
@@ -18,8 +18,8 @@
  *
  *    ip route add 10.0.0.0/24 encap bpf xmit <obj> sec "<section_N>" dev link_err
  *
- *  Here <obj> is statically defined to test_lwt_reroute.bpf.o, and it contains
- *  a single test program entry. This program sets packet mark by last byte of
+ *  Here <obj> is statically defined to test_lwt_reroute.bpf.o.
+ *  The lwt_xmit program sets packet mark by last byte of
  *  the IPv4 daddr. For example, a packet going to 1.2.3.4 will receive a skb
  *  mark 4. A packet will only be marked once, and IP x.x.x.0 will be skipped
  *  to avoid route loop. We didn't use generated BPF skeleton since the
@@ -42,6 +42,7 @@
  * --------------------------------
  *  1. Reroute to a running tun device
  *  2. Reroute to a device where qdisc drop
+ *  3. Reroute an IPv4 packet with a pushed IPv6 header
  *
  *  For case 1, ping packets should be received by the tun device.
  *
@@ -241,11 +242,26 @@ static void test_lwt_reroute_qdisc_dropped(void)
 		close(tun_fd);
 }
 
+static void test_lwt_reroute_push6(void)
+{
+	SYS(out, "ip link add link_err type dummy");
+	SYS(out, "ip link set lo up");
+	SYS(out, "ip addr add dev lo " LOCAL_SRC "/32");
+	SYS(out, "ip link set link_err up");
+	SYS(out, "ip route add %s dev link_err encap bpf xmit obj %s sec push6_zerosrc",
+	    TEST_CIDR, BPF_OBJECT);
+
+	ping_once("10.0.0.2");
+out:
+	return;
+}
+
 static void *test_lwt_reroute_run(void *arg)
 {
 	netns_delete();
 	RUN_TEST(lwt_reroute_normal_xmit);
 	RUN_TEST(lwt_reroute_qdisc_dropped);
+	RUN_TEST(lwt_reroute_push6);
 	return NULL;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/test_lwt_reroute.c b/tools/testing/selftests/bpf/progs/test_lwt_reroute.c
index 1dc64351929c..c969962926e6 100644
--- a/tools/testing/selftests/bpf/progs/test_lwt_reroute.c
+++ b/tools/testing/selftests/bpf/progs/test_lwt_reroute.c
@@ -4,7 +4,9 @@
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 #include <linux/if_ether.h>
+#include <linux/in.h>
 #include <linux/ip.h>
+#include <linux/ipv6.h>
 
 /* This function extracts the last byte of the daddr, and uses it
  * as output dev index.
@@ -33,4 +35,26 @@ int test_lwt_reroute(struct __sk_buff *skb)
 	return BPF_LWT_REROUTE;
 }
 
+SEC("push6_zerosrc")
+int test_lwt_reroute_push6(struct __sk_buff *skb)
+{
+	struct ipv6hdr h = {};
+
+	h.version = 6;
+	h.payload_len = bpf_htons(skb->len);
+	h.nexthdr = IPPROTO_IPIP;
+	h.hop_limit = 64;
+	/* 2001:db8::3, a fake address */
+	h.daddr.s6_addr[0] = 0x20;
+	h.daddr.s6_addr[1] = 0x01;
+	h.daddr.s6_addr[2] = 0x0d;
+	h.daddr.s6_addr[3] = 0xb8;
+	h.daddr.s6_addr[15] = 0x03;
+
+	if (bpf_lwt_push_encap(skb, BPF_LWT_ENCAP_IP, &h, sizeof(h)))
+		return BPF_DROP;
+
+	return BPF_LWT_REROUTE;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

