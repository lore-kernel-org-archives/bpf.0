Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257214;
	b=mRBxEOw+tPnH9dGcpTOf/JuTW75O6NLu3xxVGwaF1Uszuu+sNpJFF2F1Mw9Nf6sVZ8q4
	 Lq8K0DpnLg8PpupU6s9csjuNQIF0JsiCzMqwR4quNvXDJiLiFuKP7IliYKmiswITYw24d
	 O9p1kj4d9EhOX61MLIw2e574/zcF8XpudE/p2w9fAM6HXetdhsdg2SEeNIAWMUd98+plu
	 HVgtDNtLaNPOQ/VseJQUHObveSan1LEvxY179zguERbkpGWQhUAsM/T4TLfaSdUt3906d
	 y+zFEBSk77+P4ZpNVF3Bwh3pp4+c7LCs6oL+U5nure5Xn83YjEXyeB3rsAsycZQ+cxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257214;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qDFe3Eb/sDf2oY9Rdx9A18lPKXa/58lnLDoXACH0uNE=;
	b=ntQUNxcdp8sFwefi0N6TYLXuoxlDiy5eU69RdEiARgAmBDAYxLyGCamwnMyMcklLS3hF
	 wMbkCN08lcnqPoasSts57JtF6qhWiaLhNwzf0e9yah2iVN8ymAD12iamRPc5Bu7Txekyo
	 Sd0p+J0vPr3NGw0hoWdE9xHbm6VnULqwjul1ffSuNmbnG9g3Sh8IWseqk5Y7y0RWS61wH
	 Axjc1en8vYkR38sWUOjwtoVlTDOpxJDLTTG3omZ2XLDiLVZp96ZGYIuQr2rsU1l/Shggh
	 ejxa1X/UFFCUdI11Z+6OLibzq9TDLfRDHl5qrpIG9tozjLPZRJRQihc6br7C4tZRkjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lKuWbaHF;
	arc=none smtp.remote-ip=91.218.175.221
Received: from mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D3F606A325
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 10:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34D3F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lKuWbaHF
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WaciBSPn9XkFGrkKUG3od0QibHtMUzNPcJXcuG/0Z10=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795257212; v=1; x=1795862012;
 b=lKuWbaHF8W8C8Vwpn34DiFVNkMK0Mk7oISvohWvuctGB/MwnU0i90uK4y3I8SWaHEB+4QwAx
 9iUoj43fAcjDYioGdWVCTmU54iiQ8TCPhdcSVYXE4disH4vnfxXdpJYyG5ZUkKjEwCQtsCseuhN
 Gu3tBIlB0lKKYNS/RvRsJewM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8c1c28370649b49c;
	Sat, 21 Nov 2026 10:33:32 +0000
X-Mizu-Trace-ID: 8c1c28370649b49c
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
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
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Mattia Meleleo <mattia.meleleo@coralogix.com>,
	Michal Luczaj <mhal@rbox.co>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 02/11] selftests/bpf: Add test for unread SK_PASS data with strparser
Date: Sat, 21 Nov 2026 18:30:03 +0800
Message-ID: <20261121103222.88209-3-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121103222.88209-1-jiayuan.chen@linux.dev>
References: <20261121103222.88209-1-jiayuan.chen@linux.dev>
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

Send two packets and wait for each to reach ingress_msg before sending
the next, so that the parser runs once per packet with the first one
still unread. Read both, then send a third packet and expect it to be
delivered.

Without the fix the third packet is never read: copied_seq has passed
rcv_nxt after the first recv(), so the parser is not woken anymore.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
index 1d7231728eafd..18eb0c791e492 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
@@ -364,6 +364,88 @@ static void test_sockmap_strp_pass(int family, int sotype, bool fionread)
 	test_sockmap_strp__destroy(strp);
 }
 
+static int sockmap_strp_wait_fionread(int fd, int expected)
+{
+	int err, avail = 0;
+
+	while (1) {
+		err = ioctl(fd, FIONREAD, &avail);
+		if (!ASSERT_OK(err, "ioctl(FIONREAD) error"))
+			return -1;
+		if (avail >= expected)
+			break;
+		usleep(10000);
+	}
+	return ASSERT_EQ(avail, expected, "ioctl(FIONREAD)") ? 0 : -1;
+}
+
+/*
+ * Let the parser run twice before the reader reads anything. Each round
+ * must keep the SK_PASS bytes of the earlier rounds out of copied_seq,
+ * otherwise copied_seq runs past rcv_nxt and the stream stalls.
+ */
+static void test_sockmap_strp_pass_unread(int family, int sotype)
+{
+	int zero = 0, one = 1, pkt_size = STRP_PKT_FULL_LEN, sent, recvd;
+	int err, map, i;
+	int c = -1, p = -1;
+	struct test_sockmap_strp *strp = NULL;
+	char rcv[STRP_PKT_FULL_LEN * 2 + 1] = "0";
+
+	strp = sockmap_strp_init(&map, true, true);
+	if (!ASSERT_TRUE(strp, "sockmap_strp_init"))
+		return;
+
+	err = create_pair(family, sotype, &c, &p);
+	if (err)
+		goto out;
+
+	err = bpf_map_update_elem(map, &zero, &p, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(p)"))
+		goto out_close;
+
+	err = setsockopt(c, IPPROTO_TCP, TCP_NODELAY, &one, sizeof(one));
+	if (!ASSERT_OK(err, "setsockopt(TCP_NODELAY)"))
+		goto out_close;
+
+	/*
+	 * wait for each packet to reach ingress_msg before sending the
+	 * next one, so that the parser runs once per packet
+	 */
+	for (i = 1; i <= 2; i++) {
+		sent = xsend(c, packet, pkt_size, 0);
+		if (!ASSERT_EQ(sent, pkt_size, "xsend(c)"))
+			goto out_close;
+		if (sockmap_strp_wait_fionread(p, pkt_size * i))
+			goto out_close;
+	}
+
+	recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, IO_TIMEOUT_SEC);
+	if (!ASSERT_EQ(recvd, pkt_size * 2, "recv_timeout(p)") ||
+	    !ASSERT_OK(memcmp(packet, rcv, pkt_size), "memcmp, data mismatch") ||
+	    !ASSERT_OK(memcmp(packet, rcv + pkt_size, pkt_size),
+		       "memcmp, second data mismatch"))
+		goto out_close;
+
+	/* the next packet must still wake the parser */
+	sent = xsend(c, packet, pkt_size, 0);
+	if (!ASSERT_EQ(sent, pkt_size, "xsend(c) after read"))
+		goto out_close;
+
+	recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, IO_TIMEOUT_SEC);
+	if (!ASSERT_EQ(recvd, pkt_size, "recv_timeout(p) after read") ||
+	    !ASSERT_OK(memcmp(packet, rcv, pkt_size),
+		       "memcmp, data mismatch after read"))
+		goto out_close;
+
+out_close:
+	close(c);
+	close(p);
+
+out:
+	test_sockmap_strp__destroy(strp);
+}
+
 /* Test strparser with verdict mode */
 static void test_sockmap_strp_verdict(int family, int sotype)
 {
@@ -470,6 +552,10 @@ void test_sockmap_strp(void)
 		test_sockmap_strp_pass(AF_INET, SOCK_STREAM, true);
 	if (test__start_subtest("sockmap strp tcp v6 pass fionread"))
 		test_sockmap_strp_pass(AF_INET6, SOCK_STREAM, true);
+	if (test__start_subtest("sockmap strp tcp pass unread"))
+		test_sockmap_strp_pass_unread(AF_INET, SOCK_STREAM);
+	if (test__start_subtest("sockmap strp tcp v6 pass unread"))
+		test_sockmap_strp_pass_unread(AF_INET6, SOCK_STREAM);
 	if (test__start_subtest("sockmap strp tcp verdict"))
 		test_sockmap_strp_verdict(AF_INET, SOCK_STREAM);
 	if (test__start_subtest("sockmap strp tcp v6 verdict"))
-- 
2.43.0

